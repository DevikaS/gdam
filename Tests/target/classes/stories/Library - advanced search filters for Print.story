!--NGN-5297
Feature:          Library - advanced search filters for Print
Narrative:
In order to
As a              AgencyAdmin
I want to         Check library advanced search filters for Print metadata

Scenario: check edit metadata for files in projects
Meta:@gdam
@projects
Given I created the agency 'Realin_1' with default attributes
And I created users with following fields:
| AgencyUnique | Email       |
| Realin_1     | UserPrint_1 |
And I logged in with details of 'UserPrint_1'
And I created 'ProjectPrint_1' project
And I created '/FolderPrint_1' folder for project 'ProjectPrint_1'
And I uploaded into project 'ProjectPrint_1' following files:
| FileName            | Path           |
| /files/GWGTest2.pdf | /FolderPrint_1 |
And waited while transcoding is finished in folder '/FolderPrint_1' on project 'ProjectPrint_1' files page
When I open uploaded file 'GWGTest2.pdf' in folder '/FolderPrint_1' project 'ProjectPrint_1'
And I 'save' file info by next information:
| FieldName | FieldValue |
| Country   | Australia  |
And I refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName | FieldValue |
| Country   | Australia  |


Scenario: check that metadata correct after move file from one project to another
Meta:@gdam
@projects
Given I created the agency 'Realin_4' with default attributes
And I created users with following fields:
| AgencyUnique | Email       |
| Realin_4     | UserPrint_4 |
And logged in with details of 'UserPrint_4'
And created 'ProjectPrint_4_1' project
And created '/FolderPrint_4_1' folder for project 'ProjectPrint_4_1'
And created 'ProjectPrint_4_2' project
And created '/FolderPrint_4_2' folder for project 'ProjectPrint_4_2'
And uploaded into project 'ProjectPrint_4_1' following files:
| FileName            | Path             |
| /files/GWGTest2.pdf | /FolderPrint_4_1 |
And waited while preview is available in folder '/FolderPrint_4_1' on project 'ProjectPrint_4_1' files page
When I go to file 'GWGTest2.pdf' info page in folder '/FolderPrint_4_1' project 'ProjectPrint_4_1'
And 'save' file info by next information:
| FieldName | FieldValue |
| Country   | Australia  |
And go to project 'ProjectPrint_4_1' folder '/FolderPrint_4_1' page
And click on Want to move files to another project link on move/copy file 'GWGTest2.pdf' popup
And enter 'ProjectPrint_4_2' in search field on move/copy file popup
And select folder '/FolderPrint_4_2' on move/copy file popup
And click move button on move/copy files popup
And wait untill move/copy files popup will be closed
And go to file 'GWGTest2.pdf' info page in folder '/FolderPrint_4_2' project 'ProjectPrint_4_2'
And refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName | FieldValue |
| Country   | Australia  |


Scenario: check that metadata correct after copy file from one project to another
Meta:@gdam
@projects
Given I created the agency 'Realin_5' with default attributes
And I created users with following fields:
| AgencyUnique | Email       |
| Realin_5     | UserPrint_5 |
And logged in with details of 'UserPrint_5'
And created 'ProjectPrint_5_1' project
And created '/FolderPrint_5_1' folder for project 'ProjectPrint_5_1'
And created 'ProjectPrint_5_2' project
And created '/FolderPrint_5_2' folder for project 'ProjectPrint_5_2'
And uploaded into project 'ProjectPrint_5_1' following files:
| FileName            | Path             |
| /files/GWGTest2.pdf | /FolderPrint_5_1 |
And waited while preview is available in folder '/FolderPrint_5_1' on project 'ProjectPrint_5_1' files page
When I go to file 'GWGTest2.pdf' info page in folder '/FolderPrint_5_1' project 'ProjectPrint_5_1'
And 'save' file info by next information:
| FieldName | FieldValue |
| Country   | Australia  |
And go to project 'ProjectPrint_5_1' folder '/FolderPrint_5_1' page
And click on Want to copy files to another project link on move/copy file 'GWGTest2.pdf' popup
And enter 'ProjectPrint_5_2' in search field on move/copy file popup
And select folder '/FolderPrint_5_2' on move/copy file popup
And click move button on move/copy files popup
And wait untill move/copy files popup will be closed
And go to file 'GWGTest2.pdf' info page in folder '/FolderPrint_5_2' project 'ProjectPrint_5_2'
And refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName | FieldValue |
| Country   | Australia  |

Scenario: check that additional field for print mediatypes
Meta:@gdam
@library
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_CASFP_S06' with default attributes
And I opened role 'agency.admin' page with parent 'A_CASFP_S06'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'A_CASFP_S06_R1'
And I clicked element 'SaveButton' on page 'Roles'
And I update role 'A_CASFP_S06_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_CASFP_S06'
And updated following 'asset' custom metadata fields for agency 'A_CASFP_S06':
| FieldType | Section | Description        | Choices                   |
| dropdown  | video   | Account Director   | Mr. Garrison,mr. Garrison |
And created users with following fields:
| Email       | Agency      |Access|Role|
| U_CASFP_S06 | A_CASFP_S06 |streamlined_library|A_CASFP_S06_R1|
And logged in with details of 'U_CASFP_S06'
And uploaded following assetsNEWLIB:
| Name                        |
| /files/GWGTestfile064v3.pdf |
| /files/GWGTest2.pdf         |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
And I am on asset 'GWGTestfile064v3.pdf' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName         | FieldValue      |
| Account Director  | Mr. Garrison    |
| Account Manager   | Mr. Mackey      |
| Art Director      | Mr. Slave       |
| Copywriter        | mr. Hankey      |
| Creative Director | Ms. Choksondik  |
And I am on asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName         | FieldValue      |
| Account Director  | Mr. Garrison    |
| Account Manager   | Mr. Mackey      |
| Art Director      | Mr. Slave       |
| Copywriter        | Hankey      |
And I edited user 'U_CASFP_S06' with following fields:
|Role|
|agency.admin|
And I logout from account
And logged in with details of 'U_CASFP_S06'
When I go to the library page for collection 'Everything'NEWLIB
And I click on filter link for collection 'Everything'
And I select 'Business Unit' with value 'A_CASFP_S06' as filter collection 'Everything'NEWLIB
And I switch 'on' media type filter 'PRINT' on filter page
And add additional filter as filter collection:
|Additional Field            | value                     |
| Account Director           |       <AccountDirector>          |
| Copywriter       | <Copywriter>      |
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
Then I 'should' see assets '<AssetName>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '<AssetsCount>' in '<CollectionName>' NEWLIB


Examples:
| CollectionName | AccountDirector | Copywriter | AssetName                         | AssetsCount |
| C_CASFP_S06_1  | Mr. Garrison    |  Hankey          | GWGTest2.pdf | 1           |


Scenario: check that metadata correct for assets in library after moved file to library
Meta:@gdam
@bug
@library
!--UIR-1069
Given I created the agency 'Realin_2' with default attributes
And created users with following fields:
| AgencyUnique | Email       |Access|
| Realin_2     | UserPrint_2 |streamlined_library,library,adkits,folders|
And logged in with details of 'UserPrint_2'
And created 'ProjectPrint_2' project
And created '/FolderPrint_2' folder for project 'ProjectPrint_2'
And uploaded into project 'ProjectPrint_2' following files:
| FileName            | Path           |
| /files/GWGTest2.pdf | /FolderPrint_2 |
And waited while preview is available in folder '/FolderPrint_2' on project 'ProjectPrint_2' files page
When I go to file 'GWGTest2.pdf' info page in folder '/FolderPrint_2' project 'ProjectPrint_2'
And 'save' file info by next information:
| FieldName | FieldValue |
| Country   | Australia  |
And send file 'GWGTest2.pdf' on project 'ProjectPrint_2' folder '/FolderPrint_2' page to Library
And fill add file to library page with ID 'AssetPrint_2'
And click Save button on Add file to new library page
And go to asset 'AssetPrint_2' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName        | FieldValue |
| Country          | Australia  |


Scenario: check edit metadata for assets in library
Meta:@gdam
@bug
@library
!--UIR-1069
Given I created the agency 'Realin_3' with default attributes
And I created users with following fields:
| AgencyUnique | Email       |Access|
| Realin_3     | UserPrint_3 |streamlined_library,library|
And I logged in with details of 'UserPrint_3'
And I am on the Library page for collection 'My Assets'NEWLIB
And I appended file '/files/GWGTestfile064v3.pdf' to library for collection 'My Assets' while file count less than '1'
When I wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to asset 'GWGTestfile064v3.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'saved' asset info by following information on opened asset info pageNEWLIB:
| FieldName        | FieldValue |
| Country          | Australia  |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName        | FieldValue          |
| Country          | Australia           |


