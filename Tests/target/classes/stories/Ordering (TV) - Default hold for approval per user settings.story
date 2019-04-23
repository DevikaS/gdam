!--ORD-1275
Feature:  Default hold for approval per user settings
Narrative:
In order to:
As a AgencyAdmin
I want to perform default hold for approval per user settings

Scenario: Default hold for approval per user settings
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVDHFASA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDHFASU1 | agency.admin | OTVDHFASA1   |
And logged in with details of 'OTVDHFASU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval |
| <CheckState>             |
And save own Delivery Setting
And go to View Draft Orders tab of 'tv' order on ordering page
And create 'tv' order on View Draft Orders tab on ordering page
Then I '<ShouldState>' see order item held for approval for active cover flow

Examples:
| CheckState | ShouldState |
| should     | should      |
| should not | should not  |

Scenario: Default hold for approval per user settings by use new and copy current
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVDHFASA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDHFASU1 | agency.admin | OTVDHFASA1   |
And logged in with details of 'OTVDHFASU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval |
| should                   |
And save own Delivery Setting
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And open order item with following clock number '<ClockNumber>'
And '<Action>' order item by Add Commercial button on order item page
Then I 'should' see order item held for approval for active cover flow

Examples:
| ClockNumber   | Action       |
| OTVDHFASCN2_1 | create new   |
| OTVDHFASCN2_2 | copy current |

Scenario: Check the save properly works for checkbox Always Hold For Approval for confirmed order
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVDHFASA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDHFASU1 | agency.admin | OTVDHFASA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVDHFASA1':
| Advertiser  | Brand       | Sub Brand   | Product    |
| OTVDHFASAR3 | OTVDHFASBR3 | OTVDHFASSB3 | OTVDHFASP3 |
And logged in with details of 'OTVDHFASU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval |
| <CheckState>             |
And save own Delivery Setting
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product    | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVDHFASAR3 | OTVDHFASBR3 | OTVDHFASSB3 | OTVDHFASP3 | OTVDHFASC3 | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | OTVDHFAST3 | Already Supplied   | BSkyB Green Button:Standard |
And completed order contains item with clock number '<ClockNumber>' with following fields:
| Job Number  | PO Number   |
| OTVDHFASJN3 | OTVDHFASPN3 |
And go to View Live Orders tab of 'tv' order on ordering page
Then I should see count orders '<CountLiveOrders>' on 'View Live Orders' tab in order slider
And should see orders counter '<CountLiveOrders>' above orders list on ordering page
When I select 'View Held Orders' tab on ordering page
Then I should see count orders '<CountHeldOrders>' on 'View Held Orders' tab in order slider
And should see orders counter '<CountHeldOrders>' above orders list on ordering page

Examples:
| CheckState | ClockNumber   | CountLiveOrders | CountHeldOrders |
| should     | OTVDHFASCN3_1 | 1               | 1               |
| should not | OTVDHFASCN3_2 | 2               | 1               |