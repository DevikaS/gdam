Feature: Login - cake

Meta:


Narrative:
In order to work with the system
As a Guest
I want to be able to login

Scenario: Notification about incorrect username
!-- NGN-515
Given I am on babylon Login page
When I fill fields login '<login>' and password '<password>'
And click on element 'LoginButton'
Then I 'should' see 'error' message notification '<message>' on Login page

Examples:
| login                | password | message                                                       |
| agencyadmin@test.com | @#$      | {"error":"Error: Login failed. Incorrect email or password."} |
| #$@                  | 1        | {"error":"Error: Login failed. Incorrect email or password."} |
|                      |          | All fields should be filled                                   |


Scenario: Sucessful login
!-- NGN-515
Given I am on babylon Login page
When I login as 'AgencyAdmin'
Then I should see page 'home'