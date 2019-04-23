!--NGN-32 NGN-1343
Feature:          Templates Teams - Common
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Templates Teams - Common

Scenario: Check that 'Users on this template' count is increased after adding new user
Meta:@gdam
@projects
Given I created 'TTCT1' template
And created '/TTCF1' folder for template 'TTCT1'
And created users with following fields:
| Email   | Role       |
| TTCU1_1 | guest.user |
| TTCU1_2 | guest.user |
| TTCU1_3 | guest.user |
And created 'TTCR1' role in 'project' group for advertiser 'DefaultAgency'
And I am on template 'TTCT1' teams page
When I add user '<UserName>' into template 'TTCT1' team with role 'TTCR1' expired '12.12.2021' for folder pop up '/TTCF1'
Then I should see users count '<Count>' on template 'TTCT1' team

Examples:
| UserName | Count |
| TTCU1_1  | 2     |
| TTCU1_2  | 3     |
| TTCU1_3  | 4     |


Scenario: Check that 'Users on this template' count is decreased after removing new user
Meta:@gdam
@projects
Given I created 'TTCT2' template
And created '/TTCF2' folder for template 'TTCT2'
And created users with following fields:
| Email   | Role       |
| TTCU2_1 | guest.user |
| TTCU2_2 | guest.user |
| TTCU2_3 | guest.user |
And created 'TTCR2' role in 'project' group for advertiser 'DefaultAgency'
And added users '<Users>' to template 'TTCT2' team folders '/TTCF2' with role 'TTCR2' expired '12.12.2021'
And I am on template 'TTCT2' teams page
When I select user '<UserName>' on template 'TTCT2' team page
And I wait for '1' seconds
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
And I refresh the page
Then I should see users count '<Count>' on template 'TTCT2' team

Examples:
| Users                   | UserName | Count |
| TTCU2_1,TTCU2_2,TTCU2_3 | TTCU2_1  | 3     |
| TTCU2_2,TTCU2_3         | TTCU2_2  | 2     |
| TTCU2_3                 | TTCU2_3  | 1     |


Scenario: Logo of user should be displayed on Team page
Meta:@gdam
@projects
Given I created 'TTCT3' template
And created '/TTCF3' folder for template 'TTCT3'
And created users with following fields:
| Email | Role       | Logo |
| TTCU3 | guest.user | GIF  |
And created 'TTCR3' role in 'project' group for advertiser 'DefaultAgency'
And I am on template 'TTCT3' teams page
When I add user 'TTCU3' into template 'TTCT3' team with role 'TTCR3' expired '12.12.2021' for folder pop up '/TTCF3'
Then I should see logo 'GIF' for user 'TTCU3' on template 'TTCT3' team page


Scenario: Check correct work of 'Select All' checkbox
Meta: @skip
      @gdam
Given I created 'TTCT4' template
And created '/TTCF4' folder for template 'TTCT4'
And created users with following fields:
| Email   | Role       |
| TTCU4_1 | guest.user |
| TTCU4_2 | guest.user |
| TTCU4_3 | guest.user |
And created 'TTCR4' role in 'project' group for advertiser 'DefaultAgency'
And added users 'TTCU4_1,TTCU4_2,TTCU4_3' to template 'TTCT4' team folders '/TTCF4' with role 'TTCR4' expired '12.12.2021'
And I am on template 'TTCT4' teams page
When I click element 'SelectAllCheckBox' on page 'TeamsPage'
Then I should see users count '4' selected on template 'TTCT4' team