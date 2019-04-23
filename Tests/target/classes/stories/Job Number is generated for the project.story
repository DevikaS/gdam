!-- NGN-9282
Feature:          Job Number is generated for the project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check generation of Job Number according to rules



Scenario: Check that you can add custom rule for 'Job Number' field in Metadata editor
Meta:@gdam
@projects
Given I created the following agency:
| Name          |
| BU_JNisGFTP_1 |
And created users with following fields:
| Email        | Role         | AgencyUnique  |
| U_JNisGFTP_1 | agency.admin | BU_JNisGFTP_1 |
And logged in with details of 'U_JNisGFTP_1'
And I am on the 'Project' metadata page
And clicked 'Job number' button in 'Editable Metadata' section on opened metadata page
When I fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name    | Metadata Characters | Free Text | Separator |
| JNGFT 1   | should | MMDDYYYY    | 3                   | should            | Advertiser,Brand | 3,2                 | should    | -         |
And save metadata field settings
And click 'Job number' button in 'Editable Metadata' section on opened metadata page
Then I should see following data for custom code 'JNGFT 1' on AdCode Manager form of metadata page:
| Code Name | Preview            | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name    | Metadata Characters | Free Text | Separator |
| JNGFT 1   | SSSMMDDYYYYAAABB-  | should | MMDDYYYY    | 3                   | should            | Advertiser,Brand | 3,2                 | should    | -         |

Scenario: Check that you can specify custom code for Advertiser hierarchy and use it in Job Number code
Meta:@gdam
@projects
Given I created the following agency:
| Name          |
| BU_JNisGFTP_3 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BU_JNisGFTP_3':
| Advertiser     | Brand         | Sub Brand       | Product      |
| Adv_JNisGFTP_3 | Br_JNisGFTP_3 | SuBr_JNisGFTP_3 | P_JNisGFTP_3 |
And created users with following fields:
| Email        | Role         | AgencyUnique  |
| U_JNisGFTP_3 | agency.admin | BU_JNisGFTP_3 |
And logged in with details of 'U_JNisGFTP_3'
And I am on the 'Project' metadata page
And clicked 'Job number' button in 'Editable Metadata' section on opened metadata page
When I fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name     | Metadata Elements  | Metadata Name                      | Metadata Characters     |
| CN_JNisGFTP_3 | should             | Advertiser,Brand,Sub Brand,Product | 3,2,1,1                 |
And save metadata field settings
And click 'Job number' button in 'Editable Metadata' section on opened metadata page
Then I should see following data for custom code 'CN_JNisGFTP_3' on AdCode Manager form of metadata page:
| Code Name    | Metadata Elements | Metadata Name                      | Metadata Characters |
| CN_JNisGFTP_3| should            | Advertiser,Brand,Sub Brand,Product | 3,2,1,1             |

Scenario: Check preview for Job Number with different rules
Meta:@gdam
@projects
Given I created the following agency:
| Name          |
| BU_JNisGFTP_2 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BU_JNisGFTP_2':
| Advertiser     | Brand         | Sub Brand       | Product      |
| Adv_JNisGFTP_2 | Br_JNisGFTP_2 | SuBr_JNisGFTP_2 | P_JNisGFTP_2 |
And created users with following fields:
| Email        | Role         | AgencyUnique  |
| U_JNisGFTP_2 | agency.admin | BU_JNisGFTP_2 |
And logged in with details of 'U_JNisGFTP_2'
And I am on the 'Project' metadata page
And clicked 'Job number' button in 'Editable Metadata' section on opened metadata page
When I fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name     | Date   | Date Format   | Sequence Characters | Metadata Elements | Metadata Name  | Metadata Characters | Free Text  | Separator  |
| CN_JNisGFTP_2 | <Date> | <FormatD>     | <SC>                | <Elements>        | <Name>         | <Characters>        | <FreeText> | <Separator> |
Then I should see following data for custom code 'CN_JNisGFTP_2' on AdCode Manager form of metadata page:
| Preview    |
| <Preview>  |

Examples:
| Date       | FormatD  | SC | Elements | Name                  | Characters | FreeText   | Separator | Preview |
| should     | MMDDYYYY | 3  | should   | Name                  | 2          | should     | -         | SSSMMDDYYYYNN-  |
| should     | DD       | 2  | should   | Advertiser            | 3          | should     | -         | SSDDAAA-         |
| should not |          | 4  | should   | Advertiser,Brand,Name | 3,1,2      | should not |           | SSSSAAABNN        |
| should not |          | 3  | should   | Sub Brand             | 3          | should     |S,SS,SSS   | SSSSSSSSSSSS        |


Scenario: Check that you can specify custom code for Advertiser hierarchy and use it in Job Number code



Scenario: Check Job number generation on Create New Project form




Scenario: Check validation for fields that included in Job Number code




Scenario: Check option 'Pick up values on the fly' for Job Number
!--NGN-11465



Scenario: Check that you can manually enter Job Number in edit mode



Scenario: Check that after change custom code for Job Number next autogeneretion will pick up new format



Scenario: Check Job Number autogeneration while create project for another BU
!--NGN-12044