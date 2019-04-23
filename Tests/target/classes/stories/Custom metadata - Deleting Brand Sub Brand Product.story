!--NGN-7810 NGN-8349
Feature:          Custom metadata - Deleting Brand Sub Brand Product
Narrative:        QA internal task
In order to
As a              GlobalAdmin
I want to         check deleting Brand Sub Brand Product

Scenario: Check that after deleting Product and Sub Brand, new project appears in project list
Meta:@projects
     @gdam
Given I created the agency 'A_CMDBSBP_S01' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_CMDBSBP_S01 | agency.admin | A_CMDBSBP_S01 |
And logged in with details of 'U_CMDBSBP_S01'
And on the 'common custom' metadata page
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And removed catalogue structure items 'Product' on opened Settings and Customization page
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And removed catalogue structure items 'Sub Brand' on opened Settings and Customization page
When I create new project with following fields:
| FieldName  | FieldValue    |
| Name       | P_CMDBSBP_S01 |
| Media type | Broadcast     |
| Start date | Today         |
| End date   | Tomorrow      |
And wait for '3' seconds
Then I 'should' see project 'P_CMDBSBP_S01' on project list page


Scenario: Check that after deleting Product and Sub Brand, project is created with proper metadata
Meta:@projects
     @gdam
Given I created the agency 'A_CMDBSBP_S02' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_CMDBSBP_S02 | agency.admin | A_CMDBSBP_S02 |
And updated following 'common' custom metadata fields for agency 'A_CMDBSBP_S02':
| FieldType          | Description | Parent     | AddOnFly |
| CatalogueStructure | Advertiser  |            | true     |
| CatalogueStructure | Brand       | Advertiser | true     |
And logged in with details of 'U_CMDBSBP_S02'
And on the 'common custom' metadata page
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And removed catalogue structure items 'Product' on opened Settings and Customization page
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And removed catalogue structure items 'Sub Brand' on opened Settings and Customization page
When I create new project with following fields:
| FieldName  | FieldValue     |
| Advertiser | AR_CMDBSBP_S02 |
| Brand      | B_CMDBSBP_S02  |
| Name       | P_CMDBSBP_S02  |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
Then I 'should' see following fields on opened Project 'P_CMDBSBP_S02' Overview page:
| FieldName  | FieldValue     |
| Advertiser | AR_CMDBSBP_S02 |
| Brand      | B_CMDBSBP_S02  |


Scenario: Check that after deleting Product and Sub Brand, file metadata could be changed
Meta:@projects
     @gdam
Given I created the agency 'A_CMDBSBP_S03' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_CMDBSBP_S03 | agency.admin | A_CMDBSBP_S03 |
And updated following 'common' custom metadata fields for agency 'A_CMDBSBP_S03':
| FieldType          | Description | Parent     | AddOnFly |
| CatalogueStructure | Advertiser  |            | true     |
| CatalogueStructure | Brand       | Advertiser | true     |
And logged in with details of 'U_CMDBSBP_S03'
And on the 'common custom' metadata page
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And removed catalogue structure items 'Product' on opened Settings and Customization page
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And removed catalogue structure items 'Sub Brand' on opened Settings and Customization page
And created 'P_CMDBSBP_S03' project
And created '/F_CMDBSBP_S03' folder for project 'P_CMDBSBP_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_CMDBSBP_S03' folder for 'P_CMDBSBP_S03' project
And waited while transcoding is finished in folder '/F_CMDBSBP_S03' on project 'P_CMDBSBP_S03' files page
And on file 'Fish Ad.mov' info page in folder '/F_CMDBSBP_S03' project 'P_CMDBSBP_S03'
When I 'save' file info by next information:
| FieldName    | FieldValue     |
| Advertiser   | AR_CMDBSBP_S03 |
| Brand        | B_CMDBSBP_S03  |
| Clock number | testcn         |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue     |
| Advertiser | AR_CMDBSBP_S03 |
| Brand      | B_CMDBSBP_S03  |



Scenario: Check that after deleting Product and renaming Sub Brand to product, project metadata could be changed
Meta:@projects
     @gdam
Given I created the agency 'A_CMDBSBP_S05' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_CMDBSBP_S05 | agency.admin | A_CMDBSBP_S05 |
And updated following 'common' custom metadata fields for agency 'A_CMDBSBP_S05':
| FieldType          | Description | Parent     | AddOnFly |
| CatalogueStructure | Advertiser  |            | true     |
| CatalogueStructure | Brand       | Advertiser | true     |
And logged in with details of 'U_CMDBSBP_S05'
And on the 'common custom' metadata page
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And removed catalogue structure items 'Product' on opened Settings and Customization page
And on the 'common custom' metadata page
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And filled Description field with text 'Product' on opened Settings and Customization tab
And saved metadata field settings
And created new project with following fields:
| FieldName  | FieldValue     |
| Advertiser | AR_CMDBSBP_S05 |
| Brand      | B_CMDBSBP_S05  |
| Product    | PT_CMDBSBP_S05 |
| Name       | P_CMDBSBP_S05  |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
When I update project 'P_CMDBSBP_S05' with following fields on Edit Project popup:
| FieldName  | FieldValue       |
| Advertiser | UVAR_CMDBSBP_S05 |
| Brand      | UVB_CMDBSBP_S05  |
| Product    | UVPT_CMDBSBP_S05 |
Then I 'should' see following fields on opened Project Overview page:
| FieldName  | FieldValue       |
| Advertiser | UVAR_CMDBSBP_S05 |
| Brand      | UVB_CMDBSBP_S05  |
| Product    | UVPT_CMDBSBP_S05 |


Scenario: Check that after deleting Product and renaming Sub Brand to product, metadata inherited to the file
Meta:@projects
     @gdam
Given I created the agency 'A_CMDBSBP_S06' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_CMDBSBP_S06 | agency.admin | A_CMDBSBP_S06 |
And updated following 'common' custom metadata fields for agency 'A_CMDBSBP_S06':
| FieldType          | Description | Parent     | AddOnFly |
| CatalogueStructure | Advertiser  |            | true     |
| CatalogueStructure | Brand       | Advertiser | true     |
And logged in with details of 'U_CMDBSBP_S06'
And on the 'common custom' metadata page
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And removed catalogue structure items 'Product' on opened Settings and Customization page
And on the 'common custom' metadata page
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And filled Description field with text 'Product' on opened Settings and Customization tab
And saved metadata field settings
And created new project with following fields:
| FieldName  | FieldValue     |
| Advertiser | AR_CMDBSBP_S06 |
| Brand      | B_CMDBSBP_S06  |
| Product    | PT_CMDBSBP_S06 |
| Name       | P_CMDBSBP_S06  |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
And created '/F_CMDBSBP_S06' folder for project 'P_CMDBSBP_S06'
And uploaded '/files/Fish Ad.mov' file into '/F_CMDBSBP_S06' folder for 'P_CMDBSBP_S06' project
And waited while transcoding is finished in folder '/F_CMDBSBP_S06' on project 'P_CMDBSBP_S06' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_CMDBSBP_S06' project 'P_CMDBSBP_S06'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue     |
| Advertiser | AR_CMDBSBP_S06 |
| Brand      | B_CMDBSBP_S06  |
| Product    | PT_CMDBSBP_S06 |



Scenario: Check that after deleting Product and renaming Sub Brand to product, file could be moved to library
Meta:@gdam
     @library
Given I created the agency 'A_CMDBSBP_S04' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| U_CMDBSBP_S04 | agency.admin | A_CMDBSBP_S04 |streamlined_library,adkits,folders,library|
And updated following 'common' custom metadata fields for agency 'A_CMDBSBP_S04':
| FieldType          | Description | Parent     | AddOnFly |
| CatalogueStructure | Advertiser  |            | true     |
| CatalogueStructure | Brand       | Advertiser | true     |
And logged in with details of 'U_CMDBSBP_S04'
And on the 'common custom' metadata page
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And removed catalogue structure items 'Product' on opened Settings and Customization page
And on the 'common custom' metadata page
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And filled Description field with text 'Product' on opened Settings and Customization tab
And saved metadata field settings
And created new project with following fields:
| FieldName  | FieldValue     |
| Advertiser | AR_CMDBSBP_S04 |
| Brand      | B_CMDBSBP_S04  |
| Product    | PT_CMDBSBP_S04 |
| Name       | P_CMDBSBP_S04  |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
And created '/F_CMDBSBP_S04' folder for project 'P_CMDBSBP_S04'
And uploaded '/files/Fish Ad.mov' file into '/F_CMDBSBP_S04' folder for 'P_CMDBSBP_S04' project
And waited while transcoding is finished in folder '/F_CMDBSBP_S04' on project 'P_CMDBSBP_S04' files page
When I select file 'Fish Ad.mov' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| Clock number |
| testcn       |
And wait for '2' seconds
And click on element 'SaveButton'
And wait for '3' seconds
And refresh the page
And go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue |
| Advertiser | AR_CMDBSBP_S04 |
| Brand      | B_CMDBSBP_S04  |
| Product    | PT_CMDBSBP_S04 |