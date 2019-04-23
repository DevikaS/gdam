!--NGN-11522
Feature:          User can see their Library organised by BU
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check library in case of sharing category from partner agency nad default view without



Scenario: Check that after sharing collection to user from partner BU it appears under BU name
Meta:@gdam
@library
Given I created the agency 'A_USLOBU_S03_1' with default attributes
And created the agency 'A_USLOBU_S03_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_USLOBU_S03_1 | agency.admin | A_USLOBU_S03_1 |streamlined_library,library|
| U_USLOBU_S03_2 | agency.admin | A_USLOBU_S03_2 |streamlined_library,library|
And logged in with details of 'U_USLOBU_S03_1'
And created 'C_USLOBU_S03' category
And added next users for following categories:
| CategoryName | UserName       | RoleName     |
| C_USLOBU_S03 | U_USLOBU_S03_2 | library.user |
And logged in with details of 'U_USLOBU_S03_2'
When I go to the collections page
Then I 'should' see that following collections in BU on library pageNEWLIB:
| ParentName     | ChildName    |
| A_USLOBU_S03_1 | C_USLOBU_S03 |
And 'should not' see business unit 'A_USLOBU_S03_2' on collection pageNEWLIB


Scenario: Default view of Library for agency admin
Meta:@gdam
@library
Given I created the agency 'A_USLOBU_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| U_USLOBU_S01 | agency.admin | A_USLOBU_S01 |streamlined_library,library|
And logged in with details of 'U_USLOBU_S01'
Then I 'should' be on 'New Library' PageNEWLIB
When I go to the collections page
Then I 'should not' see business unit 'A_USLOBU_S01' on collection pageNEWLIB
And I 'should' see list of collections 'My Assets' on the collection pageNEWLIB


Scenario: Default view of Library for agency user (without any shares)
Meta:@gdam
@library
Given I created the agency 'A_USLOBU_S02' with default attributes
And created users with following fields:
| Email        | Role        | Agency       |Access|
| U_USLOBU_S02 | agency.user | A_USLOBU_S02 |streamlined_library,library|
And logged in with details of 'U_USLOBU_S02'
When I go to the collections page
Then I 'should not' see business unit 'A_USLOBU_S02' on collection pageNEWLIB
And I 'should' see list of collections 'My Assets' on the collection pageNEWLIB





