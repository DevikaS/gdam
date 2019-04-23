!--ORD-287
!--ORD-2878
Feature: Ability to autogenerate clocks with AdCode
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of autogenerating clocks with AdCode

Scenario: Check that Auto Code is autogenerating for file in Project
!--ORD-4450
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAA10 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAU10 | agency.admin | AACAA10      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAA10':
| Advertiser | Brand    | Sub Brand | Product  |
| ARAACA10   | BRAACA10 | SBAACA10  | PRAACA10 |
And update custom code 'Clock number' of schema 'video' agency 'AACAA10' by following fields:
| Name     | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACACC10 | 9                 | _         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Duration:2 | should  |
And logged in with details of 'AACAU10'
And created 'AACAP10' project
And created '/AACAF10' folder for project 'AACAP10'
And uploaded into project 'AACAP10' following files:
| FileName             | Path     |
| /files/Fish1-Ad.mov  | /AACAF10 |
And waited while transcoding is finished in folder '/AACAF10' on project 'AACAP10' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/AACAF10' project 'AACAP10'
When I click Edit link on file info page
And fill Edit file popup with following information:
| FieldName    | FieldValue |
| Advertiser   | ARAACA10   |
| Brand        | BRAACA10   |
| Sub Brand    | SBAACA10   |
| Product      | PRAACA10   |
| Duration     | 20         |
And generate auto code value for field 'Clock number' in section 'Admin Information' on opened Edit File popup
Then I should see following auto generated code '\d{2,9}_ARBRSBPR20' for field 'Clock number' in section 'Admin Information' on opened Edit File popup

Scenario: Check that Auto button for Clock Number is locked for QC Asset in Library
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU1 | agency.admin | AACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAA1':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACA3    | BRAACA3 | SBAACA3   | PRAACA3 |
And update custom code 'Clock number' of schema 'video' agency 'AACAA1' by following fields:
| Name     | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACACC11 | 2                 | /         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Duration:2 | should  |
And logged in with details of 'AACAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | ARAACA3    | BRAACA3 | SBAACA3   | PRAACA3 | AACAC11  | AACACN11     | 20       | 10/14/2022     | HD 1080i 25fps | AACAT11 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'AACACN11' with following fields:
| Job Number | PO Number |
| AACAJN11   | AACAPN11  |
And I am on asset 'AACAT11' info page in Library for collection 'My Assets'
When I click Edit link on asset info page
Then I should see 'inactive' Auto code button on opened Edit Asset popup

Scenario: check that data is not duplicated in Metadata Names each time after saving
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAA12 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAU12 | agency.admin | AACAA12      |
And logged in with details of 'AACAU12'
And I am on the global 'video asset' metadata page for agency 'AACAA12'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                                                         | Metadata Characters |
| AACACC12  | 3                   | should            | Advertiser,Brand,Sub Brand,Product,Campaign,Duration,Title,Media type | 2,2,2,2,2,2,2,2     |
And save metadata field settings
And click 'Clock number' button in 'Editable Metadata' section on opened metadata page
And 'edit' custom code 'AACACC12' on AdCode Manager form of metadata page
And save metadata field settings
And click 'Clock number' button in 'Editable Metadata' section on opened metadata page
And 'edit' custom code 'AACACC12' on AdCode Manager form of metadata page
Then I 'should' see available following metadata names 'Advertiser,Brand,Sub Brand,Product,Campaign,Duration,Title,Media type' for custom code on AdCode Manager form of metadata page
And should see count '8' metadata names for custom code on AdCode Manager form of metadata page

Scenario: Check the order for fields in Custom Code format panel after saving
Meta: @ordering
!--NGN-18611 Sequential number unchecked by default
Given I created the following agency:
| Name    | A4User        |
| AACAA13 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAU13 | agency.admin | AACAA13      |
And logged in with details of 'AACAU13'
And I am on the global 'video asset' metadata page for agency 'AACAA13'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name                               | Metadata Characters | Free Text | Separator |
| AACACC13  | should | MMDDYYYY    | 3                   | should            | Advertiser,Brand,Sub Brand,Product,Duration | 2,2,2,2,2           | should    | /,-       |
And save metadata field settings
And click 'Clock number' button in 'Editable Metadata' section on opened metadata page
Then I should see following data for custom code 'AACACC13' on AdCode Manager form of metadata page:
| Custom Code Format                                             |
| Sequential NumberDateAdvertiserBrandSub BrandProductDuration/- |

Scenario: Check that Auto button is locked for QC asset on order item page
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU1 | agency.admin | AACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAA1':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACA3    | BRAACA3 | SBAACA3   | PRAACA3 |
And update custom code 'Clock number' of schema 'video' agency 'AACAA1' by following fields:
| Name     | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACACC14 | 2                 | /         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Duration:2 | should  |
And logged in with details of 'AACAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | ARAACA3    | BRAACA3 | SBAACA3   | PRAACA3 | AACAC14  | AACACN14_1   | 20       | 10/14/2022     | HD 1080i 25fps | AACAT14 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| AACACN14_2   |
And complete order contains item with clock number 'AACACN14_1' with following fields:
| Job Number | PO Number |
| AACAJN14   | AACAPN14  |
And add to 'tv' order item with clock number 'AACACN14_2' following qc asset 'AACAT14' of collection 'My Assets'
When I open order item with clock number 'AACACN14_1' for order with market 'Republic of Ireland'
Then I should see 'inactive' Auto code button on Add information form of order item page

Scenario: chech that advertiser hierarchy is not shown in Metadata Elements if nothing is marked as Advertiser and Product
!--ORD-4919
!--ORD-4962
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Mark as Advertiser | Mark as Product | Mark as Campaign |
| AACAA15 | DefaultA4User |                    |                 |                  |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAU15 | agency.admin | AACAA15      |
And logged in with details of 'AACAU15'
And I am on the global 'video asset' metadata page for agency 'AACAA15'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I create new custom code on AdCode Manager form of metadata page
Then I 'should' see available following metadata names 'Media type,Duration,Title' for custom code on AdCode Manager form of metadata page
And should see count '3' metadata names for custom code on AdCode Manager form of metadata page

Scenario: Check order of Sequantial Number on Custom Code format after changing number of characters
!--NGN-18611 Sequential number unchecked by default
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAA16 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAU16 | agency.admin | AACAA16      |
And logged in with details of 'AACAU16'
And I am on the global 'video asset' metadata page for agency 'AACAA16'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name                               | Metadata Characters | Free Text | Separator |
| AACACC16  | should | MMDDYYYY    | 3                   | should            | Advertiser,Brand,Sub Brand,Product,Duration | 2,2,2,2,2           | should    | /,-       |
And save metadata field settings
And click 'Clock number' button in 'Editable Metadata' section on opened metadata page
And 'edit' custom code 'AACACC16' on AdCode Manager form of metadata page
And fill following fields for 'existing' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters |
| AACACC16  | 4                   |
Then I should see following data for custom code 'AACACC16' on AdCode Manager form of metadata page:
| Custom Code Format                                             |
| Sequential NumberDateAdvertiserBrandSub BrandProductDuration/- |

Scenario: check deletion an option of Metadata Elements
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU1 | agency.admin | AACAA1       |
And update custom code 'Clock number' of schema 'video' agency 'AACAA1' by following fields:
| Name     | Sequential Number | Metadata Elements                                     | Enabled |
| AACACC17 | 2                 | Advertiser:2,Brand:3,Sub Brand:2,Product:3,Duration:2 | should  |
And logged in with details of 'AACAU1'
And I am on the global 'video asset' metadata page for agency 'AACAA1'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I 'edit' custom code 'AACACC17' on AdCode Manager form of metadata page
And delete metadata element with following name 'Advertiser' and characters '2' for custom code on AdCode Manager form of metadata page
Then I should see following data for custom code 'AACACC17' on AdCode Manager form of metadata page:
| Metadata Name                    | Metadata Characters |
| Brand,Sub Brand,Product,Duration | 3,2,3,2             |
And should see metadata elements for custom code on following positions on AdCode Manager form of metadata page:
| Metadata Name | Metadata Characters | Position |
| Brand         | 3                   | 1        |
| Sub Brand     | 2                   | 2        |
| Product       | 3                   | 3        |
| Duration      | 2                   | 4        |

Scenario: check deletion an option of Free Text elements
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU1 | agency.admin | AACAA1       |
And update custom code 'Clock number' of schema 'video' agency 'AACAA1' by following fields:
| Name     | Sequential Number | Free Text | Enabled |
| AACACC18 | 2                 | /;#;-     | should  |
And logged in with details of 'AACAU1'
And I am on the global 'video asset' metadata page for agency 'AACAA1'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I 'edit' custom code 'AACACC18' on AdCode Manager form of metadata page
And delete following free text '/' for custom code on AdCode Manager form of metadata page
Then I should see following data for custom code 'AACACC18' on AdCode Manager form of metadata page:
| Separator |
| #,-       |
And should see free text for custom code on following positions on AdCode Manager form of metadata page:
| Separator | Position |
| #         | 1        |
| -         | 2        |

Scenario: check deletion of Custom code on Adcode Manager form
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAA19 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAU19 | agency.admin | AACAA19      |
And update custom code 'Clock number' of schema 'video' agency 'AACAA19' by following fields:
| Name       | Date Format | Sequential Number | Free Text | Metadata Elements | Enabled |
| AACACC19_1 | DDMMYYYY    | 4                 | /         | Advertiser:3      | should  |
And logged in with details of 'AACAU19'
And I am on the global 'video asset' metadata page for agency 'AACAA19'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name  | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name    | Metadata Characters | Free Text | Separator |
| AACACC19_2 | should | MMDDYYYY    | 3                   | should            | Advertiser,Brand | 3,2                 | should    | /,-       |
And save metadata field settings
And click 'Clock number' button in 'Editable Metadata' section on opened metadata page
And 'delete' custom code 'AACACC19_2' on AdCode Manager form of metadata page
Then I 'should not' see following custom code 'AACACC19_2' on AdCode Manager form of metadata page