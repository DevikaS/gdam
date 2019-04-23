!--NGN-11620
Feature:          Some Project activities are missing
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check some Project activities are missing


Scenario: Check that activity appears after share folder on unregistred user
Meta:@gdam
@projects
Given I created the agency 'SPAAM_A1' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| SPAAM_EA01_1 | agency.admin | SPAAM_A1     |
And logged in with details of 'SPAAM_EA01_1'
And I created 'PSP501' project
And created '/PSF501' folder for project 'PSP501'
And I am on project 'PSP501' folder '/' page
And selected folder 'PSF501' on project files page
When I click element 'Share' on page 'FilesPage'
And fill Share window of project folder for following users:
| User     | Role         | ExpiredDate | ShouldAccess |
| megauser | Project User | 12.12.2020  | should not   |
And click element 'Add' on page 'ShareWindow'
And wait for '3' seconds
Then I 'should' see activity where user 'SPAAM_EA01_1' shared folder 'PSF501' to user 'megauser' on Dashboard


Scenario: Check that activity appears after share project on unregistred user
Meta:@gdam
@projects
Given I created the agency 'SPAAM_A1' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| SPAAM_EA01_2 | agency.admin | SPAAM_A1     |
And logged in with details of 'SPAAM_EA01_2'
And created 'PSP501' project
When I edit the following fields for 'PSP501' project:
| Name   | Administrators |
| PSP501 | testUser       |
And click Save button on project popup
And wait for '3' seconds
And go to Dashboard page
Then I 'should' see activity where user 'SPAAM_EA01_2' shared project 'PSP501' to user 'testUser' on Dashboard