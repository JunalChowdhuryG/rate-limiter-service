# Etapa 1: Construcción del proyecto con Maven
FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Imagen final para ejecución
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/rate-limiter-service-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]