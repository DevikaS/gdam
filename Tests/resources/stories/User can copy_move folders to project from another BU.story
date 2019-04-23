!--NGN-12870
Feature:          User can copy_move folders to project from another BU
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user can copy_move folders to project from another BU


Scenario: Check that user could copy folder withinn same project from another BU
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFTPFABU_1' with default attributes
And created the agency 'A_UCCMFTPFABU_2' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFTPFABU_S01_1 | agency.admin | A_UCCMFTPFABU_1 |
| E_UCCMFTPFABU_S01_2 | agency.admin | A_UCCMFTPFABU_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UCCMFTPFABU_2' to agency 'A_UCCMFTPFABU_1' on partners page
And logged in with details of 'E_UCCMFTPFABU_S01_1'
And created 'P_UCCMFTPFABU_S01' project
And created '/F_UCCMFTPFABU_S01' folder for project 'P_UCCMFTPFABU_S01'
And created '/F_UCCMFTPFABU_S02' folder for project 'P_UCCMFTPFABU_S01'
And added users 'E_UCCMFTPFABU_S01_2' to project 'P_UCCMFTPFABU_S01' team folders '/F_UCCMFTPFABU_S01,/F_UCCMFTPFABU_S02' with role 'project.user' expired '12.12.2020'
When I login with details of 'E_UCCMFTPFABU_S01_2'
And copy folder '/F_UCCMFTPFABU_S01' in folder '/F_UCCMFTPFABU_S02' in project 'P_UCCMFTPFABU_S01'
And wait for '3' seconds
And go to project 'P_UCCMFTPFABU_S01' overview page
Then I should see following folders in 'P_UCCMFTPFABU_S01' project:
| folder                               |
| /F_UCCMFTPFABU_S01                   |
| /F_UCCMFTPFABU_S02/F_UCCMFTPFABU_S01 |


Scenario: Check that user could copy folder to a different project from another BU
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFTPFABU_1' with default attributes
And created the agency 'A_UCCMFTPFABU_2' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFTPFABU_S01_1 | agency.admin | A_UCCMFTPFABU_1 |
| E_UCCMFTPFABU_S01_2 | agency.admin | A_UCCMFTPFABU_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UCCMFTPFABU_2' to agency 'A_UCCMFTPFABU_1' on partners page
And logged in with details of 'E_UCCMFTPFABU_S01_1'
And created 'P_UCCMFTPFABU_S01' project
And created '/F_UCCMFTPFABU_S01' folder for project 'P_UCCMFTPFABU_S01'
And created '/F_UCCMFTPFABU_S02' folder for project 'P_UCCMFTPFABU_S01'
And added users 'E_UCCMFTPFABU_S01_2' to project 'P_UCCMFTPFABU_S01' team with role 'project.user' expired '12.12.2020'
When I login with details of 'E_UCCMFTPFABU_S01_2'
And created 'P_UCCMFTPFABU_S02' project
And I create '/F_UCCMFTPFABU_S03' folder for project 'P_UCCMFTPFABU_S02'
And I create '/F_UCCMFTPFABU_S04' folder for project 'P_UCCMFTPFABU_S02'
And I add users 'E_UCCMFTPFABU_S01_1' to project 'P_UCCMFTPFABU_S02' team with role 'project.user' expired '12.12.2020'
And copy folder 'F_UCCMFTPFABU_S01' from project 'P_UCCMFTPFABU_S01' into folder 'F_UCCMFTPFABU_S03' in project 'P_UCCMFTPFABU_S02'
And wait for '3' seconds
And go to project 'P_UCCMFTPFABU_S02' overview page
Then I should see following folders in 'P_UCCMFTPFABU_S02' project:
| folder                               |
| /F_UCCMFTPFABU_S04                   |
| /F_UCCMFTPFABU_S03/F_UCCMFTPFABU_S01 |

Scenario: Check that user could move folder to WR from another BU
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFTPFABU_1' with default attributes
And created the agency 'A_UCCMFTPFABU_2' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFTPFABU_S02_1 | agency.admin | A_UCCMFTPFABU_1 |
| E_UCCMFTPFABU_S02_2 | agency.admin | A_UCCMFTPFABU_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UCCMFTPFABU_2' to agency 'A_UCCMFTPFABU_1' on partners page
And logged in with details of 'E_UCCMFTPFABU_S02_1'
And created 'WR_UCCMFTPFABU_S02' work request
And created '/F_UCCMFTPFABU_S02_1' folder for work request 'WR_UCCMFTPFABU_S02'
And created '/F_UCCMFTPFABU_S02_2' folder for work request 'WR_UCCMFTPFABU_S02'
And edited the following fields for 'WR_UCCMFTPFABU_S02' work request:
| Name               | Administrators      |
| WR_UCCMFTPFABU_S02 | E_UCCMFTPFABU_S02_2 |
And clicked Save button on opened Edit Work Request popup
When I login with details of 'E_UCCMFTPFABU_S02_2'
And move folder '/F_UCCMFTPFABU_S02_1' in folder '/F_UCCMFTPFABU_S02_2' in work request 'WR_UCCMFTPFABU_S02'
And wait for '3' seconds
And go to work request 'WR_UCCMFTPFABU_S02' overview page
Then I should see following folders in 'WR_UCCMFTPFABU_S02' project:
| folder                                   |
| /F_UCCMFTPFABU_S02_2/F_UCCMFTPFABU_S02_1 |


Scenario: Check that user could copy folder to Template from another BU
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFTPFABU_1' with default attributes
And created the agency 'A_UCCMFTPFABU_2' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFTPFABU_S03_1 | agency.admin | A_UCCMFTPFABU_1 |
| E_UCCMFTPFABU_S03_2 | agency.admin | A_UCCMFTPFABU_2 |
When I login with details of 'GlobalAdmin'
And add following partners 'A_UCCMFTPFABU_2' to agency 'A_UCCMFTPFABU_1' on partners page
And login with details of 'E_UCCMFTPFABU_S03_1'
And create 'TPL_UCCMFTPFABU_S03' template
And create '/F_UCCMFTPFABU_S03_1' folder for template 'TPL_UCCMFTPFABU_S03'
And create '/F_UCCMFTPFABU_S03_2' folder for template 'TPL_UCCMFTPFABU_S03'
And go to template 'TPL_UCCMFTPFABU_S03' teams page
And edit the following fields for 'TPL_UCCMFTPFABU_S03' template:
| Name                | Administrators      |
| TPL_UCCMFTPFABU_S03 | E_UCCMFTPFABU_S03_2 |
And click Save button on template popup
When I login with details of 'E_UCCMFTPFABU_S03_2'
And I copy folder '/F_UCCMFTPFABU_S03_1' in template '/F_UCCMFTPFABU_S03_2' in template 'TPL_UCCMFTPFABU_S03'
Then I should see following folders in 'TPL_UCCMFTPFABU_S03' template:
| folder                                   |
| /F_UCCMFTPFABU_S03_1                     |
| /F_UCCMFTPFABU_S03_2/F_UCCMFTPFABU_S03_1 |


Scenario: Check that acl on folder won't be changed after move/copy (without element_write,master_download etc)
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFTPFABU_1' with default attributes
And created the agency 'A_UCCMFTPFABU_2' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFTPFABU_S04_1 | agency.admin | A_UCCMFTPFABU_1 |
| E_UCCMFTPFABU_S04_2 | agency.admin | A_UCCMFTPFABU_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UCCMFTPFABU_2' to agency 'A_UCCMFTPFABU_1' on partners page
And logged in with details of 'E_UCCMFTPFABU_S04_1'
And created 'P_UCCMFTPFABU_S04_1' project
And created '/F_UCCMFTPFABU_S04_1' folder for project 'P_UCCMFTPFABU_S04_1'
And created '/F_UCCMFTPFABU_S04_2' folder for project 'P_UCCMFTPFABU_S04_1'
And uploaded '/files/128_shortname.jpg' file into '/F_UCCMFTPFABU_S04_1' folder for 'P_UCCMFTPFABU_S04_1' project
And waited while transcoding is finished in folder '/F_UCCMFTPFABU_S04_1' on project 'P_UCCMFTPFABU_S04_1' files page
And added users 'E_UCCMFTPFABU_S04_2' to project 'P_UCCMFTPFABU_S04_1' team folders '/F_UCCMFTPFABU_S04_1,/F_UCCMFTPFABU_S04_2' with role 'project.contributor' expired '12.12.2020'
When I login with details of 'E_UCCMFTPFABU_S04_2'
And move folder 'F_UCCMFTPFABU_S04_1' in folder 'F_UCCMFTPFABU_S04_2' in project 'P_UCCMFTPFABU_S04_1'
And wait for '3' seconds
Then I 'should not' see Download Original button on file '128_shortname.jpg' info page in folder '/F_UCCMFTPFABU_S04_2/F_UCCMFTPFABU_S04_1' project 'P_UCCMFTPFABU_S04_1'


Scenario: Check that copied folder will be available in search results
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFTPFABU_1' with default attributes
And created users with following fields:
| Email             | Role         | Agency          |
| E_UCCMFTPFABU_S05 | agency.admin | A_UCCMFTPFABU_1 |
And logged in with details of 'E_UCCMFTPFABU_S05'
And created 'P_UCCMFTPFABU_S05' project
And created '/FUCCMFTPFABUS501' folder for project 'P_UCCMFTPFABU_S05'
And created '/FUCCMFTPFABUS502' folder for project 'P_UCCMFTPFABU_S05'
When I copy folder '/FUCCMFTPFABUS501' in folder '/FUCCMFTPFABUS502' in project 'P_UCCMFTPFABU_S05'
And refresh the page
And search by text with test session 'FUCCMFTPFABUS501'
Then I should see next count '2' found items


Scenario: Check that moved folder to shared project from another BU should be only with metadata update
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFTPFABU_1' with default attributes
And created the agency 'A_UCCMFTPFABU_2' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFTPFABU_S06_1 | agency.admin | A_UCCMFTPFABU_1 |
| E_UCCMFTPFABU_S06_2 | agency.admin | A_UCCMFTPFABU_2 |
When I login with details of 'GlobalAdmin'
And add following partners 'A_UCCMFTPFABU_2' to agency 'A_UCCMFTPFABU_1' on partners page
And login with details of 'E_UCCMFTPFABU_S06_1'
And create 'P_UCCMFTPFABU_S06_1' project
And create '/F_UCCMFTPFABU_S06_1' folder for project 'P_UCCMFTPFABU_S06_1'
And create 'P_UCCMFTPFABU_S06_2' project
And create '/F_UCCMFTPFABU_S06_2' folder for project 'P_UCCMFTPFABU_S06_2'
And upload '/files/atCalcImage.jpg' file into '/F_UCCMFTPFABU_S06_1' folder for 'P_UCCMFTPFABU_S06_1' project
And wait while transcoding is finished in folder '/F_UCCMFTPFABU_S06_1' on project 'P_UCCMFTPFABU_S06_1' files page
And go to file 'atCalcImage.jpg' info page in folder '/F_UCCMFTPFABU_S06_1' project 'P_UCCMFTPFABU_S06_1'
And click Edit link on file info page
And I fill Edit file popup with following information:
| FieldName  | FieldValue     |
| Advertiser | testAdvertiser |
And click on element 'SaveButton'
And edit the following fields for 'P_UCCMFTPFABU_S06_1' project:
| Name                | Administrators      |
| P_UCCMFTPFABU_S06_1 | E_UCCMFTPFABU_S06_2 |
And click Save button on project popup
And publish the project 'P_UCCMFTPFABU_S06_1'
And wait for '2' seconds
And go to project 'P_UCCMFTPFABU_S06_2' files page
And edit the following fields for 'P_UCCMFTPFABU_S06_2' project:
| Name                | Administrators      |
| P_UCCMFTPFABU_S06_2 | E_UCCMFTPFABU_S06_2 |
And click Save button on project popup
And publish the project 'P_UCCMFTPFABU_S06_2'
And login with details of 'E_UCCMFTPFABU_S06_2'
And move folder 'F_UCCMFTPFABU_S06_1' from project 'P_UCCMFTPFABU_S06_1' into folder 'F_UCCMFTPFABU_S06_2' in project 'P_UCCMFTPFABU_S06_2' with 'update' metadata
And wait for '3' seconds
And go to file 'atCalcImage.jpg' info page in folder '/F_UCCMFTPFABU_S06_2/F_UCCMFTPFABU_S06_1' project 'P_UCCMFTPFABU_S06_2'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue     |
| Advertiser | testAdvertiser |


Scenario: Check that all files are available in folder after move (with thumbnails and could be playable)
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFTPFABU_1' with default attributes
And created the agency 'A_UCCMFTPFABU_2' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFTPFABU_S07_1 | agency.admin | A_UCCMFTPFABU_1 |
| E_UCCMFTPFABU_S07_2 | agency.admin | A_UCCMFTPFABU_2 |
When I login with details of 'GlobalAdmin'
And add following partners 'A_UCCMFTPFABU_2' to agency 'A_UCCMFTPFABU_1' on partners page
And login with details of 'E_UCCMFTPFABU_S07_1'
And create 'P_UCCMFTPFABU_S07' project
And create '/F_UCCMFTPFABU_S07_1' folder for project 'P_UCCMFTPFABU_S07'
And upload '/files/atCalcImage.jpg' file into '/F_UCCMFTPFABU_S07_1' folder for 'P_UCCMFTPFABU_S07' project
And upload '/files/Fish4-Ad.mov' file into '/F_UCCMFTPFABU_S07_1' folder for 'P_UCCMFTPFABU_S07' project
And wait while transcoding is finished in folder '/F_UCCMFTPFABU_S07_1' on project 'P_UCCMFTPFABU_S07' files page
And publish the project 'P_UCCMFTPFABU_S07'
And edit the following fields for 'P_UCCMFTPFABU_S07' project:
| Name              | Administrators      |
| P_UCCMFTPFABU_S07 | E_UCCMFTPFABU_S07_2 |
And click Save button on project popup
And wait for '3' seconds
And login with details of 'E_UCCMFTPFABU_S07_2'
And create 'P_UCCMFTPFABU_S07_2' project
And create '/F_UCCMFTPFABU_S07_2' folder for project 'P_UCCMFTPFABU_S07_2'
And move folder 'F_UCCMFTPFABU_S07_1' from project 'P_UCCMFTPFABU_S07' into folder 'F_UCCMFTPFABU_S07_2' in project 'P_UCCMFTPFABU_S07_2' with 'update' metadata
And wait for '10' seconds
And go to file 'Fish4-Ad.mov' in '/F_UCCMFTPFABU_S07_2/F_UCCMFTPFABU_S07_1' in project 'P_UCCMFTPFABU_S07_2' on related files page
Then I 'should' see playable preview on file info page
And Files preview should be available on project 'P_UCCMFTPFABU_S07_2' overview page


Scenario: Check that moved folder can be renamed
Meta:@projects
!--QA-1124
Given I created 'P_UCCMFTPFABU_S08' project
And created 'F_UCCMFTPFABU_S08_1' folder for project 'P_UCCMFTPFABU_S08'
And created 'P_UCCMFTPFABU_S09' project
And created 'F_UCCMFTPFABU_S09_1' folder for project 'P_UCCMFTPFABU_S09'
When I move folder 'F_UCCMFTPFABU_S08_1' from project 'P_UCCMFTPFABU_S08' into folder 'F_UCCMFTPFABU_S09_1' in project 'P_UCCMFTPFABU_S09' with 'update' metadata
When I go to project 'P_UCCMFTPFABU_S09' files page
And select folder '/F_UCCMFTPFABU_S09_1/F_UCCMFTPFABU_S08_1' in project 'P_UCCMFTPFABU_S09'
And rename folder '/F_UCCMFTPFABU_S09_1/F_UCCMFTPFABU_S08_1' to 'F_UCCMFTPFABU_S08_1_Renamed' in 'P_UCCMFTPFABU_S09' project
And select folder '/F_UCCMFTPFABU_S09_1/F_UCCMFTPFABU_S08_1_Renamed' in project 'P_UCCMFTPFABU_S09'
Then 'should' see '/F_UCCMFTPFABU_S09_1/F_UCCMFTPFABU_S08_1_Renamed' folder in 'P_UCCMFTPFABU_S09' project