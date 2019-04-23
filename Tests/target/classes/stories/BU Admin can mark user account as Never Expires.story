!--NGN-8846
Feature:          BU Admin can mark user account as never expires
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check behavior of users with 'Password never expires' option on

Scenario: Check that checkbox 'Password never expires' is present on user details page
Meta:@gdam
     @projects
Given I created users with following fields:
| Email         | Role        |
| U_BUASPNE_S01 | agency.user |
Then I 'should' see checkbox 'Password never expires' on user 'U_BUASPNE_S01' settings page


Scenario: Check that non admin user does not see 'Password never expires' checkbox on user settings page
Meta:@gdam
     @projects
Given I created users with following fields:
| Email         | Role        |
| U_BUASPNE_S02 | agency.user |
When I login with details of 'U_BUASPNE_S02'
And go on my profile page
Then I 'should not' see checkbox 'Password never expires' on my profile page


Scenario: Check that after turn on 'Password never expires' option user can login with expired password
Meta:@gdam
     @projects
Given I created the agency 'A_BUASPNE_S03' with default attributes
And created users with following fields:
| Email         | Role        | PasswordNeverExpires | Agency        |
| U_BUASPNE_S03 | agency.user | true                 | A_BUASPNE_S03 |
And updated password rules for agency 'A_BUASPNE_S03' with following attributes:
| PasswordExpirationInDays |
| 0                        |
When I login with details of 'U_BUASPNE_S03'
Then I 'should' be on the Dashboard page


Scenario: Check that after turn off 'Password never expires' option works regular behaviour
Meta:@gdam
     @projects
Given I created the agency 'A_BUASPNE_S04' with default attributes
And created users with following fields:
| Email          | Role         | PasswordNeverExpires | Agency        |
| AU_BUASPNE_S04 | agency.admin | true                 | A_BUASPNE_S04 |
| U_BUASPNE_S04  | agency.user  | true                 | A_BUASPNE_S04 |
When I login with details of 'AU_BUASPNE_S04'
And deselect 'Password never expires' option on user 'U_BUASPNE_S04' settings page
When I login with details of 'U_BUASPNE_S04'
And set expired password for current user '33' before today
And logout from account
And I trying to login as user with login 'U_BUASPNE_S04' and password 'abcdefghA1'
And wait for '5' seconds
Then I 'should' be on the refresh password page