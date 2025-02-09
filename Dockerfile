# Use OpenJDK as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file built by Maven into the container
COPY target/*.jar app.jar

# Expose port 8080 inside the container
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
