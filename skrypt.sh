#!/bin/bash

SCRIPT_NAME=$(basename "$0")

show_date() {
    date +"%Y-%m-%d"
}

create_logs() {
    COUNT=100

    for ((i=1; i<=COUNT; i++))
    do
        FILE_NAME="log${i}.txt"
        {
            echo "Nazwa pliku: $FILE_NAME"
            echo "Utworzony przez skrypt: $SCRIPT_NAME"
            echo "Data utworzenia: $(date +"%Y-%m-%d %H:%M:%S")"
        } > "$FILE_NAME"
    done

    echo "Utworzono $COUNT plików log."
}

case "$1" in
    --date)
        show_date
        ;;
    --logs)
        create_logs
        ;;
    *)
        echo "Nieznana opcja. Użyj: ./skrypt.sh --help"
        ;;
esac