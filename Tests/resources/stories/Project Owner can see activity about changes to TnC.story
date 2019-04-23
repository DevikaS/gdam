!--NGN-9970
Feature:          Project Owner can see activity about changes to TnC
Narrative:
In order to
As a              AgencyAdmin
I want to         check that project owner can see activity about changes to TNC

Scenario: Check that activity is present on
Meta:@gdam
@projects
Given created the agency 'OCSAACTTC_A' with default attributes
And I created users with following fields:
| Email     | Role         | Agency      |
| OCSAACTTC | agency.admin | OCSAACTTC_A |
And logged in with details of 'OCSAACTTC'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue   |
| Name               | OCSAACTTC_P1 |
| Media type         | Broadcast    |
| Start date         | Today        |
| End date          | Tomorrow     |
| Terms & Conditions | test         |
And accept agency Terms and Conditions
And update project 'OCSAACTTC_P1' with following fields on Edit Project popup:
| FieldName          | FieldValue |
| Terms & Conditions | test1      |
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName  | Message                            | Value                |
| OCSAACTTC | updated project Terms & Conditions | Terms and Conditions |


Scenario: Check that activity is present activity on project
Meta:@gdam
@projects
Given created the agency 'OCSAACTTC_A2' with default attributes
And I created users with following fields:
| Email        | Role         | Agency       |
| OCSAACTTC_E2 | agency.admin | OCSAACTTC_A2 |
And logged in with details of 'OCSAACTTC_E2'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue   |
| Name               | OCSAACTTC_P2 |
| Media type         | Broadcast    |
| Start date         | Today        |
| End date          | Tomorrow     |
| Terms & Conditions | test         |
And accept agency Terms and Conditions
And update project 'OCSAACTTC_P2' with following fields on Edit Project popup:
| FieldName          | FieldValue |
| Terms & Conditions | test2      |
And refresh the page
And accept agency Terms and Conditions
Then I 'should' see activity for user 'OCSAACTTC_E2' on project 'OCSAACTTC_P2' overview page with message 'updated project Terms & Conditions' and value 'Terms and Conditions'


Scenario: Check that owner (no other users) can see activity
Meta:@gdam
@projects
Given created the agency 'OCSAACTTC_A' with default attributes
And I created users with following fields:
| Email         | Role         | Agency      |
| OCSAACTTC3_E1 | agency.admin | OCSAACTTC_A |
| OCSAACTTC3_E2 | agency.admin | OCSAACTTC_A |
And logged in with details of 'OCSAACTTC3_E1'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue    |
| Name               | OCSAACTTC3_P1 |
| Media type         | Broadcast     |
| Start date         | Today         |
| End date          | Tomorrow      |
| Terms & Conditions | test          |
And accept agency Terms and Conditions
And update project 'OCSAACTTC3_P1' with following fields on Edit Project popup:
| FieldName          | FieldValue |
| Terms & Conditions | test1      |
And I login with details of 'OCSAACTTC3_E2'
And go to Project list page
And click by project name 'OCSAACTTC3_P1'
And accept agency Terms and Conditions
Then I 'should' see activity for user 'OCSAACTTC3_E1' on project 'OCSAACTTC3_P1' overview page with message 'updated project Terms & Conditions' and value 'Terms and Conditions'
