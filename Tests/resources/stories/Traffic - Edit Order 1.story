Feature:    Traffic Edit Order
Narrative:
In order to
As a              AgencyAdmin
I want to check edit order feature

Scenario: Check that after adding additional destination, order details in A5 should be changed
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1  | TTVBTVSC1 | TBCCN2_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TBCCN2_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN2_1' will be available in Traffic
And wait till order with clockNumber 'TBCCN2_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN2_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TBCCN2_1' in Traffic
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard     |
| AOL          |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait for '5' seconds
And login with details of 'AgencyAdmin'
And go to Order Summary page for order contains item with following clock number 'TBCCN2_1'
Then I 'should' see following destinations 'Talk Sport,AOL' for clock delivery 'TBCCN2_1' on 'tv' order summary page


Scenario: Check that after cancelling destination, order details in A5 should be changed
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1  | TTVBTVSC1 | TBCCN3_11     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard;AOL:Standard |
And completed order contains item with clock number 'TBCCN3_11' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN3_11' will be available in Traffic
And wait till order with clockNumber 'TBCCN3_11' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN3_11' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TBCCN3_11' in Traffic
And cancel following destinations for Select Broadcast Destinations form on order item page 'AOL'
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait for '5' seconds
And login with details of 'AgencyAdmin'
And go to Order Summary page for order contains item with following clock number 'TBCCN3_11'
Then I 'should' see that following destinations 'AOL' are cancelled for clock delivery 'TBCCN3_11' on 'tv' order summary page

Scenario: Check that after cancelling  destination, order details in Traffic list should be changed
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1| TTVBTVSP1 | TTVBTVSC1 | TBCCN5_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard;AOL:Standard |
And completed order contains item with clock number 'TBCCN5_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN5_1' will be available in Traffic
And wait till order with clockNumber 'TBCCN5_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN5_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TBCCN5_1' in Traffic
And cancel following destinations for Select Broadcast Destinations form on order item page 'AOL'
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait for '5' seconds
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN5_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destination 'AOL' with Delivery status 'Cancelled' for order item in Traffic List with clockNumber 'TBCCN5_1'

Scenario: Check that after changing SLA for destination, order details in A5 should be changed (in Delivery Report)
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1  | TTVBTVSC1 | TBCCN4_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Express |
And completed order contains item with clock number 'TBCCN4_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN4_1' will be available in Traffic
And wait till order with clockNumber 'TBCCN4_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN4_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TBCCN4_1' in Traffic
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard     |
| Talk Sport   |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait for '5' seconds
And login with details of 'AgencyAdmin'
And go to Order Summary page for order contains item with following clock number 'TBCCN4_1'
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser  | Brand      | Sub Brand  | Product   |   Title   | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Note                | Attachments | Subtitles Required | Delivery Points | Destination  | Service Level |
| TBCCN4_1     |            |           | 1                 | 1                 | United Kingdom | TTVBTVSAR1  | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVST1 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | automated test info |             | Already Supplied   | 1               | Talk Sport   | Standard      |



Scenario: Check that after changing SLA for destination, destination details in Traffic should be changed
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1  | TTVBTVSC1 | TBCCN6_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Express |
And completed order contains item with clock number 'TBCCN6_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN6_1' will be available in Traffic
And wait till order with clockNumber 'TBCCN6_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN6_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TBCCN6_1' in Traffic
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard     |
| Talk Sport   |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait for '5' seconds
And open Traffic Order List page
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'TBCCN6_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destination 'Talk Sport' with service level 'Standard' for order item in Traffic List with clockNumber 'TBCCN6_1'