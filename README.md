# GitOpsLedger App

GitOpsLedger App is a Java Spring MVC web application for user registration,
login, profile management, file upload, RabbitMQ message publishing, Memcached
user lookups, and Elasticsearch user indexing experiments.

The application is packaged as a WAR and runs on Tomcat. Docker Compose is
included for running the main app stack with MySQL, Memcached, and RabbitMQ.

## Tech Stack

- Java 8 source compatibility
- Spring MVC 4.2
- Spring Security 4.0
- Spring Data JPA and Hibernate
- MySQL 8
- Memcached
- RabbitMQ
- Elasticsearch 5 transport client integration
- Maven
- Tomcat 9
- Docker and Docker Compose

## Repository Layout

```text
src/main/java/com/opsledger/account/    Java source code
src/main/resources/                     application properties and SQL seed data
src/main/webapp/WEB-INF/views/          JSP views
src/test/java/                          JUnit tests
Dockerfile                              Web application image build
Dockerfile.db                           MySQL image build with seed SQL
compose.yaml                            Local container stack
pom.xml                                 Maven build configuration
sonar-project.properties                SonarQube analysis settings
docs/                                   CI/CD setup notes and screenshot evidence
```

## Documentation

Additional CI/CD setup notes and screenshot evidence is available in
[`docs/`](docs/):

- [`docs/ci-cd.md`](docs/ci-cd.md) - SonarQube, ECR, GitHub Actions, Helm repo update, and branch protection setup
- [`docs/screenshots/`](docs/screenshots/) - Pipeline, SonarQube, ECR, and deployed application screenshots

## Prerequisites

- JDK 8 or newer
- Maven 3.x
- Docker and Docker Compose

## Run With Docker Compose

Build and start the local stack:

```sh
docker compose up --build
```

The web application is exposed at:

```text
http://localhost:8080
```

RabbitMQ Management UI is exposed at:

```text
http://localhost:15672
```

Default local service credentials are provided through Compose environment
variables:

```text
OPSLEDGER_DB_PASSWORD=opsledger-local-pass
OPSLEDGER_RABBITMQ_USERNAME=opsledger
OPSLEDGER_RABBITMQ_PASSWORD=opsledger-local-pass
```

You can override these values in your shell or with a local `.env` file before
starting Docker Compose.

## Build Locally

Run the Maven test suite:

```sh
mvn test
```

Build the WAR package:

```sh
mvn package
```

Run with the Jetty Maven plugin:

```sh
mvn jetty:run
```

By default, the Jetty plugin serves the application at:

```text
http://localhost:8080
```

## Application URLs

- `/login` - Login page
- `/registration` - User registration
- `/welcome` - Authenticated welcome page
- `/users` - User list
- `/users/{id}` - User profile lookup with Memcached caching
- `/user/{username}` - User profile edit page
- `/upload` - File upload page
- `/user/rabbit` - Publish sample messages to RabbitMQ
- `/user/elasticsearch` - Index users into Elasticsearch
- `/rest/users/view/{id}` - View indexed user data from Elasticsearch

## Configuration

Runtime configuration is loaded from:

```text
src/main/resources/application.properties
```

The application expects the following environment variables:

```text
OPSLEDGER_DB_USERNAME
OPSLEDGER_DB_PASSWORD
OPSLEDGER_RABBITMQ_USERNAME
OPSLEDGER_RABBITMQ_PASSWORD
```

The Docker Compose stack supplies these values for the containerized web app.

Elasticsearch host settings are present in `application.properties`, but the
current `compose.yaml` does not define an Elasticsearch service.

## Database Seed Data

The database image initializes MySQL with:

```text
src/main/resources/db_backup.sql
```

An additional SQL snapshot is available at:

```text
src/main/resources/accountsdb.sql
```

## Code Quality

Run SonarQube analysis with your configured scanner:

```sh
sonar-scanner
```

The SonarQube project settings are defined in `sonar-project.properties`.
