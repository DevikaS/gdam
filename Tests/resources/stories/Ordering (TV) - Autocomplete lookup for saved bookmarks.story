!--ORD-2575
!--ORD-3037
Feature: Autocomplete lookup for saved bookmarks
Narrative:
In order to:
As a AgencyAdmin
I want to check autocomplete lookup for saved bookmarks

Scenario: Check autocomplete for bookmarks
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ALFBA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ALFBU1 | agency.admin | ALFBA1       |
And logged in with details of 'ALFBU1'
And create bookmark for order with market 'United Kingdom' with following fields:
| Name    | Destination                 |
| ALFBBN1 | BSkyB Green Button:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ALFBCN1      |
When I open order item with following clock number 'ALFBCN1'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Express   |
| PTV Prime |
And fill following fields for Bookmark stations form of Select Broadcast Destinations section on order item page:
| Name    |
| ALFBBN1 |
Then I should see auto complete bookmarks count '1' under Name on Bookmark stations form of Select Broadcast Destinations section

Scenario: Check that autocomplete for bookmars is individual per market
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ALFBA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ALFBU1 | agency.admin | ALFBA1       |
And logged in with details of 'ALFBU1'
And create bookmark for order with market 'United Kingdom' with following fields:
| Name    | Destination                 |
| ALFBBN2 | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| ALFBCN2      |
When I open order item with following clock number 'ALFBCN2'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard          |
| Universal Ireland |
And fill following fields for Bookmark stations form of Select Broadcast Destinations section on order item page:
| Name    |
| ALFBBN2 |
Then I should see auto complete bookmarks count '0' under Name on Bookmark stations form of Select Broadcast Destinations section

Scenario: Check that autocomplete for bookmars is individual per user
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ALFBA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ALFBU1 | agency.admin | ALFBA1       |
| ALFBU3 | agency.admin | ALFBA1       |
And logged in with details of 'ALFBU1'
And create bookmark for order with market 'United Kingdom' with following fields:
| Name    | Destination                 |
| ALFBBN3 | BSkyB Green Button:Standard |
And logged in with details of 'ALFBU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ALFBCN3      |
When I open order item with following clock number 'ALFBCN3'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Express   |
| PTV Prime |
And fill following fields for Bookmark stations form of Select Broadcast Destinations section on order item page:
| Name    |
| ALFBBN3 |
Then I should see auto complete bookmarks count '0' under Name on Bookmark stations form of Select Broadcast Destinations section