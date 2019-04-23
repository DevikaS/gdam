!--ORD-1239
Feature: Check saving data when change market type
Narrative:
In order to:
As a AgencyAdmin
I want to check saving data when change market type

Scenario: Check that after changing market data isn't changed under Add Information section and on cover flow
!--ORD-1191,ORD-1273
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVCSDCMA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVCSDCMU1 | agency.admin | OTVCSDCMA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCSDCMA1':
| Advertiser  | Brand       | Sub Brand   | Product    |
| OTVCSDCMAR1 | OTVCSDCMBR1 | OTVCSDCMSB1 | OTVCSDCMP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCSDCMA1'
And logged in with details of 'OTVCSDCMU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required |
| automated test info    | OTVCSDCMAR1 | OTVCSDCMBR1 | OTVCSDCMSB1 | OTVCSDCMP1 | OTVCSDCMC1 | OTVCSDCMCN1  | 20       | 10/14/2022     | HD 1080i 25fps | OTVCSDCMT1 | Already Supplied   |
And select following market 'Republic of Ireland' on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Campaign   | Clock Number | Duration | First Air Date | Format         | Product    | Title      | Subtitles Required |
| automated test info    | OTVCSDCMAR1 | OTVCSDCMC1 | OTVCSDCMCN1  | 20       | 10/14/2022     | HD 1080i 25fps | OTVCSDCMP1 | OTVCSDCMT1 | Already Supplied   |
And should see for active order item on cover flow following data:
| Title      | Duration | Clock Number |
| OTVCSDCMT1 | 20       | OTVCSDCMCN1  |

Scenario: Check that after changing market data isn't changed under Add Information section and on cover flow (retrieved from Library case)
!--ORD-3202
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVCSDCMA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| OTVCSDCMU1 | agency.admin | OTVCSDCMA1   |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCSDCMA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVCSDCMAR2 | OTVCSDCMBR2 | OTVCSDCMSB2 | OTVCSDCMPR2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCSDCMA1'
And logged in with details of 'OTVCSDCMU1'
And I am on the Library page for collection 'My Assets'NEWLIB
And uploaded following assetsNEWLIB:
| Name                       |
| /files/13DV-CAPITAL-10.mpg |
And waited while preview is visible on library page for collection 'My Assets' for assets '13DV-CAPITAL-10.mpg'NEWLIB
When I 'save' asset '13DV-CAPITAL-10.mpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue  |
| Clock number | AssetCN2    |
| Duration     | 8s  |
| Air Date     | 12/14/22  |
| Advertiser   | OTVCSDCMAR2 |
| Brand        | OTVCSDCMBR2 |
| Sub Brand    | OTVCSDCMSB2 |
| Product      | OTVCSDCMPR2 |
And go to View Draft Orders tab of 'tv' order on ordering page
And create 'tv' order on View Draft Orders tab on ordering page
And add to order for order item at Add media to your order form following assets '13DV-CAPITAL-10.mpg'
And select following market 'Republic of Ireland' on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Campaign | Clock Number |Duration| First Air Date | Format | Product     | Title               | Subtitles Required |
|                        | OTVCSDCMAR2 |          | AssetCN2     |  8s     |12/14/2022     |        | OTVCSDCMPR2 | 13DV-CAPITAL-10.mpg |                    |
And should see for active order item on cover flow following data:
| Title               | Clock Number | Cover Title         | Aspect Ratio |Duration|
| 13DV-CAPITAL-10.mpg |  AssetCN2     | 13DV-CAPITAL-10.mpg | 16:9         |8s|

Scenario: Check that after changing market data isn't changed under Add Information section and on cover flow (retrieved from Library case for QC asset)
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVCSDCMA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVCSDCMU1 | agency.admin | OTVCSDCMA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCSDCMA1':
| Advertiser  | Brand       | Sub Brand   | Product    |
| OTVCSDCMAR2 | OTVCSDCMBR3 | OTVCSDCMSB3 | OTVCSDCMP3 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCSDCMA1'
And logged in with details of 'OTVCSDCMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVCSDCMAR2 | OTVCSDCMBR3 | OTVCSDCMSB3 | OTVCSDCMP3 | OTVCSDCMC3 | OTVCSDCMCN3  | 20       | 10/14/2022     | HD 1080i 25fps | OTVCSDCMT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVCSDCMCN3' with following fields:
| Job Number  | PO Number   |
| OTVCSDCMJN3 | OTVCSDCMPN3 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And add to order for order item at Add media to your order form following qc assets 'OTVCSDCMT3'
And select following market 'Republic of Ireland' on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Campaign   | Clock Number | Duration | First Air Date | Format      | Product    | Title      | Subtitles Required |
|                        | OTVCSDCMAR2 | OTVCSDCMC3 | OTVCSDCMCN3  | 20       | 10/14/2022     | SD PAL 16x9 | OTVCSDCMP3 | OTVCSDCMT3 | Already Supplied   |
And should see for active order item on cover flow following data:
| Title      | Duration | Clock Number |
| OTVCSDCMT3 | 20       | OTVCSDCMCN3  |