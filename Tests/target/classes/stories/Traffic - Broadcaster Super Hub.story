Feature:    Traffic TV Broadcaster Super  Hub functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check feature of TV broadcaster super hub

Lifecycle:
Before:
Given updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo      |      broadcasterTrafficManagerTwo     |
| BroadCasterAgencyOneStage  |       true         |      one      |  |broadcasterTrafficManagerOne |

Scenario: Check that broadcaster super hub can only see the orders belong to his hub members-not other TV broadcaster
!--NGN-16253
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TBSHA_4     | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
| TBSHA_5     | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TBSHU_2    |       broadcast.traffic.manager       |  TBSHA_5       | adpath   |
And I logged in as 'GlobalAdmin'
And I am on agency 'TBSHA_4' hub members page
And waited for '4' seconds
And I add hub members:
|Hub Members|
|BroadCasterAgencyTwoStage|
|BroadCasterAgencyOneStage|
And I am on agency 'TBSHA_5' super hub members page
And I add super hub members:
|Super Hub Members|
|TBSHA_4|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TBSHAR1    | TBSHBR1    | TBSHSB1    | TBSHP1    | TBSHC1    |TBSHCN_1      | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TBSHT1    |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TBSHAR2    | TBSHBR2    | TBSHSB2    | TBSHP2    | TBSHC2    |TBSHCN_2      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TBSHT2 |  TV Bayern Media:Express             |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TBSHAR3    | TBSHBR3    | TBSHSB3    | TBSHP3     | TBSHC3   |TBSHCN_3      | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps | TBSHT3      |  Viacom DE:Express |
And I complete order contains item with clock number 'TBSHCN_1' with following fields:
| Job Number  | PO Number |
| TBSHJN1   | TBSHPO1 |
And complete order contains item with clock number 'TBSHCN_2' with following fields:
| Job Number  | PO Number |
| TBSHJN2   | TBSHPO2 |
And complete order contains item with clock number 'TBSHCN_3' with following fields:
| Job Number  | PO Number |
| TBSHJN3     | TBSHPO3 |
And I logged in with details of 'TBSHU_2'
And I waited till order with clockNumber 'TBSHCN_1' will be available in Traffic
And I waited till order with clockNumber 'TBSHCN_2' will be available in Traffic
And I waited till order with clockNumber 'TBSHCN_3' will be available in Traffic
And I have refreshed the page
And waited for '5' seconds
And I selected 'All' tab in Traffic UI
Then 'should' see orderItems 'TBSHCN_1' in order item list in Traffic
And 'should' see orderItems 'TBSHCN_2' in order item list in Traffic
And 'should not' see orderItems 'TBSHCN_3' in order item list in Traffic


