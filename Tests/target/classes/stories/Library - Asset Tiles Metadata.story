Feature:          Asset Tiles Metadata
Narrative:
In order to
As a              AgencyAdmin
I want to         check asset tiles metadata

Lifecycle:
Before:
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand   | Product    |
| ATM_AR     | ATM_BR     | ATM_SB      | ATM_PR     |


Scenario: Check that asset tiles metadata are displayed for asset type(audio,print,image)
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| <UserName> | agency.admin |streamlined_library,library|
And logged in with details of '<UserName>'
And uploaded file '<Upload_FileName>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to View Asset Management Settings page
And I set maximum number of fields '5 '
And I go to the '<AssetType>' asset view page
And I fill  following fields with orders  on View Asset page:
| FieldName     | FieldValue |
|Advertiser     |   1        |
|Title          |            |
|Title          |   2        |
|Product        |   3        |
|Sub Brand      |   4        |
|Media type     |   5        |
And wait for '5' seconds
And go to the Library page for collection 'Everything'NEWLIB
And I refresh the page
And I go to asset '<AssetName>' info page in Library for collection 'Everything'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
| Advertiser   | ATM_AR   |
| Brand        | ATM_BR   |
| Sub Brand    | ATM_SB   |
| Product      | ATM_PR   |
And go to the Library page for collection 'Everything'NEWLIB
And wait for '2' seconds
Then I 'should' see following metadata in tiles for asset '<AssetName>' in collection 'Everything'NEWLIB:
| FieldName       | FieldValue       |
|Advertiser       |   ATM_AR          |
|Title            |   <AssetName>    |
|Product          |   ATM_PR         |
|Sub Brand        |   ATM_SB         |
Examples:
|UserName   |Upload_FileName          |AssetName         |AssetType|
|ATM_U01    |/files/GWGTest2.pdf      |GWGTest2.pdf      |print    |
|ATM_U02    |/files/audio01.mp3       |audio01.mp3       |audio    |
|ATM_U03    |/files/128_shortname.jpg |128_shortname.jpg |image    |

Scenario: Check that asset tiles metadata are displayed for asset type(video)
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| ATM_U04 | agency.admin |streamlined_library,library|
And logged in with details of 'ATM_U04'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to View Asset Management Settings page
And I set maximum number of fields '5 '
And I go to the 'Video' asset view page
And I fill  following fields with orders  on View Asset page:
| FieldName     | FieldValue |
|Advertiser     |   1        |
|Title          |   2        |
|Product        |   3        |
|Sub Brand      |   4        |
|Media type     |   5        |
|Clock number   |            |
|ID             |            |
And I go to asset 'Fish Ad.mov' info page in Library for collection 'Everything'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue  |
| Advertiser   | ATM_AR      |
| Brand        | ATM_BR      |
| Sub Brand    | ATM_SB      |
| Product      | ATM_PR      |
|Clock number  | ATM_Clk_CN1 |
And go to the Library page for collection 'Everything'NEWLIB
And wait for '2' seconds
Then I 'should' see following metadata in tiles for asset 'Fish Ad.mov' in collection 'Everything'NEWLIB:
| FieldName     | FieldValue        |
|Advertiser     |   ATM_AR           |
|Title          |   Fish Ad.mov     |
|Product        |   ATM_PR          |
|Sub Brand      |   ATM_SB          |





