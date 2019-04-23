!--NGN-10989
Feature:          BU Admin sets up custom metadata field for Work Request
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Check that BU Admin sets up custom metadata field for Work Request


Scenario: Check editing data value Advertiser with childs on WR (Add on fly)
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUASUCMFFWR_01' with default attributes
And created users with following fields:
| Email            | Role             | Agency           |
| E_BUASUCMFFWR_01 | agency.admin     | A_BUASUCMFFWR_01 |
And logged in with details of 'E_BUASUCMFFWR_01'
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
And created following Advertiser chain with checked 'Add values on the fly' checkbox on Settings and Customization page:
| Advertiser         | Brand             | Sub Brand          | Product            |
| AR_BUASUCMFFWR_S01 | B_BUASUCMFFWR_S01 | SB_BUASUCMFFWR_S01 | PT_BUASUCMFFWR_S01 |
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
Then I 'should' see following Advertiser chain on Settings and Customization page:
| Advertiser         | Brand             | Sub Brand          | Product            |
| AR_BUASUCMFFWR_S01 | B_BUASUCMFFWR_S01 | SB_BUASUCMFFWR_S01 | PT_BUASUCMFFWR_S01 |


Scenario: Check creation of Multiline control on Metadata editor for WR
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUASUCMFFWR_01' with default attributes
And created users with following fields:
| Email            | Role             | Agency           |
| E_BUASUCMFFWR_02 | agency.admin     | A_BUASUCMFFWR_01 |
And logged in with details of 'E_BUASUCMFFWR_02'
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
And created 'Multiline' custom metadata field with following information on opened metadata page:
| Description       |
| custom-multiline1 |
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
Then I 'should' see button 'custom-multiline1' in 'Editable Metadata' section on opened metadata page


Scenario: Check editing data in Multiline control for WR
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUASUCMFFWR_01' with default attributes
And created users with following fields:
| Email            | Role             | Agency           |
| E_BUASUCMFFWR_03 | agency.admin     | A_BUASUCMFFWR_01 |
And logged in with details of 'E_BUASUCMFFWR_03'
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
And created 'Multiline' custom metadata field with following information on opened metadata page:
| Description       |
| Custom-multiline1 |
And changed name of 'Custom-multiline1' metadata to new name 'Custom-multiline2' in editable metadata section on opened metadata page
Then I 'should' see button 'Custom-multiline2' in 'Editable Metadata' section on opened metadata page


Scenario: Check creation of Radio button control on Metadata editor for WR
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUASUCMFFWR_01' with default attributes
And created users with following fields:
| Email            | Role             | Agency           |
| E_BUASUCMFFWR_04 | agency.admin     | A_BUASUCMFFWR_01 |
And logged in with details of 'E_BUASUCMFFWR_04'
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description   |
| custom-radio1 |
Then I 'should' see button 'custom-radio1' in 'Editable Metadata' section on opened metadata page


Scenario: Check editing of Radio button control on Metadata editor for WR
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUASUCMFFWR_01' with default attributes
And created users with following fields:
| Email            | Role             | Agency           |
| E_BUASUCMFFWR_05 | agency.admin     | A_BUASUCMFFWR_01 |
And logged in with details of 'E_BUASUCMFFWR_05'
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description |
| Radio1      |
And changed name of 'Radio1' metadata to new name 'Radio2' in editable metadata section on opened metadata page
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
Then I 'should' see button 'Radio2' in 'Editable Metadata' section on opened metadata page


Scenario: Check creation of string control on Metadata editor for WR
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUASUCMFFWR_01' with default attributes
And created users with following fields:
| Email            | Role             | Agency           |
| E_BUASUCMFFWR_06 | agency.admin     | A_BUASUCMFFWR_01 |
And logged in with details of 'E_BUASUCMFFWR_06'
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
And created 'String' custom metadata field with following information on opened metadata page:
| Description    |
| custom-string1 |
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
Then I 'should' see button 'custom-string1' in 'Editable Metadata' section on opened metadata page


Scenario: Check editing of string control on Metadata editor for WR
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUASUCMFFWR_01' with default attributes
And created users with following fields:
| Email            | Role             | Agency           |
| E_BUASUCMFFWR_07 | agency.admin     | A_BUASUCMFFWR_01 |
And logged in with details of 'E_BUASUCMFFWR_07'
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
And created 'String' custom metadata field with following information on opened metadata page:
| Description |
| String1     |
And changed name of 'String1' metadata to new name 'String2' in editable metadata section on opened metadata page
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
Then I 'should' see button 'String2' in 'Editable Metadata' section on opened metadata page


Scenario: Check that created WR are appear at project list if WR scheme contains non empty custom field
Meta:@projects
     @gdam
Given I created the agency 'A_BUASUCMFFWR_01' with default attributes
And created users with following fields:
| Email            | Role             | Agency           |
| E_BUASUCMFFWR_08 | agency.admin     | A_BUASUCMFFWR_01 |
And logged in with details of 'GlobalAdmin'
And on the global 'adkit' metadata page for agency 'A_BUASUCMFFWR_01'
And created following Advertiser chain with checked 'Add values on the fly' checkbox on Settings and Customization page:
| Advertiser         | Brand             | Sub Brand          | Product            |
| AR_BUASUCMFFWR_S01 | B_BUASUCMFFWR_S01 | SB_BUASUCMFFWR_S01 | PT_BUASUCMFFWR_S01 |
And logged in with details of 'E_BUASUCMFFWR_08'
And created new work request with following fields:
| FieldName  | FieldValue         |
| Name       | WR_BUASUCMFFWR_S08 |
| Advertiser | AR_BUASUCMFFWR_S01 |
| Brand      | B_BUASUCMFFWR_S01  |
| Sub Brand  | SB_BUASUCMFFWR_S01 |
| Product    | PT_BUASUCMFFWR_S01 |
| Media type | Other              |
| Start date | 07.09.2012         |
| End date   | 07.09.2020         |
And created '/folder1' folder for work request 'WR_BUASUCMFFWR_S08'
And uploaded '/files/image9.jpg' file into '/folder1' folder for 'WR_BUASUCMFFWR_S08' project
When I go to file 'image9.jpg' info page in folder '/folder1' work request 'WR_BUASUCMFFWR_S08'
And refresh the page without delay
Then I 'should' see following 'custom metadata' fields in the following order on opened file info page:
| SectionName  | FieldName  | FieldValue         |
| Product Info | Advertiser | AR_BUASUCMFFWR_S01 |
| Product Info | Brand      | B_BUASUCMFFWR_S01  |
| Product Info | Sub Brand  | SB_BUASUCMFFWR_S01 |
| Product Info | Product    | PT_BUASUCMFFWR_S01 |