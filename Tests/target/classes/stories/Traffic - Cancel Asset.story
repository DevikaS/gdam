!--QA-1167
Feature: I want to cancel assets in Traffic
As a AgencyAdmin
I want to cancel assets in Traffic
So that I can achieve a business goal

Lifecycle:
Before:
Given I created the following agency:
| Name     | A4User        | Save In Library |Allow To Save In Library|
| TOCMC1    | DefaultA4User | true            | true                   |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| TOCMC1_email | agency.admin | TOCMC1        |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TOCMC1':
| Advertiser | Brand   | Sub Brand | Product |
| TOCMCAR1    | TOCMCBR1 | TOCMCSB1   | TOCMCPR1 |


Scenario: Check that orders with HD-SD clones when cancelled the Order status is completed and Order Item status is cancelled
Meta: @traffic
      @qatrafficsmoke
Given I logged in with details of 'TOCMC1_email'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |  Destination                      |
| automated test info    | TOCMCAR1   | TOCMCBR1   | TOCMCSB1   | TOCMCPR1  | TOCMC1    | TOCMCN6         | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  |TOCMCTS1    |  Airdate Traffic Services:Standard (US) |
And complete order contains item with clock number 'TOCMCN6' with following fields:
| Job Number  | PO Number   |
| TOCMJN      | TOCMPN      |
And wait for finish place order with following item clock number 'TOCMCN6' to A4
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |  Destination |
| automated test info    | TOCMCAR1   | TOCMCBR1   | TOCMCSB1   | TOCMCPR1  | TOCMC1    | TOCMCN7         | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  |TOCMCTS2    |              |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |   Market            |
| Physical | TOCMCCDN3_1      | TOCMCN3_1    | TOCMCCD3_1      | TOCMCSA3_1     | TOCMCCC3_1 | TOCMCCPC3_1 | TOCMCCC3_1 | Republic of Ireland |
And create for 'tv' order with item clock number 'TOCMCN7' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard   | Express    |
| Data DVD | TOCMCCDN3_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | TOCMCCDN3_1 TOCMCN3_1 TOCMCCD3_1 TOCMCSA3_1 TOCMCCC3_1 TOCMCCPC3_1 TOCMCCC3_1 | automated test notes  | should     | should not |
When I open order item with following clock number 'TOCMCN7'
And add to order for order item at Add media to your order form following qc assets 'TOCMCTS1'
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
| TOCMJ1    | TOCMPO1  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TOCMCN6' to A4
And wait till order item with clockNumber 'TOCMCN6' has a5 view status 'Order Placed' in Traffic for destination 'Airdate Traffic Services' For Clones
And wait till order item with clockNumber 'TOCMCN6' has a5 view status 'Order Placed' in Traffic for destination 'CBC Vancouver' For Clones
And login with details of 'trafficManager'
And wait till order with clockNumber 'TOCMCN6' will be available in Traffic
And wait till order with clockNumber 'TOCMCN6' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TOCMCN6' will have next status 'New' in Traffic
And wait till order item with clockNumber 'TOCMCN6' will have dubbing service 'TOCMCCDN3_1' with 'New' in Traffic
When enter search criteria 'TOCMCN6' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And am on order details page of clockNumber 'TOCMCN6'
And I open Clone order item details page with clockNumber 'TOCMCN6' from traffic order details page and validate cloned orders and Destinations 'Airdate Traffic Services'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And am on order details page of clockNumber 'TOCMCN6'
And I open Clone order item details page with clockNumber 'TOCMCN6' from traffic order details page and validate cloned orders and Destinations 'CBC Vancouver'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And wait till order with clockNumber 'TOCMCN6' will have next status 'Completed' in Traffic
And wait till order item with clockNumber 'TOCMCN6' will have next status 'Cancelled' in Traffic
And wait till order item with clockNumber 'TOCMCN6' will have dubbing service 'TOCMCCDN3_1' with 'Cancelled' in Traffic
And login with details of 'TOCMC1_email'
And wait till order item with clockNumber 'TOCMCN6' has a5 view status 'Cancelled' in Traffic for destination 'Airdate Traffic Services' For Clones
And wait till order item with clockNumber 'TOCMCN6' has a5 view status 'Cancelled' in Traffic for destination 'CBC Vancouver' For Clones
And login with details of 'trafficManager'
And wait till order list will be loaded
Then I 'should' see below information on traffic order page for clock 'TOCMCN6':
| Order Item Status | Order Status |
| Cancelled         | Completed    |


Scenario: Check that qcd only asset when cancelled order status is completed and Order Item status is cancelled
Meta:@traffic
Given logged in with details of 'TOCMC1_email'
And uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser| Brand    | Sub Brand |Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination             |
| automated test info    | TOCMCAR1    | TOCMCBR1 | TOCMCSB1  | TOCMCPR1 | TOCMCC1   | TOCMCCN_5     | 20       | 1           | 12/14/2022     |   Already Supplied | HD 1080i 25fps | CAGSTT1   |TV Bayern Media:Express |
When I open order item with following clock number 'TOCMCCN_5'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| TOCMC12 |TOCMC12 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TOCMCCN_5' to A4
When ingested assests through A5 with following fields:
 | agencyName      | clockNumber    |
 | TOCMC1          | TOCMCCN_5       |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TOCMCCN_5' will be available in Traffic
And wait till order with clockNumber 'TOCMCCN_5' will have next status 'Completed' in Traffic
And wait till order item with clockNumber 'TOCMCCN_5' will have next status 'TVC Ingested OK' in Traffic
And wait till order item with clockNumber 'TOCMCCN_5' will have A5 view status 'At Destination' in Traffic for destination 'TV Bayern Media'
And enter search criteria 'TOCMCCN_5' in simple search form on Traffic Order List page
And am on order details page of clockNumber 'TOCMCCN_5'
And open order item details page with clockNumber 'TOCMCCN_5'
And wait for '5' seconds
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order with clockNumber 'TOCMCCN_5' will have next status 'Completed' in Traffic
And wait till order item with clockNumber 'TOCMCCN_5' will have next status 'Cancelled' in Traffic
And wait till order item with clockNumber 'TOCMCCN_5' will have A5 view status 'At Destination' in Traffic for destination 'TV Bayern Media'
And enter search criteria 'TOCMCCN_5' in simple search form on Traffic Order List page
Then I 'should' see below information on traffic order page for clock 'TOCMCCN_5':
| Order Item Status | Order Status |
| Cancelled         | Completed    |

Scenario: Check the when order created  with ingest is cancelled the Order Status shows as completed and Order Item Status and Additional Service status is also cancelled
Meta:@traffic
Given logged in with details of 'TOCMC1_email'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                                    | Motivnummer  |
| automated test info    | TOCMCAR1    | TOCMCBR1 | TOCMCSB1  | TOCMCPR1 | TOCMCC1   | TOCMCCN_1     | 20       | 10/14/2022     | HD 1080i 25fps | TOCMCT1 | Already Supplied   | Motorvision TV:Express;Travel Channel DE:Express | 1          |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |   Market            |
| Physical | TOCMCCDN3_1      | TOCMCN3_1    | TOCMCCD3_1      | TOCMCSA3_1     | TOCMCCC3_1 | TOCMCCPC3_1 | TOCMCCC3_1 | Republic of Ireland |
| Physical | TOCMCCDN3_2      | TOCMCN3_2    | TOCMCCD3_2      | TOCMCSA3_2     | TOCMCCC3_2 | TOCMCCPC3_2 | TOCMCCC3_2 | Republic of Ireland |
And create for 'tv' order with item clock number 'TOCMCCN_1' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard   | Express    |
| Data DVD | TOCMCCDN3_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | TOCMCCDN3_1 TOCMCN3_1 TOCMCCD3_1 TOCMCSA3_1 TOCMCCC3_1 TOCMCCPC3_1 TOCMCCC3_1 | automated test notes  | should     | should not |
| DVD      | TOCMCCDN3_2 | Auto-loop  | SD PAL 16x9    | Compile 2     | 2          | TOCMCCDN3_2 TOCMCN3_2 TOCMCCD3_2 TOCMCSA3_2 TOCMCSA3_2 TOCMCCC3_2 TOCMCCPC3_2 | automated test notes  | should not | should     |
And complete order contains item with clock number 'TOCMCCN_1' with following fields:
| Job Number  | PO Number   |
| TOCMJN      | TOCMPN      |
And wait for finish place order with following item clock number 'TOCMCCN_1' to A4
When I go to  Library page for collection 'Everything'NEWLIB
And I refresh the page
Then I 'should' see QCed assets with titles 'TOCMCT1' in the collection 'Everything'NEWLIB
When login with details of 'trafficManager'
And wait till order with clockNumber 'TOCMCCN_1' will be available in Traffic
And wait till order with clockNumber 'TOCMCCN_1' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TOCMCCN_1' will have next status 'New' in Traffic
And wait till order item with clockNumber 'TOCMCCN_1' will have A5 view status 'Order Placed' in Traffic for destination 'Motorvision TV'
And wait till order item with clockNumber 'TOCMCCN_1' will have A5 view status 'Order Placed' in Traffic for destination 'Travel Channel DE'
And wait till order item with clockNumber 'TOCMCCN_1' will have dubbing service 'TOCMCCDN3_1' with 'New' in Traffic
And wait till order item with clockNumber 'TOCMCCN_1' will have dubbing service 'TOCMCCDN3_2' with 'New' in Traffic
And I amon order item details page of clockNumber 'TOCMCCN_1'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order with clockNumber 'TOCMCCN_1' will have next status 'Completed' in Traffic
And wait till order item with clockNumber 'TOCMCCN_1' will have next status 'Cancelled' in Traffic
And wait till order item with clockNumber 'TOCMCCN_1' will have A5 view status 'Cancelled' in Traffic for destination 'Motorvision TV'
And wait till order item with clockNumber 'TOCMCCN_1' will have A5 view status 'Cancelled' in Traffic for destination 'Travel Channel DE'
And wait till order item with clockNumber 'TOCMCCN_1' will have dubbing service 'TOCMCCDN3_1' with 'Cancelled' in Traffic
And wait till order item with clockNumber 'TOCMCCN_1' will have dubbing service 'TOCMCCDN3_2' with 'Cancelled' in Traffic
When login with details of 'TOCMC1_email'
And I go to  Library page for collection 'Everything'NEWLIB
And I refresh the page
Then I 'should not' see QCed assets with titles 'TOCMCT1' in the collection 'Everything'NEWLIB



Scenario: Check that when an order ingested is cancelled the Order Status shows as completed and Order Item Status and Additional Service status is also cancelled
Meta:@traffic
Given logged in with details of 'TOCMC1_email'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                                    | Motivnummer  |
| automated test info    | TOCMCAR1    | TOCMCBR1 | TOCMCSB1  | TOCMCPR1 | TOCMCC1   | TOCMCCN_2     | 20       | 10/14/2022     | HD 1080i 25fps | TOCMCT2 | Already Supplied   | MDF 1:Express;Travel Channel DE:Express | 1          |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |   Market            |
| Physical | TOCMCCDN3_1      | TOCMCN3_1    | TOCMCCD3_1      | TOCMCSA3_1     | TOCMCCC3_1 | TOCMCCPC3_1 | TOCMCCC3_1 | Republic of Ireland |
| Physical | TOCMCCDN3_2      | TOCMCN3_2    | TOCMCCD3_2      | TOCMCSA3_2     | TOCMCCC3_2 | TOCMCCPC3_2 | TOCMCCC3_2 | Republic of Ireland |
And create for 'tv' order with item clock number 'TOCMCCN_2' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard   | Express    |
| Data DVD | TOCMCCDN3_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | TOCMCCDN3_1 TOCMCN3_1 TOCMCCD3_1 TOCMCSA3_1 TOCMCCC3_1 TOCMCCPC3_1 TOCMCCC3_1 | automated test notes  | should     | should not |
| DVD      | TOCMCCDN3_2 | Auto-loop  | SD PAL 16x9    | Compile 2     | 2          | TOCMCCDN3_2 TOCMCN3_2 TOCMCCD3_2 TOCMCSA3_2 TOCMCSA3_2 TOCMCCC3_2 TOCMCCPC3_2 | automated test notes  | should not | should     |
And complete order contains item with clock number 'TOCMCCN_2' with following fields:
| Job Number  | PO Number   |
| TOCMJN      | TOCMPN      |
When ingested assests through A5 with following fields:
 | agencyName      | clockNumber    |
 | TOCMC1          | TOCMCCN_2       |
And waited for finish place order with following item clock number 'TOCMCCN_2' to A4
And I go to  Library page for collection 'Everything'NEWLIB
And I refresh the page
Then I 'should' see QCed assets with titles 'TOCMCT2' in the collection 'Everything'NEWLIB
When login with details of 'trafficManager'
And wait till order with clockNumber 'TOCMCCN_2' will be available in Traffic
And wait till order with clockNumber 'TOCMCCN_2' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TOCMCCN_2' will have next status 'TVC Ingested OK' in Traffic
And wait till order item with clockNumber 'TOCMCCN_2' will have A5 view status 'Passed QC' in Traffic for destination 'MDF 1'
And wait till order item with clockNumber 'TOCMCCN_2' will have A5 view status 'At Destination' in Traffic for destination 'Travel Channel DE'
And wait till order item with clockNumber 'TOCMCCN_2' will have dubbing service 'TOCMCCDN3_1' with 'New' in Traffic
And wait till order item with clockNumber 'TOCMCCN_2' will have dubbing service 'TOCMCCDN3_2' with 'New' in Traffic
And am on order details page of clockNumber 'TOCMCCN_2'
When select 'Transfer Complete' for the following dubbing Service 'Data DVD' for Clock Number 'TOCMCCN_2':
| date  | hh  |  mm   |
|Today  | 10  |  10   |
And I amon order item details page of clockNumber 'TOCMCCN_2'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order item with clockNumber 'TOCMCCN_2' will have next status 'Cancelled' in Traffic
And wait till order with clockNumber 'TOCMCCN_2' will have next status 'Completed' in Traffic
And wait till order item with clockNumber 'TOCMCCN_2' will have A5 view status 'Cancelled' in Traffic for destination 'MDF 1'
And wait till order item with clockNumber 'TOCMCCN_2' will have A5 view status 'At Destination' in Traffic for destination 'Travel Channel DE'
And wait till order item with clockNumber 'TOCMCCN_2' will have dubbing service 'TOCMCCDN3_1' with 'Transfer Complete' in Traffic
And wait till order item with clockNumber 'TOCMCCN_2' will have dubbing service 'TOCMCCDN3_2' with 'Cancelled' in Traffic
When login with details of 'TOCMC1_email'
And I go to  Library page for collection 'Everything'NEWLIB
And I refresh the page
Then I 'should not' see QCed assets with titles 'TOCMCT2' in the collection 'Everything'NEWLIB



Scenario: Check that when an order sent to few regular destinations and additonal services is ingested and asset saved in library, if cancelled the order is completed
Meta:@traffic
Given logged in with details of 'TOCMC1_email'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                                    | Motivnummer  |
| automated test info    | TOCMCAR1    | TOCMCBR1 | TOCMCSB1  | TOCMCPR1 | TOCMCC1   | TOCMCCN_3     | 20       | 10/14/2022     | HD 1080i 25fps | TOCMCT3 | Already Supplied   | Motorvision TV:Express;Travel Channel DE:Express | 1          |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |   Market            |
| Physical | TOCMCCDN3_1      | TOCMCN3_1    | TOCMCCD3_1      | TOCMCSA3_1     | TOCMCCC3_1 | TOCMCCPC3_1 | TOCMCCC3_1 | Republic of Ireland |
| Physical | TOCMCCDN3_2      | TOCMCN3_2    | TOCMCCD3_2      | TOCMCSA3_2     | TOCMCCC3_2 | TOCMCCPC3_2 | TOCMCCC3_2 | Republic of Ireland |
And create for 'tv' order with item clock number 'TOCMCCN_3' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard   | Express    |
| Data DVD | TOCMCCDN3_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | TOCMCCDN3_1 TOCMCN3_1 TOCMCCD3_1 TOCMCSA3_1 TOCMCCC3_1 TOCMCCPC3_1 TOCMCCC3_1 | automated test notes  | should     | should not |
| DVD      | TOCMCCDN3_2 | Auto-loop  | SD PAL 16x9    | Compile 2     | 2          | TOCMCCDN3_2 TOCMCN3_2 TOCMCCD3_2 TOCMCSA3_2 TOCMCSA3_2 TOCMCCC3_2 TOCMCCPC3_2 | automated test notes  | should not | should     |
And complete order contains item with clock number 'TOCMCCN_3' with following fields:
| Job Number  | PO Number   |
| TOCMJN      | TOCMPN      |
And wait for finish place order with following item clock number 'TOCMCCN_3' to A4
When ingested assests through A5 with following fields:
 | agencyName      | clockNumber    |
 | TOCMC1          | TOCMCCN_3       |
And I go to  Library page for collection 'Everything'NEWLIB
And I refresh the page
Then I 'should' see QCed assets with titles 'TOCMCT3' in the collection 'Everything'NEWLIB
When login with details of 'trafficManager'
And wait till order with clockNumber 'TOCMCCN_3' will be available in Traffic
And wait till order with clockNumber 'TOCMCCN_3' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TOCMCCN_3' will have A5 view status 'At Destination' in Traffic for destination 'Motorvision TV'
And wait till order item with clockNumber 'TOCMCCN_3' will have A5 view status 'At Destination' in Traffic for destination 'Travel Channel DE'
And wait till order item with clockNumber 'TOCMCCN_3' will have dubbing service 'TOCMCCDN3_1' with 'New' in Traffic
And wait till order item with clockNumber 'TOCMCCN_3' will have dubbing service 'TOCMCCDN3_2' with 'New' in Traffic
And am on order details page of clockNumber 'TOCMCCN_3'
When select 'Transfer Complete' for the following dubbing Service 'Data DVD' for Clock Number 'TOCMCCN_3':
| date  | hh  |  mm   |
|Today  | 10  |  10   |
And select 'Transfer Complete' for the following dubbing Service 'DVD' for Clock Number 'TOCMCCN_3':
| date  | hh  |  mm   |
|Today  | 10  |  10   |
And wait till order item with clockNumber 'TOCMCCN_3' will have dubbing service 'TOCMCCDN3_1' with 'Transfer Complete' in Traffic
And wait till order item with clockNumber 'TOCMCCN_3' will have dubbing service 'TOCMCCDN3_2' with 'Transfer Complete' in Traffic
And I amon order item details page of clockNumber 'TOCMCCN_3'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order item with clockNumber 'TOCMCCN_3' will have A5 view status 'At Destination' in Traffic for destination 'Motorvision TV'
And wait till order item with clockNumber 'TOCMCCN_3' will have A5 view status 'At Destination' in Traffic for destination 'Travel Channel DE'
And wait till order item with clockNumber 'TOCMCCN_3' will have dubbing service 'TOCMCCDN3_1' with 'Transfer Complete' in Traffic
And wait till order item with clockNumber 'TOCMCCN_3' will have dubbing service 'TOCMCCDN3_2' with 'Transfer Complete' in Traffic
When login with details of 'TOCMC1_email'
And I go to  Library page for collection 'Everything'NEWLIB
And I refresh the page
Then I 'should not' see QCed assets with titles 'TOCMCT3' in the collection 'Everything'NEWLIB


Scenario: Check that when order created using qc'd ingested asset along with additional destination is cancelled then order status is completed and Order Item status is cancelled
Meta:@traffic
Given logged in with details of 'TOCMC1_email'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser| Brand    | Sub Brand |Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination             |
| automated test info    | TOCMCAR1    | TOCMCBR1 | TOCMCSB1  | TOCMCPR1 | TOCMCC1   | CAGSCN_2     | 20       | 1           | 12/14/2022     |   Already Supplied | HD 1080i 25fps | CAGSTT1   |TV Bayern Media:Express;MDF 1:Express  |
And complete order contains item with clock number 'CAGSCN_2' with following fields:
| Job Number  | PO Number   |
| CAGSJN      | CAGSPN      |
And wait for finish place order with following item clock number 'CAGSCN_2' to A4
When ingested assests through A5 with following fields:
 | agencyName      | clockNumber    |
 | TOCMC1   | CAGSCN_2       |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser| Brand    | Sub Brand |Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination             |
| automated test info    | TOCMCAR1    | TOCMCBR1 | TOCMCSB1  | TOCMCPR1 | TOCMCC1| CAGSCN_3     | 20       | 1           | 12/14/2022     |   Already Supplied | HD 1080i 25fps | CAGSTT31   |MDF 1:Express;Travel Channel DE:Express  |
And created additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City        | Post Code    | Country     |        Market       |
| Physical | OTVMASCDN3_3     | OTVMASCCnN3_3 | OTVMASCCD3_3    | OTVMASCSA3_3   | OTVMASCC3_3 | OTVMASCPC3_3 | OTVMASCC3_3 | Republic of Ireland |
| Physical | OTVMASCDN3_4     | OTVMASCCnN3_4 | OTVMASCCD3_4    | OTVMASCSA3_4   | OTVMASCC3_4 | OTVMASCPC3_4 | OTVMASCC3_4 | Republic of Ireland |
And created for 'tv' order with item clock number 'CAGSCN_3' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASCDN3_3 | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVMASCDN3_3 OTVMASCCnN3_3 OTVMASCCD3_3 OTVMASCSA3_3 OTVMASCC3_3 OTVMASCPC3_3 OTVMASCC3_3 | automated test notes  | should     | should not |
| DVD      | OTVMASCDN3_4 | Auto-loop  | SD PAL 16x9    | Compile 2     | 2          | OTVMASCDN3_4 OTVMASCCnN3_4 OTVMASCCD3_4 OTVMASCSA3_4 OTVMASCC3_4 OTVMASCPC3_4 OTVMASCC3_4 | automated test notes  | should not | should     |
And I open order item with following clock number 'CAGSCN_3'
And add to order for order item at Add media to your order form following qc assets 'CAGSTT1'
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| CAGSJN1    | CAGSPO1   |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'CAGSCN_2' to A4
And I go to  Library page for collection 'My Assets'NEWLIB
And I refresh the page
Then I 'should' see QCed assets with titles 'CAGSTT1' in the collection 'My Assets'NEWLIB
When login with details of 'trafficManager'
And wait till order with clockNumber 'CAGSCN_2' will be available in Traffic
And wait till order item with clockNumber 'CAGSCN_2' will have A5 view status 'Passed QC' in Traffic for destination 'MDF 1'
And wait till order item with clockNumber 'CAGSCN_2' will have A5 view status 'At Destination' in Traffic for destination 'Travel Channel DE'
And wait till order item with clockNumber 'CAGSCN_2' will have dubbing service 'OTVMASCDN3_3' with 'New' in Traffic
And wait till order item with clockNumber 'CAGSCN_2' will have dubbing service 'OTVMASCDN3_4' with 'New' in Traffic
And wait till order with clockNumber 'CAGSCN_2' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'CAGSCN_2' will have next status 'TVC Ingested OK' in Traffic
And am on order details page of clockNumber 'CAGSCN_2'
When select 'Transfer Complete' for the following dubbing Service 'Data DVD' for Clock Number 'CAGSCN_2':
| date  | hh  |  mm   |
|Today  | 10  |  10   |
And I amon order item details page of clockNumber 'CAGSCN_2'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order item with clockNumber 'CAGSCN_2' will have next status 'Cancelled' in Traffic
And wait till order with clockNumber 'CAGSCN_2' will have next status 'Completed' in Traffic
And wait till order item with clockNumber 'CAGSCN_2' will have dubbing service 'OTVMASCDN3_3' with 'Transfer Complete' in Traffic
And wait till order item with clockNumber 'CAGSCN_2' will have dubbing service 'OTVMASCDN3_4' with 'Cancelled' in Traffic
And wait till order item with clockNumber 'CAGSCN_2' will have A5 view status 'Cancelled' in Traffic for destination 'MDF 1'
And wait till order item with clockNumber 'CAGSCN_2' will have A5 view status 'At Destination' in Traffic for destination 'Travel Channel DE'
And select 'All' tab in Traffic UI
Then I 'should' see below information on traffic order page for clock 'CAGSCN_2':
| Order Item Status | Order Status |
| Cancelled         | Completed    |
When login with details of 'TOCMC1_email'
And I go to  Library page for collection 'Everything'NEWLIB
And I refresh the page
Then I 'should not' see QCed assets with titles 'CAGSTT1' in the collection 'Everything'NEWLIB


Scenario: Check that qcd only order when cancelled order status is completed and Order Item status is cancelled
Meta:@traffic
Given logged in with details of 'TOCMC1_email'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser| Brand    | Sub Brand |Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination             |
| automated test info    | TOCMCAR1    | TOCMCBR1 | TOCMCSB1  | TOCMCPR1 | TOCMCC1   | TOCMCCN_4     | 20       | 1           | 12/14/2022     |   Already Supplied | HD 1080i 25fps | CAGSTT1   |TV Bayern Media:Express |
When I open order item with following clock number 'TOCMCCN_4'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| TOCMC12 |TOCMC12 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TOCMCCN_4' to A4
When login with details of 'trafficManager'
And wait till order with clockNumber 'TOCMCCN_4' will have next status 'In Progress' in Traffic
And wait till order item with clockNumber 'TOCMCCN_4' will have next status 'New' in Traffic
Then check that order item with clockNumber 'TOCMCCN_4' has ingest view status 'Order Placed' in Traffic
When I amon order item details page of clockNumber 'TOCMCCN_4'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And open Traffic Order List page
And wait till order with clockNumber 'TOCMCCN_4' will have next status 'Completed' in Traffic
And wait till order item with clockNumber 'TOCMCCN_4' will have next status 'Cancelled' in Traffic
Then check that order item with clockNumber 'TOCMCCN_4' has ingest view status 'Cancelled' in Traffic
