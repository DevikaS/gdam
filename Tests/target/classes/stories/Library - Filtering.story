!--NGN-1056 NGN-4246
Feature:          Library - Filtering
Narrative:
In order to
As a              AgencyAdmin
I want to         Check filter in folders on library view


Scenario: Check filter by 'Other' media type in Library
Meta:@gdam
@library
Given uploaded following assetsNEWLIB:
| Name                    |
| /files/example.rar      |
| /files/logo3.png        |
| /files/file_1.unknown   |
| /files/Fish Ad.mov      |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'example.rar,logo3.png,file_1.unknown,Fish Ad.mov'NEWLIB
When I switch 'on' media type filter 'other' for collection 'Everything' on the page LibraryNEWLIB
Then I 'should' see assets 'example.rar,file_1.unknown' in the collection 'Everything'NEWLIB


Scenario: check all assets are appear in library when all filters 'off'
Meta:@gdam
@library
Given I created 'P_LFS_S1_1' project
And I created '/F_LFS_S1_1' folder for project 'P_LFS_S1_1'
And I uploaded into project 'P_LFS_S1_1' following files:
| FileName                   | Path        |
| /files/Fish1-Ad.mov         | /F_LFS_S1_1 |
| /files/test.mp3            | /F_LFS_S1_1 |
| /files/128_shortname.jpg   | /F_LFS_S1_1 |
| /files/video10s.avi        | /F_LFS_S1_1 |
And I am on project 'P_LFS_S1_1' folder '/F_LFS_S1_1' page
And waited while transcoding is finished in folder '/F_LFS_S1_1' on project 'P_LFS_S1_1' files page
When I move following files into library:
| ProjectName | Path        | FileName            | SubType |
| P_LFS_S1_1  | /F_LFS_S1_1 | Fish1-Ad.mov        |         |
| P_LFS_S1_1  | /F_LFS_S1_1 | test.mp3            |         |
| P_LFS_S1_1  | /F_LFS_S1_1 | 128_shortname.jpg   |         |
| P_LFS_S1_1  | /F_LFS_S1_1 | video10s.avi        |         |
And I go to  Library page for collection 'My Assets'NEWLIB
And I refresh the page
Then I 'should' see assets 'Fish1-Ad.mov,test.mp3,128_shortname.jpg,video10s.avi' in the collection 'My Assets'NEWLIB


Scenario: check that filters 'off' when user change category for Media Type
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov |
| /files/test.mp3            |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And I switched 'on' media type filter 'VIDEO,AUDIO,PRINT,IMAGE,DIGITAL,DOCUMENT,OTHER' for collection 'Everything' on the page LibraryNEWLIB
When I go to the library page for collection 'My Assets'NEWLIB
Then I 'should' see assets 'test.ogg,test.mp3,Fish1-Ad.mov' in the collection 'My Assets'NEWLIB
When I click on filter link on Collection details for collection 'My Assets'NEWLIB
Then I should see following 'MediaType' filter state for  'My Assets' collectionNEWLIB:
| Filter  | State |
| IMAGE   | off   |
| VIDEO   | off   |
| AUDIO   | off   |
| DOCUMENT    | off   |
| DIGITAL | off   |
| PRINT   | off   |

Scenario: Check that specified filters aren't saved after reopening collection
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov |
| /files/test.mp3            |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I switch 'on' media type filter 'VIDEO,AUDIO,PRINT,DIGITAL,DOCUMENT,OTHER' for collection 'Everything' on the page LibraryNEWLIB
And go to the library page for collection 'Everything'NEWLIB
And wait for '2' seconds
Then I 'should' see assets 'test.ogg,test.mp3,Fish1-Ad.mov' in the collection 'Everything'NEWLIB
When I go to the collections page
And I go to the Library page for collection 'Everything'NEWLIB
And I click on filter link for collection 'Everything'
And I wait for '2' seconds
Then I 'should' see filters 'IMAGE,VIDEO,AUDIO,DOCUMENT,DIGITAL,PRINT,OTHER' in state 'off' for 'Everything' collectionNEWLIB


Scenario: Check that category displayed in Library with the same filters as it was created
Meta:@gdam
@library
Given I created following categories:
| Name           |
| <CategoryName> |
And I am on collection '<CategoryName>' on administration area collections page
And switched 'on' media type filter '<Filter>' on administration area collections page
And clicked element 'SaveButton' on page 'AssetCategory'
When I go to the library page for collection '<CategoryName>'NEWLIB
And I click on filter link on Collection details for collection '<CategoryName>'NEWLIB
Then I 'should' see filters '<Filter>' in state 'on' for '<CategoryName>' collectionNEWLIB

Examples:
| CategoryName | Filter            |
| C_LF_S07_2   | audio,video       |
| C_LF_S07_3   | video,print       |
| C_LF_S07_5   | digital,document  |
| C_LF_S07_6   | document,other    |
| C_LF_S07_7   | digital,other     |


Scenario: Check that for selected collection filters are displayed in the same way as it was created
Meta:@gdam
@library
Given I am on the library page for collection 'My Assets'NEWLIB
And I have refreshed the page
When I switch 'on' media type filter '<Filter>' for collection 'My Assets' on the page LibraryNEWLIB
And I add assets to 'sub' collection '<CollectionName>' from collection 'My Assets'NEWLIB
When I go to the library page for collection '<CollectionName>'NEWLIB
When I click on filter link for collection '<CollectionName>'
And I wait for '2' seconds
Then I 'should' see filters '<Filter>' in state 'on' for '<CollectionName>' collectionNEWLIB

Examples:
| CollectionName | Filter            |
| C_LF_S08_1     | image             |
| C_LF_S08_2     | document             |
| C_LF_S08_3     | audio,video            |


Scenario: Check filter by 'Other' media type in Library
Meta:@gdam
@library
Given uploaded following assetsNEWLIB:
| Name                    |
| /files/example.rar      |
| /files/logo3.png        |
| /files/file_1.unknown   |
| /files/Fish Ad.mov      |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I switch 'on' media type filter 'other' for collection 'Everything' on the page LibraryNEWLIB
Then I 'should' see assets 'example.rar,file_1.unknown' in the collection 'Everything'NEWLIB


Scenario: check that Assets can be filtered using Campaign and after clearing filter Assets are updated accordingly
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name           |  Campaign  |
| Fish1-Ad.mov   |  TAFAC1    |
When I click on filter link for collection 'Everything'
And enter value 'TAFAC1' for campaign in the collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB
And 'should not' see assets 'test.ogg' in the collection 'Everything'NEWLIB
When I clear the filter 'Campaign' with value 'TAFAC1' on 'Everything' page
Then I 'should' see assets 'test.ogg,Fish1-Ad.mov' in the collection 'Everything'NEWLIB
And I should see following 'Campaign' filter state for 'Everything' collectionNEWLIB:
|Filter          |
|                |

Scenario: check that Assets can be filtered by Advertiser and filter can be cleared and Asset list updated accordingly
Meta:@gdam
@library
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    |
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name       | Advertiser  |
| test.ogg   | TAFAR1      |
When I click on filter link for collection 'Everything'
And select 'Advertiser' with value 'TAFAR1' in the collection 'Everything'NEWLIB
Then I 'should' see assets 'test.ogg' in the collection 'Everything'NEWLIB
And 'should not' see assets 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB
When I clear the filter 'Advertiser' with value 'TAFAR1' on 'Everything' page
And wait for '2' seconds
Then I 'should' see assets 'test.ogg,Fish1-Ad.mov' in the collection 'Everything'NEWLIB
And I should see following 'Advertiser' filter state for 'Everything' collectionNEWLIB:
|Filter          | State    |
| TAFAR1        | off      |


Scenario: check that All Assets are selected when user clicks Select All and delected when clicked Uncheck All
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role          | Access   |
| U_LAASAL_S01 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAASAL_S01'
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov |
| /files/test.mp3            |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
When select all assets for collection 'Everything' on the library pageNEWLIB
Then I 'should' see assets 'Fish1-Ad.mov,test.mp3,test.ogg' selected in 'Everything'
When deselect all assets for collection 'Everything' on the library pageNEWLIB
Then I 'should not' see assets 'Fish1-Ad.mov,test.mp3,test.ogg' selected in 'Everything'

Scenario: check that Media Type filter can be cleared and assets and filters shown accordingly
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov |
| /files/test.mp3            |
| /files/test.ogg            |
|/images/logo.bmp            |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish1-Ad.mov,test.mp3,test.ogg,logo.bmp'NEWLIB
And I switched 'on' media type filter 'VIDEO,AUDIO,PRINT,IMAGE,DIGITAL,DOCUMENT,OTHER' for collection 'Everything' on the page LibraryNEWLIB
Then I 'should' see assets 'test.ogg,test.mp3,Fish1-Ad.mov,logo.bmp' in the collection 'Everything'NEWLIB
When I clear the filter 'MediaType' with value 'VIDEO,AUDIO' on 'Everything' page
Then I 'should' see assets 'logo.bmp' in the collection 'Everything'NEWLIB
And I 'should not' see assets 'Fish1-Ad.mov,test.mp3,test.ogg' in the collection 'Everything'NEWLIB
And I should see following 'MediaType' filter state for  'Everything' collectionNEWLIB:
| Filter  | State |
| IMAGE   | on   |
| VIDEO   | off   |
| AUDIO   | off   |
| DOCUMENT    | on   |
| DIGITAL | on   |
| PRINT   | on   |


Scenario: Check that  Business Units and Originators filter can be cleared and assets and filters updated accordingly
Meta:@gdam
@library
Given I created the agency 'A_FBU_S01_3' with default attributes
And created the agency 'A_FBU_S01_4' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access |
| U_A_FBU_S01_3 | agency.admin | A_FBU_S01_3  | streamlined_library  |
| U_A_FBU_S01_4 | agency.admin | A_FBU_S01_4  | streamlined_library  |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_FBU_S01_3' to agency 'A_FBU_S01_4' on partners page
And logged in with details of 'U_A_FBU_S01_3'
And created following categories:
| Name       |
| С_FBU_S03  |
And uploaded following assetsNEWLIB:
| Name                   |
| /files/atCalcImage.jpg |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| С_FBU_S03      | U_A_FBU_S01_4         | library.admin  |
And logged in with details of 'U_A_FBU_S01_4'
And uploaded following assetsNEWLIB:
| Name                   |
| /files/Fish Ad.mov     |
When I go to the Library pageNEWLIB
And I click on filter link for collection 'Everything'
And select '<section>' with value '<Field>' in the collection 'Everything'NEWLIB
Then I 'should' see assets '<Assets>' in the collection 'Everything'NEWLIB
And 'should not' see assets '<AssetsExclude>' in the collection 'Everything'NEWLIB
When I clear the filter '<section>' with value '<Field>' on 'Everything' page
Then I 'should' see assets '<Assets>' in the collection 'Everything'NEWLIB
And 'should' see assets '<AssetsExclude>' in the collection 'Everything'NEWLIB
And I should see following '<section>' filter state for 'Everything' collectionNEWLIB:
|Filter          | State    |
| <Field>        | off      |

Examples:
|section       | Field                          | Assets            | AssetsExclude       |
|Originator    | A_FBU_S01_4                    |  Fish Ad.mov     |   atCalcImage.jpg    |
|Business Unit | A_FBU_S01_4                    | Fish Ad.mov      |   atCalcImage.jpg   |


Scenario: check that Assets can be filtered by Market and filter can be cleared and Asset list updated accordingly
Meta:@gdam
@library
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    |
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name       | Market  |
| Fish1-Ad.mov   | United Kingdom      |
When I click on filter link for collection 'Everything'
And select 'Market' with value 'United Kingdom' in the collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB
And 'should not' see assets 'test.ogg' in the collection 'Everything'NEWLIB
When I clear the filter 'Market' with value 'United Kingdom' on 'Everything' page
And wait for '2' seconds
Then I 'should' see assets 'test.ogg,Fish1-Ad.mov' in the collection 'Everything'NEWLIB
And I should see following 'Market' filter state for 'Everything' collectionNEWLIB:
|Filter                 | State    |
| United Kingdom        | off      |

Scenario: check that filters set in parents are disabled in child collections when navigate from parent to child
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
|/images/logo.bmp            |
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name           |  Campaign  |
| Fish1-Ad.mov   |  TAFAC1    |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish1-Ad.mov,test.mp3,test.ogg,logo.bmp'NEWLIB
When I switch 'on' media type filter 'VIDEO,AUDIO,PRINT,IMAGE,DIGITAL,DOCUMENT,OTHER' for collection 'Everything' on the page LibraryNEWLIB
And wait for '2' seconds
And I add assets to 'new' collection 'C_FANC_LA_S01_1' from collection 'Everything'NEWLIB
Then I 'should' see collection  'Collections>My Collections>C_FANC_LA_S01_1' in breadcrum on collections details pageNEWLIB
When I click on filter link on Collection details for collection 'C_FANC_LA_S01_1'NEWLIB
When enter value 'TAFAC1' for campaign in Filter for Collection 'C_FANC_LA_S01_1'
And I add assets to 'sub' collection 'C_FANC_LA_S01_2' from collection 'C_FANC_LA_S01_1'NEWLIB
Then I 'should' see collection  'Collections>...>C_FANC_LA_S01_1>C_FANC_LA_S01_2' in breadcrum on collections details pageNEWLIB
When I navigate to 'C_FANC_LA_S01_1' on collections details page
And wait for '2' seconds
And I click on filter link on Collection details for collection 'C_FANC_LA_S01_1'NEWLIB
Then I should see following 'MediaType' filter state for  'C_FANC_LA_S01_1' collectionNEWLIB:
| Filter    | State |disabled |
| IMAGE     | on   | no       |
| VIDEO     | on   | no       |
| AUDIO     | on   | no       |
| DOCUMENT  | on   | no       |
| DIGITAL   | on   | no       |
| PRINT     | on   | no       |
When I navigate to 'C_FANC_LA_S01_2' on collections details page
And wait for '2' seconds
And I click on filter link on Collection details for collection 'C_FANC_LA_S01_2'NEWLIB
Then I should see following 'MediaType' filter state for  'C_FANC_LA_S01_2' collectionNEWLIB:
| Filter    | disabled |
| IMAGE     | yes   |
| VIDEO     | yes   |
| AUDIO     | yes   |
| DOCUMENT  | yes   |
| DIGITAL   | yes   |
| PRINT     | yes   |


Scenario: check that filters set in collections can be saved and are retained when you go to that collection
Meta:@gdam
@library
!--QA-1026
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
|/images/logo.bmp            |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish1-Ad.mov,test.mp3,test.ogg,logo.bmp'NEWLIB
When I switch 'on' media type filter 'VIDEO,AUDIO,PRINT,IMAGE,DIGITAL,DOCUMENT,OTHER' for collection 'Everything' on the page LibraryNEWLIB
And wait for '2' seconds
And I add assets to 'new' collection 'C_FAS_S01_1' from collection 'Everything'NEWLIB
And I click on filter link on Collection details for collection 'C_FAS_S01_1'NEWLIB
And I switch 'off' media type filter 'AUDIO,PRINT,IMAGE' on filter page
And I click on save changes on collection 'C_FAS_S01_1' page
And I go to the collections page
And I search the collection 'C_FAS_S01_1' on collections page
And I click the collection 'C_FAS_S01_1' on collections page
And click on filter link on Collection page
Then I should see following 'MediaType' filter state for  'C_FAS_S01_1' collectionNEWLIB:
| Filter  | State |
| IMAGE   | off    |
| VIDEO   | on    |
| AUDIO   | off    |
| DOCUMENT| on    |
| DIGITAL | on    |
| PRINT   | off    |
| OTHER   | on    |


Scenario: check that you get a warning on saving filters changes for a parent collection
Meta:@gdam
@library
!--QA-1026
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/Fish2-Ad.mov        |
|/files/test.ogg            |
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name       | Advertiser  |
| Fish1-Ad.mov   | TAFAR1      |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish1-Ad.mov,test.mp3,test.ogg,Fish2-Ad.mov'NEWLIB
When I switch 'on' media type filter 'VIDEO' for collection 'Everything' on the page LibraryNEWLIB
And wait for '2' seconds
And I add assets to 'new' collection 'C_FAS_S01_2' from collection 'Everything'NEWLIB
And I click on filter link on Collection details for collection 'C_FAS_S01_2'NEWLIB
And I select 'Advertiser' with value 'TAFAR1' as filter collection 'C_FAS_S01_2'NEWLIB
And I add assets to 'sub' collection 'C_FAS_S01_3' from collection 'C_FAS_S01_2'NEWLIB
And wait for '2' seconds
And I go to the collections page
And I search the collection 'C_FAS_S01_2' on collections page
And I click the collection 'C_FAS_S01_2' on collections page
And click on filter link on Collection page
And I switch 'on' media type filter 'AUDIO' on filter page
And click on save changes on collection 'C_FAS_S01_2' page
Then I should see following 'MediaType' filter state for  'C_FAS_S01_2' collectionNEWLIB:
| Filter  | State |
| VIDEO   | on    |
| AUDIO   | on    |

Scenario: check that when you cancel the warning on saving filters changes for a parent collection then the filter is not saved
Meta:@gdam
@library
Given created users with following fields:
| Email                    | Role         |      Access         |
| LIBFIL_U1                | agency.admin |  streamlined_library|
And logged in with details of 'LIBFIL_U1'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
|/images/logo.bmp            |
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name       | Screen  |
| Fish1-Ad.mov   | Spot      |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish1-Ad.mov,test.mp3,test.ogg,logo.bmp'NEWLIB
When I switch 'on' media type filter 'VIDEO' for collection 'Everything' on the page LibraryNEWLIB
And wait for '2' seconds
And I add assets to 'new' collection 'C_FAS_S01_C4' from collection 'Everything'NEWLIB
And I click on filter link on Collection details for collection 'C_FAS_S01_C4'NEWLIB
And I click expand for 'VIDEO'
And add additional filter as filter collection:
|Additional Field  | value        |
| Screen           |Spot          |
And I add assets to 'sub' collection 'C_FAS_S01_C5' from collection 'C_FAS_S01_C4'NEWLIB
When I navigate to 'C_FAS_S01_C4' on collections details page
And wait for '2' seconds
And I switch 'on' media type filter 'AUDIO' for collection 'C_FAS_S01_C4' on the page LibraryNEWLIB
And wait for '1' seconds
And click on cancel button in save changes popup warning on collection 'C_FAS_S01_C4' page
And wait for '1' seconds
And I go to the collections page
And I search the collection 'C_FAS_S01_C4' on collections page
And I click the collection 'C_FAS_S01_C4' on collections page
And click on filter link on Collection page
And wait for '2' seconds
Then I should see following 'MediaType' filter state for  'C_FAS_S01_C4' collectionNEWLIB:
| Filter  | State |
| VIDEO   | on    |
| AUDIO   | off    |

Scenario: check that save change button in not visible in My Assets
Meta:@gdam
@library
!--Qa-1026
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
|/images/logo.bmp            |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov,test.mp3,test.ogg,logo.bmp'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
And I switch 'on' media type filter 'VIDEO' for collection 'My Assets' on the page LibraryNEWLIB
Then I 'should not' see save changes button



Scenario: Check that Match All words is checked by default and displays the correct results
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/Fish-Ad.mov        |
| /files/Fish-AdTests.mov        |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov,Fish-Ad.mov,Fish-AdTests.mov'NEWLIB
When go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
Then I 'should' see Match All Keywords checked by default on current filter pageNEWLIB
When I search by keyword 'Fish-Ad' on the current filter pageNEWLIB
Then I 'should' see assets 'Fish-Ad.mov' in the filter pageNEWLIB
And I 'should not' see assets 'Fish1-Ad.mov,Fish-AdTests.mov' in the filter pageNEWLIB

Scenario: Check that Match All Words results can be saved as part of collection and make sure keywords entered are retained in collection
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/Fish-Ad.mov        |
| /files/Fish-AdTests.mov        |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov,Fish-Ad.mov,Fish-AdTests.mov'NEWLIB
When go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
When I search by keyword 'Fish-Ad' on the current filter pageNEWLIB
Then I 'should' see assets 'Fish-Ad.mov' in the filter pageNEWLIB
And I 'should not' see assets 'Fish1-Ad.mov,Fish-AdTests.mov' in the filter pageNEWLIB
And I 'should' see the keyword 'Fish,Ad' accepted
And I wait for '2' seconds
When I add assets to 'sub' collection 'C_FAS_S091' from collection 'My Assets'NEWLIB
Then I 'should' see assets 'Fish-Ad.mov' in the collection 'C_FAS_S091'NEWLIB
And I 'should not' see assets 'Fish1-Ad.mov,Fish-AdTests.mov' in the collection 'C_FAS_S091'NEWLIB
When go to the Library page for collection 'C_FAS_S091'NEWLIB
And I click on filter link on Collection details for collection 'C_FAS_S091'NEWLIB
And I wait for '1' seconds
Then I 'should' see the keyword 'Fish,Ad' accepted


Scenario: Check that keywords and results are retained after navigating to asset info page
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/Fish-Ad.mov        |
| /files/Fish-AdTests.mov        |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov,Fish-Ad.mov,Fish-AdTests.mov'NEWLIB
When go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
When I search by keyword 'Fish-Ad' on the current filter pageNEWLIB
Then I 'should' see assets 'Fish-Ad.mov' in the filter pageNEWLIB
And I 'should not' see assets 'Fish1-Ad.mov,Fish-AdTests.mov' in the filter pageNEWLIB
When I click on asset 'Fish-Ad.mov' on the current filter pageNEWLIB
And I click back to library Button on asset info page
Then I 'should' see the keyword 'Fish,Ad' accepted
And I 'should' see assets 'Fish-Ad.mov' in the filter pageNEWLIB
And I 'should not' see assets 'Fish1-Ad.mov,Fish-AdTests.mov' in the filter pageNEWLIB

Scenario: Check that Match All words displays the correct results when it is unchecked
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/Fish-Ad.mov        |
| /files/Fish-AdTests.mov        |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov,Fish-Ad.mov,Fish-AdTests.mov'NEWLIB
When go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I 'uncheck' Match All Keywords on the current filter pageNEWLIB
And I search by keyword 'Fish-Ad' on the current filter pageNEWLIB
Then I 'should' see assets 'Fish-Ad.mov,Fish1-Ad.mov,Fish-AdTests.mov' in the filter pageNEWLIB

Scenario: Check that common filters has expander and BU field appears at top under common filters
Meta:@gdam
@library
Given logged in with details of 'AgencyAdmin'
When I go to the library page for collection 'Everything'NEWLIB
And I click on filter link for collection 'Everything'
Then I 'should' see common filters field with expander on filter page
And I 'should' see business unit field appears at top under common filters on filter page
When I go to the library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
Then I 'should' see common filters field with expander on filter page
And I 'should' see business unit field appears at top under common filters on filter page