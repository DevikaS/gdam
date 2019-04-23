!--ORD-1526
Feature:  Default hold for approval per user settings
Narrative:
In order to:
As a AgencyAdmin
I want to perform default hold for approval per user settings

Scenario: Default hold for approval per user settings for music order
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OMDHFASA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OMDHFASU1 | agency.admin | OMDHFASA1   |
And logged in with details of 'OMDHFASU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval |
| <CheckState>             |
And save own Delivery Setting
And go to View Draft Orders tab of 'music' order on ordering page
And create 'music' order on View Draft Orders tab on ordering page
Then I '<ShouldState>' see order item held for approval for active cover flow

Examples:
| CheckState | ShouldState |
| should     | should      |
| should not | should not  |

Scenario: Default hold for approval per user settings by use new and copy current for music order
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OMDHFASA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OMDHFASU1 | agency.admin | OMDHFASA1    |
And logged in with details of 'OMDHFASU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval |
| should                   |
And save own Delivery Setting
And created 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code  |
| <ISRCCode> |
And open order item with following isrc code '<ISRCCode>'
And '<Action>' order item by Add Commercial button on order item page
Then I 'should' see order item held for approval for active cover flow

Examples:
| ISRCCode     | Action       |
| OMDHFASCN2_1 | create new   |
| OMDHFASCN2_2 | copy current |

Scenario: Check the save properly works for checkbox Always Hold For Approval confirmed for music order
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OMDHFASA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OMDHFASU1 | agency.admin | OMDHFASA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMDHFASA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OMDHFASAR3 | OMDHFASBR3 | OMDHFASSB3 | OMDHFASP3 |
And logged in with details of 'OMDHFASU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval |
| <CheckState>             |
And save own Delivery Setting
And created 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label     | Artist    | ISRC Code  | Release Date | Format         | Title     | Destination                 |
| automated test info    | OMDHFASAR3     | OMDHFASBR3 | OMDHFASSB3 | OMDHFASP3 | OMDHFASC3 | <ISRCCode> | 12/14/2022   | HD 1080i 25fps | OMDHFAST3 | BSkyB Green Button:Standard |
And completed order contains item with isrc code '<ISRCCode>' with following fields:
| Job Number | PO Number   |
| OMDHFASJN3 | OMDHFASPN3 |
And go to View Live Orders tab of 'music' order on ordering page
Then I should see count orders '<CountLiveOrders>' on 'View Live Orders' tab in order slider
And should see orders counter '<CountLiveOrders>' above orders list on ordering page
When I select 'View Held Orders' tab on ordering page
Then I should see count orders '<CountHeldOrders>' on 'View Held Orders' tab in order slider
And should see orders counter '<CountHeldOrders>' above orders list on ordering page

Examples:
| CheckState | ISRCCode     | CountLiveOrders | CountHeldOrders |
| should     | OMDHFASCN3_1 | 1               | 1               |
| should not | OMDHFASCN3_2 | 2               | 1               |