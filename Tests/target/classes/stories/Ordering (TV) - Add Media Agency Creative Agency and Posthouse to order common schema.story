!--ORD-4660
!--ORD-4350
Feature: Add Media Agency Creative Agency and Posthouse to order common schema
Narrative:
In order to:
As a AgencyAdmin
I want to check Media Agency Creative Agency and Posthouse fields in order common schema

Scenario: Check that Media Agency and Creative Agency and Posthouse are located in Common Ordering scheme and available for all markets
Meta: @ordering
Given I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'United Kingdom' for agency ''
Then I 'should' see button 'Creative Agency,Media Agency,Posthouse' in 'editable metadata' section on opened metadata page

Scenario: Check that Media Agency and Creative Agency and Posthouse are shown on QC assets details page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| ACFTSA2 | DefaultA4User |
And created 'ACFTSR2' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'ACFTSA2'
And created users with following fields:
| Email   | Role    | AgencyUnique |Access|
| ACFTSU2 | ACFTSR2 | ACFTSA2      |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACFTSA2':
| Advertiser | Brand    | Sub Brand | Product  |
| ACFTSAR2   | ACFTSBR2 | ACFTSSB2  | ACFTSPR2 |
And logged in with details of 'ACFTSU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Media Agency | Creative Agency | Post House | Destination                 |
| automated test info    | ACFTSAR2   | ACFTSBR2 | ACFTSSB2  | ACFTSPR2 | ACFTSC2  | ACFTSCN2     | 20       | 10/14/2022     | HD 1080i 25fps | ACFTST2 | Already Supplied   | ACFTSMA2     | ACFTSCA2        | ACFTSPH2   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ACFTSCN2' with following fields:
| Job Number | PO Number |
| ACFTSJN2   | ACFTSPN2  |
And I am on asset 'ACFTST2' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName          | FieldValue |
| Media Agency       | ACFTSMA2   |
| Advertising agency | ACFTSCA2   |
| Post-production    | ACFTSPH2   |


Scenario: Check that Media Agency and Creative Agency and Posthouse are correcty pulled after retriving QC asset from library
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| ACFTSA2 | DefaultA4User |
And created 'ACFTSR2' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'ACFTSA2'
And created users with following fields:
| Email   | Role    | AgencyUnique |
| ACFTSU2 | ACFTSR2 | ACFTSA2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACFTSA2':
| Advertiser | Brand    | Sub Brand | Product  |
| ACFTSAR2   | ACFTSBR2 | ACFTSSB2  | ACFTSPR2 |
And logged in with details of 'ACFTSU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Media Agency | Creative Agency | Post House | Destination                 |
| automated test info    | ACFTSAR2   | ACFTSBR2 | ACFTSSB2  | ACFTSPR2 | ACFTSC3  | ACFTSCN3_1   | 20       | 10/14/2022     | HD 1080i 25fps | ACFTST3 | Already Supplied   | ACFTSMA3     | ACFTSCA3        | ACFTSPH3   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| ACFTSCN3_2   |
And complete order contains item with clock number 'ACFTSCN3_1' with following fields:
| Job Number | PO Number |
| ACFTSJN3   | ACFTSPN3  |
And add to 'tv' order item with clock number 'ACFTSCN3_2' following qc asset 'ACFTST3' of collection 'My Assets'
When I open order item with clock number 'ACFTSCN3_1' for order with market 'Republic of Ireland'
Then I should see following data for order item on Add information form:
| Media Agency | Creative Agency | Post House |
| ACFTSMA3     | ACFTSCA3        | ACFTSPH3   |