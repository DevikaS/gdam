!--NGN-278
Feature:          Project Share folder - Relations with Team page
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing folder


Scenario: user should dissapears from team page if last deleted from 'Users Already on this folder'
!--NGN-2149
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email    | Role       |
| UserFN    | UserLN   | PSFRTPU1 | guest.user |
And created 'PSFRTPR1' role in 'project' group for advertiser 'DefaultAgency'
And I created 'PSFRTPP1' project
And created '/PSFRTPF1' folder for project 'PSFRTPP1'
And fill Share popup by users 'PSFRTPU1' in project 'PSFRTPP1' folders '/PSFRTPF1' with role 'PSFRTPR1' expired '12.12.2022' and 'should' access to subfolders
When I open share popup in project 'PSFRTPP1' for folder '/PSFRTPF1' from root project
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
And I remove user 'PSFRTPU1' from users tab on Share window
And I click 'OK' on the alert
And go to project 'PSFRTPP1' teams page
Then I 'should not' see user 'PSFRTPU1' name in teams of project 'PSFRTPP1'


Scenario: user should dissapears from 'Users Already on this folder' page if last deleted from team page
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email    | Role       |
| UserFN    | UserLN   | PSFRTPU2 | guest.user |
And created 'PSFRTPR2' role in 'project' group for advertiser 'DefaultAgency'
And I created 'PSFRTPP2' project
And created '/PSFRTPF2' folder for project 'PSFRTPP2'
And added users 'PSFRTPU2' to project 'PSFRTPP2' team folders '/PSFRTPF2' with role 'PSFRTPR2' expired '12.12.2024'
And I am on project 'PSFRTPP2' teams page
When I select user 'PSFRTPU2' on project 'PSFRTPP2' team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
And open share popup in project 'PSFRTPP2' for folder '/PSFRTPF2' from root project
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
Then I 'should not' see user 'PSFRTPU2' with role 'PSFRTPR2' on Users already on this folder tab


Scenario: user should appears on 'Users Already on this folder' page if last added from team page
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email    | Role       |
| UserFN    | UserLN   | PSFRTPU3 | guest.user |
And created 'PSFRTPR3' role in 'project' group for advertiser 'DefaultAgency'
And I created 'PSFRTPP3' project
And created '/PSFRTPF3' folder for project 'PSFRTPP3'
And added users 'PSFRTPU3' to project 'PSFRTPP3' team folders '/PSFRTPF3' with role 'PSFRTPR3' expired '12.12.2024'
When I open share popup in project 'PSFRTPP3' for folder '/PSFRTPF3' from root project
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
Then I 'should' see user 'PSFRTPU3' with role 'PSFRTPR3' on Users already on this folder tab


Scenario: user should appears in team page if last added from Files page
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email    | Role       |
| UserFN    | UserLN   | PSFRTPU4 | guest.user |
And created 'PSFRTPR4' role in 'project' group for advertiser 'DefaultAgency'
And I created 'PSFRTPP4' project
And created '/PSFRTPF4' folder for project 'PSFRTPP4'
And fill Share popup by users 'PSFRTPU4' in project 'PSFRTPP4' folders '/PSFRTPF4' with role 'PSFRTPR4' expired '12.12.2022' and 'should' access to subfolders
When I go to project 'PSFRTPP4' teams page
Then I 'should' see user 'PSFRTPU4' name in teams of project 'PSFRTPP4'


Scenario: user's permissions should appears in permission's popup on team page if last added from Files page
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email    | Role       |
| UserFN    | UserLN   | PSFRTPU5 | guest.user |
And created 'PSFRTPR5' role in 'project' group for advertiser 'DefaultAgency'
And I created 'PSFRTPP5' project
And created '/PSFRTPF5' folder for project 'PSFRTPP5'
And fill Share popup by users 'PSFRTPU5' in project 'PSFRTPP5' folders '/PSFRTPF5' with role 'PSFRTPR5' expired '12.12.2022' and 'should not' access to subfolders
When I go to project 'PSFRTPP5' teams page
And open user 'PSFRTPU5' permissions on project 'PSFRTPP5' team page
Then I should see following role settings for folders in manage permissions popup of project 'PSFRTPP5' team for user 'PSFRTPU5':
| Folder    | Role     | Expiration |
| /PSFRTPF5 | PSFRTPR5 | 12.12.2022 |


Scenario: user team should appears in team page if last added from Files page
Meta:@gdam
@projects
Given I created users with following fields:
| Email      | Role       |
| PSFRTPU6_1 | guest.user |
| PSFRTPU6_2 | guest.user |
And created 'PSFRTPR6' role in 'project' group for advertiser 'DefaultAgency'
And I created 'PSFRTPP6' project
And created '/PSFRTPF6' folder for project 'PSFRTPP6'
And I added users to team template with the following fields:
| UserName   | TeamTemplate |
| PSFRTPU6_1 | PSFRTPTT1    |
| PSFRTPU6_2 | PSFRTPTT1    |
And fill Share popup by team template 'PSFRTPTT1' in project 'PSFRTPP6' folders '/PSFRTPF6' with role 'PSFRTPR6' expired '12.12.2022' and 'should not' access to subfolders
When I go to project 'PSFRTPP6' teams page
Then I 'should' see following users on project 'PSFRTPP6' team page:
| UserName   |
| PSFRTPU6_1 |
| PSFRTPU6_2 |


Scenario: user team should appears in shared page if last added from team page
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email      | Role       |
| first1    | last1    | PSFRTPU7_1 | guest.user |
| first2    | last2    | PSFRTPU7_2 | guest.user |
And created 'PSFRTPR7' role in 'project' group for advertiser 'DefaultAgency'
And created 'PSFRTPP7' project
And created '/PSFRTPF7' folder for project 'PSFRTPP7'
And I added users to team template with the following fields:
| UserName   | TeamTemplate |
| PSFRTPU7_1 | PSFRTPTT2    |
| PSFRTPU7_2 | PSFRTPTT2    |
And I added team template 'PSFRTPTT2' to project 'PSFRTPP7' team folders '/PSFRTPF7' with role 'PSFRTPR7' expired '12.12.2021'
When I open share popup in project 'PSFRTPP7' for folder '/PSFRTPF7' from root project
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role      | ExpiredDate | ShouldAccess |
| AgencyAdmin |           |             | should       |
| PSFRTPU7_1  | PSFRTPR7  | 12.12.2021  | should not   |
| PSFRTPU7_2  | PSFRTPR7  | 12.12.2021  | should not   |