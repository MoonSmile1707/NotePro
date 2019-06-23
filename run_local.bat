call docker/local.env.bat
docker-compose build
REM docker-compose up -d
docker stack deploy -c docker-compose.yml %STACK_NAME_NOTE_PRO%