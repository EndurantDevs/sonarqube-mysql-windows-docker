@Echo off
Setlocal
set _folder='C:\MySQL\data\*.*'


:: Is folder empty
set _TMP=
for /f "delims=" %%a in ('dir /b "C:\MySQL\data\*.*"') do set _TMP=%%a
echo "Checking Folder: %_folder%"

IF {%_TMP%}=={} (
    echo 'First run'

    C:\MySQL\bin\mysqld.exe --initialize-insecure --console --explicit_defaults_for_timestamp

    C:\MySQL\bin\mysqld.exe --install

    powershell Start-Service mysql

    C:\MySQL\bin\mysql -h localhost -u root --skip-password -e "CREATE DATABASE sonar;CREATE USER 'sonar'@'localhost' IDENTIFIED BY 'sonar';GRANT ALL PRIVILEGES ON sonar.* TO 'sonar'@'localhost';SET PASSWORD FOR 'root'@'localhost' = PASSWORD('!@345');FLUSH PRIVILEGES;"

    xcopy C:\sonarqube\original_extensions\* C:\sonarqube\extensions /e /i /h
) ELSE (
    echo 'Data exists, trying to start with your data'
    C:\MySQL\bin\mysqld.exe --install
    powershell Start-Service mysql
)

java -jar lib/sonar-application-%SONARQUBE_VERSION%.jar -Dsonar.log.console=true -Dsonar.jdbc.username="%SONARQUBE_JDBC_USERNAME%" -Dsonar.jdbc.password="%SONARQUBE_JDBC_PASSWORD%" -Dsonar.jdbc.url="%SONARQUBE_JDBC_URL%" -Dsonar.web.javaAdditionalOpts="%SONARQUBE_WEB_JVM_OPTS% -Djava.security.egd=file:/dev/./urandom"