!--NGN-6961
Feature:          Categories - sorting categories list
Narrative:
In order to
As a              AgencyAdmin
I want to         check that collections should be sorted by name alphabetically

Scenario: Check default collection are on the top for agency admin
Meta:@gdam
     @library
Given I created the agency 'A_CSCL_S01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CSCL_S01 | agency.admin | A_CSCL_S01   |
And logged in with details of 'U_CSCL_S01'
When I go to administration area collections page
Then I 'should' see collections sorted in following order on opened Categories and Permissions page:
| Name       |
| Everything |
| My Assets  |


Scenario: Check collection default sorting
Meta:@gdam
     @library
Given I created the agency 'A_CSCL_S02' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CSCL_S02 | agency.admin | A_CSCL_S02   |
And logged in with details of 'U_CSCL_S02'
And created following categories:
| Name       |
| A_CSCL_S02 |
| E_CSCL_S02 |
| M_CSCL_S02 |
| Z_CSCL_S02 |
When I go to administration area collections page
Then I 'should' see collections sorted in following order on opened Categories and Permissions page:
| Name       |
| Everything |
| My Assets  |
| A_CSCL_S02 |
| E_CSCL_S02 |
| M_CSCL_S02 |
| Z_CSCL_S02 |


Scenario: Check collection sorting after added a new collection
Meta:@gdam
     @library
Given I created the agency 'A_CSCL_S03' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CSCL_S03 | agency.admin | A_CSCL_S03   |
And logged in with details of 'U_CSCL_S03'
And created following categories:
| Name       |
| A_CSCL_S03 |
| E_CSCL_S03 |
| M_CSCL_S03 |
| Z_CSCL_S03 |
When I go to administration area collections page
And create category 'G_CSCL_S03'
Then I 'should' see collections sorted in following order on opened Categories and Permissions page:
| Name       |
| Everything |
| My Assets  |
| A_CSCL_S03 |
| E_CSCL_S03 |
| G_CSCL_S03 |
| M_CSCL_S03 |
| Z_CSCL_S03 |