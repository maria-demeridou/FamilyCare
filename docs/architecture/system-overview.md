# FamilyCare — System Overview

## 1. Architecture

FamilyCare will use a **modular monolith** architecture.

The application will be a single Spring Boot deployment backed by one PostgreSQL database. Internally, its code will be organized into independent business modules with clearly defined responsibilities.

This approach keeps deployment and development simple while encouraging maintainable code and clear separation of concerns.

## 2. Technology Stack

| Component           | Technology                       |
|---------------------|----------------------------------|
| Language            | Java 21                          |
| Backend framework   | Spring Boot                      |
| API                 | REST                             |
| Database            | PostgreSQL                       |
| Data access         | JdbcTemplate                     |
| Database migrations | Flyway                           |
| Authentication      | Keycloak                         |
| Authorization       | Spring Security                  |
| Testing             | JUnit 5, Mockito, Testcontainers |
| API documentation   | OpenAPI / Springdoc              |
| Build tool          | Gradle                           |
| Local environment   | Docker Compose                   |

## 3. Application Modules

### 3.1 Family Management

Responsible for:

- Creating and managing families.
- Family memberships and roles.
- Invitations and invitation acceptance.
- Membership changes and ownership transfer.
- Family-level authorization rules.

### 3.2 Child Profiles

Responsible for:

- Creating and updating child profiles.
- Archiving and restoring children.
- Enforcing child-related business rules.

### 3.3 Care Tasks

Responsible for:

- Creating and managing care tasks.
- Assigning and reassigning caregivers.
- Recurring task definitions and occurrence generation.
- Task completion, skipping and cancellation.
- Detecting overdue tasks.
- Preventing invalid concurrent task transitions.

### 3.4 Activity History

Responsible for:

- Recording important user and system actions.
- Maintaining an immutable activity history through normal application operations.
- Providing authorized access to family activity records.

### 3.5 Notifications

Responsible for:

- Generating upcoming and overdue task reminders.
- Managing notification delivery attempts.
- Preventing duplicate reminder events.
- Retrying failed notification processing.

### 3.6 Shared

Contains genuinely shared technical components, such as:

- Common error handling.
- API response conventions.
- Shared utilities.
- Common infrastructure configuration.

Business rules should remain inside their respective modules rather than being placed in this module.

## 4. Module Boundaries

Each module should own its business logic and data-access operations.

Rules:

1. Modules must not directly access another module's repositories or database access classes.
2. Cross-module operations should use explicitly defined interfaces.
3. Shared code should contain only functionality genuinely needed by multiple modules.
4. Business logic should not be implemented in REST controllers.
5. Database access should be performed through JdbcTemplate.

Modules will share the same database. Logical ownership of tables will remain with the module responsible for them.

## 5. Authentication & Authorization

### Authentication

Keycloak will manage:

- User registration and login.
- Password management.
- User identity.
- Access token issuance.

The Spring Boot application will validate access tokens using Spring Security as an OAuth2 Resource Server.

### Authorization

FamilyCare will enforce application-specific permissions.

The application will:

1. Identify the authenticated user from the validated token.
2. Retrieve the user's active membership in the relevant family.
3. Determine the user's role within that family.
4. Verify that the requested operation is permitted.
5. Ensure that the requested resource belongs to the relevant family.

Family-level roles (`OWNER`, `PARENT`, `CAREGIVER`) belong to FamilyCare memberships, not to global Keycloak roles.

## 6. Data & Transaction Management

PostgreSQL will be the single source of truth for application data.

JdbcTemplate will be used for SQL queries and database operations. Flyway will manage versioned database migrations.

Important rules:

- Related database changes must be executed within appropriate transactions.
- Critical business constraints must be enforced by the database where possible.
- Concurrent operations must not violate business rules.
- Activity history entries must be committed in the same transaction as the corresponding business operation.
- Database migrations must be version-controlled.

## 7. Background Processing

Background processing will initially run inside the Spring Boot application.

It will handle:

- Generating recurring task occurrences.
- Identifying tasks requiring reminders.
- Processing pending notifications.
- Retrying failed notification attempts.

Background jobs must be safe against duplicate execution. They must not create duplicate task occurrences or notifications when retried.

External email, SMS and push notification integrations are outside the MVP scope.

## 8. High-Level Request Flow

A typical authenticated request follows this flow:

1. The client sends an HTTP request with an access token.
2. Spring Security validates the token.
3. The REST controller validates the request and delegates to the relevant application service.
4. The service checks family membership and permissions.
5. The business operation executes using the module's data-access layer.
6. PostgreSQL persists the changes within a transaction.
7. Relevant activity history is recorded.
8. The API returns an appropriate HTTP response.

## 9. Deployment Model

The MVP will run as:

- One Spring Boot application.
- One PostgreSQL database.
- One Keycloak instance for authentication.
- Background jobs running within the application.

Docker Compose will provide a reproducible local development environment.

The application should remain independently testable, with integration tests using PostgreSQL through Testcontainers.

## 10. Architectural Principles

- Keep business logic separate from transport and persistence concerns.
- Enforce family-level data isolation at every relevant operation.
- Make important business rules explicit and testable.
- Use database transactions to maintain consistency.
- Preserve historical records of important actions.

---

**Architecture direction:** A modular Spring Boot monolith with PostgreSQL, JdbcTemplate, Flyway and Keycloak.
