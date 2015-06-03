FROM node:0.12.4

RUN npm install -g polld

RUN mkdir -p /home/app

ADD ssh_config /root/.ssh/config
ADD pull_app.sh /etc/my_init.d/001_git_pull_app
