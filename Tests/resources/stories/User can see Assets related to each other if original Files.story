!-- NGN-11616
Feature:          User can see Assets related to each other if original Files were related
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that User can see Assets related to each other if original Files were related



Scenario: Check that when user moves multiple Files from Folders to Library the system should check if these Files are related to each other. If yes - created Assets should become related to each other as well.
Meta:@gdam
@library
Given I created the agency 'A_UCSARTAOFOF_1' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique    |Access|
| U_UCSARTAOFOF_S01 | agency.admin | A_UCSARTAOFOF_1 |streamlined_library,library,folders|
When I login with details of 'U_UCSARTAOFOF_S01'
And create 'P_UCSARTAOFOF_1' project
And create '/F_UCSARTAOFOF_1' folder for project 'P_UCSARTAOFOF_1'
And upload into project 'P_UCSARTAOFOF_1' following files:
| FileName             | Path             |
| /images/logo.gif     | /F_UCSARTAOFOF_1 |
| /images/logo.png     | /F_UCSARTAOFOF_1 |
| /images/logo.jpg     | /F_UCSARTAOFOF_1 |
And wait while transcoding is finished in folder '/F_UCSARTAOFOF_1' on project 'P_UCSARTAOFOF_1' files page
And go to file 'logo.gif' in '/F_UCSARTAOFOF_1' in project 'P_UCSARTAOFOF_1' on related files page
And type related file 'logo*' on related files page on pop-up
And select and save following related files 'logo.png,logo.jpg' on related file pop-up
And move following files 'logo.gif,logo.png,logo.jpg' from project 'P_UCSARTAOFOF_1' folder '/F_UCSARTAOFOF_1' to new library page
And go to  library page for collection 'My Assets'NEWLIB
Then I 'should' see asset count '3' in 'My Assets' NEWLIB


Scenario: Check that When user moves single File from Folder to Library the system should check if this File has Related Files and if so if any of these related Files already have been moved to Library. If so created asset should become related to previously created assets as well.
Meta:@gdam
@library
Given I created the agency 'A_UCSARTAOFOF_2' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique    |Access|
| U_UCSARTAOFOF_S02 | agency.admin | A_UCSARTAOFOF_2 |streamlined_library,library,folders|
And logged in with details of 'U_UCSARTAOFOF_S02'
And created 'P_UCSARTAOFOF_2' project
And created '/F_UCSARTAOFOF_2' folder for project 'P_UCSARTAOFOF_2'
And uploaded into project 'P_UCSARTAOFOF_2' following files:
| FileName         | Path             |
| /images/logo.gif | /F_UCSARTAOFOF_2 |
| /images/logo.png | /F_UCSARTAOFOF_2 |
| /images/logo.jpg | /F_UCSARTAOFOF_2 |
And waited while transcoding is finished in folder '/F_UCSARTAOFOF_2' on project 'P_UCSARTAOFOF_2' files page
And opened file 'logo.gif' in '/F_UCSARTAOFOF_2' in project 'P_UCSARTAOFOF_2' on related files page
And typed related file 'logo*' on related files page on pop-up
And selected and save following related files 'logo.png,logo.jpg' on related file pop-up
And moved file 'logo.gif' from project 'P_UCSARTAOFOF_2' folder '/F_UCSARTAOFOF_2' to new library page
And moved file 'logo.png' from project 'P_UCSARTAOFOF_2' folder '/F_UCSARTAOFOF_2' to new library page
And moved file 'logo.jpg' from project 'P_UCSARTAOFOF_2' folder '/F_UCSARTAOFOF_2' to new library page
When I go to the library page for collection 'My Assets'NEWLIB
Then I 'should' see asset count '3' in 'My Assets' NEWLIB

Scenario: Check that after remove one of the assets relations should be removed
Meta:@uitobe
@library
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique |
| U_UCMARFFF_S03   | agency.admin | A_UCMARFFF_1 |
| U_UCMARFFF_S03_U | agency.user  | A_UCMARFFF_1 |
When I login with details of 'U_UCMARFFF_S03_U'
And upload following assets:
| Name                |
| /files/_file1.gif   |
| /images/SB_Logo.png |
And wait while transcoding is finished in collection 'My Assets'
And go to asset 'SB_Logo.png' info page in Library for collection 'My Assets' on related assets page
And type related asset '_file1.gif' on related assets page on pop-up
And select following related files '_file1.gif' on related asset pop-up
And go to  library page for collection 'My Assets'
And remove asset 'SB_Logo.png' from current library collection
And go to  Library page
Then I should see following number '0' of related files on library page

Scenario: Check that link to related file works fine in case when related assets available in different shared collections (NGN-11190)
Meta:@uitobe
@library
Given I created the agency 'A_UCSARTAOFOF_1' with default attributes
And created users with following fields:
| Email               | Role         | AgencyUnique    |
| U_UCSARTAOFOF_S04_1 | agency.admin | A_UCSARTAOFOF_1 |
| U_UCSARTAOFOF_S04_2 | agency.user  | A_UCSARTAOFOF_1 |
And logged in with details of 'U_UCSARTAOFOF_S04_1'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_UCSARTAOFOF_1':
| Advertiser  |
| Advertiser1 |
| Advertiser2 |
And created following categories:
| Name              |
| С_UCSARTAOFOF_4_1 |
| С_UCSARTAOFOF_4_2 |
When I go to collection 'С_UCSARTAOFOF_4_1' on administration area collections page
And add following metadata on opened category page:
| FilterName | FilterValue |
| Advertiser | Advertiser1 |
And go to collection 'С_UCSARTAOFOF_4_2' on administration area collections page
And add following metadata on opened category page:
| FilterName | FilterValue |
| Advertiser | Advertiser2 |
And upload following assets:
| Name               |
| /files/_file1.gif  |
| /files/120.600.gif |
And go to asset '_file1.gif' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName  | FieldValue  |
| Advertiser | Advertiser1 |
And go to asset '120.600.gif' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName  | FieldValue  |
| Advertiser | Advertiser2 |
And go to asset '_file1.gif' info page in Library for collection 'My Assets' on related assets page
And type related file '120.600.gif' on related files page on pop-up
And select and save following related files '120.600.gif' on related file pop-up
And add users 'U_UCSARTAOFOF_S04_2' for category 'С_UCSARTAOFOF_4_1' with role 'library.user'
And add users 'U_UCSARTAOFOF_S04_2' for category 'С_UCSARTAOFOF_4_2' with role 'library.user'
And login with details of 'U_UCSARTAOFOF_S04_2'
And go to  Library page for collection 'С_UCSARTAOFOF_4_1'
Then I should see following number '1' of related files on library page
When I go to  Library page for collection 'С_UCSARTAOFOF_4_2'
Then I should see following number '1' of related files on library page





