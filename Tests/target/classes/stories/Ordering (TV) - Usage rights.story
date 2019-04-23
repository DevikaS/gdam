!--ORD-256
!--ORD-1599
Feature: Usage rights in delivery
Narrative:
In order to:
As a AgencyAdmin
I want to check usage rights

Scenario: Check that usage rights appears on qc-ed asset
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVURA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OTVURU1 | agency.admin | OTVURA1      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVURA1':
| Advertiser | Brand    | Sub Brand | Product |
| OTVURAR1   | OTVURBR1 | OTVURSB1  | OTVURP1 |
And logged in with details of 'OTVURU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required |
| automated test info    | OTVURAR1   | OTVURBR1 | OTVURSB1  | OTVURP1 | OTVURC1  | OTVURCN1     | 20       | 12/10/2022     | HD 1080i 25fps | OTVURT1 | Already Supplied   |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVURCN1'
When I open order item with following clock number 'OTVURCN1'
And fill following fields for usage right 'General' on order item page:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And save usage information for 'General' usage right on order item page
And completed order contains item with clock number 'OTVURCN1' with following fields:
| Job Number | PO Number |
| OTVURJN1   | OTVURPN1  |
And I go to asset 'OTVURT1' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2022 | 02.02.2024     |


Scenario: Check that usage rights are indentical for all clones
Meta: @qaorderingsmoke
      @uatorderingsmoke
!-- On UAT's scenario would fail if BU created with S3 storage, FAB-767 should fix the issue
Given I created the following agency:
| Name    | A4User        |
| OTVURA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OTVURU1 | agency.admin | OTVURA1      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVURA1':
| Advertiser | Brand    | Sub Brand | Product |
| OTVURAR1   | OTVURBR2 | OTVURSB2  | OTVURP2 |
And logged in with details of 'OTVURU1'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | OTVURAR1   | OTVURBR2 | OTVURSB2  | OTVURP2 | OTVURC2  | OTVURCN2     | 20       | 12/10/2022     | HD 1080i 25fps | OTVURT2 | Already Supplied   | GEO News:Standard |
And add to 'tv' order item with clock number 'OTVURCN2' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And add usage right 'General' for order contains item with clock number 'OTVURCN2' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And complete order contains item with clock number 'OTVURCN2' with following fields:
| Job Number | PO Number |
| OTVURJN2   | OTVURPN2  |
When I go to asset 'Fish1-Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2022 | 02.02.2024     |


Scenario: Check that after editing usage rights it is updated for all clones
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVURA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OTVURU1 | agency.admin | OTVURA1      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVURA1':
| Advertiser | Brand    | Sub Brand | Product |
| OTVURAR1   | OTVURBR3 | OTVURSB3  | OTVURP3 |
And logged in with details of 'OTVURU1'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish2-Ad.mov'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | OTVURAR1   | OTVURBR3 | OTVURSB3  | OTVURP3 | OTVURC3  | OTVURCN3     | 20       | 12/10/2022     | HD 1080i 25fps | OTVURT3 | Already Supplied   | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'OTVURCN3' following asset 'Fish2-Ad.mov' of collection 'My Assets'
And add usage right 'General' for order contains item with clock number 'OTVURCN3' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
When I open order item with following clock number 'OTVURCN3'
And fill following fields for Add information form on order item page:
| Title   |
| OTVURT3 |
And save as draft order
And completed order contains item with clock number 'OTVURCN3' with following fields:
| Job Number | PO Number |
| OTVURJN3   | OTVURPN3  |
And I go to asset 'Fish2-Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
And delete entry of 'General' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2022 | 02.02.2024     |


Scenario: Check that usage rights is retrieved from asset
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVURA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OTVURU1 | agency.admin | OTVURA1      |ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVURA1':
| Advertiser | Brand    | Sub Brand | Product |
| OTVURAR1   | OTVURBR4 | OTVURSB4  | OTVURP4 |
And logged in with details of 'OTVURU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required |
| automated test info    | OTVURAR1   | OTVURBR4 | OTVURSB4  | OTVURP4 | OTVURC4  | OTVURCN4_1   | 20       | 12/10/2022     | HD 1080i 25fps | OTVURT4 | Already Supplied   |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVURCN4_1'
And add usage right 'General' for order contains item with clock number 'OTVURCN4_1' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And complete order contains item with clock number 'OTVURCN4_1' with following fields:
| Job Number | PO Number |
| OTVURJN4   | OTVURPN4  |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OTVURCN4_2   |
And add to 'tv' order item with clock number 'OTVURCN4_2' following qc asset 'OTVURT4' of collection 'My Assets'
When I open order item with clock number 'OTVURCN4_1' for order with market 'Republic of Ireland'
Then I should see following fields for usage right 'General' on order item page:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |

Scenario: Check that usage rights are coppied in case to use Copy current
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVURA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OTVURU1 | agency.admin | OTVURA1      |ordering|
And logged in with details of 'OTVURU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVURCN5     |
And add usage right 'General' for order contains item with clock number 'OTVURCN5' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
When I open order item with following clock number 'OTVURCN5'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following fields for usage right 'General' on order item page:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |

Scenario: Check that usage rights are saved in case to use Save as Draft (music order)
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVURA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OTVURU1 | agency.admin | OTVURA1      |ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVURA1':
| Advertiser | Brand    | Sub Brand | Product |
| OTVURAR1   | OTVURBR6 | OTVURSB6  | OTVURP6 |
And logged in with details of 'OTVURU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code  | Release Date | Format         | Title   |
| automated test info    | OTVURAR1       | OTVURBR6 | OTVURSB6  | OTVURP6 | OTVURC6 | OTVURCN6_1 | 12/10/2022   | HD 1080i 25fps | OTVURT6 |
And enable QC & Ingest Only for 'music' order for item with following isrc code 'OTVURCN6_1'
And add usage right 'General' for order contains item with isrc code 'OTVURCN6_1' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And complete order contains item with isrc code 'OTVURCN6_1' with following fields:
| Job Number | PO Number |
| OTVURJN6   | OTVURPN6  |
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| ISRC Code  |
| OTVURCN6_2 |
And add to 'music' order item with isrc code 'OTVURCN6_2' following qc asset 'OTVURT6' of collection 'My Assets'
When I open order item with isrc code 'OTVURCN6_1' for order with market 'Republic of Ireland'
And fill following fields for usage right 'Countries' on order item page:
| Country        | Start Date | Expire Date |
| United Kingdom | 02/02/2022 | 02/02/2024  |
And save usage information for 'Countries' usage right on order item page
And save as draft order
And open order item with isrc code 'OTVURCN6_1' for order with market 'Republic of Ireland'
Then I should see following fields for usage right 'General' on order item page:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And should see following fields for usage right 'Countries' on order item page:
| Country        | Start Date | Expire Date |
| United Kingdom | 02/02/2022 | 02/02/2024  |