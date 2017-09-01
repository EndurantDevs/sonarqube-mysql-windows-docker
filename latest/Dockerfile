FROM openjdk:nanoserver

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN \
    setx /M SONARQUBE_VERSION '6.5'; \
    setx /M SONARQUBE_JDBC_URL "'jdbc:mysql://localhost:3306/sonar?useUnicode=true"&"characterEncoding=utf8"&"rewriteBatchedStatements=true"&"useConfigs=maxPerformance'" ; \
    setx /M SONARQUBE_JDBC_USERNAME 'sonar'; \
    setx /M SONARQUBE_JDBC_PASSWORD 'sonar'; \
    setx /M SONARQUBE_HOME C:\\sonarqube

RUN powershell -command \ 

    Invoke-WebRequest "https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$env:SONARQUBE_VERSION.zip" -OutFile "sonarqube.zip"; \

    Expand-Archive -Path c:\sonarqube.zip -DestinationPath C:\ ; \

    Remove-Item sonarqube.zip ; \

    Rename-Item sonarqube-$env:SONARQUBE_VERSION sonarqube ; \

    Rename-Item c:\sonarqube\extensions c:\sonarqube\original_extensions

RUN powershell -command \
    
    Invoke-WebRequest "https://downloads.mysql.com/archives/get/file/mysql-5.7.16-winx64.zip" -OutFile "mysql.zip" ; \

    Expand-Archive -Path c:\mysql.zip -DestinationPath C:\ ; \

    Remove-Item mysql.zip ; \

    Rename-Item C:\mysql-5.7.16-winx64 C:\MySQL ; \
    
    New-Item -Path C:\MySQL\data -ItemType directory ;  
     

VOLUME c:\\MySQL\\data

VOLUME c:\\sonarqube\\extentions

EXPOSE 9000
EXPOSE 3306

WORKDIR C:\\sonarqube

COPY sonarqube.cmd C:/sonarqube/bin/

ENTRYPOINT ["C:\\sonarqube\\bin\\sonarqube.cmd"]
