Feature:    TV Broadcaster Hub and Super Hub Approval functionality from List View
Narrative:
In order to
As a              AgencyAdmin
I want to check the two stage approval feature from List View for Hub and Super Hub

Lifecycle:
Before:
Given I updated the following agency:
| Name                          | Escalation Enabled | Approval Type |Proxy Approver                 | Master Approver                 |
| BroadCasterAgencyTwoStage     |       true         |      two      |broadcasterTrafficManagerTwo   |broadcasterTrafficManagerTwo     |
| BroadCasterAgencyTwoStage_1   |       true         |      two      |broadcasterTrafficManagerTwo_1 |broadcasterTrafficManagerTwo_1   |
| BroadCasterAgency7390   |       true         |      two      |broadcasterTrafficManager7390 |broadcasterTrafficManager7390   |
| BroadCasterAgency49618   |       true         |      two      |broadcasterTrafficManager49618 |broadcasterTrafficManager49618   |
| BroadCasterAgency59065   |       true         |      two      |broadcasterTrafficManager59065 |broadcasterTrafficManager59065   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TSLVAR1     | TSLVBR1     | TSLVSB1     | TSLVSP1    |


Scenario: Check that master is released at Order Item Send level from Hub list view
Meta: @qatrafficsmoke
@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB11   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU11    |       broadcast.traffic.manager       |  TVHUB11      | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB11                  |       true         |      two      |HUBU11|HUBU11|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB11    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC22   |TSLVCN22    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT12  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC23  |TSLVCN23     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT12 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN22' with following fields:
| Job Number  | PO Number |
| TSLVJN22  | TSLVPN22 |
And complete order contains item with clock number 'TSLVCN23' with following fields:
| Job Number  | PO Number |
| TSLVJN23  | TSLVPN23 |
And wait for finish place order with following item clock number 'TSLVCN22' to A4
And wait for finish place order with following item clock number 'TSLVCN23' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN22 |
  | DefaultAgency      |   TSLVCN23  |
And login with details of 'HUBU11'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN22' will be available in Traffic
And wait till order with clockNumber 'TSLVCN23' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN22' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN23' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'PROXY_ListView' and type 'Order Item Send' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Proxy Ready For Approval |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVT12' in simple search form on Traffic Order List page
And I select all from list view at 'Send' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test20             |  Proxy approved for all items         |
And wait till order item with clockNumber 'TSLVCN22' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN23' will have broadcaster status 'Master Ready For Approval' in Traffic
And I create tab with name 'Master_ListView' and type 'Order Item Send' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Master Ready For Approval |
And wait till order item list will be loaded in Traffic
And refresh the page
And enter search criteria 'TSLVT12' in simple search form on Traffic Order List page
And I select all from list view at 'Send' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test21              |  Master Released for all items |
And wait till order item with clockNumber 'TSLVCN22' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN23' will have broadcaster status 'Delivered' in Traffic
And I open Traffic Order List page
And enter search criteria 'TSLVT12' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN22' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN23' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |



Scenario: Check that proxy is escalated and rejected at Order Item Send level from Hub list view
Meta: @traffic
!--NIR-1137
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB12   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU12    |       broadcast.traffic.manager       |  TVHUB12      | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB12                 |       true         |      two      |HUBU12|HUBU12|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB12    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC24   |TSLVCN24    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT13  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC25  |TSLVCN25     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT13 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN24' with following fields:
| Job Number  | PO Number |
| TSLVJN24  | TSLVPN24 |
And complete order contains item with clock number 'TSLVCN25' with following fields:
| Job Number  | PO Number |
| TSLVJN25  | TSLVPN25 |
And wait for finish place order with following item clock number 'TSLVCN24' to A4
And wait for finish place order with following item clock number 'TSLVCN25' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN24 |
  | DefaultAgency      |   TSLVCN25  |
And login with details of 'HUBU12'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN24' will be available in Traffic
And wait till order with clockNumber 'TSLVCN25' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN24' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN25' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'PROXY_ListView' and type 'Order Item Send' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Proxy Ready For Approval |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVT13' in simple search form on Traffic Order List page
And I select all from list view at 'Send' level on traffic list page
And I click on button 'Escalate Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test22             |  Proxy escalated for all items         |
And wait till order item with clockNumber 'TSLVCN24' will have broadcaster status 'Proxy Escalated' in Traffic
And wait till order item with clockNumber 'TSLVCN25' will have broadcaster status 'Proxy Escalated' in Traffic
And I create tab with name 'ProxyEscalated_ListView' and type 'Order Item Send' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Proxy Escalated |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVT13' in simple search form on Traffic Order List page
And I select all from list view at 'Send' level on traffic list page
Then I should see the approval buttons 'Approve Proxy,Reject Proxy' on traffic list page
When I click on button 'Reject Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test23              |  proxy rejected for all items |
And wait till order item with clockNumber 'TSLVCN24' will have broadcaster status 'Proxy Rejected' in Traffic
And wait till order item with clockNumber 'TSLVCN25' will have broadcaster status 'Proxy Rejected' in Traffic
And I open Traffic Order List page
And enter search criteria 'TSLVT13' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN24' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Rejected          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN25' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Rejected          |


Scenario: Check that master is escalated and rejected at Order Item Send level from Hub list view
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB13   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU13    |       broadcast.traffic.manager       |  TVHUB13      | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB13                |       true         |      two      |HUBU13  |HUBU13|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB13    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC26   |TSLVCN26    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT14  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC27  |TSLVCN27     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT14 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN26' with following fields:
| Job Number  | PO Number |
| TSLVJN26  | TSLVPN26 |
And complete order contains item with clock number 'TSLVCN27' with following fields:
| Job Number  | PO Number |
| TSLVJN27  | TSLVPN27 |
And wait for finish place order with following item clock number 'TSLVCN26' to A4
And wait for finish place order with following item clock number 'TSLVCN27' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN26 |
  | DefaultAgency      |   TSLVCN27  |
And login with details of 'HUBU13'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN26' will be available in Traffic
And wait till order with clockNumber 'TSLVCN27' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN26' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN27' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'PROXY_ListView' and type 'Order Item Send' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Proxy Ready For Approval |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVT14' in simple search form on Traffic Order List page
And I select all from list view at 'Send' level on traffic list page
And I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test24             |  Proxy approved for all items         |
And wait till order item with clockNumber 'TSLVCN26' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN27' will have broadcaster status 'Master Ready For Approval' in Traffic
And I create tab with name 'MasterReady_ListView' and type 'Order Item Send' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Master Ready For Approval |
And wait till order item list will be loaded in Traffic
And refresh the page
And enter search criteria 'TSLVT14' in simple search form on Traffic Order List page
And I select all from list view at 'Send' level on traffic list page
And I click on button 'Reject Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test25              |  master rejected for all items |
And wait till order item with clockNumber 'TSLVCN26' will have broadcaster status 'Master Rejected' in Traffic
And wait till order item with clockNumber 'TSLVCN27' will have broadcaster status 'Master Rejected' in Traffic
And I open Traffic Order List page
And enter search criteria 'TSLVT14' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN26' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Rejected          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN27' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Rejected          |



Scenario: Check that approval is done only for the destination chosen during approval at Oreder Item Send level from Hub list View
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB14   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU14   |       broadcast.traffic.manager       |  TVHUB14      | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB14                |       true         |      two      |HUBU14  |HUBU14|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB14    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC28  |TSLVCN28    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT15  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC29  |TSLVCN29     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT15 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN28' with following fields:
| Job Number  | PO Number |
| TSLVJN28  | TSLVPN28 |
And complete order contains item with clock number 'TSLVCN29' with following fields:
| Job Number  | PO Number |
| TSLVJN29  | TSLVPN29|
And wait for finish place order with following item clock number 'TSLVCN28' to A4
And wait for finish place order with following item clock number 'TSLVCN29' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN28 |
  | DefaultAgency      |   TSLVCN29  |
And login with details of 'HUBU14'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN28' will be available in Traffic
And wait till order with clockNumber 'TSLVCN29' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN28' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN29' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'PROXY_ListView' and type 'Order Item Send' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Proxy Ready For Approval |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVT15' in simple search form on Traffic Order List page
And I select all from list view at 'Send' level on traffic list page
And I click on button 'Force Release Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |DeselectDestination|
| test24             |  Released master forcefully for all items         |Tele 5 DE - Longform - TSLVCN29|
And wait till order item with clockNumber 'TSLVCN28' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN29' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I open Traffic Order List page
And enter search criteria 'TSLVT15' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN28' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN29' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Ready For Approval          |


Scenario: Check that master is released at Order Item Clock level from Hub list view
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB15   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU15   |       broadcast.traffic.manager       |  TVHUB15     | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB15                |       true         |      two      |HUBU15  |HUBU15|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB15    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC30  |TSLVCN30   | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVClk01  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC31  |TSLVCN31     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVClk01 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN30' with following fields:
| Job Number  | PO Number |
| TSLVJN30  | TSLVPN31 |
And complete order contains item with clock number 'TSLVCN31' with following fields:
| Job Number  | PO Number |
| TSLVJN30  | TSLVPN31|
And wait for finish place order with following item clock number 'TSLVCN30' to A4
And wait for finish place order with following item clock number 'TSLVCN31' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN30 |
  | DefaultAgency      |   TSLVCN31  |
And login with details of 'HUBU15'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN30' will be available in Traffic
And wait till order with clockNumber 'TSLVCN31' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN30' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN31' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'Proxy_ListView' and type 'Order Item Clock' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  TSLVClk01   |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVClk01' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test26            |  Proxy approved for all items         |
And wait till order item with clockNumber 'TSLVCN30' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN31' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test27             |  Master released for all items         |
And wait till order item with clockNumber 'TSLVCN30' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN31' will have broadcaster status 'Delivered' in Traffic
And I open Traffic Order List page
And enter search criteria 'TSLVClk01' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN30' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN31' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |


Scenario: Check that proxy can be restored and approved  at Order Item Clock level from Hub list view
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB16   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU16   |       broadcast.traffic.manager       |  TVHUB16     | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB16                |       true         |      two      |HUBU16 |HUBU16|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB16    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC32  |TSLVCN32  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVClk02  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC33  |TSLVCN33    | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVClk02 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN32' with following fields:
| Job Number  | PO Number |
| TSLVJN32  | TSLVPN32|
And complete order contains item with clock number 'TSLVCN33' with following fields:
| Job Number  | PO Number |
| TSLVJN33  | TSLVPN33|
And wait for finish place order with following item clock number 'TSLVCN32' to A4
And wait for finish place order with following item clock number 'TSLVCN33' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN32 |
  | DefaultAgency      |   TSLVCN33  |
And login with details of 'HUBU16'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN32' will be available in Traffic
And wait till order with clockNumber 'TSLVCN33' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN32' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN33' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'Proxy_ListView' and type 'Order Item Clock' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  TSLVClk02   |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVClk02' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Reject Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test26            |  Proxy rejected for all items         |
And wait till order item with clockNumber 'TSLVCN32' will have broadcaster status 'Proxy Rejected' in Traffic
And wait till order item with clockNumber 'TSLVCN33' will have broadcaster status 'Proxy Rejected' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Restore Proxy' on traffic list page
When I click on button 'Restore Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test27             |  Proxy restored for all items         |
And wait till order item with clockNumber 'TSLVCN32' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN33' will have broadcaster status 'Proxy Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test27             |  Proxy approved for all items         |
And wait till order item with clockNumber 'TSLVCN32' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN33' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'TSLVClk02' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN32' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Ready For Approval          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN33' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Ready For Approval          |


Scenario: Check that master can be restored and approved  at Order Item Clock level from Hub list view
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB17   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU17   |       broadcast.traffic.manager       |  TVHUB17     | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB17                |       true         |      two      |HUBU17 |HUBU17|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB17    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC34  |TSLVCN34  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVClk03  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC35  |TSLVCN35    | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVClk03 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN34' with following fields:
| Job Number  | PO Number |
| TSLVJN34  | TSLVPN34|
And complete order contains item with clock number 'TSLVCN35' with following fields:
| Job Number  | PO Number |
| TSLVJN35  | TSLVPN35|
And wait for finish place order with following item clock number 'TSLVCN34' to A4
And wait for finish place order with following item clock number 'TSLVCN35' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN34 |
  | DefaultAgency      |   TSLVCN35 |
And login with details of 'HUBU17'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN34' will be available in Traffic
And wait till order with clockNumber 'TSLVCN35' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN34' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN35' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'Proxy_ListView' and type 'Order Item Clock' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  TSLVClk03   |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVClk03' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test28           |  Proxy approved for all items         |
And wait till order item with clockNumber 'TSLVCN34' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN35' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Reject Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test29             |  master rejected for all items         |
And wait till order item with clockNumber 'TSLVCN34' will have broadcaster status 'Master Rejected' in Traffic
And wait till order item with clockNumber 'TSLVCN35' will have broadcaster status 'Master Rejected' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Restore Master' on traffic list page
When I click on button 'Restore Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test30             |  Master restored for all items         |
And wait till order item with clockNumber 'TSLVCN34' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN35' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test31            |  Master released for all items         |
And wait till order item with clockNumber 'TSLVCN34' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN35' will have broadcaster status 'Delivered' in Traffic
And refresh the page
And enter search criteria 'TSLVClk03' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN34' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN35' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |

Scenario: Check that approval is done only for the destination chosen during approval at Oreder Item Clock level from Hub list View
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB18   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU18   |       broadcast.traffic.manager       |  TVHUB18    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB18                |       true         |      two      |HUBU18 |HUBU18|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB18    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC36  |TSLVCN36  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVClk04  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC37  |TSLVCN37    | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVClk04 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN36' with following fields:
| Job Number  | PO Number |
| TSLVJN36  | TSLVPN36|
And complete order contains item with clock number 'TSLVCN37' with following fields:
| Job Number  | PO Number |
| TSLVJN37  | TSLVPN37|
And wait for finish place order with following item clock number 'TSLVCN36' to A4
And wait for finish place order with following item clock number 'TSLVCN37' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN36 |
  | DefaultAgency      |   TSLVCN37 |
And login with details of 'HUBU18'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN36' will be available in Traffic
And wait till order with clockNumber 'TSLVCN37' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN36' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN37' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'Proxy_ListView' and type 'Order Item Clock' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  TSLVClk04   |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVClk04' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Force Release Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |DeselectDestination|
| test31           |  Master released forcefully for all items         |Motorvision TV - TSLVCN36|
And wait till order item with clockNumber 'TSLVCN36' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN37' will have broadcaster status 'Delivered' in Traffic
And refresh the page
And enter search criteria 'TSLVClk04' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN36' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Ready For Approval          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN37' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |

Scenario: Check that common approval buttons are displayed when we select mix of broadcaster status(Proxy Ready For Approval and Escalate Proxy) at Order Item Clock level from Hub list view
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB19   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU19   |       broadcast.traffic.manager       |  TVHUB19    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB19                |       true         |      two      |HUBU19 |HUBU19|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB19    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC38  |TSLVCN38  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVClk05  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC39  |TSLVCN39    | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVClk05 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN38' with following fields:
| Job Number  | PO Number |
| TSLVJN38  | TSLVPN38|
And complete order contains item with clock number 'TSLVCN39' with following fields:
| Job Number  | PO Number |
| TSLVJN39 | TSLVPN39|
And wait for finish place order with following item clock number 'TSLVCN38' to A4
And wait for finish place order with following item clock number 'TSLVCN39' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN38 |
  | DefaultAgency      |   TSLVCN39 |
And login with details of 'HUBU19'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN38' will be available in Traffic
And wait till order with clockNumber 'TSLVCN39' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN38' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN39' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'Proxy_ListView' and type 'Order Item Clock' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  TSLVClk05   |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVClk05' in simple search form on Traffic Order List page
And I select following clocks from list view on traffic list page:
|Clock|
|TSLVCN38|
And I click on button 'Escalate Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test32             |  Proxy escalated for all items         |
And wait till order item with clockNumber 'TSLVCN38' will have broadcaster status 'Proxy Escalated' in Traffic
And wait till order item with clockNumber 'TSLVCN39' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVClk05' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page