!--NGN-11524
Feature:          User in multiple BU - add asset into presentation
Narrative:
In order to
As a              AgencyAdmin
I want to         User in multiple BU can add asset into presentation



Scenario: Check that user without permission add.asset.to.presentation in another BU, could not add asset to presentation
Meta:@gdam
@bug
@library
!--UIR-793 second example fails
!--QA-785
Given I created the agency 'A_UIMBUAATP_S01_1' with default attributes
And created the agency 'A_UIMBUAATP_S01_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency            |Access|
| <User1Email> | agency.admin | A_UIMBUAATP_S01_1 |streamlined_library,presentations|
| <User2Email> | agency.admin | A_UIMBUAATP_S01_2 |streamlined_library,presentations|
And logged in with details of '<User1Email>'
And created '<LibraryRole>' role in 'library' group for advertiser 'A_UIMBUAATP_S01_1' with following permissions:
| Permission                 |
| asset.delete               |
| asset.read                 |
| asset.share                |
| asset.write                |
| file.download              |
| proxy.download             |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| asset_filter_category.read |
| <Permission>               |
And created '<CategoryName>' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName   | UserName     | RoleName      |
| <CategoryName> | <User2Email> | <LibraryRole> |
When I login with details of '<User2Email>'
And go to the library page for collection '<CategoryName>'NEWLIB
And I select asset 'image10.jpg' in the '<CategoryName>'  library pageNEWLIB
Then I '<Condition>' see presentation pop up for collection '<CategoryName>'NEWLIB

Examples:
| User1Email         | User2Email         | LibraryRole        | CategoryName      | PresentationName  | Permission                | Condition  |
| U1_UIMBUAATP_S01_1 | U2_UIMBUAATP_S01_1 | LR_UIMBUAATP_S01_1 | C_UIMBUAATP_S01_1 | P_UIMBUAATP_S01_1 | asset.add_to_presentation | should     |
| U1_UIMBUAATP_S01_2 | U2_UIMBUAATP_S01_2 | LR_UIMBUAATP_S01_2 | C_UIMBUAATP_S01_2 | P_UIMBUAATP_S01_2 |                           | should not |


Scenario: Check that if user has access to Library Assets from multiple BUs, they should be able to add these assets to presentations
Meta:@gdam
@library
Given I created the agency 'A_UIMBUAATP_S02_1' with default attributes
And created the agency 'A_UIMBUAATP_S02_2' with default attributes
And created the agency 'A_UIMBUAATP_S02_3' with default attributes
And created users with following fields:
| Email             | Role         | Agency            |Access|
| U_UIMBUAATP_S02_1 | agency.admin | A_UIMBUAATP_S02_1 |streamlined_library|
| U_UIMBUAATP_S02_2 | agency.admin | A_UIMBUAATP_S02_2 |streamlined_library,presentations|
| U_UIMBUAATP_S02_3 | agency.admin | A_UIMBUAATP_S02_3 |streamlined_library,presentations|
And logged in with details of 'U_UIMBUAATP_S02_1'
And created 'C_UIMBUAATP_S02_1' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName      | UserName          | RoleName      |
| C_UIMBUAATP_S02_1 | U_UIMBUAATP_S02_3 | library.admin |
And logged in with details of 'U_UIMBUAATP_S02_2'
And created 'C_UIMBUAATP_S02_2' category
And uploaded file '/files/image11.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName      | UserName          | RoleName      |
| C_UIMBUAATP_S02_2 | U_UIMBUAATP_S02_3 | library.admin |
When I login with details of 'U_UIMBUAATP_S02_3'
And go to the library page for collection 'C_UIMBUAATP_S02_1'NEWLIB
And I refresh the page
And I add assets 'image10.jpg' to new presentation 'P_UIMBUAATP_S02' from collection 'C_UIMBUAATP_S02_1' pageNEWLIB
And go to the library page for collection 'C_UIMBUAATP_S02_2'NEWLIB
And I add assets 'image11.jpg' to existing presentations 'P_UIMBUAATP_S02' from collection 'C_UIMBUAATP_S02_2' pageNEWLIB
When I go to the presentations assets page 'P_UIMBUAATP_S02'
Then I 'should' see assets 'image10.jpg,image11.jpg' in presentation 'P_UIMBUAATP_S02'



Scenario: Check that if Presentation contains assets from Multiple BU, user should be able to assign metadata to display in Presentation, according to each BU schema
Meta:@gdam
@library
Given I created the agency 'A_UIMBUAATP_S03_1' with default attributes
And created following 'asset' custom metadata fields for agency 'A_UIMBUAATP_S03_1':
| Section | FieldType    | Description          |
| image   | string       | CMSF UIMBUAATP S03 1 |
And created the agency 'A_UIMBUAATP_S03_2' with default attributes
And created following 'asset' custom metadata fields for agency 'A_UIMBUAATP_S03_2':
| Section | FieldType    | Description          |
| image   | string       | CMSF UIMBUAATP S03 2 |
And created the agency 'A_UIMBUAATP_S03_3' with default attributes
And created following 'asset' custom metadata fields for agency 'A_UIMBUAATP_S03_3':
| Section | FieldType    | Description          |
| image   | string       | CMSF UIMBUAATP S03 3 |
And created users with following fields:
| Email             | Role         | Agency            |Access|
| U_UIMBUAATP_S03_1 | agency.admin | A_UIMBUAATP_S03_1 |streamlined_library,presentations|
| U_UIMBUAATP_S03_2 | agency.admin | A_UIMBUAATP_S03_2 |streamlined_library,presentations|
| U_UIMBUAATP_S03_3 | agency.admin | A_UIMBUAATP_S03_3 |streamlined_library,presentations|
And logged in with details of 'U_UIMBUAATP_S03_1'
And created 'C_UIMBUAATP_S03_1' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'C_UIMBUAATP_S03_1'NEWLIB
And added next users for following categories:
| CategoryName      | UserName          | RoleName      |
| C_UIMBUAATP_S03_1 | U_UIMBUAATP_S03_3 | library.admin |
And logged in with details of 'U_UIMBUAATP_S03_2'
And created 'C_UIMBUAATP_S03_2' category
And uploaded file '/files/image11.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName      | UserName          | RoleName      |
| C_UIMBUAATP_S03_2 | U_UIMBUAATP_S03_3 | library.admin |
When I login with details of 'U_UIMBUAATP_S03_3'
And go to the library page for collection 'C_UIMBUAATP_S03_1'NEWLIB
And I add assets 'image10.jpg' to new presentation 'P_UIMBUAATP_S03' from collection 'C_UIMBUAATP_S03_1' pageNEWLIB
And go to the library page for collection 'C_UIMBUAATP_S03_2'NEWLIB
And I add assets 'image11.jpg' to existing presentations 'P_UIMBUAATP_S03' from collection 'C_UIMBUAATP_S03_2' pageNEWLIB
And go to the presentation 'P_UIMBUAATP_S03' layout page
Then I 'should' see following fields in section 'Image' for agency 'A_UIMBUAATP_S03_1' on presentation 'P_UIMBUAATP_S03' layout tab:
| FieldName            |
| CMSF UIMBUAATP S03 1 |
And 'should' see following fields in section 'Image' for agency 'A_UIMBUAATP_S03_2' on presentation 'P_UIMBUAATP_S03' layout tab:
| FieldName            |
| CMSF UIMBUAATP S03 2 |
And 'should' see following fields in section 'Image' for agency 'A_UIMBUAATP_S03_3' on presentation 'P_UIMBUAATP_S03' layout tab:
| FieldName            |
| CMSF UIMBUAATP S03 3 |


Scenario: Check that on reel preview page is proper displayed metadata fields from another BU
Meta:@gdam
@bug
@library
!--FAB-476 Please do not remove the bug tag until actual bug is fixed even though it passes..It passes intermittently
Given I created the following agency:
| Name                 | A4User        |
| A_UIMBUAATP_S04_1    | DefaultA4User |
And created following 'asset' custom metadata fields for agency 'A_UIMBUAATP_S04_1':
| Section | FieldType    | Description          |
| image   | string       | CMSF UIMBUAATP S04 1 |
Given I created the following agency:
| Name                 | A4User        |
| A_UIMBUAATP_S04_2    | DefaultA4User |
And created following 'asset' custom metadata fields for agency 'A_UIMBUAATP_S04_2':
| Section | FieldType    | Description          |
| image   | string       | CMSF UIMBUAATP S04 2 |
And I created the following agency:
| Name                 | A4User        |
| A_UIMBUAATP_S04_3    | DefaultA4User |
And created following 'asset' custom metadata fields for agency 'A_UIMBUAATP_S04_3':
| Section | FieldType    | Description          |
| image   | string       | CMSF UIMBUAATP S04 3 |
And created users with following fields:
| Email             | Role         | Agency            |Access|
| U_UIMBUAATP_S04_1 | agency.admin | A_UIMBUAATP_S04_1 |streamlined_library,presentations|
| U_UIMBUAATP_S04_2 | agency.admin | A_UIMBUAATP_S04_2 |streamlined_library,presentations|
| U_UIMBUAATP_S04_3 | agency.admin | A_UIMBUAATP_S04_3 |streamlined_library,presentations|
When I login with details of 'U_UIMBUAATP_S04_1'
And create 'C_UIMBUAATP_S04_1' category
And upload file '/files/image10.jpg' into my libraryNEWLIB
And wait while preview is available in collection 'C_UIMBUAATP_S04_1'NEWLIB
And added next users for following categories:
| CategoryName      | UserName          | RoleName      |
| C_UIMBUAATP_S04_1 | U_UIMBUAATP_S04_3 | library.admin |
And go to asset 'image10.jpg' info page in Library for collection 'C_UIMBUAATP_S04_1'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName            | FieldValue            |
| CMSF UIMBUAATP S04 1 | CMSFV UIMBUAATP S04 1 |
And login with details of 'U_UIMBUAATP_S04_2'
And create 'C_UIMBUAATP_S04_2' category
And upload file '/files/image11.jpg' into my libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName      | UserName          | RoleName      |
| C_UIMBUAATP_S04_2 | U_UIMBUAATP_S04_3 | library.admin |
And go to asset 'image11.jpg' info page in Library for collection 'C_UIMBUAATP_S04_2'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName            | FieldValue            |
| CMSF UIMBUAATP S04 2 | CMSFV UIMBUAATP S04 2 |
And login with details of 'U_UIMBUAATP_S04_3'
And go to the library page for collection 'C_UIMBUAATP_S04_1'NEWLIB
And I add assets 'image10.jpg' to new presentation 'P_UIMBUAATP_S04' from collection 'C_UIMBUAATP_S04_1' pageNEWLIB
And go to the library page for collection 'C_UIMBUAATP_S04_2'NEWLIB
And I add assets 'image11.jpg' to existing presentations 'P_UIMBUAATP_S04' from collection 'C_UIMBUAATP_S04_2' pageNEWLIB
And select following fields in section 'Image' for agency 'A_UIMBUAATP_S04_1' on presentation 'P_UIMBUAATP_S04' layout tab:
| FieldName            |
| CMSF UIMBUAATP S04 1 |
And select following fields in section 'Image' for agency 'A_UIMBUAATP_S04_2' on presentation 'P_UIMBUAATP_S04' layout tab:
| FieldName            |
| CMSF UIMBUAATP S04 2 |
And go to preview presentation 'P_UIMBUAATP_S04' page
Then I 'should' see following metadata fields for asset 'image10.jpg' added from collection 'C_UIMBUAATP_S04_1' on presentation 'P_UIMBUAATP_S04' preview page:
| FieldName            | FieldValue            |
| CMSF UIMBUAATP S04 1 | CMSFV UIMBUAATP S04 1 |
And 'should' see following metadata fields for asset 'image11.jpg' added from collection 'C_UIMBUAATP_S04_2' on presentation 'P_UIMBUAATP_S04' preview page:
| FieldName            | FieldValue            |
| CMSF UIMBUAATP S04 2 | CMSFV UIMBUAATP S04 2 |



Scenario: Check that agency user or user with custom role could add asset from another BU to reel
Meta:@gdam
@library
Given I created the agency 'A_UIMBUAATP_S05_1' with default attributes
And created the agency 'A_UIMBUAATP_S05_2' with default attributes
And created '<GlobalRole>' role in 'library' group for advertiser 'A_UIMBUAATP_S05_2' with following permissions:
| Permission                             |
| agency_team.read                       |
| asset.create                           |
| dictionary.read                        |
| enum.create                            |
| enum.read                              |
| enum.write                             |
| group.agency_enums.read                |
| presentation.create                    |
| role.read                              |
| user.read                              |
| user_group.read                        |
And created users with following fields:
| Email        | Role         | Agency            |Access|
| <User1Email> | agency.admin | A_UIMBUAATP_S05_1 |streamlined_library,presentations|
| <User2Email> | <GlobalRole> | A_UIMBUAATP_S05_2 |streamlined_library,presentations|
And logged in with details of '<User1Email>'
And created '<CategoryName>' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added next users for following categories:
| CategoryName   | UserName     | RoleName      |
| <CategoryName> | <User2Email> | library.admin |
When I login with details of '<User2Email>'
And go to the library page for collection '<CategoryName>'NEWLIB
And I add assets 'image10.jpg' to new presentation '<PresentationName>' from collection '<CategoryName>' pageNEWLIB
Then I 'should' see assets 'image10.jpg' in presentation '<PresentationName>'

Examples:
| User1Email         | User2Email         | GlobalRole       | CategoryName      | PresentationName  |
| U1_UIMBUAATP_S05_1 | U2_UIMBUAATP_S05_1 | GR_UIMBUAATP_S05 | C_UIMBUAATP_S05_1 | P_UIMBUAATP_S05_1 |
| U1_UIMBUAATP_S05_2 | U2_UIMBUAATP_S05_2 | agency.user      | C_UIMBUAATP_S05_2 | P_UIMBUAATP_S05_2 |



Scenario: Check that reel that iclude assets from another BU could be shared and playable by recipient
Meta:@gdam
@gdamemails
Given I created the agency 'A_UIMBUAATP_S06_1' with default attributes
And created the agency 'A_UIMBUAATP_S06_2' with default attributes
And created users with following fields:
| Email             | Role         | Agency            |Access|
| U_UIMBUAATP_S06_1 | agency.admin | A_UIMBUAATP_S06_1 |streamlined_library,presentations|
| U_UIMBUAATP_S06_2 | agency.admin | A_UIMBUAATP_S06_2 |streamlined_library,presentations|
| U_UIMBUAATP_S06_3 | agency.user  | A_UIMBUAATP_S06_2 |streamlined_library,presentations|
And logged in with details of 'U_UIMBUAATP_S06_1'
And created 'C_UIMBUAATP_S06' category
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'C_UIMBUAATP_S06'NEWLIB
And added next users for following categories:
| CategoryName    | UserName          | RoleName      |
| C_UIMBUAATP_S06 | U_UIMBUAATP_S06_2 | library.admin |
When I login with details of 'U_UIMBUAATP_S06_2'
And go to the library page for collection 'C_UIMBUAATP_S06'NEWLIB
And I add assets 'Fish Ad.mov' to new presentation 'P_UIMBUAATP_S06' from collection 'C_UIMBUAATP_S06' pageNEWLIB
And send presentation 'P_UIMBUAATP_S06' to user 'U_UIMBUAATP_S06_3' with personal message 'Hello U_UIMBUAATP_S06_3'
And I login with details of 'U_UIMBUAATP_S06_3'
And open link from email when user 'U_UIMBUAATP_S06_3' received email with next subject 'has been shared'
Then I should see that player in the playing state on the presentation 'P_UIMBUAATP_S06' preview page for all assets