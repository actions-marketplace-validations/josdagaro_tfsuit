#!/bin/bash

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
    compliant_vars=$(echo "$vars_sum" | jq -r .compliant)
    not_compliant_vars=$(echo "$vars_sum" | jq -r .not_compliant)
    echo "compliant vars:"
    echo "$compliant_vars" | jq
    echo "::set-output name=compliant_vars::${compliant_vars}"
    echo "::set-output name=not_compliant_vars::${not_compliant_vars}"

    if [ "${not_compliant_vars}" != "[]" ]; then
      echo "not compliant vars:"
      echo "$not_compliant_vars" | jq

      if [ "$fail_on_not_compliant" -eq 1 ]; then
        die "[ERROR] There are vars that doesn't complaint" 1
      fi
    fi
  )
}

tfsuit "$@"
