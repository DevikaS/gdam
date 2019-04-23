!-- NGN-10993
Feature:          Related file could be removed by project owner
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that related file could be removed by project owner


Scenario: Check that related file could be removed by project owner
Meta:@gdam
@projects
Given I created the agency 'A_UCMDRFFF_1' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique |
| U_UCMDRFFF_S01 | agency.admin | A_UCMDRFFF_1 |
And logged in with details of 'U_UCMDRFFF_S01'
And created 'P_UCMDRFFF_1' project
And created '/folder' folder for project 'P_UCMDRFFF_1'
And uploaded into project 'P_UCMDRFFF_1' following files:
| FileName          | Path    |
| /images/logo.gif  | /folder |
| /images/logo.jpg  | /folder |
| /images/logo.jpeg | /folder |
And waited while transcoding is finished in folder '/folder' on project 'P_UCMDRFFF_1' files page
And opened file 'logo.gif' in '/folder' in project 'P_UCMDRFFF_1' on related files page
And typed related file 'logo*' on related files page on pop-up
And selected and save following related files 'logo.jpg,logo.jpeg' on related file pop-up
When I delete following files 'logo.jpeg' on related files page
Then I should see following count '1' of related files


Scenario: Check that after remove related file,relations will be removed from both sides
Meta:@gdam
@projects
Given I created the agency 'A_UCMDRFFF_1' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique |
| U_UCMDRFFF_S02 | agency.admin | A_UCMDRFFF_1 |
And logged in with details of 'U_UCMDRFFF_S02'
And created 'P_UCMDRFFF_2' project
And created '/folder' folder for project 'P_UCMDRFFF_2'
And uploaded into project 'P_UCMDRFFF_2' following files:
| FileName          | Path    |
| /images/logo.gif  | /folder |
| /images/logo.jpg  | /folder |
And waited while transcoding is finished in folder '/folder' on project 'P_UCMDRFFF_2' files page
And opened file 'logo.gif' in '/folder' in project 'P_UCMDRFFF_2' on related files page
And typed related file 'logo*' on related files page on pop-up
And selected and save following related files 'logo.jpg' on related file pop-up
When delete following files 'logo.jpg' on related files page
Then I 'should not' see following files 'logo.jpg' on related files page
When go to file 'logo.jpg' in '/folder' in project 'P_UCMDRFFF_2' on related files page
Then I 'should not' see following files 'logo.gif' on related files page


Scenario: Check that related file couldn't be removed by share user (folder shared with 'element.related.files.read', but without folder shared with element.related.files.delete)
Meta:@gdam
@projects
Given I created the agency 'A_UCMDRFFF_1' with default attributes
And created 'R_UCMDRFFF_1' role in 'project' group for advertiser 'A_UCMDRFFF_1' with following permissions:
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
| element.related_files.read |
| element.usage_rights.read  |
| file.download              |
| folder.create              |
| folder.read                |
| project.read               |
| project_template.read      |
And created users with following fields:
| Email            | Role         | AgencyUnique |
| U_UCMDRFFF_S03_1 | agency.admin | A_UCMDRFFF_1 |
| U_UCMDRFFF_S03_2 | agency.user  | A_UCMDRFFF_1 |
And logged in with details of 'U_UCMDRFFF_S03_1'
And created 'P_UCMDRFFF_3' project
And created '/folder' folder for project 'P_UCMDRFFF_3'
And uploaded into project 'P_UCMDRFFF_3' following files:
| FileName          | Path    |
| /images/logo.gif  | /folder |
| /images/logo.jpg  | /folder |
And waited while transcoding is finished in folder '/folder' on project 'P_UCMDRFFF_3' files page
And opened file 'logo.gif' in '/folder' in project 'P_UCMDRFFF_3' on related files page
And typed related file 'logo.jpg' on related files page on pop-up
And selected and save following related files 'logo.jpg' on related file pop-up
When I share each folder from project 'P_UCMDRFFF_3' to user 'U_UCMDRFFF_S03_2' with role 'R_UCMDRFFF_1' expired date '12.12.2020'
And login with details of 'U_UCMDRFFF_S03_2'
And go to file 'logo.gif' in '/folder' in project 'P_UCMDRFFF_3' on related files page
Then I 'should not' see remove button of following related files 'logo.jpg'


Scenario: Check that related file couldn't be removed by share user (folder shared with 'element.related.files.read', but without folder shared with element.related.files.delete)
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
| element.related_files.read |
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
| U_UCMDRFFF_S04_1 | agency.admin | A_UCMDRFFF_1 |
| U_UCMDRFFF_S04_2 | agency.user  | A_UCMDRFFF_1 |
And logged in with details of 'U_UCMDRFFF_S04_1'
And created 'P_UCMDRFFF_4' project
And created '/folder1' folder for project 'P_UCMDRFFF_4'
And uploaded into project 'P_UCMDRFFF_4' following files:
| FileName          | Path     |
| /images/logo.gif  | /folder1 |
And waited while transcoding is finished in folder '/folder1' on project 'P_UCMDRFFF_4' files page
And created 'P_UCMDRFFF_4' project
And created '/folder2' folder for project 'P_UCMDRFFF_4'
And uploaded into project 'P_UCMDRFFF_4' following files:
| FileName          | Path     |
| /images/logo.jpg  | /folder2 |
And waited while transcoding is finished in folder '/folder2' on project 'P_UCMDRFFF_4' files page
And opened file 'logo.jpg' in '/folder2' in project 'P_UCMDRFFF_4' on related files page
And typed related file 'logo.gif' on related files page on pop-up
And selected and save following related files 'logo.gif' on related file pop-up
When I add users 'U_UCMDRFFF_S04_2' to project 'P_UCMDRFFF_4' team folders '/folder1' with role 'R_UCMDRFFF_1_without_delete' expired '10.10.2020'
And add users 'U_UCMDRFFF_S04_2' to project 'P_UCMDRFFF_4' team folders '/folder2' with role 'R_UCMDRFFF_2_with_delete' expired '10.10.2020'
And login with details of 'U_UCMDRFFF_S04_2'
And go to file 'logo.jpg' in '/folder2' in project 'P_UCMDRFFF_4' on related files page
Then I 'should not' see remove button of following related files 'logo.gif'