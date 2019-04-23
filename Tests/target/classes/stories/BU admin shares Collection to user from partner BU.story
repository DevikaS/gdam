!-- NGN-10532
Feature:          BU admin shares Collection to user from partner BU
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that BU Admin can share collection to user from partner BU


Scenario: Check that user from partner BU can be found in look up on 'Add user' pop up
Meta:@globaladmin
     @gdam
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And I created the agency 'BUASCTUFPBU_A2' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique   |
| BUASCTUFPBU_E01_1 | agency.admin | BUASCTUFPBU_A1 |
| BUASCTUFPBU_E01_2 | agency.admin | BUASCTUFPBU_A2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUASCTUFPBU_E01_1'
And create 'col1' category
And go to collection 'col1' on administration area collections page
Then I 'should' see user 'BUASCTUFPBU_E01_2' on category 'col1' on category page pop-up



Scenario: Check that you can't share collection 'Everything'
!--As per 17823/16288 -'Everything' collection can no longer be shared
Meta:@globaladmin
     @gdam
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And I created the agency 'BUASCTUFPBU_A2' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique   |
| BUASCTUFPBU_E02_1 | agency.admin | BUASCTUFPBU_A1 |
| BUASCTUFPBU_E02_2 | agency.admin | BUASCTUFPBU_A2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUASCTUFPBU_E02_1'
And go to collection 'Everything' on administration area collections page
Then I 'should not' see Add Business Unit button on the category page
Then I 'should not' see Add Library Team button on the category page
Then I 'should not' see Add users button on the category page



Scenario: Check permission for edit asset after share to user from partner BU (custom library role)
Meta:@library
     @gdam
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And created the agency 'BUASCTUFPBU_A2' with default attributes
And created 'without.edit' role in 'library' group for advertiser 'BUASCTUFPBU_A1' with following permissions:
| Permission                 |
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
And created users with following fields:
| Email             | Role         | AgencyUnique   |Access|
| BUASCTUFPBU_E06_1 | agency.admin | BUASCTUFPBU_A1 |streamlined_library|
| BUASCTUFPBU_E06_2 | agency.admin | BUASCTUFPBU_A2 |streamlined_library|
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUASCTUFPBU_E06_1'
And create 'col6' category
And upload following assetsNEWLIB:
| Name                |
| /files/filetext.txt  |
And wait while transcoding is finished in collection 'col6'NEWLIB
And go to collection 'col6' on administration area collections page
And add users 'BUASCTUFPBU_E06_2' to category 'col6' with role 'without.edit' by users details
And login with details of 'BUASCTUFPBU_E06_2'
And I go to asset 'filetext.txt' info page in Library for collection 'col6'NEWLIB
Then I 'should not' see Edit link on opened asset info pageNEWLIB


Scenario: Check that after share to user from partner BU this user appears in users list ('guest' role)
Meta:@globaladmin
     @gdam
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And I created the agency 'BUASCTUFPBU_A2' with default attributes
And created users with following fields:
| Email               | Role         | AgencyUnique   |Access|
| BUASCTUFPBU_E08_1   | agency.admin | BUASCTUFPBU_A1 |streamlined_library|
| BUASCTUFPBU_E08_2_1 | agency.admin | BUASCTUFPBU_A2 |streamlined_library|
| BUASCTUFPBU_E08_2_2 | guest.user   | BUASCTUFPBU_A2 |streamlined_library|
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUASCTUFPBU_E08_1'
And create 'col8' category
And upload following assetsNEWLIB:
| Name              |
| /files/filetext.txt|
And wait while transcoding is finished in collection 'col8'NEWLIB
And go to collection 'col8' on administration area collections page
And add users 'BUASCTUFPBU_E08_2_2' to category 'col8' with role 'library.admin' by users details
Then I 'should' see Users 'BUASCTUFPBU_E08_2_2' for category 'col8' on on Asset Categories and Permissions page

Scenario: Check that assets from shared category can be found by global search
Meta:@library
     @gdam
!--NGN-11281
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And I created the agency 'BUASCTUFPBU_A2' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique   |Access|
| BUASCTUFPBU_E09_1 | agency.admin | BUASCTUFPBU_A1 |dashboard,folders,streamlined_library|
| BUASCTUFPBU_E09_2 | agency.admin | BUASCTUFPBU_A2 |dashboard,folders,streamlined_library|
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUASCTUFPBU_E09_1'
And create 'col9' category
And upload following assetsNEWLIB:
| Name                |
| /files/filetext.txt  |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to collection 'col9' on administration area collections page
And add users 'BUASCTUFPBU_E09_2' to category 'col9' with role 'library.admin' by users details
And login with details of 'BUASCTUFPBU_E09_2'
And search by text 'filetext.txt'
Then I 'should' see search object 'filetext.txt'




Scenario: Check that user from partner BU sees collection in library after share
Meta:@gdam
     @library
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And I created the agency 'BUASCTUFPBU_A2' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique   |Access|
| BUASCTUFPBU_E03_1 | agency.admin | BUASCTUFPBU_A1 |streamlined_library,library|
| BUASCTUFPBU_E03_2 | agency.admin | BUASCTUFPBU_A2 |streamlined_library,library|
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUASCTUFPBU_E03_1'
And create 'col3' category
And upload following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov   |
And I wait while preview is visible on library page for collection 'My Assets' for asset 'Fish2-Ad.mov'NEWLIB
And go to collection 'col3' on administration area collections page
And add users 'BUASCTUFPBU_E03_2' to category 'col3' with role 'library.admin' by users details
And login with details of 'BUASCTUFPBU_E03_2'
And I go to the Library page for collection 'col3'NEWLIB
Then I 'should' see assets 'Fish2-Ad.mov' in the collection 'col3'NEWLIB

Scenario: Check sharing category hierarchy to user from partner BU
Meta:@gdam
     @library
Given I created the agency 'BUASCTUFPBU_A3' with default attributes
And I created the agency 'BUASCTUFPBU_A4' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique   |Access|
| BUASCTUFPBU_E04_1 | agency.admin | BUASCTUFPBU_A3 |streamlined_library,library|
| BUASCTUFPBU_E04_2 | agency.admin | BUASCTUFPBU_A4 |streamlined_library,library|
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A4' to agency 'BUASCTUFPBU_A3' on partners page
When I login with details of 'BUASCTUFPBU_E04_1'
And create 'col4_1' category
And create child category 'col4_2' of category 'col4_1'
And create child category 'col4_3' of category 'col4_2'
And create child category 'col4_4' of category 'col4_3'
And go to collection 'col4_1' on administration area collections page
And add users 'BUASCTUFPBU_E04_2' to category 'col4_1' with role 'library.admin' by users details
And login with details of 'BUASCTUFPBU_E04_2'
And I go to the collections page
Then I 'should' see series of sub collections 'col4_1,col4_2,col4_3,col4_4' under agency 'BUASCTUFPBU_A3'NEWLIB


Scenario: Check download proxy/master permissions for assets in shared category (default library roles)
Meta:@gdam
     @library
Given I created the agency 'BUASCTUFPBU_A5' with default attributes
And created the agency 'BUASCTUFPBU_A6' with default attributes
And added agency 'BUASCTUFPBU_A5' as a partner to agency 'BUASCTUFPBU_A6'
And I created users with following fields:
| Email            | Role         | Agency           |Access|
| U_ASCTUFP_S05_1  | agency.admin | BUASCTUFPBU_A5 |streamlined_library,library|
| UA_ASCTUFP_S05_1 | agency.admin | BUASCTUFPBU_A6 |streamlined_library,library|
| <UserEmail>      | <GlobalRole> | BUASCTUFPBU_A6 |streamlined_library,library|
And logged in with details of 'U_ASCTUFP_S05_1'
And created following categories:
| Name            |
| C_ASCTUFP_S05_1 |
And uploaded asset '/files/Fish-Ad.mov' into libraryNEWLIB
And I waited while preview is visible on library page for collection 'My Assets' for asset 'Fish-Ad.mov'NEWLIB
And on administration area collections page
And added users '<UserEmail>' for category 'C_ASCTUFP_S05_1' with role '<LibaryRole>'
When I login with details of '<UserEmail>'
And go to asset 'Fish-Ad.mov' info page in Library for collection 'C_ASCTUFP_S05_1'NEWLIB
Then '<Condition>' see 'download proxy' button on opened asset info pageNEWLIB
And I '<Condition>' see 'download original' button on opened asset info pageNEWLIB

Examples:
| UserEmail       | GlobalRole   | LibaryRole    | Condition |
| U_ASCTUFP_S05_2 | agency.user  | library.admin | should    |
| U_ASCTUFP_S05_3 | agency.user  | library.user  | should    |


Scenario: Check that after unshare category it disappears from library for share recipient
Meta:@gdam
     @library
Given I created the agency 'BUASCTUFPBU_A7' with default attributes
And I created the agency 'BUASCTUFPBU_A8' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique   |Access|
| BUASCTUFPBU_E07_1 | agency.admin | BUASCTUFPBU_A7 |streamlined_library,library|
| BUASCTUFPBU_E07_2 | agency.admin | BUASCTUFPBU_A8 |streamlined_library,library|
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A8' to agency 'BUASCTUFPBU_A7' on partners page
When I login with details of 'BUASCTUFPBU_E07_1'
And create 'col7' category
And upload following assetsNEWLIB:
| Name                |
| /files/Fish-Ad.mov   |
And I wait while preview is visible on library page for collection 'My Assets' for asset 'Fish-Ad.mov'NEWLIB
And go to collection 'col7' on administration area collections page
And add users 'BUASCTUFPBU_E07_2' to category 'col7' with role 'library.admin' by users details
And remove users 'BUASCTUFPBU_E07_2' for category 'col7'
And login with details of 'BUASCTUFPBU_E07_2'
And I go to the collections page
Then I should see 'My Collections' list emptyNEWLIB


Scenario: Shared parent category to partner BU appears in Recepients library
Meta:@gdam
     @library
Given I created the agency 'BUASCTUFPBU_A9' with default attributes
And I created the agency 'BUASCTUFPBU_A10' with default attributes
And created users with following fields:
| Email              | Role         | AgencyUnique   |Access|
| BUASCTUFPBU_E010_1 | agency.admin | BUASCTUFPBU_A9 |streamlined_library,library|
| BUASCTUFPBU_E010_2 | agency.admin | BUASCTUFPBU_A10 |streamlined_library,library|
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A10' to agency 'BUASCTUFPBU_A9' on partners page
When I login with details of 'BUASCTUFPBU_E010_1'
And create 'col10' category
And upload following assetsNEWLIB:
| Name             |
| /files/logo3.jpg |
And I wait while preview is visible on library page for collection 'My Assets' for asset 'logo3.jpg'NEWLIB
And go to collection 'col10' on administration area collections page
And add agency 'BUASCTUFPBU_A10' to category 'col10' on Asset Categories and Permissions page
And login with details of 'BUASCTUFPBU_E010_2'
And I go to the collections page
Then I should see 'My Collections' list emptyNEWLIB