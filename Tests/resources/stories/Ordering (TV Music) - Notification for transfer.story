!--ORD-271
!--ORD-2275
Feature: Notification for Transfer
Narrative:
In order to:
As a AgencyAdmin
I want to check notification for transfer

Scenario: check transfer notifications sending for Adstream agency
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name       | A4User        |
| OTVNFTA1_1 | DefaultA4User |
| OTVNFTA1_2 | DefaultA4User |
And added agency 'OTVNFTA1_2' as a partner to agency 'OTVNFTA1_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVNFTU1_1 | agency.admin | OTVNFTA1_1   |
| OTVNFTU1_2 | agency.admin | OTVNFTA1_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVNFTA1_1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVNFTAR1  | OTVNFTBR1 | OTVNFTSB1 | OTVNFTPR1 |
And logged in with details of 'OTVNFTU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    |
| automated test info    | OTVNFTAR1  | OTVNFTBR1 | OTVNFTSB1 | OTVNFTPR1 | OTVNFTC1 | OTVNFTCN1    | 20       | 10/14/2022     | HD 1080i 25fps | OTVNFTT1 |
And transfered order contains item with clock number 'OTVNFTCN1' to user 'OTVNFTU1_2' with following message 'autotest transfer message'
Then I 'should' see email notification for 'Transfer Order' with field to 'OTVNFTU1_2' and subject 'An order has been transferred to you' contains following attributes:
| Agency     | Account Type | UserEmail  | Clock Number | Message                   |
| OTVNFTA1_1 | adstream     | OTVNFTU1_1 | OTVNFTCN1    | autotest transfer message |

Scenario: check transfer notifications sending for Beam agency
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name       | Labels | A4User        |
| OTVNFTA2_1 | Beam   | DefaultA4User |
| OTVNFTA2_2 | Beam   | DefaultA4User |
And added agency 'OTVNFTA2_2' as a partner to agency 'OTVNFTA2_1'
And created users with following fields:
| Email      | Role         | AgencyUnique | Language |
| OTVNFTU2_1 | agency.admin | OTVNFTA2_1   | en-beam  |
| OTVNFTU2_2 | agency.admin | OTVNFTA2_2   | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVNFTA2_1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVNFTAR2  | OTVNFTBR2 | OTVNFTSB2 | OTVNFTPR2 |
And logged in with details of 'OTVNFTU2_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    |
| automated test info    | OTVNFTAR2  | OTVNFTBR2 | OTVNFTSB2 | OTVNFTPR2 | OTVNFTC2 | OTVNFTCN2    | 20       | 10/14/2022     | HD 1080i 25fps | OTVNFTT2 |
And transfered order contains item with clock number 'OTVNFTCN2' to user 'OTVNFTU2_2' with following message 'autotest transfer message'
Then I 'should' see email notification for 'Transfer Order' with field to 'OTVNFTU2_2' and subject 'OTVNFTAR2-OTVNFTBR2-OTVNFTSB2-OTVNFTPR2' contains following attributes:
| Agency     | Account Type | Market         | UserEmail  | Clock Number | Message                   |
| OTVNFTA2_1 | beam         | United Kingdom | OTVNFTU2_1 | OTVNFTCN2    | autotest transfer message |

Scenario: User could assign order to yourself
!--ORD-2444,ORD-2868
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVNFTA1_1 | DefaultA4User |
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVNFTU3_1_email | agency.admin | OTVNFTA1_1   |
And logged in with details of 'OTVNFTU3_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVNFTCN3    |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVNFTCN3' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to      | Message                   |
| OTVNFTU3_1_email | autotest transfer message |
Then I should see 'disabled' Send button on Transfer Order form

Scenario: check autocomplete lookup for Email LastName FirstName BusinessUnit
!--ORD-2445
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVNFTA1_1 | DefaultA4User |
| OTVNFTA1_2 | DefaultA4User |
And added agency 'OTVNFTA1_2' as a partner to agency 'OTVNFTA1_1'
And created users with following fields:
| Email            | FirstName   | LastName    | Role         | AgencyUnique |
| OTVNFTU4_1       | OTVNFTFN4_1 | OTVNFTLN4_1 | agency.admin | OTVNFTA1_1   |
| OTVNFTU4_2_email | OTVNFTFN4_2 | OTVNFTLN4_2 | agency.admin | OTVNFTA1_2   |
And logged in with details of 'OTVNFTU4_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number '<ClockNumber>' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to | Message                   |
| <Value>     | autotest transfer message |
Then I should see 'enabled' Send button on Transfer Order form

Examples:
| ClockNumber | Value            |
| OTVNFTCN4_1 | OTVNFTU4_2_email |
| OTVNFTCN4_2 | OTVNFTFN4_2      |
| OTVNFTCN4_3 | OTVNFTLN4_2      |
| OTVNFTCN4_4 | OTVNFTA1_2       |

Scenario: check autocomplete lookup for special symbols
!--ORD-2447
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVNFTA1_1 | DefaultA4User |
| OTVNFTA1_2 | DefaultA4User |
And added agency 'OTVNFTA1_2' as a partner to agency 'OTVNFTA1_1'
And created users with following fields:
| Email      | FirstName       | LastName    | Role         | AgencyUnique |
| OTVNFTU5_1 | OTVNFTFN5_1     | OTVNFTLN5_1 | agency.admin | OTVNFTA1_1   |
| OTVNFTU5_2 | !@#$%^.&*()_+;' | OTVNFTLN5_2 | agency.admin | OTVNFTA1_2   |
And logged in with details of 'OTVNFTU5_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVNFTCN5_1  |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVNFTCN5_1' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to     | Message                   |
| !@#$%^.&*()_+; | autotest transfer message |
Then I should see 'enabled' Send button on Transfer Order form

Scenario: check transfer notifications sending for Beam agency in case order has different order items
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name       | Labels | A4User        |
| OTVNFTA2_1 | Beam   | DefaultA4User |
| OTVNFTA2_2 | Beam   | DefaultA4User |
And added agency 'OTVNFTA2_2' as a partner to agency 'OTVNFTA2_1'
And created users with following fields:
| Email      | Role         | AgencyUnique | Language |
| OTVNFTU2_1 | agency.admin | OTVNFTA2_1   | en-beam  |
| OTVNFTU2_2 | agency.admin | OTVNFTA2_2   | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVNFTA2_1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVNFTAR6_1 | OTVNFTBR6_1 | OTVNFTSB6_1 | OTVNFTPR6_1 |
| OTVNFTAR6_2 | OTVNFTBR6_2 | OTVNFTSB6_2 | OTVNFTPR6_2 |
And logged in with details of 'OTVNFTU2_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      |
| automated test info 1  | OTVNFTAR6_1 | OTVNFTBR6_1 | OTVNFTSB6_1 | OTVNFTPR6_1 | OTVNFTC6_1 | OTVNFTCN6_1  | 20       | 10/14/2022     | HD 1080i 25fps | OTVNFTT6_1 |
| automated test info 2  | OTVNFTAR6_2 | OTVNFTBR6_2 | OTVNFTSB6_2 | OTVNFTPR6_2 | OTVNFTC6_2 | OTVNFTCN6_2  | 15       | 10/14/2024     | SD PAL 16x9    | OTVNFTT6_2 |
And transfered order contains item with clock number 'OTVNFTCN6_1' to user 'OTVNFTU2_2' with following message 'autotest transfer message'
Then I 'should' see email notification for 'Transfer Order' with field to 'OTVNFTU2_2' and subject 'Various-Various-Various-Various' contains following attributes:
| Agency     | Account Type | Market         | UserEmail  | Clock Number | Message                   |
| OTVNFTA2_1 | beam         | United Kingdom | OTVNFTU2_1 | OTVNFTCN6_1  | autotest transfer message |

Scenario: check transfer notifications sending for Beam agency in case new advertiser structure
!--ORD-3970
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name       | Labels | A4User        |
| OTVNFTA7_1 | Beam   | DefaultA4User |
| OTVNFTA7_2 | Beam   | DefaultA4User |
And added agency 'OTVNFTA7_2' as a partner to agency 'OTVNFTA7_1'
And created users with following fields:
| Email      | Role         | AgencyUnique | Language |
| OTVNFTU7_1 | agency.admin | OTVNFTA7_1   | en-beam  |
| OTVNFTU7_2 | agency.admin | OTVNFTA7_2   | en-beam  |
And created following 'common' custom metadata fields for agency 'OTVNFTA7_1':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OTVNFTA7_1' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OTVNFTU7_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Title    | Duration | First Air Date | Format         |
| automated test info    | OTVNFTCN7    | OTVNFTT7 | 20       | 10/14/2022     | HD 1080i 25fps |
When I open order item with following clock number 'OTVNFTCN7'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OTVNFTAR7         | OTVNFTBR7    | OTVNFTPR7      | OTVNFTC7        |
And save as draft order
And transfer order contains item with clock number 'OTVNFTCN7' to user 'OTVNFTU7_2' with following message 'autotest transfer message'
Then I 'should' see email notification for 'Transfer Order' with field to 'OTVNFTU7_2' and subject 'OTVNFTAR7-OTVNFTBR7-OTVNFTPR7-OTVNFTC7' contains following attributes:
| Agency     | Account Type | Market         | UserEmail  | Clock Number | Message                   |
| OTVNFTA7_1 | beam         | United Kingdom | OTVNFTU7_1 | OTVNFTCN7    | autotest transfer message |