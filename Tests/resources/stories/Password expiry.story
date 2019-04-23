!--NGN-9388
Feature:          Password expiry
Narrative:
In order to
As a              GlobalAdmin
I want to         Check password expiry rules for BU

Scenario: Check default values for password expiry rules for BU
Meta:@globaladmin
     @gdam
!--NGN-556
Given I created the agency 'A_PE_S01' with default attributes
Then I 'should' see following parameters values on agency 'A_PE_S01' security page:
| PasswordExpirationInDays |
| 30                       |


Scenario: Check that user with expired password sees 'Reset password after expiry' page (expiration after reset password)
Meta:@gdam
@gdamemails
Given I created the agency 'A_PE_S02' with default attributes
And created users with following fields:
| Email    | Role         | Agency   | Password   |
| U_PE_S02 | agency.admin | A_PE_S02 | abcdefghA1 |
And updated password rules for agency 'A_PE_S02' with following attributes:
| PasswordExpirationInDays | MinimumPasswordLength | NumbersCount | UppercaseCharactersCount |
| 0                        |                     8 |            1 |                        1 |
And I am on babylon Login page
When I click Reset Password button after typed in the field Email on Reset Password popup following email 'U_PE_S02'
And open link from email when user 'U_PE_S02' received email with next subject 'Your Adbank password reset request'
Then I 'should' see message about password rules on refresh password page with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 8                     | 1                        | 1            |


Scenario: Check that user with expired password sees 'Reset password after expiry' page (expiration after user creation)
Meta:@globaladmin
     @gdam
Given I created the agency 'A_PE_S03' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| U_PE_S03 | agency.admin | A_PE_S03 |
And I logged in with details of 'U_PE_S03'
And I setted expired password for current user '33' before today
When I logout from account
And I trying to login as user with login 'U_PE_S03' and password 'abcdefghA1'
And wait for '3' seconds
Then I 'should' be on the refresh password page

Scenario: Check that user with expired password can refresh password and succesfully login
Meta:@globaladmin
     @gdam
Given I created the agency 'A_PE_S03' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| U_PE_S03 | agency.admin | A_PE_S03 |
And I logged in with details of 'U_PE_S03'
And I setted expired password for current user '33' before today
When I logout from account
And I trying to login as user with login 'U_PE_S03' and password 'abcdefghA1'
And wait for '3' seconds
Then I 'should' be on the refresh password page
When I fill and confirm refresh password form after expiry for user 'U_PE_S03' with following data:
| NewPassword       | ConfirmPassword   |OldPassword  |
| zyxwvutsR91       | zyxwvutsR91       |abcdefghA1   |
And wait for '5' seconds
And login as user with name 'U_PE_S03' and password 'zyxwvutsR91'
Then I 'should' be on the Dashboard page


Scenario: Check that user should set password according to BU's password rules (state of 'Refresh' button)
Meta:@gdamemails
     @gdam
Given I created the agency 'A_PE_S04' with default attributes
And created users with following fields:
| Email       | Role        | Agency   | Password    |
| <UserEmail> | agency.user | A_PE_S04 | abcdefghA12 |
And updated password rules for agency 'A_PE_S04' with following attributes:
| PasswordExpirationInDays | MinimumPasswordLength | NumbersCount | UppercaseCharactersCount |
| 10                       | 8                     | 2            | 1                        |
And I am on babylon Login page
When I click Reset Password button after typed in the field Email on Reset Password popup following email '<UserEmail>'
And open link from email when user '<UserEmail>' received email with next subject 'Your Adbank password reset request'
And refresh password for user '<UserEmail>' with following data:
| NewPassword       | ConfirmPassword   |
| <NewUserPassword> | <NewUserPassword> |
Then I '<Condition>' see error message 'Your password does not match password strength guidelines.' on the refresh password page

Examples:
| UserEmail  | NewUserPassword | Condition  |
| U_PE_S04_1 | qwert12A        | should not |
| U_PE_S04_2 | qwer12A         | should     |
| U_PE_S04_3 | qwert1AA        | should     |
| U_PE_S04_4 | qwert12a        | should     |


Scenario: Check that user login after entering password according to password rules
Meta:@gdamemails
     @gdam
Given I created the agency 'A_PE_S05' with default attributes
And created users with following fields:
| Email    | Role        | Agency   |
| U_PE_S05 | agency.user | A_PE_S05 |
And updated password rules for agency 'A_PE_S05' with following attributes:
| PasswordExpirationInDays | MinimumPasswordLength | NumbersCount | UppercaseCharactersCount |
| 0                        | 8                     | 1            | 1                        |
And I am on babylon Login page
When I click Reset Password button after typed in the field Email on Reset Password popup following email 'U_PE_S05'
And open link from email when user 'U_PE_S05' received email with next subject 'Your Adbank password reset request'
And update password rules for agency 'A_PE_S05' with following attributes:
| PasswordExpirationInDays |
| 1                        |
And refresh password for user 'U_PE_S05' with following data:
| NewPassword | ConfirmPassword |
| zyxwvutsR91 | zyxwvutsR91     |
And wait for '3' seconds
And logout from account
And login as user with name 'U_PE_S05' and password 'zyxwvutsR91'
Then I 'should' be on the Dashboard page



Scenario: Check that user can login with new password (change after expiry)
Meta:@gdamemails
     @gdam
Given I created the agency 'A_PE_S07' with default attributes
And created users with following fields:
| Email    | Role        | Agency   |
| U_PE_S07 | agency.user | A_PE_S07 |
And updated password rules for agency 'A_PE_S07' with following attributes:
| PasswordExpirationInDays | MinimumPasswordLength | NumbersCount | UppercaseCharactersCount |
| 0                        | 8                     | 1            | 1                        |
And I am on babylon Login page
When I click Reset Password button after typed in the field Email on Reset Password popup following email 'U_PE_S07'
And open link from email when user 'U_PE_S07' received email with next subject 'Your Adbank password reset request'
And update password rules for agency 'A_PE_S07' with following attributes:
| PasswordExpirationInDays |
| 1                        |
And refresh password for user 'U_PE_S07' with following data:
| NewPassword | ConfirmPassword |
| zyxwvutsR91 | zyxwvutsR91     |
And wait for '15' seconds
And logout from account
And login as user with name 'U_PE_S07' and password 'zyxwvutsR91'
Then I 'should' be on the Dashboard page


Scenario: Check some pages after log in from Refresh password form (Projects and Library)
Meta: @gdam
      @qagdamsmoke
	  @livegdamsmoke
	  @gdamemails
Given I created users with following fields:
| Email    | Role        |Agency       |Access|
| U_PE_S06 | agency.user |DefaultAgency|streamlined_library,library,adkits,folders|
And updated password rules for agency 'DefaultAgency' with following attributes:
| PasswordExpirationInDays | MinimumPasswordLength | NumbersCount | UppercaseCharactersCount |
| 0                        | 8                     | 1            | 1                        |
And I am on babylon Login page
When I click Reset Password button after typed in the field Email on Reset Password popup following email 'U_PE_S06'
And open link from email when user 'U_PE_S06' received email with next subject 'Your Adbank password reset request'
And update password rules for agency 'DefaultAgency' with following attributes:
| PasswordExpirationInDays |
| 1                        |
And wait for '3' seconds
And refresh password for user 'U_PE_S06' with following data:
| NewPassword | ConfirmPassword |
| zyxwvutsR91 | zyxwvutsR91     |
And wait for '3' seconds
And logout from account
And login as user with name 'U_PE_S06' and password 'zyxwvutsR91'
And I am on the library assets page
Then I 'should' be on 'New Library' PageNEWLIB
When I go to Project list page
Then I 'should' see Projects page
