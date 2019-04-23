Feature: BroadCaster Create new tab
Narrative:
In order to
As a AgencyAdmin
I want to check filtering in Traffic

Lifecycle:
Before:
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand    | Sub Brand | Product |
| BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1 |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo      |      broadcasterTrafficManagerTwo     |
| BroadCasterAgencyOneStage  |       true         |      one      |                                  |broadcasterTrafficManagerOne |


Scenario: Check that BT Tab filtered by Master Escalated shows correct deliveries and when pinned shows the tab as the first tab in the list
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format | Title | Destination |
| automated test info | BTMAPMAR1 | BTMAPMBR1 | BTMAPMSB1 | BTMAPMSP1 | BTMAPMC4_4 | <ClockNumber1> | 20 | 1 | 12/14/2022 | Already Supplied |HD 1080i 25fps | BTMAPMT4 | Motorvision TV:Standard |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number | PO Number |
| BTMTAPM12 | BTMTAPM12 |
And wait for finish place order with following item clock number 'BTMAPMCN9_1' to A4
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency | <ClockNumber1> |
When login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber '<ClockNumber1>'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test1_1 | Test |
And wait for '5' seconds
And click on 'Escalate Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test1_1 | Test |
And wait for '5' seconds
And I open Traffic Order List page
And I create tab with name 'MASTER_ESCALATED' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Master Escalated |
And wait till order item list will be loaded in Traffic
And pin 'MASTER_ESCALATED' tab in Traffic UI
And I open Traffic Order List page
And wait till order list will be loaded
Then I 'should' see first tab as 'MASTER_ESCALATED'
And I 'should' see orderItems '<ClockNumber1>' in order item list in Traffic
When I logout from account
And login with details of 'broadcasterTrafficManagerTwo'
Then I 'should' see first tab as 'MASTER_ESCALATED'
And I 'should' see orderItems '<ClockNumber1>' in order item list in Traffic

Examples:
| ClockNumber1 | TabType                    |
| BTMAPMCN9_1  | Order Item (Send)          |


Scenario: Check that BT Tab filtered by broadcaster approval status shows correct deliveries for hub
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name | A4User | AgencyType | Application Access | Market |DestinationID |
| BTMTFSBH | DefaultA4User | TV Broadcaster Hub| adpath | Germany | |
And created users with following fields:
| Email | Role | AgencyUnique | Access |
| BTMTFSBHU1_1 | broadcast.traffic.manager | BTMTFSBH | adpath |
And I logged in as 'GlobalAdmin'
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyOneStage,BroadCasterAgencyTwoStage,BroadCasterAgencyNoApproval| BTMTFSBH    |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format | Title | Destination |
| automated test info | BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1 | BTMTFSC4_4 | <ClockNumber2> | 20 | 1 | 12/14/2022 | Already Supplied | HD 1080i 25fps | BTMTFSTT2 | TV Bayern Media:Express |
| automated test info | BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1 | BTMTFSC4_4 | <ClockNumber1> | 20 | 1 | 12/14/2022 | Already Supplied |HD 1080i 25fps | BTMTFST4 | Motorvision TV:Standard |
| automated test info | BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1 | BTMTFSC4_4 | <ClockNumber3> | 20 | 1 | 12/14/2022 | Already Supplied |HD 1080i 25fps | BTMTFST4 | Travel Channel DE:Standard |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number | PO Number |
| BTMTFSS12 | BTMTFS12 |
And wait for finish place order with following item clock number 'BTMTFSCN9_1,BTMTFSCN9_2,BTMTFSCN9_3' to A4
When ingested assests through A5 with following fields:
| agencyName           | clockNumber    |
| DefaultAgency | <ClockNumber1> |
| DefaultAgency | <ClockNumber2> |
When login with details of 'BTMTFSBHU1_1'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber '<ClockNumber2>' will have broadcaster status 'Master Ready For Approval' in Traffic
And I create tab with name 'PROXY_READY' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Proxy Ready For Approval |
And wait till order item list will be loaded in Traffic
And clear search criteria in simple search form on Traffic Order List page
And enter search criteria '<ClockNumber1>' in simple search form on Traffic Order Item List page
And wait for '4' seconds
Then I 'should' see orderItems '<ClockNumber1>' in order item list in Traffic
And I 'should not' see orderItems 'BTMTFSCN9_2,BTMTFSCN9_3' in order item list in Traffic
When I clear search criteria in simple search form on Traffic Order List page
And I create tab with name 'MASTER_READY' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Master Ready For Approval |
And wait till order item list will be loaded in Traffic
And clear search criteria in simple search form on Traffic Order List page
And enter search criteria '<ClockNumber2>' in simple search form on Traffic Order Item List page
And wait for '4' seconds
Then I 'should' see orderItems '<ClockNumber2>' in order item list in Traffic
And I 'should not' see orderItems 'BTMTFSCN9_1,BTMTFSCN9_3' in order item list in Traffic
When I clear search criteria in simple search form on Traffic Order List page
And I create tab with name 'FILE_NOT_SUPP' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | File Not Supplied |
And wait till order item list will be loaded in Traffic
And clear search criteria in simple search form on Traffic Order List page
And enter search criteria '<ClockNumber3>' in simple search form on Traffic Order Item List page
And wait for '4' seconds
Then I 'should' see orderItems '<ClockNumber3>' in order item list in Traffic
And I 'should not' see orderItems 'BTMTFSCN9_2,BTMTFSCN9_1' in order item list in Traffic

Examples:
| ClockNumber1 | ClockNumber2 | ClockNumber3 | TabType |
| BTMTFSCN9_1 | BTMTFSCN9_2 | BTMTFSCN9_3    | Order Item (Send)|


Scenario: Check that BT Tab created after Proxy Approved and Master Approved status shows correct deliveries
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format | Title | Destination |
| automated test info | BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1 | BTMTAPMC4_4 | <ClockNumber2> | 20 | 1 | 12/14/2022 | Already Supplied | HD 1080i 25fps | BTMTFSTT2 | Motorvision TV:Express |
| automated test info | BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1 | BTMTAPMC4_4 | <ClockNumber1> | 20 | 1 | 12/14/2022 | Already Supplied |HD 1080i 25fps | BTMTFST4 | TV Bayern Media:Standard |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number | PO Number |
| BTMTAPM12 | BTMTAPM12 |
And wait for finish place order with following item clock number 'BTMTAPMCN9_1,BTMTAPMCN9_2' to A4
When ingested assests through A5 with following fields:
| agencyName           | clockNumber    |
| DefaultAgency | <ClockNumber1> |
| DefaultAgency | <ClockNumber2> |
When login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber2>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber '<ClockNumber2>'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test1_1 | Test |
And wait for '5' seconds
And I open Traffic Order List page
And I create tab with name 'MASTER_READY' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Master Ready For Approval |
And wait till order item list will be loaded in Traffic
Then I 'should' see orderItems '<ClockNumber2>' in order item list in Traffic
And I 'should not' see orderItems '<ClockNumber1>' in order item list in Traffic
When login with details of 'broadcasterTrafficManagerOne'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Master Ready For Approval' in Traffic
And I amon order item details page of clockNumber '<ClockNumber1>'
And click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test2 | Test |
And wait for '5' seconds
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Delivered' in Traffic
And I open Traffic Order List page
And I create tab with name 'MASTER_RELEASED' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Delivered |
And wait till order item list will be loaded in Traffic
Then I 'should' see orderItems '<ClockNumber1>' in order item list in Traffic
And I 'should not' see orderItems '<ClockNumber2>' in order item list in Traffic

Examples:
| ClockNumber1 | ClockNumber2 | TabType |
| BTMTAPMCN9_1 | BTMTAPMCN9_2 | Order Item (Send)      |



Scenario: Check that BT Tab filtered by Proxy Rejected and Master Rejected status shows correct deliveries
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format | Title | Destination |
| automated test info | BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1 | BTMTRPMC4_4 | <ClockNumber2> | 20 | 1 | 12/14/2022 | Already Supplied | HD 1080i 25fps | BTMTRPMTT2 | TV Bayern Media:Express |
| automated test info | BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1 | BTMTRPMC4_4 | <ClockNumber1> | 20 | 1 | 12/14/2022 | Already Supplied |HD 1080i 25fps | BTMTRPMT4 | Motorvision TV:Standard |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number | PO Number |
| BTMTAPM12 | BTMTAPM12 |
And wait for finish place order with following item clock number 'BTMTRPMCN9_1,BTMTRPMCN9_2' to A4
When ingested assests through A5 with following fields:
| agencyName           | clockNumber |
| DefaultAgency | <ClockNumber1> |
| DefaultAgency | <ClockNumber2> |
When login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber '<ClockNumber1>'
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test1_1 | Test |
And wait for '5' seconds
And I open Traffic Order List page
And I create tab with name 'PROXY_REJECTED' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Proxy Rejected |
And wait till order item list will be loaded in Traffic
Then I 'should' see orderItems '<ClockNumber1>' in order item list in Traffic
And I 'should not' see orderItems '<ClockNumber2>' in order item list in Traffic
When login with details of 'broadcasterTrafficManagerOne'
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber2>' will have broadcaster status 'Master Ready For Approval' in Traffic
And I amon order item details page of clockNumber '<ClockNumber2>'
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test2 | Test |
And wait for '5' seconds
And I open Traffic Order List page
And I create tab with name 'MASTER_REJECT' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Master Rejected |
And wait till order item list will be loaded in Traffic
Then I 'should' see orderItems '<ClockNumber2>' in order item list in Traffic
And I 'should not' see orderItems '<ClockNumber1>' in order item list in Traffic

Examples:
| ClockNumber1 | ClockNumber2 | TabType |
| BTMTRPMCN9_1 | BTMTRPMCN9_2 |  Order Item (Send)  |

Scenario: Check that BT Tab created after Proxy restored and Master restored shows correct deliveries
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format | Title | Destination |
| automated test info | BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1| BTMTRTPMC4_4 | <ClockNumber2> | 20 | 1 | 12/14/2022 | Already Supplied | HD 1080i 25fps | BTMTRTPMTT2 | TV Bayern Media:Express |
| automated test info | BTMTFSAR1 | BTMTFSBR1 | BTMTFSSB1 | BTMTFSSP1| BTMTRTPMC4_4 | <ClockNumber1> | 20 | 1 | 12/14/2022 | Already Supplied |HD 1080i 25fps | BTMTRTPMT4 | Motorvision TV:Standard |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number | PO Number |
| BTMTRTPM12 | BTMTRTPM12 |
And wait for finish place order with following item clock number 'BTMTRTPMCN9_1,BTMTRTPMCN9_2' to A4
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency | <ClockNumber1> |
| DefaultAgency | <ClockNumber2> |
When login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber '<ClockNumber1>'
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test1_1 | Test |
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Rejected' in Traffic
And I refresh the page
And click on 'Restore Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test4 | Test |
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I open Traffic Order List page
And I create tab with name 'PROXY_READY' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Proxy Ready For Approval |
And wait till order item list will be loaded in Traffic
Then I 'should' see orderItems '<ClockNumber1>' in order item list in Traffic
And I 'should not' see orderItems '<ClockNumber2>' in order item list in Traffic
When login with details of 'broadcasterTrafficManagerOne'
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber2>' will have broadcaster status 'Master Ready For Approval' in Traffic
And I amon order item details page of clockNumber '<ClockNumber2>'
And click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test2 | Test |
And wait till order item with clockNumber '<ClockNumber2>' will have broadcaster status 'Master Rejected' in Traffic
And click on 'Restore Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email | Comment |
| test4 | Test |
And wait till order item with clockNumber '<ClockNumber2>' will have broadcaster status 'Master Ready For Approval' in Traffic
And I open Traffic Order List page
And I create tab with name 'MASTER_READY' and type '<TabType>' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Master Ready For Approval |
And wait till order item list will be loaded in Traffic
Then I 'should' see orderItems '<ClockNumber2>' in order item list in Traffic
And I 'should not' see orderItems '<ClockNumber1>' in order item list in Traffic

Examples:
| ClockNumber1 | ClockNumber2 | TabType |
| BTMTRTPMCN9_1 | BTMTRTPMCN9_2 | Order Item (Send)|


