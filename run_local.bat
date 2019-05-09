REM set docker/local.env
docker-compose build
docker-compose up -d
REM docker stack deploy -c docker-compose.yml note