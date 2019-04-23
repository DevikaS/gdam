!--NGN-1704
Feature:          Agency Admin - People - User details
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Agency Admin - People - User details

Scenario: Check that after user's selection his data appears on Users list
Meta:@gdam
     @projects
Given I created users with following fields:
| FirstName     | LastName      | Agency        | Email       | Logo | Role         |
| UFN_AAPUD_S01 | ULN_AAPUD_S01 | DefaultAgency | U_AAPUD_S01 | GIF  | agency.admin |
When I go to User list page
And open 'U_AAPUD_S01' user menu
Then I 'should' see following data for selected user:
| Name                        | Agency        | Logo | Role         |
| UFN_AAPUD_S01 ULN_AAPUD_S01 | DefaultAgency | GIF  | agency.admin |


Scenario: Check that after clicking on user logo for selected user User Profile is opened with user details
Meta:@gdam
     @projects
Given I created users with following fields:
| Logo | FirstName     | LastName      | Agency        | Email       | Telephone  | MobileNumber | SkypeNumber   | GoogleTalkContact |
| GIF  | UFN_AAPUD_S02 | ULN_AAPUD_S02 | DefaultAgency | U_AAPUD_S02 | 0123456789 | 1234567890   | USC_AAPUD_S02 | UGC_AAPUD_S02     |
When I go to User list page
And open 'U_AAPUD_S02' user menu
And open user profile popup for selected user
Then I 'should' see following data on User Profile popup:
| Logo | Name                        | Agency        | Email       | Telephone  | MobileNumber | SkypeNumber   | GoogleTalkContact |
| GIF  | UFN_AAPUD_S02 ULN_AAPUD_S02 | DefaultAgency | U_AAPUD_S02 | 0123456789 | 1234567890   | USC_AAPUD_S02 | UGC_AAPUD_S02     |


Scenario: Check that after clicking on Edit Profile link user is redirected to User Settings
Meta:@gdam
     @projects
Given I created 'U_AAPUD_S05' User with 'AllFilledFields'
When I go to User list page
And open 'U_AAPUD_S05' user menu
And click element 'EditProfileLink' on page 'Users'
Then I 'should' see user 'U_AAPUD_S05' with filled 'AllFilledFields' on edit user page


Scenario: Check that 'Active User' button shows current status of user
Meta:@gdam
     @projects
Given I created 'U_AAPUD_S06' User
When I go to User list page
And open 'U_AAPUD_S06' user menu
Then I 'should' see element 'ActiveUserButton' on page 'Users'
When I go to user 'U_AAPUD_S06' details page
And click element 'DisableUserCheckBox' on page 'UserEdit'
And click save on users details page
And go to User list page
And open 'U_AAPUD_S06' user menu
Then I 'should' see element 'InactiveUserButton' on page 'Users'


Scenario: Check that correct data is showed on Project tab of User's details on Users list if project has been shared via project ownership
Meta:@gdam
     @projects
!--affected by NGN-6851
Given I created users with following fields:
| Email       | Agency        | Role       |
| <UserEmail> | DefaultAgency | <UserRole> |
And added user '<UserEmail>' into address book
And created following projects:
| Name          | Job Number     | Advertiser    |
| P_AAPUD_S09_1 | JN_AAPUD_S09_1 | AnotherAgency |
| P_AAPUD_S09_2 | JN_AAPUD_S09_2 | DefaultAgency |
| P_AAPUD_S09_3 | JN_AAPUD_S09_3 | DefaultAgency |
And I am on project 'P_AAPUD_S09_1' settings page
And edited the following fields for 'P_AAPUD_S09_1' project:
| Name          | Job Number     | Administrators |
| P_AAPUD_S09_1 | JN_AAPUD_S09_1 | <UserEmail>    |
And clicked on element 'SaveButton'
And I am on project 'P_AAPUD_S09_2' settings page
And edited the following fields for 'P_AAPUD_S09_2' project:
| Name          | Job Number     | Administrators |
| P_AAPUD_S09_2 | JN_AAPUD_S09_2 | <UserEmail>    |
And clicked on element 'SaveButton'
When I open '<UserEmail>' user menu
Then I should see the following projects on Projects tab for opened user details on Users list page:
| ProjectName   | JobNumber      | Condition  |
| P_AAPUD_S09_1 | JN_AAPUD_S09_1 | should     |
| P_AAPUD_S09_2 | JN_AAPUD_S09_2 | should     |
| P_AAPUD_S09_3 | JN_AAPUD_S09_3 | should not |

Examples:
| UserEmail     | UserRole     |
| U_AAPUD_S09_2 | guest.user   |
| U_AAPUD_S09_3 | agency.user  |


Scenario: Check that 'Next' button is active on Projects tab of Users details page if there are more than 6 projects for him
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And logged in with details of '<UserEmail>'
And created '<ProjectCount>' projects with name pattern '<ProjectNamePattern>'
And logged in with details of 'AgencyAdmin'
When I open '<UserEmail>' user menu
Then I '<Condition>' see active 'Next' button in user details block of users list page

Examples:
| UserEmail     | ProjectNamePattern | ProjectCount | Condition  |
| U_AAPUD_S11_1 | GP_AAPUD_S11_1     | 0            | should not |
| U_AAPUD_S11_2 | GP_AAPUD_S11_2     | 6            | should not |
| U_AAPUD_S11_3 | GP_AAPUD_S11_3     | 7            | should     |


Scenario: Check that 6 projects are displayed on Project tab of User's details page
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And logged in with details of '<UserEmail>'
And created '<ProjectCount>' projects with name pattern '<ProjectNamePattern>'
And logged in with details of 'AgencyAdmin'
When I open '<UserEmail>' user menu
Then I should see '<ProjectVisible>' projects for opened user details on users page

Examples:
| UserEmail     | ProjectNamePattern | ProjectCount | ProjectVisible |
| U_AAPUD_S12_1 | GP_AAPUD_S12_1     | 0            | 0              |
| U_AAPUD_S12_2 | GP_AAPUD_S12_2     | 6            | 6              |
| U_AAPUD_S12_3 | GP_AAPUD_S12_3     | 7            | 6              |


Scenario: Check that 'Next' link correctly works on Projects tab of User's details page
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And logged in with details of '<UserEmail>'
And created '<ProjectCount>' projects with name pattern '<ProjectNamePattern>'
And logged in with details of 'AgencyAdmin'
When I open '<UserEmail>' user menu
And click 'Next' button on projects tab for opened user details on users page
Then I 'should' see page '2' on projects tab for opened user details on users page
Then I '<Condition>' see active 'Next' button in user details block of users list page

Examples:
| UserEmail     | ProjectNamePattern | ProjectCount | Condition  |
| U_AAPUD_S13_1 | GP_AAPUD_S13_1     | 7            | should not |
| U_AAPUD_S13_2 | GP_AAPUD_S13_2     | 12           | should not |
| U_AAPUD_S13_3 | GP_AAPUD_S13_3     | 13           | should     |


Scenario: Check that 'Previous' link is active if user isn't on 'Page 1' page of Projects tab of User's details
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And logged in with details of '<UserEmail>'
And created '<ProjectCount>' projects with name pattern '<ProjectNamePattern>'
And logged in with details of 'AgencyAdmin'
When I open '<UserEmail>' user menu
And navigate to last page on projects tab for opened user details on users page
Then I '<Condition>' see active 'Previous' button in user details block of users list page

Examples:
| UserEmail     | ProjectNamePattern | ProjectCount | Condition  |
| U_AAPUD_S14_1 | GP_AAPUD_S14_1     | 0            | should not |
| U_AAPUD_S14_2 | GP_AAPUD_S14_2     | 6            | should not |
| U_AAPUD_S14_3 | GP_AAPUD_S14_3     | 7            | should     |


Scenario: Check that 'Previous' link correctly works on Projects tab of user's details page
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| U_AAPUD_S15 | agency.user |
And logged in with details of 'U_AAPUD_S15'
And created '7' projects with name pattern 'GP_AAPUD_S15'
And logged in with details of 'AgencyAdmin'
When I open 'U_AAPUD_S15' user menu
And navigate to last page on projects tab for opened user details on users page
Then I 'should' see page '2' on projects tab for opened user details on users page
And 'should' see active 'Previous' button in user details block of users list page
When I click 'Previous' button on projects tab for opened user details on users page
Then I 'should' see page '1' on projects tab for opened user details on users page
And 'should not' see active 'Previous' button in user details block of users list page


Scenario: Check that Categories are shown on Library tab of User's details on Users list
Meta:@gdam
     @library
Given I created following categories:
| Name          |
| C_AAPUD_S16_1 |
| C_AAPUD_S16_2 |
And created users with following fields:
| Email       | Role         |
| U_AAPUD_S16 | agency.admin |
And I am on administration area collections page
When I go to user 'U_AAPUD_S16' library page in administration area
Then I should see the following categories on category drop down on library tab for opened user details on users page:
| CategoryName  | Condition |
| C_AAPUD_S16_1 | should    |
| C_AAPUD_S16_2 | should    |
| Everything    | should    |



Scenario: Check that Library roles are shown on Library tab of User's details on Users list
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role         |
| U_AAPUD_S17 | agency.admin |
And created 'R_AAPUD_S17_1' role in 'library' group for advertiser 'DefaultAgency'
And created 'R_AAPUD_S17_2' role in 'library' group for advertiser 'DefaultAgency'
And I am on administration area collections page
When I go to user 'U_AAPUD_S17' library page in administration area
Then I should see the following roles on role drop down on library tab for opened user details on users page:
| RoleName      | Condition |
| R_AAPUD_S17_1 | should    |
| R_AAPUD_S17_2 | should    |




Scenario: Check that assigned category via Category Management correctly displayed on Library tab of user details
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @library
Given I created following categories:
| Name          |
| C_AAPUD_S19_1 |
| C_AAPUD_S19_2 |
And created users with following fields:
| Email       | Role         |
| U_AAPUD_S19 | agency.admin |
And created 'R_AAPUD_S19' role in 'library' group for advertiser 'DefaultAgency'
And added users 'U_AAPUD_S19' for category 'C_AAPUD_S19_1' with role 'R_AAPUD_S19'
And added users 'U_AAPUD_S19' for category 'C_AAPUD_S19_2' with role 'R_AAPUD_S19'
When I go to user 'U_AAPUD_S19' library page in administration area
Then I should see assigned to selected user following categories on library tab on users page:
| CategoryName  | RoleName    | Condition |
| C_AAPUD_S19_1 | R_AAPUD_S19 | should    |
| C_AAPUD_S19_2 | R_AAPUD_S19 | should    |


Scenario: Check that for user whom category has been removed via Category Management this category isn't displayed on Library tab of user details
Meta:@gdam
     @library
Given I created following categories:
| Name        |
| C_AAPUD_S20 |
And created users with following fields:
| Email       | Role        |
| U_AAPUD_S20 | agency.user |
And created 'R_AAPUD_S20' role in 'library' group for advertiser 'DefaultAgency'
And added users 'U_AAPUD_S20' for category 'C_AAPUD_S20' with role 'R_AAPUD_S20'
When I delete following categories from Asset Categories and Permissions page:
| Name        |
| C_AAPUD_S20 |
And go to user 'U_AAPUD_S20' library page in administration area
Then I should see assigned to selected user following categories on library tab on users page:
| CategoryName | RoleName    | Condition  |
| C_AAPUD_S20  | R_AAPUD_S20 | should not |


Scenario: Check that project is displayed on Projects tab of user if user has been granted permissions for this project
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I am on Dashboard page
And created users with following fields:
| Email       | Role        |
| U_AAPUD_S21 | agency.user |
And created 'P_AAPUD_S21' project
And created '/F_S21' folder for project 'P_AAPUD_S21'
And added users 'U_AAPUD_S21' to project 'P_AAPUD_S21' team folders '/F_S21' with role 'project.user' expired '12.02.2021'
When I go to Users list page with selected user 'U_AAPUD_S21'
Then I should see the following projects on Projects tab for opened user details on Users list page:
| ProjectName | Condition |
| P_AAPUD_S21 | should    |


Scenario: Check that project isn't displayed on Projects tab of user if user has been removed permissions for this project
Meta:@gdam
	 @projects
Given I created users with following fields:
| Email       | Role        |
| U_AAPUD_S22 | agency.user |
And created 'P_AAPUD_S22' project
And created '/F_S22' folder for project 'P_AAPUD_S22'
And added users 'U_AAPUD_S22' to project 'P_AAPUD_S22' team folders '/F_S22' with role 'project.user' expired '12.02.2021'
And removed user 'U_AAPUD_S22' from project 'P_AAPUD_S22' team page
When I open 'U_AAPUD_S22' user menu
Then I should see the following projects on Projects tab for opened user details on Users list page:
| ProjectName | Condition  |
| P_AAPUD_S22 | should not |


Scenario: Check that already added Category cannot be added again with the same library role
Meta:@gdam
     @library
Given I created following categories:
| Name          |
| C_AAPUD_S25_1 |
| C_AAPUD_S25_2 |
And created 'R_AAPUD_S25_1' role in 'library' group for advertiser 'DefaultAgency'
And created 'R_AAPUD_S25_2' role in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Role        |
| U_AAPUD_S25 | agency.user |
And added users 'U_AAPUD_S25' for category 'C_AAPUD_S25_1' with role 'R_AAPUD_S25_1'
When I go to user 'U_AAPUD_S25' library page in administration area
And select category 'C_AAPUD_S25_1' for opened user details on users page
Then I should see the following roles on role drop down on library tab for opened user details on users page:
| RoleName      | Condition  |
| R_AAPUD_S25_1 | should not |
| R_AAPUD_S25_2 | should     |


Scenario: Check that changing Applications for user correctly works on User's details of Users list
Meta:@gdam
     @globaladmin
Given I created users with following fields:
| Email       | Role         | Access |
| <UserEmail> | agency.admin |        |
When I check applications '<Applications>' on user '<UserEmail>' applications page in administration area
And save user details on users page
And login with details of '<UserEmail>'
Then I 'should' see elements '<TopMenuItems>' on page 'BasePage'

Examples:
| UserEmail      | Applications      | TopMenuItems       |
| U_AAPUD_S27_01 | Dashboard,Folders | Dashboard,Projects |
| U_AAPUD_S27_02 | Dashboard,Library | Dashboard,Library  |
| U_AAPUD_S27_04 | Folders,Library   | Projects,Library   |
| U_AAPUD_S27_05 | Folders,Tasks     | Projects,Tasks     |


Scenario: Check that project's paging isn't saved after changing user on User's list
Meta:@gdam
     @projects
Given created users with following fields:
| FirstName | LastName | Email         | Role        |
| Linda     | Stotch   | U_AAPUD_S28_1 | agency.user |
| Stephen   | Stotch   | U_AAPUD_S28_2 | agency.user |
And logged in with details of 'U_AAPUD_S28_1'
And created '7' projects with name pattern 'GP_AAPUD_S28_1'
And logged in with details of 'U_AAPUD_S28_2'
And created '7' projects with name pattern 'GP_AAPUD_S28_2'
When I login with details of 'AgencyAdmin'
And search user by text 'Stotch'
And select user 'U_AAPUD_S28_1' for current search result on Users Page
And click 'Next' button on projects tab for opened user details on users page
And select user 'U_AAPUD_S28_2' for current search result on Users Page
Then I 'should' see page '1' on projects tab for opened user details on users page


Scenario: Check that assigned category via user details is visible for this user in Library
Meta:@gdam
     @library
Given I created following categories:
| Name        |
| C_AAPUD_S18 |
And created 'R_AAPUD_S18' role in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Role        |Access|
| U_AAPUD_S18 | agency.user |streamlined_library,library|
And on administration area collections page
When I go to user 'U_AAPUD_S18' library page in administration area
And assign the following categories for opened user details on users page:
| CategoryName | RoleName    |
| C_AAPUD_S18  | R_AAPUD_S18 |
And save user details on users page
And login with details of 'U_AAPUD_S18'
And I go to the collections page
Then I 'should' see on the library page collections 'C_AAPUD_S18'NEWLIB

Scenario: Check that deletion category on Library tab of Users details correctly works
Meta:@gdam
     @library
Given I created following categories:
| Name        |
| C_AAPUD_S23 |
And created 'R_AAPUD_S23' role in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Role        |Access|
| U_AAPUD_S23 | agency.user |streamlined_library,library|
And added users 'U_AAPUD_S23' for category 'C_AAPUD_S23' with role 'R_AAPUD_S23'
When I go to user 'U_AAPUD_S23' library page in administration area
And remove the following categories from opened user details on users page:
| CategoryName | RoleName    |
| C_AAPUD_S23  | R_AAPUD_S23 |
And save user details on users page
And login with details of 'U_AAPUD_S23'
And I go to the collections page
Then I 'should not' see on the library page collections 'C_AAPUD_S23'NEWLIB


Scenario: Check that Tasks module not accessiable on revoking the access
Meta:@gdam
     @projects
!--QA-1121
Given I created users with following fields:
| Email         | Role         | Access        |
| U_AAPUD_S29_1 | agency.user  | tasks,library |
And I set 'off' 'tasks' application checkbox on user 'U_AAPUD_S29_1' details page
When I login with details of 'U_AAPUD_S29_1'
Then I 'should not' see elements 'Tasks' on page 'BasePage'
And I 'should' see elements 'Library' on page 'BasePage'


Scenario: Check that Tasks module not accessiable on revoking the access at BU level
Meta:@gdam
     @projects
!--QA-1121
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name          | A4User        | Country        | Application Access |
| BU_AAPUD_S1_1 | DefaultA4User | United Kingdom | tasks,library      |
And I created users with following fields:
| Email         | Role         | Access        | AgencyUnique |
| U_AAPUD_S30_1 | agency.user  | tasks,library | BU_AAPUD_S1_1      |
When I login with details of 'U_AAPUD_S30_1'
Then I 'should' see elements 'Tasks' on page 'BasePage'
When I login as 'GlobalAdmin'
And I update agency 'BU_AAPUD_S1_1' with following fields on agency overview page:
| FieldName            | FieldValue |
| Enables TASKS Module | false      |
And I login with details of 'U_AAPUD_S30_1'
Then I 'should not' see elements 'Tasks' on page 'BasePage'