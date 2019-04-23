!--NGN-11698
Feature:          Global Admin can hide Template field from Create New Project and Work Request forms
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Check template field on Create New Project and Create New Work request form according to checkbox

Scenario: Check that global admin can see 'Hide Template field on Create New Project forms' checkbox and default values
Meta:@globaladmin
     @gdam
Given I created the agency 'A_USHTOCP_S01' with default attributes
When I go to agency 'A_USHTOCP_S01' overview page
Then I 'should' see following fields on agency overview page:
| FieldName                                       | FieldValue |
| Hide Template field on Create New Project forms | false      |


Scenario: Check that by default you see Template field on Create New Project form
Meta:@projects
     @gdam
Given I created the agency 'A_USHTOCP_S02' with default attributes
And created users with following fields:
| Email       | Role         | Agency        |
| <UserEmail> | agency.admin | A_USHTOCP_S02 |
When I update agency 'A_USHTOCP_S02' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Hide Template field on Create New Project forms | <CheckBoxSelected> |
And login with details of '<UserEmail>'
And open Create New Project popup
Then '<Condition>' see selected Template field on opened Create Project popup

Examples:
| UserEmail       | CheckBoxSelected | Condition  |
| U_USHTOCP_S02_1 | false            | should     |
| U_USHTOCP_S02_2 | true             | should not |


Scenario: Check that by default you see Template field on Create New Work Request form
Meta:@@projects
     @gdam
Given I created the agency 'A_USHTOCP_S03' with default attributes
And created users with following fields:
| Email       | Role         | Agency        |
| <UserEmail> | agency.admin | A_USHTOCP_S03 |
And logged in with details of 'GlobalAdmin'
When I update agency 'A_USHTOCP_S03' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Hide Template field on Create New Project forms | <CheckBoxSelected> |
And login with details of '<UserEmail>'
And open Create New Work Request popup
Then '<Condition>' see selected Template field on opened Create Work Request popup

Examples:
| UserEmail       | CheckBoxSelected | Condition  |
| U_USHTOCP_S03_1 | false            | should     |
| U_USHTOCP_S03_2 | true             | should not |