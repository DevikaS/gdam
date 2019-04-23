!--NGN-11517
Feature:          BU Admin sets default value for drop down or radio buttons
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that default values set in Metadata editor appear on projects assets, file details

Scenario: Check that new default value appears on preview section after update on Admin Metadata editor
Meta:@gdam
     @projects
!--NGN-11218
Given I created the agency 'A_BUASDVDDRB_S01' with default attributes
And created following 'common' custom metadata fields for agency 'A_BUASDVDDRB_S01':
| FieldType    | Description        | Choices                                     |
| RadioButtons | RBF BUASDVDDRB S01 | RBFV BUASDVDDRB S01 1,RBFV BUASDVDDRB S01 2 |
| Dropdown     | DDF BUASDVDDRB S01 | DDFV BUASDVDDRB S01 1,DDFV BUASDVDDRB S01 2 |
And created users with following fields:
| Email            | Role         | Agency           |
| U_BUASDVDDRB_S01 | agency.admin | A_BUASDVDDRB_S01 |
And logged in with details of 'U_BUASDVDDRB_S01'
When I go to the 'common custom' metadata page
And set default value 'RBFV BUASDVDDRB S01 1' for multi choice field 'RBF BUASDVDDRB S01' in section 'common metadata' on Settings and Customization page
And set default value 'DDFV BUASDVDDRB S01 2' for multi choice field 'DDF BUASDVDDRB S01' in section 'common metadata' on Settings and Customization page
Then I 'should' see following fields with selected values in Active Metadata Preview block on opened metadata page:
| FieldType    | FieldName          | FieldValue            |
| RadioButtons | RBF BUASDVDDRB S01 | RBFV BUASDVDDRB S01 1 |
| Dropdown     | DDF BUASDVDDRB S01 | DDFV BUASDVDDRB S01 2 |


Scenario: Check that default values for catalogue structure appear on Project at creation (Advertiser - Brand - SubBrand)
Meta: @skip
      @gdam
Given I created the agency 'A_BUASDVDDRB_S02' with default attributes
And created following 'common' custom metadata fields for agency 'A_BUASDVDDRB_S02':
| FieldType          | Description       | Parent            |
| CatalogueStructure | AR BUASDVDDRB S02 |                   |
| CatalogueStructure | BR BUASDVDDRB S02 | AR BUASDVDDRB S02 |
| CatalogueStructure | SB BUASDVDDRB S02 | BR BUASDVDDRB S02 |
| CatalogueStructure | PR BUASDVDDRB S02 | SB BUASDVDDRB S02 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_BUASDVDDRB_S02':
| AR BUASDVDDRB S02   | BR BUASDVDDRB S02   | SB BUASDVDDRB S02   | PR BUASDVDDRB S02   |
| AR BUASDVDDRB S02 1 | BR BUASDVDDRB S02 1 | SB BUASDVDDRB S02 1 | PR BUASDVDDRB S02 1 |
| AR BUASDVDDRB S02 1 | BR BUASDVDDRB S02 1 | SB BUASDVDDRB S02 1 | PR BUASDVDDRB S02 2 |
| AR BUASDVDDRB S02 2 | BR BUASDVDDRB S02 1 | SB BUASDVDDRB S02 1 | PR BUASDVDDRB S02 1 |
| AR BUASDVDDRB S02 2 | BR BUASDVDDRB S02 1 | SB BUASDVDDRB S02 1 | PR BUASDVDDRB S02 2 |
And created users with following fields:
| Email            | Role         | Agency           |
| U_BUASDVDDRB_S02 | agency.admin | A_BUASDVDDRB_S02 |
And logged in with details of 'U_BUASDVDDRB_S02'
And on the 'common custom' metadata page
And set following default values chain for catalogue structure field 'AR BUASDVDDRB S02' in section 'common metadata' on Settings and Customization page:
| ChainItem           |
| AR BUASDVDDRB S02 1 |
| BR BUASDVDDRB S02 1 |
| SB BUASDVDDRB S02 1 |
| PR BUASDVDDRB S02 2 |
When I go to Create New Project page
Then I 'should' see following fields on opened Create Project popup:
| FieldName         | FieldValue          |
| AR BUASDVDDRB S02 | AR BUASDVDDRB S02 1 |
| BR BUASDVDDRB S02 | BR BUASDVDDRB S02 1 |
| SB BUASDVDDRB S02 | SB BUASDVDDRB S02 1 |
| PR BUASDVDDRB S02 | PR BUASDVDDRB S02 2 |


Scenario: Check that default values after changing in editor correctly display on asset details page (custom catalogue)
Meta:@gdam
     @library
Given I created the agency 'A_BUASDVDDRB_S03' with default attributes
And created following 'common' custom metadata fields for agency 'A_BUASDVDDRB_S03':
| FieldType          | Description       | Parent            |
| CatalogueStructure | AR BUASDVDDRB S03 |                   |
| CatalogueStructure | BR BUASDVDDRB S03 | AR BUASDVDDRB S03 |
| CatalogueStructure | SB BUASDVDDRB S03 | BR BUASDVDDRB S03 |
| CatalogueStructure | PR BUASDVDDRB S03 | SB BUASDVDDRB S03 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_BUASDVDDRB_S03':
| AR BUASDVDDRB S03   | BR BUASDVDDRB S03   | SB BUASDVDDRB S03   | PR BUASDVDDRB S03   |
| AR BUASDVDDRB S03 1 | BR BUASDVDDRB S03 1 | SB BUASDVDDRB S03 1 | PR BUASDVDDRB S03 1 |
| AR BUASDVDDRB S03 1 | BR BUASDVDDRB S03 1 | SB BUASDVDDRB S03 1 | PR BUASDVDDRB S03 2 |
| AR BUASDVDDRB S03 2 | BR BUASDVDDRB S03 1 | SB BUASDVDDRB S03 1 | PR BUASDVDDRB S03 1 |
| AR BUASDVDDRB S03 2 | BR BUASDVDDRB S03 1 | SB BUASDVDDRB S03 1 | PR BUASDVDDRB S03 2 |
And created users with following fields:
| Email            | Role         | Agency           |Access|
| U_BUASDVDDRB_S03 | agency.admin | A_BUASDVDDRB_S03 |streamlined_library|
And logged in with details of 'U_BUASDVDDRB_S03'
And on the 'common custom' metadata page
And set following default values chain for catalogue structure field 'AR BUASDVDDRB S03' in section 'common metadata' on Settings and Customization page:
| ChainItem           |
| AR BUASDVDDRB S03 1 |
| BR BUASDVDDRB S03 1 |
| SB BUASDVDDRB S03 1 |
| PR BUASDVDDRB S03 2 |
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
|SectionName| FieldName         | FieldValue          |
|General    | AR BUASDVDDRB S03 | AR BUASDVDDRB S03 1 |
|General    | BR BUASDVDDRB S03 | BR BUASDVDDRB S03 1 |
|General    | SB BUASDVDDRB S03 | SB BUASDVDDRB S03 1 |
|General    | PR BUASDVDDRB S03 | PR BUASDVDDRB S03 2 |


Scenario: Check that default values for radiobutton appear on file details page edit mode
Meta:@gdam
     @projects
Given I created the agency 'A_BUASDVDDRB_S04' with default attributes
And created following 'common' custom metadata fields for agency 'A_BUASDVDDRB_S04':
| FieldType    | Description        | Choices                                     |
| RadioButtons | RBF BUASDVDDRB S04 | RBFV BUASDVDDRB S04 1,RBFV BUASDVDDRB S04 2 |
And created users with following fields:
| Email            | Role         | Agency           |
| U_BUASDVDDRB_S04 | agency.admin | A_BUASDVDDRB_S04 |
And logged in with details of 'U_BUASDVDDRB_S04'
And on the 'common custom' metadata page
And set default value 'RBFV BUASDVDDRB S04 1' for multi choice field 'RBF BUASDVDDRB S04' in section 'common metadata' on Settings and Customization page
And created 'P_BUASDVDDRB_S04' project
And created '/F_BUASDVDDRB_S04' folder for project 'P_BUASDVDDRB_S04'
And uploaded '/files/image10.jpg' file into '/F_BUASDVDDRB_S04' folder for 'P_BUASDVDDRB_S04' project
And waited while transcoding is finished in folder '/F_BUASDVDDRB_S04' on project 'P_BUASDVDDRB_S04' files page
When I go to file 'image10.jpg' info page in folder '/F_BUASDVDDRB_S04' project 'P_BUASDVDDRB_S04'
And click Edit link on file info page
And wait for '3' seconds
Then I 'should' see following 'available' fields on opened Edit file popup:
| FieldName          | FieldValue            |
| RBF BUASDVDDRB S04 | RBFV BUASDVDDRB S04 1 |


Scenario: Check that default values for dropdown appear on asset details
Meta:@gdam
     @library
Given I created the agency 'A_BUASDVDDRB_S05' with default attributes
And created following 'common' custom metadata fields for agency 'A_BUASDVDDRB_S05':
| FieldType | Description        | Choices                                     |
| Dropdown  | DDF BUASDVDDRB S05 | DDFV BUASDVDDRB S05 1,DDFV BUASDVDDRB S05 2 |
And created users with following fields:
| Email            | Role         | Agency           |Access|
| U_BUASDVDDRB_S05 | agency.admin | A_BUASDVDDRB_S05 |streamlined_library|
And logged in with details of 'U_BUASDVDDRB_S05'
And on the 'common custom' metadata page
And set default value 'DDFV BUASDVDDRB S05 1' for multi choice field 'DDF BUASDVDDRB S05' in section 'common metadata' on Settings and Customization page
And uploaded file '/files/image11.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When I go to asset 'image11.jpg' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
|SectionName| FieldName          | FieldValue            |
|General| DDF BUASDVDDRB S05 | DDFV BUASDVDDRB S05 1 |


Scenario: Check that default value appear only for empty field not filled before
Meta:@gdam
     @library
Given I created the agency 'A_BUASDVDDRB_S06' with default attributes
And created following 'common' custom metadata fields for agency 'A_BUASDVDDRB_S06':
| FieldType          | Description       | Parent            |
| CatalogueStructure | AR BUASDVDDRB S06 |                   |
| CatalogueStructure | BR BUASDVDDRB S06 | AR BUASDVDDRB S06 |
| CatalogueStructure | SB BUASDVDDRB S06 | BR BUASDVDDRB S06 |
| CatalogueStructure | PR BUASDVDDRB S06 | SB BUASDVDDRB S06 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_BUASDVDDRB_S06':
| AR BUASDVDDRB S06   | BR BUASDVDDRB S06   | SB BUASDVDDRB S06   | PR BUASDVDDRB S06   |
| AR BUASDVDDRB S06 1 | BR BUASDVDDRB S06 1 | SB BUASDVDDRB S06 1 | PR BUASDVDDRB S06 1 |
| AR BUASDVDDRB S06 1 | BR BUASDVDDRB S06 1 | SB BUASDVDDRB S06 1 | PR BUASDVDDRB S06 2 |
| AR BUASDVDDRB S06 2 | BR BUASDVDDRB S06 1 | SB BUASDVDDRB S06 1 | PR BUASDVDDRB S06 1 |
| AR BUASDVDDRB S06 2 | BR BUASDVDDRB S06 1 | SB BUASDVDDRB S06 1 | PR BUASDVDDRB S06 2 |
And created following 'common' custom metadata fields for agency 'A_BUASDVDDRB_S06':
| FieldType    | Description        | Choices                                     |
| Dropdown     | DDF BUASDVDDRB S06 | DDFV BUASDVDDRB S06 1,DDFV BUASDVDDRB S06 2 |
| RadioButtons | RBF BUASDVDDRB S06 | RBFV BUASDVDDRB S06 1,RBFV BUASDVDDRB S06 2 |
And created users with following fields:
| Email            | Role         | Agency           |Access|
| U_BUASDVDDRB_S06 | agency.admin | A_BUASDVDDRB_S06 |streamlined_library|
And logged in with details of 'U_BUASDVDDRB_S06'
And uploaded file '/files/image11.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When I 'save' asset 'image11.jpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName          | FieldValue            |
| AR BUASDVDDRB S06  | AR BUASDVDDRB S06 2   |
| BR BUASDVDDRB S06  | BR BUASDVDDRB S06 1   |
| SB BUASDVDDRB S06  | SB BUASDVDDRB S06 1   |
| PR BUASDVDDRB S06  | PR BUASDVDDRB S06 1   |
| DDF BUASDVDDRB S06 | DDFV BUASDVDDRB S06 2 |
| RBF BUASDVDDRB S06 | RBFV BUASDVDDRB S06 2 |
And go to the 'common custom' metadata page
And set default value 'DDFV BUASDVDDRB S06 1' for multi choice field 'DDF BUASDVDDRB S06' in section 'common metadata' on Settings and Customization page
And set default value 'RBFV BUASDVDDRB S06 1' for multi choice field 'RBF BUASDVDDRB S06' in section 'common metadata' on Settings and Customization page
And set following default values chain for catalogue structure field 'AR BUASDVDDRB S06' in section 'common metadata' on Settings and Customization page:
| ChainItem           |
| AR BUASDVDDRB S06 1 |
| BR BUASDVDDRB S06 1 |
| SB BUASDVDDRB S06 1 |
| PR BUASDVDDRB S06 2 |
And go to asset 'image11.jpg' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
|SectionName| FieldName          | FieldValue            |
|General| AR BUASDVDDRB S06  | AR BUASDVDDRB S06 2   |
|General| BR BUASDVDDRB S06  | BR BUASDVDDRB S06 1   |
|General| SB BUASDVDDRB S06  | SB BUASDVDDRB S06 1   |
|General| PR BUASDVDDRB S06  | PR BUASDVDDRB S06 1   |
|General| DDF BUASDVDDRB S06 | DDFV BUASDVDDRB S06 2 |
|General| RBF BUASDVDDRB S06 | RBFV BUASDVDDRB S06 2 |
