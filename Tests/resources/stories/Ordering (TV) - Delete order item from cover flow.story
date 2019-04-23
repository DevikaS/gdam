!--ORD-367
!--ORD-612
Feature: Delete a order item on cover flow
Narrative:
In order to:
As a AgencyAdmin
I want to check a correct deletion of order item on cover flow

Scenario: Check that single order item within order cannot be deleted from cover flow of order details
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVDOICFA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDOICFU1 | agency.admin | OTVDOICFA1   |
And logged in with details of 'OTVDOICFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| OTVDOICFCN1_1 |
| OTVDOICFCN1_2 |
When I open order item with following clock number 'OTVDOICFCN1_2'
And delete active order item on cover flow
Then I should see for active order item on cover flow following data:
| Clock Number  |
| OTVDOICFCN1_1 |
And 'should not' see Cross button for active order item on cover flow

Scenario: Check that only active order item can be deleted
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVDOICFA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDOICFU1 | agency.admin | OTVDOICFA1   |
And logged in with details of 'OTVDOICFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| OTVDOICFCN2_1 |
| OTVDOICFCN2_2 |
When I open order item with following clock number 'OTVDOICFCN2_1'
Then I should see for active order item on cover flow following data:
| Clock Number  |
| OTVDOICFCN2_1 |
And 'should' see Cross button for active order item on cover flow
And 'should not' see Cross button for order item with following clock number 'OTVDOICFCN2_2' on cover flow

Scenario: Check that counter of order item is decreased in case to delete order item from cover flow
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVDOICFA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDOICFU1 | agency.admin | OTVDOICFA1   |
And logged in with details of 'OTVDOICFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| OTVDOICFCN3_1 |
| OTVDOICFCN3_2 |
| OTVDOICFCN3_3 |
When I open order item with following clock number 'OTVDOICFCN3_1'
And delete active order item on cover flow
Then I should see for active order item on cover flow following data:
| Clock Number  | Counter |
| OTVDOICFCN3_2 | 1 of 2  |

Scenario: Check that after deletion order item previous one is selected on cover flow
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVDOICFA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDOICFU1 | agency.admin | OTVDOICFA1   |
And logged in with details of 'OTVDOICFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| OTVDOICFCN4_1 |
| OTVDOICFCN4_2 |
| OTVDOICFCN4_3 |
When I open order item with following clock number 'OTVDOICFCN4_3'
And delete active order item on cover flow
Then I should see for active order item on cover flow following data:
| Clock Number  | Counter |
| OTVDOICFCN4_2 | 2 of 2  |

Scenario: Check deletion of order item on cover flow
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVDOICFA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDOICFU1 | agency.admin | OTVDOICFA1   |
And logged in with details of 'OTVDOICFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| OTVDOICFCN5_1 |
| OTVDOICFCN5_2 |
| OTVDOICFCN5_3 |
When I open order item with following clock number 'OTVDOICFCN5_2'
And delete active order item on cover flow
Then I should see for active order item on cover flow following data:
| Clock Number  | Counter |
| OTVDOICFCN5_3 | 2 of 2  |
And 'should not' see order item with following clock number 'OTVDOICFCN5_2' on cover flow