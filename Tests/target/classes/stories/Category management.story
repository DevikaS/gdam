!--NGN-62
Feature:          Category management
Narrative:
In order to
As a              AgencyAdmin
I want to         Check category management

Scenario: Check that agency admin can see Asset Categories and Permissions tab with default categories
Meta:@gdam
     @projects
Given I am on Project list page
When I go to User list page
And click element 'Categories' on page 'Users'
Then I 'should' see on the Asset Categories and Permissions page next categories:
| Name       |
| Everything |
| My Assets  |


Scenario: Check that default categories can't be remove
Meta:@gdam
     @library
!--NGN-2390
When I go to collection '<category>' on administration area collections page
Then I should see element 'DeleteButton' on page 'Categories' in following state 'disabled'

Examples:
| category   |
| Everything |
| My Assets  |


Scenario: Check that new category appears on the LHS and is selected
Meta:@gdam
     @library
Given I am on administration area collections page
When I create category '<newCategory>'
Then I should see message warning 'Collection created successfully'
And 'should' see selected '<newCategory>' at LHS on Asset Categories and Permissions page
And 'should not' see filters '<Filter>' on Asset Categories and Permissions page in the state on

Examples:
| newCategory                                               | Filter                       |
| abcdeàghijklmnoprqtsøvwyxz1234567890-=/*-+\\~!@#\$%^&*()_ | video,audio,file,image,other |


Scenario: check that sub-type greyed out when some/all filter 'on'
Meta:@gdam
     @library
Given I created following categories:
| Name       |
| AFC_CM_S05 |
When I go to collection 'AFC_CM_S05' on administration area collections page
And switch 'on' media type filter '<Filter>' on administration area collections page
Then I '<Should>' see element 'DisabledMediaSubTypeCombo' on page 'Categories'

Examples:
| Filter      | Should     |
| VIDEO       | should not |
| VIDEO,IMAGE | should     |


Scenario: check that Admin have ability to add users to category
Meta: @bug
      @gdam
      @library
!--FAB-470
Given I created following users:
| User Name  |
| U_CM_S08_1 |
| U_CM_S08_2 |
And created 'R_CM_S08' role in 'library' group for advertiser 'DefaultAgency'
And created 'C_CM_S08' category
When I go to administration area collections page
And add users 'U_CM_S08_1' to category 'C_CM_S08' with role 'R_CM_S08' by users details
Then I 'should' see users 'U_CM_S08_1' on Asset Categories and Permissions page
When I add users 'U_CM_S08_2' to category 'C_CM_S08' with role 'R_CM_S08' by users details
Then I 'should' see users 'U_CM_S08_1,U_CM_S08_2' on Asset Categories and Permissions page


Scenario: check that Admin have ability to remove users from category
Meta:@gdam
     @library
Given I created users with following fields:
| Email      |
| U_CM_S09_1 |
| U_CM_S09_2 |
And created 'R_CM_S09' role in 'library' group for advertiser 'DefaultAgency'
And created 'C_CM_S09' category
And added users 'U_CM_S09_1' to category 'C_CM_S09' with role 'R_CM_S09' by users details
And added users 'U_CM_S09_2' to category 'C_CM_S09' with role 'R_CM_S09' by users details
When I remove users 'U_CM_S09_1' for category 'C_CM_S09'
Then I 'should not' see users 'U_CM_S09_1' on Asset Categories and Permissions page
And 'should' see users 'U_CM_S09_2' on Asset Categories and Permissions page


Scenario: check that Admin have ability to remove category
Meta:@gdam
     @library
Given I created following categories:
| Name         |
| AFC_CM_S10_1 |
| AFC_CM_S10_2 |
| AFC_CM_S10_3 |
When I go to administration area collections page
And delete following categories from Asset Categories and Permissions page:
| Name         |
| AFC_CM_S10_1 |
| AFC_CM_S10_2 |
And refresh the page without delay
Then I should see following collections on administration area collections page:
| CategoryName | Should     |
| AFC_CM_S10_1 | should not |
| AFC_CM_S10_2 | should not |
| AFC_CM_S10_3 | should     |


Scenario: Check that only library roles are available on Limit user pop-up
Meta:@gdam
     @library
Given I created following roles:
| RoleName    | Group   |
| GR_CM_S15_1 | global  |
| LR_CM_S15_2 | library |
| LR_CM_S15_3 | library |
| PR_CM_S15_4 | project |
And created 'AFC_CM_S15' category
When I go to administration area collections page
Then I 'should' see the following roles for category 'AFC_CM_S15' in dropdown box of 'Limit User' popup:
| RoleName    |
| LR_CM_S15_2 |
| LR_CM_S15_3 |
And 'should not' see the following roles for category 'AFC_CM_S15' in dropdown box of 'Limit User' popup:
| RoleName    |
| GR_CM_S15_1 |
| PR_CM_S15_4 |


Scenario: Check that look up correctly works
Meta:@gdam
     @library
Given I created the agency 'A_CM_S22' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |
| U_CM_S22 | agency.admin | A_CM_S22     |
And created users with following fields:
| FirstName      | LastName  | Email      | Telephone | Logo | Agency   |
| Eric           | Cartman   | U_CM_S22_1 | +33333    | GIF  | A_CM_S22 |
| Liane          | Cartman   | U_CM_S22_2 | +44444    | GIF  | A_CM_S22 |
| Kenny          | McCormick | U_CM_S22_3 | +88888    | GIF  | A_CM_S22 |
| Màr`garet Anna | Tetcher   | U_CM_S22_4 | +99999    | GIF  | A_CM_S22 |
And logged in with details of 'U_CM_S22'
And created 'AFC_CM_S22' category
When I put data '<Text>' into 'Limit User' popup for category 'AFC_CM_S22'
Then I 'should' see drop down user list with '<UserNames>' and '<UserEmails>' on 'Limit User' popup

Examples:
| Text                         | UserNames                  | Image   | UserEmails            |
| Cartman                      | Eric Cartman,Liane Cartman | GIF,GIF | U_CM_S22_1,U_CM_S22_2 |
| Màr`garet Anna               | Màr`garet Anna Tetcher     | GIF     | U_CM_S22_4            |
| qatbabylonautotester+U_CM_S22_3 | Kenny McCormick            | GIF     | U_CM_S22_3            |


Scenario: Check that data displayed in look-up can be selected
Meta:@gdam
     @library
Given I created the agency 'A_CM_S23' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |
| U_CM_S23 | agency.admin | A_CM_S23     |
And created users with following fields:
| FirstName      | LastName  | Email      | Telephone | Logo | Agency   |
| Eric           | Cartman   | U_CM_S23_1 | +33333    | GIF  | A_CM_S23 |
| Liane          | Cartman   | U_CM_S23_2 | +44444    | GIF  | A_CM_S23 |
| Kenny          | McCormick | U_CM_S23_3 | +88888    | GIF  | A_CM_S23 |
| Màr`garet Anna | Tetcher   | U_CM_S23_4 | +99999    | GIF  | A_CM_S23 |
And logged in with details of 'U_CM_S23'
And created 'AFC_CM_S23' category
When I put data '<Text>' into 'Limit User' popup for category 'AFC_CM_S23'
And select user by name '<UserName>' and email '<UserEmail>' on 'Limit User' popup
Then I 'should' see selected user with name '<UserName>' and email '<UserEmail>' in add user on 'Limit User' popup

Examples:
| Text                         | UserName               | UserEmail  |
| Cartman                      | Liane Cartman          | U_CM_S23_2 |
| Màr`garet Anna               | Màr`garet Anna Tetcher | U_CM_S23_4 |
| qatbabylonautotester+U_CM_S23_3 | Kenny McCormick        | U_CM_S23_3 |


Scenario: check that button 'manage user' is disable for category 'My Assets'
Meta:@gdam
     @library
!--NGN-2592
When I go to collection 'My Assets' on administration area collections page
Then I 'should not' see element 'ManageUsers' on page 'Categories'


Scenario: check that admin can create parent collection D based on collections A, B, C (different filters in advanced search)
Meta:@gdam
     @library
Given I created users with following fields:
| Email    | Role         |
| U_CM_S25 | agency.admin |
And logged in with details of 'U_CM_S25'
And created 'PC_CM_S25_1' category
And created 'PC_CM_S25_2' category
And created 'PC_CM_S25_3' category
And created 'CC_CM_S25' category
When I add into category 'PC_CM_S25_1' following metadata with switched on mediatype 'video':
| FilterName    | FilterValue   |
| Business Unit | DefaultAgency |
| Screen        | Trailer       |
And add into category 'PC_CM_S25_3' following metadata with switched on mediatype 'audio':
| FilterName    | FilterValue   |
| Business Unit | DefaultAgency |
| Genre         | Comedy        |
And add into category 'CC_CM_S25' following metadata:
| FilterName    | FilterValue                         |
| Collection    | PC_CM_S25_1,PC_CM_S25_2,PC_CM_S25_3 |
Then I 'should' see following metadata for category 'CC_CM_S25' on Categories and Permissions page:
| FilterName | FilterValue                         |
| Collection | PC_CM_S25_1,PC_CM_S25_2,PC_CM_S25_3 |



Scenario: Check that 'Everything' collection is not available in 'Collection' dropdown at creation new category
Meta:@gdam
     @library
!--NGN-10895
Given I created 'CC_CM_S28' category
When I go to collection 'CC_CM_S28' on administration area collections page
And select metadata filter name 'Collection' on opened administration area collections page
Then I 'should not' see metadata filter values 'Everything' for filter name 'Collection' on opened administration area collections page


Scenario: Check that you can not create category with existing name on the same level
Meta:@gdam
     @library
Given I created the agency 'A_LPTG_S2' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |
| U_LPTG_2 | agency.admin | A_LPTG_S2    |
And logged in with details of 'U_LPTG_2'
And on administration area collections page
And I created 'C_LPTG_1' category
When create category 'C_LPTG_1'
Then I should see message warning 'Collection wasn't created'



Scenario: check that assets displaying for collection D (from all added to filter collections A, B, C)
Meta:@gdam
     @library
Given I created 'GR_PIFCWLP_02' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission                     |
| adkit.create                   |
| agency_team.read               |
| asset.create                   |
| asset_filter_collection.create |
| asset_filter_category.create    |
| asset_filter_category.write     |
| dictionary.read                |
| dictionary.add_on_the_fly      |
| enum.create                    |
| enum.read                      |
| enum.write                     |
| group.agency_enums.read        |
| presentation.create            |
| project.create                 |
| project_template.create        |
| role.read                      |
| user.invite                    |
| user.read                      |
| user_group.read                |
And created users with following fields:
| Email          | Role          | Agency       |Access|
| U_CM_S26 | GR_PIFCWLP_02  | DefaultAgency |streamlined_library,library|
And logged in with details of 'U_CM_S26'
And created 'PC_CM_S26_1' category
And created 'PC_CM_S26_2' category
And created 'PC_CM_S26_3' category
And created 'CC_CM_S26' category
And I am on the Library page for collection 'My Assets'NEWLIB
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/GWGTest2.pdf' into my libraryNEWLIB
And uploaded file '/files/GWGTestfile064v3.pdf' into my libraryNEWLIB
And uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And uploaded file '/files/audio02.mp3' into my libraryNEWLIB
When I wait while transcoding is finished in collection 'My Assets'NEWLIB
And I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName      | FieldValue               |
| Title        | video.file |
| Clock number | testcn     |
| Screen       | Trailer    |
And 'save' asset 'GWGTest2.pdf' info of collection 'My Assets' by following informationNEWLIB:
| FieldName        | FieldValue |
| Title            | print.file |
| Account Director | Sergeant Harrison Yates |
And 'save' asset 'audio01.mp3' info of collection 'My Assets' by following informationNEWLIB:
| FieldName | FieldValue |
| Title     | audio.file |
| Genre     | Comedy     |
And add into category 'PC_CM_S26_1' following metadata with switched on mediatype 'video':
| FilterName    | FilterValue   |
| Business Unit | DefaultAgency |
| Screen        | Trailer       |
And add into category 'PC_CM_S26_2' following metadata with switched on mediatype 'print':
| FilterName       | FilterValue             |
| Business Unit    | DefaultAgency           |
| Account Director | Sergeant Harrison Yates |
And add into category 'PC_CM_S26_3' following metadata with switched on mediatype 'audio':
| FilterName    | FilterValue   |
| Business Unit | DefaultAgency |
| Genre         | Comedy        |
And add into category 'CC_CM_S26' following metadata:
| FilterName | FilterValue                         |
| Collection | PC_CM_S26_1,PC_CM_S26_2,PC_CM_S26_3 |
And I go to the Library page for collection 'CC_CM_S26'NEWLIB
Then I 'should' see assets 'video.file,print.file,audio.file' in the collection 'CC_CM_S26'NEWLIB
And I 'should' see asset count '3' in 'CC_CM_S26' NEWLIB

Scenario: check that assets displaying for collection D1 (child of D with some other filter)
Meta:@gdam
     @library
Given I created the agency 'A_CM_S27' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |Access|
| U_CM_S27 | agency.admin | A_CM_S27 |streamlined_library,library|
And logged in with details of 'U_CM_S27'
And created 'PC_CM_S27_1' category
And created 'PC_CM_S27_2' category
And created 'PC_CM_S27_3' category
And created 'CC_CM_S27' category
And created 'CCC_CM_S27' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/GWGTest2.pdf' into my libraryNEWLIB
And uploaded file '/files/GWGTestfile064v3.pdf' into my libraryNEWLIB
And uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And uploaded file '/files/audio02.mp3' into my libraryNEWLIB
When I wait while transcoding is finished in collection 'My Assets'NEWLIB
And 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue |
| Title        | video.file |
| Clock number | testcn     |
| Screen       | Trailer    |
And 'save' asset 'GWGTest2.pdf' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue |
| Title        | print.file |
And 'save' asset 'audio01.mp3' info of collection 'My Assets' by following informationNEWLIB:
| FieldName | FieldValue |
| Title     | audio.file |
| Genre     | Comedy     |
And add into category 'PC_CM_S27_1' following metadata with switched on mediatype 'video':
| FilterName    | FilterValue |
| Business Unit | A_CM_S27    |
| Screen        | Trailer     |
And add into category 'PC_CM_S27_2' following metadata with switched on mediatype 'print': ||
And add into category 'PC_CM_S27_3' following metadata with switched on mediatype 'audio':
| FilterName    | FilterValue |
| Business Unit | A_CM_S27    |
| Genre         | Comedy      |
And add into category 'CC_CM_S27' following metadata:
| FilterName | FilterValue                         |
| Collection | PC_CM_S27_1,PC_CM_S27_2,PC_CM_S27_3 |
And add into category 'CCC_CM_S27' following metadata with switched on mediatype 'audio':
| FilterName | FilterValue |
| Collection | CC_CM_S27   |
And I go to the Library page for collection 'CCC_CM_S27'NEWLIB
Then I 'should' see assets 'audio.file' in the collection 'CCC_CM_S27'NEWLIB
And I 'should' see asset count '1' in 'CCC_CM_S27' NEWLIB


Scenario: Check that you can create category with existing name on another level
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role         |Access|
| U_LAATC_S01 | agency.admin |streamlined_library,library|
And logged in with details of 'U_LAATC_S01'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_LAATC_S01_2' from collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S01_2'NEWLIB
When I switch 'on' media type filter 'video' for collection 'C_LAATC_S01_2' on the page LibraryNEWLIB
And I click on 'sub' option on the collection filter page
And I type collection name 'C_LAATC_S01_2' and save on opened 'sub' collection popup from filter pageNEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'C_LAATC_S01_2'NEWLIB


Scenario: Check that after create category with 'Other' media types and you see filtered asset in Library
Meta:@gdam
     @library
Given I created the agency 'A_LPTG_S2' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| U_LPTG_2 | agency.admin | A_LPTG_S2    |streamlined_library,library|
And logged in with details of 'U_LPTG_2'
And uploaded following assetsNEWLIB:
| Name               |
| /files/example.rar |
| /files/logo3.png   |
| /files/test6.jar   |
| /files/Fish Ad.mov |
And on administration area collections page
And created 'C_CM_S29_1' category
And added into category 'C_CM_S29_1' following metadata with switched on mediatype 'other':
| FilterName | FilterValue |
When I go to  Library page for collection 'C_CM_S29_1'NEWLIB
Then I 'should' see assets 'example.rar,test6.jar' in the collection 'C_CM_S29_1'NEWLIB


Scenario: Check that metadata specific to Video and Audio media type available in collections
!-- QA-1219
Meta:@gdam
     @library
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_CM_S28' with default attributes
And created users with following fields:
| Email      | Role           | Agency   |
| U_CM_S28   | agency.admin    | A_CM_S28 |
And logged in with details of 'U_CM_S28'
When create 'COL_CM_S28' category
And go to collection 'COL_CM_S28' on administration area collections page
And switch 'on' media type filter 'Video' on administration area collections page
Then I 'should' see following metadata fields for asset type 'Video' on Categories admin area page:
| Metadata Fields                                                                                             |
| Clock number;Duration;Air Date;Country;Screen;Category;Advertising agency;Production company;Post-production|
When switch 'off' media type filter 'Video' on administration area collections page
And switch 'on' media type filter 'Audio' on administration area collections page
Then I 'should' see following metadata fields for asset type 'Audio' on Categories admin area page:
| Metadata Fields                                                                      |
| Clock Number;JCN Number;RACC Approval;Air date;Duration;Country of Broadcast;Category|

Scenario: Check that metadata specific to Print media type available in collections
!-- QA-1219
Meta:@gdam
     @library
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_CM_S30' with default attributes
And created users with following fields:
| Email      | Role            | Agency   |
| U_CM_S30   | agency.admin    | A_CM_S30 |
And logged in with details of 'U_CM_S30'
When create 'COL_CM_S30' category
And go to collection 'COL_CM_S30' on administration area collections page
And switch 'on' media type filter 'Print' on administration area collections page
Then I 'should' see following metadata fields for asset type 'Print' on Categories admin area page:
| Metadata Fields                                       |
| Country;Market Sector;Category;Genre;Description;Brief|
