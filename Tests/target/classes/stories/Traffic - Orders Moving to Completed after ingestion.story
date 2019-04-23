Feature:    Orders Moving to Completed for Online Destination
Narrative:
In order to
As a              AgencyAdmin
I want to see orders moving to completed tab for online destination

Scenario: Check that For No Approval the A5 View Status is set to At Destination and Order moves to Completed for Online Destination
Meta:@traffic
Given I created the following agency:
| Name       |    A4User     |    AgencyType  | Application Access         |
| TMNAMTCA_1   | DefaultA4User |   Advertiser   |      ordering,streamlined_library      |
And created users with following fields:
| Email        |          Role             | AgencyUnique      |  Access          |
| TMNAMTCU_1   |       agency.admin        |   TMNAMTCA_1      | ordering,streamlined_library |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TMNAMTCA_1':
| Advertiser      | Brand           | Sub Brand      | Product      |
| TFADDSASRAR1    | TFADDSASRBR1    | TFADDSASRSB1   | TFADDSASRP1   |
And logged in with details of 'TMNAMTCU_1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser     | Brand       | Sub Brand   | Product    | Campaign   | Clock Number    | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title          | Destination           |
| automated test info    | TFADDSASRAR1   | TFADDSASRBR1| TFADDSASRSB1|TFADDSASRP1 | TFADDSASRC | TFADDSASRCN_2   | 20       | 1           | 12/14/2022     |   Already Supplied | HD 1080i 25fps | TFADDSASRTT1_1   | Travel Channel DE:Express       |
And added to 'tv' order item with clock number 'TFADDSASRCN_2' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And completed order contains item with clock number 'TFADDSASRCN_2' with following fields:
| Job Number    | PO Number   |
| TFADDSASRSR14 | TFADDSASR14 |
And waited for finish place order with following item clock number 'TFADDSASRCN_2' to A4
And open Order List page
And click on 'live' order in 'tv' order list for clockNumber 'TFADDSASRCN_2'
Then I 'should' see following destinations 'Travel Channel DE' for clock delivery 'TFADDSASRCN_2' on 'tv' order summary page with A5 View status as 'Received Media'
When ingested assests through A5 with following fields:
 | agencyName     | clockNumber    |
 | DefaultAgency  | TFADDSASRCN_2  |
And wait till order item with clockNumber 'TFADDSASRCN_2' will have view status 'At Destination'
And open Order List page
And wait for '2' seconds
Then I should see count orders '1' on 'View Completed Orders' tab in order slider
When I select 'View Completed Orders' tab on ordering page
Then I should see TV order in 'complete' order list with item clock number 'TFADDSASRCN_2' and following fields:
| Order# | DateTime    | Market      | PO Number     | Job #       | NoClocks | Status        |
| Digit  | CurrentTime | Germany     | TFADDSASR14 | TFADDSASRSR14 | 1        | 1/1 Delivered |
When click on 'complete' order in 'tv' order list for clockNumber 'TFADDSASRCN_2'
Then I 'should' see following destinations 'Travel Channel DE' for clock delivery 'TFADDSASRCN_2' on 'tv' order summary page with A5 View status as 'At Destination'
When login with details of 'trafficManager'
And wait till order item with clockNumber 'TFADDSASRCN_2' with destination 'Travel Channel DE' will have the next Destination Status 'Transfer Complete' in Traffic
And am on order details page of clockNumber 'TFADDSASRCN_2'
Then I should see 'TFADDSASRCN_2' in delivery status 'Transfer Complete' in order details page for destination 'Travel Channel DE'



Scenario: Check that When Approval is present the A5 View Status is set to At Destination and Order moves to Completed for Online Destination
Meta:@traffic
Given I updated the following agency:
| Name        | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |    broadcasterTrafficManagerTwo | broadcasterTrafficManagerTwo      |
And logged in with details of 'AgencyAdmin'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish2-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish2-Ad.mov'NEWLIB
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser     | Brand       | Sub Brand    | Product    | Campaign   | Clock Number    | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title          | Destination           |
| automated test info    | TFADDSASRAR1   | TFADDSASRBR1| TFADDSASRSB1 |TFADDSASRP1 | TFADDSASRC | TFADDSASRCN_1   | 20       | 1           | 12/14/2022     |   Already Supplied | HD 1080i 25fps | TFADDSASRTT2   | Motorvision TV:Express       |
And added to 'tv' order item with clock number 'TFADDSASRCN_1' following asset 'Fish2-Ad.mov' of collection 'My Assets'
And completed order contains item with clock number 'TFADDSASRCN_1' with following fields:
| Job Number    | PO Number  |
| TFADDSASRSR13 | TFADDSASR13 |
And waited for finish place order with following item clock number 'TFADDSASRCN_1' to A4
And open Order List page
And click on 'live' order in 'tv' order list for clockNumber 'TFADDSASRCN_1'
Then I 'should' see following destinations 'Motorvision TV' for clock delivery 'TFADDSASRCN_1' on 'tv' order summary page with A5 View status as 'Received Media'
When ingested assests through A5 with following fields:
 | agencyName     | clockNumber    |
 | DefaultAgency  | TFADDSASRCN_1  |
And wait till order item with clockNumber 'TFADDSASRCN_1' will have view status 'At Destination'
And open Order List page
And I select 'View Completed Orders' tab on ordering page
Then I should see TV order in 'complete' order list with item clock number 'TFADDSASRCN_1' and following fields:
| Order# | DateTime    | Market      | PO Number     | Job #       | NoClocks | Status        |
| Digit  | CurrentTime | Germany     | TFADDSASR13 | TFADDSASRSR13 | 1        | 1/1 Delivered |
When click on 'complete' order in 'tv' order list for clockNumber 'TFADDSASRCN_1'
Then I 'should' see following destinations 'Motorvision TV' for clock delivery 'TFADDSASRCN_1' on 'tv' order summary page with A5 View status as 'At Destination'
When login with details of 'trafficManager'
And wait till order item with clockNumber 'TFADDSASRCN_1' with destination 'Motorvision TV' will have the next Destination Status 'Awaiting station release' in Traffic
And select 'All' tab in Traffic UI
And am on order details page of clockNumber 'TFADDSASRCN_1'
Then I should see 'TFADDSASRCN_1' in delivery status 'Awaiting station release' in order details page for destination 'Motorvision TV'

Scenario: Check that For No Approval the A5 View Status is set to At Destination and Order moves to Completed for Offline destination
Meta:@traffic
Given I logged in with details of 'AnotherAgencyAdmin'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish7-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish7-Ad.mov'NEWLIB
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser     | Brand       | Sub Brand   | Product    | Campaign   | Clock Number    | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title          | Destination           |
| automated test info    | TFADDSASRAR1   | TFADDSASRBR1| TFADDSASRSB1|TFADDSASRP1 | TFADDSASRC | TFADDSASRCN_3   | 20       | 1           | 12/14/2022     |   Already Supplied | HD 1080i 25fps | TFADDSASRTT1_1   | MDF 1:Express       |
And added to 'tv' order item with clock number 'TFADDSASRCN_3' following asset 'Fish7-Ad.mov' of collection 'My Assets'
And completed order contains item with clock number 'TFADDSASRCN_3' with following fields:
| Job Number    | PO Number   |
| TFADDSASRSR16 | TFADDSASR16 |
And waited for finish place order with following item clock number 'TFADDSASRCN_3' to A4
And open Order List page
And click on 'live' order in 'tv' order list for clockNumber 'TFADDSASRCN_3'
And wait for '2' seconds
Then I 'should' see following destinations 'MDF 1' for clock delivery 'TFADDSASRCN_3' on 'tv' order summary page with A5 View status as 'Received Media'
When ingested assests through A5 with following fields:
| agencyName    | clockNumber   |
| AnotherAgency | TFADDSASRCN_3 |
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TFADDSASRCN_3' will be available in Traffic
And wait till order item with clockNumber 'TFADDSASRCN_3' will have view status 'Passed QC'
And open edit page for order with Clock Number 'TFADDSASRCN_3' in Traffic
And click at destination for 'MDF 1' destinations on Select Broadcast Destinations form on order item page:
|  Date       | Time     |
| 10/14/2016  | 10:30 AM |
And login with details of 'AnotherAgencyAdmin'
And open Order List page
And wait till order item with clockNumber 'TFADDSASRCN_3' will have view status 'At Destination'
And refresh the page without delay
Then I should see count orders '1' on 'View Completed Orders' tab in order slider
When I select 'View Completed Orders' tab on ordering page
Then I should see TV order in 'complete' order list with item clock number 'TFADDSASRCN_3' and following fields:
| Order# | DateTime    | Market      | PO Number     | Job #       | NoClocks | Status        |
| Digit  | CurrentTime | Germany     | TFADDSASR16 | TFADDSASRSR16 | 1        | 1/1 Delivered |
When click on 'complete' order in 'tv' order list for clockNumber 'TFADDSASRCN_3'
And wait for '2' seconds
Then I 'should' see following destinations 'MDF 1' for clock delivery 'TFADDSASRCN_3' on 'tv' order summary page with A5 View status as 'At Destination'
When login with details of 'trafficManager'
And am on order details page of clockNumber 'TFADDSASRCN_3'
Then I should see 'TFADDSASRCN_3' in delivery status 'Transfer Complete' in order details page for destination 'MDF 1'
