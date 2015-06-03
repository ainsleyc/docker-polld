#!/bin/bash

echo "$GITHUB_SSH_KEY" > ~/.ssh/github_key && chmod 600 ~/.ssh/github_key

GIT_BRANCH=${GIT_BRANCH:-"master"}

cd /home/app

if [ -z "$GIT_PATH" ]
  then
    git clone $GITHUB_REPO --branch $GIT_BRANCH --single-branch .
  else
    git clone -n $GITHUB_REPO --branch $GIT_BRANCH --single-branch .
    git config core.sparseCheckout true
    echo "$GIT_PATH" >> .git/info/sparse-checkout
    git checkout $GIT_BRANCH
    mv /home/app/$GIT_PATH/* /home/app
fi

npm install

chown -R app /home/app

cmd="polld"

if [ -z "$STATS_HOST" ]
  then
    cmd="$cmd -h $STATSD_HOST"
fi

if [ -z "$STATS_PORT" ]
  then
    cmd="$cmd -p $STATSD_PORT"
fi

if [ -z "$TASK_INTERVAL" ]
  then
    cmd="$cmd -i $TASK_INTERVAL"
fi

if [ -z "$TASK_PATH" ]
  then
    cmd="$cmd /home/app/$TASK_PATH"
  else
    cmd="$cmd /home/app/task.js"
fi

echo $cmd
eval $cmd
