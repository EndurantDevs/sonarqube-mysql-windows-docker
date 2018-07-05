Write-Host Starting test runs of docker containers

if ($env:ARCH -ne "amd64")
{
    Write-Host "Arch $env:ARCH detected. Skip testing."
    exit 0
}

$tags = $env:TAGS -split ';'
$tags |foreach {
    $ErrorActionPreference = 'SilentlyContinue';
    docker kill sonar
    docker rm -f sonar

    $ErrorActionPreference = 'SilentlyContinue';
    Write-Host Starting tag: $_
    docker run --name sonar -d -p 9000:9000 dnikolayev/sonarqube-mysql-windows:$_
    Start-Sleep 100

    docker logs sonar

    $ErrorActionPreference = 'SilentlyContinue';
    docker kill sonar
    docker rm -f sonar
}