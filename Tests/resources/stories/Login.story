Feature: Login

Meta:
@category basic
@component login

Narrative:
In order to work with the system
As a Guest
I want to be able to login

Scenario: Notification about incorrect username
!-- NGN-515
Meta:@gdam
@projects
Given I am on babylon Login page
When I fill fields login '<login>' and password '<password>'
And click on element 'LoginButton'
Then I 'should' see 'error' message notification '<message>' on Login page

Examples:
| login                | password | message                                 |
| agencyadmin@test.com | @#$      | The username and password do not match. |
| #$@                  | 1        | The username and password do not match. |
|                      |          | The username and password do not match. |


Scenario: Sucessful login
!-- NGN-515
Meta:@gdam
@projects
Given I am on babylon Login page
When I login as 'AgencyAdmin'
Then I should see page 'home'