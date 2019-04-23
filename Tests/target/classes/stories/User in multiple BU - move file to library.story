!--NGN-11695
Feature:          User in multiple BU - move file to library
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user in multiple BU can move file to library


Scenario: Check that agency/guest user could move file to project creator library, asset should go to correct BU's library (user from another BU)
Meta:@gdam
@library
Given I created the agency 'A_UIMBUMFTL_S01' with default attributes
And created the agency '<TestesAgencyName>' with default attributes
And created users with following fields:
| Email             | Role         | Agency             | Access          |
| U_UIMBUMFTL_S01_1 | agency.admin | A_UIMBUMFTL_S01    | streamlined_library,library,folders |
| U_UIMBUMFTL_S01_2 | agency.admin | <TestesAgencyName> | streamlined_library,library,folders |
| <TestedUserEmail> | <GlobalRole> | <TestesAgencyName> | streamlined_library,library,folders |
And logged in with details of 'U_UIMBUMFTL_S01_1'
And created '<CategoryName>' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName   | UserName          | RoleName      |
| <CategoryName> | <TestedUserEmail> | library.admin |
And logged in with details of 'U_UIMBUMFTL_S01_2'
And created '<ProjectName>' project
And created '/F_UIMBUMFTL_S01' folder for project '<ProjectName>'
And added users '<TestedUserEmail>' to project '<ProjectName>' team with role 'project.admin' expired '02.02.2020'
And logged in with details of '<TestedUserEmail>'
And I am on the Library page for collection '<CategoryName>'NEWLIB
And I added following asset 'image10.jpg' of collection '<CategoryName>' to project '<ProjectName>' folder '/F_UIMBUMFTL_S01'NEWLIB
When I move file 'image10.jpg' from project '<ProjectName>' folder '/F_UIMBUMFTL_S01' to new library page
And login with details of 'U_UIMBUMFTL_S01_2'
And I go to the Library pageNEWLIB
Then I 'should' see assets 'image10.jpg' in the collection 'Everything'NEWLIB
Examples:
| TestesAgencyName   | TestedUserEmail    | GlobalRole  | CategoryName      | ProjectName       |
| TA_UIMBUMFTL_S01_1 | TU_UIMBUMFTL_S01_1 | agency.user | C_UIMBUMFTL_S01_1 | P_UIMBUMFTL_S01_1 |
| TA_UIMBUMFTL_S01_2 | TU_UIMBUMFTL_S01_2 | guest.user  | C_UIMBUMFTL_S01_2 | P_UIMBUMFTL_S01_2 |


Scenario: Check that agency/guest user could move file to project creator library, asset should appear in project creator library (user from current BU)
Meta:@gdam
@library
Given I created the agency 'A_UIMBUMFTL_S02' with default attributes
And created users with following fields:
| Email             | Role         | Agency          | Access          |
| U_UIMBUMFTL_S02_1 | agency.admin | A_UIMBUMFTL_S02 | streamlined_library,library,folders |
| U_UIMBUMFTL_S02_2 | agency.admin | A_UIMBUMFTL_S02 | streamlined_library,library,folders |
| <TestedUserEmail> | <GlobalRole> | A_UIMBUMFTL_S02 | streamlined_library,library,folders |
And logged in with details of 'U_UIMBUMFTL_S02_1'
And created '<CategoryName>' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName   | UserName          | RoleName      |
| <CategoryName> | <TestedUserEmail> | library.admin |
And logged in with details of 'U_UIMBUMFTL_S02_2'
And created '<ProjectName>' project
And created '/F_UIMBUMFTL_S02' folder for project '<ProjectName>'
And added users '<TestedUserEmail>' to project '<ProjectName>' team with role 'project.admin' expired '02.02.2020'
And logged in with details of '<TestedUserEmail>'
And I am on the Library page for collection '<CategoryName>'NEWLIB
And I added following asset 'image10.jpg' of collection '<CategoryName>' to project '<ProjectName>' folder '/F_UIMBUMFTL_S02'NEWLIB
When I move file 'image10.jpg' from project '<ProjectName>' folder '/F_UIMBUMFTL_S02' to new library page
And login with details of 'U_UIMBUMFTL_S02_2'
And I go to the Library pageNEWLIB
Then I 'should' see assets 'image10.jpg' in the collection 'Everything'NEWLIB

Examples:
| TestedUserEmail    | GlobalRole  | CategoryName      | ProjectName       |
| TU_UIMBUMFTL_S02_1 | agency.user | C_UIMBUMFTL_S02_1 | P_UIMBUMFTL_S02_1 |
| TU_UIMBUMFTL_S02_2 | guest.user  | C_UIMBUMFTL_S02_2 | P_UIMBUMFTL_S02_2 |



Scenario: Check that user without project permission element.send_to_library couldn't send file to project creator library
Meta:@gdam
@projects
Given I created the agency 'A_UIMBUMFTL_S03' with default attributes
And created the agency '<TestesAgencyName>' with default attributes
And created users with following fields:
| Email             | Role         | Agency             | Access          |
| U_UIMBUMFTL_S03_1 | agency.admin | A_UIMBUMFTL_S03    | streamlined_library,library,folders |
| U_UIMBUMFTL_S03_2 | agency.admin | <TestesAgencyName> | streamlined_library,library,folders |
| <TestedUserEmail> | <GlobalRole> | <TestesAgencyName> | streamlined_library,library,folders |
And logged in with details of 'U_UIMBUMFTL_S03_1'
And created '<CategoryName>' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName   | UserName          | RoleName      |
| <CategoryName> | <TestedUserEmail> | library.admin |
And logged in with details of 'U_UIMBUMFTL_S03_2'
And created '<ProjectName>' project
And created '/F_UIMBUMFTL_S03' folder for project '<ProjectName>'
And added users '<TestedUserEmail>' to project '<ProjectName>' team with role 'project.user' expired '02.02.2020'
And logged in with details of '<TestedUserEmail>'
And I am on the Library page for collection '<CategoryName>'NEWLIB
And I added following asset 'image10.jpg' of collection '<CategoryName>' to project '<ProjectName>' folder '/F_UIMBUMFTL_S03'NEWLIB
When I go to project '<ProjectName>' folder '/F_UIMBUMFTL_S03' page
And select file 'image10.jpg' on project files page
And click element 'MoreButton' on page 'FilesPage'
Then I 'should not' see element 'SendToLibrary' on page 'FilesPage'

Examples:
| TestesAgencyName   | TestedUserEmail    | GlobalRole  | CategoryName      | ProjectName       |
| TA_UIMBUMFTL_S03_1 | TU_UIMBUMFTL_S03_1 | agency.user | C_UIMBUMFTL_S03_1 | P_UIMBUMFTL_S03_1 |
| TA_UIMBUMFTL_S03_2 | TU_UIMBUMFTL_S03_2 | guest.user  | C_UIMBUMFTL_S03_2 | P_UIMBUMFTL_S03_2 |



Scenario: Check that user without permission asset.create but with permission element.send_to_library could send file to project creator library
Meta:@gdam
@library
Given I created the agency 'A_UIMBUMFTL_S04' with default attributes
And created the agency 'TA_UIMBUMFTL_S04' with default attributes
And created 'GR_UIMBUMFTL_S04' role in 'global' group for advertiser 'TA_UIMBUMFTL_S04' with following permissions:
| Permission                       |
| adkit.create                     |
| agency_team.read                 |
| asset_filter_collection.create   |
| dictionary.read                  |
| element.public_share.create      |
| element.public_share.write       |
| enum.create                      |
| enum.read                        |
| presentation.create              |
| presentation.public_share.create |
| presentation.public_share.write  |
| project.create                   |
| project_template.create          |
| proxy.download                   |
| role.read                        |
| user.invite                      |
| user.read                        |
And created users with following fields:
| Email             | Role             | Agency           | Access          |
| U_UIMBUMFTL_S04_1 | agency.admin     | A_UIMBUMFTL_S04  | streamlined_library,library,folders |
| U_UIMBUMFTL_S04_2 | agency.admin     | TA_UIMBUMFTL_S04 | streamlined_library,library,folders |
| TU_UIMBUMFTL_S04  | GR_UIMBUMFTL_S04 | TA_UIMBUMFTL_S04 | streamlined_library,library,folders |
And logged in with details of 'U_UIMBUMFTL_S04_1'
And created 'C_UIMBUMFTL_S04' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName    | UserName         | RoleName      |
| C_UIMBUMFTL_S04 | TU_UIMBUMFTL_S04 | library.admin |
And logged in with details of 'U_UIMBUMFTL_S04_2'
And created 'P_UIMBUMFTL_S04' project
And created '/F_UIMBUMFTL_S04' folder for project 'P_UIMBUMFTL_S04'
And added users 'TU_UIMBUMFTL_S04' to project 'P_UIMBUMFTL_S04' team with role 'project.admin' expired '02.02.2020'
And logged in with details of 'TU_UIMBUMFTL_S04'
And I am on the Library page for collection 'C_UIMBUMFTL_S04'NEWLIB
And I added following asset 'image10.jpg' of collection 'C_UIMBUMFTL_S04' to project 'P_UIMBUMFTL_S04' folder '/F_UIMBUMFTL_S04'NEWLIB
When I move file 'image10.jpg' from project 'P_UIMBUMFTL_S04' folder '/F_UIMBUMFTL_S04' to new library page
And login with details of 'U_UIMBUMFTL_S04_2'
And I go to the Library pageNEWLIB
Then I 'should' see assets 'image10.jpg' in the collection 'Everything'NEWLIB