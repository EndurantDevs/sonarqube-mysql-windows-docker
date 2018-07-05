Write-Host Starting test

if ($env:ARCH -ne "amd64") {
  Write-Host "Arch $env:ARCH detected. Skip testing."
  exit 0
}

$ErrorActionPreference = 'SilentlyContinue';
docker kill dnikolayev/sonarqube-mysql-windows:latest
docker rm -f dnikolayev/sonarqube-mysql-windows:latest

$ErrorActionPreference = 'Stop';
Write-Host Starting container
docker run --name sonar  -it -p 9000:9000 dnikolayev/sonarqube-mysql-windows:latest
Start-Sleep 10

docker logs dnikolayev/sonarqube-mysql-windows:latest

$ErrorActionPreference = 'SilentlyContinue';
docker kill dnikolayev/sonarqube-mysql-windows:latest
docker rm -f dnikolayev/sonarqube-mysql-windows:latest