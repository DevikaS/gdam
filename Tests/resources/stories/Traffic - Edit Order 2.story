Feature:    Traffic Edit Order
Narrative:
In order to
As a              AgencyAdmin
I want to check edit order feature

Scenario: Check that after adding additional Service, order item details in traffic order list should be changed (should appear new destination)
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1  | TTVBTVSC1 | TBCCN7_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TBCCN7_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN7_1' will be available in Traffic
And wait till order with clockNumber 'TBCCN7_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN7_1' in simple search form on Traffic Order List page
And wait for '4' seconds
And open edit page for order with Clock Number 'TBCCN7_1' in Traffic
And fill following fields for Additional Services section on order item page:
| Type       |
| FTP Upload |
And fill following fields for 'Add' FTP Delivery Destination form of Additional Services section on order item page:
| FTP Destination Name | FTP Host Name | FTP User Name | FTP Password | FTP Path   |
| OTVMASSFDN2          | OTVMASSFHN2   | OTVMASSFUN2   | OTVMASSFP2   | OTVMASSFP2 |
And add delivery destination for Additional Services section on order item page during 'Add' destination
And fill following fields for Additional Services section on order item page:
| Type       | Destination  | Format            | Specification  | No copies | Notes & Labels       | Standard |
| FTP Upload | OTVMASSFDN2  | MPEG-2 DVD Quality| HD 1080i 25fps | 2         | automated test notes | should   |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait for '5' seconds
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN7_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see additional service 'OTVMASSFDN2' for order item in Traffic List with clockNumber 'TBCCN7_1'

Scenario: Check that after removing additional services, order item details in traffic order list should be changed (destination should be in status cancelled)
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1  | TTVBTVSC1 | TBCCN8_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TBCCN8_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN8_1' will be available in Traffic
And wait till order with clockNumber 'TBCCN8_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN8_1' in simple search form on Traffic Order List page
And wait for '4' seconds
And open edit page for order with Clock Number 'TBCCN8_1' in Traffic
And fill following fields for Additional Services section on order item page:
| Type       |
| FTP Upload |
And fill following fields for 'Add' FTP Delivery Destination form of Additional Services section on order item page:
| FTP Destination Name | FTP Host Name | FTP User Name | FTP Password | FTP Path   |
| OFDN2          | OTVMASSFHN2   | OTVMASSFUN2   | OTVMASSFP2   | OTVMASSFP2 |
And add delivery destination for Additional Services section on order item page during 'Add' destination
And fill following fields for Additional Services section on order item page:
| Type       | Destination  | Format            | Standard | Specification  | Notes & Labels       | No copies |
| FTP Upload | OFDN2  | MPEG-2 DVD Quality| should   | HD 1080i 25fps | automated test notes |  1        |
And wait for '4' seconds
And expand Add Information section on Traffic Order Edit page
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TBCCN8_1' will have next status 'In Progress' in Traffic
And enter search criteria 'TBCCN8_1' in simple search form on Traffic Order List page
And wait for '4' seconds
And open edit page for order with Clock Number 'TBCCN8_1' in Traffic
And click Cancel this service button from Additional Services section on order item page
And wait for '4' seconds
And click proceed button on Traffic Order Edit page
And wait for '4' seconds
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN8_1' in simple search form on Traffic Order List page
And open order details with clockNumber 'TBCCN8_1' from Traffic UI
Then I 'should' see following dubbing services in order details page:
 |Clock Number | Delivery Status|Type|
 |TBCCN8_1     |Cancelled |FTP Upload|



Scenario: Check that after adding usage rights, UR should be present in asset (A5 library)
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1  | TTVBTVSC1 | TBCCN9_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TBCCN9_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN9_1' will be available in Traffic
And wait till order with clockNumber 'TBCCN9_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN9_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TBCCN9_1' in Traffic
And fill following fields for usage right 'Countries' on order item page:
| Country        | Start Date | Expire Date |
| United Kingdom | 02/02/2022 | 02/02/2024  |
And save usage information for 'Countries' usage right on order item page
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And login with details of 'AgencyAdmin'
Then I 'should' see following data for usage type 'Countries' on qc asset 'TTVBTVST1' usage rights page for collection 'My Assets'NEWLIB:
| Country        | StartDate  | ExpirationDate |
| United Kingdom | 02.02.2022 | 02.02.2024     |


Scenario: Check that after cancelling asset, qc asset wont be visible in a5
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clave | Clock Number | Duration | First Air Date | Subtitles Required  | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |   1   | TEOTVSCN23 | 20       | 12/14/2022     | None                |HD 1080i 25fps | TEOTVST10  | 101 TV:Standard |
And complete order contains item with clock number 'TEOTVSCN23' with following fields:
| Job Number | PO Number |
| AUFTATJN1  | AUFTATPN1 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber 'TEOTVSCN23' will be available in Traffic
And waited till order with clockNumber 'TEOTVSCN23' will have next status 'In Progress' in Traffic
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And entered search criteria 'TEOTVSCN23' in simple search form on Traffic Order List page
And expanded all orders on Traffic Order List page
And I amon order item details page of clockNumber 'TEOTVSCN23'
And clicked on 'Edit Asset' button on order item details page in traffic
When I cancel asset on opened info page
And I login with details of 'AgencyAdmin'
And go to the Library page for collection 'My Assets'NEWLIB
And I refresh the page
Then I 'should not' see QCed assets with titles 'TEOTVST10' in the collection 'My Assets'NEWLIB

Scenario: Check that after cancelling asset, destination will be cancelled too
Meta: @traffic
!--NIR-1053
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clave | Clock Number | Duration | First Air Date | Subtitles Required  | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |   1   | TEOTVSCN24 | 20       | 12/14/2022     | None                |HD 1080i 25fps | TEOTVST10  | 101 TV:Standard |
And complete order contains item with clock number 'TEOTVSCN24' with following fields:
| Job Number | PO Number |
| AUFTATJN1  | AUFTATPN1 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber 'TEOTVSCN24' will be available in Traffic
And waited till order with clockNumber 'TEOTVSCN24' will have next status 'In Progress' in Traffic
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And entered search criteria 'TEOTVSCN24' in simple search form on Traffic Order List page
And expanded all orders on Traffic Order List page
And opened order item details page with clockNumber 'TEOTVSCN24'
And clicked on 'Edit Asset' button on order item details page in traffic
When I cancel asset on opened info page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOTVSCN24' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destination '101 TV' with Delivery status 'Cancelled' for order item in Traffic List with clockNumber 'TEOTVSCN24'

Scenario: Traffic Manager can Download Delivery Report from Order Details Page
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1  | TTVBTVSC1 | TBCCN17S_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Express |
And completed order contains item with clock number 'TBCCN17S_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN17S_1' will be available in Traffic
And wait till order with clockNumber 'TBCCN17S_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN17S_1' in simple search form on Traffic Order Item List page
And open order details with clockNumber 'TBCCN17S_1' from Traffic UI
Then I 'should' be able to download Delivery report for clockNumber 'TBCCN17S_1' in order Details page