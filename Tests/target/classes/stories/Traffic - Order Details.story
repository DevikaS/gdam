Feature:    Traffic Approval functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check approval feature and ACL

Lifecycle:
Before:
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TBCAR1     | TBCBR1  | TBCSB1    | TBCSP1  |
And updated the following agency:
| Name                       | Escalation Enabled | Approval Type | Proxy Approver | Master Approver              |
| BroadCasterAgencyOneStage  |       true         |      one      |                | broadcasterTrafficManagerOne |

Scenario: TM can see Order Item Delivery Status Order Details view
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser     | Brand       | Sub Brand   | Product    | Campaign   | Clock Number    | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title      | Destination           |
| automated test info    | TBCAR1         | TBCBR1      | TBCSB1      | TBCSP1     | TLCMOTC4_4 | <ClockNumber_1> | 20       | 1           | 12/14/2022     |   Already Supplied | HD 1080i 25fps | TLCMOTT2   | Travel Channel DE:Express       |
| automated test info    | TBCAR1         | TBCBR1      | TBCSB1      | TBCSP1     | TLCMOTC4_4 | <ClockNumber_2> | 20       | 1           | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TLCMFSRT4  | Motorvision TV:Express  |
| automated test info    | TBCAR1         | TBCBR1      | TBCSB1      | TBCSP1     | TLCMOTC4_4 | <ClockNumber_3> | 20       | 1           | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TLCMFSRT4  | Motorvision TV:Express  |
And complete order contains item with clock number '<ClockNumber_1>' with following fields:
| Job Number   | PO Number  |
| TLCMOTSR14   | TLCMOTSR14 |
And wait for finish place order with following item clock number '<ClockNumber_1>' to A4
And wait for finish place order with following item clock number '<ClockNumber_2>' to A4
And wait for finish place order with following item clock number '<ClockNumber_3>' to A4
And ingested assests through A5 with following fields:
 | agencyName    | clockNumber      |
 | DefaultAgency | <ClockNumber_1>  |
And ingested assests through A5 with following fields:
  | agencyName    | clockNumber      |
  | DefaultAgency | <ClockNumber_2>  |
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order item with clockNumber '<ClockNumber_1>' with destination 'Travel Channel DE' will have the next Destination Status 'Transfer Complete' in Traffic
And waited till order item with clockNumber '<ClockNumber_2>' with destination 'Motorvision TV' will have the next Destination Status 'Awaiting station release' in Traffic
And waited till order item with clockNumber '<ClockNumber_3>' with destination 'Motorvision TV' will have the next Destination Status 'New' in Traffic
When am on order details page of clockNumber '<ClockNumber_1>'
Then I should see '<ClockNumber_1>' in delivery status 'Transfer Complete' in order details page for destination 'Travel Channel DE'
And I should see '<ClockNumber_2>' in delivery status 'Awaiting station release' in order details page for destination 'Motorvision TV'
And I should see '<ClockNumber_3>' in delivery status 'New' in order details page for destination 'Motorvision TV'

Examples:
|ClockNumber_1 | ClockNumber_2  |  ClockNumber_3 |
|TTVBTVSCN17_3|  TTVBTVSCN17_4  | TTVBTVSCN17_1N  |

Scenario: TM can see Order Item Delivery Status as Cancelled in Order Details view when destination is cancelled
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format          | Title       | Destination                                     |Motivnummer |
| automated test info    | TBCAR1       | TBCBR1       | TBCSB1       | TBCSP1      | TLCMC4    | <ClockNumber>     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TLCMFSRT4_2 | Eurosport DE:Standard;TV Bayern Media:Standard  | 1          |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number   | PO Number    |
| TLCMOTSR14_2 | TLCMOTSR14_2 |
| TLCMOTSR14_2 | TLCMOTSR14_2 |
When I login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber>' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number '<ClockNumber>'
And cancel following destinations for Select Broadcast Destinations form on order item page 'TV Bayern Media'
And wait for '2' seconds
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And am on order details page of clockNumber '<ClockNumber>'
And refresh the page without delay
Then I should see '<ClockNumber>' in delivery status 'Cancelled' in order details page for destination 'TV Bayern Media'

Examples:
|ClockNumber |
|TTVBTVSCN17_9|



Scenario: TM can see on Hold Dest as yes in Order Details view when destination is put on hold
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | TBCAR1       | TBCBR1       | TBCSB1       | TBCSP1      | TLCMC4    | <ClockNumber>     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TLCMFSRT4_2 | Eurosport DE:Standard;Motorvision TV:Standard                      | 1          |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number   | PO Number    |
| TLCMOTSR14_3 | TLCMOTSR14_3 |
And wait for finish place order with following item clock number '<ClockNumber>' to A4
When login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber>' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number '<ClockNumber>'
And hold following destinations for Select Broadcast Destinations form on order item page 'Motorvision TV'
Then I 'should' see order item held for approval for active cover flow
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And wait till order with clockNumber '<ClockNumber>' will have next status 'In Progress' in Traffic
And am on order details page of clockNumber '<ClockNumber>'
And refresh the page without delay
And I wait for '3' seconds
Then I should see '<ClockNumber>' with value 'Yes' for on Hold Dest in order details page for destination 'Motorvision TV'

Examples:
|ClockNumber |
|TTVBTVSCN17_8|

Scenario: Check for Order data on Order Details page
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination          | Motivnummer |
| automated test info    | TBCAR1     | TBCBR1 | TBCSB1    | TBCSP1  | TTVBTVSC1 | TMCSODCN_1   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCSODST1 | Facebook DE:Standard | 1 |
And complete order contains item with clock number 'TMCSODCN_1' with following fields:
| Job Number | PO Number |
| TMCSODJO2  | TMCSODPO2 |
And wait for finish place order with following item clock number 'TMCSODCN_1' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber |
| DefaultAgency | TMCSODCN_1  |
And logged in with details of 'trafficManager'
And waited till order with clockNumber 'TMCSODCN_1' will be available in Traffic
And waited till order item with clockNumber 'TMCSODCN_1' will have next status for 'TVC Ingested OK' in Traffic
And waited till order with clockNumber 'TMCSODCN_1' will have next status 'Completed' in Traffic
And am on order details page of clockNumber 'TMCSODCN_1'
Then I 'should' see following fields on order details page in Traffic UI:
| Order Item Ingest Status | Status         | Market Country  | Job Number  |  Po Number  | Market  | Order Service Level | Agency Name |Order Service Level Minutes | On Hold   |  Has Additional Services  |Subtitles Required  |Ingest Location |
| TVC Ingested OK          | Completed    | de              | TMCSODJO2   |  TMCSODPO2  | Germany | Standard            | A5testAdvertiser |300  | No        |    No                     | No | AdstreamQaIngest  |


Scenario:  Check that orders with HD-SD clones are displayed correctly in Traffic Order details page
!--This scenario will fail until FAB-546 is fixed
Meta: @traffic
@tbug
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TBCAR1     | TBCBR1     | TBCSB1     | TBCSP1    | TBCSC1    | TMHSCODCN_1      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMHSCODTS4 |         |
When I open order item with following clock number 'TMHSCODCN_1'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And fill Search Stations field by value 'Ad Systems/ St Catherine Springfield, KY' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)                           |
|Ad Systems/ St Catherine Springfield, KY |
And fill Search Stations field by value 'Airport Network' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)   |
| Airport Network |
And fill Search Stations field by value 'FisherMTA_ABCSD' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)   |
| FisherMTA_ABCSD |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TMEATJ1    | GDNTDPO1  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TMHSCODCN_1' to A4
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  DefaultAgency   | TMHSCODCN_1       | Airdate Traffic Services|
|  DefaultAgency   | TMHSCODCN_1       | FisherMTA_ABCSD                             |
|  DefaultAgency   | TMHSCODCN_1       | Airport Network        |
And login with details of 'trafficManager'
And on order item details page of clockNumber 'TMHSCODCN_1'
Then 'should' see following delivery item in order details page:
 |Clock Number   | Delivery Status | On Hold Dest | Destination Name                          | Service Level    |
 |TMHSCODCN_1    | New             | No           | Ad Systems/ St Catherine Springfield, KY  | Standard (US)    |
 |TMHSCODCN_1    | New             | No           | FisherMTA_ABCSD                           | Standard (US)    |
 |TMHSCODCN_1    | New             | No           | Airdate Traffic Services                  | Standard (US)    |
 |TMHSCODCN_1    | New             | No           | Airport Network                           | Standard (US)    |
And 'should' see following Order Item data for Clones for Clock Number 'TMHSCODCN_1':
 |Clock Number | Status            | On Hold  | Advertiser   | Title       | Product    |
 |TMHSCODCN_1    | TVC Ingested OK   | No       | TBCAR1       | TMHSCODTS4   | TBCSP1     |
 |TMHSCODCN_1    | TVC Ingested OK   | No      | TBCAR1       | TMHSCODTS4   | TBCSP1     |


Scenario: Check that production services and dubbing services can be seen on Order page
Meta: @traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand  | Sub Brand | Product |
| TODADV1    | TODBR1 | TODSB1    | TODPR1  |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | TODADV1    | TODBR1 | TODSB1    | TODPR1  | PSASC4   | TPSASCN4      | 20       | 10/14/2022     | HD 1080i 25fps | PSAST4 | BTI Studios        |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'TPSASCN4'
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City   | Post Code | Country |
| Physical | TPSASDN4          | PSASCnN4     | PSASCD4         | PSASSA4        | PSASC4 | PSASPC4   | PSASC4  |
And create for 'tv' order with item clock number 'TPSASCN4' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                       | Notes & Labels        | Standard |
| Data DVD | TPSASDN4     | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | PSASDN4 PSASCnN4 PSASCD4 PSASSA4 PSASC4 PSASPC4 PSASC4 | automated test notes  | should   |
And create for 'tv' order with item clock number 'TPSASCN4' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
And complete order contains item with clock number 'TPSASCN4' with following fields:
| Job Number | PO Number |
| PSASJN4    | PSASPN4   |
And wait for finish place order with following item clock number 'TPSASCN4' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TPSASCN4' will be available in Traffic
And am on order details page of clockNumber 'TPSASCN4'
Then I 'should' see following production services in order details page:
 |Clock Number | Type      | Notes       |Delivery Status  |
  |TPSASCN4     | Tagging SD |automated test notes| New |
And I 'should' see following dubbing services in order details page:
 |Clock Number | Type      | Notes       |Delivery Status  |Destination | Format      | Service Level | No. Copies |
 |TPSASCN4     | Data DVD  |automated test notes             |New              |PSASDN4     | Avid DNxHD  | Standard      | 2         |


Scenario: Check for delivery item data for the order with 2 clocks on Order page
Meta:@traffic
Given I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              | Motivnummer |
| automated test info    | TBCAR1     | TBCBR1 | TBCSB1    | TBCSP1  | TTVBTVSC1 | TMCDICN_1    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCDIST1  | Travel Channel DE:Standard     | 1           |
| automated test info    | TBCAR1     | TBCBR1 | TBCSB1    | TBCSP1  | TTVBTVSC1 | TMCDICN_2    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCDIST1  | TV Bayern Media:Express | 1           |
And complete order contains item with clock number 'TMCDICN_1' with following fields:
| Job Number | PO Number |
| TMCDIJO3    | TMCDIPO3   |
And wait for finish place order with following item clock number 'TMCDICN_1' to A4
And wait for finish place order with following item clock number 'TMCDICN_2' to A4
And ingested assests through A5 with following fields:
 | agencyName    | clockNumber      |
 | DefaultAgency | TMCDICN_1        |
 | DefaultAgency | TMCDICN_2        |
When login with details of 'trafficManager'
And wait till order with clockNumber 'TMCDICN_1' will be available in Traffic
And wait till order with clockNumber 'TMCDICN_2' will be available in Traffic
And wait till order item with clockNumber 'TMCDICN_1' with destination 'Travel Channel DE' will have the next Destination Status 'Transfer Complete' in Traffic
And wait till order item with clockNumber 'TMCDICN_2' with destination 'TV Bayern Media' will have the next Destination Status 'Awaiting station release' in Traffic
And am on order details page of clockNumber 'TMCDICN_1'
Then 'should' see following delivery item in order details page:
 |Clock Number | Delivery Status            | On Hold Dest | Destination Name   | Service Level |
 |TMCDICN_1    | Transfer Complete          | No           | Travel Channel DE  | Standard      |
 |TMCDICN_2    | Awaiting station release   | No           | TV Bayern Media    | Express       |


Scenario: Check that order item data for the order with 2 cloks on Order page
Meta:@traffic
Given I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination              | Motivnummer |
| automated test info    | TBCAR1     | TBCBR1 | TBCSB1    | TBCSP1  | TTVBTVSC1 | TMOIDCN_1    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Standard | 1           |
| automated test info    | TBCAR1     | TBCBR1 | TBCSB1    | TBCSP1  | TTVBTVSC1 | TMOIDCN_2    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | TV Bayern Media:Standard | 1           |
And complete order contains item with clock number 'TMOIDCN_1' with following fields:
| Job Number | PO Number |
| TMOIDJO3    | TMOIDPO3   |
And wait for finish place order with following item clock number 'TMOIDCN_2' to A4
And ingested assests through A5 with following fields:
 | agencyName    | clockNumber      |
 | DefaultAgency | TMOIDCN_2  |
When login with details of 'trafficManager'
And wait till order with clockNumber 'TMOIDCN_1' will be available in Traffic
And wait till order with clockNumber 'TMOIDCN_2' will be available in Traffic
And wait till order with clockNumber 'TMOIDCN_2' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TMOIDCN_1'
And fill Search Stations field by value 'Facebook DE' for Select Broadcast Destinations form on order item page
And hold following destinations for Select Broadcast Destinations form on order item page 'Facebook DE'
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And am on order details page of clockNumber 'TMOIDCN_1'
And refresh the page without delay
Then 'should' see following Order Item data for Clock Number 'TMOIDCN_1':
 |Clock Number | Status            | On Hold  | Advertiser   | Title       | Product    |
 |TMOIDCN_1    | New               | Yes       | TBCAR1       | TTVBTVST1   | TBCSP1     |
 |TMOIDCN_2    | TVC Ingested OK   | No      | TBCAR1       | TTVBTVST1   | TBCSP1     |



