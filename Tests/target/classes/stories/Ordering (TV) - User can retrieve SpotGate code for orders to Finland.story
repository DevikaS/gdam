!--ORD-4747
!--ORD-5064
!--GDN-1514 (On Cover flow generated spot code not displayed any more due to field change, confirmed with Maria. Removed cover flow verification step
Feature: User can retrieve SpotGate code for orders to Finland
Narrative:
In order to:
As a AgencyAdmin
I want to check that user can retrieve SpotGate code for orders to Finland

Scenario: check SpotGate code generating for Finland market
Meta:@uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| UCRSGCA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| UCRSGCU1 | agency.admin | UCRSGCA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCRSGCA1':
| Advertiser | Brand     | Sub Brand | Product   |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 |
And logged in with details of 'UCRSGCU1'
And create 'tv' order with market 'Finland' and items with following fields:
| Advertiser | Brand     | Sub Brand | Product   | Duration | Title    |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 | 20       | UCRSGCT1 |
When I open order item with next title 'UCRSGCT1'
And generate 'spot gate code' value for Add information form on order item page
Then I should see following spot gate generated code 'SG\d{6}' for field 'Spotgate Code' on Add information form of order item page

Scenario: check SpotGate warning message in case generation code without filling required fields
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| UCRSGCA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| UCRSGCU1 | agency.admin | UCRSGCA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCRSGCA1':
| Advertiser | Brand     | Sub Brand | Product   |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 |
And logged in with details of 'UCRSGCU1'
And create 'tv' order with market 'Finland' and items with following fields:
| Title    |
| UCRSGCT2 |
When I open order item with next title 'UCRSGCT2'
And click 'spot gate code' button for Add information form on order item page
Then I should see message error 'Sorry something went wrong, please contact support if issue persists'

Scenario: Check that SpotGate field is required
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| UCRSGCA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| UCRSGCU1 | agency.admin | UCRSGCA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCRSGCA1':
| Advertiser | Brand     | Sub Brand | Product   |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 |
And logged in with details of 'UCRSGCU1'
And create 'tv' order with market 'Finland' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Duration | First Air Date | Format         | Title    | Destination                  |
| automated test info    | UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 | UCRSGCC3 | 20       | 10/14/2022     | HD 1080i 25fps | UCRSGCT3 | YuME Finland Online:Standard |
When I open order item with next title 'UCRSGCT3'
And click active Proceed button on order item page
Then I 'should' see that following fields 'Spotgate Code' are required for order item on Add information form

Scenario: Check that SpotGate field is locked for QC asset in Library
Meta:@uatorderingsmoke
@obug
!--UIR-987
Given I created the following agency:
| Name     | A4User        |
| UCRSGCA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| UCRSGCU1 | agency.admin | UCRSGCA1     |
And updated the following agency:
| Name     | Save In Library | Allow To Save In Library |
| UCRSGCA1 | should          | should                   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCRSGCA1':
| Advertiser | Brand     | Sub Brand | Product   |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 |
And logged in with details of 'UCRSGCU1'
And create 'tv' order with market 'Finland' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Duration | First Air Date | Format         | Title    | Destination                  |
| automated test info    | UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 | UCRSGCC4 | 20       | 10/14/2022     | HD 1080i 25fps | UCRSGCT4 | YuME Finland Online:Standard |
When I open order item with next title 'UCRSGCT4'
And generate 'spot gate code' value for Add information form on order item page
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| UCRSGCJN4  | UCRSGCPN4 |
And confirm order on Order Proceed page
And go to asset 'UCRSGCT4' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following fields 'Clock number,Duration' in 'locked' state on opened Edit asset popup

Scenario: check that SpotGate field is locked on order item page afte retrieving QC asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| UCRSGCA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| UCRSGCU1 | agency.admin | UCRSGCA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCRSGCA1':
| Advertiser | Brand     | Sub Brand | Product   |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 |
And logged in with details of 'UCRSGCU1'
And create 'tv' order with market 'Finland' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                  |
| automated test info    | UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 | UCRSGCC5 | UCRSGCCN5_1  | 20       | 10/14/2022     | HD 1080i 25fps | UCRSGCT5 | YuME Finland Online:Standard |
And create 'tv' order with market 'Finland' and items with following fields:
| Clock Number |
| UCRSGCCN5_2  |
And complete order contains item with clock number 'UCRSGCCN5_1' with following fields:
| Job Number | PO Number |
| UCRSGCJN5  | UCRSGCPN5 |
And add to 'tv' order item with clock number 'UCRSGCCN5_2' following qc asset 'UCRSGCT5' of collection 'My Assets'
When I open order item with following clock number 'UCRSGCCN5_1'
Then I should see 'disabled' following fields 'Spotgate Code' for order item on Add information form

Scenario: Check SpotGate field value after saving as draft order
Meta:@uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| UCRSGCA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| UCRSGCU1 | agency.admin | UCRSGCA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCRSGCA1':
| Advertiser | Brand     | Sub Brand | Product   |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 |
And logged in with details of 'UCRSGCU1'
And create 'tv' order with market 'Finland' and items with following fields:
| Advertiser | Brand     | Sub Brand | Product   | Duration | Title    |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 | 20       | UCRSGCT6 |
When I open order item with next title 'UCRSGCT6'
And generate 'spot gate code' value for Add information form on order item page
And save as draft order
And open order item with next title 'UCRSGCT6'
Then I should see following spot gate generated code 'SG\d{6}' for field 'Spotgate Code' on Add information form of order item page

Scenario: Check clearing of SpotGate field value after saving as draft order
Meta:@uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| UCRSGCA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| UCRSGCU1 | agency.admin | UCRSGCA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCRSGCA1':
| Advertiser | Brand     | Sub Brand | Product   |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 |
And logged in with details of 'UCRSGCU1'
And create 'tv' order with market 'Finland' and items with following fields:
| Advertiser | Brand     | Sub Brand | Product   | Duration | Title    |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 | 20       | UCRSGCT7 |
When I open order item with next title 'UCRSGCT7'
And generate 'spot gate code' value for Add information form on order item page
And save as draft order
And open order item with next title 'UCRSGCT7'
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Advertiser | Brand | Product | Clock Number | Duration | Title |
|            |       |         |              |          |       |

Scenario: Check copying of SpotGate field value
Meta:@uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| UCRSGCA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| UCRSGCU1 | agency.admin | UCRSGCA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCRSGCA1':
| Advertiser | Brand     | Sub Brand | Product   |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 |
And logged in with details of 'UCRSGCU1'
And create 'tv' order with market 'Finland' and items with following fields:
| Advertiser | Brand     | Sub Brand | Product   | Duration | Title    |
| UCRSGCAR1  | UCRSGCBR1 | UCRSGCSB1 | UCRSGCPR1 | 20       | UCRSGCT8 |
When I open order item with next title 'UCRSGCT8'
And generate 'spot gate code' value for Add information form on order item page
And 'copy current' order item by Add Commercial button on order item page
Then I should see following spot gate generated code 'SG\d{6}' for field 'Spotgate Code' on Add information form of order item page


Scenario: Check that SpotGate metadata is changeable on Common Ordering Metadata area
Meta: @ordering
Given I am logged in as 'GlobalAdmin'
And created the following agency:
| Name     | A4User        |
| UCRSGCA9 | DefaultA4User |
And I am on the global common ordering metadata page of market 'Finland' for agency 'UCRSGCA9'
When I click 'Spotgate Code' button in 'editable metadata' section on opened metadata page
And fill Description field with text 'Spotgate Code Custom' on opened Settings and Customization tab
And save metadata field settings
Then I 'should' see button 'Spotgate Code Custom' in 'editable metadata' section on opened metadata page