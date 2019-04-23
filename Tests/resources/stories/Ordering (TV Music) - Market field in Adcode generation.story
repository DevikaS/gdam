!--ORD-3036
!--ORD-3205
Feature: Check market field in Adcode generation
Narrative:
In order to:
As a AgencyAdmin
I want to check market field in Adcode generation

Scenario: check correct confirming order after generating auto code with Market rule
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MFAGA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MFAGU1 | agency.admin | MFAGA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MFAGA1':
| Advertiser | Brand   | Sub Brand | Product |
| ARMFAG1    | BRMFAG1 | SBMFAG1   | PRMFAG1 |
And update custom code 'Clock number' of schema 'video' agency 'MFAGA1' by following fields:
| Name    | Market              | Date Format | Sequential Number | Free Text | Metadata Elements                | Enabled |
| MFAGCC1 | United Kingdom      | MMDDYYYY    | 4                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2 | should  |
And logged in with details of 'MFAGU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ARMFAG1    | BRMFAG1 | SBMFAG1   | PRMFAG1 | MFAGC1   | 20       | 10/14/2022     | HD 1080i 25fps | MFAGT1 | Already Supplied   | Aastha:Standard |
When I open order item with next title 'MFAGT1'
And generate 'auto code' value for Add information form on order item page
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MFAGJN1    | MFAGPN1   |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item title 'MFAGT1' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ARMFAG1    | BRMFAG1 | SBMFAG1   | PRMFAG1 | United Kingdom | MFAGPN1   | MFAGJN1 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains item title 'MFAGT1' and items with following fields:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration | Status        |
| AutoCode     | ARMFAG1    | PRMFAG1 | MFAGT1 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: check showing adcodes on Select from existing formats popup on order item page relating to Market rule
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MFAGA2 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MFAGU2 | agency.admin | MFAGA2       |
And update custom code 'Clock number' of schema 'video' agency 'MFAGA2' by following fields:
| Name      | Market              | Date Format | Sequential Number | Free Text | Metadata Elements                | Enabled |
| MFAGCC2_1 | United Kingdom      | DDMMYYYY    | 4                 | /         | Advertiser:3                     | should  |
| MFAGCC2_2 | United Kingdom      | DDMMYYYY    | 3                 | -         | Advertiser:3,Brand:2             | should  |
| MFAGCC2_3 | Republic of Ireland | MMDDYYYY    | 2                 | /;-       | Advertiser:3,Brand:2,Sub Brand:3 | should  |
And logged in with details of 'MFAGU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Title  |
| MFAGT2 |
When I open order item with next title 'MFAGT2'
Then I 'should' see following custom code 'MFAGCC2_1,MFAGCC2_2' on Select from existing formats popup of Add information form

Scenario: check generated autocode with Market rule after changing market
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MFAGA3 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MFAGU3 | agency.admin | MFAGA3       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MFAGA3':
| Advertiser | Brand   | Sub Brand | Product |
| ARMFAG3    | BRMFAG3 | SBMFAG3   | PRMFAG3 |
And update custom code 'Clock number' of schema 'video' agency 'MFAGA3' by following fields:
| Name      | Market              | Sequential Number | Free Text | Metadata Elements               | Enabled |
| MFAGCC3_1 | United Kingdom      | 4                 | /         | Advertiser:3,Brand:2            | should  |
| MFAGCC3_2 | Republic of Ireland | 5                 | /;-       | Advertiser:2,Brand:2,Duration:2 | should  |
And logged in with details of 'MFAGU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand   | Sub Brand | Product | Duration | Title  |
| ARMFAG3    | BRMFAG3 | SBMFAG3   | PRMFAG3 | 20       | MFAGT3 |
When I open order item with next title 'MFAGT3'
And generate 'auto code' value for Add information form on order item page
And select following market 'Republic of Ireland' on order item page
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,5}/-ARBR20' for field 'Clock Number' on Add information form of order item page

Scenario: check generated autocode with defferent Market rule for one custom code
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MFAGA4 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MFAGU4 | agency.admin | MFAGA4       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MFAGA4':
| Advertiser | Brand   | Sub Brand | Product |
| ARMFAG4    | BRMFAG4 | SBMFAG4   | PRMFAG4 |
And update custom code 'Clock number' of schema 'video' agency 'MFAGA4' by following fields:
| Name      | Market                             | Sequential Number | Free Text | Metadata Elements               | Enabled |
| MFAGCC4_1 | United Kingdom                     | 5                 | /         | Advertiser:3                    | should  |
| MFAGCC4_2 | United Kingdom,Republic of Ireland | 6                 | /;-       | Advertiser:2,Brand:3,Duration:2 | should  |
And logged in with details of 'MFAGU4'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Advertiser | Brand   | Sub Brand | Product | Duration | Title  |
| ARMFAG4    | BRMFAG4 | SBMFAG4   | PRMFAG4 | 20       | MFAGT4 |
When I open order item with next title 'MFAGT4'
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,6}/-ARBRM20' for field 'Clock Number' on Add information form of order item page

Scenario: check saving several markets for custom code
Meta: @ordering
!--NGN-18611 Sequential number unchecked by default
Given I created the following agency:
| Name   | A4User        |
| MFAGA5 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MFAGU5 | agency.admin | MFAGA5       |
And logged in with details of 'MFAGU5'
And I am on the global 'video asset' metadata page for agency 'MFAGA5'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Market                             | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name                      | Metadata Characters | Free Text | Separator |
| MFAGCC5   | United Kingdom,Republic of Ireland | should | MMDDYYYY    | 4                   | should            | Advertiser,Brand,Sub Brand,Product | 3,2,2,3             | should    | /,-       |
And saved metadata field settings
When I click 'Clock number' button in 'Editable Metadata' section on opened metadata page
Then I should see following data for custom code 'MFAGCC5' on AdCode Manager form of metadata page:
| Code Name | Market                             | Preview                  | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name                      | Metadata Characters | Free Text | Separator |
| MFAGCC5   | United Kingdom,Republic of Ireland | SSSSMMDDYYYYAAABBSSPPP/- | should | MMDDYYYY    | 4                   | should            | Advertiser,Brand,Sub Brand,Product | 3,2,2,3             | should    | /,-       |

Scenario: check absence of Select from existing formats popup on order item page for custom code with several markets
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MFAGA6 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MFAGU6 | agency.admin | MFAGA6       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MFAGA6':
| Advertiser | Brand   | Sub Brand | Product |
| ARMFAG6    | BRMFAG6 | SBMFAG6   | PRMFAG6 |
And update custom code 'Clock number' of schema 'video' agency 'MFAGA6' by following fields:
| Name    | Market                             | Sequential Number | Free Text | Metadata Elements                          | Enabled |
| MFAGCC6 | United Kingdom,Republic of Ireland | 4                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Product:3 | should  |
And logged in with details of 'MFAGU6'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand   | Sub Brand | Product | Title  |
| ARMFAG6    | BRMFAG6 | SBMFAG6   | PRMFAG6 | MFAGT6 |
When I open order item with next title 'MFAGT6'
And generate 'auto code' value for Add information form on order item page
Then I 'should not' see Select from existing formats popup on Add information form of order item page