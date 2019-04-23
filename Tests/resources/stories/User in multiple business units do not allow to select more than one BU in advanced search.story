!--NGN-11675
Feature:          User in multiple BU - move file to library
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user in multiple BU can move file to library

Scenario: Check that if user added BU in advanced search ,BU field must be absent in filters (library)
Meta:@gdam
@library
Given I created the agency 'A_LAS_S01_1' with default attributes
And I created the agency 'A_LAS_S01_2' with default attributes
And I added agencies 'A_LAS_S01_1' as a partner to agency 'A_LAS_S01_2'
And created users with following fields:
| Email       | Role         | Agency      |Access|
| U_LAS_S01_1 | agency.admin | A_LAS_S01_1   |streamlined_library|
| U_LAS_S01_2 | agency.admin | A_LAS_S01_2 |streamlined_library|
And logged in with details of 'U_LAS_S01_2'
And created following categories:
| Name               |
| C_LAS_S01_X        |
And I added next users for following categories:
| CategoryName   | UserName   | RoleName      |
| C_LAS_S01_X    | U_LAS_S01_1  | library.admin |
And edited for user 'U_LAS_S01_1' agency role 'Administrator'
And logged in with details of 'U_LAS_S01_1'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
When I click on filter link for collection 'My Assets'
Then I 'should' see that filter 'Business Unit' has value 'A_LAS_S01_2' in the collection 'My Assets'NEWLIB
Then I 'should not' see that filter 'Business Unit' has value 'A_LAS_S01_1' in the collection 'My Assets'NEWLIB


Scenario: Check that if user added BU in advanced search ,BU field must be absent in filters (admin)
Meta:@gdam
@library
Given I created the agency 'A_LAS_S02_1' with default attributes
And I created the agency 'A_LAS_S02_2' with default attributes
And I added agencies 'A_LAS_S02_1' as a partner to agency 'A_LAS_S02_2'
And created users with following fields:
| Email       | Role         | Agency      |Access|
| U_LAS_S02_1 | agency.admin | A_LAS_S02_1   |streamlined_library|
| U_LAS_S02_2 | agency.admin | A_LAS_S02_2 |streamlined_library|
And logged in with details of 'U_LAS_S02_2'
And created following categories:
| Name               |
| C_LAS_S02_X        |
And I added next users for following categories:
| CategoryName   | UserName   | RoleName      |
| C_LAS_S02_X    | U_LAS_S02_1  | library.admin |
And edited for user 'U_LAS_S02_1' agency role 'Administrator'
And logged in with details of 'U_LAS_S02_1'
And created following categories:
| Name               |
| C_LAS_S02_Y        |
And I am on collection 'C_LAS_S02_Y' on administration area collections page
When I add following metadata on opened category page:
| FilterName       | FilterValue       |
| Business Unit    | A_LAS_S02_1         |
| Business Unit    | A_LAS_S02_2       |
Then I 'should' see that filter 'Business Unit' has value 'A_LAS_S02_2' on opened category page
And I 'should not' see that filter 'Business Unit' has value 'A_LAS_S02_1' on opened category page

