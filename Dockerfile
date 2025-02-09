# Step 1: Build the application using Maven (Multi-Stage Build)
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy source code & pom.xml
COPY pom.xml .
COPY src ./src

# Build the JAR file
RUN mvn clean package -DskipTests

# Step 2: Use a lightweight OpenJDK image for running the application
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port (Same as used in Jenkinsfile)
EXPOSE 8080

# Health check to ensure the app is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

# Run the application
CMD ["java", "-jar", "app.jar"]
