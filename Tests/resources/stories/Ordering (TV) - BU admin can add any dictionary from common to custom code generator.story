!--ORD-4856
!--ORD-4787
Feature: BU admin can add any dictionary from common to custome code generator
Narrative:
In order to:
As a AgencyAdmin
I want to check that BU admin can add any dictionary from common to custome code generator

Scenario: check that only new dictionary fields are available in custom code generator after adding
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| ACADTCGA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| ACADTCGU1 | agency.admin | ACADTCGA1    |
And logged in with details of 'ACADTCGU1'
And I am on the global 'common custom' metadata page for agency 'ACADTCGA1'
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
And I am on the global 'video asset' metadata page for agency 'ACADTCGA1'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
When I create new custom code on AdCode Manager form of metadata page
Then I 'should' see available following metadata names 'Dropdown Custom,Catalogue Custom,Radio Custom' for custom code on AdCode Manager form of metadata page
And 'should not' see available following metadata names 'String Custom,Date Custom,Multiline Custom,Phone Custom,Address Custom,Hyperlink Custom,Custom Code Custom' for custom code on AdCode Manager form of metadata page

Scenario: check that only new dictionary fields are available in custom code generator after adding in case new Custom Code
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| ACADTCGA2 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| ACADTCGU2 | agency.admin | ACADTCGA2    |
And logged in with details of 'ACADTCGU2'
And I am on the global 'common custom' metadata page for agency 'ACADTCGA2'
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
And filled Description field with text 'Custom Code Custom 1' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code Custom 2' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code Custom 2' button in 'common metadata' section on opened metadata page
When I create new custom code on AdCode Manager form of metadata page
Then I 'should' see available following metadata names 'Dropdown Custom,Catalogue Custom,Radio Custom' for custom code on AdCode Manager form of metadata page
And 'should not' see available following metadata names 'String Custom,Date Custom,Multiline Custom,Phone Custom,Address Custom,Hyperlink Custom,Custom Code Custom 1' for custom code on AdCode Manager form of metadata page

Scenario: check custom code generation which depends on new dictionary field
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| ACADTCGA3 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| ACADTCGU3 | agency.admin | ACADTCGA3    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACADTCGA3':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARACADTCG3 | BRACADTCG3 | SBACADTCG3 | PRACADTCG3 |
And logged in with details of 'ACADTCGU3'
And I am on the global 'common custom' metadata page for agency 'ACADTCGA3'
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description     | AddOnFly | MultipleChoices | Descendants | Delivery |
| Dropdown Custom | should   | should          | drop1,drop2 | should   |
And I am on the global 'video asset' metadata page for agency 'ACADTCGA3'
And clicked 'Clock number' button in 'Editable Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                                               | Metadata Characters | Free Text | Separator |
| ACADTCGC3 | 4                   | should            | Advertiser,Brand,Sub Brand,Product,Duration,Dropdown Custom | 2,2,2,2,2,2         | should    | /         |
And saved metadata field settings
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand      | Sub Brand  | Product    | Duration | Title     |
| ARACADTCG3 | BRACADTCG3 | SBACADTCG3 | PRACADTCG3 | 20       | ACADTCGT3 |
When I open order item with next title 'ACADTCGT3'
And fill following fields for Additional information section on order item page:
| Dropdown Custom |
| drop1           |
And wait for '2' seconds
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,5}ARBRSBPR20DR/' for field 'Clock Number' on Add information form of order item page

Scenario: check custom code generation which depends on new dictionary field in case new Custom Code
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| ACADTCGA4 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| ACADTCGU4 | agency.admin | ACADTCGA4    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACADTCGA4':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARACADTCG4 | BRACADTCG4 | SBACADTCG4 | PRACADTCG4 |
And logged in with details of 'ACADTCGU4'
And I am on the global 'common custom' metadata page for agency 'ACADTCGA4'
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description     | AddOnFly | MultipleChoices | Descendants | Delivery |
| Dropdown Custom | should   | should          | drop1,drop2 | should   |
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code Custom' on opened Settings and Customization tab
And checked 'Make this field available in Delivery' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And clicked 'Custom Code Custom' button in 'common metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements | Metadata Name                                      | Metadata Characters | Free Text | Separator |
| ACADTCGC4 | 5                   | should            | Advertiser,Brand,Sub Brand,Product,Dropdown Custom | 2,2,2,2,2           | should    | /         |
And saved metadata field settings
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand      | Sub Brand  | Product    | Duration | Title     |
| ARACADTCG4 | BRACADTCG4 | SBACADTCG4 | PRACADTCG4 | 20       | ACADTCGT4 |
When I open order item with next title 'ACADTCGT4'
And fill following fields for Additional information section on order item page:
| Dropdown Custom |
| drop1           |
And generate auto code value for field 'Custom Code Custom' on Additional information section of order item page
Then I should see following auto generated code '\d{2,5}ARBRSBPRDR/' for field 'Custom Code Custom' on Additional information section of order item page



Scenario: check user can edit custom code field on ordering page when BU admin sets FIELD-IS-EDITABLE as TRUE
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| ACADTCGA5 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| ACADTCGU5   | agency.admin | ACADTCGA5    |
| ACADTCGU5_1 | agency.user | ACADTCGA5     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACADTCGA5':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARACADTCG5 | BRACADTCG5 | SBACADTCG5 | PRACADTCG5 |
And logged in with details of 'ACADTCGU5'
And I am on the 'common custom' metadata page
And clicked 'Custom Code' button in 'Custom Metadata' section on opened metadata page
And filled Description field with text 'Custom Code Field Editable' on opened Settings and Customization tab
And checked 'Field is editable' checkbox on opened string field Settings and Customization page
And checked 'Make this field available in Delivery' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the 'common custom' metadata page
And clicked 'Custom Code Field Editable' button in 'Common Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements  | Metadata Name                      | Metadata Characters     |
| ACADTCGC5 | 5                   | should             | Advertiser,Brand,Sub Brand,Product | 3,2,1,1                 |
And saved metadata field settings
And logged in with details of 'ACADTCGU5_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand      | Sub Brand  | Product    | Duration | Title        |
| ARACADTCG5 | BRACADTCG5 | SBACADTCG5 | PRACADTCG5 | 20       | ACADTCGT5 |
When I open order item with next title 'ACADTCGT5'
And generate auto code value for field 'Custom Code Field Editable' on Additional information section of order item page
Then I should see following auto generated code '\d{2,5}ARABRSP' for field 'Custom Code Field Editable' on Additional information section of order item page
When I fill following fields for Additional information section on order item page:
| Custom Code Field Editable |
| Able to edit custom code   |
Then I should see following auto generated code 'Able to edit custom code' for field 'Custom Code Field Editable' on Additional information section of order item page


Scenario: check user can't edit custom code field on ordering page when BU admin sets FIELD-IS-EDITABLE as FALSE
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| ACADTCGA6 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| ACADTCGU6   | agency.admin | ACADTCGA6    |
| ACADTCGU6_1 | agency.admin | ACADTCGA6  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ACADTCGA6':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARACADTCG6 | BRACADTCG6 | SBACADTCG6 | PRACADTCG6 |
And logged in with details of 'ACADTCGU6'
And I am on the 'common custom' metadata page
And clicked 'Custom Code' button in 'Custom Metadata' section on opened metadata page
And filled Description field with text 'Custom Code Field Not Editable' on opened Settings and Customization tab
And unchecked 'Field is editable' checkbox on opened string field Settings and Customization page
And checked 'Make this field available in Delivery' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I am on the 'common custom' metadata page
And clicked 'Custom Code Field Not Editable' button in 'Common Metadata' section on opened metadata page
And filled following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Sequence Characters | Metadata Elements  | Metadata Name                      | Metadata Characters |
| ACADTCGC6 | 5                   | should             | Advertiser,Brand,Sub Brand,Product | 3,2,1,1             |
And saved metadata field settings
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand      | Sub Brand  | Product    | Duration | Title     |
| ARACADTCG6 | BRACADTCG6 | SBACADTCG6 | PRACADTCG6 | 20       | ACADTCGT6 |
When I open order item with next title 'ACADTCGT6'
And generate auto code value for field 'Custom Code Field Not Editable' on Additional information section of order item page
Then I should see following auto generated code '\d{2,5}ARABRSP' for field 'Custom Code Field Not Editable' on Additional information section of order item page
And should see 'Custom Code Field Not Editable' field 'disabled' on Additional information section of order item page