#!/bin/sh
set -x
cd bp-release
git name-rev --tags --name-only $(git rev-parse HEAD) > ../bp-cached/tag
printf "$1" > ../bp-cached/name
BUNDLE_GEMFILE=cf.Gemfile bundle
BUNDLE_GEMFILE=cf.Gemfile bundle exec buildpack-packager --cached --any-stack
mv *.zip ../bp-cached
