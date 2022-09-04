#!/bin/bash
# No more than 100 lines of code

wait_for () {
    while ! nc -z $1 $2; do sleep 1; done;
    echo "$1:$2 accepts connections!^_^"
}

export $(xargs < /src/core/.env)
echo "env variables are populated!^_^"

case "$PROCESS" in
"DBT_DOCS")
    dbt docs generate && dbt docs serve --port=8000
    ;;
"DBT_ALL")
    wait_for "${DB_HOST}" "${DB_PORT}"
    dbt build
    ;;
"LINT")
    doit lint
    ;;
*)
    echo "no PROCESS specified!>_<"
    exit 1
    ;;
esac
