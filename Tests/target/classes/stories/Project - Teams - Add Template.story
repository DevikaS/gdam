!--NGN-32
Feature:          Project - Teams - Add Template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check  Project - Teams - Add Template

Meta:
@component project

Scenario: Check that 'Add' button is active only after specifing all mandatory data
Meta:@gdam
@projects
Given I created 'PTTP1' project
And created '/PTTF1' folder for project 'PTTP1'
And created users with following fields:
| Email | Role       |
| PTTU1 | guest.user |
And added user 'PTTU1' into address book
And created 'PTTR1' role in 'project' group for advertiser 'DefaultAgency'
And added user 'PTTU1' to team template 'PTTT1'
And I am on project 'PTTP1' teams page
When I refresh the page
And I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberTeamTemplateItem' on page 'TeamsPage'
And fill add team template popup with team '<Team>' into project 'PTTP1' team expired '<Expired>' for folder '<Folder>' without clicking add role
And click Add role button on permissions popup of project team tab
Then I '<Should>' see element 'DisabledAddButton' on page 'AddTeamUserPopUp'

Examples:
| Folder | Team  | Expired    | Should     |
| /PTTF1 | PTTT1 |            | should not |
| /PTTF1 |       | 12.12.2021 | should     |
| /PTTF1 | PTTT1 | 05.05.1999 | should not |

Scenario: Check that users of Team Template are added in case to add Team Project
Meta:@gdam
@projects
Given I created 'PTTP2' project
And created '/PTTF2' folder for project 'PTTP2'
And created users with following fields:
| Email   | Role       |
| PTTU2_1 | guest.user |
| PTTU2_2 | guest.user |
| PTTU2_3 | guest.user |
And added following users to address book:
| UserName |
| PTTU2_1  |
| PTTU2_2  |
| PTTU2_3  |
And created 'PTTR2' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'PTTT2':
| UserName |
| PTTU2_1  |
| PTTU2_2  |
| PTTU2_3  |
And I am on project 'PTTP2' teams page
When I add team template 'PTTT2' into project 'PTTP2' team for folders on popup:
| Folder  | Roles | Expire     |
| /PTTF2  | PTTR2 | 12.12.2021 |
Then I 'should' see following users on project 'PTTP2' team page:
| UserName |
| PTTU2_1  |
| PTTU2_2  |
| PTTU2_3  |


Scenario: Check that one team template can be added once on Add Template pop-up
Meta:@gdam
@projects
Given I created 'PTTP3' project
And created '/PTTF3' folder for project 'PTTP3'
And created users with following fields:
| Email | Role       |
| PTTU3 | guest.user |
And added user 'PTTU3' into address book
And created 'PTTR3' role in 'project' group for advertiser 'DefaultAgency'
And added user 'PTTU3' to team template 'PTTT3'
And I am on project 'PTTP3' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberTeamTemplateItem' on page 'TeamsPage'
And fill add team template popup with team 'PTTT3' into project 'PTTP3' team expired '12.12.2021' for folder '/PTTF3'
And add team template 'PTTT3' into add team template to project 'PTTP3' team popup
Then I should see team templates count '1' in add project 'PTTP3' team user popup


Scenario: Check that team template is autocompleted on Add Template pop-up
Meta:@gdam
@projects
Given I created 'PTTP6' project
And created '/PTTF6' folder for project 'PTTP6'
And created users with following fields:
| Email | Role       |
| PTTU6 | guest.user |
And added user 'PTTU6' into address book
And created 'PTTR6' role in 'project' group for advertiser 'DefaultAgency'
And added user 'PTTU6' to team template 'PTTT6'
And I am on project 'PTTP6' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberTeamTemplateItem' on page 'TeamsPage'
And type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'PTTT6'
Then I should see team template 'PTTT6' is available for selecting in add team template to project 'PTTP6' team popup


Scenario: Check that easyshare user that was added to team template can be added
Meta:@gdam
@projects
Given I created 'PTTP7' project
And created '/PTTF7' folder for project 'PTTP7'
And created users with following fields:
| Email | Role       |
| PTTU7 | guest.user |
And added user 'PTTU7' into address book
And created 'PTTR7' role in 'project' group for advertiser 'DefaultAgency'
And added user 'PTTU7' to team template 'PTTT7'
And I am on project 'PTTP7' teams page
When I add user 'PTTU7' into project 'PTTP7' team with role 'PTTR7' expired '12.12.2021' for folder on popup '/PTTF7'
Then I 'should' see user 'PTTU7' name in teams of project 'PTTP7'


Scenario: Check that users of Team Template are added with several folders
Meta:@gdam
@projects
Given I created 'PTTP8' project
And created in 'PTTP8' project next folders:
| folder
| /PTTF8_1/PTTF8_2         |
| /PTTF8_1/PTTF8_3/PTTF8_4 |
| /PTTF8_5/PTTF8_6         |
And created users with following fields:
| Email   | Role       |
| PTTU8_1 | guest.user |
| PTTU8_2 | guest.user |
| PTTU8_3 | guest.user |
And added following users to address book:
| UserName |
| PTTU8_1  |
| PTTU8_2  |
| PTTU8_3  |
And created 'PTTR8' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'PTTT8':
| UserName |
| PTTU8_1  |
| PTTU8_2  |
| PTTU8_3  |
And I added team template 'PTTT8' to project 'PTTP8' team folders '/PTTF8_1,/PTTF8_1/PTTF8_3/PTTF8_4,/PTTF8_5/PTTF8_6' with role 'PTTR8' expired '12.12.2021'
And I am on project 'PTTP8' teams page
When I open user 'PTTU8_1' permissions on project 'PTTP8' team page
Then I should see following role(s) settings for folders in manage permissions popup of project 'PTTP8' team for user 'PTTU8_1':
| Folder                   | Role  | Expiration |
| /PTTF8_1                 | PTTR8 | 12.12.2021 |
| /PTTF8_1/PTTF8_3/PTTF8_4 | PTTR8 | 12.12.2021 |
| /PTTF8_5/PTTF8_6         | PTTR8 | 12.12.2021 |