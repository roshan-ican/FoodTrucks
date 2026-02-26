# start from base
FROM ubuntu:20.04

LABEL maintainer="Roshan <roshansahani535@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

# install system-wide deps for python and node
RUN apt-get -yqq update && apt-get -yqq install python3-pip python3-dev curl gnupg
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get -yqq install nodejs

# copy our application code
ADD flask-app /opt/flask-app
WORKDIR /opt/flask-app

# fetch app specific deps
RUN npm install
RUN npm run build
RUN pip3 install -r requirements.txt

# expose port
EXPOSE 5000

# start app
CMD [ "python3", "./app.py" ]
