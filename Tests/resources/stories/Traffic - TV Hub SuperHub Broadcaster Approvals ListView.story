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


Scenario: Check that master can be released from Super Hub list view(All)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB20   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
| TVSUPHUB20   | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVSUPU20   |       broadcast.traffic.manager       |  TVSUPHUB20    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVSUPHUB20               |       true         |      two      |TVSUPU20 |TVSUPU20|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB20    |
And I am on agency 'TVSUPHUB20' super hub members page
And I add super hub members:
|Super Hub Members|
|TVHUB20|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC40  |TSLVCN40  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT16 |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC41  |TSLVCN41    | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT16 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN40' with following fields:
| Job Number  | PO Number |
| TSLVJN40  | TSLVPN40|
And complete order contains item with clock number 'TSLVCN41' with following fields:
| Job Number  | PO Number |
| TSLVJN41 | TSLVPN41|
And wait for finish place order with following item clock number 'TSLVCN40' to A4
And wait for finish place order with following item clock number 'TSLVCN41' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN40|
  | DefaultAgency      |   TSLVCN41 |
And login with details of 'TVSUPU20'
And wait till order with clockNumber 'TSLVCN40' will be available in Traffic
And wait till order with clockNumber 'TSLVCN41' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order item with clockNumber 'TSLVCN40' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN41' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT16' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test33              |  Proxy approved for all items |
And wait till order item with clockNumber 'TSLVCN40' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN41' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test34             |  Master Released for all items |
And wait till order item with clockNumber 'TSLVCN40' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN41' will have broadcaster status 'Delivered' in Traffic
And refresh the page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN40' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN41' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |


Scenario: Check that proxy can be rejected from Super Hub list view(All)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB21   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
| TVSUPHUB21   | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVSUPU21   |       broadcast.traffic.manager       |  TVSUPHUB21    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVSUPHUB21               |       true         |      two      |TVSUPU21 |TVSUPU21|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB21    |
And I am on agency 'TVSUPHUB21' super hub members page
And I add super hub members:
|Super Hub Members|
|TVHUB21|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC42  |TSLVCN42  | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT17 |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC43  |TSLVCN43   | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT17 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN42' with following fields:
| Job Number  | PO Number |
| TSLVJN42  | TSLVPN42|
And complete order contains item with clock number 'TSLVCN43' with following fields:
| Job Number  | PO Number |
| TSLVJN43 | TSLVPN43|
And wait for finish place order with following item clock number 'TSLVCN42' to A4
And wait for finish place order with following item clock number 'TSLVCN43' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN42|
  | DefaultAgency      |   TSLVCN43 |
And login with details of 'TVSUPU21'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN42' will be available in Traffic
And wait till order with clockNumber 'TSLVCN43' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN42' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN43' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT17' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Reject Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test35              |  Proxy rejected for all items |
And wait till order item with clockNumber 'TSLVCN42' will have broadcaster status 'Proxy Rejected' in Traffic
And wait till order item with clockNumber 'TSLVCN43' will have broadcaster status 'Proxy Rejected' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Restore Proxy' on traffic list page


Scenario: Check that common approval buttons are displayed when we select mix of broadcaster status(Proxy Ready For Approval and Escalate Proxy) from Super Hub list view(All)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB22   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
| TVSUPHUB22   | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVSUPU22   |       broadcast.traffic.manager       |  TVSUPHUB22    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVSUPHUB22               |       true         |      two      |TVSUPU22 |TVSUPU22|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB22    |
And I am on agency 'TVSUPHUB22' super hub members page
And I add super hub members:
|Super Hub Members|
|TVHUB22|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC44   |TSLVCN44    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT18   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC45  |TSLVCN45     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT18 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN44' with following fields:
| Job Number  | PO Number |
| TSLVJN44  | TSLVPN44 |
And complete order contains item with clock number 'TSLVCN45' with following fields:
| Job Number  | PO Number |
| TSLVJN45  | TSLVPN45 |
And wait for finish place order with following item clock number 'TSLVCN44' to A4
And wait for finish place order with following item clock number 'TSLVCN45' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN44 |
  | DefaultAgency      |   TSLVCN45  |
And login with details of 'TVSUPU22'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN44' will be available in Traffic
And wait till order with clockNumber 'TSLVCN45' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN44' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN45' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT18' in simple search form on Traffic Order List page
And I select following clocks from list view on traffic list page:
|Clock|
|TSLVCN44|
And I click on button 'Escalate Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test40             |  Proxy escalated for all items         |
And wait till order item with clockNumber 'TSLVCN44' will have broadcaster status 'Proxy Escalated' in Traffic
And wait till order item with clockNumber 'TSLVCN45' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT18' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Escalate Proxy' on traffic list page
And I 'should' see 'Tele 5 DE - Longform' with clock 'TSLVCN45'
And I 'should not' see 'Motorvision TV' with clock 'TSLVCN44'
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                      |
| test8             |  Proxy Escalated for all items |
And wait till order item with clockNumber 'TSLVCN45' will have broadcaster status 'Proxy Escalated' in Traffic
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN44' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Escalated               |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN45' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Escalated               |

Scenario: Check that approval is done only for the destination chosen during approval from Super Hub list View(All)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB23   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
| TVSUPHUB23   | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVSUPU23  |       broadcast.traffic.manager       |  TVSUPHUB23    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVSUPHUB23               |       true         |      two      |TVSUPU23 |TVSUPU23|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB23    |
And I am on agency 'TVSUPHUB23' super hub members page
And I add super hub members:
|Super Hub Members|
|TVHUB23|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC46  |TSLVCN46    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT19   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC47  |TSLVCN47     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT19 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN46' with following fields:
| Job Number  | PO Number |
| TSLVJN46  | TSLVPN46 |
And complete order contains item with clock number 'TSLVCN47' with following fields:
| Job Number  | PO Number |
| TSLVJN47  | TSLVPN47 |
And wait for finish place order with following item clock number 'TSLVCN46' to A4
And wait for finish place order with following item clock number 'TSLVCN47' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN46 |
  | DefaultAgency      |   TSLVCN47  |
And login with details of 'TVSUPU23'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN46' will be available in Traffic
And wait till order with clockNumber 'TSLVCN47' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN46' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN47' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT19' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Escalate Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test42             |  Proxy escalated for all items         |
And wait till order item with clockNumber 'TSLVCN46' will have broadcaster status 'Proxy Escalated' in Traffic
And wait till order item with clockNumber 'TSLVCN47' will have broadcaster status 'Proxy Escalated' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Approve Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |DeselectDestination|
| test43             |  Proxy approved for all items         |Motorvision TV - TSLVCN46|
And wait till order item with clockNumber 'TSLVCN46' will have broadcaster status 'Proxy Escalated' in Traffic
And wait till order item with clockNumber 'TSLVCN47' will have broadcaster status 'Master Ready For Approval' in Traffic
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN46' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Escalated          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN47' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Ready For Approval          |


Scenario: Check that Force Release master can be done at Order Item(Send level) from Super Hub list view
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB24   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
| TVSUPHUB24   | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVSUPU24  |       broadcast.traffic.manager       |  TVSUPHUB24    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVSUPHUB24               |       true         |      two      |TVSUPU24 |TVSUPU24|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB24    |
And I am on agency 'TVSUPHUB24' super hub members page
And I add super hub members:
|Super Hub Members|
|TVHUB24|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC48  |TSLVCN48    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT20   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC49  |TSLVCN49     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT20 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN48' with following fields:
| Job Number  | PO Number |
| TSLVJN48  | TSLVPN48 |
And complete order contains item with clock number 'TSLVCN49' with following fields:
| Job Number  | PO Number |
| TSLVJN49  | TSLVPN49 |
And wait for finish place order with following item clock number 'TSLVCN48' to A4
And wait for finish place order with following item clock number 'TSLVCN49' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN48 |
  | DefaultAgency      |   TSLVCN49  |
And login with details of 'TVSUPU24'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN48' will be available in Traffic
And wait till order with clockNumber 'TSLVCN49' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN48' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN49' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'ForceReleaseMas_ListView' and type 'Order Item Send' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Broadcaster Approval Status | Match | Proxy Ready For Approval |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVT20' in simple search form on Traffic Order List page
And I select all from list view at 'Send' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Force Release Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test45             |  master released forcefully for all items         |
And wait till order item with clockNumber 'TSLVCN48' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN49' will have broadcaster status 'Delivered' in Traffic
And I open Traffic Order List page
And enter search criteria 'TSLVT20' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN48' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN49' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |


Scenario: Check that master can be restored and approved  at Order Item Clock level from Super Hub list view
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB25   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
| TVSUPHUB25   | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVSUPU25  |       broadcast.traffic.manager       |  TVSUPHUB25    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVSUPHUB25               |       true         |      two      |TVSUPU25 |TVSUPU25|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB25    |
And I am on agency 'TVSUPHUB25' super hub members page
And I add super hub members:
|Super Hub Members|
|TVHUB25|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC50  |TSLVCN50    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVClk06   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC51  |TSLVCN51     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVClk06 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN50' with following fields:
| Job Number  | PO Number |
| TSLVJN50  | TSLVPN50 |
And complete order contains item with clock number 'TSLVCN51' with following fields:
| Job Number  | PO Number |
| TSLVJN51  | TSLVPN51 |
And wait for finish place order with following item clock number 'TSLVCN50' to A4
And wait for finish place order with following item clock number 'TSLVCN51' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN50 |
  | DefaultAgency      |   TSLVCN51  |
And login with details of 'TVSUPU25'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN50' will be available in Traffic
And wait till order with clockNumber 'TSLVCN51' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN50' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN51' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'Proxy_ListView' and type 'Order Item Clock' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  TSLVClk06   |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TSLVClk06' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test45           |  Proxy approved for all items         |
And wait till order item with clockNumber 'TSLVCN50' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN51' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Reject Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test46            |  master rejected for all items         |
And wait till order item with clockNumber 'TSLVCN50' will have broadcaster status 'Master Rejected' in Traffic
And wait till order item with clockNumber 'TSLVCN51' will have broadcaster status 'Master Rejected' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Restore Master' on traffic list page
When I click on button 'Restore Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test47             |  Master restored for all items         |
And wait till order item with clockNumber 'TSLVCN50' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN51' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test48            |  Master released for all items         |
And wait till order item with clockNumber 'TSLVCN50' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN51' will have broadcaster status 'Delivered' in Traffic
And refresh the page
And enter search criteria 'TSLVClk06' in simple search form on Traffic Order List page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN50' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN51' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |

Scenario: Check that Force Release Master button is not disabled and the destination is deselected when we have mix of clocks with and without house number mandatory from list View(All)
Meta: @criticaltraffictests
@qatrafficsmoke
@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB26   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU26    |       broadcast.traffic.manager       |  TVHUB26     | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB26                  |       true         |      two      |HUBU26|HUBU26|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgency7390| TVHUB26    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC22   |TSLVCN52   | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT52  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC23  |TSLVCN53    | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT52 |  Moviepilot:Express             |
And complete order contains item with clock number 'TSLVCN52' with following fields:
| Job Number  | PO Number |
| TSLVJN52  | TSLVPN52 |
And complete order contains item with clock number 'TSLVCN53' with following fields:
| Job Number  | PO Number |
| TSLVJN53  | TSLVPN53 |
And wait for finish place order with following item clock number 'TSLVCN52' to A4
And wait for finish place order with following item clock number 'TSLVCN53' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN52 |
  | DefaultAgency      |   TSLVCN53  |
And login with details of 'HUBU26'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN52' will be available in Traffic
And wait till order with clockNumber 'TSLVCN53' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN52' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN53' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT52' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Force Release Master' on traffic list page
Then I 'should' see the destination 'Moviepilot' unselected
When I fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test52             |  force release master for all items |
And wait till order item with clockNumber 'TSLVCN52' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN53' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN52' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'Moviepilot' for order item with clockNumber 'TSLVCN53' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Ready For Approval          |

Scenario: Check that master is released for clones from Hub list View(All)
Meta: @qatrafficsmoke
@traffic
!--NIR-1387
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB27     | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU27    |       broadcast.traffic.manager       |  TVHUB27       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB27                      |       true         |      two      |HUBU27|HUBU27|
And I am on agency 'TVHUB27' hub members page
And I add hub members:
|Hub Members|
|BroadCasterAgency49618|
|BroadCasterAgency59065|
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TSLVAR1     | TSLVBR1     | TSLVSB1     | TSLVSP1    | TSLVC22    | TSLVCN54     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TSLVT54 |           |
When I open order item with following clock number 'TSLVCN54'
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
| TSLVJN54    | TSLVPO54  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TSLVCN54' to A4
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  DefaultAgency   | TSLVCN54       | Airdate Traffic Services|
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations                                 |
|  DefaultAgency   | TSLVCN54       | CBC Vancouver                             |
And login with details of 'HUBU27'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN54' will be available in Traffic
And wait till cloned order with clockNumber 'TSLVCN54' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'TSLVCN54' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'CBC Vancouver'
And enter search criteria 'TSLVT54' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test1              |  Proxy approved for all items |
And wait till cloned order with clockNumber 'TSLVCN54' will have broadcaster status 'Master Ready For Approval' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'TSLVCN54' will have broadcaster status 'Master Ready For Approval' in Traffic for destination 'CBC Vancouver'
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test2              |  Master Released for all items |
And wait till cloned order with clockNumber 'TSLVCN54' will have broadcaster status 'Master Released' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'TSLVCN54' will have broadcaster status 'Master Released' in Traffic for destination 'CBC Vancouver'
Then I should see destination 'Airdate Traffic Services' for cloned order item with clockNumber 'TSLVCN54' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Released          |
And I should see destination 'CBC Vancouver' for cloned order item with clockNumber 'TSLVCN54' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Released          |


Scenario: Check that approval is done only for the destination chosen during approval for clones from Hub list View(All)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB28    | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU28    |       broadcast.traffic.manager       |  TVHUB28       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB28                     |       true         |      two      |HUBU28|HUBU28|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgency49618,BroadCasterAgency59065  | TVHUB28    |
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TSLVAR1     | TSLVBR1     | TSLVSB1     | TSLVSP1    | TSLVC23    | TSLVCN55     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TSLVT55 |           |
When I open order item with following clock number 'TSLVCN55'
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
| TSLVJN55    | TSLVPO55  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TSLVCN55' to A4
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  DefaultAgency   | TSLVCN55       | Airdate Traffic Services|
When ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations                                 |
|  DefaultAgency   | TSLVCN55       | CBC Vancouver                             |
And login with details of 'HUBU28'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And I wait till order with clockNumber 'TSLVCN55' will be available in Traffic
And wait till cloned order with clockNumber 'TSLVCN55' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'TSLVCN55' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'CBC Vancouver'
And enter search criteria 'TSLVT55' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test1              |  Proxy approved for all items |
And wait till cloned order with clockNumber 'TSLVCN55' will have broadcaster status 'Master Ready For Approval' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'TSLVCN55' will have broadcaster status 'Master Ready For Approval' in Traffic for destination 'CBC Vancouver'
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |DeselectDestination|
| test2              |  Master Released for all items | CBC Vancouver - TSLVCN55   |
And wait till cloned order with clockNumber 'TSLVCN55' will have broadcaster status 'Master Released' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'TSLVCN55' will have broadcaster status 'Master Ready For Approval' in Traffic for destination 'CBC Vancouver'
Then I should see destination 'Airdate Traffic Services' for cloned order item with clockNumber 'TSLVCN55' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Released          |
And I should see destination 'CBC Vancouver' for cloned order item with clockNumber 'TSLVCN55' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Ready For Approval        |



Scenario: Check that broadcsater status gets updated automatically for the destination that has house number set as non mandatory when a clock is having mix of destination with and without house number mandatory from list View(All)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB29  | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU29    |       broadcast.traffic.manager       |  TVHUB29    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB29                  |       true         |      two      |HUBU29|HUBU29|
And I am on agency 'TVHUB29' hub members page
And I add hub members:
|Hub Members|
|BroadCasterAgencyTwoStage|
|BroadCasterAgency7390|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC56  |TSLVCN56   | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT56  |  Motorvision TV:Express;Moviepilot:Express      |
And complete order contains item with clock number 'TSLVCN56' with following fields:
| Job Number  | PO Number |
| TSLVJN56  | TSLVPN56 |
And wait for finish place order with following item clock number 'TSLVCN56' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 |DefaultAgency|TSLVCN56|
And login with details of 'HUBU29'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN56' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN56' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Motorvision TV'
And wait till order item with clockNumber 'TSLVCN56' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Moviepilot'
And enter search criteria 'TSLVT56' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                                          |
| test56          |  Proxy approved for all items         |
And wait till order item with clockNumber 'TSLVCN56' will have broadcaster status 'Master Ready For Approval' in Traffic for destination 'Motorvision TV'
And wait till order item with clockNumber 'TSLVCN56' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Moviepilot'
And refresh the page
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN56' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Ready For Approval          |
And I should see destination 'Moviepilot' for order item with clockNumber 'TSLVCN56' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Ready For Approval          |


