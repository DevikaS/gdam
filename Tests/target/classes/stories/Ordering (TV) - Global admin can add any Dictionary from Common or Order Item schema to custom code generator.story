!--ORD-4850
!--ORD-4935
Feature: Global admin can add any Dictionary from Common or Order Item schema to custom code generator
Narrative:
In order to:
As a GlobalAdmin
I want to check that global admin can add any Dictionary from Common or Order Item schema to custom code generator

Scenario: Check that Advertiser and Product placeholders are available in Metadata Elements for particular BU depends on marking as these fields
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Advertiser | Mark as Product | Mark as Campaign |
| <Agency> | DefaultA4User | <MarkAsAdvertiser> | <MarkAsProduct> | <MarkAsCampaign> |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency '<Agency>'
And clicked 'Clock number' button in 'editable metadata' section on opened metadata page
When I create new custom code on AdCode Manager form of metadata page
Then I '<ShouldState>' see available following metadata names 'Advertiser,Brand,Sub Brand,Product,Campaign' for custom code on AdCode Manager form of metadata page

Examples:
| Agency    | MarkAsAdvertiser | MarkAsProduct | MarkAsCampaign | ShouldState |
| GACADA1_1 | Advertiser       | Product       | Campaign       | should      |
| GACADA1_2 |                  |               |                | should not  |

Scenario: Check that Advertiser and Product placeholders are available in Metadata Elements even if Mark as Advertiser Mark as Product and BU aren't specified
!--ORD-4919
Meta: @ordering
Given I am on the global common ordering metadata page of market 'United Kingdom' for agency ''
And clicked 'Clock number' button in 'editable metadata' section on opened metadata page
When I create new custom code on AdCode Manager form of metadata page
Then I 'should' see available following metadata names 'Advertiser,Product' for custom code on AdCode Manager form of metadata page

Scenario: Check that all dictionaries and catalogue structures of Common Editable and Common Custom and Common Ordering schemas are available in Metadata Elements
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| GACADA3 | DefaultA4User |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'GACADA3'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String Custom' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Date' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Date Custom' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Multiline' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Multiline Custom' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Phone' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Phone Custom' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Dropdown' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Dropdown Custom' on opened Settings and Customization tab
And saved metadata field settings
And opened available metadata page 'Available Metadata'
And clicked 'Catalogue Structure' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Catalogue Custom' on opened Settings and Customization tab
And saved metadata field settings
And opened available metadata page 'Available Metadata'
And clicked 'Address' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Address Custom' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Radio Buttons' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Radio Custom' on opened Settings and Customization tab
And saved metadata field settings
And opened available metadata page 'Available Metadata'
And clicked 'Hyperlink' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Hyperlink Custom' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code Custom' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Clock number' button in 'editable metadata' section on opened metadata page
When I create new custom code on AdCode Manager form of metadata page
Then I 'should' see available following metadata names 'Advertiser,Product,Campaign,Creative Agency,Duration,Format,Media Agency,Posthouse,Title,Dropdown Custom,Catalogue Custom,Radio Custom,Subtitles Required' for custom code on AdCode Manager form of metadata page
And 'should not' see available following metadata names 'String Custom,Date Custom,Multiline Custom,Phone Custom,Address Custom,Hyperlink Custom,Custom Code Custom' for custom code on AdCode Manager form of metadata page

Scenario: Check that new catalogue is displayed in Metadata Elements list and can be used for creation Custom Code
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| GACADA4 | DefaultA4User |
And created following 'common' custom metadata fields for agency 'GACADA4':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'GACADA4' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'GACADA4'
And clicked 'Clock number' button in 'editable metadata' section on opened metadata page
When I create new custom code on AdCode Manager form of metadata page
Then I 'should' see available following metadata names 'Advertiser Custom,Brand Custom,Product Custom,Campaign Custom' for custom code on AdCode Manager form of metadata page

Scenario: Check that Market Specific dictionaries are displayed in Metadata Elements list and can be used for creation Custom Code
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| GACADA5 | DefaultA4User |
And I am on the global common ordering metadata page of market 'Spain' for agency 'GACADA5'
And clicked 'Clock number' button in 'editable metadata' section on opened metadata page
When I create new custom code on AdCode Manager form of metadata page
Then I 'should' see available following metadata names 'Language,Watermarking Required' for custom code on AdCode Manager form of metadata page

Scenario: Check that created Custom Code by global admin is available for agency admin
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| GACADA6 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GACADU6 | agency.admin | GACADA6      |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'GACADA6'
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code Custom' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code Custom' button in 'editable metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                     | Metadata Characters |
| GACADC6   | 5                   | should            | Advertiser,Product,Duration,Title | 2,2,2,2             |
And saved metadata field settings
And logged in with details of 'GACADU6'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| GACADCN6     |
When I open order item with following clock number 'GACADCN6'
Then I 'should' see following custom field 'Custom Code Custom' for order item on Add information form

Scenario: Check custom code generation after creating custom code rule under Global Admin
Meta: @ordering
!--NGN-18611 Sequential number unchecked by default
Given I created the following agency:
| Name    | A4User        |
| GACADA7 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GACADU7 | agency.admin | GACADA7      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GACADA7':
| Advertiser | Brand    | Sub Brand | Product  |
| ARGACAD7   | BRGACAD7 | SBGACAD7  | PRGACAD7 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'GACADA7'
And clicked 'Clock number' button in 'editable metadata' section on opened metadata page
And 'allow' special characters on AdCode Manager form of metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                                        | Metadata Characters | Free Text | Separator |
| GACADC7   | 3                   | should            | Advertiser,Product,Duration,Title,Subtitles Required | 2,2,2,2,2           | should    | /         |
And saved metadata field settings
And logged in with details of 'GACADU7'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand    | Sub Brand | Product  | Duration | Title    | Subtitles Required |
| ARGACAD7   | BRGACAD7 | SBGACAD7  | PRGACAD7 | 20       | TTGACAD7 | Already Supplied   |
When I open order item with next title 'TTGACAD7'
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,5}ARPR20TTAL/' for field 'Clock Number' on Add information form of order item page

Scenario: Check validation during custom code generation after creating custom code rule under Global Admin
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| GACADA8 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GACADU8 | agency.admin | GACADA8      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GACADA8':
| Advertiser | Brand    | Sub Brand | Product  |
| ARGACAD8   | BRGACAD8 | SBGACAD8  | PRGACAD8 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'GACADA8'
And clicked 'Clock number' button in 'editable metadata' section on opened metadata page
And 'allow' special characters on AdCode Manager form of metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                                        | Metadata Characters | Free Text | Separator |
| GACADC8   | 5                   | should            | Advertiser,Product,Duration,Title,Subtitles Required | 2,2,2,2,2           | should    | /         |
And saved metadata field settings
And logged in with details of 'GACADU8'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Title    |
| TTGACAD8 |
When I open order item with next title 'TTGACAD8'
And click 'auto code' button for Add information form on order item page
Then I 'should' see that following fields 'Clock Number,Advertiser,Product,Duration,Subtitles Required' are required for order item on Add information form

Scenario: Check that custom value is displayed in Clock Number field in case to generate adcode if for Type of commercial Custom value is specified in Metadata Elements
Meta: @ordering
!--NGN-18611 Sequential number unchecked by default
Given I created the following agency:
| Name    | A4User        |
| GACADA9 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GACADU9 | agency.admin | GACADA9      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GACADA9':
| Advertiser | Brand    | Sub Brand | Product  |
| ARGACAD9   | BRGACAD9 | SBGACAD9  | PRGACAD9 |
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'Sweden' for agency ''
And clicked 'Copy Code' button in 'editable metadata' section on opened metadata page
And 'allow' special characters on AdCode Manager form of metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                 | Metadata Characters | Free Text | Separator |
| GACADC9   | 4                   | should            | Advertiser,Type of Commercial | 3,Custom            | should    | /         |
And saved metadata field settings
And clicked 'Type of Commercial' button in 'editable metadata' section on opened metadata page
And filled custom characters '05' for following field choice 'Spot' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'GACADU9'
And create 'tv' order with market 'Sweden' and items with following fields:
| Advertiser | Title    | Type of Commercial |
| ARGACAD9   | TTGACAD9 | Spot               |
When I open order item with next title 'TTGACAD9'
And click 'auto code' button for Add information form on order item page
And select following custom code 'GACADC9' on Select from existing formats popup of Add information form
And applied selected custom code for Add information form of order item page
And wait for generating 'auto code' for Add information form on order item page
Then I should see following auto generated code '\d{2,5}ARG05/' for field 'Copy Code' on Add information form of order item page


Scenario: Check Product field in Adcode picks values from 'Brand' filed when set as 'Mark as Product' in Delivery
Meta: @ordering
!--NGN-16200
!--NGN-18611 Sequential number unchecked by default
Given I created the following agency:
| Name    | A4User        | Mark as Advertiser |
| GACAD10 | DefaultA4User | Advertiser         |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| GACADU10 | agency.admin | GACAD10        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GACAD10':
| Advertiser | Brand   | Sub Brand | Product |
| ADGACAD    | BRGACAD | SBGACAD   | PRGACAD |
And I logged in as 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'GACAD10'
And clicked 'Brand' button in 'Common Metadata' section on opened metadata page
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the global common ordering metadata page of market 'Sweden' for agency ''
And clicked 'Copy Code' button in 'editable metadata' section on opened metadata page
And 'allow' special characters on AdCode Manager form of metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name      | Metadata Characters |
| GACADCC1  | 4                   | should            | Advertiser,Product | 2,2                 |
And saved metadata field settings
And logged in with details of 'GACADU10'
And create 'tv' order with market 'Sweden' and items with following fields:
| Advertiser | Brand   | Title  |
| ADGACAD    | BRGACAD | TGACAD |
When I open order item with next title 'TGACAD'
And click 'auto code' button for Add information form on order item page
And select following custom code 'GACADCC1' on Select from existing formats popup of Add information form
And applied selected custom code for Add information form of order item page
And wait for generating 'auto code' for Add information form on order item page
Then I should see following auto generated code '\d{2,5}ADBR' for field 'Copy Code' on Add information form of order item page


Scenario: Check Product field in Adcode picks values from 'Sub Brand' filed when set as 'Mark as Product' in Delivery
Meta: @ordering
!--NGN-16200
!--NGN-18611 Sequential number unchecked by default
Given I created the following agency:
| Name    | A4User        | Mark as Advertiser |
| GACAD11 | DefaultA4User | Advertiser         |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| GACADU11 | agency.admin | GACAD11      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GACAD11':
| Advertiser | Brand   | Sub Brand | Product |
| ADGACAD    | BRGACAD | SBGACAD   | PRGACAD |
And I logged in as 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'GACAD11'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the global common ordering metadata page of market 'Sweden' for agency ''
And clicked 'Copy Code' button in 'editable metadata' section on opened metadata page
And 'allow' special characters on AdCode Manager form of metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name      | Metadata Characters |
| GACADCC2   | 4                   | should            | Advertiser,Product | 2,2                 |
And saved metadata field settings
And logged in with details of 'GACADU11'
And create 'tv' order with market 'Sweden' and items with following fields:
| Advertiser | Brand   | Sub Brand | Title  |
| ADGACAD    | BRGACAD | SBGACAD   | TGACAD |
When I open order item with next title 'TGACAD'
And click 'auto code' button for Add information form on order item page
And select following custom code 'GACADCC2' on Select from existing formats popup of Add information form
And applied selected custom code for Add information form of order item page
And wait for generating 'auto code' for Add information form on order item page
Then I should see following auto generated code '\d{2,5}ADSB' for field 'Copy Code' on Add information form of order item page