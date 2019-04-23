!--NGN-7056
Feature:          Custom metadata - CM type - Advertiser and descendants on Metadata editor
Narrative:
In order to:
As a              GlobalAdmin
I want to         check value for Advertiser and descendants on Metadata editor

Scenario: Check creation value of Advertiser with childs on Metadata editor
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S01' with default attributes
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S01'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S01 | B_CMCMTAAD_S01 | SB_CMCMTAAD_S01 | PT_CMCMTAAD_S01 |
When I go to the global 'common custom' metadata page for agency 'A_CMCMTAAD_S01'
Then I 'should' see following Advertiser chain on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S01 | B_CMCMTAAD_S01 | SB_CMCMTAAD_S01 | PT_CMCMTAAD_S01 |


Scenario: Check renaming of Advertiser with childs on Metadata editor
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S13' with default attributes
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S13'
And updated Catalogue Structure 'Advertiser' in section 'Common Metadata' with following descriptions:
| ItemName   | Description        |
| Advertiser | CMFAR_CMCMTAAD_S13 |
| Brand      | CMFB_CMCMTAAD_S13  |
| Sub Brand  | CMFSB_CMCMTAAD_S13 |
| Product    | CMFPT_CMCMTAAD_S13 |
Then I 'Description' see following Catalogue Structure descriptions on opened Settings and Customization page:
| FieldValue         |
| CMFAR_CMCMTAAD_S13 |
| CMFB_CMCMTAAD_S13  |
| CMFSB_CMCMTAAD_S13 |
| CMFPT_CMCMTAAD_S13 |


Scenario: Check deletion value of Advertiser with childs on Metadata editor
Meta:@gdam
@globaladmin
Given I created the agency 'A_CMCMTAAD_S19' with default attributes
And logged in with details of 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S19'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S19 | B_CMCMTAAD_S19 | SB_CMCMTAAD_S19 | PT_CMCMTAAD_S19 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S19'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
When I delete Advertiser chain 'AR_CMCMTAAD_S19' on opened Settings and Customization page
And go to the global 'common custom' metadata page for agency 'A_CMCMTAAD_S19'
Then I 'should not' see following Advertiser chain on Settings and Customization page:
| Advertiser      |
| AR_CMCMTAAD_S19 |


Scenario: Check hidding value of Advertiser with childs on Metadata editor
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S29' with default attributes
And created users with following fields:
| Email             | Role         |  AgencyUnique  |
| U_CMCMTAAD_S22    | agency.admin | A_CMCMTAAD_S29 |
And I logged in with details of 'U_CMCMTAAD_S22'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S29'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I go to the global 'common custom' metadata page for agency 'A_CMCMTAAD_S29'
Then I 'should not' see field 'Advertiser,Brand,Sub Brand,Product' in Active Metadata Preview block on opened metadata page


Scenario: Check that after hiding any hierarchy level - all children of that level should be hidden by default on Metadata editor page
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S35' with default attributes
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S35'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
Then I should see following Catalogue Structure items with selected 'hide' option on opened Settings and Customization page:
| Item       | Condition |
| Advertiser | should    |
| Brand      | should    |
| Sub Brand  | should    |
| Product    | should    |


Scenario: Check that when user un-hides any hierarchy level - all parents of that level should be un-hidden by default on Metadata editor page
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S37' with default attributes
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S37'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S37'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And clicked hierarchy navigation bar item 'Product' on opened Settings and Customization tab
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
Then I should see following Catalogue Structure items with selected 'hide' option on opened Settings and Customization page:
| Item       | Condition  |
| Advertiser | should not |
| Brand      | should not |
| Sub Brand  | should not |
| Product    | should not |


Scenario: Check that when user un-hides any hierarchy level(except the last one) - confirm dialog should appear and asks whether children of that level should be un-hidden
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S39' with default attributes
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S39'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page
Then I should see following Catalogue Structure items with selected 'hide' option on opened Settings and Customization page:
| Item       | Condition  |
| Advertiser | should not |
| Brand      | should not |
| Sub Brand  | should not |
| Product    | should not |


Scenario: Check compulsory value of Advertiser with childs on Metadata editor
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S41' with default attributes
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S41'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
When I check 'make it compulsory' following catalogue structure items on opened Settings and Customization page:
| Item       |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
Then I 'should' see field 'Advertiser,Brand,Sub Brand,Product' marked as required in Active Metadata Preview block on opened metadata page


Scenario: Check that added product field in Digital assets is available in CCM
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S45' with default attributes
And on the global 'video asset' metadata page for agency 'A_CMCMTAAD_S45'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
When I check 'make it compulsory' following catalogue structure items on opened Settings and Customization page:
| Item       |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
Then I 'should' see field 'Advertiser,Brand,Sub Brand,Product' marked as required in Active Metadata Preview block on opened metadata page


Scenario: Check changing of field size value for Advertiser with childs on Metadata editor
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S46' with default attributes
And on the global 'project' metadata page for agency 'A_CMCMTAAD_S46'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And selected following catalogue structure items size on opened Settings and Customization page:
| Item       | Size            |
| Advertiser | <FieldBaseSize> |
| Brand      | <FieldBaseSize> |
| Sub Brand  | <FieldBaseSize> |
| Product    | <FieldBaseSize> |
When I go to the global 'project' metadata page for agency 'A_CMCMTAAD_S46'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And update following catalogue structure items size on opened Settings and Customization page:
| Item       | Size               |
| Advertiser | <FieldUpdatedSize> |
| Brand      | <FieldUpdatedSize> |
| Sub Brand  | <FieldUpdatedSize> |
| Product    | <FieldUpdatedSize> |
Then I 'should' see field 'Advertiser,Brand,Sub Brand,Product' with size '<FieldUpdatedSize>' on opened Active Metadata Preview

Examples:
| FieldBaseSize | FieldUpdatedSize |
| Full Width    | Half Width       |
| Half Width    | Full Width       |


Scenario: Check that Advertiser with childs created by agency admin is visible for global admin in Metadata editor
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S52' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S52 | agency.admin | A_CMCMTAAD_S52 |
And logged in with details of 'U_CMCMTAAD_S52'
And on the 'common custom' metadata page
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S52 | B_CMCMTAAD_S52 | SB_CMCMTAAD_S52 | PT_CMCMTAAD_S52 |
When I login with details of 'GlobalAdmin'
And go to the global 'common custom' metadata page for agency 'A_CMCMTAAD_S52'
Then I 'should' see following Advertiser chain on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S52 | B_CMCMTAAD_S52 | SB_CMCMTAAD_S52 | PT_CMCMTAAD_S52 |


Scenario: Check that Advertiser with childs created by agency admin shouldn't be visible for for agency admin from another agency
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S53_1' with default attributes
And created the agency 'A_CMCMTAAD_S53_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_CMCMTAAD_S53_1 | agency.admin | A_CMCMTAAD_S53_1 |
| U_CMCMTAAD_S53_2 | agency.admin | A_CMCMTAAD_S53_2 |
And logged in with details of 'U_CMCMTAAD_S53_1'
And on the 'common custom' metadata page
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S53 | B_CMCMTAAD_S53 | SB_CMCMTAAD_S53 | PT_CMCMTAAD_S53 |
When I login with details of 'U_CMCMTAAD_S53_2'
And go to the 'common custom' metadata page
Then I 'should not' see following Advertiser chain on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S53 | B_CMCMTAAD_S53 | SB_CMCMTAAD_S53 | PT_CMCMTAAD_S53 |