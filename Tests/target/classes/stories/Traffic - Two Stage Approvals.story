Feature:    Traffic Approval Emails functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check approval emails


Lifecycle:
Before:
Given I created the following agency:
| Name    | A4User        | AgencyType     | Application Access |  Market  | DestinationID |    A4User     |
| TAFA1   | DefaultA4User | Advertiser     | ordering           |          |               | DefaultA4User |
And created users with following fields:
| Email            | Role                      | AgencyUnique |  Access  |
| TAFU1            | agency.admin              | TAFA1        | ordering |
And created users with following fields:
| Email                | Role                      | Agency                           |  Access  |  Password  |
| BroadCastManagerTS_1 | broadcast.traffic.manager | BroadCasterAgencyTwoStage_1      |  adpath  | abcdefghA1 |
| BroadCastManagerTS_2 | broadcast.traffic.manager | BroadCasterAgencyTwoStage_1      |  adpath  | abcdefghA1 |
| BroadCastManagerTS_3 | broadcast.traffic.manager | BroadCasterAgencyTwoStage_1      |  adpath  | abcdefghA1 |
| BroadCastManagerTS_6 | broadcast.traffic.manager | BroadCasterAgencyTwoStage_1      |  adpath  | abcdefghA1 |
| BroadCastManagerTS_4 | broadcast.traffic.manager | BroadCasterAgencyTwoStage_1      |  adpath  | abcdefghA1 |
And updated the following agency:
| Name                         | Escalation Enabled | Approval Type | Proxy Approver                                                                                                                          | Master Approver                                                                                                                         |
| BroadCasterAgencyTwoStage_1  | true               | two           | broadcasterTrafficManagerTwo_1,BroadCastManagerTS_1,BroadCastManagerTS_2,BroadCastManagerTS_3,BroadCastManagerTS_6,BroadCastManagerTS_4 | broadcasterTrafficManagerTwo_1,BroadCastManagerTS_1,BroadCastManagerTS_2,BroadCastManagerTS_3,BroadCastManagerTS_6,BroadCastManagerTS_4 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TAFA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    |


Scenario: Check that on 'Release Master' for each order item triggers correct emails (Two Stage Approval)
Meta: @traffic
      @qatrafficsmoke
      @trafficemails
Given I logged in with details of 'TAFU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP1    | TAFCN3_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT3_1   |  Tele 5 DE - Longform:Express |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP2    | TAFCN3_2     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT3_2   |  Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TAFCN3_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN3_1' to A4
And wait for finish place order with following item clock number 'TAFCN3_2' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| TAFA1      |   TAFCN3_1  |
| TAFA1      |   TAFCN3_2  |
And login as 'BroadCastManagerTS_6' of Agency 'BroadCasterAgencyTwoStage_1'
And waited till order with clockNumber 'TAFCN3_1' will be available in Traffic
And waited till order with clockNumber 'TAFCN3_2' will be available in Traffic
And waited till order item with clockNumber 'TAFCN3_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN3_1'
When I click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                             |
| test4_1 | Proxy Approved for first order item |
And wait till order item with clockNumber 'TAFCN3_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                |  Comment                              |
| test4_2 |  Master Released for first order item |
And wait till order item with clockNumber 'TAFCN3_1' will have broadcaster status 'Master Released' in Traffic
And on order item details page of clockNumber 'TAFCN3_2'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test5_1 | Proxy Approved for second order item |
And wait till order item with clockNumber 'TAFCN3_2' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page without delay
And click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                |  Comment                               |
| test5_2 |  Master Released for second order item |
Then I 'should' see email notification for 'Preview file for has been approved' with field to 'test4_1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TAFCN3_1     | TAFAR1     | TAFSP1  | TAFT3_1 | 10       | Tele 5 DE - Longform | Proxy Approved for first order item |
And 'should' see email notification for 'Preview file for has been approved' with field to 'test5_1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TAFCN3_2     | TAFAR1     | TAFSP1  | TAFT3_2 | 20       | Tele 5 DE - Longform | Proxy Approved for second order item |
Then I 'should' see email notification for 'has been released for delivery' with field to 'test4_2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TAFCN3_1     | TAFAR1     | TAFSP1  | TAFT3_1 | 10       | Tele 5 DE - Longform | Master Released for first order item |
And 'should' see email notification for 'has been released for delivery' with field to 'test5_2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TAFCN3_2     | TAFAR1     | TAFSP1  | TAFT3_2 | 20       | Tele 5 DE - Longform | Master Released for second order item |


Scenario: Check that on 'Escalate Master' for each order item triggers correct emails (Two Stage Approval)
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TAFU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP1    | TAFCN1_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1_1   |  Tele 5 DE - Longform:Express |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP2    | TAFCN1_2     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1_2   |  Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TAFCN1_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN1_1' to A4
And wait for finish place order with following item clock number 'TAFCN1_2' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| TAFA1      |   TAFCN1_1  |
| TAFA1      |   TAFCN1_2  |
And login as 'BroadCastManagerTS_1' of Agency 'BroadCasterAgencyTwoStage_1'
And waited till order with clockNumber 'TAFCN1_1' will be available in Traffic
And waited till order with clockNumber 'TAFCN1_2' will be available in Traffic
And waited till order item with clockNumber 'TAFCN1_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And waited till order item with clockNumber 'TAFCN1_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN1_1'
And refreshed the page
And clicked on 'Approve Proxy' button on order item details page in traffic
And filled the following fields on approval traffic pop up:
| Email                | Comment                             |
| test1_1 | Proxy Approved for first order item |
And waited for '5' seconds
And refreshed the page
When I click on 'Escalate Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_2 | Master Escalated for first order item |
And wait for '5' seconds
And wait till order item with clockNumber 'TAFCN1_1' will have broadcaster status 'Master Escalated' in Traffic
And on order item details page of clockNumber 'TAFCN1_2'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test2_1 | Proxy Approved for second order item |
And refresh the page
And click on 'Escalate Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                                |
| test2_2 | Master Escalated for second order item |
Then I 'should' see email notification for 'Master escalation has been submitted' with field to 'test1_2' and subject 'Master escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               | Approval By      |
| TAFCN1_1     | TAFAR1     | TAFSP1  | TAFT1_1 | 10       | Tele 5 DE - Longform | Master Escalated for first order item | broadcasterTrafficManagerTwo_1 |
And 'should' see email notification for 'Preview file for has been approved' with field to 'test1_1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TAFCN1_1     | TAFAR1     | TAFSP1  | TAFT1_1 | 10       | Tele 5 DE - Longform | Proxy Approved for first order item |
And 'should' see email notification for 'Master escalation has been submitted' with field to 'test2_2' and subject 'Master escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                                | Approval By      |
| TAFCN1_2     | TAFAR1     | TAFSP1  | TAFT1_2 | 20       | Tele 5 DE - Longform | Master Escalated for second order item | broadcasterTrafficManagerTwo_1 |
And 'should' see email notification for 'Preview file for has been approved' with field to 'test2_1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TAFCN1_2     | TAFAR1     | TAFSP1  | TAFT1_2 | 20       | Tele 5 DE - Longform | Proxy Approved for second order item |
When I logout from account
And open link from email with subject 'Master escalation for TAFCN1_1' which user 'test1_2' received
And wait till order item page will be loaded in Traffic
Then I 'should' see playable preview on order item details page in traffic
When I open link from email with subject 'Master escalation for TAFCN1_2' which user 'test2_2' received
And wait till order item page will be loaded in Traffic
And wait for '5' seconds
Then I 'should' see playable preview on order item details page in traffic


Scenario: Check that on 'Force Release Master' for each order item triggers correct emails (Two Stage Approval)
Meta: @traffic
      @qatrafficsmoke
      @trafficemails
Given I logged in with details of 'TAFU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP1    | TAFCN8_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT8_1   |  Tele 5 DE - Longform:Express |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP2    | TAFCN8_2     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT8_2   |  Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TAFCN8_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN8_1' to A4
And wait for finish place order with following item clock number 'TAFCN8_2' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| TAFA1      |   TAFCN8_1  |
| TAFA1      |   TAFCN8_2  |
And login as 'BroadCastManagerTS_2' of Agency 'BroadCasterAgencyTwoStage_1'
And waited till order with clockNumber 'TAFCN8_1' will be available in Traffic
And waited till order with clockNumber 'TAFCN8_2' will be available in Traffic
And waited till order item with clockNumber 'TAFCN8_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And waited till order item with clockNumber 'TAFCN8_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN8_1'
When I click on 'Force Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                 | Comment                                   |
| test11_1 | Force Release Master for first order item |
And wait for '5' seconds
And on order item details page of clockNumber 'TAFCN8_2'
And refresh the page
And click on 'Force Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                 | Comment                                    |
| test12_1 | Force Release Master for second order item |
And wait for '5' seconds
Then I 'should' see email notification for 'has been released for delivery' with field to 'test11_1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                                   |
| TAFCN8_1     | TAFAR1     | TAFSP1  | TAFT8_1 | 10       | Tele 5 DE - Longform | Force Release Master for first order item |
And 'should' see email notification for 'has been released for delivery' with field to 'test12_1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                                    |
| TAFCN8_2     | TAFAR1     | TAFSP1  | TAFT8_2 | 20       | Tele 5 DE - Longform | Force Release Master for second order item |


Scenario: Check that on 'Escalate Proxy' for each order item triggers correct emails (Two Stage Approval)
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TAFU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP1    | TAFCN7_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT7_1   |  Tele 5 DE - Longform:Express |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP2    | TAFCN7_2     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT7_2   |  Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TAFCN7_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN7_1' to A4
And wait for finish place order with following item clock number 'TAFCN7_2' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| TAFA1      |   TAFCN7_1  |
| TAFA1      |   TAFCN7_2  |
And login as 'BroadCastManagerTS_3' of Agency 'BroadCasterAgencyTwoStage_1'
And waited till order item list will be loaded in Traffic
And waited till order with clockNumber 'TAFCN7_1' will be available in Traffic
And waited till order with clockNumber 'TAFCN7_2' will be available in Traffic
And waited till order item with clockNumber 'TAFCN7_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And waited till order item with clockNumber 'TAFCN7_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN7_1'
And refreshed the page without delay
When I click on 'Escalate Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                 | Comment                              |
| test10_1 | Proxy Escalated for first order item |
And wait till order item with clockNumber 'TAFCN7_1' will have broadcaster status 'Proxy Escalated' in Traffic
And on order item details page of clockNumber 'TAFCN7_2'
And click on 'Escalate Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                 | Comment                               |
| test11_1 | Proxy Escalated for second order item |
And wait till order item with clockNumber 'TAFCN7_2' will have broadcaster status 'Proxy Escalated' in Traffic
Then I 'should' see email notification for 'Preview escalation has been submitted' with field to 'test10_1' and subject 'Preview escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              | Approval By      |
| TAFCN7_1     | TAFAR1     | TAFSP1  | TAFT7_1 | 10       | Tele 5 DE - Longform | Proxy Escalated for first order item | broadcasterTrafficManagerTwo_1 |
And 'should' see email notification for 'Preview escalation has been submitted' with field to 'test11_1' and subject 'Preview escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               | Approval By      |
| TAFCN7_2     | TAFAR1     | TAFSP1  | TAFT7_2 | 20       | Tele 5 DE - Longform | Proxy Escalated for second order item | broadcasterTrafficManagerTwo_1 |
When I logout from account
And open link from email with subject 'Preview escalation for TAFCN7_1' which user 'test10_1' received
And wait till order item page will be loaded in Traffic
Then I 'should' see playable preview on order item details page in traffic
When I open link from email with subject 'Preview escalation for TAFCN7_2' which user 'test11_1' received
And wait till order item page will be loaded in Traffic
And wait for '5' seconds
Then I 'should' see playable preview on order item details page in traffic


Scenario: Check that on 'Approve Proxy' for each order item triggers correct emails (Two Stage Approval)
Meta: @traffic
      @trafficemails
      @qatrafficsmoke
      @criticaltraffictests
      @trafficdeploymentsanity
Given I logged in with details of 'TAFU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP1    | TAFCN2_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT2_1   |  Tele 5 DE - Longform:Express |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP2    | TAFCN2_2     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT2_2   |  Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TAFCN2_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |             Destination                |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP3    | TAFCN2_3     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT2_3     |  Tele 5 DE - Longform:Express;Travel Channel DE:Express   |
And complete order contains item with clock number 'TAFCN2_3' with following fields:
| Job Number  | PO Number   |
| TTVBTVS11_1 | TTVBTVS11_1 |
And wait for finish place order with following item clock number 'TAFCN2_1' to A4
And wait for finish place order with following item clock number 'TAFCN2_2' to A4
And wait for finish place order with following item clock number 'TAFCN2_3' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| TAFA1      |   TAFCN2_1  |
| TAFA1      |   TAFCN2_2  |
| TAFA1      |   TAFCN2_3  |
And login as 'BroadCastManagerTS_2' of Agency 'BroadCasterAgencyTwoStage_1'
And waited till order with clockNumber 'TAFCN2_1' will be available in Traffic
And waited till order with clockNumber 'TAFCN2_2' will be available in Traffic
And waited till order item with clockNumber 'TAFCN2_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And waited till order item with clockNumber 'TAFCN2_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN2_1'
When I click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email   | Comment                                            |
| test3_1 | Proxy Approved for first order item in first order |
And on order item details page of clockNumber 'TAFCN2_2'
And refresh the page
And I wait for '5' seconds
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email   | Comment                                             |
| test3_2 | Proxy Approved for second order item in first order |
Then I 'should' see email notification for 'Preview file for has been approved' with field to 'test3_1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations         | Comment                                            |
| TAFCN2_1     | TAFAR1     | TAFSP1  | TAFT2_1 | 10       | Tele 5 DE - Longform | Proxy Approved for first order item in first order |
And 'should' see email notification for 'Preview file for has been approved' with field to 'test3_2' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations         | Comment                                             |
| TAFCN2_2     | TAFAR1     | TAFSP1  | TAFT2_2 | 20       | Tele 5 DE - Longform | Proxy Approved for second order item in first order |
When I wait till order item with clockNumber 'TAFCN2_3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN2_3'
When I click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email   | Comment                                             |
| test3_3 | Proxy Approved for first order item in second order |
Then I 'should' see email notification for 'Preview file for has been approved' with field to 'test3_3' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations         | Comment                                             |
| TAFCN2_3     | TAFAR1     | TAFSP1  | TAFT2_3 | 20       | Tele 5 DE - Longform | Proxy Approved for first order item in second order |
And 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And I 'should not' see email with subject 'has been approved' sent to user 'test1_1' and body contains 'Travel Channel DE'

Scenario: Check that on 'Reject Master' for each order item triggers correct emails (Two Stage Approval)
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TAFU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP1    | TAFCN4_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4_1   |  Tele 5 DE - Longform:Express |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP2    | TAFCN4_2     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4_2   |  Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TAFCN4_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN4_1' to A4
And wait for finish place order with following item clock number 'TAFCN4_2' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| TAFA1      |   TAFCN4_1  |
| TAFA1      |   TAFCN4_2  |
And login as 'BroadCastManagerTS_4' of Agency 'BroadCasterAgencyTwoStage_1'
And waited till order with clockNumber 'TAFCN4_1' will be available in Traffic
And waited till order with clockNumber 'TAFCN4_2' will be available in Traffic
And waited till order item with clockNumber 'TAFCN4_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And waited till order item with clockNumber 'TAFCN4_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN4_1'
When I click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                             |
| test6_1 | Proxy Approved for first order item |
And wait till order item with clockNumber 'TAFCN4_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                |  Comment                              |
| test6_2 |  Master Rejected for first order item |
And wait till order item with clockNumber 'TAFCN4_1' will have broadcaster status 'Master Rejected' in Traffic
And on order item details page of clockNumber 'TAFCN4_2'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test7_1 | Proxy Approved for second order item |
And wait till order item with clockNumber 'TAFCN4_2' will have broadcaster status 'Master Ready For Approval' in Traffic
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                |  Comment                               |
| test7_2 |  Master Rejected for second order item |
Then I 'should' see email notification for 'Preview file for has been approved' with field to 'test6_1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TAFCN4_1     | TAFAR1     | TAFSP1  | TAFT4_1 | 10       | Tele 5 DE - Longform | Proxy Approved for first order item |
And 'should' see email notification for 'Preview file for has been approved' with field to 'test7_1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TAFCN4_2     | TAFAR1     | TAFSP1  | TAFT4_2 | 20       | Tele 5 DE - Longform | Proxy Approved for second order item |
And 'should' see email notification for 'has been rejected' with field to 'test6_2' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TAFCN4_1     | TAFAR1     | TAFSP1  | TAFT4_1 | 10       | Tele 5 DE - Longform | Master Rejected for first order item |
And 'should' see email notification for 'has been rejected' with field to 'test7_2' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TAFCN4_2     | TAFAR1     | TAFSP1  | TAFT4_2 | 20       | Tele 5 DE - Longform | Master Rejected for second order item |



Scenario: Check that on 'Reject Proxy' for each order item triggers correct emails (Two Stage Approval)
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TAFU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP1    | TAFCN5_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT5_1   |  Tele 5 DE - Longform:Express |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP2    | TAFCN5_2     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT5_2   |  Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TAFCN5_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination                                           |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP3    | TAFCN5_3     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT5_3   |  Tele 5 DE - Longform:Express;Travel Channel DE:Express |
And complete order contains item with clock number 'TAFCN5_3' with following fields:
| Job Number  | PO Number   |
| TTVBTVS11_2 | TTVBTVS11_2 |
And wait for finish place order with following item clock number 'TAFCN5_1' to A4
And wait for finish place order with following item clock number 'TAFCN5_2' to A4
And wait for finish place order with following item clock number 'TAFCN5_3' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| TAFA1      |   TAFCN5_1  |
| TAFA1      |   TAFCN5_2  |
| TAFA1      |   TAFCN5_3  |
And logged in with details of 'broadcasterTrafficManagerTwo_1'
And waited till order with clockNumber 'TAFCN5_1' will be available in Traffic
And waited till order with clockNumber 'TAFCN5_2' will be available in Traffic
And waited till order with clockNumber 'TAFCN5_3' will be available in Traffic
And waited till order item with clockNumber 'TAFCN5_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And waited till order item with clockNumber 'TAFCN5_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN5_1'
When I click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email   | Comment                             |
| test8_1 | Proxy Rejected for first order item |
And wait till order item with clockNumber 'TAFCN5_1' will have broadcaster status 'Proxy Rejected' in Traffic
And open Traffic Order List page
And on order item details page of clockNumber 'TAFCN5_2'
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email   | Comment                              |
| test9_1 | Proxy Rejected for second order item |
Then I 'should' see email notification for 'Preview file for has been rejected' with field to 'test8_1' and subject 'Preview file for clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TAFCN5_1     | TAFAR1     | TAFSP1  | TAFT5_1 | 10       | Tele 5 DE - Longform | Proxy Rejected for first order item |
And 'should' see email notification for 'Preview file for has been rejected' with field to 'test9_1' and subject 'Preview file for clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TAFCN5_2     | TAFAR1     | TAFSP1  | TAFT5_2 | 20       | Tele 5 DE - Longform | Proxy Rejected for second order item |
When I wait till order item with clockNumber 'TAFCN5_3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN5_3'
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
| Email   |  Comment                                            |
| test9_2 | Proxy Rejected for first order item in second order |
Then I 'should' see 'Proxy Rejected' Broadcaster Approval Status on on order item details page in traffic
And 'should' see email notification for 'Preview file for has been rejected' with field to 'test9_2' and subject 'Preview file for clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations         | Comment                                             |
| TAFCN5_3     | TAFAR1     | TAFSP1  | TAFT5_3 | 10       | Tele 5 DE - Longform | Proxy Rejected for first order item in second order |
And I 'should not' see email with subject 'has been rejected' sent to user 'test9_2' and body contains 'Travel Channel DE'

Scenario: Check that on 'Restore Proxy' for each order item triggers correct emails (Two Stage Approval)
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TAFU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP1    | TAFCN6_1     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT6_1   |  Tele 5 DE - Longform:Express |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP2    | TAFCN6_2     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT6_2   |  Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TAFCN6_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination            |
| automated test info    | TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    | TAFCP3    | TAFCN6_3     | 10       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT6_3   | Tele 5 DE - Longform:Express;Travel Channel DE:Express |
And complete order contains item with clock number 'TAFCN6_3' with following fields:
| Job Number  | PO Number   |
| TTVBTVS11_4 | TTVBTVS11_4 |
And wait for finish place order with following item clock number 'TAFCN6_1' to A4
And wait for finish place order with following item clock number 'TAFCN6_2' to A4
And wait for finish place order with following item clock number 'TAFCN6_3' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| TAFA1      |   TAFCN6_1  |
| TAFA1      |   TAFCN6_2  |
| TAFA1      |   TAFCN6_3  |
And logged in with details of 'broadcasterTrafficManagerTwo_1'
And waited till order with clockNumber 'TAFCN6_1' will be available in Traffic
And waited till order with clockNumber 'TAFCN6_2' will be available in Traffic
And waited till order with clockNumber 'TAFCN6_3' will be available in Traffic
And waited till order item with clockNumber 'TAFCN6_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN6_1'
And clicked on 'Reject Proxy' button on order item details page in traffic
And filled the following fields on approval traffic pop up:
| Email                | Comment                             |
| test10_1 | Proxy Rejected for first order item |
And waited till order item with clockNumber 'TAFCN6_1' will have broadcaster status 'Proxy Rejected' in Traffic
When I click on 'Restore Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test10_1 | Proxy Restored for first order item |
And open Traffic Order List page
And on order item details page of clockNumber 'TAFCN6_2'
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test11_1 | Proxy Rejected for second order item |
And wait till order item with clockNumber 'TAFCN6_2' will have broadcaster status 'Proxy Rejected' in Traffic
And click on 'Restore Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test11_1 | Proxy Restored for second order item |
Then I 'should' see email notification for 'Preview file for has been rejected' with field to 'test10_1' and subject 'Preview file for clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TAFCN6_1     | TAFAR1     | TAFSP1  | TAFT6_1 | 10       | Tele 5 DE - Longform | Proxy Rejected for first order item |
And 'should' see email notification for 'Preview file for has been rejected' with field to 'test11_1' and subject 'Preview file for clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TAFCN6_2     | TAFAR1     | TAFSP1  | TAFT6_2 | 20       | Tele 5 DE - Longform | Proxy Rejected for second order item |
And 'should' see email notification for 'Preview file for has been restored' with field to 'test10_1' and subject 'Preview file for clockNumber has been restored' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TAFCN6_1     | TAFAR1     | TAFSP1  | TAFT6_1 | 10       | Tele 5 DE - Longform | Proxy Restored for first order item |
And 'should' see email notification for 'Preview file for has been restored' with field to 'test11_1' and subject 'Preview file for clockNumber has been restored' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TAFCN6_2     | TAFAR1     | TAFSP1  | TAFT6_2 | 20       | Tele 5 DE - Longform | Proxy Restored for second order item |
When I wait till order item with clockNumber 'TAFCN6_3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN6_3'
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email    | Comment                                             |
| test11_2 | Proxy Rejected for first order item of second order |
And wait till order item with clockNumber 'TAFCN6_3' will have broadcaster status 'Proxy Rejected' in Traffic
And click on 'Restore Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email    | Comment                                             |
| test11_2 | Proxy Restored for first order item of second order |
Then I 'should' see email notification for 'Preview file for has been rejected' with field to 'test11_2' and subject 'Preview file for clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations         | Comment                                             |
| TAFCN6_3     | TAFAR1     | TAFSP1  | TAFT6_3 | 10       | Tele 5 DE - Longform | Proxy Rejected for first order item of second order |
And 'should' see email notification for 'Preview file for has been restored' with field to 'test11_2' and subject 'Preview file for clockNumber has been restored' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations         | Comment                                             |
| TAFCN6_3     | TAFAR1     | TAFSP1  | TAFT6_3 | 10       | Tele 5 DE - Longform | Proxy Restored for first order item of second order |
And 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic