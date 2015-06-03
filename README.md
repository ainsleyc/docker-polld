# docker-polld

Docker for [polld](https://github.com/ainsleyc/polld) daemon. Pulls a github repo (limited to optional subfolder) containing the taskfile, installs npm dependencies and runs the task.

Environment variables:

- GITHUB_REPO (required)
- GITHUB_SSH_KEY (required)
- GIT_PATH (optional, defaults to "/")
- GIT_BRANCH (optional, defaults to "master")
- TASK_PATH (optional, defaults to "/task.js")
- STATSD_HOST (optional, defaults to "localhost")
- STATSD_PORT (optional, defaults to 8125)
- STATSD_INTERVAL (optional, defaults to 10000) 

You can then run via:
```
docker run --name polld-task -e GITHUB_REPO="git@github.com:myorg/mytask.git" -e GITHUB_SSH_KEY="`cat path_to_my_github_key`" ainsleyc/polld
```
