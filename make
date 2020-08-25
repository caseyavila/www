#!/bin/sh

page() {

    # Make directories for any pages
    mkdir -p "$build/$(dirname "$page")"

    # Add header, then indented body, then footer for each page type
    case "$page_type" in 
        "generic")
            cat header.html > "$build/$page";
            sed "s/^/$tab/" "$page_type/$page" >> "$build/$page";
            cat footer.html >> "$build/$page";
        ;;
        "katex")
            cat header-katex.html > "$build/$page";
            sed "s/^/$tab/" "$page_type/$page" >> "$build/$page";
            cat footer.html >> "$build/$page";
        ;;
        "footer-only")
            cat "$page_type/$page" > "$build/$page";
            cat footer.html >> "$build/$page";
        ;;
    esac
}

main() {

    # Set the tab length for every page
    i=0
    while [ $i -ne 4 ]; do
        tab=$tab"    "
        i=$(( i + 1 ))
    done 

    # Set build directory
    build="../docs"

    # Move into the src directory
    cd src || exit
        
    # Enter into each page type and launch page for each page within
    for page_type in "generic" "katex" "footer-only"; do
        (cd "$page_type" && find . -type f) | while read -r page; do
            echo "Making: $page"
            page
        done
    done
}

main
