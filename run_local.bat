REM set docker/local.env
docker-compose build
REM docker-compose up -d
docker stack deploy -c docker-compose.yml smartnote