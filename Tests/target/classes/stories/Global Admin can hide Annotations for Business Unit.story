!-- NGN-13430
Feature:  Global Admin can hide Annotations for Business Unit
Narrative:
In order to
As a                 GlobalAdmin
I want to            Check user access to Annotations depends on 'Annotations' access option


Scenario: Check that global admin can hide/unhide 'Annotation' access for BU
Meta:@globaladmin
     @gdam
Given I created the agency 'A_GACHANBU_1' with default attributes
And I logged in as 'GlobalAdmin'
When I go to agency 'A_GACHANBU_1' overview page
Then I 'should' see following fields on agency overview page:
| FieldName                                       | FieldValue |
| Enable Annotations Feature                      | true       |
When I update agency 'A_GACHANBU_1' with following fields on agency overview page:
| FieldName                  | FieldValue |
| Enable Annotations Feature | false      |
Then I 'should' see following fields on agency overview page:
| FieldName                                       | FieldValue |
| Enable Annotations Feature                      | false      |


Scenario: Check visibility 'Annotations' access option on user details
Meta:@projects
     @gdam
Given I created the agency 'A_GACHANBU_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| U_GACHANBU_1 | agency.admin | A_GACHANBU_2 |
| U_GACHANBU_2 | agency.user  | A_GACHANBU_2 |
And I logged in as 'GlobalAdmin'
And updated agency 'A_GACHANBU_2' with following fields on agency overview page:
| FieldName                  | FieldValue |
| Enable Annotations Feature | <State>    |
When I login with details of 'U_GACHANBU_1'
And go to user 'U_GACHANBU_2' details page
Then I '<Condition>' see 'annotations' application access checkbox on user 'U_GACHANBU_2' details page

Examples:
| State | Condition  |
| false | should not |
| true  | should     |


Scenario: Check visibility 'Annotate' button on file details for approval owner
Meta:@projects
     @gdam
!--Bug FAB-396 is raised as part of 5.5.26 regression
Given I created users with following fields:
| Email        | Role         | Agency        |
| U_GACHANBU_3 | agency.user  | DefaultAgency |
And I logged in with details of 'U_GACHANBU_3'
And created 'P_GACHANBU_1' project
And created '/F_GACHANBU_1' folder for project 'P_GACHANBU_1'
And uploaded '/images/logo.png' file into '/F_GACHANBU_1' folder for 'P_GACHANBU_1' project
And waited while preview is available in folder '/F_GACHANBU_1' on project 'P_GACHANBU_1' files page
When I login with details of 'AgencyAdmin'
And I set '<State>' 'annotations' application checkbox on user 'U_GACHANBU_3' details page
And login with details of 'U_GACHANBU_3'
And go to file 'logo.png' info page in folder '/F_GACHANBU_1' project 'P_GACHANBU_1'
Then I '<Condition>' see Annotate button on file info page

Examples:
| State | Condition  |
| off   | should not |
| on    | should     |


Scenario: Check that user without 'Annotations' access can not see 'Annotate' button on file details for approver
!--FAB-346
Meta: @bug
      @projects
Given I created users with following fields:
| Email        | Role         | Agency        |
| U_GACHANBU_4 | agency.user  | DefaultAgency |
And I logged in with details of 'AgencyAdmin'
And created 'P_GACHANBU_2' project
And created '/F_GACHANBU_2' folder for project 'P_GACHANBU_2'
And uploaded '/files/Fish Ad.mov' file into '/F_GACHANBU_2' folder for 'P_GACHANBU_2' project
And waited while preview is available in folder '/F_GACHANBU_2' on project 'P_GACHANBU_2' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_GACHANBU_2' project 'P_GACHANBU_2':
| Name            | Approvers    | Deadline         | Description      | Started |
| AS_GACHANBU_S04 | U_GACHANBU_4 | 01/05/2017 11:45 | test description | true    |
When I set 'off' 'annotations' application checkbox on user 'U_GACHANBU_4' details page
And login with details of 'U_GACHANBU_4'
And open link from email when user 'U_GACHANBU_4' received email with next subject 'has requested your approval'
Then I 'should not' see Annotate button on file info page