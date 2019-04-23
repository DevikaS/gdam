Feature:    Arrival Time in Broadcaster Manager
Narrative:
In order to
As a              AgencyAdmin
I want to check that BT user can edit order item metadata

Lifecycle:
Before:
Given updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo      |      broadcasterTrafficManagerTwo     |


Scenario:  Arrival Time in Broadcaster Manager - Check that Arrival time is displayed for BM
Meta: @traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TBATAR4    | TBATBR4 | TBATSB4   | TBATSP4 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination         | Motivnummer |
| automated test info    | TBATAR4     | TBATBR4     | TBATSB4     | TBATSP4    | TADRSC4    | <ClockNumber>     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TLCMFSRT4  | Motorvision TV:Express  |  1          |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number   | PO Number  |
| TBATSR14     | TBATSR14   |
And wait for finish place order with following item clock number '<ClockNumber>' to A4
When ingested assests through A5 with following fields:
 | agencyName                | clockNumber        |
 | DefaultAgency      |   <ClockNumber>    |
And I login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber '<ClockNumber>' with destination 'Motorvision TV' will have the next Destination Status 'Awaiting station release' in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria '<ClockNumber>' in simple search form on Traffic Order List page
And refresh the page
Then I should see destination 'Motorvision TV' for order item with clockNumber '<ClockNumber>' in traffic order list that have following data:
|     Arrival Date    |
|      Today          |

Examples:
| ClockNumber |
| TBATCN1_1   |


Scenario: Master Arrival Date in TM - Check that the Master Arrival Date is displayed for Traffic Manager
Meta: @traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser    | Brand         | Sub Brand     | Product       |
| TMMARDAR4     | TMMARDBR4     | TMMARDSB4     | TMMARDSP4     |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination         | Motivnummer |
| automated test info    | TBATAR4     | TBATBR4     | TBATSB4     | TBATSP4    | TADRSC4    | <ClockNumber>     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TLCMFSRT4  | Facebook DE:Express  |  1          |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for New Master of order item that supply via '<UploadRequestType>' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| PACAJNM2   | PACAPNM2  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number '<ClockNumber>' to A4
And login with details of 'trafficManager'
And refresh the page
And wait for '5' seconds
And select 'All' tab in Traffic UI
And I Edit order item with following clock number '<ClockNumber>'
And click master arrived button on Traffic Order Edit page
And fill the following fields on master arrived traffic pop up:
|Tape number|Comments|
|  dsdsd    |  sdsd  |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till Master Received Date is set for Order with clockNumber '<ClockNumber>' in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria '<ClockNumber>' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I should see order item with clockNumber '<ClockNumber>' in traffic order list that have following data:
|     Master Received Date    |
|      Today                  |

Examples:
| ClockNumber | UploadRequestType |
| TMMARDCN1_1 | FTP               |
| TMMARDCN1_2 | Physical          |

