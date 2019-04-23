!-- NGN-19563
Feature:    Traffic Manager can cancel Order via Edit Asset
Narrative:
In order to
As a AgencyAdmin
I want to cancel an order via Edit Asset

Lifecycle:
Before:
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TMCOAR1    | TMCOBR1 | TMCOSB1   | TMCOP1  |

Scenario: Check that Traffic manager can cancel Ingested order via 'Edit Asset' (Off-Online Destination)
Meta:@traffic
     @qatrafficsmoke
     @trafficsmoketest
     @trafficcrossbrowser
!--NIR-860 and NIR-1053
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TMCOAR1    | TMCOBR1 | TMCOSB1   | TMCOP1  | TTVBTVSC1 | TMCACN1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
And complete order contains item with clock number 'TMCACN1' with following fields:
| Job Number | PO Number |
| TMCOJO1    | TMCOPO1 |
And wait for finish place order with following item clock number 'TMCACN1' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | TMCACN1   |
And logged in with details of 'trafficManager'
And waited till order with clockNumber 'TMCACN1' will be available in Traffic
And waited till order item with clockNumber 'TMCACN1' will have next status for 'TVC Ingested OK' in Traffic
And I selected 'All' tab in Traffic UI
Then I 'should' see below information on traffic order page for clock 'TMCACN1':
| Order Item Status | Order Status |
| TVC Ingested OK   | In Progress  |
When I expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TMCACN1' in traffic order list that have following data:
| Order Item Status |
| TVC Ingested OK   |
When I open order details with clockNumber 'TMCACN1' from Traffic UI
Then I 'should' see following fields on order details page in Traffic UI:
| Order Item Ingest Status | Status      |
| TVC Ingested OK          | In Progress |
When I amon order item details page of clockNumber 'TMCACN1'
Then I should see following metadata on order details page in traffic:
| Order Item Status |
| TVC Ingested OK   |
When I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order item with clockNumber 'TMCACN1' will have next status 'Cancelled' in Traffic
And wait till order with clockNumber 'TMCACN1' will have next status 'Completed' in Traffic
And select 'All' tab in Traffic UI
Then I 'should' see below information on traffic order page for clock 'TMCACN1':
| Order Item Status | Order Status |
| Cancelled         | Completed    |
When I expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TMCACN1' in traffic order list that have following data:
| Order Item Status |
| Cancelled         |
When I open order details with clockNumber 'TMCACN1' from Traffic UI
Then I 'should' see following fields on order details page in Traffic UI:
| Order Item Ingest Status | Status      |
| Cancelled                | Completed   |
When I amon order item details page of clockNumber 'TMCACN1'
Then I should see following metadata on order details page in traffic:
| Order Item Status |
| Cancelled         |
When I click on 'Edit Asset' button on order item details page in traffic
Then I 'should not' see 'Cancel' button on opened asset info page


Scenario: Check that Traffic manager can cancel Ingested order via 'Edit Asset' (Online Destination)
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination          | Motivnummer |
| automated test info    | TMCOAR1    | TMCOBR1 | TMCOSB1   | TMCOP1  | TTVBTVSC1 | TMCACN2      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Standard | 1 |
And complete order contains item with clock number 'TMCACN2' with following fields:
| Job Number | PO Number |
| TMCOJO2    | TMCOPO2   |
And wait for finish place order with following item clock number 'TMCACN2' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | TMCACN2   |
And logged in with details of 'trafficManager'
And waited till order with clockNumber 'TMCACN2' will be available in Traffic
And waited till order item with clockNumber 'TMCACN2' will have next status for 'TVC Ingested OK' in Traffic
And waited till order with clockNumber 'TMCACN2' will have next status 'Completed' in Traffic
And I selected 'All' tab in Traffic UI
Then I 'should' see below information on traffic order page for clock 'TMCACN2':
| Order Item Status | Order Status |
| TVC Ingested OK   | Completed  |
When I expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TMCACN2' in traffic order list that have following data:
| Order Item Status |
| TVC Ingested OK   |
When I open order details with clockNumber 'TMCACN2' from Traffic UI
Then I 'should' see following fields on order details page in Traffic UI:
| Order Item Ingest Status | Status    |
| TVC Ingested OK          | Completed |
When I amon order item details page of clockNumber 'TMCACN2'
Then I should see following metadata on order details page in traffic:
| Order Item Status |
| TVC Ingested OK   |
When I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order item with clockNumber 'TMCACN2' will have next status 'Cancelled' in Traffic
And select 'All' tab in Traffic UI
Then I 'should' see below information on traffic order page for clock 'TMCACN2':
| Order Item Status | Order Status |
| Cancelled         | Completed    |
When I expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TMCACN2' in traffic order list that have following data:
| Order Item Status |
| Cancelled         |
When I open order details with clockNumber 'TMCACN2' from Traffic UI
Then I 'should' see following fields on order details page in Traffic UI:
| Order Item Ingest Status | Status      |
| Cancelled                | Completed |
When I amon order item details page of clockNumber 'TMCACN2'
Then I should see following metadata on order details page in traffic:
| Order Item Status |
| Cancelled         |
When I click on 'Edit Asset' button on order item details page in traffic
Then I 'should not' see 'Cancel' button on opened asset info page


Scenario: Check that entire order get cancelled when Traffic manager cancels any of the order item
Meta:@traffic
     @qatrafficsmoke
     @trafficsmoketest
     @criticaltraffictests
!--NIR-860 and NIR-1053
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              | Motivnummer |
| automated test info    | TMCOAR1    | TMCOBR1 | TMCOSB1   | TMCOP1  | TTVBTVSC1 | TMCACN3_1    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | TV Bayern Media:Standard | 1           |
| automated test info    | TMCOAR1    | TMCOBR1 | TMCOSB1   | TMCOP1  | TTVBTVSC1 | TMCACN3_2    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | TV Bayern Media:Standard | 1           |
And complete order contains item with clock number 'TMCACN3_1' with following fields:
| Job Number | PO Number |
| TMCOJO3    | TMCOPO3   |
And wait for finish place order with following item clock number 'TMCACN3_1' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | TMCACN3_1   |
| DefaultAgency | TMCACN3_2   |
And logged in with details of 'trafficManager'
And waited till order with clockNumber 'TMCACN3_1' will be available in Traffic
And waited till order item with clockNumber 'TMCACN3_1' will have next status for 'TVC Ingested OK' in Traffic
When I amon order item details page of clockNumber 'TMCACN3_1'
And click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order list will be loaded
And wait till order item with clockNumber 'TMCACN3_1' will have next status 'Cancelled' in Traffic
And select 'All' tab in Traffic UI
And enter search criteria 'TMCACN3_2' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCACN3_2':
| Order Item Status | Order Status |
| Cancelled         | Completed    |
When I expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TMCACN3_2' in traffic order list that have following data:
| Order Item Status |
| TVC Ingested OK   |
When I open order details with clockNumber 'TMCACN3_2' from Traffic UI
Then I 'should' see following fields on order details page in Traffic UI:
| Order Item Ingest Status | Status      |
| Cancelled                | Completed   |
When I amon order item details page of clockNumber 'TMCACN3_2'
Then I should see following metadata on order details page in traffic:
| Order Item Status |
| TVC Ingested OK   |
When I click on 'Edit Asset' button on order item details page in traffic
Then I 'should' see 'Cancel' button on opened asset info page
And 'should' see playable preview on asset info page

Scenario: Check that Traffic manager can cancel non-Ingested order via 'Edit Asset'
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TMCOAR1    | TMCOBR1 | TMCOSB1   | TMCOP1  | TTVBTVSC1 | TMCACN4       | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
And complete order contains item with clock number 'TMCACN4' with following fields:
| Job Number | PO Number |
| TMCOJO4    | TMCOPO4   |
And wait for finish place order with following item clock number 'TMCACN4' to A4
And logged in with details of 'trafficManager'
And waited till order with clockNumber 'TMCACN4' will be available in Traffic
And waited till order item with clockNumber 'TMCACN4' will have next status for 'New' in Traffic
And I selected 'All' tab in Traffic UI
Then I 'should' see below information on traffic order page for clock 'TMCACN4':
| Order Item Status | Order Status |
| New               | In Progress  |
When I expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TMCACN4' in traffic order list that have following data:
| Order Item Status |
| New               |
When I open order details with clockNumber 'TMCACN4' from Traffic UI
Then I 'should' see following fields on order details page in Traffic UI:
| Order Item Ingest Status | Status      |
| New                      | In Progress |
When I amon order item details page of clockNumber 'TMCACN4'
Then I should see following metadata on order details page in traffic:
| Order Item Status |
| New               |
When I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order item with clockNumber 'TMCACN4' will have next status 'Cancelled' in Traffic
And select 'All' tab in Traffic UI
Then I 'should' see below information on traffic order page for clock 'TMCACN4':
| Order Item Status | Order Status |
| Cancelled         | Completed  |
When I expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TMCACN4' in traffic order list that have following data:
| Order Item Status |
| Cancelled         |
When I open order details with clockNumber 'TMCACN4' from Traffic UI
Then I 'should' see following fields on order details page in Traffic UI:
| Order Item Ingest Status | Status      |
| Cancelled                | Completed |
When I amon order item details page of clockNumber 'TMCACN4'
Then I should see following metadata on order details page in traffic:
| Order Item Status |
| Cancelled         |
When I click on 'Edit Asset' button on order item details page in traffic
Then I 'should not' see 'Cancel' button on opened asset info page

Scenario: Check that order status is In-progress before and after ingestion
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              | Motivnummer |
| automated test info    | TMCOAR1    | TMCOBR1 | TMCOSB1   | TMCOP1  | TMCOC5 | TMCOCN5   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT1 | TV Bayern Media:Standard | 1           |
And complete order contains item with clock number 'TMCOCN5' with following fields:
| Job Number | PO Number |
| TMCOJO5    | TMCOPO5   |
And wait for finish place order with following item clock number 'TMCOCN5' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order with clockNumber 'TMCOCN5' will be available in Traffic
And waited till order with clockNumber 'TMCOCN5' will have next status 'In Progress' in Traffic
And I logout from account
And logged in with details of 'AgencyAdmin'
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency  | TMCOCN5  |
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN5' will have next status 'Completed' in Traffic
And enter search criteria 'TMCOCN5' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN5':
| Order Status |
|Completed     |


Scenario: Check that order status is completed when each of the clocks are cancelled(online destination with no approval)
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              | Motivnummer |
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC6_1 | TMCOCN6_1    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT6_1 | Travel Channel DE:Standard | 1           |
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC6_2 | TMCOCN6_2    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT6_2 | Travel Channel DE:Standard | 1           |
And complete order contains item with clock number 'TMCOCN6_1' with following fields:
| Job Number | PO Number |
| TMCOJO6    | TMCOPO6   |
And wait for finish place order with following item clock number 'TMCOCN6_1' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency  | TMCOCN6_1  |
| DefaultAgency  | TMCOCN6_2  |
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order with clockNumber 'TMCOCN6_1' will be available in Traffic
And waited till order with clockNumber 'TMCOCN6_2' will be available in Traffic
And waited till order item with clockNumber 'TMCOCN6_1' with destination 'Travel Channel DE' will have the next Destination Status 'Transfer Complete' in Traffic
And waited till order item with clockNumber 'TMCOCN6_2' with destination 'Travel Channel DE' will have the next Destination Status 'Transfer Complete' in Traffic
And waited till order with clockNumber 'TMCOCN6_1' will have next status 'Completed' in Traffic
And waited till order with clockNumber 'TMCOCN6_2' will have next status 'Completed' in Traffic
When I amon order item details page of clockNumber 'TMCOCN6_1'
When I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN6_1' will have next status 'Completed' in Traffic
And enter search criteria 'TMCOCN6_1' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN6_1':
| Order Status |
|Completed|
When I amon order item details page of clockNumber 'TMCOCN6_2'
When I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN6_2' will have next status 'Completed' in Traffic
And enter search criteria 'TMCOCN6_2' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN6_2':
| Order Status |
|Completed|




Scenario: Check that order status is In-Progress after ingestion(online destination with approvals)
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyOneStage  |       true         |      one      |  |broadcasterTrafficManagerOne |
Given I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              | Motivnummer |
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC7 | TMCOCN7    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT7 | TV Bayern Media:Standard | 1           |
And complete order contains item with clock number 'TMCOCN7' with following fields:
| Job Number | PO Number |
| TMCOJO7    | TMCOPO7   |
And wait for finish place order with following item clock number 'TMCOCN7' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency  | TMCOCN7  |
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order with clockNumber 'TMCOCN7' will be available in Traffic
And waited till order with clockNumber 'TMCOCN7' will have next status 'Completed' in Traffic
And entered search criteria 'TMCOCN7' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN7':
| Order Status |
|Completed|


Scenario: Check that order status is completed after sending the clock to destination(offline destination)
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              | Motivnummer |
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC8 | TMCOCN8    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT8 | MDF 1:Standard | 1           |
And complete order contains item with clock number 'TMCOCN8' with following fields:
| Job Number | PO Number |
| TMCOJO8   | TMCOPO8   |
And wait for finish place order with following item clock number 'TMCOCN8' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency  | TMCOCN8  |
And logged in with details of 'trafficManager'
When I select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN8' will be available in Traffic
And wait till order with clockNumber 'TMCOCN8' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TMCOCN8' will have A5 view status 'Passed QC' in Traffic
And I Edit order item with following clock number 'TMCOCN8'
And click at destination for 'MDF 1' destinations on Select Broadcast Destinations form on order item page:
|  Date       | Time     |
| 10/14/2016  | 10:30 AM |
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN8' will have next status 'Completed' in Traffic
And enter search criteria 'TMCOCN8' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN8':
| Order Status |
|Completed|




Scenario: Check that order status is completed when one of the clock is delivered and another one is cancelled(offline destination)
Meta:@traffic
!--NIR-860 and NIR-1053
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              | Motivnummer |
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC9_1 | TMCOCN9_1    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT9_1 | MDF 1:Standard | 1           |
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC9_2 | TMCOCN9_2    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT9_2 | MDF 1:Standard | 1           |
And complete order contains item with clock number 'TMCOCN9_1' with following fields:
| Job Number | PO Number |
| TMCOJO9  | TMCOPO9  |
And wait for finish place order with following item clock number 'TMCOCN9_1' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency  | TMCOCN9_1  |
| DefaultAgency  | TMCOCN9_2  |
And logged in with details of 'trafficManager'
When I select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN9_1' will be available in Traffic
And wait till order with clockNumber 'TMCOCN9_2' will be available in Traffic
And wait till order with clockNumber 'TMCOCN9_1' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TMCOCN9_1' will have A5 view status 'Passed QC' in Traffic
And I Edit order item with following clock number 'TMCOCN9_1'
And click at destination for 'MDF 1' destinations on Select Broadcast Destinations form on order item page:
|  Date       | Time     |
| 10/14/2016  | 10:30 AM |
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order item with clockNumber 'TMCOCN9_1' will have broadcaster status 'Delivered' in Traffic
And wait till order with clockNumber 'TMCOCN9_1' will have next status 'In Progress' in Traffic
And enter search criteria 'TMCOCN9_1' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN9_1':
| Order Status |
|In Progress|
When I amon order item details page of clockNumber 'TMCOCN9_2'
When I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN9_2' will have next status 'Completed' in Traffic
And enter search criteria 'TMCOCN9_2' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN9_2':
| Order Status |
|Completed|


Scenario: Check that order status is completed when both the clocks are delivered(offline destination)
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              | Motivnummer |
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC10_1 | TMCOCN10_1    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT10_1 | MDF 1:Standard | 1           |
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC10_2 | TMCOCN10_2    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT10_2 | MDF 1:Standard | 1           |
And complete order contains item with clock number 'TMCOCN10_1' with following fields:
| Job Number | PO Number |
| TMCOJO10    | TMCOPO10   |
And wait for finish place order with following item clock number 'TMCOCN10_1' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| DefaultAgency  | TMCOCN10_1  |
| DefaultAgency  | TMCOCN10_2  |
And logged in with details of 'trafficManager'
When I select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN10_1' will be available in Traffic
And wait till order with clockNumber 'TMCOCN10_2' will be available in Traffic
And wait till order with clockNumber 'TMCOCN10_1' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TMCOCN10_1' will have A5 view status 'Passed QC' in Traffic
And I Edit order item with following clock number 'TMCOCN10_1'
And click at destination for 'MDF 1' destinations on Select Broadcast Destinations form on order item page:
|  Date       | Time     |
| 10/14/2016  | 10:30 AM |
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order item with clockNumber 'TMCOCN10_1' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TMCOCN10_2' will have A5 view status 'Passed QC' in Traffic
And I Edit order item with following clock number 'TMCOCN10_2'
And click at destination for 'MDF 1' destinations on Select Broadcast Destinations form on order item page:
|  Date       | Time     |
| 10/14/2016  | 10:30 AM |
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order item with clockNumber 'TMCOCN10_2' will have broadcaster status 'Delivered' in Traffic
And wait till order with clockNumber 'TMCOCN10_2' will have next status 'Completed' in Traffic
And enter search criteria 'TMCOCN10_1' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN10_1':
| Order Status |
|Completed|


Scenario: Check that order status is in-progress when one of the SD/HD clones are cancelled, order status should be completed when another clone is also cancelled(SD and HD offline destination and not delivered)
Meta:@traffic
!--NIR-860 and NIR-1053
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              |
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC1 | TMCOCN11    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT11 |  |
When I open order item with following clock number 'TMCOCN11'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And fill Search Stations field by value 'CBC Vancouver' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US) |
| CBC Vancouver |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TMCOJN11    | TMCOPO11  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TMCOCN11' to A4
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  DefaultAgency   | TMCOCN11       | Airdate Traffic Services|
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations            |
|  DefaultAgency   | TMCOCN11       | CBC Vancouver         |
And I logout from account
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN11' will have next status 'In Progress' in Traffic
And enter search criteria 'TMCOCN11' in simple search form on Traffic Order List page
When I open order details with clockNumber 'TMCOCN11' from Traffic UI
And I open Clone order item details page with clockNumber 'TMCOCN11' from traffic order details page and validate cloned orders and Destinations 'Airdate Traffic Services'
And I refresh the page
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TMCOCN11' will have next status 'In Progress' in Traffic
And enter search criteria 'TMCOCN11' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN11':
| Order Status |
|In Progress|
When I open order details with clockNumber 'TMCOCN11' from Traffic UI
And I open Clone order item details page with clockNumber 'TMCOCN11' from traffic order details page and validate cloned orders and Destinations 'CBC Vancouver'
And I refresh the page
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TMCOCN11' will have next status 'Completed' in Traffic
And enter search criteria 'TMCOCN11' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCN11':
| Order Status |
|Completed|

Scenario: Check that order status is completed when both SD and HD clones are delivered(SD and HD online destination)
Meta:@traffic
     @tbug
!--This scenario will fail when it checks the broadcaster status for HD destination until QA-541 is resolved
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              |Motivnummer|
| automated test info    | TMCOAR1     | TMCOBR1 | TMCOSB1    | TMCOP1  | TMCOC12 | TMCOCNC12    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCOT12 | Disney Germany SD:Standard;Disney Germany HD:Standard |1|
And complete order contains item with clock number 'TMCOCNC12' with following fields:
| Job Number  | PO Number   |
| TMAIDJN12 | TMAIDPO12 |
And wait for finish place order with following item clock number 'TMCOCNC12' to A4
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  DefaultAgency   | TMCOCNC12       | Disney Germany SD|
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations            |
|  DefaultAgency   | TMCOCNC12       | Disney Germany HD          |
And I logout from account
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMCOCNC12' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till cloned order with clockNumber 'TMCOCNC12' will have broadcaster status 'Delivered' in Traffic for destination 'Disney Germany SD'
And wait till cloned order with clockNumber 'TMCOCNC12' will have broadcaster status 'Delivered' in Traffic for destination 'Disney Germany HD'
And enter search criteria 'TMCOCNC12' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TMCOCNC12':
| Order Status |
|Completed|

