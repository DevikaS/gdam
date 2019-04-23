Feature:   Traffic Back button behavior
Narrative:
In order to
As a              AgencyAdmin
I want to check that back button redirect to right page



Scenario: Check that back button from Order AND Order Item pages redirect to right place
!--NGN-16243
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TBBBAR1    | TBBBBR1 | TBBBSB1   | TBBBPR1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TBBBAR1    | TBBBBR1 | TBBBSB1   | TBBBPR1 | TTVBTVSC1 | TBBBCN1      | 20       | 12/14/2022     | Already Supplied   | HD 1080i 25fps | TTVBTVST1 | Talk Sport:Standard |
And complete order contains item with clock number 'TBBBCN1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber 'TBBBCN1' will be available in Traffic
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And created tab with name 'BackButton' and type 'Order' and Data Range 'Today' and without conditions in Traffic
And waited till order list will be loaded
And entered search criteria 'TBBBCN1' in simple search form on Traffic Order List page
And opened order details with clockNumber 'TBBBCN1' from Traffic UI
When I open order item details page with clockNumber 'TBBBCN1' from traffic order details page
And click on 'Back' button on order item details page in traffic
And wait till order will be loaded in Traffic UI
And click on 'Back' button on order details page in traffic
And wait till order list will be loaded
Then I 'should' see that tab 'BackButton' is selected