FROM --platform=linux/amd64 eclipse-temurin:17-jdk-alpine
RUN apk add --no-cache curl
VOLUME /tmp
EXPOSE 8080
ADD target/springboot-aws-deploy-service.jar springboot-aws-deploy-service.jar
ENTRYPOINT ["java", "-jar", "/springboot-aws-deploy-service.jar"]
