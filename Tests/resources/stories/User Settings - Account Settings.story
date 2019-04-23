!--NGN-1133
Feature:          User Settings - Account Settings
Narrative:
In order to
As a              AgencyAdmin
I want to         Check account settings

Scenario: Successfully change password by admin
Meta: @gdam
@projects
Given I created users with following fields:
| Email      | Role         | Password     |
| U_USAS_S01 | agency.admin | UserPassw0rd |
And on user 'U_USAS_S01' Account Settings page
When I change current user's password 'UserPassw0rd' to following new password 'NewUserPassw0rd' and confirm password 'NewUserPassw0rd' on user 'U_USAS_S01' Account Settings page
Then I should see message warning 'New password has been set to user'


Scenario: Unsuccessfully change password by admin
Meta: @gdam
@projects
!--NGN-3126
Given I created users with following fields:
| Email      | Role         | Password     |
| U_USAS_S02 | agency.admin | UserPassw0rd |
And on user 'U_USAS_S02' Account Settings page
When I change current user's password 'UserPassw0rd' to following new password 'NewUserPassw0rd' and confirm password 'UserPassw0rdNew' on user 'U_USAS_S02' Account Settings page
Then I 'should' see red inputs on page


Scenario: Log in system with new password
Meta: @gdam
@projects
Given I created users with following fields:
| Email      | Role         | Password     |
| U_USAS_S03 | agency.admin | UserPassw0rd |
And on user 'U_USAS_S03' Account Settings page
When I change current user's password 'UserPassw0rd' to following new password 'NewUserPassw0rd' and confirm password 'NewUserPassw0rd' on user 'U_USAS_S03' Account Settings page
And login as user with name 'U_USAS_S03' and password 'NewUserPassw0rd'
Then I should see page 'home'


Scenario: Successfully change own password user
Meta: @gdam
@projects
Given I created users with following fields:
| Email      | Role        | Password     |
| U_USAS_S04 | agency.user | UserPassw0rd |
And logged in as user with name 'U_USAS_S04' and password 'UserPassw0rd'
And on my Account Setting page
When I change current user's password 'UserPassw0rd' to following new password 'NewUserPassw0rd' and confirm password 'NewUserPassw0rd' on my Account Settings page
Then I should see message warning 'New password has been set to user'


Scenario: Unsuccessfully change own password user
Meta: @gdam
@projects
!--NGN-3126
Given I created users with following fields:
| Email      | Role        | Password     |
| U_USAS_S05 | agency.user | UserPassw0rd |
And logged in as user with name 'U_USAS_S05' and password 'UserPassw0rd'
And on my Account Setting page
When I change current user's password 'UserPassw0rd' to following new password '321' and confirm password '123' on my Account Settings page
Then I 'should' see red inputs on page


Scenario: check that Save button isn't clickable without filling all mandatory data
Meta: @gdam
@projects
Given I created users with following fields:
| Email      | Role         | Password     |
| U_USAS_S06 | agency.admin | UserPassw0rd |
And on user 'U_USAS_S06' Account Settings page
When I typed following current password '1' new password '<Password>' and confirm password '<ConfirmPassword>' on user 'U_USAS_S06' Account Settings page
Then I should see element 'Save' on page 'AccountSetting' in following state '<State>'

Examples:
| Password     | ConfirmPassword | State    |
|              |                 | disabled |
| UserPassw0rd |                 | disabled |
|              | UserPassw0rd    | disabled |
| UserPassw0rd | UserPassw0rd    | enabled  |