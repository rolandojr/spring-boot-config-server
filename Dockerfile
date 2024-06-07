#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests -Dmaven.test.skip=true

#
# Package stage
#
FROM openjdk:11-jre-slim-buster
LABEL authors="Rolando Ramos"
COPY --from=build /home/app/target/spring-boot-config-server-1.0.0-SNAPSHOT.jar app-1.0.0.jar
ENTRYPOINT ["java","-jar","/app-1.0.0.jar"]

