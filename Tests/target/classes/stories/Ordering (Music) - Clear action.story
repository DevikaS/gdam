!--ORD-1530
Feature: Clear action
Narrative:
In order to:
As a AgencyAdmin
I want to check clear action functionality

Scenario: Check that clear action deletes destinations under Select Broadcast Destination sub-section for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMCAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMCAU1 | agency.admin | OMCAA1       |
And logged in with details of 'OMCAU1'
And create 'music' order with market 'Croatia' and items with following fields:
| ISRC Code | Destination                              |
| OMCACN1   | HRT Croatia:Standard;RTL Croatia:Express |
When I open order item with following isrc code 'OMCACN1'
And clear 'Select Broadcast Destinations' section on order item page
Then I 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard    | Express     |
| HRT Croatia | RTL Croatia |

Scenario: Check that clear action deletes QC & Ingested only under Select Broadcast Destination sub-section for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMCAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMCAU1 | agency.admin | OMCAA1       |
And logged in with details of 'OMCAU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMCACN2   |
When I open order item with following isrc code 'OMCACN2'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And clear 'Select Broadcast Destinations' section on order item page
Then I should see 'active' QC & Ingest Only button on order item page

Scenario: Check that clear action deletes data under Add Information sub-section for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMCAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMCAU1 | agency.admin | OMCAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCAA1':
| Advertiser | Brand   | Sub Brand | Product |
| OMCAAR3    | OMCABR3 | OMCASB3   | OMCAP3  |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCAA1'
And logged in with details of 'OMCAU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand   | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title  |
| automated test info    | OMCAAR3        | OMCABR3 | OMCASB3   | OMCAP3  | OMCAOC3 | OMCACN3   | 08/14/2022   | HD 1080i 25fps | OMCAT3 |
When I open order item with following isrc code 'OMCACN3'
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Record Company | Artist  | ISRC Code | Release Date | Format | Label  | Title  |
|                        |                |         |           |              |        |        |        |
And should see for active order item on cover flow following data:
| Title | ISRC Code |
|       |           |

Scenario: Check that clear action deletes data in coverflow after add asset from library for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User       |
| OMCAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |Access|
| OMCAU1 | agency.admin | OMCAA1       |streamlined_library,ordering,folders|
And logged in with details of 'OMCAU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMCACN4   |
And uploaded following assetsNEWLIB:
| Name                       |
| /files/13DV-CAPITAL-10.mpg |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I 'save' asset '13DV-CAPITAL-10.mpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue   |
| Duration     | 8s           |
| Clock number | AssetOMCACN4 |
| Screen       | Music Promo  |
| Duration     | 8s           |
And added to 'music' order item with isrc code 'OMCACN4' following asset '13DV-CAPITAL-10.mpg' of collection 'My Assets'
And open order item with following isrc code 'AssetOMCACN4'
And clear 'Add information' section on order item page
Then I should see for active order item on cover flow following data:
| Title | ISRC Code | Cover Title         | Aspect Ratio |
|       |           | 13DV-CAPITAL-10.mpg | 16:9         |
And should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form


Scenario: Values that have been entered to Add Information remained on the page for QC asset for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMCAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OMCAU1 | agency.admin | OMCAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCAA1':
| Advertiser | Brand   | Sub Brand | Product |
| OMCAAR5    | OMCABR5 | OMCASB5   | OMCAP5  |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCAA1'
And logged in with details of 'OMCAU1'
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Record Company | Brand   | Sub Brand | Label  | Artist | ISRC Code | Release Date | Format      | Title  | Destination                |
| automated test info    | OMCAAR5        | OMCABR5 | OMCASB5   | OMCAP5 | OMCAC5 | OMCACN5_1 | 08/14/2022   | SD PAL 16x9 | OMCAT5 | Universal Ireland:Standard |
And complete order contains item with isrc code 'OMCACN5_1' with following fields:
| Job Number | PO Number |
| OMCAJN5    | OMCAPN5   |
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMCACN5_2 |
When I added to 'music' order item with isrc code 'OMCACN5_2' following qc asset 'OMCAT5' of collection 'My Assets'
And open order item with isrc code 'OMCACN5_1' for order with market 'United Kingdom'
And fill following fields for Add information form on order item page:
| Additional Information | Release Date |
| automated test info    | 08/14/2022   |
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Record Company | Artist | ISRC Code | Release Date | Format      | Label  | Title  |
|                        | OMCAAR5        | OMCAC5 | OMCACN5_1 |              | SD PAL 16x9 | OMCAP5 | OMCAT5 |


Scenario: Check correct work of clear action under Add media to your order section (not for QC asset) for music
!--ORD-3202
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCAA1  | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OMCAU1  | agency.admin | OMCAA1      |streamlined_library,ordering,folders|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCAA1':
| Advertiser | Brand    | Sub Brand | Product |
| OMCAAR6    | OMCABR6  | OMCASB6   | OMCAPR6 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCAA1'
And logged in with details of 'OMCAU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMCACN6   |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue   |
| Advertiser   | OMCAAR6      |
| Brand        | OMCABR6      |
| Sub Brand    | OMCASB6      |
| Product      | OMCAPR6      |
| Air Date     | 10/14/22     |
| Screen       | Music Promo  |
| Clock number | AssetOMCACN6 |
|Duration      |15s           |
And added to 'music' order item with isrc code 'OMCACN6' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And open order item with following isrc code 'AssetOMCACN6'
And clear 'Add media' section on order item page
Then I should see for active order item on cover flow following data:
| Title        | ISRC Code    | Cover Title | Aspect Ratio |
| Fish1-Ad.mov | AssetOMCACN6 |             |              |
And should see following data for order item on Add information form:
| Additional Information | Record Company | Artist | ISRC Code    | Release Date | Format | Label   | Title        |
|                        | OMCAAR6        |        | AssetOMCACN6 | 10/13/2022   |        | OMCAPR6 | Fish1-Ad.mov |
And should see 'enabled' Retrieve from Library button for order item at Add media to your order form
And should see 'enabled' Retrieve from Project button for order item at Add media to your order form
