!--NGN-2474
Feature:          Playout action on file activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check playout action on file activity log

Scenario: Check that playout action is displayed on Activity tab within project
Meta: @gdam
      @projects
Given I created 'U_PAA_S01' User
And logged in with details of 'U_PAA_S01'
And the following projects were created:
| Name      | Job Number     | Administrators |
| P_PAA_S01 | J_PAA_S01      | AgencyAdmin    |
And created '/F1' folder for project 'P_PAA_S01'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/F1' folder for 'P_PAA_S01' project
And waited while preview is available in folder '/F1' on project 'P_PAA_S01' files page
And on file '/files/13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'P_PAA_S01'
When I play clip on file '13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'P_PAA_S01'
And wait for '1' seconds
And I login as 'AgencyAdmin'
And go to file '/files/13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'P_PAA_S01'
Then I 'should' see activity for user 'U_PAA_S01' on file '13DV-CAPITAL-10.mpg' activity tab in project 'P_PAA_S01' folder '/F1' page with message 'played file' and value ''


Scenario: Check that playout action is displayed on Activity tab within template
Meta: @gdam
      @projects
Given I created 'U_PAA_S02' User
And I logged in with details of 'U_PAA_S02'
And the following templates were created:
| Name      | Administrators |
| T_PAA_S02 | AgencyAdmin    |
And created '/F1' folder for template 'T_PAA_S02'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/F1' folder for 'T_PAA_S02' template
And I am on file '/files/13DV-CAPITAL-10.mpg' info page in folder '/F1' template 'T_PAA_S02'
When I wait while proxy is visible on file info page
And play clip on file '13DV-CAPITAL-10.mpg' info page in folder '/F1' template 'T_PAA_S02'
And wait for '1' seconds
And I login as 'AgencyAdmin'
And go to template 'T_PAA_S02' folder '/F1' page
And go to file '/files/13DV-CAPITAL-10.mpg' info page in folder '/F1' template 'T_PAA_S02'
Then I 'should' see activity for user 'U_PAA_S02' on file '13DV-CAPITAL-10.mpg' activity tab in template 'T_PAA_S02' folder '/F1' page with message 'played file' and value ''


Scenario: Check that changed file title is displayed on activity added early
!--affected by NGN-2284
Meta: @skip
      @gdam
Given I created 'U_PAA_S03' User
And I logged in with details of 'U_PAA_S03'
And the following projects were created:
| Name      | Job Number     | Administrators |
| P_PAA_S03 | J_PAA_S03      | AgencyAdmin    |
And created '/F1' folder for project 'P_PAA_S03'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/F1' folder for 'P_PAA_S03' project
And I am on file '/files/13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'P_PAA_S03'
When I wait while proxy is visible on file info page
And play clip on file '13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'P_PAA_S03'
And wait for '1' seconds
And set title '13DV-CAPITAL-10.new.mpg' for file '13DV-CAPITAL-10.mpg' in folder '/F1' of project 'P_PAA_S03'
And I login as 'AgencyAdmin'
And go to file '13DV-CAPITAL-10.new.mpg' info page in folder '/F1' project 'P_PAA_S03'
Then I 'should' see activity for user 'U_PAA_S03' on file '13DV-CAPITAL-10.new.mpg' activity tab in project 'P_PAA_S03' folder '/F1' page with message 'played file' and value '13DV-CAPITAL-10.new.mpg'


Scenario: Check that changed logo, first name, last name is displayed on activity added early after play
!--affected by NGN-2408
Meta: @skip
      @gdam
Given I created 'U_PAA_S04' User
And I logged in with details of 'U_PAA_S04'
And the following projects were created:
| Name      | Job Number     | Administrators |
| P_PAA_S04 | J_PAA_S04      | AgencyAdmin    |
And created '/F1' folder for project 'P_PAA_S04'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/F1' folder for 'P_PAA_S04' project
And I am on file '/files/13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'P_PAA_S04'
When I wait while proxy is visible on file info page
And play clip on file '13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'P_PAA_S04'
And wait for '1' seconds
And I login as 'AgencyAdmin'
And I edit user 'U_PAA_S04' with following fields:
| FirstName     | LastName     | Email     |
| testFirstName | testLastName | U_PAA_S04 |
And go to file '/files/13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'P_PAA_S04'
Then I 'should' see activity for user 'U_PAA_S04' on file '13DV-CAPITAL-10.mpg' activity tab in project 'P_PAA_S04' folder '/F1' page with message 'played file' and value '13DV-CAPITAL-10.mpg'


Scenario: Check that playout file activity displays correct user name if file has been played by user whom folder has been shared
!--NGN-4004
Meta: @gdam
      @projects
Given I created 'R_PAA_S06' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
Given I created users with following fields:
| Email       | Role        |
| U_PAA_S06_1 | agency.user |
| U_PAA_S06_2 | agency.user |
And logged in with details of 'U_PAA_S06_1'
And created 'P_PAA_S06' project
And created '/F1' folder for project 'P_PAA_S06'
And uploaded '/files/Fish-Ad.mov' file into '/F1' folder for 'P_PAA_S06' project
And waited while preview is available in folder '/F1' on project 'P_PAA_S06' files page
And I am on project 'P_PAA_S06' teams page
And added user 'U_PAA_S06_2' into project 'P_PAA_S06' team with role 'R_PAA_S06' expired '12.12.2021' for folder on popup '/F1'
When I login with details of 'U_PAA_S06_2'
And go to file '/files/Fish-Ad.mov' info page in folder '/F1' project 'P_PAA_S06'
And wait for '10' seconds
And play clip on file 'Fish-Ad.mov' info page in folder '/F1' project 'P_PAA_S06'
And wait for '1' seconds
And login with details of 'U_PAA_S06_1'
And go to project 'P_PAA_S06' folder '/F1' page
And go to file '/files/Fish-Ad.mov' info page in folder '/F1' project 'P_PAA_S06'
Then I 'should' see activity for user 'U_PAA_S06_2' on file 'Fish-Ad.mov' activity tab in project 'P_PAA_S06' folder '/F1' page with message 'played file' and value ''