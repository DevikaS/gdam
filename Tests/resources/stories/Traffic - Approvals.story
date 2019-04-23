Feature:    Traffic Approval functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check approval feature and ACL

Lifecycle:
Before:
Given created 'TAFR1' role with 'traffic.order.view.all,traffic.tab.default.view.all' permissions in 'global' group for advertiser 'BroadCasterAgencyTwoStage'
And created users with following fields:
| Email     |           Role            | Agency |  Access  | Password |
| TAFU2_2   | broadcast.traffic.manager |   BroadCasterAgencyTwoStage    |  adpath  | abcdefghA1 |
| TAFU3_2   | broadcast.traffic.manager |   BroadCasterAgencyTwoStage    |  adpath  | abcdefghA1 |
| TAFU7_2     |           TAFR1           |   BroadCasterAgencyTwoStage    |  adpath  | abcdefghA1 |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo,TAFU3_2,TAFU7_2      |      broadcasterTrafficManagerTwo,TAFU2_2,TAFU7_2     |
| BroadCasterAgencyOneStage  |       true         |      one      |  |broadcasterTrafficManagerOne |
And I logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand | Sub Brand | Product |
| TAAR1      | TABR1 | TASB1     | TASP1   |


Scenario: Check that after approving order item, status will be changed on order item details and email is send
!--NGN-16231
!-- Skipping this scenario as it is now clubbed with another scenario, "Check that on 'Restore Proxy' for each order item triggers correct emails (Two Stage Approval)"
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
      @criticaltraffictests
      @trafficdeploymentsanity
      @skip
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |             Destination                |
| automated test info    | TAAR1     | TABR1     | TASB1     | TASP1    | TAFCP1    | TAFCN1       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express;Travel Channel DE:Express   |
And complete order contains item with clock number 'TAFCN1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency    | TAFCN1  |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber 'TAFCN1' will be available in Traffic
And wait till order item with clockNumber 'TAFCN1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN1'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And I 'should' see email with subject 'has been approved' sent to user 'test1_1' and body contains 'Motorvision TV'
And I 'should not' see email with subject 'has been approved' sent to user 'test1_1' and body contains 'Travel Channel DE'


Scenario: Check that user without proxy approval permission not able to approve proxy
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TAAR1     | TABR1     | TASB1     | TASP1    | TAFCP1    | TAFCN2       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express   |
And complete order contains item with clock number 'TAFCN2' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN2' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TAFCN2    |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber 'TAFCN2' will be available in Traffic
And wait till order item with clockNumber 'TAFCN2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN2'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When login as 'TAFU2_2' of Agency 'BroadCasterAgencyTwoStage'
And wait till order list will be loaded
And enter search criteria 'TAFCN2' in simple search form on Traffic Order List page
And open order item details page with clockNumber 'TAFCN2'
And refresh the page
Then I 'should' see 'Release Master' button on order item details page in traffic
But 'should not' see 'Reject Proxy' button on order item details page in traffic

Scenario: Check that user without master approval permission not able to Release Master
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TAAR1     | TABR1     | TASB1     | TASP1    | TAFCP1    | TAFCN3       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express   |
And complete order contains item with clock number 'TAFCN3' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN3' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TAFCN3    |
And login as 'TAFU3_2' of Agency 'BroadCasterAgencyTwoStage'
And wait till order item with clockNumber 'TAFCN3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TAFCN3'
Then I 'should' see 'Approve Proxy' button on order item details page in traffic
But 'should not' see 'Release Master' button on order item details page in traffic

Scenario: Check that after rejecting order item, status will be changed on order item details and email is sent
!--NGN-16231
!-- Skipping this scenario as it is now clubbed with another scenario, "Check that on 'Restore Proxy' for each order item triggers correct emails (Two Stage Approval)"
Meta: @traffic
@skip
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |              Destination               |
| automated test info    | TAAR1     | TABR1     | TASB1     | TASP1    | TAFCP1    | TAFCN5       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express;Travel Channel DE:Express   |
And complete order contains item with clock number 'TAFCN5' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN5' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TAFCN5    |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order item with clockNumber 'TAFCN5' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TAFCN5'
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test3_1         |    Test   |
Then I 'should' see 'Proxy Rejected' Broadcaster Approval Status on on order item details page in traffic
And I 'should' see email with subject 'has been rejected' sent to user 'test3_1' and body contains 'Motorvision TV'
And I 'should not' see email with subject 'has been rejected' sent to user 'test3_1' and body contains 'Travel Channel DE'


Scenario: Check that after restoring order item, status will be changed on order item details and order list
!-- Skipping this scenario as it is now clubbed with another scenario, "Check that on 'Restore Proxy' for each order item triggers correct emails (Two Stage Approval)"
Meta: @traffic
@skip
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TAAR1     | TABR1     | TASB1     | TASP1    | TAFCP1    | TAFCN6       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express   |
And complete order contains item with clock number 'TAFCN6' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN6' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TAFCN6    |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order item with clockNumber 'TAFCN6' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TAFCN6'
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                 |  Comment  |
|      test4          |    Test   |
And click on 'Restore Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                 |  Comment  |
|      test4          |    Test   |
And wait for '5' seconds
And open Traffic Order List page
And wait for '5' seconds
And enter search criteria 'TAFCN6' in simple search form on Traffic Order List page
And wait for '5' seconds
And expand all orders on Traffic Order List page
Then I 'should' see Broadcaster Approval Status 'Proxy Ready For Approval' for order item with clock number 'TAFCN6'
And 'should' see email with subject 'has been restored' sent to 'test4'



Scenario: Check that user without restore proxy permission, cannot restore proxy
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
      @trafficdeploymentsanity
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TAAR1     | TABR1     | TASB1     | TASP1    | TAFCP1    | TAFCN7       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express   |
And complete order contains item with clock number 'TAFCN7' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFCN7' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TAFCN7    |
And login as 'TAFU7_2' of Agency 'BroadCasterAgencyTwoStage'
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TAFCN7' will be available in Traffic
And I amon order item details page of clockNumber 'TAFCN7'
And wait till order item with clockNumber 'TAFCN7' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                 |  Comment  |
|      test1         |    Test   |
And wait till order item page will be loaded in Traffic
Then I 'should not' see 'Restore Proxy' button on order item details page in traffic

Scenario: Check that Traffic Manger can Reset Approval Status
Meta: @traffic
      @trafficemails
Given created users with following fields:
| Email     |           Role            | Agency |  Access  |  Password |
| TAFU12_12   | broadcast.traffic.manager |   BroadCasterAgencyTwoStage    |  adpath  | abcdefghA1 |
And updated the following agency:
| Name     |  Master Approver | Proxy Approver |
| BroadCasterAgencyTwoStage  | TAFU12_12    | TAFU12_12 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand | Sub Brand | Product |
| TAAR1      | TABR1 | TASB1     | TASP1   |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign   | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title        | Destination                  |
| automated test info    | TAAR1     | TABR1     | TASB1     | TASP1     | TTSATDACP1 | TTSATDACN12_12 | 10       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TTSATDAT4_12 | Motorvision TV:Express       |
And complete order contains item with clock number 'TTSATDACN12_12' with following fields:
| Job Number | PO Number  |
| TTSATDAJO4 | TTSATDAPO4 |
And wait for finish place order with following item clock number 'TTSATDACN12_12' to A4
And ingested assests through A5 with following fields:
| agencyName     | clockNumber  |
| DefaultAgency  | TTSATDACN12_12 |
When login as 'TAFU12_12' of Agency 'BroadCasterAgencyTwoStage'
And wait till order with clockNumber 'TTSATDACN12_12' will be available in Traffic
And enter search criteria 'TTSATDACN12_12' in simple search form on Traffic Order List page
And wait for '2' seconds
When fill '22' House Number for order item with 'TTSATDACN12_12' clock number on traffic order list
And wait for '5' seconds
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TTSATDACN12_12' in traffic order list that have following data:
| House Number |
|     22       |
When on order item details page of clockNumber 'TTSATDACN12_12'
And wait till order item with clockNumber 'TTSATDACN12_12' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And click on 'Force Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                                    |
| test4_1              | Force Released Master for first order item |
And wait till order item with clockNumber 'TTSATDACN12_12' will have broadcaster status 'Master Released' in Traffic
Then I 'should' see email notification for 'has been released for delivery' with field to 'test4_1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number    | Advertiser | Product    | Title             | Duration | Destinations         | Comment                                    |
| TTSATDACN12_12 | TAAR1     | TASP1     | TTSATDAT4_12      | 10       | Motorvision TV       | Force Released Master for first order item |
When I login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And am on order details page of clockNumber 'TTSATDACN12_12'
And wait till order item with clockNumber 'TTSATDACN12_12' will have broadcaster status 'Delivered' in Traffic
When I open Clone order item details page with clockNumber 'TTSATDACN12_12' from traffic order details page and validate cloned orders and Destinations 'Motorvision TV'
Then 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic
When I reset Approval Status for 'TTSATDACN12_12' clock on traffic order details page
And wait till order item with clockNumber 'TTSATDACN12_12' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TTSATDACN12_12' with destination 'Motorvision TV' will have the next Destination Status 'Awaiting station release' in Traffic
And I refresh the page
Then I 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And I 'should' see 'Awaiting station release' Delivery Status on on order item details page in traffic
When login as 'TAFU12_12' of Agency 'BroadCasterAgencyTwoStage'
And wait till order with clockNumber 'TTSATDACN12_12' will be available in Traffic
And enter search criteria 'TTSATDACN12_12' in simple search form on Traffic Order List page
When fill '25' House Number for order item with 'TTSATDACN12_12' clock number on traffic order list
And wait for '5' seconds
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TTSATDACN12_12' in traffic order list that have following data:
| House Number |
|     25       |
When on order item details page of clockNumber 'TTSATDACN12_12'
And wait till order item with clockNumber 'TTSATDACN12_12' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I click on 'Force Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                                    |
| test4_1              | Force Released Master for first order item |
And wait till order item with clockNumber 'TTSATDACN12_12' will have broadcaster status 'Master Released' in Traffic
And wait till order item with clockNumber 'TTSATDACN12_12' will have broadcaster status 'Delivered' in Traffic
And refresh the page
Then 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic
