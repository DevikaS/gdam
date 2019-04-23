Feature:    Traffic Escalate functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check escalate feature



Scenario: Check that BT user with Escalate permission,can escalate master and receive email notification
!--NGN-16231 NGN-16254
Meta: @traffic
      @trafficemails
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand    | Sub Brand | Product  |
| TBUEMAR1   | TBUEMBR1 | TBUEMSB1  | TBUEMPR1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title | Destination                                      |
| automated test info    | TBUEMAR1   | TBUEMBR1 | TBUEMSB1  | TBUEMPR1 | TAFCP1   | TEFCN1       | 20       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TAFT1 | Motorvision TV:Express;Travel Channel DE:Express |
And complete order contains item with clock number 'TEFCN1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TEFCN1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TEFCN1    |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order item with clockNumber 'TEFCN1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TEFCN1'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|           TEFE1                 |    Test   |
And click on 'Escalate Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                 |  Comment  |
|           TEFE1                 |    Test   |
Then I 'should' see 'Master Escalated' Broadcaster Approval Status on on order item details page in traffic
And I 'should not' see email with subject 'Master escalation for' sent to user 'TEFE1' and body contains 'Test dest - Traffic 002'



Scenario: Check that BT user with Escalate permission,can open link from email and proxy will be available
!-- NGN-16254
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Motivnummer | Subtitles Required | Format         | Title | Destination                                      |
| automated test info    | TBUEMAR1   | TBUEMBR1 | TBUEMSB1  | TBUEMPR1 | TAFCP1   | TEFCN2       | 20       | 12/14/2022     |      1      | Already Supplied   | HD 1080i 25fps | TAFT1 | Motorvision TV:Express;Travel Channel DE:Express |
And complete order contains item with clock number 'TEFCN2' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TEFCN2' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TEFCN2    |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber 'TEFCN2' will be available in Traffic
And wait till order item with clockNumber 'TEFCN2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TEFCN2'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                 |  Comment  |
|      TEFE2         |    Test   |
And click on 'Escalate Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                 |  Comment  |
|      TEFE2         |    Test   |
And open Traffic Order List page
And I wait till order item list will be loaded in Traffic
And logout from account
When I open link from email with subject 'Master escalation for TEFCN2' which user 'TEFE2' received
And wait till order item page will be loaded in Traffic
Then I 'should' see playable preview on order item details page in traffic