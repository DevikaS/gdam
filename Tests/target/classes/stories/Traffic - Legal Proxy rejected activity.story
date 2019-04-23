Feature:    Traffic- Order Owner and  Additional recipients are notified about broadcaster rejection of Proxy
Narrative:
In order to
As a              AgencyAdmin
I want to check that user are notified about broadcaster rejection of Proxy


Lifecycle:
Before:
Given updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo      |      broadcasterTrafficManagerTwo     |

Scenario: Check that Additional Recepient's and Order owner can receive LegalProxyRejected email
!--NGN-16237
Meta:@traffic
Given I created the following agency:
| Name     | A4User        |Labels|
| MSFDPNA1 | DefaultA4User |nordics|
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| TLPRAAR1   | TLPRABR1 | TLPRASB1  | TLPRAPR1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TLPRAAR1   | TLPRABR1 | TLPRASB1  | TLPRAPR1 | TAFCP1   | <ClockNumber>    | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express  |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| TEFCUU2  | should not       | automated test | 12/14/2022    |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| PACAJNM2   | PACAPNM2  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number '<ClockNumber>' to A4
When ingested assests through A5 with following fields:
 | agencyName |    clockNumber     |
 | MSFDPNA1   |   <ClockNumber>    |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And I amon order item details page of clockNumber '<ClockNumber>'
And wait till order item with clockNumber '<ClockNumber>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                 |  Comment  |
|      test3         |    Test   |
And wait till order item with clockNumber '<ClockNumber>' will have broadcaster status 'Proxy Rejected' in Traffic
And refresh the page
Then I 'should' see 'Proxy Rejected' Broadcaster Approval Status on on order item details page in traffic
And I '<Condition>' see email with subject 'has been rejected' sent to user 'MSFDPNU1' and body contains 'LEGAL REJECTION'
And I '<Condition>' see email with subject 'has been rejected' sent to user 'TEFCUU2' and body contains 'LEGAL REJECTION'

Examples:
|  Label  |  Condition    | ClockNumber |
| nordics |   should      |  RNABRPCN2  |


Scenario: Check that traffic manager can view or download Proxies for orders placed via 'QC & Ingest Only' or with a destination
Meta: @traffic
      @qatrafficsmoke
      !--NGN-20236
!--QA-398
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand    | Sub Brand | Product  |
| TPVQCAR1   | TPVQCBR1 | TPVQCSB1  | TPVQCSP1 |
And logged in with details of 'AgencyAdmin'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'Germany' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Motivnummer  |
| automated test info    | TPVQCAR1   | TPVQCBR1 | TPVQCSB1  | TPVQCSP1 | TPVQCCP1 | TPVQCCN1_1   | 10       | 12/14/2022     | HD 1080i 25fps | TPVQCT1 |  1    |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard |
| Motorvision TV     |
And 'copy current' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Clock Number | Title   |
| TPVQCCN1_2   | TPVQCT2 |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard |
| TV Bayern Media     |
And 'copy current' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Clock Number | Title   |
| TPVQCCN1_3   | TPVQCT3 |
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TPVQCJO1   | TPVQCPO1  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TPVQCCN1_1' to A4
And waited for finish place order with following item clock number 'TPVQCCN1_2' to A4
And waited for finish place order with following item clock number 'TPVQCCN1_3' to A4
And ingested assests through A5 with following fields:
| agencyName     | clockNumber |
| DefaultAgency  | TPVQCCN1_1  |
| DefaultAgency  | TPVQCCN1_3  |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TPVQCCN1_1' will be available in Traffic
And wait till order with clockNumber 'TPVQCCN1_2' will be available in Traffic
And wait till order with clockNumber 'TPVQCCN1_3' will be available in Traffic
And wait till order item with clockNumber 'TPVQCCN1_3' will have next status 'TVC Ingested OK' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TPVQCCN1_2' in simple search form on Traffic Order List page
And on order item details page of clockNumber 'TPVQCCN1_2'
Then I 'should not' see Support Document 'Matser' for clockNumber 'TPVQCCN1_2' in order details page
And I 'should not' see playable preview on order item details page in traffic
When I amon order item details page of clockNumber 'TPVQCCN1_3'
Then I 'should' see Support Document 'Matser' for clockNumber 'TPVQCCN1_3' in order details page
And I 'should' see Support Document 'Matser' for clockNumber 'TPVQCCN1_3' is downloaded from order details page
And 'should' see playable preview on order item details page in traffic
When I amon order item details page of clockNumber 'TPVQCCN1_1'
Then I 'should' see Support Document 'Matser' for clockNumber 'TPVQCCN1_1' in order details page
And I 'should' see Support Document 'Matser' for clockNumber 'TPVQCCN1_1' is downloaded from order details page
And I 'should' see playable preview on order item details page in traffic
When I login with details of 'broadcasterTrafficManagerTwo'
And on order item details page of clockNumber 'TPVQCCN1_1'
Then I 'should' see playable preview on order item details page in traffic
When I login with details of 'broadcasterTrafficManagerOne'
And on order item details page of clockNumber 'TPVQCCN1_2'
Then I 'should not' see playable preview on order item details page in traffic
