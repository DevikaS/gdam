!--NGN-9792
Feature:          User can edit metadata of asset shared from other BU
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user can edit metadata of asset shared from other BU

Scenario: Check that user can see catalog values from Sender BU in View mode in shared asset (Advertiser,Brand,sub-Brand,Product)
Meta:@library
     @gdam
Given I created the agency 'A_UEMDSA_S01_1' with default attributes
And created the agency 'A_UEMDSA_S01_2' with default attributes
And I created 'A_UEMDSA_R1' role with 'asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions in 'global' group for advertiser 'A_UEMDSA_S01_1'
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_UEMDSA_S01_1 | A_UEMDSA_R1     | A_UEMDSA_S01_1 |streamlined_library|
| U_UEMDSA_S01_2 | agency.admin | A_UEMDSA_S01_2 |streamlined_library|
And logged in with details of 'U_UEMDSA_S01_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue     |
| Advertiser | ADV_UEMDSA_S01 |
| Brand      | BR_UEMDSA_S01  |
| Sub Brand  | SBR_UEMDSA_S01 |
| Product    | PR_UEMDSA_S01  |
| Clock number | Clk87  |
And create 'C_UEMDSA_S01_1' category
And shared next agencies for following categories:
| CategoryName   | AgencyName     |
| C_UEMDSA_S01_1 | A_UEMDSA_S01_2 |
And login with details of 'U_UEMDSA_S01_2'
When I go to the collections page
And I go to the Shared Collection 'C_UEMDSA_S01_1' from agency 'A_UEMDSA_S01_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UEMDSA_S01_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue     |
| Advertiser | ADV_UEMDSA_S01 |
| Brand      | BR_UEMDSA_S01  |
| Sub Brand  | SBR_UEMDSA_S01 |
| Product    | PR_UEMDSA_S01  |



Scenario: Check that user cannot see catalog values from Sender BU and fields are highlighted in red in Edit mode (Advertiser,Brand,sub-Brand,Product)
Meta:@library
     @gdam
Given I created the agency 'A_UEMDSA_S02_1' with default attributes
And created the agency 'A_UEMDSA_S02_2' with default attributes
And I created 'A_UEMDSA_R2' role with 'asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions in 'global' group for advertiser 'A_UEMDSA_S02_1'
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_UEMDSA_S02_1 | A_UEMDSA_R2 | A_UEMDSA_S02_1  |streamlined_library|
| U_UEMDSA_S02_2 | agency.admin | A_UEMDSA_S02_2 |streamlined_library|
And logged in with details of 'U_UEMDSA_S02_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue     |
| Advertiser | ADV_UEMDSA_S02 |
| Brand      | BR_UEMDSA_S02  |
| Sub Brand  | SBR_UEMDSA_S02 |
| Product    | PR_UEMDSA_S02  |
| Clock number | Clk817  |
And create 'C_UEMDSA_S02_1' category
And shared next agencies for following categories:
| CategoryName   | AgencyName     |
| C_UEMDSA_S02_1 | A_UEMDSA_S02_2 |
And login with details of 'U_UEMDSA_S02_2'
When I go to the collections page
And I go to the Shared Collection 'C_UEMDSA_S02_1' from agency 'A_UEMDSA_S02_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UEMDSA_S02_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And I refresh the page
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName| FieldName  | FieldValue     |
|Product Info | Advertiser | ADV_UEMDSA_S02 |
|Product Info | Brand      | BR_UEMDSA_S02  |
|Product Info | Sub Brand  | SBR_UEMDSA_S02 |
|Product Info | Product    | PR_UEMDSA_S02  |

Scenario: Check that drop down value will be displayed in view mode if agency reciever has dropdown with same name and enabled add on the fly
Meta:@library
     @gdam
Given I created the agency 'A_UEMDSA_S03_1' with default attributes
And created the agency 'A_UEMDSA_S03_2' with default attributes
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S03_1':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | CMDDF UIRPEMD | true     | true            |
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S03_2':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | CMDDF UIRPEMD | true     | true            |
And logged in with details of 'GlobalAdmin'
And added agency 'A_UEMDSA_S03_2' as a partner to agency 'A_UEMDSA_S03_1'
And I created 'A_UEMDSA_R3' role with 'asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions in 'global' group for advertiser 'A_UEMDSA_S03_1'
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_UEMDSA_S03_1 | A_UEMDSA_R3 | A_UEMDSA_S03_1 |streamlined_library|
| U_UEMDSA_S03_2 | agency.admin | A_UEMDSA_S03_2 |streamlined_library|
And created metadata mapping from agency 'A_UEMDSA_S03_1' to agency 'A_UEMDSA_S03_2' on metadata mapping page
And logged in with details of 'U_UEMDSA_S03_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName     | FieldValue     |
| CMDDF UIRPEMD | CMDDFV UIRPEMD |
| Clock number | CM1 |
And create 'C_UEMDSA_S03_1' category
And shared next agencies for following categories:
| CategoryName   | AgencyName     |
| C_UEMDSA_S03_1 | A_UEMDSA_S03_2 |
And login with details of 'U_UEMDSA_S03_2'
When I go to the collections page
And I go to the Shared Collection 'C_UEMDSA_S03_1' from agency 'A_UEMDSA_S03_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UEMDSA_S03_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName     | FieldValue     |
| CMDDF UIRPEMD | CMDDFV UIRPEMD |



Scenario: Check that drop down value will be automatically filled in edit mode if agency reciever has dropdown with same name and enabled add on the fly ()
Meta:@library
     @gdam
Given I created the agency 'A_UEMDSA_S04_1' with default attributes
And created the agency 'A_UEMDSA_S04_2' with default attributes
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S04_1':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | CMDDF UIRPEMD | true     | true            |
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S04_2':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | CMDDF UIRPEMD | true     | true            |
And I created 'A_UEMDSA_R4' role with 'asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions in 'global' group for advertiser 'A_UEMDSA_S04_1'
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_UEMDSA_S04_1 | A_UEMDSA_R4 | A_UEMDSA_S04_1  |streamlined_library|
| U_UEMDSA_S04_2 | agency.admin | A_UEMDSA_S04_2 |streamlined_library|
And logged in with details of 'U_UEMDSA_S04_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName     | FieldValue     |
| CMDDF UIRPEMD | CMDDFV UIRPEMD |
| Clock number  | CM2            |
And create 'C_UEMDSA_S04_1' category
And shared next agencies for following categories:
| CategoryName   | AgencyName     |
| C_UEMDSA_S04_1 | A_UEMDSA_S04_2 |
And login with details of 'U_UEMDSA_S04_2'
When I go to the collections page
And I go to the Shared Collection 'C_UEMDSA_S04_1' from agency 'A_UEMDSA_S04_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UEMDSA_S04_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName| FieldName     | FieldValue     |
|Product Info | CMDDF UIRPEMD | CMDDFV UIRPEMD |


Scenario: Check that string value will be displayed in view mode if agency reciever has dropdown with same name and enabled add on the fly
Meta:@library
     @gdam
Given I created the agency 'A_UEMDSA_S05_1' with default attributes
And created the agency 'A_UEMDSA_S05_2' with default attributes
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S05_1':
| Section | FieldType | Description  |
| video   | string    | CMSF UIRPEMD |
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S05_2':
| Section | FieldType | Description  |
| video   | string    | CMSF UIRPEMD |
And I created 'A_UEMDSA_R5' role with 'asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions in 'global' group for advertiser 'A_UEMDSA_S05_1'
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_UEMDSA_S05_1 | A_UEMDSA_R5 | A_UEMDSA_S05_1 |streamlined_library|
| U_UEMDSA_S05_2 | agency.admin | A_UEMDSA_S05_2 |streamlined_library|
And logged in with details of 'U_UEMDSA_S05_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue    |
| CMSF UIRPEMD | CMSFV UIRPEMD |
| Clock number  | CM4            |
And create 'C_UEMDSA_S05_1' category
And shared next agencies for following categories:
| CategoryName   | AgencyName     |
| C_UEMDSA_S05_1 | A_UEMDSA_S05_2 |
And login with details of 'U_UEMDSA_S05_2'
When I go to the collections page
And I go to the Shared Collection 'C_UEMDSA_S05_1' from agency 'A_UEMDSA_S05_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UEMDSA_S05_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName    | FieldValue    |
| CMSF UIRPEMD | CMSFV UIRPEMD |


Scenario: Check that in shared asset could be edited metadata and successfully saved (Advertiser,brand,sub-brand,String,DropDown)
Meta:@library
     @gdam
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_UEMDSA_S06_1' with default attributes
And created the agency 'A_UEMDSA_S06_2' with default attributes
And I opened role 'agency.admin' page with parent 'A_UEMDSA_S06_2'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'A_UEMDSA_S06_R2'
And I clicked element 'SaveButton' on page 'Roles'
And update role 'A_UEMDSA_S06_R2' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,inbox.read,asset.share' permissions for advertiser 'A_UEMDSA_S06_2'
And I opened role 'agency.admin' page with parent 'A_UEMDSA_S06_1'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'A_UEMDSA_S06_R1'
And I clicked element 'SaveButton' on page 'Roles'
And update role 'A_UEMDSA_S06_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,asset_filter_category.read,asset_filter_category.write,inbox.read,asset.share,asset.read' permissions for advertiser 'A_UEMDSA_S06_1'
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S06_1':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | DROP | true     | true            |
| video   | string    | STR  |          |                 |
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S06_2':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | DROP | true     | true            |
| video   | string    | STR  |          |                 |
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_UEMDSA_S06_1 | A_UEMDSA_S06_R1   | A_UEMDSA_S06_1 |streamlined_library|
| U_UEMDSA_S06_2 | agency.admin | A_UEMDSA_S06_2 |streamlined_library|
And logged in with details of 'U_UEMDSA_S06_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And create 'C_UEMDSA_S06_1' category
And shared next agencies for following categories:
| CategoryName   | AgencyName     |
| C_UEMDSA_S06_1 | A_UEMDSA_S06_2 |
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName     | FieldValue      |
| Advertiser    | 1ADV_UEMDSA_S06 |
| Brand         | 1BR_UEMDSA_S06  |
| Sub Brand     | 1SBR_UEMDSA_S06 |
| Product       | 1PR_UEMDSA_S06  |
| STR  | S1  |
| DROP | D1 |
| Clock number  | CM5            |
And login with details of 'U_UEMDSA_S06_2'
When I go to the collections page
And I go to the Shared Collection 'C_UEMDSA_S06_1' from agency 'A_UEMDSA_S06_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UEMDSA_S06_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
Given I edited user 'U_UEMDSA_S06_2' with following fields:
|Role|
|A_UEMDSA_S06_R2|
And I logout from account
When login with details of 'U_UEMDSA_S06_2'
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName     | FieldValue      |
| Advertiser    | 2ADV_UEMDSA_S06 |
| Brand         | 2BR_UEMDSA_S06  |
| Sub Brand     | 2SBR_UEMDSA_S06 |
| Product       | 2PR_UEMDSA_S06  |
| STR           | S2              |
| DROP          |D2               |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName     | FieldValue      |
| Advertiser    | 2ADV_UEMDSA_S06 |
| Brand         | 2BR_UEMDSA_S06  |
| Sub Brand     | 2SBR_UEMDSA_S06 |
| Product       | 2PR_UEMDSA_S06  |
| STR           | S2              |
| DROP          | D1,D2           |


