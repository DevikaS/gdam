!--ORD-2558
!--ORD-2625
Feature: USA Comcast clock validation
Narrative:
In order to:
As a AgencyAdmin
I want to check clock validation of USA Comcast market

Scenario:  Check that length of clock number cannot be more than 15 symbols for USA Comcast
!--ORD-2578
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCCVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCCVU1 | agency.admin | OTVCCVA1     |
And logged in with details of 'OTVCCVU1'
And create '<Type>' order with market 'United States & Canada' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I 'should' see warning icon next following fields 'AdID/ISCI' for order item on Add information form
And should see warning tooltip with following message 'AdID/ISCI is too long or contains illegal characters.' next field 'AdID/ISCI' for order item on Add information form

Examples:
| Type  | ClockNumber |
| tv    | OTVUCCVCN11 |

Scenario:  Check that length of clock number can be more than 15 symbols for another market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCCVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCCVU1 | agency.admin | OTVCCVA1     |
And logged in with details of 'OTVCCVU1'
And create '<Type>' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form

Examples:
| Type  | ClockNumber |
| tv    | OTVUCCVCN21 |
| music | OTVUCCVCN22 |

Scenario:  Check that clock number must included only alphanumeric symbols for USA Comcast
!--ORD-2578
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCCVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCCVU1 | agency.admin | OTVCCVA1     |
And logged in with details of 'OTVCCVU1'
And create '<Type>' order with market 'United States & Canada' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I 'should' see warning icon next following fields 'AdID/ISCI' for order item on Add information form
And should see warning tooltip with following message 'AdID/ISCI is too long or contains illegal characters.' next field 'AdID/ISCI' for order item on Add information form

Examples:
| Type  | ClockNumber |
| tv    | CCVCN3_1    |

Scenario:  Check that clock number included not only alphanumeric symbols for another market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCCVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCCVU1 | agency.admin | OTVCCVA1     |
And logged in with details of 'OTVCCVU1'
And create '<Type>' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form

Examples:
| Type  | ClockNumber |
| tv    | CCVCN4_1    |
| music | CCVCN4_2    |

Scenario: Check that length of clock number cannot be more than 15 symbols for USA Comcast while retrieving asset from library
!--ORD-2578
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCCVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| OTVCCVU1 | agency.admin | OTVCCVA1     |streamlined_library|
And logged in with details of 'OTVCCVU1'
And create '<Type>' order with market 'United States & Canada' and items with following fields:
| Title   |
| <Title> |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | ClockNumber   |
| Fish1-Ad.mov | <ClockNumber> |
And add to '<Type>' order item with title '<Title>' following asset 'Fish1-Ad.mov' of collection 'My Assets'
When I open order item with following clock number '<ClockNumber>'
Then I 'should' see warning icon next following fields 'AdID/ISCI' for order item on Add information form
And should see warning tooltip with following message 'AdID/ISCI is too long or contains illegal characters.' next field 'AdID/ISCI' for order item on Add information form

Examples:
| Type  | Title      | ClockNumber |
| tv    | OTVCCVT5_1 | OTVUCCVCN51 |


Scenario:  Check that clock number must included only alphanumeric symbols for USA Comcast while retrieving asset from library
!--ORD-2578
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCCVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCCVU1 | agency.admin | OTVCCVA1     |
And logged in with details of 'OTVCCVU1'
And create '<Type>' order with market 'United States & Canada' and items with following fields:
| Title   |
| <Title> |
And uploaded following assets:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And set following file info for next assets from collection 'My Assets':
| Name         | ClockNumber   |
| Fish1-Ad.mov | <ClockNumber> |
And add to '<Type>' order item with title '<Title>' following asset 'Fish1-Ad.mov' of collection 'My Assets'
When I open order item with following clock number '<ClockNumber>'
Then I 'should' see warning icon next following fields 'AdID/ISCI' for order item on Add information form
And should see warning tooltip with following message 'AdID/ISCI is too long or contains illegal characters.' next field 'AdID/ISCI' for order item on Add information form

Examples:
| Type  | Title      | ClockNumber |
| tv    | OTVCCVT6_1 | CCVCN6_1    |
