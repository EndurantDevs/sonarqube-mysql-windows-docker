$ErrorActionPreference = 'Stop';
Write-Host Starting build

$tags = $env:TAGS -split ';'
$tags |foreach {
    Write-Host Building... $_
    Write-Host Free Disk space:
    fsutil volume diskfree c:
    cd $_
    docker build --pull -t dnikolayev/sonarqube-mysql-windows:$_ -f Dockerfile .
    docker images
    cd ..
}
