!--NGN-9305
Feature:          User without asset create permission
Narrative:
In order to
As a              AgencyAdmin
I want to         Check user without asset.create permission

Scenario: Check that if user does not have asset.create permission than Latest Library Uploads section on Dashboard should be hidden
Meta:@gdam
@projects
Given I created '<GlobalRole>' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| enum.read    |
| role.read    |
| user.read    |
| <Permission> |
And created users with following fields:
| Email       | Role         |
| <UserEmail> | <GlobalRole> |
And logged in with details of '<UserEmail>'
Then I '<Condition>' see section 'Latest Library Uploads' on Dashboard page

Examples:
| UserEmail      | GlobalRole     | Permission   | Condition  |
| U_UWOACP_S01_1 | R_UWOACP_S01_1 | asset.create | should     |
| U_UWOACP_S01_2 | R_UWOACP_S01_2 |              | should not |


Scenario: My Assets category in Library should be hidden
Meta:@gdam
@library
Given I created 'R_UWOACP_S02' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission |
| enum.read  |
| role.read  |
| user.read  |
And created users with following fields:
| Email        | Role         |Access|
| U_UWOACP_S02 | R_UWOACP_S02 |streamlined_library|
And logged in with details of 'U_UWOACP_S02'
When I am on the library assets page
Then I 'should' see message 'You do not have any library materials yet. Please contact your business unit administrator.' on library assets page
When I go to the collections page
Then I 'should' see message 'You do not have any library materials yet. Please contact your business unit administrator.' on collection page




