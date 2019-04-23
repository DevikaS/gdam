!-- NGN-27
Feature:          Template List view
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Template List view

Scenario: Correct counting of selected templates on page
Meta:@gdam
@projects
Given I created '10' templates with name pattern 'T_TLV_S01'
Given I am on Template list page
And waited for '3' seconds
When I select '5' templates in templates list
Then I should see '5' selected note in templates counter


Scenario: Verify that all templates are selected using Select All
Meta:@gdam
@projects
Given I created the agency 'TLV_S01' with default attributes
And created users with following fields:
| Email     | Role         | Agency  |
| U_TLV_S01 | agency.admin | TLV_S01 |
And logged in with details of 'U_TLV_S01'
And created '10' templates with name pattern 'T_TLV_S02'
And I am on Template list page
When click 'Select all' checkbox on template list
Then I should see '10' selected note in templates counter
And all templates count '10' is 'selected' in Template list