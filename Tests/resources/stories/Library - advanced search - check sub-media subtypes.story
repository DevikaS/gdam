!--NGN-897
Feature:          Library - advanced search - check sub-media subtypes
Narrative:
In order to
As a              AgencyAdmin
I want to         Check library advanced search filters



Scenario: Check that filter saving with sub-media types for library
Meta:@gdam
@library
Given I created the agency 'A_LASCSMT_S01' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_LASCSMT_S01 | agency.admin | A_LASCSMT_S01 |streamlined_library|
And logged in with details of 'U_LASCSMT_S01'
When I go to library page for collection 'My Assets'NEWLIB
And I switch on media type filter '<CollectionMediaType>' from collection 'My Assets'NEWLIB
And I select mediaSubType '<CollectionMediaSubType>' of '<CollectionMediaType>' for collection 'My Assets' on the page LibraryNEWLIB
And I add assets to 'sub' collection '<CollectionName>' from collection 'My Assets'NEWLIB
And I go to library page for collection '<CollectionName>'NEWLIB
And I click on filter link on Collection details for collection '<CollectionName>'NEWLIB
Then I should see media sub type '<CollectionMediaSubType>' on current collection filter pageNEWLIB

Examples:
| CollectionName  | CollectionMediaType | CollectionMediaSubType |
| C_LASCSMT_S01_1 | VIDEO               | Elements               |
| C_LASCSMT_S01_2 | AUDIO               | Cinema                 |
| C_LASCSMT_S01_4 | DIGITAL             | Device                 |
| C_LASCSMT_S01_5 | DOCUMENT            | Copy                   |
| C_LASCSMT_S01_6 | IMAGE               | Print                  |


Scenario: Check that assets appear in collections after filter saving with sub-media types
Meta:@gdam
@library
Given I created the agency 'A_LASCSMT_S02' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_LASCSMT_S02 | agency.admin | A_LASCSMT_S02 |streamlined_library|
And logged in with details of 'U_LASCSMT_S02'
And uploaded following assetsNEWLIB:
| Name                |
| /images/logo.jpg    |
| /images/logo.png    |
| /images/logo.gif    |
| /files/audio01.mp3  |
| /files/audio02.mp3  |
| /files/audio03.mp3  |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
| /files/index1.html  |
| /files/index2.html  |
| /files/index3.html  |
| /files/at01.odt     |
| /files/at02.odt     |
| /files/at03.odt     |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name         | SubType        | ClockNumber |
| logo.jpg     | Print          |             |
| logo.png     | Titled master  |             |
| audio01.mp3  | Cinema         |             |
| audio02.mp3  | Elements       |             |
| Fish1-Ad.mov | Generic Master | testcn      |
| Fish2-Ad.mov | Cinema Master  | testcn      |
| index1.html  | Web Page       |             |
| index2.html  | Swf            |             |
| at01.odt     | Agenda         |             |
| at02.odt     | Concept        |             |
When I go to the library page for collection 'Everything'NEWLIB
And I switch on media type filter '<CollectionMediaType>' from collection 'Everything'NEWLIB
And I select mediaSubType '<CollectionMediaSubType>' of '<CollectionMediaType>' for collection 'Everything' on the page LibraryNEWLIB
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
And I go to library page for collection '<CollectionName>'NEWLIB
Then I 'should' see assets '<AssetName>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '1' in '<CollectionName>' NEWLIB

Examples:
| CollectionName  | CollectionMediaType | CollectionMediaSubType | AssetName    |
| C_LASCSMT_S02_1 | image               | Print                  | logo.jpg     |
| C_LASCSMT_S02_2 | audio               | Cinema                 | audio01.mp3  |
| C_LASCSMT_S02_3 | video               | Generic Master         | Fish1-Ad.mov |
| C_LASCSMT_S02_4 | digital             | Web Page               | index1.html  |
| C_LASCSMT_S02_5 | document            | Agenda                 | at01.odt     |