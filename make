#!/bin/sh

cd -P -- "$(dirname -- "$0")"

page() {

    # Make directories for any pages
    mkdir -p "$build/$(dirname "$page")"

    # Add header, then indented body, then footer for each page type
    case "$page_type" in 
        '<!-- generic -->')
            cat templates/header.html > "$build/$page";
            sed -e 1d -e "s/^/$tab/" "$page" >> "$build/$page";
            cat templates/footer.html >> "$build/$page";
        ;;
        '<!-- footer-only -->')
            sed 1d "$page" > "$build/$page";
            cat templates/footer.html >> "$build/$page";
        ;;
    esac

    echo "$page"
}

main() {

    # Set the tab length for every page
    i=0
    while [ $i -ne 4 ]; do
        tab=$tab"    "
        i=$(( i + 1 ))
    done 

    # Set build directory
    build='../docs'

    # Move into the src directory
    cd src || exit
        
    # Execute page on every page within the src directory (exclude templates)
    find -- * -type f -not -path 'templates/*' | while read -r page; do
        page_type="$(sed -n 1p "$page")"
        page
    done
}

main
