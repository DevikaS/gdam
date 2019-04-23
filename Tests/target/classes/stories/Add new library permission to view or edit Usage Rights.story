!--NGN-3367 NGN-5006
Feature:          Add new library permission to view or edit Usage Rights
Narrative:
In order to
As a              AgencyAdmin
I want to         Check new library permission to view or edit Usage Rights

Scenario: Check that Usage Rights permissions are available for library roles

Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
When I create 'LR_ANLP_S01' role in 'library' group for organization 'DefaultAgency'
Then I 'should' see 'available' permissions 'asset.usage_rights.read,asset.usage_rights.write' on opened global role page



Scenario: Check that 'asset.usage_rights.read' permission correctly works for different global roles
Meta:@library
     @gdam
Given I created the agency '<UserAgency>' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique |Access|
| <AdminUserEmail>  | agency.admin | <UserAgency> |streamlined_library|
| <TestedUserEmail> | <UserRole>   | <UserAgency> |streamlined_library|
And logged in with details of '<AdminUserEmail>'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created '<LibRole>' role in 'library' group for advertiser '<UserAgency>' with following permissions:
| Permission   |
| asset.read   |
| <Permission> |
|asset.write|
And created '<Category>' category
And added users '<TestedUserEmail>' for category '<Category>' with role '<LibRole>'
When I login with details of '<TestedUserEmail>'
And I go to asset 'Fish Ad.mov' info page in Library for collection '<Category>'NEWLIB
Then I '<Condition>' see 'Usage Rights' button on opened asset info pageNEWLIB
Examples:
| AdminUserEmail | TestedUserEmail | UserRole     | UserAgency   | Category     | LibRole       | Permission              | Condition  |
| AU_ANLP_S02_3  | TU_ANLP_S02_3   | agency.user  | A_ANLP_S02_3 | C_ANLP_S02_3 | LR_ANLP_S02_3 | asset.usage_rights.read | should     |
| AU_ANLP_S02_5  | TU_ANLP_S02_5   | guest.user   | A_ANLP_S02_5 | C_ANLP_S02_5 | LR_ANLP_S02_5 | asset.usage_rights.read | should     |


Scenario: Check that user can open 'Usage Rights' tab and view added usage right with 'asset.usage_rights.read' permission for different global roles
Meta:@library
     @gdam
Given I created the agency '<UserAgency>' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique |Access|
| <AdminUserEmail>  | agency.admin | <UserAgency> |streamlined_library|
| <TestedUserEmail> | <UserRole>   | <UserAgency> |streamlined_library|
And logged in with details of '<AdminUserEmail>'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created '<LibRole>' role in 'library' group for advertiser '<UserAgency>' with following permissions:
| Permission              |
| asset.read              |
| asset.usage_rights.read |
|asset.write              |
And created '<Category>' category
And added users '<TestedUserEmail>' for category '<Category>' with role '<LibRole>'
When I add Usage Right 'Other usage' for asset 'Fish Ad.mov' for collection '<Category>' with following fieldsNEWLIB:
| Comment      |
| test comment |
When I login with details of '<TestedUserEmail>'
Then I 'should' see following data for usage type 'Other usage' on asset 'Fish Ad.mov' usage rights page for collection '<Category>'NEWLIB:
| Comment      |
| test comment |

Examples:
| AdminUserEmail | TestedUserEmail | UserRole     | UserAgency   | Category     | LibRole       |
| AU_ANLP_S03_2  | TU_ANLP_S03_2   | agency.user  | A_ANLP_S03_2 | C_ANLP_S03_2 | LR_ANLP_S03_2 |
| AU_ANLP_S03_3  | TU_ANLP_S03_3   | guest.user   | A_ANLP_S03_3 | C_ANLP_S03_3 | LR_ANLP_S03_3 |



Scenario: Check visibility of 'Edit' link next to added usage right according to 'asset.usage_rights.write' permission for different global roles
Meta:@library
     @gdam
Given I created the agency '<UserAgency>' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique |Access|
| <AdminUserEmail>  | agency.admin | <UserAgency> |streamlined_library|
| <TestedUserEmail> | <UserRole>   | <UserAgency> |streamlined_library|
And logged in with details of '<AdminUserEmail>'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created '<LibRole>' role in 'library' group for advertiser '<UserAgency>' with following permissions:
| Permission              |
| asset.read              |
| asset.usage_rights.read |
| <Permission>            |
|asset.write|
And created '<Category>' category
And added users '<TestedUserEmail>' for category '<Category>' with role '<LibRole>'
When I add Usage Right 'Other usage' for asset 'Fish Ad.mov' for collection '<Category>' with following fieldsNEWLIB:
| Comment      |
| test comment |
When I login with details of '<TestedUserEmail>'
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection '<Category>'NEWLIB
Then I '<Condition>' see Edit link next to 'Other usage' usage type on opened asset usage rights pageNEWLIB

Examples:
| AdminUserEmail | TestedUserEmail | UserRole     | UserAgency   | Category     | LibRole       | Permission               | Condition  |
| AU_ANLP_S04_3  | TU_ANLP_S04_3   | agency.user  | A_ANLP_S04_3 | C_ANLP_S04_3 | LR_ANLP_S04_3 | asset.usage_rights.write | should     |
| AU_ANLP_S04_4  | TU_ANLP_S04_4   | agency.user  | A_ANLP_S04_4 | C_ANLP_S04_4 | LR_ANLP_S04_4 |                          | should not |
| AU_ANLP_S04_5  | TU_ANLP_S04_5   | guest.user   | A_ANLP_S04_5 | C_ANLP_S04_5 | LR_ANLP_S04_5 | asset.usage_rights.write | should     |
| AU_ANLP_S04_6  | TU_ANLP_S04_6   | guest.user   | A_ANLP_S04_6 | C_ANLP_S04_6 | LR_ANLP_S04_6 |                          | should not |


Scenario: Check that new usage right can be added to file into category assigned with 'asset.usage_rights.write' permission by user
Meta:@library
     @gdam
Given I created the agency '<UserAgency>' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique |Access|
| <AdminUserEmail>  | agency.admin | <UserAgency> |streamlined_library|
| <TestedUserEmail> | <UserRole>   | <UserAgency> |streamlined_library|
And logged in with details of '<AdminUserEmail>'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created '<LibRole>' role in 'library' group for advertiser '<UserAgency>' with following permissions:
| Permission               |
| asset.read               |
| asset.usage_rights.read  |
| asset.usage_rights.write |
|asset.write|
And created '<Category>' category
And added users '<TestedUserEmail>' for category '<Category>' with role '<LibRole>'
When I login with details of '<TestedUserEmail>'
And add Usage Right 'Other usage' for asset 'Fish Ad.mov' for collection '<Category>' with following fieldsNEWLIB:
| Comment      |
| test comment |
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |

Examples:
| AdminUserEmail | TestedUserEmail | UserRole     | UserAgency   | Category     | LibRole       |
| AU_ANLP_S05_2  | TU_ANLP_S05_2   | agency.user  | A_ANLP_S05_2 | C_ANLP_S05_2 | LR_ANLP_S05_2 |
| AU_ANLP_S05_3  | TU_ANLP_S05_3   | guest.user   | A_ANLP_S05_3 | C_ANLP_S05_3 | LR_ANLP_S05_3 |


Scenario: Check that usage right can be edited by user if category with file is assigned to user with 'asset.usage_rights.write' permission
Meta:@library
     @gdam
!--affected by NGN-4058
Given I created the agency '<UserAgency>' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique |Access|
| <AdminUserEmail>  | agency.admin | <UserAgency> |streamlined_library|
| <TestedUserEmail> | <UserRole>   | <UserAgency> |streamlined_library|
And logged in with details of '<AdminUserEmail>'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created '<LibRole>' role in 'library' group for advertiser '<UserAgency>' with following permissions:
| Permission               |
| asset.read               |
| asset.usage_rights.read  |
| asset.usage_rights.write |
|asset.write|
And created '<Category>' category
And added users '<TestedUserEmail>' for category '<Category>' with role '<LibRole>'
And added Usage Right 'Other usage' for asset 'Fish Ad.mov' for collection '<Category>' with following fieldsNEWLIB:
| Comment      |
| test comment |
When I login with details of '<TestedUserEmail>'
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection '<Category>'NEWLIB
When edit entry of 'Other usage' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      | EntryNumber     |
| updated test comment  | 1               |
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment              |
| updated test comment |

Examples:
| AdminUserEmail | TestedUserEmail | UserRole     | UserAgency   | Category     | LibRole       |
| AU_ANLP_S06_2  | TU_ANLP_S06_2   | agency.user  | A_ANLP_S06_2 | C_ANLP_S06_2 | LR_ANLP_S06_2 |
| AU_ANLP_S06_3  | TU_ANLP_S06_3   | guest.user   | A_ANLP_S06_3 | C_ANLP_S06_3 | LR_ANLP_S06_3 |



Scenario: Check that usage right can be deleted by user if category has been assigned to user with 'asset.usage_rights.write' permission
Meta:@library
     @gdam
!--affected by NGN-4058
Given I created the agency '<UserAgency>' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique |Access|
| <AdminUserEmail>  | agency.admin | <UserAgency> |streamlined_library|
| <TestedUserEmail> | <UserRole>   | <UserAgency> |streamlined_library|
And logged in with details of '<AdminUserEmail>'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created '<LibRole>' role in 'library' group for advertiser '<UserAgency>' with following permissions:
| Permission               |
| asset.read               |
| asset.usage_rights.read  |
| asset.usage_rights.write |
|asset.write|
And created '<Category>' category
And added users '<TestedUserEmail>' for category '<Category>' with role '<LibRole>'
And added Usage Right 'Other usage' for asset 'Fish Ad.mov' for collection '<Category>' with following fieldsNEWLIB:
| Comment      |
| test comment |
When I login with details of '<TestedUserEmail>'
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection '<Category>'NEWLIB
When delete entry of 'Other usage' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |

Examples:
| AdminUserEmail | TestedUserEmail | UserRole     | UserAgency   | Category     | LibRole       |
| AU_ANLP_S07_2  | TU_ANLP_S07_2   | agency.user  | A_ANLP_S07_2 | C_ANLP_S07_2 | LR_ANLP_S07_2 |
| AU_ANLP_S07_3  | TU_ANLP_S07_3   | guest.user   | A_ANLP_S07_3 | C_ANLP_S07_3 | LR_ANLP_S07_3 |