# FamilyCare — Business Rules

## 1. User & Family Membership

1. A user can belong to multiple families.
2. A family can have multiple members.
3. Each user can have only one membership per family.
4. Each membership has exactly one role: `OWNER`, `PARENT` or `CAREGIVER`.
5. A user's role is independent for each family membership.
6. Permissions granted in one family do not apply to other families.
7. Removing a user's membership from one family does not affect their memberships in other families.
8. A user account can exist without belonging to any family.
9. Every family must have exactly one OWNER.
10. A family cannot be left without an OWNER through normal membership operations.

## 2. Roles & Permissions

| Operation                        | OWNER | PARENT  | CAREGIVER |
| -------------------------------- | :---: | :-----: | :-------: |
| View family information          |  Yes  |   Yes   |    Yes    |
| Manage family settings           |  Yes  |   No    |    No     |
| Invite members                   |  Yes  |   Yes   |    No     |
| Manage membership                |  Yes  | Limited |    No     |
| Create and update child profiles |  Yes  |   Yes   |    No     |
| Archive and restore children     |  Yes  |   Yes   |    No     |
| Create and manage care tasks     |  Yes  |   Yes   |    No     |
| Assign and reassign tasks        |  Yes  |   Yes   |    No     |
| View assigned tasks              |  Yes  |   Yes   |    Yes    |
| Complete assigned tasks          |  Yes  |   Yes   |    Yes    |
| Cancel tasks                     |  Yes  |   Yes   |    No     |
| View activity history            |  Yes  |   Yes   |    Yes    |

Additional rules:

1. All permissions are evaluated within the relevant family.
2. A CAREGIVER can only view and execute tasks assigned to them.
3. A CAREGIVER cannot change task assignments or task schedules.
4. A PARENT cannot remove or demote the OWNER.
5. Only the OWNER can transfer ownership or delete the family.
6. An OWNER can perform actions on behalf of another family member where explicitly permitted by the application.

## 3. Family Invitations

1. Only OWNERs and PARENTs can invite users.
2. Every invitation belongs to exactly one family.
3. An invitation specifies the intended recipient and family role.
4. An invitation must have a unique token and expiration date.
5. Only the intended recipient can accept an invitation.
6. Expired, revoked or already accepted invitations cannot be accepted again.
7. Accepting an invitation creates a family membership with the assigned role.
8. A user who already belongs to the family cannot create another membership by accepting an invitation.
9. Multiple requests to accept the same invitation must not create duplicate memberships.
10. An invitation can be revoked by an authorized family member before acceptance.

## 4. Child Profiles

1. Every child profile belongs to exactly one family.
2. Only OWNERs and PARENTs can create or update child profiles.
3. Family members can view child profiles belonging to their family.
4. Child profiles can be archived instead of permanently deleted.
5. Archived profiles are excluded from active child listings.
6. New care tasks cannot be created for archived children.
7. Existing tasks and activity history must remain preserved when a child is archived.
8. Only OWNERs and PARENTs can restore archived profiles.
9. Archiving and restoring a child profile must be recorded in the activity history.

## 5. Care Tasks & Assignments

1. Every care task belongs to exactly one family and one child.
2. A task must have a title and scheduled date and time.
3. A task must have exactly one responsible caregiver per occurrence.
4. The assigned caregiver must be an active member of the same family.
5. Only OWNERs and PARENTs can create, update, assign or reassign tasks.
6. Reassigning a task must be recorded in the activity history.
7. Tasks cannot be created for archived children.
8. Tasks belonging to one family cannot be accessed by members of another family.
9. Each task occurrence is managed independently, even when generated from the same recurring definition.

## 6. Task Lifecycle

### 6.1 Supported statuses

A task occurrence can have one of the following stored statuses:

- `PENDING`
- `COMPLETED`
- `CANCELLED`

### 6.2 Completion

1. An assigned CAREGIVER, OWNER or PARENT can complete an eligible task.
2. The system records the actual completion timestamp and acting user.
3. Completion notes are optional.
4. A task can only be completed once.
5. A completed task cannot be canceled.
6. Completion must be recorded in the activity history.
7. Completing an overdue task is permitted and must preserve the actual completion time.

### 6.3 Cancellation

1. Only OWNERs and PARENTs can cancel a task.
2. Cancellation means the responsibility is no longer required.
3. A cancelled task must record the acting user and timestamp.
4. A cancellation reason can be provided.
5. A cancelled task cannot be completed afterward.
6. Cancellation must be recorded in the activity history.

### 6.4 Overdue tasks

1. A pending task becomes overdue when its scheduled time has passed.
2. Overdue is a derived condition, not a stored task status.
3. An overdue task remains pending until it is completed or canceled.
4. The system must never automatically convert an overdue task into a canceled task.
5. Overdue tasks can still be completed or canceled by authorized users.

## 7. Recurring Tasks

1. A recurring task defines a schedule for generating individual task occurrences.
2. Each generated occurrence is an independent task with its own status and execution history.
3. Recurrence definitions must specify a recurrence pattern and applicable date range.
4. Changes to a recurrence definition must not modify previously completed occurrences.
5. Generated occurrences must respect the family's configured time zone.
6. Each occurrence must have an independent responsible caregiver.
7. Cancelling or modifying a recurrence definition must not automatically erase historical occurrences.
8. A single occurrence can be canceled without cancelling the entire recurrence.

## 8. Activity History

1. Important family actions must be recorded in the activity history.
2. Each activity entry must identify the family, acting user, action and timestamp.
3. Relevant child and task references should be included.
4. Activity history must preserve the sequence of important actions.
5. Activity records cannot be modified or deleted through normal application operations.
6. Users can only access activity history belonging to families they are authorized to access.
7. System-generated actions must be distinguishable from user-initiated actions.

## 9. Notifications

1. Notifications are associated with a family, recipient and relevant task.
2. Only authorized recipients can access their notifications.
3. Upcoming and overdue tasks can trigger notifications.
4. Duplicate notifications for the same reminder event must be prevented.
5. Failed notification processing must support retries.
6. Notification failures must not change the underlying task status.

## 10. Data Integrity & Authorization

1. Every family-owned resource must be associated with exactly one family.
2. Users must be authorized through an active membership before accessing family resources.
3. Authorization must be checked for every operation, not only when retrieving resources.
4. Family identifiers supplied by clients must never be trusted without authorization checks.
5. Database constraints must enforce critical uniqueness and referential integrity rules.
6. Operations involving multiple related records must maintain transactional consistency.
7. Concurrent requests must not result in invalid task transitions or duplicate memberships.

---

## 11. Out of Scope for MVP

- Caregiver self-service task cancellation.
- Reporting inability to complete an assigned task.
- Permanent deletion of child profiles through normal application operations.
- Automatic resolution of overdue tasks.
- Medical advice, diagnosis or treatment recommendations.
