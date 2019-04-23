Feature:          Format field to be updated based on destination spec
Narrative:
In order to
As a           AgencyAdmin
I want to         see format field updates with destination spec

Lifecycle:
Before:
Given updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyOneStage  |       true         |      one      |  |broadcasterTrafficManagerOne |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TMDFAR1     | TMDFBR1     | TMDFSB1     | TMDFP1    |


Scenario: Check that format field is updated with SD at order and item level and order details page and clock details page when a clock is sent to SD destination
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required |  Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMDFAR1     | TMDFBR1     | TMDFSB1     | TMDFP1    | TMDFC1   | TMDFCN1     | 20       | 12/14/2022     |  Already Supplied  | TMDFT1 | TV Bayern Media:Express       |1|
And complete order contains item with clock number 'TMDFCN1' with following fields:
| Job Number  | PO Number |
| TMDFJN2   | TMDFPO2 |
And wait for finish place order with following item clock number 'TMDFCN1' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order with clockNumber 'TMDFCN1' will be available in Traffic
And entered search criteria 'TMDFCN1' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMDFCN1' in traffic list that have following data:
| Format|
| SD   |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMDFCN1' in traffic order list that have following data:
|     Format    |
|      SD                  |
When I open order details with clockNumber 'TMDFCN1' from Traffic UI
And I refresh the page
Then I should see following metadata on order details page in traffic:
| Format |
| SD         |
When login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TMDFCN1' in simple search form on Traffic Order List page
Then I should see order item with clockNumber 'TMDFCN1' in traffic order list that have following data:
|    Format    |
|      SD          |
And I should see destination 'Travel Channel DE' for order item with clockNumber 'TMDFCN1' in traffic order list that have following data:
|    Format    |
|      SD          |



Scenario: Check that format field is updated with HD at order level when a clock is having both SD and HD destination
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TMDFHUB01    | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TMDFHUBU1    |       broadcast.traffic.manager       |  TMDFHUB01       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TMDFHUB01                      |       true         |      two      |TMDFHUBU1|TMDFHUBU1|
And I am on agency 'TMDFHUB01' hub members page
And I add hub members:
|Hub Members|
|BroadCasterAgency49618|
|BroadCasterAgency59065|
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TMDFAR1     | TMDFBR1     | TMDFSB1     | TMDFP1    | TMDFC2    | TMDFCN2     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMDFT2 |           |
When I open order item with following clock number 'TMDFCN2'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And fill Search Stations field by value 'CBC Vancouver' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)   |
| CBC Vancouver |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TMDFJN02    | TMDFPO02  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TMDFCN2' to A4
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMDFCN2' will be available in Traffic
And enter search criteria 'TMDFCN2' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMDFCN2' in traffic list that have following data:
| Format|
| HD  |


Scenario: Check that format field is updated with HD for QC & Ingest Only at order and item level and order details page when a user specifies the format manually as HD
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |      Motivnummer|                                                                                                            |
| automated test info    | TMDFAR1     | TMDFBR1     | TMDFSB1     | TMDFP1    | TMDFC3 | TMDFCN3     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMDFT3|      1|
When I open order item with following clock number 'TMDFCN3'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TVBCOHJN4    | TVBCOHPO4  |
And confirm order on Order Proceed page
And wait till order with clockNumber 'TMDFCN3' will be available in Traffic
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMDFCN3' will be available in Traffic
And enter search criteria 'TMDFCN3' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMDFCN3' in traffic list that have following data:
| Format|
| HD   |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMDFCN3' in traffic order list that have following data:
|     Format    |
|      HD                  |
When I open order details with clockNumber 'TMDFCN3' from Traffic UI
And I refresh the page
Then I should see following metadata on order details page in traffic:
| Format |
| HD         |


Scenario: Check that format field is updated with SD at order and item level and order details page when a user specifies the format manually as HD and clock is sent to SD destination
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMDFAR1     | TMDFBR1     | TMDFSB1     | TMDFP1    | TMDFC4 | TMDFCN4     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMDFT4| Disney Germany SD:Standard|      1|
And complete order contains item with clock number 'TMDFCN4' with following fields:
| Job Number  | PO Number |
| TMDFJN04 | TMDFPO04|
And waited till order with clockNumber 'TMDFCN4' will be available in Traffic
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order with clockNumber 'TMDFCN4' will be available in Traffic
And entered search criteria 'TMDFCN4' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMDFCN4' in traffic list that have following data:
| Format|
| SD   |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMDFCN4' in traffic order list that have following data:
|     Format    |
|      SD                  |
When I open order details with clockNumber 'TMDFCN4' from Traffic UI
And I refresh the page
Then I should see following metadata on order details page in traffic:
| Format |
| SD         |

