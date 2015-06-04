#!/bin/bash

echo "$GITHUB_SSH_KEY" > ~/.ssh/github_key && chmod 600 ~/.ssh/github_key

GIT_BRANCH=${GIT_BRANCH:-"master"}

mkdir /home/polld/task
cd /home/polld/task

if [ -z "$GIT_PATH" ]
  then
    git clone $GITHUB_REPO --branch $GIT_BRANCH --single-branch .
  else
    git clone -n $GITHUB_REPO --branch $GIT_BRANCH --single-branch .
    git config core.sparseCheckout true
    echo "$GIT_PATH" >> .git/info/sparse-checkout
    git checkout $GIT_BRANCH
    mv /home/polld/task/$GIT_PATH/* /home/polld/task
fi

npm install

cmd="polld"

if [ -n "$STATSD_HOST" ]; then
  cmd="$cmd -h $STATSD_HOST"
fi

if [ -n "$STATSD_PORT" ]; then
  cmd="$cmd -p $STATSD_PORT"
fi

if [ -n "$TASK_INTERVAL" ]; then
  cmd="$cmd -i $TASK_INTERVAL"
fi

if [ -n "$TASK_FILE" ];
  then
    cmd="$cmd /home/polld/task/$TASK_FILE"
  else
    cmd="$cmd /home/polld/task/task.js"
fi

echo $cmd
exec $cmd
