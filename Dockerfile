FROM maven:3.9.8-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn package -DskipTests

FROM eclipse-temurin:17
WORKDIR /app
COPY --from=build /app/target/*.jar spring-petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/spring-petclinic.jar"] 

