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

# 5️⃣ Give execution permission to Maven wrapper
RUN chmod +x mvnw

# 6️⃣ Build the Spring Boot application (skip tests for faster build)
RUN ./mvnw clean package -DskipTests

# 7️⃣ Copy the generated jar into container
RUN cp target/BloggingProject-0.0.1-SNAPSHOT.jar app.jar

# 8️⃣ Expose port 8080 (Spring Boot default)
EXPOSE 8080

# 9️⃣ Set environment variables for PostgreSQL (optional, can also use Render dashboard)
# ENV SPRING_DATASOURCE_URL=jdbc:postgresql://<HOST>:<PORT>/<DB_NAME>
# ENV SPRING_DATASOURCE_USERNAME=<USERNAME>
# ENV SPRING_DATASOURCE_PASSWORD=<PASSWORD>

# 10️⃣ Run the jar
ENTRYPOINT ["java","-jar","app.jar"]
