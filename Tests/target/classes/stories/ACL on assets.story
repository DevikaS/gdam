!--NGN-2397
Feature:          ACL on assets
Narrative:
In order to
As a              AgencyAdmin
I want to         Check ACL on assets

Scenario: Check that Create Asset permission can be specified only for Global Roles
Meta:@globaladmin
     @gdam
Given I created '<Role>' role in '<RoleType>' group for advertiser 'DefaultAgency'
And I logged in as 'GlobalAdmin'
And I opened role '<Role>' page with parent 'DefaultAgency'
Then I should see role '<Role>' that '<Should>' contains following permissions 'asset.create' available for selecting for 'DefaultAgency'

Examples:
| Role      | RoleType | Should     |
| ACLOAR1_1 | global   | should     |
| ACLOAR1_2 | project  | should not |
| ACLOAR1_3 | library  | should not |


Scenario: Check that Create Asset permission is specified for agency.admin and agency.user by default
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I opened role '<Role>' page with parent 'DefaultAgency'
Then I should see role '<Role>' that '<Should>' contains following selected permissions 'asset.create'

Examples:
| Role               | Should     |
| agency.admin       | should     |
| agency.user        | should     |
| agency.enums.read  | should not |
| agency.enums.write | should not |
| guest.user         | should not |





Scenario: Check that visibility of Edit link in the library depends on 'Edit Asset' permission
Meta:@library
     @gdam
Given I created '<roleName>' role with '<Permissions>' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role        | Access               |
| <email> | agency.user | streamlined_library   |
And I created following categories:
| Name    | Advertiser    |
| ACLOAC4 | DefaultAgency |
And created 'ACLOAP4' project
And created '/ACLOAF4' folder for project 'ACLOAP4'
And uploaded '/files/_file1.gif' file into '/ACLOAF4' folder for 'ACLOAP4' project
And waited while transcoding is finished in folder '/ACLOAF4' on project 'ACLOAP4' files page
When I send file '_file1.gif' on project 'ACLOAP4' folder '/ACLOAF4' page to Library
And fill following data on add file to library page:
| ID   |
| <Id> |
And click on element 'SaveButton'
And added next users for following categories:
| CategoryName | UserName | RoleName   |
| ACLOAC4      | <email>  | <roleName> |
And login with details of '<email>'
Then I '<Should>' see Edit link on asset '<Id>' info page in Library for collection 'ACLOAC4'NEWLIB

Examples:
| email     | roleName  | Permissions            | Should     | Id         |
| ACLOAU4_1 | ACLOAR4_1 | asset.read,asset.write | should     | ACLOAID4_1 |
| ACLOAU4_2 | ACLOAR4_2 | asset.read             | should not | ACLOAID4_2 |

Scenario: Check that visibility of Download original button on the asset details depends on 'Download File' permission
Meta:@library
     @gdam
Given I created '<roleName>' role with '<Permissions>' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role        |  Access              |
| <email> | agency.user | streamlined_library   |
And I created following categories:
| Name    | Advertiser    |
| ACLOAC5 | DefaultAgency |
And created 'ACLOAP5' project
And created '/ACLOAF5' folder for project 'ACLOAP5'
And uploaded '/files/_file1.gif' file into '/ACLOAF5' folder for 'ACLOAP5' project
And waited while transcoding is finished in folder '/ACLOAF5' on project 'ACLOAP5' files page
When I send file '_file1.gif' on project 'ACLOAP5' folder '/ACLOAF5' page to Library
And fill following data on add file to library page:
| ID   |
| <Id> |
And click on element 'SaveButton'
And added next users for following categories:
| CategoryName | UserName | RoleName   |
| ACLOAC5      | <email>  | <roleName> |
And login with details of '<email>'
Then I '<Should>' see Download Original button on asset '<Id>' info page in Library for collection 'ACLOAC5'NEWLIB

Examples:
| email     | roleName  | Permissions              | Should     | Id         |
| ACLOAU5_1 | ACLOAR5_1 | asset.read,file.download | should     | ACLOAID5_1 |
| ACLOAU5_2 | ACLOAR5_2 | asset.read               | should not | ACLOAID5_2 |


Scenario: Check that user can edit and download original assets in 'My Assets' category
Meta:@library
     @gdam
Given I created users with following fields:
| Email   | Role        | Access          |
| ACLOAU6 | agency.user | folders,streamlined_library  |
And I logged in with details of 'ACLOAU6'
And created 'ACLOAP6' project
And created '/ACLOAF6' folder for project 'ACLOAP6'
And uploaded '/files/_file1.gif' file into '/ACLOAF6' folder for 'ACLOAP6' project
And waited while transcoding is finished in folder '/ACLOAF6' on project 'ACLOAP6' files page
When I send file '_file1.gif' on project 'ACLOAP6' folder '/ACLOAF6' page to Library
And fill following data on add file to library page:
| ID       |
| ACLOAID6 |
And click on element 'SaveButton'
And go to asset 'ACLOAID6' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see Download Original button on asset 'ACLOAID6' info page in Library for collection 'My Assets'NEWLIB
And 'should' see Edit link on asset 'ACLOAID6' info page in Library for collection 'My Assets'NEWLIB


Scenario: Check downloading proxy/preview on the asset details
Meta:@library
     @gdam
Given I created '<LibraryRole>' role with '<RolePermissions>' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email        | Role         | Access         |
| <UserEmail>  | agency.user  | streamlined_library  |
And created following categories:
| Name           |
| <CategoryName> |
And created '<ProjectName>' project
And created '/F_ACLOA_S09' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ACLOA_S09' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_ACLOA_S09' on project '<ProjectName>' files page
When I move following files into library:
| ProjectName | Path        | FileName            | SubType |
| <ProjectName>  |/F_ACLOA_S09 | Fish Ad.mov        |         |
And added next users for following categories:
| CategoryName   | UserName    | RoleName      |
| <CategoryName> | <UserEmail> | <LibraryRole> |
And login with details of '<UserEmail>'
And wait for '4' seconds
And go to the Library page for collection 'My Assets'NEWLIB
And go to asset 'Fish Ad.mov' info page in Library for collection '<CategoryName>'NEWLIB
And refresh the page
Then I '<FirstCondition>' see 'Download Proxy' button on opened asset info pageNEWLIB
And '<SecondCondition>' see 'Download Original' button on opened asset info pageNEWLIB

Examples:
|UserEmail      |ProjectName    |CategoryName   |LibraryRole        |RolePermissions    |FirstCondition |SecondCondition    |
|U_ACLOA_S09_1  |P_ACLOA_S09_1  |C_ACLOA_S09_1  |PR_ACLOA_S09_1     |asset.write,asset.read,asset.create,file.download   |should not |should |
|U_ACLOA_S09_2  |P_ACLOA_S09_2  |C_ACLOA_S09_2  |PR_ACLOA_S09_2     |asset.write,asset.read,asset.create,proxy.download  |should |should not |


Scenario: Check editing asset details in the library
Meta:@library
     @gdam
Given I created 'ACLOAR7' role with 'asset.read,asset.write' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role        | Access                  |
| ACLOAU7 | agency.user | streamlined_library     |
And I created following categories:
| Name    | Advertiser    |
| ACLOAC7 | DefaultAgency |
And created 'ACLOAP7' project
And created '/ACLOAF7' folder for project 'ACLOAP7'
And uploaded '/files/_file1.gif' file into '/ACLOAF7' folder for 'ACLOAP7' project
And waited while transcoding is finished in folder '/ACLOAF7' on project 'ACLOAP7' files page
When I send file '_file1.gif' on project 'ACLOAP7' folder '/ACLOAF7' page to Library
And fill following data on add file to library page:
| ID       |
| ACLOAID7 |
And click on element 'SaveButton'
And added next users for following categories:
| CategoryName | UserName | RoleName |
| ACLOAC7      | ACLOAU7  | ACLOAR7  |
And login with details of 'ACLOAU7'
And go to asset 'ACLOAID7' info page in Library for collection 'ACLOAC7'NEWLIB
And 'save' asset 'ACLOAID7' info of collection 'ACLOAC7' by following informationNEWLIB:
| FieldName | FieldValue     |
| Title     | New Title.txt  |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue    |
| Title     | New Title.txt |


Scenario: User should not see not shared assets from partner BU
Meta:@gdam
     @library
Given I created the agency 'ACLOA_A1' with default attributes
And created the agency 'ACLOA_A2' with default attributes
And added agencies 'ACLOA_A2' as a partner to agency 'ACLOA_A1'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACLOA_A1':
| Advertiser | Brand      | Sub Brand   | Product    |
| ACLOA_A1_A | ACLOA_A1_B | ACLOA_A1_SB | ACLOA_A1_P |
And created users with following fields:
| Email    | Role         | AgencyUnique | Access                |
| ACLOA_U1 | agency.admin | ACLOA_A1     | streamlined_library   |
| ACLOA_U2 | agency.admin | ACLOA_A2     | streamlined_library   |
When I login with details of 'ACLOA_U1'
And upload following assetsNEWLIB:
| Name             |
| /images/logo.gif |
| /images/logo.jpg |
| /images/logo.png |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to asset 'logo.gif' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Advertiser | ACLOA_A1_A |
And create 'ACLOA_C1' category
And add users 'ACLOA_U2' for category 'ACLOA_C1' with role 'library.user'
And add into category 'ACLOA_C1' following metadata:
| FilterName | FilterValue |
| Advertiser | ACLOA_A1_A  |
And login with details of 'ACLOA_U2'
And I go to the Library pageNEWLIB
And I click on filter link for collection 'Everything'
And select 'Business Unit' with value 'ACLOA_A1' in the collection 'Everything'NEWLIB
Then I 'should' see assets 'logo.gif' in the collection 'Everything'NEWLIB
And 'should not' see assets 'logo.jpg,logo.png' in the collection 'Everything'NEWLIB


Scenario: Check that visibility of Upload button in the library depends on 'Create Asset' permission
Meta:@library
     @gdam
Given I created '<roleName>' role with '<Permissions>' permissions in 'global' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role       | Access           |
| <email> | <roleName> | streamlined_library   |
And I logged in with details of '<email>'
And I am on library page for collection 'My Assets'NEWLIB
Then I '<Should>' see Upload button on collection 'My Assets' in LibraryNEWLIB

Examples:
| email     | roleName  | Permissions  | Should     |
| ACLOAU3_1 | ACLOAR3_1 | asset.create | should     |
| ACLOAU3_2 | ACLOAR3_2 |              | should not |