!--ORD-365
!--ORD-450
Feature: Market for distribution control
Narrative:
In order to:
As a AgencyAdmin
I want to check a correct selection market for distribution control

Scenario: Check that correct market is displayed in case to create a order
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Country   |
| <Name> | DefaultA4User | <Country> |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| <Email> | agency.admin | <Name>       |
And logged in with details of '<Email>'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
Then I should see selected following market '<Market>' on order item page

Examples:
| Name        | Email       | Country        | Market              |
| OTVMFDCA1_1 | OTVMFDCU1_1 | United Kingdom | United Kingdom      |
| OTVMFDCA1_2 | OTVMFDCU1_2 | Ireland        | Republic of Ireland |
| OTVMFDCA1_3 | OTVMFDCU1_3 | Ukraine        | Ukraine             |
| OTVMFDCA1_4 | OTVMFDCU1_5 | Italy          | Italy Pubblicita'   |

Scenario: Check that controls in Add information block are displayed according to the market selected
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMFDCA2 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMFDCU2 | agency.admin | OTVMFDCA2    |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVMFDCA2'
And logged in with details of 'OTVMFDCU2'
And create 'tv' order with market '<Market>' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I 'should' see following fields '<Fields>' for order item on Add information form

Examples:
| Market            | ClockNumber | Fields                                                                                                                                                                                           |
| United Kingdom    | OTVMDCCN2_2 | Additional Information,Advertiser,Campaign,Clock Number,Duration,First Air Date,Format,Product,Title,Subtitles Required                                                                          |
| Spain             | OTVMDCCN2_3 | Additional Information,Advertiser,Campaign,Clock Number,Duration,First Air Date,Format,Product,Title,Subtitles Required,Clave,Creative Agency Contact,Language,Media Agency,Media Agency Contact |
| Belgium           | OTVMDCCN2_4 | Additional Information,Advertiser,Campaign,Clock Number,Duration,First Air Date,Format,Product,Title,Language,MBCID Code                                                                         |
| Italy Pubblicita' | OTVMDCCN2_5 | Additional Information,Advertiser,Campaign,Clock Number,Duration,First Air Date,Format,Product,Title,Categoria Merceologica Settore,Match,Media Subtype                                          |

Scenario: Check that correct flags are displayed for specific markets
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMFDCA2 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMFDCU2 | agency.admin | OTVMFDCA2    |
And logged in with details of 'OTVMFDCU2'
And create 'tv' order with market '<Market>' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I should see selected following flag '<Market>' on order item page

Examples:
| Market              | ClockNumber |
| Italy Pubblicita'   | OTVMDCCN3_1 |
| Italy Sky Backhaul  | OTVMDCCN3_2 |
| France              | OTVMDCCN3_3 |
| Republic of Ireland | OTVMDCCN3_4 |
| Bulgaria            | OTVMDCCN3_5 |

Scenario: Check that destinations from different markets cannot be specified for one order
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMFDCA2 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMFDCU2 | agency.admin | OTVMFDCA2    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMFDCA2':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVMFDCAR4 | OTVMDCBR4 | OTVMDCSB4 | OTVMDCP4 |
And logged in with details of 'OTVMFDCU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title    | Destination        |
| automated test info    | OTVMFDCAR4 | OTVMDCBR4 | OTVMDCSB4 | OTVMDCP4 | OTVMFDCC4 | OTVMDCCN4    | 20       | 08/14/2022     | HD 1080i 25fps | OTVMDCT4 | PTV Prime:Standard |
When I open order item with following clock number 'OTVMDCCN4'
And select following market 'Spain' on order item page
And fill following fields for Add information form on order item page:
| Clave    |
| OTVMDCC4 |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard   |
| Giralda TV |
And save as draft order
And completed just created 'draft' order with following fields:
| Job Number | PO Number  |
| OTVMFDCJN4 | OTVMFDCPN4 |
And go to Order Summary page for order contains item with following clock number 'OTVMDCCN4'
Then I 'should' see following destinations 'Giralda TV' for clock delivery 'OTVMDCCN4' on 'tv' order summary page