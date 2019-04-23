!--ORD-4047
!--ORD-4366
!--ORD-4286
!--ORD-4272
!--ORD-4740
Feature: On Behalf of
Narrative:
In order to:
As a AgencyAdmin
I want to check on Behalf of

Scenario: Check default ordering on behalf of on order item page
!--ORD-4775
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA1_1 | DefaultA4User |
| OBA1_2 | DefaultA4User |
And added agency 'OBA1_2' as a partner for agency 'OBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU1_1 | agency.admin | OBA1_1       |
| OBU1_2 | agency.admin | OBA1_2       |
And added existing user 'OBU1_2' to agency 'OBA1_1' with role 'agency.admin'
And logged in with details of 'OBU1_2'
When I create 'tv' order on View Draft Orders tab with following on behalf of BU 'OBA1_2'
Then I should see following on behalf of BU 'OBA1_2' on order item page

Scenario: Check order items cover flow after changing on behalf of BU on order item page
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA1_1 | DefaultA4User |
| OBA1_2 | DefaultA4User |
And added agency 'OBA1_2' as a partner for agency 'OBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU1_1 | agency.admin | OBA1_1       |
| OBU1_2 | agency.admin | OBA1_2       |
And added existing user 'OBU1_2' to agency 'OBA1_1' with role 'agency.admin'
And logged in with details of 'OBU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN2_1      |
| OBCN2_2      |
When I open order item with following clock number 'OBCN2_1'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA1_1          | OBA1_1                  |
Then I should see for active order item on cover flow following data:
| Title | Duration | Clock Number | Counter | Cover Title |
|       |          |              |         |             |


Scenario: Check that QC asset is created in BU1 library after placing order by user U2 from BU2 on behalf of BU1
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |Save In Library |Allow To Save In Library|
| OBA1_1 | DefaultA4User |should          |should          |
| OBA1_2 | DefaultA4User |should          |should          |
And added agency 'OBA1_2' as a partner for agency 'OBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |Access|
| OBU1_1 | agency.admin | OBA1_1       |streamlined_library,ordering|
| OBU1_2 | agency.admin | OBA1_2       |streamlined_library,ordering
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 |
And added existing user 'OBU1_2' to agency 'OBA1_1' with role 'agency.admin'
And logged in with details of 'OBU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN3        |
When I open order item with following clock number 'OBCN3'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA1_1          | OBA1_1                  |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required |
| automated test info    | OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 | OBC3     | OBCN3        | 15       | 08/14/2022     | HD 1080i 25fps | OBT3  | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OBJN3      | OBPN3     |
And confirm order on Order Proceed page
And login with details of 'OBU1_1'
And wait for '10' seconds
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see QCed assets with titles 'OBT3' in the collection 'Everything'NEWLIB




Scenario: Check that order is accessible for all BU1 users after creating order by user U2 from BU2 on behalf of BU1
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA4_1 | DefaultA4User |
| OBA4_2 | DefaultA4User |
And added agency 'OBA4_2' as a partner for agency 'OBA4_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OBU4_1_1 | agency.admin | OBA4_1       |
| OBU4_1_2 | agency.user  | OBA4_1       |
| OBU4_2   | agency.admin | OBA4_2       |
And added existing user 'OBU4_2' to agency 'OBA4_1' with role 'agency.admin'
And logged in with details of 'OBU4_2'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OBCN4        |
When I open order item with following clock number 'OBCN4'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA4_1          | OBA4_1                  |
And login with details of 'OBU4_1_2'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should' see order with following market 'Republic of Ireland' in 'draft' order list

Scenario: Check that order is accessible only for user U2 in BU2 after creating it on behalf of BU1
!--ORD-4763
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA5_1 | DefaultA4User |
| OBA5_2 | DefaultA4User |
And added agency 'OBA5_2' as a partner for agency 'OBA5_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OBU5_1   | agency.admin | OBA5_1       |
| OBU5_2_1 | agency.admin | OBA5_2       |
| OBU5_2_2 | agency.admin | OBA5_2       |
And added existing user 'OBU5_2_1' to agency 'OBA5_1' with role 'agency.admin'
And logged in with details of 'OBU5_2_1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OBCN5        |
When I open order item with following clock number 'OBCN5'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA5_1          | OBA5_1                  |
And login with details of 'OBU5_2_2'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should not' see order with following market 'Republic of Ireland' in 'draft' order list

Scenario: Check that markets and destinations are loaded for different A4 agencies after changing on behalf of BU
Meta: @ordering
Given I created the following agency:
| Name   | A4User                     | A4 Agency Id                         |
| OBA6_1 | porsche-admin@adbank.me.ua | 60DBE905-6E3D-4D7F-A34C-409D7BC5E706 |
| OBA6_2 | DefaultA4User              |                                      |
And added agency 'OBA6_2' as a partner for agency 'OBA6_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU6_1 | agency.admin | OBA6_1       |
| OBU6_2 | agency.admin | OBA6_2       |
And added existing user 'OBU6_2' to agency 'OBA6_1' with role 'agency.admin'
And logged in with details of 'OBU6_2'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OBCN6        |
And add for order that contains item with clock number 'OBCN6' following invoicing organisation 'OBA6_1'
And add for order that contains item with clock number 'OBCN6' following on behalf of organisation 'OBA6_1'
When I open order item with following market 'Republic of Ireland'
And select following market 'Spain' on order item page
Then I should see selected following market 'Spain' on order item page
And 'should' see destination table with destinations for order item on Select Broadcast Destinations form

Scenario: Check that error message is shown if on behalf of BU hasn't catalog structure
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Mark as Advertiser | Mark as Product | Mark as Campaign |
| OBA7_1 | DefaultA4User |                    |                 |                  |
| OBA7_2 | DefaultA4User | Advertiser         | Product         | Campaign         |
And added agency 'OBA7_2' as a partner for agency 'OBA7_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU7_1 | agency.admin | OBA7_1       |
| OBU7_2 | agency.admin | OBA7_2       |
And added existing user 'OBU7_2' to agency 'OBA7_1' with role 'agency.admin'
And logged in with details of 'OBU7_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN7        |
When I open order item with following market 'United Kingdom'
And fill in following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU |
| OBA7_1          |
Then I should see message error without delay 'Advertiser and Product are not defined. Please contact OBA7_1\D+ support for help.'

Scenario: Check that users partners list is loaded from on behalf of BU during transfer
!--NGN-16944
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA8_1 | DefaultA4User |
| OBA8_2 | DefaultA4User |
| OBA8_3 | DefaultA4User |
And added agency 'OBA8_2' as a partner for agency 'OBA8_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And added agency 'OBA8_3' as a partner to agency 'OBA8_1'
And created users with following fields:
| Email        | Role         | AgencyUnique |
| OBU8_1       | agency.admin | OBA8_1       |
| OBU8_2       | agency.admin | OBA8_2       |
| OBU8_3_email | agency.admin | OBA8_3       |
And added existing user 'OBU8_2' to agency 'OBA8_1' with role 'agency.admin'
And logged in with details of 'OBU8_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN8        |
And add for order that contains item with clock number 'OBCN8' following invoicing organisation 'OBA8_1'
And add for order that contains item with clock number 'OBCN8' following on behalf of organisation 'OBA8_1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select orders with following markets 'United Kingdom' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to  | Message                   |
| OBU8_3_email | autotest transfer message |
Then I should see 'enabled' Send button on Transfer Order form

Scenario: Check showing new metadata field from Commong Ordering metadata for order which on behalf of another BU
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA9_1 | DefaultA4User |
| OBA9_2 | DefaultA4User |
And added agency 'OBA9_2' as a partner for agency 'OBA9_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU9_1 | agency.admin | OBA9_1       |
| OBU9_2 | agency.admin | OBA9_2       |
And added existing user 'OBU9_2' to agency 'OBA9_1' with role 'agency.admin'
And I am logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'OBA9_1'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String Common Ordering' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'OBU9_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN9        |
And add for order that contains item with clock number 'OBCN9' following invoicing organisation 'OBA9_1'
And add for order that contains item with clock number 'OBCN9' following on behalf of organisation 'OBA9_1'
When I open order item with following market 'United Kingdom'
Then I 'should' see following custom field 'String Common Ordering' for order item on Add information form

Scenario: Check Add Information section after adding asset to order which on behalf of another BU
!--ORD-4771
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OBA10_1 | DefaultA4User |
| OBA10_2 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OBU10_1 | agency.admin | OBA10_1      |streamlined_library,ordering|
| OBU10_2 | agency.admin | OBA10_2      |streamlined_library,ordering|
And added existing user 'OBU10_2' to agency 'OBA10_1' with role 'agency.admin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA10_1':
| Advertiser | Brand    | Sub Brand | Product  |
| OBAR10_1   | OBBR10_1 | OBSB10_1  | OBPR10_1 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA10_2':
| Advertiser | Brand    | Sub Brand | Product  |
| OBAR10_2   | OBBR10_2 | OBSB10_2  | OBPR10_2 |
And logged in with details of 'OBU10_2'
When I upload following assets into following agenciesNEWLIB:
| Name                | AgencyName |
| /files/Fish1-Ad.mov | OBA10_1    |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN10       |
When I open order item with following clock number 'OBCN10'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU |
| OBA10_1         |
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
Then I should see following data for order item on Add information form:
| Title        |
| Fish1-Ad.mov |


Scenario: Check that confirmation email has been sent to user U2 after confirming order which on behalf of BU1
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        |
| OBA1_1 | DefaultA4User |
| OBA1_2 | DefaultA4User |
And added agency 'OBA1_2' as a partner for agency 'OBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU1_1 | agency.admin | OBA1_1       |
| OBU1_2 | agency.admin | OBA1_2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 |
And added existing user 'OBU1_2' to agency 'OBA1_1' with role 'agency.admin'
And logged in with details of 'OBU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN11       |
When I open order item with following clock number 'OBCN11'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA1_1          | OBA1_1                  |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required |
| automated test info    | OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 | OBC11    | OBCN11       | 15       | 08/14/2022     | HD 1080i 25fps | OBT11 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha |
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'OBCN11' of QC View summary on Order Proceed page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OBJN11     | OBPN11    |
And confirm order on Order Proceed page
Then I 'should' see email notification for 'Order Confirmation' with field to 'OBU1_2' and subject 'Order Confirmation:' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number |
| adstream     | OBU1_2   | OBCN11       | OBJN11     | OBPN11    |

Scenario: Check clock number validation for orders in BU1 after placing an order in BU2 on behalf of BU1
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA1_1 | DefaultA4User |
| OBA1_2 | DefaultA4User |
And added agency 'OBA1_2' as a partner for agency 'OBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU1_1 | agency.admin | OBA1_1       |
| OBU1_2 | agency.admin | OBA1_2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 |
And added existing user 'OBU1_2' to agency 'OBA1_1' with role 'agency.admin'
And logged in with details of 'OBU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN12       |
When I open order item with following clock number 'OBCN12'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA1_1          | OBA1_1                  |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required |
| automated test info    | OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 | OBC12    | OBCN12       | 15       | 08/14/2022     | HD 1080i 25fps | OBT12 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha |
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'OBCN12' of QC View summary on Order Proceed page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OBJN12     | OBPN12    |
And confirm order on Order Proceed page
And login with details of 'OBU1_1'
And created 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OBCN12       |
And open order item with clock number 'OBCN12' for order with market 'Republic of Ireland'
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: BU that creates an order on behalf of should be able to select partner BU for billing when it has proper permission
!--ORD-4272
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OBA13_1 | DefaultA4User |
| OBA13_2 | DefaultA4User |
| OBA13_3 | DefaultA4User |
And added agency 'OBA13_2' as a partner for agency 'OBA13_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And added agency 'OBA13_3' as a partner for agency 'OBA13_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OBU13_1 | agency.admin | OBA13_1      |
| OBU13_2 | agency.admin | OBA13_2      |
| OBU13_3 | agency.admin | OBA13_3      |
And added existing user 'OBU13_2' to agency 'OBA13_1' with role 'agency.admin'
And logged in with details of 'OBU13_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN13       |
When I open order item with following clock number 'OBCN13'
And fill in following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU |
| OBA13_1         |
Then I 'should' see available following invoice on behalf of BUs 'OBA13_1,OBA13_2,OBA13_3' on Change BU on behalf of popup

Scenario: BU that creates an order on behalf of should not be able to select partner BU for billing when it has not proper permission
!--ORD-4272
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA8_1 | DefaultA4User |
| OBA8_2 | DefaultA4User |
| OBA8_3 | DefaultA4User |
And added agency 'OBA8_2' as a partner for agency 'OBA8_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And added agency 'OBA8_3' as a partner to agency 'OBA8_1'
And created users with following fields:
| Email        | Role         | AgencyUnique |
| OBU8_1       | agency.admin | OBA8_1       |
| OBU8_2       | agency.admin | OBA8_2       |
| OBU8_3_email | agency.admin | OBA8_3       |
And added existing user 'OBU8_2' to agency 'OBA8_1' with role 'agency.admin'
And logged in with details of 'OBU8_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN14       |
When I open order item with following clock number 'OBCN14'
And fill in following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU |
| OBA8_1          |
Then I 'should' see available following invoice on behalf of BUs 'OBA8_1,OBA8_2' on Change BU on behalf of popup
And 'should not' see available following invoice on behalf of BUs 'OBA8_3' on Change BU on behalf of popup

Scenario: check order summary page of order in BU1 after placing it by user U2 in BU2 on behalf of BU1
!--ORD-4268
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA1_1 | DefaultA4User |
| OBA1_2 | DefaultA4User |
And added agency 'OBA1_2' as a partner for agency 'OBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU1_1 | agency.admin | OBA1_1       |
| OBU1_2 | agency.admin | OBA1_2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 |
And added existing user 'OBU1_2' to agency 'OBA1_1' with role 'agency.admin'
And logged in with details of 'OBU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN15       |
When I open order item with following clock number 'OBCN15'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA1_1          | OBA1_1                  |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required |
| automated test info    | OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 | OBC15    | OBCN15       | 15       | 08/14/2022     | HD 1080i 25fps | OBT15 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha |
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'OBCN15' of QC View summary on Order Proceed page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OBJN15     | OBPN15    |
And confirm order on Order Proceed page
And login with details of 'OBU1_1'
And go to Order Summary page for order contains item with following clock number 'OBCN15'
Then I should see for order contains item with clock number 'OBCN15' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number | Flag           | Market         | Invoiced Organisation |
| Dijit        | OBA1_1       | DateSubmitted  | CreatedBy  | OBJN15     | OBPN15    | United Kingdom | United Kingdom | OBA1_1                |
And should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Brand   | Sub Brand | Product | Title | First Air Date | Format         | Duration | Status        | Approve |
| OBCN15       | OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 | OBT15 | 08/14/2022     | HD 1080i 25fps | 15       | 0/1 Delivered |         |
And should see clock delivery 'OBCN15' contains destinations with following fields on 'tv' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| Aastha | Order Placed | -                | Standard |

Scenario: check on behalf of BU on order item page after transfering order
!--ORD-4783
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA8_1 | DefaultA4User |
| OBA8_2 | DefaultA4User |
| OBA8_3 | DefaultA4User |
And added agency 'OBA8_2' as a partner for agency 'OBA8_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And added agency 'OBA8_3' as a partner to agency 'OBA8_1'
And created users with following fields:
| Email        | Role         | AgencyUnique |
| OBU8_1       | agency.admin | OBA8_1       |
| OBU8_2       | agency.admin | OBA8_2       |
| OBU8_3_email | agency.admin | OBA8_3       |
And added existing user 'OBU8_2' to agency 'OBA8_1' with role 'agency.admin'
And logged in with details of 'OBU8_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN16       |
When I open order item with following clock number 'OBCN16'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA8_1          | OBA8_1                  |
And fill following fields for Transfer Order form on order item page:
| Transfer to  | Message                   |
| OBU8_3_email | autotest transfer message |
And click Send button on Transfer Order form on order item page
Then I should see following on behalf of BU 'OBA8_1' on order item page
And should see following invoicing organisation 'OBA8_1' on order item page

Scenario: check invoice to BU on order summary page
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA1_1 | DefaultA4User |
| OBA1_2 | DefaultA4User |
And added agency 'OBA1_2' as a partner for agency 'OBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU1_1 | agency.admin | OBA1_1       |
| OBU1_2 | agency.admin | OBA1_2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 |
And added existing user 'OBU1_2' to agency 'OBA1_1' with role 'agency.admin'
And logged in with details of 'OBU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN17       |
When I open order item with following clock number 'OBCN17'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA1_1          | OBA1_1                  |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required |
| automated test info    | OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 | OBC17    | OBCN17       | 15       | 08/14/2022     | HD 1080i 25fps | OBT17 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha|
And click Proceed button on order item page
Then I should see next invoicing organisation 'OBA1_1' on order proceed page

Scenario: On behalf of option should not be shown if it shouldn't be possible to order on behalf of at all
!--ORD-4408
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OBA18_1 | DefaultA4User |
| OBA18_2 | DefaultA4User |
And added agency 'OBA18_2' as a partner for agency 'OBA18_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OBU18_1 | agency.admin | OBA18_1      |
| OBU18_2 | agency.admin | OBA18_2      |
And added existing user 'OBU18_2' to agency 'OBA18_1' with role 'guest.user'
And logged in with details of 'OBU18_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN18       |
When I open order item with following clock number 'OBCN18'
Then I 'should not' see on behalf of BU option on order item page

Scenario: Check that billing rates are taken from owners BU
!--ORD-4740
!--NIR-750
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OBA19_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OBA19_2 | DefaultA4User | United Kingdom | DefaultSapID |
| OBA19_3 | DefaultA4User | United Kingdom | BM0005       |
And added agency 'OBA19_2' as a partner for agency 'OBA19_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And added agency 'OBA19_3' as a partner for agency 'OBA19_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OBU19_1 | agency.admin | OBA19_1      |
| OBU19_2 | agency.admin | OBA19_2      |
| OBU19_3 | agency.admin | OBA19_3      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA19_1':
| Advertiser | Brand    | Sub Brand | Product  |
| OBAR19_1   | OBBR19_1 | OBSB19_1  | OBPR19_1 |
And added existing user 'OBU19_2' to agency 'OBA19_1' with role 'agency.admin'
And logged in with details of 'OBU19_2'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN19       |
When I open order item with following clock number 'OBCN19'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA19_1         | OBA19_3                 |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required |
| automated test info    | OBAR19_1   | OBBR19_1 | OBSB19_1  | OBPR19_1 | OBC19    | OBCN19       | 15       | 08/14/2022     | HD 1080i 25fps | OBT19 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha |
And click Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax   | Total  |
| SD Standard Normal (Digital) | 1   | 50.00 | 50.00         | 50.00   | 10.50  |60.50   |


Scenario: Check for user placing order on Behalf can see only assets from that BU library
!--NGN-16199
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OBA20_1 | DefaultA4User |
| OBA20_2 | DefaultA4User |
And added agency 'OBA20_2' as a partner for agency 'OBA20_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OBU20_1 | agency.admin | OBA20_1      |streamlined_library,ordering|
| OBU20_2 | agency.admin | OBA20_2      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA20_2':
| Advertiser | Brand    | Sub Brand | Product  |
| OBAR20_1   | OBBR20_1 | OBSB20_1  | OBPR20_1 |
And added existing user 'OBU20_2' to agency 'OBA20_1' with role 'agency.admin'
And logged in with details of 'OBU20_1'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And logged in with details of 'OBU20_2'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN20       |
When I open order item with following clock number 'OBCN20'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU |
| OBA20_2         |
Then I 'should' see for order item at Add media to your order form following assets:
| Name         |
| Fish2-Ad.mov |
And I 'should not' see for order item at Add media to your order form following assets:
| Fish1-Ad.mov |


Scenario: Check for user placing order on Behalf can see assets from categories where user has access
!--NGN-16199
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OBA21_1 | DefaultA4User |
| OBA21_2 | DefaultA4User |
And added agency 'OBA21_2' as a partner for agency 'OBA21_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OBU21_1 | agency.admin | OBA21_1      |streamlined_library,ordering|
| OBU21_2 | agency.admin | OBA21_2      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA21_2':
| Advertiser | Brand    | Sub Brand | Product  |
| OBAR21_1   | OBBR21_1 | OBSB21_1  | OBPR21_1 |
And added existing user 'OBU21_2' to agency 'OBA21_1' with role 'agency.admin'
And logged in with details of 'OBU21_1'
And created 'col3' category
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'col3'NEWLIB
And on collection 'col3' on administration area collections page
And added users 'OBU21_2' to category 'col3' with role 'library.user' by users details
And logged in with details of 'OBU21_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN21       |
When I open order item with following clock number 'OBCN21'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA21_1         | OBA21_1                 |
Then I 'should' see for order item at Add media to your order form following assets:
| Name         |
| Fish1-Ad.mov |


Scenario: Check for warning message on behalf pop-up window if user switches BU
!--NGN-16199
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OBA22_1 | DefaultA4User |
| OBA22_2 | DefaultA4User |
And added agency 'OBA22_2' as a partner for agency 'OBA22_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OBU22_1 | agency.admin | OBA22_1      |streamlined_library,ordering|
| OBU22_2 | agency.admin | OBA22_2      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA22_2':
| Advertiser | Brand    | Sub Brand | Product  |
| OBAR22_1   | OBBR22_1 | OBSB22_1  | OBPR22_1 |
And added existing user 'OBU22_2' to agency 'OBA22_1' with role 'agency.admin'
And logged in with details of 'OBU22_1'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And logged in with details of 'OBU22_2'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN22       |
When I open order item with following clock number 'OBCN22'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU |
| OBA22_2         |
And add to order for order item at Add media to your order form following assets 'Fish2-Ad.mov'
And fill in following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA22_1         | OBA22_1                 |
Then I should see following warning message 'Note: Changing client will delete information you've added to the order so far.' on behalf of BU on order item page



Scenario: Check that by switching the BU deletes information added to the order
!--NGN-16199
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OBA23_1 | DefaultA4User |
| OBA23_2 | DefaultA4User |
And added agency 'OBA23_2' as a partner for agency 'OBA23_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OBU23_1 | agency.admin | OBA23_1      |streamlined_library,ordering|
| OBU23_2 | agency.admin | OBA23_2      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA23_2':
| Advertiser | Brand    | Sub Brand | Product  |
| OBAR23_1   | OBBR23_1 | OBSB23_1  | OBPR23_1 |
And added existing user 'OBU23_2' to agency 'OBA23_1' with role 'agency.admin'
And logged in with details of 'OBU23_2'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OBCN23       |
When I open order item with following clock number 'OBCN23'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU |
| OBA23_2         |
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format | Title        | Subtitles Required |
|                        |            |       |           |         |          | OBCN23       | 6s 33ms  |                |        | Fish1-Ad.mov |                    |
When I edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA23_1         | OBA23_1                 |
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format | Title | Subtitles Required |
|                        |            |       |           |         |          |              |          |                |        |       |                    |

