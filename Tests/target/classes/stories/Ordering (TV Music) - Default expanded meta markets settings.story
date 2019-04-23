!--ORD-3231
!--ORD-3438
Feature: Default expanded meta markets settings
Narrative:
In order to:
As a AgencyAdmin
I want to check default expanded meta markets settings

Scenario: check working Expanded Multiple Markets
Meta: @ordering
@obug
!--FAB-350
Given I created the following agency:
| Name   | A4User        |
| DEMMA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| DEMMU1 | agency.admin | DEMMA1       |
And logged in with details of 'DEMMU1'
And create '<OrderType>' order with market 'DACH' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Expanded Multiple Markets |
| DACH                      |
And save own Delivery Setting
And open order item with following clock number '<ClockNumber>'
Then I 'should' see expanded all markets destinations for order item on Select Broadcast Destinations form

Examples:
| OrderType | ClockNumber |
| tv        | DEMMCN1_1   |
| music     | DEMMCN1_2   |

Scenario: check deleting value from Expanded Multiple Markets field
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| DEMMA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| DEMMU1 | agency.admin | DEMMA1       |
And logged in with details of 'DEMMU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Expanded Multiple Markets |
| DACH                      |
And save own Delivery Setting
And fill following fields for Delivery Setting form on user delivery setting page:
| Expanded Multiple Markets |
|                           |
And save own Delivery Setting
And refresh the page without delay
Then I should see following data for Delivery Setting form on user delivery setting page:
| Expanded Multiple Markets |
|                           |

Scenario: check working Expanded Multiple Markets with Copy Current and New actions
Meta: @ordering
@obug
!--FAB-350
Given I created the following agency:
| Name   | A4User        |
| DEMMA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| DEMMU1 | agency.admin | DEMMA1       |
And logged in with details of 'DEMMU1'
And create 'tv' order with market 'DACH' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Expanded Multiple Markets |
| DACH                      |
And save own Delivery Setting
And open order item with following clock number '<ClockNumber>'
And '<Action>' order item by Add Commercial button on order item page
Then I 'should' see expanded all markets destinations for order item on Select Broadcast Destinations form

Examples:
| ClockNumber | Action       |
| DEMMCN3_1   | create new   |
| DEMMCN3_2   | copy current |

Scenario: check working Expanded Multiple Markets with ALL value
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| DEMMA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| DEMMU1 | agency.admin | DEMMA1       |
And logged in with details of 'DEMMU1'
And create 'tv' order with market '<Market>' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Expanded Multiple Markets |
| ALL                       |
And save own Delivery Setting
And open order item with following clock number '<ClockNumber>'
Then I 'should' see expanded all markets destinations for order item on Select Broadcast Destinations form

Examples:
| Market | ClockNumber |
| DACH   | DEMMCN4_1   |
| MENA   | DEMMCN4_2   |

Scenario: check working Expanded Multiple Markets while doing action with destinations list
Meta: @ordering
@obug
!--FAB-350
Given I created the following agency:
| Name   | A4User        |
| DEMMA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| DEMMU1 | agency.admin | DEMMA1       |
And logged in with details of 'DEMMU1'
And create 'tv' order with market 'DACH' and items with following fields:
| Clock Number | Destination       |
| DEMMCN5      | Tele Top:Standard |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Expanded Multiple Markets |
| DACH                      |
And save own Delivery Setting
And open order item with following clock number 'DEMMCN5'
And view destinations by following filter 'View selected only' at Select Broadcast Destinations form on order item page
And view destinations by following filter 'View all' at Select Broadcast Destinations form on order item page
Then I 'should' see expanded all markets destinations for order item on Select Broadcast Destinations form