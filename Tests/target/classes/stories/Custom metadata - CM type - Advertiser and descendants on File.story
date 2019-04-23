!--NGN-7056
Feature:          Custom metadata - CM type - Advertiser and descendants on File
Narrative:
In order to:
As a              GlobalAdmin
I want to         check value for Advertiser and descendants on File

Scenario: Check appearance value of Advertiser with childs on Video asset details
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S05' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S05 | agency.admin | A_CMCMTAAD_S05 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S05'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S05 | B_CMCMTAAD_S05 | SB_CMCMTAAD_S05 | PT_CMCMTAAD_S05 |
When I login with details of 'U_CMCMTAAD_S05'
And create new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S05  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S05 |
| Brand      | B_CMCMTAAD_S05  |
| Sub Brand  | SB_CMCMTAAD_S05 |
| Product    | PT_CMCMTAAD_S05 |
| Start date | Today           |
| End date   | Tomorrow        |
And create '/F_CMCMTAAD_S05' folder for project 'P_CMCMTAAD_S05'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S05' folder for 'P_CMCMTAAD_S05' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S05' on project 'P_CMCMTAAD_S05' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S05' project 'P_CMCMTAAD_S05'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S05 |
| Brand      | B_CMCMTAAD_S05  |
| Sub Brand  | SB_CMCMTAAD_S05 |
| Product    | PT_CMCMTAAD_S05 |


Scenario: Check appearance value of Advertiser with childs on edit Video asset page
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S06' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S06 | agency.admin | A_CMCMTAAD_S06 |
And logged in with details of 'U_CMCMTAAD_S06'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S06'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S06 | B_CMCMTAAD_S06 | SB_CMCMTAAD_S06 | PT_CMCMTAAD_S06 |
When I create new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S06  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S06 |
| Brand      | B_CMCMTAAD_S06  |
| Sub Brand  | SB_CMCMTAAD_S06 |
| Product    | PT_CMCMTAAD_S06 |
| Start date | Today           |
| End date   | Tomorrow        |
And create '/F_CMCMTAAD_S06' folder for project 'P_CMCMTAAD_S06'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S06' folder for 'P_CMCMTAAD_S06' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S06' on project 'P_CMCMTAAD_S06' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S06' project 'P_CMCMTAAD_S06'
And click Edit link on file info page
Then I 'should' see following fields on opened Edit file popup:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S06 |
| Brand      | B_CMCMTAAD_S06  |
| Sub Brand  | SB_CMCMTAAD_S06 |
| Product    | PT_CMCMTAAD_S06 |


Scenario: Check editing data value Advertiser with childs on Video asset details (Add on fly)
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S10' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S10 | agency.admin | A_CMCMTAAD_S10 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S10'
And created following Advertiser chain with checked 'Add values on the fly' checkbox on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S10 | B_CMCMTAAD_S10 | SB_CMCMTAAD_S10 | PT_CMCMTAAD_S10 |
When I login with details of 'U_CMCMTAAD_S10'
And create new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S10  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S10 |
| Brand      | B_CMCMTAAD_S10  |
| Sub Brand  | SB_CMCMTAAD_S10 |
| Product    | PT_CMCMTAAD_S10 |
| Start date | Today           |
| End date   | Tomorrow        |
And create '/F_CMCMTAAD_S10' folder for project 'P_CMCMTAAD_S10'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S10' folder for 'P_CMCMTAAD_S10' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S10' on project 'P_CMCMTAAD_S10' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S10' project 'P_CMCMTAAD_S10'
And 'save' file info by next information:
| FieldName    | FieldValue       |
| Clock number | CN_CMCMTAAD_S10  |
| Advertiser   | FAR_CMCMTAAD_S10 |
| Brand        | FB_CMCMTAAD_S10  |
| Sub Brand    | FSB_CMCMTAAD_S10 |
| Product      | FPT_CMCMTAAD_S10 |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue       |
| Advertiser | FAR_CMCMTAAD_S10 |
| Brand      | FB_CMCMTAAD_S10  |
| Sub Brand  | FSB_CMCMTAAD_S10 |
| Product    | FPT_CMCMTAAD_S10 |


Scenario: Check editing data value Advertiser with childs on edit Video asset page (Several advertiser available)
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S11' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S11 | agency.admin | A_CMCMTAAD_S11 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S11'
And created following Advertiser chain with checked 'multiple choices' checkbox on Settings and Customization page:
| Advertiser        | Brand            | Sub Brand         | Product           |
| AR_CMCMTAAD_S11_1 | B_CMCMTAAD_S11_1 | SB_CMCMTAAD_S11_1 | PT_CMCMTAAD_S11_1 |
| AR_CMCMTAAD_S11_2 | B_CMCMTAAD_S11_2 | SB_CMCMTAAD_S11_2 | PT_CMCMTAAD_S11_2 |
| AR_CMCMTAAD_S11_2 | B_CMCMTAAD_S11_2 | SB_CMCMTAAD_S11_3 | PT_CMCMTAAD_S11_3 |
When I login with details of 'U_CMCMTAAD_S11'
And create new project with following fields:
| FieldName  | FieldValue        |
| Name       | P_CMCMTAAD_S11    |
| Media type | Broadcast         |
| Advertiser | AR_CMCMTAAD_S11_1 |
| Brand      | B_CMCMTAAD_S11_1  |
| Sub Brand  | SB_CMCMTAAD_S11_1 |
| Product    | PT_CMCMTAAD_S11_1 |
| Start date | Today             |
| End date   | Tomorrow          |
And create '/F_CMCMTAAD_S11' folder for project 'P_CMCMTAAD_S11'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S11' folder for 'P_CMCMTAAD_S11' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S11' on project 'P_CMCMTAAD_S11' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S11' project 'P_CMCMTAAD_S11'
And 'save' file info by next information:
| FieldName    | FieldValue                          |
| Clock number | CN_CMCMTAAD_S11                     |
| Advertiser   | AR_CMCMTAAD_S11_2                   |
| Brand        | B_CMCMTAAD_S11_2                    |
| Sub Brand    | SB_CMCMTAAD_S11_2,SB_CMCMTAAD_S11_3 |
And click Edit link on file info page
Then I 'should' see following fields on opened Edit file popup:
| FieldName  | FieldValue                          |
| Advertiser | AR_CMCMTAAD_S11_2                   |
| Brand      | B_CMCMTAAD_S11_2                    |
| Sub Brand  | SB_CMCMTAAD_S11_2,SB_CMCMTAAD_S11_3 |


Scenario: Check editing data value Advertiser with childs on edit Video asset page (Add on fly & Several advertiser available)
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S12' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S12 | agency.admin | A_CMCMTAAD_S12 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S12'
And created following Advertiser chain with checked 'multiple choices,Add values on the fly' checkbox on Settings and Customization page:
| Advertiser        | Brand            | Sub Brand         | Product           |
| AR_CMCMTAAD_S12_1 | B_CMCMTAAD_S12_1 | SB_CMCMTAAD_S12_1 | PT_CMCMTAAD_S12_1 |
| AR_CMCMTAAD_S12_2 | B_CMCMTAAD_S12_2 | SB_CMCMTAAD_S12_2 | PT_CMCMTAAD_S12_2 |
| AR_CMCMTAAD_S12_2 | B_CMCMTAAD_S12_2 | SB_CMCMTAAD_S12_3 | PT_CMCMTAAD_S12_3 |
When I login with details of 'U_CMCMTAAD_S12'
And create new project with following fields:
| FieldName  | FieldValue        |
| Name       | P_CMCMTAAD_S12    |
| Media type | Broadcast         |
| Advertiser | AR_CMCMTAAD_S12_1 |
| Brand      | B_CMCMTAAD_S12_1  |
| Sub Brand  | SB_CMCMTAAD_S12_1 |
| Product    | PT_CMCMTAAD_S12_1 |
| Start date | Today             |
| End date   | Tomorrow          |
And create '/F_CMCMTAAD_S12' folder for project 'P_CMCMTAAD_S12'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S12' folder for 'P_CMCMTAAD_S12' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S12' on project 'P_CMCMTAAD_S12' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S12' project 'P_CMCMTAAD_S12'
And 'save' file info by next information:
| FieldName    | FieldValue                                             |
| Clock number | CN_CMCMTAAD_S12                                        |
| Advertiser   | AR_CMCMTAAD_S12_2                                      |
| Brand        | B_CMCMTAAD_S12_2                                       |
| Sub Brand    | SB_CMCMTAAD_S12_2,SB_CMCMTAAD_S12_3,FSB_CMCMTAAD_S12_3 |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue                                             |
| Advertiser | AR_CMCMTAAD_S12_2                                      |
| Brand      | B_CMCMTAAD_S12_2                                       |
| Sub Brand  | SB_CMCMTAAD_S12_2,SB_CMCMTAAD_S12_3,FSB_CMCMTAAD_S12_3 |


Scenario: Check renaming of Advertiser with childs on Video asset details
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S17' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S17 | agency.admin | A_CMCMTAAD_S17 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S17'
And updated Catalogue Structure 'Advertiser' in section 'Common Metadata' with following descriptions:
| ItemName   | Description        |
| Advertiser | CMFAR_CMCMTAAD_S17 |
| Brand      | CMFB_CMCMTAAD_S17  |
| Sub Brand  | CMFSB_CMCMTAAD_S17 |
| Product    | CMFPT_CMCMTAAD_S17 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S17'
And created following Catalogue Structure chain for field 'CMFAR_CMCMTAAD_S17' on opened metadata page in 'Common Metadata' section:
| ChainItem          |
| CMVAR_CMCMTAAD_S17 |
| CMVB_CMCMTAAD_S17  |
| CMVSB_CMCMTAAD_S17 |
| CMVPT_CMCMTAAD_S17 |
When I login with details of 'U_CMCMTAAD_S17'
And create new project with following fields:
| FieldName          | FieldValue         |
| Name               | P_CMCMTAAD_S17     |
| Media type         | Broadcast          |
| CMFAR_CMCMTAAD_S17 | CMVAR_CMCMTAAD_S17 |
| CMFB_CMCMTAAD_S17  | CMVB_CMCMTAAD_S17  |
| CMFSB_CMCMTAAD_S17 | CMVSB_CMCMTAAD_S17 |
| CMFPT_CMCMTAAD_S17 | CMVPT_CMCMTAAD_S17 |
| Start date         | Today              |
| End date           | Tomorrow           |
And create '/F_CMCMTAAD_S17' folder for project 'P_CMCMTAAD_S17'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S17' folder for 'P_CMCMTAAD_S17' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S17' on project 'P_CMCMTAAD_S17' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S17' project 'P_CMCMTAAD_S17'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName          | FieldValue         |
| CMFAR_CMCMTAAD_S17 | CMVAR_CMCMTAAD_S17 |
| CMFB_CMCMTAAD_S17  | CMVB_CMCMTAAD_S17  |
| CMFSB_CMCMTAAD_S17 | CMVSB_CMCMTAAD_S17 |
| CMFPT_CMCMTAAD_S17 | CMVPT_CMCMTAAD_S17 |


Scenario: Check renaming of Advertiser with childs on edit Video asset page
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S18' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S18 | agency.admin | A_CMCMTAAD_S18 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S18'
And updated Catalogue Structure 'Advertiser' in section 'Common Metadata' with following descriptions:
| ItemName   | Description        |
| Advertiser | CMFAR_CMCMTAAD_S18 |
| Brand      | CMFB_CMCMTAAD_S18  |
| Sub Brand  | CMFSB_CMCMTAAD_S18 |
| Product    | CMFPT_CMCMTAAD_S18 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S18'
And created following Catalogue Structure chain for field 'CMFAR_CMCMTAAD_S18' on opened metadata page in 'Common Metadata' section:
| ChainItem          |
| CMVAR_CMCMTAAD_S18 |
| CMVB_CMCMTAAD_S18  |
| CMVSB_CMCMTAAD_S18 |
| CMVPT_CMCMTAAD_S18 |
When I login with details of 'U_CMCMTAAD_S18'
And create new project with following fields:
| FieldName          | FieldValue         |
| Name               | P_CMCMTAAD_S18     |
| Media type         | Broadcast          |
| CMFAR_CMCMTAAD_S18 | CMVAR_CMCMTAAD_S18 |
| CMFB_CMCMTAAD_S18  | CMVB_CMCMTAAD_S18  |
| CMFSB_CMCMTAAD_S18 | CMVSB_CMCMTAAD_S18 |
| CMFPT_CMCMTAAD_S18 | CMVPT_CMCMTAAD_S18 |
| Start date         | Today              |
| End date           | Tomorrow           |
And create '/F_CMCMTAAD_S18' folder for project 'P_CMCMTAAD_S18'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S18' folder for 'P_CMCMTAAD_S18' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S18' on project 'P_CMCMTAAD_S18' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S18' project 'P_CMCMTAAD_S18'
And click Edit link on file info page
Then I 'should' see following fields on opened Edit file popup:
| FieldName          | FieldValue         |
| CMFAR_CMCMTAAD_S18 | CMVAR_CMCMTAAD_S18 |
| CMFB_CMCMTAAD_S18  | CMVB_CMCMTAAD_S18  |
| CMFSB_CMCMTAAD_S18 | CMVSB_CMCMTAAD_S18 |
| CMFPT_CMCMTAAD_S18 | CMVPT_CMCMTAAD_S18 |


Scenario: Check that deleted value of Advertiser with childs is available for previously uploaded assets on asset details
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S22' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S22 | agency.admin | A_CMCMTAAD_S22 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S22'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S22 | B_CMCMTAAD_S22 | SB_CMCMTAAD_S22 | PT_CMCMTAAD_S22 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S22'
And logged in with details of 'U_CMCMTAAD_S22'
And created new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S22  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S22 |
| Brand      | B_CMCMTAAD_S22  |
| Sub Brand  | SB_CMCMTAAD_S22 |
| Product    | PT_CMCMTAAD_S22 |
| Start date | Today           |
| End date   | Tomorrow        |
And created '/F_CMCMTAAD_S22' folder for project 'P_CMCMTAAD_S22'
And uploaded '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S22' folder for 'P_CMCMTAAD_S22' project
And waited while transcoding is finished in folder '/F_CMCMTAAD_S22' on project 'P_CMCMTAAD_S22' files page
And logged in with details of 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S22'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And deleted Advertiser chain 'AR_CMCMTAAD_S22' on opened Settings and Customization page
When I login with details of 'U_CMCMTAAD_S22'
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S22' project 'P_CMCMTAAD_S22'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S22 |
| Brand      | B_CMCMTAAD_S22  |
| Sub Brand  | SB_CMCMTAAD_S22 |
| Product    | PT_CMCMTAAD_S22 |


Scenario: Check that deleted value of Advertiser with childs is available for previously uploaded assets on edit asset
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S23' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S23 | agency.admin | A_CMCMTAAD_S23 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S23'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S23 | B_CMCMTAAD_S23 | SB_CMCMTAAD_S23 | PT_CMCMTAAD_S23 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S23'
And logged in with details of 'U_CMCMTAAD_S23'
And created new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S23  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S23 |
| Brand      | B_CMCMTAAD_S23  |
| Sub Brand  | SB_CMCMTAAD_S23 |
| Product    | PT_CMCMTAAD_S23 |
| Start date | Today           |
| End date   | Tomorrow        |
And created '/F_CMCMTAAD_S23' folder for project 'P_CMCMTAAD_S23'
And uploaded '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S23' folder for 'P_CMCMTAAD_S23' project
And waited while transcoding is finished in folder '/F_CMCMTAAD_S23' on project 'P_CMCMTAAD_S23' files page
And logged in with details of 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S23'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And deleted Advertiser chain 'AR_CMCMTAAD_S23' on opened Settings and Customization page
When I login with details of 'U_CMCMTAAD_S23'
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S23' project 'P_CMCMTAAD_S23'
And click Edit link on file info page
Then I 'should' see following fields on opened Edit file popup:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S23 |
| Brand      | B_CMCMTAAD_S23  |
| Sub Brand  | SB_CMCMTAAD_S23 |
| Product    | PT_CMCMTAAD_S23 |


Scenario: Check deletion value of Advertiser with childs on new uploaded Video asset
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S24' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S24 | agency.admin | A_CMCMTAAD_S24 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S24'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S24 | B_CMCMTAAD_S24 | SB_CMCMTAAD_S24 | PT_CMCMTAAD_S24 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S24'
And logged in with details of 'U_CMCMTAAD_S24'
And created new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S24  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S24 |
| Brand      | B_CMCMTAAD_S24  |
| Sub Brand  | SB_CMCMTAAD_S24 |
| Product    | PT_CMCMTAAD_S24 |
| Start date | Today           |
| End date   | Tomorrow        |
And created '/F_CMCMTAAD_S24' folder for project 'P_CMCMTAAD_S24'
And logged in with details of 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S24'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And deleted Advertiser chain 'AR_CMCMTAAD_S24' on opened Settings and Customization page
When I login with details of 'U_CMCMTAAD_S24'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S24' folder for 'P_CMCMTAAD_S24' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S24' on project 'P_CMCMTAAD_S24' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S24' project 'P_CMCMTAAD_S24'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S24 |
| Brand      | B_CMCMTAAD_S24  |
| Sub Brand  | SB_CMCMTAAD_S24 |
| Product    | PT_CMCMTAAD_S24 |


Scenario: Check hidding value of Advertiser with childs on Video asset details
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S33' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S33 | agency.admin | A_CMCMTAAD_S33 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S33'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S33 | B_CMCMTAAD_S33 | SB_CMCMTAAD_S33 | PT_CMCMTAAD_S33 |
And logged in with details of 'U_CMCMTAAD_S33'
And created new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S33  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S33 |
| Brand      | B_CMCMTAAD_S33  |
| Sub Brand  | SB_CMCMTAAD_S33 |
| Product    | PT_CMCMTAAD_S33 |
| Start date | Today           |
| End date   | Tomorrow        |
And logged in with details of 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S33'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I login with details of 'U_CMCMTAAD_S33'
And create '/F_CMCMTAAD_S33' folder for project 'P_CMCMTAAD_S33'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S33' folder for 'P_CMCMTAAD_S33' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S33' on project 'P_CMCMTAAD_S33' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S33' project 'P_CMCMTAAD_S33'
Then I 'should not' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S33 |
| Brand      | B_CMCMTAAD_S33  |
| Sub Brand  | SB_CMCMTAAD_S33 |
| Product    | PT_CMCMTAAD_S33 |


Scenario: Check hidding value of Advertiser with childs on edit Video asset page
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S34' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S34 | agency.admin | A_CMCMTAAD_S34 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S34'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S34 | B_CMCMTAAD_S34 | SB_CMCMTAAD_S34 | PT_CMCMTAAD_S34 |
And logged in with details of 'U_CMCMTAAD_S34'
And created new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S34  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S34 |
| Brand      | B_CMCMTAAD_S34  |
| Sub Brand  | SB_CMCMTAAD_S34 |
| Product    | PT_CMCMTAAD_S34 |
| Start date | Today           |
| End date   | Tomorrow        |
And logged in with details of 'GlobalAdmin'
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S34'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I login with details of 'U_CMCMTAAD_S34'
And create '/F_CMCMTAAD_S34' folder for project 'P_CMCMTAAD_S34'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S34' folder for 'P_CMCMTAAD_S34' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S34' on project 'P_CMCMTAAD_S34' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S34' project 'P_CMCMTAAD_S34'
And click Edit link on file info page
Then I 'should not' see following fields on opened Edit file popup:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S34 |
| Brand      | B_CMCMTAAD_S34  |
| Sub Brand  | SB_CMCMTAAD_S34 |
| Product    | PT_CMCMTAAD_S34 |


Scenario: Check compulsory value of Advertiser with childs on edit Video asset page
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTAAD_S44' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| U_CMCMTAAD_S44 | agency.admin | A_CMCMTAAD_S44 |
And on the global 'common custom' metadata page for agency 'A_CMCMTAAD_S44'
And clicked 'Advertiser' button in 'Common Metadata' section on opened metadata page
And checked 'add values on the fly' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I login with details of 'U_CMCMTAAD_S44'
And create new project with following fields:
| FieldName  | FieldValue      |
| Name       | P_CMCMTAAD_S44  |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S44 |
| Brand      | B_CMCMTAAD_S44  |
| Sub Brand  | SB_CMCMTAAD_S44 |
| Product    | PT_CMCMTAAD_S44 |
| Start date | Today           |
| End date   | Tomorrow        |
And create '/F_CMCMTAAD_S44' folder for project 'P_CMCMTAAD_S44'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S44' folder for 'P_CMCMTAAD_S44' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S44' on project 'P_CMCMTAAD_S44' files page
And login with details of 'GlobalAdmin'
And go to the global 'common custom' metadata page for agency 'A_CMCMTAAD_S44'
And click 'Advertiser' button in 'Common Metadata' section on opened metadata page
And check 'make it compulsory' following catalogue structure items on opened Settings and Customization page:
| Item       |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
And login with details of 'U_CMCMTAAD_S44'
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S44' project 'P_CMCMTAAD_S44'
And click Edit link on file info page
Then I 'should' see following 'required' fields on opened Edit file popup:
| FieldName  | FieldValue      |
| Advertiser | AR_CMCMTAAD_S44 |
| Brand      | B_CMCMTAAD_S44  |
| Sub Brand  | SB_CMCMTAAD_S44 |
| Product    | PT_CMCMTAAD_S44 |


Scenario: Check changing of field size value for Advertiser with childs on Video asset details
Meta:@projects
     @gdam
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <AgencyName> |
And on the global 'project' metadata page for agency '<AgencyName>'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S50 | B_CMCMTAAD_S50 | SB_CMCMTAAD_S50 | PT_CMCMTAAD_S50 |
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
| Advertiser | AR_CMCMTAAD_S50 |
| Brand      | B_CMCMTAAD_S50  |
| Sub Brand  | SB_CMCMTAAD_S50 |
| Product    | PT_CMCMTAAD_S50 |
| Start date | Today           |
| End date   | Tomorrow        |
And create '/F_CMCMTAAD_S50' folder for project '<ProjectName>'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S50' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S50' on project '<ProjectName>' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S50' project '<ProjectName>'
Then I 'should' see field 'Advertiser,Brand,Sub Brand,Product' with size '<FieldUpdatedSize>' on opened file info page

Examples:
| AgencyName       | UserEmail        | ProjectName      | FieldBaseSize | FieldUpdatedSize |
| A_CMCMTAAD_S50_1 | U_CMCMTAAD_S50_1 | P_CMCMTAAD_S50_1 | Full Width    | Half Width       |
| A_CMCMTAAD_S50_2 | U_CMCMTAAD_S50_2 | P_CMCMTAAD_S50_2 | Half Width    | Full Width       |


Scenario: Check changing of field size value for Advertiser with childs on edit Video asset page
Meta:@projects
     @gdam
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <AgencyName> |
And logged in with details of '<UserEmail>'
And on the global 'project' metadata page for agency '<AgencyName>'
And created Advertiser chain with following values on Settings and Customization page:
| Advertiser      | Brand          | Sub Brand       | Product         |
| AR_CMCMTAAD_S51 | B_CMCMTAAD_S51 | SB_CMCMTAAD_S51 | PT_CMCMTAAD_S51 |
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
And create new project with following fields:
| FieldName  | FieldValue      |
| Name       | <ProjectName>   |
| Media type | Broadcast       |
| Advertiser | AR_CMCMTAAD_S51 |
| Brand      | B_CMCMTAAD_S51  |
| Sub Brand  | SB_CMCMTAAD_S51 |
| Product    | PT_CMCMTAAD_S51 |
| Start date | Today           |
| End date   | Tomorrow        |
And create '/F_CMCMTAAD_S51' folder for project '<ProjectName>'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S51' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S51' on project '<ProjectName>' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S51' project '<ProjectName>'
And click Edit link on file info page
Then I 'should' see field 'Advertiser,Brand,Sub Brand,Product' with size '<FieldUpdatedSize>' on opened Edit file popup

Examples:
| AgencyName       | UserEmail        | ProjectName      | FieldBaseSize | FieldUpdatedSize |
| A_CMCMTAAD_S51_1 | U_CMCMTAAD_S51_1 | P_CMCMTAAD_S51_1 | Full Width    | Half Width       |
| A_CMCMTAAD_S51_2 | U_CMCMTAAD_S51_2 | P_CMCMTAAD_S51_2 | Half Width    | Full Width       |


Scenario: Check that if select multiply parent then all child shouldn't be available on edit video asset page
Meta:@projects
     @gdam
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <AgencyName> |
And logged in with details of '<UserEmail>'
And on the global 'common custom' metadata page for agency '<AgencyName>'
And created following Advertiser chain with checked 'multiple choices' checkbox on Settings and Customization page:
| Advertiser        | Brand            | Sub Brand         | Product           |
| AR_CMCMTAAD_S55_1 | B_CMCMTAAD_S55_1 | SB_CMCMTAAD_S55_1 | PT_CMCMTAAD_S55_1 |
| AR_CMCMTAAD_S55_1 | B_CMCMTAAD_S55_2 | SB_CMCMTAAD_S55_2 | PT_CMCMTAAD_S55_2 |
When I create '<ProjectName>' project
When I create '/F_CMCMTAAD_S55' folder for project '<ProjectName>'
And upload '/files/Fish Ad.mov' file into '/F_CMCMTAAD_S55' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_CMCMTAAD_S55' on project '<ProjectName>' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMCMTAAD_S55' project '<ProjectName>'
And 'fill' file info by next information:
| FieldName  | FieldValue                        |
| Advertiser | AR_CMCMTAAD_S55_1                 |
| Brand      | B_CMCMTAAD_S55_1,B_CMCMTAAD_S55_2 |
Then I 'should' see following 'disabled' fields on opened Edit file popup:
| FieldName | FieldValue |
| Sub Brand |            |
| Product   |            |

Examples:
| AgencyName       | UserEmail        | ProjectName      | FieldBaseSize | FieldUpdatedSize |
| A_CMCMTAAD_S55_1 | U_CMCMTAAD_S55_1 | P_CMCMTAAD_S55_1 | Full Width    | Half Width       |
| A_CMCMTAAD_S55_2 | U_CMCMTAAD_S55_2 | P_CMCMTAAD_S55_2 | Half Width    | Full Width       |