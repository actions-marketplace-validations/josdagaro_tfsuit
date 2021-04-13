#!/usr/bin/env bash

set -eu

tfsuit() {
  (
    source helpers.sh
    source usage.sh
    source inputs.sh
    source check_deps.sh
    source version.sh
    source eval_vars.sh

    if [[ "$version" -eq 1 ]]; then
      die "$(version)"
    fi

    if [[ "$help" -eq 1 ]]; then
      die "$(version)"
    fi

    local compliant_vars
    local not_compliant_vars
    local vars_sum
    vars_sum=$(eval_vars)
    compliant_vars=$(echo "$vars_sum" | jq .compliant)
    not_compliant_vars=$(echo "$vars_sum" | jq .not_compliant)
    echo "compliant vars:"
    echo "$compliant_vars" | jq
    echo "not compliant vars:"
    echo "$not_compliant_vars" | jq
  )
}

tfsuit "$@"
