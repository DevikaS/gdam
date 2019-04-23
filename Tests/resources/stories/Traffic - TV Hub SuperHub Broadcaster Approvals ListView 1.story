Feature:    TV Broadcaster Hub and Super Hub Approval functionality from List View 1
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

Scenario: Check that master can be released from Hub list View(All)
Meta: @traffic
      @trafficemails
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB1     | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU1    |       broadcast.traffic.manager       |  TVHUB1       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB1                      |       true         |      two      |HUBU1|HUBU1|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB1    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC1    |TSLVCN1      | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT1    |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC2    |TSLVCN2      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT1 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN1' with following fields:
| Job Number  | PO Number |
| TSLVJN1  | TSLVPN1 |
And complete order contains item with clock number 'TSLVCN2' with following fields:
| Job Number  | PO Number |
| TSLVJN2  | TSLVPN2 |
And wait for finish place order with following item clock number 'TSLVCN1' to A4
And wait for finish place order with following item clock number 'TSLVCN2' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN1 |
  | DefaultAgency      |   TSLVCN2   |
And login with details of 'HUBU1'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN1' will be available in Traffic
And wait till order with clockNumber 'TSLVCN2' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT1' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test1              |  Proxy approved for all items |
And wait till order item with clockNumber 'TSLVCN1' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN2' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test2              |  Master Released for all items |
And wait till order item with clockNumber 'TSLVCN1' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN2' will have broadcaster status 'Delivered' in Traffic
Then I 'should' see email notification for 'Preview file for has been approved' with field to 'test1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TSLVCN1     | TSLVAR1     | TSLVSP1  | TSLVT1 | 20       | Motorvision TV | Proxy approved for all items |
And I 'should' see email notification for 'Preview file for has been approved' with field to 'test1' and subject 'Preview file for clockNumber has been approved' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TSLVCN2     | TSLVAR1     | TSLVSP1  | TSLVT1 | 20       | Tele 5 DE - Longform | Proxy approved for all items |
And I 'should' see email notification for 'has been released for delivery' with field to 'test2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TSLVCN1     | TSLVAR1     | TSLVSP1  | TSLVT1 | 20       | Motorvision TV | Master Released for all items |
And I 'should' see email notification for 'has been released for delivery' with field to 'test2' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| TSLVCN2     | TSLVAR1     | TSLVSP1  | TSLVT1 | 20       | Tele 5 DE - Longform | Master Released for all items |


Scenario: Check that proxy can be rejected and restored from Hub list View(All)
Meta: @traffic
      @trafficemails
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB2    | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU2    |       broadcast.traffic.manager       |  TVHUB2       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB2                      |       true         |      two      |HUBU2|HUBU2|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB2    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC3    |TSLVCN3      | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT2    |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC4    |TSLVCN4      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT2 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN3' with following fields:
| Job Number  | PO Number |
| TSLVJN2  | TSLVPN2 |
And complete order contains item with clock number 'TSLVCN4' with following fields:
| Job Number  | PO Number |
| TSLVJN3  | TSLVPN3 |
And wait for finish place order with following item clock number 'TSLVCN3' to A4
And wait for finish place order with following item clock number 'TSLVCN4' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN3 |
  | DefaultAgency      |   TSLVCN4   |
And login with details of 'HUBU2'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN3' will be available in Traffic
And wait till order with clockNumber 'TSLVCN4' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN4' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT2' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Reject Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test3             |  Proxy rejected for all items |
And wait till order item with clockNumber 'TSLVCN3' will have broadcaster status 'Proxy Rejected' in Traffic
And wait till order item with clockNumber 'TSLVCN4' will have broadcaster status 'Proxy Rejected' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Restore Proxy' on traffic list page
When I click on button 'Restore Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment
| test4              |  Proxy Restored for all items |
And wait till order item with clockNumber 'TSLVCN3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN4' will have broadcaster status 'Proxy Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
And I 'should' see email notification for 'Preview file for has been rejected' with field to 'test3' and subject 'Preview file for clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TSLVCN3     | TSLVAR1     | TSLVSP1  | TSLVT2 | 20       | Motorvision TV | Proxy rejected for all items |
And I 'should' see email notification for 'Preview file for has been rejected' with field to 'test3' and subject 'Preview file for clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TSLVCN4     | TSLVAR1     | TSLVSP1  | TSLVT2 | 20       | Tele 5 DE - Longform | Proxy rejected for all items |
And 'should' see email notification for 'Preview file for has been restored' with field to 'test4' and subject 'Preview file for clockNumber has been restored' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TSLVCN3     | TSLVAR1     | TSLVSP1  | TSLVT2 | 20       | Motorvision TV | Proxy Restored for all items |
And 'should' see email notification for 'Preview file for has been restored' with field to 'test4' and subject 'Preview file for clockNumber has been restored' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                             |
| TSLVCN4     | TSLVAR1     | TSLVSP1  | TSLVT2 | 20       | Tele 5 DE - Longform | Proxy Restored for all items |

Scenario: Check that proxy can be escalated and approved from Hub list View(All)
Meta: @traffic
      @trafficemails
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB3   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU3    |       broadcast.traffic.manager       |  TVHUB3       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB3                      |       true         |      two      |HUBU3|HUBU3|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB3    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC5    |TSLVCN5      | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT3    |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC6   |TSLVCN6      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT3 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN5' with following fields:
| Job Number  | PO Number |
| TSLVJN5  | TSLVPN5 |
And complete order contains item with clock number 'TSLVCN6' with following fields:
| Job Number  | PO Number |
| TSLVJN6  | TSLVPN6 |
And wait for finish place order with following item clock number 'TSLVCN5' to A4
And wait for finish place order with following item clock number 'TSLVCN6' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN5 |
  | DefaultAgency      |   TSLVCN6  |
And login with details of 'HUBU3'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN5' will be available in Traffic
And wait till order with clockNumber 'TSLVCN6' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN5' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN6' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT3' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Escalate Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test5             |  Proxy escalated for all items |
And wait till order item with clockNumber 'TSLVCN5' will have broadcaster status 'Proxy Escalated' in Traffic
And wait till order item with clockNumber 'TSLVCN6' will have broadcaster status 'Proxy Escalated' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Approve Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment
| test4              |  Proxy approved for all items |
And wait till order item with clockNumber 'TSLVCN5' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN6' will have broadcaster status 'Master Ready For Approval' in Traffic
Then I 'should' see email notification for 'Preview escalation has been submitted' with field to 'test5' and subject 'Preview escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              | Approval By      |
| TSLVCN5     | TSLVAR1     | TSLVSP1  | TSLVT3 | 20       | Motorvision TV | Proxy escalated for all items | HUBU3 |
Then I 'should' see email notification for 'Preview escalation has been submitted' with field to 'test5' and subject 'Preview escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              | Approval By      |
| TSLVCN6    | TSLVAR1     | TSLVSP1  | TSLVT3 | 20       |  Tele 5 DE - Longform | Proxy escalated for all items | HUBU3 |


Scenario: Check that master can be escalated and approved from Hub list View(All)
Meta: @traffic
      @trafficemails
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB4   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU4    |       broadcast.traffic.manager       |  TVHUB4       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB4                     |       true         |      two      |HUBU4|HUBU4|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB4    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC7    |TSLVCN7      | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT4   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC8   |TSLVCN8      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT4 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN7' with following fields:
| Job Number  | PO Number |
| TSLVJN7  | TSLVPN7 |
And complete order contains item with clock number 'TSLVCN8' with following fields:
| Job Number  | PO Number |
| TSLVJN8  | TSLVPN8 |
And wait for finish place order with following item clock number 'TSLVCN7' to A4
And wait for finish place order with following item clock number 'TSLVCN8' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN7 |
  | DefaultAgency      |   TSLVCN8  |
And login with details of 'HUBU4'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN7' will be available in Traffic
And wait till order with clockNumber 'TSLVCN8' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN7' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN8' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT4' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test6             |  Proxy approved for all items |
And wait till order item with clockNumber 'TSLVCN7' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN8' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Escalate' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment
| test7              |  Master escalated for all items |
And wait till order item with clockNumber 'TSLVCN7' will have broadcaster status 'Master Escalated' in Traffic
And wait till order item with clockNumber 'TSLVCN8' will have broadcaster status 'Master Escalated' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment
| test18              |  Master released for all items |
And wait till order item with clockNumber 'TSLVCN7' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN8' will have broadcaster status 'Delivered' in Traffic
Then I 'should' see email notification for 'Master escalation has been submitted' with field to 'test7' and subject 'Master escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               | Approval By      |
| TSLVCN7     | TSLVAR1     | TSLVSP1  | TSLVT4 | 20       | Motorvision TV | Master escalated for all items | HUBU4 |
Then I 'should' see email notification for 'Master escalation has been submitted' with field to 'test7' and subject 'Master escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               | Approval By      |
| TSLVCN8     | TSLVAR1     | TSLVSP1  | TSLVT4 | 20       | Tele 5 DE - Longform | Master escalated for all items | HUBU4 |


Scenario: Check that master can be rejected and restored from Hub list View(All)
Meta: @traffic
      @trafficemails
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB5   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU5    |       broadcast.traffic.manager       |  TVHUB5       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB5                     |       true         |      two      |HUBU5|HUBU5|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB5    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC9    |TSLVCN9     | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT5   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC10  |TSLVCN10      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT5 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN9' with following fields:
| Job Number  | PO Number |
| TSLVJN9  | TSLVPN9 |
And complete order contains item with clock number 'TSLVCN10' with following fields:
| Job Number  | PO Number |
| TSLVJN10  | TSLVPN10 |
And wait for finish place order with following item clock number 'TSLVCN9' to A4
And wait for finish place order with following item clock number 'TSLVCN10' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN9 |
  | DefaultAgency      |   TSLVCN10  |
And login with details of 'HUBU5'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN9' will be available in Traffic
And wait till order with clockNumber 'TSLVCN10' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN9' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN10' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT5' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test8             |  Proxy approved for all items |
And wait till order item with clockNumber 'TSLVCN9' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN10' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
And I click on button 'Reject Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment
| test9              |  Master rejected for all items |
And wait till order item with clockNumber 'TSLVCN9' will have broadcaster status 'Master Rejected' in Traffic
And wait till order item with clockNumber 'TSLVCN10' will have broadcaster status 'Master Rejected' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Restore Master' on traffic list page
When I click on button 'Restore Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment
| test10              |  Master restored for all items |
And wait till order item with clockNumber 'TSLVCN9' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN10' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
And 'should' see email notification for 'has been rejected' with field to 'test9' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TSLVCN9     | TSLVAR1     | TSLVSP1  | TSLVT5 | 20       | Motorvision TV | Master rejected for all items |
And 'should' see email notification for 'has been rejected' with field to 'test9' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| TSLVCN10     | TSLVAR1     | TSLVSP1  | TSLVT5 | 20       | Tele 5 DE - Longform | Master rejected for all items |


Scenario: Check that Force release master can be done from Hub list View(All)
Meta: @traffic
      @trafficemails
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB6   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU6    |       broadcast.traffic.manager       |  TVHUB6       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB6                     |       true         |      two      |HUBU6|HUBU6|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB6    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC11    |TSLVCN11     | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT6   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC12  |TSLVCN12      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT6 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN11' with following fields:
| Job Number  | PO Number |
| TSLVJN11  | TSLVPN11 |
And complete order contains item with clock number 'TSLVCN12' with following fields:
| Job Number  | PO Number |
| TSLVJN12  | TSLVPN12 |
And wait for finish place order with following item clock number 'TSLVCN11' to A4
And wait for finish place order with following item clock number 'TSLVCN12' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN11 |
  | DefaultAgency      |   TSLVCN12  |
And login with details of 'HUBU6'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN11' will be available in Traffic
And wait till order with clockNumber 'TSLVCN12' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN11' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN12' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT6' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Force Release Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test10             |  force release master for all items |
And wait till order item with clockNumber 'TSLVCN11' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'TSLVCN12' will have broadcaster status 'Delivered' in Traffic
Then I 'should' see email notification for 'has been released for delivery' with field to 'test10' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                                   |
| TSLVCN11     | TSLVAR1     | TSLVSP1  | TSLVT6 | 20       | Motorvision TV | force release master for all items |
And I 'should' see email notification for 'has been released for delivery' with field to 'test10' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                                   |
| TSLVCN12    | TSLVAR1     | TSLVSP1  | TSLVT6 | 20       | Tele 5 DE - Longform | force release master for all items |



Scenario: Check that approval is done only for the destination chosen during approval from Hub list View(All)
Meta: @criticaltraffictests
@qatrafficsmoke
@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB7   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU7    |       broadcast.traffic.manager       |  TVHUB7       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB7                    |       true         |      two      |HUBU7|HUBU7|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB7    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC13   |TSLVCN13    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT7   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC14  |TSLVCN14      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT7 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN13' with following fields:
| Job Number  | PO Number |
| TSLVJN13  | TSLVPN13 |
And complete order contains item with clock number 'TSLVCN14' with following fields:
| Job Number  | PO Number |
| TSLVJN14  | TSLVPN14 |
And wait for finish place order with following item clock number 'TSLVCN13' to A4
And wait for finish place order with following item clock number 'TSLVCN14' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN13 |
  | DefaultAgency      |   TSLVCN14  |
And login with details of 'HUBU7'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN13' will be available in Traffic
And wait till order with clockNumber 'TSLVCN14' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN13' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN14' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT7' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |DeselectDestination|
| test11             |  Proxy approved for all items         |Tele 5 DE - Longform - TSLVCN14|
And wait till order item with clockNumber 'TSLVCN13' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN14' will have broadcaster status 'Proxy Ready For Approval' in Traffic
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN13' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Ready For Approval          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN14' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Ready For Approval          |



Scenario: Check that common approval buttons are displayed when we select mix of broadcaster status(Proxy Ready For Approval and Master Escalate) from Hub list view(All)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB8   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU8    |       broadcast.traffic.manager       |  TVHUB8      | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB8                   |       true         |      two      |HUBU8|HUBU8|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB8    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC15   |TSLVCN15    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT8   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC16  |TSLVCN16     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT8 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN15' with following fields:
| Job Number  | PO Number |
| TSLVJN15  | TSLVPN15 |
And complete order contains item with clock number 'TSLVCN16' with following fields:
| Job Number  | PO Number |
| TSLVJN16  | TSLVPN16 |
And wait for finish place order with following item clock number 'TSLVCN15' to A4
And wait for finish place order with following item clock number 'TSLVCN16' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN15 |
  | DefaultAgency      |   TSLVCN16  |
And login with details of 'HUBU8'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN15' will be available in Traffic
And wait till order with clockNumber 'TSLVCN16' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN15' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN16' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT8' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test14             |  Proxy approved for all items         |
And wait till order item with clockNumber 'TSLVCN15' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN16' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page
And enter search criteria 'TSLVT8' in simple search form on Traffic Order List page
And I select following clocks from list view on traffic list page:
|Clock|
|TSLVCN16|
And I click on button 'Master Escalate' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment
| test7              |  Master escalated for all items |
And wait till order item with clockNumber 'TSLVCN16' will have broadcaster status 'Master Escalated' in Traffic
And refresh the page
And enter search criteria 'TSLVT8' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Escalate' on traffic list page
And I 'should' see 'Motorvision TV' with clock 'TSLVCN15'
And I 'should not' see 'Tele 5 DE - Longform' with clock 'TSLVCN16'
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                      |
| test8             |  Master Escalated for all items |
And wait till order item with clockNumber 'TSLVCN15' will have broadcaster status 'Master Escalated' in Traffic
And I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN15' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Escalated          |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN16' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Escalated     |


Scenario: Check that common approval buttons are displayed when we select mix of broadcaster status(Proxy Ready For Approval and Escalate Proxy) from Hub list view(All)
Meta: @qatrafficsmoke
@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUB9   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBU9    |       broadcast.traffic.manager       |  TVHUB9      | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUB9                   |       true         |      two      |HUBU9|HUBU9|
And I add hub members via API:
|Hub Members                                    | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1| TVHUB9    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC17   |TSLVCN17    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TSLVT9   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TSLVAR1    | TSLVBR1    | TSLVSB1    | TSLVSP1    | TSLVC18  |TSLVCN18     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | TSLVT9 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'TSLVCN17' with following fields:
| Job Number  | PO Number |
| TSLVJN17  | TSLVPN17 |
And complete order contains item with clock number 'TSLVCN18' with following fields:
| Job Number  | PO Number |
| TSLVJN18  | TSLVPN18 |
And wait for finish place order with following item clock number 'TSLVCN17' to A4
And wait for finish place order with following item clock number 'TSLVCN18' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TSLVCN17 |
  | DefaultAgency      |   TSLVCN18  |
And login with details of 'HUBU9'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TSLVCN17' will be available in Traffic
And wait till order with clockNumber 'TSLVCN18' will be available in Traffic
And wait till order item with clockNumber 'TSLVCN17' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN18' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TSLVT9' in simple search form on Traffic Order List page
When I select following clocks from list view on traffic list page:
|Clock|
|TSLVCN18|
And I click on button 'Escalate Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test14             |  Proxy escalated for all items         |
And wait till order item with clockNumber 'TSLVCN17' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TSLVCN18' will have broadcaster status 'Proxy Escalated' in Traffic
And enter search criteria 'TSLVT9' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Escalate Proxy' on traffic list page
And I 'should not' see 'Tele 5 DE - Longform' with clock 'TSLVCN18'
And 'should' see 'Motorvision TV' with clock 'TSLVCN17'
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                      |
| test8             |  Proxy Escalated for all items |
And wait till order item with clockNumber 'TSLVCN17' will have broadcaster status 'Proxy Escalated' in Traffic
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TSLVCN17' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Escalated               |
And I should see destination 'Tele 5 DE - Longform' for order item with clockNumber 'TSLVCN18' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Proxy Escalated          |
