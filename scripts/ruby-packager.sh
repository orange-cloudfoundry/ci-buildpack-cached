#!/bin/sh
set -x
cd bp-release
git name-rev --tags --name-only $(git rev-parse HEAD) > ../bp-cached/tag
BUNDLE_GEMFILE=cf.Gemfile bundle
BUNDLE_GEMFILE=cf.Gemfile bundle exec buildpack-packager --cached --any-stack
mv *.zip ../bp-cached
BUNDLE_GEMFILE=cf.Gemfile bundle exec buildpack-packager --cached --stack="cflinuxfs3"
mv *.zip ../bp-cached