!--NGN-9830
Feature:          User with inbox.read permission can find autoshared assets by global search
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check that user with inbox.read permission can find autoshared assets by global search


Scenario: check that separate group of results in quick search: Shared Collections
Meta: @gdam
@library
Given I created the agency 'A_UIRPGSC_S01_1' with default attributes
And created the agency 'A_UIRPGSC_S01_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPGSC_S01_1 | agency.admin | A_UIRPGSC_S01_1 |streamlined_library,dashboard|
| U_UIRPGSC_S01_2 | agency.admin | A_UIRPGSC_S01_2 |streamlined_library,dashboard|
And logged in with details of 'U_UIRPGSC_S01_1'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPGSC_S01' category
And added agency 'A_UIRPGSC_S01_2' to category 'C_UIRPGSC_S01' on Asset Categories and Permissions page
And logged in with details of 'U_UIRPGSC_S01_2'
When I go to Dashboard page
And I search by text '128_shortname.jpg'
Then I 'should' see search object '128_shortname.jpg' with type 'Shared Collections' after wrap according to search '128_shortname.jpg' with 'Name' type
And I 'should' see show all results link on quick search menu


Scenario: check that thumbnails for assets are display on show all results page
Meta:@gdam
@library
Given I created the agency 'A_UIRPGSC_S02_1' with default attributes
And created the agency 'A_UIRPGSC_S02_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPGSC_S02_1 | agency.admin | A_UIRPGSC_S02_1 |dashboard,streamlined_library|
| U_UIRPGSC_S02_2 | agency.admin | A_UIRPGSC_S02_2 |dashboard,streamlined_library|
And logged in with details of 'U_UIRPGSC_S02_1'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPGSC_S02' category
And added agency 'A_UIRPGSC_S02_2' to category 'C_UIRPGSC_S02' on Asset Categories and Permissions page
And logged in with details of 'U_UIRPGSC_S02_2'
When I go to Dashboard page
And I search by text '128_shortname.jpg'
And I click show all link for global user search for object 'Shared Collections'
Then I 'should' see asset count '1' on the library search results pageNEWLIB
And I 'should' see assets '128_shortname.jpg' on the library search results pageNEWLIB




Scenario: search assets by metadata in Shared Collections (see examples in global search story)
Meta: @gdam
@library
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_UIRPGSC_S03_1' with default attributes
And created the agency 'A_UIRPGSC_S03_2' with default attributes
When I open role 'agency.admin' page with parent 'A_UIRPGSC_S03_1'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_UIRPGSC_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_UIRPGSC_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,inbox.read,asset.share' permissions for advertiser 'A_UIRPGSC_S03_1'
And create users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPGSC_S03_1 | A_UIRPGSC_R1 | A_UIRPGSC_S03_1 |streamlined_library,dashboard|
| U_UIRPGSC_S03_2 | agency.admin | A_UIRPGSC_S03_2 |streamlined_library,dashboard|
And login with details of 'U_UIRPGSC_S03_1'
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C_UIRPGSC_S03' category
And add agency 'A_UIRPGSC_S03_2' to category 'C_UIRPGSC_S03' on Asset Categories and Permissions page
When go to the Library page for collection 'C_UIRPGSC_S03'NEWLIB
And I 'save' asset 'Fish1-Ad.mov' info of collection 'C_UIRPGSC_S03' by following informationNEWLIB:
| FieldName          | FieldValue      |
| Production company | <MetaData>     |
| Screen             | Spot            |
| Media sub-type     | Generic Master  |
| Clock number       | Clk_981  |
And login with details of 'U_UIRPGSC_S03_2'
And I go to Dashboard page
And I search by text '<SearchQuery>'
Then I 'should' see search object 'Fish1-Ad.mov' with type 'Shared Collections' after wrap according to search 'Fish1-Ad.mov' with 'Name' type
And I 'should' see show all results link on quick search menu

Examples:
| SearchQuery     |MetaData|
| A_UIRPGSC_S03_1 |Garrison|
| Father Maxi     |Father Maxi |
| Spot            |Anderson|



Scenario: check that users without permission inbox.read should see accepted assets from shared collections in search results
Meta: @gdam
@library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library,dashboard|
| <User2> | agency.admin | <Agency2> |streamlined_library,dashboard|
| <User3> | agency.user  | <Agency2> |streamlined_library,dashboard|
And logged in with details of '<User1>'
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPGSC_S04_1' category
And added agency '<Agency2>' to category 'C_UIRPGSC_S04_1' on Asset Categories and Permissions page
When I 'save' asset 'Fish1-Ad.mov' info of collection 'C_UIRPGSC_S04_1' by following informationNEWLIB:
| FieldName          | FieldValue      |
| Screen             | Spot            |
| Media sub-type     | Generic Master  |
| Clock number       | Clk_982  |
And login with details of '<User2>'
And I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_UIRPGSC_S04_1' from agency '<Agency1>' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UIRPGSC_S04_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'C_UIRPGSC_S04_2' category
When I go to administration area collections page
And add users '<User3>' to category 'C_UIRPGSC_S04_2' with role 'library.user' by users details
And login with details of '<User3>'
And I go to Dashboard page
And search by text '<SearchQuery>'
Then I 'should' see search object 'Fish1-Ad.mov' with type 'Shared Collections' after wrap according to search 'Fish1-Ad.mov' with 'Name' type
And I 'should' see show all results link on quick search menu

Examples:
| SearchQuery     |Agency1           |Agency2         |User1            |User2              |User3          |
| Fish1-Ad.mov    |A_UIRPGSC_S04_1  |A_UIRPGSC_S04_2  |U_UIRPGSC_S04_1  |U_UIRPGSC_S04_2    |U_UIRPGSC_S04_3|
| Spot            |A_UIRPGSC_S04_1_1|A_UIRPGSC_S04_2_1|U_UIRPGSC_S04_1_1|U_UIRPGSC_S04_2_1  |U_UIRPGSC_S04_3_1|


Scenario: check that users without permission inbox.read should not see not accepted assets from shared collections in search results
Meta: @gdam
@library
Given I created the agency 'A_UIRPGSC_S05_1' with default attributes
And created the agency 'A_UIRPGSC_S05_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPGSC_S05_1 | agency.admin | A_UIRPGSC_S05_1 |streamlined_library,dashboard|
| U_UIRPGSC_S05_2 | agency.admin | A_UIRPGSC_S05_2 |streamlined_library,dashboard|
| U_UIRPGSC_S05_3 | agency.user  | A_UIRPGSC_S05_2 |streamlined_library,dashboard|
And logged in with details of 'U_UIRPGSC_S05_1'
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPGSC_S05_1' category
And added agency 'A_UIRPGSC_S05_2' to category 'C_UIRPGSC_S05_1' on Asset Categories and Permissions page
When I login with details of 'U_UIRPGSC_S05_2'
And create 'C_UIRPGSC_S05_2' category
And add users 'U_UIRPGSC_S05_3' to category 'C_UIRPGSC_S05_2' with role 'library.user' by users details
And login with details of 'U_UIRPGSC_S05_3'
And I go to Dashboard page
And search by text '<SearchQuery>'
Then I 'should not' see search object 'Fish1-Ad.mov' with type 'Shared Collections' after wrap according to search 'Fish1-Ad.mov' with 'Name' type
And I 'should not' see show all results link on quick search menu

Examples:
| SearchQuery     |
| Fish1-Ad.mov    |
| A_UIRPGSC_S05_1 |

