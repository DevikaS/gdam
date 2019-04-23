!--NGN-9981
Feature:          User should be prompted to accept TnC before accessing project
Narrative:
In order to:
As a              AgencyAdmin
I want to         Check that user is prompted to accept TnC before accessing project

Scenario: Check that if owner change T&C than user should see pop-up window with new T&Cs to access to project
Meta: @gdam
@projects
Given created the agency 'UPTATCBAP1_A1' with default attributes
And I created users with following fields:
| Email         | Role         | Agency       |
| UPTATCBAP1_E1 | agency.admin | UPTATCBAP1_A1 |
| UPTATCBAP1_E2 | agency.admin | UPTATCBAP1_A1 |
And logged in with details of 'UPTATCBAP1_E1'
And on the T&C page
And filled terms and conditions textbox with text 'text' on T&C page
And saved current terms and conditions on opened T&C page
And I am on Dashboard page
And waited for '2' seconds
And accepted agency Terms and Conditions
When login with details of 'UPTATCBAP1_E2'
And accept agency Terms and Conditions
And login with details of 'UPTATCBAP1_E1'
And go to the T&C page
And fill terms and conditions textbox with text 'text22' on T&C page
And save current terms and conditions on opened T&C page
And login with details of 'UPTATCBAP1_E2'
When I wait for '2' seconds
Then I 'should' see agency Terms and Conditions text 'text22' on opened Terms and Conditions popup


Scenario: Check that if project was accessed, then unshared (or unpublished), then shared again - there is no need to show T&C again
Meta: @gdam
@projects
Given created the agency 'UPTATCBAP1_A2' with default attributes
And I created users with following fields:
| Email         | Role         | Agency        |
| UPTATCBAP2_E1 | agency.admin | UPTATCBAP1_A2 |
| UPTATCBAP2_E2 | agency.admin | UPTATCBAP1_A2 |
And logged in with details of 'UPTATCBAP2_E1'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue    |
| Name               | UPTATCBAP2_P1 |
| Media type         | Broadcast     |
| Start date         | Today         |
| End date           | Tomorrow      |
| Terms & Conditions | test          |
And accept agency Terms and Conditions
And publish the project 'UPTATCBAP2_P1'
And I login with details of 'UPTATCBAP2_E2'
And go to Project list page
And click by project name 'UPTATCBAP2_P1'
And accept agency Terms and Conditions
And I login with details of 'UPTATCBAP2_E1'
And unpublish the project 'UPTATCBAP2_P1'
And I login with details of 'UPTATCBAP2_E2'
And go to Project list page
And click by project name 'UPTATCBAP2_P1'
Then I 'should not' see agency Terms and Conditions popup


Scenario: Check that if project has T&C, and user is trying to access it, user should see pop-up window with T&Cs
Meta: @gdam
@projects
!-- NGN-14650: With current implementation, no project role as 'agency.admin'. so changed to 'project.observer'
Given created the agency 'UPTATCBAP3_A1' with default attributes
And created the agency 'UPTATCBAP3_A2' with default attributes
And I created users with following fields:
| Email         | Role         | Agency        |
| UPTATCBAP3_E1 | agency.admin | UPTATCBAP3_A1 |
And I created users with following fields:
| Email         | Agency        |
| UPTATCBAP3_E2 | UPTATCBAP3_A2 |
And logged in with details of 'UPTATCBAP3_E1'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue    |
| Name               | UPTATCBAP3_P1 |
| Media type         | Broadcast     |
| Start date         | Today         |
| End date           | Tomorrow      |
| Terms & Conditions | test          |
And create '/folder_f1' folder for project 'UPTATCBAP3_P1'
And I add users 'UPTATCBAP3_E2' to project 'UPTATCBAP3_P1' team folders '/folder_f1' with role 'project.observer' expired '12.12.2021'
And accept agency Terms and Conditions
And publish the project 'UPTATCBAP3_P1'
And login with details of 'UPTATCBAP3_E2'
And go to Project list page
And click by project name 'UPTATCBAP3_P1'
Then I 'should' see agency Terms and Conditions popup