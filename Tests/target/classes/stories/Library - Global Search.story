
Feature:          Library - Global Search
Narrative:
In order to
As a              AgencyAdmin
I want to         Check the global search on library

Scenario: Check the library global search using default option global with match All words
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role         | Access            |
| U_LGS_S34 | agency.admin | streamlined_library    |
And logged in with details of 'U_LGS_S34'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish3-Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov,Fish-Ad.mov,Fish3-Ad.mov'NEWLIB
When I enter input 'Fish' on global search pageNEWLIB
Then I 'should' see assets 'Fish Ad.mov,Fish-Ad.mov' in the global search pageNEWLIB
Then I 'should not' see assets 'Fish3-Ad.mov' in the global search pageNEWLIB
When I enter input 'Fish*' on global search pageNEWLIB
Then I 'should' see assets 'Fish Ad.mov,Fish-Ad.mov,Fish3-Ad.mov' in the global search pageNEWLIB
When I enter input '-Ad' with following options on global search pageNEWLIB:
|Match All Words|
|check          |
Then I 'should' see assets 'Fish Ad.mov,Fish-Ad.mov,Fish3-Ad.mov' in the global search pageNEWLIB
When I click on view all in library link on global search pageNEWLIB
And I wait for '3' seconds
Then I 'should' see assets 'Fish Ad.mov,Fish-Ad.mov,Fish3-Ad.mov' on the library search results pageNEWLIB




Scenario: Check the library global search using title option
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded file '/files/logo2.png' into my libraryNEWLIB
And uploaded file '/files/logo1.gif' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'logo2.png,logo1.gif'NEWLIB
When I go to asset 'logo2.png' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
|Title  | Test1_t1 |
|Campaign  | Cam1 |
When I go to asset 'logo1.gif' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
|Title  | Test1_t2 |
|Campaign  | Cam1 |
When I enter input 'Test1' with following options on global search pageNEWLIB:
|Match All Words|Global Options|
|check          |title          |
Then I 'should' see assets 'Test1_t1,Test1_t2' in the global search pageNEWLIB

Scenario: Check the library global search using clock number option
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov,Fish1-Ad.mov'NEWLIB
When I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
|Clock number  | Clk1 |
|Campaign  | Cam1 |
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
|Clock number  | Clk1 |
|Campaign  | Cam1 |
When I enter input 'Clk1' with following options on global search pageNEWLIB:
|Match All Words|Global Options|
|check          |Clock number          |
Then I 'should' see assets 'Fish Ad.mov,Fish1-Ad.mov' in the global search pageNEWLIB

Scenario: Check the library global search using advertsier option
Meta:@gdam
@library
Given I created the agency 'LGS_A1' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'LGS_A1':
| Advertiser | Brand      | Sub Brand   | Product    |
| LGS_A1_A | LGS_A1_B | LGS_A1_SB | LGS_A1_P |
And created users with following fields:
| Email    | Role         | AgencyUnique | Access                |
| LGS_U1 | agency.admin | LGS_A1     | streamlined_library   |
When I login with details of 'LGS_U1'
And upload following assetsNEWLIB:
| Name             |
| /images/logo.gif |
| /images/logo.jpg |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to asset 'logo.gif' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Advertiser | LGS_A1_A |
| Campaign | Camp1 |
And go to asset 'logo.jpg' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Advertiser | LGS_A1_A |
| Campaign | Camp1 |
When I enter input 'LGS_A1_A' with following options on global search pageNEWLIB:
|Match All Words|Global Options|
|check          |Advertiser          |
Then I 'should' see assets 'logo.gif,logo.jpg' in the global search pageNEWLIB

Scenario: Check the shared asset is shown in library global search
Meta:@gdam
@library
Given I created the agency 'LGS_A2' with default attributes
And created the agency 'LGS_A3' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| LGS_U1 | agency.admin | LGS_A2 |streamlined_library|
| LGS_U2 | agency.admin | LGS_A3 |streamlined_library|
And logged in with details of 'LGS_U1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'LGS_C01' category
And added agency 'LGS_A3' to category 'LGS_C01' on Asset Categories and Permissions page
And logged in with details of 'LGS_U2'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When I go to the collections page
And I refresh the page
When I go to the Shared Collection 'LGS_C01' from agency 'LGS_A2' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'LGS_C01' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
When I enter input 'Ad' on global search pageNEWLIB
And I wait for '3' seconds
Then I 'should' see assets 'Fish Ad.mov,Fish1-Ad.mov' in the global search pageNEWLIB
When I click on view all in library link on global search pageNEWLIB
And I wait for '3' seconds
Then I 'should' see assets 'Fish Ad.mov,Fish1-Ad.mov' on the library search results pageNEWLIB

Scenario: Check the library global search for files that was moved from project to library
Meta:@gdam
@library
Given I created the agency 'A_GS_S1' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |Access|
| U_GS_S1 | agency.admin | A_GS_S1 |dashboard,streamlined_library|
And logged in with details of 'U_GS_S1'
And created 'P_GS_S13' project
And created '/F_GS_S13' folder for project 'P_GS_S13'
And uploaded '/images/empty.logo.png' file into '/F_GS_S13' folder for 'P_GS_S13' project
And waited while preview is available in folder '/F_GS_S13' on project 'P_GS_S13' files page
When I send file 'empty.logo.png' on project 'P_GS_S13' folder '/F_GS_S13' page to Library
And click Save button on Add file to new library page
When I enter input 'A GS' on global search pageNEWLIB
Then I 'should' see assets 'empty.logo.png' in the global search pageNEWLIB

