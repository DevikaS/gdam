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

Scenario: Check that HouseNumber should keep its history on Re Editing (MENA template) for AMS User
!--QA-446
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TMCOAR1_1  | TMCOBR1 | TMCOSB1   | TMCOP1  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination               |
| automated test info    | TMCOAR1_1   | TMCOBR1 | TMCOSB1    | TMCOP1    | TTVBTVSC1   | <ClockNumber>       |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | MBC group (SD):Express    |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number  | PO Number |
| TMCOJO34    | TMCOPO134 |
And I wait for finish place order with following item clock number '<ClockNumber>' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |<ClockNumber>      |
When I login as 'ams.approval.user@adbank.me'
And I wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber '<ClockNumber>'
And verify house number is not set in order item details page for Mena Market in traffic
And I fill house number field with value '<HouseNumber>' on order details page in traffic
And I edit house number field with value '<New_HouseNumber>' on order details page in traffic
And I edit house number field with value '<HouseNumber>' on order details page in traffic
Then I should see House Number restored after ReEditing of '<HouseNumber>'
When I login as 'mbc.user@adbank.me'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber '<ClockNumber>'
Then I 'should not' see edit house number field on order details page in traffic


Examples:
| ClockNumber    |   HouseNumber  | New_HouseNumber  |
| BTSKHHNRECN_1  |   NCS          |  CS              |
| BTSKHHNRECN_2  |   ECS          |  NCS             |
| BTSKHHNRECN_3  |   CS           |  ECS             |

Scenario: Check that HouseNumber should keep its history on deletion (MENA template) for AMS USer
!--QA-446
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TMCOAR2    | TMCOBR2 | TMCOSB2   | TMCOP2  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                            |
| automated test info    | TMCOAR2     | TMCOBR2 | TMCOSB2    | TMCOP2    | TTVBTVSC1   | <ClockNumber>       |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TAMSURPT16 | MBC group (SD):Express                |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number  | PO Number |
| TMCOJO36    | TMCOPO136 |
And wait for finish place order with following item clock number '<ClockNumber>' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |<ClockNumber>      |
When I login as 'ams.approval.user@adbank.me'
And I wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber '<ClockNumber>'
And verify house number is not set in order item details page for Mena Market in traffic
When fill house number field with value '<HouseNumber>' on order details page in traffic
And delete house number field on order details page
And fill house number field with value '<HouseNumber>' on order details page in traffic
Then I should see House Number restored after ReEditing of '<HouseNumber>'

Examples:
| ClockNumber  |   HouseNumber  |
| BTSKHHNCN_1  |   NCS          |
| BTSKHHNCN_2  |   ECS          |
| BTSKHHNCN_3  |   CS           |

Scenario: Check that HouseNumber(Mena Template) is genearted Sequentially
!--QA-446
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TMCOAR3    | TMCOBR3 | TMCOSB3   | TMCOP3  |
| TMCOAR4    | TMCOBR4 | TMCOSB4   | TMCOP4  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                            |
| automated test info    | TMCOAR3     | TMCOBR3 | TMCOSB3    | TMCOP3    | TTVBTVSC1   | BTSKHHNRECN_4       |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | MBC group (SD):Express                 |
| automated test info    | TMCOAR4     | TMCOBR4 | TMCOSB4    | TMCOP4    | TTVBTVSC1   | BTSKHHNRECN_5       |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | MBC GROUP Sponsorship (CPS):Express    |
And complete order contains item with clock number 'BTSKHHNRECN_4' with following fields:
| Job Number  | PO Number |
| TMCOJO35    | TMCOPO135 |
And I wait for finish place order with following item clock number 'BTSKHHNRECN_4' to A4
And I wait for finish place order with following item clock number 'BTSKHHNRECN_5' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |BTSKHHNRECN_4      |
| DefaultAgency      |BTSKHHNRECN_5      |
When I login as 'ams.approval.user@adbank.me'
And wait till order with clockNumber 'BTSKHHNRECN_4' will be available in Traffic
And wait till order with clockNumber 'BTSKHHNRECN_5' will be available in Traffic
And wait till order item with clockNumber 'BTSKHHNRECN_4' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber 'BTSKHHNRECN_5' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber 'BTSKHHNRECN_4'
And verify house number is not set in order item details page for Mena Market in traffic
And I fill house number field with value 'NCS' on order details page in traffic
And I click on 'Back' button on order details page in traffic
And on order item details page of clockNumber 'BTSKHHNRECN_5'
And I fill house number field with value 'NCS' on order details page in traffic
Then I should see House Number restored is sequential of 'NCS'