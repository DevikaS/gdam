!--ORD-2235
!--ORD-2236
!--ORD-2247
!--ORD-2248
!--ORD-2524
Feature: Bookmarks
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of bookmarks

Scenario: Check that saving bookmark is correctly worked
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN1     |
When I open order item with following clock number 'OTVWBCN1'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           | Express   |
| BSkyB Green Button | PTV Prime |
And fill following fields for Bookmark stations form of Select Broadcast Destinations section on order item page:
| Name     |
| OTVWBBN1 |
And bookmark selected station list on Bookmark stations form of Select Broadcast Destinations section
Then I 'should not' see Bookmark stations form of Select Broadcast Destinations section on order item page

Scenario: Bookmark is individual per user
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
| OTVWBU2 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create bookmark for order with market 'United Kingdom' with following fields:
| Name     | Destination                                   |
| OTVWBBN2 | BSkyB Green Button:Standard;PTV Prime:Express |
And logged in with details of 'OTVWBU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN2     |
When I open order item with following clock number 'OTVWBCN2'
Then I should see 'inactive' Load a selection button of Select Broadcast Destinations section on order item page

Scenario: Bookmark is individual per market
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create bookmark for order with market 'United Kingdom' with following fields:
| Name     | Destination                                   |
| OTVWBBN3 | BSkyB Green Button:Standard;PTV Prime:Express |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OTVWBCN3     |
When I open order item with following clock number 'OTVWBCN3'
Then I should see 'inactive' Load a selection button of Select Broadcast Destinations section on order item page

Scenario: Bookmark correctly works within one marker
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create bookmark for order with market 'United Kingdom' with following fields:
| Name     | Destination                                   |
| OTVWBBN4 | BSkyB Green Button:Standard;PTV Prime:Express |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN4     |
When I open order item with following clock number 'OTVWBCN4'
Then I should see 'active' Load a selection button of Select Broadcast Destinations section on order item page

Scenario: Check that all selected destinations are displayed on Bookmark this station list
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN5     |
When I open order item with following clock number 'OTVWBCN5'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           | Express   |
| BSkyB Green Button | PTV Prime |
Then I should see following data on Bookmark stations form of Select Broadcast Destinations section:
| Service Level | Destination        |
| STD           | BSkyB Green Button |
| EXP           | PTV Prime          |

Scenario: Check that destinations can be deleted on Bookmark this station list
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN6     |
When I open order item with following clock number 'OTVWBCN6'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           | Express   |
| BSkyB Green Button | PTV Prime |
And delete following station 'BSkyB Green Button' on Bookmark stations form of Select Broadcast Destinations section
Then I should see following data on Bookmark stations form of Select Broadcast Destinations section:
| Service Level | Destination        |
| EXP           | PTV Prime          |

Scenario: Check that Save this selection button is active when destinations are selected
!--ORD-2681
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Destination                                   |
| OTVWBCN7     | BSkyB Green Button:Standard;PTV Prime:Express |
When I open order item with following clock number 'OTVWBCN7'
Then I should see 'active' Save this selection button of Select Broadcast Destinations section on order item page

Scenario: Check that destinations from Bookmark can be loaded
!--ORD-2654
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN8     |
And create bookmark for order with market 'United Kingdom' with following fields:
| Name     | Destination                                   |
| OTVWBBN8 | BSkyB Green Button:Standard;PTV Prime:Express |
When I open order item with following clock number 'OTVWBCN8'
And load bookmark with following name 'OTVWBBN8' on Select a pre-set you wish to load form of Select Broadcast Destinations section
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard           | Express   |
| BSkyB Green Button | PTV Prime |

Scenario: Check that Bookmark can be deleted
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN9     |
And create bookmark for order with market 'United Kingdom' with following fields:
| Name     | Destination                                   |
| OTVWBBN9 | BSkyB Green Button:Standard;PTV Prime:Express |
When I open order item with following clock number 'OTVWBCN9'
And delete bookmark with following name 'OTVWBBN9' on Select a pre-set you wish to load form of Select Broadcast Destinations section
Then I 'should not' see following bookmark 'OTVWBBN9' on Select a pre-set you wish to load form of Select Broadcast Destinations section

Scenario: Check that Bookmarks can be overwritten in case to specify the existed name
!--ORD-2654
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN10_1  |
| OTVWBCN10_2  |
And create bookmark for order with market 'United Kingdom' with following fields:
| Name      | Destination                                   |
| OTVWBBN10 | BSkyB Green Button:Standard;PTV Prime:Express |
When I open order item with following clock number 'OTVWBCN10_1'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard         | Express             |
| Subpostmaster TV | London News Network |
And fill following fields for Bookmark stations form of Select Broadcast Destinations section on order item page:
| Name      |
| OTVWBBN10 |
And bookmark previously saved stations list on Bookmark stations form of Select Broadcast Destinations section
And select order item with following clock number 'OTVWBCN10_2' on cover flow
And load bookmark with following name 'OTVWBBN10' on Select a pre-set you wish to load form of Select Broadcast Destinations section
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard         | Express             |
| Subpostmaster TV | London News Network |

Scenario: Check that Bookmark button is not active when all stations were deleted
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN11    |
When I open order item with following clock number 'OTVWBCN11'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| BSkyB Green Button |
And delete following station 'BSkyB Green Button' on Bookmark stations form of Select Broadcast Destinations section
Then I should see 'inactive' Bookmark button on Bookmark stations form of Select Broadcast Destinations section

Scenario: Check that Bookmark cannot create without name
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN12    |
When I open order item with following clock number 'OTVWBCN12'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| BSkyB Green Button |
And fill following fields for Bookmark stations form of Select Broadcast Destinations section on order item page:
| Name |
|      |
And click Bookmark button on Bookmark stations form of Select Broadcast Destinations section
Then I 'should' see Bookmark stations form of Select Broadcast Destinations section on order item page

Scenario: Check that Bookmarks can be extendable in case to add a few bookmarks
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVWBA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVWBU1 | agency.admin | OTVWBA1      |
And logged in with details of 'OTVWBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVWBCN13    |
And create bookmark for order with market 'United Kingdom' with following fields:
| Name        | Destination                                           |
| OTVWBBN13_1 | BSkyB Green Button:Standard;PTV Prime:Express         |
| OTVWBBN13_2 | Subpostmaster TV:Standard;London News Network:Express |
When I open order item with following clock number 'OTVWBCN13'
And load bookmarks with following names 'OTVWBBN13_1,OTVWBBN13_2' on Select a pre-set you wish to load form of Select Broadcast Destinations section
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard                            | Express                       |
| BSkyB Green Button;Subpostmaster TV | PTV Prime;London News Network |