!--ORD-1556
Feature:  Separate business methods for gathering assets for TV and Music orders
Narrative:
In order to:
As a AgencyAdmin
I want to check retrieve files and assets

Scenario: Check that only music files can be retrieved for Music orders from project
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRFAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRFAU1 | agency.admin | OTVRFAA1     |
And logged in with details of 'OTVRFAU1'
And created 'OTVRFAP1' project
And created '/OTVRFAF1' folder for project 'OTVRFAP1'
And uploaded into project 'OTVRFAP1' following files:
| FileName            | Path      |
| /files/Fish1-Ad.mov | /OTVRFAF1 |
| /files/Fish2-Ad.mov | /OTVRFAF1 |
And waited while transcoding is finished in folder '/OTVRFAF1' on project 'OTVRFAP1' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OTVRFAF1' project 'OTVRFAP1'
When I 'save' file info by next information:
| FieldName | FieldValue  |
| Screen    | Music Promo |
And created 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OTVRFACN1 |
When I open order item with following isrc code 'OTVRFACN1'
Then 'should' see for order item at Add media to your order form following files retrieved from project 'OTVRFAP1' folder '/OTVRFAF1':
| Name         |
| Fish1-Ad.mov |
And 'should not' see for order item at Add media to your order form following files retrieved from project 'OTVRFAP1' folder '/OTVRFAF1':
| Name         |
| Fish2-Ad.mov |

Scenario: Check that only tv assets can be retrieved for TV orders from library
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRFAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| OTVRFAU1 | agency.admin | OTVRFAA1     |streamlined_library,ordering|
And logged in with details of 'OTVRFAU1'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | Screen      |
| Fish2-Ad.mov | Music Promo |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVRFACN2    |
When I open order item with following clock number 'OTVRFACN2'
Then I 'should' see for order item at Add media to your order form following assets:
| Name         |
| Fish1-Ad.mov |
And 'should not' see for order item at Add media to your order form following assets:
| Name         |
| Fish2-Ad.mov |


Scenario: Check visibility Retrieve from Projects button according to application access
Meta: @qaorderingsmoke
      @uatorderingsmoke
      @orderingcrossbrowser
Given I created the following agency:
| Name     | A4User        |
| OTVRFAA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique | Access   |
| <UserEmail> | agency.admin | OTVRFAA1     | <Access> |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVRFACN3    |
When I open order item with following clock number 'OTVRFACN3'
Then '<ShouldState>' see 'Retrieve from Projects' button for order item at Add media to your order form

Examples:
| UserEmail  | Access                   | ShouldState |
| OTVRFAU2_1 | library,ordering         | should not  |
| OTVRFAU2_2 | library,ordering,folders | should      |

Scenario: Check that Retrieve from Library is available for users without Library application
!--ORD-4274
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRFAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique | Access           |
| OTVRFAU4 | agency.admin | OTVRFAA1     | ordering,folders |
And logged in with details of 'OTVRFAU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVRFACN4    |
When I open order item with following clock number 'OTVRFACN4'
Then I 'should' see 'Retrieve from Library' button for order item at Add media to your order form