!--NGN-12868
Feature:          User can copy_move folders within Business Unit no metadata update
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user can copy_move folders within Business Unit no metadata update


Scenario: Check that  permissions are NOT copied together with Folders. So same users who had access to these folders in Source Project, will NOT continue to have access in Target Project
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFWBUNMU_1' with default attributes
And created the agency 'A_UCCMFWBUNMU_2' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFWBUNMU_S01_1 | agency.admin | A_UCCMFWBUNMU_1 |
| E_UCCMFWBUNMU_S01_2 | agency.admin | A_UCCMFWBUNMU_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UCCMFWBUNMU_2' to agency 'A_UCCMFWBUNMU_1' on partners page
And logged in with details of 'E_UCCMFWBUNMU_S01_1'
And created 'P_UCCMFWBUNMU_S01_1' project
And created '/F_UCCMFWBUNMU_S01_1' folder for project 'P_UCCMFWBUNMU_S01_1'
And created 'P_UCCMFWBUNMU_S01_2' project
And created '/F_UCCMFWBUNMU_S01_2' folder for project 'P_UCCMFWBUNMU_S01_2'
And uploaded '/files/128_shortname.jpg' file into '/F_UCCMFWBUNMU_S01_1' folder for 'P_UCCMFWBUNMU_S01_1' project
And waited while transcoding is finished in folder '/F_UCCMFWBUNMU_S01_1' on project 'P_UCCMFWBUNMU_S01_1' files page
And added users 'E_UCCMFWBUNMU_S01_2' to project 'P_UCCMFWBUNMU_S01_1' team folders '/F_UCCMFWBUNMU_S01_1' with role 'project.contributor' expired '12.12.2020'
And moved folder '/F_UCCMFWBUNMU_S01_1' from project 'P_UCCMFWBUNMU_S01_1' into folder '/F_UCCMFWBUNMU_S01_2' in project 'P_UCCMFWBUNMU_S01_2' with 'update' metadata
When I login with details of 'E_UCCMFWBUNMU_S01_2'
And wait for '3' seconds
And go to project list page
Then '1' projects in project list


Scenario: Check that folder could be copied with childs (5 levels,check that all child are available after copy)
Meta:@projects
     @gdam
Given I created the agency 'A_UCCMFWBUNMU_1' with default attributes
And created the agency 'A_UCCMFWBUNMU_2' with default attributes
And created users with following fields:
| Email               | Role         | Agency          |
| E_UCCMFWBUNMU_S02_1 | agency.admin | A_UCCMFWBUNMU_1 |
| E_UCCMFWBUNMU_S02_2 | agency.admin | A_UCCMFWBUNMU_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UCCMFWBUNMU_2' to agency 'A_UCCMFWBUNMU_1' on partners page
When I login with details of 'E_UCCMFWBUNMU_S02_1'
And create 'P_UCCMFWBUNMU_S02_1' project
And create '/F_UCCMFWBUNMU_S02_1/F_UCCMFWBUNMU_S02_2/F_UCCMFWBUNMU_S02_3/F_UCCMFWBUNMU_S02_4/F_UCCMFWBUNMU_S02_5' folder for project 'P_UCCMFWBUNMU_S02_1'
And edit the following fields for 'P_UCCMFWBUNMU_S02_1' project:
| Name                | Administrators      |
| P_UCCMFWBUNMU_S02_1 | E_UCCMFWBUNMU_S02_2 |
And click Save button on project popup
And wait for '1' seconds
When I login with details of 'E_UCCMFWBUNMU_S02_2'
And create 'P_UCCMFWBUNMU_S02_2' project
And copy folder 'F_UCCMFWBUNMU_S02_1' from project 'P_UCCMFWBUNMU_S02_1' into project 'P_UCCMFWBUNMU_S02_2' in root
And wait for '3' seconds
And go to project 'P_UCCMFWBUNMU_S02_2' files page
And refresh the page
Then I should see following folders in 'P_UCCMFWBUNMU_S02_2' project:
| folder                                                                                               |
| /F_UCCMFWBUNMU_S02_1/F_UCCMFWBUNMU_S02_2/F_UCCMFWBUNMU_S02_3/F_UCCMFWBUNMU_S02_4/F_UCCMFWBUNMU_S02_5 |