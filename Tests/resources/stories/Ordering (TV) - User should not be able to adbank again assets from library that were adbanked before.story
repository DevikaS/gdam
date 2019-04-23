!--ORD-2528
!--ORD-2770
Feature: User should not be able to adbank again assets from library that were adbanked before
Narrative:
In order to:
As a AgencyAdmin
I want to check adbank already adbanked assets

Scenario: Check that Archive isn't locked and is checked in case to create order with clone of archived asset
!--ORD-2737
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |Save In Library |Allow To Save In Library|
| OAATWAA1 | DefaultA4User |should          |should                  |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OAATWAU1 | agency.admin | OAATWAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OAATWAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OAATWAAR1  | OAATWABR1 | OAATWASB1 | OAATWAPR1 |
And logged in with details of 'OAATWAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OAATWAAR1  | OAATWABR1 | OAATWASB1 | OAATWAPR1 | OAATWAC2_1 | OAATWACN2_1  | 20       | 12/10/2022     | HD 1080i 25fps | OAATWAT2_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number | Destination                |
| OAATWACN2_2  | Universal Ireland:Standard |
And complete order contains item with clock number 'OAATWACN2_1' with following fields:
| Job Number | PO Number | Adbank |
| OAATWAJN2  | OAATWAPN2 | should |
And add to 'tv' order item with clock number 'OAATWACN2_2' following qc asset 'OAATWAT2_1' of collection 'My Assets'
When I go to Order Proceed page for order with market 'Republic of Ireland' and item with following clock number 'OAATWACN2_1'
And back to order item page from Order Proceed page
And select following market 'Spain' on order item page
And fill following fields for Add information form on order item page:
| Clave     |
| OAATWACL2 |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard  |
| Gol TV HD |
And click Proceed button on order item page
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive    | Editability Archive |
| OAATWACN2_1  | should     | should              |

Scenario: Check that Archive is locked and checked in case to create order with already archived asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OAATWAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OAATWAU1 | agency.admin | OAATWAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OAATWAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OAATWAAR1  | OAATWABR1 | OAATWASB1 | OAATWAPR1 |
And logged in with details of 'OAATWAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OAATWAAR1  | OAATWABR1 | OAATWASB1 | OAATWAPR1 | OAATWAC1_1 | OAATWACN1_1  | 20       | 12/10/2022     | HD 1080i 25fps | OAATWAT1_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number | Destination                |
| OAATWACN1_2  | Universal Ireland:Standard |
And complete order contains item with clock number 'OAATWACN1_1' with following fields:
| Job Number | PO Number | Adbank |
| OAATWAJN1  | OAATWAPN1 | should |
And add to 'tv' order item with clock number 'OAATWACN1_2' following qc asset 'OAATWAT1_1' of collection 'My Assets'
When I go to Order Proceed page for order with market 'Republic of Ireland' and item with following clock number 'OAATWACN1_1'
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive | Editability Archive |
| OAATWACN1_1  | should  | should not          |

Scenario: Check that Archive isn't removed in case to click Back and return to Order Summary
!--ORD-2808
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OAATWAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OAATWAU1 | agency.admin | OAATWAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OAATWAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OAATWAAR1  | OAATWABR1 | OAATWASB1 | OAATWAPR1 |
And logged in with details of 'OAATWAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OAATWAAR1  | OAATWABR1 | OAATWASB1 | OAATWAPR1 | OAATWAC3_1 | OAATWACN3_1  | 20       | 12/10/2022     | HD 1080i 25fps | OAATWAT3_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number | Subtitles Required | Destination                |
| OAATWACN3_2  | Already Supplied   | Universal Ireland:Standard |
And complete order contains item with clock number 'OAATWACN3_1' with following fields:
| Job Number | PO Number | Adbank |
| OAATWAJN3  | OAATWAPN3 | should |
And add to 'tv' order item with clock number 'OAATWACN3_2' following qc asset 'OAATWAT3_1' of collection 'My Assets'
When I go to Order Proceed page for order with market 'Republic of Ireland' and item with following clock number 'OAATWACN3_1'
And back to order item page from Order Proceed page
And click Proceed button on order item page
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive | Editability Archive |
| OAATWACN3_1  | should  | should not          |

Scenario: Check that Archive checkbox is checked and locked in case to create order with several clones and clicking Manage my format conversion
!--ORD-2772
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OAATWAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OAATWAU1 | agency.admin | OAATWAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OAATWAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OAATWAAR1  | OAATWABR1 | OAATWASB1 | OAATWAPR1 |
And logged in with details of 'OAATWAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OAATWAAR1  | OAATWABR1 | OAATWASB1 | OAATWAPR1 | OAATWAC4_1 | OAATWACN4_1  | 20       | 12/10/2022     | HD 1080i 25fps | OAATWAT4_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave     | Destination                              |
| OAATWACN4_2  | OAATWACL4 | Gol TV HD:Standard;Barcelona TV:Standard |
And complete order contains item with clock number 'OAATWACN4_1' with following fields:
| Job Number | PO Number | Adbank |
| OAATWAJN4  | OAATWAPN4 | should |
And add to 'tv' order item with clock number 'OAATWACN4_2' following qc asset 'OAATWAT4_1' of collection 'My Assets'
When I go to Order Proceed page for order with market 'Spain' and item with following clock number 'OAATWACN4_1'
And fill following fields on Order Proceed page:
| Manage Format Conversions |
| should                    |
And fill following fields on Order Proceed page:
| Manage Format Conversions |
| should not                |
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive | Editability Archive |
| OAATWACN4_1  | should  | should not          |