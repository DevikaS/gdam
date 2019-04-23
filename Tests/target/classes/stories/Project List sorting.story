!--NGN-127
Feature:          Project List sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Project List sorting



Scenario: Default sorting for project list (by created date)
Meta:@gdam
@projects
Given I created the agency 'A_PROLIST_A01_1' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique        |
| PROLIST_U01_1 | agency.admin | A_PROLIST_A01_1     |
And logged in with details of 'PROLIST_U01_1'
And created following projects:
| Name           | Job Number |
| 1715           | zZ         |
| 5thCorporation | 567        |
| dDrum&Bass     | dD         |
| Zero Company   | aA         |
| zZZZAd         | D          |
And refreshed the page
And I am on Project list page
Then I should see projects sorted by field '_created' in order 'desc'


Scenario: Check sorting by Job Number/Project name
Meta:@gdam
@projects
Given I am on Project list page
And 'add' following project column 'Job number' on opened Project list page
When I sorting projects by field '<FieldName>' in order '<Order>'
Then I should see projects sorted by field '<FieldName>' in order '<Order>'

Examples:
| FieldName | Order |
| Title     | asc   |
| Title     | desc  |
| jobNumber | asc   |
| jobNumber | desc  |


Scenario: Check sorting by lastActivity
Meta:@gdam
@projects
Given I am on Project list page
When I sorting projects by field '<FieldName>' in order '<Order>'
Then I should see projects sorted by field '<FieldName>' in order '<Order>'

Examples:
| FieldName    | Order |
| lastActivity | asc   |
| lastActivity | desc  |


Scenario: Check sorting by created field
Meta:@gdam
@projects
Given I created the agency 'CHEDSA_1_1' with default attributes
And created users with following fields:
| Email      | Role         | Agency     |
| CHEDSU_1_1 | agency.admin | CHEDSA_1_1 |
And logged in with details of 'CHEDSU_1_1'
And the following projects were created:
| Name           | Job Number |
| 1715           | zZ         |
| 5thCorporation | 567        |
| dDrum&Bass     | dD         |
| Zero Company   | aA         |
| zZZZAd         | D          |
And I am on Project list page
Then I should see projects sorted by field '_created' in order 'desc'


Scenario: Check that data in lastActivity column gets sorted in desc order on project list page
Meta:@gdam
@projects
!--QA-1190
Given I created the agency 'CHEDSA_1' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| CHEDSU_1 | agency.admin | CHEDSA_1 |
| CHEDSU_2 | agency.admin | CHEDSA_1 |
| CHEDSU_3 | agency.admin | CHEDSA_1 |
And logged in with details of 'CHEDSU_1'
And created 'PR_CU_S01_1' project
And logged in with details of 'CHEDSU_2'
And created 'PR_CU_S01_2' project
And created 'PR_CU_S01_3' project
And logged in with details of 'CHEDSU_3'
And created 'PR_CU_S01_4' project
And I am on Project list page
When I sorting projects by field 'lastActivity' in order 'desc'
Then I 'should' see data in 'Last Activity' column sorted in following order on project list page:
| Last Activity |
| CHEDSU_1      |
| CHEDSU_2      |
| CHEDSU_2      |
| CHEDSU_3      |
And I 'should' see data in 'Name' column sorted in following order on project list page:
| Name        |
| PR_CU_S01_1 |
| PR_CU_S01_2 |
| PR_CU_S01_3 |
| PR_CU_S01_4 |


Scenario: Check that data in lastActivity column gets sorted in asc order on project list page
Meta:@gdam
@projects
!--QA-1190
Given I created the agency 'CHEDSA_2' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| CHEDSU_4 | agency.admin | CHEDSA_2 |
| CHEDSU_5 | agency.admin | CHEDSA_2 |
| CHEDSU_6 | agency.admin | CHEDSA_2 |
And logged in with details of 'CHEDSU_4'
And created 'PR_CU_S01_5' project
And logged in with details of 'CHEDSU_5'
And created 'PR_CU_S01_6' project
And created 'PR_CU_S01_7' project
And logged in with details of 'CHEDSU_6'
And created 'PR_CU_S01_8' project
And I am on Project list page
When I sorting projects by field 'lastActivity' in order 'asc'
Then I 'should' see data in 'Last Activity' column sorted in following order on project list page:
| Last Activity |
| CHEDSU_6      |
| CHEDSU_5      |
| CHEDSU_5      |
| CHEDSU_4      |
And I 'should' see data in 'Name' column sorted in following order on project list page:
| Name        |
| PR_CU_S01_8 |
| PR_CU_S01_7 |
| PR_CU_S01_6 |
| PR_CU_S01_5 |


Scenario: Check that data in mediaType column gets sorted in desc order on project list page
Meta:@gdam
@projects
!--QA-1190
Given I created the agency 'CHEDSA_3' with default attributes
And created users with following fields:
| Email    | Role        | Agency   |
| CHEDSU_7 | agency.user | CHEDSA_3 |
And logged in with details of 'CHEDSU_7'
And created 'PR_CU_S01_1' project
And created 'PR_CU_S01_2' project
And I created new project with following fields:
| FieldName  | FieldValue   |
| Name       | PR_CU_S01_3  |
| Media type | Other        |
| Start date | Today        |
| End date   | Tomorrow     |
And I created new project with following fields:
| FieldName  | FieldValue   |
| Name       | PR_CU_S01_4  |
| Media type | Cross Media  |
| Start date | Today        |
| End date   | Tomorrow     |
And I am on Project list page
And 'add' following project column 'Media type' on opened Project list page
When I sorting projects by field 'Media type' in order 'desc'
Then I 'should' see data in 'Media type' column sorted in following order on project list page:
| Media type  |
| Other       |
| Cross Media |
| Broadcast   |
| Broadcast   |
And I 'should' see data in 'Name' column sorted in following order on project list page:
| Name        |
| PR_CU_S01_3 |
| PR_CU_S01_4 |
| PR_CU_S01_1 |
| PR_CU_S01_2 |