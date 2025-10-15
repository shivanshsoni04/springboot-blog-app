# 1️⃣ Use official Java 17 JDK image
FROM eclipse-temurin:17-jdk-alpine

# 2️⃣ Set working directory inside container
WORKDIR /app

# 3️⃣ Copy Maven wrapper and pom.xml first for caching dependencies
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

# 4️⃣ Copy source code
COPY src src

# 5️⃣ Build the Spring Boot application (skip tests for faster build)
RUN ./mvnw clean package -DskipTests

# 6️⃣ Copy the built jar into container
# Make sure the jar name matches the one generated in your target folder
COPY target/BloggingProject-0.0.1-SNAPSHOT.jar app.jar

# 7️⃣ Expose port 8080 (default Spring Boot port)
EXPOSE 8080

# 8️⃣ Set environment variables (optional for MySQL, can also configure in Render dashboard)
# ENV SPRING_DATASOURCE_URL=jdbc:mysql://<HOST>:<PORT>/<DB_NAME>
# ENV SPRING_DATASOURCE_USERNAME=<USERNAME>
# ENV SPRING_DATASOURCE_PASSWORD=<PASSWORD>

# 9️⃣ Run the jar
ENTRYPOINT ["java","-jar","app.jar"]
