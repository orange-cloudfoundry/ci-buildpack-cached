#!/bin/sh
set -xe
cd bp-release
git name-rev --tags --name-only $(git rev-parse HEAD) > ../bp-cached/tag
printf "$1" > ../bp-cached/name
cwd=$(pwd)
mkdir golib
first_folder="$(ls -d ${cwd}/src/*/ | head -n 1)"
ln -s "${first_folder}/vendor" golib/src
cd src/*/vendor/github.com/cloudfoundry/libbuildpack/packager/buildpack-packager
GOPATH="${cwd}/golib" go install
cd $cwd
rm -Rf golib
buildpack-packager build -any-stack -cached
mv *.zip ../bp-cached

