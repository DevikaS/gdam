!--NGN-1864 NGN-4084
Feature:          Share project structure
Narrative:
In order to
As a              AgencyAdmin
I want to         Check share project structure

Scenario: Check that 'Share' button is available for Project Root
Meta:@gdam
@projects
Given I created 'P_SPS_S01' project
And created in 'P_SPS_S01' project next folders:
| folder       |
| /F_SPS_S01_1 |
| /F_SPS_S01_2 |
When I go to project 'P_SPS_S01' files page
And click element 'ProjectRoot' on page 'FilesPage'
Then I 'should' see element 'Share' on page 'FilesPage'

Scenario: Check that project can be selected on Manage Permissions popup
Meta:@gdam
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S03_1 | agency.user |
| U_SPS_S03_2 | agency.user |
And logged in with details of 'U_SPS_S03_1'
And created 'P_SPS_S03' project
And created '/F_SPS_S03' folder for project 'P_SPS_S03'
And added users 'U_SPS_S03_2' to project 'P_SPS_S03' team folders '/F_SPS_S03' with role 'project.user' expired '12.02.2021'
When I open user 'U_SPS_S03_2' permissions on project 'P_SPS_S03' team page
And select root folder element in manage permissions popup of project 'P_SPS_S03' team for user 'U_SPS_S03_2'
Then I 'should' see selected root folder element in manage permissions popup of project 'P_SPS_S03' team for user 'U_SPS_S03_2'
And 'should' see following roles in roles list of manage permissions popup of project 'P_SPS_S03' team:
| Name                |
| Project User        |
| Project Observer    |
| Project Contributor |


Scenario: Check that user receives correct UI notification in case to share him project structure
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
!--NGN-3904
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S04_1 | agency.user |
| U_SPS_S04_2 | agency.user |
And logged in with details of 'U_SPS_S04_1'
And created 'P_SPS_S04' project
And created '/F_SPS_S04' folder for project 'P_SPS_S04'
And added users 'U_SPS_S04_2' to project 'P_SPS_S04' team with role 'project.user' expired '12.02.2021'
When I login with details of 'U_SPS_S04_2'
When I click on notifications menu in header on Project list page
Then I 'should' see that notifications dropdown contains info about sharing project 'P_SPS_S04'


Scenario: Check that all folders of project are available for user if project structure has been shared for him
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S06_1 | agency.user |
| U_SPS_S06_2 | agency.user |
And I am on user 'U_SPS_S06_2' Notifications Settings page
And set notification 'Project Team Added' into state 'on' for current user
And saved current user notifications setting
And logged in with details of 'U_SPS_S06_1'
And created 'P_SPS_S06' project
And created in 'P_SPS_S06' project next folders:
| folder                   |
| /F_SPS_S06_1             |
| /F_SPS_S06_2             |
| /F_SPS_S06_2/F_SPS_S06_3 |
And added users 'U_SPS_S06_2' to project 'P_SPS_S06' team with role 'project.user' expired '12.02.2021'
When I login with details of 'U_SPS_S06_2'
And open link from email with shared project 'P_SPS_S06' which user 'U_SPS_S06_2' received
Then I should see following folders in 'P_SPS_S06' project:
| folder                   |
| /F_SPS_S06_1             |
| /F_SPS_S06_2             |
| /F_SPS_S06_2/F_SPS_S06_3 |


Scenario: Check that all files in folders of project are available for user if project structure has been shared for him
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S07_1 | agency.user |
| U_SPS_S07_2 | agency.user |
And I am on user 'U_SPS_S07_2' Notifications Settings page
And set notification 'Project Team Added' into state 'on' for current user
And saved current user notifications setting
And logged in with details of 'U_SPS_S07_1'
And created 'P_SPS_S07' project
And created in 'P_SPS_S07' project next folders:
| folder                   |
| /F_SPS_S07_1             |
| /F_SPS_S07_2             |
| /F_SPS_S07_2/F_SPS_S07_3 |
And I uploaded into project 'P_SPS_S07' following files:
| FileName            | Path                     |
| /files/Fish Ad.mov  | /F_SPS_S07_1             |
| /files/Fish-Ad.mov  | /F_SPS_S07_2             |
| /files/Fish2-Ad.mov | /F_SPS_S07_2/F_SPS_S07_3 |
And added users 'U_SPS_S07_2' to project 'P_SPS_S07' team with role 'project.user' expired '12.02.2021'
When I login with details of 'U_SPS_S07_2'
And open link from email with shared project 'P_SPS_S07' which user 'U_SPS_S07_2' received
Then I should see following files inside folders for 'P_SPS_S07' project:
| Folder                   | FileName     |
| /F_SPS_S07_1             | Fish Ad.mov  |
| /F_SPS_S07_2             | Fish-Ad.mov  |
| /F_SPS_S07_2/F_SPS_S07_3 | Fish2-Ad.mov |


Scenario: Check that added folder into project after sharing project structure is available for user whom it has been shared
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S08_1 | agency.user |
| U_SPS_S08_2 | agency.user |
And I am on user 'U_SPS_S08_2' Notifications Settings page
And set notification 'Project Team Added' into state 'on' for current user
And saved current user notifications setting
And logged in with details of 'U_SPS_S08_1'
And created 'P_SPS_S08' project
And added users 'U_SPS_S08_2' to project 'P_SPS_S08' team with role 'project.user' expired '12.02.2021'
When I create '/F_SPS_S08' folder for project 'P_SPS_S08'
And login with details of 'U_SPS_S08_2'
And open link from email with shared project 'P_SPS_S08' which user 'U_SPS_S08_2' received
Then I 'should' see '/F_SPS_S08' folder in 'P_SPS_S08' project


Scenario: Check that expiration of shared project structure is working
Meta:@bug
     @gdam
     @projects
!--FAB-473
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S09_1 | agency.user |
| U_SPS_S09_2 | agency.user |
And logged in with details of 'U_SPS_S09_1'
And created 'P_SPS_S09' project
And created '/F_SPS_S09' folder for project 'P_SPS_S09'
And added users 'U_SPS_S09_2' to project 'P_SPS_S09' team with role 'project.user' expired '11.11.2011'
And waited for '60' seconds
When I login with details of 'U_SPS_S09_2'
Then I 'should not' see project 'P_SPS_S09' on project list page


Scenario: Check that user doesn't get email notification about unsharing project structure for him
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S10_1 | agency.user |
| U_SPS_S10_2 | agency.user |
And logged in with details of 'U_SPS_S10_1'
And created 'P_SPS_S10' project
And created '/F_SPS_S10' folder for project 'P_SPS_S10'
And added users 'U_SPS_S10_2' to project 'P_SPS_S10' team with role 'project.user' expired '12.02.2021'
When I remove user 'U_SPS_S10_2' from project 'P_SPS_S10' team page
And login with details of 'U_SPS_S10_2'
Then I 'should not' see project 'P_SPS_S10' on project list page


Scenario: Check that user cannot get shared project using direct URL if sharing for him has been removed
Meta:@gdam
@projects
!--NGN-4152
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S11_1 | agency.user |
| U_SPS_S11_2 | agency.user |
And I am on user 'U_SPS_S11_2' Notifications Settings page
And set notification 'Project Team Added' into state 'on' for current user
And saved current user notifications setting
And logged in with details of 'U_SPS_S11_1'
And created 'P_SPS_S11' project
And created '/F_SPS_S11' folder for project 'P_SPS_S11'
And added users 'U_SPS_S11_2' to project 'P_SPS_S11' team with role 'project.user' expired '12.02.2021'
When I remove user 'U_SPS_S11_2' from project 'P_SPS_S11' team page
And login with details of 'U_SPS_S11_2'
And open link from email with shared project 'P_SPS_S11' which user 'U_SPS_S11_2' received
Then I 'should not' see project overview page


Scenario: Check that user cannot get shared project using direct URL if sharing for him has been expired
Meta:@skip
     @gdam
!--NGN-4152 FAB-473
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S12_1 | agency.user |
| U_SPS_S12_2 | agency.user |
And I am on user 'U_SPS_S12_2' Notifications Settings page
And set notification 'Project Team Added' into state 'on' for current user
And saved current user notifications setting
And logged in with details of 'U_SPS_S12_1'
And created 'P_SPS_S12' project
And created '/F_SPS_S12' folder for project 'P_SPS_S12'
And added users 'U_SPS_S12_2' to project 'P_SPS_S12' team with role 'project.user' expired '11.11.2011'
And waited for '60' seconds
When I login with details of 'U_SPS_S12_2'
And open link from email with shared project 'P_SPS_S12' which user 'U_SPS_S12_2' received
Then I 'should not' see project overview page


Scenario: Check that project.admins are displayed on Users already on this folder tab on Share Project root
Meta: @skip
      @gdam
Given I created users with following fields:
| Email     | Role        |
| U_SPS_S15 | agency.user |
And logged in with details of 'U_SPS_S15'
And created 'P_SPS_S15' project
And created '/F_SPS_S15' folder for project 'P_SPS_S15'
When I go to project 'P_SPS_S15' files page
And click element 'ProjectRoot' on page 'FilesPage'
And click element 'Share' on page 'FilesPage'
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
Then I 'should' see user 'U_SPS_S15' with role 'project.admin' on Users already on this folder tab

Scenario: Check that user whom project root has been shared is displayed on Users already on this folder tab on Share any folder of current project
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Role        |
| U_SPS_S16_1 | agency.user |
| U_SPS_S16_2 | agency.user |
And logged in with details of 'U_SPS_S16_1'
And created 'P_SPS_S16' project
And created '/F_SPS_S16' folder for project 'P_SPS_S16'
And added users 'U_SPS_S16_2' to project 'P_SPS_S16' team with role 'project.user' expired '12.02.2021'
When I open Share window from popup menu for folder '/F_SPS_S16' on project 'P_SPS_S16'
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
Then I 'should' see user 'U_SPS_S16_2' with role 'Project User' on Users already on this folder tab