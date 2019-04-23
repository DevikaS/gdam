!--NGN-9794
Feature:          User with inbox.read permission can edit asset metadata in Inbox before accepting
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check that user with inbox.read permission can edit asset metadata in Inbox before accepting


Scenario: Check that Usage Rights tab is displayed in read only mode on Asset Details
Meta: @gdam
@library
Given I created the agency 'A_UIRPEMD_S06_1' with default attributes
And created the agency 'A_UIRPEMD_S06_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPEMD_S06_1 | agency.admin | A_UIRPEMD_S06_1 |streamlined_library|
| U_UIRPEMD_S06_2 | agency.admin | A_UIRPEMD_S06_2 |streamlined_library|
And logged in with details of 'U_UIRPEMD_S06_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And created 'C_UIRPEMD_S06_1' category
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'General' for asset 'Fish1-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPEMD_S06_1 | A_UIRPEMD_S06_2 |
When I login with details of 'U_UIRPEMD_S06_2'
And I go to the collections page
And I go to asset 'Fish1-Ad.mov' info page in Library for inbox collection 'C_UIRPEMD_S06_1' of Agency 'A_UIRPEMD_S06_1'
Then I 'should not' see 'Usage Rights' tab on opened asset info pageNEWLIB



Scenario: Check that after edit 'Save & Accept' asset is removed from inbox and appear in library with proper metadata (Edit Advertiser, Brand, Sub-Brand)
Meta: @gdam
@bug
@library
!--UIR-1023
Given I logged in as 'GlobalAdmin'
Given I created the agency 'A_UIRPEMD_S01_1' with default attributes
And created the agency 'A_UIRPEMD_S01_2' with default attributes
When I open role 'agency.admin' page with parent 'A_UIRPEMD_S01_1'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_UIRPEMD_S01_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_UIRPEMD_S01_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,inbox.read' permissions for advertiser 'A_UIRPEMD_S01_1'
And create following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_UIRPEMD_S01_1':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_UIRPEMD_S01 | BR_UIRPEMD_S01 | SBR_UIRPEMD_S01 | PR_UIRPEMD_S01 |
And create users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPEMD_S01_1 | agency.admin | A_UIRPEMD_S01_1 |streamlined_library|
| U_UIRPEMD_S01_2 | A_UIRPEMD_S01_R1 | A_UIRPEMD_S01_2 |streamlined_library|
And login with details of 'U_UIRPEMD_S01_1'
And upload file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C_UIRPEMD_S01_1' category
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPEMD_S01_1 | A_UIRPEMD_S01_2 |
When I login with details of 'U_UIRPEMD_S01_2'
And I go to asset 'Fish1-Ad.mov' info page in Library for inbox collection 'C_UIRPEMD_S01_1' of Agency 'A_UIRPEMD_S01_1'
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue      |
| Advertiser | ADV_UIRPEMD_S01 |
| Brand      | BR_UIRPEMD_S01  |
| Sub Brand  | SBR_UIRPEMD_S01 |
| Product    | PR_UIRPEMD_S01  |
|Clock number| CMSF223        |
And I go to the Shared Collection 'C_UIRPEMD_S01_1' from agency 'A_UIRPEMD_S01_1' pageNEWLIB
Then I 'should not' see assets with titles 'Fish1-Ad.mov' in Shared Category 'C_UIRPEMD_S01_1'
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue      |
| Advertiser | ADV_UIRPEMD_S01 |
| Brand      | BR_UIRPEMD_S01  |
| Sub Brand  | SBR_UIRPEMD_S01 |
| Product    | PR_UIRPEMD_S01  |




Scenario: Check that after edit 'Save & Accept' asset is removed from inbox and appear in library with proper metadata (Edit custom String field)
Meta: @gdam
@library
Given I created the agency 'A_UIRPEMD_S02_1' with default attributes
And created the agency 'A_UIRPEMD_S02_2' with default attributes
And created following 'asset' custom metadata fields for agency 'A_UIRPEMD_S02_1':
| Section | FieldType | Description  |
| video   | string    | CMSF UIRPEMD |
And created following 'asset' custom metadata fields for agency 'A_UIRPEMD_S02_2':
| Section | FieldType | Description  |
| video   | string    | CMSF UIRPEMD |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPEMD_S02_1 | agency.admin | A_UIRPEMD_S02_1 |streamlined_library|
| U_UIRPEMD_S02_2 | agency.admin | A_UIRPEMD_S02_2 |streamlined_library|
And logged in with details of 'U_UIRPEMD_S02_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPEMD_S02_1' category
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPEMD_S02_1 | A_UIRPEMD_S02_2 |
When I login with details of 'U_UIRPEMD_S02_2'
And I go to asset 'Fish1-Ad.mov' info page in Library for inbox collection 'C_UIRPEMD_S02_1' of Agency 'A_UIRPEMD_S02_1'
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue    |
| CMSF UIRPEMD | CMSFV UIRPEMD |
|Clock number  | CMSF23         |
And I go to the Shared Collection 'C_UIRPEMD_S02_1' from agency 'A_UIRPEMD_S02_1' pageNEWLIB
Then I 'should not' see assets with titles 'Fish1-Ad.mov' in Shared Category 'C_UIRPEMD_S01_1'
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName    | FieldValue    |
| CMSF UIRPEMD | CMSFV UIRPEMD |


Scenario: Check that after edit 'Save & Accept' asset is removed from inbox and appear in library with proper metadata (Edit custom Dropdown field)
Meta: @gdam
@bug
@library
!--UIR-1023
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_UIRPEMD_S03_1' with default attributes
And created the agency 'A_UIRPEMD_S03_2' with default attributes
And I opened role 'agency.admin' page with parent 'A_UIRPEMD_S03_2'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'A_UIRPEMD_R1'
And I clicked element 'SaveButton' on page 'Roles'
And update role 'A_UIRPEMD_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,inbox.read,asset.share' permissions for advertiser 'A_UIRPEMD_S03_2'
And created following 'asset' custom metadata fields for agency 'A_UIRPEMD_S03_1':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | CMDDF UIRPEMD | true     | true            |
And created following 'asset' custom metadata fields for agency 'A_UIRPEMD_S03_2':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | CMDDF UIRPEMD | true     | true            |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPEMD_S03_1 | agency.admin | A_UIRPEMD_S03_1 |streamlined_library|
| U_UIRPEMD_S03_2 | A_UIRPEMD_R1 | A_UIRPEMD_S03_2 |streamlined_library|
And logged in with details of 'U_UIRPEMD_S03_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPEMD_S03_1' category
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPEMD_S03_1 | A_UIRPEMD_S03_2 |
When I login with details of 'U_UIRPEMD_S03_2'
And I go to asset 'Fish1-Ad.mov' info page in Library for inbox collection 'C_UIRPEMD_S03_1' of Agency 'A_UIRPEMD_S03_1'
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName     | FieldValue     |
| CMDDF UIRPEMD | CMDDFV UIRPEMD |
|Clock number  | CMSF234         |
And I go to the Shared Collection 'C_UIRPEMD_S03_1' from agency 'A_UIRPEMD_S03_1' pageNEWLIB
Then I 'should not' see assets with titles 'Fish1-Ad.mov' in Shared Category 'C_UIRPEMD_S01_1'
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName     | FieldValue     |
| CMDDF UIRPEMD | CMDDFV UIRPEMD |



Scenario: Check that after edit 'Save & Accept' asset, it doesn't affect parent asset
Meta: @gdam
@bug
@library
!--UIR-1023
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_UIRPEMD_S04_1' with default attributes
And created the agency 'A_UIRPEMD_S04_2' with default attributes
And I opened role 'agency.admin' page with parent 'A_UIRPEMD_S04_2'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'A_UIRPEMD_R2'
And I clicked element 'SaveButton' on page 'Roles'
And update role 'A_UIRPEMD_R2' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,inbox.read,asset.share' permissions for advertiser 'A_UIRPEMD_S04_2'
And created following 'asset' custom metadata fields for agency 'A_UIRPEMD_S04_1':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | CMDDF UIRPEMD | true     | true            |
And created following 'asset' custom metadata fields for agency 'A_UIRPEMD_S04_2':
| Section | FieldType | Description   | AddOnFly | MultipleChoices |
| video   | dropdown  | CMDDF UIRPEMD | true     | true            |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPEMD_S04_1 | agency.admin | A_UIRPEMD_S04_1 |streamlined_library|
| U_UIRPEMD_S04_2 | A_UIRPEMD_R2 | A_UIRPEMD_S04_2 |streamlined_library|
And logged in with details of 'U_UIRPEMD_S04_1'
And uploaded file '/files/Fish10-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPEMD_S04_1' category
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPEMD_S04_1 | A_UIRPEMD_S04_2 |
When I login with details of 'U_UIRPEMD_S04_2'
And I go to asset 'Fish10-Ad.mov' info page in Library for inbox collection 'C_UIRPEMD_S04_1' of Agency 'A_UIRPEMD_S04_1'
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName     | FieldValue     |
| CMDDF UIRPEMD | CMDDFV UIRPEMD |
|Clock number  | CMSF264         |
And I go to the Shared Collection 'C_UIRPEMD_S04_1' from agency 'A_UIRPEMD_S04_1' pageNEWLIB
Then I 'should not' see assets with titles 'Fish10-Ad.mov' in Shared Category 'C_UIRPEMD_S01_1'
When I go to asset 'Fish10-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName     | FieldValue     |
| CMDDF UIRPEMD | CMDDFV UIRPEMD |
When I login with details of 'U_UIRPEMD_S04_1'
When I go to asset 'Fish10-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should not' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName     | FieldValue     |
| CMDDF UIRPEMD | CMDDFV UIRPEMD |


Scenario: Check that More button, Share Asset button, Activity doesn't displayed on Asset Details
Meta: @gdam
@library
Given I created the agency 'A_UIRPEMD_S05_1' with default attributes
And created the agency 'A_UIRPEMD_S05_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPEMD_S05_1 | agency.admin | A_UIRPEMD_S05_1 |streamlined_library|
| U_UIRPEMD_S05_2 | agency.admin | A_UIRPEMD_S05_2 |streamlined_library|
And logged in with details of 'U_UIRPEMD_S05_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPEMD_S05_1' category
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPEMD_S05_1 | A_UIRPEMD_S05_2 |xczfd
When I login with details of 'U_UIRPEMD_S05_2'
And I go to the collections page
And I go to asset 'Fish1-Ad.mov' info page in Library for inbox collection 'C_UIRPEMD_S05_1' of Agency 'A_UIRPEMD_S05_1'
Then I 'should not' see 'More' tab on opened asset info pageNEWLIB
And I 'should not' see 'Share Asset' tab on opened asset info pageNEWLIB
And I 'should not' see 'Activity' tab on opened asset info pageNEWLIB


Scenario: Check that metadata is proper displayed on asset details page in inbox (Categories values, string, dropdown)
Meta: @gdam
@library
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_UIRPEMD_S07_1' with default attributes
And created the agency 'A_UIRPEMD_S07_2' with default attributes
When I open role 'agency.admin' page with parent 'A_UIRPEMD_S07_1'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMD_S07_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMD_S07_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_UIRPEMD_S07_1'
And create following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_UIRPEMD_S07_1':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_UIRPEMD_S07 | BR_UIRPEMD_S07 | SBR_UIRPEMD_S07 | PR_UIRPEMD_S07 |
And create users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_UIRPEMD_S07_1 | A_SWICMD_S07_R1 | A_UIRPEMD_S07_1 |streamlined_library|
| U_UIRPEMD_S07_2 | agency.admin | A_UIRPEMD_S07_2 |streamlined_library|
And login with details of 'U_UIRPEMD_S07_1'
And create 'C_UIRPEMD_S07_1' category
And upload file '/files/Fish1-Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue      |
| Advertiser | ADV_UIRPEMD_S07 |
| Brand      | BR_UIRPEMD_S07  |
| Sub Brand  | SBR_UIRPEMD_S07 |
| Product    | PR_UIRPEMD_S07  |
| Campaign   | C_UIRPEMD_S07   |
| Genre      | Comedy          |
| Clock number      | Clk98          |
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPEMD_S07_1 | A_UIRPEMD_S07_2 |
And login with details of 'U_UIRPEMD_S07_2'
And I go to asset 'Fish1-Ad.mov' info page in Library for inbox collection 'C_UIRPEMD_S07_1' of Agency 'A_UIRPEMD_S07_1'
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue      |
| Advertiser | ADV_UIRPEMD_S07 |
| Brand      | BR_UIRPEMD_S07  |
| Sub Brand  | SBR_UIRPEMD_S07 |
| Product    | PR_UIRPEMD_S07  |
| Campaign   | C_UIRPEMD_S07   |
| Genre      | Comedy          |


Scenario: Check that shared asset appears in matched collection after save
Meta: @gdam
@bug
@library
!--UIR-1023
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_UEMDSA_S07_1' with default attributes
And created the agency 'A_UEMDSA_S07_2' with default attributes
And I opened role 'agency.admin' page with parent 'A_UEMDSA_S07_2'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'A_UIRPEMD_R3'
And I clicked element 'SaveButton' on page 'Roles'
And update role 'A_UIRPEMD_R3' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,inbox.read,asset.share' permissions for advertiser 'A_UEMDSA_S07_2'
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S07_1':
| Section | FieldType | Description   | Choices                         |
| video   | dropdown  | CMDDF UIRPEMD | 1CMDDFV UIRPEMD,2CMDDFV UIRPEMD |
And created following 'asset' custom metadata fields for agency 'A_UEMDSA_S07_2':
| Section | FieldType | Description   | Choices                         |
| video   | dropdown  | CMDDF UIRPEMD | 1CMDDFV UIRPEMD,2CMDDFV UIRPEMD |
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_UEMDSA_S07_1 | agency.admin | A_UEMDSA_S07_1 |streamlined_library|
| U_UEMDSA_S07_2 | agency.admin | A_UEMDSA_S07_2 |streamlined_library|
And logged in with details of 'U_UEMDSA_S07_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName     | FieldValue      |
| CMDDF UIRPEMD | 1CMDDFV UIRPEMD |
| Clock number      | Clk989          |
And create 'C_UEMDSA_S07_1' category
And go to collection 'C_UEMDSA_S07_1' on administration area collections page
And switch 'on' media type filter 'video' on administration area collections page
And add following metadata on opened category page:
| FilterName    | FilterValue     |
| CMDDF UIRPEMD | 1CMDDFV UIRPEMD |
And shared next agencies for following categories:
| CategoryName   | AgencyName     |
| C_UEMDSA_S07_1 | A_UEMDSA_S07_2 |
And login with details of 'U_UEMDSA_S07_2'
And create 'C_UEMDSA_S07_2' category
And go to collection 'C_UEMDSA_S07_2' on administration area collections page
And switch 'on' media type filter 'video' on administration area collections page
And add following metadata on opened category page:
| FilterName    | FilterValue     |
| CMDDF UIRPEMD | 2CMDDFV UIRPEMD |
Given I edited user 'U_UEMDSA_S07_2' with following fields:
|Role|
|A_UIRPEMD_R3|
And I logout from account
When I login with details of 'U_UEMDSA_S07_2'
And I go to asset 'Fish1-Ad.mov' info page in Library for inbox collection 'C_UEMDSA_S07_1' of Agency 'A_UEMDSA_S07_1'
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName     | FieldValue      |
| CMDDF UIRPEMD | 2CMDDFV UIRPEMD |
| Clock number      | Clk979          |
And wait for '3' seconds
When I go to the library page for collection 'C_UEMDSA_S07_2'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'C_UEMDSA_S07_2'NEWLIB

Scenario: Check that metadata updated immediately after save
Meta: @gdam
@library
@bug
!--UIR-1023
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_UIRPEMD_S08_1' with default attributes
And created the agency 'A_UIRPEMD_S08_2' with default attributes
When I open role 'agency.admin' page with parent 'A_UIRPEMD_S08_1'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMD_S08_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMD_S08_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,inbox.read' permissions for advertiser 'A_UIRPEMD_S08_1'
And create following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_UIRPEMD_S08_1':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_UIRPEMD_S08 | BR_UIRPEMD_S08 | SBR_UIRPEMD_S08 | PR_UIRPEMD_S08 |
And create users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_UIRPEMD_S08_1 | agency.admin | A_UIRPEMD_S08_1 |streamlined_library|
| U_UIRPEMD_S08_2 | A_SWICMD_S08_R1 | A_UIRPEMD_S08_2 |streamlined_library|
And login with details of 'U_UIRPEMD_S08_1'
And upload file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C_UIRPEMD_S08_1' category
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPEMD_S08_1 | A_UIRPEMD_S08_2 |
And I login with details of 'U_UIRPEMD_S08_2'
And I go to asset 'Fish1-Ad.mov' info page in Library for inbox collection 'C_UIRPEMD_S08_1' of Agency 'A_UIRPEMD_S08_1'
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue      |
| Advertiser | ADV_UIRPEMD_S08 |
| Brand      | BR_UIRPEMD_S08  |
| Sub Brand  | SBR_UIRPEMD_S08 |
| Product    | PR_UIRPEMD_S08  |
| Clock number      | Clk99          |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue      |
| Advertiser | ADV_UIRPEMD_S08 |
| Brand      | BR_UIRPEMD_S08  |
| Sub Brand  | SBR_UIRPEMD_S08 |
| Product    | PR_UIRPEMD_S08  |

