!--NGN-7060
Feature:          Custom metadata - CM type - Multiline
Narrative:
In order to:
As a              GlobalAdmin
I want to         Check Multiline control in Common Custom Metadata scheme

Scenario: Check creation of Multiline control on Project Overview
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTM_S05' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S05 | agency.admin | A_CMCMTM_S05 |
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S05':
| FieldType | Description    |
| multiline | CMF CMCMTM S05 |
When I login with details of 'U_CMCMTM_S05'
And create new project with following fields:
| FieldName      | FieldValue       |
| Name           | P_CMCMTM_S05     |
| Media type     | Broadcast        |
| CMF CMCMTM S05 | ~!@#%&*()_+=O`"T |
| Start date     | Today            |
| End date       | Tomorrow         |
Then I 'should' see following fields on opened Project Overview page:
| FieldName      | FieldValue       |
| CMF CMCMTM S05 | ~!@#%&*()_+=O`"T |


Scenario: Check creation of Multiline control on Edit Project
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTM_S06' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S06 | agency.admin | A_CMCMTM_S06 |
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S06':
| FieldType | Description    |
| multiline | CMF CMCMTM S06 |
When I login with details of 'U_CMCMTM_S06'
And create new project with following fields:
| FieldName      | FieldValue       |
| Name           | P_CMCMTM_S06     |
| Media type     | Broadcast        |
| CMF CMCMTM S06 | ~!@#%&*()_+=O`"T |
| Start date     | Today            |
| End date       | Tomorrow         |
And open project 'P_CMCMTM_S06' settings page
Then I 'should' see following fields on opened Edit Project popup:
| FieldName      | FieldValue       |
| CMF CMCMTM S06 | ~!@#%&*()_+=O`"T |


Scenario: Check that empty Multiline control isn't displayed on audio asset details
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTM_S07' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S07 | agency.admin | A_CMCMTM_S07 |
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S07':
| FieldType | Description    |
| multiline | CMF CMCMTM S07 |
And logged in with details of 'U_CMCMTM_S07'
And created 'P_CMCMTM_S07' project
And created '/F_CMCMTM_S07' folder for project 'P_CMCMTM_S07'
When I upload '/files/audio01.mp3' file into '/F_CMCMTM_S07' folder for 'P_CMCMTM_S07' project
And wait while transcoding is finished in folder '/F_CMCMTM_S07' on project 'P_CMCMTM_S07' files page
And go to file 'audio01.mp3' info page in folder '/F_CMCMTM_S07' project 'P_CMCMTM_S07'
Then I 'should not' see following 'custom metadata' fields on opened file info page:
| FieldName      | FieldValue |
| CMF CMCMTM S07 |            |


Scenario: Check creation of Multiline control on Audio file in view form
Meta:@@projects
     @gdam
Given I created the agency 'A_CMCMTM_S08' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S08 | agency.admin | A_CMCMTM_S08 |
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S08':
| FieldType | Description    |
| multiline | CMF CMCMTM S08 |
And logged in with details of 'U_CMCMTM_S08'
And created 'P_CMCMTM_S08' project
And created '/F_CMCMTM_S08' folder for project 'P_CMCMTM_S08'
When I upload '/files/audio01.mp3' file into '/F_CMCMTM_S08' folder for 'P_CMCMTM_S08' project
And wait while transcoding is finished in folder '/F_CMCMTM_S08' on project 'P_CMCMTM_S08' files page
And go to file 'audio01.mp3' info page in folder '/F_CMCMTM_S08' project 'P_CMCMTM_S08'
And 'save' file info by next information:
| FieldName      | FieldValue       |
| CMF CMCMTM S08 | ~!@#%&*()_+=O`"T |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName      | FieldValue       |
| CMF CMCMTM S08 | ~!@#%&*()_+=O`"T |


Scenario: Check editing data in Multiline control for Project
Meta:@@projects
     @gdam
Given I created the agency 'A_CMCMTM_S09' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S09 | agency.admin | A_CMCMTM_S09 |
And logged in with details of 'U_CMCMTM_S09'
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S09':
| FieldType | Description    |
| multiline | CMF CMCMTM S09 |
And refreshed the page
When I create new project with following fields:
| FieldName      | FieldValue       |
| Name           | P_CMCMTM_S09     |
| Media type     | Broadcast        |
| CMF CMCMTM S09 | ~!@#%&*()_+=O`"T |
| Start date     | Today            |
| End date       | Tomorrow         |
And update project 'P_CMCMTM_S09' with following fields on Edit Project popup:
| FieldName      | FieldValue     |
| Name           | P_CMCMTM_S09   |
| CMF CMCMTM S09 | CMV CMCMTM S09 |
Then I 'should' see following fields on opened Project Overview page:
| FieldName      | FieldValue     |
| CMF CMCMTM S09 | CMV CMCMTM S09 |


Scenario: Check editing data in Multiline control for Audio file
Meta:@@projects
     @gdam
Given I created the agency 'A_CMCMTM_S10' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S10 | agency.admin | A_CMCMTM_S10 |
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S10':
| FieldType | Description    |
| multiline | CMF CMCMTM S10 |
And logged in with details of 'U_CMCMTM_S10'
And created 'P_CMCMTM_S10' project
And created '/F_CMCMTM_S10' folder for project 'P_CMCMTM_S10'
When I upload '/files/audio01.mp3' file into '/F_CMCMTM_S10' folder for 'P_CMCMTM_S10' project
And wait while transcoding is finished in folder '/F_CMCMTM_S10' on project 'P_CMCMTM_S10' files page
And go to file 'audio01.mp3' info page in folder '/F_CMCMTM_S10' project 'P_CMCMTM_S10'
And 'save' file info by next information:
| FieldName      | FieldValue       |
| CMF CMCMTM S10 | ~!@#%&*()_+=O`"T |
And 'save' file info by next information:
| FieldName      | FieldValue     |
| CMF CMCMTM S10 | CMV CMCMTM S10 |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName      | FieldValue     |
| CMF CMCMTM S10 | CMV CMCMTM S10 |


Scenario: Check changing of field size for Multiline control in CommonCustom scheme affects Project scheme and Audio assets scheme on Metadata editor
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTM_S11' with default attributes
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S11':
| FieldType | Description    | FieldSize  |
| multiline | CMF CMCMTM S11 | Half Width |
When I go to the global 'common custom' metadata page for agency 'A_CMCMTM_S11'
Then I 'should' see field 'CMF CMCMTM S11' with size 'Half Width' on opened Active Metadata Preview
When I go to the global 'project' metadata page for agency 'A_CMCMTM_S11'
Then I 'should' see field 'CMF CMCMTM S11' with size 'Half Width' on opened Active Metadata Preview
When I go to the global 'audio asset' metadata page for agency 'A_CMCMTM_S11'
Then I 'should' see field 'CMF CMCMTM S11' with size 'Half Width' on opened Active Metadata Preview


Scenario: Check that property Number of lines accepts correct values
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTM_S12' with default attributes
And on the global 'common custom' metadata page for agency 'A_CMCMTM_S12'
When I click 'Multiline' button in 'Custom Metadata' section on opened metadata page
And fill Number of lines field with value '<LinesNumber>' on opened Settings and Customization tab
Then I '<Condition>' see Number of lines field is red on opened Settings and Customization tab
And I '<Condition>' see error message '<ErrorMessage>' next to Number of lines field on opened Settings and Customization tab

Examples:
| LinesNumber | Condition  | ErrorMessage                    |
| 1           | should not |                                 |
| 25          | should not |                                 |
| 0           | should     | This value is out of range.     |
| 26          | should     | This value is out of range.     |
| aa          | should     | The value entered is not valid. |


Scenario: Check that property of Number of lines correctly works in Metadata Editor
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMCMTM_S13' with default attributes
And on the global 'common custom' metadata page for agency 'A_CMCMTM_S13'
And created 'Multiline' custom metadata field with following information on opened metadata page:
| Description | NumberOfLines |
| <FieldName> | <LinesNumber> |
Then I 'should' see multiline field '<FieldName>' with rows count '<LinesNumber>' in Active Metadata Preview block on opened metadata page

Examples:
| FieldName        | LinesNumber |
| CMF CMCMTM S13 1 | 1           |
| CMF CMCMTM S13 2 | 10          |
| CMF CMCMTM S13 3 | 25          |


Scenario: Check that property of Number of lines correctly works on New Project
Meta:@@projects
     @gdam
Given I created the agency 'A_CMCMTM_S14' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S14 | agency.admin | A_CMCMTM_S14 |
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S14':
| FieldType | Description | NumberOfLines |
| multiline | <FieldName> | <LinesNumber> |
When I login with details of 'U_CMCMTM_S14'
Then I 'should' see multiline field '<FieldName>' with rows count '<LinesNumber>' on New Project popup

Examples:
| FieldName        | LinesNumber |
| CMF CMCMTM S14 1 | 1           |
| CMF CMCMTM S14 2 | 10          |
| CMF CMCMTM S14 3 | 25          |


Scenario: Check that property of Number of lines correctly works on Edit Project
Meta:@@projects
     @gdam
Given I created the agency 'A_CMCMTM_S15' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S15 | agency.admin | A_CMCMTM_S15 |
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S15':
| FieldType | Description | NumberOfLines |
| multiline | <FieldName> | <LinesNumber> |
When I login with details of 'U_CMCMTM_S15'
And create new project with following fields:
| FieldName      | FieldValue    |
| Name           | <ProjectName> |
| Media type     | Broadcast     |
| Start date     | Today         |
| End date       | Tomorrow      |
Then I 'should' see multiline field '<FieldName>' with rows count '<LinesNumber>' on Edit Project '<ProjectName>' popup

Examples:
| FieldName        | LinesNumber | ProjectName    |
| CMF CMCMTM S15 1 | 1           | P_CMCMTM_S15_1 |
| CMF CMCMTM S15 2 | 10          | P_CMCMTM_S15_2 |
| CMF CMCMTM S15 3 | 25          | P_CMCMTM_S15_3 |


Scenario: Check that property of Number of lines correctly works on Audio file in view form
Meta:@@projects
     @gdam
Given I created the agency 'A_CMCMTM_S16' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S16 | agency.admin | A_CMCMTM_S16 |
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S16':
| FieldType | Description | NumberOfLines |
| multiline | <FieldName> | <LinesNumber> |
And logged in with details of 'U_CMCMTM_S16'
And created 'P_CMCMTM_S16' project
And created '/F_CMCMTM_S16' folder for project 'P_CMCMTM_S16'
When I upload '/files/audio01.mp3' file into '/F_CMCMTM_S16' folder for 'P_CMCMTM_S16' project
And wait while transcoding is finished in folder '/F_CMCMTM_S16' on project 'P_CMCMTM_S16' files page
And go to file 'audio01.mp3' info page in folder '/F_CMCMTM_S16' project 'P_CMCMTM_S16'
And click Edit link on file info page
And wait for '3' seconds
Then I 'should' see multiline field '<FieldName>' with rows count '<LinesNumber>' on opened Edit file popup

Examples:
| FieldName        | LinesNumber |
| CMF CMCMTM S16 1 | 1           |
| CMF CMCMTM S16 2 | 10          |
| CMF CMCMTM S16 3 | 25          |


Scenario: Check that property of Number of lines correctly works on Audio file in edit form
Meta:@@projects
     @gdam
Given I created the agency 'A_CMCMTM_S17' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTM_S17 | agency.admin | A_CMCMTM_S17 |
And created following 'common' custom metadata fields for agency 'A_CMCMTM_S17':
| FieldType | Description | NumberOfLines |
| multiline | <FieldName> | <LinesNumber> |
And logged in with details of 'U_CMCMTM_S17'
And created 'P_CMCMTM_S17' project
And created '/F_CMCMTM_S17' folder for project 'P_CMCMTM_S17'
When I upload '/files/audio01.mp3' file into '/F_CMCMTM_S17' folder for 'P_CMCMTM_S17' project
And wait while transcoding is finished in folder '/F_CMCMTM_S17' on project 'P_CMCMTM_S17' files page
And go to file 'audio01.mp3' info page in folder '/F_CMCMTM_S17' project 'P_CMCMTM_S17'
And 'save' file info by next information:
| FieldName   | FieldValue     |
| <FieldName> | CMV CMCMTM S17 |
And click Edit link on file info page
And wait for '3' seconds
Then I 'should' see multiline field '<FieldName>' with rows count '<LinesNumber>' on opened Edit file popup

Examples:
| FieldName        | LinesNumber |
| CMF CMCMTM S17 1 | 1           |
| CMF CMCMTM S17 2 | 10          |
| CMF CMCMTM S17 3 | 25          |