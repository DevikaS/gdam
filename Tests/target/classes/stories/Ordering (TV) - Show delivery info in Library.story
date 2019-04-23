!--ORD-2723
!--ORD-3183
Feature: Show delivery info in Library
Narrative:
In order to:
As a AgencyAdmin
I want to check show delivery info in Library


Scenario: Format definition in API should return manually entered Format under Add Information section for retrieved from library qc-ed asset
!--NGN-17579: BEAM response changed based on Feature request in 5.5.15
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVBTVSA1 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVBTVSU1 | agency.admin | OTVBTVSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR8 | OTVBTVSBR8 | OTVBTVSSB8 | OTVBTVSP8 |
And logged in with details of 'OTVBTVSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVBTVSAR8 | OTVBTVSBR8 | OTVBTVSSB8 | OTVBTVSP8 | OTVBTVSC8 | OTVBTVSCN8_1N | 20       | 12/14/2022     | HD 1080i 25fps | OTVBTVST8 | Adtext SD          | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number | Destination               |
| OTVBTVSCN8_2 | Universal Ireland:Express |
And complete order contains item with clock number 'OTVBTVSCN8_1N' with following fields:
| Job Number   | PO Number    |
| OTVBTVSJN8_1 | OTVBTVSPN8_1 |
And waited for '10' seconds
And hold for approval 'tv' order items with following clock numbers 'OTVBTVSCN8_2'
And add to 'tv' order item with clock number 'OTVBTVSCN8_2' following qc asset 'OTVBTVST8' of collection 'My Assets'
And complete order with market 'Republic of Ireland' with following fields:
| Job Number   | PO Number    |
| OTVBTVSJN8_2 | OTVBTVSPN8_2 |
And waited for '20' seconds
Then I should see Beam TV clock of market 'Republic of Ireland' for date filter begins from 'Yesterday' with following data:
| ClockNumber  | Order Reference | Country | Advertiser | Brand      | Product    | Master Held At | Service Level | Deadline | Format      | Title     | Duration | Delivery Method | Status       | Subtitling       | Date             | First Air Date | Job Number   | PO Number     |  Ingest Only | On Hold |
| OTVBTVSCN8_1N | Dijit           | IRL     | OTVBTVSAR8 | OTVBTVSBR8 | OTVBTVSSB8 |                | Express       |          | SD PAL 16x9 | OTVBTVST8 | 20       | From Library    | Order Placed | Already Supplied | StatusChangeDate | 12/14/2022     | OTVBTVSJN8_2 | OTVBTVSPN8_2 | should not   | should  |


Scenario: Check that correct data is displayed on Destinations tab
Meta: @ordering
!--QA-927
Given I created the following agency:
| Name    | A4User        | Application Access     |
| SDIILA1 | DefaultA4User | streamlined_library   |
And created users with following fields:
| Email   | Role         | AgencyUnique |  Access      |
| SDIILU1 | agency.admin | SDIILA1      | streamlined_library |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDIILA1':
| Advertiser | Brand    | Sub Brand | Product  |
| SDIILAR1   | SDIILBR1 | SDIILSB1  | SDIILPR1 |
And logged in with details of 'SDIILU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | SDIILAR1   | SDIILBR1 | SDIILSB1  | SDIILPR1 | SDIILC1  | SDIILCN1     | 20       | 10/14/2022     | HD 1080i 25fps | SDIILT1 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'SDIILCN1' with following fields:
| Job Number | PO Number |
| SDIILJN1   | SDIILPN1  |
When I go to asset 'SDIILT1' destinations info page in Library for collection 'My Assets'NEWLIB
And I wait for '5' seconds
Then I should see following data for destination of order with item clock number 'SDIILCN1' on assets destinations info page in LibraryNEWLIB:
| Order # | Destination        | Date Ordered  | Ordered by | Status       |
| Digit   | BSkyB Green Button | DateSubmitted | SDIILU1    | Order Placed |


Scenario: Check that clicking order reference moves user to order summary page
Meta: @ordering
!--QA-927
Given I created the following agency:
| Name    | A4User        | Application Access     |
| SDIILA1 | DefaultA4User | streamlined_library   |
And created users with following fields:
| Email   | Role         | AgencyUnique |  Access              |
| SDIILU1 | agency.admin | SDIILA1      | streamlined_library  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDIILA1':
| Advertiser | Brand    | Sub Brand | Product  |
| SDIILAR1   | SDIILBR1 | SDIILSB1  | SDIILPR1 |
And logged in with details of 'SDIILU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | SDIILAR1   | SDIILBR1 | SDIILSB1  | SDIILPR1 | SDIILC2  | SDIILCN2     | 20       | 10/14/2022     | HD 1080i 25fps | SDIILT2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'SDIILCN2' with following fields:
| Job Number | PO Number |
| SDIILJN2   | SDIILPN2  |
When I go to asset 'SDIILT2' destinations info page in Library for collection 'My Assets'NEWLIB
And I wait for '5' seconds
And open order summary page for order with item destination 'BSkyB Green Button' from assets destinations info page in LibraryNEWLIB
Then I 'should' see Order Summary page

Scenario: Check that no one order is displayed on Destinations tab if order item has been created with QC&Ingest Only
Meta: @ordering
!--QA-927
Given I created the following agency:
| Name    | A4User        | Application Access     |
| SDIILA1 | DefaultA4User | streamlined_library   |
And created users with following fields:
| Email   | Role         | AgencyUnique | Access     |
| SDIILU1 | agency.admin | SDIILA1      | streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDIILA1':
| Advertiser | Brand    | Sub Brand | Product  |
| SDIILAR1   | SDIILBR1 | SDIILSB1  | SDIILPR1 |
And logged in with details of 'SDIILU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required |
| automated test info    | SDIILAR1   | SDIILBR1 | SDIILSB1  | SDIILPR1 | SDIILC3  | SDIILCN3     | 20       | 10/14/2022     | HD 1080i 25fps | SDIILT3 | Already Supplied   |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'SDIILCN3'
And complete order contains item with clock number 'SDIILCN3' with following fields:
| Job Number | PO Number |
| SDIILJN3   | SDIILPN3  |
When I go to asset 'SDIILT3' destinations info page in Library for collection 'My Assets'NEWLIB
And I wait for '5' seconds
Then I 'should not' see assets destinations list on assets destinations info page in LibraryNEWLIB

Scenario: Check that correct data is displayed on Destinations tab for different destinations
Meta: @ordering
@uitobe
Given I created the following agency:
| Name    | A4User        | Application Access     |
| SDIILA1 | DefaultA4User | library,streamlined_library   |
And created users with following fields:
| Email   | Role         | AgencyUnique | Access     |
| SDIILU1 | agency.admin | SDIILA1      | library,streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDIILA1':
| Advertiser | Brand    | Sub Brand | Product  |
| SDIILAR1   | SDIILBR1 | SDIILSB1  | SDIILPR1 |
And logged in with details of 'SDIILU1'
And uploaded following assets:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | SDIILAR1   | SDIILBR1 | SDIILSB1  | SDIILPR1 | SDIILC4  | SDIILCN4_1   | 20       | 10/14/2022     | HD 1080i 25fps | SDIILT4 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number | Destination                |
| SDIILCN4_2   | Universal Ireland:Standard |
And add to 'tv' order item with clock number 'SDIILCN4_1' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And complete order contains item with clock number 'SDIILCN4_1' with following fields:
| Job Number | PO Number  |
| SDIILJN4_1 | SDIILPN4_1 |
And add to 'tv' order item with clock number 'SDIILCN4_2' following qc asset 'Fish1-Ad.mov' of collection 'My Assets'
And complete order with market 'Republic of Ireland' with following fields:
| Job Number | PO Number  |
| SDIILJN4_2 | SDIILPN4_2 |
When I go to asset 'Fish1-Ad.mov' destinations info page in Library for collection 'My Assets'
And I wait for '5' seconds
Then I should see following data for destination 'BSkyB Green Button' of orders with markets 'United Kingdom' on assets destinations info page in Library:
| Order # | Destination        | Date Ordered  | Ordered by | Status         |
| Digit   | BSkyB Green Button   | DateSubmitted | SDIILU1    | Received Media   |
And I should see following data for destination 'Universal Ireland' of orders with markets 'Republic of Ireland' on assets destinations info page in Library:
| Order # | Destination        | Date Ordered  | Ordered by | Status         |
| Digit   | Universal Ireland   | DateSubmitted | SDIILU1    | Order Placed   |


Scenario: Check that order reference isn't clickable on Destinations tab if collection with asset has been shared for user
!-- TODO
Meta: @ordering
@obug
!--FAB-351
Given I created the following agency:
| Name      | A4User        | Application Access     |
| SDIILA5_1 | DefaultA4User |streamlined_library   |
| SDIILA5_2 | DefaultA4User | streamlined_library   |
And added agency 'SDIILA5_2' as a partner to agency 'SDIILA5_1'
And created users with following fields:
| Email     | Role         | AgencyUnique | Access     |
| SDIILU5_1 | agency.admin | SDIILA5_1    | streamlined_library   |
| SDIILU5_2 | agency.admin | SDIILA5_2    | streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDIILA5_1':
| Advertiser | Brand    | Sub Brand | Product  |
| SDIILAR5   | SDIILBR5 | SDIILSB5  | SDIILPR5 |
And logged in with details of 'SDIILU5_1'
And created following categories:
| Name    |
| SDIILC5 |
And added next users for following categories:
| CategoryName | UserName  | RoleName      |
| SDIILC5      | SDIILU5_2 | library.admin |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | SDIILAR5   | SDIILBR5 | SDIILSB5  | SDIILPR5 | SDIILC5  | SDIILCN5     | 20       | 10/14/2022     | HD 1080i 25fps | SDIILT5 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'SDIILCN5' with following fields:
| Job Number | PO Number |
| SDIILJN5   | SDIILPN5  |
And logged in with details of 'SDIILU5_2'
When I go to asset 'SDIILT5' destinations info page in Library for collection 'SDIILC5'
Then I should see following data for destination of order with item clock number 'SDIILCN5' on assets destinations info page in Library:
| Order # | Destination        | Date Ordered  | Ordered by | Status       |
| Digit   | BSkyB Green Button | DateSubmitted | SDIILU5_1  | Order Placed |


Scenario: Check that order reference isn't clickable on Destinations tab if asset has been shared for user
!-- TODO
Meta: @ordering
@uitobe
Given I created the following agency:
| Name      | A4User        | Application Access     |
| SDIILA6_1 | DefaultA4User | streamlined_library   |
| SDIILA6_2 | DefaultA4User | streamlined_library   |
And created users with following fields:
| Email     | Role         | AgencyUnique | Access     |
| SDIILU6_1 | agency.admin | SDIILA6_1    | streamlined_library   |
| SDIILU6_2 | agency.admin | SDIILA6_2    | streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDIILA6_1':
| Advertiser | Brand    | Sub Brand | Product  |
| SDIILAR6   | SDIILBR6 | SDIILSB6  | SDIILPR6 |
And logged in with details of 'SDIILU6_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | SDIILAR6   | SDIILBR6 | SDIILSB6  | SDIILPR6 | SDIILC6  | SDIILCN6     | 20       | 10/14/2022     | HD 1080i 25fps | SDIILT6 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'SDIILCN6' with following fields:
| Job Number | PO Number |
| SDIILJN6   | SDIILPN6  |
And added secure share for asset 'SDIILT6' from collection 'My Assets' to following users:
| ExpireDate | UserEmails | Message                           |
| 12.12.24   | SDIILU6_2  | auto test secure sharing qc asset |
And logged in with details of 'SDIILU6_2'
When I open link from email when user 'SDIILU6_2' received email with next subject 'has been shared'
And open destinations tab on opened asset preview page
Then I should see following data for destination of order with item clock number 'SDIILCN6' on assets destinations page in Library:
| Order # | Destination        | Date Ordered  | Ordered by | Status       |
| Digit   | BSkyB Green Button | DateSubmitted | SDIILU6_1  | Order Placed |
And 'should not' see order reference link for destination 'BSkyB Green Button' on assets destinations page in Library


Scenario: Check that order reference isn't clickable on Destinations tab if collection with asset has been shared for agency
!-- TODO
Meta: @ordering
@obug
!--FAB-351
Given I created the following agency:
| Name      | A4User        |  Application Access     |
| SDIILA7_1 | DefaultA4User | streamlined_library   |
| SDIILA7_2 | DefaultA4User | streamlined_library   |
And added agency 'SDIILA7_2' as a partner to agency 'SDIILA7_1'
And created users with following fields:
| Email     | Role         | AgencyUnique | Access         |
| SDIILU7_1 | agency.admin | SDIILA7_1    | streamlined_library   |
| SDIILU7_2 | agency.admin | SDIILA7_2    | streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDIILA7_1':
| Advertiser | Brand    | Sub Brand | Product  |
| SDIILAR7   | SDIILBR7 | SDIILSB7  | SDIILPR7 |
And logged in with details of 'SDIILU7_1'
And created following categories:
| Name    |
| SDIILC7 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| SDIILC7      | SDIILA7_2  |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | SDIILAR7   | SDIILBR7 | SDIILSB7  | SDIILPR7 | SDIILC7  | SDIILCN7     | 20       | 10/14/2022     | HD 1080i 25fps | SDIILT7 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'SDIILCN7' with following fields:
| Job Number | PO Number |
| SDIILJN7   | SDIILPN7  |
And logged in with details of 'SDIILU7_2'
And accepted all assets on Shared Collection 'SDIILC7' from agency 'SDIILA7_1' pageNEWLIB
When I go to asset 'SDIILT7' destinations info page in Library for collection 'My Assets'NEWLIB
Then I should see following data for destination of order with item clock number 'SDIILCN7' on assets destinations info page in LibraryNEWLIB:
| Order # | Destination        | Date Ordered  | Ordered by | Status       |
| Digit   | BSkyB Green Button | DateSubmitted | SDIILU7_1  | Order Placed |
