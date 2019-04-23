Feature:          Library - Asset Navigation
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Asset Navigation on Preview page

Lifecycle:
Before:
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    |
| TAFAR2     | TAFBR2     | TAFSB2     | TAFSP2    |
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |

Scenario: check that cancel works for Asset Edit
Meta:@gdam
@bug
@library
!--UIR-1069
Given I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And I refresh the page
And 'save' asset 'Fish1-Ad.mov' info of collection 'Everything' by following informationNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR1                           |
| Category                    | Food                             |
| Clock number                | testcn                           |
| Sub Category                | Meat and Fish                    |
| Air Date                    | 12/12/15                       |
| Shoot Dates                 | 12/12/15                       |
| Country                     | Austria                          |
| Duration                    | 6s 33ms                          |
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And wait for '4' seconds
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Country                     | Austria                          |
| Clock number                | testcn                           |
When 'cancel' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
|Advertiser                   | TAFAR2                           |
| Category                    | Home                             |
| Clock number                | testcng                          |
| Sub Category                | Laundry                          |
| Air Date                    | 11/12/15                       |
| Shoot Dates                 | 11/12/15                       |
| Country                     | Australia                        |
| Duration                    | 6s 32ms                          |
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Country                     | Austria                          |
| Clock number                | testcn                           |

Scenario: Check that Multi Asset Select shows Expanded Common Metadata and Collapsed Metadata for all Assets Selected
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access            |
| U_MASM_S01 | agency.admin | streamlined_library  |
And logged in with details of 'U_MASM_S01'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov                           |
| /files/index.html                            |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav |
| /files/test.ogg                              |
| /files/test.mp3                              |
| /files/video10s.avi                          |
| /files/GWGTestfile064v3.pdf                  |
| /files/CCITT_1.TIF                           |
| /files/ISO_12233-reschart.svg                |
| /images/logo.bmp                             |
| /images/logo.png                             |
| /images/logo.jpeg                            |
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And select all assets for collection 'Everything' on the library pageNEWLIB
And I go to edit Asset Metadata page on 'Everything' collection
Then I 'should' see 'Video,Audio,Print,Image,Digital,Common' metadata sections
And 'should not' see 'Video,Audio,Print,Image,Digital' metadata section expanded
And 'should' see 'Common' metadata section expanded

Scenario: check that when you multiselect Assets and go to Edit Asset page then Edit One by One title is displayed and you can edit and navigate through the Asset
Meta:@gdam
@library
Given I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And select all assets for collection 'Everything' on the library pageNEWLIB
And I go to edit Asset Metadata page on 'Everything' collection
Then 'should' see 'EDIT ONE BY ONE' message
When I click 'EDIT ONE BY ONE' message
Then 'should' see 'EDIT ALL' message on single edit Asset page
When I click 'EDIT ALL' message on single edit Asset page
Then 'should' see 'EDIT ONE BY ONE' message
And 'should' see 'test.mp3,Fish1-Ad.mov,test.ogg' on edit Asset Metadata page

Scenario: check that you can delete Asset from Asset Preview page
Meta:@gdam
@library
Given I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And select all assets for collection 'Everything' on the library pageNEWLIB
And I delete 'test.ogg' on 'Everything' edit Asset Metadata page
Then 'should' see 'test.mp3,Fish1-Ad.mov' on edit Asset Metadata page

Scenario: check that you can edit assets together and the fields will be reflected accordingly
Meta:@gdam
@bug
@library
!--UIR-1069
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And select all assets for collection 'Everything' on the library pageNEWLIB
And wait for '2' seconds
And 'save' metadata for 'test.ogg'  on 'Everything'  edit Asset Metadata page:
| FieldName                   | FieldValue                       | SectionName      |
| Advertiser                  | TAFAR1                           | common           |
| Clock number                | testcn                           | Video            |
| Brand                       | TAFBR1                           | common           |
| Air Date                    | 12/12/2015                       | Video            |
| Category                    | Food                             | Audio            |
| Duration                    | 6s 33ms                          | Audio            |
| Sub Category                | Meat and Fish                    | Audio            |
| Sub Brand                   | TAFSB1                           | common           |
| Shoot Dates                 | 12/12/2015                       | Video            |
| Product                     | TAFSP1                           | common           |
| Category                    | Home                             | Video            |
| Country                     | Austria                          | Video            |
| Sub Category                | Laundry                          | Video            |
| Screen                      | Spot                             | Video            |
| Approved For Broadcast      | No                               | Video            |
| Duration                    | 6s 33ms                          | Video            |
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Category                    | Home                             |
| Advertiser                  | TAFAR1                           |
| Brand                       | TAFBR1                           |
| Sub Brand                   | TAFSB1                           |
| Product                     | TAFSP1                           |
| Sub Category                | Laundry                          |
| Country                     | Austria                          |
| Clock number                | testcn                           |
| Screen                      | Spot                             |
When I go to asset 'test.ogg' info page in Library for collection 'Everything'NEWLIB
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Category                    | Food                             |
| Advertiser                  | TAFAR1                           |
| Sub Category                | Meat and Fish                    |
| Brand                       | TAFBR1                           |
| Sub Brand                   | TAFSB1                           |
| Product                     | TAFSP1                           |
When I go to asset 'test.mp3' info page in Library for collection 'Everything'NEWLIB
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Advertiser                  | TAFAR1                           |
| Brand                       | TAFBR1                           |
| Sub Brand                   | TAFSB1                           |
| Product                     | TAFSP1                           |


Scenario: check that you can navigate to the next Asset on Asset Preview page
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And select all assets for collection 'Everything' on the library pageNEWLIB
And I go to asset 'Fish1-Ad.mov' page in Library for collection 'Everything'NEWLIB
Then 'should' see 'Fish1-Ad.mov' on asset preview page
When I navigate to asset with title 'test.mp3' on preview pageNEWLIB
Then 'should' see 'test.mp3' on asset preview page
When I navigate to asset with title 'Fish1-Ad.mov' on preview pageNEWLIB
Then 'should' see 'Fish1-Ad.mov' on asset preview page

