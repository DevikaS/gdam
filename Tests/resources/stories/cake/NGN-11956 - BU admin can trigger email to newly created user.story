!--NGN-11956
Feature:          BU admin can trigger email to newly created user
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Check password field on Create New User page according to user self registers checkbox

Meta:
@cake

Scenario: Check that global admin can see 'User Self Registers' checkbox and default values
Given I created the agency 'A_USHTOCP_S01' with default attributes
When I go to agency 'A_USHTOCP_S01' overview page
Then I 'should' see following fields on agency overview page:
| FieldName                                       | FieldValue |
| User Self Registers                             | false      |


Scenario: Check that presence of Password field on Create New User page is based on agency setting and can create user
Given I created the agency 'A_USHTOCP_S02' with default attributes
And created users with following fields:
| Email       | Role         | Agency        |
| <UserEmail> | agency.admin | A_USHTOCP_S02 |
When I update agency 'A_USHTOCP_S02' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| User Self Registers                             | <CheckBoxSelected> |
And login with details of '<UserEmail>'
And go to Create New User page
Then '<Condition>' see selected Password field on create user page
When I fill '<FieldSet>' and 'EMPTY' logo for '<NewUser>' user
And click element 'SaveButton' on page 'UserSettings'
And wait for '3' seconds
Then I 'should' see user with email '<NewUser>' on Users list page

Examples:
| UserEmail       | CheckBoxSelected | Condition  | FieldSet                  | NewUser   |
| U_USHTOCP_S02_1 | false            | should     | MandatoryFields           | NewUser_1 |
| U_USHTOCP_S02_2 | true             | should not | MandatoryFieldsNoPassword | NewUser_2 |
