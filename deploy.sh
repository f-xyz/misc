#!/usr/bin/env bash

git status

echo -e "\n"
echo "Commit message: $1";
echo "Press any key to commit. Ctrl+C to cancel."
read -n 1 -s

commitMessage=$1
: ${commitMessage:='.'}

gulp build

git add --all .
git commit -m "${commitMessage}"
git push -u origin master
