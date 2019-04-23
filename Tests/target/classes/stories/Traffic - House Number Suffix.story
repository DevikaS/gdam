Feature:   Traffic BT User can see house number suffix
Narrative:
In order to
As a              GlobalAdmin
I want to check that BT user can add HN

Scenario: Check that BTM can see House Number with automatically added suffix for TV Broadcaster
Meta:@traffic
     @qatrafficsmoke
     @uattrafficsmoke
Given logged in with details of 'AgencyAdmin'
And I updated the following agency:
| Name                       | House Number Suffix|
| BroadCasterAgencyOneStage  |  HNS               |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product| Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format        | Title      |     Destination           |
| automated test info    | THNSAR1    | THNSBR1    | THNSSB1    | THNSSP1| THNSCP1    |  THNSCN1   | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | THNST1     | TV Bayern Media:Express  |
And complete order contains item with clock number 'THNSCN1' with following fields:
| Job Number  | PO Number |
| THNSJN0     | THNSPO0   |
And wait for finish place order with following item clock number 'THNSCN1' to A4
When login with details of 'broadcasterTrafficManagerOne'
And I wait till order with clockNumber 'THNSCN1' will be available in Traffic
And I amon order item details page of clockNumber 'THNSCN1'
And fill house number field with value '123' on order details page in traffic
And refresh the page
And I 'should' see house number suffix 'HNS' on order details page in traffic
And I click on 'Back' button on order details page in traffic
And wait till order item list will be loaded in Traffic
And I create tab with name 'Send' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition   | Condition Type |  Value  |
| Clock Number |    Match       |  THNSCN1 |
And wait till order item list will be loaded in Traffic
Then I 'should' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| VerfyData   |
|  HNS        |
When login with details of 'trafficManager'
And I wait till order with clockNumber 'THNSCN1' will be available in Traffic
And I create tab with name 'Send' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition   | Condition Type |  Value  |
| Clock Number  |    Match       |  THNSCN1 |
And wait till order item list will be loaded in Traffic
Then I 'should' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| VerfyData   |
|  HNS        |


Scenario: Check HNS is automatically suffixed and not suffixed when a hub has multiple destination with and without suffix(without grouping)
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I updated the following agency:
| Name                          | Escalation Enabled | Approval Type |Proxy Approver                  | Master Approver                 |House Number Suffix|
| BroadCasterAgency7429         |       true         |      two      |broadcasterTrafficManager7429   |broadcasterTrafficManager7429    |HNSS2              |
| BroadCasterAgencyTwoStage_1   |       true         |      two      |broadcasterTrafficManagerTwo_1  |broadcasterTrafficManagerTwo_1   |                   |
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser   | Brand          | Sub Brand     | Product       |
| THNSAR       | THNSBR1        | THNSSB1       | THNSSP1       |
And I created the following agency:
| Name     | A4User           | AgencyType        | Market         |DestinationID|Application Access|
| THNSHUB01| DefaultA4User    | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email         |           Role                      | AgencyUnique|  Access  |
| THNSHUB_U1    |       broadcast.traffic.manager     |  THNSHUB01  | adpath   |
And I updated the following agency:
| Name        | Escalation Enabled | Approval Type |Proxy Approver  | Master Approver |
| THNSHUB01   |       true         |      two       |THNSHUB_U1      |THNSHUB_U1|
And I add hub members via API:
| Hub Members                                        | Name      |
| BroadCasterAgency7429, BroadCasterAgencyTwoStage_1 | THNSHUB01 |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'MENA' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | THNSAR    | THNSBR1    | THNSSB1    | THNSP1    | THNSC1    |THNSCN2     | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | THNST1    |  SpaceToon:Standard     |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | THNSAR    | THNSBR1    | THNSSB1    | THNSP1    | THNSC2    |THNSCN3     | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | THNST2    | Tele 5 DE - Longform:Express      |
And complete order contains item with clock number 'THNSCN2' with following fields:
| Job Number  | PO Number |
| THNSJN1   | THNSPO1 |
And complete order contains item with clock number 'THNSCN3' with following fields:
| Job Number  | PO Number |
| THNSJN2   | THNSPO2 |
When login with details of 'THNSHUB_U1'
And I wait till order with clockNumber 'THNSCN2' will be available in Traffic
And I wait till order with clockNumber 'THNSCN3' will be available in Traffic
And I amon order item details page of clockNumber 'THNSCN2'
And fill house number field with value '50' on order details page in traffic
And wait for '5' seconds
Then 'should' see house number suffix 'HNSS2' on order details page in traffic
When I amon order item details page of clockNumber 'THNSCN3'
And fill house number field with value '51' on order details page in traffic
Then 'should not' see house number suffix '' on order details page in traffic
And open Traffic Order List page
When I create tab with name 'Send' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition   | Condition Type |  Value   |
| Advertiser   |    Match       |  THNSAR |
And wait till order item list will be loaded in Traffic
Then I 'should' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| HouseNumber | Suffix |
|  50         | HNSS2  |
|  51         |        |
When login with details of 'trafficManager'
And I wait till order with clockNumber 'THNSCN2' will be available in Traffic
And I wait till order with clockNumber 'THNSCN3' will be available in Traffic
And I create tab with name 'Send' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition   | Condition Type |  Value   |
| Advertiser   |    Match       |  THNSAR |
And wait till order item list will be loaded in Traffic
Then I 'should' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| HouseNumber | Suffix|
|  50         | HNSS2 |
|  51         |       |