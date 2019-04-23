!--NGN-7762
Feature:          Custom metadata - Specific cases
Narrative:
In order to
As a              GlobalAdmin
I want to         check specific cases using custom metadata

Scenario: check that Usage rights can be saved if to project schema was added drop down
Meta:@globaladmin
     @gdam
     @projects
Given I created the agency 'A_CMSC_S01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSC_S01 | agency.admin | A_CMSC_S01   |
And logged in with details of 'U_CMSC_S01'
And on the 'project' metadata page
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description    |
| CMDDF CMSC S01 |
And clicked 'CMDDF CMSC S01' button in 'Editable Metadata' section on opened metadata page
And added following dropdown choices on opened Settings and Customization page:
| Choice            |
| CMDDFV CMSC S01 1 |
| CMDDFV CMSC S01 2 |
And created 'P_CMSC_S01' project
And created '/F_CMSC_S01' folder for project 'P_CMSC_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_CMSC_S01' folder for 'P_CMSC_S01' project
And waited while transcoding is finished in folder '/F_CMSC_S01' on project 'P_CMSC_S01' files page
When I add 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_CMSC_S01' and project 'P_CMSC_S01' Usage Rights page:
| StartDate  | ExpirationDate |
| 21.02.2012 | 12.02.2021     |
And refresh the page
Then I 'should' see 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_CMSC_S01' and project 'P_CMSC_S01' Usage Rights page:
| StartDate  | ExpirationDate |
| 21.02.2012 | 12.02.2021     |

Scenario: Check that removing custom date fields does not set date to a default value
Meta:@gdam
     @projects
Given I created the agency 'A_CMSC_S02' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSC_S02 | agency.admin | A_CMSC_S02   |
And logged in with details of 'U_CMSC_S02'
And on the global 'common custom' metadata page for agency 'A_CMSC_S02'
And created 'Section Break' custom metadata field with following information on opened metadata page:
| Description              |
| Usage Rights information |
And created 'Date' custom metadata field with following information on opened metadata page:
| Description    |
| TestDate       |
And created 'Date' custom metadata field with following information on opened metadata page:
| Description      |
| Start date       |
And created 'Date' custom metadata field with following information on opened metadata page:
| Description    |
| End date       |
And I moved fields into group 'Usage Rights information' in following order in Active Metadata Preview block on opened metadata page:
| FieldName  |
| Start date |
| End date   |
And I created 'P_CMSC_S02' project
And created '/F_CMSC_S02' folder for project 'P_CMSC_S02'
And uploaded '/files/Fish Ad.mov' file into '/F_CMSC_S02' folder for 'P_CMSC_S02' project
And waited while transcoding is finished in folder '/F_CMSC_S02' on project 'P_CMSC_S02' files page
And I am on file 'Fish Ad.mov' info page in folder '/F_CMSC_S02' project 'P_CMSC_S02'
When I click Edit link on asset info page
And I 'save' file info by next information:
| FieldName      | FieldValue |
| TestDate       | 02/20/2020 |
| Start date     | 03/13/2018 |
| End date       | 05/10/2025 |
And go to project 'P_CMSC_S02' folder 'root' page
And I go to file 'Fish Ad.mov' info page in folder '/F_CMSC_S02' project 'P_CMSC_S02'
And I click Edit link on asset info page
And I 'save' file info by next information:
| FieldName      | FieldValue |
| TestDate       |            |
| Start date     |            |
| End date       |            |
Then I 'should not' see following 'custom metadata' fields on opened asset info page:
| FieldName                   | FieldValue                       |
| TestDate                    |                                  |
| Start date                  |                                  |
| End date                    |                                  |
When go to project 'P_CMSC_S02' folder 'root' page
And I go to file 'Fish Ad.mov' info page in folder '/F_CMSC_S02' project 'P_CMSC_S02'
Then I 'should not' see following 'custom metadata' fields on opened asset info page:
| FieldName                   | FieldValue                       |
| TestDate                    |                                  |
| Start date                  |                                  |
| End date                    |                                  |
