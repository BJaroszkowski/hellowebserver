#!/usr/bin/env bash
set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPORT="$SCRIPT_DIR/docker_report.txt"
echo "BENCHMARK REPORT" > $REPORT

wait_for_server () {
    until $(docker exec -it $1 bash -c "curl --output /dev/null --silent --fail http://localhost:8000"); do
        sleep 1
    done
}

if [[ "$(docker images -q bombardier:base 2> /dev/null)" == "" ]]; then
        docker build -t bombardier:base -f "$SCRIPT_DIR/Dockerfile" $SCRIPT_DIR
fi

for D in $(find $SCRIPT_DIR -maxdepth 2 -mindepth 2 -name Dockerfile) ; do
    echo "benchmarking $D"
    base_dir=$(dirname $D)
    tag=$(basename $base_dir)
    if [ "$(docker ps -a -q -f name=$tag)" ]; then
        docker rm --force $tag
    fi
    echo "$tag" >> $REPORT
    image_name="hellowebserver:$tag"
    echo "tag is $tag"
    if [[ "$(docker images -q $image_name 2> /dev/null)" == "" ]]; then
        docker build -t $image_name -f $D $base_dir
    fi
    docker run -d --rm --name $tag $image_name && wait_for_server $tag
    docker exec $tag bash -c "bombardier --print=i,r -c 125 -n 100000 http://localhost:8000" >> $REPORT && docker rm --force $tag
    echo "===============================================" >> $REPORT
done

set +x