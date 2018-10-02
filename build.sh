#!/usr/bin/env sh

set -e

bundle exec jekyll b
cp CNAME _site/
