Feature: Traffic Simple search for Orders
Narrative:
In order to
As a              GlobalAdmin
I want to check simple search in traffic interface


Lifecycle:
Before:
Given updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |  Labels  |
| BroadCasterAgencyNoApproval  | | | | | MENA,dubbing_services,nVerge,FTP,Physical |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo      |      broadcasterTrafficManagerTwo     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 |
| TTVBTVSAR2 | TTVBTVSBR2 | TTVBTVSSB2 | TTVBTVSP2 |


Scenario: Check that Broadcaster Traffic Manager can search orders in Traffic By Clock number, Title, Advertiser, Product, Agency
Meta: @traffic
@qatrafficsmoke
Given I created the following agency:
| Name        |    A4User     | AgencyType     | Application Access |     Market     | DestinationID |
| TCNTA4      | DefaultA4User | Advertiser     |      ordering      |                |               |
And created users with following fields:
| Email      |           Role            | AgencyUnique |  Access  |
| TCNTU_8    |       agency.admin        |   TCNTA4     | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TCNTA4':
| Advertiser | Brand      | Sub Brand  | Product   |
| TTVBTVSAR3 | TTVBTVSBR3 | TTVBTVSSB3 | TTVBTVSP3 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1            |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR2 | TTVBTVSBR2 | TTVBTVSSB2 | TTVBTVSP2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | Motorvision TV:Express | 1     |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'TCNTU_8'
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR3 | TTVBTVSBR3 | TTVBTVSSB3 | TTVBTVSP3 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST3 | Motorvision TV:Express | 1  |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And select all from dropdown on Traffic Order List page
And wait for '2' seconds
And enter search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
And wait for '2' seconds
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic

Examples:
|ClockNumber1 |ClockNumber2 |ClockNumber3 |   OrderNotAvailable        |      OrderAvailable        |SearchCriteria |
|TTVBTVSCN17_1|TTVBTVSCN17_2|TTVBTVSCN17_3|TTVBTVSCN17_1,TTVBTVSCN17_2 |  TTVBTVSCN17_3             |  TCNTA4       |
|TTVBTVSCN13_1|TTVBTVSCN13_2|TTVBTVSCN13_3|TTVBTVSCN13_2,TTVBTVSCN13_3 |        TTVBTVSCN13_1       |  TTVBTVSCN13_1|
|TTVBTVSCN14_1|TTVBTVSCN14_2|TTVBTVSCN14_3|TTVBTVSCN14_1,TTVBTVSCN14_3 |        TTVBTVSCN14_2       |  TTVBTVST2    |
|TTVBTVSCN15_1|TTVBTVSCN15_2|TTVBTVSCN15_3|TTVBTVSCN15_1,TTVBTVSCN15_3 |        TTVBTVSCN15_2       |  TTVBTVSAR2   |
|TTVBTVSCN16_1|TTVBTVSCN16_2|TTVBTVSCN16_3|TTVBTVSCN16_3,TTVBTVSCN16_2 |        TTVBTVSCN16_1       |  TTVBTVSP1    |

Scenario: Check that Traffic Manager can search orders in Traffic By Clock number, Title, Advertiser, Product, Agency
Meta: @traffic
Given I created the following agency:
| Name      |    A4User     | AgencyType | Application Access |
| TTVBTVSA2 | DefaultA4User | Advertiser |      ordering      |
And created users with following fields:
| Email     |           Role          | AgencyUnique |  Access  |
| TTVBTVSU3 |       agency.admin      |   TTVBTVSA2  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TTVBTVSA2':
| Advertiser | Brand      | Sub Brand  | Product   |
| TTVBTVSAR5 | TTVBTVSBR5 | TTVBTVSSB5 | TTVBTVSP5 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | BSkyB Green Button:Standard |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR2 | TTVBTVSBR2 | TTVBTVSSB2 | TTVBTVSP2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | BSkyB Green Button:Standard |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'TTVBTVSU3'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR5 | TTVBTVSBR5 | TTVBTVSSB5 | TTVBTVSP5 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST3 | BSkyB Green Button:Standard |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And select all from dropdown on Traffic Order List page
And enter search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
And wait for '10' seconds
Then 'should' see order '<OrderAvailable>' in order list at Traffic UI
And 'should not' see order '<OrderNotAvailable>' in order list at Traffic UI

Examples:
|ClockNumber1|ClockNumber2|ClockNumber3|   OrderNotAvailable      |      OrderAvailable       |SearchCriteria  |
|TTVBTVSCN1_1|TTVBTVSCN1_2|TTVBTVSCN1_3|TTVBTVSCN1_2,TTVBTVSCN1_3 |        TTVBTVSCN1_1       |  TTVBTVSCN1_1  |
|TTVBTVSCN2_1|TTVBTVSCN2_2|TTVBTVSCN2_3|TTVBTVSCN2_1,TTVBTVSCN2_3 |        TTVBTVSCN2_2       |  TTVBTVST2   |
|TTVBTVSCN3_1|TTVBTVSCN3_2|TTVBTVSCN3_3|TTVBTVSCN3_1,TTVBTVSCN3_2 |        TTVBTVSCN3_3       |  TTVBTVSAR5  |
|TTVBTVSCN4_1|TTVBTVSCN4_2|TTVBTVSCN4_3|TTVBTVSCN4_1,TTVBTVSCN4_3 |        TTVBTVSCN4_2       |  TTVBTVSP2   |
|TTVBTVSCN5_1|TTVBTVSCN5_2|TTVBTVSCN5_3|TTVBTVSCN5_1,TTVBTVSCN5_2 |TTVBTVSCN5_3               |  TTVBTVSA2   |




Scenario: Check that Traffic Manager can search orders in Traffic By Order Refference
Meta:@traffic
     @qatrafficsmoke
     @uattrafficsmoke
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |TTVBTVSCN6_1  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST4 |  Talk Sport:Standard |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR2 | TTVBTVSBR2 | TTVBTVSSB2 | TTVBTVSP2 | TTVBTVSC1 |TTVBTVSCN6_2  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST5 |  Talk Sport:Standard |
And completed order contains item with clock number 'TTVBTVSCN6_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS14   | TTVBTVS14 |
And completed order contains item with clock number 'TTVBTVSCN6_2' with following fields:
| Job Number  | PO Number |
| TTVBTVS15   | TTVBTVS15 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TTVBTVSCN6_1' will be available in Traffic
And wait till order with clockNumber 'TTVBTVSCN6_2' will be available in Traffic
And open Traffic Order List page
And select 'All' tab in Traffic UI
And enter orderReference 'TTVBTVSCN6_1' in simple search form on Traffic Order List page
Then 'should' see order 'TTVBTVSCN6_1' in order list at Traffic UI
And 'should not' see order 'TTVBTVSCN6_2' in order list at Traffic UI



Scenario: Check that Traffic Manager can search orders in Traffic Particular Field (Clock Number, Title, Advertiser)
Meta: @traffic
@skip
!--QA-852 ticket has covered it in scenario below
Given I created the following agency:
| Name      |    A4User     | AgencyType | Application Access |
| TTVBTVSA7 | DefaultA4User | Advertiser |      ordering      |
And created users with following fields:
| Email     |           Role          | AgencyUnique |  Access  |
| TTVBTVSU8 |       agency.admin      |   TTVBTVSA7  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TTVBTVSA7':
| Advertiser | Brand      | Sub Brand  | Product   |
| TTVBTVSAR6 | TTVBTVSBR6 | TTVBTVSSB6 | TTVBTVSP6 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTV_BTV_ST1 | BSkyB Green Button:Standard |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR2 | TTVBTVSBR2 | TTVBTVSSB2 | TTVBTVSP2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTV_BTV_ST2 | BSkyB Green Button:Standard |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'TTVBTVSU8'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR6 | TTVBTVSBR6 | TTVBTVSSB6 | TTVBTVSP6 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTV_BTV_ST3 | BSkyB Green Button:Standard |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And refresh the page
And wait for '5' seconds
And select 'All' tab in Traffic UI
And select exact search by '<SearchType>' field and search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
Then 'should' see order '<OrderAvailable>' in order list at Traffic UI
And 'should not' see order '<OrderNotAvailable>' in order list at Traffic UI

Examples:
|  ClockNumber1  |  ClockNumber2  |  ClockNumber3  |      OrderNotAvailable        |        OrderAvailable       |  SearchCriteria   |  SearchType  |
| TTV/BTVS/CN7_1 | TTV/BTVS/CN7_2 | TTV/BTVS/CN7_3 | TTV/BTVS/CN7_2,TTV/BTVS/CN7_3 |        TTV/BTVS/CN7_1       |  TTV/BTVS/CN7_1   |   Clock Number    |
| TTV/BTVS/CN8_1 | TTV/BTVS/CN8_2 | TTV/BTVS/CN8_3 | TTV/BTVS/CN8_2,TTV/BTVS/CN8_1 |        TTV/BTVS/CN8_3       |    TTV_BTV_ST3    |    Title     |
| TTV/BTVS/CN9_1 | TTV/BTVS/CN9_2 | TTV/BTVS/CN9_3 | TTV/BTVS/CN9_2,TTV/BTVS/CN9_1 |        TTV/BTVS/CN9_3       |    TTVBTVSAR6     |  Advertiser  |


Scenario: Check that Broadcaster Traffic Manager can search orders in Traffic By House Number
Meta: @traffic
Given I created the following agency:
| Name        |    A4User     | AgencyType     | Application Access |     Market     | DestinationID | Labels  |
| TCNTA5      | DefaultA4User | Advertiser     |      ordering      |                |               |         |
And created users with following fields:
| Email      |           Role            | Agency |  Access  | Password |
| <User>     | broadcast.traffic.manager |   <Agency>   |  adpath  | abcdefghA1 |
And created users with following fields:
| Email      |           Role            | AgencyUnique |  Access  |
| TCNTU_9    |       agency.admin        |   TCNTA5     | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TCNTA5':
| Advertiser | Brand      | Sub Brand  | Product   |
| TTVBTVSAR7 | TTVBTVSBR7 | TTVBTVSSB7 | TTVBTVSP7 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | 1_TTVBTVST | <Destination>               | 1   |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer |
| automated test info    | TTVBTVSAR2 | TTVBTVSBR2 | TTVBTVSSB2 | TTVBTVSP2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | 2_TTVBTVST | <Destination>               | 1    |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And logged in with details of 'TCNTU_9'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination      | Motivnummer  |
| automated test info    | TTVBTVSAR7 | TTVBTVSBR7 | TTVBTVSSB7 | TTVBTVSP7 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | 3_TTVBTVST | <Destination>    |  1           |
And complete order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And login as '<User>' of Agency '<Agency>'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber3>' will be available in Traffic
And refreshed the page
And selected 'All' tab in Traffic UI
When I fill in House Number for order items in Traffic UI:
|  HouseNumber   |  clockNumber      |
| <HouseNumber1> |  <ClockNumber1>   |
| <HouseNumber2> |  <ClockNumber2>   |
| <HouseNumber3> |  <ClockNumber3>   |
And select exact search by '<SearchType>' field and search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
And I sort Order Items by field 'Title' in order 'asc' from Traffic UI
And wait for '7' seconds
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic

Examples:
|  Agency    |  User      |  ClockNumber1   |  ClockNumber2   |  ClockNumber3   |       OrderNotAvailable          |        OrderAvailable        |  SearchCriteria    |  SearchType  | HouseNumber1 | HouseNumber2 | HouseNumber3 | Destination |
| BroadCasterAgencyNoApproval | TCNTU8_2   | TTV/BTVS/CN10_1 | TTV/BTVS/CN10_2 | TTV/BTVS/CN10_3 |  TTV/BTVS/CN10_2,TTV/BTVS/CN10_3 |        TTV/BTVS/CN10_1       |     NCS            | House Number |     NCS      |     CS       |     ECS      | Travel Channel DE:Express  |
| BroadCasterAgencyTwoStage | TCNTU8_1_1 | TTV/BTVS/CN11_1 | TTV/BTVS/CN11_2 | TTV/BTVS/CN11_3 |  TTV/BTVS/CN11_2,TTV/BTVS/CN11_1 |        TTV/BTVS/CN11_3       |     CL-DS-03       | House Number |   CL-DS-01   |   CL-DS-02   |   CL-DS-03   |     Motorvision TV:Express |



Scenario: Check that Broadcaster Traffic Manager can search orders by particular field Product in new tab
Meta: @traffic
@skip
!--QA-852 ticket has covered it in scenario below
Given I created the following agency:
| Name        |    A4User     | AgencyType     | Application Access |     Market     | DestinationID |
| TCNTA5      | DefaultA4User | Advertiser     |      ordering      |                |               |
And created users with following fields:
| Email      |           Role            | AgencyUnique |  Access  |
| TCNTU_11   |       agency.admin        |   TCNTA5     | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TCNTA5':
| Advertiser | Brand      | Sub Brand  | Product   |
| TTVBTVSAR8 | TTVBTVSBR8 | TTVBTVSSB8 | TTVBTVSP8 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 |  Motorvision TV:Express      | 1     |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer  |
| automated test info    | TTVBTVSAR2 | TTVBTVSBR2 | TTVBTVSSB2 | TTVBTVSP2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | Motorvision TV:Express       | 1            |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And logged in with details of 'TCNTU_11'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 | Motivnummer  |
| automated test info    | TTVBTVSAR8 | TTVBTVSBR8 | TTVBTVSSB8 | TTVBTVSP8 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST3 | Motorvision TV:Express       | 1            |
And complete order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And logged in with details of 'broadcasterTrafficManagerTwo'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber3>' will be available in Traffic
And refreshed the page
And selected 'All' tab in Traffic UI
When I create tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value  |
| <Condition> |   Match        | <Value> |
And wait till order item list will be loaded in Traffic
And select exact search by '<SearchType>' field and search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
Then I 'should' see orderItems '<AvailableOrder>' in order item list in Traffic
And I 'should not' see orderItems '<NotAvailableOrderItem>' in order item list in Traffic

Examples:
|  Agency    |  User    |  ClockNumber1   |  ClockNumber2   |  ClockNumber3   |       NotAvailableOrderItem      |        AvailableOrder        |  SearchCriteria    |  SearchType  | Condition        | Value             | TabName         | TabType          |
| TCNTTVB8_1 | TCNTU9_2 | TTV/BTVS/CN12_1 | TTV/BTVS/CN12_2 | TTV/BTVS/CN12_3 |  TTV/BTVS/CN12_3,TTV/BTVS/CN12_1 |        TTV/BTVS/CN12_2       |     TTVBTVSP2      |   Product    | Destination name | Motorvision TV| testDestination | Order Item (Send)   |



Scenario: Check that Broadcaster Traffic Manager can search orders in Traffic By Clock number, Title, Advertiser, Product, Agency based upon Exact Search
Meta: @traffic
@qatrafficsmoke
!--QA-852
Given I created the following agency:
| Name        |    A4User     | AgencyType     | Application Access |     Market     | DestinationID |
| TBMESA1      | DefaultA4User | Advertiser     |      ordering      |                |               |
And created users with following fields:
| Email      |           Role            | AgencyUnique |  Access  |
| TBMESU1    |       agency.admin        |   TBMESA1     | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TBMESA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| TTVBTVSAR4 | TTVBTVSBR4 | TTVBTVSSB4 | TTVBTVSP4 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1            |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR2 | TTVBTVSBR2 | TTVBTVSSB2 | TTVBTVSP2 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST2 | Motorvision TV:Express | 1     |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And login with details of 'TBMESU1'
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR9 | TTVBTVSBR9 | TTVBTVSSB9 | TTVBTVSP9 | TTVBTVSC2 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST3 | Motorvision TV:Express | 1  |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And select exact search by '<SearchType>' field and search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
And wait for '20' seconds
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic

Examples:
|ClockNumber1  |ClockNumber2 |ClockNumber3  |   OrderNotAvailable     |      OrderAvailable    |SearchCriteria |SearchType  |
|TBMESCN1_1    |TBMESCN1_2   |TBMESCN1_3    |TBMESCN1_1,TBMESCN1_2    |      TBMESCN1_3        |  TBMESA1      | All        |
|TBMESCN2_1    |TBMESCN2_2   |TBMESCN2_3    |TBMESCN2_2,TBMESCN2_3    |      TBMESCN2_1        |  TBMESCN2_1   | Clock Number    |
|TBMESCN3_1    |TBMESCN3_2   |TBMESCN3_3    |TBMESCN3_1,TBMESCN3_3    |      TBMESCN3_2        |  TTVBTVST2    | Title      |
|TBMESCN4_1    |TBMESCN4_2   |TBMESCN4_3    |TBMESCN4_1,TBMESCN4_3    |      TBMESCN4_2        |  TTVBTVSAR2   | Advertiser |
|TBMESCN5_1    |TBMESCN5_2   |TBMESCN5_3    |TBMESCN5_3,TBMESCN5_2    |      TBMESCN5_1        |  TTVBTVSP1    | Product    |
|TBMESCN6_1    |TBMESCN6_2   |TBMESCN6_3    |TBMESCN6_1,TBMESCN6_3    |      TBMESCN6_2        |  TTVBTVSAR2   | Basic      |
|TBMESCN7_1    |TBMESCN7_2   |TBMESCN7_3    |TBMESCN7_2,TBMESCN7_3    |      TBMESCN7_1        |  TBMESCN7_1   | Basic      |
|TBMESCN8_1    |TBMESCN8_2   |TBMESCN8_3    |TBMESCN8_2,TBMESCN8_3    |      TBMESCN8_1        |  TTVBTVSP1    | Basic      |
|TBMESCN9_1    |TBMESCN9_2   |TBMESCN9_3    |TBMESCN9_2,TBMESCN9_1    |      TBMESCN9_3        |  TTVBTVSC2    | Basic      |



Scenario: Check that Broadcaster Traffic Manager can filter based upon the date
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1            |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1     |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1  |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And waited for finish place order with following item clock number '<ClockNumber1>' to A4
And waited for finish place order with following item clock number '<ClockNumber2>' to A4
And waited for finish place order with following item clock number '<ClockNumber3>' to A4
When ingested assests through A5 with following fields:
 | agencyName                | clockNumber        |
 | DefaultAgency      |   <ClockNumber1>    |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber '<ClockNumber1>' with destination 'Motorvision TV' will have the next Destination Status 'Awaiting station release' in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And refresh the page without delay
And wait till order item list will be loaded in Traffic
And filter by date:
|Filter By Date  | Start Date  | End Date |
|Arrival Date    | Today       | Today    |
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic
When open order item details page with clockNumber '<ClockNumber1>'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page without delay
And click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Delivered' in Traffic
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And filter by date:
|Filter By Date  | Start Date  | End Date |
|Delivery Date    | Today       | Today    |
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic
When I create tab with name 'Date_Tab' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value    |
|   Advertiser     |   Match        |  TTVBTVSAR1 |
And wait till order item list will be loaded in Traffic
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic

Examples:
|ClockNumber1 |ClockNumber2 |ClockNumber3 |   OrderNotAvailable        |      OrderAvailable        |
|TBTMFDCN_1|TBTMFDCN_2|TBTMFDCN_3|TBTMFDCN_3,TBTMFDCN_2 |  TBTMFDCN_1             |


Scenario: Check that filter by Date delete and edit works and orders reflected accordingly for Broadcast Traffic Manager of Super Hub
Given I created the following agency:
| Name        | A4User            | AgencyType              | Market         |DestinationID|Application Access|
| TBTMFDH     | DefaultA4User     | TV Broadcaster Hub      | Germany        |             |adpath            |
| TBTMFDSH    | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TBTMFDSHU  |       broadcast.traffic.manager       |  TBTMFDSH    | adpath   |
And I am on agency 'TBTMFDSH' hub members page
And I add hub members:
|Hub Members|
|BroadCasterAgencyTwoStage|
|BroadCasterAgencyNoApproval|
And I am on agency 'TBTMFDSH' super hub members page
And I add super hub members:
|Super Hub Members|
|TBTMFDH|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |TBTMFDSHCN_1    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TTVBTVST1  |  Motorvision TV:Express      |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |TBTMFDSHCN_2      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TTVBTVST1 |  Motorvision TV:Express     |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |TBTMFDSHCN_3      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TTVBTVST1 |  Travel Channel DE:Express     |
And complete order contains item with clock number 'TBTMFDSHCN_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number 'TBTMFDSHCN_2' with following fields:
| Job Number | PO Number |
| TTVBTVS11  | TTVBTVS11 |
And complete order contains item with clock number 'TBTMFDSHCN_3' with following fields:
| Job Number | PO Number |
| TTVBTVS11  | TTVBTVS11 |
And wait for finish place order with following item clock number 'TBTMFDSHCN_1' to A4
And wait for finish place order with following item clock number 'TBTMFDSHCN_2' to A4
And wait for finish place order with following item clock number 'TBTMFDSHCN_3' to A4
When ingested assests through A5 with following fields:
 | agencyName         | clockNumber    |
 | DefaultAgency      |   TBTMFDSHCN_1 |
 | DefaultAgency      |   TBTMFDSHCN_3 |
And login with details of 'TBTMFDSHU'
And wait till order with clockNumber 'TBTMFDSHCN_1' will be available in Traffic
And wait till order with clockNumber 'TBTMFDSHCN_2' will be available in Traffic
And wait till order with clockNumber 'TBTMFDSHCN_3' will be available in Traffic
And wait till order item with clockNumber 'TBTMFDSHCN_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TBTMFDSHCN_3' will have broadcaster status 'Delivered' in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And refresh the page without delay
And wait till order item list will be loaded in Traffic
And filter by date:
|Filter By Date  | Start Date  | End Date |
|Arrival Date    | Today       | Today    |
Then 'should' see orderItems 'TBTMFDSHCN_1,TBTMFDSHCN_3' in order item list in Traffic
And 'should not' see orderItems 'TBTMFDSHCN_2' in order item list in Traffic


Scenario: Check that filter by Date delete and edit works and orders reflected accordingly for Broadcast Traffic Manager of Hub
Meta: @traffic
@qatrafficsmoke
Given I created the following agency:
| Name    | A4User        | AgencyType         | Application Access | Market   |DestinationID |
| TBTMFDB | DefaultA4User | TV Broadcaster Hub | adpath             | Germany  |              |
And created users with following fields:
| Email | Role | AgencyUnique | Access |
| TBTMFDBU | broadcast.traffic.manager | TBTMFDB | adpath |
And I logged in as 'GlobalAdmin'
And I am on agency 'TBTMFDB' hub members page
And I add hub members:
|Hub Members|
|BroadCasterAgencyTwoStage|
|BroadCasterAgencyNoApproval|
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |TBTMFDCN_4    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1            |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |TBTMFDCN_5    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1     |
And completed order contains item with clock number 'TBTMFDCN_4' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number 'TBTMFDCN_5' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |TBTMFDCN_6    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Travel Channel DE:Express | 1  |
And completed order contains item with clock number 'TBTMFDCN_6' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And waited for finish place order with following item clock number 'TBTMFDCN_4' to A4
And waited for finish place order with following item clock number 'TBTMFDCN_5' to A4
And waited for finish place order with following item clock number 'TBTMFDCN_6' to A4
When ingested assests through A5 with following fields:
 | agencyName         | clockNumber         |
 | DefaultAgency      |   TBTMFDCN_4        |
 | DefaultAgency      |   TBTMFDCN_6      |
And login with details of 'TBTMFDBU'
And wait till order with clockNumber 'TBTMFDCN_4' will be available in Traffic
And wait till order with clockNumber 'TBTMFDCN_5' will be available in Traffic
And wait till order with clockNumber 'TBTMFDCN_6' will be available in Traffic
And wait till order item with clockNumber 'TBTMFDCN_4' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TBTMFDCN_6' will have broadcaster status 'Delivered' in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And refresh the page without delay
And wait till order item list will be loaded in Traffic
And filter by date:
|Filter By Date  | Start Date  | End Date |
|Arrival Date    | Today       | Today    |
Then 'should' see orderItems 'TBTMFDCN_4,TBTMFDCN_6' in order item list in Traffic
And 'should not' see orderItems 'TBTMFDCN_5' in order item list in Traffic
When I create tab with name 'Date_del_Tab' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value    |
|   Advertiser|   Match        |  TTVBTVSAR1 |
And wait till order item list will be loaded in Traffic
And I delete filter by date
And wait for '2' seconds
Then 'should' see orderItems 'TBTMFDCN_4,TBTMFDCN_5,TBTMFDCN_6' in order item list in Traffic
When select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
Then 'should' see orderItems 'TBTMFDCN_4,TBTMFDCN_5,TBTMFDCN_6' in order item list in Traffic
When edit filter by date:
|Filter By Date  | Start Date  | End Date |
|Delivery Date    | Today       | Today    |
Then 'should' see orderItems 'TBTMFDCN_6' in order item list in Traffic
And 'should not' see orderItems 'TBTMFDCN_5,TBTMFDCN_4' in order item list in Traffic
When I create tab with name 'Date_edit_Tab' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value    |
|   Advertiser     |   Match        |  TTVBTVSAR1 |
And wait till order item list will be loaded in Traffic
Then 'should' see orderItems 'TBTMFDCN_6' in order item list in Traffic
And 'should not' see orderItems 'TBTMFDCN_5,TBTMFDCN_4' in order item list in Traffic
