!--NGN-1261
Feature:          Project Team - Activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check project team activity

Scenario: Check that all project activity is displayed on right side of Project Team page if no user is selected
Meta:@gdam
@projects
Given I created 'P_PTA_S01' project
And created '/F1' folder for project 'P_PTA_S01'
And created users with following fields:
| Email      |
| U1_PTA_S01 |
| U2_PTA_S01 |
And created 'PR_PTA_S01' role with 'folder.read,element.read' permissions in 'project' group for advertiser 'DefaultAgency'
And added users 'U1_PTA_S01,U2_PTA_S01' to project 'P_PTA_S01' team folders '/F1' with role 'PR_PTA_S01' expired '12.12.2021'
And logged in with details of 'U1_PTA_S01'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_PTA_S01' project
And logged in with details of 'U2_PTA_S01'
And uploaded '/images/logo.gif' file into '/F1' folder for 'P_PTA_S01' project
And logged in with details of 'AgencyAdmin'
And waited while transcoding is finished in folder '/F1' on project 'P_PTA_S01' files page
When I go to project 'P_PTA_S01' folder '/F1' page
And go to project 'P_PTA_S01' teams page
Then I 'should' see activity for user 'U1_PTA_S01' on project team page with message 'uploaded 1 files logo.png' and value 'P_PTA_S01/P_PTA_S01/F1/logo.png'
And 'should' see activity for user 'U2_PTA_S01' on project team page with message 'uploaded 1 files logo.gif' and value 'P_PTA_S01/P_PTA_S01/F1/logo.gif'


Scenario: Check that only activity of selected user in the project are displayed
Meta:@gdam
@projects
Given I created 'P_PTA_S02' project
And created '/F1' folder for project 'P_PTA_S02'
And created users with following fields:
| Email      |
| U1_PTA_S02 |
| U2_PTA_S02 |
And created 'PR_PTA_S02' role with 'folder.read,element.read' permissions in 'project' group for advertiser 'DefaultAgency'
And added users 'U1_PTA_S02,U2_PTA_S02' to project 'P_PTA_S02' team folders '/F1' with role 'PR_PTA_S02' expired '12.12.2021'
And logged in with details of 'U1_PTA_S02'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_PTA_S02' project
And logged in with details of 'U2_PTA_S02'
And uploaded '/images/logo.gif' file into '/F1' folder for 'P_PTA_S02' project
And logged in with details of 'AgencyAdmin'
And waited while transcoding is finished in folder '/F1' on project 'P_PTA_S02' files page
When I go to project 'P_PTA_S02' teams page
And open user 'U1_PTA_S02' details on project 'P_PTA_S02' team page
Then I 'should' see activity for user 'U1_PTA_S02' on project team page with message 'uploaded 1 files logo.png' and value 'P_PTA_S02/P_PTA_S02/F1/logo.png'
And 'should not' see activity for user 'U2_PTA_S02' on project team page with message 'uploaded 1 files logo.gif' and value 'P_PTA_S02/P_PTA_S02/F1/logo.gif'


Scenario: Check that clicking on username on Recent Activity section should select user on team page
!--As per QA-678 Modified test
Meta:@gdam
@projects
Given I created 'P_PTA_S03' project
And created '/F1' folder for project 'P_PTA_S03'
And created users with following fields:
| Email     |
| U_PTA_S03 |
And created 'PR_PTA_S03' role with 'folder.read,element.read' permissions in 'project' group for advertiser 'DefaultAgency'
And added users 'U_PTA_S03,U1_PTA_S03,U2_PTA_S03' to project 'P_PTA_S03' team folders '/F1' with role 'PR_PTA_S03' expired '12.12.2021'
And logged in with details of 'U_PTA_S03'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_PTA_S03' project
And waited while transcoding is finished in folder '/F1' on project 'P_PTA_S03' files page
And logged in with details of 'AgencyAdmin'
When I go to project 'P_PTA_S03' teams page
And click on user 'U_PTA_S03' in project 'P_PTA_S03' team activities
Then I 'should not' see user 'U_PTA_S03' is selected on project team page


Scenario: Check that clicking on username on Recent Activity section absent on project team should show warning message that user isn't available
Meta:@gdam
@projects
!-- NGN-1569
Given I created 'P_PTA_S04' project
And created '/F1' folder for project 'P_PTA_S04'
And created users with following fields:
| Email     | Role        | Access  |
| U_PTA_S04 | agency.user | folders |
And added users 'U_PTA_S04' to project 'P_PTA_S04' team folders '/F1' with role 'project.user' expired '12.12.2021'
And logged in with details of 'U_PTA_S04'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_PTA_S04' project
And waited while transcoding is finished in folder '/F1' on project 'P_PTA_S04' files page
And logged in with details of 'AgencyAdmin'
When I go to project 'P_PTA_S04' teams page
And remove user 'U_PTA_S04' from project 'P_PTA_S04' team page
And click on user 'U_PTA_S04' in project 'P_PTA_S04' team activities
Then I 'should not' see user 'U_PTA_S04' is selected on project team page


Scenario: Check that click on file on Recent Activity section should redirect to file details page
Meta:@gdam
@projects
Given I created 'P_PTA_S05' project
And created '/F1' folder for project 'P_PTA_S05'
And uploaded into project 'P_PTA_S05' following files:
| FileName         | Path |
| /images/logo.png | /F1  |
And waited while transcoding is finished in folder '/F1' on project 'P_PTA_S05' files page
When I go to project 'P_PTA_S05' teams page
And click on file 'logo.png' in project 'P_PTA_S05' team activities
Then I should see file 'logo.png' info page in project 'P_PTA_S05' folder '/F1'


Scenario: Check that 'create project' is displayed on Recent Activity in project team
Meta:@gdam
@projects
Given I created 'U_PTA_S07' User
And logged in with details of 'U_PTA_S07'
And created 'P_PTA_S07' project
And I logged in as 'AgencyAdmin'
When I go to project 'P_PTA_S07' teams page
Then I 'should' see activity for user 'U_PTA_S07' on project team page with message 'created project' and value 'P_PTA_S07'


Scenario: Check that 'updated project' is displayed on Recent Activity in project team
Meta:@gdam
@projects
Given I created 'U_PTA_S08' User
And logged in with details of 'U_PTA_S08'
And created 'P_PTA_S08' project
And I am on project 'P_PTA_S08' settings page
When I edit the following fields for 'P_PTA_S08' project:
| Name      | Media Type |
| P_PTA_S08 | Digital    |
And click on element 'SaveButton'
And I login as 'AgencyAdmin'
And go to project 'P_PTA_S08' teams page
Then I 'should' see activity for user 'U_PTA_S08' on project team page with message 'updated project' and value 'P_PTA_S08'


Scenario: Check that activity correct works in case to create project from template
Meta:@gdam
@projects
Given I created 'U_PTA_S14' User
And logged in with details of 'U_PTA_S14'
And created 'T_PTA_S14' template
And I am on Template list page
When I use 'T_PTA_S14' template
And fill the following fields for project from template:
| Name      | Start Date | End Date   |
| P_PTA_S14 | 12.12.2012 | 12.12.2021 |
And click on element 'SaveButton'
And wait for '5' seconds
And I go to project 'P_PTA_S14' teams page
And refresh the page
Then I 'should' see activity for user 'U_PTA_S14' on project team page with message 'created project' and value 'P_PTA_S14'