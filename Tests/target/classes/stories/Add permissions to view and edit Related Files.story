!--NGN-11101
Feature:          Add permissions to view, edit Related Files
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that Add permissions to view, edit Related Files


Scenario: Check that share user from current BU could/could not add related file (depends on element.related_files.create)
Meta:@gdam
     @projects
Given created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission     |
| element.create |
And created users with following fields:
| Email  | Role        |
| <User> | agency.user |
And update role '<ProjectRole>' role by following '<Permission>' permissions for advertiser 'DefaultAgency'
And created '<Project>' project
And created '/folder' folder for project '<Project>'
And uploaded '/files/Fish1-Ad.mov' file into '/folder' folder for '<Project>' project
And shared each folder from project '<Project>' to user '<User>' with role '<ProjectRole>' expired date '12.12.2020'
When I login with details of '<User>'
And go to project '<Project>' folder '/folder' page
And go to file 'Fish1-Ad.mov' in '/folder' in project '<Project>' on related files page
Then I '<ShouldState>' see LinkToExisting button on related files page

Examples:
| ShouldState | Permission                                                                                    | ProjectRole      | User            | Project         |
| should      | element.read,element.related_files.create,element.related_files.read,folder.read,project.read | PR_APTVERF_S01_1 | U_APTVERF_S01_1 | P_APTVERF_S01_1 |
| should not  | element.read,element.related_files.read,folder.read,project.read                              | PR_APTVERF_S01_2 | U_APTVERF_S01_2 | P_APTVERF_S01_2 |


Scenario: Check that share user from another BU could/could not add related file (depends on element.related_files.create)
Meta:@gdam
     @projects
Given created the agency 'A_APTVERF_S01_1' with default attributes
And created the agency 'A_APTVERF_S02_1' with default attributes
And created '<Roles>' role in 'project' group for advertiser 'A_APTVERF_S01_1' with following permissions:
| Permission     |
| element.create |
And created users with following fields:
| Email            | Role         | Agency          |
| <AdminEmails>    | agency.admin | A_APTVERF_S01_1 |
| AU_APTVERF_S02_1 | agency.admin | A_APTVERF_S02_1 |
| <UserEmails>     | agency.user  | A_APTVERF_S02_1 |
And update role '<Roles>' role by following '<Permissions>' permissions for advertiser 'A_APTVERF_S01_1'
And logged in with details of '<AdminEmails>'
And created '<Projects>' project
And created '/folder' folder for project '<Projects>'
And uploaded '/files/Fish1-Ad.mov' file into '/folder' folder for '<Projects>' project
And shared each folder from project '<Projects>' to user '<UserEmails>' with role '<Roles>' expired date '12.12.2020'
When I login with details of '<UserEmails>'
And go to project '<Projects>' folder '/folder' page
And go to file 'Fish1-Ad.mov' in '/folder' in project '<Projects>' on related files page
Then I '<ShouldState>' see LinkToExisting button on related files page

Examples:
| Permissions                                                                                   | Roles            | Projects        | AdminEmails      | UserEmails      | ShouldState  |
| element.read,element.related_files.create,element.related_files.read,folder.read,project.read | PR_APTVERF_S02_1 | P_APTVERF_S02_1 | AU_APTVERF_S02_1 | U_APTVERF_S02_1 | should       |
| element.read,element.related_files.read,folder.read,project.read                              | PR_APTVERF_S02_2 | P_APTVERF_S02_2 | AU_APTVERF_S02_2 | U_APTVERF_S02_2 | should state |


Scenario: Check that share user from current could/could not view related file of owner (depends on element.related_files.read)
Meta:@gdam
     @projects
Given created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission     |
| element.create |
And created users with following fields:
| Email  | Role        |
| <User> | agency.user |
And update role '<ProjectRole>' role by following '<Permission>' permissions for advertiser 'DefaultAgency'
And created '<Project>' project
And created '/folder' folder for project '<Project>'
And uploaded '/files/Fish1-Ad.mov' file into '/folder' folder for '<Project>' project
And shared each folder from project '<Project>' to user '<User>' with role '<ProjectRole>' expired date '12.12.2020'
When I login with details of '<User>'
And go to project '<Project>' folder '/folder' page
And go to file '/files/Fish1-Ad.mov' info page in folder '/folder' project '<Project>'
Then I '<ShouldState>' see 'Related Files' tab on file info page

Examples:
| ShouldState | Permission                                                       | ProjectRole      | User            | Project         |
| should      | element.read,element.related_files.read,folder.read,project.read | PR_APTVERF_S03_1 | U_APTVERF_S03_1 | P_APTVERF_S03_1 |
| should not  | element.read,folder.read,project.read                            | PR_APTVERF_S03_2 | U_APTVERF_S03_2 | P_APTVERF_S03_2 |


Scenario: Check that share user from another BU could/could not view related file of owner (depends on element.related_files.read)
Meta:@gdam
     @projects
Given created the agency 'A_APTVERF_S01_1' with default attributes
And created the agency 'A_APTVERF_S02_1' with default attributes
And created '<Roles>' role in 'project' group for advertiser 'A_APTVERF_S01_1' with following permissions:
| Permission     |
| element.create |
And created users with following fields:
| Email            | Role         | Agency          |
| <AdminEmails>    | agency.admin | A_APTVERF_S01_1 |
| AU_APTVERF_S04_1 | agency.admin | A_APTVERF_S02_1 |
| <UserEmails>     | agency.user  | A_APTVERF_S02_1 |
And update role '<Roles>' role by following '<Permissions>' permissions for advertiser 'A_APTVERF_S01_1'
And logged in with details of '<AdminEmails>'
And created '<Projects>' project
And created '/folder' folder for project '<Projects>'
And uploaded '/files/Fish1-Ad.mov' file into '/folder' folder for '<Projects>' project
And shared each folder from project '<Projects>' to user '<UserEmails>' with role '<Roles>' expired date '12.12.2020'
When I login with details of '<UserEmails>'
And go to project '<Projects>' folder '/folder' page
And go to file '/files/Fish1-Ad.mov' info page in folder '/folder' project '<Projects>'
Then I '<ShouldState>' see 'Related Files' tab on file info page

Examples:
| Permissions                                                      | Roles            | Projects        | AdminEmails      | UserEmails      | ShouldState |
| element.read,element.related_files.read,folder.read,project.read | PR_APTVERF_S04_1 | P_APTVERF_S04_1 | AU_APTVERF_S04_1 | U_APTVERF_S04_1 | should      |
| element.read,folder.read,project.read                            | PR_APTVERF_S04_2 | P_APTVERF_S04_2 | AU_APTVERF_S04_2 | U_APTVERF_S04_2 | should not  |


Scenario: Check that share user from current BU could/could not remove related file (depends on element.related_files.delete)
Meta:@gdam
     @projects
Given created the agency 'A_APTVERF_S01_1' with default attributes
And created '<Roles>' role in 'project' group for advertiser 'A_APTVERF_S01_1' with following permissions:
| Permission     |
| element.create |
And created users with following fields:
| Email            | Role         | Agency          |
| <AdminEmails>    | agency.admin | A_APTVERF_S01_1 |
| <UserEmails>     | agency.user  | A_APTVERF_S01_1 |
And update role '<Roles>' role by following '<Permissions>' permissions for advertiser 'A_APTVERF_S01_1'
And logged in with details of '<AdminEmails>'
And created '<Projects>' project
And created '/folder1' folder for project '<Projects>'
And uploaded into project '<Projects>' following files:
| FileName          | Path     |
| /images/logo.gif  | /folder1 |
| /images/logo.jpg  | /folder1 |
And I am on project '<Projects>' folder '/folder1' page
And opened file 'logo.gif' in '/folder1' in project '<Projects>' on related files page
And typed related file 'logo.jpg' on related files page on pop-up
And selected and save following related files 'logo.jpg' on related file pop-up
And shared each folder from project '<Projects>' to user '<UserEmails>' with role '<Roles>' expired date '12.12.2020'
When I login with details of '<UserEmails>'
And go to project '<Projects>' folder '/folder1' page
And go to file 'logo.gif' in '/folder1' in project '<Projects>' on related files page
Then I '<ShouldState>' see remove button of following related files 'logo.jpg'

Examples:
| Permissions                                                                                   | Roles            | Projects        | AdminEmails      | UserEmails      | ShouldState  |
| element.read,element.related_files.read,element.related_files.delete,folder.read,project.read | PR_APTVERF_S05_1 | P_APTVERF_S05_1 | AU_APTVERF_S05_1 | U_APTVERF_S05_1 | should       |
| element.read,folder.read,project.read,element.related_files.read                              | PR_APTVERF_S05_2 | P_APTVERF_S05_2 | AU_APTVERF_S05_2 | U_APTVERF_S05_2 | should not   |


Scenario: Check that share user from another BU could/could not remove related file (depends on element.related_files.delete)
Meta:@gdam
     @projects
Given created the agency 'A_APTVERF_S01_1' with default attributes
And created the agency 'A_APTVERF_S02_1' with default attributes
And created '<Roles>' role in 'project' group for advertiser 'A_APTVERF_S01_1' with following permissions:
| Permission     |
| element.create |
And created users with following fields:
| Email            | Role         | Agency          |
| <AdminEmails>    | agency.admin | A_APTVERF_S01_1 |
| AU_APTVERF_S06_1 | agency.admin | A_APTVERF_S02_1 |
| <UserEmails>     | agency.user  | A_APTVERF_S02_1 |
And update role '<Roles>' role by following '<Permissions>' permissions for advertiser 'A_APTVERF_S01_1'
And logged in with details of '<AdminEmails>'
And created '<Projects>' project
And created '/folder' folder for project '<Projects>'
And created '/folder1' folder for project '<Projects>'
And uploaded '/files/Fish1-Ad.mov' file into '/folder' folder for '<Projects>' project
And uploaded '/files/Fish2-Ad.mov' file into '/folder1' folder for '<Projects>' project
And opened file 'Fish1-Ad.mov' in '/folder' in project '<Projects>' on related files page
And typed related file 'Fish2-Ad.mov' on related files page on pop-up
And selected and save following related files 'Fish2-Ad.mov' on related file pop-up
And shared each folder from project '<Projects>' to user '<UserEmails>' with role '<Roles>' expired date '12.12.2020'
When I login with details of '<UserEmails>'
And go to project '<Projects>' folder '/folder' page
And go to file 'Fish1-Ad.mov' in '/folder' in project '<Projects>' on related files page
Then I '<ShouldState>' see remove button of following related files 'Fish2-Ad.mov'

Examples:
| Permissions                                                                                   | Roles            | Projects        | AdminEmails      | UserEmails      | ShouldState |
| element.read,element.related_files.read,folder.read,project.read,element.related_files.delete | PR_APTVERF_S06_1 | P_APTVERF_S06_1 | AU_APTVERF_S06_1 | U_APTVERF_S06_1 | should      |
| element.read,folder.read,project.read,element.related_files.read                              | PR_APTVERF_S06_2 | P_APTVERF_S06_2 | AU_APTVERF_S06_2 | U_APTVERF_S06_2 | should not  |


Scenario: Check that share user couldn't view related file in case when related file available in folder without permisssion element.related_files.read
Meta:@gdam
     @projects
Given I created the agency 'A_UCMDRFFF_1' with default attributes
And created 'R_UCMDRFFF_1_without_delete' role in 'project' group for advertiser 'A_UCMDRFFF_1' with following permissions:
| Permission                 |
| adkit.read                 |
| adkit_template.read        |
| attached_file.create       |
| attached_file.delete       |
| attached_file.read         |
| comment.create             |
| comment.read               |
| element.create             |
| element.read               |
| element.usage_rights.read  |
| file.download              |
| folder.create              |
| folder.read                |
| project.read               |
| project_template.read      |
And created 'R_UCMDRFFF_2_with_delete' role in 'project' group for advertiser 'A_UCMDRFFF_1' with following permissions:
| Permission                   |
| adkit.read                   |
| adkit_template.read          |
| attached_file.create         |
| attached_file.delete         |
| attached_file.read           |
| comment.create               |
| comment.read                 |
| element.create               |
| element.read                 |
| element.related_files.read   |
| element.related_files.delete |
| element.usage_rights.read    |
| file.download                |
| folder.create                |
| folder.read                  |
| project.read                 |
| project_template.read        |
And created users with following fields:
| Email            | Role         | AgencyUnique |
| U_UCMDRFFF_S07_1 | agency.admin | A_UCMDRFFF_1 |
| U_UCMDRFFF_S07_2 | agency.user  | A_UCMDRFFF_1 |
And logged in with details of 'U_UCMDRFFF_S07_1'
And created 'P_UCMDRFFF_7' project
And created '/folder7_1' folder for project 'P_UCMDRFFF_7'
And uploaded into project 'P_UCMDRFFF_7' following files:
| FileName          | Path       |
| /images/logo.gif  | /folder7_1 |
And waited while transcoding is finished in folder '/folder7_1' on project 'P_UCMDRFFF_7' files page
And created 'P_UCMDRFFF_7' project
And created '/folder7_2' folder for project 'P_UCMDRFFF_7'
And uploaded into project 'P_UCMDRFFF_7' following files:
| FileName          | Path       |
| /images/logo.jpg  | /folder7_2 |
And waited while transcoding is finished in folder '/folder7_2' on project 'P_UCMDRFFF_7' files page
And opened file 'logo.jpg' in '/folder7_2' in project 'P_UCMDRFFF_7' on related files page
And typed related file 'logo.gif' on related files page on pop-up
And selected and save following related files 'logo.gif' on related file pop-up
When I add users 'U_UCMDRFFF_S07_1' to project 'P_UCMDRFFF_7' team folders '/folder7_1' with role 'R_UCMDRFFF_1_without_delete' expired '10.10.2020'
And add users 'U_UCMDRFFF_S07_2' to project 'P_UCMDRFFF_7' team folders '/folder7_2' with role 'R_UCMDRFFF_2_with_delete' expired '10.10.2020'
And login with details of 'U_UCMDRFFF_S07_2'
And go to project 'P_UCMDRFFF_7' folder '/folder7_2' page
And go to file 'logo.jpg' in '/folder7_2' in project 'P_UCMDRFFF_7' on related files page
Then I 'should not' see following files 'logo.gif' on related files page