!--NGN-193
Feature:          Edit template details
Narrative:
In order to
As a              AgencyAdmin
I want to         Check editing template details

Scenario: Updating template details using existed template name
Meta:@gdam
@projects
Given created the agency 'A_ETD' with default attributes
And created users with following fields:
| Email | Agency | Role         |
| E_ETD | A_ETD  | agency.admin |
And logged in with details of 'E_ETD'
And the following templates were created:
| Name |
| ETD3 |
| ETD4 |
And I am on template 'ETD4' settings page
When I edit the following fields for 'ETD4' template:
| Name | Job Number |
| ETD3 | 3          |
And click on element 'SaveButton' without delay
Then I should see message error 'Changes saved successfully'
When I go to template list page
Then I should see 'ETD3' template in templates list
And I shouldn't see 'ETD4' template in template list


Scenario: Updating template details using logo with invalid extension
Meta:@gdam
@projects
Given the following templates were created:
| Name | Logo |
| ETD7 | GIF  |
And I am on template 'ETD7' settings page
When I edit the following fields for 'ETD7' template:
| Name | Logo |
| ETD7 | BMP  |
Then I should see  error message 'logo\w+.bmp has invalid extension. Only jpg, jpeg, png are allowed.'


Scenario: Updating template details with empty mandatory field
Meta:@gdam
@projects
Given I created 'ETD8' template
And I am on template 'ETD8' settings page
When I edit the following fields for 'ETD8' template:
| Name |
|      |
Then I 'should' see red inputs on page


Scenario: Updating template details with new user as template administrator
Meta:@gdam
@projects
Given I created 'ETD9' template
When I edit the following fields for 'ETD9' template:
| Name | Administrators    |
| ETD9 | NotExistAdminName |
Then I should see count '2' of administrators on create new template page


Scenario: Check that Logo after update should be displayed in template list
Meta:@gdam
@projects
Given the following templates were created:
| Name | Logo |
| ETD10| GIF  |
And I am on template 'ETD10' settings page
When I edit the following fields for 'ETD10' template:
| Name | Logo |
| ETD10| PNG |
And click on element 'SaveButton'
Then I should see template 'ETD10' with logo 'PNG' in template list