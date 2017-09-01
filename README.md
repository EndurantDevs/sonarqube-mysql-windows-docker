Update
=========
**Latest versions updated to SonarQube v6.5**

Basic Info
=========

**Windows** container with [SonarQube](https://www.sonarqube.org/), Java, and MySQL as Database for SonarQube.
It provides an easy way to run of SonarQube with sharing MySQL and SonarQube Extensions folders for more comfortable work with SonarQube.

SonarQube® software (previously called Sonar) is an open source quality management platform, dedicated to continuously analyze and measure technical quality, from project portfolio to method.

Containers are based on [Microsoft Nanoserver](https://hub.docker.com/r/microsoft/nanoserver/) and [OpenJDK](https://hub.docker.com/_/openjdk/). Nanoserver was used to save your resources. However, for special purposes there are versions based on [Microsoft Windowsservercore](https://hub.docker.com/r/microsoft/windowsservercore/).

MySQL version used: 5.7.16 

Dockerfiles for builds are [shared in GitHub](https://github.com/dnikolayev/sonarqube-mysql-windows-docker) and [built images are available on DockerHub](https://hub.docker.com/r/dnikolayev/sonarqube-mysql-windows/). 
Files are fully windows-native, so you can customize them for your needs if you don't like a version from DockerHub.

Containers have two shared Volumes. 
One for MySQL data and the second one is for "Extensions" folder for SonarQube. 
MySQL data Volume is needed to not lose your SonarQube history after restarting the container.
Extensions Volume is need to give ability to update plugins to newer versions for SonarQube. 

I recommend assigning extensions folder to a useful path on your host-machine. 
This will make you easier to add custom plugins for SonarQube like [Community C++ Plugin](https://github.com/SonarOpenCommunity/sonar-cxx) or any other one.

Available versions
=========

Tag  | SonarQube Version | Base Container | Size | Source
  ------------- | -------------  | ------------- | -------------  | -------------
  **:latest**  | 6.5 Latest | nanoserver | 3.46 GB | [GitHub](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/tree/master/latest)
  **:lts**  | 5.6 LTS | nanoserver | 3.41 GB | [GitHub](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/tree/master/lts) 
 **:latest-windowsservercore**  | 6.5 Latest | windowsservercore | 12.8 GB | [GitHub](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/tree/master/latest-windowsservercore)
  **:lts-windowsservercore**  | 5.6 LTS | windowsservercore | 12.7 GB | [GitHub](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/tree/master/lts-windowsservercore) 

Usage (Command Line) 
=========

```shell
docker pull dnikolayev/sonarqube-mysql-windows
```
![Docker Pull](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/raw/master/images/docker-pull.png "Pulling container from DockerHub")

**Note: On windows 10 default memory allocation is different to windows 2016 server. Please don't forget to add --memory 2g to the next command** [Discussion on GitHub](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/issues/1) 

```shell
docker run --name sonar  -it -p 9000:9000  `
-v C:/data/mysql:C:/MySQL/data `
-v C:/data/extensions:C:/sonarqube/extensions `
dnikolayev/sonarqube-mysql-windows:latest
```
![Running container](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/raw/master/images/run-container-shell.png "SonarQube starts")

To check configuration of the run container:
```shell
docker inspect sonar
```

Usage (Visual)
=========

* Let's try to use [Kitematic](https://kitematic.com/) to run SonarQube container. 
![Kinematic main screen](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/raw/master/images/kitematic.png "Kinematic")

* Find this container via my nickname *dnikolayev* 
![Find SonarQube Windows container](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/raw/master/images/find-container.png "SonarQube Windows container")

* Select the tag (Version) you want to use. To go into this menu - please click on ". . ." button
![Select the version you need](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/raw/master/images/select-image-tag.png "Selecting the tag")

* Don't forget to go to "Settings" to configure local folders, network and other settings. Than Run the container.
![Select local directories for Volumes](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/raw/master/images/volumes.png "Set Volumes directories")

* Once container loads - you will have SonarQube working. Just add extensions you need for you work.
![After loading container - SonarQube is getting available](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/raw/master/images/sonarqube.png "SonarQube Main Page")

Notes
=========

By default, SonarQube starts via [Java Service Wrapper](https://wrapper.tanukisoftware.com/doc/english/download.jsp). This container doesn't use it and runs SonarQube via jar-file directly. 
This was done because of the fact that nanoserver allows you to run only 64-bit applications.
However, 64-bit version of java-wrapper uses some 32-bit libraries?!
So, on nanoserver it just doesn't start without throwing any errors. 
Thanks to [NanoServerApiScan utility](https://blogs.technet.microsoft.com/nanoserver/2016/04/27/nanoserverapiscan-exe-updated-for-tp5/). It gave me ability to see the source of the problem :)

![64-bit Java Wrapper doesn't work on Nanoserver because of 32-bit dependencies](https://github.com/dnikolayev/sonarqube-mysql-windows-docker/raw/master/images/java-wrapper-problem.png "64-bit Java Wrapper has 32-bit dependency which doesn't work in NanoServer")

# Good luck with your code quality checks! #
