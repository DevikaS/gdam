!--NGN-9229
Feature:          Library - Add asset to collection
Narrative:
In order to
As a              AgencyAdmin
I want to         Check adding assets to collection



Scenario: Check that added to parent asset won't be visible in child even if child filters not differs
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| U_LAATC_S06 | agency.admin |streamlined_library|
And logged in with details of 'U_LAATC_S06'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created following collections:
| Name          |
| C_LAATC_S06_1 |
And created following collections:
| Name          | ParentCategory | MediaType |
| C_LAATC_S06_2 | C_LAATC_S06_1  | image     |
When I select asset 'Fish Ad.mov' in the 'My Assets'  collection pageNEWLIB
And copy to 'C_LAATC_S06_1'  from 'My Assets' library page
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S06_1'NEWLIB
When go to the Library page for collection 'C_LAATC_S06_2'NEWLIB
Then 'should not' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S06_2'NEWLIB


Scenario: Check that assets could be added only to collection and cannot be copied to category
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access            |
| U_LAATC_S01 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAATC_S01'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And created following collections:
| Name          |
| C_LAATC_S01_1 |
And created following categories:
| Name          |
| C_LAATC_S01_2 |
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And wait for '2' seconds
And click copy to collection from 'Everything' library page
Then 'should not' see that category 'C_LAATC_S01_2' available for copy
And 'should' see that category 'C_LAATC_S01_1' available for copy


Scenario: Check that assets with different media types could be added to collection
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Access              |
| U_LAATC_S02 | agency.admin |streamlined_library  |
And logged in with details of 'U_LAATC_S02'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And uploaded file '/files/GWGTest2.pdf' into my libraryNEWLIB
And created following collectionsNEWLIB:
| Name        | MediaType |
| C_LAATC_S02 | print     |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'GWGTest2.pdf' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_LAATC_S02' from collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'GWGTest2.pdf' in the collection 'C_LAATC_S02'NEWLIB

Scenario: Check that asset that was moved from project could be added to collection
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access             |
| U_LAATC_S03 | agency.admin |folders,library,streamlined_library  |
And logged in with details of 'U_LAATC_S03'
And created 'P_LAATC_S03' project
And created '/F_LAATC_S03' folder for project 'P_LAATC_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_LAATC_S03' folder for 'P_LAATC_S03' project
And waited while transcoding is finished in folder '/F_LAATC_S03' on project 'P_LAATC_S03' files page
When I move file 'Fish Ad.mov' from project 'P_LAATC_S03' folder '/F_LAATC_S03' to new library page
And I go to  Library page for collection 'Everything'NEWLIB
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_LAATC_S03' from collection 'Everything'NEWLIB
And go to the Library page for collection 'C_LAATC_S03'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S03'NEWLIB

Scenario: Check that shared asset could be added to collection
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Agency       | Access      |
| U_LAATC_S04_1 | agency.admin |DefaultAgency|streamlined_library  |
| U_LAATC_S04_2 | agency.user  |DefaultAgency|streamlined_library  |
And logged in with details of 'U_LAATC_S04_1'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And created 'C_LAATC_S04_1' category
And waited while transcoding is finished in collection 'Everything'NEWLIB
And added users 'U_LAATC_S04_2' to category 'C_LAATC_S04_1' with role 'library.user' by users details
When login with details of 'U_LAATC_S04_2'
And I go to the collections page
And I search the collection 'C_LAATC_S04_1' on collections page
And I click the collection 'C_LAATC_S04_1' on collections page
And wait for '2' seconds
And click on filter link on Collection page
And I switch 'on' media type filter 'VIDEO' on filter page
And I add assets to 'sub' collection 'C_LAATC_S04_2' from collection 'C_LAATC_S04_1'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S04_2'NEWLIB


Scenario: Check that added to parent collection won't be visible in child even if child filters not differs
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Access           |
| U_LAATC_S06 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAATC_S06'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And created following collectionsNEWLIB:
| Name          |MediaType       |
| C_LAATC_S06_1 | video          |
And created following collectionsNEWLIB:
| Name          | ParentCategory | MediaSubType       |MediaType       |
| C_LAATC_S06_2 | C_LAATC_S06_1  | Generic Master     |video           |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name              | SubType            |
| Fish Ad.mov       | Generic Master             |
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And copy to 'C_LAATC_S06_1'  from 'Everything' library page
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S06_1'NEWLIB
And 'should not' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S06_2'NEWLIB

Scenario: Check that assets could be added to several collections (one of them added on the fly)
Meta:
@gdam
@library
Given I created users with following fields:
| Email       | Role         | Access         |
| U_LAATC_S05 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAATC_S05'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And created following collectionsNEWLIB:
| Name          |
| C_LAATC_S05_1 |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And I have refreshed the page
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_LAATC_S05_2' from collection 'Everything'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And copy to 'C_LAATC_S05_1'  from 'Everything' library page
And go to the Library page for collection 'C_LAATC_S05_1'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S05_1'NEWLIB
When go to the Library page for collection 'C_LAATC_S05_2'NEWLIB
Then 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S05_2'NEWLIB

Scenario: Check that assets can be added to a new Collection by selecting filters from Library List on fly
Meta:@gdam
@library
Given I created users with following fields:
| Email           | Role         |  Access             |
| U_LAATC_LA_S02 | agency.admin  | streamlined_library |
And logged in with details of 'U_LAATC_LA_S02'
When I upload file '/files/Fish Ad.mov' into my libraryNEWLIB
Then I 'should not' see create 'new' button on 'Everything' page
When I switch 'on' media type filter 'VIDEO' for collection 'Everything' on the page LibraryNEWLIB
Then I 'should' see create 'new' button on 'Everything' page
And I 'should' see option 'Using filters' button on 'Everything' page
And I 'should not' see option 'Using selected items' button on 'Everything' page
When I add assets to 'new' collection 'C_LAATC_LA_S01_2' from collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_LA_S01_2'NEWLIB
When I go to  Library page for collection 'C_LAATC_LA_S01_2'NEWLIB
And I click on filter link on Collection details for collection 'C_LAATC_LA_S01_2'NEWLIB
Then I should see following 'MediaType' filter state for 'C_LAATC_LA_S01_2' collectionNEWLIB:
| Filter     | State |
| IMAGE      | off   |
| VIDEO      | on    |
| AUDIO      | off   |
| DOCUMENT   | off   |
| DIGITAL    | off   |
| PRINT      | off   |
| OTHER      | off   |


Scenario: Check that assets can be added to a new Collection by selecting items from Library List on fly
Meta:@gdam
@library
Given I created users with following fields:
| Email           | Role        | Access            |
| U_LAATC_LA_S03 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAATC_LA_S03'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
When I go to  Library page for collection 'Everything'NEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
And I select all assets for collection 'Everything' on the library pageNEWLIB
And I add assets to 'new' collection 'C_LAATC_LA_S01_3' from collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'Fish1-Ad.mov,test.mp3,test.ogg' in the collection 'C_LAATC_LA_S01_3'NEWLIB
When I click on filter link on Collection details for collection 'C_LAATC_LA_S01_3'NEWLIB
Then I should see following 'MediaType' filter state for 'C_LAATC_LA_S01_3' collectionNEWLIB:
| Filter  | State |
| IMAGE   | off   |
| VIDEO   | off   |
| AUDIO   | off   |
| DOCUMENT| off   |
| DIGITAL | off   |
| PRINT   | off   |
| OTHER   | off   |


Scenario: Check that a new collection can be created under BU which is shared a category
Meta:@gdam
@library
Given I created the agency 'A_ACTA_S05_1' with default attributes
And created the agency 'A_ACTA_S05_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access         |
| U_ACTA_S05_1 | agency.admin | A_ACTA_S05_1 | streamlined_library  |
| U_ACTA_S05_2 | agency.admin | A_ACTA_S05_2 | streamlined_library  |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_ACTA_S05_2' to agency 'A_ACTA_S05_1' on partners page
And logged in with details of 'U_ACTA_S05_1'
And created following categories:
| Name       |
| С_ACTA_S05 |
And uploaded following assetsNEWLIB:
| Name                   |
| /files/atCalcImage.jpg |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| С_ACTA_S05     | U_ACTA_S05_2  | library.admin  |
And logged in with details of 'U_ACTA_S05_2'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov'NEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And I refresh the page
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add asset to 'new' collection 'C_LAATC_LA_S01_1' from collection 'Everything' under Agency 'A_ACTA_S05_1'NEWLIB
And I search the collection 'C_LAATC_LA_S01_1' on collections page
And I click the collection 'C_LAATC_LA_S01_1' on collections page
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection page
When I search the collection 'С_ACTA_S05' on collections page
And I click the collection 'С_ACTA_S05' on collections page
Then I 'should not' see assets with titles 'Fish Ad.mov' in the collection page

Scenario: Check that BU being shared the category is listed in the new collection popup for Everything
Meta:@gdam
@library
Given I created the agency 'A_ACTA_S05_1' with default attributes
And created the agency 'A_ACTA_S05_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access               |
| U_ACTA_S05_1 | agency.admin | A_ACTA_S05_1 | streamlined_library  |
| U_ACTA_S05_2 | agency.admin | A_ACTA_S05_2 | streamlined_library  |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_ACTA_S05_2' to agency 'A_ACTA_S05_1' on partners page
And logged in with details of 'U_ACTA_S05_1'
And created following categories:
| Name       |
| С_ACTA_S05 |
And uploaded following assetsNEWLIB:
| Name                   |
| /files/atCalcImage.jpg |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| С_ACTA_S05     | U_ACTA_S05_2  | library.admin  |
And logged in with details of 'U_ACTA_S05_2'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And I select asset 'Fish Ad.mov' in the 'Everything' library pageNEWLIB
And click on add 'new' collection on 'Everything'NEWLIB
Then I 'should' see below agencies in the location dropdown for 'new' collection:
|Agency      |
|A_ACTA_S05_1|
|A_ACTA_S05_2|
|My Collections |


Scenario: Check that sub collection can be created from a newly created collection
Meta:@gdam
@library
Given I created the agency 'A_ACTA_S010_1' with default attributes
And created the agency 'A_ACTA_S010_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |  Access             |
| U_ACTA_S010_1 | agency.admin | A_ACTA_S010_1 |streamlined_library  |
| U_ACTA_S010_2 | agency.admin | A_ACTA_S010_2 |streamlined_library  |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_ACTA_S010_2' to agency 'A_ACTA_S010_1' on partners page
And logged in with details of 'U_ACTA_S010_1'
And created following categories:
| Name       |
| С_ACTA_S05 |
And uploaded following assetsNEWLIB:
| Name                   |
| /files/Fish Ad.mov     |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name              | SubType            |
| Fish Ad.mov       | Generic Master             |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| С_ACTA_S05     | U_ACTA_S010_2  | library.admin  |
And logged in with details of 'U_ACTA_S010_2'
When I go to the collections page
And I search the collection 'С_ACTA_S05' on collections page
And I click the collection 'С_ACTA_S05' on collections page
And click on filter link on Collection page
And switch 'on' media type filter 'VIDEO' on filter page
And add media subtype as filter collection:
| value               |
|Generic Master       |
And I add assets to 'sub' collection 'С_ACTA_S06' from collection 'C_FAS_S01_5'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'С_ACTA_S06'NEWLIB
And 'should not' see assets with titles 'atCalcImage.jpg' in the collection 'С_ACTA_S06'NEWLIB


Scenario: Check that asset will be added to collection even if collection filters differs
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Access              |
| U_LAATC_S07 | agency.admin |streamlined_library  |
And logged in with details of 'U_LAATC_S07'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And created following collectionsNEWLIB:
| Name          | MediaType |
| C_LAATC_S07_1 | print     |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I select asset 'Fish Ad.mov' in the 'My Assets'  collection pageNEWLIB
And copy to 'C_LAATC_S07_1'  from 'My Assets' library page
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S07_1'NEWLIB

Scenario: Check that when you click cancel in  new collection popup then assets are not added to the Collection
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Access              |
| U_CNCP_S01 | agency.admin |streamlined_library  |
And logged in with details of 'U_CNCP_S01'
And uploaded file '/files/GWGTest2.pdf' into my libraryNEWLIB
When I go to the Library page for collection 'Everything'NEWLIB
Then I 'should not' see create 'new' button on 'Everything' page
When I select asset 'GWGTest2.pdf' in the 'Everything'  library pageNEWLIB
And wait for '2' seconds
Then I 'should' see create 'new' button on 'Everything' page
And I 'should' see option 'Using selected items' button on 'Everything' page
And I 'should not' see option 'Using filters' button on 'Everything' page
When cancel assets to 'new' collection 'C_CNCP_S01' from collection 'Everything'NEWLIB
And I go to the collections page
And I search the collection 'C_CNCP_S01' on collections page
Then I 'should not' see on the library page collections 'C_CNCP_S01'NEWLIB


Scenario: check Asset should appear under collection with same Campaign
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| U_LAATC_S08 | agency.admin |streamlined_library|
And logged in with details of 'U_LAATC_S08'
And I uploaded following assetsNEWLIB:
| Name                     |
| /files/128_shortname.jpg |
| /files/logo3.jpg         |
And waited while preview is available in collection 'Everything'NEWLIB
And I am on the library pageNEWLIB
When I click on filter link for collection 'Everything'
And enter value 'LAACC1' for campaign in the collection 'Everything'NEWLIB
And I add assets to 'new' collection 'C_LAATC_S08_1' from collection 'Everything'NEWLIB
Then I 'should not' see assets '128_shortname.jpg' in the collection 'C_LAATC_S08_1'NEWLIB
When I patch following file info for next assets from collection 'Everything':
| Name                |  Campaign  |
| 128_shortname.jpg   |  LAACC1    |
And I patch following file info for next assets from collection 'Everything':
| Name       | Campaign  |
| logo3.jpg  | LAACC2    |
And go to the Library page for collection 'C_LAATC_S08_1'NEWLIB
And I refresh the page
Then I 'should' see assets '128_shortname.jpg' in the collection 'C_LAATC_S08_1'NEWLIB
And I 'should not' see assets 'logo3.jpg' in the collection 'C_LAATC_S08_1'NEWLIB

