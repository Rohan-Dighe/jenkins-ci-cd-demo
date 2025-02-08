# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file built by Maven
COPY target/*.jar app.jar

# Expose port 8080 inside the container (Matches Jenkinsfile mapping)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
