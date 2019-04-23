!--QA-450
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

Scenario: Check that AMS user and MBC User can search by House Number
!--QA-452
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand   | Sub Brand | Product |
| TMCOAR9     | TMCOBR9 | TMCOSB9   | TMCOP9  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                                      |
| automated test info    | TMCOAR9     | TMCOBR9 | TMCOSB9    | TMCOP9    | TTVBTVSC1   | TBMSEARHN_1         |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST2 | MBC group (SD):Express;                          |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                                      |
| automated test info    | TMCOAR9     | TMCOBR9 | TMCOSB9    | TMCOP9    | TTVBTVSC1   | TBMSEARHN_2         |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST3 | MBC group (SD):Express;                          |
And complete order contains item with clock number 'TBMSEARHN_1' with following fields:
| Job Number   | PO Number |
| TMEATJ16     | GDNTDPO16 |
And complete order contains item with clock number 'TBMSEARHN_2' with following fields:
| Job Number   | PO Number |
| TMEATJ17     | GDNTDPO17 |
And wait for finish place order with following item clock number 'TBMSEARHN_1' to A4
And wait for finish place order with following item clock number 'TBMSEARHN_2' to A4
And ingested assests through A5 with following fields:
| agencyName  | clockNumber       |destinations                |
|DefaultAgency| TBMSEARHN_1       |MBC group (SD)              |
|DefaultAgency| TBMSEARHN_2       |MBC group (SD)              |
When I login as 'ams.approval.user@adbank.me'
And I wait till order with clockNumber 'TBMSEARHN_1' will be available in Traffic
And I wait till order with clockNumber 'TBMSEARHN_2' will be available in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item with clockNumber 'TBMSEARHN_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'TBMSEARHN_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And on order item details page of clockNumber 'TBMSEARHN_1'
And refresh the page
And fill house number field with value 'NCS' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Back' button on order details page in traffic
And refresh the page
And on order item details page of clockNumber 'TBMSEARHN_2'
And refresh the page
And fill house number field with value 'ECS' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I login as 'mbc.user@adbank.me'
And select 'Waiting for Approval' tab in Traffic UI
And on order item details page of clockNumber 'TBMSEARHN_1'
And I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_4              | Master Released for first order item |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Back' button on order details page in traffic
And refresh the page
And on order item details page of clockNumber 'TBMSEARHN_2'
And I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_4              | Master Released for first order item |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Back' button on order details page in traffic
And select 'Delivered' tab in Traffic UI
And refresh the page
And enter search criteria 'TBMSEARHN_1' in simple search form on Traffic Order List page
And wait for '4' seconds
Then I 'should' see order with Title 'TTVBTVST2' in Order Item send list on searching based on the 'House Number' whose value is 'NCS'
When I logout from account
And I login as 'ams.approval.user@adbank.me'
And select 'Delivered' tab in Traffic UI
And refresh the page
And enter search criteria 'TBMSEARHN_1' in simple search form on Traffic Order List page
And wait for '4' seconds
Then I 'should' see order with Title 'TTVBTVST2' in Order Item send list on searching based on the 'House Number' whose value is 'NCS'


Scenario: Check that AMS user and MBC User can search by Advertiser, Clock , Title
!--QA-452
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser   | Brand    | Sub Brand  | Product  |
| TMCOAR10     | TMCOBR10 | TMCOSB10   | TMCOP10  |
| TMCOAR19     | TMCOBR19 | TMCOSB19   | TMCOP19  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser   | Brand    | Sub Brand   | Product    | Campaign    | Clock Number           |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                                      |
| automated test info    | TMCOAR19     | TMCOBR19 | TMCOSB19    | TMCOP19    | TTVBTVSC1   | <ClockNumber1>         |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST4 | MBC group (SD):Express;                          |
| automated test info    | TMCOAR10     | TMCOBR10 | TMCOSB10    | TMCOP10    | TTVBTVSC1   | <ClockNumber2>         |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST6 | MBC group (SD):Express;                          |
| automated test info    | TMCOAR10     | TMCOBR10 | TMCOSB10    | TMCOP10    | TTVBTVSC1   | <ClockNumber3>         |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST6 | MBC group (SD):Express;                          |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number   | PO Number |
| TMEATJ17     | GDNTDPO17 |
And wait for finish place order with following item clock number '<ClockNumber1>' to A4
And wait for finish place order with following item clock number '<ClockNumber2>' to A4
And wait for finish place order with following item clock number '<ClockNumber3>' to A4
And waited for '10' seconds
And ingested assests through A5 with following fields:
| agencyName  | clockNumber          |destinations                |
|DefaultAgency| <ClockNumber1>       |MBC group (SD)              |
|DefaultAgency| <ClockNumber2>       |MBC group (SD)              |
|DefaultAgency| <ClockNumber3>       |MBC group (SD)              |
When I login as 'ams.approval.user@adbank.me'
And I wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And I wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And I wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber '<ClockNumber2>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber '<ClockNumber3>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber '<ClockNumber1>'
And refresh the page
And fill house number field with value 'NCS' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Back' button on order details page in traffic
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber '<ClockNumber2>'
And refresh the page
And fill house number field with value 'NCS' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Back' button on order details page in traffic
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber '<ClockNumber3>'
And refresh the page
And fill house number field with value 'NCS' on order details page in traffic
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I login as 'mbc.user@adbank.me'
And select 'Waiting for Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber '<ClockNumber1>'
And I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_4 | Master Released for first order item |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Back' button on order details page in traffic
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber '<ClockNumber2>'
And I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_4 | Master Released for first order item |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Back' button on order details page in traffic
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber '<ClockNumber3>'
And I click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_4 | Master Released for first order item |
Then I 'should' see 'Master Released' Broadcaster Approval Status on on order item details page in traffic
When I logout from account
And I login as 'ams.approval.user@adbank.me'
And select 'Delivered' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
And wait for '6' seconds
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic
When I pin 'All' tab in Traffic UI
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
And wait for '4' seconds
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
When I logout from account
And I login as 'mbc.user@adbank.me'
And select 'Delivered' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
And wait for '8' seconds
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic
When I select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
And wait for '4' seconds
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic

Examples:
|ClockNumber1|ClockNumber2|ClockNumber3|OrderNotAvailable        |      OrderAvailable                  |SearchCriteria |
|TBMSEAR_1   |TBMSEAR_2 | TBMSEAR_3    | TBMSEAR_1               |TBMSEAR_2,TBMSEAR_3                   |   TMCOAR10    |
|TBMSEAR_4   |TBMSEAR_5 | TBMSEAR_6    | TBMSEAR_4,TBMSEAR_6     |TBMSEAR_5                             |   TBMSEAR_5   |
|TBMSEAR_7   |TBMSEAR_8 | TBMSEAR_9    | TBMSEAR_7               |TBMSEAR_8,TBMSEAR_9                   |   TTVBTVST6   |
