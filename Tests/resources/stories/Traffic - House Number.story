Feature:   Traffic BT User can assign house number
Narrative:
In order to
As a              AgencyAdmin
I want to check that BT user can add HN 


Lifecycle:
Before:
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand   | Sub Brand | Product |
| TAFADR1     | TAFBRD1 | TAFSBRD1  | TAFPRD1 |
And updated the following agency:
| Name                         | Escalation Enabled | Approval Type | Proxy Approver | Master Approver | Labels                                    |
| BroadCasterAgencyNoApproval  |                    |               |                |                 | MENA,dubbing_services,nVerge,FTP,Physical |
And updated the following agency:
| Name                       | Escalation Enabled | Approval Type | Proxy Approver               | Master Approver              |
| BroadCasterAgencyTwoStage  |       true         |      two      | broadcasterTrafficManagerTwo | broadcasterTrafficManagerTwo |
| BroadCasterAgencyOneStage  |       true         |      one      |                              | broadcasterTrafficManagerOne |

Scenario: Check that BT user is able to add House Number from order list and it is visible in order list and order item page
Meta:@traffic
     @qatrafficsmoke
     @uattrafficsmoke
     @criticaltraffictests
     @trafficcrossbrowser
Given created users with following fields:
| Email     |           Role               | Agency                         |  Access  | Password |
| BTCAHNU1_2   | broadcast.traffic.manager |   BroadCasterAgencyTwoStage    |  adpath  | abcdefghA1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TAFADR1     | TAFBRD1     | TAFSBRD1     | TAFPRD1    | TAFCP1    |  BTCAHNCN2   | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Standard  |
And complete order contains item with clock number 'BTCAHNCN2' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'BTCAHNCN2' to A4
And login as 'BTCAHNU1_2' of Agency 'BroadCasterAgencyTwoStage'
And waited till order item list will be loaded in Traffic
And waited till order with clockNumber 'BTCAHNCN2' will be available in Traffic
And entered search criteria 'BTCAHNCN2' in simple search form on Traffic Order Item List page
And waited for '4' seconds
When fill '22' House Number for order item with 'BTCAHNCN2' clock number on traffic order list
And refresh the page
Then I should see destination 'Talk Sport' for order item with clockNumber 'BTCAHNCN2' in traffic order list that have following data:
| House Number |
|     22       |
When on order item details page of clockNumber 'BTCAHNCN2'
Then 'should' see house number '22' on order details page in traffic


Scenario: Check that BT user is able to add House Number from order details page and it visible there and on order list page
Meta:@traffic
     @qatrafficsmoke
     @uattrafficsmoke
     @trafficdeploymentsanity
Given created users with following fields:
| Email     |           Role            | Agency |  Access  |  Password |
| BTCAHNU1_2   | broadcast.traffic.manager |   BroadCasterAgencyTwoStage    |  adpath  | abcdefghA1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TAFADR1     | TAFBRD1     | TAFSBRD1     | TAFPRD1    | TAFCP1    |  BTCAHNCN1   | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Standard  |
And complete order contains item with clock number 'BTCAHNCN1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login as 'BTCAHNU1_2' of Agency 'BroadCasterAgencyTwoStage'
And waited till order with clockNumber 'BTCAHNCN1' will be available in Traffic
And selected 'All' tab in Traffic UI
And waited till order item list will be loaded in Traffic
And I amon order item details page of clockNumber 'BTCAHNCN1'
When fill house number field with value '44' on order details page in traffic
And refresh the page
Then 'should' see house number '44' on order details page in traffic
And open Traffic Order List page
And wait for '10' seconds
And should see destination 'Talk Sport' for order item with clockNumber 'BTCAHNCN1' in traffic order list that have following data:
| House Number |
|     44       |


Scenario: Check that BT user is able to add House Number from order list and it is visible in order list and order item page for Mena Market
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TAFADR1     | TAFBRD1     | TAFSBRD1     | TAFPRD1    | TAFCP1    |  BTCAHNCN2_1 | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Travel Channel DE:Express  |
And complete order contains item with clock number 'BTCAHNCN2_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And logged in with details of 'broadcasterTrafficManagerNoApproval'
And waited till order with clockNumber 'BTCAHNCN2_1' will be available in Traffic
And selected 'All' tab in Traffic UI
And waited till order item list will be loaded in Traffic
And entered search criteria 'BTCAHNCN2_1' in simple search form on Traffic Order List page
And waited for '5' seconds
When I fill in House Number for order items in Traffic UI:
|  HouseNumber   |  clockNumber      |
| NCS |  BTCAHNCN2_1      |
And wait for '5' seconds
Then I should see destination 'Travel Channel DE' for order item with clockNumber 'BTCAHNCN2_1' in traffic order list that have following data:
| House Number |
|     NCS       |
When on order item details page of clockNumber 'BTCAHNCN2_1'
Then 'should' see house number 'NCS' on order details page in traffic



Scenario: Check that BT user is able to add MENA House Number from order details page and it visible there and on order list page
Meta:@traffic
Given created users with following fields:
| Email     |           Role            | Agency |  Access  | Password |
| BTCAHNU3_2   | broadcast.traffic.manager |   BroadCasterAgencyNoApproval    |  adpath  | abcdefghA1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TAFADR1     | TAFBRD1     | TAFSBRD1     | TAFPRD1    | TAFCP1    |  BTCAHNCN3   | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     | Travel Channel DE:Express  |
And complete order contains item with clock number 'BTCAHNCN3' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login as 'BTCAHNU3_2' of Agency 'BroadCasterAgencyNoApproval'
And waited till order with clockNumber 'BTCAHNCN3' will be available in Traffic
And I amon order item details page of clockNumber 'BTCAHNCN3'
When fill house number field with value 'NCS' on order details page in traffic
And refresh the page
Then 'should' see house number 'NCS' on order details page in traffic
When open Traffic Order List page
And wait till order item list will be loaded in Traffic
And should see destination 'Travel Channel DE' for order item with clockNumber 'BTCAHNCN3' in traffic order list that have following data:
| House Number |
|     NCS      |


Scenario: Check that HouseNumber is available in email
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TAFADR1     | TAFBRD1     | TAFSBRD1     | TAFPRD1    | TAFCP1    |  BTCAHNCN4   | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express  |
And complete order contains item with clock number 'BTCAHNCN4' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'BTCAHNCN4' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   BTCAHNCN4 |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber 'BTCAHNCN4' will be available in Traffic
And wait till order item with clockNumber 'BTCAHNCN4' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'BTCAHNCN4'
When I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|test_22          |
And wait for '3' seconds
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                  |  Comment  |
|      BTCAHN         |    Test   |
Then I 'should' see email with subject 'has been rejected' sent to user 'BTCAHN' and body contains 'test_22'


Scenario: Check that HN is uniq per destination
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TAFADR1     | TAFBRD1     | TAFSBRD1     | TAFPRD1    | TAFCP1    |  BTCAHNCN5_1 | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express  |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TAFADR1     | TAFBRD1     | TAFSBRD1     | TAFPRD1    | TAFCP1    |  BTCAHNCN5   | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express  |
And complete order contains item with clock number 'BTCAHNCN5' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number 'BTCAHNCN5_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And logged in with details of 'broadcasterTrafficManagerTwo'
And waited till order with clockNumber 'BTCAHNCN5' will be available in Traffic
And waited till order with clockNumber 'BTCAHNCN5_1' will be available in Traffic
And I amon order item details page of clockNumber 'BTCAHNCN5'
When fill house number field with value 'uniq_HN' on order details page in traffic
And open Traffic Order List page
And open order item details page with clockNumber 'BTCAHNCN5_1'
And fill house number field with value 'uniq_HN' on order details page in traffic without delay
Then I should see icon that house number is not uniq on order details page in traffic



Scenario: Check that user without HN edit permission is not able edit HN on order details page
Meta:@traffic
Given created 'BTCAHNR1' role with 'traffic.order.view.all,traffic.tab.default.view.all' permissions in 'global' group for advertiser 'BroadCasterAgencyTwoStage'
And created 'BTCAHNRZ1' role with 'traffic.edit.housenumber,traffic.order.view.all,traffic.tab.default.view.all' permissions in 'global' group for advertiser 'BroadCasterAgencyTwoStage'
And created users with following fields:
|    Email     |           Role            | Agency |  Access  | Password  |
| BTCAHNU6_2   |         BTCAHNR1          |   BroadCasterAgencyTwoStage   |  adpath  | abcdefghA1 |
| BTCAHNU6_3   |         BTCAHNRZ1         |   BroadCasterAgencyTwoStage   |  adpath  | abcdefghA1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TAFADR1     | TAFBRD1     | TAFSBRD1     | TAFPRD1    | TAFCP1    |  BTCAHNCN6   | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express  |
And complete order contains item with clock number 'BTCAHNCN6' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login as 'BTCAHNU6_2' of Agency 'BroadCasterAgencyTwoStage'
And waited till order with clockNumber 'BTCAHNCN6' will be available in Traffic
And opened order item details page with clockNumber 'BTCAHNCN6'
Then I 'should not' see edit house number field on order details page in traffic
When login as 'BTCAHNU6_3' of Agency 'BroadCasterAgencyTwoStage'
And wait till order with clockNumber 'BTCAHNCN6' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
When I amon order item details page of clockNumber 'BTCAHNCN6'
Then I 'should' see edit house number field on order details page in traffic

Scenario: Check that user without HN edit permission is not able edit HN from order list page
Meta:@traffic
Given created 'BTCAHNR2' role with 'traffic.order.view.all,traffic.tab.default.view.all' permissions in 'global' group for advertiser 'BroadCasterAgencyNoApproval'
And created 'BTCAHNRZ3' role with 'traffic.edit.housenumber,traffic.order.view.all,traffic.tab.default.view.all' permissions in 'global' group for advertiser 'BroadCasterAgencyNoApproval'
And created users with following fields:
|    Email     |           Role            | Agency                        |  Access  | Password |
| BTCAHNU7_2   |         BTCAHNR2          |   BroadCasterAgencyNoApproval   |  adpath  | abcdefghA1 |
| BTCAHNU7_3   |         BTCAHNRZ3         |   BroadCasterAgencyNoApproval   |  adpath  | abcdefghA1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |      Destination       |
| automated test info    | TAFADR1     | TAFBRD1     | TAFSBRD1     | TAFPRD1    | TAFCP1    |  BTCAHNCN7   | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     | Travel Channel DE:Express  |
And complete order contains item with clock number 'BTCAHNCN7' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login as 'BTCAHNU7_2' of Agency 'BroadCasterAgencyNoApproval'
When wait till order with clockNumber 'BTCAHNCN7' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'BTCAHNCN7' in simple search form on Traffic Order Item List page
Then I 'should not' see edit house number pencil icon on order details page in traffic for clock number 'BTCAHNCN7'
When login as 'BTCAHNU7_3' of Agency 'BroadCasterAgencyNoApproval'
And wait till order with clockNumber 'BTCAHNCN7' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'BTCAHNCN7' in simple search form on Traffic Order Item List page
Then I 'should' see edit house number pencil icon on order details page in traffic for clock number 'BTCAHNCN7'


Scenario: Check that house number is grouped on order details page and order list item page
!--NIR-1156
Meta:@traffic
@tbug
!--NIR-268
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name          | A4User            | AgencyType              | Market                 |DestinationID|Application Access|
| BTCAHNA_4     | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email        |           Role                        | AgencyUnique   |  Access  |
| BTCAHNU_2    |       broadcast.traffic.manager       |  BTCAHNA_4     | adpath   |
And I am on agency 'BTCAHNA_4' super hub members page
And I add super hub members:
|Super Hub Members|
|A5TestBroadcastTwoStage   |
|A5TestBroadcastOneStage   |
|A5TestBroadcastNoApproval |
And I add house number:
|House Number|
|1           |
|1           |
|2           |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                                                 |
| automated test info    | TAFADR1       | TAFBRD1       | TAFSBRD1       | TAFPRD1      | BTCAHNC1    |BTCAHNCN_1      | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | BTCAHNT1  |  Motorvision TV:Express;TV Bayern Media:Express;Travel Channel DE:Express   |
And I complete order contains item with clock number 'BTCAHNCN_1' with following fields:
| Job Number  | PO Number |
| BTCAHNJN1   | BTCAHNPO1 |
And I logged in with details of 'BTCAHNU_2'
And I waited till order with clockNumber 'BTCAHNCN_1' will be available in Traffic
And I amon order item details page of clockNumber 'BTCAHNCN_1'
When fill house number field with value '12' on order details page in traffic
Then I should see house number grouped on order details page in traffic:
|Destination|House Number|
|Motorvision TV|12          |
|TV Bayern Media |12          |
|Travel Channel DE   |            |
When I click on 'Back' button on order item details page in traffic
And wait till order item list will be loaded in Traffic
And enter search criteria 'BTCAHNCN_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destination 'Motorvision TV' with house number '12' for order item in Traffic List with clockNumber 'BTCAHNCN_1'
And I 'should' see destination 'TV Bayern Media' with house number '12' for order item in Traffic List with clockNumber 'BTCAHNCN_1'
And I 'should' see destination 'Travel Channel DE' with house number '' for order item in Traffic List with clockNumber 'BTCAHNCN_1'


Scenario: Check that house number is not grouped for MENA market
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name          | A4User            | AgencyType              | Market                 |DestinationID|Application Access|Labels|
| BTCAHNA_9     | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |MENA  |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| BTCAHNU_4  |       broadcast.traffic.manager       |  BTCAHNA_9     | adpath   |
And I am on agency 'BTCAHNA_9' super hub members page
And I add super hub members:
|Super Hub Members|
|A5TestBroadcastTwoStage   |
|A5TestBroadcastOneStage   |
|A5TestBroadcastNoApproval |     |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                                                      |
| automated test info    | TAFADR1       | TAFBRD1       | TAFSBRD1       | TAFPRD1      | BTCAHNC1    |BTCAHNCN1_2     | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | BTCAHNT1  |  Motorvision TV:Express;TV Bayern Media:Express;Travel Channel DE:Express        |
And I complete order contains item with clock number 'BTCAHNCN1_2' with following fields:
| Job Number  | PO Number |
| BTCAHNJN1   | BTCAHNPO1 |
And I logged in with details of 'BTCAHNU_4'
And I waited till order with clockNumber 'BTCAHNCN1_2' will be available in Traffic
And I amon order item details page of clockNumber 'BTCAHNCN1_2'
And I select existing house number for the destination on order details page:
|Destination|House Number|
|Motorvision TV|NCS         |
Then I should not see house number grouped on order details page in traffic:
|Destination|House Number|
|TV Bayern Media |N/A         |
|Travel Channel DE  |N/A         |

Scenario: HouseNumber should keep its history on Re Editing (MENA template)
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser     | Brand          | Sub Brand    | Product       | Campaign      | Clock Number   | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title        | Destination            |
| automated test info    | TAFADR1         | TAFBRD1         | TAFSBRD1       | TAFPRD1        | BTCAHNREC1    | <ClockNumber>  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | BTSKHHNRET1  |  Travel Channel DE:Express   |
And I complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number     | PO Number    |
| BTSKHHNREJN1   | BTSKHHNREPO1 |
And I logged in with details of 'broadcasterTrafficManagerNoApproval'
And I waited till order with clockNumber '<ClockNumber>' will be available in Traffic
And I amon order item details page of clockNumber '<ClockNumber>'
And verify house number is not set in order item details page for Mena Market in traffic
When I fill house number field with value '<HouseNumber>' on order details page in traffic
And I edit house number field with value '<New_HouseNumber>' on order details page in traffic
And I edit house number field with value '<HouseNumber>' on order details page in traffic
Then I should see House Number restored after ReEditing of '<HouseNumber>'

Examples:
| ClockNumber    |   HouseNumber  | New_HouseNumber  |
| BTSKHHNRECN_1  |   NCS          |  CS              |
| BTSKHHNRECN_2  |   ECS          |  NCS             |
| BTSKHHNRECN_3  |   CS           |  ECS             |


Scenario: HouseNumber should keep its history on deletion (MENA template)
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination           |
| automated test info    | TAFADR1       | TAFBRD1       | TAFSBRD1       | TAFPRD1      | BTCAHNC1    | <ClockNumber>  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | BTSKHHNT1  |  Travel Channel DE:Express |
And I complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number  | PO Number |
| BTSKHHNJN1   | BTSKHHNPO1 |
And I logged in with details of 'broadcasterTrafficManagerNoApproval'
And I waited till order with clockNumber '<ClockNumber>' will be available in Traffic
And I amon order item details page of clockNumber '<ClockNumber>'
And verify house number is not set in order item details page for Mena Market in traffic
When fill house number field with value '<HouseNumber>' on order details page in traffic
And delete house number field on order details page
And wait for '2' seconds
And fill house number field with value '<HouseNumber>' on order details page in traffic
Then I should see House Number restored after ReEditing of '<HouseNumber>'

Examples:
| ClockNumber  |   HouseNumber  |
| BTSKHHNCN_1  |   NCS          |
| BTSKHHNCN_2  |   ECS          |
| BTSKHHNCN_3  |   CS           |





