!--NGN-7064
Feature:          Custom metadata - CM type - Radio Buttons
Narrative:
In order to:
As a              GlobalAdmin
I want to         Check Radio buttons in Print scheme

Scenario: Check creation of Radio Buttons control on Metadata editor
Meta: @gdam
@globaladmin
Given I created the following agency:
| Name             | A4User        |
| A_CMCMTRB_S01    | DefaultA4User |
And logged in with details of 'GlobalAdmin'
And on the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S01'
When I click 'Radio Buttons' button in 'Custom Metadata' section on opened metadata page
And fill Description field with text '<CustomFieldName>' on opened Settings and Customization tab
And save metadata field settings
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S01'
And wait for '3' seconds
Then I 'should' see button '<CustomFieldName>' in 'Editable Metadata' section on opened metadata page
And 'should' see field '<CustomFieldName>' in Active Metadata Preview block on opened metadata page

Examples:
| CustomFieldName  |
| ~!@#%&*()_+=O`"T |


Scenario: Check behaviour of Radio Buttons control creation with empty description in Metadata editor
Meta:@gdam
@globaladmin
Given I created the agency 'A_CMCMTRB_S02' with default attributes
And on the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S02'
When I click 'Radio Buttons' button in 'Custom Metadata' section on opened metadata page
And fill Description field with text '' on opened Settings and Customization tab
And save metadata field settings
Then I 'should' see Description field is red on opened Settings and Customization tab


Scenario: Check that Radio Buttons control isn't displayed on Print assets details if value of Radio Buttons isn't specified
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S03' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S03 | agency.admin | A_CMCMTRB_S03 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S03':
| FieldType    | Section | Description     |
| radioButtons | print   | CMF CMCMTRB S03 |
And logged in with details of 'U_CMCMTRB_S03'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
Then I 'should not' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue |
| CMF CMCMTRB S03 |            |



Scenario: Check appearance of Radio Buttons control on Print assets in view form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S04' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S04 | agency.admin | A_CMCMTRB_S04 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S04':
| FieldType    | Section | Description     | Choices          |
| radioButtons | print   | CMF CMCMTRB S04 | CMFC CMCMTRB S04 |
And logged in with details of 'U_CMCMTRB_S04'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue       |
| CMF CMCMTRB S04 | CMFC CMCMTRB S04 |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue       |
| CMF CMCMTRB S04 | CMFC CMCMTRB S04 |


Scenario: Check adding values for Radio Buttons control on Metadata editor
Meta:@gdam
@globaladmin
Given I created the agency 'A_CMCMTRB_S05' with default attributes
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S05':
| FieldType    | Section | Description       |
| radioButtons | print   | CMF CMCMTRB S05 1 |
And on the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S05'
And clicked 'CMF CMCMTRB S05 1' button in 'Editable Metadata' section on opened metadata page
And added following radio choices on opened Settings and Customization page:
| Choice                     |
| CMFC ~!@#%&*()_+=O`" S05 1 |
| CMFC ~!@#%&*()_+=O`" S05 2 |
And clicked 'CMF CMCMTRB S05 1' button in 'Editable Metadata' section on opened metadata page
Then I 'should' see following radio button 'CMF CMCMTRB S05 1' choices in Active Metadata Preview block on opened metadata page:
| Choice                     |
| CMFC ~!@#%&*()_+=O`" S05 1 |
| CMFC ~!@#%&*()_+=O`" S05 2 |
And 'should' see following choices on opened radio buttons field Settings and Customization page:
| Choice                     |
| CMFC ~!@#%&*()_+=O`" S05 1 |
| CMFC ~!@#%&*()_+=O`" S05 2 |


Scenario: Check adding empty values for Radio Buttons control on Metadata editor
Meta:@gdam
@globaladmin
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name             | A4User        |
| A_CMCMTRB_S05    | DefaultA4User |
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S05':
| FieldType    | Section | Description       |
| radioButtons | print   | CMF CMCMTRB S05 2 |
And on the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S05'
And waited for '3' seconds
And clicked 'CMF CMCMTRB S05 2' button in 'Editable Metadata' section on opened metadata page
And added following radio choices on opened Settings and Customization page:
| Choice |
|        |
And waited for '3' seconds
And clicked 'CMF CMCMTRB S05 2' button in 'Editable Metadata' section on opened metadata page
Then I 'should not' see any radio button 'CMF CMCMTRB S05 2' choices in Active Metadata Preview block on opened metadata page
And 'should not' see following choices on opened radio buttons field Settings and Customization page:
| Choice |
|        |


Scenario: Check adding new values for Radio Buttons control on Print assets in edit form
Meta:@gdam
@library
Given I created the following agency:
| Name             | A4User        |
| A_CMCMTRB_S06    | DefaultA4User |
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S06 | agency.admin | A_CMCMTRB_S06 |streamlined_library|
And logged in with details of 'U_CMCMTRB_S06'
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S06':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S06 | CMFC CMCMTRB S06 1,CMFC CMCMTRB S06 2 |
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S06 | CMFC CMCMTRB S06 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S06'
And click 'CMF CMCMTRB S06' button in 'Editable Metadata' section on opened metadata page
And add following radio choices on opened Settings and Customization page:
| Choice             |
| CMFC CMCMTRB S06 3 |
And login with details of 'U_CMCMTRB_S06'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
|SectionName   |  FieldName       | FieldValue         |
| Product Info | CMF CMCMTRB S06 | CMFC CMCMTRB S06 1 |
Then I 'should not' see following 'metadata' fields with value on edit asset popup NEWLIB:
|SectionName   | FieldName       | FieldValue         |
|Product Info |CMF CMCMTRB S06  | CMFC CMCMTRB S06 2 |
|Product Info  | CMF CMCMTRB S06 | CMFC CMCMTRB S06 3 |


Scenario: Check adding values for Radio Buttons control on Print assets in edit form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S07' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S07 | agency.admin | A_CMCMTRB_S07 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S07':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S07 | CMFC CMCMTRB S07 1,CMFC CMCMTRB S07 2 |
And logged in with details of 'U_CMCMTRB_S07'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following dropdown fields with values under section 'General' on opened Edit asset popup NEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S07 | CMFC CMCMTRB S07 1 |
| CMF CMCMTRB S07 | CMFC CMCMTRB S07 2 |


Scenario: Check removing not used values for Radio Buttons control on Metadata editor
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S08' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S08 | agency.admin | A_CMCMTRB_S08 |streamlined_library|
And logged in with details of 'U_CMCMTRB_S08'
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S08':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S08 | CMFC CMCMTRB S08 1,CMFC CMCMTRB S08 2 |
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S08 | CMFC CMCMTRB S08 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S08'
And click 'CMF CMCMTRB S08' button in 'Editable Metadata' section on opened metadata page
And remove radio buttons items 'CMFC CMCMTRB S08 2' on opened Settings and Customization page
And login with details of 'U_CMCMTRB_S08'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName |FieldName       | FieldValue         |
| Product Info|CMF CMCMTRB S08 | CMFC CMCMTRB S08 1 |
Then I 'should not' see following 'metadata' fields with value on edit asset popup NEWLIB:
|SectionName  | FieldName       | FieldValue         |
| Product Info|CMF CMCMTRB S08 | CMFC CMCMTRB S08 2 |



Scenario: Check removing used values for Radio Buttons control on Metadata editor
Meta:@gdam
@globaladmin
Given I created the agency 'A_CMCMTRB_S09' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S09 | agency.admin | A_CMCMTRB_S09 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S09':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S09 | CMFC CMCMTRB S09 1,CMFC CMCMTRB S09 2 |
And logged in with details of 'U_CMCMTRB_S09'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S09 | CMFC CMCMTRB S09 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S09'
And click 'CMF CMCMTRB S09' button in 'Editable Metadata' section on opened metadata page
And remove radio buttons items 'CMFC CMCMTRB S09 1' on opened Settings and Customization page
Then I 'should' see following 'radio buttons' 'CMF CMCMTRB S09' choices in Active Metadata Preview block on opened metadata page:
| Choice             |
| CMFC CMCMTRB S09 2 |
And 'should not' see following 'radio buttons' 'CMF CMCMTRB S09' choices in Active Metadata Preview block on opened metadata page:
| Choice             |
| CMFC CMCMTRB S09 1 |



Scenario: Check removing not used values for Radio Buttons control on Print assets in view form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S10' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S10 | agency.admin | A_CMCMTRB_S10 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S10':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S10 | CMFC CMCMTRB S10 1,CMFC CMCMTRB S10 2 |
And logged in with details of 'U_CMCMTRB_S10'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S10 | CMFC CMCMTRB S10 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S10'
And click 'CMF CMCMTRB S10' button in 'Editable Metadata' section on opened metadata page
And remove radio buttons items 'CMFC CMCMTRB S10 2' on opened Settings and Customization page
And wait for '3' seconds
And login with details of 'U_CMCMTRB_S10'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S10 | CMFC CMCMTRB S10 1 |
And 'should not' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S10 | CMFC CMCMTRB S10 2 |


Scenario: Check removing used values for Radio Buttons control on Print assets in view form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S11' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S11 | agency.admin | A_CMCMTRB_S11 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S11':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S11 | CMFC CMCMTRB S11 1,CMFC CMCMTRB S11 2 |
And logged in with details of 'U_CMCMTRB_S11'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S11 | CMFC CMCMTRB S11 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S11'
And click 'CMF CMCMTRB S11' button in 'Editable Metadata' section on opened metadata page
And remove radio buttons items 'CMFC CMCMTRB S11 1' on opened Settings and Customization page
And wait for '3' seconds
And login with details of 'U_CMCMTRB_S11'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S11 | CMFC CMCMTRB S11 1 |
Then I 'should not' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S11 | CMFC CMCMTRB S11 2 |




Scenario: Check editing data in Radio control for Print asset
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S14' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S14 | agency.admin | A_CMCMTRB_S14 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S14':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S14 | CMFC CMCMTRB S14 1,CMFC CMCMTRB S14 2 |
And logged in with details of 'U_CMCMTRB_S14'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S14 | CMFC CMCMTRB S14 1 |
And I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S14 | CMFC CMCMTRB S14 2 |
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S14 | CMFC CMCMTRB S14 1,CMFC CMCMTRB S14 2 |



Scenario: Check renaming of Radio control on Metadata editor
Meta:@gdam
@globaladmin
Given I created the agency 'A_CMCMTRB_S15' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMFC_S05 | agency.admin | A_CMCMTRB_S15|
And logged in with details of 'U_CMFC_S05'
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S15':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S15 | CMFC CMCMTRB S15 1,CMFC CMCMTRB S15 2 |
When I go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S15'
And click 'CMF CMCMTRB S15' button in 'Editable Metadata' section on opened metadata page
And fill Description field with text 'UCMF CMCMTRB S15' on opened Settings and Customization tab
And save metadata field settings
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S15'
Then I 'should' see button 'UCMF CMCMTRB S15' in 'Editable Metadata' section on opened metadata page
And 'should not' see button 'CMF CMCMTRB S15' in 'Editable Metadata' section on opened metadata page
And 'should' see field 'UCMF CMCMTRB S15' in Active Metadata Preview block on opened metadata page
And 'should not' see field 'CMF CMCMTRB S15' in Active Metadata Preview block on opened metadata page



Scenario: Check deletion of Radio control on Metadata editor
Meta:@gdam
@globaladmin
Given I created the agency 'A_CMCMTRB_S18' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMFC_S18 | agency.admin | A_CMCMTRB_S18|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S18':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S18 | CMFC CMCMTRB S18 1,CMFC CMCMTRB S18 2 |
And logged in with details of 'U_CMFC_S18'
When I go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S18'
And remove metadata field 'CMF CMCMTRB S18' from metadata page
Then I 'should not' see button 'CMF CMCMTRB S18' in 'Editable Metadata' section on opened metadata page
And 'should not' see field 'CMF CMCMTRB S18' in Active Metadata Preview block on opened metadata page


Scenario: Check deletion of Radio control on Print asset in view form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S19' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S19 | agency.admin | A_CMCMTRB_S19 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S19':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S19 | CMFC CMCMTRB S19 1,CMFC CMCMTRB S19 2 |
And logged in with details of 'U_CMCMTRB_S19'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S19 | CMFC CMCMTRB S19 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S19'
And remove metadata field 'CMF CMCMTRB S19' from metadata page
And wait for '5' seconds
And login with details of 'U_CMCMTRB_S19'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
Then I 'should not' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName        | FieldValue         |
| CMF CMCMTRB S19  | CMFC CMCMTRB S19 1 |
| CMF CMCMTRB S19  | CMFC CMCMTRB S19 2 |




Scenario: Check removing not used values for Radio Buttons control on Print assets in edit form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S12' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S12 | agency.admin | A_CMCMTRB_S12 |streamlined_library|
And logged in with details of 'U_CMCMTRB_S12'
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S12':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S12 | CMFC CMCMTRB S12 1,CMFC CMCMTRB S12 2 |
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S12 | CMFC CMCMTRB S12 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S12'
And click 'CMF CMCMTRB S12' button in 'Editable Metadata' section on opened metadata page
And remove radio buttons items 'CMFC CMCMTRB S12 2' on opened Settings and Customization page
And wait for '3' seconds
And login with details of 'U_CMCMTRB_S12'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And click Edit link on asset info pageNEWLIB
Then I 'should' see following dropdown fields with values under section 'General' on opened Edit asset popup NEWLIB:
| FieldName      | FieldValue                     |
|CMF CMCMTRB S12 | CMFC CMCMTRB S12 1             |
Then I 'should not' see following dropdown fields with values under section 'General' on opened Edit asset popup NEWLIB:
| FieldName      | FieldValue                     |
|CMF CMCMTRB S12 | CMFC CMCMTRB S12 2             |


Scenario: Check removing used values for Radio Buttons control on Print assets in edit form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S13' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S13 | agency.admin | A_CMCMTRB_S13 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S13':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S13 | CMFC CMCMTRB S13 1,CMFC CMCMTRB S13 2 |
And logged in with details of 'U_CMCMTRB_S13'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S13 | CMFC CMCMTRB S13 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S13'
And click 'CMF CMCMTRB S13' button in 'Editable Metadata' section on opened metadata page
And remove radio buttons items 'CMFC CMCMTRB S13 1' on opened Settings and Customization page
And login with details of 'U_CMCMTRB_S13'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And I click Edit link on asset info pageNEWLIB
Then I 'should' see following dropdown fields with values under section 'General' on opened Edit asset popup NEWLIB:
| FieldName      | FieldValue                     |
|CMF CMCMTRB S13 | CMFC CMCMTRB S13 2             |
Then I 'should not' see following dropdown fields with values under section 'General' on opened Edit asset popup NEWLIB:
| FieldName      | FieldValue                     |
|CMF CMCMTRB S13 | CMFC CMCMTRB S13 1             |


Scenario: Check renaming of Radio control on Print asset in view form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S16' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S16 | agency.admin | A_CMCMTRB_S16 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S16':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S16 | CMFC CMCMTRB S16 1,CMFC CMCMTRB S16 2 |
And logged in with details of 'U_CMCMTRB_S16'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S16 | CMFC CMCMTRB S16 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S16'
And click 'CMF CMCMTRB S16' button in 'Editable Metadata' section on opened metadata page
And fill Description field with text 'UCMF CMCMTRB S16' on opened Settings and Customization tab
And save metadata field settings
And wait for '3' seconds
And login with details of 'U_CMCMTRB_S16'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue    |
| UCMF CMCMTRB S16 | CMFC CMCMTRB S16 1 |
And I 'should not' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue    |
| CMF CMCMTRB S16  | CMFC CMCMTRB S16 1 |
| CMF CMCMTRB S16  | CMFC CMCMTRB S16 2 |
| UCMF CMCMTRB S16 | CMFC CMCMTRB S16 2 |


Scenario: Check renaming of Radio control on Print asset in edit form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S17' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S17 | agency.admin | A_CMCMTRB_S17 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S17':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S17 | CMFC CMCMTRB S17 1,CMFC CMCMTRB S17 2 |
And logged in with details of 'U_CMCMTRB_S17'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S17 | CMFC CMCMTRB S17 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S17'
And click 'CMF CMCMTRB S17' button in 'Editable Metadata' section on opened metadata page
And fill Description field with text 'UCMF CMCMTRB S17' on opened Settings and Customization tab
And save metadata field settings
And login with details of 'U_CMCMTRB_S17'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And click Edit link on asset info pageNEWLIB
Then I 'should' see following dropdown fields with values under section 'General' on opened Edit asset popup NEWLIB:
| FieldName      | FieldValue                     |
| UCMF CMCMTRB S17 | CMFC CMCMTRB S17 1 |
| UCMF CMCMTRB S17 | CMFC CMCMTRB S17 2 |
And I '<shouldState>' see following 'metadata' fields on edit asset popup NEWLIB:
| FieldName      |shouldState|
|CMF CMCMTRB S17 |should not|
|UCMF CMCMTRB S17|should|


Scenario: Check deletion of Radio control on Print asset in edit form
Meta:@gdam
@library
Given I created the agency 'A_CMCMTRB_S20' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_CMCMTRB_S20 | agency.admin | A_CMCMTRB_S20 |streamlined_library|
And created following 'asset' custom metadata fields for agency 'A_CMCMTRB_S20':
| FieldType    | Section | Description     | Choices                               |
| radioButtons | print   | CMF CMCMTRB S20 | CMFC CMCMTRB S20 1,CMFC CMCMTRB S20 2 |
And logged in with details of 'U_CMCMTRB_S20'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName       | FieldValue         |
| CMF CMCMTRB S20 | CMFC CMCMTRB S20 1 |
And login with details of 'GlobalAdmin'
And go to the global 'Print Asset' metadata page for agency 'A_CMCMTRB_S20'
And remove metadata field 'CMF CMCMTRB S20' from metadata page
And wait for '5' seconds
And login with details of 'U_CMCMTRB_S20'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I '<shouldState>' see following 'metadata' fields on edit asset popup NEWLIB:
| FieldName      |shouldState|
|CMF CMCMTRB S20 |should not|
