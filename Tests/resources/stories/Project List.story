!--NGN-120
Feature:          Project List
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Project list

Meta:
@component project

Scenario: Correct counting of selected projects on page
Meta:@gdam
@projects
Given I created '5' projects with name pattern 'PLV'
And I am on Project list page
When I select '5' projects in project list
Then I should see '5' selected note in projects counter


Scenario: Verify that all projects are selected using Select All
Meta:@gdam
@projects
Given I created the agency 'A_PL_Select_all' with default attributes
And I created users with following fields:
| Agency          | Email           | Role |
| A_PL_Select_all | U_PL_Select_all | agency.admin |
And I logged in with details of 'U_PL_Select_all'
And I created '10' projects with name pattern 'PLV'
And I am on Project list page
When I refresh the page
When click 'Select all' checkbox on project list
Then I should see '10' selected note in projects counter
And all projects count '10' is 'selected' in Project list


Scenario: Check project list filtering
Meta:@gdam
@projects
Given I am on Project list page
When I select filtering by view '<View>'
Then I should see '<View>' projects on Project list

Examples:
| View         |
| All Projects |
| My Projects  |


Scenario: check that filter work correctly for user with WR permission
Meta:@gdam
@projects
Given I created the agency 'A_PLS_S08' with default attributes
And created users with following fields:
| Email       | Role         | Agency    |
| AU_PLS_S08  | agency.admin | A_PLS_S08 |
| <UserEmail> | <UserRole>   | A_PLS_S08 |
And logged in with details of 'AU_PLS_S08'
And created 'P_PLS_S08' project
And created 'WR_PLS_S08' work request
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And created '<WorkRequestName>' work request
When I go to project list page
When I select filtering by view '<View>'
Then I 'should' see project '<VisibleObjects>' on project list page
And 'should not' see project '<InvisibleObjects>' on project list page

Examples:
| UserEmail   | UserRole     | ProjectName | WorkRequestName | View              | VisibleObjects                                | InvisibleObjects                  |
| U_PLS_S08_2 | agency.admin | P_PLS_S08_2 | WR_PLS_S08_2    | All Projects      | P_PLS_S08_2,P_PLS_S08                         | WR_PLS_S08_2,WR_PLS_S08           |
| U_PLS_S08_4 | agency.admin | P_PLS_S08_4 | WR_PLS_S08_4    | My Projects       | P_PLS_S08_4                                   | WR_PLS_S08_4,P_PLS_S08,WR_PLS_S08 |


Scenario: check that filter work correctly for user without WR permission
Meta:@gdam
@projects
Given I created the agency 'A_PLS_S09' with default attributes
And created users with following fields:
| Email       | Role         | Agency    |
| AU_PLS_S09  | agency.admin | A_PLS_S09 |
| <UserEmail> | <UserRole>   | A_PLS_S09 |
And logged in with details of 'AU_PLS_S09'
And created 'P_PLS_S09' project
And created 'WR_PLS_S09' work request
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
When I go to project list page
When I select filtering by view '<View>'
Then I 'should' see project '<VisibleObjects>' on project list page
And 'should not' see project '<InvisibleObjects>' on project list page

Examples:
| UserEmail   | UserRole    | ProjectName | View              | VisibleObjects | InvisibleObjects     |
| U_PLS_S09_1 | agency.user | P_PLS_S09_1 | All               | P_PLS_S09_1    | P_PLS_S09,WR_PLS_S09 |
| U_PLS_S09_2 | agency.user | P_PLS_S09_2 | My Projects       | P_PLS_S09_2    | P_PLS_S09,WR_PLS_S09 |