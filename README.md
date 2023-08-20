# hellowebserver


## Disclaimer
Aim of this repository is to provide simple comparison of dockerised implementations of simplest possible REST API in different langages. The throughput check is there only to get
a general idea of peformance and should not be treated as objective proof of each language's overall "fastness". The implementations are far from perfect and completely different
results could be achieved with proper configuration tuning or better choice of libraries. It is only an indication what can be pieced together within 5-15 minutes of googling.

Author's main goal was to learn about different approaches to package and environment managment offered by different languages as well as general feel what kind of performance can
be expected out of the box from a REST API. I am sure that it is possible to achieve much more performant implementations (without simply scaling horizontally or vertically of course).

## Implementation details

Each of the webservers is run inside the docker image based on a debian 11 with [bombardier](https://github.com/codesenberg/bombardier) library installed. After the webserver is started inside
container exposing endpoint at port 8000, it is bombarded with 100000 requests being made by 125 threads. The overall time and throughput is then recorded in a report inside benchmarks directory.

## Instructions
Benchmarks can be recreated locally by simply running the `run_benchmarks.sh` script. By default, this will download pre-prepared docker images stored in this repository.
You can also force local rebuild of docker images with `--force-build` flag. Be warned that this may take a significant amount of time. It is also possible to only
run benchmarking on a subset of languages using `--servers` flag. For more information on script usage simply run `run_benchmarks.sh --help`
