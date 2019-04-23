!-- NGN-19361
Feature:    Traffic Edit Order
Narrative:
In order to
As a              AgencyAdmin
I want to check edit order feature


Lifecycle:
Before:
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFMAR1    | TAFMBR1    | TAFMSB1    | TAFMOP1   |
|  TAFMAR2   |  TAFMBR2   |  TAFMBR2   |  TAFMOP2 |
And I am logged in as 'GlobalAdmin'
And on the global 'common editable' metadata page for agency 'DefaultAgency'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo      |      broadcasterTrafficManagerTwo     |
| BroadCasterAgency7209  |       true         |      two      |broadcasterTrafficManager7209      |      broadcasterTrafficManager7209     |
| BroadCasterAgency20320  |       true         |      two      |broadcasterTrafficManager20320      |      broadcasterTrafficManager20320     |
| BroadCasterAgencyOneStage  |       true         |      one      |  |broadcasterTrafficManagerOne |


Scenario: Check that Music orders can be approved By broadcast traffic manager for Germany Market
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'music' order with market 'Germany' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code  | Release Date | Format         | Title    | Destination                                    |
| automated test info    | TAFMAR1        | TAFMBR1   | TAFMSB1   | TAFMOP1  | TAFMOC1   | TAFMCN1_1 | 12/14/2022   | HD 1080i 25fps | TAFMT1 | Motorvision TV:Express;Travel Channel DE:Express |
And complete order contains item with clock number 'TAFMCN1_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFMCN1_1' to A4
When ingested assests through A5 with following fields:
 | agencyName         | clockNumber |
 | DefaultAgency      | TAFMCN1_1  |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order item with clockNumber 'TAFMCN1_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TAFMCN1_1'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And I 'should' see email with subject 'has been approved' sent to user 'test1_1' and body contains 'Motorvision TV'
And I 'should not' see email with subject 'has been approved' sent to user 'test1_1' and body contains 'Travel Channel DE'


Scenario: Check that after order editing of Music orders in traffic, fields also should be changed in order list for Germany Market
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'music' order with market 'Germany' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand | Label    | Artist    | ISRC Code     | Release Date | Format         | Title    | Destination                                    |
| automated test info    |  TAFMAR1       |  TAFMBR1   |  TAFMBR1  | TAFMOP1  | TAFMOC2   | <ClockNumber> | 12/14/2022   | HD 1080i 25fps | TAFMT2 | Motorvision TV:Express;Travel Channel DE:Express |
And completed order contains item with clock number '<ClockNumber>' with following fields:
| Job Number    | PO Number   |
| <Job Number>  | <PO Number> |
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber>' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number '<ClockNumber>'
And edit order in traffic with the following fields:
| FieldName          | FieldValue        |
| Key Number         | <NewClock>        |
| Title              | ChangedName       |
| Advertiser         |  TAFMAR2          |
| Brand              |  TAFMBR2          |
| Sub Brand          |  TAFMBR2          |
| Product            |  TAFMOP2          |
| Release Date     |  12/16/2021         |
And click proceed button on Traffic Order Edit page
And fill following fields on Order Proceed page:
| Job Number         | PO Number        |
| <New Jb Number>   | <New Pb Number>  |
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And enter search criteria '<NewClock>' in simple search form on Traffic Order List page
Then I should see order with clockNumber '<NewClock>' in traffic list that have following data:
| Job Number         | PO Number        |
| <New Jb Number>   | <New Pb Number>  |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber '<NewClock>' in traffic order list that have following data:
| Clock Number | Advertiser |  Title           |  Release Date |
| <NewClock>   |  TAFMAR2   |  ChangedName     | 12/16/2021    |
Examples:
| Job Number | PO Number | New Jb Number | New Pb Number | ClockNumber  | NewClock       |
| TTVBTMS11  | TTVBTMS12 | editedS11      | editedS12     | TEOTMCN17_1 | TTVBMST1_testing |
|            |           | editedS21      | editedS22     | TEOTMCN17_2 | TTVBMST2_testing |

Scenario: Check that Music orders can be seen By broadcast traffic manager for Market Music Promo UK
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'music' order with market 'Music Promo UK' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code  | Release Date | Format         | Title    | Destination                                    |
| automated test info    | TAFMAR1        | TAFMBR1   | TAFMBR1   | TAFMOP1  | TAFMOC1   | TAFMPUCN1_1 | 12/14/2022   | HD 1080i 25fps | TAFMT1 | MTV UK (Music Promo):Standard;SubTV (Music Promo):Standard|
And complete order contains item with clock number 'TAFMPUCN1_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAFMPUCN1_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      | TAFMPUCN1_1  |
And login with details of 'broadcasterTrafficManager7209'
And wait till order item with clockNumber 'TAFMPUCN1_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TAFMPUCN1_1'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And I 'should' see email with subject 'has been approved' sent to user 'test1_1' and body contains 'SubTV (Music Promo)'
And I 'should not' see email with subject 'has been approved' sent to user 'test1_1' and body contains 'MTV UK (Music Promo)'


Scenario: Check that Music orders can be seen By broadcast traffic manager for Market Music Promo Australia
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'music' order with market 'Music Promo Australia' and items with following fields:
| Additional Information | Record Company | Brand       | Sub Brand  | Label       | Artist   | ISRC Code  | Release Date | Format         | Title    | Destination                                    |
| automated test info    | TAFMAR1        | TAFMBR1     | TAFMBR1    | TAFMOP1     | TAFMOC1   | TAFMPUACN1_1 | 12/14/2022   | HD 1080i 25fps | TAFMT1 | (music NZ) Juice TV:Red Hot (AU);(music) MTV:Red Hot (AU) |
And complete order contains item with clock number 'TAFMPUACN1_1' with following fields:
| Job Number     | PO Number    |
| TAFAMPUTVS11   | TAFAMPUTVS11 |
And wait for finish place order with following item clock number 'TAFMPUACN1_1' to A4
When ingested assests through A5 with following fields:
 | agencyName      | clockNumber |
 | DefaultAgency   | TAFMPUACN1_1  |
And login with details of 'broadcasterTrafficManager20320'
And wait till order item with clockNumber 'TAFMPUACN1_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TAFMPUACN1_1'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|   Email           |  Comment  |
|    test1_1        |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
And I 'should' see email with subject 'has been approved' sent to user 'test1_1' and body contains '(music NZ) Juice TV'
And I 'should not' see email with subject 'has been approved' sent to user 'test1_1' and body contains '(music) MTV'

Scenario: Check that after order editing of Music orders in traffic, fields also should be changed in order list for Market Music Promo UK
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'music' order with market 'Music Promo UK' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand | Label       | Artist    | ISRC Code     | Release Date | Format         | Title    | Destination                                    |
| automated test info    | TAFMAR1        | TAFMBR1    | TAFMBR1   | TAFMOP1     | TAFMOC2   | <ClockNumber> | 12/14/2022   | HD 1080i 25fps | TAFMT2   | Capital TV (Music Promo):Standard;Clubland TV (Music Promo):Standard |
And completed order contains item with clock number '<ClockNumber>' with following fields:
| Job Number    | PO Number   |
| <Job Number>  | <PO Number> |
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber>' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number '<ClockNumber>'
And edit order in traffic with the following fields:
| FieldName          | FieldValue        |
| Key Number         | <NewClock>        |
| Title              | ChangedName       |
| Advertiser         | TAFMAR2           |
| Brand              | TAFMBR2           |
| Sub Brand          | TAFMBR2           |
| Product            | TAFMOP2           |
| Release Date       |  12/16/2021       |
And click proceed button on Traffic Order Edit page
And fill following fields on Order Proceed page:
| Job Number         | PO Number       |
| <New Jb Number>   | <New Pb Number>  |
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria '<NewClock>' in simple search form on Traffic Order List page
Then I should see order with clockNumber '<NewClock>' in traffic list that have following data:
| Job Number         | PO Number        |
| <New Jb Number>   | <New Pb Number>  |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber '<NewClock>' in traffic order list that have following data:
| Clock Number | Advertiser |  Title           |  Release Date |
| <NewClock>   | TAFMAR2    |  ChangedName     | 12/16/2021    |
Examples:
| Job Number    | PO Number    | New Jb Number | New Pb Number | ClockNumber    | NewClock       |
| TCNTMPUTVS11  | TCNTMPUTVS12 | editedS11      | editedS12     | TEOTMPUCN17_1 | TTVBMPUST1_test |
|               |              | editedS21      | editedS22     | TEOTMPUCN17_2 | TTVBMPUST2_test |


Scenario: Check that after order editing of Music orders in traffic, fields also should be changed in order list for Market Music Promo Australia
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'music' order with market 'Music Promo Australia' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand | Label       | Artist    | ISRC Code     | Release Date | Format         | Title    | Destination                                    |
| automated test info    | TAFMAR1        | TAFMBR1    | TAFMBR1   | TAFMOP1     | TAFMOC2   | <ClockNumber> | 12/14/2022   | HD 1080i 25fps | TAFMT2   | (music NZ) Juice TV:Standard (AU);(music) MTV:Standard (AU) |
And completed order contains item with clock number '<ClockNumber>' with following fields:
| Job Number    | PO Number   |
| <Job Number>  | <PO Number> |
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber>' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number '<ClockNumber>'
And edit order in traffic with the following fields:
| FieldName          | FieldValue        |
| Key Number         | <NewClock>        |
| Title              | ChangedName       |
| Advertiser         | TAFMAR2           |
| Brand              | TAFMBR2           |
| Sub Brand          | TAFMBR2           |
| Product            | TAFMOP2           |
| Release Date     |  12/16/2021         |
And click proceed button on Traffic Order Edit page
And fill following fields on Order Proceed page:
| Job Number         | PO Number        |
| <New Jb Number>   | <New Pb Number>  |
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And enter search criteria '<NewClock>' in simple search form on Traffic Order List page
Then I should see order with clockNumber '<NewClock>' in traffic list that have following data:
| Job Number         | PO Number        |
| <New Jb Number>   | <New Pb Number>  |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber '<NewClock>' in traffic order list that have following data:
| Clock Number | Advertiser |  Title           |  Release Date |
| <NewClock>   | TAFMAR2    |  ChangedName     | 12/16/2021    |
Examples:
| Job Number | PO Number | New Jb Number | New Pb Number | ClockNumber    | NewClock       |
| TTVBTVS11  | TTVBTVS12 | editedS11      | editedS12     | TEOTMPACN17_1 | TTVBMPAST1_test |
|            |           | editedS21      | editedS22     | TEOTMPACN17_2 | TTVBMPAST2_test |
