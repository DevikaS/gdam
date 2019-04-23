!--ORD-5233
!--ORD-5261
!--ORD-5415
Feature: Show two more fields Brand and Model fields if choose Watermarking Yes in Spain market
Narrative:
In order to:
As a AgencyAdmin
I want to check that two fields Brand and Model fields are shown if choose Watermarking Yes in Spain market

Scenario: Check saving new Watermarking Required fields after filling
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SMFFSWA1 | DefaultA4User |
And created 'SMFFSWR1' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'SMFFSWA1'
And created users with following fields:
| Email    | Role     | AgencyUnique |
| SMFFSWU1 | SMFFSWR1 | SMFFSWA1     |
And logged in with details of 'SMFFSWU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number |
| SMFFSWCN1    |
When I open order item with following clock number 'SMFFSWCN1'
And fill following fields for Add information form on order item page:
| Watermarking Required | Watermarking Code | Watermarking Brand | Product Description | Model    | Creative Description |
| Yes                   | SMFFSWWC1         | SMFFSWWB1          | SMFFSWPD1           | SMFFSWM1 | SMFFSWCD1            |
And save as draft order
And open order item with following clock number 'SMFFSWCN1'
Then I should see following data for order item on Add information form:
| Watermarking Required | Watermarking Code | Watermarking Brand | Product Description | Model    | Creative Description |
| Yes                   | SMFFSWWC1         | SMFFSWWB1          | SMFFSWPD1           | SMFFSWM1 | SMFFSWCD1            |
And should see that metadata fields in following order 'Producto WM,Sector,Group,Language,Clave,Media Agency Contact,Creative Agency Contact,Watermarking Required,Watermarking Code,Brand,Model,Product Description,Creative Description,Subtitles Required' for order item on Add information form

Scenario: Check that Watermarking Code Brand Model fields are hidden after clear Add Information section section
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SMFFSWA1 | DefaultA4User |
And created 'SMFFSWR1' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'SMFFSWA1'
And created users with following fields:
| Email    | Role     | AgencyUnique |
| SMFFSWU1 | SMFFSWR1 | SMFFSWA1     |
And logged in with details of 'SMFFSWU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Watermarking Required | Watermarking Code | Watermarking Brand | Model    |
| SMFFSWCN2    | Yes                   | SMFFSWWC2         | SMFFSWWB2          | SMFFSWM2 |
When I open order item with following clock number 'SMFFSWCN2'
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Watermarking Required |
| No                    |

Scenario: Check that Watermarking Required fields are corectly shown on report
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SMFFSWA1 | DefaultA4User |
And created 'SMFFSWR1' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'SMFFSWA1'
And created users with following fields:
| Email    | Role     | AgencyUnique |
| SMFFSWU1 | SMFFSWR1 | SMFFSWA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SMFFSWA1':
| Advertiser | Brand     | Sub Brand | Product  |
| SMFFSWAR3  | SMFFSWBR3 | SMFFSWSB3 | SMFFSWP3 |
And logged in with details of 'SMFFSWU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Clave     | Watermarking Required | Watermarking Code | Watermarking Brand | Model    | Product Description | Creative Description | Sector | Group                | Watermarking Product | Destination           |
| automated test info    | SMFFSWAR3  | SMFFSWBR3 | SMFFSWSB3 | SMFFSWP3 | SMFFSWC3 | SMFFSWCN3    | 20       | 10/14/2022     | HD 1080i 25fps | SMFFSWT3 | Yes                | SMFFSWCL3 | Yes                   | SMFFSWWC3         | SMFFSWWB3          | SMFFSWM3 | SMFFSWPD3           | SMFFSWCD3            | HOGAR  | PRODUCTOS INFANTILES | CUNAS                | Barcelona TV:Standard |
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country | Advertiser | Brand     | Sub Brand | Product  | Title    | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Clave     | Watermarking Required | Watermarking Code | Watermarking Brand | Model    | Watermarking Product Description | Creative Description | Sector | Group                | Watermarking Product | Delivery Points | Destination Group | Destination  | Service Level |
| SMFFSWCN3    |            |           | 1                 | 1                 | Spain   | SMFFSWAR3  | SMFFSWBR3 | SMFFSWSB3 | SMFFSWP3 | SMFFSWT3 | HD 1080i 25fps |                 |               | 10/14/2022     | No      | automated test info |             | Yes                | SMFFSWCL3 | Yes                   | SMFFSWWC3         | SMFFSWWB3          | SMFFSWM3 | SMFFSWPD3                        | SMFFSWCD3            | HOGAR  | PRODUCTOS INFANTILES | CUNAS                | 1               | Spain             | Barcelona TV | Standard      |


Scenario: Check that new Watermarking Required fields are correct on asset details in Library
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SMFFSWA1 | DefaultA4User |
And created 'SMFFSWR1' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'SMFFSWA1'
And created users with following fields:
| Email    | Role     | AgencyUnique |Access|
| SMFFSWU1 | SMFFSWR1 | SMFFSWA1     |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SMFFSWA1':
| Advertiser | Brand     | Sub Brand | Product  |
| SMFFSWAR3  | SMFFSWBR3 | SMFFSWSB3 | SMFFSWP3 |
And logged in with details of 'SMFFSWU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Clave     | Watermarking Required | Watermarking Code | Watermarking Brand | Model    | Destination           |
| automated test info    | SMFFSWAR3  | SMFFSWBR3 | SMFFSWSB3 | SMFFSWP3 | SMFFSWC4 | SMFFSWCN4    | 20       | 10/14/2022     | HD 1080i 25fps | SMFFSWT4 | Yes                | SMFFSWCL4 | Yes                   | SMFFSWWC4         | SMFFSWWB4          | SMFFSWM4 | Barcelona TV:Standard |
And complete order contains item with clock number 'SMFFSWCN4' with following fields:
| Job Number | PO Number |
| SMFFSWJN4  | SMFFSWPN4 |
And I am on asset 'SMFFSWT4' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName             | FieldValue |
| Watermarking Required | Yes        |
| Watermarking Code     | SMFFSWWC4  |
| Model                 | SMFFSWM4   |

Scenario: Check generating of Watermarking Code
Meta: @ordering
!--NGN-18611 Sequential number unchecked by default
Given I created the following agency:
| Name     | A4User        |
| SMFFSWA5 | DefaultA4User |
And created 'SMFFSWR5' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'SMFFSWA5'
And created users with following fields:
| Email    | Role     | AgencyUnique |
| SMFFSWU5 | SMFFSWR5 | SMFFSWA5     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SMFFSWA5':
| Advertiser |
| ARSMFFSW5  |
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'Spain' for agency 'SMFFSWA5'
And set default value 'Yes' for multi choice field 'Watermarking Required' in section 'editable metadata' on Settings and Customization page
And clicked 'Watermarking Code' button in 'editable metadata' section on opened metadata page
And 'allow' special characters on AdCode Manager form of metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                    | Metadata Characters | Free Text | Separator |
| SMFFSWC5  | 5                   | should            | Advertiser,Watermarking Required | 3,2                 | should    | /         |
And saved metadata field settings
And logged in with details of 'SMFFSWU5'
And create 'tv' order with market 'Spain' and items with following fields:
| Advertiser | Clock Number | Watermarking Required |
| ARSMFFSW5  | SMFFSWCN5    | Yes                   |
When I open order item with following clock number 'SMFFSWCN5'
And generate 'watermarking code' value for Add information form on order item page
Then I should see following watermarking generated code '\d{2,5}ARSYE/' for field 'Watermarking Code' on Add information form of order item page

Scenario: Check that Watermarking Code is not copied to second order item
!--ORD-5415
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SMFFSWA6 | DefaultA4User |
And created 'SMFFSWR6' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'SMFFSWA6'
And created users with following fields:
| Email    | Role     | AgencyUnique |
| SMFFSWU6 | SMFFSWR6 | SMFFSWA6     |
And logged in with details of 'SMFFSWU6'
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Watermarking Required | Watermarking Code | Watermarking Brand | Model    |
| SMFFSWCN6    | Yes                   | SMFFSWWC6         | SMFFSWWB6          | SMFFSWM6 |
When I open order item with following clock number 'SMFFSWCN6'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data for order item on Add information form:
| Watermarking Required | Watermarking Code | Watermarking Brand | Model    |
| Yes                   |                   | SMFFSWWB6          | SMFFSWM6 |

Scenario: Check Watermarking Code generated is unique When Sequential Number is enabled
!--NGN-18949
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| SMFFSWA55 | DefaultA4User |
And created 'SMFFSWR55' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'SMFFSWA55'
And created users with following fields:
| Email     | Role      | AgencyUnique  |
| SMFFSWU55 | SMFFSWR55 | SMFFSWA55     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SMFFSWA55':
| Advertiser  |
| ARSMFFSW55  |
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'Spain' for agency 'SMFFSWA55'
And set default value 'Yes' for multi choice field 'Watermarking Required' in section 'editable metadata' on Settings and Customization page
And clicked 'Watermarking Code' button in 'editable metadata' section on opened metadata page
And 'allow' special characters on AdCode Manager form of metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name  | Sequence Characters | Metadata Elements | Metadata Name                    | Metadata Characters | Free Text | Separator |
| SMFFSWC55  | 5                   | should            | Advertiser,Watermarking Required | 3,2                 | should    | /         |
And saved metadata field settings
And logged in with details of 'SMFFSWU55'
And create 'tv' order with market 'Spain' and items with following fields:
| Advertiser  | Clock Number  | Watermarking Required |
| ARSMFFSW55  | SMFFSWCN55    | Yes                   |
When I open order item with following clock number 'SMFFSWCN55'
And generate 'watermarking code' value for Add information form on order item page
Then I should see following watermarking generated code '\d{2,5}ARSYE/' for field 'Watermarking Code' on Add information form of order item page
And I 'shouldnot' see generated watermarking code in field 'Watermarking Code' on the BackEnd