$ErrorActionPreference = 'Stop';
Write-Host Starting build

$tags = $env:TAGS -split ';'
$tags |foreach {
	cd $_
    docker build --pull -t dnikolayev/sonarqube-mysql-windows:$_ -f Dockerfile .
    docker images
    cd ..
}
