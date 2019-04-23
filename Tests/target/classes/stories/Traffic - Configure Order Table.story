!--NGN-19000
Feature: Traffic -  Configure Order Table
Narrative:
In order to
As a              AgencyAdmin
I want to configure the order and item table

Scenario: Check that traffic manager can hide/unhide the items in order item table
Meta:     @traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TCTAR1     | TCTBR1     | TCTSB1     | TCTP1     |
| TCTAR2     | TCTBR2     | TCTSB2     | TCTP2     |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCTAR1     | TCTBR1     | TCTSB1     | TCTP1     | TCTC1     |TCT_CN1       | 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And completed order contains item with clock number 'TCT_CN1' with following fields:
| Job Number  | PO Number |
| TCTJN11     | TCTPO11   |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCT_CN1' will be available in Traffic
And select 'All' tab in Traffic UI
When I 'hide' order item table items:
|Item Name|
|First Air Date|
|Duration|
And enter search criteria 'TCT_CN1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should not' see the items on order item table:
|Item Name|
|First Air Date|
|Duration|
When I 'unhide' order item table items:
|Item Name|
|First Air Date|
|Duration|
Then I 'should' see the items on order item table:
|Item Name|
|First Air Date|
|Duration|


Scenario: Check that traffic manager can hide/unhide the items in order table
Meta:     @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCTAR1     | TCTBR1     | TCTSB1     | TCTP1     | TCTC1     |TCT_CN2       | 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And completed order contains item with clock number 'TCT_CN2' with following fields:
| Job Number  | PO Number |
| TCTJN11     | TCTPO11   |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCT_CN2' will be available in Traffic
And select 'All' tab in Traffic UI
When I 'hide' order table items:
|Item Name|
|Submitted Date|
|PO Number|
Then I 'should not' see the items on order table:
|Item Name|
|Submitted Date|
|PO Number|
When I 'unhide' order table items:
|Item Name|
|Submitted Date|
|PO Number|
Then I 'should' see the items on order table:
|Item Name|
|Submitted Date|
|PO Number|




