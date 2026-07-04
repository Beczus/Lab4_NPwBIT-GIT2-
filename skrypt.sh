#!/bin/bash

SCRIPT_NAME=$(basename "$0")

show_date() {
    date +"%Y-%m-%d"
}

create_logs() {
    COUNT=${1:-100}

    if ! [[ "$COUNT" =~ ^[0-9]+$ ]]; then
        echo "Błąd: liczba plików musi być liczbą całkowitą."
        exit 1
    fi

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

show_help() {
    echo "Dostępne opcje:"
    echo "  --date          Wyświetla dzisiejszą datę"
    echo "  --logs          Tworzy domyślnie 100 plików log"
    echo "  --logs LICZBA   Tworzy podaną liczbę plików log"
    echo "  --help          Wyświetla pomoc"
}

case "$1" in
    --date)
        show_date
        ;;
    --logs)
        create_logs "$2"
        ;;
    --help)
        show_help
        ;;
    *)
        echo "Nieznana opcja. Użyj: ./skrypt.sh --help"
        ;;
esac