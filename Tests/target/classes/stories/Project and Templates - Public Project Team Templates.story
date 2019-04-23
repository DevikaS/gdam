!--QA-784
Feature:          As Project Admin I should see project team templates are carried forward along with team members
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that as project admin I should see project team templates are carried forward along with team members

Scenario: Check project team templates are carried forward along with team members and roles when project template is created from project
Meta:@projects
      @gdam
Given I created the agency 'APAISSPTTACFAWTM_1' with default attributes
And created users with following fields:
| Email                      | Role         | Agency           |
| E_APAISSPTTACFAWTM_S01_1 | agency.admin | APAISSPTTACFAWTM_1 |
| E_APAISSPTTACFAWTM_S01_2 | agency.admin | APAISSPTTACFAWTM_1 |
| E_APAISSPTTACFAWTM_S01_3 | agency.user | APAISSPTTACFAWTM_1 |
| E_APAISSPTTACFAWTM_S01_4 | agency.user | APAISSPTTACFAWTM_1 |
| E_APAISSPTTACFAWTM_S01_5 | agency.admin | APAISSPTTACFAWTM_1 |
And I logged in with details of 'E_APAISSPTTACFAWTM_S01_5'
And I am on Users list page
When I add 'E_APAISSPTTACFAWTM_S01_1,E_APAISSPTTACFAWTM_S01_3' users to 'Team_01' project team with default role 'project.contributor' on Users list page
And I add 'E_APAISSPTTACFAWTM_S01_2,E_APAISSPTTACFAWTM_S01_4' users to 'Team_02' project team with default role 'project.contributor' on Users list page
And created 'P_APAISSPTTACFAWTM_S01' project
And I go to project 'P_APAISSPTTACFAWTM_S01' overview page
And I go to project 'P_APAISSPTTACFAWTM_S01' teams page using UI
And I add team template 'Team_01' into project 'P_APAISSPTTACFAWTM_S01' team with role 'Project Contributor' and expiry date '12.12.2020'
And I wait for '5' seconds
And I add team template 'Team_02' into project 'P_APAISSPTTACFAWTM_S01' team with role 'Project Contributor' and expiry date '12.12.2020'
Then I 'should' see project team 'Team_01,Team_02' in agency project teams list for this project
And I should see user 'E_APAISSPTTACFAWTM_S01_1,E_APAISSPTTACFAWTM_S01_2,E_APAISSPTTACFAWTM_S01_3,E_APAISSPTTACFAWTM_S01_4' has role 'Project Contributor' on project 'P_APAISSPTTACFAWTM_S01' team page
When I click create template from project for project 'P_APAISSPTTACFAWTM_S01'
And I specify template name 'PT_APAISSPTTACFAWTM_S01' on create template page
And 'check' include 'Teams' for template
And 'check' include 'Folders' for project
And click on element 'SaveButton'
And I wait for '5' seconds
And go to template 'PT_APAISSPTTACFAWTM_S01' teams page
And I wait for '5' seconds
Then I 'should' see template team 'Team_01,Team_02' in agency project teams list for this project
And I should see user 'E_APAISSPTTACFAWTM_S01_1,E_APAISSPTTACFAWTM_S01_2,E_APAISSPTTACFAWTM_S01_3,E_APAISSPTTACFAWTM_S01_4' has role 'Project Contributor' on template 'PT_APAISSPTTACFAWTM_S01' team page

Scenario: Check when roles assigned are different while adding team templates in project team page are carried forward to templates team page when project template is created from project
Meta:@projects
      @gdam
 !--Failing due to FAB-548
Given I created the agency 'APAISSPTTACFAWTM_2' with default attributes
And created users with following fields:
| Email                      | Role         | Agency           |
| E_APAISSPTTACFAWTM_S02_1 | agency.admin | APAISSPTTACFAWTM_2 |
| E_APAISSPTTACFAWTM_S02_2 | agency.admin | APAISSPTTACFAWTM_2 |
| E_APAISSPTTACFAWTM_S02_3 | agency.user | APAISSPTTACFAWTM_2 |
| E_APAISSPTTACFAWTM_S02_4 | agency.user | APAISSPTTACFAWTM_2 |
| E_APAISSPTTACFAWTM_S02_5 | agency.admin | APAISSPTTACFAWTM_2 |
And I logged in with details of 'E_APAISSPTTACFAWTM_S02_5'
And I am on Users list page
When I add 'E_APAISSPTTACFAWTM_S02_1,E_APAISSPTTACFAWTM_S02_3' users to 'Team_03' project team with default role 'project.contributor' on Users list page
And I add 'E_APAISSPTTACFAWTM_S02_2,E_APAISSPTTACFAWTM_S02_4' users to 'Team_04' project team with default role 'project.contributor' on Users list page
And created 'P_APAISSPTTACFAWTM_S02' project
And I go to project 'P_APAISSPTTACFAWTM_S02' overview page
And I go to project 'P_APAISSPTTACFAWTM_S02' teams page using UI
And I wait for '5' seconds
And I add team template 'Team_03' into project 'P_APAISSPTTACFAWTM_S02' team with role 'Project Observer' and expiry date '12.12.2020'
And I wait for '5' seconds
And I add team template 'Team_04' into project 'P_APAISSPTTACFAWTM_S02' team with role 'Project Observer' and expiry date '12.12.2020'
Then I 'should' see project team 'Team_03,Team_04' in agency project teams list for this project
And I should see user 'E_APAISSPTTACFAWTM_S02_1,E_APAISSPTTACFAWTM_S02_2,E_APAISSPTTACFAWTM_S02_3,E_APAISSPTTACFAWTM_S02_4' has role 'Project Observer' on project 'P_APAISSPTTACFAWTM_S02' team page
When I click create template from project for project 'P_APAISSPTTACFAWTM_S02'
And I specify template name 'PT_APAISSPTTACFAWTM_S02' on create template page
And 'check' include 'Teams' for template
And 'check' include 'Folders' for project
And click on element 'SaveButton'
And I wait for '5' seconds
And go to template 'PT_APAISSPTTACFAWTM_S02' teams page
And I wait for '5' seconds
Then I 'should' see template team 'Team_03,Team_04' in agency project teams list for this project
And I should see user 'E_APAISSPTTACFAWTM_S02_1,E_APAISSPTTACFAWTM_S02_2,E_APAISSPTTACFAWTM_S02_3,E_APAISSPTTACFAWTM_S02_4' has role 'Project Observer' on template 'PT_APAISSPTTACFAWTM_S02' team page

Scenario: Check project team templates are carried forward along with team members and roles when project is created from project template
Meta:@projects
      @gdam
Given I created the agency 'APAISSPTTACFAWTM_3' with default attributes
And created users with following fields:
| Email                      | Role         | Agency           |
| E_APAISSPTTACFAWTM_S03_1 | agency.admin | APAISSPTTACFAWTM_3 |
| E_APAISSPTTACFAWTM_S03_2 | agency.admin | APAISSPTTACFAWTM_3 |
| E_APAISSPTTACFAWTM_S03_3 | agency.user | APAISSPTTACFAWTM_3 |
| E_APAISSPTTACFAWTM_S03_4 | agency.user | APAISSPTTACFAWTM_3 |
| E_APAISSPTTACFAWTM_S03_5 | agency.admin | APAISSPTTACFAWTM_3 |
And I logged in with details of 'E_APAISSPTTACFAWTM_S03_5'
And I am on Users list page
When I add 'E_APAISSPTTACFAWTM_S03_1,E_APAISSPTTACFAWTM_S03_3' users to 'Team_05' project team with default role 'Project Contributor' on Users list page
And I add 'E_APAISSPTTACFAWTM_S03_2,E_APAISSPTTACFAWTM_S03_4' users to 'Team_06' project team with default role 'Project Contributor' on Users list page
And I go to Create New Template page
And I fill following fields on create new template page:
| FieldName  | FieldValue     |
| Name       | PT_APAISSPTTACFAWTM_S03 |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
And click on element 'SaveButton'
And I go to template 'PT_APAISSPTTACFAWTM_S03' teams page
And I wait for '5' seconds
And I add team template 'Team_05' into template 'PT_APAISSPTTACFAWTM_S03' team with role 'Project Contributor' and expiry date '12.12.2020'
And I wait for '5' seconds
And I add team template 'Team_06' into template 'PT_APAISSPTTACFAWTM_S03' team with role 'Project Contributor' and expiry date '12.12.2020'
Then I 'should' see template team 'Team_05,Team_06' in agency project teams list for this project
And I should see user 'E_APAISSPTTACFAWTM_S03_1,E_APAISSPTTACFAWTM_S03_2,E_APAISSPTTACFAWTM_S03_3,E_APAISSPTTACFAWTM_S03_4' has role 'Project Contributor' on template 'PT_APAISSPTTACFAWTM_S03' team page
When I use 'PT_APAISSPTTACFAWTM_S03' template
And fill the following fields for project from template:
| Name |
| P_APAISSPTTACFAWTM_S03 |
And I 'check' include 'Folders' for project
And I 'check' include 'Teams' for project
And I click on element 'SaveButton'
And I go to project 'P_APAISSPTTACFAWTM_S03' teams page
Then I 'should' see project team 'Team_05,Team_06' in agency project teams list for this project
And I should see user 'E_APAISSPTTACFAWTM_S03_1,E_APAISSPTTACFAWTM_S03_2,E_APAISSPTTACFAWTM_S03_3,E_APAISSPTTACFAWTM_S03_4' has role 'Project Contributor' on project 'P_APAISSPTTACFAWTM_S03' team page

Scenario: Check when roles assigned are different while adding team templates in template team page are carried forward to project team page when project is created from project template
Meta:@projects
      @gdam
      !--Failing due to FAB-548
Given I created the agency 'APAISSPTTACFAWTM_4' with default attributes
And created users with following fields:
| Email                      | Role         | Agency           |
| E_APAISSPTTACFAWTM_S04_1 | agency.admin | APAISSPTTACFAWTM_4 |
| E_APAISSPTTACFAWTM_S04_2 | agency.admin | APAISSPTTACFAWTM_4 |
| E_APAISSPTTACFAWTM_S04_3 | agency.user | APAISSPTTACFAWTM_4 |
| E_APAISSPTTACFAWTM_S04_4 | agency.user | APAISSPTTACFAWTM_4 |
| E_APAISSPTTACFAWTM_S04_5 | agency.admin | APAISSPTTACFAWTM_4 |
And I logged in with details of 'E_APAISSPTTACFAWTM_S04_5'
And I am on Users list page
When I add 'E_APAISSPTTACFAWTM_S04_1,E_APAISSPTTACFAWTM_S04_3' users to 'Team_07' project team with default role 'project.contributor' on Users list page
And I add 'E_APAISSPTTACFAWTM_S04_2,E_APAISSPTTACFAWTM_S04_4' users to 'Team_08' project team with default role 'project.contributor' on Users list page
And I go to Create New Template page
And I fill following fields on create new template page:
| FieldName  | FieldValue     |
| Name       | PT_APAISSPTTACFAWTM_S04 |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
And click on element 'SaveButton'
And I go to template 'PT_APAISSPTTACFAWTM_S04' teams page
And I wait for '5' seconds
And I add team template 'Team_07' into template 'PT_APAISSPTTACFAWTM_S04' team with role 'Project Observer' and expiry date '12.12.2020'
And I wait for '5' seconds
And I add team template 'Team_08' into template 'PT_APAISSPTTACFAWTM_S04' team with role 'Project Observer' and expiry date '12.12.2020'
Then I 'should' see template team 'Team_07,Team_08' in agency project teams list for this project
And I should see user 'E_APAISSPTTACFAWTM_S04_1,E_APAISSPTTACFAWTM_S04_2,E_APAISSPTTACFAWTM_S04_3,E_APAISSPTTACFAWTM_S04_4' has role 'Project Observer' on template 'PT_APAISSPTTACFAWTM_S04' team page
When I use 'PT_APAISSPTTACFAWTM_S04' template
And fill the following fields for project from template:
| Name |
| P_APAISSPTTACFAWTM_S04 |
And I 'check' include 'Folders' for project
And I 'check' include 'Teams' for project
And I click on element 'SaveButton'
And I go to project 'P_APAISSPTTACFAWTM_S04' teams page
Then I 'should' see template team 'Team_07,Team_08' in agency project teams list for this project
And I should see user 'E_APAISSPTTACFAWTM_S04_1,E_APAISSPTTACFAWTM_S04_2,E_APAISSPTTACFAWTM_S04_3,E_APAISSPTTACFAWTM_S04_4' has role 'Project Observer' on project 'P_APAISSPTTACFAWTM_S04' team page