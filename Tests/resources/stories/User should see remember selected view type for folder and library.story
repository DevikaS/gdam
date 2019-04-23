Feature:          Folder/Library should remember user's selected view type (List/Tile)
Narrative:
In order to
As a              AgencyAdmin
I want to         perform save type of view on Project and Library page and see this view after returning back from othe page

Scenario: Check that selected view type is saved for Folder after user logged of from application and logged in back
Meta: @gdam
@projects
Given I created the agency 'A_USSRS_S01_1' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |
| U_USSRS_S01_1 | agency.admin | A_USSRS_S01_1 |
And logged in with details of 'U_USSRS_S01_1'
And created 'P_USSRS_S01_1' project
And created '/F_USSRS_F01' folder for project 'P_USSRS_S01_1'
When I go to project 'P_USSRS_S01_1' folder '/' page
And switch to 'list' view
And logout from account
And login with details of 'U_USSRS_S01_1'
And go to project 'P_USSRS_S01_1' folder '/' page
Then I should see for project 'P_USSRS_S01_1' folder '/' page files in the 'list' view




Scenario: Check that selected view type is saved for Library after user logged of from application and logged in back
Meta: @gdam
@library
Given I created the agency 'A_USSRS_S01_1' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_USSRS_S02_1 | agency.admin | A_USSRS_S01_1 |streamlined_library,library|
And logged in with details of 'U_USSRS_S02_1'
And uploaded file '/files/Fish Ad.mov' into my library
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to the Library pageNEWLIB
And I switch to 'list' view from the collection 'Everything' pageNEWLIB
And logout from account
And login with details of 'U_USSRS_S02_1'
And I go to the Library pageNEWLIB
Then I should see assets in the 'list' view in the collection 'Everything' pageNEWLIB


Scenario: Check that change of view type does not affect other users and their view type is not affected
Meta: @gdam
@library
Given I created the agency 'A_USSRS_S01_1' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_USSRS_S03_1 | agency.admin | A_USSRS_S01_1 |streamlined_library,library|
| U_USSRS_S03_2 | agency.admin | A_USSRS_S01_1 |streamlined_library,library|
And logged in with details of 'U_USSRS_S03_1'
And created 'P_USSRS_S03_1' project
And created '/F_USSRS_F03' folder for project 'P_USSRS_S03_1'
When I go to project 'P_USSRS_S03_1' folder '/' page
And switch to 'list' view
And I go to the Library pageNEWLIB
And I switch to 'list' view from the collection 'Everything' pageNEWLIB
And login with details of 'U_USSRS_S03_2'
And go to project 'P_USSRS_S03_1' folder '/' page
Then I should see for project 'P_USSRS_S03_1' folder '/' page files in the 'tile' view
When I go to the Library pageNEWLIB
Then I should see assets in the 'grid' view in the collection 'Everything' pageNEWLIB



