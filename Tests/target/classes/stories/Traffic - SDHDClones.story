Feature:          Agency Admin - Branding - from email address for notifications field
Narrative:
In order to
As a           AgencyAdmin
I want to         check from email address for notifications field

Lifecycle:
Before:
Given I created the following agency:
| Name         |    A4User          | AgencyType     | Application Access |     Market            | DestinationID | Save In Library | Allow To Save In Library  |
| TMEATA3_5    | DefaultA4User      | Advertiser     |streamlined_library,ordering    |                       |               |should           | should                    |
And I created users with following fields:
| Email      |           Role            | AgencyUnique   |  Access          |
| TMEATU1_5  |       agency.admin        |   TMEATA3_5    | streamlined_library,ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TMEATA3_5':
| Advertiser | Brand      | Sub Brand  | Product   |
| TBCAR5     | TBCBR5     | TBCSB5     | TBCSP5    |

Scenario:  Check that orders with HD-SD clones are displayed correctly in Traffic ,placing clock on hold and on releasing it
!--NGN-16765
Meta: @traffic
Given I logged in with details of 'TMEATU1_5'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TBCAR5     | TBCBR5     | TBCSB5     | TBCSP5    | TBCSC1    | TMEATCN115      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMEATIATS4 |           |
When I open order item with following clock number 'TMEATCN115'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And fill Search Stations field by value 'Ad Systems/ St Catherine Springfield, KY' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)                           |
|Ad Systems/ St Catherine Springfield, KY |
And fill Search Stations field by value 'Airport Network' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)   |
| Airport Network |
And fill Search Stations field by value 'FisherMTA_ABCSD' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)   |
| FisherMTA_ABCSD |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TMEATJ1    | GDNTDPO1  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TMEATCN115' to A4
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  TMEATA3_5   | TMEATCN115       | Airdate Traffic Services|
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations                                 |
|  TMEATA3_5   | TMEATCN115       | FisherMTA_ABCSD                             |
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations            |
|  TMEATA3_5   | TMEATCN115       | Airport Network        |
And I logout from account
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMEATCN115' will be available in Traffic
And wait till order with clockNumber 'TMEATCN115' will have next status 'In Progress' in Traffic
And enter search criteria 'TMEATCN115' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TMEATCN115' in Traffic
And wait for '5' seconds
And expand delivery section on Traffic Order Edit page
And fill Search Stations field by value 'Ad Systems/ St Catherine Springfield, KY' for Select Broadcast Destinations form on order item page
And click Hold for Approval button for destination
And wait for '4' seconds
Then I 'should' see order item held for approval for active cover flow
When I click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMEATCN115' in simple search form on Traffic Order List page
And open order details with clockNumber 'TMEATCN115' from Traffic UI
And wait for '2' seconds
Then I should see 'TMEATCN115' with value 'Yes' for on Hold Dest in order details page for destination 'Ad Systems/ St Catherine Springfield, KY'
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMEATCN115' in simple search form on Traffic Order List page
Then I 'should' see that On Hold status was updated to value 'Yes' for order with ClockNumber 'TMEATCN115'
When I login with details of 'broadcasterTrafficManager42818'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
Then 'should not' see orderItems 'TMEATCN115' in order item list in Traffic
When I logout from account
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMEATCN115' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TMEATCN115' in Traffic
And wait for '3' seconds
And expand delivery section on Traffic Order Edit page
And fill Search Stations field by value 'Ad Systems/ St Catherine Springfield, KY' for Select Broadcast Destinations form on order item page
And wait for '5' seconds
And click Restart Delivery button for destination
And wait for '5' seconds
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And am on order details page of clockNumber 'TMEATCN115'
And refresh the page
And wait for '2' seconds
Then I should see 'TMEATCN115' with value 'No' for on Hold Dest in order details page for destination 'Ad Systems/ St Catherine Springfield, KY'
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMEATCN115' in simple search form on Traffic Order List page
Then I 'should' see that On Hold status was updated to value 'No' for order with ClockNumber 'TMEATCN115'
When I login with details of 'broadcasterTrafficManager42818'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
Then 'should' see orderItems 'TMEATCN115' in order item list in Traffic


Scenario:  Check that orders with HD-SD clones are displayed correctly in Traffic,when one of the clone is ingested
!--NGN-16765
Meta: @traffic
Given I logged in with details of 'TMEATU1_5'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title     |  Destination|
| automated test info    | TBCAR5     | TBCBR5     | TBCSB5     | TBCSP35   | TBCSC1    | TMEATCN13      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMEATIATS2|             |
When I open order item with following clock number 'TMEATCN13'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And fill Search Stations field by value 'CBC Vancouver' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US) |
| CBC Vancouver |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TMEATJ1    | GDNTDPO1  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TMEATCN13' to A4
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations            |
|  TMEATA3_5   | TMEATCN13       | Airdate Traffic Service|
And I logout from account
And login with details of 'broadcasterTrafficManager49618'
And I wait till order with clockNumber 'TMEATCN13' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And wait for '5' seconds
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| NES          |  TMEATCN13       |
And I logout from account
And login with details of 'broadcasterTrafficManager59065'
And select 'All' tab in Traffic UI
And refresh the page
And wait for '5' seconds
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| EES          | TMEATCN13        |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMEATCN13' will be available in Traffic
And select 'All' tab in Traffic UI
And am on order details page of clockNumber 'TMEATCN13'
And wait for '2' seconds
Then I should see '2' cloned orders for clocknumber 'TMEATCN13'
When I open Clone order item details page with clockNumber 'TMEATCN13' from traffic order details page and validate cloned orders and Destinations 'Airdate Traffic Services'
Then I 'should' see Support Document 'Matser' for clockNumber 'TMEATCN13' in order details page
And I 'should' see Support Document 'Matser' for clockNumber 'TMEATCN13' is downloaded from order details page
And I 'should' see house number 'NES' on order details page in traffic
And I 'should' see playable preview on order item details page in traffic
And I 'should' see playable preview available for download on order item details page in traffic
And I 'should' see Proxy file 'TMEATIATS2' for clockNumber 'TMEATCN13' is downloaded from order details page with duration '20'
And I 'should' see orderItem status as 'TVC Ingested OK' in order item details page in Traffic
When I open Traffic Order List page
And am on order details page of clockNumber 'TMEATCN13'
And I open Clone order item details page with clockNumber 'TMEATCN13' from traffic order details page and validate cloned orders and Destinations 'CBC Vancouver'
Then I 'shouldnot' see Support Document for clockNumber 'TMEATCN13' in order details page
And I 'should' see house number 'EES' on order details page in traffic
And I 'shouldnot' see playable preview on order item details page in traffic
And I 'shouldnot' see playable preview available for download on order item details page in traffic
And I 'shouldnot' see Proxy file 'TMEATIATS2' for clockNumber 'TMEATCN13' is downloaded from order details page with duration '20'
And I 'should' see orderItem status as 'New' in order item details page in Traffic




Scenario:  Check that orders with HD-SD clones are displayed correctly in Traffic,when two clones are ingested
!--NGN-16765
Meta: @traffic
Given I logged in with details of 'TMEATU1_5'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination |
| automated test info    | TBCAR5     | TBCBR5     | TBCSB5     | TBCSP5    | TBCSC1    | TMEATCN14      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMEATIATS3 |            |
When I open order item with following clock number 'TMEATCN14'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And fill Search Stations field by value 'CBC Vancouver' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US) |
| CBC Vancouver |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TMEATJ1    | GDNTDPO1  |
And confirm order on Order Proceed page
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  TMEATA3_5   | TMEATCN14       | Airdate Traffic Services|
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations            |
|  TMEATA3_5   | TMEATCN14       | CBC Vancouver          |
And I logout from account
And login with details of 'broadcasterTrafficManager49618'
And I wait till order with clockNumber 'TMEATCN14' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TMEATCN14' in simple search form on Traffic Order List page
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| NFS          |  TMEATCN14       |
And I logout from account
And login with details of 'broadcasterTrafficManager59065'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TMEATCN14' in simple search form on Traffic Order List page
And wait for '2' seconds
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| EFS          | TMEATCN14        |
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMEATCN14' in simple search form on Traffic Order List page
And I open order details with clockNumber 'TMEATCN14' from Traffic UI
Then I should see '2' cloned orders for clocknumber 'TMEATCN14'
When I open Clone order item details page with clockNumber 'TMEATCN14' from traffic order details page and validate cloned orders and Destinations 'Airdate Traffic Services'
Then I 'should' see Support Document 'Matser' for clockNumber 'TMEATCN14' in order details page
And I 'should' see Support Document 'Matser' for clockNumber 'TMEATCN14' is downloaded from order details page
And I 'should' see house number 'NFS' on order details page in traffic
And I 'should' see playable preview on order item details page in traffic
And I 'should' see playable preview available for download on order item details page in traffic
And I 'should' see Proxy file 'TMEATIATS3' for clockNumber 'TMEATCN14' is downloaded from order details page with duration '20'
And I 'should' see orderItem status as 'TVC Ingested OK' in order item details page in Traffic
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And am on order details page of clockNumber 'TMEATCN14'
And I open Clone order item details page with clockNumber 'TMEATCN14' from traffic order details page and validate cloned orders and Destinations 'CBC Vancouver'
Then I 'should' see Support Document 'Matser' for clockNumber 'TMEATCN14' in order details page
And I 'should' see Support Document 'Matser' for clockNumber 'TMEATCN14' is downloaded from order details page
And I 'should' see house number 'EFS' on order details page in traffic
And I 'should' see playable preview on order item details page in traffic
And I 'should' see playable preview available for download on order item details page in traffic
And I 'should' see Proxy file 'TMEATIATS3' for clockNumber 'TMEATCN14' is downloaded from order details page with duration '20'
And I 'should' see orderItem status as 'TVC Ingested OK' in order item details page in Traffic


Scenario:  Check that orders with HD-SD clones are displayed correctly in Traffic on ingestion and only two clones generated when more than one SD and HD Destination selected
!--NGN-16765
Meta: @traffic
Given logged in with details of 'TMEATU1_5'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TBCAR5     | TBCBR5     | TBCSB5     | TBCSP5    | TBCSC1    | TMEATCN15      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMEATIATS4 |           |
When I open order item with following clock number 'TMEATCN15'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And fill Search Stations field by value 'Ad Systems/ St Catherine Springfield, KY' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)                            |
| Ad Systems/ St Catherine Springfield, KY |
And fill Search Stations field by value 'Airport Network' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)   |
| Airport Network |
And fill Search Stations field by value 'FisherMTA_ABCSD' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)   |
| FisherMTA_ABCSD |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TMEATJ1    | GDNTDPO1  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TMEATCN15' to A4
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  TMEATA3_5   | TMEATCN15       | Airdate Traffic Services|
And I logout from account
And login with details of 'broadcasterTrafficManager49618'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And I wait till order with clockNumber 'TMEATCN15' will be available in Traffic
And enter search criteria 'TMEATCN15' in simple search form on Traffic Order List page
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| NGS          |  TMEATCN15       |
And I logout from account
And login with details of 'trafficManager'
And am on order details page of clockNumber 'TMEATCN15'
Then I should see '2' cloned orders for clocknumber 'TMEATCN15'
When I open Clone order item details page with clockNumber 'TMEATCN15' from traffic order details page and validate cloned orders and Destinations 'Airdate Traffic Services'
Then I 'should' see Support Document 'Matser' for clockNumber 'TMEATCN15' in order details page
And I 'should' see Support Document 'Matser' for clockNumber 'TMEATCN15' is downloaded from order details page
And I 'should' see house number 'NGS' on order details page in traffic for Clock 'TMEATCN15' for destination 'Airdate Traffic Services'
And I 'should' see playable preview on order item details page in traffic
And I 'should' see playable preview available for download on order item details page in traffic
And I 'should' see Proxy file 'TMEATIATS4' for clockNumber 'TMEATCN15' is downloaded from order details page with duration '20'
And I 'should' see orderItem status as 'TVC Ingested OK' in order item details page in Traffic
When I open Traffic Order List page
And am on order details page of clockNumber 'TMEATCN15'
And I open Clone order item details page with clockNumber 'TMEATCN15' from traffic order details page and validate cloned orders and Destinations 'FisherMTA_ABCSD'
Then I 'shouldnot' see Support Document for clockNumber 'TMEATCN15' in order details page
And I 'shouldnot' see house number 'NGS' on order details page in traffic for Clock 'TMEATCN15' for destination 'FisherMTA_ABCSD'
And I 'shouldnot' see playable preview on order item details page in traffic
And I 'shouldnot' see playable preview available for download on order item details page in traffic
And I 'shouldnot' see Proxy file 'TMEATIATS4' for clockNumber 'TMEATCN15' is downloaded from order details page with duration '20'
And I 'should' see orderItem status as 'New' in order item details page in Traffic


Scenario: Check that orders with HD-SD clones are displayed correctly in Traffic,when one of the clone is cancelled
!--NGN-16765
Meta: @traffic
Given I logged in with details of 'TMEATU1_5'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |  Destination |
| automated test info    | TBCAR5     | TBCBR5     | TBCSB5     | TBCSP5    | TBCSC1    | TMEATCN16      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMEATIATS1 |              |
When I open order item with following clock number 'TMEATCN16'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And fill Search Stations field by value 'CBC Vancouver' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US) |
| CBC Vancouver |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TMEATJ1    | GDNTDPO1  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TMEATCN16' to A4
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations            |
|  TMEATA3_5   | TMEATCN16       | Airdate Traffic Service|
And I logout from account
And login with details of 'broadcasterTrafficManager49618'
And I wait till order with clockNumber 'TMEATCN16' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TMEATCN16' in simple search form on Traffic Order Item List page
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| NHS          |  TMEATCN16       |
And I logout from account
And login with details of 'broadcasterTrafficManager59065'
And select 'All' tab in Traffic UI
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| EHS          | TMEATCN16        |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMEATCN16' will be available in Traffic
And am on order details page of clockNumber 'TMEATCN16'
Then I should see '2' cloned orders for clocknumber 'TMEATCN16'
When I open Clone order item details page with clockNumber 'TMEATCN16' from traffic order details page and validate cloned orders and Destinations 'Airdate Traffic Services'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And am on order details page of clockNumber 'TMEATCN16'
And refresh the page without delay
And I open Clone order item details page with clockNumber 'TMEATCN16' from traffic order details page and validate cloned orders and Destinations 'Airdate Traffic Services'
And refresh the page without delay
Then I 'shouldnot' see Support Document for clockNumber 'TMEATCN16' in order details page
And I 'should' see house number 'NHS' on order details page in traffic
And I 'shouldnot' see playable preview on order item details page in traffic
And I 'shouldnot' see playable preview available for download on order item details page in traffic
And I 'shouldnot' see Proxy file 'TMEATIATS1' for clockNumber 'TMEATCN16' is downloaded from order details page with duration '20'
And I 'should' see orderItem status as 'Cancelled' in order item details page in Traffic
When I open Traffic Order List page
And am on order details page of clockNumber 'TMEATCN16'
And I open Clone order item details page with clockNumber 'TMEATCN16' from traffic order details page and validate cloned orders and Destinations 'CBC Vancouver'
Then I 'shouldnot' see Support Document for clockNumber 'TMEATCN16' in order details page
And I 'should' see house number 'EHS' on order details page in traffic
And I 'shouldnot' see playable preview on order item details page in traffic
And I 'shouldnot' see playable preview available for download on order item details page in traffic
And I 'shouldnot' see Proxy file 'TMEATIATS1' for clockNumber 'TMEATCN16' is downloaded from order details page with duration '20'
And I 'should' see orderItem status as 'New' in order item details page in Traffic

