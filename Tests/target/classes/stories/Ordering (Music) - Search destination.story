!--ORD-1544
Feature: Search destinations
Narrative:
In order to:
As a AgencyAdmin
I want to check search destinations

Scenario: Check combination search of destination sub groups and destinations for music
!--ORD-802
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMSDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMSDU1 | agency.admin | OMSDA1       |
And logged in with details of 'OMSDU1'
And create 'music' order with market '<Market>' and items with following fields:
| ISRC Code  |
| <ISRCCode> |
When I open order item with following isrc code '<ISRCCode>'
And fill Search Stations field by value '<SearchFilter>' for Select Broadcast Destinations form on order item page
Then I 'should' see following destinations '<Destinations>' in destination table on Select Broadcast Destinations form
And 'should' see following destinations sub groups '<SubGroups>' in destination table on Select Broadcast Destinations form

Examples:
| Market         | ISRCCode  | SearchFilter                            | Destinations                             | SubGroups           |
| Canada         | OMSDCN1_1 | One: The Body                           | One: The Body, Mind and Spirit Channel   | ZoomerMedia Hub     |
| Brasil         | OMSDCN1_2 | Disney BRASIL SD                        | Disney Brasil SD                         | TV Por Assinatura   |
| Belgium        | OMSDCN1_3 | Discovery N                             | Discovery Networks Benelux               | Belgium             |
| United Kingdom | OMSDCN1_4 | E!                                      | BSkyB - E! Entertainment;E! Sponsorship  | BSkyB,Sponsorship   |
| United Kingdom | OMSDCN1_5 | SyFy/Universal/Movies24/Movies 24+/DIVA | SyFy/Universal/Movies24/Movies 24+/DIVA  | Redbee (formerly BBC)|
| United Kingdom | OMSDCN1_6 | BT Sport 1& 2                           | Channel 4 &E4 / 4seven / BT Sport 1& 2   | Channel 4/E4        |
| United Kingdom | OMSDCN1_7 | AL Ehya (formerly                       | AL Ehya (formerly Noor)                  | ZMTV                |
| United Kingdom | OMSDCN1_8 | POP                                     | Viacom;Subpostmaster TV                  |POP TV               |
| United Kingdom | OMSDCN1_9 | Optimal Media Sales                     | ITV Teleshopping                         | Optimal Media Sales |

Scenario: Check search with no results for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMSDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMSDU1 | agency.admin | OMSDA1       |
And logged in with details of 'OMSDU1'
And create 'music' order with market '<Market>' and items with following fields:
| ISRC Code  |
| <ISRCCode> |
When I open order item with following isrc code '<ISRCCode>'
And fill Search Stations field by value '<SearchFilter>' for Select Broadcast Destinations form on order item page
Then I '<ShouldState>' see destination table with destinations for order item on Select Broadcast Destinations form

Examples:
| Market         | ISRCCode  | SearchFilter | ShouldState |
| United Kingdom | OMSDCN2_1 | rea est      | should not  |
| United Kingdom | OMSDCN2_2 | urner VOD    | should      |

Scenario: Check that destination from another market cannot be found for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMSDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMSDU1 | agency.admin | OMSDA1       |
And logged in with details of 'OMSDU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMSDCN3   |
When I open order item with following isrc code 'OMSDCN3'
And fill Search Stations field by value 'BRASIL SD' for Select Broadcast Destinations form on order item page
Then I 'should not' see following destinations 'Disney Brasil SD' in destination table on Select Broadcast Destinations form
And 'should not' see destination table with destinations for order item on Select Broadcast Destinations form

Scenario: Check that after removing value in search stations field all destinations are displayed for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMSDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMSDU1 | agency.admin | OMSDA1       |
And logged in with details of 'OMSDU1'
And create 'music' order with market 'Bolivia' and items with following fields:
| ISRC Code |
| OMSDCN4   |
When I open order item with following isrc code 'OMSDCN4'
And fill Search Stations field by value 'test' for Select Broadcast Destinations form on order item page
And update Search Stations field by value '' for Select Broadcast Destinations form on order item page
Then I 'should' see following destinations 'ATB - Canal 9;RED BOLIVISION;RED PAT;Red Uno - Canal 11;Unitel - Canal 2' in destination table on Select Broadcast Destinations form
And 'should' see following destinations sub groups 'Bolivia' in destination table on Select Broadcast Destinations form

Scenario: Check that correct search result is showed in case to update value into search results for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMSDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMSDU1 | agency.admin | OMSDA1       |
And logged in with details of 'OMSDU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMSDCN5   |
When I open order item with following isrc code 'OMSDCN5'
And fill Search Stations field by value 'BSkyB' for Select Broadcast Destinations form on order item page
And update Search Stations field by value 'BSkyB Green Button' for Select Broadcast Destinations form on order item page
Then I 'should' see following destinations 'BSkyB Green Button' in destination table on Select Broadcast Destinations form
And 'should' see following destinations sub groups 'BSkyB' in destination table on Select Broadcast Destinations form

Scenario: Check that search destinations doesn’t reset already selected destinations for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMSDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMSDU1 | agency.admin | OMSDA1       |
And logged in with details of 'OMSDU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code | Destination               |
| OMSDCN6   | Subpostmaster TV:Standard |
When I open order item with following isrc code 'OMSDCN6'
And fill Search Stations field by value 'PTV Prime' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Express   |
| PTV Prime |
And update Search Stations field by value '' for Select Broadcast Destinations form on order item page
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard         | Express   |
| Subpostmaster TV | PTV Prime |