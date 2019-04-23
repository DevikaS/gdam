!--NGN-3041
Feature:          Categories - advanced search - check sub-media types
Narrative:
In order to
As a              AgencyAdmin
I want to         check advanced search in categories

Scenario: Check that filter saving with sub-media types for categories
Meta:@gdam
     @library
Given I created the agency 'A_CASCSMT_S01' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |
| U_CASCSMT_S01 | agency.admin | A_CASCSMT_S01 |
And logged in with details of 'U_CASCSMT_S01'
And created following categories:
| Name           |
| <CategoryName> |
And I am on administration area collections page
And selected category '<CategoryName>'
When switch 'on' media type filter '<CategoryMediaType>' on administration area collections page
And I select media subtype '<CategoryMediaSubType>' for current category
And I click save button for metadata of current category
And refresh the page
Then I 'should' see media subtype '<CategoryMediaSubType>' for current category

Examples:
| CategoryName    | CategoryMediaType | CategoryMediaSubType |
| C_CASCSMT_S01_1 | image             | Print                |
| C_CASCSMT_S01_2 | audio             | Cinema               |
| C_CASCSMT_S01_3 | video             | Generic Master       |
| C_CASCSMT_S01_4 | digital           | Web Page             |
| C_CASCSMT_S01_5 | document          | Agenda               |



Scenario: Check that assets appear in categories after filter saving with sub-media types
Meta:@gdam
     @library
Given I created the agency 'A_CASCSMT_S02' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CASCSMT_S02 | agency.admin | A_CASCSMT_S02 |streamlined_library,library|
And logged in with details of 'U_CASCSMT_S02'
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
And created following categories:
| Name           | MediaType           | MediaSubType           |
| <CategoryName> | <CategoryMediaType> | <CategoryMediaSubType> |
When I go to library page for collection '<CategoryName>'NEWLIB
Then I 'should' see assets '<AssetName>' in the collection '<CategoryName>'NEWLIB
And I 'should' see asset count '1' in '<CategoryName>' NEWLIB

Examples:
| CategoryName    | CategoryMediaType | CategoryMediaSubType | AssetName    |
| C_CASCSMT_S02_1 | image             | Print                | logo.jpg     |
| C_CASCSMT_S02_2 | audio             | Cinema               | audio01.mp3  |
| C_CASCSMT_S02_3 | video             | Generic Master       | Fish1-Ad.mov |
| C_CASCSMT_S02_4 | digital           | Web Page             | index1.html  |
| C_CASCSMT_S02_5 | document          | Agenda               | at01.odt     |