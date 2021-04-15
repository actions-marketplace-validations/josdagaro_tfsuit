#!/bin/bash

# Initialize variables
help=0
debug=0
version=0
fail_on_not_compliant=0
dir=
config_json_path=

for arg in "$@"; do
  case $arg in
  -h | --help)
    help=1
    ;;
  -D | --debug)
    debug=1
    ;;
  -v | --version)
    version=1
    ;;
  -d=* | --dir=*)
    dir="${arg#*=}"
    ;;
  -c=* | --config-json-path=*)
    config_json_path="${arg#*=}"
    ;;
  -f | --fail-on-not-compliant)
    fail_on_not_compliant=1
    ;;
  esac
  shift
done

if [ -z "$dir" ] || [ -z "$config_json_path" ]; then
  show_usage
fi
