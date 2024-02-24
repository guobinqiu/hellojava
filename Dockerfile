FROM maven:3.9 as build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package
FROM tomcat:9.0
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/hellojava.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]