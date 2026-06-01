FROM eclipse-temurin:11-jdk AS BUILD_IMAGE
RUN apt update && apt install maven -y
COPY ./ opsledger-project
RUN cd opsledger-project && mvn install

FROM tomcat:9.0-jdk11-temurin
LABEL "Project"="OpsLedger"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE opsledger-project/target/opsledger-v1.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
