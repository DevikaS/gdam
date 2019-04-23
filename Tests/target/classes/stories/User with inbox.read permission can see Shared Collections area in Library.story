!--NGN-9522
Feature:          User with inbox.read permission can see Shared Collections area in Library
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check that user with inbox.read permission can see Shared Collections area in Library

Scenario: Check that User with inbox.read permission can see Shared Collections area in Library (all user types)
Meta: @gdam
@library
Given I created users with following fields:
| Email       | Role         | Access  |
| <UserEmail> | <GlobalRole> | streamlined_library |
When I login with details of '<UserEmail>'
And I go to the collections page
Then I '<Condition>' see shared collection link on collection pgeNEWLIB
Examples:
| UserEmail       | GlobalRole   | Condition  |
| U_UIRPSCL_S01_1 | agency.admin | should     |
| U_UIRPSCL_S01_2 | agency.user | should not     |


Scenario: Check that inbox.read permission is default for agency admin
Meta:@globaladmin
     @gdam
Given I created the agency 'A_UIRPSCL_S02' with default attributes
And logged in with details of 'GlobalAdmin'
When I open role 'agency.admin' page with parent 'A_UIRPSCL_S02'
Then I should see role 'agency.admin' that 'should' contains following selected permissions 'inbox.read'


Scenario: Check that after sharing between one agency (shared category should be available only in Library and absent in inbox)
Meta:@library
     @gdam
Given I created users with following fields:
| Email         | Role         |Access|
| U_UIRPSCL_S03 | agency.admin |streamlined_library|
And created 'С_UIRPSCL_S03' category
And added users 'U_UIRPSCL_S03' to category 'С_UIRPSCL_S03' with role 'library.user' by users details
When I login with details of 'U_UIRPSCL_S03'
And I go to the collections page
Then I 'should' see on the library page collections 'С_UIRPSCL_S03'NEWLIB
And I should not see shared collection expandableNEWLIB


Scenario: Check sharing from one agency to another (Shared Category with assets should be available in Shared categories)
Meta:@library
     @gdam
Given I created the agency 'A_UIRPSCL_S04_1' with default attributes
And created the agency 'A_UIRPSCL_S04_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPSCL_S04_1 | agency.admin | A_UIRPSCL_S04_1 |streamlined_library|
| U_UIRPSCL_S04_2 | agency.admin | A_UIRPSCL_S04_2 |streamlined_library|
And logged in with details of 'U_UIRPSCL_S04_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_UIRPSCL_S04' category
And added agency 'A_UIRPSCL_S04_2' to category 'C_UIRPSCL_S04' on Asset Categories and Permissions page
And logged in with details of 'U_UIRPSCL_S04_2'
When I go to the collections page
Then I 'should' see collection 'C_UIRPSCL_S04' from agency 'A_UIRPSCL_S04_1' on inbox shared collectionNEWLIB
When I go to the Shared Collection 'C_UIRPSCL_S04' from agency 'A_UIRPSCL_S04_1' pageNEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' on Shared collection pageNEWLIB

Scenario: Check that after upload new asset to shared category, receiver sees this new asset in Inbox
Meta:@library
     @gdam
Given I created the agency 'A_UIRPSCL_S05_1' with default attributes
And created the agency 'A_UIRPSCL_S05_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPSCL_S05_1 | agency.admin | A_UIRPSCL_S05_1 |streamlined_library|
| U_UIRPSCL_S05_2 | agency.admin | A_UIRPSCL_S05_2 |streamlined_library|
And logged in with details of 'U_UIRPSCL_S05_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_UIRPSCL_S05' category
And added agency 'A_UIRPSCL_S05_2' to category 'C_UIRPSCL_S05' on Asset Categories and Permissions page
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And logged in with details of 'U_UIRPSCL_S05_2'
When I go to the Shared Collection 'C_UIRPSCL_S05' from agency 'A_UIRPSCL_S05_1' pageNEWLIB
Then I 'should' see assets 'Fish1-Ad.mov,Fish2-Ad.mov' on Shared collection pageNEWLIB



Scenario: Check that If user in the Sender BU edit assets metadata so it does not match category anymore - it disappears from Receiver's Inbox
Meta:@library
     @gdam
Given I created the agency 'A_UIRPSCL_S06_1' with default attributes
And created the agency 'A_UIRPSCL_S06_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPSCL_S06_1 | agency.admin | A_UIRPSCL_S06_1 |streamlined_library|
| U_UIRPSCL_S06_2 | agency.admin | A_UIRPSCL_S06_2 |streamlined_library|
And logged in with details of 'U_UIRPSCL_S06_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created following categories:
| Name          | MediaType | MediaSubType  |
| C_UIRPSCL_S06 | video     | Cinema Master |
When I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name              | SubType |
| Fish1-Ad.mov       | Cinema Master   |
And add agency 'A_UIRPSCL_S06_2' to category 'C_UIRPSCL_S06' on Asset Categories and Permissions page
And I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name              | SubType |
| Fish1-Ad.mov       | Generic Master   |
And login with details of 'U_UIRPSCL_S06_2'
And I go to the collections page
And I go to the Shared Collection 'C_UIRPSCL_S06' from agency 'A_UIRPSCL_S06_1' pageNEWLIB
Then I 'should not' see assets 'Fish1-Ad.mov' on Shared collection pageNEWLIB

Scenario: Check that shared category should be visible only in Inbox not in library
Meta:@library
     @gdam
Given I created the agency 'A_UIRPSCL_S07_1' with default attributes
And created the agency 'A_UIRPSCL_S07_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPSCL_S07_1 | agency.admin | A_UIRPSCL_S07_1 |streamlined_library|
| U_UIRPSCL_S07_2 | agency.admin | A_UIRPSCL_S07_2 |streamlined_library|
And logged in with details of 'U_UIRPSCL_S07_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_UIRPSCL_S07' category
And added agency 'A_UIRPSCL_S07_2' to category 'C_UIRPSCL_S07' on Asset Categories and Permissions page
When I login with details of 'U_UIRPSCL_S07_2'
And I go to the collections page
Then I 'should not' see on the library page collections 'C_UIRPSCL_S07'NEWLIB
And I 'should' see collection 'C_UIRPSCL_S07' from agency 'A_UIRPSCL_S07_1' on inbox shared collectionNEWLIB
