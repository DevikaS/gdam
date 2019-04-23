!--ORD-2234
!--ORD-2424
Feature: Advanced search filtering for American station
Narrative:
In order to:
As a AgencyAdmin
I want to check advanced search filtering for american station

Scenario: Search by Market SysCode Destination Type Delivery Tape
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Market   | Destination Type  | Syscode   | Delivery Type  |
| <Market> | <DestinationType> | <Syscode> | <DeliveryType> |
And do searching for current filter options on Advanced Search form of Select Broadcast Destination section
Then I 'should' see following destinations '<Destinations>' in destination table on Select Broadcast Destinations form

Examples:
| ClockNumber | Market      | DestinationType      | Syscode | DeliveryType  | Destinations                  |
| OTVASFCN1_1 | cincinnati  |                      |         |               | Comcast/Brookville, IN        |
| OTVASFCN1_2 |             | advanced advertising | 8602    |               | Time Warner/AA-Cincinnati, OH |
| OTVASFCN1_3 |             |                      | 9039    |               | CSI/Pahrump, NV               |
| OTVASFCN1_4 |             |                      | 1309    | electronic    | Adlink Interconnect, CA       |
| OTVASFCN1_5 | los angeles | advanced advertising | 0195    | electronic    | Time Warner/AA-SA Zone, CA    |

Scenario: Search by wrong syscode value
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OTVASFCN2    |
When I open order item with following clock number 'OTVASFCN2'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Syscode |
| 378821  |
And do searching for current filter options on Advanced Search form of Select Broadcast Destination section
Then I 'should not' see destination table with destinations for order item on Select Broadcast Destinations form

Scenario: Multiple search by syscodes
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OTVASFCN3    |
When I open order item with following clock number 'OTVASFCN3'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Syscodes  |
| KSFV 8775 |
And do searching by multiple syscodes on Advanced Search form of Select Broadcast Destination section
Then I 'should' see following destinations 'CHARTER/AA-LOS ANGELES, CA;KSFV' in destination table on Select Broadcast Destinations form

Scenario: Multiple search by syscodes with non-exist value
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OTVASFCN4    |
When I open order item with following clock number 'OTVASFCN4'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Syscodes         |
| KSFV 8775 371211 |
And do searching by multiple syscodes on Advanced Search form of Select Broadcast Destination section
Then I 'should' see following destinations 'CHARTER/AA-LOS ANGELES, CA;KSFV' in destination table on Select Broadcast Destinations form
And 'should not' see following destinations 'USA Comcast HD 371211' in destination table on Select Broadcast Destinations form

Scenario: Copy current the search result from first order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number | Destination                      |
| OTVASFCN5    | Synacor/ISP Online:Standard (US) |
When I open order item with following clock number 'OTVASFCN5'
And 'copy current' order item by Add Commercial button on order item page
And view destinations by following filter 'View selected only' at Select Broadcast Destinations form on order item page
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard (US)      |
| Synacor/ISP Online |

Scenario: Search with reset property
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OTVASFCN6    |
When I open order item with following clock number 'OTVASFCN6'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Syscode |
| 0300    |
And do searching for current filter options on Advanced Search form of Select Broadcast Destination section
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)      |
| Synacor/ISP Online |
And reset search result on Advanced Search form of Select Broadcast Destination section
And view destinations by following filter 'View selected only' at Select Broadcast Destinations form on order item page
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard (US)      |
| Synacor/ISP Online |

Scenario: Search with reset property after Saving as Draft
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OTVASFCN7    |
When I open order item with following clock number 'OTVASFCN7'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Syscode |
| 0300    |
And do searching for current filter options on Advanced Search form of Select Broadcast Destination section
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)      |
| Synacor/ISP Online |
And save as draft order
And open order item with following clock number 'OTVASFCN7'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Syscode |
| 0303    |
And do searching for current filter options on Advanced Search form of Select Broadcast Destination section
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)          |
| Synacor/Verizon Online |
And reset search result on Advanced Search form of Select Broadcast Destination section
And view destinations by following filter 'View selected only' at Select Broadcast Destinations form on order item page
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard (US)                             |
| Synacor/ISP Online;Synacor/Verizon Online |

Scenario: Clear section after selected Comcast destinations
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number | Destination                      |
| OTVASFCN8    | Synacor/ISP Online:Standard (US) |
When I open order item with following clock number 'OTVASFCN8'
And clear 'Select Broadcast Destinations' section on order item page
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Syscode |
| 0300    |
And do searching for current filter options on Advanced Search form of Select Broadcast Destination section
Then I 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard (US)      |
| Synacor/ISP Online |

Scenario: Locked fields while typing search filter
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Market   | Destination Type  | Syscode   | Delivery Type  | Syscodes   |
| <Market> | <DestinationType> | <Syscode> | <DeliveryType> | <syscodes> |
Then I should see 'disabled' following fields '<Fields>' for order item on Advanced search form of Select Broadcast Destinations section

Examples:
| ClockNumber | Market      | DestinationType      | Syscode | DeliveryType | syscodes | Fields                                             |
| OTVASFCN9_1 | los angeles | advanced advertising | 0195    | electronic   |          | Syscodes,File                                      |
| OTVASFCN9_2 |             |                      |         |              | 8602     | Market,Destination Type,Syscode,Delivery Type,File |

Scenario: Copy to all selected destinations from first order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number | Destination                      |
| OTVASFCN10_1 | Synacor/ISP Online:Standard (US) |
| OTVASFCN10_2 |                                  |
When I open order item with following clock number 'OTVASFCN10_1'
And copy data from 'Select Broadcast Destinations' section of order item page to all other items
And select order item with following clock number 'OTVASFCN10_2' on cover flow
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Syscode |
| 0303    |
And do searching for current filter options on Advanced Search form of Select Broadcast Destination section
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)          |
| Synacor/Verizon Online |
And reset search result on Advanced Search form of Select Broadcast Destination section
And view destinations by following filter 'View selected only' at Select Broadcast Destinations form on order item page
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard (US)                             |
| Synacor/ISP Online;Synacor/Verizon Online |

Scenario: Check visibility delivery tape icon
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVASFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVASFU1 | agency.admin | OTVASFA1     |
And logged in with details of 'OTVASFU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OTVASFCN11   |
When I open order item with following clock number 'OTVASFCN11'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| Syscode | Delivery Type |
| MCTV    | tape          |
And do searching for current filter options on Advanced Search form of Select Broadcast Destination section
Then I 'should' see following destinations 'MCTV' with delivery tape icon in destination table on Select Broadcast Destinations form