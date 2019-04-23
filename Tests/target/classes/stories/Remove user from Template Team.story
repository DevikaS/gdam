!--NGN-32 NGN-1343
Feature:          Remove user from Template Team
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Remove user from Template Team

Scenario: Check that user can be removed from Template Team
Meta:@gdam
@projects
Given I created 'RUTT1' template
And created '/RUTF1' folder for template 'RUTT1'
And created users with following fields:
| Email   | Role       |
| RUTU1_1 | guest.user |
| RUTU1_2 | guest.user |
And created 'RUTR1' role in 'project' group for advertiser 'DefaultAgency'
And added users 'RUTU1_1,RUTU1_2' to template 'RUTT1' team folders '/RUTF1' with role 'RUTR1' expired '12.12.2021'
And I am on template 'RUTT1' teams page
When I select user 'RUTU1_1' on template 'RUTT1' team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
Then I 'should' see user 'RUTU1_2' name in teams of template 'RUTT1'
And 'should not' see user 'RUTU1_1' name in teams of template 'RUTT1'