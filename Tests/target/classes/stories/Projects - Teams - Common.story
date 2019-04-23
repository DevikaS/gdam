!--NGN-32
!--QA-548 [TD-133]
Feature:          Projects - Teams - Common
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Project Team

Scenario: Check that 'Users on this project' count is increased after adding new user
Meta:@gdam
@projects
Given I created 'PCP2' project
And created '/PCF2' folder for project 'PCP2'
And created users with following fields:
| Email   | Role       |
| PCU2_1  | guest.user |
And created 'PCR2' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PCP2' teams page
When I refresh the page
And I add user '<UserName>' into project 'PCP2' team with role 'PCR2' expired '12.12.2021' for folder on popup '/PCF2'
Then I should see users count '<Count>' on project 'PCP2' team

Examples:
| UserName | Count |
| PCU2_1   | 2     |



Scenario: Check that 'Users on this project' count is decreased after removing new user
Meta:@gdam
@projects
Given I created 'PCP3' project
And created '/PCF3' folder for project 'PCP3'
And created users with following fields:
| Email  | Role       |
| PCU3_1 | guest.user |
| PCU3_2 | guest.user |
| PCU3_3 | guest.user |
And created 'PCR3' role in 'project' group for advertiser 'DefaultAgency'
And added users '<Users>' to project 'PCP3' team folders '/PCF3' with role 'PCR3' expired '12.12.2021'
And I am on project 'PCP3' teams page
When I select user '<UserName>' on project 'PCP3' team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
Then I should see users count '<Count>' on project 'PCP3' team

Examples:
| Users                | UserName | Count |
| PCU3_1,PCU3_2,PCU3_3 | PCU3_1   | 3     |
| PCU3_2,PCU3_3        | PCU3_2   | 2     |
| PCU3_3               | PCU3_3   | 1     |


Scenario: Logo of user should be displayed on Team page
Meta:@gdam
@projects
Given I created 'PCP4' project
And created '/PCF4' folder for project 'PCP4'
And created users with following fields:
| Email | Role       | Logo |
| PCU4  | guest.user | GIF  |
And created 'PCR4' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PCP4' teams page
When I add user 'PCU4' into project 'PCP4' team with role 'PCR4' expired '12.12.2021' for folder on popup '/PCF4'
Then I should see logo 'GIF' for user 'PCU4' on project 'PCP4' team page


Scenario: Check correct work of 'Select All' checkbox
Meta: @skip
      @gdam
Given I created 'PCP5' project
And created '/PCF5' folder for project 'PCP5'
And created users with following fields:
| Email  | Role       |
| PCU5_1 | guest.user |
| PCU5_2 | guest.user |
| PCU5_3 | guest.user |
And created 'PCR5' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PCU5_1,PCU5_2,PCU5_3' to project 'PCP5' team folders '/PCF5' with role 'PCR5' expired '12.12.2021'
And I am on project 'PCP5' teams page
When I click element 'SelectAllCheckBox' on page 'TeamsPage'
Then I should see users count '4' selected on project 'PCP5' team


Scenario: Search project team member in teams page
Meta:@gdam
@projects
!--QA-548
Given I created 'PTP_1' project
And created '/PTF_1' folder for project 'PTP_1'
And created users with following fields:
| FirstName | LastName  | Email  |  Role    |
| aaa       | aaaL         | UM1    |  guest.user |
| admor     | admorL       | UM2    | guest.user  |
| zzzz      | vvvv        | UM3    |  guest.user |
And created 'PTR_1' role in 'project' group for advertiser 'DefaultAgency'
And added users 'UM1,UM2,UM3' to project 'PTP_1' team folders '/PTF_1' with role 'PTR_1' expired '12.12.2021'
And I am on project 'PTP_1' teams page
When I type and hit enter in element 'UserSearchField' on page 'TeamsPage' with 'text' as 'aaa'
Then I should see the number of users display per page is '1'
And I should see element 'UserName' with text 'aaa aaaL' on page 'TeamsPage'
And I click element 'ClearButton' on page 'TeamsPage'
When I type and hit enter in element 'UserSearchField' on page 'TeamsPage' with 'text' as 'admorL'
Then I should see the number of users display per page is '1'
And I should see element 'UserName' with text 'admor admorL' on page 'TeamsPage'
And I click element 'ClearButton' on page 'TeamsPage'
When I type and hit enter in element 'UserSearchField' on page 'TeamsPage' with 'email' as 'UM3'
Then I should see the number of users display per page is '1'
And I should see element 'UserName' with text 'zzzz vvvv' on page 'TeamsPage'
And I click element 'ClearButton' on page 'TeamsPage'
When I type and hit enter in element 'UserSearchField' on page 'TeamsPage' with 'text' as 'aaa aaaL'
Then I should see the number of users display per page is '1'
And I should see element 'UserName' with text 'aaa aaaL' on page 'TeamsPage'
And I click element 'ClearButton' on page 'TeamsPage'
When I type and hit enter in element 'UserSearchField' on page 'TeamsPage' with 'text' as 'First'
Then I should see the number of users display per page is '0'


Scenario:Check the number of users to display per page and pagination
Meta:@gdam
@projects
!--QA-548
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name            | A4User        |
|  BU_For105Users_|DefaultA4User |
And created users with following fields:
| Email         | Role         | AgencyUnique    |
|	BUAdmin  	| agency.admin | BU_For105Users_ |
And I login as 'BUAdmin' of Agency 'BU_For105Users_'
And I created 'PTP_105' project
And created '/PTF_105' folder for project 'PTP_105'
And created '103' users with role 'guest.user'
And created users with following fields:
| FirstName | LastName  | Email  |  Role     |
| zzzzz   | zyzyz     |  UM104  |guest.user |
And created 'PTR_105' role in 'project' group for advertiser 'BU_For105Users_'
And added users 'UM1,UM2,UM3,UM4,UM5,UM6,UM7,UM8,UM9,UM10,UM11,UM12,UM13,UM14,UM15,UM16,UM17,UM18,UM19,UM20,UM21,UM22,UM23,UM24,UM25,UM26,UM27,UM28,UM29,UM30,UM31,UM32,UM33,UM34,UM35,UM36,UM37,UM38,UM39,UM40,UM41,UM42,UM43,UM44,UM45,UM46,UM47,UM48,UM49,UM50' to project 'PTP_105' team folders '/PTF_105' with role 'PTR_105' expired '12.12.2021'
And added users 'UM51,UM52,UM53,UM54,UM55,UM56,UM57,UM58,UM59,UM60,UM61,UM62,UM63,UM64,UM65,UM66,UM67,UM68,UM69,UM70,UM71,UM72,UM73,UM74,UM75,UM76,UM77,UM78,UM79,UM80,UM81,UM82,UM83,UM84,UM85,UM86,UM87,UM88,UM89,UM90,UM91,UM92,UM93,UM94,UM95,UM96,UM97,UM98,UM99,UM100,UM101,UM102,UM103,UM104,yashwiyoyo' to project 'PTP_105' team folders '/PTF_105' with role 'PTR_105' expired '12.12.2021'
When go to project 'PTP_105' teams page
Then I should see element 'PagingButton' with text '100' on page 'TeamsPage'
And I should see the number of users display per page is '100'
When I click element 'PagingButton' on page 'TeamsPage'
Then I should see following pagination sizes in the dropdown:
|PaginationSize|
|20|
|50|
|250
When I click element 'NextPagingButton' on page 'TeamsPage'
Then I should see the number of users display per page is '6'
And I should see user 'zzzzz zyzyz' is displayed on 'PTP_105' team page
When I select '20' from the pagination size dropdown
Then I should see the number of users display per page is '20'
When I select '50' from the pagination size dropdown
Then I should see the number of users display per page is '50'
When I type and hit enter in element 'UserSearchField' on page 'TeamsPage' with 'email' as 'UM104'
Then I should see element 'UserName' with text 'zzzzz zyzyz' on page 'TeamsPage'

Scenario: Delete of several users from Project Teams page
Meta:@gdam
@projects
!--QA-548
Given I created 'PTPR' project
And created '/PTFR' folder for project 'PTPR'
And created users with following fields:
| FirstName | LastName  | Email  |  Role       |
| FirstName1| L1        | UM1    |  guest.user |
| FirstName1| L2        | UM2    |  guest.user |
| FirstName1| L3        | UM3    |  guest.user |
| FirstName1| L4        | UM4    |  guest.user |
| FirstName1| L5        | UM5    |  guest.user |
| FirstName6| L6        | UM6    |  guest.user |
| FirstName7| L7        | UM7    |  guest.user |
| FirstName8| L8        | UM8    |  guest.user |
And created 'PTRR_1' role in 'project' group for advertiser 'DefaultAgency'
And added users 'UM1,UM2,UM3,UM4,UM5,UM6,UM7,UM8' to project 'PTPR' team folders '/PTFR' with role 'PTRR_1' expired '12.12.2021'
And I am on project 'PTPR' teams page
Then I should see users count '9' on project 'PTPR' team
When I type and hit enter in element 'UserSearchField' on page 'TeamsPage' with 'text' as 'FirstName1'
And wait for '2' seconds
When I select users on project 'PTPR' team page:
| UserName   |
| UM1        |
| UM2        |
| UM3        |
| UM4        |
| UM5        |
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
When I type and hit enter in element 'UserSearchField' on page 'TeamsPage' with 'text' as 'FirstName1'
Then I should see the number of users display per page is '0'