!--NGN-9977
Feature:          Project Owner can add TnC to the Project
Narrative:
In order to
As a              AgencyAdmin
I want to         check that project owner can add TNC to the project

Scenario: Check that project owner clicks Edit button and can change T&Cs together with other project details
Meta:@gdam
@projects
Given I created the agency 'POATCOP_A1' with default attributes
And I created users with following fields:
| Email      | Role         | Agency     |
| POATCOP_E1 | agency.admin | POATCOP_A1 |
And logged in with details of 'POATCOP_E1'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue |
| Name               | POATCOP_P1 |
| Media type         | Broadcast  |
| Start date         | Today      |
| End date           | Tomorrow   |
| Terms & Conditions | test       |
And accept agency Terms and Conditions
And update project 'POATCOP_P1' with following fields on Edit Project popup:
| FieldName          | FieldValue   |
| Name               | POATCOP_P1_1 |
| Media type         | Digital      |
| End date           | Today        |
| Terms & Conditions | test2        |
And refresh the page
Then 'should' see agency Terms and Conditions text 'test2' on opened Terms and Conditions popup and accept rules
And Project 'POATCOP_P1_1' should include the following fields:
| Name         | Media Type | End date |
| POATCOP_P1_1 | Digital    | [Today]    |


Scenario: Check that project owner can see T&C in the Project Overview, this T&Cs should not display in full, it should be a link to open T&C in the pop-up window
Meta:@gdam
@projects
Given I created the agency 'POATCOP_A2' with default attributes
And I created users with following fields:
| Email      | Role         | Agency     |
| POATCOP_E2 | agency.admin | POATCOP_A2 |
And logged in with details of 'POATCOP_E2'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue  |
| Name               | POATCOP2_P1 |
| Media type         | Broadcast   |
| Start date         | Today       |
| End date           | Tomorrow    |
| Terms & Conditions | test        |
And accept agency Terms and Conditions
Then 'should' see 'Terms and Conditions' link on project Overview page


Scenario: Check that T&C is empty if project owner removed text of T&C when edited project details
Meta:@gdam
@projects
Given I created the agency 'POATCOP_A3' with default attributes
And I created users with following fields:
| Email      | Role         | Agency     |
| POATCOP_E2 | agency.admin | POATCOP_A3 |
And logged in with details of 'POATCOP_E2'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue  |
| Name               | POATCOP3_P1 |
| Media type         | Broadcast   |
| Start date         | Today       |
| End date           | Tomorrow    |
| Terms & Conditions | test        |
And accept agency Terms and Conditions
And update project 'POATCOP3_P1' with following fields on Edit Project popup:
| FieldName          | FieldValue   |
| Terms & Conditions |              |
And refresh the page
Then 'should not' see agency Terms and Conditions popup