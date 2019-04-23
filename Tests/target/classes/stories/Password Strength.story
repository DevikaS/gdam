!--NGN-9384
Feature:          Password strength
Narrative:
In order to
As a              GlobalAdmin
I want to         Check features of password strength

Scenario: Check the default values for password rules
Meta:@globaladmin
     @gdam
Given I created the agency 'A_PS_S01' with default attributes
Then I 'should' see following parameters values on agency 'A_PS_S01' security page:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 8                     | 1                        | 1            |


Scenario: Check password strength rule at creating new user
Meta:@globaladmin
     @gdam
Given I created the agency 'A_PS_S02' with default attributes
And updated password rules for agency 'A_PS_S02' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |
And created users with following fields:
| Email     | Role         | Agency   |
| AU_PS_S02 | agency.admin | A_PS_S02 |
And logged in with details of 'AU_PS_S02'
When I go to Create New User page
And fill following fields on user opened details page:
| FirstName       | LastName       | Email       | Password       | Access          | Role        |
| <UserFirstName> | <UserLastName> | <UserEmail> | <UserPassword> | library,folders | agency.user |
And click save on users details page with no Timezone
Then I '<Condition>' see '<UserEmail>' in User list

Examples:
| UserFirstName | UserLastName | UserEmail   | UserPassword | Condition  |
| Eric          | Cartman      | AU_PS_S02_1 | abF5         | should     |
| Stan          | Marsh        | AU_PS_S02_2 | test         | should not |
| Kenny         | McCormick    | AU_PS_S02_3 | TEST         | should not |
| Kyle          | Broflovski   | AU_PS_S02_4 | 12345        | should not |


Scenario: Check password guidance on Add new user page
Meta:@globaladmin
     @gdam
Given I created the agency 'A_PS_S03' with default attributes
And updated password rules for agency 'A_PS_S03' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |
And created users with following fields:
| Email     | Role         | Agency   |
| AU_PS_S03 | agency.admin | A_PS_S03 |
And logged in with details of 'AU_PS_S03'
When I go to Create New User page
Then I 'should' see message about password rules on create user page with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |


Scenario: Check password rule guidance on current user Account settings page
Meta:@globaladmin
     @gdam
!--NGN-7456
Given I created the agency 'A_PS_S04' with default attributes
And updated password rules for agency 'A_PS_S04' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |
And created users with following fields:
| Email     | Role         | Agency   |
| AU_PS_S04 | agency.admin | A_PS_S04 |
And logged in with details of 'AU_PS_S04'
Then I 'should' see message about password rules on my Account Settings page with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |


Scenario: Check password rule at changing password by user
Meta:@globaladmin
     @gdam
Given I created the agency 'A_PS_S05' with default attributes
And updated password rules for agency 'A_PS_S05' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |
And created users with following fields:
| Email       | Role         | Agency   |
| <UserEmail> | agency.admin | A_PS_S05 |
And logged in with details of '<UserEmail>'
When I change current user's password 'abcdefghA1' to following new password '<UserPassword>' and confirm password '<UserPassword>' on my Account Settings page
And logout from account
And login to system as user with name '<UserEmail>' and password '<UserPassword>'
Then I '<Condition>' be on the Dashboard page

Examples:
| UserEmail  | UserPassword | Condition  |
| U_PS_S05_1 | abF5         | should     |
| U_PS_S05_2 | test         | should not |
| U_PS_S05_3 | TEST         | should not |
| U_PS_S05_4 | 12345        | should not |


Scenario: Check password rule guidance on user Account settings page
Meta:@globaladmin
     @gdam
!--NGN-7456
Given I created the agency 'A_PS_S06' with default attributes
And updated password rules for agency 'A_PS_S06' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |
And created users with following fields:
| Email     | Role         | Agency   |
| AU_PS_S06 | agency.admin | A_PS_S06 |
| U_PS_S06  | agency.user  | A_PS_S06 |
And logged in with details of 'AU_PS_S06'
Then I 'should' see message about password rules on user 'U_PS_S06' settings page with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |


Scenario: Check password rule at changing password for user
Meta:@globaladmin
     @gdam
Given I created the agency 'A_PS_S07' with default attributes
And updated password rules for agency 'A_PS_S07' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |
And created users with following fields:
| Email             | Role         | Agency   |
| <AdminUserEmail>  | agency.admin | A_PS_S07 |
| <TestedUserEmail> | agency.user  | A_PS_S07 |
And logged in with details of '<AdminUserEmail>'
And on user '<TestedUserEmail>' Account Settings page
When I change current user's password 'abcdefghA1' to following new password '<UserPassword>' and confirm password '<UserPassword>' on user '<TestedUserEmail>' Account Settings page
And logout from account
And login to system as user with name '<TestedUserEmail>' and password '<UserPassword>'
Then I '<Condition>' be on the Dashboard page

Examples:
| AdminUserEmail | TestedUserEmail | UserPassword | Condition  |
| U_PS_S07_1     | U_PS_S07_1      | abF5         | should     |
| U_PS_S07_2     | U_PS_S07_2      | test         | should not |
| U_PS_S07_3     | U_PS_S07_3      | TEST         | should not |
| U_PS_S07_4     | U_PS_S07_4      | 12345        | should not |


Scenario: Check email with subject 'Your new Adbank login details' after click reset password button
Meta:@globaladmin
     @gdam
Given I created the agency 'A_PS_S08' with default attributes
And updated password rules for agency 'A_PS_S08' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |
And created users with following fields:
| Email    | Role        | Agency   |
| U_PS_S08 | agency.user | A_PS_S08 |
And I am on babylon Login page
When I click Reset Password button after typed in the field Email on Reset Password popup following email 'U_PS_S08'
Then I 'should' see that user 'U_PS_S08' received email with subject 'Your Adbank password reset request' and password generated according to agency 'A_PS_S08' password rules