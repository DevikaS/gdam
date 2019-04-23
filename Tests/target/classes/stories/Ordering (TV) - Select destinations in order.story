!--ORD-663
!--ORD-257
!--ORD-712
Feature: Select destinations
Narrative:
In order to:
As a AgencyAdmin
I want to check selection and saving destinations

Scenario: Check correct work of View selected only,View all filter
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Destination                   |
| OTVSDOCN1    | IDS UKTV and Flextech:Express |
When I open order item with following clock number 'OTVSDOCN1'
And view destinations by following filter 'View selected only' at Select Broadcast Destinations form on order item page
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Express                                     |
| Redbee (formerly BBC);IDS UKTV and Flextech |
And 'should' see following destinations filter 'View all' at Select Broadcast Destinations form on order item page

Scenario: Check that only one service level can be selected per destination destination group
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard      | Express       |
| <Destination> | <Destination> |
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Express       |
| <Destination> |
And 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard      |
| <Destination> |

Examples:
| ClockNumber | Destination            |
| OTVSDOCN2_1 | Scottish Media Group 2 |
| OTVSDOCN2_2 | Turner                 |

Scenario: Check that selection of destination sub group selects all destinations within this destination sub group
Meta: @qaorderingsmoke
      @uatorderingsmoke
      @orderingcrossbrowser
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OTVSDOCN3    |
When I open order item with following clock number 'OTVSDOCN3'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard               |
| Sponsorship IE         |
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard                                              |
| RTE Sponsorship HD;RTE Sponsorship SD;TV3 Sponsorship |

Scenario: Check that selection of broadcast center selects all destinations within this broadcast center
!--There is no longer a checkbox against Broaadcast centres--so cant select them
Meta: @ordering
      @skip
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVSDOCN4    |
When I open order item with following clock number 'OTVSDOCN4'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard        |
| Global Music TV |
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard                              |
| Global Music TV;-Capital TV;-Heart TV |

Scenario: Check that selection of all destinations in destination sub group selects destination sub group
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'Australia' and items with following fields:
| Clock Number |
| OTVSDOCN5    |
When I open order item with following clock number 'OTVSDOCN5'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| CAD/Free TV;Foxtel |
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard |
| Tasmania |

Scenario: Check that selection of all destinations in broadcast center selects this broadcast center
!--No checkbox against broadcast centre--no channels cant be selected individually
Meta: @ordering
      @skip
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVSDOCN6    |
When I open order item with following clock number 'OTVSDOCN6'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard              |
| -Capital TV;-Heart TV |
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard        |
| Global Music TV |

Scenario: Check that selected destinations are saved in case to save draft order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVSDOCN7    |
When I open order item with following clock number 'OTVSDOCN7'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard                   |
| Health Club Network;Turner |
And save as draft order
And open order item with following clock number 'OTVSDOCN7'
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard                                          |
| Health Club Network;Turner;Scottish Media Group 2 |

Scenario: Check that correct destinations are displayed after confirming order on order details
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVSDOAR8  | OTVSDOBR8 | OTVSDOSB8 | OTVSDOP8 |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                  |
| automated test info    | OTVSDOAR8  | OTVSDOBR8 | OTVSDOSB8 | OTVSDOP8 | OTVSDOC8_1 | OTVSDOCN8_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT8_1 | Already Supplied   | Health Club Network:Standard |
| automated test info    | OTVSDOAR8  | OTVSDOBR8 | OTVSDOSB8 | OTVSDOP8 | OTVSDOC8_2 | OTVSDOCN8_2  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT8_2 | Already Supplied   | PTV Prime:Express            |
And complete order contains item with clock number 'OTVSDOCN8_1' with following fields:
| Job Number | PO Number |
| OTVSDOJN8  | OTVSDOPN8 |
When I go to Order Summary page for order contains item with following clock number 'OTVSDOCN8_1'
Then I 'should' see following destinations 'Health Club Network' for clock delivery 'OTVSDOCN8_1' on 'tv' order summary page
And 'should' see following destinations 'PTV Prime' for clock delivery 'OTVSDOCN8_2' on 'tv' order summary page

Scenario: Check that searching destinations reset View selected only filter
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Destination                  |
| OTVSDOCN9    | Health Club Network:Standard |
When I open order item with following clock number 'OTVSDOCN9'
And view destinations by following filter 'View selected only' at Select Broadcast Destinations form on order item page
And fill Search Stations field by value 'Turner' for Select Broadcast Destinations form on order item page
Then I 'should' see following destinations filter 'View selected only' at Select Broadcast Destinations form on order item page
And 'should' see following destinations sub groups 'Turner' in destination table on Select Broadcast Destinations form

Scenario: Check that unselection destination removes it from View selected only filter
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Destination                                     |
| OTVSDOCN10   | Health Club Network:Standard;PTV Prime:Standard |
When I open order item with following clock number 'OTVSDOCN10'
And view destinations by following filter 'View selected only' at Select Broadcast Destinations form on order item page
And 'uncheck' following destinations for Select Broadcast Destinations form on order item page:
| Standard  |
| PTV Prime |
Then I 'should' see following destinations 'Health Club Network' in destination table on Select Broadcast Destinations form
And 'should not' see following destinations 'PTV Prime' in destination table on Select Broadcast Destinations form

Scenario: Check that unselection destination correctly works in case to save draft order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Destination                  |
| OTVSDOCN11   | Health Club Network:Standard |
When I open order item with following clock number 'OTVSDOCN11'
And 'uncheck' following destinations for Select Broadcast Destinations form on order item page:
| Standard            |
| Health Club Network |
And save as draft order
And open order item with following clock number 'OTVSDOCN11'
Then I 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard            |
| Health Club Network |

Scenario: Check works of View all filter
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'Thailand' and items with following fields:
| Clock Number | Destination        |
| OTVSDOCN12   | Channel 3:Standard |
When I open order item with following clock number 'OTVSDOCN12'
And fill Search Stations field by value 'New Station - Thailand' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard               |
| New Station - Thailand |
And view destinations by following filter 'View selected only' at Select Broadcast Destinations form on order item page
And view destinations by following filter 'View all' at Select Broadcast Destinations form on order item page
Then I 'should' see following destinations 'New Station - Thailand;New Station - Thailand HD' in destination table on Select Broadcast Destinations form


Scenario: Check that all SD (HD) destinations that belong to the same BC are disabled for selection and only selected destination is ordered
!--NGN-16235
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSDOU1 | agency.admin | OTVSDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSDOA1':
| Advertiser | Brand   | Sub Brand | Product |
| SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR |
And logged in with details of 'OTVSDOU1'
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                               |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | OTVSDOCN2_1  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT  | None               | Colonial Shopping Centres HD:Standard;FreeTV CAD:Standard |
When I open order item with following clock number 'OTVSDOCN2_1'
Then I should see following destinations 'disabled' in Select Broadcast Destinations form on order item page:
| Standard                     |
| -Colonial Shopping Centres;-FreeTV CAD HD |
Then I should see following destinations 'enabled' in Select Broadcast Destinations form on order item page:
| Standard                  |
| -Colonial Shopping Centres HD;-FreeTV CAD |
When I click active Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OTVSDOJN1  | OTVSDOPN1 |
And confirm order on Order Proceed page
Then I should see 'live' order in 'tv' order list contains clock number 'OTVSDOCN2_1' and items with following fields:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration | Status        |
| OTVSDOCN2_1  | SPMUKAR    | SPMUKPR | SPMUKT | 10/14/2022     | HD 1080i 25fps | 20       | 0/2 Delivered |
When I go to Order Summary page for order contains item with following clock number 'OTVSDOCN2_1'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Brand   | Sub Brand | Product | Title  | First Air Date | Format         | Duration | Status        | Approve |
| OTVSDOCN2_1  | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKT | 10/14/2022     | HD 1080i 25fps | 20       | 0/2 Delivered |         |
And should see clock delivery 'OTVSDOCN2_1' contains destinations with following fields on 'tv' order summary page:
| Destination  | Status       | Time of Delivery | Priority |
| Colonial Shopping Centres HD | Order Placed | -                | Standard |
| FreeTV CAD   | Order Placed | -                | Standard |
