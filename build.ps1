$ErrorActionPreference = 'Stop';
Write-Host Starting build

cd latest
docker build --pull -t latest -f Dockerfile .
docker tag latest dnikolayev/sonarqube-mysql-windows:latest
docker images
