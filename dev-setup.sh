#!/bin/sh

docker-compose build
docker-compose up -d db
docker-compose run --rm app mix deps.get
docker-compose run --rm app mix ecto.create

