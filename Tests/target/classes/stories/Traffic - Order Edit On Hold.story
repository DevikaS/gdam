Feature:    Traffic Edit On Hold for Order
Narrative:
In order to
As a              AgencyAdmin
I want to check edit On Hold for  order feature

Lifecycle:
Before:
Given updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo     |      broadcasterTrafficManagerTwo     |

Scenario: Check that after enable Hold For Approval value should be changed in order list, order edit page and not visible in BT UI
Meta: @traffic
Given created users with following fields:
| Email     |           Role            | Agency       |  Access  | Password    |
| TCNTU10   | broadcast.traffic.manager |   BroadCasterAgencyTwoStage   |  adpath  | abcdefghA1 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TOEHAR1    | TOEHBR1 | TOEHSB1   | TOEHPR1 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format        | Title     | Destination         | Motivnummer |
| automated test info    | TOEHAR1    | TOEHBR1 | TOEHSB1   | TOEHPR1 | TTVBTVSC1 |TTVBTVSCN03_1 | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express| 1 |
And completed order contains item with clock number 'TTVBTVSCN03_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TTVBTVSCN03_1' will be available in Traffic
And wait till order with clockNumber 'TTVBTVSCN03_1' will have next status 'In Progress' in Traffic
And enter search criteria 'TTVBTVSCN03_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TTVBTVSCN03_1' in Traffic
And click Hold For Approval button on Traffic Order Edit page
Then I 'should' see order item held for approval for active cover flow
When I click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TTVBTVSCN03_1' in simple search form on Traffic Order List page
Then I 'should' see that On Hold status was updated to value 'Yes' for order with ClockNumber 'TTVBTVSCN03_1'
And open edit page for order with Clock Number 'TTVBTVSCN03_1' in Traffic
And 'should' see Hold For Approval button is active
And login with details of 'broadcasterTrafficManagerTwo'
And 'should not' see orderItems 'TTVBTVSCN03_1' in order item list in Traffic
When I login with details of 'trafficManager'
And wait till order list will be loaded
And wait till order with clockNumber 'TTVBTVSCN03_1' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TTVBTVSCN03_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TTVBTVSCN03_1' in Traffic
And I click Held For Approval button on Order Item page via UI
Then I 'should not' see order item held for approval for active cover flow
When I click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And wait for '5' seconds
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TTVBTVSCN03_1' in simple search form on Traffic Order List page
Then I 'should' see that On Hold status was updated to value 'No' for order with ClockNumber 'TTVBTVSCN03_1'

Scenario: Check that after enable Hold For Approval ,order should be visible in A5 Delivery View Held Orders tab
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TOEHAR1    | TOEHBR1 | TOEHSB1   | TOEHPR1 | TTVBTVSC1 | TTVBTVSCN15_1A| 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TTVBTVSCN15_1A' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And waited for finish place order with following item clock number 'TTVBTVSCN15_1A' to A4
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TTVBTVSCN15_1A' will be available in Traffic
And wait till order with clockNumber 'TTVBTVSCN15_1A' will have next status 'In Progress' in Traffic
And enter search criteria 'TTVBTVSCN15_1A' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TTVBTVSCN15_1A' in Traffic
And click Hold For Approval button on Traffic Order Edit page
And click proceed button on Traffic Order Edit page
And wait for '2' seconds
And click confirm button on Traffic Order Summary page
And login with details of 'AgencyAdmin'
And I open Order List page
When I select 'View Held Orders' tab on ordering page
And refresh the page
Then I should see TV order in 'live' order list with item clock number 'TTVBTVSCN15_1A' and following fields:
| Order# | DateTime    | Advertiser | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | TOEHAR1 | TTVBTVS11 | TTVBTVS11 | 1        | 0/1 Delivered |

Scenario: Check that after enable Hold For Approval for paticular destinartion, value should be changed for destination at order list and order item should no be visible at BT UI
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer  |
| automated test info    | TOEHAR1    | TOEHBR1 | TOEHSB1   | TOEHPR1 | TTVBTVSC1 | TTVBTVSCN017_1    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | TTVBTVST1 | TV Bayern Media:Standard | 1    |
And completed order contains item with clock number 'TTVBTVSCN017_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TTVBTVSCN017_1' will be available in Traffic
And wait till order with clockNumber 'TTVBTVSCN017_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TTVBTVSCN017_1' in simple search form on Traffic Order Item List page
And open edit page for order with Clock Number 'TTVBTVSCN017_1' in Traffic
And expand delivery section on Traffic Order Edit page
And fill Search Stations field by value 'TV Bayern Media' for Select Broadcast Destinations form on order item page
And wait for '5' seconds
And click Hold for Approval button for destination
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And wait for '5' seconds
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And enter search criteria 'TTVBTVSCN017_1' in simple search form on Traffic Order Item List page
And expand all orders on Traffic Order List page
Then I 'should' see that On Hold status was updated to value 'Yes' for order item destination order with ClockNumber 'TTVBTVSCN017_1'
And login with details of 'broadcasterTrafficManagerOne'
And enter search criteria 'TTVBTVSCN017_1' in simple search form on Traffic Order List page
And 'should not' see orderItems 'TTVBTVSCN017_1' in order item list in Traffic

Scenario: Check that after restart delivery for paticular destinartion, value should be changed for destination at order list and order item should be visible at BT UI
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer |
| automated test info    | TOEHAR1    | TOEHBR1 | TOEHSB1   | TOEHPR1 | TTVBTVSC1 | TTVBTVSCN19_1    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | TTVBTVST1 | TV Bayern Media:Express | 1  |
And completed order contains item with clock number 'TTVBTVSCN19_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TTVBTVSCN19_1' will be available in Traffic
And wait till order with clockNumber 'TTVBTVSCN19_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TTVBTVSCN19_1' in simple search form on Traffic Order Item List page
And wait for '2' seconds
And open edit page for order with Clock Number 'TTVBTVSCN19_1' in Traffic
And wait for '2' seconds
And expand delivery section on Traffic Order Edit page
And fill Search Stations field by value 'TV Bayern Media' for Select Broadcast Destinations form on order item page
And click Hold for Approval button for destination
And wait for '2' seconds
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TTVBTVSCN19_1' in simple search form on Traffic Order Item List page
And open edit page for order with Clock Number 'TTVBTVSCN19_1' in Traffic
And wait for '5' seconds
And expand delivery section on Traffic Order Edit page
And wait for '10' seconds
And click Restart Delivery button for destination
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TTVBTVSCN19_1' will have next status 'In Progress' in Traffic
And enter search criteria 'TTVBTVSCN19_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see that On Hold status was updated to value 'No' for order item destination order with ClockNumber 'TTVBTVSCN19_1'
And wait for '2' seconds
When login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TTVBTVSCN19_1' in simple search form on Traffic Order List page
Then 'should' see orderItems 'TTVBTVSCN19_1' in order item list in Traffic
