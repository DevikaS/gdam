!--NGN-38
Feature:          Projects - Delete template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check template deletion

Scenario: Check single template deletion
Meta:@gdam
@projects
Given I created 'DT1' template
And I am on Template list page
When I select 'DT1' template on templates list page
And click element 'RemoveButton' on page 'Templates'
And wait for '2' seconds
And click element 'Delete' on page 'DeletePopUp'
Then I shouldn't see 'DT1' template in template list


Scenario: Check multiple template deletion
Meta:@gdam
@projects
Given I created 'DT2' template
And created 'DT3' template
And I am on Template list page
When I select 'DT2' template on templates list page
And select 'DT3' template on templates list page
And click element 'RemoveButton' on page 'Templates'
And wait for '2' seconds
And click element 'Delete' on page 'DeletePopUp'
Then I shouldn't see 'DT2' template in template list
And I shouldn't see 'DT3' template in template list


Scenario: Check that project based on the deleted template should be visible
Meta:@gdam
@projects
Given I created 'DT9' template
When I use 'DT9' template
And fill the following fields for project:
| Name |
| DTP1 |
And I click on element 'SaveButton'
And I go to Template list page
And select 'DT9' template on templates list page
And click element 'RemoveButton' on page 'Templates'
And wait for '2' seconds
And click element 'Delete' on page 'DeletePopUp'
And I go to Project list page
Then I should see 'DTP1' project in project list
