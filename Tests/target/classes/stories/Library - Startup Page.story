Feature:          Redirect the user to new library after login when a user has only access to new library
Narrative:
In order to
As a              AgencyAdmin
I want to         check that user is redirected to new library after login when a user has only access to new library


Scenario: Check that user has only access to new library lands on new library page after login
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| RFCP_S03 | agency.admin |streamlined_library|
And logged in with details of 'RFCP_S03'
Then I 'should' be on 'New Library' PageNEWLIB
When I click on 'Library' on top menu
Then I 'should' be on 'New Library' PageNEWLIB

Scenario: Check that user has  access to both old and new library lands on new library page after login
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| RFCP_S04 | agency.admin |streamlined_library,library|
And logged in with details of 'RFCP_S04'
Then I 'should' be on 'New Library' PageNEWLIB
When I click on 'Library' on top menu
Then I 'should' be on 'New Library' PageNEWLIB