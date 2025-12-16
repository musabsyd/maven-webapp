FROM tomcat:latest
MAINTAINER musab <musab@oracle.coms>
EXPOSE 8080
COPY target/maven-webapp.war /usr/local/tomcat/webapps/maven-webapp.war



