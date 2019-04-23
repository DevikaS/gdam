!--NGN-21
Feature:          Lost Password functionality
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Lost Password functionality

Scenario: Check that when the user clicks Lost Password link, this should open a new form
Meta:@gdam
@projects
Given I am on babylon Login page
When I click element 'ForgotPassword' on page 'Login'
Then I 'should' see element 'ResetPasswordPopUp' on page 'Login'


Scenario: Check that accept both valid and email address
!--NGN-3707
!-- 30/09:Accepts both valid and invalid email ids.."this was flagged by security audit that we should not betray that some emails are not registered in db!"
!--!--10/03/2017 Mark S changes this behaviour in cosmos to throw an error if its invalid email id. he is checking now on how it should behave. changing scenario for now.
!--21/03 - mark s reverted teh code back to how it was before TD-180
Meta:@gdam
@gdamemails
Given I am on babylon Login page
When I click Reset Password button after an following text '<Text>' typed in the field Email on Reset Password popup
Then I 'should not' see element 'ResetPasswordPopUp' on page 'Login'
And 'should' see 'success' message notification 'Your password has been sent to your email address.' on Login page

Examples:
| Text      |
| aw1@zxfas |
| qweqwe    |


Scenario: Check that an error should appear if such email is not registered in the system
!-- 30/09:Accepts both valid and invalid email ids.."this was flagged by security audit that we should not betray that some emails are not registered in db!"
!--!--10/03/2017 Mark S changes this behaviour in cosmos to throw an error if its invalid email id. he is checking now on how it should behave. changing scenario for now.
!--21/03 - mark s reverted teh code back to how it was before TD-180
Meta:@gdam
@gdamemails
Given I am on babylon Login page
When I click Reset Password button after typed in the field Email on Reset Password popup following email '<Email>'
Then I 'should not' see element 'ResetPasswordPopUp' on page 'Login'
And 'should' see 'success' message notification 'Your password has been sent to your email address.' on Login page

Examples:
| Email                       |
| notregistereduser@gmail.com |


Scenario: check while reset password there is no any errors if email is valid and registered in system
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email           | Role       |
| LPFU5@email.com | guest.user |
And I am on babylon Login page
When I click Reset Password button after typed in the field Email on Reset Password popup following email 'LPFU5@email.com'
Then I 'should not' see element 'ResetPasswordPopUp' on page 'Login'
And 'should' see 'success' message notification 'Your password has been sent to your email address.' on Login page


Scenario: check that is reset password new password should be generated and sent to user's email
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email | Role       |
| LPFU6 | guest.user |
And I am on babylon Login page
When I click Reset Password button after typed in the field Email on Reset Password popup following email 'LPFU6'
Then I 'should not' see element 'ResetPasswordPopUp' on page 'Login'
And 'should' see 'success' message notification 'Your password has been sent to your email address.' on Login page
And the user 'LPFU6' should received reset password's email with next subject 'Your Adbank password reset request'

Scenario: check that text of received email is correct
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email | Role       |
| LPFU8 | guest.user |
And I am on babylon Login page
And waited for '5' seconds
When I click Reset Password button after typed in the field Email on Reset Password popup following email 'LPFU8'
And wait for '20' seconds
Then I 'should not' see element 'ResetPasswordPopUp' on page 'Login'
And 'should' see 'success' message notification 'Your password has been sent to your email address.' on Login page
And the user 'LPFU8' should receiving reset password's email with next subject 'Your Adbank password reset request' and contains following action 'RESET PASSWORD'

