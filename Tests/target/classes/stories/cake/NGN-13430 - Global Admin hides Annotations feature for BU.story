!--NGN-13430
Feature:          Global Admin hides annotations module for BU
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Ensure access levels are respected as set for the user's agency.

Meta:
@cake

Scenario: Users without approvals access cannot see Approval-related sections on Dashboard.
Given I created the agency 'A_USHTOCF_S01' with default attributes
And created users with following fields:
| Email           | Role         | Agency        | Access                      |
| U_USHTOCF_S01_1 | agency.admin | A_USHTOCF_S01 | library,folders,annotations |
| U_USHTOCF_S01_2 | agency.admin | A_USHTOCF_S01 | library,folders             |
And logged in with details of '<User>'
And created 'P_USHTOCF_S01' project
And created '/F_USHTOCF_S01' folder for project 'P_USHTOCF_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_USHTOCF_S01' folder for 'P_USHTOCF_S01' project
And waited while preview is available in folder '/F_USHTOCF_S01' on project 'P_USHTOCF_S01' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_USHTOCF_S01' project 'P_USHTOCF_S01'
Then I '<Condition>' see element 'AnnotateButton' on page 'FilesPage'

Examples:
| User            | Condition  | ApprovalsEnabled  |
| U_USHTOCF_S01_1 | should     | true              |
| U_USHTOCF_S01_2 | should not | false             |
