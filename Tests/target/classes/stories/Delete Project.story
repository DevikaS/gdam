!--NGN-119
Feature:          Delete project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check project deletion

Scenario: Check that button 'Delete Project' becomes active after project selection
Meta:@gdam
@projects
Given I created 'NewProject0' project
And I am on Project list page
And refreshed the page
When I select 'NewProject0' project in Project list page
Then I should see Delete button is 'Enabled' on Project list page


Scenario: Check that button 'Delete Project' becomes inactive by default
Meta:@gdam
@projects
Given I am on Project list page
Then I should see Delete button is 'Disabled' on Project list page


Scenario: Check project deletion
Meta:@gdam
@projects
Given I created 'NewProject1' project
And I am on Project list page
And refreshed the page
When I select 'NewProject1' project in Project list page
And click element 'DeleteButton' on page 'Projects'
And click element 'Delete' on page 'DeletePopUp'
Then I shouldn't see 'NewProject1' project in project list


Scenario: Check multiple project deletion
Meta:@gdam
@projects
Given I created 'NewProject2' project
And I created 'NewProject3' project
And I am on Project list page
And refreshed the page
When I select 'NewProject2' project in Project list page
And I select 'NewProject3' project in Project list page without Sorting
And click element 'DeleteButton' on page 'Projects'
And click element 'Delete' on page 'DeletePopUp'
Then I shouldn't see 'NewProject2' project in project list
And I shouldn't see 'NewProject3' project in project list