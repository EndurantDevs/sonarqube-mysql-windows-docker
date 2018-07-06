Write-Host Preparing to deploy, logging to DockerHub
docker login -u="$env:DOCKER_USER" -p="$env:DOCKER_PASS"

$tags = $env:TAGS -split ';'
$tags |foreach {
    docker push dnikolayev/sonarqube-mysql-windows:$_
}

Write-Host Finishing, logging out from DockerHub
docker logout