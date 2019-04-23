!--NGN-32 NGN-1343
Feature:          Templates Teams - Add User
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Templates:Team: Add User

Scenario: Check that 'Add' button is active only after specifing all mandatory data
Meta:@gdam
@projects
Given I created '<Template>' template
And created '<Folder>' folder for template '<Template>'
And created users with following fields:
| Email | Role       |
| TTAU1 | guest.user |
And created 'TTAUR1' role in 'project' group for advertiser 'DefaultAgency'
And I am on template '<Template>' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And fill add user popup with user '<User>' into template '<Template>' team with role '<Role>' expired '<Expired>' for folder pop up '<Folder>'
Then I '<Should>' see element 'DisabledAddButton' on page 'AddTeamUserPopUp'

Examples:
| Template | Folder  | User  | Role   | Expired    | Should     |
| TTAUT1   | /TTAUF1 | TTAU1 | TTAUR1 |            | should not |
| TTAUT1   | /TTAUF1 | TTAU1 |        | 12.12.2021 | should     |
| TTAUT1   | /TTAUF1 |       | TTAUR1 | 12.12.2021 | should     |
| TTAUT1   |         | TTAU1 | TTAUR1 | 12.12.2021 | should not |
| TTAUT1   | /TTAUF1 | TTAU1 | TTAUR1 | 05.05.1999 | should     |

Scenario: Check that user can be added using first name on Add User pop-up
Meta:@gdam
@projects
Given I created 'TTAUT4' template
And created '/TTAUF4' folder for template 'TTAUT4'
And created users with following fields:
| FirstName | Email | Logo | Role       |
| TTAUN     | TTAU4 | JPEG | guest.user |
And created 'TTAUR4' role in 'project' group for advertiser 'DefaultAgency'
And I am on template 'TTAUT4' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And I type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'TTAUN'
Then I should see user by first name 'TTAUN' is available for selecting in add user to template 'TTAUT4' team popup
And logo is visible for user by first name 'TTAUN' in add user to template 'TTAUT4' team popup



Scenario: Check that easyshare user can be added
Meta:@gdam
@projects
Given I created 'TTAUT5' template
And created '/TTAUF5' folder for template 'TTAUT5'
And created 'TTAU5' User
And created 'TTAUR5' role in 'project' group for advertiser 'DefaultAgency'
And I am on template 'TTAUT5' teams page
When I add user 'TTAU5' into template 'TTAUT5' team with role 'TTAUR5' expired '12.12.2021' for folder pop up '/TTAUF5'
Then I 'should' see user 'TTAU5' name in teams of template 'TTAUT5'


Scenario: Check that only project roles  (w/o project.owner too) are available on Add User pop-up
Meta:@gdam
@projects
Given I created 'TTAUT8' template
And created '/TTAUF8' folder for template 'TTAUT8'
And created users with following fields:
| Email | Role       |
| TTAU8 | guest.user |
And created following roles:
| RoleName | Group   |
| TTAUR8_1 | global  |
| TTAUR8_2 | project |
| TTAUR8_3 | library |
And I am on template 'TTAUT8' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
Then I 'should not' see role 'TTAUR8_1' in roles list of add user to template 'TTAUT8' team popup
And 'should' see role 'TTAUR8_2' in roles list of add user to template 'TTAUT8' team popup
And 'should not' see role 'TTAUR8_3' in roles list of add user to template 'TTAUT8' team popup


Scenario: Check proper displaying template name
Meta:@gdam
@projects
Given I created 'TTAUT10' template
And I am on template 'TTAUT10' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
Then I should see template name 'TTAUT10' in add user to template team popup


Scenario: Check proper displaying folder hierarchy
Meta:@gdam
@projects
Given I created 'TTAUT11' template
And created in 'TTAUT11' template next folders:
| folder                         |
| /TTAUF11_1/TTAUF11_2           |
| /TTAUF11_1/TTAUF11_3/TTAUF11_4 |
| /TTAUF11_5/TTAUF11_6           |
And created users with following fields:
| Email  | Role       |
| TTAU11 | guest.user |
And created 'TTAUR11' role in 'project' group for advertiser 'DefaultAgency'
And I am on template 'TTAUT11' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
Then I should see following folders in add user to template 'TTAUT11' team popup:
| folder                         |
| /TTAUF11_1/TTAUF11_2           |
| /TTAUF11_1/TTAUF11_3/TTAUF11_4 |
| /TTAUF11_5/TTAUF11_6           |


Scenario: Check add several user with several folders
Meta:@gdam
@projects
Given I created 'TTAUT12' template
And created in 'TTAUT12' template next folders:
| folder                         |
| /TTAUF12_1/TTAUF12_2/TTAUF12_3 |
| /TTAUF12_4                     |
And created following users:
| User Name |
| TTAU12_1  |
| TTAU12_2  |
| TTAU12_3  |
And created 'TTAUR12' role in 'project' group for advertiser 'DefaultAgency'
And added users 'TTAU12_1,TTAU12_2,TTAU12_3' to template 'TTAUT12' team folders '/TTAUF12_1,/TTAUF12_1/TTAUF12_2/TTAUF12_3,/TTAUF12_4' with role 'TTAUR12' expired '12.12.2021'
And I am on template 'TTAUT12' teams page
When I open user 'TTAU12_1' permissions on template 'TTAUT12' team page
Then I should see following role settings for folders in manage permissions popup of template 'TTAUT12' team for user 'TTAU12_1':
| Folder                         | Role    | Expiration |
| /TTAUF12_1                     | TTAUR12 | 12.12.2021 |
| /TTAUF12_1/TTAUF12_2/TTAUF12_3 | TTAUR12 | 12.12.2021 |
| /TTAUF12_4                     | TTAUR12 | 12.12.2021 |


Scenario: Search user in look-up (space cannot be used as separator)
Meta:@gdam
@projects
!-- NGN-1249
Given I created 'TTAUT13' template
And created '/TTAUF13' folder for template 'TTAUT13'
And created users with following fields:
| FirstName | LastName | Email  | Logo | Role       |
| TTAUFN1   | TTAULN1  | TTAU13 | JPEG | guest.user |
And created 'TTAUR13' role in 'project' group for advertiser 'DefaultAgency'
And I am on template 'TTAUT13' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And I type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'TTAUFN1 TTAULN1'
Then I should see user by first name 'TTAUFN1 TTAULN1' is available for selecting in add user to template 'TTAUT13' team popup


Scenario: Check that passed date isn't accessible
Meta:@gdam
@projects
Given I created 'TTAUT14' template
And created '/TTAUF14' folder for template 'TTAUT14'
And created users with following fields:
| Email  | Role       |
| TTAU14 | guest.user |
And created 'TTAUR14' role in 'project' group for advertiser 'DefaultAgency'
And I am on template 'TTAUT14' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And fill add user popup with user 'TTAU14' into template 'TTAUT14' team with role 'TTAUR14' expired '12.12.2011' for folder pop up '/TTAUF14'
Then I 'should' see red inputs on page