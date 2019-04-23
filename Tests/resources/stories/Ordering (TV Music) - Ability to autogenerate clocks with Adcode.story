!--ORD-287
!--ORD-2878
Feature: Ability to autogenerate clocks with AdCode
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of autogenerating clocks with AdCode

Scenario: check Preview for Custom Code
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU1 | agency.admin | AACAA1       |
And update custom code 'Clock number' of schema 'video' agency 'AACAA1' by following fields:
| Name    | Date Format | Sequential Number | Free Text | Metadata Elements | Enabled |
| AACACC1 | DDMMYYYY    | 4                 | /         | Advertiser:3      | should  |
And logged in with details of 'AACAU1'
And I am on the global 'video asset' metadata page for agency 'AACAA1'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
Then I should see following data for custom code 'AACACC1' on AdCode Manager form of metadata page:
| Preview          |
| DDMMYYYYSSSS/AAA |

Scenario: check saving data for custom code
Meta: @ordering
!--NGN-18611 Sequential number unchecked by default
Given I created the following agency:
| Name   | A4User        |
| AACAA2 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU2 | agency.admin | AACAA2       |
And logged in with details of 'AACAU2'
And I am on the global 'video asset' metadata page for agency 'AACAA2'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name    | Metadata Characters | Free Text | Separator |
| AACACC2   | should | MMDDYYYY    | 3                   | should            | Advertiser,Brand | 3,2                 | should    | /,-       |
And save metadata field settings
And click 'Clock number' button in 'Editable Metadata' section on opened metadata page
Then I should see following data for custom code 'AACACC2' on AdCode Manager form of metadata page:
| Code Name | Preview            | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name    | Metadata Characters | Free Text | Separator |
| AACACC2   | SSSMMDDYYYYAAABB/- | should | MMDDYYYY    | 3                   | should            | Advertiser,Brand | 3,2                 | should    | /,-       |

Scenario: check confirming order using Auto code
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
| Name    | Date Format | Sequential Number | Free Text | Metadata Elements | Enabled |
| AACACC3 | DDMMYYYY    | 10                | /         | Advertiser:3      | should  |
And logged in with details of 'AACAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ARAACA3    | BRAACA3 | SBAACA3   | PRAACA3 | AACAC3   | 20       | 10/14/2022     | HD 1080i 25fps | AACAT3 | Already Supplied   | Aastha:Standard |
When I open order item with next title 'AACAT3'
And generate 'auto code' value for Add information form on order item page
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| AACAJN3    | AACAPN3   |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item title 'AACAT3' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ARAACA3    | BRAACA3 | SBAACA3   | PRAACA3 | United Kingdom | AACAPN3   | AACAJN3 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains item title 'AACAT3' and items with following fields:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration | Status        |
| AutoCode     | ARAACA3    | PRAACA3 | AACAT3 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: check confirming order with Auto code
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
| Name    | Date Format | Sequential Number | Free Text | Metadata Elements | Enabled |
| AACACC4 | DDMMYYYY    | 4                 | /         | Advertiser:3      | should  |
And logged in with details of 'AACAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ARAACA3    | BRAACA3 | SBAACA3   | PRAACA3 | 20       | 10/14/2022     | HD 1080i 25fps | AACAT4 | Already Supplied   | Aastha:Standard |
When I open order item with next title 'AACAT4'
And fill following fields for Add information form on order item page:
| Clock Number | Campaign |
| AACACN4      | AACAC4   |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| AACAJN4    | AACAPN4   |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'AACACN4' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ARAACA3    | BRAACA3 | SBAACA3   | PRAACA3 | United Kingdom | AACAPN4   | AACAJN4 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'AACACN4' and items with following fields:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration | Status        |
| AACACN4      | ARAACA3    | PRAACA3 | AACAT4 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: Validation for Auto Code
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU1 | agency.admin | AACAA1       |
And update custom code 'Clock number' of schema 'video' agency 'AACAA1' by following fields:
| Name    | Date Format | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACACC5 | DDMMYYYY    | 4                 | /         | Advertiser:3,Brand:3,Sub Brand:3,Product:3,Duration:2 | should  |
And logged in with details of 'AACAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Title  |
| AACAT5 |
When I open order item with next title 'AACAT5'
And click 'auto code' button for Add information form on order item page
Then I 'should' see that following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Duration' are required for order item on Add information form

Scenario: check Auto Code generating by custom catalog
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>     |
And created following 'common' custom metadata fields for agency '<Agency>':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency '<Agency>' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of '<User>'
And I am on the global 'video asset' metadata page for agency '<Agency>'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                                                          | Metadata Characters |
| AACACC6   | 5                   | should            | Advertiser Custom,Brand Custom,Product Custom,Campaign Custom,Duration | 2,2,2,2,2           |
And save metadata field settings
And created '<OrderType>' order with market 'United Kingdom' and items with following fields:
| Additional Information | Title   | Duration   | First Air Date | Format         |
| automated test info    | <Title> | <Duration> | 10/14/2022     | HD 1080i 25fps |
And open order item with next title '<Title>'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| ARAACA6           | BRAACA6      | PRAACA6        | CAAACA6         |
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '<AutoCode>' for field '<FieldName>' on Add information form of order item page
And should see following auto generated code '<AutoCode>' for active order item on cover flow

Examples:
|Agency	|User	|OrderType	|Title	|Duration	|AutoCode	|FieldName	|
|AACAA6_1	|AACAU6_1	|tv	|AACAT6_1	|20	|\d{2,5}ARBRPRCA20	|Clock Number	|
|AACAA6_2	|AACAU6_2	|music	|AACAT6_2	|	|\d{2,5}ARBRPRCA	|ISRC Code	|

Scenario: check copy current for Auto Code
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACAA7 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU7 | agency.admin | AACAA7       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAA7':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACA7    | BRAACA7 | SBAACA7   | PRAACA7 |
And update custom code 'Clock number' of schema 'video' agency 'AACAA7' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACACC7 | 5                 | /         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Duration:2 | should  |
And logged in with details of 'AACAU7'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand   | Sub Brand | Product | Duration | Title  |
| ARAACA7    | BRAACA7 | SBAACA7   | PRAACA7 | 20       | AACAT7 |
When I open order item with next title 'AACAT7'
And generate 'auto code' value for Add information form on order item page
And 'copy current' order item by Add Commercial button on order item page
Then I should see following auto generated code '\d{2,5}/ARBRSBPR20' for field 'Clock Number' on Add information form of order item page
And 'should' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: check Copy to all for Auto Code
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACAA8 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU8 | agency.admin | AACAA8       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAA8':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACA8    | BRAACA8 | SBAACA8   | PRAACA8 |
And update custom code 'Clock number' of schema 'video' agency 'AACAA8' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACACC8 | 5                 | #         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Duration:2 | should  |
And logged in with details of 'AACAU8'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand   | Sub Brand | Product | Duration | Title    |
| ARAACA8    | BRAACA8 | SBAACA8   | PRAACA8 | 20       | AACAT8_1 |
|            |         |           |         |          | AACAT8_2 |
When I open order item with next title 'AACAT8_1'
And wait for '2' seconds
And generate 'auto code' value for Add information form on order item page
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with following title 'AACAT8_1' on cover flow
Then I should see following auto generated code '\d{2,7}#ARBRSBPR20' for field 'Clock Number' on Add information form of order item page
And 'should' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: Check that Auto Code is autogenerating for asset in Library
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACAA9 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACAU9 | agency.admin | AACAA9       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAA9':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACA9    | BRAACA9 | SBAACA9   | PRAACA9 |
And update custom code 'Clock number' of schema 'video' agency 'AACAA9' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACACC9 | 8                 | -         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Duration:2 | should  |
And logged in with details of 'AACAU9'
And uploaded following assets:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'
And I am on asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
When I click Edit link on asset info page
And fill asset info by following information on opened Edit Asset popup on asset info page:
| FieldName    | FieldValue |
| Advertiser   | ARAACA9    |
| Brand        | BRAACA9    |
| Sub Brand    | SBAACA9    |
| Product      | PRAACA9    |
| Duration     | 20         |
And generate auto code value for field 'Clock number' in section 'Admin Information' on opened Edit Asset popup
Then I should see following auto generated code '\d{2,8}-ARBRSBPR20' for field 'Clock number' in section 'Admin Information' on opened Edit Asset popup

