Feature: Traffic Create new tab
Narrative:
In order to
As a              AgencyAdmin
I want to check filtering in Traffic


Lifecycle:
Before:
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TCNTAR1    | TCNTSB1 | TCNTSBR1  | TCNTPR1 |
| TCNTAR2    | TCNTSB2 | TCNTSBR2  | TCNTPR2 |
And updated the following agency:
| Name                        | Labels                                    |
| BroadCasterAgencyNoApproval | MENA,dubbing_services,nVerge,FTP,Physical |

Scenario: Check that Traffic Manager can create tab with specific filter (Order Item Status)
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format          | Title     | Destination     |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber2>| 20       |      1      | 12/14/2022     |   Already Supplied | HD 1080i 25fps  | TTVBTVST2 | kino.de:Express |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And waited for finish place order with following item clock number '<ClockNumber2>' to A4
And ingested assests through A5 with following fields:
 | agencyName | clockNumber    |
 | DefaultAgency     | <ClockNumber2> |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber2>' will have next status 'TVC Ingested OK' in Traffic
And open Traffic Order List page
And I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |
| <Condition> |   Match        | <Value> |
And wait till order list will be loaded
And wait for '8' seconds
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic

Examples:
| ClockNumber1 | ClockNumber2  | Condition         | Value             | TabName         | TabType             | AvailableOrder  | NotAvailableOrderItem |
| TCNSCN3_2    | TCNSCN3_1     | Order Item Status | TVC Ingested OK   | OrderItemStatus | Order Item (Clock)  |  TCNSCN3_1      | TCNSCN3_2             |



Scenario: Check that Traffic Manager can create tab with specific filter (Order Status)
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format          | Title     | Destination     |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber2>| 20       |      1      | 12/14/2022     |   Already Supplied | HD 1080i 25fps  | TTVBTVST2 | kino.de:Express |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And waited for finish place order with following item clock number '<ClockNumber2>' to A4
And ingested assests through A5 with following fields:
 | agencyName     | clockNumber    |
 | DefaultAgency  | <ClockNumber2> |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will have next status 'Completed' in Traffic
And open Traffic Order List page
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |
| <Condition> |   Match        | <Value> |
And wait till order list will be loaded
And enter search criteria '<AvailableOrder>' in simple search form on Traffic Order List page
Then I 'should' see order '<AvailableOrder>' in order list at Traffic UI
When enter search criteria '<NotAvailableOrderItem>' in simple search form on Traffic Order List page
Then 'should not' see order '<NotAvailableOrderItem>' in order list at Traffic UI

Examples:
| ClockNumber1 | ClockNumber2  | Condition        | Value             | TabName      | TabType   | AvailableOrder  | NotAvailableOrderItem |
| TCNSCN2_2    | TCNSCN2_1     | Order Status     | Completed         | OrderStatus  | Order     |  TCNSCN2_1      | TCNSCN2_2             |



Scenario: Check that Traffic Manager can create tab with specific filter (Order Status + Market)
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And created 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clave | Clock Number | Watermarking Required | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination       |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 | Test  |<ClockNumber2>|         No            |  20      | 12/14/2022     |   Already Supplied | HD 1080i 25fps | TTVBTVST2 | Antena 3:Standard |
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | BSkyB Green Button:Standard |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And I wait till order with clockNumber '<ClockNumber1>' will have next status 'In Progress' in Traffic
And I wait till order with clockNumber '<ClockNumber2>' will have next status 'In Progress' in Traffic
And I wait till order with clockNumber '<ClockNumber3>' will have next status 'In Progress' in Traffic
And wait till order will be loaded in Traffic UI
And open create new tab popup and fill name '<TabName>' and type '<TabType>' and dataRange 'Today'
And add new conditions at the traffic create new tab pop up:
|  Condition   | Condition Type |  Value   | NewRule | Match | NewConditionAfterCurrent |
| <Condition1> |   Match        | <Value1> |         | Any   | Yes                      |
| <Condition1> |   Match        | <Value2> |         |       |                          |
| <Condition2> |   Match        | <Value3> |  Yes    | All   |                          |
And click save at the traffic create new tab pop up
And wait till order item list will be loaded in Traffic
When enter search criteria 'TCNSCN4_1' in simple search form on Traffic Order List page
Then I 'should' see order 'TCNSCN4_1' in order list at Traffic UI
When enter search criteria 'TCNSCN4_2' in simple search form on Traffic Order List page
Then I 'should' see order 'TCNSCN4_2' in order list at Traffic UI
When enter search criteria 'TCNSCN4_3' in simple search form on Traffic Order List page
Then 'should not' see order 'TCNSCN4_3' in order list at Traffic UI

Examples:
| ClockNumber1 | ClockNumber2  | ClockNumber3  | Condition1 | Condition2   | Value1  | Value2   | Value3      | TabName              | TabType             | AvailableOrder        | NotAvailableOrderItem |
| TCNSCN4_2    | TCNSCN4_1     | TCNSCN4_3     | Market     | Order Status | Spain   | Germany  | In Progress | OrderStatusAndMarket | Order               |  TCNSCN4_1,TCNSCN4_2  | TCNSCN4_3             |


Scenario: Check that Traffic Manager can share tab with others users in Business Unit
Meta: @traffic
Given I created users with following fields:
| Email      |           Role            | AgencyUnique |  Access  |
| TCNTU5_3    |       traffic.traffic.manager       |   IngestAgency      | adpath |
Given I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       |      1      | 06/16/2016     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber2>| 20       |      1      | 06/13/2016     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber3>| 20       | 06/14/2016     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber3>' will be available in Traffic
And on Traffic Order List page
And opened create new tab popup and fill name '<TabName>' and type '<TabType>' and dataRange 'Today'
And added new conditions at the traffic create new tab pop up:
|  Condition   | Condition Type |  Value   | NewRule | Match | NewConditionAfterCurrent |
| <Condition1> |   Match        | <Value1> |         | Any   | Yes                      |
| <Condition1> |   Match        | <Value2> |         |       |                          |
When select share tab option at the traffic create new tab pop up
And click save at the traffic create new tab pop up
And login as 'TCNTU5_3' of Agency 'IngestAgency'
And select '<TabName>' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait for '4' seconds
When enter search criteria 'TCNSCN6_2' in simple search form on Traffic Order Item List page
Then I 'should' see orderItems 'TCNSCN6_2' in order item list in Traffic
When enter search criteria 'TCNSCN6_1' in simple search form on Traffic Order Item List page
Then I 'should' see orderItems 'TCNSCN6_1' in order item list in Traffic
When enter search criteria 'TCNSCN6_3' in simple search form on Traffic Order Item List page
Then I 'should not' see orderItems 'TCNSCN6_3' in order item list in Traffic

Examples:
| ClockNumber1 | ClockNumber2  | ClockNumber3  | Condition1    | Value1     | Value2      | TabName     | TabType             | AvailableOrder       | NotAvailableOrderItem |
| TCNSCN6_1    | TCNSCN6_2     | TCNSCN6_3     | Clock Number  | TCNSCN6_1  | TCNSCN6_2   | SharedTab   | Order Item (Clock)  | TCNSCN6_2,TCNSCN6_1  | TCNSCN6_3             |


Scenario: Check that broadcast traffic manager can delete the newly created tab
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination      |Motivnummer|
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 |Motorvision TV:Express |1|
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order list will be loaded
And refresh the page
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |
| <Condition> |    Match       | <Value> |
When I delete the tab
Then I 'should not' see following tabs:
| Tab name    |
| <TabName>   |

Examples:
| ClockNumber1  | Condition  | Value          | TabName     | TabType  | AvailableOrder |
| TTVBTVSCN12_11 | Advertiser | TCNTAR1     | testDelete |   Order Item (Send)         |  TTVBTVSCN12_11 |


Scenario: Check that traffic manager can delete the newly created tab
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order list will be loaded
And refresh the page
And open create new tab popup and fill name '<TabName>' and type '<TabType>' and dataRange 'Today'
And add new conditions at the traffic create new tab pop up:
|  Condition   | Condition Type |  Value   | NewRule | Match | NewConditionAfterCurrent |
| <Condition1> |   Match        | <Value2> |         |       |                          |
And click save at the traffic create new tab pop up
And select '<TabName>' tab in Traffic UI
And pin '<TabName>' tab in Traffic UI
And wait till order list will be loaded
When I delete the tab
And wait for '5' seconds
Then I 'should not' see following tabs:
| Tab name    |
| <TabName>   |

Examples:
| ClockNumber1 | Condition1 |  Value2   |  TabName              | TabType             | AvailableOrder  |
| TCNSCN4_22    | Market     |  Germany  |  OrderStatusAndMarket | Order               |  TCNSCN4_22      |

Scenario: Check that Traffic Manager can create tab (Order with specific filter (Market) and later Update the rule to include Ingest location
Meta: @traffic
Given I created the following agency:
| Name       |    A4User     | AgencyType | Application Access |  Ingest Location  |
| TMCTILI    | DefaultA4User | Ingest     |      adpath        |                   |
| TMCTILA    | DefaultA4User | Advertiser |      ordering      | TMCTILI         |
And created users with following fields:
| Email     |           Role          | AgencyUnique |  Access  |
| TMCTILAU  |       agency.admin      |   TMCTILA  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TMCTILA':
| Advertiser | Brand      | Sub Brand  | Product   |
| TMCTILAR1  | TMCTILBR1  | TMCTILSB1  | TMCTILSP1 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                  | Motivnummer |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TMFDNBAST1 | Motorvision TV:Standard      |   1         |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number     | PO Number    |
| TMCTILTVS11   | TMCTILTVS11 |
And login with details of 'TMCTILAU'
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                  | Motivnummer |
| automated test info    | TMCTILAR1  | TMCTILBR1  | TMCTILSB1  | TMCTILSP1 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TMFDNBAST2 | Motorvision TV:Standard      |   1        |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TMCTILAR1  | TMCTILBR1  | TMCTILSB1  | TMCTILSP1 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TMFDNBAST3 | Talk Sport:Standard         |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number     | PO Number    |
| TMFDNDSTVS11   | TMFDNDSTVS11 |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number     | PO Number    |
| TMFDNDSTVS11   | TMFDNDSTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And wait till order list will be loaded
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value    |
| <Condition1> |   Match        | <Value1>   |
And wait till order item list will be loaded in Traffic
And wait for '4' seconds
Then I 'should' see order '<AvailableOrder>' in Traffic order list page
And I 'should not' see order '<NotAvailableOrderItem>' in Traffic order list page
When I Edit the tab
And update tab with new rule:
|  Condition   | Condition Type |  Value   |
| <Condition2> |   Match        |<Value2>  |
And wait till order item list will be loaded in Traffic
And wait for '4' seconds
Then I 'should' see order '<New_AvailableOrder>' in Traffic order list page
And I 'should not' see order '<New_NotAvailableOrderItem>' in Traffic order list page
When I Edit the tab
And I delete the rule with condition '<Condition2>'
And click save at the traffic create new tab pop up
And wait for '10' seconds
Then I 'should' see order '<AvailableOrder>' in Traffic order list page
And I 'should not' see order '<NotAvailableOrderItem>' in Traffic order list page



Examples:
| ClockNumber1   | ClockNumber2  | ClockNumber3  |Condition1        | Value1              |  Condition2           |  Value2            |TabName        | TabType            | AvailableOrder                      | NotAvailableOrderItem      |New_AvailableOrder     |New_NotAvailableOrderItem       |
| TMCTILCN_1     | TMCTILCN_2    | TMCTILCN_3    |Market            |  Germany            |  Ingest Location      | TMCTILI            |IngestTab      |  Order             |  TMCTILCN_1,TMCTILCN_2              | TMCTILCN_3                 | TMCTILCN_2            |TMCTILCN_1,TMCTILCN_3           |


Scenario: Check that Traffic Manager can create tab (Order Item Clock view) with specific filter (Market,Advertiser) and later Update the rule to delete Advertiser
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                | Motivnummer |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Facebook DE:Express         | 1           |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | Facebook DE:Standard        | 1           |
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | BSkyB Green Button:Standard  |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And waited for finish place order with following item clock number '<ClockNumber1>' to A4
And waited for finish place order with following item clock number '<ClockNumber2>' to A4
And waited for finish place order with following item clock number '<ClockNumber3>' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency    | <ClockNumber1>  |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And open Traffic Order List page
And wait till order list will be loaded
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value    |
| <Condition1> |   Match        | <Value1>   |
| <Condition2> |   Match        | <Value2>  |
And wait till order item list will be loaded in Traffic
And wait for '8' seconds
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic
When I Edit the tab
And I delete the rule with condition '<Condition2>'
And click save at the traffic create new tab pop up
And wait for '10' seconds
Then I 'should' see orderItems '<New_AvalilableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<New_NotAvailableOrderItem>' in order item list in Traffic

Examples:
| ClockNumber1     | ClockNumber2   |  ClockNumber3    | Condition1      | Value1      | Condition2        |  Value2    | TabName        | TabType           | AvailableOrder   | NotAvailableOrderItem    | New_AvalilableOrder   | New_NotAvailableOrderItem |
| TMDLACN_1        | TMDLACN_2      |  TMDLACN_3       |Market Country   | DE          | Advertiser        | TCNTAR1 | testAgencyCnty | Order Item Clock  |  TMDLACN_1        | TMDLACN_2,TMDLACN_3     | TMDLACN_2,TMDLACN_1   | TMDLACN_3              |
| TMDLACN_4        | TMDLACN_5      |  TMDLACN_6       |Destination Name | Facebook DE | Service Level     | Standard   | testService    | Order Item (Send)     |  TMDLACN_5        | TMDLACN_4,TMDLACN_6     | TMDLACN_4,TMDLACN_5   | TMDLACN_6              |
| TMDLACN_7        | TMDLACN_8      |  TMDLACN_9       |Destination Name | Facebook DE | Delivery Status   | Awaiting Station release   | testDelivery    | Order Item Send   |  TMDLACN_7       | TMDLACN_8,TMDLACN_9     | TMDLACN_7,TMDLACN_8   | TMDLACN_9              |


Scenario: Check that Traffic Manager can create tab (Order Item Send view) with specific filter (Market Country and Delivery status) and later Update the rule with Delivery Status
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                             | Motivnummer |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TMFDNDST1 | MDF 1:Standard;Motorvision TV:Standard   | 1          |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TMFDNDST2 | Travel Channel DE:Standard                |   1        |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TMFDNDST2 | Travel Channel DE:Express                |   1        |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number     | PO Number    |
| TMFDNDSTVS11   | TMFDNDSTVS11 |
And waited for finish place order with following item clock number '<ClockNumber1>' to A4
And waited for finish place order with following item clock number '<ClockNumber2>' to A4
When ingested assests through A5 with following fields:
 | agencyName       | clockNumber     |
 | DefaultAgency    | <ClockNumber1>  |
 | DefaultAgency    | <ClockNumber2>  |
 | DefaultAgency    | <ClockNumber3>  |
And login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber1>' will have A5 view status 'Passed QC' in Traffic
And select 'All' tab in Traffic UI
And wait till order item with clockNumber '<ClockNumber1>' with destination 'MDF 1' will have the next Destination Status 'New' in Traffic
And wait till order item with clockNumber '<ClockNumber2>' with destination 'Travel Channel DE' will have the next Destination Status 'Transfer Complete' in Traffic
And wait till order item with clockNumber '<ClockNumber3>' with destination 'Travel Channel DE' will have the next Destination Status 'Transfer Complete' in Traffic
And open Traffic Order List page
And wait till order list will be loaded
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value    |
| <Condition1> |   Match        | <Value1>   |
| <Condition2> |   Match        | <Value2>  |
And wait till order item list will be loaded in Traffic
And wait for '8' seconds
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic
When I Edit the tab
And I delete the rule with condition '<Condition2>'
And update tab with new rule:
|  Condition   | Condition Type |  Value     |
| <Condition3> |   Match        |  <Value3> |
And wait till order item list will be loaded in Traffic
And wait for '8' seconds
Then I 'should' see orderItems '<New_AvailableOrder>' in order item list in Traffic
When I Edit the tab
And update tab with new rule:
|  Condition   | Condition Type |  Value     |
| <Condition4> |   Does not match        | <Value4>   |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TMFDNDSCN_3' in simple search form on Traffic Order List page
Then I 'should' see orderItems 'TMFDNDSCN_3' in order item list in Traffic
When enter search criteria 'TMFDNDSCN_1' in simple search form on Traffic Order List page
Then I 'should not' see orderItems 'TMFDNDSCN_1' in order item list in Traffic
When enter search criteria 'TMFDNDSCN_2' in simple search form on Traffic Order List page
Then I 'should not' see orderItems 'TMFDNDSCN_2' in order item list in Traffic

Examples:
| ClockNumber1     | ClockNumber2   | ClockNumber3      |Condition1        | Value1  | Condition2       |  Value2               | Condition3   |  Value3   |Condition4    |  Value4      |TabName        | TabType            | AvailableOrder            | NotAvailableOrderItem                 |New_AvailableOrder        |
| TMFDNDSCN_1      | TMFDNDSCN_2    | TMFDNDSCN_3       |Market Country    |  DE     | Delivery Status  | New                   | Service Level | Express |Service Level | Standard     |DeliveryStat   | Order Item (Send)      |   TMFDNDSCN_1             | TMFDNDSCN_2,TMFDNDSCN_3               | TMFDNDSCN_3 |


Scenario: Check that Broadcast Traffic Manager can create tab with specific filter (Destination) and later Update the rule to include Broadcaster Approval status
Meta: @traffic
Given I updated the following agency:
| Name         | Escalation Enabled   | Approval Type | Proxy Approver     | Master Approver |
| BroadCasterAgencyTwoStage   |       true           |      two      |    broadcasterTrafficManagerTwo  | broadcasterTrafficManagerTwo  |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                  | Motivnummer |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TMFDNBAST1 | Motorvision TV:Standard      |   1        |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TMFDNBAST2 | Motorvision TV:Standard      |   1        |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TMFDNBAST3 | Facebook DE:Standard         |   1        |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number     | PO Number    |
| TMFDNDSTVS11   | TMFDNDSTVS11 |
And waited for finish place order with following item clock number '<ClockNumber1>' to A4
And waited for finish place order with following item clock number '<ClockNumber2>' to A4
And waited for finish place order with following item clock number '<ClockNumber3>' to A4
When ingested assests through A5 with following fields:
 | agencyName       | clockNumber     |
 | DefaultAgency    | <ClockNumber1>  |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And open Traffic Order List page
And refresh the page
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value    |
| <Condition1> |   Match        | <Value1>   |
And wait till order item list will be loaded in Traffic
And wait for '4' seconds
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic
When I Edit the tab
And wait for '2' seconds
And update tab with new rule:
|  Condition   | Condition Type |  Value   |
| <Condition2> |   Match        |<Value2>  |
And wait till order item list will be loaded in Traffic
And wait for '4' seconds
Then I 'should' see orderItems '<New_AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<New_NotAvailableOrderItem>' in order item list in Traffic

Examples:
| ClockNumber1     | ClockNumber2  | ClockNumber3  |Condition1        | Value1              |  Condition2                     |  Value2                  |TabName        | TabType            | AvailableOrder                      | NotAvailableOrderItem      |New_AvailableOrder       |New_NotAvailableOrderItem           |
| TMFDNBASCN_1     | TMFDNBASCN_2  | TMFDNBASCN_3  |Destination Name  |  Motorvision TV     |  Broadcaster Approval Status    | Proxy Ready for Approval |BroadcastStat  | Order Item (Send)  |  TMFDNBASCN_1,TMFDNBASCN_2          | TMFDNBASCN_3               | TMFDNBASCN_1            |TMFDNBASCN_2,TMFDNBASCN_3           |
