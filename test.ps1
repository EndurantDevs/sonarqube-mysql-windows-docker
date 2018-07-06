Write-Host Starting test runs of docker containers


$ErrorActionPreference = 'SilentlyContinue';
docker kill sonar
docker rm -f sonar

$ErrorActionPreference = 'SilentlyContinue';
Write-Host Starting tag: $env:TAG
docker run --name sonar -d -p 9000:9000 dnikolayev/sonarqube-mysql-windows:$env:TAG
Start-Sleep 100

docker logs sonar

$ErrorActionPreference = 'SilentlyContinue';
docker kill sonar
docker rm -f sonar
