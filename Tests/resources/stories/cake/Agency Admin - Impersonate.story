!--NGN-9798
Feature:          Agency Admin - Impersonate
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that agency admin can be impersonated

Meta:
@cake

Scenario: check that Impersonate by default for agency admin
Given I created the agency 'A_AAI_S01' with default attributes
And logged in with details of 'GlobalAdmin'
When I open role 'agency.admin' page with parent 'A_AAI_S01'
Then I 'should' see 'selected' permissions 'user.impersonate' on opened global role page


Scenario: check that global admin can add permission 'user.impersonate' for different user roles
Given I created the agency 'A_AAI_S02' with default attributes
And logged in with details of 'GlobalAdmin'
When I add following permissions 'user.impersonate' to role '<GlobalRole>' in agency 'A_AAI_S02'
And refresh the page
Then I 'should' see 'selected' permissions 'user.impersonate' on opened global role page

Examples:
| GlobalRole    |
| agency.admin  |
| agency.user   |
| guest.user    |


Scenario: check that agency.user now not sees extra lines in top right menu
Given I created users with following fields:
| Email     | Role        |
| U_AAI_S03 | agency.user |
When I login with details of 'U_AAI_S03'
Then I 'should not' see following account menu items:
| ItemName    |
| Impersonate |


Scenario: check that Impersonate only as user of current BU (popup)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
Given I created users with following fields:
| FirstName | LastName | Email       | Role         | Agency        |
| Eric      | Cartman  | U_AAI_S04   | agency.admin | DefaultAgency |
| Stan      | Marsh    | U_AAI_S04_1 | agency.user  | DefaultAgency |
| Stan      | Marsh    | U_AAI_S04_2 | agency.user  | AnotherAgency |
When I login with details of 'U_AAI_S04'
And select item 'Impersonate' from account menu
And type user full name 'Stan Marsh' on opened Impersonate me popup
And wait for '2' seconds
Then I 'should' see users 'U_AAI_S04_1' on opened user dropdown list on Impersonate me popup
Then I 'should not' see users 'U_AAI_S04_2' on opened user dropdown list on Impersonate me popup


Scenario: check that agency admin user can be impersonated
Given I created users with following fields:
| Email     | Role        |
| U_AAI_S05 | agency.user |
Then I 'should' be logged in as user 'AgencyAdmin'
When I impersonate me as user 'U_AAI_S05' on opened page
Then I 'should' be logged in as user 'U_AAI_S05'


Scenario: check that When trying to impersonate as other from other BU, should see empty result list
Given I created the agency 'A_AAI_S01' with default attributes
And created users with following fields:
| FirstName | LastName | Email       | Role         | Agency        |
| Eric      | Cartman  | U_AAI_S06   | agency.admin | A_AAI_S01     |
| Stan      | Marsh    | U_AAI_S06_1 | agency.user  | DefaultAgency |
When I login with details of 'U_AAI_S06'
And select item 'Impersonate' from account menu
And type user full name 'Stan Marsh' on opened Impersonate me popup
Then I 'should' see users '' on opened user dropdown list on Impersonate me popup


Scenario: Check that user in multiple BU cannot be impersonated in secondary BU
!--NGN-11202
Given I created the agency 'A_AAI_S01' with default attributes
And created the agency 'A_AAI_S01_2' with default attributes
And created users with following fields:
| FirstName | LastName | Email       | Role         | Agency      |
| Eric      | Cartman  | U_AAI_S07_1 | agency.admin | A_AAI_S01   |
| Stan      | Marsh    | U_AAI_S07_2 | agency.admin | A_AAI_S01_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_AAI_S01_2' to agency 'A_AAI_S01' on partners page
When I login with details of 'U_AAI_S07_1'
And select item 'Impersonate' from account menu
And type user full name 'Stan Marsh' on opened Impersonate me popup
Then I 'should not' see users 'U_AAI_S07_2' on opened user dropdown list on Impersonate me popup


Scenario: Check that 'Impersonate' button disabled if comment field is not filled (global admin)
Given I created users with following fields:
| Email     | Role        |
| U_AAI_S05 | agency.user |
And logged in with details of 'GlobalAdmin'
When I select item 'Impersonate' from account menu
And I type user 'U_AAI_S05' email on opened Impersonate me popup
Then I should see elements on page 'ImpersonatePopup' in the following state:
| element            | state    |
| ImpersonateButton  | disabled |


Scenario: Check that 'Impersonate' button disabled if comment field is not filled (agency admin)
Given I created users with following fields:
| Email     | Role        |
| U_AAI_S05 | agency.user |
When I select item 'Impersonate' from account menu
And I type user 'U_AAI_S05' email on opened Impersonate me popup
Then I should see elements on page 'ImpersonatePopup' in the following state:
| element            | state    |
| ImpersonateButton  | disabled |
