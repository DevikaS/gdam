!--NGN-11518
Feature:          User can manually add Related Files for Asset
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that User can manually add Related Files for Asset




Scenario: Check that as related assets couldn't be added asset without 'element.related.file.read' permission
Meta:@gdam
@uitobe
@library
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique |
| U_UCMARFFF_S05_1 | agency.admin | A_UCMARFFF_1 |
| U_UCMARFFF_S05_2 | agency.user  | A_UCMARFFF_1 |
And logged in with details of 'U_UCMARFFF_S05_1'
And created 'С_UCMARFFF_S05' category
And added users 'U_UCMARFFF_S05_2' to category 'С_UCMARFFF_S05' with role 'library.user' by users details
And uploaded following assets:
| Name              |
| /files/logo1.gif  |
And waited while transcoding is finished in collection 'С_UCMARFFF_S05'
And added users 'U_UCMARFFF_S05_2' to category 'С_UCMARFFF_S05' with role 'library.user' by users details
When I login with details of 'U_UCMARFFF_S05_2'
And go to asset 'logo1.gif' info page in Library for collection 'С_UCMARFFF_S05'
Then I 'should not' see 'Related Assets' tab on file info page


Scenario: Check that as related asset could be added asset from shared collection
Meta:@uitobe
@library
@gdam
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique |
| U_UCMARFFF_S06_1 | agency.admin | A_UCMARFFF_1 |
| U_UCMARFFF_S06_2 | agency.user  | A_UCMARFFF_1 |
And logged in with details of 'U_UCMARFFF_S06_1'
And created 'С_UCMARFFF_S06' category
And added users 'U_UCMARFFF_S06_2' to category 'С_UCMARFFF_S06' with role 'library.user' by users details
And uploaded following assets:
| Name              |
| /files/logo1.gif  |
| /files/file2_.gif |
And waited while transcoding is finished in collection 'С_UCMARFFF_S06'
And added users 'U_UCMARFFF_S06_2' to category 'С_UCMARFFF_S06' with role 'library.admin' by users details
When I login with details of 'U_UCMARFFF_S06_2'
And go to asset 'logo1.gif' info page in Library for collection 'С_UCMARFFF_S06' on related assets page
And type related asset 'file2_.gif' on related assets page on pop-up
And select following related files 'file2_.gif' on related asset pop-up
Then I should see following count '1' of related files on assets pop-up


Scenario: Check that in related asset search available only assets (not files folders project users)
Meta: @uitobe
@library
@gdam
!-- User checking removed due Maria ask (Search by email return wrong results but it won't be fixed)
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique |
| U_UCMARFFF_S01_1 | agency.admin | A_UCMARFFF_1 |
| U_UCMARFFF_S01_2 | agency.user  | A_UCMARFFF_1 |
And logged in with details of 'U_UCMARFFF_S01_1'
And created 'P_UCMARFFF_1' project
And created '/folder' folder for project 'P_UCMARFFF_1'
And uploaded into project 'P_UCMARFFF_1' following files:
| FileName         | Path    |
| /images/bg_img.jpg | /folder |
And uploaded asset '/images/SB_Logo.png' into library
And created collection 'C_UCMARFFF_01' based on category 'My Assets' on library page
And waited while transcoding is finished in collection 'C_UCMARFFF_01'
When I go to asset 'SB_Logo.png' info page in Library for collection 'C_UCMARFFF_01'
And go to asset 'SB_Logo.png' info page in Library for collection 'C_UCMARFFF_01' on related assets page
And type related asset 'P_UCMARFFF_1*' on related assets page on pop-up
Then I should see message warning 'Your search did not return any results'
When I type related file 'folder' on related files page on pop-up
Then I should see message warning 'Your search did not return any results'
When I type related file 'bg_img.jpg' on related files page on pop-up
Then I should see message warning 'Your search did not return any results'


Scenario: Check that after add related asset an asset metadata could be re-saved
Meta:@uitobe
@library
@gdam
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique |
| U_UCMARFFF_S02 | agency.admin | A_UCMARFFF_1 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_UCMARFFF_1':
| Advertiser       | Brand           | Sub Brand        | Product         |
| ADV_UCMARFFF_S01 | BR_UCMARFFF_S01 | SBR_UCMARFFF_S01 | PR_UCMARFFF_S01 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_UCMARFFF_1':
| Advertiser       | Brand           | Sub Brand        | Product         |
| ADV_UCMARFFF_S02 | BR_UCMARFFF_S02 | SBR_UCMARFFF_S02 | PR_UCMARFFF_S02 |
When I login with details of 'U_UCMARFFF_S02'
And create collection 'C_UCMARFFF_02' based on category 'My Assets' on library page
And upload following assets:
| Name             |
| /files/logo1.gif |
| /files/logo2.png |
And wait while transcoding is finished in collection 'C_UCMARFFF_02'
And go to asset 'logo2.png' info page in Library for collection 'C_UCMARFFF_02'
And 'save' asset info by following information on opened asset info page:
| FieldName  | FieldValue       |
| Advertiser | ADV_UCMARFFF_S01 |
| Brand      | BR_UCMARFFF_S01  |
| Sub Brand  | SBR_UCMARFFF_S01 |
| Product    | PR_UCMARFFF_S01  |
And go to asset 'logo1.gif' info page in Library for collection 'C_UCMARFFF_02' on related assets page
And type related file 'logo2.png' on related files page on pop-up
And select and save following related files 'logo2.png' on related file pop-up
And go to asset 'logo2.png' info page in Library for collection 'C_UCMARFFF_02'
And 'save' asset info by following information on opened asset info page:
| FieldName  | FieldValue       |
| Advertiser | ADV_UCMARFFF_S02 |
| Brand      | BR_UCMARFFF_S02  |
| Sub Brand  | SBR_UCMARFFF_S02 |
| Product    | PR_UCMARFFF_S02  |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue       |
| Advertiser | ADV_UCMARFFF_S02 |
| Brand      | BR_UCMARFFF_S02  |
| Sub Brand  | SBR_UCMARFFF_S02 |
| Product    | PR_UCMARFFF_S02  |


Scenario: Check that after add more than 15 asset they will be succeesfully displayed on related tab
Meta:@uitobe
@library
@gdam
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique |
| U_UCMARFFF_S03   | agency.admin | A_UCMARFFF_1 |
| U_UCMARFFF_S03_U | agency.user  | A_UCMARFFF_1 |
When I login with details of 'U_UCMARFFF_S03_U'
And create collection 'C_UCMARFFF_03' based on category 'My Assets' on library page
And upload following assets:
| Name                           |
| /files/logo1.gif               |
| /files/_file1.gif              |
| /images/logo.gif               |
| /files/logo2.png               |
| /images/big.logo.png           |
| /images/branding_logo.png      |
| /images/empty.project.logo.png |
| /files/logo3.png               |
| /images/logo.png               |
| /images/SB_Logo.png            |
| /files/logo3.jpg               |
| /images/admin.logo.jpg         |
| /images/bg_img.jpg             |
| /images/logo.jpg               |
| /images/empty.logo.png         |
| /files/image11.jpg             |
And wait while transcoding is finished in collection 'C_UCMARFFF_03'
And go to asset 'SB_Logo.png' info page in Library for collection 'C_UCMARFFF_03' on related assets page
And type related asset '.gif' on related assets page on pop-up
And select following related files 'logo1.gif,_file1.gif,logo.gif' on related asset pop-up
And go to asset 'SB_Logo.png' info page in Library for collection 'C_UCMARFFF_03' on related assets page
And type related asset '.png' on related assets page on pop-up
And select following related files 'logo2.png,big.logo.png,branding_logo.png,empty.project.logo.png,logo3.png,logo.png,empty.logo.png,' on related asset pop-up
And go to asset 'SB_Logo.png' info page in Library for collection 'C_UCMARFFF_03' on related assets page
And type related asset '.jpg' on related assets page on pop-up
And select following related files 'logo3.jpg,admin.logo.jpg,bg_img.jpg,logo.jpg,image11.jpg' on related asset pop-up
And go to asset 'SB_Logo.png' info page in Library for collection 'C_UCMARFFF_03' on related assets page
Then I should see following count '15' of related files on assets pop-up


Scenario: Check that in related asset search not available assets of another user of current/another agency
Meta:@uitobe
@library
@gdam
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique |
| U_UCMARFFF_S04_1 | agency.admin | <Agency>     |
| U_UCMARFFF_S04_2 | agency.user  | <Agency>     |
| <Email>          | <Role>       | <Agency>     |
When I login with details of 'U_UCMARFFF_S04_2'
And create collection '<CollectionName>' based on category 'My Assets' on library page
And upload following assets:
| Name              |
| /files/logo1.gif  |
| /files/_file1.gif |
And wait while transcoding is finished in collection '<CollectionName>'
And go to asset 'logo1.gif' info page in Library for collection '<CollectionName>' on related assets page
And type related asset '.gif' on related assets page on pop-up
And select following related files '_file1.gif' on related asset pop-up
And login with details of '<Email>'
And create collection '<SecondCollectionName>' based on category 'My Assets' on library page
And upload following assets:
| Name               |
| /files/image10.jpg |
And wait while transcoding is finished in collection '<SecondCollectionName>'
And go to asset 'image10.jpg' info page in Library for collection '<SecondCollectionName>' on related assets page
And type related asset '.gif' on related assets page on pop-up
Then I should see message warning 'Your search did not return any results'

Examples:
| Email            | Role         | Agency       | CollectionName  | SecondCollectionName |
| U_UCMARFFF_S04_3 | agency.user  | A_UCMARFFF_1 | C_UCMARFFF_04_1 | C_UCMARFFF_05_1      |
| U_UCMARFFF_S04_4 | agency.admin | A_UCMARFFF_2 | C_UCMARFFF_04_2 | C_UCMARFFF_05_2      |

