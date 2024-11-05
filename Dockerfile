# # ```Dockerfile
# # Use the official OpenJDK 21 JRE slim image as the base
# # FROM openjdk:21-jre-slim MH: Didn't work, of course.
# TIME>>> 3.537 seconds (process running for 4.292)
# FROM openjdk:21-jdk-slim

# # Set the working directory inside the container
# WORKDIR /app

# # Copy the Java application JAR file into the container
# # COPY java-in-the-can-0.0.1-SNAPSHOT.jar /app/java-in-the-can-0.0.1-SNAPSHOT.jar
# # MH: Fix this
# COPY java-in-the-can-0.0.1-SNAPSHOT.jar /app/java-in-the-can.jar

# # Expose the port that the application will run on
# EXPOSE 8080

# # Command to run the Java application
# # CMD ["java", "-jar", "java-in-the-can-0.0.1-SNAPSHOT.jar"]
# CMD ["java", "-jar", "java-in-the-can.jar"]
# # ```
# # This Dockerfile now uses the official OpenJDK 21 JRE slim image as the base. Let me know if you need any further adjustments!



# 
# Using ChatGPT, two tries (used JDK17 first)
# TIME>>> 4.049 seconds (process running for 4.873)
# Use an official Alpine image with JDK 21 as the base
# FROM openjdk:21-alpine  MH: Also didn't work.
# FROM alpine/java:21.0.4-jdk

# # Set the working directory in the container
# # WORKDIR /app

# # Copy the Java application into the container
# # COPY java-in-the-can-0.0.1-SNAPSHOT.jar /app/java-in-the-can.jar
# COPY java-in-the-can-0.0.1-SNAPSHOT.jar /app.jar

# # Expose the port the application runs on (change as necessary)
# EXPOSE 8080

# # Command to run the Java application
# # CMD ["java", "-jar", "/app/java-in-the-can.jar"]
# CMD ["java", "-jar", "/app.jar"]



# # Distroless version!
# # 3.62 seconds (process running for 4.329)
# FROM mcr.microsoft.com/openjdk/jdk:21-distroless

# COPY java-in-the-can-0.0.1-SNAPSHOT.jar /app.jar

# EXPOSE 8080

# CMD ["-Xmx256m", "-jar", "/app.jar"]


# 
# MULTI-STAGE BUILD
# n.nn seconds (process running for n.nnn)
# NOTE: Must be run from the root of the project with the following command:
#       docker build -t java-in-the-can-msb ../Docker
FROM openjdk:21-jdk-slim AS builder

WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY ./src ./src
RUN ./mvnw clean package

FROM openjdk:21-jdk-slim AS final
WORKDIR /app
EXPOSE 8080
COPY --from=builder /app/target/*.jar /app/*.jar
ENTRYPOINT ["java", "-jar", "/app/*.jar"]
