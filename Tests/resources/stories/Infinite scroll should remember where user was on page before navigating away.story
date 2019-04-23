!--NGN-9306
Feature:          Infinite scroll should remember where user was on page before navigating away
Narrative:
In order to
As a              AgencyAdmin
I want to         check that infinite scroll should remember where user was on page before navigating away

Scenario: Check that trash bin should be visible only for NewRoleWithCreateViewProjectPermissionCheck that infinite scroll should remember where user was on page before navigating away (Projects)
Meta:@gdam
@projects
!--FAB-201
Given I created the agency 'CTISSRWUWOPBNW_A1' with default attributes
And created users with following fields:
| Email             | Role        | AgencyUnique      |
| CTISSRWUWOPBNW_E1 | agency.user | CTISSRWUWOPBNW_A1 |
And logged in with details of 'CTISSRWUWOPBNW_E1'
And created '10' projects with name pattern 'ATV'
When go to project list page
And I refresh the page
And scroll down to footer '1' times on opened Project page
And save current scroll position
When click following activity 'ATV_1' on opened Project list page
And wait for '2' seconds
And return to previous page
And wait for '2' seconds
Then should see be on current scroll position


Scenario: Check that infinite scroll should remember where user was on page before navigating away (Dashboard)
Meta:@gdam
@projects
!--FAB-201
Given I created the agency 'CTISSRWUWOPBNW_A1' with default attributes
And created users with following fields:
| Email             | Role        | AgencyUnique      |
| CTISSRWUWOPBNW_E2 | agency.user | CTISSRWUWOPBNW_A1 |
And logged in with details of 'CTISSRWUWOPBNW_E2'
And created '10' projects with name pattern 'PR'
When go to Dashboard page
And scroll down to footer '1' times on opened Dashboard page
And save current scroll position
And click following activity '7' on Dashboard page
And wait for '2' seconds
And return to previous page
Then should see be on current scroll position



Scenario: Check that infinite scroll should remember where user was on page before navigating away (Library)
Meta:@gdam
@library
Given I created the agency 'CTISSRWUWOPBNW_A1' with default attributes
And created users with following fields:
| Email             | Role        | AgencyUnique      |Access|
| CTISSRWUWOPBNW_E3 | agency.user | CTISSRWUWOPBNW_A1 |streamlined_library,library|
And logged in with details of 'CTISSRWUWOPBNW_E3'
When I upload file '/files/logo1.gif' '45' times to libraryNEWLIB
When I am on the library assets page
And I wait for '10' seconds
And I refresh the page
When I set pagination '60' in library assets pageNEWLIB
And I wait for '10' seconds
When I scroll down to footer '2' times on opened Library pageNEWLIB
And I wait for '10' seconds
And save current scroll position
When click following activity '44' on opened Library pageNEWLIB
And wait for '2' seconds
When I click back to library Button on asset info page
Then should see be on current scroll position


