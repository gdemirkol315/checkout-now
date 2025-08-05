# Multi-stage build for Spring Boot application
FROM eclipse-temurin:21-jdk-alpine AS build

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw .
COPY mvnw.cmd .
COPY pom.xml .
COPY .mvn .mvn

# Make Maven wrapper executable
RUN chmod +x ./mvnw

# Download dependencies (this layer will be cached if pom.xml doesn't change)
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src src

# Build the application
RUN ./mvnw clean package -DskipTests

# Production stage
FROM eclipse-temurin:21-jre-alpine AS production

# Create non-root user for security (Alpine syntax)
RUN addgroup -S appuser && adduser -S appuser -G appuser

# Set working directory
WORKDIR /app

# Copy the JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Change ownership to non-root user
RUN chown appuser:appuser app.jar

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 8080

# Health check (we'll handle this in Kubernetes)
# HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
#   CMD wget -q --tries=1 --spider http://localhost:8080/api/actuator/health || exit 1

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]