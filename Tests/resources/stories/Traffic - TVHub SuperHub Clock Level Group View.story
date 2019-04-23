Feature:    TV Broadcaster Hub and Super Hub Clock Level list functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check the clock level list view for Hub and Super Hub

Lifecycle:
Before:
Given I updated the following agency:
| Name                          | Escalation Enabled | Approval Type |Proxy Approver                 | Master Approver                 |
| BroadCasterAgencyTwoStage     |       true         |      two      |broadcasterTrafficManagerTwo   |broadcasterTrafficManagerTwo     |
| BroadCasterAgencyTwoStage_1   |       true         |      two      |broadcasterTrafficManagerTwo_1 |broadcasterTrafficManagerTwo_1   |
| BroadCasterAgency7390   |       true         |      two      |broadcasterTrafficManager7390 |broadcasterTrafficManager7390   |
| BroadCasterAgency49618   |       true         |      two      |broadcasterTrafficManager49618 |broadcasterTrafficManager49618   |
| BroadCasterAgency59065   |       true         |      two      |broadcasterTrafficManager59065 |broadcasterTrafficManager59065   |
| BroadCasterAgencyOneStage  |       true         |      one      |  |broadcasterTrafficManagerOne |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| CLTAR1     | CLTBR1     | CLTSB1     | CLTP1    |



Scenario: Check that clocks and destinations are grouped on clock tab for TV Broadcaster hub
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUBCLT1   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBCLTU1    |       broadcast.traffic.manager       |  TVHUBCLT1       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUBCLT1                    |       true         |      two      |HUBCLTU1|HUBCLTU1|
And I add hub members via API:
|Hub Members                                                                  | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1,BroadCasterAgency7390  | TVHUBCLT1    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                                    |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC1  |CLTCN1   | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | CLTT1     |  Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express       |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC2  |CLTCN2     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | CLTT1   |  Tele 5 DE - Longform:Express;Motorvision TV:Express       |
And complete order contains item with clock number 'CLTCN1' with following fields:
| Job Number  | PO Number |
| CLTJN1  | CLTJN1 |
And wait for finish place order with following item clock number 'CLTCN1' to A4
And wait for finish place order with following item clock number 'CLTCN2' to A4
When login with details of 'HUBCLTU1'
And I create tab with name 'ClockView' and type 'Clock' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  CLTT1   |
And wait till order item list will be loaded in Traffic
Then I see the following clocknumber in clock level list in Traffic:
|ClkNumber|shouldState|
| CLTCN1 |should|
| CLTCN2 |should|
And enter search criteria 'CLTCN1' in simple search form on Traffic Order List page
When expand all orders on Traffic Order List page
Then I see the following destination in clock level list in Traffic:
|Destination|shouldState|
|Motorvision TV|should|
|Tele 5 DE - Longform|should|
|Moviepilot|should|
And enter search criteria 'CLTCN2' in simple search form on Traffic Order List page
And refresh the page
When expand all orders on Traffic Order List page
Then I see the following destination in clock level list in Traffic:
|Destination|shouldState|
|Motorvision TV|should|
|Tele 5 DE - Longform|should|
|Moviepilot|should not|




Scenario: Check that clocks and destinations are grouped on clock tab for TV Broadcaster Super hub
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUBCLT5  | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
| TVSUPHUBCLT5  | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVSUPCLTU5  |       broadcast.traffic.manager       |  TVSUPHUBCLT5    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVSUPHUBCLT5               |       true         |      two      |TVSUPCLTU5 |TVSUPCLTU5|
And I am on agency 'TVHUBCLT5' hub members page
And I add hub members:
|Hub Members|
|BroadCasterAgencyTwoStage|
|BroadCasterAgencyTwoStage_1|
|BroadCasterAgency7390|
And I am on agency 'TVSUPHUBCLT5' super hub members page
And I add super hub members:
|Super Hub Members|
|TVHUBCLT5|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                                    |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC8  |CLTCN8   | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | CLTT5     |  Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express       |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC9  |CLTCN9     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | CLTT5   |  Tele 5 DE - Longform:Express;Motorvision TV:Express       |
And complete order contains item with clock number 'CLTCN8' with following fields:
| Job Number  | PO Number |
| CLTJN5  | CLTJN5 |
And wait for finish place order with following item clock number 'CLTCN8' to A4
And wait for finish place order with following item clock number 'CLTCN9' to A4
When login with details of 'TVSUPCLTU5'
And I create tab with name 'ClockView' and type 'Clock' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  CLTT5   |
And wait till order item list will be loaded in Traffic
Then I see the following clocknumber in clock level list in Traffic:
|ClkNumber|shouldState|
| CLTCN8 |should|
| CLTCN9 |should|
And enter search criteria 'CLTCN8' in simple search form on Traffic Order List page
When expand all orders on Traffic Order List page
Then I see the following destination in clock level list in Traffic:
|Destination|shouldState|
|Motorvision TV|should|
|Tele 5 DE - Longform|should|
|Moviepilot|should|
And enter search criteria 'CLTCN9' in simple search form on Traffic Order List page
And refresh the page
When expand all orders on Traffic Order List page
Then I see the following destination in clock level list in Traffic:
|Destination|shouldState|
|Motorvision TV|should|
|Tele 5 DE - Longform|should|
|Moviepilot|should not|


Scenario: Check that clocks are grouped based on filters on clock tab for TV Broadcaster hub
!--This will fail until NIR-1142 and NIR-1143 are fixed
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUBCLT2   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBCLTU2    |       broadcast.traffic.manager       |  TVHUBCLT2       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUBCLT2                    |       true         |      two      |HUBCLTU2|HUBCLTU2|
And I add hub members via API:
|Hub Members                                                                  | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1,BroadCasterAgency7390  | TVHUBCLT2    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                                    |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC3  |CLTCN3   | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | CLTT2     |  Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express       |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC4 |CLTCN4     | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | CLTT2   |  Tele 5 DE - Longform:Express;Motorvision TV:Express       |
And complete order contains item with clock number 'CLTCN3' with following fields:
| Job Number  | PO Number |
| CLTJN2  | CLTJN2 |
And wait for finish place order with following item clock number 'CLTCN3' to A4
And wait for finish place order with following item clock number 'CLTCN4' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   CLTCN3 |
And login with details of 'HUBCLTU2'
And wait till order item with clockNumber 'CLTCN3' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Motorvision TV'
And wait till order item with clockNumber 'CLTCN3' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Tele 5 DE - Longform'
And wait till order item with clockNumber 'CLTCN3' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Moviepilot'
And wait till order item with clockNumber 'CLTCN4' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And wait till order item with clockNumber 'CLTCN4' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Tele 5 DE - Longform'
And I create tab with name 'ClockView' and type 'Clock' and dataRange 'All' and the following rules:
| Condition | Condition Type | Value |Filter By Status|
| Title | Starts with |  CLTT2   |Proxy Ready For Approval|
And wait till order item list will be loaded in Traffic
Then I see the following clocknumber in clock level list in Traffic:
|ClkNumber|shouldState|
| CLTCN3 |should|
| CLTCN4 |should not|
And enter search criteria 'CLTCN3' in simple search form on Traffic Order List page
When expand all orders on Traffic Order List page
Then I should see the destination 'Motorvision TV' with clockNumber 'CLTCN3' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Proxy Ready For Approval|
And I should see the destination 'Tele 5 DE - Longform' with clockNumber 'CLTCN3' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Proxy Ready For Approval|
And I should see the destination 'Moviepilot' with clockNumber 'CLTCN3' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Proxy Ready For Approval|




Scenario: Check that SD and HD clones are grouped correctly on clock tab for TV Broadcaster hub
!--NIR-1157
Meta: @traffic
@tbug
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUBCLT8   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBCLTU8    |       broadcast.traffic.manager       |  TVHUBCLT8       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUBCLT8                   |       true         |      two      |HUBCLTU8|HUBCLTU8|
And I am on agency 'TVHUBCLT8' hub members page
And I add hub members:
|Hub Members|
|BroadCasterAgency49618|
|BroadCasterAgency59065|
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | CLTAR1     | CLTBR1     | CLTSB1     | CLTP1    | CLTC13    | CLTCN13    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | CLTT13 |           |
And upload to 'tv' order item with clock number 'CLTCN13' following documents:
| Document          |
| /files/filetext.txt |
And upload to 'tv' order item with clock number 'CLTCN13' following documents:
| Document          |
| /files/file_2.txt |
When I open order item with following clock number 'CLTCN13'
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
| CLTJN13    | CLTPO13  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'CLTCN13' to A4
And login with details of 'HUBCLTU8'
And I create tab with name 'ClockView' and type 'Clock' and dataRange 'All' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  CLTT13   |
And wait till order item list will be loaded in Traffic
Then I see the following clocknumber in clock level list in Traffic:
|ClkNumber|shouldState|
| CLTCN13 |should|
And enter search criteria 'CLTCN13' in simple search form on Traffic Order List page
When expand all orders on Traffic Order List page
Then I should see the destination 'CBC Vancouver' with clockNumber 'CLTCN13' in traffic clock level list that have following data:
|Destination|
|CBC Vancouver|
And I should see the destination 'Airdate Traffic Services' with clockNumber 'CLTCN13' in traffic clock level list that have following data:
|Destination|
|Airdate Traffic Services|
When I am on clock details page of clockNumber 'CLTCN13'
Then I should see the supporting documents 'file_2.txt,filetext.txt' on clock list page
And I should see the clock details page that have following data:
|Advertiser|Product|ClkNumber|Additional Details|
|CLTAR1|CLTP1|CLTCN13|second clock|
When I click on 'Carousel Right' button on clock details page in traffic
And I wait for '2' seconds
Then I should see the clock details page that have following data:
|Advertiser|Product|ClkNumber|Additional Details|
|CLTAR1|CLTP1|CLTCN13|first clock|


Scenario: Check that clock option is not available for TV Broadcaster
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                                    |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC7  |CLTCN7   | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | CLTT4     |   TV Bayern Media:Express      |
And complete order contains item with clock number 'CLTCN7' with following fields:
| Job Number  | PO Number |
| CLTJN4  | CLTJN4 |
And wait for finish place order with following item clock number 'CLTCN7' to A4
When I login with details of 'broadcasterTrafficManagerOne'
Then I 'should not' see 'Clock' in new tab popup
And I 'should not' see 'Order Item (Clock)' in new tab popup




Scenario: Check that approval is done only for the destination chosen during approval from Hub list View(clock tab)
Meta: @qatrafficsmoke
@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUBCLT6   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBCLTU6    |       broadcast.traffic.manager       |  TVHUBCLT6      | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUBCLT6                    |       true         |      two      |HUBCLTU6|HUBCLTU6|
And I add hub members via API:
|Hub Members                                            | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1  | TVHUBCLT6    |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC9   |CLTCN15    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | CLTT9   |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC10  |CLTCN10      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | CLTT9 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'CLTCN15' with following fields:
| Job Number  | PO Number |
| CLTJN9  | CLTPO9 |
And complete order contains item with clock number 'CLTCN10' with following fields:
| Job Number  | PO Number |
| CLTJN10  | CLTPO10 |
And wait for finish place order with following item clock number 'CLTCN15' to A4
And wait for finish place order with following item clock number 'CLTCN10' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   CLTCN15 |
  | DefaultAgency      |   CLTCN10  |
And login with details of 'HUBCLTU6'
And wait till order item with clockNumber 'CLTCN15' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'CLTCN10' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'ClockView' and type 'Clock' and dataRange 'All' and the following rules:
| Condition | Condition Type | Value |
| Advertiser | Starts with |  CLTAR1  |
And wait till order item list will be loaded in Traffic
And I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Force Release Master,Approve Proxy,Escalate Proxy,Reject Proxy' on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |DeselectDestination|
| test11             |  Proxy approved for all items         |Tele 5 DE - Longform - CLTCN10|
And wait till order item with clockNumber 'CLTCN15' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'CLTCN10' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I refresh the page
And enter search criteria 'CLTCN15' in simple search form on Traffic Order List page
When expand all orders on Traffic Order List page
Then I should see the destination 'Motorvision TV' with clockNumber 'CLTCN15' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Master Ready For Approval|
And enter search criteria 'CLTCN10' in simple search form on Traffic Order List page
And refresh the page
When expand all orders on Traffic Order List page
Then I should see the destination 'Tele 5 DE - Longform' with clockNumber 'CLTCN10' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Proxy Ready For Approval|




Scenario: Check that approval is done only for the destination chosen during approval from Super Hub list View(clock tab)
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUBCLT7  | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
| TVSUPHUBCLT7  | DefaultA4User     | TV Broadcaster Super Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVSUPCLTU7  |       broadcast.traffic.manager       |  TVSUPHUBCLT7    | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVSUPHUBCLT7               |       true         |      two      |TVSUPCLTU7 |TVSUPCLTU7|
And I add hub members via API:
|Hub Members                                            | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1  | TVHUBCLT7    |
And I am on agency 'TVSUPHUBCLT7' super hub members page
And I add super hub members:
|Super Hub Members|
|TVHUBCLT7|
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC11   |CLTCN11    | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | CLTT11  |  Motorvision TV:Express        |
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | CLTAR1    | CLTBR1    | CLTSB1    | CLTP1    | CLTC12  |CLTCN12      | 20       |      1      |12/14/2022      |   Already Supplied |HD 1080i 25fps | CLTT11 |  Tele 5 DE - Longform:Express             |
And complete order contains item with clock number 'CLTCN11' with following fields:
| Job Number  | PO Number |
| CLTJN11  | CLTPO11 |
And complete order contains item with clock number 'CLTCN12' with following fields:
| Job Number  | PO Number |
| CLTJN12  | CLTPO12 |
And wait for finish place order with following item clock number 'CLTCN11' to A4
And wait for finish place order with following item clock number 'CLTCN12' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   CLTCN11 |
  | DefaultAgency      |   CLTCN12  |
And login with details of 'TVSUPCLTU7'
And wait till order item with clockNumber 'CLTCN11' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'CLTCN12' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I create tab with name 'ClockView' and type 'Clock' and dataRange 'All' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  CLTT11   |
And wait till order item list will be loaded in Traffic
And I select all from list view at 'Clock' level on traffic list page
When I click on button 'Approve Proxy' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test33              |  Proxy approved for all items |
And wait till order item with clockNumber 'CLTCN11' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'CLTCN12' will have broadcaster status 'Master Ready For Approval' in Traffic
And enter search criteria 'CLTT11' in simple search form on Traffic Order List page
And I select all from list view at 'Clock' level on traffic list page
Then I should see the approval buttons 'Reject Master,Master Escalate,Master Release' on traffic list page
When I click on button 'Master Release' on traffic list page
And fill the following fields on approval traffic pop up on list page:
| Email              |  Comment                              |
| test34             |  Master Released for all items |
And wait till order item with clockNumber 'CLTCN11' will have broadcaster status 'Delivered' in Traffic
And wait till order item with clockNumber 'CLTCN12' will have broadcaster status 'Delivered' in Traffic
And I refresh the page
And enter search criteria 'CLTCN11' in simple search form on Traffic Order List page
When expand all orders on Traffic Order List page
Then I should see the destination 'Motorvision TV' with clockNumber 'CLTCN11' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Delivered|
And enter search criteria 'CLTCN12' in simple search form on Traffic Order List page
And refresh the page
When expand all orders on Traffic Order List page
Then I should see the destination 'Tele 5 DE - Longform' with clockNumber 'CLTCN12' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Delivered|



Scenario: Check that metadata and Carousel and attachements under supporting documents are displayed on clock details page for Hub
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUBCLT1   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBCLTU1    |       broadcast.traffic.manager       |  TVHUBCLT1       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUBCLT1                    |       true         |      two      |HUBCLTU1|HUBCLTU1|
And I add hub members via API:
|Hub Members                                                                 | Name         |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1,BroadCasterAgency7390  | TVHUBCLT1    |
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
| first clock    | CLTAR1     | CLTBR1     | CLTSB1     | CLTP1    | CLTC5  |  CLTCN5      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  |  CLTT5 |  Motorvision TV:Express         |1|
And upload to 'tv' order item with clock number 'CLTCN5' following documents:
| Document          |
| /files/filetext.txt |
And complete order contains item with clock number 'CLTCN5' with following fields:
| Job Number  | PO Number |
|  CLTJN5   | CLTPO5 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|      Motivnummer|                                                                                                            |
|  second clock   | CLTAR1     | CLTBR1     | CLTSB1     | CLTP1    |  CLTC6   | CLTCN6      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  |  CLTT6 | Tele 5 DE - Longform:Express;Moviepilot:Express         |1|
And add to 'tv' order item with clock number 'CLTCN6' following qc asset ' CLTT5' of collection 'My Assets'
And upload to 'tv' order item with clock number 'CLTCN5' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'CLTCN5' with following fields:
| Job Number  | PO Number |
| CLTJN6   | CLTPO6 |
And wait for finish place order with following item clock number 'CLTCN5' to A4
When login with details of 'HUBCLTU1'
And I create tab with name 'ClockViewTab' and type 'Clock' and dataRange 'All' and the following rules:
| Condition | Condition Type | Value |
| Title | Starts with |  CLTT5   |
And wait till order item list will be loaded in Traffic
When I am on clock details page of clockNumber 'CLTCN5'
Then I should see the supporting documents 'file_2.txt,filetext.txt' on clock list page
And I should see the clock details page that have following data:
|Advertiser|Product|ClkNumber|Additional Details|
|CLTAR1|CLTP1| CLTCN5|second clock|
When I click on 'Carousel Right' button on clock details page in traffic
And I wait for '2' seconds
Then I should see the clock details page that have following data:
|Advertiser|Product|ClkNumber|Additional Details|
|CLTAR1|CLTP1| CLTCN5|first clock|

Scenario: Check HN grouping along with approval on clock details page for Hub
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVHUBCLT9  | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HUBCLTU9   |       broadcast.traffic.manager       |  TVHUBCLT9       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVHUBCLT9                   |       true         |      two      |HUBCLTU9|HUBCLTU9|
And I am on agency 'TVHUBCLT9' hub members page
And I add hub members:
|Hub Members|
|BroadCasterAgencyTwoStage|
|BroadCasterAgencyTwoStage_1|
|BroadCasterAgency7390|
And I add house number:
|House Number|
|1           |
|1           |
|1          |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | CLTAR1       | CLTBR1       | CLTSB1       | CLTP1      | CLTC14    | CLTCN14     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | CLTT14 | Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express                     | 1          |
And complete order contains item with clock number 'CLTCN14' with following fields:
| Job Number   | PO Number    |
| CLTJN14 | CLTPO14 |
And wait for finish place order with following item clock number 'CLTCN14' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency      |   CLTCN14 |
And I login with details of 'HUBCLTU9'
And I wait till order with clockNumber 'CLTCN14' will be available in Traffic
And wait till order item with clockNumber 'CLTCN14' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Tele 5 DE - Longform'
And wait till order item with clockNumber 'CLTCN14' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Moviepilot'
And wait till order item with clockNumber 'CLTCN14' will have broadcaster status 'Proxy Ready For Approval' in Traffic for destination 'Motorvision TV'
And enter search criteria 'CLTCN14' in simple search form on Traffic Order List page
When I am on clock details page of clockNumber 'CLTCN14'
When I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN811         |
Then I see the house number for the following destination:
|Destination         |House Number|
|Tele 5 DE - Longform|HN811         |
|Motorvision TV          |HN811         |
|Moviepilot        |HN811         |
When I click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                 |  Comment  |
|      test22        |    Test   |
And wait till order item with clockNumber 'CLTCN14' will have broadcaster status 'Master Ready For Approval' in Traffic
And wait till order item with clockNumber 'CLTCN14' will have broadcaster status 'Master Ready For Approval' in Traffic
When I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|           Email                 |  Comment  |
|      test21       |    Test   |
And wait till order item with clockNumber 'CLTCN14' will have broadcaster status 'Master Released' in Traffic
And wait till order item with clockNumber 'CLTCN14' will have broadcaster status 'Master Released' in Traffic
And click on 'Back' button on order item details page in traffic
And select 'All' tab in Traffic UI
And enter search criteria 'CLTCN14' in simple search form on Traffic Order List page
When expand all orders on Traffic Order List page
Then I should see the destination 'Motorvision TV' with clockNumber 'CLTCN14' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Master Released|
And I should see the destination 'Tele 5 DE - Longform' with clockNumber 'CLTCN14' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Master Released|
And I should see the destination 'Moviepilot' with clockNumber 'CLTCN14' in traffic clock level list that have following data:
|Broadcaster Approval Status|
|Master Released|


