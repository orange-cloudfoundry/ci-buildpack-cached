#!/bin/sh
set -xe
cd bp-release
git name-rev --tags --name-only $(git rev-parse HEAD) > ../bp-cached/tag
printf "$1" > ../bp-cached/name
BUNDLE_GEMFILE=cf.Gemfile bundle
BUNDLE_GEMFILE=cf.Gemfile bundle exec buildpack-packager --cached
mv *.zip ../bp-cached
