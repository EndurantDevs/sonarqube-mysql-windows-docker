docker login -u="$env:DOCKER_USER" -p="$env:DOCKER_PASS"
docker push dnikolayev/sonarqube-mysql-windows:latest
docker logout