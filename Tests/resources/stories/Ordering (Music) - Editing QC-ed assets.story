!--ORD-1537
Feature: Editing QC-ed assets
Narrative:
In order to:
As a AgencyAdmin
I want to check editing qc-ed assets

Scenario: Media sub-tupe shows type QC-ed master automatically for QC assets for music
!--ORD-739
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name     | A4User         |
| OMEQCAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| OMEQCAU1 | agency.admin | OMEQCAA1      |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMEQCAA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMEQCAAR1  | OMEQCABR1 | OMEQCASB1 | OMEQCAP1 |
And logged in with details of 'OMEQCAU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code | Release Date | Format         | Title    | Destination                 |
| automated test info    | OMEQCAAR1      | OMEQCABR1 | OMEQCASB1 | OMEQCAP1 | OMEQCAC1 | OMEQCACN1 | 08/14/2022   | HD 1080i 25fps | OMEQCAT1 | GEO News:Standard |
And complete order contains item with isrc code 'OMEQCACN1' with following fields:
| Job Number | PO Number |
| OMEQCAJN1  | OMEQCAPN1 |
And I am on asset 'OMEQCAT1' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue   |
| Media sub-type | QC-ed master |


Scenario: For QC assents should be locked following fields Media sub-type, Clock number, Duration for music
Meta: @ordering
      @obug
!--UIR-987
Given I created the following agency:
| Name    | A4User        |
| OMEQCAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| OMEQCAU1 | agency.admin | OMEQCAA1      |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMEQCAA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMEQCAAR1  | OMEQCABR2 | OMEQCASB2 | OMEQCAP2 |
And logged in with details of 'OMEQCAU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code | Release Date | Format         | Title    | Destination                 |
| automated test info    | OMEQCAAR1      | OMEQCABR2 | OMEQCASB2 | OMEQCAP2 | OMEQCAC2 | OMEQCACN2 | 08/14/2022   | HD 1080i 25fps | OMEQCAT2 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'OMEQCACN2' with following fields:
| Job Number | PO Number |
| OMEQCAJN2  | OMEQCAPN2 |
And I am on asset 'OMEQCAT2' info page in Library for collection 'My Assets'NEWLIB
When I click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields disabled on edit asset popup NEWLIB:
| SectionName |FieldName       |
| Technical   |Media type      |
| Technical   |Media sub-type   |
And 'should' see following fields 'Clock number,Duration' in 'locked' state on opened Edit asset popup

Scenario: Children fields of Advertiser for QC assets in A5 Library should be editable for music
!--ORD-1406
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMEQCAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| OMEQCAU1 | agency.admin | OMEQCAA1      |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMEQCAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OMEQCAAR1  | OMEQCABR3 | OMEQCASB3 | OMEQCAPR3 |
And logged in with details of 'OMEQCAU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label     | Artist   | ISRC Code | First Air Date | Format         | Title    | Destination                 |
| automated test info    | OMEQCAAR1      | OMEQCABR3 | OMEQCASB3 | OMEQCAPR3 | OMEQCAC3 | OMEQCACN3 | 08/14/2022     | HD 1080i 25fps | OMEQCAT3 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'OMEQCACN3' with following fields:
| Job Number | PO Number |
| OMEQCAJN3  | OMEQCAPN3 |
When I 'save' asset 'OMEQCAT3' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue |
| Brand        | OMEQCABR3  |
| Sub Brand    | OMEQCASB3  |
| Product      | OMEQCAPR3  |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
| Advertiser   | OMEQCAAR1  |
| Brand        | OMEQCABR3  |
| Sub Brand    | OMEQCASB3  |
| Product      | OMEQCAPR3  |

