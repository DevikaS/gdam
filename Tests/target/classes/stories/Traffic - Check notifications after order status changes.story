!--QA-433
Feature: Email notification for multiple recipients on order status change from InProgress to Completed [Order Ingestion Complete Report and Order Delivery Report]
Narrative:
In order to:
As a AgencyAdmin
I want to check email notification for multiple recipients on order status change


Scenario: Check that tv order delivery report is sent to the additional recipients and order creator (2 clocks and 5 Online destinations)
Meta: @traffic
      @tbug
      @trafficemails
 !--FAB-487
Given I created the following agency:
| Name    |    A4User     | AgencyType | Application Access |
| TAZA1   | DefaultA4User | Advertiser |      ordering      |
And created users with following fields:
| Email       |           Role          | AgencyUnique |  Access  |
| OTVCNOSC_U1 |       agency.user       |   TAZA1      | ordering |
| OTVCNOSC_U2 |       agency.user       |   TAZA1      | ordering |
| OTVCNOSC_U3 |       agency.user       |   TAZA1      |  ordering|
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser   | Brand       | Sub Brand     | Product        |
| OTVCNOSC_AR1 | OTVCNOSC_BR1 | OTVCNOSC_SB1   | OTVCNOSC_P1  |
And logged in with details of 'OTVCNOSC_U1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand       | Sub Brand     | Product    | Campaign    | Clock Number  | Duration |Motivnummer| First Air Date | Subtitles Required | Format        | Title      | Destination                 |
| automated test info    | OTVCNOSC_AR1| OTVCNOSC_BR1 | OTVCNOSC_SB1| OTVCNOSC_P1| OTVCNOSC_C1 | OTVCNOSC_CN1  | 20       |     1     |12/14/2022      |  Already Supplied  |HD 1080i 25fps | OTVCNOSC_T1 | Travel Channel DE:Standard;Super RTL HD:Standard|
| automated test info    | OTVCNOSC_AR1| OTVCNOSC_BR1 | OTVCNOSC_SB1| OTVCNOSC_P1| OTVCNOSC_C1 | OTVCNOSC_CN2  | 20       |     1     |12/14/2022      |  Already Supplied  |HD 1080i 25fps | OTVCNOSC_T2 | RTL HD:Express;VOX HD:Express;RTL2 DE HD:Express|
And complete order contains item with clock number 'OTVCNOSC_CN1' with following fields:
| Job Number  | PO Number    |
| OTVCNOSC_JN1| OTVCNOSC_PN1 |
And wait for finish place order with following item clock numbers 'OTVCNOSC_CN1,OTVCNOSC_CN2' to A4
When login with details of 'trafficManager'
And open edit page for order with Clock Number 'OTVCNOSC_CN1' in Traffic
And edit order in traffic with the following fields:
| FieldName          | FieldValue        |
| Duration           | 22                |
And click proceed button on Traffic Order Edit page
And add order 'completed' email recipients 'OTVCNOSC_U2,OTVCNOSC_U3' on Traffic Order Summary page
And click notify order creator when entire order has 'delivered'
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I login with details of 'OTVCNOSC_U1'
And ingested assests through A5 with following fields:
| agencyName             | clockNumber    |
| TAZA1                  | OTVCNOSC_CN1   |
| TAZA1                  | OTVCNOSC_CN2   |
And wait till order item with clockNumber 'OTVCNOSC_CN1' will have view status 'At Destination'
And wait till order item with clockNumber 'OTVCNOSC_CN2' will have view status 'At Destination'
Then I 'should' see email notification for 'Order Delivery Report' with field to 'OTVCNOSC_U1' and subject 'Order Refnumber delivery report' contains following attributes:
|UserName   |
|OTVCNOSC_U1|
And I 'should' see email notification for 'Order Delivery Report' with field to 'OTVCNOSC_U2' and subject 'Order Refnumber delivery report' contains following attributes:
|UserName   |
|OTVCNOSC_U2|
And I 'should' see email notification for 'Order Delivery Report' with field to 'OTVCNOSC_U3' and subject 'Order Refnumber delivery report' contains following attributes:
|UserName   |
|OTVCNOSC_U3|

Scenario: Check that tv order ingestion completed report is sent to the additional recipients and order creator (2 clocks and 5 Online destinations)
Meta: @traffic
      @tbug
      @trafficemails
  !--FAB-488
Given I created the following agency:
| Name     |    A4User     | AgencyType | Application Access |
| TAZA1Z   | DefaultA4User | Advertiser |      ordering      |
And created users with following fields:
| Email       |           Role          | AgencyUnique  |  Access  |
| OTVCNOSC_U5 |       agency.user       |   TAZA1Z      | ordering |
| OTVCNOSC_U6 |       agency.user       |   TAZA1Z      | ordering |
| OTVCNOSC_U7 |       agency.user       |   TAZA1Z      |  ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser   | Brand       | Sub Brand     | Product        |
| OTVCNOSC_AR2 | OTVCNOSC_BR2 | OTVCNOSC_SB2   | OTVCNOSC_P2  |
And logged in with details of 'OTVCNOSC_U5'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand       | Sub Brand     | Product    | Campaign    | Clock Number   | Duration |Motivnummer| First Air Date | Subtitles Required | Format        | Title       | Destination                                     |
| automated test info    | OTVCNOSC_AR2| OTVCNOSC_BR2 | OTVCNOSC_SB2| OTVCNOSC_P2| OTVCNOSC_C2 | OTVCNOSC_ICN3  | 20       |     1     |12/14/2022      |  Already Supplied  |HD 1080i 25fps | OTVCNOSC_T3 | Travel Channel DE:Standard;Super RTL HD:Standard|
| automated test info    | OTVCNOSC_AR2| OTVCNOSC_BR2 | OTVCNOSC_SB2| OTVCNOSC_P2| OTVCNOSC_C2 | OTVCNOSC_ICN4  | 20       |     1     |12/14/2022      |  Already Supplied  |HD 1080i 25fps | OTVCNOSC_T4 | RTL HD:Express;VOX HD:Express;RTL2 DE HD:Express|
And complete order contains item with clock number 'OTVCNOSC_ICN3' with following fields:
| Job Number  | PO Number    |
| OTVCNOSC_JN2| OTVCNOSC_PN2 |
And wait for finish place order with following item clock numbers 'OTVCNOSC_ICN3,OTVCNOSC_ICN4' to A4
When login with details of 'trafficManager'
And open edit page for order with Clock Number 'OTVCNOSC_ICN3' in Traffic
And click proceed button on Traffic Order Edit page
And add order 'ingested' email recipients 'OTVCNOSC_U6,OTVCNOSC_U7' on Traffic Order Summary page
And click notify order creator when entire order has 'passedQC'
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I login with details of 'OTVCNOSC_U5'
And ingested assests through A5 with following fields:
| agencyName     | clockNumber    |
| TAZA1Z         | OTVCNOSC_ICN3   |
| TAZA1Z         | OTVCNOSC_ICN4   |
And wait till order item with clockNumber 'OTVCNOSC_ICN3' will have view status 'At Destination'
And wait till order item with clockNumber 'OTVCNOSC_ICN4' will have view status 'At Destination'
Then I 'should' see email notification for 'Order Ingestion Complete Report' with field to 'OTVCNOSC_U5' and subject 'Order Refnumber ingestion complete report' contains following attributes:
|UserName    |
|OTVCNOSC_U5 |
And I 'should' see email notification for 'Order Ingestion Complete Report' with field to 'OTVCNOSC_U6' and subject 'Order Refnumber ingestion complete report' contains following attributes:
|UserName    |
|OTVCNOSC_U6 |
And I 'should' see email notification for 'Order Ingestion Complete Report' with field to 'OTVCNOSC_U7' and subject 'Order Refnumber ingestion complete report' contains following attributes:
|UserName   |
|OTVCNOSC_U7|

