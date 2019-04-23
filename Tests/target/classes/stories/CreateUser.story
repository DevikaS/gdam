!--NGN-45 NGN-4685
Feature:          CreateUser
Narrative:
In order to
As a              AgencyAdmin
I want to         Check creating of a new user

Scenario: Successfully creating a new user mandatory fields
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I am on Create New User page
When create user with following fields:
| Email    | Role        |Agency       |
| UFNCU2   | agency.user |DefaultAgency|
And wait for '10' seconds
And refresh the page
Then I 'should' see user with email 'UFNCU2' on Users list page


Scenario: Creating a new user with extended examples
Meta:@gdam
@projects
Given I am on Create New User page
When I create user with following fields:
| FirstName   | LastName   | Email       |
| <FirstName> | <LastName> | <UserEmail> |
And refresh the page
And go to user '<UserEmail>' details page
Then I should see on user details page fields with following values:
| element   | value       |
| FirstName | <FirstName> |
| LastName  | <LastName>  |

Examples:
| FirstName | LastName           | UserEmail |
| Cæt'alà   | Cøpez-Brea Högdahl | CU2_2     |


Scenario: Successfully creating a new user all fields
Meta:@gdam
@projects
Given I am on Create New User page
When I fill '<Fields>' and '<Logo>' logo for '<Name>' user
And I click element 'SaveButton' on page 'UserSettings' without delay
Then I should see message warning '<TextOnPage>'
And refresh the page
And '<Name>' in User list with logo '<Logo>'
And '<Name>' user should contains '<Fields>'

Examples:
| Name     | Fields          | Logo  | TextOnPage                       |
| NewUser8 | AllFilledFields | PNG   | User has been successfully saved |

Scenario: Successfully log in as a new user
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I created 'NewUser0' User with 'MandatoryFields'
And I logout from account
When I login with details of 'NewUser0'
Then I should see interface 'projects'


Scenario: Creating a User with same name
Meta:@gdam
@projects
Given I created 'AlreadyExistUser' User with 'AllFilledFields'
And I am on Create New User page
When I fill 'AllFilledFields' for 'AlreadyExistUser' user
And I click element 'SaveButton' on page 'UserSettings'
Then I should see message error 'This user already exists in another business unit. Would you like to invite this user to your business unit(.*)' on same page


Scenario: Creating a User with empty mandatory fields
Meta:@gdam
@projects
Given I am on Create New User page
When I fill following fields on user opened details page:
| FirstName | LastName | Email | Password |
|           |          |       |          |
Then I 'should' see red inputs on page


Scenario: Successfully upload after upload
Meta:@gdam
@projects
Given I am on Create New User page
When I fill 'AllFilledFields' and 'JPG' logo for 'NewUser9' user
And I fill 'AllFilledFields' and 'PNG' logo for 'NewUser9' user
And I click element 'SaveButton' on page 'UserSettings' without delay
Then I should see message without delay warning 'User has been successfully saved'
When I refresh the page
Then 'NewUser9' in User list with logo 'PNG'
And 'NewUser9' user should contains 'AllFilledFields'


Scenario: check that role and unit of created user correctly displayed in users list
Meta:@gdam
@projects
Given I created 'R_CU_S01' role in 'global' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName | LastName | Email      | Role         | Agency        |
| Homer     | Simpson  | U_CU_S01_1 | guest.user   | DefaultAgency |
| Marge     | Simpson  | U_CU_S01_2 | agency.user  | DefaultAgency |
| Lisa      | Simpson  | U_CU_S01_3 | agency.admin | DefaultAgency |
| Bart      | Simpson  | U_CU_S01_4 | R_CU_S01     | DefaultAgency |
When I go to User list page
Then I 'should' see users with following fields on users list page:
| FullName      | Role         | Unit          |
| Homer Simpson | guest.user   | DefaultAgency |
| Marge Simpson | agency.user  | DefaultAgency |
| Lisa Simpson  | agency.admin | DefaultAgency |
| Bart Simpson  | R_CU_S01     | DefaultAgency |


Scenario: Check that existing user is added to another BU via UI by BU Admin
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @gdam
	  @projects
!--QA-1178
Given I logged in as 'GlobalAdmin'
And I created the agency 'BU_CU_S01_1' with default attributes
And I created the agency 'BU_CU_S01_2' with default attributes
And I created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CU_S01_5 | agency.admin | BU_CU_S01_1  |
| U_CU_S01_6 | agency.admin | BU_CU_S01_2  |
And I logged in with details of 'U_CU_S01_5'
And I am on Create New User page
When create user with following fields:
| Email      | Password   | Role        |
| U_CU_S01_6 | abcdefghA1 | agency.user |
And I click 'OK' on the alert
And I click save on users details page
And I wait for '2' seconds
And refresh the page without delay
Then I 'should' see user with email 'U_CU_S01_6' on Users list page


Scenario: Check that existing user is added to another BU via UI by Global Admin
Meta: @gdam
@globaladmin
!--QA-1178
Given I logged in as 'GlobalAdmin'
And I created the agency 'BU_CU_S01_1' with default attributes
And I created the agency 'BU_CU_S01_2' with default attributes
And I created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CU_S01_7 | agency.admin | BU_CU_S01_1  |
And I am on global admin 'BU_CU_S01_2' create user page
When I created new user with following fields:
| Email      | Password   | Role        |
| U_CU_S01_7 | abcdefghA1 | agency.user |
And I click 'OK' on the alert
Then I should see 'U_CU_S01_7' on global admin users list page