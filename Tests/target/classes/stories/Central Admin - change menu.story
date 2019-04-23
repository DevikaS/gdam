!-- NGN-4309
Feature:          Central Admin - change menu
Narrative:
In order to
As a              GlobalAdmin
I want to         Check menu for global admin user




Scenario: Check default page after log in and top level menu
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
Then I should see interface 'units'
And I 'should' see following elements on page 'BasePage':
| element   |
| Billing   |
| Roles     |
| Metadata  |
| Passwords  |
| Mail Templates  |
| Holidays  |


Scenario: Check top right dropdown menu
Meta:@globaladmin
     @gdam
!-- NGN-4309
Given I logged in as 'GlobalAdmin'
When I click element 'MainMenu' on page 'BasePage'
Then I 'should not' see following elements on page 'BasePage':
| element         |
| AddressBookMenu |
| BillingMenu     |
| RolesMenu       |
And 'should' see element 'Logout' on page 'BasePage'




Scenario: Check tabs on Role page
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
When I click on element 'Roles'
Then I should see global roles page
And I 'should not' see following elements on page 'Roles':
| element    |
| Users      |
| Categories |
| Branding   |
And I 'should' see element 'Permissions for all business units' on roles page


Scenario: Check 'Log off' functionality
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
When I click element 'MainMenu' on page 'BasePage'
And click on element 'Logout'
Then I 'should' see login page

