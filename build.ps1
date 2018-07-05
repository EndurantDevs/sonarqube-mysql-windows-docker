$ErrorActionPreference = 'Stop';
Write-Host Starting build

cd latest
docker build --pull -t latest -f Dockerfile .

docker images
