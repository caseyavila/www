#!/bin/sh

tab=""

# Set the tab length for every page
i=0
while [ $i -ne 4 ]; do
    tab=${tab}"    "
    i=$(( i + 1 ))
done 

# Move into the site directory
cd site || exit

page() {

    mkdir -p "../docs/$(dirname ${page})"

    case "$page_type" in 
        "generic")
            cat header.html > "../docs/$page";
            sed "s/^/${tab}/" "${page_type}/${page}" >> "../docs/$page";
            cat footer.html >> "../docs/$page";
        ;;
        "katex")
            cat header-katex.html > "../docs/$page";
            sed "s/^/${tab}/" "${page_type}/${page}" >> "../docs/$page";
            cat footer.html >> "../docs/$page";
        ;;
        "footer-only")
            cat "${page_type}/${page}" > "../docs/$page";
            cat footer.html >> "../docs/$page";
        ;;
    esac
}

main() {
    for page_type in "generic" "katex" "footer-only"
    do
        (cd "$page_type" && find . -type f) | while read -r page; do
            echo "CC ${page}"
            page
        done
    done


}

main
