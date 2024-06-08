#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /home/app
COPY pom.xml .
RUN mvn clean package -Dmaven.test.skip -Dmaven.main.skip -Dspring-boot.repackage.skip && rm -r ./target/
COPY src ./src
RUN mvn clean package

#
# Package stage
#
FROM openjdk:11-jre-slim-buster
LABEL authors="Rolando Ramos"
COPY --from=build /home/app/target/spring-boot-config-server-1.0.0-SNAPSHOT.jar app-1.0.0.jar
ENTRYPOINT ["java","-jar","/app-1.0.0.jar"]

