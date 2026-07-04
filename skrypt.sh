#!/bin/bash

SCRIPT_NAME=$(basename "$0")

show_date() {
    date +"%Y-%m-%d"
}

case "$1" in
    --date)
        show_date
        ;;
    *)
        echo "Nieznana opcja. UĹĽyj: ./skrypt.sh --help"
        ;;
esac