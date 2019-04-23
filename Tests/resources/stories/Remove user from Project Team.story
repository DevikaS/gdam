!--NGN-32
Feature:          Remove user from Project Team
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Remove user from Project Team

Scenario: Check that user can be removed from Project Team
Meta:@gdam
@projects
Given I created 'RUP1' project
And created '/RUF1' folder for project 'RUP1'
And created users with following fields:
| Email  | Role       |
| RUU1_1 | guest.user |
| RUU1_2 | guest.user |
And created 'RUR1' role in 'project' group for advertiser 'DefaultAgency'
And added users 'RUU1_1,RUU1_2' to project 'RUP1' team folders '/RUF1' with role 'RUR1' expired '12.12.2021'
And I am on project 'RUP1' teams page
When I select user 'RUU1_1' on project 'RUP1' team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
Then I 'should' see user 'RUU1_2' name in teams of project 'RUP1'
And 'should not' see user 'RUU1_1' name in teams of project 'RUP1'