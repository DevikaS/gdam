!--ORD-2969
!--ORD-3443
Feature: System should not allow to create order with metadata field exceeding its max value of 50
Narrative:
In order to:
As a AgencyAdmin
I want to check that system should not allow to create order with metadata field exceeding its max value of 50

Scenario: Check that user can confirm order with value exceeded 50 symbols for default advertiser structure if it doesn't replicated into A4
!--ORD-3226
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| MFEA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| MFEU1 | agency.admin | MFEA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MFEA1':
| Advertiser | Brand                                                          | Sub Brand                                                      | Product |
| MFEAR1     | Phantasy Sound Under Exclusive License to Because Music MFEBR1 | Phantasy Sound Under Exclusive License to Because Music MFESB1 | MFEPR1  |
And logged in with details of 'MFEU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand                                                          | Sub Brand                                                      | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title                                                         | Subtitles Required | Destination                 |
| automated test info    | MFEAR1     | Phantasy Sound Under Exclusive License to Because Music MFEBR1 | Phantasy Sound Under Exclusive License to Because Music MFESB1 | MFEPR1  | MFEC1    | MFECN1       | 20       | 12/14/2022     | HD 1080i 25fps | Phantasy Sound Under Exclusive License to Because Music MFET1 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MFECN1'
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MFEJN1     | MFEPN1    |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'MFECN1' and following fields:
| Order# | DateTime    | Advertiser | Brand                                                          | Sub Brand                                                      | Product | Market         | PO Number | Job #  | NoClocks | Status        |
| Digit  | CurrentTime | MFEAR1     | Phantasy Sound Under Exclusive License to Because Music MFEBR1 | Phantasy Sound Under Exclusive License to Because Music MFESB1 | MFEPR1  | United Kingdom | MFEPN1    | MFEJN1 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'MFECN1' and items with following fields:
| Clock Number | Advertiser | Product | Title                                                         | First Air Date | Format         | Duration | Status        |
| MFECN1       | MFEAR1     | MFEPR1  | Phantasy Sound Under Exclusive License to Because Music MFET1 | 12/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: Check that user can confirm order with value exceeded 50 symbols for custom advertiser structure if it doesn't replicated into A4
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| MFEA2 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| MFEU2 | agency.admin | MFEA2        |
And created following 'common' custom metadata fields for agency 'MFEA2':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'MFEA2' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'MFEU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Duration | First Air Date | Format         | Title                                                         | Subtitles Required | Destination                 |
| automated test info    | MFECN2       | 20       | 12/14/2022     | HD 1080i 25fps | Phantasy Sound Under Exclusive License to Because Music MFET2 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MFECN2'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom                                                   | Product Custom | Campaign Custom |
| MFEAR2            | Phantasy Sound Under Exclusive License to Because Music MFEBR2 | MFEPR2         | MFEC2           |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MFEJN2     | MFEPN2    |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'MFECN2' and following fields:
| Order# | DateTime    | Advertiser | Brand                                                          | Product | Campaign | Market         | PO Number | Job #  | NoClocks | Status        |
| Digit  | CurrentTime | MFEAR2     | Phantasy Sound Under Exclusive License to Because Music MFEBR2 | MFEPR2  | MFEC2    | United Kingdom | MFEPN2    | MFEJN2 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'MFECN2' and items with following fields:
| Clock Number | Advertiser | Product | Title                                                         | First Air Date | Format         | Duration | Status        |
| MFECN2       | MFEAR2     | MFEPR2  | Phantasy Sound Under Exclusive License to Because Music MFET2 | 12/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: Check that user cannot confirm order with value exceeded 50 symbols for default advertiser structure if it is replicated into A4
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Advertiser | Mark as Product | Mark as Campaign |
| <Agency> | DefaultA4User | <MarkAsAdvertiser> | <MarkAsProduct> | <MarkAsCampaign> |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser   | Brand   | Sub Brand  | Product   |
| <advertiser> | <brand> | <SubBrand> | <product> |
And logged in with details of '<User>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand   | Sub Brand  | Product   | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title                                                         | Subtitles Required | Destination                 |
| automated test info    | <advertiser> | <brand> | <SubBrand> | <product> | <campaign> | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | Phantasy Sound Under Exclusive License to Because Music MFET3 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number '<ClockNumber>'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field '<Field>' for order item on Add information form
And 'should not' see validation error next to following field 'Title' for order item on Add information form

Examples:
| Agency  | User    | MarkAsAdvertiser | MarkAsProduct | MarkAsCampaign | advertiser                                                       | brand                                                            | SubBrand                                                         | product                                                          | campaign                                                        | ClockNumber                                                      | Field                                    |
| MFEA3_1 | MFEU3_1 | Advertiser       | Product       | Campaign       | Phantasy Sound Under Exclusive License to Because Music MFEAR3_1 | MFEBR3_1                                                         | MFESB3_1                                                         | MFEPR3_1                                                         | MFEC3_1                                                         | MFECN3_1                                                         | Advertiser                               |
| MFEA3_2 | MFEU3_2 | Advertiser       | Product       | Campaign       | MFEAR3_2                                                         | MFEBR3_2                                                         | MFESB3_2                                                         | Phantasy Sound Under Exclusive License to Because Music MFEPR3_2 | MFEC3_2                                                         | MFECN3_2                                                         | Product                                  |
| MFEA3_3 | MFEU3_3 | Advertiser       | Product       | Campaign       | MFEAR3_3                                                         | MFEBR3_3                                                         | MFESB3_3                                                         | MFEPR3_3                                                         | Phantasy Sound Under Exclusive License to Because Music MFEC3_3 | MFECN3_3                                                         | Campaign                                 |
| MFEA3_4 | MFEU3_4 | Brand            | Advertiser    | Product        | MFEAR3_4                                                         | Phantasy Sound Under Exclusive License to Because Music MFEBR3_4 | MFESB3_4                                                         | MFEPR3_4                                                         | MFEC3_4                                                         | MFECN3_4                                                         | Brand                                    |
| MFEA3_5 | MFEU3_5 | Sub Brand        | Brand         | Advertiser     | Phantasy Sound Under Exclusive License to Because Music MFEAR3_5 | MFEBR3_5                                                         | MFESB3_5                                                         | MFEPR3_5                                                         | MFEC3_5                                                         | MFECN3_5                                                         | Advertiser                               |
| MFEA3_6 | MFEU3_6 | Product          | Sub Brand     | Brand          | MFEAR3_6                                                         | MFEBR3_6                                                         | Phantasy Sound Under Exclusive License to Because Music MFESB3_6 | MFEPR3_6                                                         | MFEC3_6                                                         | MFECN3_6                                                         | Sub Brand                                |
| MFEA3_7 | MFEU3_7 | Advertiser       | Product       | Sub Brand      | MFEAR3_7                                                         | MFEBR3_7                                                         | MFESB3_7                                                         | MFEPR3_7                                                         | MFEC3_7                                                         | Phantasy Sound Under Exclusive License to Because Music MFECN3_7 | Clock Number                             |
| MFEA3_8 | MFEU3_8 | Advertiser       | Product       | Campaign       | Phantasy Sound Under Exclusive License to Because Music MFEAR3_8 | MFEBR3_8                                                         | MFESB3_8                                                         | Phantasy Sound Under Exclusive License to Because Music MFEPR3_8 | Phantasy Sound Under Exclusive License to Because Music MFEC3_8 | Phantasy Sound Under Exclusive License to Because Music MFECN3_8 | Clock Number,Advertiser,Product,Campaign |

Scenario: Check that user cannot confirm order with value exceeded 50 symbols for custom advertiser structure if it is replicated into A4
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>     |
And created following 'common' custom metadata fields for agency '<Agency>':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency '<Agency>' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of '<User>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number  | Duration | First Air Date | Format         | Subtitles Required | Destination                 |
| automated test info    | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number '<ClockNumber>'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| <Advertiser>      | <Brand>      | <Product>      | <Campaign>      |
And fill following fields for Add information form on order item page:
| Title                                                         |
| Phantasy Sound Under Exclusive License to Because Music MFET4 |
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should not' see validation error next to following field 'Title' for order item on Add information form

Examples:
| Agency  | User    | Advertiser                                                       | Brand    | Product                                                          | Campaign                                                        | ClockNumber                                                      |
| MFEA4_1 | MFEU4_1 | Phantasy Sound Under Exclusive License to Because Music MFEAR4_1 | MFEBR4_1 | MFEPR4_1                                                         | MFEC4_1                                                         | MFECN4_1                                                         |
| MFEA4_2 | MFEU4_2 | MFEAR4_2                                                         | MFEBR4_2 | Phantasy Sound Under Exclusive License to Because Music MFEPR4_2 | MFEC4_2                                                         | MFECN4_2                                                         |
| MFEA4_3 | MFEU4_3 | MFEAR4_3                                                         | MFEBR4_3 | MFEPR4_3                                                         | Phantasy Sound Under Exclusive License to Because Music MFEC4_3 | MFECN4_3                                                         |
| MFEA4_4 | MFEU4_4 | Phantasy Sound Under Exclusive License to Because Music MFEAR4_4 | MFEBR4_4 | Phantasy Sound Under Exclusive License to Because Music MFEPR4_4 | Phantasy Sound Under Exclusive License to Because Music MFEC4_4 | Phantasy Sound Under Exclusive License to Because Music MFECN4_4 |

Scenario: Check that user cannot confirm order with Motivnummer value exceeded 50 symbols
!--ORD-3226
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| MFEA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| MFEU1 | agency.admin | MFEA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MFEA1':
| Advertiser | Brand  | Sub Brand | Product |
| MFEAR5     | MFEBR5 | MFESB5    | MFEPR5  |
And logged in with details of 'MFEU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Motivnummer                                                    | Destination            |
| automated test info    | MFEAR5     | MFEBR5 | MFESB5    | MFEPR5  | MFEC5    | MFECN5       | 20       | 12/14/2022     | HD 1080i 25fps | MFET5 | Phantasy Sound Under Exclusive License to Because Music MFEMN5 | Romance TV HD:Standard |
When I open order item with following clock number 'MFECN5'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'Motivnummer' for order item on Add information form

Scenario: check validation of clock number if it is autogenerated and then deleted or changed to existing value
!--ORD-3638
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| MFEA6 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| MFEU6 | agency.admin | MFEA6        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MFEA6':
| Advertiser | Brand  | Sub Brand | Product |
| MFEAR6     | MFEBR6 | MFESB6    | MFEPR6  |
And update custom code 'Clock number' of schema 'video' agency 'MFEA6' by following fields:
| Name   | Date Format | Sequential Number | Free Text | Metadata Elements    | Enabled |
| MFECC6 | DDMMYYYY    | 9                 | /         | Advertiser:3,Brand:3 | should  |
And logged in with details of 'MFEU6'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | MFEAR6     | MFEBR6 | MFESB6    | MFEPR6  | MFEC6_1  | MFECN6_1     | 20       | 10/14/2022     | HD 1080i 25fps | MFET6_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | MFEAR6     | MFEBR6 | MFESB6    | MFEPR6  | MFEC6_2  | 20       | 10/14/2022     | HD 1080i 25fps | MFET6_2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'MFECN6_1' with following fields:
| Job Number | PO Number |
| MFEJN6     | MFEPN6    |
When I open order item with next title 'MFET6_2'
And generate 'auto code' value for Add information form on order item page
And fill following fields for Add information form on order item page:
| Clock Number |
| MFECN6_1     |
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page