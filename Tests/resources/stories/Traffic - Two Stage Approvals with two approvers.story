
Feature:    Traffic Approval Emails functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check approval emails


Lifecycle:
Before:
Given I created the following agency:
| Name      | A4User        | AgencyType     | Application Access |  Market  | DestinationID |    A4User     |
| TTSATDAA1 | DefaultA4User | Advertiser     | ordering           |          |               | DefaultA4User |
And created users with following fields:
| Email       | Role                      | AgencyUnique |  Access  |
| TTSATDAU1   | agency.admin              | TTSATDAA1    | ordering |
And created users with following fields:
| Email       | Role                      | Agency |  Access  | Password |
| TTSATDA_BTM1 | broadcast.traffic.manager | BroadCasterAgencyTwoStage_1    |  adpath  | abcdefghA1 |
| TTSATDA_BTM2 | broadcast.traffic.manager | BroadCasterAgencyTwoStage_1    |  adpath  | abcdefghA1 |
And updated the following agency:
| Name      | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage_1 | false              | two           | broadcasterTrafficManagerTwo_1,TTSATDA_BTM1    | broadcasterTrafficManagerTwo_1,TTSATDA_BTM2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TTSATDAA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| TTSATDAAR1 | TTSATDABR1 | TTSATDASB1 | TTSATDASP1 |


Scenario: Check that on 'Approve Proxy' by first approver and 'Release Master' by second approver correct emails are triggered (Two Stage Approval - With Two Approvers, Escalations disabled)
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TTSATDAU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign   | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title       | Destination             |
| automated test info    | TTSATDAAR1 | TTSATDABR1 | TTSATDASB1 | TTSATDASP1 | TTSATDACP1 | TTSATDACN1_1 | 10       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TTSATDAT1_1 | Tele 5 DE - Longform:Express |
| automated test info    | TTSATDAAR1 | TTSATDABR1 | TTSATDASB1 | TTSATDASP1 | TTSATDACP2 | TTSATDACN1_2 | 20       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TTSATDAT1_2 | Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TTSATDACN1_1' with following fields:
| Job Number | PO Number  |
| TTSATDAJO1 | TTSATDAPO1 |
And wait for finish place order with following item clock number 'TTSATDACN1_1' to A4
And wait for finish place order with following item clock number 'TTSATDACN1_2' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber  |
| TTSATDAA1  | TTSATDACN1_1 |
| TTSATDAA1  | TTSATDACN1_2 |
When login as 'TTSATDA_BTM2' of Agency 'BroadCasterAgencyTwoStage_1'
And wait till order item with clockNumber 'TTSATDACN1_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TTSATDACN1_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TTSATDACN1_1'
Then I 'should not' see 'Release Master' button on order item details page in traffic
And 'should not' see 'Reject Master' button on order item details page in traffic
And 'should not' see 'Force Release Master' button on order item details page in traffic
And 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I amon order item details page of clockNumber 'TTSATDACN1_2'
Then I 'should not' see 'Release Master' button on order item details page in traffic
And 'should not' see 'Reject Master' button on order item details page in traffic
And 'should not' see 'Force Release Master' button on order item details page in traffic
And 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When login as 'TTSATDA_BTM1' of Agency 'BroadCasterAgencyTwoStage_1'
And wait till order item with clockNumber 'TTSATDACN1_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TTSATDACN1_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TTSATDACN1_1'
Then I 'should' see 'Approve Proxy' button on order item details page in traffic
And 'should' see 'Reject Proxy' button on order item details page in traffic
And 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                             |
| test1_1 | Proxy Approved for first order item |
And wait till order item with clockNumber 'TTSATDACN1_1' will have broadcaster status 'Master Ready For Approval' in Traffic
Then I 'should not' see 'Release Master' button on order item details page in traffic
And 'should not' see 'Reject Master' button on order item details page in traffic
And 'should' see email notification for 'Preview file for has been approved' with field to 'test1_1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                             |
| TTSATDACN1_1 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT1_1 | 10       | Tele 5 DE - Longform | Proxy Approved for first order item |
When I amon order item details page of clockNumber 'TTSATDACN1_2'
Then I 'should' see 'Approve Proxy' button on order item details page in traffic
And 'should' see 'Reject Proxy' button on order item details page in traffic
And 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test1_2 | Proxy Approved for second order item |
And wait till order item with clockNumber 'TTSATDACN1_2' will have broadcaster status 'Master Ready For Approval' in Traffic
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And 'should not' see 'Release Master' button on order item details page in traffic
And 'should not' see 'Reject Master' button on order item details page in traffic
And 'should' see email notification for 'Preview file for has been approved' with field to 'test1_1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                              |
| TTSATDACN1_1 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT1_1 | 10       | Tele 5 DE - Longform | Proxy Approved for first order item |
And 'should' see email notification for 'Preview file for has been approved' with field to 'test1_2' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                              |
| TTSATDACN1_2 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT1_2 | 20       | Tele 5 DE - Longform | Proxy Approved for second order item |
When login as 'TTSATDA_BTM2'  of Agency 'BroadCasterAgencyTwoStage_1'
And on order item details page of clockNumber 'TTSATDACN1_1'
Then I 'should' see 'Release Master' button on order item details page in traffic
And 'should' see 'Reject Master' button on order item details page in traffic
And 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test2_1 | Master Released for first order item |
And wait till order item with clockNumber 'TTSATDACN1_1' will have broadcaster status 'Master Released' in Traffic
Then I 'should not' see 'Restore Master' button on order item details page in traffic
When I amon order item details page of clockNumber 'TTSATDACN1_2'
Then I 'should' see 'Release Master' button on order item details page in traffic
And 'should' see 'Reject Master' button on order item details page in traffic
And 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test2_2 | Master Released for second order item |
And wait till order item with clockNumber 'TTSATDACN1_2' will have broadcaster status 'Master Released' in Traffic
Then I 'should not' see 'Restore Master' button on order item details page in traffic
And 'should' see email notification for 'has been released for delivery' with field to 'test2_1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                              |
| TTSATDACN1_1 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT1_1 | 10       | Tele 5 DE - Longform | Master Released for first order item |
And 'should' see email notification for 'has been released for delivery' with field to 'test2_2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                               |
| TTSATDACN1_2 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT1_2 | 20       | Tele 5 DE - Longform | Master Released for second order item |
When login as 'TTSATDA_BTM1' of Agency 'BroadCasterAgencyTwoStage_1'
And on order item details page of clockNumber 'TTSATDACN1_1'
And wait till order item with clockNumber 'TTSATDACN1_1' will have broadcaster status 'Master Released' in Traffic
And refresh the page without delay
Then I 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic
When I amon order item details page of clockNumber 'TTSATDACN1_2'
And wait till order item with clockNumber 'TTSATDACN1_2' will have broadcaster status 'Master Released' in Traffic
And refresh the page without delay
Then I 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic


Scenario: Check that on 'Approve Proxy' by first approver and 'Reject Master' by second approver correct emails are triggered (Two Stage Approval - With Two Approvers, Escalations disabled)
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TTSATDAU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign   | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title       | Destination             |
| automated test info    | TTSATDAAR1 | TTSATDABR1 | TTSATDASB1 | TTSATDASP1 | TTSATDACP1 | TTSATDACN2_1 | 10       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TTSATDAT2_1 | Tele 5 DE - Longform:Express |
| automated test info    | TTSATDAAR1 | TTSATDABR1 | TTSATDASB1 | TTSATDASP1 | TTSATDACP2 | TTSATDACN2_2 | 20       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TTSATDAT2_2 | Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TTSATDACN2_1' with following fields:
| Job Number | PO Number  |
| TTSATDAJO2 | TTSATDAPO2 |
And wait for finish place order with following item clock number 'TTSATDACN2_1' to A4
And wait for finish place order with following item clock number 'TTSATDACN2_2' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber  |
| TTSATDAA1  | TTSATDACN2_1 |
| TTSATDAA1  | TTSATDACN2_2 |
When login as 'TTSATDA_BTM1'  of Agency 'BroadCasterAgencyTwoStage_1'
And on order item details page of clockNumber 'TTSATDACN2_1'
And wait till order item with clockNumber 'TTSATDACN2_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                             |
| test2_1 | Proxy Approved for first order item |
And wait till order item with clockNumber 'TTSATDACN2_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And on order item details page of clockNumber 'TTSATDACN2_2'
And wait till order item with clockNumber 'TTSATDACN2_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test2_2 | Proxy Approved for second order item |
And wait till order item with clockNumber 'TTSATDACN2_2' will have broadcaster status 'Master Ready For Approval' in Traffic
When login as 'TTSATDA_BTM2' of Agency 'BroadCasterAgencyTwoStage_1'
And on order item details page of clockNumber 'TTSATDACN2_1'
And wait till order item with clockNumber 'TTSATDACN2_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test2_1 | Master Rejected for first order item |
And wait till order item with clockNumber 'TTSATDACN2_1' will have broadcaster status 'Master Rejected' in Traffic
And refresh the page
Then I 'should' see 'Restore Master' button on order item details page in traffic
And 'should' see 'Master Rejected' Broadcaster Approval Status on on order item details page in traffic
And 'should not' see 'Release Master' button on order item details page in traffic
And 'should not' see 'Reject Master' button on order item details page in traffic
When I amon order item details page of clockNumber 'TTSATDACN2_2'
And wait till order item with clockNumber 'TTSATDACN2_2' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test2_2 | Master Rejected for second order item |
And wait till order item with clockNumber 'TTSATDACN2_2' will have broadcaster status 'Master Rejected' in Traffic
And refresh the page
Then I 'should' see 'Restore Master' button on order item details page in traffic
And 'should' see 'Master Rejected' Broadcaster Approval Status on on order item details page in traffic
And 'should' see email notification for 'has been rejected' with field to 'test2_1' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                              |
| TTSATDACN2_1 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT2_1 | 10       | Tele 5 DE - Longform | Master Rejected for first order item |
And 'should' see email notification for 'has been rejected' with field to 'test2_2' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                               |
| TTSATDACN2_2 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT2_2 | 20       | Tele 5 DE - Longform | Master Rejected for second order item |
When login as 'TTSATDA_BTM1' of Agency 'BroadCasterAgencyTwoStage_1'
And on order item details page of clockNumber 'TTSATDACN2_1'
Then I 'should' see 'Master Rejected' Broadcaster Approval Status on on order item details page in traffic
And 'should not' see 'Restore Master' button on order item details page in traffic
When I amon order item details page of clockNumber 'TTSATDACN2_2'
Then I 'should' see 'Master Rejected' Broadcaster Approval Status on on order item details page in traffic
And 'should not' see 'Restore Master' button on order item details page in traffic


Scenario: Check that on 'Approve Proxy' by first approver and 'Restore Master' by second approver correct emails are triggered (Two Stage Approval - With Two Approvers, Escalations disabled)
Meta: @traffic
      @trafficemails
Given I logged in with details of 'TTSATDAU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign   | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title       | Destination             |
| automated test info    | TTSATDAAR1 | TTSATDABR1 | TTSATDASB1 | TTSATDASP1 | TTSATDACP1 | TTSATDACN3_1 | 10       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TTSATDAT3_1 | Tele 5 DE - Longform:Express |
| automated test info    | TTSATDAAR1 | TTSATDABR1 | TTSATDASB1 | TTSATDASP1 | TTSATDACP2 | TTSATDACN3_2 | 20       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TTSATDAT3_2 | Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TTSATDACN3_1' with following fields:
| Job Number | PO Number  |
| TTSATDAJO3 | TTSATDAPO3 |
And wait for finish place order with following item clock number 'TTSATDACN3_1' to A4
And wait for finish place order with following item clock number 'TTSATDACN3_2' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber  |
| TTSATDAA1  | TTSATDACN3_1 |
| TTSATDAA1  | TTSATDACN3_2 |
When login as 'TTSATDA_BTM1'  of Agency 'BroadCasterAgencyTwoStage_1'
And on order item details page of clockNumber 'TTSATDACN3_1'
And wait till order item with clockNumber 'TTSATDACN3_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                             |
| test3_1 | Proxy Approved for first order item |
And wait till order item with clockNumber 'TTSATDACN3_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And on order item details page of clockNumber 'TTSATDACN3_2'
And wait till order item with clockNumber 'TTSATDACN3_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test3_2 | Proxy Approved for second order item |
And wait till order item with clockNumber 'TTSATDACN3_2' will have broadcaster status 'Master Ready For Approval' in Traffic
When login as 'TTSATDA_BTM2'  of Agency 'BroadCasterAgencyTwoStage_1'
And on order item details page of clockNumber 'TTSATDACN3_1'
And wait till order item with clockNumber 'TTSATDACN3_1' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test3_1 | Master Rejected for first order item |
And wait till order item with clockNumber 'TTSATDACN3_1' will have broadcaster status 'Master Rejected' in Traffic
And refresh the page
And click on 'Restore Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test3_1 | Master Restored for first order item |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And 'should' see 'Release Master' button on order item details page in traffic
And 'should' see 'Reject Master' button on order item details page in traffic
When I amon order item details page of clockNumber 'TTSATDACN3_2'
And wait till order item with clockNumber 'TTSATDACN3_2' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test3_2 | Master Rejected for second order item |
And wait till order item with clockNumber 'TTSATDACN3_2' will have broadcaster status 'Master Rejected' in Traffic
And refresh the page
And click on 'Restore Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                              |
| test3_1 | Master Restored for first order item |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And 'should' see 'Release Master' button on order item details page in traffic
And 'should' see 'Reject Master' button on order item details page in traffic
And 'should' see email notification for 'has been rejected' with field to 'test3_1' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                              |
| TTSATDACN3_1 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT3_1 | 10       | Tele 5 DE - Longform | Master Rejected for first order item |
And 'should' see email notification for 'has been rejected' with field to 'test3_2' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                               |
| TTSATDACN3_2 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT3_2 | 20       | Tele 5 DE - Longform | Master Rejected for second order item |
When login as 'TTSATDA_BTM1'  of Agency 'BroadCasterAgencyTwoStage_1'
And on order item details page of clockNumber 'TTSATDACN3_1'
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And 'should not' see 'Restore Master' button on order item details page in traffic
And 'should not' see 'Approve Proxy' button on order item details page in traffic
When I amon order item details page of clockNumber 'TTSATDACN3_2'
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And 'should not' see 'Restore Master' button on order item details page in traffic
And 'should not' see 'Approve Proxy' button on order item details page in traffic


Scenario: Check that when second approver directly performs 'Force Release Master' then correct emails are triggered (Two Stage Approval - With Two Approvers,Escalations disabled)
Meta: @traffic
      @trafficemails
!-- NIR-718
Given I logged in with details of 'TTSATDAU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign   | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title       | Destination             |
| automated test info    | TTSATDAAR1 | TTSATDABR1 | TTSATDASB1 | TTSATDASP1 | TTSATDACP1 | TTSATDACN4_1 | 10       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TTSATDAT4_1 | Tele 5 DE - Longform:Express |
| automated test info    | TTSATDAAR1 | TTSATDABR1 | TTSATDASB1 | TTSATDASP1 | TTSATDACP2 | TTSATDACN4_2 | 20       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TTSATDAT4_2 | Tele 5 DE - Longform:Express |
And complete order contains item with clock number 'TTSATDACN4_1' with following fields:
| Job Number | PO Number  |
| TTSATDAJO4 | TTSATDAPO4 |
And wait for finish place order with following item clock number 'TTSATDACN4_1' to A4
And wait for finish place order with following item clock number 'TTSATDACN4_2' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber  |
| TTSATDAA1  | TTSATDACN4_1 |
| TTSATDAA1  | TTSATDACN4_2 |
When login with details of 'broadcasterTrafficManagerTwo_1'
And wait till order with clockNumber 'TTSATDACN4_1' will be available in Traffic
And wait till order with clockNumber 'TTSATDACN4_2' will be available in Traffic
And on order item details page of clockNumber 'TTSATDACN4_1'
And wait till order item with clockNumber 'TTSATDACN4_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And click on 'Force Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                                    |
| test4_1 | Force Released Master for first order item |
And wait till order item with clockNumber 'TTSATDACN4_1' will have broadcaster status 'Master Released' in Traffic
And on order item details page of clockNumber 'TTSATDACN4_2'
And wait till order item with clockNumber 'TTSATDACN4_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And click on 'Force Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                                    |
| test4_2 | Force Released Master for second order item |
And wait till order item with clockNumber 'TTSATDACN4_2' will have broadcaster status 'Master Released' in Traffic
Then I 'should' see email notification for 'has been released for delivery' with field to 'test4_1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                                    |
| TTSATDACN4_1 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT4_1 | 10       | Tele 5 DE - Longform | Force Released Master for first order item |
And 'should' see email notification for 'has been released for delivery' with field to 'test4_2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product    | Title       | Duration | Destinations    | Comment                                     |
| TTSATDACN4_2 | TTSATDAAR1 | TTSATDASP1 | TTSATDAT4_2 | 20       | Tele 5 DE - Longform | Force Released Master for second order item |
When I amon order item details page of clockNumber 'TTSATDACN4_1'
And wait till order item with clockNumber 'TTSATDACN4_1' will have broadcaster status 'Delivered' in Traffic
And refresh the page without delay
Then I 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic
When I amon order item details page of clockNumber 'TTSATDACN4_2'
And wait till order item with clockNumber 'TTSATDACN4_2' will have broadcaster status 'Delivered' in Traffic
And refresh the page without delay
Then I 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic
