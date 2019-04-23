!--NGN-32
Feature:          Project Teams - Permissions changes
Narrative:
In order to
As a              AgencyAdmin
I want to         Check permissins changes

Scenario: Check that folder hierarchy is updated in Add member User pop-up
Meta:@gdam
@projects
Given I created 'PTCP1' project
And created '/F1_1' folder for project 'PTCP1'
And I am on project 'PTCP1' teams page
And waited for '2' seconds
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And go to project 'PTCP1' files page
And refresh the page
And create '/F1_1/F1_2' folder in 'PTCP1' project
And create '/F1_3' folder in 'PTCP1' project
And go to project 'PTCP1' teams page
And click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
Then I should see following folders in add user to project 'PTCP1' team popup:
| folder     |
| /F1_1/F1_2 |
| /F1_3      |



Scenario: Check that user is removed from Teams when Expiration date is passed
!--FAB-473
Meta:@gdam
     @bug
     @projects
Given I created 'PTCP2' project
And created '/F1' folder for project 'PTCP2'
And created users with following fields:
| Email | Role       |
| PTCU2 | guest.user |
And created 'PTCR2' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTCU2' to project 'PTCP2' team folders '/F1' with role 'PTCR2' expired '11.11.2011'
When I wait for '60' seconds
And go to project 'PTCP2' teams page
Then I 'should not' see user 'PTCU2' name in teams of project 'PTCP2'


Scenario: Check that team template users are removed from Teams when 'Expiration Date' date is passed
Meta:@bug
     @gdam
     @projects
!--FAB-473
Given I created 'PTCP3' project
And created '/F3' folder for project 'PTCP3'
And created users with following fields:
| Email   | Role       |
| PTCU3_1 | guest.user |
| PTCU3_2 | guest.user |
| PTCU3_3 | guest.user |
And added following users to address book:
| UserName |
| PTCU3_1  |
| PTCU3_2  |
| PTCU3_3  |
And created 'PTCR3' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'PTCT3':
| UserName |
| PTCU3_1  |
| PTCU3_2  |
| PTCU3_3  |
And I added team template 'PTCT3' to project 'PTCP3' team folders '/F3' with role 'PTCR3' expired '11.11.2011'
When I wait for '60' seconds
And go to project 'PTCP3' teams page
Then I 'should not' see following users on project 'PTCP3' team page:
| UserName |
| PTCU3_1  |
| PTCU3_2  |
| PTCU3_3  |


Scenario: Check if access is removed from all folders, user should not be displayed on Team page anymore
Meta:@gdam
@projects
Given I created 'PTCP4' project
And created '/F4' folder for project 'PTCP4'
And created users with following fields:
| Email  | Role       |
| PTCU4  | guest.user |
And created 'PTCR4' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTCU4' to project 'PTCP4' team folders '/F4' with role 'PTCR4' expired '12.12.2021'
And I am on project 'PTCP4' teams page
When I open user 'PTCU4' permissions on project 'PTCP4' team page
And toggle folder '/F4' in manage permissions popup of project 'PTCP4' team for user 'PTCU4'
And remove 'PTCR4' role on manage permissions popup of project team tab
And click element 'SaveButton' on page 'AddTeamUserPopUp'
Then I 'should not' see user 'PTCU4' name in teams of project 'PTCP4'


Scenario: Check if access is removed from all folders, users from team template should not be displayed on Team page anymore
Meta:@gdam
@projects
Given I created 'PTCP5' project
And created in 'PTCP5' project next folders:
| folder |
| /F5_1  |
| /F5_2  |
And created users with following fields:
| Email   | Role       |
| PTCU5_1 | guest.user |
| PTCU5_2 | guest.user |
And added following users to address book:
| UserName |
| PTCU5_1  |
| PTCU5_2  |
And created 'PTCR5' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'PTCT5':
| UserName |
| PTCU5_1  |
| PTCU5_2  |
And I added team template 'PTCT5' to project 'PTCP5' team folders '/F5_1,/F5_2' with role 'PTCR5' expired '12.12.2021'
And I am on project 'PTCP5' teams page
When I open user 'PTCU5_1' permissions on project 'PTCP5' team page
And toggle folder '/F5_1' in manage permissions popup of project 'PTCP5' team for user 'PTCU5_1'
And remove 'PTCR5' role on manage permissions popup of project team tab
And toggle folder '/F5_2' in manage permissions popup of project 'PTCP5' team for user 'PTCU5_1'
And remove 'PTCR5' role on manage permissions popup of project team tab
And click Save button on permissions popup of project team tab
And open user 'PTCU5_2' permissions on project 'PTCP5' team page
And toggle folder '/F5_1' in manage permissions popup of project 'PTCP5' team for user 'PTCU5_2'
And remove 'PTCR5' role on manage permissions popup of project team tab
And toggle folder '/F5_2' in manage permissions popup of project 'PTCP5' team for user 'PTCU5_2'
And remove 'PTCR5' role on manage permissions popup of project team tab
And click Save button on permissions popup of project team tab
Then I 'should not' see following users on project 'PTCP5' team page:
| UserName |
| PTCU5_1  |
| PTCU5_2  |


Scenario: Check re-add user to several folders with another
Meta:@gdam
@projects
Given I created 'PTCP6' project
And created in 'PTCP6' project next folders:
| folder     |
| /F6_1/F6_2 |
| /F6_3      |
And created users with following fields:
| Email | Role       |
| PTCU6 | guest.user |
And created following roles:
| RoleName | Group   |
| PCTR61   | project |
| PCTR62   | project |
| PCTR63   | project |
And added users 'PTCU6' to project 'PTCP6' team folders '/F6_1' with role 'PCTR61' expired '12.12.2021'
And added users 'PTCU6' to project 'PTCP6' team folders '/F6_1/F6_2' with role 'PCTR62' expired '12.12.2021'
And added users 'PTCU6' to project 'PTCP6' team folders '/F6_1/F6_2' with role 'PCTR63' expired '12.12.2021'
When I go to project 'PTCP6' teams page
Then I should see user 'PTCU6' has role 'PCTR61,PCTR62,PCTR63' on project 'PTCP6' team page


Scenario: Check add user to folders with same permission (same role should be displayed once)
Meta:@gdam
@projects
Given I created 'PTCP7' project
And created in 'PTCP7' project next folders:
| folder |
| /F7_1  |
| /F7_2  |
And created users with following fields:
| Email | Role       |
| PTCU7 | guest.user |
And created 'PTCR7' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTCU7' to project 'PTCP7' team folders '/F7_1,/F7_2' with role 'PTCR7' expired '12.12.2021'
When I select user 'PTCU7' on project 'PTCP7' team page
Then I should see role 'PTCR7' displayed once for user 'PTCU7' details on project 'PTCP7' team page


Scenario: Check that the same role for several folders is displayed once (change role)
Meta:@gdam
@projects
!--NGN-4501
Given I created 'PTCP8' project
And created in 'PTCP8' project next folders:
| folder |
| /F8_1  |
| /F8_2  |
And created users with following fields:
| Email | Role       |
| PTCU8 | guest.user |
And created 'PTCR8' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTCU8' to project 'PTCP8' team folders '/F8_1' with role 'PTCR8' expired '12.12.2021'
And added users 'PTCU8' to project 'PTCP8' team folders '/F8_2' with role 'Project User' expired '12.12.2021'
Then I should see user 'PTCU8' has role 'PTCR8,Project User' on project 'PTCP8' team page
When I assign role 'PTCR8' in user 'PTCU8' permissions popup for folder '/F8_2' on project 'PTCP8' team
Then I should see role 'PTCR8' displayed once for user 'PTCU8' details on project 'PTCP8' team page
And 'should not' see role 'Project User' for user 'PTCU8' details on project 'PTCP8' team page



Scenario: Check re-add team template to folders with same permission
Meta:@gdam
@projects
Given I created 'PTCP9' project
And created in 'PTCP9' project next folders:
| folder |
| /F9_1  |
| /F9_2  |
And created users with following fields:
| Email   | Role       |
| PTCU9_1 | guest.user |
| PTCU9_2 | guest.user |
And added following users to address book:
| UserName |
| PTCU9_1  |
| PTCU9_2  |
And created 'PTCR9' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'PTCT9':
| UserName |
| PTCU9_1  |
| PTCU9_2  |
And I added team template 'PTCT9' to project 'PTCP9' team folders '/F9_1,/F9_2' with role 'PTCR9' expired '12.12.2021'
And I am on project 'PTCP9' teams page
When I add team template 'PTCT9' into project 'PTCP9' team expired '12.12.2021' for following folders:
| Folder | Role |
| /F9_1  | PTCR9 |
| /F9_2  | PTCR9 |
Then I should see user 'PTCU9_1' has role 'PTCR9' on project 'PTCP9' team page
Then I should see user 'PTCU9_2' has role 'PTCR9' on project 'PTCP9' team page


Scenario: Check re-add user to several folders with another Expiration date date
Meta:@gdam
@projects
Given I created 'PTCP10' project
And created in 'PTCP10' project next folders:
| folder |
| /F10_1 |
| /F10_2 |
And created users with following fields:
| Email  | Role       |
| PTCU10 | guest.user |
And created 'PCTR10' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTCU10' to project 'PTCP10' team folders '/F10_1,/F10_2' with role 'PCTR10' expired '12.12.2022'
And I am on project 'PTCP10' teams page
When I add user 'PTCU10' into project 'PTCP10' team with role 'PCTR10' expired '12.12.2022' for following folders on popup:
| Folder  |
| /F10_1  |
| /F10_2  |
And open user 'PTCU10' permissions on project 'PTCP10' team page
Then I should see following role settings for folders in manage permissions popup of project 'PTCP10' team for user 'PTCU10':
| Folder | Role   | Expiration |
| /F10_1 | PCTR10 | 12.12.2022 |
| /F10_2 | PCTR10 | 12.12.2022 |



Scenario: Check add user to folders on one root with different permission
Meta:@gdam
@projects
Given I created 'PTCP12' project
And created in 'PTCP12' project next folders:
| folder       |
| /F12_1/F12_2 |
| /F12_3       |
And created users with following fields:
| Email  | Role       |
| PTCU12 | guest.user |
And created following roles:
| RoleName  | Group   |
| PCTR12_1  | project |
| PCTR12_2  | project |
| PCTR12_3  | project |
And added users 'PTCU12' to project 'PTCP12' team folders '/F12_1' with role 'PCTR12_1' expired '12.12.2021'
And added users 'PTCU12' to project 'PTCP12' team folders '/F12_1/F12_2' with role 'PCTR12_2' expired '12.12.2021'
And added users 'PTCU12' to project 'PTCP12' team folders '/F12_3' with role 'PCTR12_3' expired '12.12.2021'
And I am on project 'PTCP12' teams page
When I open user 'PTCU12' permissions on project 'PTCP12' team page
Then I should see following role settings for folders in manage permissions popup of project 'PTCP12' team for user 'PTCU12':
| Folder       | Role     | Expiration |
| /F12_1       | PCTR12_1 | 12.12.2021 |
| /F12_1/F12_2 | PCTR12_2 | 12.12.2021 |
| /F12_3       | PCTR12_3 | 12.12.2021 |


Scenario: After delete shared folder, share user should dissapears from list
Meta:@gdam
@projects
Given I created 'PTCP13' project
And created '/F13' folder for project 'PTCP13'
And created users with following fields:
| Email   | Role       |
| PTCU13  | guest.user |
And created 'PTCR13' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTCU13' to project 'PTCP13' team folders '/F13' with role 'PTCR13' expired '12.12.2021'
And I am on project 'PTCP13' files page
When I delete folder '/F13' in project 'PTCP13'
And go to project 'PTCP13' teams page
Then I 'should not' see user 'PTCU13' name in teams of project 'PTCP13'


Scenario: After delete shared folder, share user from template should dissapears from list
Meta:@gdam
@projects
Given I created 'PTCP14' project
And created '/F14' folder for project 'PTCP14'
And created users with following fields:
| Email    | Role       |
| PTCU14_1 | guest.user |
| PTCU14_2 | guest.user |
And created 'PTCR14' role in 'project' group for advertiser 'DefaultAgency'
And added following users to address book:
| UserName |
| PTCU14_1 |
| PTCU14_2 |
And added following users to team template 'PTCT14':
| UserName |
| PTCU14_1 |
| PTCU14_2 |
And I added team template 'PTCT14' to project 'PTCP14' team folders '/F14' with role 'PTCR14' expired '12.12.2021'
And I am on project 'PTCP14' files page
When I delete folder '/F14' in project 'PTCP14'
And go to project 'PTCP14' teams page
Then I 'should not' see following users on project 'PTCP14' team page:
| UserName |
| PTCU14_1 |
| PTCU14_2 |


Scenario: After rename shared folder, share user should stay in list
Meta:@gdam
@projects
Given I created 'PTCP15' project
And created '/F15' folder for project 'PTCP15'
And created users with following fields:
| Email   | Role       |
| PTCU15  | guest.user |
And created 'PTCR15' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTCU15' to project 'PTCP15' team folders '/F15' with role 'PTCR15' expired '12.12.2021'
And I am on project 'PTCP15' files page
When I rename folder '/F15' to 'F15_new' in 'PTCP15' project
And go to project 'PTCP15' teams page
Then I 'should' see user 'PTCU15' name in teams of project 'PTCP15'


Scenario: After rename shared folder, share users from teamplate should stay in list
Meta:@gdam
@projects
Given I created 'PTCP16' project
And created '/F16' folder for project 'PTCP16'
And created users with following fields:
| Email    | Role       |
| PTCU16_1 | guest.user |
| PTCU16_2 | guest.user |
And created 'PTCR16' role in 'project' group for advertiser 'DefaultAgency'
And added following users to address book:
| UserName |
| PTCU16_1 |
| PTCU16_2 |
And added following users to team template 'PTCT16':
| UserName |
| PTCU16_1 |
| PTCU16_2 |
And I added team template 'PTCT16' to project 'PTCP16' team folders '/F16' with role 'PTCR16' expired '12.12.2021'
And I am on project 'PTCP16' files page
When I rename folder '/F16' to 'F16_new' in 'PTCP16' project
And wait for '5' seconds
And go to project 'PTCP16' teams page
Then I 'should' see following users on project 'PTCP16' team page:
| UserName |
| PTCU16_1 |
| PTCU16_2 |