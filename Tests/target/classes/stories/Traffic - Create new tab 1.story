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

Scenario: Check that Traffic Manager can create tab (Order) with specific filter (Market and Order Status) and later Update the rule to include Order Item Status
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 |  Travel Channel DE:Express   | 1           |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 |  Travel Channel DE:Express   |   1         |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 |  Talk Sport:Express          |   1         |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And waited for finish place order with following item clock number '<ClockNumber1>' to A4
And waited for finish place order with following item clock number '<ClockNumber2>' to A4
And waited for finish place order with following item clock number '<ClockNumber3>' to A4
And ingested assests through A5 with following fields:
 | agencyName       | clockNumber     |
 | DefaultAgency    | <ClockNumber1>  |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value    |
| <Condition1> |   Match        | <Value1>  |
| <Condition2> |   Match        | <Value2>  |
And wait till order list will be loaded
And enter search criteria 'TMFACOSOISCN_1' in simple search form on Traffic Order List page
Then I 'should' see order 'TMFACOSOISCN_1' in Traffic order list page
When enter search criteria 'TMFACOSOISCN_2' in simple search form on Traffic Order List page
Then I 'should not' see order 'TMFACOSOISCN_2' in Traffic order list page
When enter search criteria 'TMFACOSOISCN_3' in simple search form on Traffic Order List page
Then I 'should not' see order 'TMFACOSOISCN_3' in Traffic order list page
When login with details of 'AgencyAdmin'
And ingested assests through A5 with following fields:
 | agencyName       | clockNumber     |
 | DefaultAgency    | <ClockNumber2>  |
And logout from account
And login with details of 'trafficManager'
And wait till order item with clockNumber '<ClockNumber2>' will have next status 'TVC Ingested OK' in Traffic
And wait till order with clockNumber '<ClockNumber2>' will have next status 'Completed' in Traffic
And select '<TabName>' tab in Traffic UI
And I Edit the tab
And update tab with new rule:
|  Condition        | Condition Type |  Value          |
| <Condition3>      |   Match        | <Value3>        |
And wait till order list will be loaded
And enter search criteria 'TMFACOSOISCN_1' in simple search form on Traffic Order List page
Then I 'should' see order 'TMFACOSOISCN_1' in Traffic order list page
When enter search criteria 'TMFACOSOISCN_2' in simple search form on Traffic Order List page
Then I 'should' see order 'TMFACOSOISCN_2' in Traffic order list page
When enter search criteria 'TMFACOSOISCN_3' in simple search form on Traffic Order List page
Then I 'should not' see order 'TMFACOSOISCN_3' in Traffic order list page

Examples:
| ClockNumber1     | ClockNumber2      |  ClockNumber3    |Condition1      | Value1             | Condition2       |  Value2   | Condition3                    |  Value3                  |TabName        | TabType          | AvailableOrder  | NotAvailableOrderItem           | New_AvailableOrder                  | New_NotAvailableOrderItem  |
| TMFACOSOISCN_1   | TMFACOSOISCN_2    |  TMFACOSOISCN_3  |Market          | Germany            | Order Status     | Completed | Order Item Status           | TVC Ingested OK          |testAgencyCnty | Order              |  TMFACOSOISCN_1 | TMFACOSOISCN_2,TMFACOSOISCN_3   |  TMFACOSOISCN_1,TMFACOSOISCN_2      |  TMFACOSOISCN_3            |


Scenario: Check that Traffic Manager can create tab (Order Item Clock view) with specific filter (Agency,Market,Advertiser)
Meta: @traffic
Given I created the following agency:
| Name      |    A4User     | AgencyType | Application Access |
| TCNTA2 | DefaultA4User | Advertiser |      ordering      |
And created users with following fields:
| Email     |           Role          | AgencyUnique |  Access  |
| TCNTU3    |       agency.admin      |   TCNTA2  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TCNTA2':
| Advertiser | Brand      | Sub Brand  | Product   |
| TTVBTVSAR3 | TTVBTVSBR3 | TTVBTVSSB3 | TTVBTVSP3 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | BSkyB Green Button:Standard |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | BSkyB Green Button:Standard |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'TCNTU3'
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Motivnummer |Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR3 | TTVBTVSBR3 | TTVBTVSSB3 | TTVBTVSP3 | TTVBTVSC1 |<ClockNumber3>|    111      |20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST3  | Facebook DE:Standard |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And open Traffic Order List page
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |
| <Condition> |   Match        | <Value> |
And wait till order item list will be loaded in Traffic
And wait for '4' seconds
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic

Examples:
| ClockNumber1  | ClockNumber2  | ClockNumber3  | Condition  | Value          | TabName        | TabType          | AvailableOrder                | NotAvailableOrderItem     |
| TTVBTVSCN9_1  | TTVBTVSCN9_2  | TTVBTVSCN9_3  | Advertiser | TCNTAR1     | testAdvertiser | Order Item Clock |  TTVBTVSCN9_1                 | TTVBTVSCN9_3,TTVBTVSCN9_2 |


Scenario: Check that Traffic Manager can create tab with specific filter (First Air Date) and pin the tab
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       |      1      | 06/16/2016     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber2>| 20       |      1      | 06/13/2016     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber3>| 20       | 06/14/2016     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | BSkyB Green Button:Standard |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And open Traffic Order List page
And open create new tab popup and fill name '<TabName>' and type '<TabType>' and dataRange 'Today'
And add new conditions at the traffic create new tab pop up:
|  Condition   | Condition Type |  Value   | NewRule | Match | NewConditionAfterCurrent |
| <Condition1> |   Before       | <Value1> |         | All   | Yes                      |
| <Condition1> |   After        | <Value2> |         |       |                          |
And click save at the traffic create new tab pop up
And pin '<TabName>' tab in Traffic UI
And I open Traffic Order List page
And wait till order list will be loaded
Then I 'should' see first tab as '<TabName>'
And I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic
When I logout from account
And login with details of 'trafficManager'
Then I 'should' see first tab as '<TabName>'
And I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic

Examples:
| ClockNumber1 | ClockNumber2  | ClockNumber3  | Condition1     | Value1     | Value2      | TabName        | TabType             | AvailableOrder        | NotAvailableOrderItem |
| TCNSCN5_2    | TCNSCN5_1     | TCNSCN5_3     | First Air Date | 2016-06-15 | 2016-06-13  | FirstAirDate   | Order Item (Clock)  |  TCNSCN5_3,TCNSCN5_1  | TCNSCN5_2             |


Scenario: Check that Traffic Manager can create tab (Order view) with specific filter (Agency,Market)
Meta: @traffic
Given I created the following agency:
| Name      |    A4User     | AgencyType | Application Access |
| TCNTA2    | DefaultA4User | Advertiser |      ordering      |
And created users with following fields:
| Email     |           Role          | AgencyUnique |  Access  |
| TCNTU3 |       agency.admin         |   TCNTA2  | ordering |
And I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | BSkyB Green Button:Standard |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | BSkyB Green Button:Standard |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'TCNTU3'
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Motivnummer |Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR3 | TTVBTVSBR3 | TTVBTVSSB3 | TTVBTVSP3 | TTVBTVSC1 |<ClockNumber3>|    111      |20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST3  | Facebook DE:Standard |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And open Traffic Order List page
And refresh the page
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |
| <Condition> |   Match        | <Value> |
And wait till order list will be loaded
And wait for '4' seconds
Then I 'should' see order '<AvailableOrder>' in order list at Traffic UI
And I 'should not' see order '<NotAvailableOrderItem>' in order list at Traffic UI

Examples:
| ClockNumber1  | ClockNumber2  | ClockNumber3  | Condition  | Value          | TabName        | TabType          | AvailableOrder                | NotAvailableOrderItem     |
| TTVBTVSCN8_1  | TTVBTVSCN8_2  | TTVBTVSCN8_3  | Agency     | TCNTA2         | testAgency4     | Order            |  TTVBTVSCN8_3                 | TTVBTVSCN8_1,TTVBTVSCN8_2 |
| TTVBTVSCN10_1 | TTVBTVSCN10_2 | TTVBTVSCN10_3 | Market     | United Kingdom | Testmarket4     | Order            | TTVBTVSCN10_1,TTVBTVSCN10_2   | TTVBTVSCN10_3             |


Scenario: Check that Traffic Manager can create tab with specific filter and use search on this new tab and Download CSV
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Talk Sport:Standard          |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber2>| 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | BSkyB Green Button:Standard  |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And open Traffic Order List page
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |
| <Condition> |   Match        | <Value> |
And wait till order item list will be loaded in Traffic
And enter search criteria '<SearchCriteria>' in simple search form on Traffic Order Item List page
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic
Then I 'should' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| VerfyData      |
| <Value>        |
| <ClockNumber1> |
And I 'shouldnot' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| VerfyData             |
| BSkyB Green Button    |
|  <ClockNumber2>       |

Examples:
| ClockNumber1  | ClockNumber2   | Condition        | Value             | TabName         | TabType              | AvailableOrder  | NotAvailableOrderItem | SearchCriteria |
| TTVBTVSCN11_1 | TTVBTVSCN11Z_2 | Destination name | Talk Sport        | testDestination | Order Item (Send)    |  TTVBTVSCN11_1  |  TTVBTVSCN11Z_2         | TTVBTVSCN11_1  |


Scenario: Check that Broadcaster Traffic Manager can create tab with specific filter (Agency,Market,Advertiser) and Download CSv
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1           |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           |Motivnummer  |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | Motorvision TV:Express | 1           |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And open Traffic Order List page
And refresh the page
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |
| <Condition> |    Match       | <Value> |
And wait till order item list will be loaded in Traffic
And wait for '4' seconds
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic
Then I 'should' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| VerfyData      |
| <Value>        |
| <ClockNumber1> |
And I 'shouldnot' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| VerfyData             |
|TCNTAR2             |
|<ClockNumber2>         |

Examples:
| ClockNumber1  | ClockNumber2  | ClockNumber3  | Condition  | Value          | TabName        | TabType                     | AvailableOrder | NotAvailableOrderItem |
| TTVBTVSCN12_1 | TTVBTVSCN12_2 | TTVBTVSCN12_3 | Advertiser | TCNTAR1     | testAdvertiser | Order Item (Send)           |  TTVBTVSCN12_1 | TTVBTVSCN12_2         |



Scenario: Check that expand all feature works on new tab
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 | TCNT1_1    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | TTVBTVST1 | Talk Sport:Standard|
And completed order contains item with clock number 'TCNT1_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCNT1_1' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
When I create tab with name 'TestExpand' and type 'Order' and Data Range 'Today' and without conditions in Traffic
And wait for '5' seconds
And enter search criteria 'TCNT1_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destinations 'Talk Sport' for order item in Traffic List with clockNumber 'TCNT1_1'


Scenario: Create tabs based on House number at send level
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number      | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |  <ClockNumber1>   | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     | Travel Channel DE:Express  |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number      | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 | <ClockNumber2>    | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT2     | Travel Channel DE:Express  |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number      | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 | <ClockNumber3>    | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT3     | Travel Channel DE:Express  |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number      | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |     Destination       |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 | <ClockNumber4>    | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT4     | Travel Channel DE:Express  |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And complete order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And complete order contains item with clock number '<ClockNumber4>' with following fields:
| Job Number  | PO Number |
| TTVBTVS14   | TTVBTVS14 |
And logged in with details of 'broadcasterTrafficManagerNoApproval'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber3>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber4>' will be available in Traffic
And selected 'All' tab in Traffic UI
And waited till order item list will be loaded in Traffic
And I cleared search criteria in simple search form on Traffic Order List page
And waited for '2' seconds
And entered search criteria '<ClockNumber1>' in simple search form on Traffic Order List page
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| NCS          |  <ClockNumber1>   |
And I cleared search criteria in simple search form on Traffic Order List page
And waited for '2' seconds
And entered search criteria '<ClockNumber2>' in simple search form on Traffic Order List page
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| CS           |  <ClockNumber2>   |
And I cleared search criteria in simple search form on Traffic Order List page
And waited for '2' seconds
And entered search criteria '<ClockNumber3>' in simple search form on Traffic Order List page
And I fill in House Number for order items in Traffic UI:
| HouseNumber  |  clockNumber      |
| ECS          |  <ClockNumber3>   |
And waited for '2' seconds
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition   | Condition Type    | Value     |
| <Condition>  |  <Cond Type 1>    | <value_1> |
| <Condition>  |  <Cond Type 2>    | <value_2> |
| <Condition>  |  <Cond Type 3>    | <value_3> |
And wait till order item list will be loaded in Traffic
And clear search criteria in simple search form on Traffic Order List page
And wait for '2' seconds
And enter search criteria '<AvailableOrder>' in simple search form on Traffic Order List page
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
When clear search criteria in simple search form on Traffic Order List page
Then I 'should not' see orderItems '<NotAvailItem>' in order item list in Traffic


Examples:
| ClockNumber1  | ClockNumber2   | ClockNumber3   | ClockNumber4  | Condition    | Cond Type 1      |  value_1   | Cond Type 2          |  value_2 | Cond Type 3         |  value_3  |TabName        | TabType             | AvailableOrder   | NotAvailItem                        |
| TTBHNSL2_1    | TTBHNSL2_2     | TTBHNSL2_3     | TTBHNSL2_4    | House Number | Starts with      |  NCS       | Does not start with  |   ECS    |                     |           |HN_NCS         | Order Item (Send)   | TTBHNSL2_1       | TTBHNSL2_2,TTBHNSL2_3,TTBHNSL2_4    |
| TTBHNSL3_1    | TTBHNSL3_2     | TTBHNSL3_3     | TTBHNSL3_4    | House Number | Starts with      |  ECS       | Does not start with  |   NCS    |                     |           |HN_ECS         | Order Item (Send)   | TTBHNSL3_3       | TTBHNSL3_1,TTBHNSL3_2,TTBHNSL3_4    |
| TTBHNSL4_1    | TTBHNSL4_2     | TTBHNSL4_3     | TTBHNSL4_4    | House Number | Starts with      |   CS       | Does not start with  |   ECS    | Does not start with |  NCS      |HN_CS          | Order Item (Send)   | TTBHNSL4_2       | TTBHNSL4_1,TTBHNSL4_3,TTBHNSL4_4    |




Scenario: Check that Traffic Manager can create tab based on specific to Market schema fields (Watermarking)
Meta: @traffic
Given I am logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'Spain' for agency 'DefaultAgency'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String Common Ordering' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clave | Clock Number | Watermarking Required |  Duration | First Air Date | Subtitles Required | Format         | Title     | Destination       |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 | Test  |<ClockNumber1>|         Yes           |  20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Antena 3:Standard |
And created 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clave | Clock Number | Watermarking Required | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination       |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 | Test  |<ClockNumber2>|         No           |  20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | Antena 3:Standard |
And created 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clave | Clock Number | Watermarking Required | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination       |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 | Test  |<ClockNumber3>|         No           |  20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | Antena 3:Standard |
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
And select 'All' tab in Traffic UI
And wait till order list will be loaded
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
| Schema |  Condition  | Condition Type |  Value  |
| Spain  | <Condition> |   Match        | <Value> |
And wait till order item list will be loaded in Traffic
And wait for '4' seconds
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic

Examples:
| ClockNumber1  | ClockNumber2  | ClockNumber3  |       Condition       | Value | TabName          |      TabType        | AvailableOrder | NotAvailableOrderItem |
|  TSSWSCN1_1   |  TSSWSCN1_2   |  TSSWSCN1_3   | Watermarking Required |  Yes  | testWatermarking | Order Item (Clock)  |  TSSWSCN1_1    | TSSWSCN1_3,TSSWSCN1_2 |



Scenario: Check that Traffic Manager can create tab with specific filter (Destination Type)
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TCNTAR1 | TCNTSB1 | TCNTSBR1 | TCNTPR1 | TTVBTVSC1 |<ClockNumber1>| 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Express |
And created 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Watermarking Required | Clave | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination      |
| automated test info    | TCNTAR2 | TCNTSB2 | TCNTSBR2 | TCNTPR2 | TTVBTVSC1 |<ClockNumber2>| No                    | 1     | 20       |      1      | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST2 | Ibecom TV:Express |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And open Traffic Order List page
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |
| <Condition> |   Match        | <Value> |
And wait till order item list will be loaded in Traffic
And wait for '4' seconds
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic

Examples:
| ClockNumber1 | ClockNumber2  | Condition        | Value             | TabName           | TabType              | AvailableOrder  | NotAvailableOrderItem |
| TCNSCN1_1    | TCNSCN1_2     | Destination type | Offline           | DestinationStatus | Order Item (Send)    |  TCNSCN1_2      | TCNSCN1_1             |