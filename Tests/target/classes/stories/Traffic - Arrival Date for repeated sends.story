Feature:    Arrival Date set correctly for repeat sends in Traffic UI
Narrative:
In order to
As a              AgencyAdmin
I want to check approval feature and ACL

Scenario: Arrival Date set correctly for repeat sends on Send Tab in Traffic UI
Meta:@traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser   | Brand        | Sub Brand    | Product     |
| TADRSAR4     | TADRSBR4     | TADRSSB4     | TADRSP4     |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination         | Motivnummer |
| automated test info    | TADRSAR4     | TADRSBR4     | TADRSSB4     | TADRSP4    | TADRSC4    | <ClockNumber>    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TLCMFSRT4  | Motorvision TV:Express  |  1          |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number   | PO Number  |
| TADRSSR14    | TADRSSR14  |
And wait for finish place order with following item clock number '<ClockNumber>' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency    | <ClockNumber>  |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  |  Duration | First Air Date | Subtitles Required | Format         | Title      | Destination         |  Motivnummer  |
| automated test info    | TADRSAR4     | TADRSBR4     | TADRSSB4     | TADRSP4    | TLCMC4    |  20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TLCMFSRT4   | Motorvision TV:Express  |   1           |
And wait for '10' seconds
And open order item with next title 'TLCMFSRT4'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value '<ClockNumber>' for Add media to your order form on order item page
And I add to order for order item at Add media to your order form following assets 'TLCMFSRT4'
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| TADRSSR15 | TADRSSR15 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number '<ClockNumber>' to A4
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber>' with destination 'Motorvision TV' will have the next Destination Status 'Awaiting station release' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria '<ClockNumber>' in simple search form on Traffic Order List page
And wait for '2' seconds
Then I '<condition>' see same '<Field>' for the orders with '<ClockNumber>' for repeated sends for 'Motorvision TV'

Examples:
|ClockNumber	|Field	|condition	|
|TLLCMCN_1	|Arrival Date	|should not	|


