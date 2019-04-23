!--ORD-261
!--ORD-660
Feature: Search destinations
Narrative:
In order to:
As a AgencyAdmin
I want to check search destinations

Scenario: Check combination search of destination sub groups and destinations
!--ORD-802
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVSDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVSDU1 | agency.admin | OTVSDA1      |
And logged in with details of 'OTVSDU1'
And create 'tv' order with market '<Market>' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill Search Stations field by value '<SearchFilter>' for Select Broadcast Destinations form on order item page
Then I 'should' see following destinations '<Destinations>' in destination table on Select Broadcast Destinations form
And 'should' see following destinations sub groups '<SubGroups>' in destination table on Select Broadcast Destinations form

Examples:
| Market         | ClockNumber | SearchFilter                            | Destinations                            | SubGroups           |
| Canada         | OTVSDCN1_1  | One: The Body                           | One: The Body, Mind and Spirit Channel  | ZoomerMedia Hub     |
| Brasil         | OTVSDCN1_2  | Disney BRASIL SD                        | Disney Brasil SD                        | TV Por Assinatura   |
| Belgium        | OTVSDCN1_3  | Discovery N                             | Discovery Networks Benelux              | Belgium             |
| United Kingdom | OTVSDCN1_4  | E!                                      | BSkyB - E! Entertainment;E! Sponsorship | BSkyB,Sponsorship   |
| United Kingdom | OTVSDCN1_5  | SyFy/Universal/Movies24/Movies 24+/DIVA | SyFy/Universal/Movies24/Movies 24+/DIVA | Redbee (formerly BBC)|
| United Kingdom | OTVSDCN1_6  | BT Sport 1& 2                           | Channel 4 &E4 / 4seven / BT Sport 1& 2  | Channel 4/E4        |
| United Kingdom | OTVSDCN1_7  | AL Ehya (formerly                       | AL Ehya (formerly Noor)                 | ZMTV                |
| United Kingdom | OTVSDCN1_8  | POP                                     | Viacom;Subpostmaster TV                 | POP TV              |
| United Kingdom | OTVSDCN1_9  | Optimal Media Sales                     | ITV Teleshopping                        | Optimal Media Sales |

Scenario: Check search with no results
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVSDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVSDU1 | agency.admin | OTVSDA1      |
And logged in with details of 'OTVSDU1'
And create 'tv' order with market '<Market>' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill Search Stations field by value '<SearchFilter>' for Select Broadcast Destinations form on order item page
Then I '<ShouldState>' see destination table with destinations for order item on Select Broadcast Destinations form

Examples:
| Market         | ClockNumber | SearchFilter | ShouldState |
| United Kingdom | OTVSDCN2_1  | rea est      | should not  |
| United Kingdom | OTVSDCN2_2  | urner VOD    | should      |

Scenario: Check that destination from another market cannot be found
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVSDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVSDU1 | agency.admin | OTVSDA1      |
And logged in with details of 'OTVSDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVSDCN3     |
When I open order item with following clock number 'OTVSDCN3'
And fill Search Stations field by value 'BRASIL SD' for Select Broadcast Destinations form on order item page
Then I 'should not' see following destinations 'Disney Brasil SD' in destination table on Select Broadcast Destinations form
And 'should not' see destination table with destinations for order item on Select Broadcast Destinations form

Scenario: Check that after removing value in search stations field all destinations are displayed
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVSDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVSDU1 | agency.admin | OTVSDA1      |
And logged in with details of 'OTVSDU1'
And create 'tv' order with market 'Bolivia' and items with following fields:
| Clock Number |
| OTVSDCN4     |
When I open order item with following clock number 'OTVSDCN4'
And fill Search Stations field by value 'test' for Select Broadcast Destinations form on order item page
And update Search Stations field by value '' for Select Broadcast Destinations form on order item page
Then I 'should' see following destinations 'ATB - Canal 9;RED BOLIVISION;RED PAT;Red Uno - Canal 11;Unitel - Canal 2' in destination table on Select Broadcast Destinations form
And 'should' see following destinations sub groups 'Bolivia' in destination table on Select Broadcast Destinations form

Scenario: Check that correct search result is showed in case to update value into search results
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name    | A4User        |
| OTVSDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVSDU1 | agency.admin | OTVSDA1      |
And logged in with details of 'OTVSDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVSDCN5     |
When I open order item with following clock number 'OTVSDCN5'
And fill Search Stations field by value 'ABP' for Select Broadcast Destinations form on order item page
And update Search Stations field by value 'ABP News' for Select Broadcast Destinations form on order item page
Then I 'should' see following destinations 'ABP News' in destination table on Select Broadcast Destinations form
And 'should' see following destinations sub groups 'Exodus' in destination table on Select Broadcast Destinations form

Scenario: Check that search destinations doesn’t reset already selected destinations
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVSDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVSDU1 | agency.admin | OTVSDA1      |
And logged in with details of 'OTVSDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Destination               |
| OTVSDCN6     | Subpostmaster TV:Standard |
When I open order item with following clock number 'OTVSDCN6'
And fill Search Stations field by value 'PTV Prime' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Express   |
| PTV Prime |
And update Search Stations field by value '' for Select Broadcast Destinations form on order item page
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard         | Express   |
| Subpostmaster TV | PTV Prime |

Scenario: Check contains rule for destinations searching
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVSDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVSDU1 | agency.admin | OTVSDA1      |
And logged in with details of 'OTVSDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill Search Stations field by value '<SearchFilter>' for Select Broadcast Destinations form on order item page
Then I 'should' see following destinations '<Destinations>' in destination table on Select Broadcast Destinations form
And 'should' see following destinations sub groups '<SubGroups>' in destination table on Select Broadcast Destinations form

Examples:
| ClockNumber | SearchFilter | Destinations              | SubGroups   |
| OTVSDCN7_1  | Button       | BSkyB Green Button        | BSkyB       |
| OTVSDCN7_2  | lster        | ITV Ulster (UTV)          | ITV         |
| OTVSDCN7_3  | AB TV        | FAB TV                    | Media 15    |
| OTVSDCN7_4  | llite)       | JSTV (Japanese Satellite) | ZMTV        |
| OTVSDCN7_5  | /Reve        | Genesis/Revelation        | TMH         |
| OTVSDCN7_6  | - UK         | New Station - UK          | New Station |