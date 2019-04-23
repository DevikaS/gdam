Feature:    Traffic Manager - Reset Approval
Narrative:
In order to
As a              AgencyAdmin
I want to verify the state of Reset Approval button When the broadcaster status is master released

Lifecycle:
Before:
Given I updated the following agency:
| Name                          | Escalation Enabled | Approval Type |Proxy Approver                 | Master Approver                 |
| BroadCasterAgencyOneStage  |       true         |      one      |                 |broadcasterTrafficManagerOne |
| BroadCasterAgencyTwoStage     |       true         |      two      |broadcasterTrafficManagerTwo   |broadcasterTrafficManagerTwo     |
| BroadCasterAgency49618   |       true         |      two      |broadcasterTrafficManager49618 |broadcasterTrafficManager49618   |
| BroadCasterAgency59065   |       true         |      two      |broadcasterTrafficManager59065 |broadcasterTrafficManager59065   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TRABAR1     | TRABBR1     | TRABSB1     | TRABP1    |

Scenario: Check that Reset approval button is diabled when the broadcaster approval status is Master Released for TV Broadcaster
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TRABAR1     | TRABBR1     | TRABSB1     | TRABP1    | TRABCP1    | TRABCN1       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TRABT1     |  TV Bayern Media:Express   |
And complete order contains item with clock number 'TRABCN1' with following fields:
| Job Number  | PO Number |
| TRABJN1   | TRABPO1 |
And wait for finish place order with following item clock number 'TRABCN1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TRABCN1    |
And login with details of 'broadcasterTrafficManagerOne'
And select 'All' tab in Traffic UI
And wait till order item with clockNumber 'TRABCN1' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'TRABCN1' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test1              |  Master Released for all items |
And wait till order item with clockNumber 'TRABCN1' will have broadcaster status 'Master Released' in Traffic
And login with details of 'trafficManager'
And I amon order item details page of clockNumber 'TRABCN1'
Then I 'should' see reset approval button disabled on order item details page in traffic



Scenario: Check that Reset approval button is diabled when the broadcaster approval status is Master Released for TV Broadcaster hub(Force Release master)
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TRABHUB1     | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TRABHUBU1    |       broadcast.traffic.manager       |  TRABHUB1       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TRABHUB1                      |       true         |      two      |TRABHUBU1|TRABHUBU1|
And I add hub members via API:
| Hub Members               | Name     |
| BroadCasterAgencyTwoStage | TRABHUB1 |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TRABAR1    | TRABBR1    | TRABSB1    | TRABP1    | TRABC3    |TRABCN3     | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TRABT3    |  Motorvision TV:Express          |
And complete order contains item with clock number 'TRABCN3' with following fields:
| Job Number  | PO Number |
| TRABJN3  | TRABPO3 |
And wait for finish place order with following item clock number 'TRABCN3' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   TRABCN3 |
And login with details of 'TRABHUBU1'
And select 'All' tab in Traffic UI
And wait till order item with clockNumber 'TRABCN3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TRABT3' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Force Release Master' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test1              |  forced to release master |
And wait till order item with clockNumber 'TRABCN3' will have broadcaster status 'Master Released' in Traffic
And login with details of 'trafficManager'
And I amon order item details page of clockNumber 'TRABCN3'
Then I 'should' see reset approval button disabled on order item details page in traffic


Scenario: Check that Reset approval button is diabled when the broadcaster approval status is Master Released for clones with two satge approval
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TRABHUB2     | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TRABHUBU2    |       broadcast.traffic.manager       |  TRABHUB2       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TRABHUB2                      |       true         |      two      |TRABHUBU2|TRABHUBU2|
And I add hub members via API:
| Hub Members                                    | Name     |
| BroadCasterAgency49618, BroadCasterAgency59065 | TRABHUB2 |
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | TRABAR1     | TRABBR1     | TRABSB1     | TRABP1    | TRABC4    | TRABCN4     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TRABT4 |           |
When I open order item with following clock number 'TRABCN4'
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
| TRABJN4    | TRABPO4  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TRABCN4' to A4
And ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations             |
|  DefaultAgency   | TRABCN4       | Airdate Traffic Services|
And ingested assests through A5 with following fields:
| agencyName   | clockNumber      |destinations                                 |
|  DefaultAgency   | TRABCN4       | CBC Vancouver                             |
And login with details of 'TRABHUBU2'
And select 'All' tab in Traffic UI
And wait till cloned order with clockNumber 'TRABCN4' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'TRABCN4' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'CBC Vancouver'
And enter search criteria 'TRABT4' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test1              |  Proxy approved for all items |
And wait till cloned order with clockNumber 'TRABCN4' will have broadcaster status 'Master Ready For Approval' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'TRABCN4' will have broadcaster status 'Master Ready For Approval' in Traffic for destination 'CBC Vancouver'
And I select all from list view at 'Clock' level on traffic list page
And I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test2              |  Master Released for all items |
And wait till cloned order with clockNumber 'TRABCN4' will have broadcaster status 'Master Released' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'TRABCN4' will have broadcaster status 'Master Released' in Traffic for destination 'CBC Vancouver'
And login with details of 'trafficManager'
And I am on cloned order item details page of clockNumber 'TRABCN4' for destination 'CBC Vancouver'
Then I 'should' see reset approval button disabled on order item details page in traffic
When open Traffic Order List page
And I am on cloned order item details page of clockNumber 'TRABCN4' for destination 'Airdate Traffic Services'
Then I 'should' see reset approval button disabled on order item details page in traffic




