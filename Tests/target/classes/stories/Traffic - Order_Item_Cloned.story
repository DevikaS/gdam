Feature:          New field Cloned should show if order item was cloned during prder placement
Narrative:
In order to
As a           AgencyAdmin
I want to         see cloned field with respective value if order item was cloned during prder placement

Lifecycle:
Before:
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    |


Scenario: Check that Cloned field is updated with Yes at order level and destination level when a clock is sent to mix of SD and HD destination
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC1    | TMCCN1      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT1 |           |
When I open order item with following clock number 'TMCCN1'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And fill Search Stations field by value 'CBC Vancouver' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)   |
| CBC Vancouver |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| TMCJN1    | TMCPO1  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TMCCN1' to A4
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TMCCN1' will be available in Traffic
And enter search criteria 'TMCCN1' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN1' in traffic list that have following data:
| Cloned|
| Yes    |
And expand all orders on Traffic Order List page
And I should see order item details for clones in traffic order list that have following data:
|Destination             | Cloned |
|Airdate Traffic Services| Yes    |
|CBC Vancouver           | Yes    |
When I open order details with clockNumber 'TMCCN1' from Traffic UI
And I refresh the page without delay
Then I should see following metadata on order details page in traffic:
| Cloned |
| Yes         |


Scenario: Check that Cloned field is updated with No at order level and item level when a clock is sent to normal destination
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC2   | TMCCN2      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT2 | Motorvision TV:Express;Travel Channel DE:Express          |1|
And complete order contains item with clock number 'TMCCN2' with following fields:
| Job Number  | PO Number |
| TMCJN2   | TMCPO2 |
And wait for finish place order with following item clock number 'TMCCN2' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And waited till order with clockNumber 'TMCCN2' will be available in Traffic
And entered search criteria 'TMCCN2' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN2' in traffic list that have following data:
| Cloned|
| No    |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMCCN2' in traffic order list that have following data:
|     Cloned    |
|      No                  |



Scenario: Check that Cloned field is updated with No at order level and item level when a clock is sent to either SD or HD
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC3  | TMCCN3      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT3 | Disney Germany SD:Standard         |1|
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC4   | TMCCN4      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT4 | Disney Germany HD:Standard          |1|
And complete order contains item with clock number 'TMCCN3' with following fields:
| Job Number  | PO Number |
| TMCJN3   | TMCPO3 |
And complete order contains item with clock number 'TMCCN4' with following fields:
| Job Number  | PO Number |
| TMCJN4   | TMCPO4 |
And wait for finish place order with following item clock number 'TMCCN3' to A4
And wait for finish place order with following item clock number 'TMCCN4' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And waited till order with clockNumber 'TMCCN3' will be available in Traffic
And waited till order with clockNumber 'TMCCN4' will be available in Traffic
And entered search criteria 'TMCCN3' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN3' in traffic list that have following data:
| Cloned|
| No    |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMCCN3' in traffic order list that have following data:
|     Cloned    |
|      No                  |
When enter search criteria 'TMCCN4' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN4' in traffic list that have following data:
| Cloned|
| No    |
And I refresh the page
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMCCN4' in traffic order list that have following data:
|     Cloned    |
|      No                  |


Scenario: Check that Cloned field is updated with Yes at order level,No for SD destination and Yes for HD destination when SD asset is sent to mix of SD and HD
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC5  | TMCCN5      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT5 | Disney Germany SD:Standard         |1|
And complete order contains item with clock number 'TMCCN5' with following fields:
| Job Number  | PO Number |
| TMCJN5   | TMCPO5 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC6   | TMCCN6      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT6 | Disney Germany HD:Standard;Disney Germany SD:Standard         |1|
And add to 'tv' order item with clock number 'TMCCN6' following qc asset 'TMCT5' of collection 'My Assets'
And complete order contains item with clock number 'TMCCN5' with following fields:
| Job Number  | PO Number |
| TMCJN6   | TMCPO6 |
And wait for finish place order with following item clock number 'TMCCN5' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And waited till order with clockNumber 'TMCCN5' will be available in Traffic
And I select all from dropdown on Traffic Order List page
And entered search criteria 'TMCPO6' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN5' in traffic list that have following data:
| Cloned|
| Yes    |
And expand all orders on Traffic Order List page
And I should see order item details for clones in traffic order list that have following data:
|Destination             | Cloned |
|Disney Germany SD| No    |
|Disney Germany HD          | Yes    |
When I open order details with clockNumber 'TMCCN5' from Traffic UI
And I refresh the page
Then I should see following metadata on order details page in traffic:
| Cloned |
| Yes         |



Scenario: Check that Cloned field is updated with Yes at order level,Yes for SD destination and No for HD destination when HD asset is sent to mix of SD and HD
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC7 | TMCCN7      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT7 | Disney Germany HD:Standard         |1|
And complete order contains item with clock number 'TMCCN7' with following fields:
| Job Number  | PO Number |
| TMCJN7   | TMCPO7 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC8   | TMCCN8      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT8 | Disney Germany HD:Standard;Disney Germany SD:Standard         |1|
And add to 'tv' order item with clock number 'TMCCN8' following qc asset 'TMCT7' of collection 'My Assets'
And complete order contains item with clock number 'TMCCN7' with following fields:
| Job Number  | PO Number |
| TMCJN8   | TMCPO8 |
And wait for finish place order with following item clock number 'TMCCN7' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And waited till order with clockNumber 'TMCCN7' will be available in Traffic
And I select all from dropdown on Traffic Order List page
And entered search criteria 'TMCPO8' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN7' in traffic list that have following data:
| Cloned|
| Yes    |
And expand all orders on Traffic Order List page
And I should see order item details for clones in traffic order list that have following data:
|Destination             | Cloned |
|Disney Germany SD| Yes    |
|Disney Germany HD          | No    |


Scenario: Check that Cloned field is updated with No at order level and item level  when SD asset is sent to SD destination
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC9 | TMCCN9      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT9 | Disney Germany SD:Standard         |1|
And complete order contains item with clock number 'TMCCN9' with following fields:
| Job Number  | PO Number |
| TMCJN9  | TMCPO9 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC10   | TMCCN10      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT10 | Disney Germany SD:Standard         |1|
And add to 'tv' order item with clock number 'TMCCN10' following qc asset 'TMCT9' of collection 'My Assets'
And complete order contains item with clock number 'TMCCN9' with following fields:
| Job Number  | PO Number |
| TMCJN10   | TMCPO10 |
And wait for finish place order with following item clock number 'TMCCN9' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And waited till order with clockNumber 'TMCCN9' will be available in Traffic
And I select all from dropdown on Traffic Order List page
And entered search criteria 'TMCPO10' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN9' in traffic list that have following data:
| Cloned|Order Item Status|
| No    |New|
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMCCN9' in traffic order list that have following data:
|     Cloned    |Order Item Status|
|      No                  |New|
When I open order details with clockNumber 'TMCCN9' from Traffic UI
And I refresh the page
Then I should see following metadata on order details page in traffic:
| Cloned |
| No         |


Scenario: Check that Cloned field is updated with No at order level and item level  when SD asset is sent to HD destination
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC11 | TMCCN11     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT11 | Disney Germany SD:Standard         |1|
And complete order contains item with clock number 'TMCCN11' with following fields:
| Job Number  | PO Number |
| TMCJN11  | TMCPO11 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC12   | TMCCN12      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT12 | Disney Germany HD:Standard         |1|
And add to 'tv' order item with clock number 'TMCCN12' following qc asset 'TMCT11' of collection 'My Assets'
And complete order contains item with clock number 'TMCCN11' with following fields:
| Job Number  | PO Number |
| TMCJN12  | TMCPO12 |
And wait for finish place order with following item clock number 'TMCCN11' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And waited till order with clockNumber 'TMCCN11' will be available in Traffic
And I select all from dropdown on Traffic Order List page
And entered search criteria 'TMCPO12' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN11' in traffic list that have following data:
| Cloned|Order Item Status|
| Yes    |New|
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMCCN11' in traffic order list that have following data:
|     Cloned    |Order Item Status|
|      Yes                  |New|


Scenario: Check that Cloned field is updated with Yes at order level and item level  when HD asset is sent to SD destination
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC13 | TMCCN13     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT13 | Disney Germany HD:Standard         |1|
And complete order contains item with clock number 'TMCCN13' with following fields:
| Job Number  | PO Number |
| TMCJN13  | TMCPO13 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC14   | TMCCN14      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT14 | Disney Germany SD:Standard         |1|
And add to 'tv' order item with clock number 'TMCCN14' following qc asset 'TMCT13' of collection 'My Assets'
And complete order contains item with clock number 'TMCCN13' with following fields:
| Job Number  | PO Number |
| TMCJN14  | TMCPO14 |
And wait for finish place order with following item clock number 'TMCCN13' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And waited till order with clockNumber 'TMCCN13' will be available in Traffic
And I select all from dropdown on Traffic Order List page
And entered search criteria 'TMCPO14' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN13' in traffic list that have following data:
| Cloned|Order Item Status|
| Yes    |New|
And expand all orders on Traffic Order List page
And I should see order item with clockNumber 'TMCCN13' in traffic order list that have following data:
|     Cloned    |Order Item Status|
|      Yes                  |New|


Scenario: Check that Cloned field is updated with No at order level and item level  when non QCed asset is sent to either SD or HD
!--This will fail until NIR-1021 is fixed.Remove this comment once passed
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/<Asset>  |
And waiting while transcoding is finished in collection 'My Assets' for asset '<Asset>'NEWLIB
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | <Campaign> | <Clock>      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | <Title> | <Destination>       |1|
And add to 'tv' order item with clock number '<Clock>' following asset '<Asset>' of collection 'My Assets'
And complete order contains item with clock number '<Clock>' with following fields:
| Job Number  | PO Number |
| <Job Number> | <PO Number> |
And wait for finish place order with following item clock number '<Clock>' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And waited till order with clockNumber '<Clock>' will be available in Traffic
And entered search criteria '<Clock>' in simple search form on Traffic Order List page
Then I should see order with clockNumber '<Clock>' in traffic list that have following data:
| Cloned|
| <Cloned_At_Order_Level>   |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber '<Clock>' in traffic order list that have following data:
|     Cloned    |
|      <Cloned_At_Item_Level>                  |

Examples:
|Campaign|Clock|Title |Cloned_At_Order_Level|Cloned_At_Item_Level|Job Number|PO Number|Destination|Asset|
|TMCC15   |TMCCN15    |TMCT15 |No                  |No                  |TMCJN15   |TMCPO15  |Disney Germany SD:Standard|Fish11-Ad.mov|
|TMCC16   |TMCCN16    |TMCT16 |No                  |No                  |TMCJN16   |TMCPO16  |Disney Germany HD:Standard|Fish12-Ad.mov|



Scenario: Check that Cloned field is updated with Yes at order level and destination level  when non QCed asset is sent to mix of SD and HD
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish10-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish10-Ad.mov'NEWLIB
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| automated test info    | TMCAR1     | TMCBR1     | TMCSB1     | TMCP1    | TMCC17 | TMCCN17      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCT17 | Disney Germany SD:Standard;Disney Germany HD:Standard      |1|
And add to 'tv' order item with clock number 'TMCCN17' following asset 'Fish10-Ad.mov' of collection 'My Assets'
And complete order contains item with clock number 'TMCCN17' with following fields:
| Job Number  | PO Number |
| TMCJN17| TMCPO17|
And wait for finish place order with following item clock number 'TMCCN17' to A4
And logged in with details of 'trafficManager'
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And waited till order with clockNumber 'TMCCN17' will be available in Traffic
And entered search criteria 'TMCCN17' in simple search form on Traffic Order List page
Then I should see order with clockNumber 'TMCCN17' in traffic list that have following data:
| Cloned|Order Item Status|
| Yes    |Media Received - Awaiting|
And expand all orders on Traffic Order List page
And I should see order item details for clones in traffic order list that have following data:
|Destination             | Cloned |Order Item Status|
|Disney Germany SD       | Yes    |Media Received - Awaiting|
|Disney Germany HD       | Yes    |Media Received - Awaiting|
When I open order details with clockNumber 'TMCCN17' from Traffic UI
And I refresh the page
Then I should see following metadata on order details page in traffic:
| Cloned |
| Yes         |


