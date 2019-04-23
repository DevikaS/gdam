!--QA-459
Feature:    AMS Scenario
Narrative:
In order to
As a              GlobalAdmin
I want to check AMS feature

Lifecycle:
Before:
Given updated the following agency:
| Name     |  Labels|
| Arabian Media Services  |  MENA |

Scenario: Check that Approve Proxy works for Clock sent to more than one channel with same specifications within the hub
!--QA-454
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TMCOAR5    | TMCOBR5 | TMCOSB5   | TMCOP5  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                                                   |
| automated test info    | TMCOAR5     | TMCOBR5 | TMCOSB5    | TMCOP5    | TTVBTVSC1   | TCCSMCINHCN_2       |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST2 | MBC group (SD):Express;MBC GROUP Sponsorship (CPS):Express    |
And complete order contains item with clock number 'TCCSMCINHCN_2' with following fields:
| Job Number  | PO Number |
| TMCOJO35    | TMCOPO135 |
And wait for finish place order with following item clock number 'TCCSMCINHCN_2' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |destinations                |
|DefaultAgency       | TCCSMCINHCN_2     |MBC group (SD)              |
|DefaultAgency       | TCCSMCINHCN_2     |MBC GROUP Sponsorship (CPS) |
When I login as 'ams.approval.user@adbank.me'
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item with clockNumber 'TCCSMCINHCN_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TCCSMCINHCN_2' in simple search form on Traffic Order List page
And wait for '2' seconds
And go to order item details page with clockNumber 'TCCSMCINHCN_2' using destination 'MBC GROUP Sponsorship (CP'
And refresh the page
And click on 'Approve Proxy' button on order item details page in traffic
Then I 'should' see approval option of following destinations for order item on Approve pop up:
| MBC group (SD) | MBC GROUP Sponsorship (CPS)   |
| ON             | ON                            |
When I fill the following fields for specific destination on approval traffic pop up for new user:
|           Email                 |  Comment  |  Destination                                            |
|      test1_3                    |    Test   |  MBC GROUP Sponsorship (CPS)                            |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Back' button on order details page in traffic
And select 'Waiting for MBC Approval' tab in Traffic UI
And enter search criteria 'TCCSMCINHCN_2' in simple search form on Traffic Order List page
And wait for '2' seconds
And go to order item details page with clockNumber 'TCCSMCINHCN_2' using destination 'MBC GROUP Sponsorship (CP'
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic


Scenario: Check that Reject Proxy works for Clock sent to more than one channel with same specifications within the hub
!--QA-454
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TMCOAR6    | TMCOBR6 | TMCOSB6   | TMCOP6  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                                                   |
| automated test info    | TMCOAR6     | TMCOBR6 | TMCOSB6    | TMCOP6    | TTVBTVSC1   | TCCSMCINHCN_1       |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST3 | MBC group (SD):Express;MBC GROUP Sponsorship (CPS):Express    |
And complete order contains item with clock number 'TCCSMCINHCN_1' with following fields:
| Job Number    | PO Number  |
| TMEATJ145     | GDNTDP145  |
And wait for finish place order with following item clock number 'TCCSMCINHCN_1' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |destinations                |
| DefaultAgency      | TCCSMCINHCN_1     |MBC group (SD)              |
|DefaultAgency       | TCCSMCINHCN_1     |MBC GROUP Sponsorship (CPS) |
When I login as 'ams.approval.user@adbank.me'
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And I wait till order with clockNumber 'TCCSMCINHCN_1' will be available in Traffic
And I amon order item details page of clockNumber 'TCCSMCINHCN_1'
And wait till order item with clockNumber 'TCCSMCINHCN_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I open Clone order item details page with clockNumber 'TCCSMCINHCN_1' from traffic order details page and validate cloned orders and Destinations 'MBC GROUP Sponsorship (CPS)'
And refresh the page
And click on 'Reject Proxy' button on order item details page in traffic
Then I 'should' see approval option of following destinations for order item on Approve pop up:
| MBC group (SD) | MBC GROUP Sponsorship (CPS)   |
| ON             | ON                            |
When I fill the following fields for specific destination on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
Then I 'should' see 'Proxy Rejected' Broadcaster Approval Status on on order item details page in traffic
When I login as 'mbc.user@adbank.me'
And I amon order item details page of clockNumber 'TCCSMCINHCN_1'
And I open Clone order item details page with clockNumber 'TCCSMCINHCN_1' from traffic order details page and validate cloned orders and Destinations 'MBC group (SD)'
Then I 'should' see 'Proxy Rejected' Broadcaster Approval Status on on order item details page in traffic

Scenario: Check that Approve Proxy works for Clock sent to more than one channel with Diffrent specifications within the hub
!--QA-454
!-- This will fail for now,as there is an problem with hd destination delivery(may pass wen they set target souce format as Sd in DB)
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TMCOAR8    | TMCOBR8 | TMCOSB8   | TMCOP8  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                                      |
| automated test info    | TMCOAR8     | TMCOBR8 | TMCOSB8    | TMCOP8    | TTVBTVSC1   | TCCSMCINHCN_3       |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST2 | MBC group (SD):Express;MBC GROUP (HD):Express    |
And complete order contains item with clock number 'TCCSMCINHCN_3' with following fields:
| Job Number   | PO Number |
| TMEATJ16     | GDNTDPO16 |
And wait for finish place order with following item clock number 'TCCSMCINHCN_3' to A4
And ingested assests through A5 with following fields:
| agencyName  | clockNumber       |destinations                |
|DefaultAgency| TCCSMCINHCN_3     |MBC group (SD)              |
|DefaultAgency| TCCSMCINHCN_3     |MBC GROUP (HD)              |
When I login as 'ams.approval.user@adbank.me'
And I wait till order with clockNumber 'TCCSMCINHCN_3' will be available in Traffic
And wait till order item with clockNumber 'TCCSMCINHCN_3' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TCCSMCINHCN_3' in simple search form on Traffic Order List page
And wait for '12' seconds
And open order item details page with clockNumber 'TCCSMCINHCN_3' and destionation 'MBC GROUP (HD)'
And refresh the page
And click on 'Approve Proxy' button on order item details page in traffic
And wait for '7' seconds
Then I 'should' see approval option of following destinations for order item on Approve pop up:
| MBC GROUP (HD)                |
| ON                            |
When I fill the following fields for specific destination on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
And wait for '5' seconds
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Back' button on order details page in traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TCCSMCINHCN_3' in simple search form on Traffic Order List page
And wait for '4' seconds
And open order item details page with clockNumber 'TCCSMCINHCN_3' and destionation 'MBC group (SD)'
Then I 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic

Scenario: Check that Reject Proxy works for Clock sent to more than one channel with diffrent specifications within the hub
!--QA-454
Meta: @ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TMCOAR7    | TMCOBR7 | TMCOSB7   | TMCOP7  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                                                   |
| automated test info    | TMCOAR7     | TMCOBR7 | TMCOSB7    | TMCOP7    | TTVBTVSC1   | TCCSMCINHCN_4       |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST3 | MBC group (SD):Express;MBC GROUP (HD):Express                 |
And complete order contains item with clock number 'TCCSMCINHCN_4' with following fields:
| Job Number    | PO Number  |
| TMEATJ155     | GDNTDPO15  |
And wait for finish place order with following item clock number 'TCCSMCINHCN_4' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |destinations                |
| DefaultAgency      | TCCSMCINHCN_4     |MBC group (SD)              |
| DefaultAgency      | TCCSMCINHCN_4     |MBC GROUP (HD)              |
When I login as 'ams.approval.user@adbank.me'
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And wait till order with clockNumber 'TCCSMCINHCN_4' will be available in Traffic
And wait till order item with clockNumber 'TCCSMCINHCN_4' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And enter search criteria 'TCCSMCINHCN_4' in simple search form on Traffic Order List page
And wait for '4' seconds
And go to order item details page with clockNumber 'TCCSMCINHCN_4' using destination 'MBC GROUP (HD)'
And refresh the page
And click on 'Reject Proxy' button on order item details page in traffic
Then I 'should' see approval option of following destinations for order item on Approve pop up:
| MBC GROUP (HD)                |
| ON                            |
When I fill the following fields for specific destination on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
Then I 'should' see 'Proxy Rejected' Broadcaster Approval Status on on order item details page in traffic
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TCCSMCINHCN_4' in simple search form on Traffic Order List page
And wait for '4' seconds
And go to order item details page with clockNumber 'TCCSMCINHCN_4' using destination 'MBC GROUP (SD)'
Then I 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic

Scenario: Check that AMS user can restore proxy and Reject Proxy
!-QA-450
Meta: @ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand    | Sub Brand   | Product  |
| TMCOAR11    | TMCOBR11 | TMCOSB11    | TMCOP11  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser   | Brand    | Sub Brand   | Product    | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title      | Destination               |
| automated test info    | TMCOAR11     | TMCOBR11 | TMCOSB11    | TMCOP11    | TTVBTVSC1   | TAMSURESPCN1_1      |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TAMSUAPT12 | MBC group (SD):Express    |
And complete order contains item with clock number 'TAMSURESPCN1_1' with following fields:
| Job Number  | PO Number |
| TMEATJ1     | GDNTDPO1  |
And I wait for finish place order with following item clock number 'TAMSURESPCN1_1' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |TAMSURESPCN1_1     |
When I login as 'ams.approval.user@adbank.me'
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order with clockNumber 'TAMSURESPCN1_1' will be available in Traffic
And wait till order item list will be loaded in Traffic
And am on order details page of clockNumber 'TAMSURESPCN1_1'
And wait till order item with clockNumber 'TAMSURESPCN1_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1                    |    Test   |
And click on 'Restore Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
Then I 'should' see 'Proxy Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I refresh the page
And click on 'Reject Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
Then I 'should' see 'Proxy Rejected' Broadcaster Approval Status on on order item details page in traffic

Scenario: Check that AMS user can approve proxy and MBC User can Release Master
!--QA-450
Meta: @ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand    | Sub Brand  | Product  |
| TMCOAR12    | TMCOBR12 | TMCOSB12   | TMCOP12  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser   | Brand    | Sub Brand   | Product    | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination               |
| automated test info    | TMCOAR12     | TMCOBR12 | TMCOSB12    | TMCOP12    | TTVBTVSC1   | TAMSUAPCN1_1        |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TAMSUAPT12 | MBC group (SD):Express    |
And complete order contains item with clock number 'TAMSUAPCN1_1' with following fields:
| Job Number   | PO Number |
| TMEATJ11     | GDNTDP11  |
And I wait for finish place order with following item clock number 'TAMSUAPCN1_1' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |TAMSUAPCN1_1       |
When I login as 'ams.approval.user@adbank.me'
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And I amon order item details page of clockNumber 'TAMSUAPCN1_1'
And wait till order item with clockNumber 'TAMSUAPCN1_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And fill house number field with value 'NCS' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1                    |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I login as 'mbc.user@adbank.me'
And select 'Waiting for Approval' tab in Traffic UI
And I amon order item details page of clockNumber 'TAMSUAPCN1_1'
And I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_4              | Master Released for first order item  |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic