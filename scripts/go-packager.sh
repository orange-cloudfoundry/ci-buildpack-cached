#!/bin/sh
set -xe
cd bp-release
git name-rev --tags --name-only $(git rev-parse HEAD) > ../bp-cached/tag
cwd=$(pwd)
mkdir golib
first_folder="$(ls -d ${cwd}/src/*/ | head -n 1)"
export GOPATH="${cwd}/golib"
if [ -f "go.mod" ]; then
	export GOBIN=$(pwd)/.bin
	export PATH="$GOBIN:$PATH"
	go mod download
	go install github.com/cloudfoundry/libbuildpack/packager/buildpack-packager
else
	ln -s "${first_folder}/vendor" golib/src
	cd src/*/vendor/github.com/cloudfoundry/libbuildpack/packager/buildpack-packager
	go install
	cd $cwd
fi

rm -Rf golib
buildpack-packager build -any-stack -cached
buildpack-packager build -stack cflinuxfs3 -cached
mv *.zip ../bp-cached

