!--NIR-400
Feature:    Visibilty of order item for broadcaster when whole clock is put On-Hold
Narrative:
In order to
As a              AgencyAdmin
I want to check the visibilty of order item for broadcaster when whole clock is put On-Hold


Lifecycle:
Before:
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand     | Sub Brand | Product  |
| TVBCOHAR1  | TVBCOHBR1 | TVBCOHSB1 | TVBCOHP1 |
And updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver                  | Master Approver                |
| BroadCasterAgencyOneStage   | true               | one           |                                | broadcasterTrafficManagerOne   |
| BroadCasterAgencyTwoStage   | true               | two           | broadcasterTrafficManagerTwo   | broadcasterTrafficManagerTwo   |
| BroadCasterAgencyTwoStage_1 | true               | two           | broadcasterTrafficManagerTwo_1 | broadcasterTrafficManagerTwo_1 |
| BroadCasterAgency49618      | true               | two           | broadcasterTrafficManager49618 | broadcasterTrafficManager49618 |
| BroadCasterAgency59065      | true               | two           | broadcasterTrafficManager59065 | broadcasterTrafficManager59065 |
| BroadCasterAgency7390       | false              | two           | broadcasterTrafficManager7390  | broadcasterTrafficManager7390  |

Scenario: Check that order item is not visible for TV broadcaster when clock is put On-Hold
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TVBCOHAR1       | TVBCOHBR1       | TVBCOHSB1       | TVBCOHP1      | TVBCOHC1   | TVBCOHCN1    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT1 | TV Bayern Media:Express                      | 1          |
And complete order contains item with clock number 'TVBCOHCN1' with following fields:
| Job Number   | PO Number    |
| TVBCOHJN1 | TVBCOHPO1 |
And wait for finish place order with following item clock number 'TVBCOHCN1' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN1' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN1'
And hold following destinations for Select Broadcast Destinations form on order item page 'TV Bayern Media'
And wait for '5' seconds
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'TVBCOHCN1'
Then I should see 'TVBCOHCN1' with value 'Yes' for on Hold Dest in order details page for destination 'TV Bayern Media'
And login with details of 'broadcasterTrafficManagerOne'
When I select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TVBCOHCN1' in simple search form on Traffic Order List page
Then 'should not' see orderItems 'TVBCOHCN1' in order item list in Traffic


Scenario: Check that broadcaster hub manager can see order item when one of the destination is put On-Hold in a clock and should not see destination that is On-Hold
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVBCOHHUB1   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVBCOHHUB_U1    |       broadcast.traffic.manager       |  TVBCOHHUB1       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVBCOHHUB1                    |       true         |      two      |TVBCOHHUB_U1|TVBCOHHUB_U1|
And I add hub members via API:
| Hub Members                                            | Name       |
| BroadCasterAgencyTwoStage, BroadCasterAgencyTwoStage_1 | TVBCOHHUB1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TVBCOHAR1       | TVBCOHBR1       | TVBCOHSB1       | TVBCOHP1      | TVBCOHC2    | TVBCOHCN2     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT2 | Motorvision TV:Express;Tele 5 DE - Longform:Express                      | 1          |
And complete order contains item with clock number 'TVBCOHCN2' with following fields:
| Job Number   | PO Number    |
| TVBCOHJN2 | TVBCOHPO2 |
And wait for finish place order with following item clock number 'TVBCOHCN2' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN2' will be available in Traffic
And wait till order with clockNumber 'TVBCOHCN2' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN2'
And hold following destinations for Select Broadcast Destinations form on order item page 'Motorvision TV'
And wait for '5' seconds
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'TVBCOHCN2'
Then I should see 'TVBCOHCN2' with value 'Yes' for on Hold Dest in order details page for destination 'Motorvision TV'
When login with details of 'TVBCOHHUB_U1'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TVBCOHCN2' in simple search form on Traffic Order List page
And I wait for '5' seconds
Then I 'should' see destinations 'Tele 5 DE - Longform' for order item in Traffic List with clockNumber 'TVBCOHCN2' at broadcaster level
And I 'should not' see destinations 'Motorvision TV' for order item in Traffic List with clockNumber 'TVBCOHCN2' at broadcaster level


Scenario: Check that broadcaster hub manager cannot see order item when whole clock is put ON-Hold
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVBCOHHUB2   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVBCOHHUB_U2    |       broadcast.traffic.manager       |  TVBCOHHUB2       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVBCOHHUB2                    |       true         |      two      |TVBCOHHUB_U2|TVBCOHHUB_U2|
And I add hub members via API:
| Hub Members                                            | Name       |
| BroadCasterAgencyTwoStage, BroadCasterAgencyTwoStage_1 | TVBCOHHUB2 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TVBCOHAR1       | TVBCOHBR1       | TVBCOHSB1       | TVBCOHP1      | TVBCOHC3    | TVBCOHCN3     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT3 | Motorvision TV:Express;Tele 5 DE - Longform:Express                      | 1          |
And complete order contains item with clock number 'TVBCOHCN3' with following fields:
| Job Number   | PO Number    |
| TVBCOHJN3 | TVBCOHPO3 |
And wait for finish place order with following item clock number 'TVBCOHCN3' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN3' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN3'
And hold following destinations for Select Broadcast Destinations form on order item page 'Motorvision TV'
And wait for '2' seconds
And hold following destinations for Select Broadcast Destinations form on order item page 'Tele 5 DE - Longform'
And wait for '2' seconds
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'TVBCOHCN3'
Then I should see 'TVBCOHCN3' with value 'Yes' for on Hold Dest in order details page for destination 'Motorvision TV'
And I should see 'TVBCOHCN3' with value 'Yes' for on Hold Dest in order details page for destination 'Tele 5 DE - Longform'
When login with details of 'TVBCOHHUB_U2'
And I select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TVBCOHCN3' in simple search form on Traffic Order List page
Then 'should not' see orderItems 'TVBCOHCN3' in order item list in Traffic


Scenario: Check that broadcaster hub manager can see SD and HD clones order item when one of the destination is put On-Hold in a clock and should not see destination that is On-Hold
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVBCOHHUB3   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVBCOHHUB_U3    |       broadcast.traffic.manager       |  TVBCOHHUB3       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVBCOHHUB3                    |       true         |      two      |TVBCOHHUB_U3|TVBCOHHUB_U3|
And I add hub members via API:
| Hub Members                                    | Name       |
| BroadCasterAgency49618, BroadCasterAgency59065 | TVBCOHHUB3 |
And I logout from account
When I login with details of 'AgencyAdmin'
And created 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TVBCOHAR1     | TVBCOHBR1     | TVBCOHSB1     | TVBCOHP1    | TVBCOHC4    | TVBCOHCN4     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TVBCOHT4 |           |
And I open order item with following clock number 'TVBCOHCN4'
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
| TVBCOHJN4    | TVBCOHPO4  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TVBCOHCN4' to A4
And login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN4' will be available in Traffic
And wait till order with clockNumber 'TVBCOHCN4' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN4'
And hold following destinations for Select Broadcast Destinations form on order item page 'Airdate Traffic Services'
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'TVBCOHCN4'
Then I should see 'TVBCOHCN4' with value 'Yes' for on Hold Dest in order details page for destination 'Airdate Traffic Services'
When login with details of 'TVBCOHHUB_U3'
And wait till order item list will be loaded in Traffic
And enter search criteria 'TVBCOHCN4' in simple search form on Traffic Order List page
And I wait for '5' seconds
Then I 'should' see destinations 'CBC Vancouver' for order item in Traffic List with clockNumber 'TVBCOHCN4' at broadcaster level
And I 'should not' see destinations 'Airdate Traffic Services' for order item in Traffic List with clockNumber 'TVBCOHCN4' at broadcaster level



Scenario: Check that broadcaster hub manager cannot see SD and HD clones order item when whole clock is put ON-Hold
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVBCOHHUB4   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVBCOHHUB_U4    |       broadcast.traffic.manager       |  TVBCOHHUB4       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVBCOHHUB4                    |       true         |      two      |TVBCOHHUB_U4|TVBCOHHUB_U4|
And I add hub members via API:
| Hub Members                                    | Name       |
| BroadCasterAgency49618, BroadCasterAgency59065 | TVBCOHHUB4 |
When I login with details of 'AgencyAdmin'
And created 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TVBCOHAR1     | TVBCOHBR1     | TVBCOHSB1     | TVBCOHP1    | TVBCOHC5    | TVBCOHCN5     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TVBCOHT5 |           |
And I open order item with following clock number 'TVBCOHCN5'
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
| TVBCOHJN4    | TVBCOHPO4  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TVBCOHCN5' to A4
And login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN5' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN5'
And hold following destinations for Select Broadcast Destinations form on order item page 'Airdate Traffic Services'
And hold following destinations for Select Broadcast Destinations form on order item page 'CBC Vancouver'
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'TVBCOHCN5'
Then I should see 'TVBCOHCN5' with value 'Yes' for on Hold Dest in order details page for destination 'Airdate Traffic Services'
And I should see 'TVBCOHCN5' with value 'Yes' for on Hold Dest in order details page for destination 'CBC Vancouver'
When login with details of 'TVBCOHHUB_U4'
And I select 'All' tab in Traffic UI
And enter search criteria 'TVBCOHCN5' in simple search form on Traffic Order List page
Then 'should not' see orderItems 'TVBCOHCN5' in order item list in Traffic



Scenario: Check that braocaster manager can see a order item based on the clock On-Hold status when order has multiple clocks
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVBCOHHUB5   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVBCOHHUB_U5    |       broadcast.traffic.manager       |  TVBCOHHUB5       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVBCOHHUB5                    |       true         |      two      |TVBCOHHUB_U5|TVBCOHHUB_U5|
And I add hub members via API:
| Hub Members                                           | Name       |
| BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1 | TVBCOHHUB5 |
When login with details of 'AgencyAdmin'
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TVBCOHAR1       | TVBCOHBR1       | TVBCOHSB1       | TVBCOHP1      | TVBCOHC6    | TVBCOHCN6     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT6 | Motorvision TV:Express;Tele 5 DE - Longform:Express                      | 1          |
| automated test info    | TVBCOHAR1       | TVBCOHBR1       | TVBCOHSB1       | TVBCOHP1      | TVBCOHC7    | TVBCOHCN7     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT7 | Motorvision TV:Express                      | 1          |
And completed order contains item with clock number 'TVBCOHCN6' with following fields:
| Job Number   | PO Number    |
| TVBCOHJN6 | TVBCOHPO6 |
And waited for finish place order with following item clock number 'TVBCOHCN6' to A4
And waited for finish place order with following item clock number 'TVBCOHCN7' to A4
And login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN6' will have next status 'In Progress' in Traffic
And wait till order with clockNumber 'TVBCOHCN7' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN6'
And hold following destinations for Select Broadcast Destinations form on order item page 'Motorvision TV'
And wait for '2' seconds
And hold following destinations for Select Broadcast Destinations form on order item page 'Tele 5 DE - Longform'
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'TVBCOHCN6'
Then I should see 'TVBCOHCN6' with value 'Yes' for on Hold Dest in order details page for destination 'Motorvision TV'
And I should see 'TVBCOHCN6' with value 'Yes' for on Hold Dest in order details page for destination 'Tele 5 DE - Longform'
When login with details of 'TVBCOHHUB_U5'
And enter search criteria 'TVBCOHCN6' in simple search form on Traffic Order List page
Then 'should not' see orderItems 'TVBCOHCN6' in order item list in Traffic
When I clear search criteria in simple search form on Traffic Order List page
And enter search criteria 'TVBCOHCN7' in simple search form on Traffic Order List page
And I wait for '5' seconds
Then I 'should' see destinations 'Motorvision TV' for order item in Traffic List with clockNumber 'TVBCOHCN7' at broadcaster level




Scenario: Check that destination On-hold status gets updated to Yes for each of the destinations when a clock is having more than one destination
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TVBCOHAR1       | TVBCOHBR1       | TVBCOHSB1       | TVBCOHP1      | TVBCOHC8   | TVBCOHCN8    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT8 | TV Bayern Media:Express;Motorvision TV:Express;Tele 5 DE - Longform:Express                      | 1          |
And complete order contains item with clock number 'TVBCOHCN8' with following fields:
| Job Number   | PO Number    |
| TVBCOHJN8 | TVBCOHPO8 |
And wait for finish place order with following item clock number 'TVBCOHCN8' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN8' will be available in Traffic
And wait till order with clockNumber 'TVBCOHCN8' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN8'
And hold following destinations for Select Broadcast Destinations form on order item page 'TV Bayern Media'
And hold following destinations for Select Broadcast Destinations form on order item page 'Motorvision TV'
And hold following destinations for Select Broadcast Destinations form on order item page 'Tele 5 DE - Longform'
Then I 'should' see order item held for approval for active cover flow
And wait for '2' seconds
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order with clockNumber 'TVBCOHCN8' will be available in Traffic
And wait till order with clockNumber 'TVBCOHCN8' will have next status 'In Progress' in Traffic
And I am on order details page of clockNumber 'TVBCOHCN8'
Then I should see 'TVBCOHCN8' with value 'Yes' for on Hold Dest in order details page for destination 'TV Bayern Media'
And I should see 'TVBCOHCN8' with value 'Yes' for on Hold Dest in order details page for destination 'Motorvision TV'
And I should see 'TVBCOHCN8' with value 'Yes' for on Hold Dest in order details page for destination 'Tele 5 DE - Longform'



Scenario: Check that filter works correctly when a destination that is part of hub is put on hold and a destination that is part of outside hub is not put on hold
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVBCOHHUB7  | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVBCOHHUB_U7    |       broadcast.traffic.manager       |  TVBCOHHUB7       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVBCOHHUB7                    |       true         |      two      |TVBCOHHUB_U7|TVBCOHHUB_U7|
And I add hub members via API:
| Hub Members                                           | Name       |
| BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1 | TVBCOHHUB7 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TVBCOHAR1       | TVBCOHBR1       | TVBCOHSB1       | TVBCOHP1      | TVBCOHC10    | TVBCOHCN10     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT10 | Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express                      | 1          |
And complete order contains item with clock number 'TVBCOHCN10' with following fields:
| Job Number   | PO Number    |
| TVBCOHJN10 | TVBCOHPO10 |
And wait for finish place order with following item clock number 'TVBCOHCN10' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN10' will be available in Traffic
And wait till order with clockNumber 'TVBCOHCN10' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN10'
And hold following destinations for Select Broadcast Destinations form on order item page 'Motorvision TV'
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'TVBCOHCN10'
Then I should see 'TVBCOHCN10' with value 'Yes' for on Hold Dest in order details page for destination 'Motorvision TV'
When login with details of 'AgencyAdmin'
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency      |   TVBCOHCN10  |
And login with details of 'TVBCOHHUB_U7'
And wait till order item with clockNumber 'TVBCOHCN10' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Tele 5 DE - Longform'
And I create tab with name 'TestFilter' and type 'Order Item Clock' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |Filter By Status|
| Title | Starts with |  TVBCOHT10   |Proxy Ready For Approval|
And wait till order item list will be loaded in Traffic
And enter search criteria 'TVBCOHCN10' in simple search form on Traffic Order List page
And I wait for '5' seconds
Then I 'should' see destinations 'Tele 5 DE - Longform' for order item in Traffic List with clockNumber 'TVBCOHCN10' at broadcaster level
And I 'should not' see destinations 'Motorvision TV' for order item in Traffic List with clockNumber 'TVBCOHCN10' at broadcaster level
And I 'should not' see destinations 'Moviepilot' for order item in Traffic List with clockNumber 'TVBCOHCN10' at broadcaster level

Scenario: Check that filter works correctly when a destination that is part of outside hub is put on hold and a destination that is part of  hub is not put on hold
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVBCOHHUB8  | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVBCOHHUB_U8    |       broadcast.traffic.manager       |  TVBCOHHUB8       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVBCOHHUB8                    |       true         |      two      |TVBCOHHUB_U8|TVBCOHHUB_U8|
And I add hub members via API:
| Hub Members                                           | Name       |
| BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1 | TVBCOHHUB8 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TVBCOHAR1       | TVBCOHBR1       | TVBCOHSB1       | TVBCOHP1      | TVBCOHC11    | TVBCOHCN11     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT11 | Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express                      | 1          |
And complete order contains item with clock number 'TVBCOHCN11' with following fields:
| Job Number   | PO Number    |
| TVBCOHJN11 | TVBCOHPO11 |
And wait for finish place order with following item clock number 'TVBCOHCN11' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN11' will be available in Traffic
And wait till order with clockNumber 'TVBCOHCN11' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN11'
And hold following destinations for Select Broadcast Destinations form on order item page 'Moviepilot'
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'TVBCOHCN11'
Then I should see 'TVBCOHCN11' with value 'Yes' for on Hold Dest in order details page for destination 'Moviepilot'
When login with details of 'AgencyAdmin'
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency      |   TVBCOHCN11  |
And login with details of 'TVBCOHHUB_U8'
And wait till order item with clockNumber 'TVBCOHCN11' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Tele 5 DE - Longform'
And wait till order item with clockNumber 'TVBCOHCN11' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Motorvision TV'
And I create tab with name 'TestFilter' and type 'Order Item Clock' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |Filter By Status|
| Title | Starts with |  TVBCOHT11   |Proxy Ready For Approval|
And wait till order item list will be loaded in Traffic
And enter search criteria 'TVBCOHCN11' in simple search form on Traffic Order List page
And I wait for '5' seconds
Then I 'should' see destinations 'Tele 5 DE - Longform' for order item in Traffic List with clockNumber 'TVBCOHCN11' at broadcaster level
And I 'should' see destinations 'Motorvision TV' for order item in Traffic List with clockNumber 'TVBCOHCN11' at broadcaster level
And I 'should not' see destinations 'Moviepilot' for order item in Traffic List with clockNumber 'TVBCOHCN11' at broadcaster level


Scenario: Check that filter works correctly when a destination that is part of hub is put on hold and a destination that is part of outside hub is put on hold
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType         | Market  | DestinationID | Application Access |
| TVBCOHHUB9  | DefaultA4User | TV Broadcaster Hub | Germany |               | adpath             |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVBCOHHUB_U9    |       broadcast.traffic.manager       |  TVBCOHHUB9       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVBCOHHUB9                    |       true         |      two      |TVBCOHHUB_U9|TVBCOHHUB_U9|
And I add hub members via API:
| Hub Members                                           | Name       |
| BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1 | TVBCOHHUB9 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TVBCOHAR1       | TVBCOHBR1       | TVBCOHSB1       | TVBCOHP1      | TVBCOHC12    | TVBCOHCN12     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT12 | Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express                      | 1          |
And complete order contains item with clock number 'TVBCOHCN12' with following fields:
| Job Number   | PO Number    |
| TVBCOHJN12 | TVBCOHPO12 |
And wait for finish place order with following item clock number 'TVBCOHCN12' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TVBCOHCN12' will be available in Traffic
And wait till order with clockNumber 'TVBCOHCN12' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN12'
And hold following destinations for Select Broadcast Destinations form on order item page 'Moviepilot'
And hold following destinations for Select Broadcast Destinations form on order item page 'Motorvision TV'
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'TVBCOHCN12'
Then I should see 'TVBCOHCN12' with value 'Yes' for on Hold Dest in order details page for destination 'Moviepilot'
Then I should see 'TVBCOHCN12' with value 'Yes' for on Hold Dest in order details page for destination 'Motorvision TV'
When login with details of 'AgencyAdmin'
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency      |   TVBCOHCN12  |
And I logout from account
And login with details of 'TVBCOHHUB_U9'
And wait till order item with clockNumber 'TVBCOHCN12' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Tele 5 DE - Longform'
And I create tab with name 'TestFilter' and type 'Order Item Clock' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |Filter By Status|
| Title | Starts with |  TVBCOHT12   |Proxy Ready For Approval|
And wait till order item list will be loaded in Traffic
And enter search criteria 'TVBCOHCN12' in simple search form on Traffic Order List page
And I wait for '5' seconds
Then I 'should' see destinations 'Tele 5 DE - Longform' for order item in Traffic List with clockNumber 'TVBCOHCN12' at broadcaster level
And I 'should not' see destinations 'Motorvision TV' for order item in Traffic List with clockNumber 'TVBCOHCN12' at broadcaster level
And I 'should not' see destinations 'Moviepilot' for order item in Traffic List with clockNumber 'TVBCOHCN12' at broadcaster level