# docker-polld

Dockerfile for polld daemon. Pulls a github repo (limited to optional subfolder) containing the taskfile, installs npm dependencies and runs the task.

Environment variables:

-GITHUB_REPO (required)
-GITHUB_SSH_KEY (required)
-GIT_PATH (optional, defaults to "/")
-GIT_BRANCH (optional, defaults to "master")

You can then run via

```
docker --name polld-task -e GITHUB_REPO="git@github.com:myorg/myrepo.git" -e GITHUB_SSH_KEY="`cat path_to_my_github_key`" ainsleyc/polld
```
