!--NGN-4732 NGN-2298
Feature:          Permissions for shared via autosharing assets - Usage Rights
Narrative:
In order to
As a              AgencyAdmin
I want to         check permissions for usage rights for shared via autosharing assets

Scenario: Check that visibility of Usage Rights tab depends on 'asset.usage_rights.read' permission for autoshared asset on asset details
Meta:@gdam
@library
Given I created the agency 'A_PSAAUR_S01_1' with default attributes
And created the agency 'A_PSAAUR_S01_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU1_PSAAUR_S01 | agency.admin | A_PSAAUR_S01_1 |streamlined_library|
| AU2_PSAAUR_S01 | agency.admin | A_PSAAUR_S01_2 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S01_2 |streamlined_library|
And logged in with details of 'AU1_PSAAUR_S01'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAAUR_S01' category
And added agency 'A_PSAAUR_S01_2' to category 'C1_PSAAUR_S01' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAAUR_S01'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAAUR_S01' from agency 'A_PSAAUR_S01_1' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S01' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S01' category
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAAUR_S01_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAAUR_S01' with role '<LibRole>' by users details
And login with details of '<TestedUser>'
And I go to asset '<Asset1Name>' info page in Library for collection 'C2_PSAAUR_S01'NEWLIB
Then I '<Condition>' see 'Usage Rights' button on opened asset info pageNEWLIB
When I go to asset '<Asset2Name>' info page in Library for collection 'C2_PSAAUR_S01'NEWLIB
Then I '<Condition>' see 'Usage Rights' button on opened asset info pageNEWLIB

Examples:
| TestedUser      | GlobalRole  | LibRole         | Permission              | Condition  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S01_1 | agency.user | LR_PSAAUR_S01_1 |                         | should not | /files/Fish1-Ad.mov | /files/Fish5-Ad.mov | Fish1-Ad.mov | Fish5-Ad.mov |Fish1-Ad.mov |
| TU_PSAAUR_S01_2 | guest.user  | LR_PSAAUR_S01_1 |                         | should not | /files/Fish2-Ad.mov | /files/Fish6-Ad.mov | Fish2-Ad.mov | Fish6-Ad.mov |Fish2-Ad.mov|
| TU_PSAAUR_S01_3 | agency.user | LR_PSAAUR_S01_2 | asset.usage_rights.read | should     | /files/Fish3-Ad.mov | /files/Fish7-Ad.mov | Fish3-Ad.mov | Fish7-Ad.mov |Fish3-Ad.mov|
| TU_PSAAUR_S01_4 | guest.user  | LR_PSAAUR_S01_2 | asset.usage_rights.read | should     | /files/Fish4-Ad.mov | /files/Fish8-Ad.mov | Fish4-Ad.mov | Fish8-Ad.mov |Fish4-Ad.mov|


Scenario: Check that user can open Usage Rights tab for autoshared asset on asset details as a agency user
Meta:@gdam
@library
Given I created the agency 'A_PSAAUR_S02_1' with default attributes
And created the agency 'A_PSAAUR_S02_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU1_PSAAUR_S02 | agency.admin | A_PSAAUR_S02_1 |streamlined_library|
| AU2_PSAAUR_S02 | agency.admin | A_PSAAUR_S02_2 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S02_2 |streamlined_library|
And logged in with details of 'AU1_PSAAUR_S02'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
And created 'C1_PSAAUR_S02' category
And added agency 'A_PSAAUR_S02_2' to category 'C1_PSAAUR_S02' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAAUR_S02'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAAUR_S02' from agency 'A_PSAAUR_S02_1' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S02' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S02' category
And create 'LR_PSAAUR_S02' role in 'library' group for advertiser 'A_PSAAUR_S02_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
And add users '<TestedUser>' to category 'C2_PSAAUR_S02' with role 'LR_PSAAUR_S02' by users details
And I login with details of '<TestedUser>'
And go to asset '<Asset1Name>' usage rights page in Library for collection 'C2_PSAAUR_S02'NEWLIB
Then I 'should' be on the asset usage rights pageNEWLIB
When I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S02'NEWLIB
Then I 'should' be on the asset usage rights pageNEWLIB

Examples:
| TestedUser      | GlobalRole  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S02_1 | agency.user | /files/Fish1-Ad.mov | /files/Fish3-Ad.mov | Fish1-Ad.mov | Fish3-Ad.mov |Fish1-Ad.mov|


Scenario: Check that user can open Usage Rights tab for autoshared asset on asset details as a guest user
Meta:@gdam
@library
Given I created the agency 'A_PSAAUR_S02_3' with default attributes
And created the agency 'A_PSAAUR_S02_4' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU3_PSAAUR_S02 | agency.admin | A_PSAAUR_S02_3 |streamlined_library|
| AU4_PSAAUR_S02 | agency.admin | A_PSAAUR_S02_4 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S02_4 |streamlined_library|
And logged in with details of 'AU3_PSAAUR_S02'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
And created 'C1_PSAAUR_S02' category
And added agency 'A_PSAAUR_S02_4' to category 'C1_PSAAUR_S02' on Asset Categories and Permissions page
And logged in with details of 'AU4_PSAAUR_S02'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAAUR_S02' from agency 'A_PSAAUR_S02_3' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S02' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S02' category
And create 'LR_PSAAUR_S03' role in 'library' group for advertiser 'A_PSAAUR_S02_4' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
And add users '<TestedUser>' to category 'C2_PSAAUR_S02' with role 'LR_PSAAUR_S03' by users details
And I login with details of '<TestedUser>'
And go to asset '<Asset1Name>' usage rights page in Library for collection 'C2_PSAAUR_S02'NEWLIB
Then I 'should' be on the asset usage rights pageNEWLIB
When I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S02'NEWLIB
Then I 'should' be on the asset usage rights pageNEWLIB

Examples:
| TestedUser      | GlobalRole  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S02_2 | guest.user  | /files/Fish2-Ad.mov | /files/Fish4-Ad.mov | Fish2-Ad.mov | Fish4-Ad.mov |Fish2-Ad.mov|

Scenario: Check that visibility of 'Edit' link next to added usage rights depends on 'asset.usage_rights.write' permission for autoshared asset on asset details when asset.usage_rights.write is not given for a agency user
Meta:@gdam
@library
Given I created the agency 'A_PSAAUR_S03_1' with default attributes
And created the agency 'A_PSAAUR_S03_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU1_PSAAUR_S03 | agency.admin | A_PSAAUR_S03_1 |streamlined_library|
| AU2_PSAAUR_S03 | agency.admin | A_PSAAUR_S03_2 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S03_2 |streamlined_library|
And logged in with details of 'AU1_PSAAUR_S03'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAAUR_S03' category
And I am on asset '<Asset1Name>' usage rights page in Library for collection 'C1_PSAAUR_S03'NEWLIB
And added Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And added agency 'A_PSAAUR_S03_2' to category 'C1_PSAAUR_S03' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAAUR_S03'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAAUR_S03' from agency 'A_PSAAUR_S03_1' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S03' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S03' category
And I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S03'NEWLIB
And add Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAAUR_S03_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAAUR_S03' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<Asset1Name>' usage rights page in Library for collection 'C2_PSAAUR_S03'NEWLIB
Then I '<Condition>' see Edit link next to 'Other usage' usage type on opened asset usage rights pageNEWLIB
When I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S03'NEWLIB
And I refresh the page
Then I '<Condition>' see Edit link next to 'Other usage' usage type on opened asset usage rights pageNEWLIB

Examples:
| TestedUser      | GlobalRole  | LibRole         | Permission               | Condition  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S03_1 | agency.user | LR_PSAAUR_S03_1 |                          | should not | /files/Fish1-Ad.mov | /files/Fish5-Ad.mov | Fish1-Ad.mov | Fish5-Ad.mov |Fish1-Ad.mov|


Scenario: Check that visibility of 'Edit' link next to added usage rights depends on 'asset.usage_rights.write' permission for autoshared asset on asset details when asset.usage_rights.write is not given for a guest user
Meta:@gdam
@library
Given I created the agency 'A_PSAAUR_S03_3' with default attributes
And created the agency 'A_PSAAUR_S03_4' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU1_PSAAUR_S03 | agency.admin | A_PSAAUR_S03_3 |streamlined_library|
| AU2_PSAAUR_S03 | agency.admin | A_PSAAUR_S03_4 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S03_4 |streamlined_library|
And logged in with details of 'AU1_PSAAUR_S03'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAAUR_S04' category
And I am on asset '<Asset1Name>' usage rights page in Library for collection 'C1_PSAAUR_S04'NEWLIB
And added Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And added agency 'A_PSAAUR_S03_4' to category 'C1_PSAAUR_S04' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAAUR_S03'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAAUR_S04' from agency 'A_PSAAUR_S03_3' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S04' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S04' category
And I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S04'NEWLIB
And add Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAAUR_S03_4' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAAUR_S04' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<Asset1Name>' usage rights page in Library for collection 'C2_PSAAUR_S04'NEWLIB
Then I '<Condition>' see Edit link next to 'Other usage' usage type on opened asset usage rights pageNEWLIB
When I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S04'NEWLIB
And I refresh the page
Then I '<Condition>' see Edit link next to 'Other usage' usage type on opened asset usage rights pageNEWLIB

Examples:
| TestedUser      | GlobalRole  | LibRole         | Permission               | Condition  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S03_2 | guest.user  | LR_PSAAUR_S03_1 |                          | should not | /files/Fish2-Ad.mov | /files/Fish6-Ad.mov | Fish2-Ad.mov | Fish6-Ad.mov |Fish2-Ad.mov|


Scenario: Check that visibility of 'Edit' link next to added usage rights depends on 'asset.usage_rights.write' permission for autoshared asset on asset details when asset.usage_rights.write is given for a agency user
Meta:@gdam
@library
Given I created the agency 'A_PSAAUR_S03_5' with default attributes
And created the agency 'A_PSAAUR_S03_6' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU11_PSAAUR_S03 | agency.admin | A_PSAAUR_S03_5 |streamlined_library|
| AU21_PSAAUR_S03 | agency.admin | A_PSAAUR_S03_6 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S03_6 |streamlined_library|
And logged in with details of 'AU11_PSAAUR_S03'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAAUR_S05' category
And I am on asset '<Asset1Name>' usage rights page in Library for collection 'C1_PSAAUR_S05'NEWLIB
And added Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And added agency 'A_PSAAUR_S03_6' to category 'C1_PSAAUR_S05' on Asset Categories and Permissions page
And logged in with details of 'AU21_PSAAUR_S03'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C1_PSAAUR_S05' from agency 'A_PSAAUR_S03_5' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S05' category
And I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S05'NEWLIB
And add Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAAUR_S03_6' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAAUR_S05' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<Asset1Name>' usage rights page in Library for collection 'C2_PSAAUR_S05'NEWLIB
Then I '<Condition>' see Edit link next to 'Other usage' usage type on opened asset usage rights pageNEWLIB
When I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S05'NEWLIB
And I refresh the page
Then I '<Condition>' see Edit link next to 'Other usage' usage type on opened asset usage rights pageNEWLIB

Examples:
| TestedUser      | GlobalRole  | LibRole         | Permission               | Condition  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S03_3 | agency.user | LR_PSAAUR_S03_2 | asset.usage_rights.write | should     | /files/Fish3-Ad.mov | /files/Fish7-Ad.mov | Fish3-Ad.mov | Fish7-Ad.mov |Fish3-Ad.mov|

Scenario: Check that visibility of 'Edit' link next to added usage rights depends on 'asset.usage_rights.write' permission for autoshared asset on asset details when asset.usage_rights.write is given for a guest user
Meta:@gdam
@library
Given I created the agency 'A_PSAAUR_S03_7' with default attributes
And created the agency 'A_PSAAUR_S03_8' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU1_PSAAUR_S03_1 | agency.admin | A_PSAAUR_S03_7 |streamlined_library|
| AU2_PSAAUR_S03_2 | agency.admin | A_PSAAUR_S03_8 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S03_8 |streamlined_library|
And logged in with details of 'AU1_PSAAUR_S03_1'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAAUR_S06' category
And I am on asset '<Asset1Name>' usage rights page in Library for collection 'C1_PSAAUR_S06'NEWLIB
And added Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And added agency 'A_PSAAUR_S03_8' to category 'C1_PSAAUR_S06' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAAUR_S03_2'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAAUR_S06' from agency 'A_PSAAUR_S03_7' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S06' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S06' category
And I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S06'NEWLIB
And add Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAAUR_S03_8' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAAUR_S06' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<Asset1Name>' usage rights page in Library for collection 'C2_PSAAUR_S06'NEWLIB
Then I '<Condition>' see Edit link next to 'Other usage' usage type on opened asset usage rights pageNEWLIB
When I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S06'NEWLIB
And I refresh the page
Then I '<Condition>' see Edit link next to 'Other usage' usage type on opened asset usage rights pageNEWLIB

Examples:
| TestedUser      | GlobalRole  | LibRole         | Permission               | Condition  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S03_4 | guest.user  | LR_PSAAUR_S03_2 | asset.usage_rights.write | should     | /files/Fish4-Ad.mov | /files/Fish8-Ad.mov | Fish4-Ad.mov | Fish8-Ad.mov |Fish4-Ad.mov|


Scenario: Check that new usage rights can be added using 'Add Usage' button for autoshared asset on asset details as a agency user
Meta:@gdam
@library
!--affected by NGN-4058
Given I created the agency 'A_PSAAUR_S04_1' with default attributes
And created the agency 'A_PSAAUR_S04_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU1_PSAAUR_S04 | agency.admin | A_PSAAUR_S04_1 |streamlined_library|
| AU2_PSAAUR_S04 | agency.admin | A_PSAAUR_S04_2 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S04_2 |streamlined_library|
And logged in with details of 'AU1_PSAAUR_S04'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAAUR_S04' category
And added agency 'A_PSAAUR_S04_2' to category 'C1_PSAAUR_S04' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAAUR_S04'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAAUR_S04' from agency 'A_PSAAUR_S04_1' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S04' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my library
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S04' category
And create 'LR_PSAAUR_S04' role in 'library' group for advertiser 'A_PSAAUR_S04_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And add users '<TestedUser>' to category 'C2_PSAAUR_S04' with role 'LR_PSAAUR_S04' by users details
And I login with details of '<TestedUser>'
And go to asset '<Asset1Name>' usage rights page in Library for collection 'C2_PSAAUR_S04'NEWLIB
And add Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
When I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S04'NEWLIB
And add Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |

Examples:
| TestedUser      | GlobalRole  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S04_1 | agency.user | /files/Fish1-Ad.mov | /files/Fish3-Ad.mov | Fish1-Ad.mov | Fish3-Ad.mov |Fish1-Ad.mov|


Scenario: Check that new usage rights can be added using 'Add Usage' button for autoshared asset on asset details as a guest user
Meta:@gdam
@library
!--affected by NGN-4058
Given I created the agency 'A_PSAAUR_S04_3' with default attributes
And created the agency 'A_PSAAUR_S04_4' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU1_PSAAUR_S04 | agency.admin | A_PSAAUR_S04_3 |streamlined_library|
| AU2_PSAAUR_S04 | agency.admin | A_PSAAUR_S04_4 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S04_4 |streamlined_library|
And logged in with details of 'AU1_PSAAUR_S04'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAAUR_S07' category
And added agency 'A_PSAAUR_S04_4' to category 'C1_PSAAUR_S07' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAAUR_S04'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAAUR_S07' from agency 'A_PSAAUR_S04_3' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S07' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my library
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S07' category
And create 'LR_PSAAUR_S04' role in 'library' group for advertiser 'A_PSAAUR_S04_4' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And add users '<TestedUser>' to category 'C2_PSAAUR_S07' with role 'LR_PSAAUR_S04' by users details
And I login with details of '<TestedUser>'
And go to asset '<Asset1Name>' usage rights page in Library for collection 'C2_PSAAUR_S07'NEWLIB
And add Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
When I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S07'NEWLIB
And add Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |

Examples:
| TestedUser      | GlobalRole  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S04_2 | guest.user  | /files/Fish2-Ad.mov | /files/Fish4-Ad.mov | Fish2-Ad.mov | Fish4-Ad.mov |Fish2-Ad.mov|


Scenario: Check that editing of added usage rights correctly works for autoshared asset on asset details
Meta:@gdam
@library
!--NGN-4058
Given I created the agency 'A_PSAAUR_S05_1' with default attributes
And created the agency 'A_PSAAUR_S05_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| AU1_PSAAUR_S05 | agency.admin | A_PSAAUR_S05_1 |streamlined_library|
| AU2_PSAAUR_S05 | agency.admin | A_PSAAUR_S05_2 |streamlined_library|
| <TestedUser>   | <GlobalRole> | A_PSAAUR_S05_2 |streamlined_library|
And logged in with details of 'AU1_PSAAUR_S05'
And uploaded file '<File1Path>' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C1_PSAAUR_S05' category
And I am on asset '<Asset1Name>' usage rights page in Library for collection 'C1_PSAAUR_S05'NEWLIB
And added Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And added agency 'A_PSAAUR_S05_2' to category 'C1_PSAAUR_S05' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAAUR_S05'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAAUR_S05' from agency 'A_PSAAUR_S05_1' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_PSAAUR_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '<File2Path>' into my libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And create 'C2_PSAAUR_S05' category
And I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S05'NEWLIB
And add Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And create 'LR_PSAAUR_S05' role in 'library' group for advertiser 'A_PSAAUR_S05_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And add users '<TestedUser>' to category 'C2_PSAAUR_S05' with role 'LR_PSAAUR_S05' by users details
When I login with details of '<TestedUser>'
And go to asset '<Asset1Name>' usage rights page in Library for collection 'C2_PSAAUR_S05'NEWLIB
And edit entry of 'Other usage' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| EntryNumber | Comment              |
| 1           | updated test comment |
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment              |
| updated test comment |
When I go to asset '<Asset2Name>' usage rights page in Library for collection 'C2_PSAAUR_S05'NEWLIB
And edit entry of 'Other usage' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| EntryNumber | Comment              |
| 1           | updated test comment |
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment              |
| updated test comment |

Examples:
| TestedUser      | GlobalRole  | File1Path           | File2Path           | Asset1Name   | Asset2Name   |AssetName|
| TU_PSAAUR_S05_1 | agency.user | /files/Fish1-Ad.mov | /files/Fish2-Ad.mov | Fish1-Ad.mov | Fish2-Ad.mov |Fish1-Ad.mov|