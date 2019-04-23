!--NGN-12869
Feature:          User can copy and move folders to another project (with metadata update)
Narrative:
In order to
As a              AgencyAdmin
I want to         User can copy and move folders to another project (with metadata update)


Scenario: Check that moved folder will be dissapear from origin project
Meta:@gdam
@projects
Given created users with following fields:
| Email             | Role         |
| E_UCCAMFTAP_S01_1 | agency.admin |
When I login with details of 'E_UCCAMFTAP_S01_1'
And create 'P_UCCAMFTAP_S01_1' project
And create '/F_UCCAMFTAP_S01_1' folder for project 'P_UCCAMFTAP_S01_1'
And create 'P_UCCAMFTAP_S01_2' project
And create '/F_UCCAMFTAP_S01_2' folder for project 'P_UCCAMFTAP_S01_2'
And move folder 'F_UCCAMFTAP_S01_1' from project 'P_UCCAMFTAP_S01_1' into folder 'F_UCCAMFTAP_S01_2' in project 'P_UCCAMFTAP_S01_2' with 'update' metadata
And wait for '2' seconds
And go to project 'P_UCCAMFTAP_S01_1' files page
Then I 'should not' see folder name '/F_UCCAMFTAP_S01_1' on files page


Scenario: Check that file could be commented after folder copy
Meta:@gdam
@projects
Given created users with following fields:
| Email             | Role         |
| E_UCCAMFTAP_S02_1 | agency.admin |
When I login with details of 'E_UCCAMFTAP_S02_1'
And create 'P_UCCAMFTAP_S02_1' project
And create '/F_UCCAMFTAP_S02_1' folder for project 'P_UCCAMFTAP_S02_1'
And upload '/files/120.600.gif' file into '/F_UCCAMFTAP_S02_1' folder for 'P_UCCAMFTAP_S02_1' project
And wait while transcoding is finished in folder '/F_UCCAMFTAP_S02_1' on project 'P_UCCAMFTAP_S02_1' files page
And create 'P_UCCAMFTAP_S02_2' project
And create '/F_UCCAMFTAP_S02_2' folder for project 'P_UCCAMFTAP_S02_2'
And move folder 'F_UCCAMFTAP_S02_1' from project 'P_UCCAMFTAP_S02_1' into folder 'F_UCCAMFTAP_S02_2' in project 'P_UCCAMFTAP_S02_2' with 'update' metadata
And wait for '2' seconds
And add comment 'test comment' on file '120.600.gif' comments page on folder '/F_UCCAMFTAP_S02_2/F_UCCAMFTAP_S02_1' in project 'P_UCCAMFTAP_S02_2'
Then I 'should' see comment 'test comment' on file '120.600.gif' comments page on folder '/F_UCCAMFTAP_S02_2/F_UCCAMFTAP_S02_1' in project 'P_UCCAMFTAP_S02_2'


Scenario: Check that file could be approved after folder copy
Meta:@gdam
@projects
Given I created users with following fields:
| Email         | Role         |
| U_UCCAMFTAP_3 | agency.admin |
And created 'UCCAMFTAP_P3_1' project
And created '/folder1' folder for project 'UCCAMFTAP_P3_1'
And uploaded '/files/image9.jpg' file into '/folder1' folder for 'UCCAMFTAP_P3_1' project
And created 'UCCAMFTAP_P3_2' project
And created '/folder2' folder for project 'UCCAMFTAP_P3_2'
And waited while preview is available in folder '/folder1' on project 'UCCAMFTAP_P3_1' files page
And copied folder 'folder1' from project 'UCCAMFTAP_P3_1' into folder 'folder2' in project 'UCCAMFTAP_P3_2'
And waited for '2' seconds
And I am on project 'UCCAMFTAP_P3_2' teams page
And added user 'U_UCCAMFTAP_3' into project 'UCCAMFTAP_P3_2' team with role 'Project Contributor' expired '12.12.2021' for folder on popup '/folder2/folder1'
And added approval stage on file 'image9.jpg' approvals page in folder '/folder2/folder1' project 'UCCAMFTAP_P3_2':
| Name      | Approvers     | Deadline         | Description      | Started |
| UCCAMFTAP | U_UCCAMFTAP_3 | 01/05/2023 12:15 | test description | true    |
And 'Approve' stage 'UCCAMFTAP' with comment 'test comment' on file 'image9.jpg' approvals page in folder '/folder2/folder1' project 'UCCAMFTAP_P3_2'
When I login with details of 'U_UCCAMFTAP_3'
And go to project 'UCCAMFTAP_P3_2' folder '/folder2/folder1' page
Then I 'should' see approval status icon 'approved' in file 'image9.jpg' preview on project 'UCCAMFTAP_P3_2' folder '/folder2/folder1' files page


Scenario: Check that if user copied folder with metadata update files will inherit project metadata (check in files,custom metadata 'String',dropdown,radio button,catalog group)
Meta:@gdam
@projects
Given I created the agency 'A_UCCAMFTAP_S01' with default attributes
And created users with following fields:
| Email         | Role         | Agency          |
| U_UCCAMFTAP_4 | agency.admin | A_UCCAMFTAP_S01 |
When I login with details of 'U_UCCAMFTAP_4'
And go to the global 'common custom' metadata page for agency 'A_UCCAMFTAP_S01'
And create 'Dropdown' custom metadata field with following information on opened metadata page:
| Description        |
| DROPDOWN_UCCAMFTAP |
And click 'DROPDOWN_UCCAMFTAP' button in 'common metadata' section on opened metadata page
And add following dropdown choices on opened Settings and Customization page:
| Choice       |
| UCCAMFTAP1_1 |
| UCCAMFTAP1_2 |
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser       | Brand           | Sub Brand        | Product          |
| AR_UCCAMFTAP_S01 | B_UCCAMFTAP_S01 | SB_UCCAMFTAP_S01 | PT_UCCAMFTAP_S01 |
And create new project with following fields:
| FieldName          | FieldValue      |
| Name               | UCCAMFTAP_P4_1  |
| Media type         | Broadcast       |
| Advertiser         | AR_CMCMTAAD_S01 |
| Brand              | B_CMCMTAAD_S01  |
| Sub Brand          | SB_CMCMTAAD_S01 |
| Product            | PT_CMCMTAAD_S01 |
| Start date         | Today           |
| End date           | Tomorrow        |
| DROPDOWN_UCCAMFTAP | UCCAMFTAP1_2    |
And create '/F_CMCMTAAD_S01' folder for project 'UCCAMFTAP_P4_1'
And upload '/files/image9.jpg' file into '/F_CMCMTAAD_S01' folder for 'UCCAMFTAP_P4_1' project
And wait while preview is available in folder '/F_CMCMTAAD_S01' on project 'UCCAMFTAP_P4_1' files page
And create 'UCCAMFTAP_P4_2' project
And create '/F_CMCMTAAD_S02' folder for project 'UCCAMFTAP_P4_2'
And copy folder 'F_CMCMTAAD_S01' from project 'UCCAMFTAP_P4_1' into folder 'F_CMCMTAAD_S02' in project 'UCCAMFTAP_P4_2'
And wait for '2' seconds
And go to file 'image9.jpg' info page in folder '/F_CMCMTAAD_S02/F_CMCMTAAD_S01' project 'UCCAMFTAP_P4_2'
And I Open and fill Edit file popup with following information:
| FieldName          | FieldValue      |
| Advertiser         | AR_CMCMTAAD_S01 |
| Brand              | B_CMCMTAAD_S01  |
| Sub Brand          | SB_CMCMTAAD_S01 |
| Product            | PT_CMCMTAAD_S01 |
| DROPDOWN_UCCAMFTAP | UCCAMFTAP1_2    |
And click on element 'SaveButton'
When I go to file 'image9.jpg' info page in folder '/F_CMCMTAAD_S02/F_CMCMTAAD_S01' project 'UCCAMFTAP_P4_2'
And go to file 'image9.jpg' info page in folder '/F_CMCMTAAD_S02/F_CMCMTAAD_S01' project 'UCCAMFTAP_P4_2'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName          | FieldValue      |
| Advertiser         | AR_CMCMTAAD_S01 |
| Brand              | B_CMCMTAAD_S01  |
| Sub Brand          | SB_CMCMTAAD_S01 |
| Product            | PT_CMCMTAAD_S01 |
| DROPDOWN_UCCAMFTAP | UCCAMFTAP1_2    |

Scenario: Check that if user moved folder without metadata update files will not inherit project metadata (check in files)
Meta:@gdam
@projects
Given I created the agency 'A_UCCMFTPFABU_1' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFTPFABU_S05_1 | agency.admin | A_UCCMFTPFABU_1 |
When I login with details of 'E_UCCMFTPFABU_S05_1'
And create 'P_UCCMFTPFABU_S05_1' project
And create '/F_UCCMFTPFABU_S05_1' folder for project 'P_UCCMFTPFABU_S05_1'
And create 'P_UCCMFTPFABU_S05_2' project
And create '/F_UCCMFTPFABU_S05_2' folder for project 'P_UCCMFTPFABU_S05_2'
And upload '/files/atCalcImage.jpg' file into '/F_UCCMFTPFABU_S05_1' folder for 'P_UCCMFTPFABU_S05_1' project
And wait while transcoding is finished in folder '/F_UCCMFTPFABU_S05_1' on project 'P_UCCMFTPFABU_S05_1' files page
And go to file 'atCalcImage.jpg' info page in folder '/F_UCCMFTPFABU_S05_1' project 'P_UCCMFTPFABU_S05_1'
And click Edit link on file info page
And I fill Edit file popup with following information:
| FieldName  | FieldValue     |
| Advertiser | testAdvertiser |
And click on element 'SaveButton'
And wait for '2' seconds
And move folder 'F_UCCMFTPFABU_S05_1' from project 'P_UCCMFTPFABU_S05_1' into folder 'F_UCCMFTPFABU_S05_2' in project 'P_UCCMFTPFABU_S05_2' with 'no update' metadata
And wait for '3' seconds
And go to file 'atCalcImage.jpg' info page in folder '/F_UCCMFTPFABU_S05_2/F_UCCMFTPFABU_S05_1' project 'P_UCCMFTPFABU_S05_2'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue     |
| Advertiser | testAdvertiser |