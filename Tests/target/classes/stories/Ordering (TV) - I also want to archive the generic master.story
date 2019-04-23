!--ORD-331
!--ORD-2317
Feature: Generics Upload media type and email notification for this action
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of Generics Upload media type and email notification for this action

Scenario: Check that correct default data is specified in case to select Generics Upload media type
Meta: @ordering
Given I created the following agency:
| Name  | A4User        | Labels |
| AGMA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email | Role         | AgencyUnique | Language |
| AGMU1 | agency.admin | AGMA1        | en-beam  |
And logged in with details of 'AGMU1'
And create additional destinations with following fields:
| Type     | Email            |
| Generics | Generics_email_1 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| AGMCN1       |
When open order item with following clock number 'AGMCN1'
And fill following fields for Additional Services section on order item page:
| Type            | Destination      |
| Generics Upload | Generics_email_1 |
Then I should see following data for order item on Additional Services section:
| Type            | Destination      | Format         | Specification  | No copies  | Delivery Details |
| Generics Upload | Generics_email_1 | Master Toolkit | As required    | 1          | Generics_email_1 |

Scenario: Check that correct email notification is sent in case create order with Generics Upload media type
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name  | A4User        | Labels |
| AGMA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email | Role         | AgencyUnique | Language |
| AGMU1 | agency.admin | AGMA1        | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AGMA1':
| Advertiser | Brand  | Sub Brand | Product |
| AGMAR2     | AGMBR2 | AGMSB2    | AGMPR2  |
And logged in with details of 'AGMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | AGMAR2     | AGMBR2 | AGMSB2    | AGMPR2  | AGMC2    | AGMCN2       | 20       | 10/14/2022     | HD 1080i 25fps | AGMT2 | Already Supplied   | BSkyB Green Button:Standard |
And create additional destinations with following fields:
| Type     | Email            |
| Generics | Generics_email_2 |
And create for 'tv' order with item clock number 'AGMCN2' additional services with following fields:
| Type            | Destination      | Format         | Specification | Media Compile | No copies  | Delivery Details | Notes & Labels       | Standard |
| Generics Upload | Generics_email_2 | Master Toolkit | As required   | Compile 1     | 1          | Generics_email_2 | automated test notes | should   |
And complete order contains item with clock number 'AGMCN2' with following fields:
| Job Number | PO Number |
| AGMJN2     | AGMPN2    |
Then 'should' see email notification for 'Generics Upload' with field to 'Generics_email_2' and subject 'You have just completed an order for' contains following attributes:
| Clock Number | Agency | Account Type |
| AGMCN2       | AGMA1  | beam         |

Scenario: Check that correct email notification is sent in case checking of email From adress
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name  | A4User        | Labels | EmailFrom |
| AGMA3 | DefaultA4User | Beam   | AGMU3     |
And created users with following fields:
| Email | Role         | AgencyUnique | Language |
| AGMU3 | agency.admin | AGMA3        | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AGMA3':
| Advertiser | Brand  | Sub Brand | Product |
| AGMAR3     | AGMBR3 | AGMSB3    | AGMPR3  |
And logged in with details of 'AGMU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | AGMAR3     | AGMBR3 | AGMSB3    | AGMPR3  | AGMC3    | AGMCN3       | 20       | 10/14/2022     | HD 1080i 25fps | AGMT3 | Already Supplied   | BSkyB Green Button:Standard |
And create additional destinations with following fields:
| Type     | Email            |
| Generics | Generics_email_3 |
And create for 'tv' order with item clock number 'AGMCN3' additional services with following fields:
| Type            | Destination      | Format         | Specification | Media Compile | No copies  | Delivery Details | Notes & Labels       | Standard |
| Generics Upload | Generics_email_3 | Master Toolkit | As required   | Compile 1     | 1          | Generics_email_3 | automated test notes | should   |
And I am on system branding page
And clicked save on the system branding page
And complete order contains item with clock number 'AGMCN3' with following fields:
| Job Number | PO Number |
| AGMJN3     | AGMPN3    |
Then 'should' see email notification for 'Generics Upload' with field to 'Generics_email_3' and subject 'You have just completed an order for' contains following attributes:
| Clock Number | Agency | Account Type | EmailFrom |
| AGMCN3       | AGMA3  | beam         | AGMU3     |