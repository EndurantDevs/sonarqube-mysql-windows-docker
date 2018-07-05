Write-Host Starting test

if ($env:ARCH -ne "amd64") {
  Write-Host "Arch $env:ARCH detected. Skip testing."
  exit 0
}

$ErrorActionPreference = 'SilentlyContinue';
docker kill sonar
docker rm -f sonar

$ErrorActionPreference = 'SilentlyContinue';
Write-Host Starting container
docker run --name sonar -d -p 9000:9000 dnikolayev/sonarqube-mysql-windows:latest
Start-Sleep 100

docker logs sonar

$ErrorActionPreference = 'SilentlyContinue';
docker kill sonar
docker rm -f sonar