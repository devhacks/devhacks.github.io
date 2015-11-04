#!/usr/bin/env bash -xe


message=$1

if [ "$message" == "" ]; then
  message=`git log -1 --pretty=%B`
fi

hugo -d public

rsync -avh --delete public/* dist/

cd dist

git add .

git commit -m "$message"

git push origin master

cd -
