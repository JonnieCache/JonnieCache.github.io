#!/usr/bin/env sh

set -e

bundle exec jekyll b
cp CNAME _site/

# git push origin `git subtree split --prefix _site blog`:master --force
