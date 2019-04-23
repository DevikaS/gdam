!--NGN-11618
Feature:          As Project Admin I should see project activities of all Project Team Users or specific User within a Project
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that As Project Admin I should see project activities of all Project Team Users or specific User within a Project


Scenario: Check that activity of all user is displayed on project team tab
Meta:@projects
     @gdam
Given I created the agency 'APAISSPAOAPTUOSUWP_1' with default attributes
And created users with following fields:
| Email                      | Role         | Agency               |
| E_APAISSPAOAPTUOSUWP_S01_1 | agency.admin | APAISSPAOAPTUOSUWP_1 |
| E_APAISSPAOAPTUOSUWP_S01_2 | agency.admin | APAISSPAOAPTUOSUWP_1 |
And logged in with details of 'E_APAISSPAOAPTUOSUWP_S01_1'
And created 'P_APAISSPAOAPTUOSUWP_S01' project
And created '/F_APAISSPAOAPTUOSUWP_S01' folder for project 'P_APAISSPAOAPTUOSUWP_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S01' folder for 'P_APAISSPAOAPTUOSUWP_S01' project
And waited while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S01' on project 'P_APAISSPAOAPTUOSUWP_S01' files page
And added users 'E_APAISSPAOAPTUOSUWP_S01_2' to project 'P_APAISSPAOAPTUOSUWP_S01' team folders '/F_APAISSPAOAPTUOSUWP_S01' with role 'project.user' expired '12.12.2020'
When I login with details of 'E_APAISSPAOAPTUOSUWP_S01_2'
And upload '/files/Fish1-Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S01' folder for 'P_APAISSPAOAPTUOSUWP_S01' project
And wait while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S01' on project 'P_APAISSPAOAPTUOSUWP_S01' files page
And go to project 'P_APAISSPAOAPTUOSUWP_S01' teams page
Then I 'should' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_2' on project team page with message 'uploaded 1 files Fish1-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S01/P_APAISSPAOAPTUOSUWP_S01/F_APAISSPAOAPTUOSUWP_S01/Fish1-Ad.mov'


Scenario: Check that activity only selected user is displayed (agency user of current BU)
Meta:@projects
     @gdam
Given I created the agency 'APAISSPAOAPTUOSUWP_1' with default attributes
And created users with following fields:
| Email                      | Role         | Agency               |
| E_APAISSPAOAPTUOSUWP_S01_1 | agency.admin | APAISSPAOAPTUOSUWP_1 |
| E_APAISSPAOAPTUOSUWP_S01_2 | agency.admin | APAISSPAOAPTUOSUWP_1 |
And logged in with details of 'E_APAISSPAOAPTUOSUWP_S01_1'
And created 'P_APAISSPAOAPTUOSUWP_S02' project
And created '/F_APAISSPAOAPTUOSUWP_S02' folder for project 'P_APAISSPAOAPTUOSUWP_S02'
And uploaded '/files/Fish2-Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S02' folder for 'P_APAISSPAOAPTUOSUWP_S02' project
And waited while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S02' on project 'P_APAISSPAOAPTUOSUWP_S02' files page
And added users 'E_APAISSPAOAPTUOSUWP_S01_2' to project 'P_APAISSPAOAPTUOSUWP_S02' team folders '/F_APAISSPAOAPTUOSUWP_S02' with role 'project.user' expired '12.12.2020'
When I login with details of 'E_APAISSPAOAPTUOSUWP_S01_2'
And upload '/files/Fish3-Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S02' folder for 'P_APAISSPAOAPTUOSUWP_S02' project
And wait while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S02' on project 'P_APAISSPAOAPTUOSUWP_S02' files page
And open user 'E_APAISSPAOAPTUOSUWP_S01_1' details on project 'P_APAISSPAOAPTUOSUWP_S02' team page
Then I 'should' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_1' on project team page with message 'uploaded 1 files Fish2-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S02/P_APAISSPAOAPTUOSUWP_S02/F_APAISSPAOAPTUOSUWP_S02/Fish2-Ad.mov'
And 'should not' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_2' on project team page with message 'uploaded 1 files Fish3-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S02/P_APAISSPAOAPTUOSUWP_S02/F_APAISSPAOAPTUOSUWP_S02/Fish3-Ad.mov'


Scenario: Check that activity only selected user is displayed (agency user of another BU)
Meta:@projects
      @gdam
Given I created the agency 'APAISSPAOAPTUOSUWP_1' with default attributes
Given I created the agency 'APAISSPAOAPTUOSUWP_2' with default attributes
And created users with following fields:
| Email                      | Role         | Agency               |
| E_APAISSPAOAPTUOSUWP_S01_1 | agency.admin | APAISSPAOAPTUOSUWP_1 |
| E_APAISSPAOAPTUOSUWP_S01_2 | agency.admin | APAISSPAOAPTUOSUWP_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'APAISSPAOAPTUOSUWP_2' to agency 'APAISSPAOAPTUOSUWP_1' on partners page
And logged in with details of 'E_APAISSPAOAPTUOSUWP_S01_1'
And created 'P_APAISSPAOAPTUOSUWP_S03' project
And created '/F_APAISSPAOAPTUOSUWP_S01' folder for project 'P_APAISSPAOAPTUOSUWP_S03'
And uploaded '/files/Fish4-Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S01' folder for 'P_APAISSPAOAPTUOSUWP_S03' project
And waited while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S01' on project 'P_APAISSPAOAPTUOSUWP_S03' files page
And added users 'E_APAISSPAOAPTUOSUWP_S01_2' to project 'P_APAISSPAOAPTUOSUWP_S03' team folders '/F_APAISSPAOAPTUOSUWP_S01' with role 'project.user' expired '12.12.2020'
When I login with details of 'E_APAISSPAOAPTUOSUWP_S01_2'
And upload '/files/Fish5-Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S01' folder for 'P_APAISSPAOAPTUOSUWP_S03' project
And wait while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S01' on project 'P_APAISSPAOAPTUOSUWP_S03' files page
And login with details of 'E_APAISSPAOAPTUOSUWP_S01_1'
And open user 'E_APAISSPAOAPTUOSUWP_S01_1' details on project 'P_APAISSPAOAPTUOSUWP_S03' team page
Then I 'should' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_1' on project team page with message 'uploaded 1 files Fish4-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S03/P_APAISSPAOAPTUOSUWP_S03/F_APAISSPAOAPTUOSUWP_S01/Fish4-Ad.mov'
And 'should not' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_2' on project team page with message 'uploaded 1 files Fish5-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S03/P_APAISSPAOAPTUOSUWP_S03/F_APAISSPAOAPTUOSUWP_S01/Fish5-Ad.mov'

Scenario: Check that activity of all users displayed upon refresh after selecting user (agency user of another BU)
Meta:@projects
      @gdam
Given I created the agency 'APAISSPAOAPTUOSUWP_1' with default attributes
Given I created the agency 'APAISSPAOAPTUOSUWP_2' with default attributes
And created users with following fields:
| Email                      | Role         | Agency               |
| E_APAISSPAOAPTUOSUWP_S01_1 | agency.admin | APAISSPAOAPTUOSUWP_1 |
| E_APAISSPAOAPTUOSUWP_S01_2 | agency.admin | APAISSPAOAPTUOSUWP_2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'APAISSPAOAPTUOSUWP_2' to agency 'APAISSPAOAPTUOSUWP_1' on partners page
And logged in with details of 'E_APAISSPAOAPTUOSUWP_S01_1'
And created 'P_APAISSPAOAPTUOSUWP_S03' project
And created '/F_APAISSPAOAPTUOSUWP_S01' folder for project 'P_APAISSPAOAPTUOSUWP_S03'
And uploaded '/files/Fish4-Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S01' folder for 'P_APAISSPAOAPTUOSUWP_S03' project
And waited while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S01' on project 'P_APAISSPAOAPTUOSUWP_S03' files page
And added users 'E_APAISSPAOAPTUOSUWP_S01_2' to project 'P_APAISSPAOAPTUOSUWP_S03' team folders '/F_APAISSPAOAPTUOSUWP_S01' with role 'project.user' expired '12.12.2020'
When I login with details of 'E_APAISSPAOAPTUOSUWP_S01_2'
And upload '/files/Fish5-Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S01' folder for 'P_APAISSPAOAPTUOSUWP_S03' project
And wait while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S01' on project 'P_APAISSPAOAPTUOSUWP_S03' files page
And login with details of 'E_APAISSPAOAPTUOSUWP_S01_1'
And open user 'E_APAISSPAOAPTUOSUWP_S01_1' details on project 'P_APAISSPAOAPTUOSUWP_S03' team page
Then I 'should' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_1' on project team page with message 'uploaded 1 files Fish4-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S03/P_APAISSPAOAPTUOSUWP_S03/F_APAISSPAOAPTUOSUWP_S01/Fish4-Ad.mov'
And 'should not' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_2' on project team page with message 'uploaded 1 files Fish5-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S03/P_APAISSPAOAPTUOSUWP_S03/F_APAISSPAOAPTUOSUWP_S01/Fish5-Ad.mov'
When I refresh the page
Then I 'should' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_1' on project team page with message 'uploaded 1 files Fish4-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S03/P_APAISSPAOAPTUOSUWP_S03/F_APAISSPAOAPTUOSUWP_S01/Fish4-Ad.mov'
And 'should' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_2' on project team page with message 'uploaded 1 files Fish5-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S03/P_APAISSPAOAPTUOSUWP_S03/F_APAISSPAOAPTUOSUWP_S01/Fish5-Ad.mov'


Scenario: Check that activity of all users displayed upon refresh after selecting user (agency user of current BU)
Meta:@projects
     @gdam
Given I created the agency 'APAISSPAOAPTUOSUWP_1' with default attributes
And created users with following fields:
| Email                      | Role         | Agency               |
| E_APAISSPAOAPTUOSUWP_S01_1 | agency.admin | APAISSPAOAPTUOSUWP_1 |
| E_APAISSPAOAPTUOSUWP_S01_2 | agency.admin | APAISSPAOAPTUOSUWP_1 |
And logged in with details of 'E_APAISSPAOAPTUOSUWP_S01_1'
And created 'P_APAISSPAOAPTUOSUWP_S02' project
And created '/F_APAISSPAOAPTUOSUWP_S02' folder for project 'P_APAISSPAOAPTUOSUWP_S02'
And uploaded '/files/Fish2-Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S02' folder for 'P_APAISSPAOAPTUOSUWP_S02' project
And waited while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S02' on project 'P_APAISSPAOAPTUOSUWP_S02' files page
And added users 'E_APAISSPAOAPTUOSUWP_S01_2' to project 'P_APAISSPAOAPTUOSUWP_S02' team folders '/F_APAISSPAOAPTUOSUWP_S02' with role 'project.user' expired '12.12.2020'
When I login with details of 'E_APAISSPAOAPTUOSUWP_S01_2'
And upload '/files/Fish3-Ad.mov' file into '/F_APAISSPAOAPTUOSUWP_S02' folder for 'P_APAISSPAOAPTUOSUWP_S02' project
And wait while transcoding is finished in folder '/F_APAISSPAOAPTUOSUWP_S02' on project 'P_APAISSPAOAPTUOSUWP_S02' files page
And open user 'E_APAISSPAOAPTUOSUWP_S01_1' details on project 'P_APAISSPAOAPTUOSUWP_S02' team page
Then I 'should' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_1' on project team page with message 'uploaded 1 files Fish2-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S02/P_APAISSPAOAPTUOSUWP_S02/F_APAISSPAOAPTUOSUWP_S02/Fish2-Ad.mov'
And 'should not' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_2' on project team page with message 'uploaded 1 files Fish3-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S02/P_APAISSPAOAPTUOSUWP_S02/F_APAISSPAOAPTUOSUWP_S02/Fish3-Ad.mov'
When I refresh the page
Then I 'should' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_1' on project team page with message 'uploaded 1 files Fish2-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S02/P_APAISSPAOAPTUOSUWP_S02/F_APAISSPAOAPTUOSUWP_S02/Fish2-Ad.mov'
And 'should' see activity for user 'E_APAISSPAOAPTUOSUWP_S01_2' on project team page with message 'uploaded 1 files Fish3-Ad.mov' and value 'P_APAISSPAOAPTUOSUWP_S02/P_APAISSPAOAPTUOSUWP_S02/F_APAISSPAOAPTUOSUWP_S02/Fish3-Ad.mov'
