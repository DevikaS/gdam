!--NGN-9381 NGN-9974
Feature:          Agency Admin - Terms and Conditions
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Terms and Conditions for agency

Scenario: check that in Admin area, BU admin should see T&C tab
Meta:@gdam
     @projects
When I go to User list page
Then I 'should' see element 'TermsAndConditionsTab' on page 'Users'

Scenario: check that user logs in first time after that, user should be prompted to accept T&C before proceeding to Adbank
Meta:@gdam
Given I created users with following fields:
| Email         | Role         |Agency       |
| U_AATNC_S05_1 | agency.admin |DefaultAgency|
| U_AATNC_S05_2 | agency.admin |DefaultAgency|
And logged in with details of 'U_AATNC_S05_1'
When I fill terms and conditions textbox with text 'ATC_AATNC_S05_1' on T&C page
And save current terms and conditions on opened T&C page
And wait for '3' seconds
When I login with details of 'U_AATNC_S05_2'
Then I 'should' see agency Terms and Conditions text 'ATC_AATNC_S05_1' on opened Terms and Conditions popup
When I accept agency Terms and Conditions
And wait for '3' seconds
And fill terms and conditions textbox with text 'ATC_AATNC_S05_2' on T&C page
And save current terms and conditions on opened T&C page
When I login with details of 'U_AATNC_S05_2'
And wait for '3' seconds
Then I 'should' see agency Terms and Conditions text 'ATC_AATNC_S05_2' on opened Terms and Conditions popup
When I accept agency Terms and Conditions
And I go to the T&C page
And delete current terms and conditions on opened T&C page
When I login with details of 'U_AATNC_S05_1'
And wait for '1' seconds
Then I 'should not' see agency Terms and Conditions popup

Scenario: check that user (Different user types or Invited users) logs in first time after that, user should be prompted to accept T&C before proceeding to Adbank
Meta:@gdam
     @projects
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email            | Role         | Agency       |
| <AdminUserEmail> | agency.admin | <AgencyName> |
| <UserEmail>      | <GlobalRole> | <AgencyName> |
And logged in with details of '<AdminUserEmail>'
When I fill terms and conditions textbox with text 'ATC_AATNC_S05' on T&C page
And save current terms and conditions on opened T&C page
When I login with details of '<UserEmail>'
Then I 'should' see agency Terms and Conditions text 'ATC_AATNC_S05' on opened Terms and Conditions popup
When I accept agency Terms and Conditions
And login with details of '<AdminUserEmail>'
And wait for '3' seconds
And I accept agency Terms and Conditions
And wait for '4' seconds
And fill terms and conditions textbox with text 'ATC_AATNC_S05_2' on T&C page
And save current terms and conditions on opened T&C page
And wait for '1' seconds
And login with details of '<UserEmail>'
And wait for '5' seconds
Then I 'should' see agency Terms and Conditions text 'ATC_AATNC_S05_2' on opened Terms and Conditions popup

Examples:
| AgencyName    | AdminUserEmail | UserEmail     | GlobalRole   |
| A_AATNC_S05_2 | AU_AATNC_S05_2 | U_AATNC_S05_2_N | agency.user  |
| A_AATNC_S05_3 | AU_AATNC_S05_3 | U_AATNC_S05_3 | guest.user   |


Scenario: If BU admin deletes T&C, users will not be prompted to accept T&C after logging in anymore
Meta:@gdam
     @projects
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email            | Role         | Agency       |
| <AdminUserEmail> | agency.admin | <AgencyName> |
| <UserEmail>      | <GlobalRole> | <AgencyName> |
And logged in with details of '<AdminUserEmail>'
When I wait for '3' seconds
And I fill terms and conditions textbox with text 'ATC_AATNC_S07' on T&C page
And save current terms and conditions on opened T&C page
And login with details of '<AdminUserEmail>'
And wait for '3' seconds
And accept agency Terms and Conditions
And go to the T&C page
And delete current terms and conditions on opened T&C page
When I login with details of '<UserEmail>'
Then I 'should not' see agency Terms and Conditions popup


Examples:
| AgencyName    | AdminUserEmail | UserEmail     | GlobalRole   |
| A_AATNC_S07_1 | AU_AATNC_S07_1 | U_AATNC_S07_1 | agency.admin |
| A_AATNC_S07_2 | AU_AATNC_S07_2 | U_AATNC_S07_2 | agency.user  |
| A_AATNC_S07_3 | AU_AATNC_S07_3 | U_AATNC_S07_3 | guest.user   |


Scenario: when admin updated t&c than user should be prompted to accept T&C before proceeding to Adbank
Meta: @gdam
     @projects
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email            | Role         | Agency       |
| <AdminUserEmail> | agency.admin | <AgencyName> |
| <UserEmail>      | <GlobalRole> | <AgencyName> |
And logged in with details of '<AdminUserEmail>'
When I wait for '3' seconds
And I fill terms and conditions textbox with text 'ATC_AATNC_S08_1' on T&C page
And save current terms and conditions on opened T&C page
And login with details of '<AdminUserEmail>'
And accept agency Terms and Conditions
When I wait for '3' seconds
And fill terms and conditions textbox with text 'ATC_AATNC_S08_2' on T&C page
And save current terms and conditions on opened T&C page
And login with details of '<UserEmail>'
And wait for '2' seconds
Then I 'should' see agency Terms and Conditions text 'ATC_AATNC_S08_2' on opened Terms and Conditions popup


Examples:
|AgencyName	|AdminUserEmail	|UserEmail	|GlobalRole	|
|A_AATNC_S08_1	|AU_AATNC_S08_1	|U_AATNC_S08_1	|agency.admin	|
|A_AATNC_S08_2	|AU_AATNC_S08_2	|U_AATNC_S08_2	|agency.user	|
|A_AATNC_S08_3	|AU_AATNC_S08_3	|U_AATNC_S08_3	|guest.user	|

Scenario: Check that admin can enable/disable T&C on Projects in BU admin and check T&C link on project overview
Meta:@gdam
     @projects
!--Though the T&C link doesnt appear on projet overview page --The T&C popup appears which is a bug - NGN-16582
Given I created the agency 'A_AATNC_S09' with default attributes
And created users with following fields:
| Email       | Role         | Agency      |
| U_AATNC_P09 | agency.admin | A_AATNC_S09 |
And logged in with details of 'U_AATNC_P09'
And created 'P_AATNC_P09' project
And on the T&C page
And refreshed the page
And turned '<State>' terms and conditions for projects
When I go to project 'P_AATNC_P09' overview page
Then I '<Should>' see 'Terms and Conditions' link on project Overview page

Examples:
| State | Should     |
| on    | should     |
| off   | should not |

Scenario: Check that tick is appear after navigate between tabs in admin area
Meta:@gdam
     @projects
Given I created the agency 'A_AATNC_S11' with default attributes
And I created users with following fields:
| Email       | Role         | Agency      |
| U_AATNC_S11 | agency.admin | A_AATNC_S11 |
And logged in with details of 'U_AATNC_S11'
And on the T&C page
And filled terms and conditions textbox with text 'text' on T&C page
And enabled current terms and conditions for projects on opened T&C page
When I go to the metadata page
And go to the T&C page
Then I 'should' see selected 'Enable Terms & Conditions for project' checkbox
And 'should' see terms and conditions text '' on T&C page