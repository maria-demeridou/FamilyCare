# FamilyCare — Product Requirements Document

**Version:** 1.0  
**Status:** Draft  
**Product:** Family Care Coordination Platform

## 1. Overview

FamilyCare is a platform that helps families coordinate childcare responsibilities between parents and trusted caregivers.

It provides a shared environment for managing children, assigning care tasks, coordinating schedules and recording completed activities.

## 2. Problem

Childcare responsibilities are often distributed across multiple caregivers, with information scattered across messaging applications, phone calls and calendars.

This creates coordination problems, missed responsibilities and limited visibility into completed activities.

FamilyCare aims to centralize this information and provide a reliable shared record of family care activities.

## 3. Target Users

- **Parents:** Manage family information, children, tasks and caregivers.
- **Caregivers:** View assigned responsibilities and record completed activities.
- **Family Administrators:** Manage family membership and permissions.

## 4. Core Features

1. **Family Management:** Create families, invite members and manage roles.
2. **Child Profiles:** Maintain basic information about children.
3. **Care Tasks:** Create, schedule and assign childcare responsibilities.
4. **Task Execution:** Complete, skip or cancel scheduled tasks.
5. **Activity History:** Maintain a chronological record of important actions.
6. **Notifications:** Notify caregivers about upcoming and overdue responsibilities.

## 5. Product Goals

- Centralize family care coordination.
- Make caregiver responsibilities visible and accountable.
- Prevent missed and duplicated activities.
- Maintain reliable historical records.
- Protect family data through appropriate access controls.

## 6. MVP Scope

The initial release will support multiple families, caregiver memberships, child profiles, task assignments, recurring schedules, task completion and activity history.

## 7. Out of Scope

- Medical diagnosis or recommendations.
- Native mobile applications.
- Payment processing.
- AI-powered features.
- Third-party healthcare integrations.

## 8. Success Criteria

The MVP must demonstrate:

- Secure family-level data isolation.
- Correct role-based authorization.
- Reliable task scheduling and execution.
- Protection against concurrent duplicate actions.
- Traceable activity history.
- Automated integration tests covering critical business rules.
- Reproducible deployment and documented APIs.

## 9. Technical Direction

Java 21, Spring Boot, PostgreSQL, JDBC, Flyway, Spring Security, Keycloak and Docker Compose.

Architecture: Modular monolith.
