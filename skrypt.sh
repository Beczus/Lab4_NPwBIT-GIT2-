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

create_errors() {
    COUNT=${1:-100}

    if ! [[ "$COUNT" =~ ^[0-9]+$ ]]; then
        echo "Błąd: liczba plików musi być liczbą całkowitą."
        exit 1
    fi

    for ((i=1; i<=COUNT; i++))
    do
        DIR_NAME="error${i}"
        FILE_NAME="${DIR_NAME}/error${i}.txt"

        mkdir -p "$DIR_NAME"

        {
            echo "Nazwa pliku: error${i}.txt"
            echo "Katalog: $DIR_NAME"
            echo "Utworzony przez skrypt: $SCRIPT_NAME"
            echo "Data utworzenia: $(date +"%Y-%m-%d %H:%M:%S")"
        } > "$FILE_NAME"
    done

    echo "Utworzono $COUNT katalogów error z plikami error."
}

init_repo() {
    REPO_URL=$(git config --get remote.origin.url)

    if [ -z "$REPO_URL" ]; then
        echo "Błąd: nie znaleziono adresu zdalnego repozytorium."
        echo "Uruchom tę opcję wewnątrz repozytorium Git."
        exit 1
    fi

    TARGET_DIR="repo_clone"

    if [ -d "$TARGET_DIR" ]; then
        TARGET_DIR="repo_clone_$(date +%s)"
    fi

    git clone "$REPO_URL" "$TARGET_DIR"

    FULL_PATH="$(pwd)/$TARGET_DIR"

    echo "export PATH=\"\$PATH:$FULL_PATH\"" >> ~/.bashrc

    echo "Repozytorium sklonowano do: $FULL_PATH"
    echo "Ścieżkę dodano do PATH w pliku ~/.bashrc"
    echo "Aby odświeżyć PATH, wykonaj: source ~/.bashrc"
}

show_help() {
    echo "Dostępne opcje:"
    echo "  --date, -d             Wyświetla dzisiejszą datę"
    echo "  --logs, -l             Tworzy domyślnie 100 plików log"
    echo "  --logs LICZBA          Tworzy podaną liczbę plików log"
    echo "  -l LICZBA              Tworzy podaną liczbę plików log"
    echo "  --error, -e            Tworzy domyślnie 100 katalogów error z plikami error"
    echo "  --error LICZBA         Tworzy podaną liczbę katalogów error z plikami error"
    echo "  -e LICZBA              Tworzy podaną liczbę katalogów error z plikami error"
    echo "  --init                 Klonuje repozytorium i dodaje jego katalog do PATH"
    echo "  --help, -h             Wyświetla pomoc"
}

case "$1" in
    --date|-d)
        show_date
        ;;
    --logs|-l)
        create_logs "$2"
        ;;
    --error|-e)
        create_errors "$2"
        ;;
    --init)
        init_repo
        ;;
    --help|-h)
        show_help
        ;;
    *)
        echo "Nieznana opcja. Użyj: ./skrypt.sh --help"
        ;;
esac