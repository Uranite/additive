#!/usr/bin/env bash
set -e

CMD="$1"

update_packwiz() {
    go install github.com/packwiz/packwiz@latest
    echo "Packwiz has been Updated"
}

export_pack() {
    mkdir -p build/fabric
    (
        cd versions/fabric/1.21.11
        packwiz mr export
    )
    mv versions/fabric/1.21.11/*.mrpack build/fabric/
}

update() {
    (
        cd versions/fabric/1.21.11
        packwiz update --all
    )
}

update_loader() {
    (
        cd versions/fabric/1.21.11
        packwiz migrate loader latest
    )
}

refresh() {
    for d in versions/fabric/*/; do
        (
            cd "$d"
            packwiz refresh
        )
    done
}

add() {
    (
        cd versions/fabric/1.21.11
        packwiz mr add "$2"
    )
}

case "$CMD" in
    ""|update)
        update
        ;;
    update-packwiz)
        update_packwiz
        ;;
    export)
        export_pack
        ;;
    update-loader)
        update_loader
        ;;
    refresh)
        refresh
        ;;
    add)
        add "$@"
        ;;
    *)
        exit 0
        ;;
esac
