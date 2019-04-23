!--NGN-11683
Feature:          User can select Publish Immediately option when creating project or work request
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Check 'Publish Immediately' option on creating project work requests

Scenario: Check default value for 'Publish Immediately' option on BU details page
Meta:@globaladmin
     @gdam
Given I created the agency 'A_USPIOWCP_S01' with default attributes
When I go to agency 'A_USPIOWCP_S01' overview page
Then I 'should' see following fields on agency overview page:
| FieldName                               | FieldValue |
| Publish Projects Immediately by Default | false      |


Scenario: Check 'Publish Immediately' option on 'Create new Project' form
Meta:@projects
     @gdam
Given I created the agency 'A_USPIOWCP_S02' with default attributes
And created users with following fields:
| Email       | Role         | Agency         |
| <UserEmail> | agency.admin | A_USPIOWCP_S02 |
When I update agency 'A_USPIOWCP_S02' with following fields on agency overview page:
| FieldName                               | FieldValue         |
| Publish Projects Immediately by Default | <CheckBoxSelected> |
And login with details of '<UserEmail>'
And open Create New Project popup
Then '<Condition>' see selected Publish Immediately checkbox on opened Create Project popup

Examples:
| UserEmail        | CheckBoxSelected | Condition  |
| U_USPIOWCP_S02_1 | true             | should     |
| U_USPIOWCP_S02_2 | false            | should not |


Scenario: Check 'Publish Immediately' option on 'Create new Work Request' form
Meta:@projects
     @gdam
Given I created the agency 'A_USPIOWCP_S03' with default attributes
And created users with following fields:
| Email       | Role         | Agency         |
| <UserEmail> | agency.admin | A_USPIOWCP_S03 |
When I update agency 'A_USPIOWCP_S03' with following fields on agency overview page:
| FieldName                               | FieldValue         |
| Publish Projects Immediately by Default | <CheckBoxSelected> |
And login with details of '<UserEmail>'
And open Create New Work Request popup
Then '<Condition>' see selected Publish Immediately checkbox on opened Create Work Request popup

Examples:
| UserEmail        | CheckBoxSelected | Condition  |
| U_USPIOWCP_S03_1 | true             | should     |
| U_USPIOWCP_S03_2 | false            | should not |


Scenario: Check 'Publish Immediately' option on 'Create Project From Template' form
Meta:@projects
     @gdam
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email       | Role         | Agency       |
| <UserEmail> | agency.admin | <AgencyName> |
And updated agency '<AgencyName>' with following fields on agency overview page:
| FieldName                               | FieldValue         |
| Publish Projects Immediately by Default | <CheckBoxSelected> |
And logged in with details of '<UserEmail>'
And created 'T_USPIOWCP_S04' template
When I go to Dashboard page
And go to template list page
And click use template button next to template 'T_USPIOWCP_S04' on opened templates list page
Then '<Condition>' see selected Publish Immediately checkbox on opened Create Project popup

Examples:
| AgencyName       | UserEmail        | CheckBoxSelected | Condition  |
| A_USPIOWCP_S04_1 | U_USPIOWCP_S04_1 | true             | should     |
| A_USPIOWCP_S04_2 | U_USPIOWCP_S04_2 | false            | should not |