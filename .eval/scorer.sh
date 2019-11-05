#!/bin/bash

user_score=0

if [ -d $1/$8 ]
then
  if [ -d $1/$2 ]
  then
    user_score=`expr $user_score + 1`
    [ -f $1/$2/$3 ] && user_score=`expr $user_score + 1`
    [ -f $1/$4 ] && user_score=`expr $user_score + 1`
    cd $1
    [ `eval git branch -r | wc -l` -ge 2 ] && user_score=`expr $user_score + 1`
    git checkout master > /dev/null 2>&1
    [ `eval git log --pretty="oneline" | wc -l` -ge 1 ] && user_score=`expr $user_score + 1`
    git checkout new_branch > /dev/null 2>&1
    [ `eval git log --pretty="oneline" | wc -l` -ge 2 ] && user_score=`expr $user_score + 1`
    touch sample1©.txt
    git add sample1©.txt
    git commit -m "Committing with my new file" > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
      git reset --hard HEAD~1 > /dev/null 2>&1
    else
      git reset HEAD sample1©.txt > /dev/null 2>&1
      rm sample1©.txt
      user_score=`expr $user_score + 20`
    fi
    cd ..
  fi

  if [ -d $5/$6 ]
  then
    user_score=`expr $user_score + 1`
    cd $5
    git clone remote $7 > /dev/null 2>&1
    if [ -d $7/$2 ]
    then
      user_score=`expr $user_score + 1`
      [ -f $7/$2/$3 ] && user_score=`expr $user_score + 1`
    fi
    [ -f $7/$4 ] && user_score=`expr $user_score + 1`
    cd $7
    [ `eval git branch -r | wc -l` -ge 3 ] && user_score=`expr $user_score + 1`
    git checkout master > /dev/null 2>&1
    [ `eval git log --pretty="oneline" | wc -l` -ge 1 ] && user_score=`expr $user_score + 1`
    git checkout new_branch > /dev/null 2>&1
    [ `eval git log --pretty="oneline" | wc -l` -ge 2 ] && user_score=`expr $user_score + 1`
    cd ../..
    rm -rf $5/$7
  fi
fi

percent_score=$(( user_score * 100 / 33 ))
echo "Points scored: $user_score/33"
echo "FS_SCORE:$percent_score%"
