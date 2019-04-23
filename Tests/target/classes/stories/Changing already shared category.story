!--NGN-4728 NGN-2298
Feature:          Changing already shared category
Narrative:
In order to
As a              AgencyAdmin
I want to         check changing already shared category



Scenario: Check that changing of role on Category details correctly affects shared asset(agency user)
Meta:@gdam
     @library
Given I created the agency 'A_CASC_S01_1' with default attributes
And created the agency 'A_CASC_S01_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_CASC_S01_2 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |Access|
| U_CASC_S01_1 | agency.admin | A_CASC_S01_1 |streamlined_library,library|
| U_CASC_S01_2 | agency.admin | A_CASC_S01_2 |streamlined_library,library|
| <UserEmail>  | <GlobalRole> | A_CASC_S01_2 |streamlined_library,library|
And created 'LR_CASC_S01_1' role with 'asset_filter_category.read,asset.read,asset.write' permissions in 'library' group for advertiser 'A_CASC_S01_2'
And created 'LR_CASC_S01_2' role with 'asset_filter_category.read,asset.read,proxy.download,file.download' permissions in 'library' group for advertiser 'A_CASC_S01_2'
And logged in with details of 'U_CASC_S01_1'
And created following categories:
| Name                 |
| <CategoryForSharing> |
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And I waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName         | AgencyName   |
| <CategoryForSharing> | A_CASC_S01_2 |
And logged in with details of 'U_CASC_S01_2'
When I go to the collections page
And I click shared collection '<CategoryForSharing>' on the collection page for Agency 'A_CASC_S01_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection '<CategoryForSharing>' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create following categories:
| Name                 |
| <CategoryToMapShare> |
And I go to administration area collections page
And add users '<UserEmail>' for category '<CategoryToMapShare>' with role 'LR_CASC_S01_1'
And go to the Library page for collection 'My Assets'NEWLIB
And upload following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov   |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to administration area collections page
And I refresh the page
And change role for users '<UserEmail>' in category '<CategoryToMapShare>' with role 'LR_CASC_S01_2'
And I wait for '5' seconds
And I login with details of '<UserEmail>'
And go to asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
Then 'should not' see Edit link on asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
And I 'should' see 'download proxy' button on opened asset info pageNEWLIB
And I 'should' see 'download original' button on opened asset info pageNEWLIB
And I 'should' see 'download sendplus' button on opened asset info pageNEWLIB

Examples:
| UserEmail    | GlobalRole  | AssetName    | CategoryForSharing | CategoryToMapShare |
| U_CASC_S01_U1 | agency.user | Fish1-Ad.mov | C_CASC_S01_1       | C_CASC_S01_5       |


Scenario: Check that changing of role on Category details correctly affects shared asset(guest user)
Meta:@gdam
     @library
Given I created the agency 'A_CASC_S01_3' with default attributes
And created the agency 'A_CASC_S01_4' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_CASC_S01_4 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |Access|
| U_CASC_S01_3 | agency.admin | A_CASC_S01_3 |streamlined_library,library|
| U_CASC_S01_4 | agency.admin | A_CASC_S01_4 |streamlined_library,library|
| <UserEmail>  | <GlobalRole> | A_CASC_S01_4 |streamlined_library,library|
And created 'LR_CASC_S01_1' role with 'asset_filter_category.read,asset.read,asset.write' permissions in 'library' group for advertiser 'A_CASC_S01_4'
And created 'LR_CASC_S01_2' role with 'asset_filter_category.read,asset.read,proxy.download,file.download' permissions in 'library' group for advertiser 'A_CASC_S01_4'
And logged in with details of 'U_CASC_S01_3'
And created following categories:
| Name                 |
| <CategoryForSharing> |
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And I waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName         | AgencyName   |
| <CategoryForSharing> | A_CASC_S01_4 |
And logged in with details of 'U_CASC_S01_4'
When I go to the collections page
And I click shared collection '<CategoryForSharing>' on the collection page for Agency 'A_CASC_S01_3'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection '<CategoryForSharing>' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create following categories:
| Name                 |
| <CategoryToMapShare> |
And I go to administration area collections page
And add users '<UserEmail>' for category '<CategoryToMapShare>' with role 'LR_CASC_S01_1'
And go to the Library page for collection 'My Assets'NEWLIB
And upload following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov   |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to administration area collections page
And I refresh the page
And change role for users '<UserEmail>' in category '<CategoryToMapShare>' with role 'LR_CASC_S01_2'
And I wait for '5' seconds
And I login with details of '<UserEmail>'
And go to asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
Then 'should not' see Edit link on asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
And I 'should' see 'download proxy' button on opened asset info pageNEWLIB
And I 'should' see 'download original' button on opened asset info pageNEWLIB
And I 'should' see 'download sendplus' button on opened asset info pageNEWLIB

Examples:
| UserEmail    | GlobalRole  | AssetName    | CategoryForSharing | CategoryToMapShare |
| U_CASC_S01_U2 | guest.user  | Fish2-Ad.mov | C_CASC_S01_4       | C_CASC_S01_8       |



Scenario: Check that changing of role in User details on Library tab correctly affects shared asset(agency user)
Meta:@gdam
     @library
Given I created the agency 'A_CASC_S02_5' with default attributes
And created the agency 'A_CASC_S02_6' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_CASC_S02_6 | new-library-dev-version |
And I created users with following fields:
| Email        | Role         | Agency       |Access|
| U_CASC_S02_5 | agency.admin | A_CASC_S02_5 |streamlined_library,library|
| U_CASC_S02_6 | agency.admin | A_CASC_S02_6 |streamlined_library,library|
| <UserEmail>  | <GlobalRole> | A_CASC_S02_6 |streamlined_library,library|
And created 'LR_CASC_S02_1' role with 'asset_filter_category.read,asset.read,asset.write' permissions in 'library' group for advertiser 'A_CASC_S02_6'
And created 'LR_CASC_S02_2' role with 'asset_filter_category.read,asset.read,proxy.download,file.download' permissions in 'library' group for advertiser 'A_CASC_S02_6'
And logged in with details of 'U_CASC_S02_5'
And created following categories:
| Name                 |
| <CategoryForSharing> |
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And I waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName         | AgencyName   |
| <CategoryForSharing> | A_CASC_S02_6 |
And logged in with details of 'U_CASC_S02_6'
When I go to the collections page
And I click shared collection '<CategoryForSharing>' on the collection page for Agency 'A_CASC_S02_5'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection '<CategoryForSharing>' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create following categories:
| Name                 |
| <CategoryToMapShare> |
And I go to administration area collections page
And add users '<UserEmail>' for category '<CategoryToMapShare>' with role 'LR_CASC_S02_1'
And upload following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov   |
And I go to the Library page for collection 'My Assets'NEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to administration area collections page
And I go to user '<UserEmail>' library page in administration area
And assign the following categories for opened user details on users page:
| CategoryName         | RoleName      |
| <CategoryToMapShare> | LR_CASC_S02_2 |
And remove the following categories from opened user details on users page:
| CategoryName         | RoleName      |
| <CategoryToMapShare> | LR_CASC_S02_1 |
And save user details on users page
And login with details of '<UserEmail>'
And go to asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
Then 'should not' see Edit link on asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
And I 'should' see 'download proxy' button on opened asset info pageNEWLIB
And I 'should' see 'download original' button on opened asset info pageNEWLIB
And I 'should' see 'download sendplus' button on opened asset info pageNEWLIB


Examples:
| UserEmail    | GlobalRole  | AssetName    | CategoryForSharing | CategoryToMapShare |
| U_CASC_S02_U3 | agency.user | Fish1-Ad.mov | C_CASC_S02_1       | C_CASC_S02_5       |


Scenario: Check that changing of role in User details on Library tab correctly affects shared asset(guest user)
Meta:@gdam
     @library
Given I created the agency 'A_CASC_S02_7' with default attributes
And created the agency 'A_CASC_S02_8' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_CASC_S02_8 | new-library-dev-version |
And I created users with following fields:
| Email        | Role         | Agency       |Access|
| U_CASC_S02_7 | agency.admin | A_CASC_S02_7 |streamlined_library,library|
| U_CASC_S02_8 | agency.admin | A_CASC_S02_8 |streamlined_library,library|
| <UserEmail>  | <GlobalRole> | A_CASC_S02_8 |streamlined_library,library|
And created 'LR_CASC_S02_1' role with 'asset_filter_category.read,asset.read,asset.write' permissions in 'library' group for advertiser 'A_CASC_S02_8'
And created 'LR_CASC_S02_2' role with 'asset_filter_category.read,asset.read,proxy.download,file.download' permissions in 'library' group for advertiser 'A_CASC_S02_8'
And logged in with details of 'U_CASC_S02_7'
And created following categories:
| Name                 |
| <CategoryForSharing> |
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And I waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName         | AgencyName   |
| <CategoryForSharing> | A_CASC_S02_8 |
And logged in with details of 'U_CASC_S02_8'
When I go to the collections page
And I click shared collection '<CategoryForSharing>' on the collection page for Agency 'A_CASC_S02_7'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection '<CategoryForSharing>' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create following categories:
| Name                 |
| <CategoryToMapShare> |
And I go to administration area collections page
And add users '<UserEmail>' for category '<CategoryToMapShare>' with role 'LR_CASC_S02_1'
And upload following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov   |
And I go to the Library page for collection 'My Assets'NEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to administration area collections page
And I go to user '<UserEmail>' library page in administration area
And assign the following categories for opened user details on users page:
| CategoryName         | RoleName      |
| <CategoryToMapShare> | LR_CASC_S02_2 |
And remove the following categories from opened user details on users page:
| CategoryName         | RoleName      |
| <CategoryToMapShare> | LR_CASC_S02_1 |
And save user details on users page
And login with details of '<UserEmail>'
And go to asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
Then 'should not' see Edit link on asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
And I 'should' see 'download proxy' button on opened asset info pageNEWLIB
And I 'should' see 'download original' button on opened asset info pageNEWLIB
And I 'should' see 'download sendplus' button on opened asset info pageNEWLIB


Examples:
| UserEmail    | GlobalRole  | AssetName    | CategoryForSharing | CategoryToMapShare |
| U_CASC_S02_6 | guest.user  | Fish2-Ad.mov | C_CASC_S02_4       | C_CASC_S02_8       |


Scenario: Check that changing of permissions set for library role correctly affects shared asset(agency user)
Meta:@gdam
     @library
Given I created the agency 'A_CASC_S03_9' with default attributes
And created the agency 'A_CASC_S03_10' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_CASC_S03_10 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |Access|
| U_CASC_S03_9 | agency.admin | A_CASC_S03_9 |streamlined_library,library|
| U_CASC_S03_10 | agency.admin | A_CASC_S03_10 |streamlined_library,library|
| <UserEmail>  | <GlobalRole> | A_CASC_S03_10 |streamlined_library,library|
And created 'LR_CASC_S03_1' role with 'asset_filter_category.read,asset.read,asset.write' permissions in 'library' group for advertiser 'A_CASC_S03_10'
And logged in with details of 'U_CASC_S03_9'
And created following categories:
| Name                 |
| <CategoryForSharing> |
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And I waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName         | AgencyName   |
| <CategoryForSharing> | A_CASC_S03_10 |
And logged in with details of 'U_CASC_S03_10'
When I go to the collections page
And I refresh the page
When I go to the Shared Collection '<CategoryForSharing>' from agency 'A_CASC_S03_9' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection '<CategoryForSharing>' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create following categories:
| Name                 |
| <CategoryToMapShare> |
And I go to administration area collections page
And add users '<UserEmail>' for category '<CategoryToMapShare>' with role 'LR_CASC_S03_1'
And upload following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov   |
And I go to the Library page for collection 'My Assets'NEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I login with details of 'GlobalAdmin'
And I update role 'LR_CASC_S03_1' role by following 'asset_filter_category.read,asset.read,proxy.download,file.download' permissions for advertiser 'A_CASC_S03_10'
And login with details of '<UserEmail>'
And go to asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
Then 'should not' see Edit link on asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
And I 'should' see 'download proxy' button on opened asset info pageNEWLIB
And I 'should' see 'download original' button on opened asset info pageNEWLIB
And I 'should' see 'download sendplus' button on opened asset info pageNEWLIB

Examples:
| UserEmail    | GlobalRole  | AssetName    | CategoryForSharing | CategoryToMapShare |
| U_CASC_S03_7 | agency.user | Fish1-Ad.mov | C_CASC_S03_1       | C_CASC_S03_5       |


Scenario: Check that changing of permissions set for library role correctly affects shared asset(guest user)
Meta:@gdam
     @library
Given I created the agency 'A_CASC_S03_11' with default attributes
And created the agency 'A_CASC_S03_12' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_CASC_S03_12 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |Access|
| U_CASC_S03_11 | agency.admin | A_CASC_S03_11 |streamlined_library,library|
| U_CASC_S03_12 | agency.admin | A_CASC_S03_12 |streamlined_library,library|
| <UserEmail>  | <GlobalRole> | A_CASC_S03_12 |streamlined_library,library|
And created 'LR_CASC_S03_1' role with 'asset_filter_category.read,asset.read,asset.write' permissions in 'library' group for advertiser 'A_CASC_S03_12'
And logged in with details of 'U_CASC_S03_11'
And created following categories:
| Name                 |
| <CategoryForSharing> |
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And I waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName         | AgencyName   |
| <CategoryForSharing> | A_CASC_S03_12 |
And logged in with details of 'U_CASC_S03_12'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection '<CategoryForSharing>' from agency 'A_CASC_S03_11' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection '<CategoryForSharing>' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create following categories:
| Name                 |
| <CategoryToMapShare> |
And I go to administration area collections page
And add users '<UserEmail>' for category '<CategoryToMapShare>' with role 'LR_CASC_S03_1'
And upload following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov   |
And I go to the Library page for collection 'My Assets'NEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I login with details of 'GlobalAdmin'
And I update role 'LR_CASC_S03_1' role by following 'asset_filter_category.read,asset.read,proxy.download,file.download' permissions for advertiser 'A_CASC_S03_12'
And I wait for '3' seconds
And login with details of '<UserEmail>'
And go to asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
Then 'should not' see Edit link on asset '<AssetName>' info page in Library for collection '<CategoryToMapShare>'NEWLIB
And I 'should' see 'download proxy' button on opened asset info pageNEWLIB
And I 'should' see 'download original' button on opened asset info pageNEWLIB
And I 'should' see 'download sendplus' button on opened asset info pageNEWLIB

Examples:
| UserEmail    | GlobalRole  | AssetName    | CategoryForSharing | CategoryToMapShare |
| U_CASC_S03_8 | guest.user  | Fish2-Ad.mov | C_CASC_S03_4       | C_CASC_S03_8       |




