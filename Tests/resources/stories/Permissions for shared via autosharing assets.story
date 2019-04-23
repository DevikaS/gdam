!--NGN-4732 NGN-2298
Feature:          Permissions for shared via autosharing assets
Narrative:
In order to
As a              AgencyAdmin
I want to         check permissions for shared via autosharing assets


Scenario: Check that 'Download Original' correctly works for autoshared asset
Meta: @gdam
      @skip
Given I created the agency 'A_PSAA_S02_1' with default attributes
And created the agency 'A_PSAA_S02_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| AU1_PSAA_S02 | agency.admin | A_PSAA_S02_1 |
| AU2_PSAA_S02 | agency.admin | A_PSAA_S02_2 |
| <TestedUser> | <GlobalRole> | A_PSAA_S02_2 |
And logged in with details of 'AU1_PSAA_S02'
And uploaded file '/files/Fish1-Ad.mov' into library
And created 'C1_PSAA_S02' category
And added agency 'A_PSAA_S02_2' to category 'C1_PSAA_S02' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAA_S02'
And accepted all assets on Shared Collection 'C1_PSAA_S02' from agency 'A_PSAA_S02_1' page
And uploaded file '/files/Fish2-Ad.mov' into library
And created 'C2_PSAA_S02' category
And created 'LR_PSAA_S02' role in 'library' group for advertiser 'A_PSAA_S02_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| file.download              |
And added users '<TestedUser>' to category 'C2_PSAA_S02' with role 'LR_PSAA_S02' by users details
When I login with details of '<TestedUser>'
Then I 'should' see download original file '<FileName>' on asset '<AssetName>' info page for collection 'C2_PSAA_S02' after clicking Download original btn

Examples:
| TestedUser    | GlobalRole  | AssetName    | FileName            |
| TU_PSAA_S02_1 | agency.user | Fish1-Ad.mov | Fish1-Ad_master.mov |
| TU_PSAA_S02_2 | guest.user  | Fish1-Ad.mov | Fish1-Ad_master.mov |
| TU_PSAA_S02_3 | agency.user | Fish2-Ad.mov | Fish2-Ad_master.mov |
| TU_PSAA_S02_4 | guest.user  | Fish2-Ad.mov | Fish2-Ad_master.mov |


Scenario: Check that visibility of 'edit' links depends on 'asset.write' permission for autoshared asset
Meta:@gdam
@library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAA_S04' category
And added agency '<Agency2>' to category 'C1_PSAA_S04' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I  click shared collection 'C1_PSAA_S04' on the collection page for Agency '<Agency1>'NEWLIB
And I wait for '5' seconds
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S04' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAA_S04' category
And create  '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAA_S04' with role '<LibRole>' by users details
And login with details of '<TestedUser>'
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'C2_PSAA_S04'NEWLIB
Then I '<Condition>' see Edit link on opened asset info pageNEWLIB
When I go to asset 'Fish2-Ad.mov' info page in Library for collection 'C2_PSAA_S04'NEWLIB
Then I '<Condition>' see Edit link on opened asset info pageNEWLIB

Examples:
| TestedUser    | GlobalRole  | LibRole       | Permission  | Condition  |Agency1         |Agency2                |User1|User2|
| TU_PSAA_S04_1 | agency.user | LR_PSAA_S04_1 |             | should not |  A_PSAA_S04_1   |  A_PSAA_S04_2        |AU1_PSAA_S04|AU2_PSAA_S04|
| TU_PSAA_S04_2 | guest.user  | LR_PSAA_S04_2 |             | should not |  A_PSAA_S04_1_1 |   A_PSAA_S04_2_2     |AU3_PSAA_S04|AU4_PSAA_S04|
| TU_PSAA_S04_3 | agency.user | LR_PSAA_S04_3 | asset.write | should     |A_PSAA_S04_1_3   |A_PSAA_S04_1_4        |AU5_PSAA_S04|AU6_PSAA_S04|
| TU_PSAA_S04_4 | guest.user  | LR_PSAA_S04_4 | asset.write | should     |A_PSAA_S04_1_5   |A_PSAA_S04_1_6        |AU7_PSAA_S04|AU8_PSAA_S04|



Scenario: Check that 'edit asset' permission correctly works for autoshared asset
Meta:@gdam
@library
!--NGN-5992
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAA_S05' category
And added agency '<Agency2>' to category 'C1_PSAA_S05' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I  click shared collection 'C1_PSAA_S05' on the collection page for Agency '<Agency1>'NEWLIB
And I wait for '5' seconds
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAA_S05' category
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
And add users '<TestedUser>' to category 'C2_PSAA_S05' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<AssetName>' info page in Library for collection 'C2_PSAA_S05'NEWLIB
And I 'save' asset '<AssetName>' info of collection 'C2_PSAA_S05' by following informationNEWLIB:
| FieldName    | FieldValue   |
| Title        | FID_PSAA_S05 |
| Clock number | CNPFAVAA05   |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue   |
| Title     | FID_PSAA_S05 |

Examples:
| TestedUser    | GlobalRole  | AssetName    |Agency1     |Agency2         |User1       |User2       |LibRole|
| TU_PSAA_S05_1 | agency.user | Fish1-Ad.mov |A_PSAA_S05_1|A_PSAA_S05_2    |AU1_PSAA_S05|AU2_PSAA_S05|LR_PSAA_S05_1|
| TU_PSAA_S05_2 | guest.user  | Fish1-Ad.mov |A_PSAA_S05_1_1|A_PSAA_S05_2_2|AU3_PSAA_S05|AU4_PSAA_S05|LR_PSAA_S05_2|



Scenario: Check that availability of Remove menu point depends on 'delete asset' permission for autoshared asset on asset details
Meta:@gdam
@library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAA_S07' category
And added agency '<Agency2>' to category 'C1_PSAA_S07' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I  click shared collection 'C1_PSAA_S07' on the collection page for Agency '<Agency1>'NEWLIB
And I wait for '5' seconds
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S07' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my library
And create 'C2_PSAA_S07' category
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| <Permission>               |
|  asset.write|
And add users '<TestedUser>' to category 'C2_PSAA_S07' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<AssetName>' info page in Library for collection 'C2_PSAA_S07'NEWLIB
Then I '<Condition>' see 'remove' option in menu on opened asset info page NEWLIB

Examples:
| TestedUser    | GlobalRole  | LibRole       | Permission   | AssetName    | Condition  |Agency1      |Agency2         |User1       |User2       |
| TU_PSAA_S07_5 | agency.user | LR_PSAA_S07_1 |              | Fish2-Ad.mov | should not |A_PSAA_S07_1 |A_PSAA_S07_2    |AU1_PSAA_S07|AU2_PSAA_S07|
| TU_PSAA_S07_6 | guest.user  | LR_PSAA_S07_2 |              | Fish2-Ad.mov | should not |A_PSAA_S07_3 |A_PSAA_S07_4    |AU3_PSAA_S07|AU4_PSAA_S07|
| TU_PSAA_S07_7 | agency.user | LR_PSAA_S07_3 | asset.delete | Fish2-Ad.mov | should     |A_PSAA_S07_5 |A_PSAA_S07_6    |AU5_PSAA_S07|AU6_PSAA_S07|
| TU_PSAA_S07_8 | guest.user  | LR_PSAA_S07_4 | asset.delete | Fish2-Ad.mov | should     |A_PSAA_S07_7 |A_PSAA_S07_8    |AU7_PSAA_S07|AU8_PSAA_S07|


Scenario: Check that permissions are summarized for the same assigned shared asset
Meta:@gdam
@library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAA_S08' category
And added agency '<Agency2>' to category 'C1_PSAA_S08' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I  click shared collection 'C1_PSAA_S08' on the collection page for Agency '<Agency1>'NEWLIB
And I wait for '5' seconds
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S08' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create following categories:
| Name        |
| C2_PSAA_S08 |
| C3_PSAA_S08 |
And create '<LibRole1>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create '<LibRole2>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
And add users '<TestedUser>' to category 'C2_PSAA_S08' with role '<LibRole1>' by users details
And add users '<TestedUser>' to category 'C3_PSAA_S08' with role '<LibRole2>' by users details
And login with details of '<TestedUser>'
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'C2_PSAA_S08'NEWLIB
Then I 'should' see Edit link on opened asset info pageNEWLIB
When I go to asset 'Fish2-Ad.mov' info page in Library for collection 'C2_PSAA_S08'NEWLIB
Then I 'should' see Edit link on opened asset info pageNEWLIB

Examples:
| TestedUser    | GlobalRole  |Agency1      |Agency2         |User1       |User2       |LibRole1     |LibRole2 |
| TU_PSAA_S08_1 | agency.user |A_PSAA_S08_1 |A_PSAA_S08_2    |AU1_PSAA_S08|AU2_PSAA_S08|LR1_PSAA_S08|LR2_PSAA_S08|
| TU_PSAA_S08_2 | guest.user  |A_PSAA_S08_3 |A_PSAA_S08_4    |AU3_PSAA_S08|AU4_PSAA_S08|LR3_PSAA_S08|LR4_PSAA_S08|

Scenario: Check that summarized permissions for the same assigned shared asset correctly works
Meta:@gdam
@library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAA_S09' category
And added agency '<Agency2>' to category 'C1_PSAA_S09' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I  click shared collection 'C1_PSAA_S09' on the collection page for Agency '<Agency1>'NEWLIB
And I wait for '5' seconds
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S09' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create following categories:
| Name        |
| C2_PSAA_S09 |
| C3_PSAA_S09 |
And create '<LibRole1>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create '<LibRole2>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
And add users '<TestedUser>' to category 'C2_PSAA_S09' with role '<LibRole1>' by users details
And wait for '5' seconds
And add users '<TestedUser>' to category 'C3_PSAA_S09' with role '<LibRole2>' by users details
And login with details of '<TestedUser>'
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'C2_PSAA_S09'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue   |
| Title        | FID_PSAA_S09 |
| Clock number | CNPFAVAA14   |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue   |
| Title      | FID_PSAA_S09 |
When I go to asset 'Fish2-Ad.mov' info page in Library for collection 'C2_PSAA_S09'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue   |
| Title        | FID_PSAA_S09 |
| Clock number | CNPFAVAA14   |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue   |
| Title     | FID_PSAA_S09 |

Examples:
| TestedUser    | GlobalRole  |Agency1      |Agency2         |User1       |User2       |LibRole1     |LibRole2 |
| TU_PSAA_S09_1 | agency.user |A_PSAA_S09_1 |A_PSAA_S09_2 |AU1_PSAA_S09 |AU2_PSAA_S09|LR1_PSAA_S09|LR2_PSAA_S09|
| TU_PSAA_S09_2 | guest.user  |A_PSAA_S09_3 |A_PSAA_S09_4 |AU3_PSAA_S09 |AU4_PSAA_S09|LR3_PSAA_S09|LR4_PSAA_S09|


Scenario: Check that permissions aren't summarized for assets if they are located in different shared categories and these categories have been shared with different permissions (positive)
Meta:@gdam
@library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAA_S10' category
And added agency '<Agency2>' to category 'C1_PSAA_S10' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I  click shared collection 'C1_PSAA_S10' on the collection page for Agency '<Agency1>'NEWLIB
And I wait for '5' seconds
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S10' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create following categories:
| Name        |
| C2_PSAA_S10 |
| C3_PSAA_S10 |
And create '<LibRole1>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create '<LibRole2>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
And add users '<TestedUser>' to category 'C2_PSAA_S10' with role '<LibRole1>' by users details
And add users '<TestedUser>' to category 'C3_PSAA_S10' with role '<LibRole2>' by users details
And login with details of '<TestedUser>'
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'C3_PSAA_S10'NEWLIB
Then I 'should' see Edit link on opened asset info pageNEWLIB
When I go to asset 'Fish2-Ad.mov' info page in Library for collection 'C3_PSAA_S10'NEWLIB
Then I 'should' see Edit link on opened asset info pageNEWLIB

Examples:
| TestedUser    | GlobalRole  |Agency1      |Agency2         |User1       |User2       |LibRole1     |LibRole2 |
| TU_PSAA_S10_1 | agency.user |A_PSAA_S10_1 |A_PSAA_S10_2 |AU1_PSAA_S10 |AU2_PSAA_S10 |LR1_PSAA_S10 |LR2_PSAA_S10 |
| TU_PSAA_S10_2 | guest.user  |A_PSAA_S10_3 |A_PSAA_S10_4 |AU3_PSAA_S10 |AU4_PSAA_S10 |LR3_PSAA_S10 |LR4_PSAA_S10 |



Scenario: Check that removing correctly works for autoshared asset in category
Meta:@gdam
@library
Given I created the agency 'A_PSAA_S11_1' with default attributes
And created the agency 'A_PSAA_S11_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| AU1_PSAA_S11 | agency.admin | A_PSAA_S11_1 |streamlined_library|
| AU2_PSAA_S11 | agency.admin | A_PSAA_S11_2 |streamlined_library|
| <TestedUser> | <GlobalRole> | A_PSAA_S11_2 |streamlined_library|
And logged in with details of 'AU1_PSAA_S11'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAA_S11' category
And added agency 'A_PSAA_S11_2' to category 'C1_PSAA_S11' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAA_S11'
When I go to the collections page
And I refresh the page
And I  click shared collection 'C1_PSAA_S11' on the collection page for Agency 'A_PSAA_S11_1'NEWLIB
And I wait for '5' seconds
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S11' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAA_S11' category
And create 'LR_PSAA_S11' role in 'library' group for advertiser 'A_PSAA_S11_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.delete               |
And add users '<TestedUser>' to category 'C2_PSAA_S11' with role 'LR_PSAA_S11' by users details
And login with details of '<TestedUser>'
When go to the Library page for collection 'C2_PSAA_S11'NEWLIB
And remove asset 'Fish1-Ad.mov,Fish2-Ad.mov' from 'C2_PSAA_S11' collection
Then I 'should not' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in the collection 'C2_PSAA_S11'NEWLIB

Examples:
| TestedUser    | GlobalRole  |
| TU_PSAA_S11_1 | agency.user |

Scenario: Check that removing correctly works for autoshared asset on asset details
Meta:@gdam
@projects
Given I created the agency 'A_PSAA_S12_1' with default attributes
And created the agency 'A_PSAA_S12_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| AU1_PSAA_S12 | agency.admin | A_PSAA_S12_1 |
| AU2_PSAA_S12 | agency.admin | A_PSAA_S12_2 |
| <TestedUser> | <GlobalRole> | A_PSAA_S12_2 |
And logged in with details of 'AU1_PSAA_S12'
And uploaded file '/files/Fish1-Ad.mov' into library
And created 'C1_PSAA_S12' category
And added agency 'A_PSAA_S12_2' to category 'C1_PSAA_S12' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAA_S12'
And accepted all assets on Shared Collection 'C1_PSAA_S12' from agency 'A_PSAA_S12_1' page
And uploaded file '/files/Fish2-Ad.mov' into library
And created 'C2_PSAA_S12' category
And created 'LR_PSAA_S12' role in 'library' group for advertiser 'A_PSAA_S12_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.delete               |
And added users '<TestedUser>' to category 'C2_PSAA_S12' with role 'LR_PSAA_S12' by users details
When I login with details of '<TestedUser>'
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'C2_PSAA_S12'
And remove asset from opened asset details page
And go to asset 'Fish2-Ad.mov' info page in Library for collection 'C2_PSAA_S12'
And remove asset from opened asset details page
Then I 'should not' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in the collection 'C2_PSAA_S12'

Examples:
| TestedUser    | GlobalRole |
| TU_PSAA_S12_2 | guest.user |


Scenario: Check that visibility of 'Download' buttons depends on 'download file' permission for autoshared asset when file.download permission is not given
Meta:@gdam
@library
Given I created the agency 'A_PSAA_S01_1' with default attributes
And created the agency 'A_PSAA_S01_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_PSAA_S01_2 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |Access|
| AU1_PSAA_S01 | agency.admin | A_PSAA_S01_1 |streamlined_library,library|
| AU2_PSAA_S01 | agency.admin | A_PSAA_S01_2 |streamlined_library,library|
| <TestedUser> | <GlobalRole> | A_PSAA_S01_2 |streamlined_library,library|
And logged in with details of 'AU1_PSAA_S01'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And waited while preview is visible on library page for collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And created 'C1_PSAA_S01' category
And added agency 'A_PSAA_S01_2' to category 'C1_PSAA_S01' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAA_S01'
When I go to the collections page
And I  click shared collection 'C1_PSAA_S01' on the collection page for Agency 'A_PSAA_S01_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S01' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And I go to the Library page for collection 'My Assets'NEWLIB
And wait while preview is visible on library page for collection 'My Assets' for asset 'Fish2-Ad.mov'NEWLIB
And create 'C2_PSAA_S01' category
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAA_S01_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAA_S01' with role '<LibRole>' by users details
And login with details of '<TestedUser>'
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'C2_PSAA_S01'NEWLIB
Then I '<Condition>' see 'Download' button on opened asset info pageNEWLIB
When I go to asset 'Fish2-Ad.mov' info page in Library for collection 'C2_PSAA_S01'NEWLIB
Then I '<Condition>' see 'Download' button on opened asset info pageNEWLIB

Examples:
| TestedUser    | GlobalRole  | LibRole       | Permission    | Condition  |
| TU_PSAA_S01_1 | agency.user | LR_PSAA_S01_1 |               | should not |
| TU_PSAA_S01_2 | guest.user  | LR_PSAA_S01_1 |               | should not |


Scenario: Check that visibility of 'Download' buttons depends on 'download file' permission for autoshared asset when file.download permission is given
Meta:@gdam
@library
Given I created the agency 'A_PSAA_S01_1' with default attributes
And created the agency 'A_PSAA_S01_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_PSAA_S01_2 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |Access|
| AU1_PSAA_S01 | agency.admin | A_PSAA_S01_1 |streamlined_library,library|
| AU2_PSAA_S01 | agency.admin | A_PSAA_S01_2 |streamlined_library,library|
| <TestedUser> | <GlobalRole> | A_PSAA_S01_2 |streamlined_library,library|
And logged in with details of 'AU1_PSAA_S01'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And waited while preview is visible on library page for collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And created 'C1_PSAA_S01' category
And added agency 'A_PSAA_S01_2' to category 'C1_PSAA_S01' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAA_S01'
When I go to the collections page
And I  click shared collection 'C1_PSAA_S01' on the collection page for Agency 'A_PSAA_S01_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S01' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And I go to the Library page for collection 'My Assets'NEWLIB
And wait while preview is visible on library page for collection 'My Assets' for asset 'Fish2-Ad.mov'NEWLIB
And create 'C2_PSAA_S01' category
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAA_S01_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAA_S01' with role '<LibRole>' by users details
And login with details of '<TestedUser>'
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'C2_PSAA_S01'NEWLIB
Then I 'should not' see 'download proxy' button on opened asset info pageNEWLIB
And '<Condition>' see 'download original' button on opened asset info pageNEWLIB
And '<Condition>' see 'download sendplus' button on opened asset info pageNEWLIB
When I go to asset 'Fish2-Ad.mov' info page in Library for collection 'C2_PSAA_S01'NEWLIB
Then I 'should not' see 'download proxy' button on opened asset info pageNEWLIB
And '<Condition>' see 'download original' button on opened asset info pageNEWLIB
And '<Condition>' see 'download sendplus' button on opened asset info pageNEWLIB

Examples:
| TestedUser    | GlobalRole  | LibRole       | Permission    | Condition  |
| TU_PSAA_S01_3 | agency.user | LR_PSAA_S01_2 | file.download | should     |
| TU_PSAA_S01_4 | guest.user  | LR_PSAA_S01_2 | file.download | should     |



Scenario: Check that availability of Remove menu point depends on 'delete asset' permission for autoshared asset in category when asset.delete permission is not given
Meta:@gdam
@library
Given I created the agency 'A_PSAA_S06_1' with default attributes
And created the agency 'A_PSAA_S06_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_PSAA_S06_2 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |Access|
| AU1_PSAA_S06 | agency.admin | A_PSAA_S06_1 |streamlined_library,library|
| AU2_PSAA_S06 | agency.admin | A_PSAA_S06_2 |streamlined_library,library|
| <TestedUser> | <GlobalRole> | A_PSAA_S06_2 |streamlined_library,library|
And logged in with details of 'AU1_PSAA_S06'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAA_S06' category
And added agency 'A_PSAA_S06_2' to category 'C1_PSAA_S06' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAA_S06'
When I go to the collections page
And I  click shared collection 'C1_PSAA_S06' on the collection page for Agency 'A_PSAA_S06_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S06' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And create 'C2_PSAA_S06' category
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAA_S06_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAA_S06' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to the Library page for collection 'C2_PSAA_S06'NEWLIB
And I refresh the page
And I select asset '<AssetTitle>' in the 'C2_PSAA_S06'  library pageNEWLIB
Then I '<Condition>' see menu option in collection 'C2_PSAA_S06'NEWLIB


Examples:
| TestedUser    | GlobalRole  | LibRole       | Permission   | AssetTitle   | Condition  |
| TU_PSAA_S06_1 | agency.user | LR_PSAA_S06_1 |              | Fish1-Ad.mov | should not |
| TU_PSAA_S06_2 | guest.user  | LR_PSAA_S06_1 |              | Fish1-Ad.mov | should not |



Scenario: Check that availability of Remove menu point depends on 'delete asset' permission for autoshared asset in category when asset.delete permission is given
Meta:@gdam
@library
Given I created the agency 'A_PSAA_S06_1' with default attributes
And created the agency 'A_PSAA_S06_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_PSAA_S06_2 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |Access|
| AU1_PSAA_S06 | agency.admin | A_PSAA_S06_1 |streamlined_library,library|
| AU2_PSAA_S06 | agency.admin | A_PSAA_S06_2 |streamlined_library,library|
| <TestedUser> | <GlobalRole> | A_PSAA_S06_2 |streamlined_library,library|
And logged in with details of 'AU1_PSAA_S06'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_PSAA_S06' category
And added agency 'A_PSAA_S06_2' to category 'C1_PSAA_S06' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAA_S06'
When I go to the collections page
And I  click shared collection 'C1_PSAA_S06' on the collection page for Agency 'A_PSAA_S06_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S06' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C2_PSAA_S06' category
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAA_S06_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAA_S06' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And I select asset '<AssetTitle>' in the 'C2_PSAA_S06'  library pageNEWLIB
Then I 'should' see 'Remove' option in menu for collection 'C2_PSAA_S06'NEWLIB

Examples:
| TestedUser    | GlobalRole  | LibRole       | Permission   | AssetTitle   | Condition  |
| TU_PSAA_S06_3 | agency.user | LR_PSAA_S06_2 | asset.delete | Fish1-Ad.mov | should     |
| TU_PSAA_S06_4 | guest.user  | LR_PSAA_S06_2 | asset.delete | Fish1-Ad.mov | should     |



Scenario: Check that when No 'add asset to reel' permission the Add to new presentaion is disabled
Meta:@gdam
@bug
@library
!--can't be done until UIR-793 is fixed or QA-785 is fixed
Given I created the agency 'A_PSAA_S03_1' with default attributes
And created the agency 'A_PSAA_S03_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| AU1_PSAA_S03 | agency.admin | A_PSAA_S03_1 |streamlined_library,presentations|
| AU2_PSAA_S03 | agency.admin | A_PSAA_S03_2 |streamlined_library,presentations|
| <TestedUser> | <GlobalRole> | A_PSAA_S03_2 |streamlined_library,presentations|
And logged in with details of 'AU1_PSAA_S03'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
And created 'C1_PSAA_S03' category
And added agency 'A_PSAA_S03_2' to category 'C1_PSAA_S03' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAA_S03'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAA_S03' from agency 'A_PSAA_S03_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S03' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into library
And wait while preview is visible on library page for collection 'My Assets' for assets 'Fish2-Ad.mov'NEWLIB
And create 'C2_PSAA_S03' category
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAA_S03_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
|asset.write                 |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAA_S03' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to the library page for collection 'C2_PSAA_S03'NEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' in the 'C2_PSAA_S03'  library pageNEWLIB
Then I '<Condition>' see presentation pop up for collection 'C2_PSAA_S03'NEWLIB

Examples:
| TestedUser    | GlobalRole  | LibRole       | Permission                | Presentation | Condition  |
| TU_PSAA_S03_1 | agency.user | LR_PSAA_S03_1 |                           | P_PSAA_S03_1 | should not |


Scenario: Check that 'add asset to reel' permission correctly works for autoshared asset
Meta:@gdam
@library
Given I created the agency 'A_PSAA_S03_1' with default attributes
And created the agency 'A_PSAA_S03_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| AU1_PSAA_S03 | agency.admin | A_PSAA_S03_1 |streamlined_library,presentations|
| AU2_PSAA_S03 | agency.admin | A_PSAA_S03_2 |streamlined_library,presentations|
| <TestedUser> | <GlobalRole> | A_PSAA_S03_2 |streamlined_library,presentations|
And logged in with details of 'AU1_PSAA_S03'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
And created 'C1_PSAA_S03' category
And added agency 'A_PSAA_S03_2' to category 'C1_PSAA_S03' on Asset Categories and Permissions page
And logged in with details of 'AU2_PSAA_S03'
When I go to the collections page
And I go to the Shared Collection 'C1_PSAA_S03' from agency 'A_PSAA_S03_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_PSAA_S03' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into library
And wait while preview is visible on library page for collection 'My Assets' for assets 'Fish2-Ad.mov'NEWLIB
And create 'C2_PSAA_S03' category
And create '<LibRole>' role in 'library' group for advertiser 'A_PSAA_S03_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| <Permission>               |
And add users '<TestedUser>' to category 'C2_PSAA_S03' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to the library page for collection 'C2_PSAA_S03'NEWLIB
And I add assets 'Fish1-Ad.mov,Fish2-Ad.mov' to new presentation '<Presentation>' from collection 'C2_PSAA_S03' pageNEWLIB
And I go to the presentations assets page '<Presentation>'
Then I '<Condition>' see asset 'Fish1-Ad.mov' in the current presentation
And I '<Condition>' see asset 'Fish2-Ad.mov' in the current presentation

Examples:
| TestedUser    | GlobalRole  | LibRole       | Permission                | Presentation | Condition  |
| TU_PSAA_S03_2 | agency.user | LR_PSAA_S03_2 | asset.add_to_presentation | P_PSAA_S03_2 | should     |


