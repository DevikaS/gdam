!--ORD-1440
Feature: Editing QC-ed asets
Narrative:
In order to:
As a AgencyAdmin
I want to check editing qc-ed asets

Scenario: Media sub-tupe shows type QC-ed master automatically for QC assets
!--ORD-739
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| EQCAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |Access|
| EQCAU1 | agency.admin | EQCAA1       |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'EQCAA1':
| Advertiser | Brand   | Sub Brand | Product |
| EQCAAR1    | EQCABR1 | EQCASB1   | EQCAP1  |
And logged in with details of 'EQCAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | EQCAAR1    | EQCABR1 | EQCASB1   | EQCAP1  | EQCAC1   | EQCACN1      | 20       | 08/14/2022     | HD 1080i 25fps | EQCAT1 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'EQCACN1' with following fields:
| Job Number | PO Number |
| EQCAJN1    | EQCAPN1   |
And I am on asset 'EQCAT1' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue   |
| Media sub-type | QC-ed master |


Scenario: For QC assents should be locked following fields Media sub-type, Clock number, Duration
Meta: @ordering
      @obug
!--UIR-987
Given I created the following agency:
| Name   | A4User        |
| EQCAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |Access|
| EQCAU1 | agency.admin | EQCAA1       |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'EQCAA1':
| Advertiser | Brand   | Sub Brand | Product |
| EQCAAR1    | EQCABR2 | EQCASB2   | EQCAP2  |
And logged in with details of 'EQCAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | EQCAAR1    | EQCABR2 | EQCASB2   | EQCAP2  | EQCAC2   | EQCACN2      | 20       | 08/14/2022     | HD 1080i 25fps | EQCAT2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'EQCACN2' with following fields:
| Job Number | PO Number |
| EQCAJN2    | EQCAPN2   |
And I am on asset 'EQCAT2' info page in Library for collection 'My Assets'NEWLIB
When I click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields disabled on edit asset popup NEWLIB:
| SectionName |FieldName       |
| Technical   |Media type      |
| Technical   |Media sub-type   |
And 'should' see following fields 'Clock number,Duration' in 'locked' state on opened Edit asset popup

Scenario: Children fields of Advertiser for QC assets in A5 Library should be editable
!--ORD-1406
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| EQCAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |Access|
| EQCAU1 | agency.admin | EQCAA1       |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'EQCAA1':
| Advertiser | Brand   | Sub Brand | Product |
| EQCAAR1    | EQCABR3 | EQCASB3   | EQCAPR3 |
And logged in with details of 'EQCAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | EQCAAR1    | EQCABR3 | EQCASB3   | EQCAPR3 | EQCAC3   | EQCACN3      | 20       | 08/14/2022     | HD 1080i 25fps | EQCAT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'EQCACN3' with following fields:
| Job Number | PO Number |
| EQCAJN3    | EQCAPN3   |
When I 'save' asset 'EQCAT3' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue |
| Brand        | EQCABR3    |
| Sub Brand    | EQCASB3    |
| Product      | EQCAPR3    |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
| Advertiser   | EQCAAR1    |
| Brand        | EQCABR3    |
| Sub Brand    | EQCASB3    |
| Product      | EQCAPR3    |