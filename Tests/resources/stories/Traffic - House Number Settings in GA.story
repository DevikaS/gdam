Feature:    Traffic picks up House Number settings from GA
Narrative:
In order to
As a              AgencyAdmin
I want to House Number feature

Lifecycle:
Before:
Given created users with following fields:
| Email    | Role                      | Agency | Access | Password   |
| THN_BTM1 | broadcast.traffic.manager | BroadCasterAgency7390     | adpath | abcdefghA1  |
| THN_BTM2 | broadcast.traffic.manager | BroadCasterAgency7390     | adpath | abcdefghA1  |
| THN_BTM4 | broadcast.traffic.manager | BroadCasterAgency7429     | adpath | abcdefghA1  |
| THN_BTM5 | broadcast.traffic.manager | BroadCasterAgency7429     | adpath | abcdefghA1  |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
| BroadCasterAgency7390 | false              | two           | THN_BTM1,broadcasterTrafficManager7390       | THN_BTM2,broadcasterTrafficManager7390        |
| BroadCasterAgency7724 | false              | two           | broadcasterTrafficManager7724       | broadcasterTrafficManager7724        |
| BroadCasterAgency7429 | false              | two           | broadcasterTrafficManager7429,THN_BTM4       | broadcasterTrafficManager7429,THN_BTM5        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand  | Sub Brand | Product |
| THNAR1     | THNBR1 | THNSB1    | THNP1   |

Scenario: Check that after entering house number and approving proxy,status changed emails are triggered("House Number is Mandatory for Proxy Approve and  Master Release in GA (Two Stage Approval-2 Approvers)" )
Meta:@traffic
     @trafficemails
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Motivnummer | Subtitles Required | Format         | Title | Destination         |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP6   | THNCN6       | 10       | 12/14/2022     |      1      | Already Supplied   | HD 1080i 25fps | THNT6 | Moviepilot:Express |
And complete order contains item with clock number 'THNCN6' with following fields:
| Job Number | PO Number |
| THNJO6     | THNPO6    |
And wait for finish place order with following item clock number 'THNCN6' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN6      |
When login as 'THN_BTM1' of Agency 'BroadCasterAgency7390'
And wait till order with clockNumber 'THNCN6' will be available in Traffic
And wait till order item with clockNumber 'THNCN6' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN6'
And fill house number field with value 'THNCN6' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                 | Comment        |
| THNCN6_1              | Proxy approved |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When login as 'THN_BTM2' of Agency 'BroadCasterAgency7390'
And wait till order item with clockNumber 'THNCN6' will have broadcaster status 'Master Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN6'
Then I 'should' see house number 'THNCN6' on order details page in traffic
And 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And 'should' see 'Release Master' button on order item details page in traffic
And 'should' see 'Reject Master' button on order item details page in traffic
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                 | Comment         |
| THNCN6_2              | Master Released |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
And 'should' see email notification for 'has been released for delivery' with field to 'THNCN6_2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title | Duration | Destinations | Comment         |
| THNCN6       | THNAR1     | THNP1   | THNT6 | 10       | Moviepilot  | Master Released |


Scenario: Check that FORCE RELEASE MASTER button is disabled if "House Number is Mandatory for Proxy Approve and Master Release" options are set to TRUE in GA (Two Stage Approval 2 Approvers)
Meta:@traffic
     @qatrafficsmoke
     @uattrafficsmoke
     @trafficdeploymentsanity
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Motivnummer | Subtitles Required | Format         | Title | Destination         |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP1   | THNCN1       | 10       | 12/14/2022     |      1      | Already Supplied   | HD 1080i 25fps | THNT1 | Moviepilot:Express |
And complete order contains item with clock number 'THNCN1' with following fields:
| Job Number | PO Number |
| THNJO1     | THNPO1    |
And wait for finish place order with following item clock number 'THNCN1' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN1      |
When I login with details of 'broadcasterTrafficManager7390'
And wait till order with clockNumber 'THNCN1' will be available in Traffic
And wait till order item with clockNumber 'THNCN1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN1'
Then I 'should' see 'Force Release Master' button disabled on order item details page in traffic


Scenario: Check that BroadcastTrafficManager can't APPROVE PROXY without filling house number if "House Number is Mandatory for Proxy Approve and Master Release" (Two Stage Approval - 2 Approvers)
Meta:@traffic
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Motivnummer | Subtitles Required | Format         | Title | Destination         |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP2   | THNCN2       | 10       | 12/14/2022     |      1      | Already Supplied   | HD 1080i 25fps | THNT2 | Moviepilot:Express |
And complete order contains item with clock number 'THNCN2' with following fields:
| Job Number | PO Number |
| THNJO2     | THNPO2    |
And wait for finish place order with following item clock number 'THNCN2' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN2      |
When login as 'THN_BTM1' of Agency 'BroadCasterAgency7390'
And wait till order with clockNumber 'THNCN2' will be available in Traffic
And wait till order item with clockNumber 'THNCN2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN2'
Then I 'should not' see button Approve Proxy enabled
And I 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And I 'should' see playable preview on order item details page in traffic
And I 'should' see playable preview available for download on order item details page in traffic
And I 'should' see Proxy file 'THNT2' for clockNumber 'THNCN2' is downloaded from order details page with duration '10'
And 'should' see 'Reject Proxy' button on order item details page in traffic
When login as 'THN_BTM2' of Agency 'BroadCasterAgency7390'
And wait till order item with clockNumber 'THNCN2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN2'
Then I 'should' see 'Force Release Master' button disabled on order item details page in traffic


Scenario: Check that proxy approval email not triggered without filling house number "House Number is Mandatory and Master Release" (Two Stage Approval - 2 Approvers)
Meta:@traffic
     @trafficemails
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Motivnummer | Subtitles Required | Format         | Title | Destination         |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP3   | THNCN3       | 10       | 12/14/2022     |      1      | Already Supplied   | HD 1080i 25fps | THNT3 | Moviepilot:Express |
And complete order contains item with clock number 'THNCN3' with following fields:
| Job Number | PO Number |
| THNJO3     | THNPO3    |
And wait for finish place order with following item clock number 'THNCN3' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN3      |
When login as 'THN_BTM1' of Agency 'BroadCasterAgency7390'
And wait till order with clockNumber 'THNCN3' will be available in Traffic
And wait till order item with clockNumber 'THNCN3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN3'
Then I 'should not' see button Approve Proxy enabled

Scenario: Check for warning message when APPROVE PROXY selected without filling house number "House Number is Mandatory for Proxy Approve and Master Release" (Two Stage Approval - 2 Approvers)
Meta:@traffic
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Motivnummer | Subtitles Required | Format         | Title | Destination         |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP4   | THNCN4       | 10       | 12/14/2022     |      1      | Already Supplied   | HD 1080i 25fps | THNT4 | Moviepilot:Express |
And complete order contains item with clock number 'THNCN4' with following fields:
| Job Number | PO Number |
| THNJO4     | THNPO4    |
And wait for finish place order with following item clock number 'THNCN4' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN4      |
When login as 'THN_BTM1' of Agency 'BroadCasterAgency7390'
And wait till order with clockNumber 'THNCN4' will be available in Traffic
And wait till order item with clockNumber 'THNCN4' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN4'
Then I 'should not' see button Approve Proxy enabled


Scenario: Check that warning message not displayed after filling house number "House Number is Mandatory for Proxy Approve and Master Release" (Two Stage Approval - 2 Approvers)
Meta:@traffic
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Motivnummer | Subtitles Required | Format         | Title | Destination         |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP5   | THNCN5       | 10       | 12/14/2022     |      1      | Already Supplied   | HD 1080i 25fps | THNT5 | Moviepilot:Express |
And complete order contains item with clock number 'THNCN5' with following fields:
| Job Number | PO Number |
| THNJO5     | THNPO5    |
And wait for finish place order with following item clock number 'THNCN5' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN5      |
When login as 'THN_BTM1' of Agency 'BroadCasterAgency7390'
And wait till order with clockNumber 'THNCN5' will be available in Traffic
And wait till order item with clockNumber 'THNCN5' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN5'
Then I 'should not' see button Approve Proxy enabled

Scenario: Check that after entering house number and approving proxy, status changed accordingly and emails are triggered ("House Number is Mandatory for Proxy Approve and Master Release" (Two Stage Approval - 2 Approvers)
Meta:@traffic
     @trafficemails
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Motivnummer | Subtitles Required | Format         | Title | Destination         |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP6   | THNCN6_N       | 10       | 12/14/2022     |      1      | Already Supplied   | HD 1080i 25fps | THNT6 | Moviepilot:Express |
And complete order contains item with clock number 'THNCN6_N' with following fields:
| Job Number | PO Number |
| THNJO6     | THNPO6    |
And wait for finish place order with following item clock number 'THNCN6_N' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN6_N      |
When login as 'THN_BTM1' of Agency 'BroadCasterAgency7390'
And wait till order with clockNumber 'THNCN6_N' will be available in Traffic
And wait till order item with clockNumber 'THNCN6_N' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN6_N'
And fill house number field with value 'THNCN6_N' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                 | Comment        |
| THNCN6_1              | Proxy approved |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When login as 'THN_BTM2' of Agency 'BroadCasterAgency7390'
And wait till order item with clockNumber 'THNCN6_N' will have broadcaster status 'Master Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN6_N'
Then I 'should' see house number 'THNCN6_N' on order details page in traffic
And 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And 'should' see 'Release Master' button on order item details page in traffic
And 'should' see 'Reject Master' button on order item details page in traffic
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                 | Comment         |
| THNCN6_2              | Master Released |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
And 'should' see email notification for 'has been released for delivery' with field to 'THNCN6_2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title | Duration | Destinations | Comment         |
| THNCN6_N       | THNAR1     | THNP1   | THNT6 | 10       | Moviepilot  | Master Released |



Scenario: Check that FORCE RELEASE MASTER is enabled only after entering house number ("House Number is Mandatory for Proxy Approve and Master Release" - Two Stage Approval - 2 Approvers)
Meta:@traffic
     @qatrafficsmoke
     @trafficdeploymentsanity
     @criticaltraffictests
     @trafficemails
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Motivnummer | Subtitles Required | Format         | Title | Destination         |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP7   | THNCN7       | 10       | 12/14/2022     |      1      | Already Supplied   | HD 1080i 25fps | THNT7 | Moviepilot:Express |
And complete order contains item with clock number 'THNCN7' with following fields:
| Job Number | PO Number |
| THNJO7     | THNPO7    |
And wait for finish place order with following item clock number 'THNCN7' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN7      |
When I login with details of 'broadcasterTrafficManager7390'
And wait till order with clockNumber 'THNCN7' will be available in Traffic
And wait till order item with clockNumber 'THNCN7' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN7'
When fill house number field with value 'THNCN7' on order details page in traffic
And wait for '10' seconds
And click on 'Force Release Master' button on order item details page in traffic
And wait for '10' seconds
And fill the following fields on approval traffic pop up:
| Email               | Comment                                    |
| THNCN7              | Force Released Master for first order item |
And wait till order item with clockNumber 'THNCN7' will have broadcaster status 'Master Released' in Traffic
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
And 'should' see email notification for 'has been released for delivery' with field to 'THNCN7' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title | Duration | Destinations | Comment                                    |
| THNCN7       | THNAR1     | THNP1   | THNT7 | 10       | Moviepilot | Force Released Master for first order item |


Scenario: Check that FORCE RELEASE MASTER is enabled only after entering house number "House Number is Mandatory for Master Release" (Two Stage Approval - With Same Approvers)
Meta:@traffic
     @trafficemails
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Destination             |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP9   | THNCN9       | 10       | 12/14/2022     | HD 1080i 25fps | THNT9 | MBC Group (HD):Standard |
And complete order contains item with clock number 'THNCN9' with following fields:
| Job Number | PO Number |
| THNJO9     | THNPO9    |
And wait for finish place order with following item clock number 'THNCN9' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN9      |
When I login with details of 'broadcasterTrafficManager7724'
And wait till order with clockNumber 'THNCN9' will be available in Traffic
And wait till order item with clockNumber 'THNCN9' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN9'
Then I 'should' see 'Force Release Master' button disabled on order item details page in traffic
When fill house number field with value 'THNCN9' on order details page in traffic
And click on 'Force Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email               | Comment                                    |
| THNCN9              | Force Released Master for first order item |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
And 'should' see email notification for 'has been released for delivery' with field to 'THNCN9' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title | Duration | Destinations  | Comment                                    |
| THNCN9       | THNAR1     | THNP1   | THNT9 | 10       | MBC Group (HD)| Force Released Master for first order item |



Scenario: Check that FORCE RELEASE MASTER button is disabled if "House Number is Mandatory for Master Release" is set to TRUE in GA (Two Stage Approval - With Same Approvers)
Meta:@traffic
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination             |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP10  | THNCN10      | 10       | 12/14/2022     | HD 1080i 25fps | THNT10 | MBC Group (HD):Standard |
And complete order contains item with clock number 'THNCN10' with following fields:
| Job Number | PO Number |
| THNJO10    | THNPO10   |
And wait for finish place order with following item clock number 'THNCN10' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN10     |
When I login with details of 'broadcasterTrafficManager7724'
And wait till order item with clockNumber 'THNCN10' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN10'
Then I 'should' see 'Force Release Master' button disabled on order item details page in traffic


Scenario: Check that RELEASE MASTER button is disabled if "House Number is Mandatory for Master Release" is set as TRUE  in GA (Two Stage Approval - With Same Approvers)
Meta:@traffic
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination             |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP11  | THNCN11      | 10       | 12/14/2022     | HD 1080i 25fps | THNT11 | MBC Group (HD):Standard |
And complete order contains item with clock number 'THNCN11' with following fields:
| Job Number | PO Number |
| THNJO11    | THNPO11   |
And wait for finish place order with following item clock number 'THNCN11' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN11     |
When I login with details of 'broadcasterTrafficManager7724'
And wait till order item with clockNumber 'THNCN11' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN11'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment |
| THNCN11              | Test    |
And wait till order item with clockNumber 'THNCN11' will have broadcaster status 'Master Ready For Approval' in Traffic
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And 'should' see 'Release Master' button disabled on order item details page in traffic


Scenario: Check that after entering house number and then releasing the master, status changes and emails triggered ('House Number is Mandatory for Master Release' - Two Stage Approval - With Same Approvers)
Meta:@traffic
     @trafficemails
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination             |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP12  | THNCN12       | 10       | 12/14/2022    | HD 1080i 25fps | THNT12 | MBC Group (HD):Standard |
And complete order contains item with clock number 'THNCN12' with following fields:
| Job Number | PO Number |
| THNJO12     | THNPO12    |
And wait for finish place order with following item clock number 'THNCN12' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN12     |
When I login with details of 'broadcasterTrafficManager7724'
And wait till order with clockNumber 'THNCN12' will be available in Traffic
And wait till order item with clockNumber 'THNCN12' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN12'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                  | Comment        |
| THNCN12_1              | Proxy approved |
And wait till order item with clockNumber 'THNCN12' will have broadcaster status 'Master Ready For Approval' in Traffic
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I fill house number field with value 'THNCN12' on order details page in traffic
Then I 'should' see 'Release Master' button on order item details page in traffic
And 'should' see 'Reject Master' button on order item details page in traffic
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                  | Comment         |
| THNCN12_2              | Master Released |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
And 'should' see email notification for 'has been released for delivery' with field to 'THNCN12_2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title  | Duration | Destinations  | Comment         |
| THNCN12      | THNAR1     | THNP1   | THNT12 | 10       | MBC Group (HD)| Master Released |


Scenario: Check that house number entered in first stage is visible during second stage ('House Number is Mandatory for Master Release' in GA - Two Stage Approval - With Same Approvers)
Meta:@traffic
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination             |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP13  | THNCN13      | 10       | 12/14/2022     | HD 1080i 25fps | THNT13 | MBC Group (HD):Standard |
And complete order contains item with clock number 'THNCN13' with following fields:
| Job Number | PO Number |
| THNJO13    | THNPO13   |
And wait for finish place order with following item clock number 'THNCN13' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN13     |
When I login with details of 'broadcasterTrafficManager7724'
And wait till order item with clockNumber 'THNCN13' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN13'
And fill house number field with value 'THNCN13' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                  | Comment        |
| THNCN13_1              | Proxy approved |
And wait till order item with clockNumber 'THNCN13' will have broadcaster status 'Master Ready For Approval' in Traffic
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And 'should' see house number 'THNCN13' on order details page in traffic



Scenario: Check that FORCE RELEASE MASTER is enabled only after entering house number ("House Number is Mandatory for Master Release" set as TRUE  in GA - Two Stage Approval - Two Approvers)
Meta:@traffic
     @trafficemails
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination       |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP14   | THNCN14     | 10       | 12/14/2022     | HD 1080i 25fps | THNT14 | SpaceToon:Standard |
And complete order contains item with clock number 'THNCN14' with following fields:
| Job Number | PO Number |
| THNJO14    | THNPO14   |
And wait for finish place order with following item clock number 'THNCN14' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN14      |
When I login with details of 'broadcasterTrafficManager7429'
And wait till order item with clockNumber 'THNCN14' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN14'
Then I 'should' see 'Force Release Master' button disabled on order item details page in traffic
And wait for '1' seconds
When fill house number field with value 'THNCN14' on order details page in traffic
And click on 'Force Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                                    |
| THNCN14              | Force Released Master for first order item |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
And 'should' see email notification for 'has been released for delivery' with field to 'THNCN14' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title  | Duration | Destinations | Comment                                    |
| THNCN14      | THNAR1     | THNP1   | THNT14 | 10       | SpaceToon     | Force Released Master for first order item |


Scenario: Check that FORCE RELEASE MASTER button is disabled if "House Number is Mandatory for Master Release" is set to TRUE in GA (Two Stage Approval - Two Approvers)
Meta:@traffic
     @qatrafficsmoke
     @uattrafficsmoke
     @trafficdeploymentsanity
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination       |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP15  | THNCN15      | 10       | 12/14/2022     | HD 1080i 25fps | THNT15 | SpaceToon:Standard |
And complete order contains item with clock number 'THNCN15' with following fields:
| Job Number | PO Number |
| THNJO15    | THNPO15   |
And wait for finish place order with following item clock number 'THNCN15' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN15     |
When I login with details of 'broadcasterTrafficManager7429'
And wait till order with clockNumber 'THNCN15' will be available in Traffic
And wait till order item with clockNumber 'THNCN15' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN15'
Then I 'should' see 'Force Release Master' button disabled on order item details page in traffic


Scenario: Check that RELEASE MASTER button is disabled if "House Number is Mandatory for Master Release" is set as TRUE  in GA (Two Stage Approval - Two Approvers)
Meta:@traffic
     @qatrafficsmoke
     @uattrafficsmoke
     @trafficdeploymentsanity
     @criticaltraffictests
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination       |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP16  | THNCN16      | 10       | 12/14/2022     | HD 1080i 25fps | THNT16 | SpaceToon:Standard |
And complete order contains item with clock number 'THNCN16' with following fields:
| Job Number | PO Number |
| THNJO16    | THNPO16   |
And wait for finish place order with following item clock number 'THNCN16' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN16     |
When login as 'THN_BTM4' of Agency 'BroadCasterAgency7429'
And wait till order with clockNumber 'THNCN16' will be available in Traffic
And wait till order item with clockNumber 'THNCN16' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN16'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment |
| THNCN16              | Test    |
And wait for '2' seconds
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When login as 'THN_BTM5' of Agency 'BroadCasterAgency7429'
And I amon order item details page of clockNumber 'THNCN16'
Then I 'should' see 'Release Master' button disabled on order item details page in traffic



Scenario: Check that after entering house number and then releasing the master, status changes and emails triggered ('House Number is Mandatory for Master Release' in GA - Two Stage Approval - Two Approvers)
Meta:@traffic
     @trafficemails
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination       |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP17  | THNCN17      | 10       | 12/14/2022     | HD 1080i 25fps | THNT17 | SpaceToon:Standard |
And complete order contains item with clock number 'THNCN17' with following fields:
| Job Number | PO Number |
| THNJO17    | THNPO17   |
And wait for finish place order with following item clock number 'THNCN17' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN17     |
When login as 'THN_BTM4' of Agency 'BroadCasterAgency7429'
And wait till order with clockNumber 'THNCN17' will be available in Traffic
And wait till order item with clockNumber 'THNCN17' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN17'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                  | Comment        |
| THNCN17_1              | Proxy approved |
And wait till order item with clockNumber 'THNCN17' will have broadcaster status 'Master Ready For Approval' in Traffic
When login as 'THN_BTM5' of Agency 'BroadCasterAgency7429'
And I amon order item details page of clockNumber 'THNCN17'
When I fill house number field with value 'THNCN17' on order details page in traffic
Then I 'should' see 'Release Master' button on order item details page in traffic
And 'should' see 'Reject Master' button on order item details page in traffic
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                  | Comment         |
| THNCN17_2 | Master Released |
And wait till order item with clockNumber 'THNCN17' will have broadcaster status 'Master Released' in Traffic
Then 'should' see email notification for 'has been released for delivery' with field to 'THNCN17_2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title  | Duration | Destinations  | Comment   |
| THNCN17      | THNAR1     | THNP1   | THNT17 | 10       | SpaceToon| Master Released |

Scenario: Check that house number entered in first stage is visible during second stage ('House Number is Mandatory for Master Release' in GA - Two Stage Approval - Two Approvers)
Meta:@traffic
Given I logged in as 'AgencyAdmin'
And create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination       |
| automated test info    | THNAR1     | THNBR1 | THNSB1    | THNP1   | THNCP18  | THNCN18      | 10       | 12/14/2022     | HD 1080i 25fps | THNT18 | SpaceToon:Standard |
And complete order contains item with clock number 'THNCN18' with following fields:
| Job Number | PO Number |
| THNJO18    | THNPO18   |
And wait for finish place order with following item clock number 'THNCN18' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | THNCN18     |
When login as 'THN_BTM4' of Agency 'BroadCasterAgency7429'
And wait till order item with clockNumber 'THNCN18' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'THNCN18'
And fill house number field with value 'THNCN18' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                  | Comment        |
| THNCN18_1              | Proxy approved |
And wait till order item with clockNumber 'THNCN18' will have broadcaster status 'Master Ready For Approval' in Traffic
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When login as 'THN_BTM5' of Agency 'BroadCasterAgency7429'
And I amon order item details page of clockNumber 'THNCN18'
Then I 'should' see house number 'THNCN18' on order details page in traffic