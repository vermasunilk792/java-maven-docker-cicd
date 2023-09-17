# First stage: complete build environment
FROM maven:3.5.4-jdk-8-alpine as build

# add pom.xml and source code
ADD ./pom.xml pom.xml
ADD ./src src/

# package jar
RUN mvn clean package
# Second stage: minimal runtime environment
FROM openjdk:8-jre-alpine
# copy jar from the first stage
COPY --from=build target/my-app-1.0-SNAPSHOT.jar my-app-1.0-SNAPSHOT.jar
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
