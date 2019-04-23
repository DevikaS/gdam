!--NGN-9976
Feature:          Project Owner can update TnC in the Project
Narrative:
In order to
As a              AgencyAdmin
I want to         check that project owner can update TnC in the project

Scenario: Check that all users who have access should be prompted to accept T&Cs again
Meta:@gdam
@projects
Given I created the agency 'A_POCUPTC_S01' with default attributes
And I created users with following fields:
| Email           | Agency        |
| U_POCUPTC_S01_1 | A_POCUPTC_S01 |
| U_POCUPTC_S01_2 | A_POCUPTC_S01 |
And logged in with details of 'U_POCUPTC_S01_1'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When I create new project with following fields:
| FieldName          | FieldValue    |
| Name               | P_POCUPTC_S01 |
| Media type         | Broadcast     |
| Start date         | Today         |
| End date           | Tomorrow      |
| Terms & Conditions | test          |
And refresh the page
And accept agency Terms and Conditions
And create '/F_POCUPTC_S01' folder for project 'P_POCUPTC_S01'
And add users 'U_POCUPTC_S01_2' to project 'P_POCUPTC_S01' team with role 'project.contributor' expired '12.12.2021'
And go to project 'P_POCUPTC_S01' overview page
And refresh the page
And update project 'P_POCUPTC_S01' with following fields on Edit Project popup:
| FieldName          | FieldValue |
| Terms & Conditions | test1      |
And refresh the page
And accept agency Terms and Conditions
And login with details of 'U_POCUPTC_S01_2'
And refresh the page
And go to Project list page
And click by project name 'P_POCUPTC_S01'
Then I 'should' see agency Terms and Conditions text 'test1' on opened Terms and Conditions popup



Scenario: Check that users should not be prompted to accept T&Cs if T&C is empty
Meta:@gdam
@projects
Given I created the agency 'A_POCUPTC_S02' with default attributes
And I created users with following fields:
| Email           | Agency        |
| U_POCUPTC_S02_1 | A_POCUPTC_S02 |
| U_POCUPTC_S02_2 | A_POCUPTC_S02 |
And logged in with details of 'U_POCUPTC_S02_1'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When I create new project with following fields:
| FieldName          | FieldValue    |
| Name               | P_POCUPTC_S02 |
| Media type         | Broadcast     |
| Start date         | Today         |
| End date           | Tomorrow      |
| Terms & Conditions | test          |
And refresh the page
And accept agency Terms and Conditions
And create '/F_POCUPTC_S02' folder for project 'P_POCUPTC_S02'
And add users 'U_POCUPTC_S02_2' to project 'P_POCUPTC_S02' team with role 'project.contributor' expired '12.12.2021'
And update project 'P_POCUPTC_S02' with following fields on Edit Project popup:
| FieldName          | FieldValue |
| Terms & Conditions |            |
And login with details of 'U_POCUPTC_S02_2'
And refresh the page
And go to Project list page
And click by project name 'P_POCUPTC_S02'
Then I 'should not' see Terms and Conditions popup