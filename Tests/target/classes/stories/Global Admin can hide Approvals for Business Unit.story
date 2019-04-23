!--NGN-13429
Feature:             Global Admin can hide Approvals for Business Unit
Narrative:
In order to
As a                 AgencyAdmin
I want to            Check user access to Approvals depends on 'Approvals' access option


Scenario: Check that global admin can hide/unhide 'Approvals' access for BU
Meta:@gdam
@globaladmin
Given I created the agency 'A_GACHAFBU_1' with default attributes
And I logged in as 'GlobalAdmin'
When I update agency 'A_GACHAFBU_1' with following fields on agency overview page:
| FieldName                | FieldValue |
| Enable Approvals Feature | false      |
And refresh the page
Then I 'should' see following fields on agency overview page:
| FieldName                 | FieldValue |
| Enable Approvals Feature  | false      |

Scenario: Check visibility 'Approvals' access option on user details
Meta:@approvals
     @gdam
Given I created the following agency:
| Name            | A4User        |
| A_GACHAFBU_1    | DefaultA4User |
And I logged in as 'GlobalAdmin'
And updated agency 'A_GACHAFBU_1' with following fields on agency overview page:
| FieldName                | FieldValue |
| Enable Approvals Feature | <State>    |
And created users with following fields:
| Email        | Role         | Agency       |
| U_GACHAFBU_3 | agency.admin | A_GACHAFBU_1 |
| U_GACHAFBU_4 | agency.user  | A_GACHAFBU_1 |
When I login with details of 'U_GACHAFBU_3'
And go to user 'U_GACHAFBU_4' details page
Then I '<Condition>' see 'approvals' application access checkbox on user 'U_GACHAFBU_4' details page

Examples:
| State | Condition  |
| true  | should     |
| false | should not |

Scenario: Check that user without Approvals access can not see Approvals section on Dashboard
Meta:@gdam
@approvals
Given I created users with following fields:
| Email          | Role          | Agency        |
| U_GACHAFBU_4_N | agency.user   | DefaultAgency |
And set 'off' 'approvals' application checkbox on user 'U_GACHAFBU_4_N' details page
When I login with details of 'U_GACHAFBU_4_N'
Then I 'should not' see section 'Approvals' on Dashboard page

Scenario: Check that approver without Approvals access still can see file from email link
Meta:@approvals
     @gdam
Given I created users with following fields:
| Email        | Role          | Agency        | Access             |
| U_GACHAFBU_5 | agency.user   | DefaultAgency | folders, dashboard |
And created 'P_GACHAFBU_S08' project
And created '/F_GACHAFBU_S08' folder for project 'P_GACHAFBU_S08'
And uploaded '/files/atCalcImage.jpg' file into '/F_GACHAFBU_S08' folder for 'P_GACHAFBU_S08' project
And waited while preview is available in folder '/F_GACHAFBU_S08' on project 'P_GACHAFBU_S08' files page
And added approval stage on file 'atCalcImage.jpg' approvals page in folder '/F_GACHAFBU_S08' project 'P_GACHAFBU_S08':
| Name            | Approvers    | Deadline         | Reminder         | Started |
| AS_GACHAFBU_S08 | U_GACHAFBU_5 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I login with details of 'U_GACHAFBU_5'
And I open link from email when user 'U_GACHAFBU_5' received email with next subject 'has requested your approval'
Then I 'should' see approval stages with the following information:
| Name            | Status  | Reminder        | Deadline         |
| AS_GACHAFBU_S08 | pending | 5/1/23, 8:00 AM | 5/1/23, 12:15 PM |
