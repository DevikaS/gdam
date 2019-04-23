Feature:          Assign or Unassign orders
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that orders can be assigned or unassigned to TM

Lifecycle:
Before:
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product   |
| TAUAR1    | TAUBR1 | TAUSB1   | TAUP1 |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyOneStage  |       true         |      one      |  |broadcasterTrafficManagerOne |
| BroadCasterAgencyTwoStage     |       true         |      two      |broadcasterTrafficManagerTwo   |broadcasterTrafficManagerTwo     |

Scenario: Check that orders can be assigned or unassigned from list view
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TAUAR1    | TAUBR1 | TAUSB1   | TAUP1  | TAUC1   |TAUCN1| 20       |      1      | 06/16/2016     |   Already Supplied |HD 1080i 25fps  | TAUT1 | Facebook DE:Express |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TAUAR1    | TAUBR1 | TAUSB1   | TAUP1  | TAUC2   |TAUCN2| 20       |      1      | 06/13/2016     |   Already Supplied |HD 1080i 25fps  | TAUT2 | Facebook DE:Express |
And complete order contains item with clock number 'TAUCN1' with following fields:
| Job Number | PO Number |
| TAUJN1    | TAUPO1   |
And complete order contains item with clock number 'TAUCN2' with following fields:
| Job Number | PO Number |
| TAUJN2     | TAUPO1    |
And logged in with details of 'trafficManager'
When I select 'All' tab in Traffic UI
And wait till order with clockNumber 'TAUCN1' will be available in Traffic
And wait till order with clockNumber 'TAUCN2' will be available in Traffic
When I select all from dropdown on Traffic Order List page
And I enter search criteria 'TAUPO1' in simple search form on Traffic Order List page
When I select all from list view in Traffic UI
When I click on 'Assign to me' button in Traffic order list page
Then I 'should' see 'Unassign me' button in Traffic order list page
And I 'should' see 'Reassign Order' button in Traffic order list page
And I should see order with clockNumber 'TAUCN1' in traffic list that have following data:
| Traffic assigned to|
| trafficManager    |
And I should see order with clockNumber 'TAUCN2' in traffic list that have following data:
| Traffic assigned to|
| trafficManager    |
When I click on 'Unassign me' button in Traffic order list page
Then I 'should' see 'Assign to me' button in Traffic order list page
And I 'should' see 'Reassign Order' button in Traffic order list page
And I should see order with clockNumber 'TAUCN1' in traffic list that have following data:
| Traffic assigned to|
|     |
And I should see order with clockNumber 'TAUCN2' in traffic list that have following data:
| Traffic assigned to|
|     |


Scenario: Check that orders can be assigned or unassigned to TM from order details page and make sure the changes reflected in order list page
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TAUAR1    | TAUBR1 | TAUSB1   | TAUP1  | TAUC3   |TAUCN3| 20       |      1      | 06/16/2016     |   Already Supplied |HD 1080i 25fps  | TAUT3 | Facebook DE:Express |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TAUAR1    | TAUBR1 | TAUSB1   | TAUP1  | TAUC4  |TAUCN4| 20       |      1      | 06/13/2016     |   Already Supplied |HD 1080i 25fps  | TAUT4 | Facebook DE:Express |
And complete order contains item with clock number 'TAUCN3' with following fields:
| Job Number | PO Number |
| TAUJN3     | TAUPO2    |
And complete order contains item with clock number 'TAUCN4' with following fields:
| Job Number | PO Number |
| TAUJN4     | TAUPO2    |
And logged in with details of 'trafficManager'
When I wait till order with clockNumber 'TAUCN3' will be available in Traffic
And wait till order with clockNumber 'TAUCN4' will be available in Traffic
And I am on order details page of clockNumber 'TAUCN3'
When I click on 'Assign to me' button on order details page in traffic
Then I 'should' see 'Unassign me' button in Traffic order details page
And I 'should' see 'Reassign Order' button in Traffic order details page
And I should see following fields on order page in Traffic UI:
| Assigned to |
| trafficManager     |
When I open Traffic Order List page
When I select 'All' tab in Traffic UI
When I select all from dropdown on Traffic Order List page
And I enter search criteria 'TAUPO2' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TAUCN3' in traffic list that have following data:
| Traffic assigned to|
|  trafficManager   |
And I should see order with clockNumber 'TAUCN4' in traffic list that have following data:
| Traffic assigned to|
|     |
When I open order details with clockNumber 'TAUCN3' from Traffic UI
When I click on 'Unassign me' button on order details page in traffic
Then I 'should' see 'Assign to me' button in Traffic order details page
And I 'should' see 'Reassign Order' button in Traffic order details page
And I should see following fields on order page in Traffic UI:
| Assigned to |
|  Unassigned    |
When I open Traffic Order List page
When I select 'All' tab in Traffic UI
And select all from dropdown on Traffic Order List page
And I enter search criteria 'TAUPO2' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TAUCN3' in traffic list that have following data:
| Traffic assigned to|
|     |
And I should see order with clockNumber 'TAUCN4' in traffic list that have following data:
| Traffic assigned to|
|     |


Scenario: Check that TM can be added to the list of existing users already added and make sure TM is not duplicated if already added
Meta: @traffic
Given I created the following agency:
| Name    |    A4User     | AgencyType | Application Access |
| TAUA1 | DefaultA4User | Advertiser |      ordering      |
| TAUI1 | DefaultA4User |   Ingest   |       adpath       |
And created users with following fields:
| Email   |           Role          | AgencyUnique |  Access  |
| TAU_U1 |       agency.admin      |   TAUA1  | ordering |
| TAU_U2 | traffic.traffic.manager |   TAUI1  |  adpath  |
| TAU_U3 | traffic.traffic.manager |   TAUI1  |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TAUA1':
| Advertiser | Brand   | Sub Brand | Product   |
| TAUAR2    | TAUBR2 | TAUSB2   | TAUP2 |
And logged in with details of 'TAU_U1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TAUAR2    | TAUBR2 | TAUSB2   | TAUP2  | TAUC5   |TAUCN5| 20       |      1      | 06/16/2016     |   Already Supplied |HD 1080i 25fps  | TAUT5 | Facebook DE:Express |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TAUAR2    | TAUBR2 | TAUSB2   | TAUP2  | TAUC6   |TAUCN6| 20       |      1      | 06/13/2016     |   Already Supplied |HD 1080i 25fps  | TAUT6 | Facebook DE:Express |
And complete order contains item with clock number 'TAUCN5' with following fields:
| Job Number | PO Number |
| TAUJN5     | TAUPO3    |
And complete order contains item with clock number 'TAUCN6' with following fields:
| Job Number | PO Number |
| TAUJN6     | TAUPO3    |
And logged in with details of 'TAU_U2'
And waited till order with clockNumber 'TAUCN5' will be available in Traffic
And waited till order with clockNumber 'TAUCN6' will be available in Traffic
And selected 'All' tab in Traffic UI
And refreshed the page
When I assign all users from 'TAUI1' agency for following orders:
| clockNumber      |
| TAUCN5  |
Then I should see order with clockNumber 'TAUCN5' in traffic list that have following data:
| Traffic assigned to|
| TAU_U2,TAU_U3    |
And should see order with clockNumber 'TAUCN6' in traffic list that have following data:
| Traffic assigned to|
|    |
When I select all from dropdown on Traffic Order List page
And I enter search criteria 'TAUPO3' in simple search form on Traffic Order List page
And I select all from list view in Traffic UI
When I click on 'Assign to me' button in Traffic order list page
Then I should see order with clockNumber 'TAUCN5' in traffic list that have following data:
| Traffic assigned to|
| TAU_U2,TAU_U3    |
And should see order with clockNumber 'TAUCN6' in traffic list that have following data:
| Traffic assigned to|
|   TAU_U2 |
When I click on 'Unassign me' button in Traffic order list page
Then I should see order with clockNumber 'TAUCN5' in traffic list that have following data:
| Traffic assigned to|
| TAU_U3    |
And should see order with clockNumber 'TAUCN6' in traffic list that have following data:
| Traffic assigned to|
|    |


Scenario: Check that TM is assigned or unassigned to only the orders that are selected from list view
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TAUAR1    | TAUBR1 | TAUSB1   | TAUP1  | TAUC7  |TAUCN7| 20       |      1      | 06/16/2016     |   Already Supplied |HD 1080i 25fps  | TAUT7 | Facebook DE:Express |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TAUAR1    | TAUBR1 | TAUSB1   | TAUP1  | TAUC8   |TAUCN8| 20       |      1      | 06/13/2016     |   Already Supplied |HD 1080i 25fps  | TAUT8 | Facebook DE:Express |
And complete order contains item with clock number 'TAUCN7' with following fields:
| Job Number | PO Number |
| TAUJN7     | TAUPO4    |
And complete order contains item with clock number 'TAUCN8' with following fields:
| Job Number | PO Number |
| TAUJN8     | TAUPO4    |
And logged in with details of 'trafficManager'
When I select 'All' tab in Traffic UI
And wait till order with clockNumber 'TAUCN7' will be available in Traffic
And wait till order with clockNumber 'TAUCN8' will be available in Traffic
When I select all from dropdown on Traffic Order List page
And I enter search criteria 'TAUPO4' in simple search form on Traffic Order List page
When I select the following orders on traffic order list:
|clockNumber|
|TAUCN7|
When I click on 'Assign to me' button in Traffic order list page
Then I should see order with clockNumber 'TAUCN7' in traffic list that have following data:
| Traffic assigned to|
| trafficManager    |
And should see order with clockNumber 'TAUCN8' in traffic list that have following data:
| Traffic assigned to|
|    |
When I click on 'Unassign me' button in Traffic order list page
Then I should see order with clockNumber 'TAUCN7' in traffic list that have following data:
| Traffic assigned to|
|     |
And should see order with clockNumber 'TAUCN8' in traffic list that have following data:
| Traffic assigned to|
|    |


Scenario: Check that Assign to me and Unassign me button do not appear for TV broadcaster
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TAUAR1     | TAUBR1     | TAUSB1     | TAUP1    | TAUC9    | TAUCN9      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAUT9     |  TV Bayern Media:Express   |
And complete order contains item with clock number 'TAUCN9' with following fields:
| Job Number  | PO Number |
| TAUJN9  | TAUPO9 |
And wait for finish place order with following item clock number 'TAUCN9' to A4
When login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And enter search criteria 'TAUCN9' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
Then I 'should not' see 'Assign to me' button at broadcaster level
And I 'should not' see 'Unassign me' button at broadcaster level


Scenario: Check that Assign to me and Unassign me button do not appear for TV broadcaster hub
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TAUHUB1   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TAUHUB1_U1    |       broadcast.traffic.manager       |  TAUHUB1       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TAUHUB1                    |       true         |      two      |TAUHUB1_U1|TAUHUB1_U1|
And I add hub members via API:
| Hub Members               | Name    |
| BroadCasterAgencyTwoStage | TAUHUB1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TAUAR1       | TAUBR1       | TAUSB1       | TAUP1      | TAUC10    | TAUCN10     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TAUT10 | Motorvision TV:Express                      | 1          |
And complete order contains item with clock number 'TAUCN10' with following fields:
| Job Number   | PO Number    |
| TAUJN10 | TAUPO10 |
And wait for finish place order with following item clock number 'TAUCN10' to A4
When login with details of 'TAUHUB1_U1'
And select 'All' tab in Traffic UI
And enter search criteria 'TAUCN10' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
Then I 'should not' see 'Assign to me' button at broadcaster level
And I 'should not' see 'Unassign me' button at broadcaster level



