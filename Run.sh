#!/bin/bash
docker compose run --rm airflow-webserver airflow db init
sleep 30
docker compose up