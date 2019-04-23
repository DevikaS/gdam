!--NGN-19006
Feature: Traffic -  Manual Send To Destination
Narrative:
In order to
As a              AgencyAdmin
I want to manually send an asset to destination

Lifecycle:
Before:
Given updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyOneStage  |       true         |      one      |  |broadcasterTrafficManagerOne |

Scenario: Check that traffic manager can manually push to destination and the internal order should appear in traffic/broadcsater interface and not visible for owner of original order
Meta:@traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand        | Sub Brand  | Product     |
| TMSTDAR1   | TMSTDBR1     | TMSTDSB1   | TMSTDP1     |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TMSTDAR1   | TMSTDBR1   | TMSTDSB1   | TMSTDP1   | TMSTDC1   |TMSTD_CN1     | 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMSTDT1   | Facebook DE:Express |
And completed order contains item with clock number 'TMSTD_CN1' with following fields:
| Job Number  | PO Number |
| TMSTDJN11   | TMSTDPO11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMSTD_CN1' will be available in Traffic
And select 'All' tab in Traffic UI
And I amon order item details page of clockNumber 'TMSTD_CN1'
And I click on 'Edit Asset' button on order item details page in traffic
And I click 'Destinations' TAB on opened asset info page
And wait for '4' seconds
When I manually push an asset to destination:
|Market|Destination|Service Level|
|Germany|TV Bayern Media|Standard|
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMSTD_CN1' in simple search form on Traffic Order List page
Then I should see internal order appeared on Traffic Order List page:
|Market              |
|Germany             |
When I login with details of 'broadcasterTrafficManagerOne'
And enter search criteria 'TMSTD_CN1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destination 'TV Bayern Media' with house number '' for order item in Traffic List with clockNumber 'TMSTD_CN1'
When I logout from account
And login with details of 'AgencyAdmin'
And I open Order List page
Then I should see TV order in 'live' order list with item clock number 'TMSTD_CN1' and following fields:
| Order# | DateTime    | Advertiser |  Brand    |Sub Brand  |Product  |Market          | Status        |
| Digit# | CurrentTime | TMSTDAR1   |  TMSTDBR1 |TMSTDSB1   |TMSTDP1  |Germany         | 0/1 Delivered |
When I go to Order Summary page for order contains item with following clock number 'TMSTD_CN1'
Then I should see clock delivery 'TMSTD_CN1' contains destinations with following fields on 'tv' order summary page:
| Destination | Status       | Time of Delivery | Priority |
| Facebook DE | Order Placed | -                | Express  |


Scenario: Check that internal order delivery status is Transfer Complete
Meta:@traffic
!-- wait is added for Delivery status to change
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination             |
| automated test info    | TMSTDAR1   | TMSTDBR1   | TMSTDSB1   | TMSTDP1   | TMSTDC2   |TMSTD_CN2    | 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMSTDT2   | TV Bayern Media:Standard |
And completed order contains item with clock number 'TMSTD_CN2' with following fields:
| Job Number  | PO Number |
| TMSTDJN22  | TMSTDPO22 |
And waited for finish place order with following item clock number 'TMSTD_CN2' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TMSTD_CN2    |
And I login with details of 'broadcasterTrafficManagerOne'
And wait till order with clockNumber 'TMSTD_CN2' will be available in Traffic
And select 'All' tab in Traffic UI
And I amon order item details page of clockNumber 'TMSTD_CN2'
And wait till order item with clockNumber 'TMSTD_CN2' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page
And click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|      Email                 |  Comment  |
|      test2         |    Test   |
And wait till order item with clockNumber 'TMSTD_CN2' will have broadcaster status 'Delivered' in Traffic
When I login with details of 'trafficManager'
And wait till order with clockNumber 'TMSTD_CN2' will be available in Traffic
And I amon order item details page of clockNumber 'TMSTD_CN2'
And I click on 'Edit Asset' button on order item details page in traffic
And I click 'Destinations' TAB on opened asset info page
And wait for '5' seconds
When I manually push an asset to destination:
|Market|Destination|Service Level|
|Germany|kino.de   |Standard     |
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TMSTD_CN2' will be available in Traffic
And wait for '120' seconds
And enter search criteria 'TMSTD_CN2' in simple search form on Traffic Order List page
Then I should see internal order appeared on Traffic Order List page:
|Market              |
|Germany             |
And I 'should' find 'Delivery Status' for the orders with 'TMSTD_CN2' as 'Transfer Complete' for 'kino.de'

