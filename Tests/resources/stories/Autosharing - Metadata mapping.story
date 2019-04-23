!--NGN-9829
Feature:          Autosharing - Metadata mapping
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Check fields value according to metadata mapping between business units


Scenario: Check that you can add metadata for mapped fields from the Originating BU for the asset in the Inbox Category if add on Fly is checked for User's primary BU
Meta:@library
     @gdam
     @bug
!--UIR-1023
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_CASAI_S05_8' with default attributes
And I opened role 'agency.admin' page with parent 'A_CASAI_S05_8'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'A_SWICMD_S04_R1_1'
And I clicked element 'SaveButton' on page 'Roles'
And update role 'A_SWICMD_S04_R1_1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,asset_filter_category.read,asset_filter_category.write,inbox.read,asset.share,asset.read' permissions for advertiser 'A_CASAI_S05_8'
And I created the agency 'A_CASAI_S05_7' with default attributes
And created the agency 'A_CASAI_S05_8' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CASAI_S05_7':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFAR3     | TAFBR3     | TAFSB3     | TAFSP3    |
And updated the following agency:
| Name         | Labels                  |
| A_CASAI_S05_8 | new-library-dev-version |
And added agency 'A_CASAI_S05_7' as a partner to agency 'A_CASAI_S05_8'
And created users with following fields:
| Email         | Role         | Agency        |  Access              |
| U_CASAI_S05_7 | agency.admin | A_CASAI_S05_7 |  streamlined_library |
| U_CASAI_S05_8 | A_SWICMD_S04_R1_1 | A_CASAI_S05_8 | streamlined_library  |
When login with details of 'U_CASAI_S05_7'
And create following categories:
| Name             | Media Type |
| C_CASAI_S05      | video      |
And upload following assetsNEWLIB:
| Name                   |
|/files/Fish1-Ad.mov     |
|/files/Fish2-Ad.mov     |
|/files/Fish3-Ad.mov     |
|/files/Fish4-Ad.mov     |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_CASAI_S05  | A_CASAI_S05_8 |
When login with details of 'GlobalAdmin'
And I refresh the page
And create metadata mapping from agency 'A_CASAI_S05_7' to agency 'A_CASAI_S05_8' on metadata mapping page
And go to the global 'common custom' metadata page for agency 'A_CASAI_S05_8'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And check 'add values on the fly' following catalogue structure items on opened Settings and Customization page:
| Item       |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
And login with details of 'U_CASAI_S05_8'
And I go to asset 'Fish2-Ad.mov' info page in Library for inbox collection 'C_CASAI_S05' of Agency 'A_CASAI_S05_7'
And I refresh the page
And click Edit link on asset info pageNEWLIB
And fill asset info by following information on opened Edit Asset popup on asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR3                           |
| Brand                       | TAFBR3                           |
| Sub Brand                   | TAFSB3                           |
| Product                     | TAFPR3                           |
| Clock number                | testcn                           |
And click 'Save and accept' on edit asset popup
And I go to asset 'Fish2-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR3                           |
| Brand                       | TAFBR3                           |
| Sub Brand                   | TAFSB3                           |
| Product                     | TAFPR3                           |
| Clock number                | testcn                           |
When go to the global 'common custom' metadata page for agency 'A_CASAI_S05_8'
Then I 'should' see following Advertiser chain on Settings and Customization page:
| Advertiser         | Brand             | Sub Brand          | Product            |
| TAFAR3             | TAFBR3            | TAFSB3             | TAFPR3             |

Scenario: Check that user needs to have inbox.read permission to be able to see Inbox Category
Meta:@gdam
     @library
Given I created the agency 'A_CASAI_S05_1' with default attributes
And created the agency 'A_CASAI_S05_2' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_CASAI_S05_2 | new-library-dev-version |
And added agency 'A_CASAI_S05_1' as a partner to agency 'A_CASAI_S05_2'
And I created '<roleName>' role with '<Permissions>' permissions in 'global' group for advertiser 'A_CASAI_S05_2'
And created users with following fields:
| Email         | Role         | Agency         |  Access              |
| U_CASAI_S05_1 | agency.admin | A_CASAI_S05_1 |  streamlined_library |
| <email>       | <roleName>   | A_CASAI_S05_2  | streamlined_library  |
When login with details of 'U_CASAI_S05_1'
And create following categories:
| Name             | Media Type |
| C_CASAI_S05      | video      |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_CASAI_S05  | A_CASAI_S05_2 |
When I login with details of '<email>'
And I go to the collections page
And I refresh the page
Then I '<Should>' see collection 'C_CASAI_S05' from agency 'A_CASAI_S05_1' on inbox shared collectionNEWLIB

Examples:
| email     | roleName  | Permissions  | Should     |
| ACRIRU1_1 | ACRIR_1   | dictionary.add_on_the_fly,asset.create,asset.write,asset_filter_collection.create,asset_filter_category.create,inbox.read,asset.share   | should     |
| ACRIRU1_2 | ACRIR_2   |   dictionary.add_on_the_fly,asset.create,asset.write,asset_filter_collection.create,asset_filter_category.create,asset.share           | should not |



Scenario: Check that if you cancel edit Asset popup in the Inbox category for a single Asset then the Asset is not saved in Everything and My Assets
Meta:@gdam
     @library
Given I created the agency 'A_CASAI_S05_3' with default attributes
And created the agency 'A_CASAI_S05_4' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CASAI_S05_4':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFAR2     | TAFBR2     | TAFSB2     | TAFSP2    |
And updated the following agency:
| Name         | Labels                  |
| A_CASAI_S05_4 | new-library-dev-version |
And added agency 'A_CASAI_S05_3' as a partner to agency 'A_CASAI_S05_4'
And created users with following fields:
| Email         | Role         | Agency        |  Access              |
| U_CASAI_S05_3 | agency.admin | A_CASAI_S05_3 |  streamlined_library |
| U_CASAI_S05_4 | agency.admin | A_CASAI_S05_4 | streamlined_library  |
When login with details of 'U_CASAI_S05_3'
And create following categories:
| Name             | Media Type |
| C_CASAI_S05      | video      |
And upload following assetsNEWLIB:
| Name                   |
|/files/Fish3-Ad.mov     |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_CASAI_S05  | A_CASAI_S05_4 |
When login with details of 'U_CASAI_S05_4'
And I go to asset 'Fish3-Ad.mov' info page in Library for inbox collection 'C_CASAI_S05' of Agency 'A_CASAI_S05_3'
And click Edit link on asset info pageNEWLIB
And fill asset info by following information on opened Edit Asset popup on asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR2                           |
| Brand                       | TAFBR2                           |
| Sub Brand                   | TAFSB2                           |
| Product                     | TAFPR2                           |
| Clock number                | testcn                           |
And click 'cancel' on edit asset popup
And wait for '2' seconds
Then 'should' see 'Fish3-Ad.mov' on asset preview page
When I go to  Library page for collection 'My Assets'NEWLIB
Then I 'should not' see assets with titles 'Fish3-Ad.mov' in the collection 'My Assets'NEWLIB
When I go to the collections page
And I click shared collection 'C_CASAI_S05' on the collection page for Agency 'A_CASAI_S05_3'NEWLIB
Then I 'should' see assets with titles 'Fish3-Ad.mov' in Shared Category 'C_CASAI_S05'
When I go to the library page for collection 'Everything'NEWLIB
Then I 'should not' see assets 'Fish3-Ad.mov' in the collection 'Everything'NEWLIB

Scenario: Check that you can edit Asset Metadata for unmapped fields with the metadata of Users own BU and 'Save and accept' the asset in the Edit  Asset popup
Meta:@gdam
     @library
Given I created the agency 'A_CASAI_S05_5' with default attributes
And created the agency 'A_CASAI_S05_6' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CASAI_S05_6':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFAR2     | TAFBR2     | TAFSB2     | TAFSP2    |
And updated the following agency:
| Name          | Labels                  |
| A_CASAI_S05_6 | new-library-dev-version |
And added agency 'A_CASAI_S05_5' as a partner to agency 'A_CASAI_S05_6'
And created users with following fields:
| Email         | Role         | Agency        |  Access              |
| U_CASAI_S05_5 | agency.admin | A_CASAI_S05_5 |  streamlined_library |
| U_CASAI_S05_6 | agency.admin | A_CASAI_S05_6 | streamlined_library  |
When login with details of 'U_CASAI_S05_5'
And create following categories:
| Name             | Media Type |
| C_CASAI_S05      | video      |
And upload following assetsNEWLIB:
| Name                   |
|/files/Fish3-Ad.mov     |
|/files/Fish4-Ad.mov     |
And wait while preview is visible on library page for collection 'My Assets' for assets 'Fish3-Ad.mov,Fish4-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_CASAI_S05  | A_CASAI_S05_6 |
When login with details of 'U_CASAI_S05_6'
And I go to the collections page
And I refresh the page
When I go to the Shared Collection 'C_CASAI_S05' from agency 'A_CASAI_S05_5' pageNEWLIB
And click asset 'Fish4-Ad.mov' on the collection page
And click Edit link on asset info pageNEWLIB
And fill asset info by following information on opened Edit Asset popup on asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | TAFAR2                           |
| Brand                       | TAFBR2                           |
| Sub Brand                   | TAFSB2                           |
| Clock number                | testcn                           |
| Product                     | TAFPR2                           |
And click 'Save and accept' on edit asset popup
And wait for '2' seconds
Then 'should' see 'Fish3-Ad.mov' on asset preview page
When I go to  Library page for collection 'My Assets'NEWLIB
Then I 'should' see assets with titles 'Fish4-Ad.mov' in the collection 'My Assets'NEWLIB
When I go to the collections page
And I refresh the page
When I go to the Shared Collection 'C_CASAI_S05' from agency 'A_CASAI_S05_5' pageNEWLIB
Then I 'should not' see assets 'Fish4-Ad.mov' on Shared collection pageNEWLIB
When I go to the library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish4-Ad.mov' in the collection 'Everything'NEWLIB


Scenario: Check that values appear in asset (common field mapping specific case)
Meta:@gdam
     @library
Given I logged in with details of 'GlobalAdmin'
And I created the agency 'A_CASAI_S05_7_1' with default attributes
And created the agency 'A_CASAI_S05_8_1' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_CASAI_S05_8_1 | new-library-dev-version |
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CASAI_S05_7_1':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ACASAI        | BCASAI       | SBCASAI       | PCASAI       |
And updated following 'common' custom metadata fields for agency 'A_CASAI_S05_8_1':
| FieldType          | Description | Parent     | AddOnFly |
| catalogueStructure | Advertiser  |            | true     |
| catalogueStructure | Brand       | Advertiser | true     |
| catalogueStructure | Sub Brand   | Brand      | true     |
| catalogueStructure | Product     | Sub Brand  | true     |
And created users with following fields:
| Email         | Role         | Agency        | Access           |
| U_CASAI_S05_7_1 | agency.admin | A_CASAI_S05_7_1 | streamlined_library |
| U_CASAI_S05_8_1 | agency.admin | A_CASAI_S05_8_1 | streamlined_library |
And added agency 'A_CASAI_S05_7_1' as a partner to agency 'A_CASAI_S05_8_1'
And I have refreshed the page
And created metadata mapping from agency 'A_CASAI_S05_7_1' to agency 'A_CASAI_S05_8_1' on metadata mapping page
And removed following 'Common' mapped items on metadata mapping page from agency 'A_CASAI_S05_7_1' to agency 'A_CASAI_S05_8_1':
| FieldFrom  | FieldTo    |
| Advertiser | Advertiser |
| Brand      | Brand      |
| Sub Brand  | Sub Brand  |
| Product    | Product    |
And mapped following 'Common' fields from agency 'A_CASAI_S05_7_1' to agency 'A_CASAI_S05_8_1' on metadata mapping edit page:
| GroupFrom     | FieldFrom  | GroupTo       | FieldTo    |
| Common Custom | Advertiser | Common Custom | Brand      |
| Common Custom | Brand      | Common Custom | Sub Brand  |
| Common Custom | Sub Brand  | Common Custom | Product    |
| Common Custom | Product    | Common Custom | Advertiser |
And logged in with details of 'U_CASAI_S05_7_1'
And created 'C_CASAI_S01' category
And uploaded asset '/files/128_shortname.jpg' into libraryNEWLIB
And waited while preview is available in collection 'C_CASAI_S01'NEWLIB
And I have refreshed the page
When I 'save' asset '128_shortname.jpg' info of collection 'C_CASAI_S01' by following informationNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | ACASAI        |
| Brand      | BCASAI        |
| Sub Brand  | SBCASAI       |
| Product    | PCASAI        |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_CASAI_S01  | A_CASAI_S05_8_1|
And login with details of 'U_CASAI_S05_8_1'
And accept all assets on Shared Collection 'C_CASAI_S01' from agency 'A_CASAI_S05_7_1' pageNEWLIB
And go to asset '128_shortname.jpg' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | PCASAI        |
| Brand      | ACASAI        |
| Sub Brand  | BCASAI        |
| Product    | SBCASAI       |


Scenario: Check mapping field with 'Dropdown' type after sharing Video asset
Meta:@gdam
     @library
Given I created the agency 'A_CASAI_S05_9' with default attributes
And created the agency 'A_CASAI_S05_10' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_CASAI_S05_10 | new-library-dev-version |
And updated following 'asset' custom metadata fields for agency 'A_CASAI_S05_9':
| Section | FieldType | Description      | Choices                 |
| video   | dropdown  | Account Director | Sergeant Harrison Yates |
And updated following 'asset' custom metadata fields for agency 'A_CASAI_S05_10':
| Section | FieldType | Description      | AddOnFly |
| video   | dropdown  | Account Director | true     |
And created users with following fields:
| Email         | Role         | Agency        | Access               |
| U_CASAI_S05_9 | agency.admin | A_CASAI_S05_9 |streamlined_library   |
| U_CASAI_S05_10 | agency.admin | A_CASAI_S05_10 |streamlined_library   |
And added agency 'A_CASAI_S05_9' as a partner to agency 'A_CASAI_S05_10'
When login with details of 'GlobalAdmin'
And wait for '2' seconds
And create metadata mapping from agency 'A_CASAI_S05_9' to agency 'A_CASAI_S05_10' on metadata mapping page
And login with details of 'U_CASAI_S05_9'
And create 'C_CASAI_S03' category
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And wait while preview is available in collection 'C_CASAI_S03'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'C_CASAI_S03' by following informationNEWLIB:
| FieldName        | FieldValue              |
| Account Director | Sergeant Harrison Yates |
| Clock number                | testcn                           |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_CASAI_S03  | A_CASAI_S05_10 |
And login with details of 'U_CASAI_S05_10'
And accept all assets on Shared Collection 'C_CASAI_S03' from agency 'A_CASAI_S05_9' pageNEWLIB
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName        | FieldValue              |
| Account Director | Sergeant Harrison Yates |
When login with details of 'GlobalAdmin'
And go to the global 'video asset' metadata page for agency 'A_CASAI_S05_10'
Then I 'should' see following 'dropdown' 'Account Director' choices in Active Metadata Preview block on opened metadata page:
| Choice                  |
| Sergeant Harrison Yates |


Scenario: Check that values for Common fields appear after sharing between BU (Advertiser - Brand - SubBrand default case)
Meta: @library
      @gdam
Given I created the agency 'A_MDMSA_S01_1' with default attributes
And created the agency 'A_MDMSA_S01_2' with default attributes
And added agency 'A_MDMSA_S01_2' as a partner to agency 'A_MDMSA_S01_1'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_MDMSA_S01_1':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_MDMSA_S01 | BR_MDMSA_S01 | SBR_MDMSA_S01 | PR_MDMSA_S01 |
And updated following 'common' custom metadata fields for agency 'A_MDMSA_S01_2':
| FieldType          | Description | Parent     | AddOnFly |
| catalogueStructure | Advertiser  |            | true     |
| catalogueStructure | Brand       | Advertiser | true     |
| catalogueStructure | Sub Brand   | Brand      | true     |
| catalogueStructure | Product     | Sub Brand  | true     |
And created users with following fields:
| Email         | Role         | Agency        |Access|
| U_MDMSA_S01_1 | agency.admin | A_MDMSA_S01_1 |streamlined_library|
| U_MDMSA_S01_2 | agency.admin | A_MDMSA_S01_2 |streamlined_library|
And created metadata mapping from agency 'A_MDMSA_S01_1' to agency 'A_MDMSA_S01_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S01_1'
And created 'C_MDMSA_S01' category
And uploaded asset '/files/128_shortname.jpg' into libraryNEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I 'save' asset '128_shortname.jpg' info of collection 'C_MDMSA_S01' by following informationNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | ADV_MDMSA_S01 |
| Brand      | BR_MDMSA_S01  |
| Sub Brand  | SBR_MDMSA_S01 |
| Product    | PR_MDMSA_S01  |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S01  | A_MDMSA_S01_2 |
And login with details of 'U_MDMSA_S01_2'
When I go to the collections page
And I go to the Shared Collection 'C_MDMSA_S01' from agency 'A_MDMSA_S01_1' pageNEWLIB
And I select asset '128_shortname.jpg' for collection 'C_MDMSA_S01' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset '128_shortname.jpg' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | ADV_MDMSA_S01 |
| Brand      | BR_MDMSA_S01  |
| Sub Brand  | SBR_MDMSA_S01 |
| Product    | PR_MDMSA_S01  |

Scenario: Check mapping fields with 'Catalog structure' type (custom fields) after sharing Print asset
Meta:@library
     @gdam
Given I created the agency 'A_MDMSA_S04_1' with default attributes
And created the agency 'A_MDMSA_S04_2' with default attributes
And I opened role 'agency.admin' page with parent 'A_MDMSA_S04_1'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'A_MDMSA_S04_R2'
And I clicked element 'SaveButton' on page 'Roles'
And update role 'A_MDMSA_S04_R2' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create,inbox.read,asset.share' permissions for advertiser 'A_MDMSA_S04_1'
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S04_1':
| Section | FieldType          | Description    | Parent         | AddOnFly |
| print   | catalogueStructure | PCSF MDMSA S04 |                | true     |
| print   | catalogueStructure | CCSF MDMSA S04 | PCSF MDMSA S04 | true     |
And created following catalogue structure items chains in 'print' section of 'asset' schema for agency 'A_MDMSA_S04_1':
| PCSF MDMSA S04 | CCSF MDMSA S04 |
| PCSF_MDMSA_S04 | CCSF_MDMSA_S04 |
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S04_2':
| Section | FieldType           | Description    | Parent         | AddOnFly |
| print   | catalogueStructure  | PCSF MDMSA S04 |                | true     |
| print   | catalogueStructure  | CCSF MDMSA S04 | PCSF MDMSA S04 | true     |
And created users with following fields:
| Email         | Role         | Agency        |Access|
| U_MDMSA_S04_1 | agency.admin | A_MDMSA_S04_1 |streamlined_library|
| U_MDMSA_S04_2 | agency.admin | A_MDMSA_S04_2 |streamlined_library|
And added agency 'A_MDMSA_S04_2' as a partner to agency 'A_MDMSA_S04_1'
And I have refreshed the page
And created metadata mapping from agency 'A_MDMSA_S04_1' to agency 'A_MDMSA_S04_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S04_1'
And created 'C_MDMSA_S04' category
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S04  | A_MDMSA_S04_2 |
And uploaded asset '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
And I edited user 'U_MDMSA_S04_1' with following fields:
|Role|
|A_MDMSA_S04_R2|
And I logout from account
And logged in with details of 'U_MDMSA_S04_1'
When I 'save' asset 'GWGTest2.pdf' info of collection 'C_MDMSA_S04' by following informationNEWLIB:
| FieldName      | FieldValue     |
| PCSF MDMSA S04 | PCSF_MDMSA_S04 |
| CCSF MDMSA S04 | PCSF_MDMSA_S04 |
And login with details of 'U_MDMSA_S04_2'
And I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_MDMSA_S04' from agency 'A_MDMSA_S04_1' pageNEWLIB
And I select asset 'GWGTest2.pdf' for collection 'C_MDMSA_S04' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'GWGTest2.pdf' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue     |
| PCSF MDMSA S04 | PCSF_MDMSA_S04 |
| CCSF MDMSA S04 | PCSF_MDMSA_S04 |



Scenario: Check mapping field with 'String' type after sharing Audio asset
Meta: @library
     @gdam
Given I created the agency 'A_MDMSA_S05_1' with default attributes
And created the agency 'A_MDMSA_S05_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| U_MDMSA_S05_1 | agency.admin | A_MDMSA_S05_1 |streamlined_library|
| U_MDMSA_S05_2 | agency.admin | A_MDMSA_S05_2 |streamlined_library|
And added agency 'A_MDMSA_S05_2' as a partner to agency 'A_MDMSA_S05_1'
And I have refreshed the page
And created metadata mapping from agency 'A_MDMSA_S05_1' to agency 'A_MDMSA_S05_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S05_1'
And created 'C_MDMSA_S05' category
And uploaded asset '/files/Fish1-Ad.mp3' into libraryNEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I 'save' asset 'Fish1-Ad.mp3' info of collection 'C_MDMSA_S05' by following informationNEWLIB:
| FieldName  | FieldValue    |
| JCN Number | JCN_MDMSA_S05 |
| Campaign   | CMP_S05 |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S05  | A_MDMSA_S05_2 |
And login with details of 'U_MDMSA_S05_2'
And I go to the collections page
And I go to the Shared Collection 'C_MDMSA_S05' from agency 'A_MDMSA_S05_1' pageNEWLIB
And I refresh the page
And I select asset 'Fish1-Ad.mp3' for collection 'C_MDMSA_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'Fish1-Ad.mp3' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| JCN Number | JCN_MDMSA_S05 |


Scenario: Check mapping field with 'Date' type after sharing Image asset
Meta: @library
     @gdam
Given I created the agency 'A_MDMSA_S06_1' with default attributes
And created the agency 'A_MDMSA_S06_2' with default attributes
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S06_1':
| Section | FieldType | Description  |
| image   | date      | DF MDMSA S06 |
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S06_2':
| Section | FieldType | Description  |
| image   | date      | DF MDMSA S06 |
And created users with following fields:
| Email         | Role         | Agency        |Access|
| U_MDMSA_S06_1 | agency.admin | A_MDMSA_S06_1 |streamlined_library|
| U_MDMSA_S06_2 | agency.admin | A_MDMSA_S06_2 |streamlined_library|
And added agency 'A_MDMSA_S06_2' as a partner to agency 'A_MDMSA_S06_1'
And I have refreshed the page
And created metadata mapping from agency 'A_MDMSA_S06_1' to agency 'A_MDMSA_S06_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S06_1'
And created 'C_MDMSA_S06' category
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S06  | A_MDMSA_S06_2 |
And uploaded asset '/files/128_shortname.jpg' into libraryNEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I 'save' asset '128_shortname.jpg' info of collection 'C_MDMSA_S06' by following informationNEWLIB:
| FieldName    | FieldValue |
| DF MDMSA S06 | 12/12/20 |
| Campaign | CAM_01 |
And login with details of 'U_MDMSA_S06_2'
And I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_MDMSA_S06' from agency 'A_MDMSA_S06_1' pageNEWLIB
And I select asset '128_shortname.jpg' for collection 'C_MDMSA_S06' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset '128_shortname.jpg' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
| DF MDMSA S06 | 12/12/2020 |



Scenario: Check mapping field with 'Radiobutton' type after sharing Print asset (the same choices)
Meta: @library
     @gdam
Given I created the agency 'A_MDMSA_S07_1' with default attributes
And created the agency 'A_MDMSA_S07_2' with default attributes
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S07_1':
| Section | FieldType    | Description   | Choices          |
| print   | radioButtons | RBF MDMSA S07 | RBFV_MDMSA_S07_1 |
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S07_2':
| Section | FieldType    | Description   | Choices          |
| print   | radioButtons | RBF MDMSA S07 | RBFV_MDMSA_S07_1 |
And added agency 'A_MDMSA_S07_2' as a partner to agency 'A_MDMSA_S07_1'
And I have refreshed the page
And created metadata mapping from agency 'A_MDMSA_S07_1' to agency 'A_MDMSA_S07_2' on metadata mapping page
And created users with following fields:
| Email         | Role         | Agency        |Access|
| U_MDMSA_S07_1 | agency.admin | A_MDMSA_S07_1 |streamlined_library|
| U_MDMSA_S07_2 | agency.admin | A_MDMSA_S07_2 |streamlined_library|
And logged in with details of 'U_MDMSA_S07_1'
And created 'C_MDMSA_S07' category
And uploaded asset '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I 'save' asset 'GWGTest2.pdf' info of collection 'C_MDMSA_S07' by following informationNEWLIB:
| FieldName     | FieldValue       |
| RBF MDMSA S07 | RBFV_MDMSA_S07_1 |
| Campaign | CAM_02 |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S07  | A_MDMSA_S07_2 |
And login with details of 'U_MDMSA_S07_2'
And I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_MDMSA_S07' from agency 'A_MDMSA_S07_1' pageNEWLIB
And I select asset 'GWGTest2.pdf' for collection 'C_MDMSA_S07' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'GWGTest2.pdf' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName     | FieldValue       |
| RBF MDMSA S07 | RBFV_MDMSA_S07_1 |



Scenario: Check mapping field with 'Phone' type after sharing Video asset
Meta:@library
     @gdam
Given I created the agency 'A_MDMSA_S08_1' with default attributes
And created the agency 'A_MDMSA_S08_2' with default attributes
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S08_1':
| Section | FieldType | Description   |
| video   | phone     | PHF MDMSA S08 |
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S08_2':
| Section | FieldType | Description   |
| video   | phone     | PHF MDMSA S08 |
And added agency 'A_MDMSA_S08_2' as a partner to agency 'A_MDMSA_S08_1'
And I have refreshed the page
And created metadata mapping from agency 'A_MDMSA_S08_1' to agency 'A_MDMSA_S08_2' on metadata mapping page
And created users with following fields:
| Email         | Role         | Agency        |Access|
| U_MDMSA_S08_1 | agency.admin | A_MDMSA_S08_1 |streamlined_library|
| U_MDMSA_S08_2 | agency.admin | A_MDMSA_S08_2 |streamlined_library|
And logged in with details of 'U_MDMSA_S08_1'
And created 'C_MDMSA_S08' category
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'C_MDMSA_S08' by following informationNEWLIB:
| FieldName     | FieldValue |
| PHF MDMSA S08 | 0158965247 |
| Clock number  | Clk_012 |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S08  | A_MDMSA_S08_2 |
And login with details of 'U_MDMSA_S08_2'
And I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_MDMSA_S08' from agency 'A_MDMSA_S08_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_MDMSA_S08' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName     | FieldValue |
| PHF MDMSA S08 | 0158965247 |



Scenario: Check mapping field with 'Hyperlink' type after sharing Video asset
Meta:@skip
     @gdam
!-- Maria said that this test could be skipped (similar issue NGN-9568)
Given I created the agency 'A_MDMSA_S09_1' with default attributes
And created the agency 'A_MDMSA_S09_2' with default attributes
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S09_1':
| Section | FieldType | Description   |
| video   | hyperlink | HLF MDMSA S09 |
And created following 'asset' custom metadata fields for agency 'A_MDMSA_S09_2':
| Section | FieldType | Description   |
| video   | hyperlink | HLF MDMSA S09 |
And created users with following fields:
| Email         | Role         | Agency        |
| U_MDMSA_S09_1 | agency.admin | A_MDMSA_S09_1 |
| U_MDMSA_S09_2 | agency.admin | A_MDMSA_S09_2 |
And added agency 'A_MDMSA_S09_2' as a partner to agency 'A_MDMSA_S09_1'
And created metadata mapping from agency 'A_MDMSA_S09_1' to agency 'A_MDMSA_S09_2' on metadata mapping page
And mapped following 'Video' fields from agency 'A_MDMSA_S09_1' to agency 'A_MDMSA_S09_2' on metadata mapping edit page:
| GroupFrom     | FieldFrom     | GroupTo       | FieldTo       |
| Without group | HLF MDMSA S09 | Without group | HLF MDMSA S09 |
And logged in with details of 'U_MDMSA_S09_1'
And created 'C_MDMSA_S09' category
And uploaded asset '/files/Fish1-Ad.mov' into library
And waited while preview is available in collection 'C_MDMSA_S09'
When I 'save' asset 'Fish1-Ad.mov' info of collection 'C_MDMSA_S09' by following information:
| FieldName     | FieldValue   |
| HLF MDMSA S09 | http://ya.ru |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S09  | A_MDMSA_S09_2 |
And login with details of 'U_MDMSA_S09_2'
And accept all assets on Shared Collection 'C_MDMSA_S09' from agency 'A_MDMSA_S09_1' page
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'
Then I 'should' see following 'custom metadata' fields on opened asset info page:
| FieldName     | FieldValue   |
| HLF MDMSA S09 | http://ya.ru |


Scenario: Check that changing value on original asset doesn't affect value on accepted asset
Meta:@library
     @gdam
Given I created the agency 'A_MDMSA_S10_1' with default attributes
And created the agency 'A_MDMSA_S10_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| U_MDMSA_S10_1 | agency.admin | A_MDMSA_S10_1 |streamlined_library|
| U_MDMSA_S10_2 | agency.admin | A_MDMSA_S10_2 |streamlined_library|
And added agency 'A_MDMSA_S10_2' as a partner to agency 'A_MDMSA_S10_1'
And I have refreshed the page
And created metadata mapping from agency 'A_MDMSA_S10_1' to agency 'A_MDMSA_S10_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S10_1'
And created 'C_MDMSA_S10' category
And uploaded asset '/files/Fish1-Ad.mp3' into libraryNEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I 'save' asset 'Fish1-Ad.mp3' info of collection 'C_MDMSA_S10' by following informationNEWLIB:
| FieldName  | FieldValue    |
| JCN Number | JCN_MDMSA_S10 |
| Campaign | CAM_04 |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S10  | A_MDMSA_S10_2 |
And login with details of 'U_MDMSA_S10_2'
And I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_MDMSA_S10' from agency 'A_MDMSA_S10_1' pageNEWLIB
And I select asset 'Fish1-Ad.mp3' for collection 'C_MDMSA_S10' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And login with details of 'U_MDMSA_S10_1'
And 'save' asset 'Fish1-Ad.mp3' info of collection 'C_MDMSA_S10' by following informationNEWLIB:
| FieldName  | FieldValue            |
| JCN Number | CHANGED JCN_MDMSA_S10 |
| Campaign | CAM_05 |
And login with details of 'U_MDMSA_S10_2'
And go to asset 'Fish1-Ad.mp3' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| JCN Number | JCN_MDMSA_S10 |


Scenario: Check that new value appears in dictionary after accept asset (Metadata editor in Admin)
Meta:@library
     @gdam
Given I created the agency 'A_MDMSA_S11_1' with default attributes
And created the agency 'A_MDMSA_S11_2' with default attributes
And updated following 'asset' custom metadata fields for agency 'A_MDMSA_S11_1':
| Section | FieldType | Description      | Choices                 |
| video   | dropdown  | Account Director | Sergeant Harrison Yates |
And updated following 'asset' custom metadata fields for agency 'A_MDMSA_S11_2':
| Section | FieldType | Description      | AddOnFly |
| video   | dropdown  | Account Director | true     |
And created users with following fields:
| Email         | Role         | Agency        |Access|
| U_MDMSA_S11_1 | agency.admin | A_MDMSA_S11_1 |streamlined_library|
| U_MDMSA_S11_2 | agency.admin | A_MDMSA_S11_2 |streamlined_library|
And added agency 'A_MDMSA_S11_2' as a partner to agency 'A_MDMSA_S11_1'
And I have refreshed the page
And created metadata mapping from agency 'A_MDMSA_S11_1' to agency 'A_MDMSA_S11_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S11_1'
And created 'C_MDMSA_S11' category
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'C_MDMSA_S11'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'C_MDMSA_S11' by following informationNEWLIB:
| FieldName        | FieldValue              |
| Account Director | Sergeant Harrison Yates |
| Clock number     | Clk10 |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S11  | A_MDMSA_S11_2 |
And login with details of 'U_MDMSA_S11_2'
And I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_MDMSA_S11' from agency 'A_MDMSA_S11_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_MDMSA_S11' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And login with details of 'GlobalAdmin'
And go to the global 'video asset' metadata page for agency 'A_MDMSA_S11_2'
Then I 'should' see following 'dropdown' 'Account Director' choices in Active Metadata Preview block on opened metadata page:
| Choice                  |
| Sergeant Harrison Yates |

Scenario: Allow extend dictionaries when accepting shared assets" is TICKED  & for metadata Advertiser "Add values on the fly" is TICKED
Meta:@globaladmin
     @gdam
Given I created the agency 'A_MDMSA_S12_1' with default attributes
And created the agency 'A_MDMSA_S12_2' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_MDMSA_S12_1':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_MDMSA_S12 | BR_MDMSA_S12 | SBR_MDMSA_S12 | PR_MDMSA_S12 |
And updated following 'common' custom metadata fields for agency 'A_MDMSA_S12_2':
| FieldType          | Description | Parent     | AddOnFly |
| catalogueStructure | Advertiser  |            | true     |
| catalogueStructure | Brand       | Advertiser | true     |
| catalogueStructure | Sub Brand   | Brand      | true     |
| catalogueStructure | Product     | Sub Brand  | true     |
And created users with following fields:
| Email         | Role         | Agency        |
| U_MDMSA_S12_1 | agency.admin | A_MDMSA_S12_1 |
| U_MDMSA_S12_2 | agency.admin | A_MDMSA_S12_2 |
And added agency 'A_MDMSA_S12_2' as a partner to agency 'A_MDMSA_S12_1'
And created metadata mapping from agency 'A_MDMSA_S12_1' to agency 'A_MDMSA_S12_2' on metadata mapping page
And I updated agency 'A_MDMSA_S12_2' with following fields on agency overview page:
| FieldName                                              | FieldValue   |
| Allow extend dictionaries when accepting shared assets | true         |
And logged in with details of 'U_MDMSA_S12_1'
And created 'C_MDMSA_S12' category
And uploaded asset '/files/128_shortname.jpg' into library
And waited while preview is available in collection 'C_MDMSA_S12'
When I 'save' asset '128_shortname.jpg' info of collection 'C_MDMSA_S12' by following information:
| FieldName  | FieldValue    |
| Advertiser | ADV_MDMSA_S12 |
| Brand      | BR_MDMSA_S12  |
| Sub Brand  | SBR_MDMSA_S12 |
| Product    | PR_MDMSA_S12  |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S12  | A_MDMSA_S12_2 |
And login with details of 'U_MDMSA_S12_2'
And accept all assets on Shared Collection 'C_MDMSA_S12' from agency 'A_MDMSA_S12_1' page
And go to asset '128_shortname.jpg' info page in Library for collection 'Everything'
Then I 'should' see following 'custom metadata' fields on opened asset info page:
| FieldName  | FieldValue     |
| Advertiser | ADV_MDMSA_S12  |
| Brand      | BR_MDMSA_S12   |
| Sub Brand  | SBR_MDMSA_S12  |
| Product    | PR_MDMSA_S12   |
When login with details of 'GlobalAdmin'
And I go to the global 'common custom' metadata page for agency 'A_MDMSA_S12_2'
Then I 'should' see following Advertiser chain on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| ADV_MDMSA_S12   | BR_MDMSA_S12   | SBR_MDMSA_S12   | PR_MDMSA_S12    |

Scenario: Allow extend dictionaries when accepting shared assets" is UNTICKED  & for metadata Advertiser "Add values on the fly" is TICKED
Meta:@globaladmin
     @gdam
Given I created the agency 'A_MDMSA_S13_1' with default attributes
And I created the following agency:
| Name          | Allow extend dictionaries when accepting shared assets |
| A_MDMSA_S13_2 | should not                                             |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_MDMSA_S13_1':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_MDMSA_S13 | BR_MDMSA_S13 | SBR_MDMSA_S13 | PR_MDMSA_S13 |
And updated following 'common' custom metadata fields for agency 'A_MDMSA_S13_2':
| FieldType          | Description | Parent     | AddOnFly |
| catalogueStructure | Advertiser  |            | true     |
| catalogueStructure | Brand       | Advertiser | true     |
| catalogueStructure | Sub Brand   | Brand      | true     |
| catalogueStructure | Product     | Sub Brand  | true     |
And created users with following fields:
| Email         | Role         | Agency        |
| U_MDMSA_S13_1 | agency.admin | A_MDMSA_S13_1 |
| U_MDMSA_S13_2 | agency.admin | A_MDMSA_S13_2 |
And added agency 'A_MDMSA_S13_2' as a partner to agency 'A_MDMSA_S13_1'
And created metadata mapping from agency 'A_MDMSA_S13_1' to agency 'A_MDMSA_S13_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S13_1'
And created 'C_MDMSA_S13' category
And uploaded asset '/files/128_shortname.jpg' into library
And waited while preview is available in collection 'C_MDMSA_S13'
When I 'save' asset '128_shortname.jpg' info of collection 'C_MDMSA_S13' by following information:
| FieldName  | FieldValue    |
| Advertiser | ADV_MDMSA_S13 |
| Brand      | BR_MDMSA_S13  |
| Sub Brand  | SBR_MDMSA_S13 |
| Product    | PR_MDMSA_S13  |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S13  | A_MDMSA_S13_2 |
And login with details of 'U_MDMSA_S13_2'
And accept all assets on Shared Collection 'C_MDMSA_S13' from agency 'A_MDMSA_S13_1' page
And go to asset '128_shortname.jpg' info page in Library for collection 'Everything'
Then I 'should' see following 'custom metadata' fields on opened asset info page:
| FieldName  | FieldValue     |
| Advertiser | ADV_MDMSA_S13  |
| Brand      | BR_MDMSA_S13   |
| Sub Brand  | SBR_MDMSA_S13  |
| Product    | PR_MDMSA_S13   |
When login with details of 'GlobalAdmin'
And I go to the global 'common custom' metadata page for agency 'A_MDMSA_S13_2'
Then I 'should not' see following Advertiser chain on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| ADV_MDMSA_S13   | BR_MDMSA_S13   | SBR_MDMSA_S13   | PR_MDMSA_S13    |

Scenario: Allow extend dictionaries when accepting shared assets" is UNTICKED  & for metadata Advertiser "Add values on the fly" is UNTICKED
Meta:@globaladmin
     @gdam
Given I created the agency 'A_MDMSA_S14_1' with default attributes
And I created the following agency:
| Name          | Allow extend dictionaries when accepting shared assets |
| A_MDMSA_S14_2 | should not                                             |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_MDMSA_S14_1':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_MDMSA_S14 | BR_MDMSA_S14 | SBR_MDMSA_S14 | PR_MDMSA_S14 |
And updated following 'common' custom metadata fields for agency 'A_MDMSA_S14_2':
| FieldType          | Description | Parent     | AddOnFly |
| catalogueStructure | Advertiser  |            | false     |
| catalogueStructure | Brand       | Advertiser | false     |
| catalogueStructure | Sub Brand   | Brand      | false     |
| catalogueStructure | Product     | Sub Brand  | false     |
And created users with following fields:
| Email         | Role         | Agency        |
| U_MDMSA_S14_1 | agency.admin | A_MDMSA_S14_1 |
| U_MDMSA_S14_2 | agency.admin | A_MDMSA_S14_2 |
And added agency 'A_MDMSA_S14_2' as a partner to agency 'A_MDMSA_S14_1'
And created metadata mapping from agency 'A_MDMSA_S14_1' to agency 'A_MDMSA_S14_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S14_1'
And created 'C_MDMSA_S14' category
And uploaded asset '/files/128_shortname.jpg' into library
And waited while preview is available in collection 'C_MDMSA_S14'
When I 'save' asset '128_shortname.jpg' info of collection 'C_MDMSA_S14' by following information:
| FieldName  | FieldValue    |
| Advertiser | ADV_MDMSA_S14 |
| Brand      | BR_MDMSA_S14  |
| Sub Brand  | SBR_MDMSA_S14 |
| Product    | PR_MDMSA_S14  |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S14  | A_MDMSA_S14_2 |
And login with details of 'U_MDMSA_S14_2'
And accept all assets on Shared Collection 'C_MDMSA_S14' from agency 'A_MDMSA_S14_1' page
When login with details of 'GlobalAdmin'
And I go to the global 'common custom' metadata page for agency 'A_MDMSA_S14_2'
Then I 'should not' see following Advertiser chain on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| ADV_MDMSA_S14   | BR_MDMSA_S14   | SBR_MDMSA_S14   | PR_MDMSA_S14    |

Scenario: Allow extend dictionaries when accepting shared assets" is TICKED  & for metadata Advertiser "Add values on the fly" is UNTICKED
Meta:@globaladmin
     @gdam
Given I created the agency 'A_MDMSA_S15_1' with default attributes
And I created the following agency:
| Name          | Allow extend dictionaries when accepting shared assets |
| A_MDMSA_S15_2 | should                                                 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_MDMSA_S15_1':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_MDMSA_S15 | BR_MDMSA_S15 | SBR_MDMSA_S15 | PR_MDMSA_S15 |
And updated following 'common' custom metadata fields for agency 'A_MDMSA_S15_2':
| FieldType          | Description | Parent     | AddOnFly |
| catalogueStructure | Advertiser  |            | false    |
| catalogueStructure | Brand       | Advertiser | false    |
| catalogueStructure | Sub Brand   | Brand      | false    |
| catalogueStructure | Product     | Sub Brand  | false     |
And created users with following fields:
| Email         | Role         | Agency        |
| U_MDMSA_S15_1 | agency.admin | A_MDMSA_S15_1 |
| U_MDMSA_S15_2 | agency.admin | A_MDMSA_S15_2 |
And added agency 'A_MDMSA_S15_2' as a partner to agency 'A_MDMSA_S15_1'
And created metadata mapping from agency 'A_MDMSA_S15_1' to agency 'A_MDMSA_S15_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S15_1'
And created 'C_MDMSA_S15' category
And uploaded asset '/files/128_shortname.jpg' into library
And waited while preview is available in collection 'C_MDMSA_S15'
When I 'save' asset '128_shortname.jpg' info of collection 'C_MDMSA_S15' by following information:
| FieldName  | FieldValue    |
| Advertiser | ADV_MDMSA_S15 |
| Brand      | BR_MDMSA_S15  |
| Sub Brand  | SBR_MDMSA_S15 |
| Product    | PR_MDMSA_S15  |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S15  | A_MDMSA_S15_2 |
And login with details of 'U_MDMSA_S15_2'
And accept all assets on Shared Collection 'C_MDMSA_S15' from agency 'A_MDMSA_S15_1' page
When login with details of 'GlobalAdmin'
And I go to the global 'common custom' metadata page for agency 'A_MDMSA_S15_2'
Then I 'should not' see following Advertiser chain on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| ADV_MDMSA_S15   | BR_MDMSA_S15   | SBR_MDMSA_S15   | PR_MDMSA_S15    |

Scenario: Allow extend dictionaries when accepting shared assets" is TICKED  & for metadata Advertiser "Add values on the fly" is TICKED and Reject asset
Meta:@globaladmin
     @gdam
Given I created the agency 'A_MDMSA_S16_1' with default attributes
And I created the following agency:
| Name          | Allow extend dictionaries when accepting shared assets |
| A_MDMSA_S16_2 | should                                                 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_MDMSA_S16_1':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_MDMSA_S16 | BR_MDMSA_S16 | SBR_MDMSA_S16 | PR_MDMSA_S16 |
And updated following 'common' custom metadata fields for agency 'A_MDMSA_S16_2':
| FieldType          | Description | Parent     | AddOnFly |
| catalogueStructure | Advertiser  |            | true     |
| catalogueStructure | Brand       | Advertiser | true     |
| catalogueStructure | Sub Brand   | Brand      | true     |
| catalogueStructure | Product     | Sub Brand  | true     |
And created users with following fields:
| Email         | Role         | Agency        |
| U_MDMSA_S16_1 | agency.admin | A_MDMSA_S16_1 |
| U_MDMSA_S16_2 | agency.admin | A_MDMSA_S16_2 |
And added agency 'A_MDMSA_S16_2' as a partner to agency 'A_MDMSA_S16_1'
And I have refreshed the page
And created metadata mapping from agency 'A_MDMSA_S16_1' to agency 'A_MDMSA_S16_2' on metadata mapping page
And logged in with details of 'U_MDMSA_S16_1'
And created 'C_MDMSA_S16' category
And uploaded asset '/files/128_shortname.jpg' into library
And waited while preview is available in collection 'C_MDMSA_S16'
When I 'save' asset '128_shortname.jpg' info of collection 'C_MDMSA_S16' by following information:
| FieldName  | FieldValue    |
| Advertiser | ADV_MDMSA_S16 |
| Brand      | BR_MDMSA_S16  |
| Sub Brand  | SBR_MDMSA_S16 |
| Product    | PR_MDMSA_S16  |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_MDMSA_S16  | A_MDMSA_S16_2 |
And login with details of 'U_MDMSA_S16_2'
And reject all assets on Shared Collection 'C_MDMSA_S16' from agency 'A_MDMSA_S16_1' page
When login with details of 'GlobalAdmin'
And I go to the global 'common custom' metadata page for agency 'A_MDMSA_S16_2'
Then I 'should not' see following Advertiser chain on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| ADV_MDMSA_S16   | BR_MDMSA_S16   | SBR_MDMSA_S16   | PR_MDMSA_S16    |