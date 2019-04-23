!--ORD-931
Feature: Clear action
Narrative:
In order to:
As a AgencyAdmin
I want to check clear action functionality

Scenario: Check that clear action deletes destinations under Select Broadcast Destination sub-section
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name    | A4User        |
| OTVCAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVCAU1 | agency.admin | OTVCAA1      |
And logged in with details of 'OTVCAU1'
And create 'tv' order with market 'Croatia' and items with following fields:
| Clock Number | Destination                              |
| OTVCACN1     | HRT Croatia:Standard;SPT Networks:Express |
When I open order item with following clock number 'OTVCACN1'
And clear 'Select Broadcast Destinations' section on order item page
Then I 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard    | Express     |
| HRT Croatia | SPT Networks |

Scenario: Check that clear action deletes QC & Ingested only under Select Broadcast Destination sub-section
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVCAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVCAU1 | agency.admin | OTVCAA1      |
And logged in with details of 'OTVCAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCACN2     |
When I open order item with following clock number 'OTVCACN2'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And clear 'Select Broadcast Destinations' section on order item page
Then I should see 'active' QC & Ingest Only button on order item page

Scenario: Check that clear action deletes data under Add Information sub-section
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVCAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVCAU1 | agency.admin | OTVCAA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCAA1':
| Advertiser | Brand    | Sub Brand | Product |
| OTVCAAR3   | OTVCABR3 | OTVCASB3  | OTVCAP3 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCAA1'
And logged in with details of 'OTVCAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   |
| automated test info    | OTVCAAR3   | OTVCABR3 | OTVCASB3  | OTVCAP3 | OTVCAOC3 | OTVCACN3     | 20       | 08/14/2022     | HD 1080i 25fps | OTVCAT3 |
When I open order item with following clock number 'OTVCACN3'
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title |
|                        |            |          |              |          |                |        |         |       |
And should see for active order item on cover flow following data:
| Title | Duration | Clock Number |
|       |          |              |


Scenario: Check that clear action deletes data in coverflow after add asset from library
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVCAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OTVCAU1 | agency.admin | OTVCAA1      |streamlined_library,folders|
And logged in with details of 'OTVCAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCACN4     |
And uploaded following assetsNEWLIB:
| Name                       |
| /files/13DV-CAPITAL-10.mpg |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I 'save' asset '13DV-CAPITAL-10.mpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue    |
| Clock number | AssetOTVCACN4 |
| Duration     | 8s            |
And added to 'tv' order item with clock number 'OTVCACN4' following asset '13DV-CAPITAL-10.mpg' of collection 'My Assets'
And open order item with following clock number 'AssetOTVCACN4'
And clear 'Add information' section on order item page
Then I should see for active order item on cover flow following data:
| Title | Duration | Clock Number | Cover Title         | Aspect Ratio |
|       |          |              | 13DV-CAPITAL-10.mpg | 16:9         |
And should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form


Scenario: Values that have been entered to Add Information remained on the page for QC asset
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVCAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVCAU1 | agency.admin | OTVCAA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCAA1':
| Advertiser | Brand    | Sub Brand | Product |
| OTVCAAR5   | OTVCABR5 | OTVCASB5  | OTVCAP5 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCAA1'
And logged in with details of 'OTVCAU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format      | Title   | Subtitles Required | Destination                |
| automated test info    | OTVCAAR5   | OTVCABR5 | OTVCASB5  | OTVCAP5 | OTVCAC5  | OTVCACN5_1   | 20       | 08/14/2022     | SD PAL 16x9 | OTVCAT5 | Already Supplied   | Universal Ireland:Standard |
And complete order contains item with clock number 'OTVCACN5_1' with following fields:
| Job Number | PO Number |
| OTVCAJN5   | OTVCAPN5  |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCACN5_2   |
When I added to 'tv' order item with clock number 'OTVCACN5_2' following qc asset 'OTVCAT5' of collection 'My Assets'
And open order item with clock number 'OTVCACN5_1' for order with market 'United Kingdom'
And fill following fields for Add information form on order item page:
| Additional Information | First Air Date |
| automated test info    | 08/14/2022     |
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format      | Product | Title   | Subtitles Required |
|                        | OTVCAAR5   | OTVCABR5 | OTVCASB5  | OTVCAP5 | OTVCAC5  | OTVCACN5_1   | 20       |                | SD PAL 16x9 | OTVCAP5 | OTVCAT5 | Already Supplied   |


Scenario: Check correct work of clear action under Add media to your order section (not for QC asset)
!--ORD-3202
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVCAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| OTVCAU1 | agency.admin | OTVCAA1      |streamlined_library,folders|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCAA1':
| Advertiser | Brand    | Sub Brand | Product  |
| OTVCAAR6   | OTVCABR6 | OTVCASB6  | OTVCAPR6 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCAA1'
And logged in with details of 'OTVCAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCACN6     |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue    |
| Clock number | AssetOTVCACN6 |
| Duration | 8s |
| Air Date     | 10/14/22    |
| Advertiser   | OTVCAAR6      |
| Brand        | OTVCABR6      |
| Sub Brand    | OTVCASB6      |
| Product      | OTVCAPR6      |
And added to 'tv' order item with clock number 'OTVCACN6' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And open order item with following clock number 'AssetOTVCACN6'
And clear 'Add media' section on order item page
Then I should see for active order item on cover flow following data:
| Title        |  Clock Number  | Cover Title | Aspect Ratio |Duration|
| Fish1-Ad.mov |  AssetOTVCACN6 |             |              |8s|
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign | Clock Number  | First Air Date | Format | Product  | Title        | Subtitles Required |Duration|
|                        | OTVCAAR6   |          | AssetOTVCACN6 | 10/13/2022     |        | OTVCAPR6 | Fish1-Ad.mov |                    |8s|
And should see 'enabled' Retrieve from Library button for order item at Add media to your order form
And should see 'enabled' Retrieve from Project button for order item at Add media to your order form


