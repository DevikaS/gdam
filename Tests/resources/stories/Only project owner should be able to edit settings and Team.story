!--NGN-550
Feature:          Only project owner should be able to edit Settings and Team
Narrative:
In order to
As a              AgencyAdmin
I want to         Check owner edit Project settings

Scenario: check that added project administrator can edit Project Settings
Meta:@gdam
@projects
Given I created 'OPOU1' User
And created following projects:
| Name  | Job Number | Administrators | Media Type | Start Date | End Date   |
| OPOP1 | OPOJ1      | OPOU1          | Broadcast  | 12.12.2012 | 12.12.2021 |
And I logged in with details of 'OPOU1'
When I edit the following fields for 'OPOP1' project:
| Name  | Job Number | Media Type | Start date | End date   |
| OPOP1 | OPOJ1      | Print      | 12.12.2013 | 12.12.2022 |
And click on element 'SaveButton'
Then Project 'OPOP1' should include the following fields:
| Name  | Job Number | Media Type | Start date | End date   |
| OPOP1 | OPOJ1      | Print      | 12.12.2013 | 12.12.2022 |


Scenario: add project owner by added project administrator
Meta:@gdam
@projects
Given I created following users:
| User Name |
| OPOU2_1   |
| OPOU2_2   |
And created following projects:
| Name  | Job Number | Administrators |
| OPOP2 | OPOJ2      | OPOU2_1        |
And I logged in with details of 'OPOU2_1'
And added user 'OPOU2_2' into address book
When I edit the following fields for 'OPOP2' project:
| Name  | Job Number | Administrators |
| OPOP2 | OPOJ2      | OPOU2_2        |
And click on element 'SaveButton'
Then I should see user 'OPOU2_2' has role 'Project Admin' on project 'OPOP2' team page
And 'should' see administrator 'OPOU2_2' on project 'OPOP2' settings tab



Scenario: check that  project administrator can add new member to Team
Meta:@gdam
@projects
Given I created following users:
| User Name |
| OPOU3_1   |
| OPOU3_2   |
And created following projects:
| Name  | Job Number | Administrators   |
| OPOP3 | OPOJ3      | OPOU3_1          |
And created '/F1' folder for project 'OPOP3'
And created 'OPOR3' role in 'project' group for advertiser 'DefaultAgency'
And I logged in with details of 'OPOU3_1'
And I am on project 'OPOP3' teams page
And refreshed the page
When I add user 'OPOU3_2' into project 'OPOP3' team with role 'OPOR3' expired '12.12.2021' for folder on popup '/F1'
Then I 'should' see user 'OPOU3_2' name in teams of project 'OPOP3'


Scenario: check that project administrator can remove member of Team
Meta:@gdam
@projects
Given I created 'OPOU4' User
And created following projects:
| Name  | Job Number |
| OPOP4 | OPOJ4      |
And created '/F1' folder for project 'OPOP4'
And created 'OPOR4' role in 'project' group for advertiser 'DefaultAgency'
And added users 'OPOU4' to project 'OPOP4' team folders '/F1' with role 'OPOR4' expired '12.12.2021'
And I logged in with details of 'OPOU4'
And I am on project 'OPOP4' teams page
When I remove user 'AgencyAdmin' from project 'OPOP4' team page
Then I 'should not' see user 'AgencyAdmin' name in teams of project 'OPOP4'


Scenario: check that project administrator can edit permissions of team member
!--FAB-780 5.7.0_bug
Meta:@gdam
@projects
Given I created 'OPOU5' User
And created following projects:
| Name  | Job Number |
| OPOP5 | OPOJ5      |
And created '/F1' folder for project 'OPOP5'
And created 'OPOR5' role in 'project' group for advertiser 'DefaultAgency'
And created 'OPOR5_ATP' role in 'project' group for advertiser 'DefaultAgency'
And added users 'OPOU5' to project 'OPOP5' team folders '/F1' with role 'OPOR5' expired '12.12.2021'
And I am on project 'OPOP5' teams page
When I open user 'OPOU5' permissions on project 'OPOP5' team page
When I select folder '/F1' in manage permissions popup of project 'OPOP5' team for user 'OPOU5'
And select role 'OPOR5_ATP' in user 'OPOU5' permissions popup for project 'OPOP5' team
And click Add role button on permissions popup of project team tab
And click element 'Save' on page 'ManagePermissionsPopUp'
Then I should see user 'OPOU5' has role 'OPOR5_ATP,OPOR5' on project 'OPOP5' team page



Scenario: check that project user can't edit project setting
Meta:@gdam
@projects
Given I created users with following fields:
| Email | Role        |
| OPOU6 | agency.user |
And created following projects:
| Name  | Job Number |
| OPOP6 | OPOJ6      |
And created '/F1' folder for project 'OPOP6'
And created 'OPOR6' role in 'project' group for advertiser 'DefaultAgency'
And added users 'OPOU6' to project 'OPOP6' team folders '/F1' with role 'OPOR6' expired '12.12.2021'
And I logged in with details of 'OPOU6'
And waited for '5' seconds
When I go to project 'OPOP6' overview page
Then I 'should not' see element 'EditLink' on page 'ProjectsOverview'


Scenario: check that project user(not owner) can't see Team tab
Meta:@gdam
@projects
Given I created users with following fields:
| Email | Role        |
| OPOU7 | agency.user |
And created following projects:
| Name  | Job Number |
| OPOP7 | OPOJ7      |
And created '/F1' folder for project 'OPOP7'
And created 'OPOR7' role in 'project' group for advertiser 'DefaultAgency'
And added users 'OPOU7' to project 'OPOP7' team folders '/F1' with role 'OPOR7' expired '12.12.2021'
And I logged in with details of 'OPOU7'
When I go to project 'OPOP7' overview page
Then I 'should not' see element 'TeamsTab' on page 'ProjectsOverview'