!--NGN-7056
Feature:          Custom metadata - CM type - Advertiser and descendants on Project
Narrative:
In order to:
As a              GlobalAdmin
I want to         check value for Advertiser and descendants on Project

Scenario: Check appearance value of Advertiser with childs on New Project
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S02' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S02 | agency.admin | A_CMCMTAAD_S02 |
And logged in with details of 'U_CMCMTAAD_S02'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S02'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S02 | B_CMCMTAAD_S02 | SB_CMCMTAAD_S02 | PT_CMCMTAAD_S02 |
When I login with details of 'U_CMCMTAAD_S02'
Then I 'should' see following Advertiser chain on Create New Project popup:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S02 | B_CMCMTAAD_S02 | SB_CMCMTAAD_S02 | PT_CMCMTAAD_S02 |


Scenario: Check appearance value of Advertiser with childs on Project Overview
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S03' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S03 | agency.admin | A_CMCMTAAD_S03 |
And logged in with details of 'U_CMCMTAAD_S03'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S03'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S03 | B_CMCMTAAD_S03 | SB_CMCMTAAD_S03 | PT_CMCMTAAD_S03 |
When I login with details of 'U_CMCMTAAD_S03'
And create new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S03  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S03 |
| Brand      | B_CMCMTAAD_S03  |
| Sub Brand  | SB_CMCMTAAD_S03 |
| Product    | PT_CMCMTAAD_S03 |
| Start date | Today           |
| End date   | Tomorrow        |
Then I 'should' see following fields on opened Project Overview page:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S03 |
| Brand      | B_CMCMTAAD_S03  |
| Sub Brand  | SB_CMCMTAAD_S03 |
| Product    | PT_CMCMTAAD_S03 |


Scenario: Check appearance value of Advertiser with childs on Edit Project
Meta:@globaladmin
      @gdam
Given I created the agency 'A_CMCMTAAD_S04' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S04 | agency.admin | A_CMCMTAAD_S04 |
And logged in with details of 'U_CMCMTAAD_S04'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S04'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S04 | B_CMCMTAAD_S04 | SB_CMCMTAAD_S04 | PT_CMCMTAAD_S04 |
When I login with details of 'U_CMCMTAAD_S04'
And create new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S04  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S04 |
| Brand      | B_CMCMTAAD_S04  |
| Sub Brand  | SB_CMCMTAAD_S04 |
| Product    | PT_CMCMTAAD_S04 |
| Start date | Today           |
| End date   | Tomorrow        |
And open project 'P_CMCMTAAD_S04' settings page
Then I 'should' see following fields on opened Edit Project popup:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S04 |
| Brand      | B_CMCMTAAD_S04  |
| Sub Brand  | SB_CMCMTAAD_S04 |
| Product    | PT_CMCMTAAD_S04 |


Scenario: Check editing data value Advertiser with childs for Projects (Add on fly)
!--FAB-412 logged on 04/08/2017
Meta:@globaladmin
     @gdam
     @bug
Given I created the agency 'A_CMCMTAAD_S07' with default attributes
And created users with following fields:
| Email           | Role         | AgencyUnique   |
| U_CMCMTAAD_S07N | agency.admin | A_CMCMTAAD_S07 |
And opened role 'agency.admin' page with parent 'A_CMCMTAAD_S07'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'newrole_S07'
And I clicked element 'SaveButton' on page 'Roles'
And added following permissions 'dictionary.add_on_the_fly' to role 'newrole_S07' in agency 'A_CMCMTAAD_S07'
And logged in with details of 'U_CMCMTAAD_S07N'
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S07 | newrole_S07 | A_CMCMTAAD_S07 |
And logged in with details of 'U_CMCMTAAD_S07'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S07'
And created following Advertiser chain with checked 'Add values on the fly' checkbox on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S07 | B_CMCMTAAD_S07 | SB_CMCMTAAD_S07 | PT_CMCMTAAD_S07 |
When I create new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S07  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S07 |
| Brand      | B_CMCMTAAD_S07  |
| Sub Brand  | SB_CMCMTAAD_S07 |
| Product    | PT_CMCMTAAD_S07 |
| Start date | Today           |
| End date   | Tomorrow        |
And update project 'P_CMCMTAAD_S07' with following fields on Edit Project popup:
| FieldName  | FieldValue        |
| Advertiser | U_AR_CMCMTAAD_S07 |
| Brand      | U_B_CMCMTAAD_S07  |
| Sub Brand  | U_SB_CMCMTAAD_S07 |
| Product    | U_PT_CMCMTAAD_S07 |
| Name       | U_P_CMCMTAAD_S07  |
Then I 'should' see following fields on opened Project Overview page:
| FieldName  | FieldValue        |
| Advertiser | U_AR_CMCMTAAD_S07 |
| Brand      | U_B_CMCMTAAD_S07  |
| Sub Brand  | U_SB_CMCMTAAD_S07 |
| Product    | U_PT_CMCMTAAD_S07 |
| Name       | U_P_CMCMTAAD_S07  |

Scenario: Check editing data value Advertiser with childs for Projects (Several advertiser available)
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S08' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S08 | agency.admin | A_CMCMTAAD_S08 |
And logged in with details of 'U_CMCMTAAD_S08'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S08'
And created following Advertiser chain with checked 'multiple choices' checkbox on Settings and Customization page:
| Advertiser        | Brand            | Sub Brand         | Product           |
| AR_CMCMTAAD_S08_1 | B_CMCMTAAD_S08_1 | SB_CMCMTAAD_S08_1 | PT_CMCMTAAD_S08_1 |
| AR_CMCMTAAD_S08_2 | B_CMCMTAAD_S08_2 | SB_CMCMTAAD_S08_2 | PT_CMCMTAAD_S08_2 |
| AR_CMCMTAAD_S08_2 | B_CMCMTAAD_S08_2 | SB_CMCMTAAD_S08_3 | PT_CMCMTAAD_S08_3 |
When I create new project with following fields:
| FieldName  | FieldValue        |
| Name       | P_CMCMTAAD_S08    |
| Media type | Broadcast         |
| Advertiser | AR_CMCMTAAD_S08_1 |
| Brand      | B_CMCMTAAD_S08_1  |
| Sub Brand  | SB_CMCMTAAD_S08_1 |
| Product    | PT_CMCMTAAD_S08_1 |
| Start date | Today             |
| End date   | Tomorrow          |
And update project 'P_CMCMTAAD_S08' with following fields on Edit Project popup:
| FieldName  | FieldValue                          |
| Advertiser | AR_CMCMTAAD_S08_2                   |
| Brand      | B_CMCMTAAD_S08_2                    |
| Sub Brand  | SB_CMCMTAAD_S08_2,SB_CMCMTAAD_S08_3 |
Then I 'should' see following fields on opened Project Overview page:
| FieldName  | FieldValue                          |
| Advertiser | AR_CMCMTAAD_S08_2                   |
| Brand      | B_CMCMTAAD_S08_2                    |
| Sub Brand  | SB_CMCMTAAD_S08_2,SB_CMCMTAAD_S08_3 |


Scenario: Check editing data value Advertiser with childs for Projects (Add on fly + Several advertiser available)
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S09' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S09 | agency.admin | A_CMCMTAAD_S09 |
And logged in with details of 'U_CMCMTAAD_S09'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S09'
And created following Advertiser chain with checked 'multiple choices,Add values on the fly' checkbox on Settings and Customization page:
| Advertiser        | Brand            | Sub Brand         | Product           |
| AR_CMCMTAAD_S09_1 | B_CMCMTAAD_S09_1 | SB_CMCMTAAD_S09_1 | PT_CMCMTAAD_S09_1 |
| AR_CMCMTAAD_S09_2 | B_CMCMTAAD_S09_2 | SB_CMCMTAAD_S09_2 | PT_CMCMTAAD_S09_2 |
| AR_CMCMTAAD_S09_2 | B_CMCMTAAD_S09_2 | SB_CMCMTAAD_S09_3 | PT_CMCMTAAD_S09_3 |
When I create new project with following fields:
| FieldName  | FieldValue        |
| Name       | P_CMCMTAAD_S09    |
| Media type | Broadcast         |
| Advertiser | AR_CMCMTAAD_S09_1 |
| Brand      | B_CMCMTAAD_S09_1  |
| Sub Brand  | SB_CMCMTAAD_S09_1 |
| Product    | PT_CMCMTAAD_S09_1 |
| Start date | Today             |
| End date   | Tomorrow          |
And update project 'P_CMCMTAAD_S09' with following fields on Edit Project popup:
| FieldName  | FieldValue                                           |
| Advertiser | AR_CMCMTAAD_S09_2                                    |
| Brand      | B_CMCMTAAD_S09_2                                     |
| Sub Brand  | SB_CMCMTAAD_S09_2,SB_CMCMTAAD_S09_3,FSB_CMCMTAAD_S09 |
Then I 'should' see following fields on opened Project Overview page:
| FieldName  | FieldValue                                           |
| Advertiser | AR_CMCMTAAD_S09_2                                    |
| Brand      | B_CMCMTAAD_S09_2                                     |
| Sub Brand  | SB_CMCMTAAD_S09_2,SB_CMCMTAAD_S09_3,FSB_CMCMTAAD_S09 |


Scenario: Check renaming of Advertiser with childs on New Project
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S14' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S14 | agency.admin | A_CMCMTAAD_S14 |
And logged in with details of 'U_CMCMTAAD_S14'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S14'
And updated Catalogue Structure 'Advertiser' in section 'Common Metadata' with following descriptions:
| ItemName   | Description        |
| Advertiser | CMFAR_CMCMTAAD_S14 |
| Brand      | CMFB_CMCMTAAD_S14  |
| Sub Brand  | CMFSB_CMCMTAAD_S14 |
| Product    | CMFPT_CMCMTAAD_S14 |
When I login with details of 'U_CMCMTAAD_S14'
Then I 'should' see metadata field 'CMFAR_CMCMTAAD_S14' on New Project popup
And 'should' see metadata field 'CMFB_CMCMTAAD_S14' on New Project popup
And 'should' see metadata field 'CMFSB_CMCMTAAD_S14' on New Project popup
And 'should' see metadata field 'CMFPT_CMCMTAAD_S14' on New Project popup


Scenario: Check renaming of Advertiser with childs on Project Overview
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S15' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S15 | agency.admin | A_CMCMTAAD_S15 |
And logged in with details of 'U_CMCMTAAD_S15'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S15'
And updated Catalogue Structure 'Advertiser' in section 'Common Metadata' with following descriptions:
| ItemName   | Description        |
| Advertiser | CMFAR_CMCMTAAD_S15 |
| Brand      | CMFB_CMCMTAAD_S15  |
| Sub Brand  | CMFSB_CMCMTAAD_S15 |
| Product    | CMFPT_CMCMTAAD_S15 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S15'
And created following Catalogue Structure chain for field 'CMFAR_CMCMTAAD_S15' on opened metadata page in 'Common Metadata' section:
| ChainItem          |
| CMVAR_CMCMTAAD_S15 |
| CMVB_CMCMTAAD_S15  |
| CMVSB_CMCMTAAD_S15 |
| CMVPT_CMCMTAAD_S15 |
When I login with details of 'U_CMCMTAAD_S15'
And create new project with following fields:
| FieldName          | FieldValue         |
| Name               | P_CMCMTAAD_S15     |
| Media type         | Broadcast          |
| CMFAR_CMCMTAAD_S15 | CMVAR_CMCMTAAD_S15 |
| CMFB_CMCMTAAD_S15  | CMVB_CMCMTAAD_S15  |
| CMFSB_CMCMTAAD_S15 | CMVSB_CMCMTAAD_S15 |
| CMFPT_CMCMTAAD_S15 | CMVPT_CMCMTAAD_S15 |
| Start date         | Today              |
| End date           | Tomorrow           |
Then I 'should' see following fields on opened Project Overview page:
| FieldName          | FieldValue         |
| CMFAR_CMCMTAAD_S15 | CMVAR_CMCMTAAD_S15 |
| CMFB_CMCMTAAD_S15  | CMVB_CMCMTAAD_S15  |
| CMFSB_CMCMTAAD_S15 | CMVSB_CMCMTAAD_S15 |
| CMFPT_CMCMTAAD_S15 | CMVPT_CMCMTAAD_S15 |


Scenario: Check renaming of Advertiser with childs on Edit Project
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S16' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S16 | agency.admin | A_CMCMTAAD_S16 |
And logged in with details of 'U_CMCMTAAD_S16'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S16'
And updated Catalogue Structure 'Advertiser' in section 'Common Metadata' with following descriptions:
| ItemName   | Description        |
| Advertiser | CMFAR_CMCMTAAD_S16 |
| Brand      | CMFB_CMCMTAAD_S16  |
| Sub Brand  | CMFSB_CMCMTAAD_S16 |
| Product    | CMFPT_CMCMTAAD_S16 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S16'
And created following Catalogue Structure chain for field 'CMFAR_CMCMTAAD_S16' on opened metadata page in 'Common Metadata' section:
| ChainItem          |
| CMVAR_CMCMTAAD_S16 |
| CMVB_CMCMTAAD_S16  |
| CMVSB_CMCMTAAD_S16 |
| CMVPT_CMCMTAAD_S16 |
When I login with details of 'U_CMCMTAAD_S16'
And create new project with following fields:
| FieldName          | FieldValue         |
| Name               | P_CMCMTAAD_S16     |
| Media type         | Broadcast          |
| CMFAR_CMCMTAAD_S16 | CMVAR_CMCMTAAD_S16 |
| CMFB_CMCMTAAD_S16  | CMVB_CMCMTAAD_S16  |
| CMFSB_CMCMTAAD_S16 | CMVSB_CMCMTAAD_S16 |
| CMFPT_CMCMTAAD_S16 | CMVPT_CMCMTAAD_S16 |
| Start date         | Today              |
| End date           | Tomorrow           |
And open project 'P_CMCMTAAD_S16' settings page
Then I 'should' see following fields on opened Edit Project popup:
| FieldName          | FieldValue         |
| CMFAR_CMCMTAAD_S16 | CMVAR_CMCMTAAD_S16 |
| CMFB_CMCMTAAD_S16  | CMVB_CMCMTAAD_S16  |
| CMFSB_CMCMTAAD_S16 | CMVSB_CMCMTAAD_S16 |
| CMFPT_CMCMTAAD_S16 | CMVPT_CMCMTAAD_S16 |


Scenario: Check deletion value of Advertiser with childs on New Project
Meta:@gdam
@projects
Given I created the agency 'A_CMCMTAAD_S20' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S20 | agency.admin | A_CMCMTAAD_S20 |
And logged in with details of 'U_CMCMTAAD_S20'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S20'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S20 | B_CMCMTAAD_S20 | SB_CMCMTAAD_S20 | PT_CMCMTAAD_S20 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S20'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
When I delete Advertiser chain 'AR_CMCMTAAD_S20' on opened Settings and Customization page
When I login with details of 'U_CMCMTAAD_S20'
Then I 'should not' see following Advertiser chain on Create New Project popup:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S20 | B_CMCMTAAD_S20 | SB_CMCMTAAD_S20 | PT_CMCMTAAD_S20 |


Scenario: Check that deleted value of Advertiser with childs is available for previously created project on Edit Project
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S21' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S21 | agency.admin | A_CMCMTAAD_S21 |
And logged in with details of 'U_CMCMTAAD_S21'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S21'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S21 | B_CMCMTAAD_S21 | SB_CMCMTAAD_S21 | PT_CMCMTAAD_S21 |
When I login with details of 'U_CMCMTAAD_S21'
And create new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S21  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S21 |
| Brand      | B_CMCMTAAD_S21  |
| Sub Brand  | SB_CMCMTAAD_S21 |
| Product    | PT_CMCMTAAD_S21 |
| Start date | Today           |
| End date   | Tomorrow        |
And login with details of 'GlobalAdmin'
And go to the global 'common custom' metadata page for agency 'A_CMCMTAAD_S21'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And delete Advertiser chain 'AR_CMCMTAAD_S21' on opened Settings and Customization page
And login with details of 'U_CMCMTAAD_S21'
And open project 'P_CMCMTAAD_S21' settings page
Then I 'should' see following fields on opened Edit Project popup:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S21 |
| Brand      | B_CMCMTAAD_S21  |
| Sub Brand  | SB_CMCMTAAD_S21 |
| Product    | PT_CMCMTAAD_S21 |


Scenario: Check hidding value of Advertiser with childs on New Project
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S30' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S30 | agency.admin | A_CMCMTAAD_S30 |
And logged in with details of 'U_CMCMTAAD_S30'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S30'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I login with details of 'U_CMCMTAAD_S30'
Then I 'should not' see metadata field 'Advertiser,Brand,Sub Brand,Product' on New Project popup


Scenario: Check hidding value of Advertiser with childs on Project Overview
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S31' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S31 | agency.admin | A_CMCMTAAD_S31 |
And logged in with details of 'U_CMCMTAAD_S31'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S31'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S31 | B_CMCMTAAD_S31 | SB_CMCMTAAD_S31 | PT_CMCMTAAD_S31 |
And logged in with details of 'U_CMCMTAAD_S31'
And created new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S31  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S31 |
| Brand      | B_CMCMTAAD_S31  |
| Sub Brand  | SB_CMCMTAAD_S31 |
| Product    | PT_CMCMTAAD_S31 |
| Start date | Today           |
| End date   | Tomorrow        |
And logged in with details of 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S31'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I login with details of 'U_CMCMTAAD_S31'
Then I 'should not' see following fields on opened Project 'P_CMCMTAAD_S31' Overview page:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S31 |
| Brand      | B_CMCMTAAD_S31  |
| Sub Brand  | SB_CMCMTAAD_S31 |
| Product    | PT_CMCMTAAD_S31 |


Scenario: Check hidding value of Advertiser with childs on Edit Project
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S32' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S32 | agency.admin | A_CMCMTAAD_S32 |
And logged in with details of 'U_CMCMTAAD_S32'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S32'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S32 | B_CMCMTAAD_S32 | SB_CMCMTAAD_S32 | PT_CMCMTAAD_S32 |
And logged in with details of 'U_CMCMTAAD_S32'
And created new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S32  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S32 |
| Brand      | B_CMCMTAAD_S32  |
| Sub Brand  | SB_CMCMTAAD_S32 |
| Product    | PT_CMCMTAAD_S32 |
| Start date | Today           |
| End date   | Tomorrow        |
And logged in with details of 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S32'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And waited for '3' seconds
When I login with details of 'U_CMCMTAAD_S32'
And wait for '3' seconds
And open project 'P_CMCMTAAD_S32' settings page
Then I 'should not' see following fields on opened Edit Project popup:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S32 |
| Brand      | B_CMCMTAAD_S32  |
| Sub Brand  | SB_CMCMTAAD_S32 |
| Product    | PT_CMCMTAAD_S32 |


Scenario: Check that after hiding any ld be hidden by defauhierarchy level - all children of that level shoult on new Project Page
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S36' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S36 | agency.admin | A_CMCMTAAD_S36 |
And logged in with details of 'U_CMCMTAAD_S36'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S36'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And clicked hierarchy navigation bar item 'Sub Brand' on opened Settings and Customization tab
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I login with details of 'U_CMCMTAAD_S36'
Then I 'should' see metadata field 'Advertiser,Brand' on New Project popup
And 'should not' see metadata field 'Sub Brand,Product' on New Project popup


Scenario: Check that when user un-hides any hierarchy level - all parents of that level should be un-hidden by default on Edit project page
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S38' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S38 | agency.admin | A_CMCMTAAD_S38 |
And logged in with details of 'U_CMCMTAAD_S38'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S38'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S38 | B_CMCMTAAD_S38 | SB_CMCMTAAD_S38 | PT_CMCMTAAD_S38 |
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And created new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S38  |
| Media type | Broadcast       |
| Start date | Today           |
| End date   | Tomorrow        |
And logged in with details of 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S38'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And clicked hierarchy navigation bar item 'Product' on opened Settings and Customization tab
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I login with details of 'U_CMCMTAAD_S38'
And open project 'P_CMCMTAAD_S38' settings page
Then I 'should' see following fields on opened Edit Project popup:
| FieldName  | FieldValue      |
| Advertiser |                 |
| Brand      |                 |
| Sub Brand  |                 |
| Product    |                 |


Scenario: Check compulsory value of Advertiser with childs on New Project
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTAAD_S42' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S42 | agency.admin | A_CMCMTAAD_S42 |
And logged in with details of 'U_CMCMTAAD_S42'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S42'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S42 | B_CMCMTAAD_S42 | SB_CMCMTAAD_S42 | PT_CMCMTAAD_S42 |
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'make it compulsory' following catalogue structure items on opened Settings and Customization page:
| Item       |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
When I open Create New Project popup
And fill following fields on Create New Project popup:
| FieldName  | FieldValue        |
| Name       | P_CMCMTAAD_S42    |
| Media type | Broadcast         |
| Advertiser | <AdvertiserValue> |
| Brand      | <BrandValue>      |
| Sub Brand  | <SubBrandValue>   |
| Product    | <ProductValue>    |
| Start date | Today             |
| End date   | Tomorrow          |
Then I 'should' see metadata field 'Advertiser,Brand,Sub Brand,Product' marked as required on New Project popup
And '<Condition>' see element 'ActiveSaveButton' on page 'CreateNewProjectPopUp'

Examples:
| AdvertiserValue | BrandValue     | SubBrandValue   | ProductValue    | Condition  |
|                 |                |                 |                 | should not |
| AR_CMCMTAAD_S42 |                |                 |                 | should not |
| AR_CMCMTAAD_S42 | B_CMCMTAAD_S42 |                 |                 | should not |
| AR_CMCMTAAD_S42 | B_CMCMTAAD_S42 | SB_CMCMTAAD_S42 |                 | should not |
| AR_CMCMTAAD_S42 | B_CMCMTAAD_S42 | SB_CMCMTAAD_S42 | PT_CMCMTAAD_S42 | should     |


Scenario: Check compulsory value of Advertiser with childs on Edit Project
!--FAB-412 logged on 04/08/2017
Meta:@globaladmin
     @gdam
     @bug
Given I created the agency 'A_CMCMTAAD_S43' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique   |
| U_CMCMTAAD_S43_N | agency.admin | A_CMCMTAAD_S43 |
And opened role 'agency.admin' page with parent 'A_CMCMTAAD_S43'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'newrole_S43'
And I clicked element 'SaveButton' on page 'Roles'
And added following permissions 'dictionary.add_on_the_fly' to role 'newrole_S43' in agency 'A_CMCMTAAD_S43'
And logged in with details of 'U_CMCMTAAD_S43_N'
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S43 | newrole_S43  | A_CMCMTAAD_S43 |
And logged in with details of 'U_CMCMTAAD_S43'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S43'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'add values on the fly' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And checked 'make it compulsory' following catalogue structure items on opened Settings and Customization page:
| Item       |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
When I create new project with following fields:
| FieldName  | FieldValue      |
| Name       | <ProjectName>   |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S43 |
| Brand      | B_CMCMTAAD_S43  |
| Sub Brand  | SB_CMCMTAAD_S43 |
| Product    | PT_CMCMTAAD_S43 |
| Start date | Today           |
| End date   | Tomorrow        |
And open project '<ProjectName>' settings page
And update following fields on Edit Project popup:
| FieldName  | FieldValue        |
| Advertiser | <AdvertiserValue> |
| Brand      | <BrandValue>      |
| Sub Brand  | <SubBrandValue>   |
| Product    | <ProductValue>    |
| Start date | Today             |
| End date   | Tomorrow          |
Then I 'should' see metadata field 'Advertiser,Brand,Sub Brand,Product' marked as required on opened Edit Project popup
And '<Condition>' see element 'ActiveSaveButton' on page 'EditProjectPopUp'

Examples:
| AdvertiserValue | BrandValue     | SubBrandValue   | ProductValue    | Condition  | ProjectName      |
|                 |                |                 |                 | should not | P_CMCMTAAD_S43_1 |
| AR_CMCMTAAD_S43 |                |                 |                 | should not | P_CMCMTAAD_S43_2 |
| AR_CMCMTAAD_S43 | B_CMCMTAAD_S43 |                 |                 | should not | P_CMCMTAAD_S43_3 |
| AR_CMCMTAAD_S43 | B_CMCMTAAD_S43 | SB_CMCMTAAD_S43 |                 | should not | P_CMCMTAAD_S43_4 |
| AR_CMCMTAAD_S43 | B_CMCMTAAD_S43 | SB_CMCMTAAD_S43 | PT_CMCMTAAD_S43 | should     | P_CMCMTAAD_S43_5 |


Scenario: Check changing of field size value for Advertiser with childs on New Project
Meta:@globaladmin
     @gdam
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <AgencyName> |
And logged in with details of '<UserEmail>'
And on the global 'project' metadata page for agency '<AgencyName>'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And selected following catalogue structure items size on opened Settings and Customization page:
| Item       | Size            |
| Advertiser | <FieldBaseSize> |
| Brand      | <FieldBaseSize> |
| Sub Brand  | <FieldBaseSize> |
| Product    | <FieldBaseSize> |
When I go to the global 'project' metadata page for agency '<AgencyName>'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And update following catalogue structure items size on opened Settings and Customization page:
| Item       | Size               |
| Advertiser | <FieldUpdatedSize> |
| Brand      | <FieldUpdatedSize> |
| Sub Brand  | <FieldUpdatedSize> |
| Product    | <FieldUpdatedSize> |
When I login with details of '<UserEmail>'
Then I 'should' see field 'Advertiser,Brand,Sub Brand,Product' with size '<FieldUpdatedSize>' on New Project popup

Examples:
| AgencyName       | UserEmail        | FieldBaseSize | FieldUpdatedSize |
| A_CMCMTAAD_S47_1 | U_CMCMTAAD_S47_1 | Full Width    | Half Width       |
| A_CMCMTAAD_S47_2 | U_CMCMTAAD_S47_2 | Half Width    | Full Width       |


Scenario: Check changing of field size value for Advertiser with childs on Project Overview
Meta:@globaladmin
     @gdam
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <AgencyName> |
And logged in with details of '<UserEmail>'
And on the global 'project' metadata page for agency '<AgencyName>'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S48 | B_CMCMTAAD_S48 | SB_CMCMTAAD_S48 | PT_CMCMTAAD_S48 |
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And selected following catalogue structure items size on opened Settings and Customization page:
| Item       | Size            |
| Advertiser | <FieldBaseSize> |
| Brand      | <FieldBaseSize> |
| Sub Brand  | <FieldBaseSize> |
| Product    | <FieldBaseSize> |
When I go to the global 'project' metadata page for agency '<AgencyName>'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And update following catalogue structure items size on opened Settings and Customization page:
| Item       | Size               |
| Advertiser | <FieldUpdatedSize> |
| Brand      | <FieldUpdatedSize> |
| Sub Brand  | <FieldUpdatedSize> |
| Product    | <FieldUpdatedSize> |
When I login with details of '<UserEmail>'
And create new project with following fields:
| FieldName  | FieldValue      |
| Name       | <ProjectName>   |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S48 |
| Brand      | B_CMCMTAAD_S48  |
| Sub Brand  | SB_CMCMTAAD_S48 |
| Product    | PT_CMCMTAAD_S48 |
| Start date | Today           |
| End date   | Tomorrow        |
Then I 'should' see field 'Advertiser,Brand,Sub Brand,Product' with size '<FieldUpdatedSize>' on opened Project overview page

Examples:
| AgencyName       | UserEmail        | ProjectName      | FieldBaseSize | FieldUpdatedSize |
| A_CMCMTAAD_S48_1 | U_CMCMTAAD_S48_1 | P_CMCMTAAD_S48_1 | Full Width    | Half Width       |
| A_CMCMTAAD_S48_2 | U_CMCMTAAD_S48_2 | P_CMCMTAAD_S48_2 | Half Width    | Full Width       |


Scenario: Check changing of field size value for Advertiser with childs on Edit Project
Meta:@globaladmin
     @gdam
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <AgencyName> |
And logged in with details of '<UserEmail>'
And on the global 'project' metadata page for agency '<AgencyName>'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S49 | B_CMCMTAAD_S49 | SB_CMCMTAAD_S49 | PT_CMCMTAAD_S49 |
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And selected following catalogue structure items size on opened Settings and Customization page:
| Item       | Size            |
| Advertiser | <FieldBaseSize> |
| Brand      | <FieldBaseSize> |
| Sub Brand  | <FieldBaseSize> |
| Product    | <FieldBaseSize> |
When I go to the global 'project' metadata page for agency '<AgencyName>'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And update following catalogue structure items size on opened Settings and Customization page:
| Item       | Size               |
| Advertiser | <FieldUpdatedSize> |
| Brand      | <FieldUpdatedSize> |
| Sub Brand  | <FieldUpdatedSize> |
| Product    | <FieldUpdatedSize> |
When I login with details of '<UserEmail>'
And create new project with following fields:
| FieldName  | FieldValue      |
| Name       | <ProjectName>   |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S49 |
| Brand      | B_CMCMTAAD_S49  |
| Sub Brand  | SB_CMCMTAAD_S49 |
| Product    | PT_CMCMTAAD_S49 |
| Start date | Today           |
| End date   | Tomorrow        |
And open project '<ProjectName>' settings page
Then I 'should' see field 'Advertiser,Brand,Sub Brand,Product' with size '<FieldUpdatedSize>' on opened Edit Project popup

Examples:
| AgencyName       | UserEmail        | ProjectName      | FieldBaseSize | FieldUpdatedSize |
| A_CMCMTAAD_S49_1 | U_CMCMTAAD_S49_1 | P_CMCMTAAD_S49_1 | Full Width    | Half Width       |
| A_CMCMTAAD_S49_2 | U_CMCMTAAD_S49_2 | P_CMCMTAAD_S49_2 | Half Width    | Full Width       |


Scenario: Check that if select multiply parent then all child shouldn't be available on create new project page
Meta:@globaladmin
     @gdam
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <AgencyName> |
And logged in with details of '<UserEmail>'
And on the global 'common custom' metadata page for agency '<AgencyName>'
And created following Advertiser chain with checked 'multiple choices' checkbox on Settings and Customization page:
| Advertiser        | Brand            | Sub Brand         | Product           |
| AR_CMCMTAAD_S54_1 | B_CMCMTAAD_S54_1 | SB_CMCMTAAD_S54_1 | PT_CMCMTAAD_S54_1 |
| AR_CMCMTAAD_S54_1 | B_CMCMTAAD_S54_2 | SB_CMCMTAAD_S54_2 | PT_CMCMTAAD_S54_2 |
When open Create New Project popup
And fill following fields on Create New Project popup:
| FieldName  | FieldValue                        |
| Name       | <ProjectName>                     |
| Media type | Broadcast                         |
| Advertiser | AR_CMCMTAAD_S54_1                 |
| Brand      | B_CMCMTAAD_S54_1,B_CMCMTAAD_S54_2 |
| Start date | Today                             |
| End date   | Tomorrow                          |
Then I 'should' see disabled field 'Sub Brand,Product' on New Project popup

Examples:
| AgencyName       | UserEmail        | ProjectName      | FieldBaseSize | FieldUpdatedSize |
| A_CMCMTAAD_S54_1 | U_CMCMTAAD_S54_1 | P_CMCMTAAD_S54_1 | Full Width    | Half Width       |
| A_CMCMTAAD_S54_2 | U_CMCMTAAD_S54_2 | P_CMCMTAAD_S54_2 | Half Width    | Full Width       |