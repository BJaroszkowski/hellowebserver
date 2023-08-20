#!/usr/bin/env bash

# Default variable values
force_build=false
report_name="benchmark"
servers=(
    "clojure"
    "C_sharp"
    "elixir_phoenix"
    "haskell"
    "java_spring"
    "JS_svelte"
    "nim"
    "PHP"
    "python_django"
    "python_flask"
    "ruby"
    "scala"
    "c_facil"
    "cpp_crow"
    "elixir_bandit"
    "golang"
    "java_quarkus"
    "JS_react"
    "julia"
    "ocaml"
    "prolog"
    "python_fastapi"
    "racket"
    "rust"
)

# Function to display script usage
usage() {
 echo "Usage: $0 [OPTIONS]"
 echo "Options:"
 echo " -h, --help      Display this help message"
 echo " -s, --servers      Explicit, comma delimited list of servers to run benchmark on. Defaults to all."
 echo " -r, --report-name  Custom name for benchmark output file. Defaults to 'benchmark'"
 echo "--force-build  Force local build of docker images. Otherwise they will be pulled
from remote repository requiring you to have access to ghcr.io.
NOTE: Building docker images requies docker experimental features enabled"
}

has_argument() {
    [[ ("$1" == *=* && -n ${1#*=}) || ( -n "$2" && "$2" != -*)  ]];
}

extract_argument() {
  echo "${2:-${1#*=}}"
}

# Function to handle options and arguments
handle_options() {
  while [ $# -gt 0 ]; do
    case $1 in
      -h | --help)
        usage
        exit 0
        ;;
      --force-build)
        force_build=true
        echo "Running with --force-build flag. This may take a while."
        ;;
      -s | --servers*)
        if ! has_argument "$@"; then
          echo "Specify server name(s)" >&2
          usage
          exit 1
        fi

        server_string=$(extract_argument "$@")
        IFS=',' read -ra servers <<< "$server_string"

        shift
        ;;
      -r | --report-name*)
        if ! has_argument "$@"; then
          echo "Specify report name" >&2
          usage
          exit 1
        fi

        report_name=$(extract_argument "$@")
        shift
        ;;
      *)
        echo "Invalid option: $1" >&2
        usage
        exit 1
        ;;
    esac
    shift
  done
}

# Main script execution
handle_options "$@"

#!/usr/bin/env bash
BASE_IMAGE_NAME=ghcr.io/bjaroszkowski/hellowebserver
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
printf -v current_date '%(%Y-%m-%dT%H:%M:%S)T\n' -1
REPORT="$SCRIPT_DIR"/benchmarks/"$report_name"_"$current_date".txt
echo "BENCHMARK REPORT" > "$REPORT"

wait_for_server () {
    until eval '$(docker exec $1 bash -c "curl --output /dev/null --silent --fail http://localhost:8000")'; do
        sleep 1
    done
}

if [[ "$(docker images -q $BASE_IMAGE_NAME:base 2> /dev/null)" == "" ]]; then
        if [[ $force_build = true ]]; then
            docker build -t $BASE_IMAGE_NAME:base -f "$SCRIPT_DIR/Dockerfile" "$SCRIPT_DIR"
        else
            docker pull $BASE_IMAGE_NAME:base
        fi
fi


while IFS= read -r -d '' D; do
    base_dir=$(dirname "$D")
    tag=$(basename "$base_dir")
    if ! echo "${servers[@]}" | grep -Fqw "$tag"; then
        echo "Skipping $tag"
        continue
    fi
    echo "benchmarking $tag"
    if [[ "$(docker ps -a -q -f name="$tag")" ]]; then
        docker rm --force "$tag"
    fi
    echo "$tag" >> "$REPORT"
    image_name="$BASE_IMAGE_NAME:$tag"
    if [[ "$(docker images -q "$image_name" 2> /dev/null)" == "" ]]; then
        if [[ $force_build = true ]]; then
            docker build -t "$image_name" -f "$D" "$base_dir"
        else
            docker pull "$image_name"
        fi
    fi
    docker run -d --rm --name "$tag" "$image_name" > /dev/null && wait_for_server "$tag"
    docker exec "$tag" bash -c "bombardier --print=i,r -c 125 -n 100000 http://localhost:8000" >> "$REPORT" && docker rm --force "$tag" > /dev/null
    echo "===============================================" >> "$REPORT"
done< <(find "$SCRIPT_DIR" -maxdepth 2 -mindepth 2 -name Dockerfile -print0)

