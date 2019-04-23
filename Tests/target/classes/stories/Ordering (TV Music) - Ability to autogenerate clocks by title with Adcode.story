!--ORD-3219
!--ORD-3255
Feature: Ability to autogenerate clocks by title with AdCode
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of autogenerating clocks by title with AdCode

Scenario: check generated autocode with Title rule
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACTA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACTU1 | agency.admin | AACTA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACTA1':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACT1    | BRAACT1 | SBAACT1   | PRAACT1 |
And update custom code 'Clock number' of schema 'video' agency 'AACTA1' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                        | Enabled |
| AACTCC1 | 6                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Title:3 | should  |
And logged in with details of 'AACTU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand   | Sub Brand | Product | Title  |
| ARAACT1    | BRAACT1 | SBAACT1   | PRAACT1 | TAACT1 |
When I open order item with next title 'TAACT1'
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,6}/-ARABRSBTAA' for field 'Clock Number' on Add information form of order item page

Scenario: check correct confirming order after generating auto code with Title rule
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACTA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACTU1 | agency.admin | AACTA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACTA1':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACT1    | BRAACT1 | SBAACT1   | PRAACT1 |
And update custom code 'Clock number' of schema 'video' agency 'AACTA1' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                        | Enabled |
| AACTCC2 | 5                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Title:3 | should  |
And logged in with details of 'AACTU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ARAACT1    | BRAACT1 | SBAACT1   | PRAACT1 | AACTC2   | 20       | 10/14/2022     | HD 1080i 25fps | AACTT2 | Already Supplied   | Aastha:Standard |
When I open order item with next title 'AACTT2'
And generate 'auto code' value for Add information form on order item page
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| AACTJN2    | AACTPN2   |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item title 'AACTT2' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ARAACT1    | BRAACT1 | SBAACT1   | PRAACT1 | United Kingdom | AACTPN2   | AACTJN2 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains item title 'AACTT2' and items with following fields:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration | Status        |
| AutoCode     | ARAACT1    | PRAACT1 | AACTT2 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: check validation for autocode with Title rule
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACTA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACTU1 | agency.admin | AACTA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACTA1':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACT1    | BRAACT1 | SBAACT1   | PRAACT1 |
And update custom code 'Clock number' of schema 'video' agency 'AACTA1' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                                  | Enabled |
| AACTCC3 | 6                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Product:3,Title:3 | should  |
And logged in with details of 'AACTU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And click 'auto code' button for Add information form on order item page
Then I 'should' see that following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Title' are required for order item on Add information form

Scenario: check generated autocode with Title rule for asset in Library
!--ORD-4450
Meta: @ordering
@uitobe
Given I created the following agency:
| Name   | A4User        |
| AACTA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACTU1 | agency.admin | AACTA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACTA1':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACT1    | BRAACT1 | SBAACT1   | PRAACT1 |
And update custom code 'Clock number' of schema 'video' agency 'AACTA1' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                                  | Enabled |
| AACTCC4 | 7                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Product:3,Title:3 | should  |
And logged in with details of 'AACTU1'
And uploaded following assets:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'
And I am on asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
When I click Edit link on asset info page
And fill asset info by following information on opened Edit Asset popup on asset info page:
| FieldName    | FieldValue |
| Advertiser   | ARAACT1    |
| Brand        | BRAACT1    |
| Sub Brand    | SBAACT1    |
| Product      | PRAACT1    |
| Title        | TAACT4     |
And generate auto code value for field 'Clock number' in section 'Admin Information' on opened Edit Asset popup
Then I should see following auto generated code '\d{2,7}/-ARABRSBPRATAA' for field 'Clock number' in section 'Admin Information' on opened Edit Asset popup

Scenario: check generated autocode with Title rule for file in Project
!--ORD-4450
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACTA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACTU1 | agency.admin | AACTA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACTA1':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACT1    | BRAACT1 | SBAACT1   | PRAACT1 |
And update custom code 'Clock number' of schema 'video' agency 'AACTA1' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                                  | Enabled |
| AACTCC5 | 8                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Product:3,Title:3 | should  |
And logged in with details of 'AACTU1'
And created 'AACTP5' project
And created '/AACTF5' folder for project 'AACTP5'
And uploaded into project 'AACTP5' following files:
| FileName             | Path    |
| /files/Fish1-Ad.mov  | /AACTF5 |
And waited while transcoding is finished in folder '/AACTF5' on project 'AACTP5' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/AACTF5' project 'AACTP5'
When I click Edit link on file info page
And fill Edit file popup with following information:
| FieldName    | FieldValue |
| Advertiser   | ARAACT1    |
| Brand        | BRAACT1    |
| Sub Brand    | SBAACT1    |
| Product      | PRAACT1    |
| Title        | TAACT5     |
And generate auto code value for field 'Clock number' in section 'Admin Information' on opened Edit File popup
Then I should see following auto generated code '\d{2,8}/-ARABRSBPRATAA' for field 'Clock number' in section 'Admin Information' on opened Edit File popup

Scenario: check validation after changing autocode type
!--ORD-3235
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACTA6 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACTU6 | agency.admin | AACTA6       |
And update custom code 'Clock number' of schema 'video' agency 'AACTA6' by following fields:
| Name      | Date Format | Sequential Number | Free Text | Metadata Elements                                  | Enabled |
| AACTCC6_1 |             | 5                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Product:3,Title:3 | should  |
| AACTCC6_2 | DDMMYYYY    | 6                 | /         | Advertiser:2,Title:2                               | should  |
And logged in with details of 'AACTU6'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And click 'auto code' button for Add information form on order item page
And select following custom code 'AACTCC6_1' on Select from existing formats popup of Add information form
And applied selected custom code for Add information form of order item page
And click 'auto code' button for Add information form on order item page
And select following custom code 'AACTCC6_2' on Select from existing formats popup of Add information form
And applied selected custom code for Add information form of order item page
Then I 'should' see that following fields 'Clock Number,Advertiser,Title' are required for order item on Add information form
And 'should not' see that following fields 'Brand,Sub Brand,Product' are required for order item on Add information form

Scenario: Check the validation for Clock number(auto code) when sequential checkbox is checked
!--ORD-17789
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACTA2 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACTU2 | agency.admin | AACTA2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACTA2':
| Advertiser | Brand   | Sub Brand | Product |
| <Advertiser>  | BRAACT1 | SBAACT1   | PRAACT1 |
And update custom code 'Clock number' of schema 'video' agency 'AACTA2' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                        | Enabled |
| AACTCC2 | 6                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Title:3 | should  |
And I logged in as 'GlobalAdmin'
And I am on the global 'video asset' metadata page for agency 'AACTA2'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I 'edit' custom code 'AACTCC2' on AdCode Manager form of metadata page
Then I 'should' see sequential checked for the custom code 'AACTCC2'
When I '<Checkbox>' the sequential checkbox for the custom code 'AACTCC2' on AdCode Manager form of metadata page
And I '<SequentialAlert>' see an sequential alert with warning message 'Warning – by removing sequential number there is no guarantee that Adcodes generated by this rule will be unique from one another. Please confirm you wish to proceed' for the custom code 'AACTCC1'
And I save metadata field settings
And wait for '5' seconds
And I login with details of 'AACTU2'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | <Advertiser>    | BRAACT1 | SBAACT1   | PRAACT1 | UWPCEOC_2        | 10/14/2022     | HD 1080i 25fps | <Title> | Already Supplied   | Aastha:Standard |
And I open order item with next title '<Title>'
And I generate 'auto code' value for Add information form on order item page
And I wait for '60' seconds
Then I '<ShouldState1>' see an error 'cannot generate unique code'
When I generate 'auto code' value for Add information form on order item page
And I wait for '60' seconds
Then I '<ShouldState2>' see an error 'cannot generate unique code'
When I fill following fields for Add information form on order item page:
| Clock Number|Duration|
| <ClockNumber> |20|
And click Proceed button on order item page
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser |  Market          | Status        |
| Digit# | CurrentTime | <Advertiser> |United Kingdom  | 0/1 Delivered |

Examples:
|Checkbox|ShouldState1|ShouldState2|Advertiser |SequentialAlert|Title |ClockNumber|
|check   |should not  |should not  |AAKRAACT1|should not       |TAACT1|AACTAC_1   |

Scenario: Check the validation for Clock number(auto code) when sequential checkbox is unchecked
!--ORD-17789
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACTA2_1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AACTU2_1 | agency.admin | AACTA2_1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACTA2_1':
| Advertiser | Brand   | Sub Brand | Product |
| <Advertiser>  | BRAACT1 | SBAACT1   | PRAACT1 |
And update custom code 'Clock number' of schema 'video' agency 'AACTA2_1' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                        | Enabled |
| AACTCC2 | 6                 | /;-       | Advertiser:8,Brand:2,Sub Brand:2,Title:3 | should  |
And I logged in as 'GlobalAdmin'
And I am on the global 'video asset' metadata page for agency 'AACTA2_1'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I 'edit' custom code 'AACTCC2' on AdCode Manager form of metadata page
Then I 'should' see sequential checked for the custom code 'AACTCC2'
When I '<Checkbox>' the sequential checkbox for the custom code 'AACTCC2' on AdCode Manager form of metadata page
And wait for '3' seconds
And I '<SequentialAlert>' see an sequential alert with warning message 'Warning – by removing sequential number there is no guarantee that Adcodes generated by this rule will be unique from one another. Please confirm you wish to proceed' for the custom code 'AACTCC1'
And I save metadata field settings
And wait for '2' seconds
And I login with details of 'AACTU2_1'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | <Advertiser>    | BRAACT1 | SBAACT1   | PRAACT1 | UWPCEOC_2        | 10/14/2022     | HD 1080i 25fps | <Title> | Already Supplied   | Aastha:Standard |
And I open order item with next title '<Title>'
And I generate 'auto code' value for Add information form on order item page
Then I '<ShouldState1>' see an error 'Sorry something went wrong, please contact support if issue persists'
When I generate 'auto code' value for Add information form on order item page
Then I '<ShouldState2>' see an error 'Sorry something went wrong, please contact support if issue persists'
When I fill following fields for Add information form on order item page:
| Clock Number|Duration|
| <ClockNumber> |20|
And click Proceed button on order item page
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser |  Market          | Status        |
| Digit# | CurrentTime | <Advertiser> |United Kingdom  | 0/1 Delivered |

Examples:
|Checkbox|ShouldState1|ShouldState2|Advertiser     |SequentialAlert|Title |ClockNumber|
|uncheck |should not  |should      |ZYX            |should         |TAACT2|AACTAC_2   |


Scenario: Check the sequential number for clock number is generated unique
!--ORD-17789
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AACTA4 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| AACTU4 | agency.admin | AACTA4      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AACTA4':
| Advertiser | Brand   | Sub Brand | Product |
| ARAACT4  | BRAACT1 | SBAACT1   | PRAACT1 |
And update custom code 'Clock number' of schema 'video' agency 'AACTA4' by following fields:
| Name    | Sequential Number | Free Text | Metadata Elements                        | Enabled |
| AACTCC4 | 6                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Title:3 | should  |
When I login with details of 'AACTU4'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ARAACT4    | BRAACT1 | SBAACT1   | PRAACT1 | UWPCEOC_2        | 10/14/2022     | HD 1080i 25fps | TAACT1 | Already Supplied   | Aastha:Standard |
And I open order item with next title 'TAACT1'
Then I should see unique 'auto code' generated on Add information form on order item page
