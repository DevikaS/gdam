!-- NGN-16249
Feature: BroadCaster Create new tab
Narrative:
In order to
As a              AgencyAdmin
I want to check filtering in Traffic

Scenario: Check At Transferring button and At destination not shown  when A5 view status is Receiving Media Using Agency User
Meta: @traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TMDSRMAR1  | TMDSRMBR1  | TMDSRMSB1  | TMDSRMSP1 |
And logged in with details of 'AgencyUser'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer |
| automated test info    | TMDSRMAR1 | TMDSRMBR1  | TMDSRMSB1 | TMDSRMSP1 | TMDSRMSC1 | TMDSRMCN_1| 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | TMDSRMST1 | MDF 1:Standard | 1     |
And added to 'tv' order item with clock number 'TMDSRMCN_1' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And completed order contains item with clock number 'TMDSRMCN_1' with following fields:
| Job Number    | PO Number   |
| TFADDSASRSR14 | TFADDSASR14 |
And waited for finish place order with following item clock number 'TMDSRMCN_1' to A4
And I logout from account
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMDSRMCN_1' will be available in Traffic
And wait till order with clockNumber 'TMDSRMCN_1' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TMDSRMCN_1' will have A5 view status 'Received Media' in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And wait for '5' seconds
And I Edit order item with following clock number 'TMDSRMCN_1'
Then I 'should not' see 'At Destination' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page
And I 'should not' see 'Transferring' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page


Scenario: Check At Transferring button and At destination shown after non QCed asset is QCed later
Meta: @traffic
Given I created the following agency:
| Name       |
| A_TMDSRM_s01 |
And created users with following fields:
| Email         | Role         | Agency       |Access|
| AU_TMDSRM_S01 | agency.admin | A_TMDSRM_s01 |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_TMDSRM_s01':
| Advertiser | Brand      | Sub Brand  | Product   |
| TMDSRMAR1  | TMDSRMBR1  | TMDSRMSB1  | TMDSRMSP1 |
And logged in with details of 'AU_TMDSRM_S01'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish6-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish6-Ad.mov'NEWLIB
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer |
| automated test info    | TMDSRMAR1  | TMDSRMBR1  | TMDSRMSB1  | TMDSRMSP1 | TMDSRMSC1 | TMDSRMCN_2| 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | TMDSRMST1 | MDF 1:Standard | 1     |
And added to 'tv' order item with clock number 'TMDSRMCN_2' following asset 'Fish6-Ad.mov' of collection 'My Assets'
And completed order contains item with clock number 'TMDSRMCN_2' with following fields:
| Job Number    | PO Number   |
| TFADDSASRSR14 | TFADDSASR14 |
And waited for finish place order with following item clock number 'TMDSRMCN_2' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TMDSRMCN_2' will be available in Traffic
And wait till order with clockNumber 'TMDSRMCN_2' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TMDSRMCN_2' will have A5 view status 'Received Media' in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And I Edit order item with following clock number 'TMDSRMCN_2'
Then I 'should not' see 'At Destination' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page
And I 'should not' see 'Transferring' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page
When I logout from account
And login with details of 'AU_TMDSRM_S01'
And ingested assests through A5 with following fields:
 | agencyName      | clockNumber      |
 | A_TMDSRM_s01    | TMDSRMCN_2       |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMDSRMCN_2' will be available in Traffic
And wait till order with clockNumber 'TMDSRMCN_2' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TMDSRMCN_2' will have A5 view status 'Passed QC' in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And wait for '5' seconds
And I Edit order item with following clock number 'TMDSRMCN_2'
Then I 'should' see 'At Destination' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page
And I 'should' see 'Transferring' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page


Scenario: Check Delivery status set to Transfer in Progress on clicking Transferring button when Machine is not set up for destination
Meta: @traffic
      @trafficsmoketest
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer  |
| automated test info    | TMDSRMAR1  | TMDSRMBR1  | TMDSRMSB1  | TMDSRMSP1| TMHACMSC1 |TMHACMSCN_1     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMHACMST1   | MDF 1:Express |1 |
And completed order contains item with clock number 'TMHACMSCN_1' with following fields:
| Job Number  | PO Number |
| TMHACMS11   | TMHACMS11 |
And waited for finish place order with following item clock number 'TMHACMSCN_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency  | TMHACMSCN_1  |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMHACMSCN_1' will be available in Traffic
And wait till order with clockNumber 'TMHACMSCN_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order item with clockNumber 'TMHACMSCN_1' will have A5 view status 'Passed QC' in Traffic
And I Edit order item with following clock number 'TMHACMSCN_1'
And click transferring for 'MDF 1' destinations on Select Broadcast Destinations form on order item page:
|  Date       | Time    |
| 10/14/2016  | 10:30 AM   |
And I 'should not' see 'hold' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page
And I 'should' see 'cancel' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order item with clockNumber 'TMHACMSCN_1' with destination 'MDF 1' will have the next Destination Status 'Transfer In Progress' in Traffic
And enter search criteria 'TMHACMSCN_1' in simple search form on Traffic Order List page
When open order details with clockNumber 'TMHACMSCN_1' from Traffic UI
And refresh the page
Then I should see 'TMHACMSCN_1' in delivery status 'Transfer In Progress' in order details page for destination 'MDF 1'


Scenario: Check Delivery status set to Transfer Complete on clicking At destination when Machine is not set up for destination
Meta: @traffic
      @trafficsmoketest
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration  | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer |
| automated test info    | TMDSRMAR1  | TMDSRMBR1  | TMDSRMSB1  | TMDSRMSP1 | TMHACMSC1 |TMHACMSCN_2     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMHACMST1   | MDF 1:Express |  1  |
And completed order contains item with clock number 'TMHACMSCN_2' with following fields:
| Job Number  | PO Number |
| TMHACMS11   | TMHACMS11 |
And waited for finish place order with following item clock number 'TMHACMSCN_2' to A4
When ingested assests through A5 with following fields:
 | agencyName     | clockNumber |
 | DefaultAgency  | TMHACMSCN_2  |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMHACMSCN_2' will be available in Traffic
And wait till order with clockNumber 'TMHACMSCN_2' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And wait for '5' seconds
And wait till order item with clockNumber 'TMHACMSCN_2' will have A5 view status 'Passed QC' in Traffic
And I Edit order item with following clock number 'TMHACMSCN_2'
And click at destination for 'MDF 1' destinations on Select Broadcast Destinations form on order item page:
|  Date       | Time     |
| 10/14/2016  | 10:30 AM |
And I 'should not' see 'hold' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page
And I 'should' see 'cancel' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order item with clockNumber 'TMHACMSCN_2' with destination 'MDF 1' will have the next Destination Status 'Transfer Complete' in Traffic
And enter search criteria 'TMHACMSCN_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destination 'MDF 1' with Arrival Date '10/14/2016 10:30' for order item in Traffic List with clockNumber 'TMHACMSCN_2'
When open order details with clockNumber 'TMHACMSCN_2' from Traffic UI
And refresh the page
Then I should see 'TMHACMSCN_2' in delivery status 'Transfer Complete' in order details page for destination 'MDF 1'


Scenario: Check Delivery status set to Transfer Complete on clicking At destination when Offline destination is set to At Destination
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'other countries' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer  |
| automated test info    | TMDSRMAR1    | TMDSRMBR1    | TMDSRMSB1    | TMDSRMSP1 | TMFODATDC1 | TMFODATDCN_1   | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMFODATDST1   | Adstream France 2:Express |1 |
And completed order contains item with clock number 'TMFODATDCN_1' with following fields:
| Job Number  | PO Number  |
| TMFODTJS11  | TMFODTPS11 |
And waited for finish place order with following item clock number 'TMFODATDCN_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber   |
 | DefaultAgency  | TMFODATDCN_1  |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMFODATDCN_1' will be available in Traffic
And wait till order with clockNumber 'TMFODATDCN_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order item with clockNumber 'TMFODATDCN_1' will have A5 view status 'Passed QC' in Traffic
And I Edit order item with following clock number 'TMFODATDCN_1'
And click at destination for 'Adstream France 2' destinations on Select Broadcast Destinations form on order item page:
|  Date       | Time     |
| 10/14/2016  | 10:30 AM |
And I 'should not' see 'hold' button for 'Adstream France 2' destinations on Select Broadcast Destinations form on order item page
And I 'should' see 'cancel' button for 'Adstream France 2' destinations on Select Broadcast Destinations form on order item page
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order item with clockNumber 'TMFODATDCN_1' with destination 'Adstream France 2' will have the next Destination Status 'Transfer Complete' in Traffic
And enter search criteria 'TMFODATDCN_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destination 'Adstream France 2' with Arrival Date '10/14/2016 10:30' for order item in Traffic List with clockNumber 'TMFODATDCN_1'
When open order details with clockNumber 'TMFODATDCN_1' from Traffic UI
And refresh the page
Then I should see 'TMFODATDCN_1' in delivery status 'Transfer Complete' in order details page for destination 'Adstream France 2'

Scenario: Check At Transferring button and At destination not shown  when A5 view status is Order Placed
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination    | Motivnummer |
| automated test info    | TMDSRMAR1    | TMDSRMBR1    | TMDSRMSB1    | TMDSRMSP1   | TADRSC4    |TMDTBNSACN1_1     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMDTBNST4  | MDF 1:Express  |  1          |
When I open order item with following clock number 'TMDTBNSACN1_1'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number    | PO Number  |
| TMDTBNSJNM2   | TMDTBNSPNM2|
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TMDTBNSACN1_1' to A4
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TMDTBNSACN1_1' will be available in Traffic
And wait till order with clockNumber 'TMDTBNSACN1_1' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TMDTBNSACN1_1' will have A5 view status 'Order Placed' in Traffic
And enter search criteria 'TMDTBNSACN1_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TMDTBNSACN1_1' in Traffic
Then I 'should not' see 'At Destination' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page
And I 'should not' see 'Transferring' button for 'MDF 1' destinations on Select Broadcast Destinations form on order item page


Scenario: Check Delivery status set to Transfer in Progress on clicking Transferring for Offline destination
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'other countries' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer  |
| automated test info    | TMDSRMAR1    | TMDSRMBR1    | TMDSRMSB1    | TMDSRMSP1 | TMHACMSC1 | TMFODTCN_1   | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMHACMST1   | Adstream France 2:Express |1 |
And completed order contains item with clock number 'TMFODTCN_1' with following fields:
| Job Number  | PO Number  |
| TMFODTJS11  | TMFODTPS11 |
And waited for finish place order with following item clock number 'TMFODTCN_1' to A4
When ingested assests through A5 with following fields:
 | agencyName     | clockNumber |
 | DefaultAgency  | TMFODTCN_1  |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMFODTCN_1' will be available in Traffic
And wait till order with clockNumber 'TMFODTCN_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order item with clockNumber 'TMFODTCN_1' will have A5 view status 'Passed QC' in Traffic
And I Edit order item with following clock number 'TMFODTCN_1'
And click transferring for 'Adstream France 2' destinations on Select Broadcast Destinations form on order item page:
|  Date       | Time       |
| 10/14/2016  | 10:30 AM   |
And I 'should not' see 'hold' button for 'Adstream France 2' destinations on Select Broadcast Destinations form on order item page
And I 'should' see 'cancel' button for 'Adstream France 2' destinations on Select Broadcast Destinations form on order item page
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order item with clockNumber 'TMFODTCN_1' with destination 'Adstream France 2' will have the next Destination Status 'Transfer In Progress' in Traffic
And enter search criteria 'TMFODTCN_1' in simple search form on Traffic Order List page
When open order details with clockNumber 'TMFODTCN_1' from Traffic UI
And refresh the page
Then I should see 'TMFODTCN_1' in delivery status 'Transfer In Progress' in order details page for destination 'Adstream France 2'




