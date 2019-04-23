!-- NGN-10992
Feature:          User can manually add related files for file
Narrative:
In order to
As a              AgencyAdmin
I want to         Check user can manually add related files for file

Scenario: Check that user can add several related files
Meta:@projects
     @gdam
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique |
| U_UCMARFFF_S01 | agency.admin | A_UCMARFFF_1 |
And logged in with details of 'U_UCMARFFF_S01'
And created 'P_UCMARFFF_1' project
And created '/folder' folder for project 'P_UCMARFFF_1'
And uploaded into project 'P_UCMARFFF_1' following files:
| FileName             | Path    |
| /images/logo.gif     | /folder |
| /images/logo.png     | /folder |
| /images/logo.jpg     | /folder |
| /files/logo1.gif     | /folder |
| /files/Fish1-Ad.mov  | /folder |
| /files/Fish2-Ad.mov  | /folder |
| /files/Fish3-Ad.mov  | /folder |
And waited while transcoding is finished in folder '/folder' on project 'P_UCMARFFF_1' files page
And opened file 'logo.gif' in '/folder' in project 'P_UCMARFFF_1' on related files page
And typed related file 'logo*' on related files page on pop-up
And selected and save following related files 'logo.png,logo.jpg' on related file pop-up
And opened file 'logo.gif' in '/folder' in project 'P_UCMARFFF_1' on related files page
And typed related file 'Fish*' on related files page on pop-up
And selected and save following related files 'Fish1-Ad.mov,Fish2-Ad.mov' on related file pop-up
Then should see following count '4' of related files


Scenario: Check that as related file couldn't be added file without 'element.related.file.read' permission
Meta:@projects
     @gdam
Given created users with following fields:
| Email            | Role         |
| U_UCMARFFF_S02_1 | agency.admin |
| U_UCMARFFF_S02_2 | agency.user  |
And created 'P_UCMARFFF_2' project
And created '/folder' folder for project 'P_UCMARFFF_2'
And uploaded '/images/logo.jpeg' file into '/folder' folder for 'P_UCMARFFF_2' project
And waited while transcoding is finished in folder '/folder' on project 'P_UCMARFFF_2' files page
And shared each folder from project 'P_UCMARFFF_2' to user 'U_UCMARFFF_S02_2' with role 'project.user' expired date '12.12.2021'
When I login with details of 'U_UCMARFFF_S02_2'
And go to file 'logo.jpeg' in '/folder' in project 'P_UCMARFFF_2' on related files page
Then I 'should not' see LinkToExisting button on related files page


Scenario: Check that as related file could be added file from shared folder
Meta:@projects
     @gdam
Given created users with following fields:
| Email          | Role         |
| U_UCMARFFF_S03 | agency.admin |
And created 'P_UCMARFFF_3' project
And created '/folder' folder for project 'P_UCMARFFF_3'
And uploaded '/images/logo.jpeg' file into '/folder' folder for 'P_UCMARFFF_3' project
And uploaded '/images/logo.jpg' file into '/folder' folder for 'P_UCMARFFF_3' project
And uploaded '/images/logo.png' file into '/folder' folder for 'P_UCMARFFF_3' project
And waited while transcoding is finished in folder '/folder' on project 'P_UCMARFFF_3' files page
And shared each folder from project 'P_UCMARFFF_3' to user 'U_UCMARFFF_S03' with role 'project.user' expired date '12.12.2021'
When I login with details of 'U_UCMARFFF_S03'
And go to file 'logo.png' in '/folder' in project 'P_UCMARFFF_3' on related files page
And type related file 'logo*' on related files page on pop-up
And select and save following related files 'logo.jpg,logo.jpeg' on related file pop-up
Then should see following count '2' of related files


Scenario: Check that in related files search, available only files (not assets folders project users)
Meta:@projects
     @gdam
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique |
| U_UCMARFFF_S04 | agency.admin | A_UCMARFFF_1 |
And logged in with details of 'U_UCMARFFF_S04'
And created 'P_UCMARFFF_4' project
And created '/folder' folder for project 'P_UCMARFFF_4'
And uploaded asset '/images/SB_Logo.png' into library
And uploaded into project 'P_UCMARFFF_4' following files:
| FileName         | Path    |
| /images/logo.gif | /folder |
And waited while transcoding is finished in folder '/folder' on project 'P_UCMARFFF_4' files page
When I go to file 'logo.gif' in '/folder' in project 'P_UCMARFFF_4' on related files page
And type related file 'P_UCMARFFF_4*' on related files page on pop-up
Then I should see message warning 'Your search did not return any results'
When I type related file 'folder' on related files page on pop-up
Then I should see message warning 'Your search did not return any results'
When I type related file '"SB_Logo.png"' on related files page on pop-up
Then I should see message warning 'Your search did not return any results'


Scenario: Check that in related files search, not available files of another user of current/another agency
Meta:@projects
     @gdam
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created the agency 'A_UCMARFFF_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique |
| U_UCMARFFF_S05_1 | agency.admin | A_UCMARFFF_1 |
| U_UCMARFFF_S05_2 | agency.user  | A_UCMARFFF_1 |
| U_UCMARFFF_S05_3 | agency.admin | A_UCMARFFF_2 |
| U_UCMARFFF_S05_3 | agency.user  | A_UCMARFFF_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UCMARFFF_2' to agency 'A_UCMARFFF_1' on partners page
And logged in with details of 'U_UCMARFFF_S05_1'
And created 'P_UCMARFFF_5_1' project
And created '/folder' folder for project 'P_UCMARFFF_5_1'
And uploaded '/files/Fish1-Ad.mov' file into '/folder' folder for 'P_UCMARFFF_5_1' project
And logged in with details of 'U_UCMARFFF_S05_2'
And created 'P_UCMARFFF_5_2' project
And created '/folder' folder for project 'P_UCMARFFF_5_2'
And uploaded '/files/Fish2-Ad.mov' file into '/folder' folder for 'P_UCMARFFF_5_2' project
And waited while transcoding is finished in folder '/folder' on project 'P_UCMARFFF_5_2' files page
When I go to file 'Fish2-Ad.mov' in '/folder' in project 'P_UCMARFFF_5_2' on related files page
And type related file '"Fish1-Ad.mov"' on related files page on pop-up
Then I should see message warning 'Your search did not return any results'
When I login with details of 'U_UCMARFFF_S05_3'
And I create 'P_UCMARFFF_5_3' project
And create '/folder' folder for project 'P_UCMARFFF_5_3'
And upload '/files/Fish3-Ad.mov' file into '/folder' folder for 'P_UCMARFFF_5_3' project
And wait while transcoding is finished in folder '/folder' on project 'P_UCMARFFF_5_3' files page
When I go to file 'Fish3-Ad.mov' in '/folder' in project 'P_UCMARFFF_5_3' on related files page
And type related file '"Fish2-Ad.mov"' on related files page on pop-up
Then I should see message warning 'Your search did not return any results'


Scenario: Check that after add related file, file metadata could be re-saved
Meta:@projects
     @gdam
Given I created the agency 'A_UCMARFFF_1' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique |
| U_UCMARFFF_S05 | agency.admin | A_UCMARFFF_1 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_UCMARFFF_1':
| Advertiser       | Brand           | Sub Brand        | Product         |
| ADV_UCMARFFF_S01 | BR_UCMARFFF_S01 | SBR_UCMARFFF_S01 | PR_UCMARFFF_S01 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_UCMARFFF_1':
| Advertiser       | Brand           | Sub Brand        | Product         |
| ADV_UCMARFFF_S02 | BR_UCMARFFF_S02 | SBR_UCMARFFF_S02 | PR_UCMARFFF_S02 |
And I logged in with details of 'U_UCMARFFF_S05'
And created new project with following fields:
| FieldName  | FieldValue       |
| Name       | P_UCMARFFF_5     |
| Media type | Broadcast        |
| Advertiser | ADV_UCMARFFF_S01 |
| Brand      | BR_UCMARFFF_S01  |
| Sub Brand  | SBR_UCMARFFF_S01 |
| Product    | PR_UCMARFFF_S01  |
| Start date | Today            |
| End date   | Tomorrow         |
And created '/folder' folder for project 'P_UCMARFFF_5'
And uploaded '/images/logo.jpeg' file into '/folder' folder for 'P_UCMARFFF_5' project
And uploaded '/images/logo.jpg' file into '/folder' folder for 'P_UCMARFFF_5' project
And waited while transcoding is finished in folder '/folder' on project 'P_UCMARFFF_5' files page
And opened file 'logo.jpeg' in '/folder' in project 'P_UCMARFFF_5' on related files page
And typed related file 'logo.jpg' on related files page on pop-up
And selected following related files 'logo.jpg' on related asset pop-up
And opened uploaded file 'logo.jpg' in folder '/folder' project 'P_UCMARFFF_5'
When I 'save' file info by next information:
| FieldName  | FieldValue        |
| Advertiser | ADV_UCMARFFF_S02  |
| Brand      | BR_UCMARFFF_S02   |
| Sub Brand  | SBR_UCMARFFF_S02  |
| Product    | PR_UCMARFFF_S02   |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue        |
| Advertiser | ADV_UCMARFFF_S02  |
| Brand      | BR_UCMARFFF_S02   |
| Sub Brand  | SBR_UCMARFFF_S02  |
| Product    | PR_UCMARFFF_S02   |


Scenario: Check creation of Multiline control on Project Overview
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTM_S06' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S06 | agency.admin | A_CMCMTM_S06 |
And logged in with details of 'U_CMCMTM_S06'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CMCMTM_S06':
| Advertiser  | Brand  | Sub Brand | Product  |
| Advertiser1 | Brand1 | SubBrand1 | Product1 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CMCMTM_S06':
| Advertiser  | Brand  | Sub Brand | Product  |
| Advertiser2 | Brand2 | SubBrand2 | Product2 |
And created 'P_UCMARFFF_6' project
And created '/folder' folder for project 'P_UCMARFFF_6'
And uploaded '/images/logo.jpeg' file into '/folder' folder for 'P_UCMARFFF_6' project
And uploaded '/images/logo.jpg' file into '/folder' folder for 'P_UCMARFFF_6' project
And waited while transcoding is finished in folder '/folder' on project 'P_UCMARFFF_6' files page
When I go to file 'logo.jpeg' in '/folder' in project 'P_UCMARFFF_6' on related files page
And type related file 'logo.jpg' on related files page on pop-up
And select following related files 'logo.jpg' on related file pop-up
And open uploaded file 'logo.jpg' in folder '/folder' project 'P_UCMARFFF_6'
And 'save' file info by next information:
| FieldName  | FieldValue  |
| Advertiser | Advertiser2 |
| Brand      | Brand2      |
| Sub Brand  | SubBrand2   |
| Product    | Product2    |
And I refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue  |
| Advertiser | Advertiser2 |
| Brand      | Brand2      |
| Sub Brand  | SubBrand2   |
| Product    | Product2    |


Scenario: Check that parent should not be displayed beneath Is related to current file field when files are linked together with relationship as child
Meta:@projects
@gdam
!-- QA-1137
Given I created 'P_UCMARFFF_7' project
And created '/folder' folder for project 'P_UCMARFFF_7'
And uploaded into project 'P_UCMARFFF_7' following files:
| FileName                   | Path    |
| /files/Fish Ad.mov         | /folder |
| /files/Fish3-Ad.mov        | /folder |
And waited while preview is available in folder '/folder' on project 'P_UCMARFFF_7' files page
When I go to file 'Fish Ad.mov' in '/folder' in project 'P_UCMARFFF_7' on related files page
And type related file 'Fish3-Ad.mov' on related files page on pop-up
And select following related files 'Fish3-Ad.mov' on related file pop-up
And selected type of files become as 'Child' on related file pop-up
And click on save button on related file pop-up
And wait for '3' seconds
Then 'should' see following related files on related files page:
| FileName     | ProjectName   | IsRelatedAs |
| Fish3-Ad.mov | P_UCMARFFF_7  | Child       |


Scenario: Check that users should be able to link files together when file title contains double quotes
Meta:@gdam
@projects
!-- QA-1137
Given I created 'P_UCMARFFF_8' project
And created '/folder' folder for project 'P_UCMARFFF_8'
And uploaded into project 'P_UCMARFFF_8' following files:
| FileName                   | Path    |
| /files/Fish Ad.mov         | /folder |
| /files/Fish3-Ad.mov        | /folder |
And waited while preview is available in folder '/folder' on project 'P_UCMARFFF_8' files page
And I am on file 'Fish3-Ad.mov' info page in folder '/folder' project 'P_UCMARFFF_8'
When I 'save' file info by next information:
| FieldName  | FieldValue    |
| Title      | "Fish3-Ad.mov |
And I go to file 'Fish Ad.mov' in '/folder' in project 'P_UCMARFFF_8' on related files page
And type related file '"Fish3-Ad.mov' on related files page on pop-up
And select following related files '"Fish3-Ad.mov' on related file pop-up
And selected type of files become as 'Child' on related file pop-up
And click on save button on related file pop-up
Then I 'should not' see error message 'An error occured during related files saving'
And 'should' see following related files on related files page:
| FileName      | ProjectName   | IsRelatedAs |
| "Fish3-Ad.mov | P_UCMARFFF_8  | Child       |