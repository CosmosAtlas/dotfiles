#!/bin/bash
# ~/.dotfiles/wiki2html.sh

hugo --themesDir ~/ -t vimwiki \
     --config ~/vimwiki/config.toml \
     --contentDir ~/vimwiki/content/ \
     --layoutDir ~/vimwiki/layouts/ \
     -d ~/vimwiki/_site --quiet > /dev/null

