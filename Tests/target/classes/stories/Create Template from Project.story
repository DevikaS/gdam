!--NGN-37
Feature:          Create Template from Project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check creation template from project

Scenario: Check that folder structure and team of template is inhereted from project
Meta:@gdam
	  @projects
Given I created users with following fields:
| Email        | Role         |
| U_CTFP_S01_1 | agency.admin |
| U_CTFP_S01_2 | agency.user  |
| U_CTFP_S01_3 | guest.user   |
And created '<ProjectName>' project
And created in '<ProjectName>' project next folders:
| folder    |
| /F1/F2/F3 |
| /F2/F3    |
| /F3       |
And added users 'U_CTFP_S01_1' to project '<ProjectName>' team folders '/F1' with role 'project.user' expired '12.12.2020'
And added users 'U_CTFP_S01_2' to project '<ProjectName>' team folders '/F2' with role 'project.user' expired '12.12.2020'
And added users 'U_CTFP_S01_3' to project '<ProjectName>' team folders '/F3' with role 'project.user' expired '12.12.2020'
And added users 'U_CTFP_S01_2' to project '<ProjectName>' team folders '/F1/F2' with role 'project.contributor' expired '12.12.2020'
And added users 'U_CTFP_S01_3' to project '<ProjectName>' team folders '/F1/F2/F3' with role 'project.contributor' expired '12.12.2020'
And clicked create template from project for project '<ProjectName>'
When I specify template name '<TemplateName>' on create template page
And '<TeamsCheck>' include 'Teams' for template
And '<FoldersCheck>' include 'Folders' for project
And click on element 'SaveButton'
Then I '<TeamsCondition>' see following users on template '<TemplateName>' team page:
| UserName     |
| U_CTFP_S01_1 |
| U_CTFP_S01_2 |
| U_CTFP_S01_3 |
And '<FoldersCondition>' see following folders in '<TemplateName>' template:
| folder    |
| /F1/F2/F3 |
| /F2/F3    |
| /F3       |

Examples:
| ProjectName  | TemplateName | TeamsCheck | FoldersCheck | TeamsCondition | FoldersCondition |
| P_CTFP_S01_1 | T_CTFP_S01_1 | not check  | not check    | should not     | should not       |
| P_CTFP_S01_2 | T_CTFP_S01_2 | check      | check        | should         | should           |
| P_CTFP_S01_3 | T_CTFP_S01_3 | check      | not check    | should not     | should not       |
| P_CTFP_S01_4 | T_CTFP_S01_4 | not check  | check        | should not     | should           |


Scenario: Check that team settings correctly transferred in case creating a new Template from project including teams and including folders from the template
Meta:@gdam
	  @projects
Given I created users with following fields:
| Email       | Role       |
| U_CTFP_S7_1 | guest.user |
And created 'PR_CTFP_S7_1' role in 'project' group for advertiser 'DefaultAgency'
And I created 'P_CTFP_S7_1' project
And created '/F_CTFP_S7_1' folder for project 'P_CTFP_S7_1'
And added users 'U_CTFP_S7_1' to project 'P_CTFP_S7_1' team folders '/F_CTFP_S7_1' with role 'PR_CTFP_S7_1' expired '12.12.2020'
And clicked create template from project for project 'P_CTFP_S7_1'
And I specifyed template name 'T_CTFP_S7_1' on create template page
And I 'check'-ed include 'Folders' for template
And I 'check'-ed include 'Teams' for template
When I click on element 'SaveButton'
And open user 'U_CTFP_S7_1' permissions on template 'T_CTFP_S7_1' team page
Then I should see following role settings for folders in manage permissions popup of template 'T_CTFP_S7_1' team for user 'U_CTFP_S7_1':
| Folder       | Role         | Expiration |
| /F_CTFP_S7_1 | PR_CTFP_S7_1 | 12.12.2020 |


Scenario: Check that files aren't inherented from project
Meta:@gdam
	  @projects
Given I created 'P_CTFP_S8_1' project
And created in 'P_CTFP_S8_1' project next folders:
| folder                   |
| /F_CTFP_S8_1             |
| /F_CTFP_S8_2/F_CTFP_S8_1 |
And uploaded into project 'P_CTFP_S8_1' following files:
| FileName                | Path                     |
| /files/for_babylon43.7z | /F_CTFP_S8_2/F_CTFP_S8_1 |
And clicked create template from project for project 'P_CTFP_S8_1'
And I 'check'-ed include 'Folders' for template
And I specifyed template name 'T_CTFP_S8_1' on create template page
When I click on element 'SaveButton'
Then I 'should' see following folders in 'T_CTFP_S8_1' template:
| folder                   |
| /F_CTFP_S8_1             |
| /F_CTFP_S8_2/F_CTFP_S8_1 |
And I 'should not' see file 'for_babylon43.7z' on template files page
And I should not see for template 'T_CTFP_S8_1' files in the the following folders:
| folder                   | FileName         |
| /F_CTFP_S8_1             | for_babylon43.7z |
| /F_CTFP_S8_2/F_CTFP_S8_1 | for_babylon43.7z |


Scenario: Check that 'create template from project' is available only for project owners from the same agency
Meta:@gdam
	  @projects
Given I created 'CTFPP13' project
And created '/CTFPF13' folder for project 'CTFPP13'
Then I 'should' see Create template from project link on project 'CTFPP13' overview page


Scenario: Check that 'create template from project' is available only for project owners from the same agency #2
Meta:@gdam
     @bug
     	  @projects
!--FAB-744 (Bug) Only example 2 and 3 will fail
Given I created users with following fields:
| Email     | Role         | Agency        |
| CTFPU14_1 | agency.user  | DefaultAgency |
| CTFPU14_2 | agency.admin | AnotherAgency |
| CTFPU14_3 | agency.user  | AnotherAgency |
| CTFPU14_4 | agency.admin | DefaultAgency |
And added following users to address book:
| UserName  |
| CTFPU14_2 |
| CTFPU14_3 |
And created 'CTFPP14' project
And created '/CTFPF14' folder for project 'CTFPP14'
When I edit the following fields for 'CTFPP14' project:
| Name    | Administrators                |
| CTFPP14 | CTFPU14_1,CTFPU14_2,CTFPU14_3 |
And click on element 'SaveButton'
And wait for '3' seconds
And login with details of '<Email>'
Then I '<ShouldState>' see Create template from project link on project 'CTFPP14' overview page

Examples:
| Email     | ShouldState |
| CTFPU14_1 | should      |
| CTFPU14_2 | should not  |
| CTFPU14_3 | should not  |
| CTFPU14_4 | should not  |


Scenario: Check that 'create template from project' isn't available for users whom project's folder has been shared
Meta:@gdam
	  @projects
Given I created 'CTFPR15' role with 'project.read,project.settings.read,project_template.read,folder.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email     | Role         | Agency        |
| CTFPU15_1 | agency.user  | DefaultAgency |
| CTFPU15_2 | agency.admin | AnotherAgency |
| CTFPU15_3 | agency.user  | AnotherAgency |
| CTFPU15_4 | agency.admin | DefaultAgency |
And added following users to address book:
| UserName  |
| CTFPU15_3 |
| CTFPU15_4 |
And created 'CTFPP15' project
And created '/CTFPF15' folder for project 'CTFPP15'
And fill Share popup by users 'CTFPU15_1,CTFPU15_2,CTFPU15_3,CTFPU15_4' in project 'CTFPP15' folders '/CTFPF15' with role 'CTFPR15' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<Email>'
Then I '<ShouldState>' see Create template from project link on project 'CTFPP15' overview page

Examples:
| Email     | ShouldState |
| CTFPU15_1 | should      |
| CTFPU15_2 | should not  |
| CTFPU15_3 | should not  |
| CTFPU15_4 | should      |