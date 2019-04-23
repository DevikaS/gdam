Feature:    TV Broadcaster Approval functionality from List View
Narrative:
In order to
As a              AgencyAdmin
I want to check the single stage approval feature from List View for TV Broadcaster

Lifecycle:
Before:
Given I updated the following agency:
| Name                       | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyOneStage  |       true         |      one      |                 |broadcasterTrafficManagerOne |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    |

Scenario: Check that master can be released from list view(All) and email is sent
Meta: @traffic
      @trafficemails
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP1    | SSLVCN4       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT1     |  TV Bayern Media:Express   |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP1    | SSLVCN5       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT1     |  TV Bayern Media:Express   |
And complete order contains item with clock number 'SSLVCN4' with following fields:
| Job Number  | PO Number |
| SSLVJN1   | SSLVPN1 |
And wait for finish place order with following item clock number 'SSLVCN4' to A4
And wait for finish place order with following item clock number 'SSLVCN5' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   SSLVCN4    |
  | DefaultAgency      |   SSLVCN5    |
And login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And wait till order item with clockNumber 'SSLVCN4' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN5' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'SSLVT1' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test1              |  Master Released for all items |
And wait for '5' seconds
And open Traffic Order List page
And wait till order list will be loaded
And enter search criteria 'SSLVCN4' in simple search form on Traffic Order List page
And wait for '5' seconds
And expand all orders on Traffic Order List page
Then I 'should' see Broadcaster Approval Status 'Master Released' for order item with clock number 'SSLVCN4'
When I wait till order item with clockNumber 'SSLVCN4' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'SSLVCN5' will have broadcaster status 'Delivered' in Traffic
Then I 'should' see email notification for 'has been released for delivery' with field to 'test1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| SSLVCN4        | SSLVAR1     | SSLVSP1  | SSLVT1 | 20       | TV Bayern Media | Master Released for all items |
And 'should' see email notification for 'has been released for delivery' with field to 'test1' and subject 'clockNumber has been released for delivery' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| SSLVCN5        | SSLVAR1     | SSLVSP1  | SSLVT1 | 20       | TV Bayern Media | Master Released for all items |
When I amon order item details page of clockNumber 'SSLVCN4'
And wait for '60' seconds
Then 'should' see 'Delivered' Broadcaster Approval Status on on order item details page in traffic


Scenario: Check that master can be escalated after restore master from list view(All) and email is sent
Meta: @traffic
      @trafficemails
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP8   | SSLVCN8       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT4     |  TV Bayern Media:Express   |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP9   | SSLVCN9       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT4    |  TV Bayern Media:Express   |
And complete order contains item with clock number 'SSLVCN8' with following fields:
| Job Number  | PO Number |
| SSLVJN4  | SSLVPN4 |
And wait for finish place order with following item clock number 'SSLVCN8' to A4
And wait for finish place order with following item clock number 'SSLVCN9' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   SSLVCN8  |
  | DefaultAgency      |   SSLVCN9    |
And login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And wait till order item with clockNumber 'SSLVCN8' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN9' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'SSLVT4' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
And I click on button 'Reject Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test2              |  Master Rejected for all items |
And wait till order item with clockNumber 'SSLVCN8' will have broadcaster status 'Master Rejected' in Traffic
And wait till order item with clockNumber 'SSLVCN9' will have broadcaster status 'Master Rejected' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Restore Master' on traffic list page
When I click on button 'Restore Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test3              |  Master Restored for all items |
And wait till order item with clockNumber 'SSLVCN8' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN9' will have broadcaster status 'Master Ready For Approval' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Escalate' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test4              |  Master Escalated for all items |
And wait till order item with clockNumber 'SSLVCN8' will have broadcaster status 'Master Escalated' in Traffic
And wait till order item with clockNumber 'SSLVCN9' will have broadcaster status 'Master Escalated' in Traffic
Then I 'should' see email notification for 'Master escalation has been submitted' with field to 'test4' and subject 'Master escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| SSLVCN8     | SSLVAR1     | SSLVSP1  | SSLVT4 | 20       | TV Bayern Media | Master Escalated for all items        |
And I 'should' see email notification for 'Master escalation has been submitted' with field to 'test4' and subject 'Master escalation for clockNumber has been submitted' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| SSLVCN9    | SSLVAR1     | SSLVSP1  | SSLVT4 | 20       | TV Bayern Media | Master Escalated for all items        |
Then I 'should' see email notification for 'has been rejected' with field to 'test2' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                              |
| SSLVCN8     | SSLVAR1     | SSLVSP1  | SSLVT4 | 20       | TV Bayern Media | Master Rejected for all items |
And 'should' see email notification for 'has been rejected' with field to 'test2' and subject 'clockNumber has been rejected' contains following attributes:
| Clock Number | Advertiser | Product | Title   | Duration | Destinations    | Comment                               |
| SSLVCN9     | SSLVAR1     | SSLVSP1  | SSLVT4 | 20       | TV Bayern Media | Master Rejected for all items |


Scenario: Check that master can be approved from list view(All) from Escalated status
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP10   | SSLVCN10     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT5     |  TV Bayern Media:Express   |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP11  | SSLVCN11      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT5   |  TV Bayern Media:Express   |
And complete order contains item with clock number 'SSLVCN10' with following fields:
| Job Number  | PO Number |
| SSLVJN5  | SSLVPN5 |
And wait for finish place order with following item clock number 'SSLVCN10' to A4
And wait for finish place order with following item clock number 'SSLVCN11' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   SSLVCN10  |
  | DefaultAgency      |   SSLVCN11   |
And login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And wait till order item with clockNumber 'SSLVCN10' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN11' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'SSLVT5' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
And I click on button 'Reject Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test6              |  Master Rejected for all items |
And wait till order item with clockNumber 'SSLVCN10' will have broadcaster status 'Master Rejected' in Traffic
And wait till order item with clockNumber 'SSLVCN11' will have broadcaster status 'Master Rejected' in Traffic
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Restore Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test7              |  Master Restored for all items |
And wait till order item with clockNumber 'SSLVCN10' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN11' will have broadcaster status 'Master Ready For Approval' in Traffic
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Master Escalate' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test8             |  Master Escalated for all items |
And wait till order item with clockNumber 'SSLVCN10' will have broadcaster status 'Master Escalated' in Traffic
And wait till order item with clockNumber 'SSLVCN11' will have broadcaster status 'Master Escalated' in Traffic
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test9             |  Master Released for all items |
And wait till order item with clockNumber 'SSLVCN10' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'SSLVCN11' will have broadcaster status 'Delivered' in Traffic
And refresh the page
Then I should see destination 'TV Bayern Media' for order item with clockNumber 'SSLVCN10' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'TV Bayern Media' for order item with clockNumber 'SSLVCN11' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |


Scenario: Check that master can be rejected from list view(All) from Escalated status
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP12   | SSLVCN12     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT6     |  TV Bayern Media:Express   |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP13  | SSLVCN13      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT6   |  TV Bayern Media:Express   |
And complete order contains item with clock number 'SSLVCN12' with following fields:
| Job Number  | PO Number |
| SSLVJN6  | SSLVPN6 |
And wait for finish place order with following item clock number 'SSLVCN12' to A4
And wait for finish place order with following item clock number 'SSLVCN13' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   SSLVCN12  |
  | DefaultAgency      |   SSLVCN13   |
And login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And wait till order item with clockNumber 'SSLVCN12' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN13' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'SSLVT6' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
And I click on button 'Reject Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test6              |  Master Rejected for all items |
And wait till order item with clockNumber 'SSLVCN12' will have broadcaster status 'Master Rejected' in Traffic
And wait till order item with clockNumber 'SSLVCN13' will have broadcaster status 'Master Rejected' in Traffic
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Restore Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test7              |  Master Restored for all items |
And wait till order item with clockNumber 'SSLVCN12' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN13' will have broadcaster status 'Master Ready For Approval' in Traffic
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Master Escalate' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test8             |  Master Escalated for all items |
And wait till order item with clockNumber 'SSLVCN12' will have broadcaster status 'Master Escalated' in Traffic
And wait till order item with clockNumber 'SSLVCN13' will have broadcaster status 'Master Escalated' in Traffic
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Reject Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test9             |  Master Rejected for all items |
And wait till order item with clockNumber 'SSLVCN12' will have broadcaster status 'Master Rejected' in Traffic
And wait till order item with clockNumber 'SSLVCN13' will have broadcaster status 'Master Rejected' in Traffic
Then I should see destination 'TV Bayern Media' for order item with clockNumber 'SSLVCN12' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Rejected          |
And I should see destination 'TV Bayern Media' for order item with clockNumber 'SSLVCN13' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Rejected          |

Scenario: Check that Recall master works from list view(All)
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
      @criticaltraffictests
!--Once NIR-1057 is fixed change "Master Reccall" to correct spelling
Given I logged in as 'GlobalAdmin'
And I created 'BTMR1' role with 'delivery.edit,traffic.tab.default.view.all,traffic.tab.default.view.master.approved,traffic.tab.default.view.master.rejected,traffic.tab.default.view.proxy.rejected,traffic.tab.default.view.proxy.approved,traffic.tab.default.view.awaiting.master.approval,traffic.tab.default.view.awaiting.proxy.approval' permissions in 'global' group for advertiser 'BroadCasterAgencyOneStage'
And created users with following fields:
| Email     |           Role            | Agency |  Access  | Password |
| TBRMU1   | BTMR1 |   BroadCasterAgencyOneStage    |  adpath  | abcdefghA1 |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
| BroadCasterAgencyOneStage  |       true         |      one      |                |      TBRMU1    |
And I logout from account
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP14   | SSLVCN14     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT7     |  TV Bayern Media:Express   |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP15  | SSLVCN15      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT7   |  TV Bayern Media:Express   |
And complete order contains item with clock number 'SSLVCN14' with following fields:
| Job Number  | PO Number |
| SSLVJN7  | SSLVPN7 |
And wait for finish place order with following item clock number 'SSLVCN14' to A4
And wait for finish place order with following item clock number 'SSLVCN15' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   SSLVCN14 |
  | DefaultAgency      |   SSLVCN15   |
And login as 'TBRMU1' of Agency 'BroadCasterAgencyOneStage'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'SSLVCN14' will be available in Traffic
And wait till order with clockNumber 'SSLVCN15' will be available in Traffic
And wait till order item with clockNumber 'SSLVCN14' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN15' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'SSLVT7' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
And I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test7              |  Master Released for all items |
And wait till order item with clockNumber 'SSLVCN14' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'SSLVCN15' will have broadcaster status 'Delivered' in Traffic
And refresh the page
And enter search criteria 'SSLVT7' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Master Recall' on traffic list page
When I click on button 'Master Recall' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test7              |  Master Recalled for all items |
And wait till order item with clockNumber 'SSLVCN14' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'SSLVCN15' will have broadcaster status 'Delivered' in Traffic
And refresh the page
Then I should see destination 'TV Bayern Media' for order item with clockNumber 'SSLVCN14' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |
And I should see destination 'TV Bayern Media' for order item with clockNumber 'SSLVCN15' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |

Scenario: Check that common approval buttons are displayed when we select mix of broadcaster status(Master Ready For Approval and Master Escalate) from list view(All)
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
      @criticaltraffictests
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP16  | SSLVCN16     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT8     |  TV Bayern Media:Express   |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP17 | SSLVCN17     | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT8   |  TV Bayern Media:Express   |
And complete order contains item with clock number 'SSLVCN16' with following fields:
| Job Number  | PO Number |
| SSLVJN8  | SSLVPN8 |
And wait for finish place order with following item clock number 'SSLVCN16' to A4
And wait for finish place order with following item clock number 'SSLVCN17' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   SSLVCN16 |
  | DefaultAgency      |   SSLVCN17   |
And login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'SSLVCN16' will be available in Traffic
And wait till order with clockNumber 'SSLVCN17' will be available in Traffic
And wait till order item with clockNumber 'SSLVCN16' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN17' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'SSLVT8' in simple search form on Traffic Order List page
When I select following clocks from list view on traffic list page:
|Clock|
|SSLVCN16|
And I click on button 'Reject Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test6              |  Master Rejected for all items |
And wait till order item with clockNumber 'SSLVCN16' will have broadcaster status 'Master Rejected' in Traffic
And enter search criteria 'SSLVT8' in simple search form on Traffic Order List page
When I select following clocks from list view on traffic list page:
|Clock|
|SSLVCN16|
And I click on button 'Restore Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test7              |  Master Restored for all items |
And wait till order item with clockNumber 'SSLVCN16' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'SSLVT8' in simple search form on Traffic Order List page
When I select following clocks from list view on traffic list page:
|Clock|
|SSLVCN16|
And I click on button 'Master Escalate' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test8             |  Master Escalated for all items |
And wait till order item with clockNumber 'SSLVCN16' will have broadcaster status 'Master Escalated' in Traffic
And enter search criteria 'SSLVT8' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Master Release, Reject Master, Master Escalate' on traffic list page

Scenario: Check that approval is done only for the clock chosen during approval from list View(All)
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
      @criticaltraffictests
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP18    | SSLVCN18      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT9    |  TV Bayern Media:Express   |
| automated test info    | SSLVAR1     | SSLVBR1     | SSLVSB1     | SSLVSP1    | SSLVCP19    | SSLVCN19       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | SSLVT9     |  TV Bayern Media:Express   |
And complete order contains item with clock number 'SSLVCN18' with following fields:
| Job Number  | PO Number |
| SSLVJN18   | SSLVPN18 |
And wait for finish place order with following item clock number 'SSLVCN18' to A4
And wait for finish place order with following item clock number 'SSLVCN19' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   SSLVCN18    |
  | DefaultAgency      |   SSLVCN19   |
And login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'SSLVCN18' will be available in Traffic
And wait till order with clockNumber 'SSLVCN19' will be available in Traffic
And wait till order item with clockNumber 'SSLVCN18' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN19' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'SSLVT9' in simple search form on Traffic Order List page
When I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Master Release, Reject Master, Master Escalate' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |DeselectDestination|
| test1              |  Master Released for all items |TV Bayern Media - SSLVCN18|
And wait till order item with clockNumber 'SSLVCN18' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'SSLVCN19' will have broadcaster status 'Delivered' in Traffic
And I refresh the page
Then I should see destination 'TV Bayern Media' for order item with clockNumber 'SSLVCN18' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Master Ready For Approval          |
And I refresh the page
And I should see destination 'TV Bayern Media' for order item with clockNumber 'SSLVCN19' in traffic order list that have following data:
|     Broadcaster Approval Status    |
|      Delivered          |


