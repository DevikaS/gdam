!--NGN-11357
Feature:          User with permission creates Public Template
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that User with permission creates Public Template


Scenario: check that agency admin has ability to set option 'View Public Templates' for agency users
Meta:@gdam
@projects
Given I created users with following fields:
| Email  | Role        | ViewPublicTemplate |
| <Name> | agency.user | <Flag>             |
And I am on user '<Name>' details page
Then '<ShouldState>' see 'View Public Templates' option on user details page

Examples:
| ShouldState | Flag  | Name |
| should      | true  | Roy1 |
| should not  | false | Roy2 |


Scenario: Check that owner has ability to set option 'Allow other users in my Business Unit to create projects from this template' for tepmlates
Meta:@gdam
@projects
Given I am on Create New Template page
Then 'should' option 'Allow other users in my Business Unit to create projects from this template' on create template popup


Scenario: Check that public templates are appear at list for agency user with permission 'View Public Templates'
Meta:@gdam
@projects
Given I created new  template with following fields:
| FieldName           | FieldValue  |
| AllowCreateProjects | true        |
| Name                | <Templates> |
| Media type          | Broadcast   |
| Start date          | Today       |
| End date            | Tomorrow    |
And created users with following fields:
| Email    | Role    |
| <Emails> | <Roles> |
When I login with details of '<Emails>'
And go to template list page
And use '<Templates>' template
And fill the following fields for project from template:
| Name       | Start Date | End date   |
| <Projects> | [Today]    | 12.12.2016 |
And click Save button on template popup
Then I should see project '<Projects>' overview page

Examples:
| Emails        | Roles        | Templates     | Projects      |
| E_UWPCPT_E3_1 | agency.user  | T_UWPCPT_03_1 | P_UWPCPT_03_1 |
| E_UWPCPT_E3_2 | agency.admin | T_UWPCPT_03_2 | P_UWPCPT_03_2 |


Scenario: Check that user can't delete and edit public templates
Meta:@gdam
@projects
Given I created new  template with following fields:
| FieldName           | FieldValue  |
| AllowCreateProjects | true        |
| Name                | T_UWPCPT_04 |
| Media type          | Broadcast   |
| Start date          | Today       |
| End date            | Tomorrow    |
And created users with following fields:
| Email       | Role        |
| E_UWPCPT_E4 | agency.user |
When I login with details of 'E_UWPCPT_E4'
And I go to template 'T_UWPCPT_04' overview page
Then I 'should not' see edit link for current template


Scenario: Check that user can create project from available public templates from template drop-down
Meta:@gdam
@projects
Given I created new template with following fields:
| FieldName           | FieldValue  |
| AllowCreateProjects | true        |
| Name                | T_UWPCPT_05 |
| Media type          | Broadcast   |
| Start date          | Today       |
| End date            | Tomorrow    |
And created users with following fields:
| Email       | Role        |
| E_UWPCPT_E5 | agency.user |
When I go to Create New Project page
And I create new project with following fields:
| FieldName   | FieldValue   |
| Template    | T_UWPCPT_05  |
| Name        | P_DIFPT_S01  |
| Media type  | Broadcast    |
| Start date  | Today        |
| End date    | Tomorrow     |
Then I should see project 'P_DIFPT_S01' overview page