#!/usr/bin/env bash -xe


#allow passing a commit message
message=$1

if [ "$message" == "" ]; then
  #use last git commit message for deploying into github pages
  message=`git log -1 --pretty=%B`
fi

#generate static site into public & copy files into dist folder
/usr/bin/env hugo -d public
rsync -avh --delete public/* dist/

# push the files into github pages
cd dist
git add .
git commit -m "$message"
git push origin master

# go back to source directory
cd -
