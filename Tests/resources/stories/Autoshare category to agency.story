!--NGN-4731 NGN-2298
Feature:          Autoshare category to agency
Narrative:
In order to
As a              AgencyAdmin
I want to         Check share category to agency


Scenario: Check that category with the same name as category in another agency can be shared to this agency
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Role         | Agency        |
| U_ACTA_S02_1 | agency.admin | DefaultAgency |
| U_ACTA_S02_2 | agency.admin | AnotherAgency |
And added agency 'AnotherAgency' as a partner to agency 'DefaultAgency'
And logged in with details of 'U_ACTA_S02_2'
And created following categories:
| Name       |
| C_ACTA_S02 |
And logged in with details of 'U_ACTA_S02_1'
And created following categories:
| Name       |
| C_ACTA_S02 |
And on collection 'C_ACTA_S02' on administration area collections page
When I click Add Agencies button for category 'C_ACTA_S02'
And specify agency name 'AnotherAgency' on Add Agencies popup
And save Add Agencies on the Add Agencies popup
Then I 'should' see agency 'AnotherAgency' in the agencies list for current category


Scenario: Check that autoshared category isn't displayed in Library tab of agency admin from agency which this category has been shared
Meta:@gdam
     @bug
     @library
!--UIR-1029
Given I created users with following fields:
| Email        | Role         | Agency        |Access|
| U_ACTA_S03_1 | agency.admin | DefaultAgency |streamlined_library|
| U_ACTA_S03_2 | agency.admin | AnotherAgency |streamlined_library|
And logged in with details of 'U_ACTA_S03_1'
And created following categories:
| Name       |
| С_ACTA_S03 |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| С_ACTA_S03   | AnotherAgency |
And logged in with details of 'U_ACTA_S03_2'
And I am on the Library page for collection 'Everything'NEWLIB
And I am on administration area collections page
When I go to user 'U_ACTA_S03_2' library page in administration area
Then I should see that users list is empty on the library tab for selected user

Scenario: Check that names of agency are displayed under Users & Agencies in this category if category has been shared with these agencies
Meta:@gdam
     @projects
Given I created the agency 'A_ACTA_S04_1' with default attributes
And created the agency 'A_ACTA_S04_2' with default attributes
And added agency 'A_ACTA_S04_1' as a partner to agency 'DefaultAgency'
And added agency 'A_ACTA_S04_2' as a partner to agency 'DefaultAgency'
And created following categories:
| Name       |
| С_ACTA_S04 |
And on collection 'С_ACTA_S04' on administration area collections page
When I click Add Agencies button for category 'С_ACTA_S04'
And specify agency name 'A_ACTA_S04_1' on Add Agencies popup
And save Add Agencies on the Add Agencies popup
When I click Add Agencies button for category 'С_ACTA_S04'
And specify agency name 'A_ACTA_S04_2' on Add Agencies popup
And save Add Agencies on the Add Agencies popup
Then I 'should' see agency 'A_ACTA_S04_1,A_ACTA_S04_2' in the agencies list for current category


Scenario: Check that asset from shared category is available in Everything and My Assets
Meta:@gdam
     @library
Given I created the agency 'A_ACTA_S05_1' with default attributes
And created the agency 'A_ACTA_S05_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| U_ACTA_S05_1 | agency.admin | A_ACTA_S05_1 |streamlined_library|
| U_ACTA_S05_2 | agency.admin | A_ACTA_S05_2 |streamlined_library|
And logged in with details of 'U_ACTA_S05_1'
And created following categories:
| Name       |
| С_ACTA_S05 |
And uploaded following assetsNEWLIB:
| Name                   |
| /files/atCalcImage.jpg |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| С_ACTA_S05   | A_ACTA_S05_2 |
And logged in with details of 'U_ACTA_S05_2'
When I go to the collections page
And I click shared collection 'С_ACTA_S05' on the collection page for Agency 'A_ACTA_S05_1'NEWLIB
And I select asset 'atCalcImage.jpg' for collection 'С_ACTA_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
When I go to the Library pageNEWLIB
Then I 'should' see assets 'atCalcImage.jpg' in the collection 'Everything'NEWLIB
When go to the Library page for collection 'My Assets'NEWLIB
Then 'should' see assets 'atCalcImage.jpg' in the collection 'My Assets'NEWLIB



Scenario: Check that autoshared assets are available for global search for assigned users
Meta:@gdam
     @library
Given I created the agency 'A_ACTA_S12_1' with default attributes
And created the agency 'A_ACTA_S12_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| U_ACTA_S12_1 | agency.admin | A_ACTA_S12_1 |dashboard,streamlined_library|
| U_ACTA_S12_2 | agency.admin | A_ACTA_S12_2 |dashboard,streamlined_library
And logged in with details of 'U_ACTA_S12_1'
And created following categories:
| Name         | MediaType |
| С_ACTA_S12_1 | image     |
And uploaded following assetsNEWLIB:
| Name                   |
| /images/admin.logo.jpg |
| /images/big.logo.png   |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| С_ACTA_S12_1 | A_ACTA_S12_2 |
And logged in with details of 'U_ACTA_S12_2'
When I go to the collections page
And I go to the Shared Collection 'С_ACTA_S12_1' from agency 'A_ACTA_S12_1' pageNEWLIB
And I select asset 'admin.logo.jpg,big.logo.png' for collection 'С_ACTA_S12_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'LR_ACTA_S12' role with 'asset_filter_category.read,asset.read' permissions in 'library' group for advertiser 'A_ACTA_S12_2'
And create users with following fields:
| Email       | Role       | Agency       |
| TU_ACTA_S12 | guest.user | A_ACTA_S12_2 |
And create following categories:
| Name         |
| С_ACTA_S12_2 |
And added next users for following categories:
| CategoryName | UserName    | RoleName    |
| С_ACTA_S12_2 | TU_ACTA_S12 | LR_ACTA_S12 |
And login with details of 'TU_ACTA_S12'
When I go to Dashboard page
And search by text 'logo'
Then I 'should' see search object 'admin.logo.jpg' with type 'Assets' after wrap according to search 'logo' with 'Name' type
And 'should' see show all results link on quick search menu


Scenario: Check that user will get notifications when assets are added to the collection for which he subscribes
Meta: @gdam
      @gdamemails
Given I created the agency 'A_ANFS_S01_1' with default attributes
And created the agency 'A_ANFS_S01_2' with default attributes
And added agencies 'A_ANFS_S01_2' as a partner to agency 'A_ANFS_S01_1'
And created users with following fields:
| Email        | Role         | Agency       |  Access               |
| U_ANFS_S01_1 | agency.admin | A_ANFS_S01_1 | streamlined_library   |
| U_ANFS_S01_2 | agency.admin | A_ANFS_S01_2 | streamlined_library,folders,dashboard   |
| U_ANFS_S01_3 | agency.admin | A_ANFS_S01_2 | streamlined_library,folders,dashboard   |
And logged in with details of 'U_ANFS_S01_1'
And created following categories:
| Name       | MediaType       |
| C_ANFS_S01 |  video          |
And I added next users for following categories:
| CategoryName   | UserName      | RoleName      |
| C_ANFS_S01     | U_ANFS_S01_2  | library.admin  |
| C_ANFS_S01     | U_ANFS_S01_3  | library.admin  |
And uploaded following assetsNEWLIB:
| Name                   |
| /files/Fish1-Ad.mov    |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And logged in with details of 'U_ANFS_S01_2'
And I am on my Notifications Settings page
And set notification 'Category Updated' into state 'on' for current user
And saved current user notifications setting
When I go to the collections page
And I search the collection 'C_ANFS_S01' on collections page
And I 'subscribe' collection 'C_ANFS_S01'
And login with details of 'U_ANFS_S01_1'
And upload following assetsNEWLIB:
| Name                   |
| /files/Fish2-Ad.mov    |
And wait while transcoding is finished in collection 'Everything'NEWLIB
And I have enable the Category Updated job to run every 1 min
Then I 'should' see that user 'U_ANFS_S01_2' received email for category update 'C_ANFS_S01' with interval
And I 'should not' see that user 'U_ANFS_S01_3' received email for category update 'C_ANFS_S01' with interval

Scenario: Check that user does not get notifications when assets are added to the collection for which he unsubscribes
Meta: @gdam
     @gdamemails
!--QA-999
Given I created the agency 'A_ANFS_S01_3' with default attributes
And created the agency 'A_ANFS_S01_4' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |  Access               |
| U_ANFS_S01_3 | agency.admin | A_ANFS_S01_3 | streamlined_library   |
| U_ANFS_S01_4 | agency.admin | A_ANFS_S01_4 | streamlined_library,folders,dashboard   |
And logged in with details of 'U_ANFS_S01_3'
And created following categories:
| Name       | MediaType       |
| C_ANFS_S01 |  video          |
And I added next users for following categories:
| CategoryName   | UserName      | RoleName      |
| C_ANFS_S01     | U_ANFS_S01_4  | library.admin  |
And uploaded following assetsNEWLIB:
| Name                   |
| /files/Fish1-Ad.mov    |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And logged in with details of 'U_ANFS_S01_4'
And I am on my Notifications Settings page
And set notification 'Category Updated' into state 'on' for current user
And saved current user notifications setting
When I go to the collections page
And I search the collection 'C_ANFS_S01' on collections page
And I 'subscribe' collection 'C_ANFS_S01'
And I 'unsubscribe' collection 'C_ANFS_S01'
And login with details of 'U_ANFS_S01_3'
And upload following assetsNEWLIB:
| Name                   |
| /files/Fish2-Ad.mov    |
Then I 'should not' see email with subject 'New assets in collection' sent to user 'U_ANFS_S01_4' and body contains 'NEW ASSETS IN COLLECTION'



Scenario: Check that shared category is created under Shared with me menu and assets when Accepted are displayed in My Assets
Meta:@gdam
     @library
!--QA-1022
!--QA-1098
!--QA-1031
Given I created the agency 'A_ACTA_S05_1' with default attributes
And created the agency 'A_ACTA_S05_2' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_ACTA_S05_2 | new-library-dev-version |
And added agency 'A_ACTA_S05_1' as a partner to agency 'A_ACTA_S05_2'
And created users with following fields:
| Email        | Role         | Agency       |  Access              |
| U_ACTA_S05_1 | agency.admin | A_ACTA_S05_1 |  streamlined_library   |
| U_ACTA_S05_2 | agency.admin | A_ACTA_S05_2 | streamlined_library   |
And logged in with details of 'U_ACTA_S05_1'
And created following categories:
| Name            | Media Type |
| <CategoryName>  | video      |
And uploaded following assetsNEWLIB:
| Name                   |
|/files/<Asset>          |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| <CategoryName> | A_ACTA_S05_2 |
And logged in with details of 'U_ACTA_S05_2'
When I go to the collections page
And I refresh the page
When I go to the Shared Collection '<CategoryName>' from agency 'A_ACTA_S05_1' pageNEWLIB
And I select asset '<Asset>' for collection '<CategoryName>' in the collections page
And I click '<AcceptReject>' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And wait for '2' seconds
And go to the Library page for collection 'My Assets'NEWLIB
Then I '<condition1>' see assets with titles '<Asset>' in the collection 'My Assets'NEWLIB
When I go to the collections page
When I go to the Shared Collection '<CategoryName>' from agency 'A_ACTA_S05_1' pageNEWLIB
Then I '<condition2>' see assets '<Asset>' on Shared collection pageNEWLIB
When I go to the library page for collection 'Everything'NEWLIB
Then I '<condition1>' see assets '<Asset>' in the collection 'Everything'NEWLIB

Examples:
|CategoryName      |  Asset          | AcceptReject      | condition1         |condition2|
| C_ACTA_S05       | Fish1-Ad.mov    | accept            |  should           |should not|


Scenario: Check that shared category is created under Shared with me menu and assets when rejected are not displayed in My Assets
Meta:@gdam
     @library
!--QA-1022
!--QA-1098
!--QA-1031
Given I created the agency 'A_ACTA_S05_1_1' with default attributes
And created the agency 'A_ACTA_S05_2_1' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_ACTA_S05_2_1 | new-library-dev-version |
And added agency 'A_ACTA_S05_1_1' as a partner to agency 'A_ACTA_S05_2_1'
And created users with following fields:
| Email        | Role         | Agency       |  Access              |
| U_ACTA_S05_1_1 | agency.admin | A_ACTA_S05_1_1 |  streamlined_library   |
| U_ACTA_S05_2_1 | agency.admin | A_ACTA_S05_2_1 | streamlined_library   |
And logged in with details of 'U_ACTA_S05_1_1'
And created following categories:
| Name            | Media Type |
| <CategoryName>  | video      |
And uploaded following assetsNEWLIB:
| Name                   |
|/files/<Asset>          |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| <CategoryName> | A_ACTA_S05_2_1 |
And logged in with details of 'U_ACTA_S05_2_1'
When I go to the collections page
And I refresh the page
When I go to the Shared Collection '<CategoryName>' from agency 'A_ACTA_S05_1_1' pageNEWLIB
And I select asset '<Asset>' for collection '<CategoryName>' in the collections page
And I click '<AcceptReject>' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And wait for '2' seconds
And go to the Library page for collection 'My Assets'NEWLIB
Then I '<condition1>' see assets with titles '<Asset>' in the collection 'My Assets'NEWLIB
When I go to the collections page
When I go to the Shared Collection '<CategoryName>' from agency 'A_ACTA_S05_1_1' pageNEWLIB
Then I '<condition2>' see assets '<Asset>' on Shared collection pageNEWLIB
When I go to the library page for collection 'Everything'NEWLIB
Then I '<condition1>' see assets '<Asset>' in the collection 'Everything'NEWLIB

Examples:
|CategoryName      |  Asset          | AcceptReject      | condition1         |condition2|
| C_ACTA_S05_1       | Fish2-Ad.mov    | reject            |  should not           |should not|


Scenario: Check that shared Category is not visible to Agency user
Meta:@gdam
     @library
!--QA-1098
Given I created the agency 'A_ACTA_S05_3' with default attributes
And created the agency 'A_ACTA_S05_4' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_ACTA_S05_4 | new-library-dev-version |
And waited for '2' seconds
And added agency 'A_ACTA_S05_3' as a partner to agency 'A_ACTA_S05_4'
And created users with following fields:
| Email        | Role         | Agency       |  Access              |
| U_ACTA_S05_3 | agency.admin | A_ACTA_S05_3 |  streamlined_library   |
| U_ACTA_S05_4 | agency.user  | A_ACTA_S05_4 | streamlined_library   |
And logged in with details of 'U_ACTA_S05_3'
And created following categories:
| Name            | Media Type |
| C_ACTA_S07      | video      |
And uploaded following assetsNEWLIB:
| Name                   |
|/files/Fish1-Ad.mov     |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S07   | A_ACTA_S05_4 |
And logged in with details of 'U_ACTA_S05_4'
When I go to the collections page
Then I 'should not' see the shared collections for Agency 'A_ACTA_S05_3':
|collection   |
|C_ACTA_S07   |

Scenario: Check that shared category does not show Tree, Filter, Info Icon, upload and download button
Meta:@gdam
     @library
!--QA-1098
Given I created the agency 'A_ACTA_S05_5' with default attributes
And created the agency 'A_ACTA_S05_6' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_ACTA_S05_6 | new-library-dev-version |
And added agency 'A_ACTA_S05_5' as a partner to agency 'A_ACTA_S05_6'
And created users with following fields:
| Email        | Role         | Agency       |  Access              |
| U_ACTA_S05_5 | agency.admin | A_ACTA_S05_5 |  streamlined_library   |
| U_ACTA_S05_6 | agency.admin | A_ACTA_S05_6 | streamlined_library   |
And logged in with details of 'U_ACTA_S05_5'
And created following categories:
| Name            | Media Type |
| C_ACTA_S07      | video      |
And uploaded following assetsNEWLIB:
| Name                   |
|/files/Fish1-Ad.mov     |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S07   | A_ACTA_S05_6 |
And logged in with details of 'U_ACTA_S05_6'
When I go to the collections page
And I refresh the page
Then I 'should' see collection 'C_ACTA_S07' from agency 'A_ACTA_S05_5' on inbox shared collectionNEWLIB
When I click shared collection 'C_ACTA_S07' on the collection page
Then I 'should not' see 'tree Icon,Info Icon,Filter Icon' for the collection
When I select asset 'Fish1-Ad.mov' for collection 'C_ACTA_S07' in the collections page
Then I 'should not' see 'Upload,Download' for the collection


Scenario: Check that Asset metadata is visible in the Shared Category
Meta:@gdam
     @library
!--QA-1098
Given I created the agency 'A_ACTA_S05_7' with default attributes
And created the agency 'A_ACTA_S05_8' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_ACTA_S05_8 | new-library-dev-version |
And added agency 'A_ACTA_S05_7' as a partner to agency 'A_ACTA_S05_8'
And created users with following fields:
| Email        | Role         | Agency       |  Access              |
| U_ACTA_S05_7 | agency.admin | A_ACTA_S05_7 |  streamlined_library   |
| U_ACTA_S05_8 | agency.admin | A_ACTA_S05_8 | streamlined_library   |
And logged in with details of 'U_ACTA_S05_7'
And created following categories:
| Name            | Media Type |
| C_ACTA_S07      | video      |
And uploaded following assetsNEWLIB:
| Name                   |
|/files/Fish1-Ad.mov     |
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name           | Advertiser  | Brand   |
| Fish1-Ad.mov   | TAFAR1      | TAFBR1  |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S07   | A_ACTA_S05_8 |
And logged in with details of 'U_ACTA_S05_8'
When I go to the collections page
And I refresh the page
Then I 'should' see collection 'C_ACTA_S07' from agency 'A_ACTA_S05_7' on inbox shared collectionNEWLIB
When I click shared collection 'C_ACTA_S07' on the collection page
And I select asset 'Fish1-Ad.mov' for collection 'C_ACTA_S07' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
Then 'should not' see assets with titles 'Fish1-Ad.mov' in the collection page
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue    |
| Advertiser                  | TAFAR1        |
| Brand                       | TAFBR1        |

Scenario: Check that shared category isn't visible in Categories tab of Admin menu and in Library
Meta:@gdam
     @library
Given I created users with following fields:
| Email        | Role         | Agency        |  Access             |
| U_ACTA_S01_1 | agency.admin | DefaultAgency | streamlined_library   |
| U_ACTA_S01_2 | agency.admin | AnotherAgency | streamlined_library   |
And updated the following agency:
| Name         | Labels                  |
| AnotherAgency | new-library-dev-version |
And added agency 'DefaultAgency' as a partner to agency 'AnotherAgency'
And logged in with details of 'U_ACTA_S01_1'
And created following categories:
| Name       |
| C_ACTA_S01 |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_ACTA_S01   | AnotherAgency |
When I login with details of 'U_ACTA_S01_2'
And go to administration area collections page
Then I should see following collections on administration area collections page:
| CategoryName | Should     |
| C_ACTA_S01   | should not |
When I go to the collections page
Then I 'should not' see on the library page collections 'C_ACTA_S01'NEWLIB

Scenario: Check that re-sharing on 3-rd agency works
Meta:@gdam
     @library
Given I created the agency 'A_ACTA_S06_1' with default attributes
And created the agency 'A_ACTA_S06_2' with default attributes
And created the agency 'A_ACTA_S06_3' with default attributes
And created users with following fields:
| Email        | Agency       |   Access               |
| U_ACTA_S06_1 | A_ACTA_S06_1 |  streamlined_library   |
| U_ACTA_S06_2 | A_ACTA_S06_2 |  streamlined_library   |
| U_ACTA_S06_3 | A_ACTA_S06_3 |  streamlined_library   |
And logged in with details of 'U_ACTA_S06_1'
And created following categories:
| Name         | MediaType |
| C_ACTA_S06_1 | video     |
And uploaded following assets:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S06_1 | A_ACTA_S06_2 |
And logged in with details of 'U_ACTA_S06_2'
And accepted all assets on Shared Collection 'C_ACTA_S06_1' from agency 'A_ACTA_S06_1' pageNEWLIB
And created following categories:
| Name         | MediaType |
| C_ACTA_S06_2 | video     |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S06_2 | A_ACTA_S06_3 |
When login with details of 'U_ACTA_S06_3'
And accept all assets on Shared Collection 'C_ACTA_S06_2' from agency 'A_ACTA_S06_2' pageNEWLIB
And create following categories:
| Name         | MediaType |
| C_ACTA_S06_3 | video     |
And go to  library pageNEWLIB
Then I 'should' see assets 'Fish2-Ad.mov,Fish1-Ad.mov' in the collection 'Everything'NEWLIB
And I 'should' see assets 'Fish2-Ad.mov,Fish1-Ad.mov' in the collection 'C_ACTA_S06_3'NEWLIB


Scenario: Check that added asset after autosharing agency appears for agency which this agency has been shared
Meta:@gdam
     @library
Given I created the agency 'A_ACTA_S07_1' with default attributes
And created the agency 'A_ACTA_S07_2' with default attributes
And created users with following fields:
| Email        | Agency       |  Access               |
| U_ACTA_S07_1 | A_ACTA_S07_1 | streamlined_library   |
| U_ACTA_S07_2 | A_ACTA_S07_2 | streamlined_library   |
And logged in with details of 'U_ACTA_S07_1'
And created following categories:
| Name         | MediaType |
| C_ACTA_S07_1 | video     |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S07_1 | A_ACTA_S07_2 |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish5-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And logged in with details of 'U_ACTA_S07_2'
And accepted all assets on Shared Collection 'C_ACTA_S07_1' from agency 'A_ACTA_S07_1' pageNEWLIB
And created following categories:
| Name         | MediaType |
| C_ACTA_S07_2 | video     |
When I go to the Library pageNEWLIB
Then I 'should' see assets 'Fish5-Ad.mov' in the collection 'Everything'NEWLIB
And I 'should' see assets 'Fish5-Ad.mov' in the collection 'C_ACTA_S07_2'NEWLIB

Scenario: Check that autoshared assets can be reshared within agency
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access                |
| <User1> | agency.admin | <Agency1> |streamlined_library   |
| <User2> | agency.admin | <Agency2> | streamlined_library   |
| <UserEmail>  | <GlobalRole> | <Agency2> | streamlined_library   |
And logged in with details of '<User1>'
And created following categories:
| Name         | MediaType |
| C_ACTA_S08_1 | video     |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish3-Ad.mov |
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish3-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S08_1 | <Agency2> |
And logged in with details of '<User2>'
When I go to the collections page
And accept all assets on Shared Collection 'C_ACTA_S08_1' from agency '<Agency1>' pageNEWLIB
And create '<LibRole>' role with 'asset_filter_category.read,asset.read' permissions in 'library' group for advertiser '<Agency2>'
And create following categories:
| Name         | MediaType |
| C_ACTA_S08_2 | video     |
And added next users for following categories:
| CategoryName | UserName    | RoleName    |
| C_ACTA_S08_2 | <UserEmail> | <LibRole> |
And login with details of '<UserEmail>'
And I am on the library assets page
Then I 'should' see assets 'Fish3-Ad.mov' in the collection 'Everything'NEWLIB
When go to the Library page for collection 'C_ACTA_S08_2'NEWLIB
Then I 'should' see assets 'Fish3-Ad.mov' in the collection 'C_ACTA_S08_2'NEWLIB


Examples:
| UserEmail     | GlobalRole  |Agency1     |Agency2     |User1       |User2       |LibRole    |
| TU_ACTA_S08_1 | agency.user |A_ACTA_S08_1|A_ACTA_S08_2|U_ACTA_S08_1|U_ACTA_S08_2|LR_ACTA_S08|
| TU_ACTA_S08_2 | guest.user |A_ACTA_S08_1_1|A_ACTA_S08_2_1|U_ACTA_S08_1_1|U_ACTA_S08_2_1|LR_ACTA_S08_1|


Scenario: Check that shared asset is available and collection can be created out of shared asset
Meta:@gdam
     @library
Given I created the agency 'A_ACTA_S09_1' with default attributes
And created the agency 'A_ACTA_S09_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |  Access                |
| U_ACTA_S09_1 | agency.admin | A_ACTA_S09_1 |  streamlined_library   |
| U_ACTA_S09_2 | agency.admin | A_ACTA_S09_2 |  streamlined_library   |
And logged in with details of 'U_ACTA_S09_1'
And created following categories:
| Name         | MediaType |
| C_ACTA_S09_1 | video     |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish6-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S09_1 | A_ACTA_S09_2 |
And logged in with details of 'U_ACTA_S09_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_ACTA_S09_1' from agency 'A_ACTA_S09_1' pageNEWLIB
And I select asset 'Fish6-Ad.mov' for collection 'C_ACTA_S09_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create following categories:
| Name         | MediaType  |
| C_ACTA_S09_2 | video      |
And go to the Library page for collection 'Everything'NEWLIB
When I select asset 'Fish6-Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_ACTA_S09_3' from collection 'Everything'NEWLIB
And go to the Library page for collection 'C_ACTA_S09_3'NEWLIB
Then I 'should' see assets 'Fish6-Ad.mov' in the collection 'C_ACTA_S09_3'NEWLIB

Scenario: Check that autoshared assets are available for global search
Meta:@gdam
     @library
Given I created the agency 'A_ACTA_S10_1' with default attributes
And created the agency 'A_ACTA_S10_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |   Access                 |
| U_ACTA_S10_1 | agency.admin | A_ACTA_S10_1 |  streamlined_library,dashboard     |
| U_ACTA_S10_2 | agency.admin | A_ACTA_S10_2 |  streamlined_library,dashboard    |
And logged in with details of 'U_ACTA_S10_1'
And created following categories:
| Name         | MediaType |
| C_ACTA_S10_1 | image     |
And uploaded following assetsNEWLIB:
| Name                   |
| /images/admin.logo.jpg |
| /images/big.logo.png   |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S10_1 | A_ACTA_S10_2 |
And logged in with details of 'U_ACTA_S10_2'
When I go to the collections page
And I go to the Shared Collection 'C_ACTA_S10_1' from agency 'A_ACTA_S10_1' pageNEWLIB
And I select asset 'admin.logo.jpg,big.logo.png' for collection 'C_ACTA_S10_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to Dashboard page
And search by text 'logo'
Then I 'should' see search object 'admin.logo.jpg,big.logo.png' with type 'Assets' after wrap according to search 'logo' with 'Name' type
And I 'should' see show all results link on quick search menu


Scenario: Check that autoshared assets are available for advanced search with media filter as image
Meta:@gdam
     @library
Given I created the agency 'A_ACTA_S11_1' with default attributes
And created the agency 'A_ACTA_S11_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_ACTA_S11_2 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |  Access                 |
| U_ACTA_S11_1 | agency.admin | A_ACTA_S11_1 | streamlined_library     |
| U_ACTA_S11_2 | agency.admin | A_ACTA_S11_2 |streamlined_library      |
And logged in with details of 'U_ACTA_S11_1'
And created following categories:
| Name         |
| C_ACTA_S11_1 |
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish9-Ad.mov  |
| /files/Fish10-Ad.mov |
| /files/Fish11-Ad.mov |
| /files/Fish12-Ad.mov |
| /files/image9.jpg    |
| /files/image10.jpg   |
| /files/GWGTest2.pdf  |
| /files/EnvIc.eps     |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name          | SubType  |
| Fish9-Ad.mov  | Rushes   |
| Fish10-Ad.mov | Elements |
| Fish11-Ad.mov | Rushes   |
| Fish12-Ad.mov | Rushes   |
| image9.jpg    | Print    |
| image10.jpg   |          |
| GWGTest2.pdf  |          |
| EnvIc.eps     |          |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S11_1 | A_ACTA_S11_2 |
And logged in with details of 'U_ACTA_S11_2'
When I go to the collections page
And I refresh the page
When I go to the Shared Collection 'C_ACTA_S11_1' from agency 'A_ACTA_S11_1' pageNEWLIB
And I select asset 'Fish9-Ad.mov,Fish10-Ad.mov,Fish11-Ad.mov,Fish12-Ad.mov,image9.jpg,image10.jpg,GWGTest2.pdf,EnvIc.eps' for collection 'C_ACTA_S11_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I create following categories:
| Name         |
| C_ACTA_S11_2 |
When I go to  Library page for collection 'C_ACTA_S11_2'NEWLIB
And I click on filter link on Collection details for collection 'C_ACTA_S11_2'NEWLIB
And switch 'on' media type filter '<MediaFilter>' on filter page
And add media subtype as filter collection:
| value               |
|<MediaSubType>       |
Then I 'should' see assets '<AssetInclude>' in the collection 'C_ACTA_S11_2'NEWLIB
And 'should not' see assets '<AssetExclude>' in the collection 'C_ACTA_S11_2'NEWLIB

Examples:
| MediaFilter | MediaSubType | AssetInclude                                                                 | AssetExclude                                                                                             |
| image       |  Print       | image9.jpg                                                                   | Fish9-Ad.mov,Fish10-Ad.mov,Fish11-Ad.mov,Fish12-Ad.mov,GWGTest2.pdf,EnvIc.eps,image10.jpg                |



Scenario: Check that autoshared assets are available for advanced search with media filter as video
Meta:@gdam
     @library
Given I created the agency 'A_ACTA_S11_3' with default attributes
And created the agency 'A_ACTA_S11_4' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_ACTA_S11_4 | new-library-dev-version |
And created users with following fields:
| Email        | Role         | Agency       |  Access                 |
| U_ACTA_S11_3 | agency.admin | A_ACTA_S11_3 | streamlined_library     |
| U_ACTA_S11_4 | agency.admin | A_ACTA_S11_4 |streamlined_library      |
And logged in with details of 'U_ACTA_S11_3'
And created following categories:
| Name         |
| C_ACTA_S11_3 |
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish9-Ad.mov  |
| /files/Fish10-Ad.mov |
| /files/Fish11-Ad.mov |
| /files/Fish12-Ad.mov |
| /files/image9.jpg    |
| /files/image10.jpg   |
| /files/GWGTest2.pdf  |
| /files/EnvIc.eps     |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name          | SubType  |
| Fish9-Ad.mov  | Rushes   |
| Fish10-Ad.mov | Elements |
| Fish11-Ad.mov | Rushes   |
| Fish12-Ad.mov | Rushes   |
| image9.jpg    | Print    |
| image10.jpg   |          |
| GWGTest2.pdf  |          |
| EnvIc.eps     |          |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S11_3 | A_ACTA_S11_4 |
And logged in with details of 'U_ACTA_S11_4'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_ACTA_S11_3' from agency 'A_ACTA_S11_3' pageNEWLIB
And I select asset 'Fish9-Ad.mov,Fish10-Ad.mov,Fish11-Ad.mov,Fish12-Ad.mov,image9.jpg,image10.jpg,GWGTest2.pdf,EnvIc.eps' for collection 'C_ACTA_S11_3' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I create following categories:
| Name         |
| C_ACTA_S11_2 |
When I go to  Library page for collection 'C_ACTA_S11_2'NEWLIB
And I click on filter link on Collection details for collection 'C_ACTA_S11_2'NEWLIB
And switch 'on' media type filter '<MediaFilter>' on filter page
And add media subtype as filter collection:
| value               |
|<MediaSubType>       |
Then I 'should' see assets '<AssetInclude>' in the collection 'C_ACTA_S11_2'NEWLIB
And 'should not' see assets '<AssetExclude>' in the collection 'C_ACTA_S11_2'NEWLIB

Examples:
| MediaFilter | MediaSubType | AssetInclude                                                                 | AssetExclude                                                                                             |
| video       | Rushes       | Fish9-Ad.mov,Fish11-Ad.mov,Fish12-Ad.mov                                     | image10.jpg,GWGTest2.pdf,EnvIc.eps,Fish10-Ad.mov,image9.jpg                                              |



Scenario: Check that you can see the list of assets selected in shared Category popup
Meta:@gdam
     @library
!--QA-1131
Given I created the agency 'A_LASIC_S05_1' with default attributes
And created the agency 'A_LASIC_S05_2' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_LASIC_S05_2 | new-library-dev-version |
And added agency 'A_LASIC_S05_1' as a partner to agency 'A_LASIC_S05_2'
And created users with following fields:
| Email         | Role         | Agency        |  Access              |
| U_LASIC_S05_1 | agency.admin | A_LASIC_S05_1 |  streamlined_library  |
| U_LASIC_S05_2 | agency.admin | A_LASIC_S05_2 | streamlined_library   |
And logged in with details of 'U_LASIC_S05_1'
And created following categories:
| Name         | Media Type |
| C_LASIC_S05  | video      |
And uploaded following assetsNEWLIB:
| Name                   |
|/files/Fish1-Ad.mov     |
|/files/Fish2-Ad.mov     |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_LASIC_S05  | A_LASIC_S05_2 |
And logged in with details of 'U_LASIC_S05_2'
When I go to the collections page
And I refresh the page
Then I 'should' see collection 'C_LASIC_S05' from agency 'A_LASIC_S05_1' on inbox shared collectionNEWLIB
When I click shared collection 'C_LASIC_S05' on the collection page
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_LASIC_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
Then I 'should' see 'Fish1-Ad.mov,Fish2-Ad.mov' in library Shared Category popup window

Scenario: Check that if you cancel asset in accept shared category window in the collection page then Asset is not accepted in the library
Meta:@gdam
     @library
!--QA-1131
Given I created the agency 'A_LASIC_S05_3' with default attributes
And created the agency 'A_LASIC_S05_4' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_LASIC_S05_4 | new-library-dev-version |
And added agency 'A_LASIC_S05_3' as a partner to agency 'A_LASIC_S05_4'
And created users with following fields:
| Email         | Role         | Agency        |  Access              |
| U_LASIC_S05_3 | agency.admin | A_LASIC_S05_3 |  streamlined_library  |
| U_LASIC_S05_4 | agency.admin | A_LASIC_S05_4 | streamlined_library   |
And logged in with details of 'U_LASIC_S05_3'
And created following categories:
| Name         | Media Type |
| C_LASIC_S05  | video      |
And uploaded following assetsNEWLIB:
| Name                   |
|/files/Fish1-Ad.mov     |
|/files/Fish2-Ad.mov     |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_LASIC_S05  | A_LASIC_S05_4 |
And logged in with details of 'U_LASIC_S05_4'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_LASIC_S05' from agency 'A_LASIC_S05_3' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_LASIC_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'cancel' button in accept reject assets popup
And wait for '2' seconds
And I go to  Library page for collection 'My Assets'NEWLIB
Then I 'should not' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in the collection 'My Assets'NEWLIB
When I go to the collections page
And I go to the Shared Collection 'C_LASIC_S05' from agency 'A_LASIC_S05_3' pageNEWLIB
Then I 'should' see assets 'Fish1-Ad.mov,Fish2-Ad.mov' on Shared collection pageNEWLIB
When I go to the library page for collection 'Everything'NEWLIB
Then I 'should not' see assets 'Fish1-Ad.mov,Fish2-Ad.mov' in the collection 'Everything'NEWLIB

