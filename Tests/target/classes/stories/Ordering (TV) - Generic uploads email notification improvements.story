!--ORD-3003
!--ORD-3013
Feature: Generics Upload email improvments
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of Generics Upload email notification improvements

Scenario: Check that correct Generic Upload email notification is sent in case if BU label is Beam_AMV
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        | Labels   |
| GUENA1 | DefaultA4User | Beam_AMV |
And created users with following fields:
| Email  | Role         | AgencyUnique | Language |
| GUENU1 | agency.admin | GUENA1       | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GUENA1':
| Advertiser | Brand   | Sub Brand | Product |
| GUENAR1    | GUENBR1 | GUENSB1   | GUENPR1 |
And logged in with details of 'GUENU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | GUENAR1    | GUENBR1 | GUENSB1   | GUENPR1 | GUENC1   | GUENCN1      | 20       | 10/14/2022     | HD 1080i 25fps | GUENT1 | Already Supplied   | BSkyB Green Button:Standard |
And create additional destinations with following fields:
| Type     | Email            |
| Generics | Generics_email_1 |
And create for 'tv' order with item clock number 'GUENCN1' additional services with following fields:
| Type            | Destination      | Format         | Specification | Media Compile | No copies  | Delivery Details | Notes & Labels       | Standard |
| Generics Upload | Generics_email_1 | Master Toolkit | As required   | Compile 1     | 1          | Generics_email_1 | automated test notes | should   |
And complete order contains item with clock number 'GUENCN1' with following fields:
| Job Number | PO Number |
| GUENJN1    | GUENPN1   |
Then 'should' see email notification for 'Generics Upload' with field to 'Generics_email_1' and subject 'You have just completed a UK version for' contains following attributes:
| Clock Number | Agency | Account Type |
| GUENCN1      | GUENA1 | beam amv     |

Scenario: Check that correct Generic Upload email notification is sent in case if BU label isn't Beam and user locale isn't Beam
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        |
| GUENA2 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GUENU2 | agency.admin | GUENA2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GUENA2':
| Advertiser | Brand   | Sub Brand | Product |
| GUENAR2    | GUENBR2 | GUENSB2   | GUENPR2 |
And logged in with details of 'GUENU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | GUENAR2    | GUENBR2 | GUENSB2   | GUENPR2 | GUENC2   | GUENCN2      | 20       | 10/14/2022     | HD 1080i 25fps | GUENT2 | Already Supplied   | BSkyB Green Button:Standard |
And create additional destinations with following fields:
| Type     | Email            |
| Generics | Generics_email_2 |
And create for 'tv' order with item clock number 'GUENCN2' additional services with following fields:
| Type            | Destination      | Format         | Specification | Media Compile | No copies  | Delivery Details | Notes & Labels       | Standard |
| Generics Upload | Generics_email_2 | Master Toolkit | As required   | Compile 1     | 1          | Generics_email_2 | automated test notes | should   |
And complete order contains item with clock number 'GUENCN2' with following fields:
| Job Number | PO Number |
| GUENJN2    | GUENPN2   |
Then 'should' see email notification for 'Generics Upload' with field to 'Generics_email_2' and subject 'You have just completed an order for' contains following attributes:
| Clock Number | Agency | Account Type |
| GUENCN2      | GUENA2 | adstream     |