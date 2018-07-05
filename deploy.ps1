docker login -u $env:DOCKER_USER --password-stdin $env:DOCKER_PASS
docker push dnikolayev/sonarqube-mysql-windows:latest
docker logout