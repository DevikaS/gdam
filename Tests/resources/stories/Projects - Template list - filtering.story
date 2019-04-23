!--NGN-36
Feature:          Projects - Template list - filtering
Narrative:
In order to
As a              AgencyAdmin
I want to         Check filtering of Template list


Scenario: Check availability Template list filtering options
Meta:@gdam
@projects
Given I am on Template list page
When I click element 'ViewComboBox' on page 'Templates'
Then I 'should' see following elements on page 'Templates':
| element            |
| ProjectTemplates   |
| MyProjecttemplates |


Scenario: Check that 'All templates' option is default filtering option
Meta:@gdam
@projects
Given I am on Template list page
Then I should see view type 'Project templates' is selected on Templates list


Scenario: Check default filtering
Meta:@gdam
@projects
Given I am on Template list page
Then I should see 'all' templates on Template list


Scenario: Check template list filtering
Meta:@gdam
@projects
Given I am on Template list page
When I click element 'ViewComboBox' on page 'Templates'
And click element '<element>' on page 'Templates'
Then I should see '<result>' templates on Template list

Examples:
| element            | result |
| ProjectTemplates   | all    |
| MyProjecttemplates | my     |