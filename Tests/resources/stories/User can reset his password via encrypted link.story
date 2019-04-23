Feature:             User can reset his password via encrypted link
Narrative:
In order to
As a                 AgencyAdmin
I want to            User can reset his password via encrypted link


Scenario: Check that user could upload files to project after refresh password
Meta:@gdam
@projects
!--Run with SSO enabled in config / box
Given created users with following fields:
| Email       | Role         |
| U_LPTG_NU_1 | agency.admin |
And I logout from account
When click Reset Password button after typed in the field Email on Reset Password popup following email 'U_LPTG_NU_1'
And open link from email with subject 'Your Adbank password reset request' which user 'U_LPTG_NU_1' received
And refresh password for user 'U_LPTG_NU_1' with following data:
| NewPassword | ConfirmPassword |
| abcdefghA1  | abcdefghA1      |
And logout from account
And login as user with name 'U_LPTG_NU_1' and password 'abcdefghA1'
And create 'P_LPTG_NU_1' project
And create '/F2' folder for project 'P_LPTG_NU_1'
And upload '/files/image10.jpg' file into '/F2' folder for 'P_LPTG_NU_1' project
And wait while file '/files/image10.jpg' fully uploaded to folder folder '/F2' of project 'P_LPTG_NU_1'
Then Files preview should be available on project 'P_LPTG_NU_1' overview page

Scenario: Check that after user refresh page, he will receive confirmation email
Meta:@gdam
@gdamemails
!--Run with SSO enabled in config / box
Given created users with following fields:
| Email        | Role        |
| U_LPTG_NU_2 | agency.admin |
And I logout from account
When click Reset Password button after typed in the field Email on Reset Password popup following email 'U_LPTG_NU_2'
And open link from email with subject 'Your Adbank password reset request' which user 'U_LPTG_NU_2' received
And refresh password for user 'U_LPTG_NU_2' with following data:
| NewPassword | ConfirmPassword |
| abcdefghA1  | abcdefghA1      |
Then I 'should' see email with subject 'Your Adbank password has been changed' sent to user 'U_LPTG_NU_2' and body contains 'You Adbank password has been changed. If it was not you who changed this password, please contact Adbank support.'


Scenario: Check that after user refresh page, link to refresh page currently redirect to log in page
Meta:@gdam
@gdamemails
!--Run with SSO enabled in config / box
Given created users with following fields:
| Email        | Role        |
| U_LPTG_NU_3 | agency.admin |
And I logout from account
When click Reset Password button after typed in the field Email on Reset Password popup following email 'U_LPTG_NU_3'
And open link from email with subject 'Your Adbank password reset request' which user 'U_LPTG_NU_3' received
And refresh password for user 'U_LPTG_NU_3' with following data:
| NewPassword | ConfirmPassword |
| abcdefghA1  | abcdefghA1      |
And I logout from account
And open link from email with subject 'Your Adbank password reset request' which user 'U_LPTG_NU_3' received
Then I 'should' see login page


Scenario: Check that BU password rules are validate entered password on refresh page
Meta:@gdam
@gdamemails
!--Run with SSO enabled in config / box
Given I created the following agency:
| Name          |
| A_LPTG_New_01 |
And created users with following fields:
| Email        | Role         | Agency        |
| U_LPTG_NU_4  | agency.admin | A_LPTG_New_01 |
And updated password rules for agency 'A_LPTG_New_01' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 2                        | 2            |
And I logout from account
When click Reset Password button after typed in the field Email on Reset Password popup following email 'U_LPTG_NU_4'
And open link from email with subject 'Your Adbank password reset request' which user 'U_LPTG_NU_4' received
And refresh password for user 'U_LPTG_NU_4' with following data:
| NewPassword | ConfirmPassword |
| abcdefghA1  | abcdefghA1      |
Then I 'should' see error message 'Your password does not match password strength guidelines.' on the page on clicking refresh password
And 'should' be on the reset password page
