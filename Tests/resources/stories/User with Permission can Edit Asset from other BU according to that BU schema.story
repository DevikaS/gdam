!--NGN-11523
Feature:          User with Permission can Edit Asset from other BU according to that BU schema
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that User with Permission can Edit Asset from other BU according to that BU schema


Scenario: Check that user without permission asset.write couldn't see edit button on asset details page
Meta:@library
     @gdam
Given I created the agency 'UWPCEAFOBUATTBUS_A1' with default attributes
And created the agency 'UWPCEAFOBUATTBUS_A2' with default attributes
And created users with following fields:
| Email                  | Role         | AgencyUnique        |Access|
| UWPCEAFOBUATTBUS_E01   | agency.admin | UWPCEAFOBUATTBUS_A1 |streamlined_library|
| UWPCEAFOBUATTBUS_E01_1 | agency.admin | UWPCEAFOBUATTBUS_A2 |streamlined_library|
| UWPCEAFOBUATTBUS_E01_2 | agency.user  | UWPCEAFOBUATTBUS_A2 |streamlined_library|
And I created 'test_library_role' role in 'library' group for advertiser 'UWPCEAFOBUATTBUS_A2' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| file.download              |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And logged in with details of 'GlobalAdmin'
And waited for '5' seconds
And added following partners 'UWPCEAFOBUATTBUS_A2' to agency 'UWPCEAFOBUATTBUS_A1' on partners page
And logged in with details of 'UWPCEAFOBUATTBUS_E01'
And created 'test_col' category
And shared next agencies for following categories:
| CategoryName | AgencyName        |
| test_col     | UWPCEAFOBUATTBUS_A2 |
And uploaded asset '/images/admin.logo.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'test_col'NEWLIB
And logged in with details of 'UWPCEAFOBUATTBUS_E01_1'
When I go to the collections page
And I go to the Shared Collection 'test_col' from agency 'UWPCEAFOBUATTBUS_A1' pageNEWLIB
And I select asset 'admin.logo.jpg' for collection 'test_col' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I create 'test_col_1' category
And wait for '5' seconds
And add users 'UWPCEAFOBUATTBUS_E01_2' to category 'test_col_1' with role 'test_library_role' by users details
And login with details of 'UWPCEAFOBUATTBUS_E01_2'
And go to asset 'admin.logo.jpg' info page in Library for collection 'test_col_1'NEWLIB
Then I 'should not' see Edit link on opened asset info pageNEWLIB


Scenario: Check that asset from other BU has schema of BU that has crated this asset (Schema should include custom fields and mandatory fields)
Meta:@library
     @gdam
Given I created the agency 'UWPCEAFOBUATTBUS_A1' with default attributes
And created the agency 'UWPCEAFOBUATTBUS_A2' with default attributes
And created users with following fields:
| Email                  | Role         | AgencyUnique        |Access|
| UWPCEAFOBUATTBUS_E02   | agency.admin | UWPCEAFOBUATTBUS_A1 |streamlined_library|
| UWPCEAFOBUATTBUS_E02_1 | agency.admin | UWPCEAFOBUATTBUS_A2 |streamlined_library|
| UWPCEAFOBUATTBUS_E02_2 | agency.user  | UWPCEAFOBUATTBUS_A2 |streamlined_library|
And logged in with details of 'GlobalAdmin'
And added following partners 'UWPCEAFOBUATTBUS_A2' to agency 'UWPCEAFOBUATTBUS_A1' on partners page
And logged in with details of 'UWPCEAFOBUATTBUS_E02'
And on the global 'common custom' metadata page for agency 'UWPCEAFOBUATTBUS_A1'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser              | Brand                  | Sub Brand               | Product                 |
| AR_UWPCEAFOBUATTBUS_S02 | B_UWPCEAFOBUATTBUS_S02 | SB_UWPCEAFOBUATTBUS_S02 | PT_UWPCEAFOBUATTBUS_S02 |
And created 'test_col_2' category
And shared next agencies for following categories:
| CategoryName | AgencyName          |
| test_col_2   | UWPCEAFOBUATTBUS_A2 |
And uploaded asset '/images/admin.logo.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'test_col_2'NEWLIB
And on asset 'admin.logo.jpg' info page in Library for collection 'test_col_2'NEWLIB
And 'saved' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue              |
| Advertiser | AR_UWPCEAFOBUATTBUS_S02 |
| Brand      | B_UWPCEAFOBUATTBUS_S02  |
| Sub Brand  | SB_UWPCEAFOBUATTBUS_S02 |
| Product    | PT_UWPCEAFOBUATTBUS_S02 |
And logged in with details of 'UWPCEAFOBUATTBUS_E02_1'
When I go to the collections page
And I go to the Shared Collection 'test_col_2' from agency 'UWPCEAFOBUATTBUS_A1' pageNEWLIB
And I select asset 'admin.logo.jpg' for collection 'test_col_2' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
When I create 'shared_category' category
And add users 'UWPCEAFOBUATTBUS_E02_2' to category 'shared_category' with role 'library.user' by users details
And login with details of 'UWPCEAFOBUATTBUS_E02_2'
And go to asset 'admin.logo.jpg' info page in Library for collection 'shared_category'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName     | FieldValue              |
| Advertiser    | AR_UWPCEAFOBUATTBUS_S02 |
| Brand         | B_UWPCEAFOBUATTBUS_S02  |
| Sub Brand     | SB_UWPCEAFOBUATTBUS_S02 |
| Product       | PT_UWPCEAFOBUATTBUS_S02 |
And I 'should' see following 'asset information' fields on opened asset info pageNEWLIB:
| FieldName   | FieldValue          |
| Originator | UWPCEAFOBUATTBUS_A1 |


Scenario: Check that asset from other BU has schema with values from BU that has crated this asset(Check in catalog group dropdown radiobuttons)
Meta:@library
     @gdam
Given I created the agency 'UWPCEAFOBUATTBUS_A1' with default attributes
And created the agency 'UWPCEAFOBUATTBUS_A2' with default attributes
And created users with following fields:
| Email                  | Role         | AgencyUnique        |Access|
| UWPCEAFOBUATTBUS_E3_01 | agency.admin | UWPCEAFOBUATTBUS_A1 |streamlined_library|
| UWPCEAFOBUATTBUS_E3_02 | agency.admin | UWPCEAFOBUATTBUS_A2 |streamlined_library|
When I login with details of 'GlobalAdmin'
And add following partners 'UWPCEAFOBUATTBUS_A2' to agency 'UWPCEAFOBUATTBUS_A1' on partners page
And login with details of 'UWPCEAFOBUATTBUS_E3_01'
And go to the global 'common custom' metadata page for agency 'UWPCEAFOBUATTBUS_A1'
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser              | Brand                  | Sub Brand               | Product                 |
| AR_UWPCEAFOBUATTBUS_S03 | B_UWPCEAFOBUATTBUS_S03 | SB_UWPCEAFOBUATTBUS_S03 | PT_UWPCEAFOBUATTBUS_S03 |
And create following 'common' custom metadata fields for agency 'UWPCEAFOBUATTBUS_A1':
| FieldType    | Description                     | Choices     |
| Dropdown     | DROPDOWN_UWPCEAFOBUATTBUS_3     | drop1,drop2 |
| RadioButtons | RADIOBUTTONS_UWPCEAFOBUATTBUS_3 | rad1,rad2   |
And create 'test_col_2_1' category
And upload file '/images/admin.logo.jpg' into libraryNEWLIB
And wait while transcoding is finished in collection 'test_col_2_1'NEWLIB
And go to administration area collections page
And add users 'UWPCEAFOBUATTBUS_E3_02' for category 'test_col_2_1' with role 'library.admin'
And go to the Library page for collection 'My Assets'NEWLIB
And I refresh the page
And go to the Library page for collection 'test_col_2_1'NEWLIB
And go to asset 'admin.logo.jpg' info page in Library for collection 'test_col_2_1'NEWLIB
And 'saved' asset info by following information on opened asset info pageNEWLIB:
| FieldName                       | FieldValue              |
| Advertiser                      | AR_UWPCEAFOBUATTBUS_S03 |
| Brand                           | B_UWPCEAFOBUATTBUS_S03  |
| Sub Brand                       | SB_UWPCEAFOBUATTBUS_S03 |
| Product                         | PT_UWPCEAFOBUATTBUS_S03 |
| DROPDOWN_UWPCEAFOBUATTBUS_3     | drop2                   |
| RADIOBUTTONS_UWPCEAFOBUATTBUS_3 | rad1                    |
And login with details of 'UWPCEAFOBUATTBUS_E3_02'
And go to the Library page for collection 'My Assets'NEWLIB
And go to the Library page for collection 'test_col_2_1'NEWLIB
And go to asset 'admin.logo.jpg' info page in Library for collection 'test_col_2_1'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                       | FieldValue              |
| Advertiser                      | AR_UWPCEAFOBUATTBUS_S03 |
| Brand                           | B_UWPCEAFOBUATTBUS_S03  |
| Sub Brand                       | SB_UWPCEAFOBUATTBUS_S03 |
| Product                         | PT_UWPCEAFOBUATTBUS_S03 |
| DROPDOWN_UWPCEAFOBUATTBUS_3     | drop2                   |
| RADIOBUTTONS_UWPCEAFOBUATTBUS_3 | rad1                    |


Scenario: Check that user could upload asset in another BUCheck that asset from other BU could be edited and saved(Check with catalog group dropdown radiobuttons mandatory fields)
Meta:@library
     @gdam
Given I logged in as 'GlobalAdmin'
And I created the agency 'UWPCEAFOBUATTBUS_A1' with default attributes
And created the agency 'UWPCEAFOBUATTBUS_A2' with default attributes
When I open role 'agency.admin' page with parent 'UWPCEAFOBUATTBUS_A2'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'UWPCEAFOBUATTBUS_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'UWPCEAFOBUATTBUS_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'UWPCEAFOBUATTBUS_A2'
And create users with following fields:
| Email                  | Role         | AgencyUnique        |Access|
| UWPCEAFOBUATTBUS_E4_01 | agency.admin | UWPCEAFOBUATTBUS_A1 |streamlined_library|
| UWPCEAFOBUATTBUS_E4_02 | agency.admin | UWPCEAFOBUATTBUS_A2 |streamlined_library|
And add following partners 'UWPCEAFOBUATTBUS_A2' to agency 'UWPCEAFOBUATTBUS_A1' on partners page
And login with details of 'UWPCEAFOBUATTBUS_E4_01'
And go to the global 'common custom' metadata page for agency 'UWPCEAFOBUATTBUS_A1'
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser              | Brand                  | Sub Brand               | Product                 |
| AR_UWPCEAFOBUATTBUS_S04 | B_UWPCEAFOBUATTBUS_S04 | SB_UWPCEAFOBUATTBUS_S04 | PT_UWPCEAFOBUATTBUS_S04 |
And create following 'common' custom metadata fields for agency 'UWPCEAFOBUATTBUS_A1':
| FieldType    | Description                     | Choices     |
| Dropdown     | DROPDOWN_UWPCEAFOBUATTBUS_4     | drop1,drop2 |
| RadioButtons | RADIOBUTTONS_UWPCEAFOBUATTBUS_4 | rad1,rad2   |
And create 'test_col_4' category
And upload file '/images/admin.logo.jpg' into libraryNEWLIB
And wait while transcoding is finished in collection 'test_col_4'NEWLIB
And go to administration area collections page
And add users 'UWPCEAFOBUATTBUS_E4_02' for category 'test_col_4' with role 'library.admin'
And go to asset 'admin.logo.jpg' info page in Library for collection 'test_col_4'NEWLIB
And 'saved' asset info by following information on opened asset info pageNEWLIB:
| FieldName                       | FieldValue              |
| Advertiser                      | AR_UWPCEAFOBUATTBUS_S04 |
| Brand                           | B_UWPCEAFOBUATTBUS_S04  |
| Sub Brand                       | SB_UWPCEAFOBUATTBUS_S04 |
| Product                         | PT_UWPCEAFOBUATTBUS_S04 |
| DROPDOWN_UWPCEAFOBUATTBUS_4     | drop2                   |
| RADIOBUTTONS_UWPCEAFOBUATTBUS_4 | rad1                    |
And login with details of 'UWPCEAFOBUATTBUS_E4_02'
And go to the global 'common custom' metadata page for agency 'UWPCEAFOBUATTBUS_A2'
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser                | Brand                    | Sub Brand                 | Product                   |
| AR_UWPCEAFOBUATTBUS_S04_2 | B_UWPCEAFOBUATTBUS_S04_2 | SB_UWPCEAFOBUATTBUS_S04_2 | PT_UWPCEAFOBUATTBUS_S04_2 |
And create following 'common' custom metadata fields for agency 'UWPCEAFOBUATTBUS_A1':
| FieldType    | Description                       | Choices     |
| Dropdown     | DROPDOWN_UWPCEAFOBUATTBUS_4_2     | drop1,drop2 |
| RadioButtons | RADIOBUTTONS_UWPCEAFOBUATTBUS_4_2 | rad1,rad2   |
Given I edited user 'UWPCEAFOBUATTBUS_E4_02' with following fields:
|Role|
|UWPCEAFOBUATTBUS_R1|
And I logout from account
When I login with details of 'UWPCEAFOBUATTBUS_E4_02'
And go to asset 'admin.logo.jpg' info page in Library for collection 'test_col_4'NEWLIB
And 'saved' asset info by following information on opened asset info pageNEWLIB:
| FieldName                         | FieldValue                |
| Advertiser                        | AR_UWPCEAFOBUATTBUS_S04_2 |
| Brand                             | B_UWPCEAFOBUATTBUS_S04_2  |
| Sub Brand                         | SB_UWPCEAFOBUATTBUS_S04_2 |
| Product                           | PT_UWPCEAFOBUATTBUS_S04_2 |
| DROPDOWN_UWPCEAFOBUATTBUS_4_2     | drop1                     |
| RADIOBUTTONS_UWPCEAFOBUATTBUS_4_2 | rad2                      |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                         | FieldValue                |
| Advertiser                        | AR_UWPCEAFOBUATTBUS_S04_2 |
| Brand                             | B_UWPCEAFOBUATTBUS_S04_2  |
| Sub Brand                         | SB_UWPCEAFOBUATTBUS_S04_2 |
| Product                           | PT_UWPCEAFOBUATTBUS_S04_2 |
| DROPDOWN_UWPCEAFOBUATTBUS_4_2     | drop1                     |
| RADIOBUTTONS_UWPCEAFOBUATTBUS_4_2 | rad2                      |



Scenario: Check that user could create relationship between asset from another BU and current
Meta:@library
     @gdam
     @uitobe
Given I created the agency 'UWPCEAFOBUATTBUS_A1' with default attributes
And created the agency 'UWPCEAFOBUATTBUS_A2' with default attributes
And created users with following fields:
| Email                  | Role         | AgencyUnique        |
| UWPCEAFOBUATTBUS_E5_01 | agency.admin | UWPCEAFOBUATTBUS_A1 |
| UWPCEAFOBUATTBUS_E5_02 | agency.admin | UWPCEAFOBUATTBUS_A2 |
When I login with details of 'GlobalAdmin'
And add following partners 'UWPCEAFOBUATTBUS_A2' to agency 'UWPCEAFOBUATTBUS_A1' on partners page
And login with details of 'UWPCEAFOBUATTBUS_E5_01'
And create 'test_col_5' category
And upload file '/images/admin.logo.jpg' into library
And wait while transcoding is finished in collection 'test_col_5'
And go to administration area collections page
And add users 'UWPCEAFOBUATTBUS_E5_02' for category 'test_col_5' with role 'library.admin'
And login with details of 'UWPCEAFOBUATTBUS_E5_02'
And upload following assets:
| Name                      |
| /images/branding_logo.png |
| /images/big.logo.png      |
And go to asset 'admin.logo.jpg' info page in Library for collection 'test_col_5' on related assets page
And type related asset '.png' on related assets page on pop-up
And select following related files 'branding_logo.png,big.logo.png' on related asset pop-up
Then I should see following count '2' of related files on assets pop-up



Scenario: Check that user could Upload attachments in asset from another BU
Meta:@library
     @gdam
Given I created the agency 'UWPCEAFOBUATTBUS_A1' with default attributes
And created the agency 'UWPCEAFOBUATTBUS_A2' with default attributes
And created users with following fields:
| Email                  | Role         | AgencyUnique        | Access              |
| UWPCEAFOBUATTBUS_E6_01 | agency.admin | UWPCEAFOBUATTBUS_A1 |streamlined_library  |
| UWPCEAFOBUATTBUS_E6_02 | agency.admin | UWPCEAFOBUATTBUS_A2 |streamlined_library  |
When I login with details of 'GlobalAdmin'
And add following partners 'UWPCEAFOBUATTBUS_A2' to agency 'UWPCEAFOBUATTBUS_A1' on partners page
And login with details of 'UWPCEAFOBUATTBUS_E6_01'
And create 'test_col_6' category
And upload file '/images/admin.logo.jpg' into library
And wait while transcoding is finished in collection 'test_col_6'NEWLIB
And go to administration area collections page
And add users 'UWPCEAFOBUATTBUS_E6_02' for category 'test_col_6' with role 'library.admin'
And login with details of 'UWPCEAFOBUATTBUS_E6_02'
And attache new file '/files/big_background.jpg' into collection 'test_col_6' for asset 'admin.logo.jpg' on attachment assets pageNEWLIB
And attache new file '/files/128_shortname.jpg' into collection 'test_col_6' for asset 'admin.logo.jpg' on attachment assets pageNEWLIB
And refresh the page
And I go to  library page for collection 'Everything'NEWLIB
And go to asset 'admin.logo.jpg' info page in Library for collection 'test_col_6' on attachment assets pageNEWLIB
Then I 'should' see following count '2' of assets on attachment assets pageNEWLIB
And 'should' see following attached files 'big_background.jpg,128_shortname.jpg' on asset attachments pageNEWLIB
