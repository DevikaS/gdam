!--ORD-1528
Feature: Check saving data when change market type
Narrative:
In order to:
As a AgencyAdmin
I want to check saving data when change market type

Scenario: Check that after changing market data isn't changed under Add Information section and on cover flow for music order
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OMCSDCMA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OMCSDCMU1 | agency.admin | OMCSDCMA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCSDCMA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OMCSDCMAR1 | OMCSDCMBR1 | OMCSDCMSB1 | OMCSDCMP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCSDCMA1'
And logged in with details of 'OMCSDCMU1'
And I am on View Draft Orders tab of 'music' order on ordering page
When I create 'music' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand      | Sub Brand  | Label     | Artist    | ISRC Code  | Release Date | Format         | Title     |
| automated test info    | OMCSDCMAR1 | OMCSDCMBR1 | OMCSDCMSB1 | OMCSDCMP1 | OMCSDCMC1 | OMCSDCMCN1 | 12/14/2022   | HD 1080i 25fps | OMCSDCMT1 |
And select following market 'Republic of Ireland' on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Record Company | Artist    | ISRC Code  | Release Date | Format         | Label     | Title     |
| automated test info    | OMCSDCMAR1     | OMCSDCMC1 | OMCSDCMCN1 | 12/14/2022   | HD 1080i 25fps | OMCSDCMP1 | OMCSDCMT1 |
And should see for active order item on cover flow following data:
| Title     | ISRC Code  | Aspect Ratio | Format |
| OMCSDCMT1 | OMCSDCMCN1 | 16x9         | hd     |

Scenario: Check that after changing market data isn't changed under Add Information section and on cover flow (retrieved from Library case) for music order
!--ORD-3202
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OMCSDCMA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OMCSDCMU1 | agency.admin | OMCSDCMA1   |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCSDCMA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OMCSDCMAR2 | OMCSDCMBR2 | OMCSDCMSB2 | OMCSDCMPR2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCSDCMA1'
And logged in with details of 'OMCSDCMU1'
And uploaded following assetsNEWLIB:
| Name                       |
| /files/13DV-CAPITAL-10.mpg |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I 'save' asset '13DV-CAPITAL-10.mpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue  |
| Advertiser   | OMCSDCMAR2  |
| Brand        | OMCSDCMBR2  |
| Sub Brand    | OMCSDCMSB2  |
| Product      | OMCSDCMPR2  |
| Air Date     | 12/14/22  |
| Duration     | 8s          |
| Clock number | AssetCN2    |
| Screen       | Music Promo |
And go to View Draft Orders tab of 'music' order on ordering page
And create 'music' order on View Draft Orders tab on ordering page
And add to order for order item at Add media to your order form following assets '13DV-CAPITAL-10.mpg'
And select following market 'Republic of Ireland' on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Record Company | Artist | ISRC Code | Release Date | Format | Label      | Title               |
|                        | OMCSDCMAR2     |        | AssetCN2  | 12/14/2022   |        | OMCSDCMPR2 | 13DV-CAPITAL-10.mpg |
And should see for active order item on cover flow following data:
| Title               | ISRC Code | Cover Title         | Aspect Ratio |
| 13DV-CAPITAL-10.mpg | AssetCN2  | 13DV-CAPITAL-10.mpg | 16:9         |


Scenario: Check that after changing market data isn't changed under Add Information section and on cover flow (retrieved from Library case for QC asset) for music order
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OMCSDCMA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OMCSDCMU1 | agency.admin | OMCSDCMA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCSDCMA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OMCSDCMAR2 | OMCSDCMBR3 | OMCSDCMSB3 | OMCSDCMP3 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCSDCMA1'
And logged in with details of 'OMCSDCMU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label     |  Artist   | ISRC Code  | Release Date | Format      | Title     | Destination                 |
| automated test info    | OMCSDCMAR2     | OMCSDCMBR3 | OMCSDCMSB3 | OMCSDCMP3 | OMCSDCMC3 | OMCSDCMCN3 | 12/14/2022   | SD PAL 16x9 | OMCSDCMT3 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'OMCSDCMCN3' with following fields:
| Job Number | PO Number  |
| OMCSDCMJN3 | OMCSDCMPN3 |
And I am on View Draft Orders tab of 'music' order on ordering page
When I create 'music' order on View Draft Orders tab on ordering page
And add to order for order item at Add media to your order form following qc assets 'OMCSDCMT3'
And select following market 'Republic of Ireland' on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Record Company | Artist    | ISRC Code  | Release Date | Format      | Label     | Title     |
|                        | OMCSDCMAR2     | OMCSDCMC3 | OMCSDCMCN3 | 12/14/2022   | SD PAL 16x9 | OMCSDCMP3 | OMCSDCMT3 |
And should see for active order item on cover flow following data:
| Title     | ISRC Code  | Aspect Ratio | Format |
| OMCSDCMT3 | OMCSDCMCN3 | 16x9         | sd     |