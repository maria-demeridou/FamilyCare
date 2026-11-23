# FamilyCare — User Stories

## 1. Identity & Access

### US-01: Access FamilyCare

**As a user,** I want to authenticate securely so that I can access my family information.

**Acceptance criteria:**

- Users must authenticate before accessing protected resources.
- Each authenticated account is associated with a unique application user.
- Unauthenticated requests to protected resources are rejected.
- Users can only access resources they are authorized to access.

**Priority:** Must

## 2. Family Management

### US-02: Create a family

**As a user,** I want to create a family so that I can organize childcare responsibilities in a shared space.

**Acceptance criteria:**

- An authenticated user can create a family.
- The creator automatically becomes its OWNER.
- A family must have a name.
- The creator can immediately access the new family.

**Priority:** Must

### US-03: Invite a family member

**As a family OWNER or PARENT,** I want to invite another user so that they can participate in childcare coordination.

**Acceptance criteria:**

- Only authorized family members can create invitations.
- An invitation specifies the intended family role.
- Invitations have a unique token and expiration date.
- Duplicate pending invitations for the same email and family are prevented.
- The invitation is associated with the family that created it.
- The invitation can be revoked by the owner or the parent.

**Priority:** Must

### US-04: Accept a family invitation

**As an invited user,** I want to accept an invitation so that I can join a family.

**Acceptance criteria:**

- Only the intended recipient can accept an invitation.
- Expired, revoked or already accepted invitations cannot be accepted.
- Accepting an invitation creates a family membership with the assigned role.
- The invitation cannot create duplicate memberships.
- The new member can access only resources permitted by their role.

**Priority:** Must

### US-05: Manage family membership

**As a family OWNER,** I want to manage family membership so that I can control who participates in childcare coordination.

**Acceptance criteria:**

- The OWNER can view family members and their roles.
- Authorized users can change membership roles within their permissions.
- The OWNER can remove family members.
- Removed members immediately lose access to family resources.
- A family must always have an OWNER.

**Priority:** Must

## 3. Child Management

### US-06: Create a child profile

**As a family OWNER or PARENT,** I want to create a child profile so that childcare responsibilities can be associated with a specific child.

**Acceptance criteria:**

- Authorized family members can create child profiles.
- A child profile must belong to exactly one family.
- A profile includes a name and date of birth.
- Users cannot create profiles in families they do not belong to.

**Priority:** Must

### US-07: View and update child profiles

**As a family member,** I want to view child profiles and authorized members to update them so that family information remains accurate.

**Acceptance criteria:**

- Family members can view profiles belonging to their family.
- Only authorized roles can update child information.
- Users cannot access or modify profiles belonging to another family.
- Child profiles with existing activity history cannot be permanently deleted through normal application operations.

**Priority:** Must

### US-08: Archive and restore child profiles

**As a family OWNER or PARENT,** I want to archive or restore a child profile so that inactive profiles do not appear in everyday family operations.
Their historical records remain available.

**Acceptance criteria:**

- Authorized family members can archive an active child profile.
- Archived profiles are excluded from active child listings. 
- New care tasks cannot be created for archived children.
- Existing tasks and activity history remain preserved. 
- Authorized family members can restore an archived profile. 
- Archiving and restoring are recorded in the activity history. 
- Archived profiles cannot be permanently deleted through normal application operations.

**Priority:** Must

## 4. Care Task Management

### US-09: Create a care task

**As a family OWNER or PARENT,** I want to create a care task so that a childcare responsibility is clearly defined.

**Acceptance criteria:**

- A task must have a title, child, scheduled date and time.
- A task must belong to the same family as its child.
- Optional descriptions and notes can be provided.
- Only authorized family members can create tasks.
- Task creation is recorded in the activity history.

**Priority:** Must

### US-10: Assign a care task

**As a family OWNER or PARENT,** I want to assign a task to a family member so that responsibility has a clear owner.

**Acceptance criteria:**

- Each task occurrence has exactly one responsible caregiver.
- The assignee must be an active member of the same family.
- Only authorized family members can assign or reassign tasks.
- Reassignment is recorded in the activity history.
- Unauthorized users cannot assign tasks.

**Priority:** Must

### US-11: Schedule recurring care tasks

**As a family OWNER or PARENT,** I want to create recurring tasks so that regular childcare responsibilities do not need to be entered manually.

**Acceptance criteria:**

- Users can define a recurrence pattern and its applicable start and end dates.
- The system generates individual task occurrences from the recurrence definition.
- Each occurrence has its own scheduled date, time and execution status.
- Changes to a recurrence definition do not overwrite previously completed occurrences.
- Recurrence calculations respect the family's configured time zone.

**Priority:** Must

## 5. Task Execution

### US-12: View assigned tasks

**As a caregiver,** I want to view my assigned tasks so that I know which childcare responsibilities I need to perform.

**Acceptance criteria:**

- Caregivers can view tasks assigned to them.
- Tasks can be viewed by date and execution status.
- Task information includes the child, scheduled time and relevant instructions.
- Caregivers cannot view tasks belonging to unrelated families.

**Priority:** Must

### US-13: Complete a care task

**As an assigned caregiver,** I want to mark a task as completed so that other family members know the responsibility has been fulfilled.

**Acceptance criteria:**

- Only the assigned caregiver or an explicitly authorized family member can complete a task.
- The system records the completion timestamp and acting user.
- Optional completion notes can be provided.
- A completed task cannot be completed again.
- Concurrent completion requests cannot produce duplicate successful completions.
- Completion is recorded in the activity history.

**Priority:** Must

### US-14: Cancel a care task

**As an authorized family member,** I want to cancel a task so that the schedule accurately reflects what happened.

**Acceptance criteria:**

- Authorized users can cancel eligible pending tasks.
- A canceled task records the acting user, timestamp and optionally reason.
- Completed or already canceled tasks cannot be canceled again.
- Task status changes are recorded in the activity history.

**Priority:** Must

## 6. Activity History & Notifications

### US-15: View family activity history

**As a family member,** I want to view a chronological activity history so that I can understand what happened and who performed each action.

**Acceptance criteria:**

- Authorized family members can view activity belonging to their family.
- Activity entries identify the acting user, action and timestamp.
- Relevant task and child references are included.
- Activity records cannot be modified through normal application operations.
- Users cannot access activity belonging to another family.

**Priority:** Must

### US-15: Receive task reminders

**As an assigned caregiver,** I want to be notified about upcoming and overdue tasks so that I do not forget my responsibilities.

**Acceptance criteria:**

- The system identifies tasks approaching their scheduled time.
- Pending tasks can be identified as overdue after their scheduled time.
- Notifications are associated with the intended recipient and task.
- Duplicate notifications for the same reminder event are prevented.
- Notification processing failures can be retried.

**Priority:** Must

---

## 7. Priority Summary

| Priority | Meaning                                   |
| -------- | ----------------------------------------- |
| Must     | Required for the initial usable release   |
| Should   | Valuable, but can follow the core release |

**Initial scope:** 15 Must stories and 0 Should story.

The Must stories establish the complete core workflow: create a family, invite caregivers, manage children, schedule responsibilities, execute tasks, review activities and receive task reminders.

## 8. Scope Notes

- Authentication is delegated to Keycloak.
- Family membership determines access to family-owned resources.
- A user may belong to multiple families with different roles.
- Task recurrence definitions and individual task occurrences are separate concepts.
- Overdue status is derived from the scheduled time and current execution status.
- The application records caregiver-provided information; it does not provide medical advice or diagnosis.
- External email, SMS and push notification integrations are outside the initial MVP scope.
