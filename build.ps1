$ErrorActionPreference = 'Stop';
Write-Host Starting build


Write-Host Building... $env:TAG
Write-Host Free Disk space:
fsutil volume diskfree c:
cd $env:TAG
docker build --pull -t dnikolayev/sonarqube-mysql-windows:$env:TAG -f Dockerfile .
docker images
cd ..
