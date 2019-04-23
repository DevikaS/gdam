!--NGN-32
Feature:          Project - Teams - Add user
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Project - Team - Add user

Meta:
@component project

Scenario: Check that 'Add' button is active only after specifing all mandatory data
Meta:@gdam
@projects
Given I created '<Project>' project
And created '<Folder>' folder for project '<Project>'
And created users with following fields:
| Email | Role       |
| PTU1  | guest.user |
And created 'PTR1' role in 'project' group for advertiser 'DefaultAgency'
And I am on project '<Project>' teams page
When I refresh the page
And I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And fill add user popup on teams page with user '<User>' into project '<Project>' team with role '<Role>' expired '<Expired>' for folder '<Folder>'
Then I '<Should>' see element 'DisabledAddButton' on page 'AddTeamUserPopUp'

Examples:
| Project | Folder | User | Role | Expired    | Should     |
| PTP1    | /PTF1  | PTU1 | PTR1 |            | should not |
| PTP1    | /PTF1  | PTU1 |      | 12.12.2021 | should     |
| PTP1    | /PTF1  |      | PTR1 | 12.12.2021 | should     |
| PTP1    | /PTF1  | PTU1 | PTR1 | 05.05.1999 | should     |


Scenario: Check that one user can be added once on 'Add member > User' page
!--NGN-1069
Meta: @skip
      @gdam
!--NGN-17941 --Marias comment --if it doesnt create duplicate user records--drop this test
Given I created 'PTP2' project
And created '/PTF2' folder for project 'PTP2'
And created users with following fields:
| Email | Role       |
| PTU2  | guest.user |
And created 'PTR2' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PTP2' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And fill add user popup with user 'PTU2' into project 'PTP2' team with role 'PTR2' expired '12.12.2021' for folder on popup '/PTF2'
And add user 'PTU2' into add user to project 'PTP2' team popup
Then I should see users count '1' in add project 'PTP2' team user popup


Scenario: Check that one user can be added once on 'Add member > User' page #2
Meta:@gdam
@projects
Given I created 'PTP3' project
And created '/PTF3' folder for project 'PTP3'
And created users with following fields:
| Email | Role       |
| PTU3  | guest.user |
And created 'PTR3' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PTP3' teams page
When I add user 'PTU3' into project 'PTP3' team with role 'PTR3' expired '12.12.2021' for folder on popup '/PTF3'
And add user 'PTU3' into project 'PTP3' team with role 'PTR3' expired '12.12.2021' for folder on popup '/PTF3'
Then I 'should' see user 'PTU3' name in teams of project 'PTP3'


Scenario: Check that user can be added using first name on Add User pop-up
Meta:@gdam
@projects
!--NGN-1239 NGN-1306
Given I created 'PTP4' project
And created '/PTF4' folder for project 'PTP4'
And created users with following fields:
| FirstName | Email | Logo | Role       |
| PTFN      | PTU4  | JPEG | guest.user |
And created 'PTR4' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PTP4' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And I type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'PTFN'
Then I should see user by first name 'PTFN' is available for selecting in add user to project 'PTP4' team popup
And logo is visible for user by first name 'PTFN' in add user to project 'PTP4' team popup


Scenario: Check that easyshare user can be added
Meta:@gdam
@projects
Given I created 'PTP5' project
And created '/PTF5' folder for project 'PTP5'
And created 'PTU5' User
And created 'PTR5' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PTP5' teams page
When I add user 'PTU5' into project 'PTP5' team with role 'PTR5' expired '12.12.2021' for folder on popup '/PTF5'
Then I 'should' see user 'PTU5' name in teams of project 'PTP5'


Scenario: Check that only project roles  (w/o project.owner too) are available on Add User pop-up
Meta:@gdam
@projects
Given I created 'PTP8' project
And created '/PTF8' folder for project 'PTP8'
And created users with following fields:
| Email | Role       |
| PTU8  | guest.user |
And created following roles:
| RoleName | Group   |
| PTR8_1   | global  |
| PTR8_2   | project |
| PTR8_3   | library |
And I am on project 'PTP8' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
Then I 'should not' see role 'PTR8_1' in roles list of add user to project 'PTP8' team popup
And 'should' see role 'PTR8_2' in roles list of add user to project 'PTP8' team popup
And 'should not' see role 'PTR8_3' in roles list of add user to project 'PTP8' team popup


Scenario: Check that several users can be added
Meta:@gdam
@projects
Given I created 'PTP9' project
And created '/PTF9' folder for project 'PTP9'
And created users with following fields:
| Email  | Role       |
| PTU9_1 | guest.user |
| PTU9_2 | guest.user |
| PTU9_3 | guest.user |
And created 'PTR9' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PTP9' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And fill add user popup with user 'PTU9_1' into project 'PTP9' team with role 'PTR9' expired '12.12.2021' for folder on popup '/PTF9'
And I add following users into add user to project 'PTP9' team popup:
| UserName |
| PTU9_2   |
| PTU9_3   |
And click element 'AddButton' on page 'AddTeamUserPopUp'
Then I 'should' see following users on project 'PTP9' team page:
| UserName |
| PTU9_1   |
| PTU9_2   |
| PTU9_3   |


Scenario: Check proper displaying project name
Meta:@gdam
@projects
Given I created 'PTP10' project
And I am on project 'PTP10' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
Then I should see project name 'PTP10' in add user to project team popup


Scenario: Check proper displaying folder hierarchy
Meta:@gdam
@projects
Given I created 'PTP11' project
And created in 'PTP11' project next folders:
| folder                   |
| /PTF11_1/PTF11_2         |
| /PTF11_1/PTF11_3/PTF11_4 |
| /PTF11_5/PTF11_6         |
And created users with following fields:
| Email | Role       |
| PTU11 | guest.user |
And created 'PTR11' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PTP11' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
Then I should see following folders in add user to project 'PTP11' team popup:
| folder                   |
| /PTF11_1/PTF11_2         |
| /PTF11_1/PTF11_3/PTF11_4 |
| /PTF11_5/PTF11_6         |


Scenario: Check add several user with several folders
Meta:@gdam
@projects
Given I created 'PTP12' project
And created in 'PTP12' project next folders:
| folder                   |
| /PTF12_1/PTF12_2/PTF12_3 |
| /PTF12_4                 |
And created following users:
| User Name |
| PTU12_1   |
| PTU12_2   |
| PTU12_3   |
And created 'PTR12' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTU12_1,PTU12_2,PTU12_3' to project 'PTP12' team folders '/PTF12_1,/PTF12_1/PTF12_2/PTF12_3,/PTF12_4' with role 'PTR12' expired '12.12.2021'
And I am on project 'PTP12' teams page
When I open user 'PTU12_1' permissions on project 'PTP12' team page
Then I should see following role settings for folders in manage permissions popup of project 'PTP12' team for user 'PTU12_1':
| Folder                   | Role  | Expiration |
| /PTF12_1                 | PTR12 | 12.12.2021 |
| /PTF12_1/PTF12_2/PTF12_3 | PTR12 | 12.12.2021 |
| /PTF12_4                 | PTR12 | 12.12.2021 |



Scenario: Search user in look-up (space cannot be used as separator)
Meta:@gdam
@projects
!--NGN-1249
Given I created 'PTP13' project
And created '/PTF13' folder for project 'PTP13'
And created users with following fields:
| FirstName | LastName | Email | Logo | Role       |
| PTFN      | PTLN     | PTU13 | JPEG | guest.user |
And created 'PTR13' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PTP13' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And I type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'PTFN PTLN'
Then I should see user by first name 'PTFN PTLN' is available for selecting in add user to project 'PTP13' team popup


Scenario: Check that passed date isn't accessible
Meta:@gdam
@projects
Given I created 'PCP1' project
And created '/PCF1' folder for project 'PCP1'
And created users with following fields:
| Email | Role       |
| PCU1  | guest.user |
And created 'PCR1' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PCP1' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And fill add user popup with user 'PCU1' into project 'PCP1' team with role 'PCR1' expired '12.12.2011' for folder on popup '/PCF1'
Then I 'should' see red inputs on page
