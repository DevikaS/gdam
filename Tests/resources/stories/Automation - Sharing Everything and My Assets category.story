!--NGN-2298 NGN-5890
Feature:          Automation - Sharing Everything and My Assets category
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that autosharing 'Everything' and 'My Assets' disable

Scenario: check the default view for category 'My Assets'
Meta:@gdam
     @library
Given I am on administration area collections page
When I select category 'My Assets'
Then I 'should not' see element 'AddUsersButton' on page 'AdminCategoryPage'
And I 'should not' see element 'AddAgenciesButton' on page 'AdminCategoryPage'
And I 'should not' see element 'AddLibraryTeamButton' on page 'AdminCategoryPage'
And I should see that count of agencies in the list is '0' for current category
And I should see that count of users in the list is '0' for current category


Scenario: check the default view for category 'Everything'
Meta:@gdam
     @library
Given I am on administration area collections page
When I select category 'Everything'
Then I 'should not' see element 'AddUsersButton' on page 'AdminCategoryPage'
And I 'should not' see element 'AddAgenciesButton' on page 'AdminCategoryPage'
And I 'should not' see element 'AddLibraryTeamButton' on page 'AdminCategoryPage'
And I should see that count of agencies in the list is '0' for current category
And I should see that count of users in the list is '0' for current category
