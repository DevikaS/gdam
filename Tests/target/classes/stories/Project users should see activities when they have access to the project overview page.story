Feature:             Project users should see activities when they have access to the project overview page
Narrative:
In order to
As a                 AgencyAdmin
I want to            Check that project users should see activities when they have access to the project overview page

Scenario: Check that agency admin should see all project activities even if he is not project admin
Meta:@gdam
@projects
Given I created users with following fields:
| Email                | Role         |
| E_PASSAWTHATTPOP_S01 | agency.admin |
| E_PASSAWTHATTPOP_S02 | agency.admin |
And created 'P_PASSAWTHATTPOP_S01' project
And created '/F_PASSAWTHATTPOP_S01' folder for project 'P_PASSAWTHATTPOP_S01'
When I upload '/files/120.600.gif' file into '/F_PASSAWTHATTPOP_S01' folder for 'P_PASSAWTHATTPOP_S01' project
And wait while transcoding is finished in folder '/F_PASSAWTHATTPOP_S01' on project 'P_PASSAWTHATTPOP_S01' files page
And go to project 'P_PASSAWTHATTPOP_S01' teams page
And add user 'E_PASSAWTHATTPOP_S02' into project 'P_PASSAWTHATTPOP_S01' team with role 'Project User' expired '12.12.2022' for folder on popup '/F_PASSAWTHATTPOP_S01'
And login with details of 'E_PASSAWTHATTPOP_S01'
And go to project 'P_PASSAWTHATTPOP_S01' overview page
Then I 'should' see activity where user 'AgencyAdmin' create project 'P_PASSAWTHATTPOP_S01' on Project Overview page
And 'should' see activity where user 'AgencyAdmin' create folder 'F_PASSAWTHATTPOP_S01' on Project Overview page
And 'should' see activity where user 'AgencyAdmin' shared folder 'F_PASSAWTHATTPOP_S01' to user 'E_PASSAWTHATTPOP_S02' on Project Overview page


Scenario: Check that project user should see activities only from his folders on overview page
Meta:@gdam
@projects
Given created the agency 'A_PUSSAWTHATTPOP_S01' with default attributes
And created 'project_user' role in 'project' group for advertiser 'A_PUSSAWTHATTPOP_S01' with following permissions:
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
| project.settings.read      |
| project_template.read      |
And created users with following fields:
| Email                  | Role         | Agency               |
| E_PASSAWTHATTPOP_S02_1 | agency.admin | A_PUSSAWTHATTPOP_S01 |
| E_PASSAWTHATTPOP_S02_2 | agency.user  | A_PUSSAWTHATTPOP_S01 |
And logged in with details of 'E_PASSAWTHATTPOP_S02_1'
And created 'P_PASSAWTHATTPOP_S02' project
And created '/F_PASSAWTHATTPOP_S02' folder for project 'P_PASSAWTHATTPOP_S02'
When I go to project 'P_PASSAWTHATTPOP_S02' teams page
And refresh the page
And add user 'E_PASSAWTHATTPOP_S02_2' into project 'P_PASSAWTHATTPOP_S02' team with role 'project_user' expired '12.12.2022' for folder on popup '/F_PASSAWTHATTPOP_S02'
And login with details of 'E_PASSAWTHATTPOP_S02_2'
And go to project 'P_PASSAWTHATTPOP_S02' overview page
Then I 'should not' see activity where user 'E_PASSAWTHATTPOP_S02_1' create project 'P_PASSAWTHATTPOP_S02' on Project Overview page
When I create 'P_PASSAWTHATTPOP_S03' project
When I create following projects:
| Name                 | Business Unit         |
| P_PASSAWTHATTPOP_S03 | A_PUSSAWTHATTPOP_S01  |
And wait for '3' seconds
And go to project 'P_PASSAWTHATTPOP_S03' overview page
And refresh the page
Then I 'should' see activity where user 'E_PASSAWTHATTPOP_S02_2' create project 'P_PASSAWTHATTPOP_S03' on Project Overview page





Scenario: Check that once folder has been shared to user - user sees all history of activity in that folder
Meta: @skip
      @gdam
!--05/10-confirmed with Maris as invalid -"this is old scenario. after activity refactoring, user is only able to see activities that happened after they joined the project"
Given created the agency 'A_PUSSAWTHATTPOP_S01' with default attributes
And created 'project_user' role in 'project' group for advertiser 'A_PUSSAWTHATTPOP_S01' with following permissions:
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
| project.settings.read      |
| project_template.read      |
| activity.read              |
And created users with following fields:
| Email                  | Role         | Agency               |
| E_PASSAWTHATTPOP_S03_1 | agency.admin | A_PUSSAWTHATTPOP_S01 |
| E_PASSAWTHATTPOP_S03_2 | agency.user  | A_PUSSAWTHATTPOP_S01 |
And logged in with details of 'E_PASSAWTHATTPOP_S03_1'
And created 'P_PASSAWTHATTPOP_S03' project
And created '/F_PASSAWTHATTPOP_S03' folder for project 'P_PASSAWTHATTPOP_S03'
When I go to project 'P_PASSAWTHATTPOP_S03' teams page
And refresh the page
And add user 'E_PASSAWTHATTPOP_S03_2' into project 'P_PASSAWTHATTPOP_S03' team with role 'project_user' expired '12.12.2022' for folder '/F_PASSAWTHATTPOP_S03'
And login with details of 'E_PASSAWTHATTPOP_S03_2'
And go to project 'P_PASSAWTHATTPOP_S03' overview page
Then 'should' see activity where user 'E_PASSAWTHATTPOP_S03_1' create folder 'F_PASSAWTHATTPOP_S03' on Project Overview page
And 'should' see activity where user 'E_PASSAWTHATTPOP_S02_2' create project 'P_PASSAWTHATTPOP_S03' on Project Overview page