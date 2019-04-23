!--QA-468
Feature:    Traffic Manager can see Ads Ingested and Delivered
Narrative:
In order to
As a AgencyAdmin
I want to see Ads Ingested and Delivered

Lifecycle:
Before:
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TMAIDAR1    | TMAIDBR1 | TMAIDSB1   | TMAIDP1  |


Scenario: Check that Ingested and delivered Ads field when the clock is not ingested and the destination is not delivered
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TMAIDAR1     | TMAIDBR1 | TMAIDSB1    | TMAIDP1  | TMAIDC1 | TMAIDCN1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMAIDT1 | Talk Sport:Standard |
And complete order contains item with clock number 'TMAIDCN1' with following fields:
| Job Number | PO Number |
| TMAIDJO1    | TMAIDPO1 |
And wait for finish place order with following item clock number 'TMAIDCN1' to A4
And logged in with details of 'trafficManager'
When I select 'All' tab in Traffic UI
And enter search criteria 'TMAIDCN1' in simple search form on Traffic Order Item List page
Then I should see order with clockNumber 'TMAIDCN1' in traffic list that have following data:
| Ingested Ads|
| 0/1    |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMAIDCN1' in traffic order list that have following data:
| Ads Delivered |
| 0/1 |   |


Scenario: Check that Ingested Ads field when the clock is ingested and Delivered Ad's field when the destination is before-after delivered
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I updated the following agency:
| Name     | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
| BroadCasterAgencyOneStage  |       true         |      one      |                |      broadcasterTrafficManagerOne    |
And waited for '4' seconds
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |Motivnummer|
| automated test info    | TMAIDAR1    | TMAIDBR1     | TMAIDSB1     | TMAIDP1    | TMAIDC2_1   | TMAIDCN2_1     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TMAIDT2_1     |  Travel Channel DE:Express   |1|
| automated test info    | TMAIDAR1    | TMAIDBR1     | TMAIDSB1     | TMAIDP1    | TMAIDC2_2  | TMAIDCN2_2      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TMAIDT2_2     |  TV Bayern Media:Express   |2|
And complete order contains item with clock number 'TMAIDCN2_1' with following fields:
| Job Number | PO Number |
| TMAIDJN2    | TMAIDPO2 |
And wait for finish place order with following item clock number 'TMAIDCN2_1' to A4
And wait for finish place order with following item clock number 'TMAIDCN2_2' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | TMAIDCN2_1   |
| DefaultAgency | TMAIDCN2_2   |
And logged in with details of 'trafficManager'
When I select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TMAIDCN2_1' will be available in Traffic
And wait till order with clockNumber 'TMAIDCN2_2' will be available in Traffic
And wait till order item with clockNumber 'TMAIDCN2_1' will have broadcaster status 'File Not Supplied' in Traffic
And wait till order item with clockNumber 'TMAIDCN2_1' will have broadcaster status 'Delivered' in Traffic
And I wait till order item with clockNumber 'TMAIDCN2_1' will have next status 'TVC Ingested OK' in Traffic
And I wait till order item with clockNumber 'TMAIDCN2_2' will have next status 'TVC Ingested OK' in Traffic
And enter search criteria 'TMAIDCN2_1' in simple search form on Traffic Order Item List page
Then I should see order with clockNumber 'TMAIDCN2_1' in traffic list that have following data:
| Ingested Ads|
| 2/2    |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMAIDCN2_1' in traffic order list that have following data:
| Ads Delivered |
| 1/1    |
And I should see order item with clockNumber 'TMAIDCN2_2' in traffic order list that have following data:
| Ads Delivered |
| 0/1    |
When I login with details of 'broadcasterTrafficManagerOne'
And I wait till order item with clockNumber 'TMAIDCN2_2' will have broadcaster status 'Master Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TMAIDCN2_2'
And I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1 |  Master Released for first order item |
And wait till order item with clockNumber 'TMAIDCN2_2' will have broadcaster status 'Master Released' in Traffic
And wait till order item with clockNumber 'TMAIDCN2_2' will have broadcaster status 'Delivered' in Traffic
And I login with details of 'trafficManager'
And I select 'All' tab in Traffic UI
And enter search criteria 'TMAIDCN2_2' in simple search form on Traffic Order Item List page
And wait for '2' seconds
And expand all orders on Traffic Order List page
And wait for '2' seconds
Then I should see order item with clockNumber 'TMAIDCN2_2' in traffic order list that have following data:
| Ads Delivered |
| 1/1    |


Scenario: Check that Delivered Ad's field with Recall master
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created 'TMAIDR3' role with 'delivery.edit,traffic.tab.default.view.all,traffic.tab.default.view.master.approved,traffic.tab.default.view.master.rejected,traffic.tab.default.view.proxy.rejected,traffic.tab.default.view.proxy.approved,traffic.tab.default.view.awaiting.master.approval,traffic.tab.default.view.awaiting.proxy.approval' permissions in 'global' group for advertiser 'BroadCasterAgencyNoApproval'
And created users with following fields:
| Email                                  |           Role            | Agency                             |  Access  | Password |
| TMAIDU3                                | TMAIDR3                   |   BroadCasterAgencyNoApproval        |  adpath  |abcdefghA1|
And updated the following agency:
| Name     | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
| BroadCasterAgencyNoApproval  |       true         |      none      |                |          |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |Motivnummer|
| automated test info    | TMAIDAR1    | TMAIDBR1     | TMAIDSB1     | TMAIDP1    | TMAIDC3   | TMAIDCN3      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TMAIDT3     |  Travel Channel DE:Express   |1|
And complete order contains item with clock number 'TMAIDCN3' with following fields:
| Job Number  | PO Number |
| TMAIDJN3   | TMAIDPO3 |
And wait for finish place order with following item clock number 'TMAIDCN3' to A4
And I ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TMAIDCN3    |
When login as 'TMAIDU3' of Agency 'BroadCasterAgencyNoApproval'
And wait till order with clockNumber 'TMAIDCN3' will be available in Traffic
And wait till order item with clockNumber 'TMAIDCN3' will have broadcaster status 'Delivered' in Traffic
And I amon order item details page of clockNumber 'TMAIDCN3'
And I click on Recall Master on order item details page in traffic
And wait for '2' seconds
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1 |  Recall master |
And wait till order item with clockNumber 'TMAIDCN3' will have broadcaster status 'File Not Supplied' in Traffic
And wait till order item with clockNumber 'TMAIDCN3' will have broadcaster status 'Delivered' in Traffic
And I login with details of 'trafficManager'
And I select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMAIDCN3' in simple search form on Traffic Order Item List page
And expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TMAIDCN3' in traffic order list that have following data:
| Ads Delivered |
| 1/1 |   |


Scenario: Check that Ingested and Delivered Ad's field for SD and HD clones(SD and HD online destination)
Meta:@traffic
     @tbug
!--This will fail when checks the Ad's delivered for HD destination until QA-541 is resolved
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              |Motivnummer|
| automated test info    | TMAIDAR1     | TMAIDBR1 | TMAIDSB1    | TMAIDP1  | TMAIDC4 | TMAIDCN4    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMAIDT4 |  Disney Germany SD:Standard;Disney Germany HD:Standard |1|
And complete order contains item with clock number 'TMAIDCN4' with following fields:
| Job Number  | PO Number   |
| TMAIDJN4 | TMAIDPO4 |
And wait for finish place order with following item clock number 'TMAIDCN4' to A4
And I ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  DefaultAgency   | TMAIDCN4       | Disney Germany SD|
And I ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations            |
|  DefaultAgency   | TMAIDCN4       | Disney Germany HD          |
And I logout from account
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And I waited till order item with clockNumber 'TMAIDCN4' will have next status for 'TVC Ingested OK' in Traffic
And entered search criteria 'TMAIDCN4' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMAIDCN4' in traffic list that have following data:
| Ingested Ads|
| 2/2    |
And expand all orders on Traffic Order List page
Then I should see order item details for clones in traffic order list that have following data:
|Destination      | Ads Delivered |
|Disney Germany SD| 1/1           |
|Disney Germany HD| 1/1           |


Scenario: Check that Delivered Ad's and Ingested Ads when a clock having more than one online destination
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              |Motivnummer|
| automated test info    | TMAIDAR1     | TMAIDBR1 | TMAIDSB1    | TMAIDP1  | TMAIDC5 | TMAIDCN5    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMAIDT5 |Disney Germany SD:Standard;Travel Channel DE:Standard |1|
And complete order contains item with clock number 'TMAIDCN5' with following fields:
| Job Number  | PO Number   |
| TMAIDJN5 | TMAIDPO5 |
And wait for finish place order with following item clock number 'TMAIDCN5' to A4
And I ingested assests through A5 with following fields:
| agencyName   | clockNumber      |
|  DefaultAgency   | TMAIDCN5       |
And I logout from account
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order with clockNumber 'TMAIDCN5' will be available in Traffic
And waited till order item with clockNumber 'TMAIDCN5' will have next status for 'TVC Ingested OK' in Traffic
And waited till order item with clockNumber 'TMAIDCN5' will have broadcaster status 'Delivered' in Traffic for destination 'Disney Germany SD'
And waited till order item with clockNumber 'TMAIDCN5' will have broadcaster status 'Delivered' in Traffic for destination 'Travel Channel DE'
And waited for '5' seconds
And entered search criteria 'TMAIDCN5' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMAIDCN5' in traffic list that have following data:
| Ingested Ads|
| 1/1    |
And expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TMAIDCN5' in traffic order list that have following data:
| Ads Delivered |
| 2/2 |   |



