!--ORD-388
!--ORD-3080
Feature: Check showing X Y info for library assets
Narrative:
In order to:
As a AgencyAdmin
I want to check showing X Y info for library assets

Scenario: check files found notification after retrieve from library
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYILAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| SXYILAU1 | agency.admin | SXYILAA1     |streamlined_library|
And logged in with details of 'SXYILAU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
| /files/Fish3-Ad.mov  |
| /files/Fish4-Ad.mov  |
| /files/Fish5-Ad.mov  |
| /files/Fish6-Ad.mov  |
| /files/Fish7-Ad.mov  |
| /files/Fish8-Ad.mov  |
| /files/Fish9-Ad.mov  |
| /files/Fish10-Ad.mov |
| /files/Fish11-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYILACN1    |
When I open order item with following clock number 'SXYILACN1'
Then I should see following 'Library' content counter notification '11 files found. Showing 1 - 10' for order item at Add media to your order form


Scenario: check files found notification for second page after retrieve from library
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYILAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| SXYILAU1 | agency.admin | SXYILAA1     |streamlined_library|
And logged in with details of 'SXYILAU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
| /files/Fish3-Ad.mov  |
| /files/Fish4-Ad.mov  |
| /files/Fish5-Ad.mov  |
| /files/Fish6-Ad.mov  |
| /files/Fish7-Ad.mov  |
| /files/Fish8-Ad.mov  |
| /files/Fish9-Ad.mov  |
| /files/Fish10-Ad.mov |
| /files/Fish11-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYILACN2    |
When I open order item with following clock number 'SXYILACN2'
And scroll to page '2' in 'Library' content for Add media to your order form
Then I should see following 'Library' content counter notification '11 files found. Showing 11 - 11' for order item at Add media to your order form



Scenario: check files found notification after searching assets
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYILAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYILAU1 | agency.admin | SXYILAA1     |
And logged in with details of 'SXYILAU1'
And uploaded following assets:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYILACN3    |
When I open order item with following clock number 'SXYILACN3'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value 'Fish1-Ad' for Add media to your order form on order item page
Then I should see following 'Library' content counter notification '1 files found. Showing 1 - 1' for order item at Add media to your order form

Scenario: check files found notification after searching assets by wrong filter
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYILAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| SXYILAU1 | agency.admin | SXYILAA1     |streamlined_library|
And logged in with details of 'SXYILAU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYILACN4    |
When I open order item with following clock number 'SXYILACN4'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value 'test asset' for Add media to your order form on order item page
Then I should see following 'Library' content counter notification '0 files found. Showing 0 - 0' for order item at Add media to your order form


Scenario: check files found notification after deleting asset in library
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYILAA5 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| SXYILAU5 | agency.admin | SXYILAA5     |streamlined_library|
And logged in with details of 'SXYILAU5'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And deleted asset 'Fish1-Ad.mov' from collection 'My Assets' in LibraryNEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYILACN5    |
When I open order item with following clock number 'SXYILACN5'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value 'Fish1-Ad' for Add media to your order form on order item page
Then I should see following 'Library' content counter notification '0 files found. Showing 0 - 0' for order item at Add media to your order form


Scenario: check files found notification for assets with Music Promo
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYILAA6 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| SXYILAU6 | agency.admin | SXYILAA6     |streamlined_library|
And logged in with details of 'SXYILAU6'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | Screen      |
| Fish1-Ad.mov | Music Promo |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYILACN6_1  |
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code   |
| SXYILACN6_2 |
When I open order item with following clock number 'SXYILACN6_1'
And retrieve assets from library for order item at Add media to your order form
Then I should see following 'Library' content counter notification '0 files found. Showing 0 - 0' for order item at Add media to your order form
When I open order item with following isrc code 'SXYILACN6_2'
And refresh the page without delay
And retrieve assets from library for order item at Add media to your order form
Then I should see following 'Library' content counter notification '1 files found. Showing 1 - 1' for order item at Add media to your order form

