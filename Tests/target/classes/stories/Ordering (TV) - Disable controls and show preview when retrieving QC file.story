!--ORD-842
!--ORD-1061
Feature: Disable controls and show preview when retrieving QC file
Narrative:
In order to:
As a AgencyAdmin
I want to check of disabling controls and show preview when retrieving QC file


Scenario: Check when QC without media
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVDCSPQCA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVDCSPQCU1 | agency.admin | OTVDCSPQCA1  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVDCSPQCA1':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVDCSPQCAR3 | OTVDCSPQCBR3 | OTVDCSPQCSB3 | OTVDCSPQCP3 |
And logged in with details of 'OTVDCSPQCU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number   |
| OTVDCSPQCCN3_1 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVDCSPQCAR3 | OTVDCSPQCBR3 | OTVDCSPQCSB3 | OTVDCSPQCP3 | OTVDCSPQCC3 | OTVDCSPQCCN3_2 | 20       | 12/14/2022     | HD 1080i 25fps | OTVDCSPQCT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVDCSPQCCN3_2' with following fields:
| Job Number   | PO Number    |
| OTVDCSPQCJN3 | OTVDCSPQCPN3 |
When I added to 'tv' order item with clock number 'OTVDCSPQCCN3_1' following qc asset 'OTVDCSPQCT3' of collection 'My Assets'
And open order item with clock number 'OTVDCSPQCCN3_2' for order with market 'Republic of Ireland'
Then I should see for active order item on cover flow following data:
| Cover Title |
| OTVDCSPQCT3 |
And 'should not' see preview asset 'OTVDCSPQCT3' of collection 'My Assets' for active order item on cover flow


Scenario: User is able to edit only specific fields
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVDCSPQCA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVDCSPQCU1 | agency.admin | OTVDCSPQCA1  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVDCSPQCA1':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVDCSPQCAR3 | OTVDCSPQCBR5 | OTVDCSPQCSB5 | OTVDCSPQCP5 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVDCSPQCA1'
And logged in with details of 'OTVDCSPQCU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number   |
| OTVDCSPQCCN5_1 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVDCSPQCAR3 | OTVDCSPQCBR5 | OTVDCSPQCSB5 | OTVDCSPQCP5 | OTVDCSPQCC5 | OTVDCSPQCCN5_2 | 20       | 12/14/2022     | HD 1080i 25fps | OTVDCSPQCT5 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVDCSPQCCN5_2' with following fields:
| Job Number   | PO Number    |
| OTVDCSPQCJN5 | OTVDCSPQCPN5 |
When I added to 'tv' order item with clock number 'OTVDCSPQCCN5_1' following qc asset 'OTVDCSPQCT5' of collection 'My Assets'
And open order item with clock number 'OTVDCSPQCCN5_2' for order with market 'Republic of Ireland'
And fill following fields for Add information form on order item page:
| Additional Information | First Air Date |
| automated test info    | 12/14/2022     |
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | First Air Date | Format      | Product     | Title       | Subtitles Required |
| automated test info    | OTVDCSPQCAR3 | OTVDCSPQCBR5 | OTVDCSPQCSB5 | OTVDCSPQCP5 | OTVDCSPQCC5 | OTVDCSPQCCN5_2 | 20       | 12/14/2022     | SD PAL 16x9 | OTVDCSPQCP5 | OTVDCSPQCT5 | Already Supplied   |


Scenario: Check data in QC asset after save as draft
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVDCSPQCA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVDCSPQCU1 | agency.admin | OTVDCSPQCA1  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVDCSPQCA1':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVDCSPQCAR3 | OTVDCSPQCBR8 | OTVDCSPQCSB8 | OTVDCSPQCP8 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVDCSPQCA1'
And logged in with details of 'OTVDCSPQCU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number   |
| OTVDCSPQCCN8_1 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVDCSPQCAR3 | OTVDCSPQCBR8 | OTVDCSPQCSB8 | OTVDCSPQCP8 | OTVDCSPQCC8 | OTVDCSPQCCN8_2 | 20       | 12/14/2022     | HD 1080i 25fps | OTVDCSPQCT8 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVDCSPQCCN8_2' with following fields:
| Job Number   | PO Number    |
| OTVDCSPQCJN8 | OTVDCSPQCPN8 |
When I added to 'tv' order item with clock number 'OTVDCSPQCCN8_1' following qc asset 'OTVDCSPQCT8' of collection 'My Assets'
And open order item with clock number 'OTVDCSPQCCN8_2' for order with market 'Republic of Ireland'
And fill following fields for Add information form on order item page:
| Additional Information | First Air Date |
| automated test info    | 10/14/2022     |
And save as draft order
And open order item with clock number 'OTVDCSPQCCN8_2' for order with market 'Republic of Ireland'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | First Air Date | Format      | Product     | Title       | Subtitles Required |
| automated test info    | OTVDCSPQCAR3 | OTVDCSPQCBR8 | OTVDCSPQCSB8 | OTVDCSPQCP8 | OTVDCSPQCC8 | OTVDCSPQCCN8_2 | 20       | 10/14/2022     | SD PAL 16x9 | OTVDCSPQCP8 | OTVDCSPQCT8 | Already Supplied   |



Scenario: Check that preview is visible according to QC
Meta:@ordering
Given I created the following agency:
| Name        | A4User        |
| OTVDCSPQCA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| OTVDCSPQCU1 | agency.admin | OTVDCSPQCA1  |streamlined_library,library,ordering|
And logged in with details of 'OTVDCSPQCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVDCSPQCCN1 |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
When I set following file info for next assets from collection 'My Assets':
| Name         | ClockNumber | SubType      |
| Fish1-Ad.mov | QCCN1       | QC-ed master |
And open order item with following clock number 'OTVDCSPQCCN1'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
Then I 'should' see preview asset 'Fish1-Ad.mov' of collection 'My Assets' for active order item on cover flow

Scenario: Check that preview isn't visible according to not QC assets
Meta:@ordering
Given I created the following agency:
| Name        | A4User        |
| OTVDCSPQCA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| OTVDCSPQCU1 | agency.admin | OTVDCSPQCA1  |streamlined_library,library,ordering|
And logged in with details of 'OTVDCSPQCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVDCSPQCCN4 |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish3-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for asset 'Fish3-Ad.mov'NEWLIB
When I added to 'tv' order item with clock number 'OTVDCSPQCCN4' following asset 'Fish3-Ad.mov' of collection 'My Assets'
And open order item with following clock number 'OTVDCSPQCCN4'
Then I should see for active order item on cover flow following data:
| Title        |
| Fish3-Ad.mov |
Then I 'should not' see preview asset 'Fish3-Ad.mov' of collection 'My Assets' for active order item on cover flow

Scenario: Add several QC asset separate
Meta:@ordering
Given I created the following agency:
| Name        | A4User        |
| OTVDCSPQCA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| OTVDCSPQCU1 | agency.admin | OTVDCSPQCA1  |streamlined_library,library,ordering|
And logged in with details of 'OTVDCSPQCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVDCSPQCCN6 |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
|Name|
|Fish1-Ad.mov|
|Fish2-Ad.mov|
When I set following file info for next assets from collection 'My Assets':
| Name         | ClockNumber | SubType      |
| Fish1-Ad.mov | QCCN6_1     | QC-ed master |
| Fish2-Ad.mov | QCCN6_2     | QC-ed master |
And open order item with following clock number 'OTVDCSPQCCN6'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
Then I 'should' see preview asset 'Fish1-Ad.mov' of collection 'My Assets' for active order item on cover flow
When I 'create new' order item by Add Commercial button on order item page
And add to order for order item at Add media to your order form following assets 'Fish2-Ad.mov'
Then I 'should' see preview asset 'Fish2-Ad.mov' of collection 'My Assets' for active order item on cover flow


Scenario: Add several QC asset at the same time
Meta:@ordering
Given I created the following agency:
| Name        | A4User        |
| OTVDCSPQCA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| OTVDCSPQCU1 | agency.admin | OTVDCSPQCA1  |streamlined_library,library,ordering|
And logged in with details of 'OTVDCSPQCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVDCSPQCCN7 |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
|Name|
|Fish1-Ad.mov|
|Fish2-Ad.mov|
When I set following file info for next assets from collection 'My Assets':
| Name         | ClockNumber | SubType      |
| Fish1-Ad.mov | QCCN7_1     | QC-ed master |
| Fish2-Ad.mov | QCCN7_2     | QC-ed master |
And open order item with following clock number 'OTVDCSPQCCN7'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov,Fish2-Ad.mov'
Then I should see for active order item on cover flow following data:
| Title        | Duration | Clock Number | Cover Title  |
| Fish1-Ad.mov | 6s 33ms  | QCCN7_1      | Fish1-Ad.mov |
And 'should' see preview asset 'Fish1-Ad.mov' of collection 'My Assets' for active order item on cover flow
When I select order item with following clock number 'QCCN7_2' on cover flow
Then I should see for active order item on cover flow following data:
| Title        | Duration | Clock Number | Cover Title  |
| Fish2-Ad.mov | 6s 33ms  | QCCN7_2      | Fish2-Ad.mov |
And 'should' see preview asset 'Fish2-Ad.mov' of collection 'My Assets' for active order item on cover flow


