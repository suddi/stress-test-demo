# BASE DOCKER IMAGE DOCKERFILE:
# https://github.com/nodejs/docker-node/blob/4fa0c90f383880b8c03f6e2c07e8d46a0ae9075f/6.10/alpine/Dockerfile
FROM node:6-alpine

COPY . /code
WORKDIR /code

RUN rm -rf node_modules
RUN npm cache clean
RUN npm install
RUN npm update
