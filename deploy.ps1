Write-Host Preparing to deploy, logging to DockerHub
docker login -u="$env:DOCKER_USER" -p="$env:DOCKER_PASS"

docker push dnikolayev/sonarqube-mysql-windows:$env:TAG

Write-Host Finishing, logging out from DockerHub
docker logout