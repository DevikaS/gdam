!--NGN-32 NGN-1343
Feature:          Templates Teams - Add Template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Templates:Team: Add Template


Scenario: Check that 'Add' button is active only after specifing all mandatory data
Meta:@gdam
@projects
Given I created 'TTATT1' template
And created '/TTATF1' folder for template 'TTATT1'
And created users with following fields:
| Email  | Role       |
| TTATU1 | guest.user |
And added user 'TTATU1' into address book
And created 'TTATR1' role in 'project' group for advertiser 'DefaultAgency'
And added user 'TTATU1' to team template 'TTATTT1'
And I am on template 'TTATT1' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberTeamTemplateItem' on page 'TeamsPage'
And fill add team template popup with team '<Team>' into template 'TTATT1' team expired '<Expired>' for folder '<Folder>' without Adding role
And click Add role button on permissions popup of template team tab
Then I '<Should>' see element 'DisabledAddButton' on page 'AddTeamUserPopUp'

Examples:
| Folder  | Team    | Expired    | Should     |
| /TTATF1 | TTATTT1 |            | should not |
| /TTATF1 |         | 12.12.2021 | should     |
| /TTATF1 | TTATTT1 | 05.05.1999 | should not |


Scenario: Check that users of Team Template are added in case to add Team Template
Meta:@gdam
@projects
Given I created 'TTATT2' template
And created '/TTATF2' folder for template 'TTATT2'
And created users with following fields:
| Email    | Role       |
| TTATU2_1 | guest.user |
| TTATU2_2 | guest.user |
| TTATU2_3 | guest.user |
And added following users to address book:
| UserName |
| TTATU2_1 |
| TTATU2_2 |
| TTATU2_3 |
And created 'TTATR2' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'TTATTT2':
| UserName |
| TTATU2_1 |
| TTATU2_2 |
| TTATU2_3 |
And I am on template 'TTATT2' teams page
When I add team template 'TTATTT2' into template 'TTATT2' team expired '12.12.2021' for folder '/TTATF2'
Then I 'should' see following users on template 'TTATT2' team page:
| UserName |
| TTATU2_1 |
| TTATU2_2 |
| TTATU2_3 |


Scenario: Check that one team template can be added once on Add Template pop-up
Meta:@gdam
@projects
Given I created 'TTATT3' template
And created '/TTATF3' folder for template 'TTATT3'
And created users with following fields:
| Email  | Role       |
| TTATU3 | guest.user |
And added user 'TTATU3' into address book
And created 'TTATR3' role in 'project' group for advertiser 'DefaultAgency'
And added user 'TTATU3' to team template 'TTATTT3'
And I am on template 'TTATT3' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberTeamTemplateItem' on page 'TeamsPage'
And fill add team template popup with team 'TTATTT3' into template 'TTATT3' team expired '12.12.2021' for folder '/TTATF3'
And add team template 'TTATTT3' into add team template to template 'TTATT3' team popup
Then I should see team templates count '1' in add template 'TTATT3' team user popup


Scenario: Check that team template is autocompleted on Add Template pop-up
Meta:@gdam
@projects
Given I created 'TTATT6' template
And created '/TTATF6' folder for template 'TTATT6'
And created users with following fields:
| Email  | Role       |
| TTATU6 | guest.user |
And added user 'TTATU6' into address book
And created 'TTATR6' role in 'project' group for advertiser 'DefaultAgency'
And added user 'TTATU6' to team template 'TTATTT6'
And I am on template 'TTATT6' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberTeamTemplateItem' on page 'TeamsPage'
And type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'TTATTT6'
Then I should see team template 'TTATTT6' is available for selecting in add team template to template 'TTATT6' team popup


Scenario: Check that easyshare user that was added to team template can be added
Meta:@gdam
@projects
Given I created 'TTATT7' template
And created '/TTATF7' folder for template 'TTATT7'
And created users with following fields:
| Email  | Role       |
| TTATU7 | guest.user |
And added user 'TTATU7' into address book
And created 'TTATR7' role in 'project' group for advertiser 'DefaultAgency'
And added user 'TTATU7' to team template 'TTATTT7'
And I am on template 'TTATT7' teams page
When I add user 'TTATU7' into template 'TTATT7' team with role 'TTATR7' expired '12.12.2021' for folder pop up '/TTATF7'
Then I 'should' see user 'TTATU7' name in teams of template 'TTATT7'


Scenario: Check that users of Team Template are added with several folders
Meta:@gdam
@projects
Given I created 'TTATT8' template
And created in 'TTATT8' template next folders:
| folder
| /TTATF8_1/TTATF8_2          |
| /TTATF8_1/TTATF8_3/TTATF8_4 |
| /TTATF8_5/TTATF8_6          |
And created users with following fields:
| Email    | Role       |
| TTATU8_1 | guest.user |
| TTATU8_2 | guest.user |
| TTATU8_3 | guest.user |
And added following users to address book:
| UserName |
| TTATU8_1 |
| TTATU8_2 |
| TTATU8_3 |
And created 'TTATR8' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'TTATTT8':
| UserName |
| TTATU8_1 |
| TTATU8_2 |
| TTATU8_3 |
And I added team template 'TTATTT8' to template 'TTATT8' team folders '/TTATF8_1,/TTATF8_1/TTATF8_3/TTATF8_4,/TTATF8_5/TTATF8_6' with role 'TTATR8' expired '12.12.2021'
And I am on template 'TTATT8' teams page
When I open user 'TTATU8_1' permissions on template 'TTATT8' team page
Then I should see following role(s) settings for folders in manage permissions popup of template 'TTATT8' team for user 'TTATU8_1':
| Folder                      | Role   | Expiration |
| /TTATF8_1                   | TTATR8 | 12.12.2021 |
| /TTATF8_1/TTATF8_3/TTATF8_4 | TTATR8 | 12.12.2021 |
| /TTATF8_5/TTATF8_6          | TTATR8 | 12.12.2021 |