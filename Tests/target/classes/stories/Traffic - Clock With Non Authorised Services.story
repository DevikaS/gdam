Feature:    Clock with non-authorised services should be put On-Hold
Narrative:
In order to
As a              AgencyAdmin
I want to check clock with non-authorised services should be put On-Hold


Scenario: Check that non authorised warning message is shown when a clock is having non authorised services(HD Destination with Standard SLA and Subtitling)
Meta:@traffic
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   | SAP Country|
| CNASA1       | DefaultA4User | United Kingdom | BM0004   | United Kingdom|
And created users with following fields:
| Email  | Role         | AgencyUnique |
| CNASU1 | agency.admin | CNASA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CNASA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| CNASAR1     | CNASBR1     | CNASSB1     | CNASSP1    |
And I logged in with details of 'CNASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | CNASAR1       | CNASBR1       | CNASSB1       | CNASSP1      | CNASC1   | CNASCN1    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | CNAST1 | Sky Go HD:Standard                      | 1          |
And complete order contains item with clock number 'CNASCN1' with following fields:
| Job Number   | PO Number    |
| CNASJN1 | CNASPO1 |
And I wait for finish place order with following item clock number 'CNASCN1' to A4
When I go to View Held Orders tab of 'tv' order on ordering page
Then I 'should' see orders with following markets 'United Kingdom' in 'held' order list
When login with details of 'trafficManager'
And I am on order details page of clockNumber 'CNASCN1'
Then I should see 'CNASCN1' with value 'Yes' for on Hold Dest in order details page for destination 'Sky Go HD'
And I 'should' see warning message 'contain non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN1' on traffic order details page


Scenario: Check that non authorised warning message is shown  when a clock is having non authorised services(HD Destination with Standard SLA and watermarking)
Meta:@traffic
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   | SAP Country|
| CNASA2       | DefaultA4User | Spain | BM0004   | United Kingdom|
And created users with following fields:
| Email  | Role         | AgencyUnique |
| CNASU2 | agency.admin | CNASA2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CNASA2':
| Advertiser | Brand      | Sub Brand  | Product   |
| CNASAR2    | CNASBR2     | CNASSB2     | CNASSP2    |
And I logged in with details of 'CNASU2'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Watermarking Required | Format         | Title       | Destination                               |Clave|
| automated test info    | CNASAR2       | CNASBR2       | CNASSB2       | CNASSP2      | CNASC2   | CNASCN2    | 20       | 12/14/2022     |   Yes |HD 1080i 25fps   | CNAST2 | Cosmopolitan Patrocinios HD:Standard                      |test|
And complete order contains item with clock number 'CNASCN2' with following fields:
| Job Number   | PO Number    |
| CNASJN2 | CNASPO2 |
And I wait for finish place order with following item clock number 'CNASCN2' to A4
When I go to View Held Orders tab of 'tv' order on ordering page
Then I 'should' see orders with following markets 'Spain' in 'held' order list
When login with details of 'trafficManager'
And I am on order details page of clockNumber 'CNASCN2'
Then I should see 'CNASCN2' with value 'Yes' for on Hold Dest in order details page for destination 'Cosmopolitan Patrocinios HD'
And I 'should' see warning message 'contain non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN2' on traffic order details page


Scenario: Check that non authorised warning message is shown when TM edits the clock with non authorised services(HD Destination with Standard SLA and Subtitling)
Meta:@traffic
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   | SAP Country|
| CNASA3       | DefaultA4User | United Kingdom | BM0004   | United Kingdom|
And created users with following fields:
| Email  | Role         | AgencyUnique |
| CNASU3 | agency.admin | CNASA3       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CNASA3':
| Advertiser | Brand      | Sub Brand  | Product   |
| CNASAR3     | CNASBR3     | CNASSB3     | CNASSP3   |
And I logged in with details of 'CNASU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date        |  Format            | Subtitles Required   |Title       | Destination                               |Motivnummer |
| automated test info    | CNASAR3       | CNASBR3       | CNASSB3       | CNASSP3      | CNASC3   | CNASCN3    | 20       | 12/14/2022     |   HD 1080i 25fps   |Already Supplied      | CNAST3 | BSkyB sponsorship HD:Express                     | 1          |
And complete order contains item with clock number 'CNASCN3' with following fields:
| Job Number   | PO Number    |
| CNASJN3 | CNASPO3 |
And I wait for finish place order with following item clock number 'CNASCN3' to A4
When I go to View Held Orders tab of 'tv' order on ordering page
Then I 'should not' see orders with following markets 'United Kingdom' in 'held' order list
When login with details of 'trafficManager'
And I am on order details page of clockNumber 'CNASCN3'
Then I should see 'CNASCN3' with value 'No' for on Hold Dest in order details page for destination 'BSkyB sponsorship HD'
And I 'should not' see warning message 'contain non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN3' on traffic order details page
When I amon order item details page of clockNumber 'CNASCN3'
And click on 'Edit Order' button on order item details page in traffic
And fill Search Stations field by value 'BSkyB sponsorship HD' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard     |
|BSkyB sponsorship HD    |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'CNASCN3'
Then I should see 'CNASCN3' with value 'Yes' for on Hold Dest in order details page for destination 'BSkyB sponsorship HD'
And I 'should' see warning message 'contain non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN3' on traffic order details page



Scenario: Check that non authorised warning message is shown for the respective clocks when one of the clock is having non-aouthorised services(HD Destination with Standard SLA and Subtitling)
Meta:@traffic
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   | SAP Country|
| CNASA4       | DefaultA4User | United Kingdom | BM0004   | United Kingdom|
And created users with following fields:
| Email  | Role         | AgencyUnique |
| CNASU4 | agency.admin | CNASA4       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CNASA4':
| Advertiser | Brand      | Sub Brand  | Product   |
| CNASAR4     | CNASBR4     | CNASSB4    | CNASSP4   |
And I logged in with details of 'CNASU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title       | Destination                               |Motivnummer |
| automated test info    | CNASAR4       | CNASBR4       | CNASSB4       | CNASSP4      | CNASC4   | CNASCN4    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | CNAST4 | Sky Go HD:Standard                      | 1          |
| automated test info    | CNASAR4       | CNASBR4       | CNASSB4       | CNASSP4      | CNASC5   | CNASCN5    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps   | CNAST5 | Talk Sport:Standard                      | 1          |
And complete order contains item with clock number 'CNASCN4' with following fields:
| Job Number   | PO Number    |
| CNASJN4 | CNASPO4 |
And I wait for finish place order with following item clock number 'CNASCN4' to A4
And I wait for finish place order with following item clock number 'CNASCN5' to A4
When I go to View Held Orders tab of 'tv' order on ordering page
Then I 'should' see orders with following markets 'United Kingdom' in 'held' order list
When login with details of 'trafficManager'
And wait till order list will be loaded
And wait till order with clockNumber 'CNASCN4' will have next status 'In Progress' in Traffic
And wait till order with clockNumber 'CNASCN5' will have next status 'In Progress' in Traffic
And I am on order details page of clockNumber 'CNASCN4'
Then I should see 'CNASCN4' with value 'Yes' for on Hold Dest in order details page for destination 'Sky Go HD'
And I should see 'CNASCN5' with value 'No' for on Hold Dest in order details page for destination 'Talk Sport'
And I 'should' see warning message 'contain non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN4' on traffic order details page
When I amon order item details page of clockNumber 'CNASCN4'
Then I 'should' see warning message 'WARNING! This clock contains non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN4' on traffic order item details page
When I amon order item details page of clockNumber 'CNASCN5'
Then I 'should not' see warning message 'WARNING! This clock contains non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN5' on traffic order item details page


Scenario: Check that non authorised warning message is not shown when TM releases a clock that was put On-Hold
Meta:@traffic
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   | SAP Country|
| CNASA5       | DefaultA4User | United Kingdom | BM0004   | United Kingdom|
And created users with following fields:
| Email  | Role         | AgencyUnique |
| CNASU5 | agency.admin | CNASA5       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CNASA5':
| Advertiser | Brand      | Sub Brand  | Product   |
| CNASAR5     | CNASBR5     | CNASSB5    | CNASSP5   |
And I logged in with details of 'CNASU5'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date        |  Format            | Subtitles Required   |Title       | Destination                               |Motivnummer |
| automated test info    | CNASAR5       | CNASBR5       | CNASSB5       | CNASSP5      | CNASC5   | CNASCN5    | 20       | 12/14/2022     |   HD 1080i 25fps   |Already Supplied      | CNAST5 | BSkyB sponsorship HD:Standard                     | 1          |
And complete order contains item with clock number 'CNASCN5' with following fields:
| Job Number   | PO Number    |
| CNASJN5 | CNASPO5 |
And I wait for finish place order with following item clock number 'CNASCN5' to A4
When I go to View Held Orders tab of 'tv' order on ordering page
Then I 'should' see orders with following markets 'United Kingdom' in 'held' order list
When login with details of 'trafficManager'
And wait till order with clockNumber 'CNASCN5' will have next status 'In Progress' in Traffic
And I am on order details page of clockNumber 'CNASCN5'
Then I should see 'CNASCN5' with value 'Yes' for on Hold Dest in order details page for destination 'BSkyB sponsorship HD'
And I 'should' see warning message 'contain non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN5' on traffic order details page
When I amon order item details page of clockNumber 'CNASCN5'
And click on 'Edit Order' button on order item details page in traffic
Then I 'should' see order item held for approval for active cover flow
When I click Held For Approval button on Order Item page via UI
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And I am on order details page of clockNumber 'CNASCN5'
Then I should see 'CNASCN5' with value 'No' for on Hold Dest in order details page for destination 'BSkyB sponsorship HD'
And I 'should' see warning message 'contain non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN5' on traffic order details page


Scenario: Check that non authorised warning message is not shown for TV broadcaster
Meta:@traffic
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name        | A4User        | AgencyType              | Market         |DestinationID|Application Access|
| CNASHUB1     | DefaultA4User     | TV Broadcaster Hub| Germany        |             |adpath            |
And created users with following fields:
| Email      |           Role                        | AgencyUnique   |  Access  |
| CNASHUBU1    |       broadcast.traffic.manager       |  CNASHUB1       | adpath   |
And I updated the following agency:
| Name                        | Escalation Enabled | Approval Type |Proxy Approver              | Master Approver |
| CNASHUB1                      |       true         |      two      |CNASHUBU1|CNASHUBU1|
And I add hub members via API:
| Hub Members            | Name     |
| BroadCasterAgency49618 | CNASHUB1 |
And I created the following agency:
| Name        | A4User        | Country        | SAP ID   | SAP Country|
| CNASA6       | DefaultA4User | United States | BM0004   | United Kingdom|
And created users with following fields:
| Email  | Role         | AgencyUnique |
| CNASU6 | agency.admin | CNASA6       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CNASA6':
| Advertiser | Brand      | Sub Brand  | Product   |
| CNASAR6     | CNASBR6     | CNASSB6    | CNASSP6   |
And I logged in with details of 'CNASU6'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date        |  Format            | Subtitles Required   |Title       | Destination                               |Motivnummer |
| automated test info    | CNASAR6       | CNASBR6       | CNASSB6       | CNASSP6      | CNASC6   | CNASCN6    | 20       | 12/14/2022     |   HD 1080i 25fps   |Already Supplied      | CNAST6 |                    | 1          |
When I open order item with following clock number 'CNASCN6'
And fill Search Stations field by value 'Airdate' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)            |
| Airdate Traffic Services |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| CNASJN6    | CNASPO6  |
And confirm order on Order Proceed page
And I waited for finish place order with following item clock number 'CNASCN6' to A4
And I go to View Held Orders tab of 'tv' order on ordering page
Then I 'should' see orders with following markets 'United States & Canada' in 'held' order list
When login with details of 'trafficManager'
And wait till order with clockNumber 'CNASCN6' will have next status 'In Progress' in Traffic
And I am on order details page of clockNumber 'CNASCN6'
Then I should see 'CNASCN6' with value 'Yes' for on Hold Dest in order details page for destination 'Airdate Traffic Services'
And I 'should' see warning message 'contain non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN6' on traffic order details page
When I amon order item details page of clockNumber 'CNASCN6'
And click on 'Edit Order' button on order item details page in traffic
Then I 'should' see order item held for approval for active cover flow
When I click Held For Approval button on Order Item page via UI
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And login with details of 'CNASHUBU1'
And wait till order with clockNumber 'CNASCN6' will be available in Traffic
And I am on order details page of clockNumber 'CNASCN6'
Then I 'should not' see warning message 'contain non-authorised service(s):HDStdDomNormal' for clockNumber 'CNASCN6' on traffic order item details page