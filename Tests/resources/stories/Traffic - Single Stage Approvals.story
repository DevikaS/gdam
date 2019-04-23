Feature:    Traffic Approval Emails functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check approval emails


Lifecycle:
Before:
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name    | A4User        | AgencyType     | Application Access |  Market  | DestinationID |    A4User     |
| TAFA4   | DefaultA4User | Advertiser     | ordering           |          |               | DefaultA4User |
And created users with following fields:
| Email            | Role                      | AgencyUnique |  Access  |
| TAFU4            | agency.admin              | TAFA4        | ordering |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyOneStage  |       true         |      one      |  |broadcasterTrafficManagerOne |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TAFA4':
| Advertiser | Brand   | Sub Brand | Product |
| TSSAAR1    | TSSABR1 | TSSASB1   | TSSAPR1 |


Scenario: Check that on 'Release Master' for each order item triggers correct emails (Single Stage Approval with Master As Approver)
Meta: @traffic
      @qatrafficsmoke
      @qatrafficsmoke
      @criticaltraffictests
      @trafficemails
      @trafficcrossbrowser
Given I logged in with details of 'TAFU4'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TSSAAR1     | TSSABR1     | TSSASB1     | TSSAPR1    | TAFCP1    | TAFCN4_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4_1   |  TV Bayern Media:Express |
| automated test info    | TSSAAR1     | TSSABR1     | TSSASB1     | TSSAPR1    | TAFCP2    | TAFCN4_2     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4_2   |  TV Bayern Media:Express |
And complete order contains item with clock number 'TAFCN4_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN4_1' to A4
And wait for finish place order with following item clock number 'TAFCN4_2' to A4
And ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | TAFA4      |   TAFCN4_1  |
 | TAFA4      |   TAFCN4_2  |
And logged in with details of 'broadcasterTrafficManagerOne'
And waited till order with clockNumber 'TAFCN4_1' will be available in Traffic
And waited till order with clockNumber 'TAFCN4_2' will be available in Traffic
And waited till order item with clockNumber 'TAFCN4_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And waited till order item with clockNumber 'TAFCN4_2' will have broadcaster status 'Master Ready For Approval' in Traffic
And I waited for '7' seconds
And on order item details page of clockNumber 'TAFCN4_1'
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1 |  Master Released for first order item |
And open Traffic Order List page
And on order item details page of clockNumber 'TAFCN4_2'
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test2 |  Master Released for second order item |
Then I 'should' see email notification for 'has been released for delivery' with field to 'test1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TAFCN4_1     | TSSAAR1     | TSSAPR1  | TAFT4_1 | 10       | TV Bayern Media | Master Released for first order item |
And 'should' see email notification for 'has been released for delivery' with field to 'test2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TAFCN4_2     | TSSAAR1     | TSSAPR1  | TAFT4_2 | 20       | TV Bayern Media | Master Released for second order item |


Scenario: Check that on 'Reject Master' for each order item triggers correct emails (Single Stage Approval with Master As Approver)
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TAFU4'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TSSAAR1     | TSSABR1     | TSSASB1     | TSSAPR1    | TAFCP1    | TAFCN4_3     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4_3   |  TV Bayern Media:Express |
| automated test info    | TSSAAR1     | TSSABR1     | TSSASB1     | TSSAPR1    | TAFCP2    | TAFCN4_4     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4_4   |  TV Bayern Media:Express |
And complete order contains item with clock number 'TAFCN4_3' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN4_3' to A4
And wait for finish place order with following item clock number 'TAFCN4_4' to A4
And ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | TAFA4      |   TAFCN4_3  |
 | TAFA4      |   TAFCN4_4  |
And logged in with details of 'broadcasterTrafficManagerOne'
And waited till order item with clockNumber 'TAFCN4_3' will have broadcaster status 'Master Ready For Approval' in Traffic
And waited till order item with clockNumber 'TAFCN4_4' will have broadcaster status 'Master Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN4_3'
When I click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1_1 |  Master Rejected for first order item |
And open Traffic Order List page
And on order item details page of clockNumber 'TAFCN4_4'
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                                 |
| test2_1 |  Master Rejected for second order item |
Then I 'should' see email notification for 'has been rejected' with field to 'test1_1' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TAFCN4_3     | TSSAAR1     | TSSAPR1  | TAFT4_3 | 10       | TV Bayern Media | Master Rejected for first order item |
And 'should' see email notification for 'has been rejected' with field to 'test2_1' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TAFCN4_4     | TSSAAR1     | TSSAPR1  | TAFT4_4 | 20       | TV Bayern Media | Master Rejected for second order item |


Scenario: Check that on 'Restore Master' for each order item triggers correct emails (Single Stage Approval with Master As Approver)
Meta: @traffic
      @skip
      @trafficemails
!--This scenario is invalid ..see comment in this NGN-18799
Given I logged in with details of 'TAFU4'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TSSAAR1     | TSSABR1     | TSSASB1     | TSSAPR1    | TAFCP1    | TAFCN4_5     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4_5   |  TV Bayern Media:Express |
| automated test info    | TSSAAR1     | TSSABR1     | TSSASB1     | TSSAPR1    | TAFCP2    | TAFCN4_6     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4_6   |  TV Bayern Media:Express |
And complete order contains item with clock number 'TAFCN4_5' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN4_5' to A4
And wait for finish place order with following item clock number 'TAFCN4_6' to A4
And ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | TAFA4      |   TAFCN4_5  |
 | TAFA4      |   TAFCN4_6  |
And logged in with details of 'broadcasterTrafficManagerOne'
And waited till order item with clockNumber 'TAFCN4_5' will have broadcaster status 'Master Ready For Approval' in Traffic
And waited till order item with clockNumber 'TAFCN4_6' will have broadcaster status 'Master Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN4_5'
And clicked on 'Reject Master' button on order item details page in traffic
And filled the following fields on approval traffic pop up:
| Email                |  Comment                              |
| test4_5_1 |  Master Rejected for first order item |
And waited till order item with clockNumber 'TAFCN4_5' will have broadcaster status 'Master Rejected' in Traffic
When I click on 'Restore Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                  |  Comment                              |
| test4_5_2 |  Master Restored for first order item |
And open Traffic Order List page
And on order item details page of clockNumber 'TAFCN4_6'
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                  |  Comment                               |
| test4_6_1 |  Master Rejected for second order item |
And click on 'Restore Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                  | Comment                               |
| test4_6_2 | Master Restored for second order item |
Then I 'should' see email notification for 'has been restored' with field to 'test4_5_2' and subject 'clockNumber has been restored' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TAFCN4_5     | TSSAAR1     | TSSAPR1  | TAFT4_5 | 10       | TV Bayern Media | Master Restored for first order item |
And 'should' see email notification for 'has been restored' with field to 'test4_6_2' and subject 'clockNumber has been restored' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TAFCN4_6     | TSSAAR1     | TSSAPR1  | TAFT4_6 | 20       | TV Bayern Media | Master Restored for second order item |


Scenario: Check that Traffic Manger can Reset Approval Status for Single Stage Approval Destination
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TAFU4'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TSSAAR1     | TSSABR1     | TSSASB1     | TSSAPR1    | TAFCP1    | TAFCNZ5_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4_1   |  TV Bayern Media:Express |
And complete order contains item with clock number 'TAFCNZ5_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCNZ5_1' to A4
And ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | TAFA4      |   TAFCNZ5_1  |
And logged in with details of 'broadcasterTrafficManagerOne'
And waited till order with clockNumber 'TAFCNZ5_1' will be available in Traffic
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And entered search criteria 'TAFCNZ5_1' in simple search form on Traffic Order Item List page
And waited for '2' seconds
When fill '222' House Number for order item with 'TAFCNZ5_1' clock number on traffic order list
And refresh the page
Then I should see destination 'TV Bayern Media' for order item with clockNumber 'TAFCNZ5_1' in traffic order list that have following data:
| House Number  |
|     222       |
When on order item details page of clockNumber 'TAFCNZ5_1'
And wait till order item with clockNumber 'TAFCNZ5_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page
And I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1              |  Master Released for first order item |
And wait till order item with clockNumber 'TAFCNZ5_1' will have broadcaster status 'Delivered' in Traffic
Then I 'should' see email notification for 'has been released for delivery' with field to 'test1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TAFCNZ5_1     | TSSAAR1     | TSSAPR1  | TAFT4_1 | 10       | TV Bayern Media | Master Released for first order item |
When I login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And enter search criteria 'TAFCNZ5_1' in simple search form on Traffic Order Item List page
And I open order details with clockNumber 'TAFCNZ5_1' from Traffic UI
When I open Clone order item details page with clockNumber 'TAFCNZ5_1' from traffic order details page and validate cloned orders and Destinations 'TV Bayern Media'
Then 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic
When I reset Approval Status for 'TAFCNZ5_1' clock on traffic order details page
And wait till order item with clockNumber 'TAFCNZ5_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TAFCNZ5_1' with destination 'TV Bayern Media' will have the next Destination Status 'Awaiting station release' in Traffic
And I refresh the page
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And I 'should' see 'Awaiting station release' Delivery Status on on order item details page in traffic
When I login with details of 'broadcasterTrafficManagerOne'
And wait till order with clockNumber 'TAFCNZ5_1' will be available in Traffic
And select 'All' tab in Traffic UI
And enter search criteria 'TAFCNZ5_1' in simple search form on Traffic Order Item List page
And wait for '2' seconds
When fill '225' House Number for order item with 'TAFCNZ5_1' clock number on traffic order list
And refresh the page
Then I should see destination 'TV Bayern Media' for order item with clockNumber 'TAFCNZ5_1' in traffic order list that have following data:
| House Number  |
|     225       |
When on order item details page of clockNumber 'TAFCNZ5_1'
And wait till order item with clockNumber 'TAFCNZ5_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page
And on order item details page of clockNumber 'TAFCNZ5_1'
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1              |  Master Released for first order item |
Then I 'should' see email notification for 'has been released for delivery' with field to 'test1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TAFCNZ5_1     | TSSAAR1     | TSSAPR1  | TAFT4_1 | 10       | TV Bayern Media | Master Released for first order item |
When I wait till order item with clockNumber 'TAFCNZ5_1' will have broadcaster status 'Master Released' in Traffic
And wait till order item with clockNumber 'TAFCNZ5_1' will have broadcaster status 'Delivered' in Traffic
And refresh the page
Then 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic

