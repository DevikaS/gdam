!--NGN-16205
Feature: Admin can set Custom Code field to be not editable manually by the user
Narrative:
In order to
As a AgencyAdmin
I want to custom code field can or can't be editable

Scenario: check user can't edit custom code field on library edit asset popup when BU admin sets FIELD-IS-EDITABLE as FALSE
Meta:@gdam
@uitobe
!--custom code generation not supported on new lib yet
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name      |
| ACSCCFEA1 |
And updated the following agency:
| Name      | A4User        |
| ACSCCFEA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| ACSCCFEU1_1 | agency.admin | ACSCCFEA1    |
| ACSCCFEU1_2 | agency.user  | ACSCCFEA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACSCCFEA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARACSCCFE1 | BRACSCCFE1 | SBACSCCFE1 | PRACSCCFE1 |
And logged in with details of 'ACSCCFEU1_1'
And I am on the 'common custom' metadata page
And clicked 'Custom Code' button in 'Custom Metadata' section on opened metadata page
And filled Description field with text 'Custom Code In Library Not Editable' on opened Settings and Customization tab
And unchecked 'Field is editable' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the 'common custom' metadata page
And clicked 'Custom Code In Library Not Editable' button in 'Common Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements  | Metadata Name                      | Metadata Characters     |
| ACSCCFEC1 | 5                   | should             | Advertiser,Brand,Sub Brand,Product | 3,2,1,1                 |
And saved metadata field settings
And logged in with details of 'ACSCCFEU1_2'
And uploaded following assets:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'
And I am on asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
When I click Edit link on asset info page
And fill asset info by following information on opened Edit Asset popup on asset info page:
| FieldName    | FieldValue |
| Advertiser   | ARACSCCFE1 |
| Brand        | BRACSCCFE1 |
| Sub Brand    | SBACSCCFE1 |
| Product      | PRACSCCFE1 |
| Title        | ACSCCFET1  |
And generate auto code value for custom code field 'Custom Code In Library Not Editable' on opened Edit Asset popup
And wait for '10' seconds
Then I should see following auto generated code '\d{2,5}ARABRSP' for field 'Custom Code In Library Not Editable' in section '' on opened Edit Asset popup
And 'should' see following fields 'Custom Code In Library Not Editable' in 'locked' state on opened Edit asset popup


Scenario: check user can edit custom code field on library edit asset popup when BU admin sets FIELD-IS-EDITABLE as TRUE
Meta:@gdam
@uitobe
!--custom code generation not supported on new lib yet
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name      |
| ACSCCFEA2 |
And updated the following agency:
| Name      | A4User        |
| ACSCCFEA2 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| ACSCCFEU2_1 | agency.admin | ACSCCFEA2    |
| ACSCCFEU2_2 | agency.user  | ACSCCFEA2    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACSCCFEA2':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARACSCCFE2 | BRACSCCFE2 | SBACSCCFE2 | PRACSCCFE2 |
And logged in with details of 'ACSCCFEU2_1'
And I am on the 'common custom' metadata page
And clicked 'Custom Code' button in 'Custom Metadata' section on opened metadata page
And filled Description field with text 'Custom Code For Library Asset Is Editable' on opened Settings and Customization tab
And checked 'Field is editable' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the 'common custom' metadata page
And clicked 'Custom Code For Library Asset Is Editable' button in 'Common Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements  | Metadata Name                      | Metadata Characters     |
| ACSCCFEC2 | 5                   | should             | Advertiser,Brand,Sub Brand,Product | 3,2,1,1                 |
And saved metadata field settings
And logged in with details of 'ACSCCFEU2_2'
And uploaded following assets:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'
And I am on asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
When I 'save' asset info by following information after edit operation on asset info page:
| FieldName                                 | FieldValue     |
| Custom Code For Library Asset Is Editable | Test with Edit |
And click Edit link on asset info page
Then I should see following auto generated code 'Test with Edit' for field 'Custom Code For Library Asset Is Editable' in section '' on opened Edit Asset popup
When I fill asset info by following information on opened Edit Asset popup on asset info page:
| FieldName    | FieldValue |
| Advertiser   | ARACSCCFE2 |
| Brand        | BRACSCCFE2 |
| Sub Brand    | SBACSCCFE2 |
| Product      | PRACSCCFE2 |
| Title        | ACSCCFET2  |
And generate auto code value for custom code field 'Custom Code For Library Asset Is Editable' on opened Edit Asset popup
And wait for '10' seconds
Then I should see following auto generated code '\d{2,5}ARABRSP' for field 'Custom Code For Library Asset Is Editable' in section '' on opened Edit Asset popup



Scenario: check user can edit custom code field on new project popup when set to TRUE by BU admin
Meta:@gdam
     @projects
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name      |
| ACSCCFEA3 |
And updated the following agency:
| Name      | A4User        |
| ACSCCFEA3 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| ACSCCFEU3_1 | agency.admin | ACSCCFEA3    |
| ACSCCFEU3_2 | agency.user  | ACSCCFEA3    |
And logged in with details of 'ACSCCFEU3_1'
And I am on the 'common custom' metadata page
And clicked 'Custom Code' button in 'Custom Metadata' section on opened metadata page
And filled Description field with text 'Custom Code For Project Is Editable' on opened Settings and Customization tab
And checked 'Field is editable' checkbox on opened string field Settings and Customization page
And checked 'Make this field available in Delivery' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the 'common custom' metadata page
And clicked 'Custom Code For Project Is Editable' button in 'Common Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Metadata Elements  | Metadata Name                      | Metadata Characters |
| ACSCCFEC3 | should             | Advertiser,Brand,Sub Brand,Product | 3,2,1,1             |
And saved metadata field settings
And logged in with details of 'ACSCCFEU3_2'
And created new project with following fields:
| FieldName                           | FieldValue   |
| Custom Code For Project Is Editable | Able to edit |
| Name                                | ACSCCFEU3    |
| Media type                          | Broadcast    |
| Start date                          | Today        |
| End date                            | Tomorrow     |
Then I 'should' see following fields on opened Project Overview page:
| FieldName                           | FieldValue   |
| Custom Code For Project Is Editable | Able to edit |


Scenario: check user can't edit custom code field on new project popup when set to FALSE by BU admin
Meta:@gdam
     @projects
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name       |
| ACSCCFEA4 |
And updated the following agency:
| Name      | A4User        |
| ACSCCFEA4 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| ACSCCFEU4_1 | agency.admin | ACSCCFEA4   |
| ACSCCFEU4_2 | agency.user  | ACSCCFEA4   |
And logged in with details of 'ACSCCFEU4_1'
And I am on the 'common custom' metadata page
And clicked 'Custom Code' button in 'Custom Metadata' section on opened metadata page
And filled Description field with text 'Custom Code For Project Not Editable' on opened Settings and Customization tab
And unchecked 'Field is editable' checkbox on opened string field Settings and Customization page
And checked 'Make this field available in Delivery' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the 'common custom' metadata page
And clicked 'Custom Code For Project Not Editable' button in 'Common Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name  | Metadata Elements | Metadata Name                      | Metadata Characters |
| ACSCCFEC4 | should            | Advertiser,Brand,Sub Brand,Product | 3,2,1,1             |
And saved metadata field settings
And logged in with details of 'ACSCCFEU4_2'
When I open Create New Project popup
Then I 'should' see 'Custom Code For Project Not Editable' field as disabled


Scenario: check user can edit custom code field of project asset popup when set to TRUE by BU admin
Meta:@gdam
     @projects
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name       |
| ACSCCFEA5 |
And updated the following agency:
| Name      | A4User        |
| ACSCCFEA5 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| ACSCCFEU5_1 | agency.admin | ACSCCFEA5    |
| ACSCCFEU5_2 | agency.user  | ACSCCFEA5    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACSCCFEA5':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARACSCCFE5 | BRACSCCFE5 | SBACSCCFE5 | PRACSCCFE5 |
And logged in with details of 'ACSCCFEU5_1'
And I am on the 'common custom' metadata page
And clicked 'Custom Code' button in 'Custom Metadata' section on opened metadata page
And filled Description field with text 'Custom Code For Project Asset Editable' on opened Settings and Customization tab
And checked 'Field is editable' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the 'common custom' metadata page
And clicked 'Custom Code For Project Asset Editable' button in 'Common Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                      | Metadata Characters |
| ACSCCFEC5 | 5                   | should            | Advertiser,Brand,Sub Brand,Product | 3,2,1,1             |
And saved metadata field settings
And logged in with details of 'ACSCCFEU5_2'
And created 'ACSCCFEP1' project
And created '/ACSCCFEF1' folder for project 'ACSCCFEP1'
And uploaded into project 'ACSCCFEP1' following files:
| FileName             | Path     |
| /files/Fish1-Ad.mov  | /ACSCCFEF1 |
And waited while transcoding is finished in folder '/ACSCCFEF1' on project 'ACSCCFEP1' files page
When I go to project 'ACSCCFEP1' overview page
And open file 'Fish1-Ad.mov' on project 'ACSCCFEP1' overview page
And click Edit link on project file info page
And fill asset info by following information on opened Edit Asset popup on asset info page:
| FieldName    | FieldValue |
| Advertiser   | ARACSCCFE5 |
| Brand        | BRACSCCFE5 |
| Sub Brand    | SBACSCCFE5 |
| Product      | PRACSCCFE5 |
| Title        | ACSCCFET5  |
And generate auto code value for custom code field 'Custom Code For Project Asset Editable' on opened Edit Asset popup
And wait for '10' seconds
Then I should see following auto generated code '\d{2,5}ARABRSP' for field 'Custom Code For Project Asset Editable' in section '' on opened Edit Asset popup


Scenario: check user can't edit custom code field on project asset popup when set to FALSE by BU admin
Meta:@gdam
     @projects
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name      |
| ACSCCFEA6 |
And updated the following agency:
| Name      | A4User        |
| ACSCCFEA6 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| ACSCCFEU6_1 | agency.admin | ACSCCFEA6    |
| ACSCCFEU6_2 | agency.user  | ACSCCFEA6    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACSCCFEA6':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARACSCCFE6 | BRACSCCFE6 | SBACSCCFE6 | PRACSCCFE6 |
And logged in with details of 'ACSCCFEU6_1'
And I am on the 'common custom' metadata page
And clicked 'Custom Code' button in 'Custom Metadata' section on opened metadata page
And filled Description field with text 'Custom Code For Project Asset Not Editable' on opened Settings and Customization tab
And unchecked 'Field is editable' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the 'common custom' metadata page
And clicked 'Custom Code For Project Asset Not Editable' button in 'Common Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                      | Metadata Characters |
| ACSCCFEC6 | 5                   | should            | Advertiser,Brand,Sub Brand,Product | 3,2,1,1             |
And saved metadata field settings
And logged in with details of 'ACSCCFEU6_2'
And created 'ACSCCFEP1' project
And created '/ACSCCFEF1' folder for project 'ACSCCFEP1'
And uploaded into project 'ACSCCFEP1' following files:
| FileName            | Path       |
| /files/Fish1-Ad.mov | /ACSCCFEF1 |
And waited while transcoding is finished in folder '/ACSCCFEF1' on project 'ACSCCFEP1' files page
When I open file 'Fish1-Ad.mov' on project 'ACSCCFEP1' overview page
And I click Edit link on project file info page
And fill asset info by following information on opened Edit Asset popup on asset info page:
| FieldName    | FieldValue |
| Advertiser   | ARACSCCFE6 |
| Brand        | BRACSCCFE6 |
| Sub Brand    | SBACSCCFE6 |
| Product      | PRACSCCFE6 |
| Title        | ACSCCFET6  |
And generate auto code value for custom code field 'Custom Code For Project Asset Not Editable' on opened Edit Asset popup
And wait for '10' seconds
Then I should see following auto generated code '\d{2,5}ARABRSP' for field 'Custom Code For Project Asset Not Editable' in section '' on opened Edit Asset popup
And 'should' see following fields 'Custom Code For Project Asset Not Editable' in 'locked' state on opened Edit asset popup