
Feature:          Asset Metadata Support values added on fly
Narrative:
As a AgencyAdmin
I want to check Asset Metadata Support values added on fly

!--QA-974
Scenario: Check that you can add values on fly for Asset when you choose 'Add values on the fly' for Advertiser, Brand, Sub brand, Product
Meta:@gdam
@library
Given I created the agency 'A_CAVF_01' with default attributes
And created users with following fields:
| Email          | Role          | AgencyUnique   | Access       |
| U_CAVF_01       | agency.admin | A_CAVF_01       | streamlined_library  |
When login with details of 'GlobalAdmin'
And go to the global 'common custom' metadata page for agency 'A_CAVF_01'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And check 'add values on the fly' following catalogue structure items on opened Settings and Customization page:
| Item       |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
And I login with details of 'U_CAVF_01'
And I upload following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
And I go to the Library page for collection 'Everything'NEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And 'save' asset 'Fish1-Ad.mov' info of collection 'Everything' by following informationNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR1                           |
| Brand                       | TAFBR1                           |
| Sub Brand                   | TAFSB1                           |
| Product                     | TAFPR1                           |
| Clock number                | testcn                           |
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR1                           |
| Brand                       | TAFBR1                           |
| Sub Brand                   | TAFSB1                           |
| Product                     | TAFPR1                           |
| Clock number                | testcn                           |
When go to the global 'common custom' metadata page for agency 'A_CAVF_01'
Then I 'should' see following Advertiser chain on Settings and Customization page:
| Advertiser         | Brand             | Sub Brand          | Product            |
| TAFAR1             | TAFBR1            | TAFSB1             | TAFPR1             |


Scenario: Check that you can add multiple values on fly for Asset when you choose 'Add values on the fly' and 'multiple choice' for Advertiser field
Meta:@gdam
@library
Given I created the agency 'A_CAMV_01' with default attributes
And created users with following fields:
| Email          | Role          | AgencyUnique   | Access       |
| U_CAMV_01       | agency.admin | A_CAMV_01       | streamlined_library  |
When login with details of 'GlobalAdmin'
And go to the global 'common custom' metadata page for agency 'A_CAMV_01'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And check 'add values on the fly' following catalogue structure items on opened Settings and Customization page:
| Item       |
| Advertiser |
And check 'multiple choices' following catalogue structure items on opened Settings and Customization page:
| Item       |
| Advertiser |
And I login with details of 'U_CAMV_01'
And I upload following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
And I go to the Library page for collection 'Everything'NEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And 'save' asset 'Fish1-Ad.mov' info of collection 'Everything' by following informationNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR1,TAFAR2                    |
| Clock number                | testcn                           |
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR1,TAFAR2                    |
| Clock number                | testcn                           |
When go to the global 'common custom' metadata page for agency 'A_CAMV_01'
Then I 'should' see following Advertiser chain on Settings and Customization page:
| Advertiser         |
| TAFAR1             |
| TAFAR2             |

Scenario: Check that you can add values on fly for Asset when you choose 'Add values on the fly' and 'multiple choice' for Custom field
Meta:@gdam
@library
Given I created the agency 'A_CAFM_01' with default attributes
And created users with following fields:
| Email          | Role          | AgencyUnique   | Access       |
| U_CAFM_01       | agency.admin | A_CAFM_01       | streamlined_library  |
When login with details of 'GlobalAdmin'
And create following 'asset' custom metadata fields for agency 'A_CAFM_01':
| Section | FieldType          | Description    | Parent         | AddOnFly | MultipleChoices |
| video   | catalogueStructure | PCSF MDMSA S04 |                | true     | true            |
And I login with details of 'U_CAFM_01'
And I upload following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
And I go to the Library page for collection 'Everything'NEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And 'save' asset 'Fish1-Ad.mov' info of collection 'Everything' by following informationNEWLIB:
| FieldName                   | FieldValue                       |
| PCSF MDMSA S04              | value1                           |
| Clock number                | testcn                           |
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| PCSF MDMSA S04              | value1                           |
When go to the global 'Video Asset' metadata page for agency 'A_CAFM_01'
And click 'PCSF MDMSA S04' button in 'Editable Metadata' section on opened metadata page
Then 'should' see following choices on opened radio buttons field Settings and Customization page:
| Choice                     |
| value1                     |

Scenario: Check that you get invalid value error if you try to add value on fly without choosing 'Add values on the fly' for Advertiser field
Meta:@gdam
@library
Given I created the agency 'A_CIVEA_01' with default attributes
And created users with following fields:
| Email          | Role          | AgencyUnique   | Access       |
| U_CIVEA_01     | agency.admin  | A_CIVEA_01     | streamlined_library  |
When login with details of 'GlobalAdmin'
And go to the global 'common custom' metadata page for agency 'A_CIVEA_01'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And uncheck 'add values on the fly' checkbox on opened string field Settings and Customization page
And save metadata field settings
And I login with details of 'U_CIVEA_01'
And I upload following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
And I go to the Library page for collection 'Everything'NEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And click Edit link on asset info pageNEWLIB
And fill asset info by following information on opened Edit Asset popup on asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR1                           |
| Clock number                | testcn                           |
Then I 'should' be able to see 'Invalid value' error for 'Advertiser'
And I 'should not' see 'save' enabled


