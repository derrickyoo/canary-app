# pull official base image
FROM python:3.8.5-alpine

# install system-level dependencies
RUN apk add --update --no-cache \
  g++ gcc libxslt-dev musl-dev python3-dev \
  libffi-dev openssl-dev jpeg-dev zlib-dev postgresql-dev

ENV LIBRARY_PATH=/lib:/usr/lib

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# set work directory
WORKDIR /usr/src/app

# install dependencies
COPY ./requirements /usr/src/app/requirements
RUN pip install -r requirements/local.txt

# copy entrypoint.sh
COPY ./entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# copy project
COPY . /usr/src/app

# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
