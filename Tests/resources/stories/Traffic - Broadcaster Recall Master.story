Feature:    Traffic Broadcaster Recall Master functionality
Narrative:
In order to
As a              GlobalAdmin
I want to check broadcaster recall master

Scenario: Check that Broadcaster approval status is changed to File Not Supplied after Recall Master(non approval)
Meta: @traffic
!--NIR-1007
!--This scenario would fail at times coz to set a BU with no stage u need to go to admin-approvals- select one stage-save and then select no stage and save.
!--This adds the traffic section in Mongo BU json for this BU. No work around implemented here and needs to be fixed as per above bug
Given I logged in as 'GlobalAdmin'
And I created 'BTMR2' role with 'delivery.edit,traffic.tab.default.view.all,traffic.tab.default.view.master.approved,traffic.tab.default.view.master.rejected,traffic.tab.default.view.proxy.rejected,traffic.tab.default.view.proxy.approved,traffic.tab.default.view.awaiting.master.approval,traffic.tab.default.view.awaiting.proxy.approval' permissions in 'global' group for advertiser 'BroadCasterAgencyNoApproval'
And logged in with details of 'AgencyAdmin'
And created users with following fields:
| Email     |           Role            | Agency |  Access  | Password |
| TBRMU2   | BTMR2 |   BroadCasterAgencyNoApproval    |  adpath  | abcdefghA1 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TBRMAR2    | TBRMBR2     | TBRMSB2     | TBRMSP2    | TBRMCP2   | TBRMCN2      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TBRMT2     |  Travel Channel DE:Express   |
And complete order contains item with clock number 'TBRMCN2' with following fields:
| Job Number  | PO Number |
| TBRMJN2   | TBRMPO2 |
And wait for finish place order with following item clock number 'TBRMCN2' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TBRMCN2    |
And login as 'TBRMU2' of Agency 'BroadCasterAgencyNoApproval'
And wait till order with clockNumber 'TBRMCN2' will be available in Traffic
And wait till order item with clockNumber 'TBRMCN2' will have broadcaster status 'Delivered' in Traffic
And I amon order item details page of clockNumber 'TBRMCN2'
When I click on Recall Master on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1 |  Recall master |
And wait till order item with clockNumber 'TBRMCN2' will have broadcaster status 'File Not Supplied' in Traffic
And wait till order item with clockNumber 'TBRMCN2' will have broadcaster status 'Delivered' in Traffic
And I refresh the page
Then I 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic

Scenario: Check that Broadcaster approval status is changed to Master Released after Recall Master(two stage)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created 'BTMR3' role with 'delivery.edit,traffic.tab.default.view.all,traffic.tab.default.view.master.approved,traffic.tab.default.view.master.rejected,traffic.tab.default.view.proxy.rejected,traffic.tab.default.view.proxy.approved,traffic.tab.default.view.awaiting.master.approval,traffic.tab.default.view.awaiting.proxy.approval' permissions in 'global' group for advertiser 'BroadCasterAgencyTwoStage_1'
And created users with following fields:
| Email     |           Role            | Agency |  Access     | Password |
| TBRMU3   | BTMR3 |   BroadCasterAgencyTwoStage_1  |  adpath  | abcdefghA1 |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage_1  |       true         |      two      |       TBRMU3         |      TBRMU3    |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TBRMAR3    | TBRMBR3     | TBRMSB3     | TBRMSP3    | TBRMCP3    | TBRMCN3       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TBRMT3     |  Tele 5 DE - Longform:Express   |
And complete order contains item with clock number 'TBRMCN3' with following fields:
| Job Number  | PO Number |
| TBRMJN3   | TBRMPO3 |
And wait for finish place order with following item clock number 'TBRMCN3' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TBRMCN3    |
And login as 'TBRMU3' of Agency 'BroadCasterAgencyTwoStage_1'
And wait till order with clockNumber 'TBRMCN3' will be available in Traffic
And wait till order item with clockNumber 'TBRMCN3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TBRMCN3'
When I click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1 |  Master Released for first order item |
And wait till order item with clockNumber 'TBRMCN3' will have broadcaster status 'Master Ready For Approval' in Traffic
And I refresh the page
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1 |  Master Released for first order item |
And wait till order item with clockNumber 'TBRMCN3' will have broadcaster status 'Master Released' in Traffic
And wait till order item with clockNumber 'TBRMCN3' will have broadcaster status 'Delivered' in Traffic
And I refresh the page
When I click on Recall Master on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1 |  Recall master |
And wait till order item with clockNumber 'TBRMCN3' will have broadcaster status 'Master Released' in Traffic
And wait till order item with clockNumber 'TBRMCN3' will have broadcaster status 'Delivered' in Traffic
And I refresh the page
Then I 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic

Scenario: Check that Broadcaster approval status is changed to Master Released after Recall Master(One stage approval)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created 'BTMR1' role with 'delivery.edit,traffic.tab.default.view.all,traffic.tab.default.view.master.approved,traffic.tab.default.view.master.rejected,traffic.tab.default.view.proxy.rejected,traffic.tab.default.view.proxy.approved,traffic.tab.default.view.awaiting.master.approval,traffic.tab.default.view.awaiting.proxy.approval' permissions in 'global' group for advertiser 'BroadCasterAgencyOneStage'
And created users with following fields:
| Email     |           Role            | Agency |  Access  | Password |
| TBRMU1   | BTMR1 |   BroadCasterAgencyOneStage    |  adpath  | abcdefghA1 |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
| BroadCasterAgencyOneStage  |       true         |      one      |                |      TBRMU1    |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TBRMAR1     | TBRMBR1     | TBRMSB1     | TBRMSP1    | TBRMCP1    | TBRMCN1      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TBRMT1     |  TV Bayern Media:Express   |
And complete order contains item with clock number 'TBRMCN1' with following fields:
| Job Number  | PO Number |
| TBRMJN1   | TBRMPO1 |
And wait for finish place order with following item clock number 'TBRMCN1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TBRMCN1    |
And login as 'TBRMU1' of Agency 'BroadCasterAgencyOneStage'
And wait till order with clockNumber 'TBRMCN1' will be available in Traffic
And wait till order item with clockNumber 'TBRMCN1' will have broadcaster status 'Master Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TBRMCN1'
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1 |  Master Released for first order item |
And wait till order item with clockNumber 'TBRMCN1' will have broadcaster status 'Master Released' in Traffic
And wait till order item with clockNumber 'TBRMCN1' will have broadcaster status 'Delivered' in Traffic
And I refresh the page
When I click on Recall Master on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email              |  Comment                              |
| test1 |  Recall master |
And wait till order item with clockNumber 'TBRMCN1' will have broadcaster status 'Master Released' in Traffic
And wait till order item with clockNumber 'TBRMCN1' will have broadcaster status 'Delivered' in Traffic
And I refresh the page
Then I 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic



