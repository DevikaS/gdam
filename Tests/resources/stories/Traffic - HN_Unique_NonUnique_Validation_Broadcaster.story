Feature:    Validate House Number Uniqueness
Narrative:
In order to
As a AgencyAdmin
I want to Validate House Number Uniqueness

Lifecycle:
Before:
Given I updated the following agency:
| Name                          | Escalation Enabled | Approval Type |Proxy Approver                 | Master Approver                 |House Number Suffix|
| BroadCasterAgencyTwoStage     |       true         |      two      |broadcasterTrafficManagerTwo   |broadcasterTrafficManagerTwo     |HNSS2|
| BroadCasterAgencyTwoStage_1   |       true         |      two      |broadcasterTrafficManagerTwo_1 |broadcasterTrafficManagerTwo_1   ||
| BroadCasterAgency7390   |       true         |      two      |broadcasterTrafficManager7390 |broadcasterTrafficManager7390   ||
| BroadCasterAgencyOneStage  |       true         |      one      |                 |broadcasterTrafficManagerOne ||
| BroadCasterAgencyNoApproval  |       true         |      one      |                 |broadcasterTrafficManagerNoApproval ||
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| HNUVAR1    | HNUVBR1 | HNUVSB1   | HNUVP1  |

Scenario: Check that HN grouping model when an option unique is chosen(hub) and unique validation within the group should not happen when one of the destination has HNS suffix
!--Bug raised NIR - 1155 but workaround is done at step level in such a way that selecting the model after adding hub members
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| HNUVHUB5   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HNUV_U5    |       broadcast.traffic.manager       |  HNUVHUB5       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| HNUVHUB5                  |       true         |      two      |HNUV_U5|HNUV_U5|
And I add hub members via API:
|Hub Members                                    | Name         | Grouping Type     |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1,BroadCasterAgency7390,BroadCasterAgencyNoApproval| HNUVHUB5    | unique            |
And I am on agency 'HNUVHUB5' hub members page
And I add house number:
|House Number|
|1           |
|1           |
|2         |
|2|
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC11   | HNUVCN11     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT11 | Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express;Travel Channel DE:Express                     | 1          |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC12    | HNUVCN12     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT12 | Motorvision TV:Express;Tele 5 DE - Longform:Express                     | 1          |
And complete order contains item with clock number 'HNUVCN11' with following fields:
| Job Number   | PO Number    |
| HNUVJN11 | HNUVPO11 |
And complete order contains item with clock number 'HNUVCN12' with following fields:
| Job Number   | PO Number    |
| HNUVJN12| HNUVPO12 |
And wait for finish place order with following item clock number 'HNUVCN11' to A4
And wait for finish place order with following item clock number 'HNUVCN12' to A4
And I logged in with details of 'HNUV_U5'
And waited till order with clockNumber 'HNUVCN11' will be available in Traffic
And waited till order with clockNumber 'HNUVCN12' will be available in Traffic
And waited till order item with clockNumber 'HNUVCN11' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Moviepilot'
And waited till order item with clockNumber 'HNUVCN11' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And waited till order item with clockNumber 'HNUVCN11' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Tele 5 DE - Longform'
And waited till order item with clockNumber 'HNUVCN11' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Travel Channel DE'
And waited till order item with clockNumber 'HNUVCN12' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Tele 5 DE - Longform'
And waited till order item with clockNumber 'HNUVCN12' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And I amon order item details page of clockNumber 'HNUVCN11'
When I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV      |HN90        |
Then I see the house number for the following destination:
|Destination         |House Number|
|Tele 5 DE - Longform|            |
When I fill house number field for the following destination:
|Destination         |House Number|
|Tele 5 DE - Longform|HN90         |
And wait for '4' seconds
Then I 'should not' see the house number unique validation message on order details page
And wait for '10' seconds
When I fill house number field for the following destination:
|Destination         |House Number|
|Tele 5 DE - Longform|HN100         |
And wait for '4' seconds
Then I 'should not' see the house number unique validation message on order details page
And wait for '4' seconds
When I fill house number field for the following destination:
|Destination         |House Number|
|Moviepilot|HN200         |
And wait for '4' seconds
Then I see the house number for the following destination:
|Destination         |House Number|
|Travel Channel DE|            |
And wait for '4' seconds
When I fill house number field for the following destination:
|Destination         |House Number|
|Travel Channel DE|HN200         |
Then I 'should' see the house number unique validation message on order details page
And wait for '6' seconds
When I fill house number field for the following destination:
|Destination         |House Number|
|Travel Channel DE|HN300         |
And wait for '1' seconds
Then I 'should not' see the house number unique validation message on order details page
And I refresh the page
Then I see the house number for the following destination:
|Destination         |House Number|
|Motorvision TV      |   HN90         |
|Tele 5 DE - Longform|    HN100       |
|Moviepilot          |    HN200        |
|Travel Channel DE          |    HN300       |
When I click on 'Back' button on order details page in traffic
And wait for '2' seconds
And I amon order item details page of clockNumber 'HNUVCN12'
And I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN90         |
And wait for '1' seconds
Then I 'should' see the house number unique validation message on order details page
And I see the house number for the following destination:
|Destination         |House Number|
|Motorvision TV|            |
And wait for '4' seconds
When I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN400         |
|Tele 5 DE - Longform|    HN500        |
And wait for '4' seconds
And I refresh the page
Then I see the house number for the following destination:
|Destination         |House Number|
|Motorvision TV      |  HN400         |
|Tele 5 DE - Longform|    HN500        |


Scenario: Check that broadcaster is able to assign the same HN manually to the destination that is not part of same HN group
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| HNUVHUB1   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HNUV_U1    |       broadcast.traffic.manager       |  HNUVHUB1       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| HNUVHUB1                   |       true         |      two      |HNUV_U1|HNUV_U1|
And I add hub members via API:
|Hub Members| Name            |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1,BroadCasterAgency7390| HNUVHUB1     |
And I am on agency 'HNUVHUB1' hub members page
And I add house number:
|House Number|
|1           |
|1           |
|2          |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC1    | HNUVCN1     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT1 | Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express                     | 1          |
And complete order contains item with clock number 'HNUVCN1' with following fields:
| Job Number   | PO Number    |
| HNUVJN1 | HNUVPO1 |
And wait for finish place order with following item clock number 'HNUVCN1' to A4
And I logged in with details of 'HNUV_U1'
And waited till order with clockNumber 'HNUVCN1' will be available in Traffic
And waited till order item with clockNumber 'HNUVCN1' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Tele 5 DE - Longform'
And waited till order item with clockNumber 'HNUVCN1' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Moviepilot'
And waited till order item with clockNumber 'HNUVCN1' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And selected 'All' tab in Traffic UI
And waited till order item list will be loaded in Traffic
And I amon order item details page of clockNumber 'HNUVCN1'
When I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN10         |
Then I see the house number for the following destination:
|Destination         |House Number|
|Tele 5 DE - Longform|HN10          |
|Motorvision TV          |HN10         |
When I fill house number field for the following destination:
|Destination         |House Number|
|Moviepilot|HN10          |
Then I 'should not' see the house number unique validation message on order details page


Scenario: Check that HN unique validation occurs when entering the same HN for same destination across order item either at same order or different order(without grouping with default option)
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| HNUVHUB2  | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HNUV_U2    |       broadcast.traffic.manager       |  HNUVHUB2       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| HNUVHUB2                   |       true         |      two      |HNUV_U2|HNUV_U2|
And I add hub members via API:
|Hub Members| Name            |
|BroadCasterAgencyTwoStage,BroadCasterAgency7390| HNUVHUB2     |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC2    | HNUVCN2     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT2 | Motorvision TV:Express                    | 1          |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC3    | HNUVCN3     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT3 | Motorvision TV:Express;Moviepilot:Express                     | 1          |
And complete order contains item with clock number 'HNUVCN2' with following fields:
| Job Number   | PO Number    |
| HNUVJN2 | HNUVPO2 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC4    | HNUVCN4     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT4 | Motorvision TV:Express                    | 1          |
And complete order contains item with clock number 'HNUVCN4' with following fields:
| Job Number   | PO Number    |
| HNUVJN4 | HNUVPO4 |
And wait for finish place order with following item clock number 'HNUVCN2' to A4
And wait for finish place order with following item clock number 'HNUVCN3' to A4
And wait for finish place order with following item clock number 'HNUVCN4' to A4
And I logged in with details of 'HNUV_U2'
And waited till order with clockNumber 'HNUVCN2' will be available in Traffic
And waited till order with clockNumber 'HNUVCN3' will be available in Traffic
And waited till order with clockNumber 'HNUVCN4' will be available in Traffic
And waited till order item with clockNumber 'HNUVCN2' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And waited till order item with clockNumber 'HNUVCN3' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And waited till order item with clockNumber 'HNUVCN3' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Moviepilot'
And waited till order item with clockNumber 'HNUVCN4' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And entered search criteria 'HNUVCN2' in simple search form on Traffic Order List page
And opened order item details page with clockNumber 'HNUVCN2'
When I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN30          |
Then I 'should not' see the house number unique validation message on order details page
And I see the house number for the following destination:
|Destination         |House Number|
|Motorvision TV          |HN30          |
When I click on 'Back' button on order details page in traffic
And I amon order item details page of clockNumber 'HNUVCN3'
And I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN30         |
Then I 'should' see the house number unique validation message on order details page
When I fill house number field for the following destination:
|Destination         |House Number|
|Moviepilot|HN30         |
Then I 'should not' see the house number unique validation message on order details page
And I see the house number for the following destination:
|Destination         |House Number|
|Motorvision TV          |          |
When I click on 'Back' button on order details page in traffic
And I amon order item details page of clockNumber 'HNUVCN4'
And I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN30         |
Then I 'should' see the house number unique validation message on order details page



Scenario: Check that HN unique validation occurs when entering the same HN for same destination across order item for TV broadcaster
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC5    | HNUVCN5    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT5 | TV Bayern Media:Express                    | 1          |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC6    | HNUVCN6    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT6 | TV Bayern Media:Express                    | 1          |
And complete order contains item with clock number 'HNUVCN5' with following fields:
| Job Number   | PO Number    |
| HNUVJN5 | HNUVPO5 |
And wait for finish place order with following item clock number 'HNUVCN5' to A4
And wait for finish place order with following item clock number 'HNUVCN6' to A4
And I logged in with details of 'broadcasterTrafficManagerOne'
And waited till order with clockNumber 'HNUVCN5' will be available in Traffic
And waited till order with clockNumber 'HNUVCN6' will be available in Traffic
And waited till order item with clockNumber 'HNUVCN5' will have broadcaster status 'File Not Supplied' in Traffic for destination 'TV Bayern Media'
And waited till order item with clockNumber 'HNUVCN6' will have broadcaster status 'File Not Supplied' in Traffic for destination 'TV Bayern Media'
And I amon order item details page of clockNumber 'HNUVCN5'
When I fill house number field for the following destination:
|Destination         |House Number|
|TV Bayern Media|HN40          |
Then I 'should not' see the house number unique validation message on order details page
And I see the house number for the following destination:
|Destination         |House Number|
|TV Bayern Media          |HN40          |
When I click on 'Back' button on order details page in traffic
And I amon order item details page of clockNumber 'HNUVCN6'
And I fill house number field for the following destination:
|Destination         |House Number|
|TV Bayern Media|HN40          |
Then I 'should' see the house number unique validation message on order details page



Scenario: Check that HN Unique validation does not happen between SD and HD when a clock is having both SD and HD
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| HNUVHUB4  | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HNUV_U4    |       broadcast.traffic.manager       |  HNUVHUB4       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| HNUVHUB4                   |       true         |      two      |HNUV_U4|HNUV_U4|
And I add hub members via API:
|Hub Members| Name            |
|BroadCasterAgency49618,BroadCasterAgency59065| HNUVHUB4     |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | HNUVAR1     | HNUVBR1     | HNUVSB1     | HNUVP1    | HNUVC9    | HNUVCN9     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | HNUVT9 |           |
When I open order item with following clock number 'HNUVCN9'
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
| HNUVJN9    | HNUVPO9  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'HNUVCN9' to A4
When login with details of 'HNUV_U4'
And wait till order with clockNumber 'HNUVCN9' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till cloned order with clockNumber 'HNUVCN9' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Airdate Traffic Services'
And wait till cloned order with clockNumber 'HNUVCN9' will have broadcaster status 'File Not Supplied' in Traffic for destination 'CBC Vancouver'
And I am on cloned order item details page of clockNumber 'HNUVCN9' for destination 'Airdate Traffic Services'
When I fill house number field for the following destination:
|Destination         |House Number|
|Airdate Traffic Services      |HN60         |
Then I 'should not' see the house number unique validation message on order details page
When I open Traffic Order List page
And I am on cloned order item details page of clockNumber 'HNUVCN9' for destination 'CBC Vancouver'
Then I see the house number for the following destination:
|Destination         |House Number|
|CBC Vancouver          |         |
When I fill house number field for the following destination:
|Destination         |House Number|
|CBC Vancouver      |HN60         |
Then I 'should not' see the house number unique validation message on order details page
When I refresh the page
Then I see the house number for the following destination:
|Destination         |House Number|
|CBC Vancouver          |    HN60     |


Scenario: Check that broadcaster can assign and unassign house number when one of the destination is put On-Hold in a clock and make sure house number grouping works
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| TVBCOHHUB6   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| TVBCOHHUB_U6    |       broadcast.traffic.manager       |  TVBCOHHUB6       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| TVBCOHHUB6                   |       true         |      two      |TVBCOHHUB_U6|TVBCOHHUB_U6|
And I add hub members via API:
|Hub Members| Name            |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1,BroadCasterAgency7390| TVBCOHHUB6     |
And I am on agency 'TVBCOHHUB6' hub members page
And I add house number:
|House Number|
|1           |
|1           |
|1           |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | TVBCOHC9    | TVBCOHCN9     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | TVBCOHT9 | Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express                     | 1          |
And complete order contains item with clock number 'TVBCOHCN9' with following fields:
| Job Number   | PO Number    |
| TVBCOHJN9 | TVBCOHPO9 |
And wait for finish place order with following item clock number 'TVBCOHCN9' to A4
When login with details of 'trafficManager'
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TVBCOHCN9' will be available in Traffic
And wait till order with clockNumber 'TVBCOHCN9' will have next status 'In Progress' in Traffic
And I Edit order item with following clock number 'TVBCOHCN9'
And hold following destinations for Select Broadcast Destinations form on order item page 'Motorvision TV'
Then I 'should' see order item held for approval for active cover flow
And wait for '2' seconds
When click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TVBCOHCN9' will be available in Traffic
And enter search criteria 'TVBCOHCN9' in simple search form on Traffic Order List page
And open order details with clockNumber 'TVBCOHCN9' from Traffic UI
And refresh the page without delay
Then I should see 'TVBCOHCN9' with value 'Yes' for on Hold Dest in order details page for destination 'Motorvision TV'
When login with details of 'TVBCOHHUB_U6'
And wait till order with clockNumber 'TVBCOHCN9' will be available in Traffic
And enter search criteria 'TVBCOHCN9' in simple search form on Traffic Order List page
And open order item details page with clockNumber 'TVBCOHCN9'
And wait till order item with clockNumber 'TVBCOHCN9' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Tele 5 DE - Longform'
And wait till order item with clockNumber 'TVBCOHCN9' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Moviepilot'
And refresh the page
And I fill house number field for the following destination:
|Destination         |House Number|
|Tele 5 DE - Longform|20          |
Then I 'should not' see the house number unique validation message on order details page
And I see the house number for the following destination:
|Destination         |House Number|
|Tele 5 DE - Longform|20          |
|Moviepilot          |20          |
When I delete house number field for the following destination:
|Destination         |
|Tele 5 DE - Longform|
And wait for '4' seconds
Then I see the house number for the following destination:
|Destination         |House Number|
|Tele 5 DE - Longform|          |
|Moviepilot          |          |


Scenario: Check that HN grouping model when a default option same group is chosen(Hub)
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| HNUVHUB4   | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HNUV_U4    |       broadcast.traffic.manager       |  HNUVHUB4       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| HNUVHUB4                  |       true         |      two      |HNUV_U4|HNUV_U4|
And I add hub members via API:
|Hub Members| Name            | Grouping Type     |
|BroadCasterAgencyTwoStage,BroadCasterAgencyTwoStage_1,BroadCasterAgency7390,BroadCasterAgencyNoApproval| HNUVHUB4     | grouped   |
And I am on agency 'HNUVHUB4' hub members page
And I add house number:
|House Number|
|1           |
|1           |
|2         |
|2|
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC9    | HNUVCN13     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT9 | Motorvision TV:Express;Tele 5 DE - Longform:Express;Moviepilot:Express;Travel Channel DE:Express                     | 1          |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC10    | HNUVCN10     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT10 | Motorvision TV:Express;Tele 5 DE - Longform:Express                     | 1          |
And complete order contains item with clock number 'HNUVCN13' with following fields:
| Job Number   | PO Number    |
| HNUVJN9 | HNUVPO9 |
And complete order contains item with clock number 'HNUVCN10' with following fields:
| Job Number   | PO Number    |
| HNUVJN10| HNUVPO10 |
And wait for finish place order with following item clock number 'HNUVCN13' to A4
And wait for finish place order with following item clock number 'HNUVCN10' to A4
And I logged in with details of 'HNUV_U4'
And waited till order with clockNumber 'HNUVCN13' will be available in Traffic
And waited till order with clockNumber 'HNUVCN10' will be available in Traffic
And waited till order item with clockNumber 'HNUVCN13' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Moviepilot'
And waited till order item with clockNumber 'HNUVCN13' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And waited till order item with clockNumber 'HNUVCN13' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Tele 5 DE - Longform'
And waited till order item with clockNumber 'HNUVCN13' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Travel Channel DE'
And waited till order item with clockNumber 'HNUVCN10' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Tele 5 DE - Longform'
And waited till order item with clockNumber 'HNUVCN10' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And I amon order item details page of clockNumber 'HNUVCN13'
When I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV      |HN70        |
Then I see the house number for the following destination:
|Destination         |House Number|
|Tele 5 DE - Longform|  HN70          |
When I fill house number field for the following destination:
|Destination         |House Number|
|Moviepilot|HN80         |
Then I see the house number for the following destination:
|Destination         |House Number|
|Travel Channel DE|  HN80         |
When I refresh the page
Then I see the house number for the following destination:
|Destination         |House Number|
|Motorvision TV      |   HN70         |
|Tele 5 DE - Longform|    HN70        |
|Moviepilot          |    HN80        |
|Travel Channel DE          |    HN80        |
When I click on 'Back' button on order details page in traffic
And I amon order item details page of clockNumber 'HNUVCN10'
And I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN70         |
Then I 'should' see the house number unique validation message on order details page
When I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN80         |
Then I 'should not' see the house number unique validation message on order details page
When I refresh the page
Then I see the house number for the following destination:
|Destination         |House Number|
|Motorvision TV      |  HN80          |
|Tele 5 DE - Longform|    HN80        |


Scenario: Check that HN unique validation occurs when entering the same HN for same destination across order item either at same order or different order(without grouping with unique option)
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| HNUVHUB14 | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| HNUV_U14    |       broadcast.traffic.manager       |  HNUVHUB14      | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| HNUVHUB14                   |       true         |      two      |HNUV_U14|HNUV_U14|
And I add hub members via API:
|Hub Members                                    | Name         | Grouping Type     |
|BroadCasterAgencyTwoStage,BroadCasterAgency7390| HNUVHUB14    | unique            |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC17    | HNUVCN17     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT17 | Motorvision TV:Express                    | 1          |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC18    | HNUVCN18     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT18 | Motorvision TV:Express;Moviepilot:Express                     | 1          |
And complete order contains item with clock number 'HNUVCN17' with following fields:
| Job Number   | PO Number    |
| HNUVJN17 | HNUVPO17 |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | HNUVAR1       | HNUVBR1       | HNUVSB1       | HNUVP1      | HNUVC19   | HNUVCN19     | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | HNUVT19 | Motorvision TV:Express                    | 1          |
And complete order contains item with clock number 'HNUVCN19' with following fields:
| Job Number   | PO Number    |
| HNUVJN19 | HNUVPO19 |
And wait for finish place order with following item clock number 'HNUVCN17' to A4
And wait for finish place order with following item clock number 'HNUVCN18' to A4
And wait for finish place order with following item clock number 'HNUVCN19' to A4
And I logged in with details of 'HNUV_U14'
And waited till order with clockNumber 'HNUVCN17' will be available in Traffic
And waited till order with clockNumber 'HNUVCN18' will be available in Traffic
And waited till order with clockNumber 'HNUVCN19' will be available in Traffic
And waited till order item with clockNumber 'HNUVCN17' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And waited till order item with clockNumber 'HNUVCN18' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And waited till order item with clockNumber 'HNUVCN18' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Moviepilot'
And waited till order item with clockNumber 'HNUVCN19' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Motorvision TV'
And I amon order item details page of clockNumber 'HNUVCN17'
When I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN601         |
Then I 'should not' see the house number unique validation message on order details page
And I see the house number for the following destination:
|Destination         |House Number|
|Motorvision TV          |HN601          |
When I click on 'Back' button on order details page in traffic
And I amon order item details page of clockNumber 'HNUVCN18'
And I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN601         |
Then I 'should' see the house number unique validation message on order details page
When I fill house number field for the following destination:
|Destination         |House Number|
|Moviepilot|HN601         |
Then I 'should not' see the house number unique validation message on order details page
And I see the house number for the following destination:
|Destination         |House Number|
|Moviepilot          |HN601          |
When I click on 'Back' button on order details page in traffic
And I amon order item details page of clockNumber 'HNUVCN19'
And I fill house number field for the following destination:
|Destination         |House Number|
|Motorvision TV|HN601        |
Then I 'should' see the house number unique validation message on order details page


Scenario: Check that HN unique validation should not happen when HouseNumber Unique checkbox is set to true
!--This will fail until SPB-944 is fixed
Meta:@traffic
Given I updated the following agency:
| Name                       | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |HouseNumber Unique|
| BroadCasterAgency42818  |       true         |      one      |                 |broadcasterTrafficManager42818 |true|
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | HNUVAR1     | HNUVBR1     | HNUVSB1     | HNUVP1    | HNUVC22    | HNUVCN22      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | HNUVT22 |           |
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|                                                                                                                  |
| automated test info    | HNUVAR1     | HNUVBR1     | HNUVSB1     | HNUVP1    | HNUVC23    | HNUVCN23     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | HNUVT23 |           |
When I open order item with following clock number 'HNUVCN22'
And fill Search Stations field by value 'Ad Systems/ St Catherine Springfield, KY' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)                           |
|Ad Systems/ St Catherine Springfield, KY |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| HNUVPO22    | HNUVJN22  |
And confirm order on Order Proceed page
When I open order item with following clock number 'HNUVCN23'
And fill Search Stations field by value 'Ad Systems/ St Catherine Springfield, KY' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)                           |
|Ad Systems/ St Catherine Springfield, KY |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| HNUVPO22    | HNUVJN22  |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'HNUVCN22' to A4
And waited for finish place order with following item clock number 'HNUVCN23' to A4
When login with details of 'broadcasterTrafficManager42818'
And wait till order with clockNumber 'HNUVCN22' will be available in Traffic
And wait till order with clockNumber 'HNUVCN23' will be available in Traffic
And wait till order item with clockNumber 'HNUVCN22' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Ad Systems/ St Catherine Springfield, KY'
And wait till order item with clockNumber 'HNUVCN23' will have broadcaster status 'File Not Supplied' in Traffic for destination 'Ad Systems/ St Catherine Springfield, KY'
And I amon order item details page of clockNumber 'HNUVCN22'
And wait for '2' seconds
When I fill house number field for the following destination:
|Destination         |House Number|
|Ad Systems/ St Catherine Springfield, KY|HN401          |
Then I 'should not' see the house number unique validation message on order details page
And I see the house number for the following destination:
|Destination         |House Number|
|Ad Systems/ St Catherine Springfield, KY          |HN401          |
When I click on 'Back' button on order details page in traffic
And I amon order item details page of clockNumber 'HNUVCN23'
And I fill house number field for the following destination:
|Destination         |House Number|
|Ad Systems/ St Catherine Springfield, KY|HN401          |
Then I 'should not' see the house number unique validation message on order details page
When I refresh the page
Then I see the house number for the following destination:
|Destination         |House Number|
|Ad Systems/ St Catherine Springfield, KY          |HN401          |

Scenario: Check HNS is automatically suffixed when a clock has multiple destination (with grouping)
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I updated the following agency:
| Name                          | Escalation Enabled | Approval Type |Proxy Approver                 | Master Approver                 |House Number Suffix|
| BroadCasterAgencyTwoStage     |       true         |      two      |broadcasterTrafficManagerTwo   |broadcasterTrafficManagerTwo     |HNSS2|
| BroadCasterAgencyTwoStage_1   |       true         |      two      |broadcasterTrafficManagerTwo_1 |broadcasterTrafficManagerTwo_1   | HNSS3 |
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser   | Brand         | Sub Brand  | Product     |
| THNSAR2| THNSBR2        | THNSSB2     | THNSSP2     |
And I created the following agency:
| Name        | A4User        | AgencyType        | Market         |DestinationID|Application Access|
| THNSHUB02| DefaultA4User | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email    |           Role                        | AgencyUnique   |  Access  |
| THNSHUB_U2    |       broadcast.traffic.manager     |  THNSHUB02  | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| THNSHUB02                   |       true         |      two      |THNSHUB_U2|THNSHUB_U2|
And I am on agency 'THNSHUB02' hub members page
And I add hub members:
|Hub Members|
|BroadCasterAgencyTwoStage|
|BroadCasterAgencyTwoStage_1|
And I add house number:
|House Number|
|1           |
|1           |
And I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | THNSAR2    | THNSBR2    | THNSSB2    | THNSP2    | THNSC3    |THNSCN4     | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | THNST3    |  Motorvision TV:Express;Tele 5 DE - Longform:Express     |
And complete order contains item with clock number 'THNSCN4' with following fields:
| Job Number  | PO Number |
| THNSJN3   | THNSPO3 |
When login with details of 'THNSHUB_U2'
And I wait till order with clockNumber 'THNSCN4' will be available in Traffic
And I amon order item details page of clockNumber 'THNSCN4'
When I fill house number field for the following destination:
|Destination    | House Number |
|Motorvision TV | 57           |
Then I should see house number grouped on order details page in traffic:
|Destination          |House Number |
|Motorvision TV       |57    |
|Tele 5 DE - Longform |57    |
And I should see house number suffixed on order details page in traffic:
|Destination          |House Number Suffix|
|Motorvision TV       |HNSS2|
|Tele 5 DE - Longform |HNSS3|
When I click on 'Back' button on order item details page in traffic
And wait till order will be loaded in Traffic UI
And I create tab with name 'Send' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition   | Condition Type |  Value   |
| Advertiser   |    Match       | THNSAR2 |
And wait till order item list will be loaded in Traffic
Then I 'should' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| HouseNumber|Suffix|
| 57  |HNSS2|
| 57  |HNSS3|
When login with details of 'trafficManager'
And I wait till order with clockNumber 'THNSCN4' will be available in Traffic
And I create tab with name 'Send' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition   | Condition Type |  Value   |
| Advertiser   |    Match       |THNSAR2|
And wait till order item list will be loaded in Traffic
Then I 'should' download csv report from tab with specific filter on Traffic Order Item List page and verify for data:
| HouseNumber|Suffix|
| 57  |HNSS2|
| 57  |HNSS3|
