!--NGN-13429
Feature:          Global Admin hides Library module for BU
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Ensure access levels are respected as set for the user's agency.

Meta:
@cake

Scenario: Users from BU cannot see Approval-related sections on Dashboard when approvals disabled for BU.
Given I created the agency 'A_USHTOCD_S01' with default attributes
And created users with following fields:
| Email           | Role         | Agency        | Access                    |
| U_USHTOCD_S01_1 | agency.admin | A_USHTOCD_S01 | library,folders,approvals |
| U_USHTOCD_S01_2 | agency.admin | A_USHTOCD_S01 | library,folders           |
When I update agency 'A_USHTOCD_S01' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Enable Approvals Feature                        | false              |
And login with details of 'U_USHTOCD_S01_1'
Then I 'should not' see section 'Approvals' on Dashboard page


Scenario: Users without approvals accesscannot see Approval-related sections on Dashboard.
Given I created the agency 'A_USHTOCE_S01' with default attributes
And created users with following fields:
| Email           | Role         | Agency        | Access                    |
| U_USHTOCE_S01_1 | agency.admin | A_USHTOCE_S01 | library,folders,approvals |
| U_USHTOCE_S01_2 | agency.admin | A_USHTOCE_S01 | library,folders           |
And logged in with details of '<User>'
And created 'P_USHTOCE_S01' project
And created '/F_USHTOCE_S01' folder for project 'P_USHTOCE_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_USHTOCE_S01' folder for 'P_USHTOCE_S01' project
And waited while preview is available in folder '/F_USHTOCE_S01' on project 'P_USHTOCE_S01' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_USHTOCE_S01' project 'P_USHTOCE_S01'
And click element 'MoreButton' on page 'FilesPage'
Then I '<Condition>' see element 'SendForApproval' on page 'FilesPage'

Examples:
| User            | Condition  | ApprovalsEnabled  |
| U_USHTOCE_S01_1 | should     | true              |
| U_USHTOCE_S01_2 | should not | false             |
