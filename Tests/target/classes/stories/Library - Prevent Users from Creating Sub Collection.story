Feature:          Prevent users from creating sub collection when only assets are selected
Narrative:
In order to
As a              AgencyAdmin
I want to         check that users are prevented from creating sub collection when only assets are selected

Scenario: Check that sub collection option is hidden when only assets are selected from library assets
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| PUCS_U01 | agency.admin |streamlined_library,library|
And logged in with details of 'PUCS_U01'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov,Fish1-Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'PUCS_C1' from collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov,Fish1-Ad.mov' in the collection 'PUCS_C1'NEWLIB
When I select asset 'Fish Ad.mov,Fish1-Ad.mov' in the 'PUCS_C1'  library pageNEWLIB
Then 'should not' see 'New sub-collection' option in top level menu on collection 'PUCS_C1'NEWLIB


Scenario: Check that sub collection can be created by applying filters from library assets
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| PUCS_U02 | agency.admin |streamlined_library,library|
And logged in with details of 'PUCS_U02'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov,Fish1-Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'PUCS_C2' from collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov,Fish1-Ad.mov' in the collection 'PUCS_C2'NEWLIB
When I switch 'on' media type filter 'video' for collection 'PUCS_C2' on the page LibraryNEWLIB
And I click on 'sub' option on the collection filter page
And I type collection name 'PUCS_SC2' and save on opened 'sub' collection popup from filter pageNEWLIB
And go to the Library page for collection 'PUCS_SC2'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov,Fish1-Ad.mov' in the collection 'PUCS_SC2'NEWLIB



Scenario: Check that sub collection can be created by applying filters from My assets
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| PUCS_U03 | agency.admin |streamlined_library,library|
And logged in with details of 'PUCS_U03'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I switch 'on' media type filter 'video' for collection 'My Assets' on the page LibraryNEWLIB
And I select asset 'Fish Ad.mov,Fish1-Ad.mov' from filter pageNEWLIB
And I click on 'sub' option on the collection filter page
And I type collection name 'PUCS_SC3' and save on opened 'sub' collection popup from filter pageNEWLIB
And go to the Library page for collection 'PUCS_SC3'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov,Fish1-Ad.mov' in the collection 'PUCS_SC3'NEWLIB


Scenario: Check that sub collection option is hidden when only assets are selected from My Assets
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| PUCS_U04 | agency.admin |streamlined_library,library|
And logged in with details of 'PUCS_U04'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I select asset 'Fish Ad.mov,Fish1-Ad.mov' in the 'My Assets'  library pageNEWLIB
Then 'should not' see 'New sub-collection' option in top level menu on collection 'My Assets'NEWLIB

Scenario: Check that My Assets page loads same asset count when filter is opened within this collection
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| PUCS_U05 | agency.admin |streamlined_library,library|
And logged in with details of 'PUCS_U05'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see asset count '2' in 'My Assets' NEWLIB
When I click on filter link on Collection details for collection 'My Assets'NEWLIB
Then I 'should' see asset count '2' in collection filter pageNEWLIB


Scenario: Check that child category is not able to edit metadata of parent category
Meta:@gdam
@library
Given I created the agency 'PUCS_A1' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PUCS_A1':
| Advertiser | Brand      | Sub Brand   | Product    |
| PUCS_A1_A | PUCS_A1_B | PUCS_A1_SB | PUCS_A1_P |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| PUCS_U06 | agency.admin | PUCS_A1     |streamlined_library,library|
And I logged in with details of 'PUCS_U06'
And created 'PUCS_C1' category
And added into category 'PUCS_C1' following metadata:
| FilterName | FilterValue |
| Advertiser | PUCS_A1_A  |
And created child category 'PUCS_C1_1' of category 'PUCS_C1'
And added into category 'PUCS_C1_1' following metadata:
| FilterName | FilterValue |
| Brand | PUCS_A1_B  |
When I go to the Library page for collection 'PUCS_C1_1'NEWLIB
And I click on filter link on Collection details for collection 'PUCS_C1_1'NEWLIB
Then I 'should not' see the following metadata editable in collection filter pageNEWLIB:
|MetaData|
|Advertiser|
|Brand|


Scenario: check that sub collection shows correct assets when using filter query
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/Fish-Ad.mov        |
| /files/Fish-AdTests.mov        |
| /files/test.mp3            |
| /files/logo3.png        |
|/images/logo.bmp            |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I switch 'on' media type filter 'VIDEO' on filter page
And I search by keyword 'Fish-Ad' on the current filter pageNEWLIB
Then I 'should' see assets 'Fish-Ad.mov' in the collection 'My Assets'NEWLIB
When I add assets to 'sub' collection 'C_FAS_S01' from collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'C_FAS_S01'NEWLIB
Then I 'should' see assets 'Fish-Ad.mov' in the collection 'C_FAS_S01'NEWLIB


Scenario: Check that shared colection and filter show the same asset count
Meta:@gdam
@library
Given I created the agency 'PUCS_A1' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique |Access|
| PUCS_U9 | agency.admin | PUCS_A1 |streamlined_library|
| PUCS_U10 | agency.admin  | PUCS_A1 |streamlined_library|
And logged in with details of 'PUCS_U9'
And created 'PUCS_C1' category
And added users 'PUCS_U10' to category 'PUCS_C1' with role 'library.user' by users details
And uploaded following assetsNEWLIB:
| Name              |
| /files/logo1.gif  |
And waited while preview is visible on library page for collection 'My Assets' for assets 'logo1.gif'NEWLIB
When I login with details of 'PUCS_U10'
And I upload following assetsNEWLIB:
| Name                       |
| /files/test.mp3            |
| /files/logo3.png        |
And wait while preview is visible on library page for collection 'My Assets' for assets 'test.mp3,logo3.png'NEWLIB
When I go to the Library page for collection 'PUCS_C1'NEWLIB
Then I 'should' see total asset count '3' in collection 'PUCS_C1'NEWLIB
When I click on filter link on Collection details for collection 'PUCS_C1'NEWLIB
Then I 'should' see asset count '3' in collection filter pageNEWLIB


