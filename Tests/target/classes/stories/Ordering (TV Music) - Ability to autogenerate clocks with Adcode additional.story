!--ORD-2927
!--ORD-2875
!--ORD-3006
!--ORD-4685
!--ORD-5275
!--ORD-5271
Feature: Ability to autogenerate clocks with AdCode additional
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of autogenerating clocks with AdCode additional

Scenario: check that deleted Custom code isn't visible on Select from existing formats popup on order item page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAAU1 | agency.admin | AACAAA1      |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA1' by following fields:
| Name       | Date Format | Sequential Number | Free Text | Metadata Elements    | Enabled |
| AACAACC1_1 | DDMMYYYY    | 4                 | /         | Advertiser:3         | should  |
| AACAACC1_2 | MMDDYYYY    | 3                 | -         | Advertiser:2         | should  |
| AACAACC1_3 | MMDDYYYY    | 2                 | /;-       | Advertiser:3,Brand:2 | should  |
And logged in with details of 'AACAAU1'
And I am on the global 'video asset' metadata page for agency 'AACAAA1'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I 'delete' custom code 'AACAACC1_1' on AdCode Manager form of metadata page
And save metadata field settings
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Title   |
| AACAAT1 |
And open order item with next title 'AACAAT1'
Then I 'should not' see following custom code 'AACAACC1_1' on Select from existing formats popup of Add information form

Scenario: Check deactivation of Custom Code on Adcode Manager form
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAAA2 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAAU2 | agency.admin | AACAAA2      |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA2' by following fields:
| Name     | Date Format | Sequential Number | Free Text | Metadata Elements | Enabled |
| AACAACC2 | DDMMYYYY    | 4                 | /         | Advertiser:3      | should  |
And logged in with details of 'AACAAU2'
And I am on the global 'video asset' metadata page for agency 'AACAAA2'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I 'uncheck' active checkbox for custom code 'AACAACC2' on AdCode Manager form of metadata page
And save metadata field settings
And click 'Clock number' button in 'Editable Metadata' section on opened metadata page
Then I should see 'inactive' custom code 'AACAACC2' on AdCode Manager form of metadata page

Scenario: Check that deactivated Custom Code is not visible on Select from existing formats popup on order item page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAAA2 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAAU2 | agency.admin | AACAAA2      |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA2' by following fields:
| Name       | Date Format | Sequential Number | Free Text | Metadata Elements    | Enabled    |
| AACAACC3_1 | DDMMYYYY    | 4                 | /         | Advertiser:3         | should not |
| AACAACC3_2 | MMDDYYYY    | 3                 | -         | Advertiser:2         | should     |
| AACAACC3_3 | MMDDYYYY    | 2                 | /;-       | Advertiser:3,Brand:2 | should     |
And logged in with details of 'AACAAU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Title   |
| AACAAT3 |
When I open order item with next title 'AACAAT3'
Then I 'should not' see following custom code 'AACAACC3_1' on Select from existing formats popup of Add information form

Scenario: Check activation of Custom Code on Adcode Manager form
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAAA4 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAAU4 | agency.admin | AACAAA4      |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA4' by following fields:
| Name     | Date Format | Sequential Number | Free Text | Metadata Elements | Enabled    |
| AACAACC4 | DDMMYYYY    | 4                 | /         | Advertiser:3      | should not |
And logged in with details of 'AACAAU4'
And I am on the global 'video asset' metadata page for agency 'AACAAA4'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I 'check' active checkbox for custom code 'AACAACC4' on AdCode Manager form of metadata page
And save metadata field settings
And click 'Clock number' button in 'Editable Metadata' section on opened metadata page
Then I should see 'active' custom code 'AACAACC4' on AdCode Manager form of metadata page

Scenario: Check that activated Custom Code is visible on Select from existing formats popup on order item page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAAA4 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAAU4 | agency.admin | AACAAA4      |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA4' by following fields:
| Name       | Date Format | Sequential Number | Free Text | Metadata Elements | Enabled    |
| AACAACC5_1 | DDMMYYYY    | 4                 | /         | Advertiser:3      | should not |
| AACAACC5_2 | MMDDYYYY    | 3                 | -         | Advertiser:2      | should     |
And logged in with details of 'AACAAU4'
And I am on the global 'video asset' metadata page for agency 'AACAAA4'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I 'check' active checkbox for custom code 'AACAACC5_1' on AdCode Manager form of metadata page
And save metadata field settings
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Title   |
| AACAAT5 |
And open order item with next title 'AACAAT5'
Then I 'should' see following custom code 'AACAACC5_1,AACAACC5_2' on Select from existing formats popup of Add information form

Scenario: Check that Name of Custom code is required field
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAAA6 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAAU6 | agency.admin | AACAAA6      |
And logged in with details of 'AACAAU6'
And I am on the global 'video asset' metadata page for agency 'AACAAA6'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name |
|           |
And saved metadata field settings
Then I 'should' see validation error for following fields 'Code Name' on AdCode Manager form of metadata page


Scenario: check that Custom codes are visible on Select from existing formats popup for asset in Library
Meta: @ordering
@uitobe
Given I created the following agency:
| Name    | A4User        |
| AACAAA8 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAAU8 | agency.admin | AACAAA8      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAAA8':
| Advertiser | Brand    | Sub Brand | Product  |
| ARAACAA8   | BRAACAA8 | SBAACAA8  | PRAACAA8 |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA8' by following fields:
| Name       | Date Format | Sequential Number | Free Text | Metadata Elements                           | Enabled |
| AACAACC8_1 |             | 5                 | #         | Advertiser:2,Brand:3,Sub Brand:2,Duration:2 | should  |
| AACAACC8_2 | MMDDYYYY    | 3                 | -         | Advertiser:2,Brand:3                        | should  |
And logged in with details of 'AACAAU8'
And uploaded following assets:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'
And I am on asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
When I click Edit link on asset info page
Then I 'should' see following custom codes 'AACAACC8_1,AACAACC8_2' on Select from existing formats popup on opened Edit Asset popup

Scenario: check that auto code types are not dublicated after each copy current action
!--ORD-4413
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAAA9 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AACAAU9 | agency.admin | AACAAA9      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAAA9':
| Advertiser | Brand    | Sub Brand | Product  |
| ARAACAA9   | BRAACAA9 | SBAACAA9  | PRAACAA9 |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA9' by following fields:
| Name     | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACAACC9 | 5                 | /         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Duration:2 | should  |
And logged in with details of 'AACAAU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand    | Sub Brand | Product  | Duration | Title   |
| ARAACAA9   | BRAACAA9 | SBAACAA9  | PRAACAA9 | 20       | AACAAT9 |
When I open order item with next title 'AACAAT9'
And 'copy current' order item by Add Commercial button on order item page
And generate 'auto code' value for Add information form on order item page
Then I 'should not' see Select from existing formats popup on Add information form of order item page
And should see following auto generated code '\d{2,5}/ARBRSBPR20' for field 'Clock Number' on Add information form of order item page

Scenario: Check allow disallow special characters in generated value
!--ORD-4685
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AACAAA10 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AACAAU10 | agency.admin | AACAAA10     |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA10' by following fields:
| Name      | Date Format | Sequential Number | Free Text | Metadata Elements | Enabled |
| AACAACC10 | DDMMYYYY    | 4                 | /;-       | Advertiser:3      | should  |
And logged in with details of 'AACAAU10'
And I am on the global 'video asset' metadata page for agency 'AACAAA10'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
Then I should see following data for custom code 'AACAACC10' on AdCode Manager form of metadata page:
| Preview           |
| DDMMYYYYSSSS/-AAA |
When I 'disallow' special characters on AdCode Manager form of metadata page
Then I should see following data for custom code 'AACAACC10' on AdCode Manager form of metadata page:
| Preview          |
| DDMMYYYYSSSS-AAA |

Scenario: Check that every individual rule has own sequential number
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AACAAA11 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AACAAU11 | agency.admin | AACAAA11     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAAA11':
| Advertiser | Brand     | Sub Brand | Product   |
| ARAACAA11  | BRAACAA11 | SBAACAA11 | PRAACAA11 |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA11' by following fields:
| Name        | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACAACC11_1 | 6                 | /         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Duration:2 | should  |
| AACAACC11_2 | 7                 | #         | Advertiser:3,Brand:3                                  | should  |
And logged in with details of 'AACAAU11'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand     | Sub Brand | Product   | Duration | Title    |
| ARAACAA11  | BRAACAA11 | SBAACAA11 | PRAACAA11 | 20       | AACAAT11 |
When I open order item with next title 'AACAAT11'
And click 'auto code' button for Add information form on order item page
And select following custom code 'AACAACC11_1' on Select from existing formats popup of Add information form
And applied selected custom code for Add information form of order item page
And wait for generating 'auto code' for Add information form on order item page
Then I should see following auto generated code '\d{2,6}/ARBRSBPR20' for field 'Clock Number' on Add information form of order item page
When I clear clock number field on order item page
And I click 'auto code' button for Add information form on order item page
And select following custom code 'AACAACC11_2' on Select from existing formats popup of Add information form
And applied selected custom code for Add information form of order item page
And wait for generating 'auto code' for Add information form on order item page
Then I should see following auto generated code '\d{2,7}#ARABRA' for field 'Clock Number' on Add information form of order item page

Scenario: Adcode sequential rules should disregard Duration field
!--ORD-5275
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AACAAA12 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AACAAU12 | agency.admin | AACAAA12     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAAA12':
| Advertiser | Brand     | Sub Brand | Product   |
| ARAACAA12  | BRAACAA12 | SBAACAA12 | PRAACAA12 |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA12' by following fields:
| Name      | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| AACAACC12 | 5                 | /         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Duration:2 | should  |
And logged in with details of 'AACAAU12'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand     | Sub Brand | Product   | Duration | Title    |
| ARAACAA12  | BRAACAA12 | SBAACAA12 | PRAACAA12 | 20       | AACAAT12 |
When I open order item with next title 'AACAAT12'
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,5}/ARBRSBPR20' for field 'Clock Number' on Add information form of order item page
When I fill following fields for Add information form on order item page:
| Duration |
| 10       |
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,5}/ARBRSBPR10' for field 'Clock Number' on Add information form of order item page


Scenario: Check correct generation of clock number in case to send file from project to Library
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AACAAA7 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| AACAAU7 | agency.admin | AACAAA7      |streamlined_library,library,adkits,folders|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACAAA7':
| Advertiser | Brand    | Sub Brand | Product  |
| ARAACAA7   | BRAACAA7 | SBAACAA7  | PRAACAA7 |
And update custom code 'Clock number' of schema 'video' agency 'AACAAA7' by following fields:
| Name     | Sequential Number | Free Text | Metadata Elements                | Enabled |
| AACAACC7 | 10                | #         | Advertiser:2,Brand:3,Sub Brand:2 | should  |
And logged in with details of 'AACAAU7'
And created 'AACAAP7' project
And created '/AACAAF7' folder for project 'AACAAP7'
And uploaded into project 'AACAAP7' following files:
| FileName             | Path     |
| /files/Fish1-Ad.mov  | /AACAAF7 |
And waited while transcoding is finished in folder '/AACAAF7' on project 'AACAAP7' files page
When I select file 'Fish1-Ad.mov' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| Advertiser | Brand    | Sub Brand |
| ARAACAA7   | BRAACAA7 | SBAACAA7  |
And generate auto code value on New Assets form
Then I should see following data on add file to library page:
| Clock number     |
| \d{2,10}#ARBRASB |
