#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------------------------
#
# Program: initpost.sh
# Description: scaffold a new blog post following the repo conventions.
#
# Usage: ./initpost.sh [options] <post title>
#
# Options:
#   -h, --help        output instructions
#   -c, --create      create post
#
# Example:
#   ./initpost.sh -c Como substituir strings com sed
#
# Based on the initpost.sh script from the Indigo theme by Vitor Britto.
# Licensed under the MIT license.
#
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

CURRENT_DATE="$(date +'%Y-%m-%d')"
TIME="$(date +%H:%M)"
BINPATH="$(cd "$(dirname "$0")" && pwd)"
DIST_FOLDER="${BINPATH}/_posts"

POST_TITLE=""
FILE_NAME=""


# ------------------------------------------------------------------------------
# | UTILS                                                                      |
# ------------------------------------------------------------------------------

# Colors (only when stdout is a terminal)
if [ -t 1 ]; then
    C_HEAD="$(tput setaf 6)"
    C_OK="$(tput setaf 2)"
    C_ERR="$(tput setaf 1)"
    C_WARN="$(tput setaf 3)"
    C_RESET="$(tput sgr0)"
else
    C_HEAD=""
    C_OK=""
    C_ERR=""
    C_WARN=""
    C_RESET=""
fi

# Header logging
e_header() {
    printf '%s\n' "${C_HEAD}→ ${*}${C_RESET}"
}

# Success logging
e_success() {
    printf '%s\n' "${C_OK}✔ ${*}${C_RESET}"
}

# Error logging
e_error() {
    printf '%s\n' "${C_ERR}✖ ${*}${C_RESET}"
}

# Warning logging
e_warning() {
    printf '%s\n' "${C_WARN}! ${*}${C_RESET}"
}


# ------------------------------------------------------------------------------
# | MAIN FUNCTIONS                                                             |
# ------------------------------------------------------------------------------

initpost_help() {

cat <<EOT
------------------------------------------------------------------------------
INIT POST - Scaffold a new blog post.
------------------------------------------------------------------------------
Usage: ./initpost.sh [options] <post title>
Options:
  -h, --help        output instructions
  -c, --create      create post
Example:
  ./initpost.sh -c Como substituir strings com sed
------------------------------------------------------------------------------
EOT

}

# Initial content (conventions: see AGENTS.md)
initpost_content() {

cat <<EOT
---
title: "${POST_TITLE//\"/\\\"}"
layout: post
date: ${CURRENT_DATE} ${TIME}
headerImage: false
tag:
category: blog
author: arianebrandao
description: ""
---
EOT

}

# Create file
initpost_file() {
    if [ -e "${DIST_FOLDER}/${FILE_NAME}" ]; then
        e_warning "File already exists: _posts/${FILE_NAME}"
        exit 1
    fi

    e_header "Creating template..."
    initpost_content > "${DIST_FOLDER}/${FILE_NAME}"
    e_success "Post created: _posts/${FILE_NAME}"
}


# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

main() {

    case "${1:-}" in
        -h|--help)
            initpost_help
            exit 0
            ;;
        -c|--create)
            if [ $# -lt 2 ]; then
                e_error "Informe o título do post."
                initpost_help
                exit 1
            fi

            shift
            POST_TITLE="${*}"

            # Normalize to an ASCII slug (accents become plain letters)
            POST_NAME="$(printf '%s' "${POST_TITLE}" \
                | iconv -f utf-8 -t ascii//TRANSLIT \
                | tr '[:upper:]' '[:lower:]' \
                | sed -e 's/[^a-z0-9]\+/-/g' -e 's/^-//' -e 's/-$//')"

            if [ -z "${POST_NAME}" ]; then
                e_error "Não foi possível gerar um slug para o título informado."
                exit 1
            fi

            FILE_NAME="${CURRENT_DATE}-${POST_NAME}.md"
            initpost_file
            ;;
        *)
            initpost_help
            exit 1
            ;;
    esac

}

# Initialize
main "$@"
