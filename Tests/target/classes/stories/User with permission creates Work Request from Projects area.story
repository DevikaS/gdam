!--NGN-11516
Feature:          User with permission creates Work Request from Projects area
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that User with permission creates Work Request from Projects area


Scenario: Check that user can upload file as Brief with Work Request
Meta:@gdam
@projects
Given created users with following fields:
| Email           | Roles       |
| E_UWPCWRFPA_S01 | agency.user |
And logged in with details of 'E_UWPCWRFPA_S01'
When I open Create New Work Request popup
And fill following fields on Create New Work Request popup:
| FieldName  | FieldValue         |
| Name       | WR_UWPCWRFPA_S01 |
| Media type | Broadcast          |
| Start date | Today              |
| End date   | Tomorrow           |
And upload brief '/files/image10.jpg' on opened create work request popup
And click Save button on opened Create Work Request popup
And wait while transcoding is finished on Work request 'WR_UWPCWRFPA_S01' in folder '/Brief' for 'image10.jpg' file
Then I 'should' see file 'image10.jpg' on work request 'WR_UWPCWRFPA_S01' folder '/Brief' files page


Scenario: check that user have ability to delete WR
Meta:@gdam
@projects
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created 'GR_PIFCWLP_02' role in 'global' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                     |
| adkit.create                   |
| agency_team.read               |
| asset.create                   |
| asset_filter_collection.create |
| dictionary.read                |
| enum.create                    |
| enum.read                      |
| enum.write                     |
| group.agency_enums.read        |
| presentation.create            |
| project.create                 |
| project_template.create        |
| role.read                      |
| user.invite                    |
| user.read                      |
| user_group.read                |
And created users with following fields:
| Email           | Roles         | Agency       |
| E_UWPCWRFPA_S01 | agency.admin  | A_PIFCWLP_01 |
| E_UWPCWRFPA_S02 | GR_PIFCWLP_02 | A_PIFCWLP_01 |
And logged in with details of 'E_UWPCWRFPA_S02'
When I create new work request with following fields:
| FieldName  | FieldValue    |
| Name       | WR_PIFCWLP_02 |
| Media type | Other         |
| Start date | 07.09.2013    |
| End date   | 07.09.2020    |
And delete 'WR_PIFCWLP_02' work request
And go to work request list page
And refresh the page
Then I 'should not' see following work request 'WR_PIFCWLP_02' in work request list


Scenario: check that user have ability to edit WR
Meta:@gdam
@projects
Given I created the agency 'A_UWPCWRFPA_01' with default attributes
And created 'GR_UWPCWRFPA_03' role in 'global' group for advertiser 'A_UWPCWRFPA_01' with following permissions:
| Permission                     |
| adkit.create                   |
| agency_team.read               |
| asset.create                   |
| asset_filter_collection.create |
| dictionary.read                |
| enum.create                    |
| enum.read                      |
| enum.write                     |
| group.agency_enums.read        |
| presentation.create            |
| project.create                 |
| project_template.create        |
| role.read                      |
| user.invite                    |
| user.read                      |
| user_group.read                |
And created users with following fields:
| Email             | Roles           | Agency         |
| E_UWPCWRFPA_S2_01 | agency.admin    | A_UWPCWRFPA_01 |
| E_UWPCWRFPA_S2_03 | GR_UWPCWRFPA_03 | A_UWPCWRFPA_01 |
And logged in with details of 'E_UWPCWRFPA_S2_03'
When I create new work request with following fields:
| FieldName  | FieldValue      |
| Name       | WR_UWPCWRFPA_03 |
| Media type | Other           |
| Start date | 07.09.2013      |
| End date   | 07.09.2020      |
And edit the following fields for 'WR_UWPCWRFPA_03' project:
| Name                 |
| WR_UWPCWRFPA_03_edit |
And click on element 'SaveButton'
And go to work request list page
And refresh the page
Then I should see 'WR_UWPCWRFPA_03_edit' work request in work request list


Scenario: Check that user has ability to edit and copy brief in WR
Meta:@gdam
@projects
Given I created the agency 'A_UWPCWRFPA_01' with default attributes
And created 'GR_UWPCWRFPA_04' role in 'global' group for advertiser 'A_UWPCWRFPA_01' with following permissions:
| Permission                     |
| adkit.create                   |
| agency_team.read               |
| asset.create                   |
| asset_filter_collection.create |
| dictionary.read                |
| enum.create                    |
| enum.read                      |
| enum.write                     |
| group.agency_enums.read        |
| presentation.create            |
| project.create                 |
| project_template.create        |
| role.read                      |
| user.invite                    |
| user.read                      |
| user_group.read                |
And created users with following fields:
| Email             | Roles           | Agency         |
| E_UWPCWRFPA_S4_01 | agency.admin    | A_UWPCWRFPA_01 |
| E_UWPCWRFPA_S4_02 | GR_UWPCWRFPA_04 | A_UWPCWRFPA_01 |
And logged in with details of 'E_UWPCWRFPA_S4_02'
And am on Project list page
When I open Create New Work Request popup
And fill following fields on Create New Work Request popup:
| FieldName  | FieldValue       |
| Name       | WR_UWPCWRFPA_S04 |
| Media type | Broadcast        |
| Start date | Today            |
| End date   | Tomorrow         |
And upload brief '/files/image10.jpg' on opened create work request popup
And click Save button on opened Create Work Request popup
And create '/folder1' folder for work request 'WR_UWPCWRFPA_S04'
And wait while transcoding is finished on Work request 'WR_UWPCWRFPA_S04' in folder '/Brief' for 'image10.jpg' file
And go to file 'image10.jpg' info page in folder '/Brief' work request 'WR_UWPCWRFPA_S04'
And click Edit link on file info page
And I fill Edit file popup with following information:
| FieldName | FieldValue  |
| Title     | image11.jpg |
And click on element 'SaveButton'
Then I 'should' see file 'image11.jpg' on work request 'WR_UWPCWRFPA_S04' folder '/Brief' files page
When I go to work request 'WR_UWPCWRFPA_S04' folder '/Brief' page
And click on Want to copy files to another Work request link on move/copy file 'image11.jpg' popup
And enter 'WR_UWPCWRFPA_S04' in search field on move/copy file popup
And select folder '/folder1' on move/copy file popup
And click copy button on move/copy files popup
Then I 'should' see file 'image11.jpg' on work request 'WR_UWPCWRFPA_S04' folder '/folder1' files page


Scenario: Check that user has ability to move and delete files in WR
Meta:@gdam
@projects
Given I created the agency 'A_UWPCWRFPA_01' with default attributes
And created 'GR_UWPCWRFPA_05' role in 'global' group for advertiser 'A_UWPCWRFPA_01' with following permissions:
| Permission                     |
| adkit.create                   |
| agency_team.read               |
| asset.create                   |
| asset_filter_collection.create |
| dictionary.read                |
| enum.create                    |
| enum.read                      |
| enum.write                     |
| group.agency_enums.read        |
| presentation.create            |
| project.create                 |
| project_template.create        |
| role.read                      |
| user.invite                    |
| user.read                      |
| user_group.read                |
And created users with following fields:
| Email             | Roles           | Agency         |
| E_UWPCWRFPA_S5_01 | agency.admin    | A_UWPCWRFPA_01 |
| E_UWPCWRFPA_S5_02 | GR_UWPCWRFPA_05 | A_UWPCWRFPA_01 |
And logged in with details of 'E_UWPCWRFPA_S5_02'
And am on Project list page
When I open Create New Work Request popup
And fill following fields on Create New Work Request popup:
| FieldName  | FieldValue       |
| Name       | WR_UWPCWRFPA_S05 |
| Media type | Broadcast        |
| Start date | Today            |
| End date   | Tomorrow         |
And click Save button on opened Create Work Request popup
And create '/folder1' folder for work request 'WR_UWPCWRFPA_S05'
And create '/folder2' folder for work request 'WR_UWPCWRFPA_S05'
And upload '/files/image10.jpg' file into '/folder1' folder for 'WR_UWPCWRFPA_S05' work request
And wait while transcoding is finished on Work request 'WR_UWPCWRFPA_S05' in folder '/folder1' for 'image10.jpg' file
And go to work request 'WR_UWPCWRFPA_S05' folder '/folder1' page
And click on Want to move files to another project link on move/copy file 'image10.jpg' popup
And enter 'WR_UWPCWRFPA_S05' in search field on move/copy file popup
And select folder '/folder2' on move/copy file popup
And click move button on move/copy files popup
Then I 'should' see file 'image10.jpg' on work request 'WR_UWPCWRFPA_S05' folder '/folder2' files page
When I delete file 'image10.jpg' in Work request 'WR_UWPCWRFPA_S05' folder '/folder2'
And refresh the page
Then I 'should not' see file 'image10.jpg' on work request 'WR_UWPCWRFPA_S05' folder '/folder2' files page


Scenario: check that if user does not have adkit.read do not show Work Request options in Project List filter Template List filter
Meta: @skip
      @gdam
!--05/10- Incorrect scenario as per Maria--"this depends on application access in user settings"
Given created 'U_UWPCWRFPA_S06' User
When I login with details of 'U_UWPCWRFPA_S06'
Then 'should not' see tab 'Work Requests' on project list page
And 'should not' see tab 'Work Request Templates' on project list page


Scenario: Check that uploaded brief file appears in 'Brief' folder
!-- QA-1331
Meta:@gdam
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name             |
| A_UWPCWRFPA_02   |
| A_UWPCWRFPA_03   |
And updated the following agency:
| Name                 | Storage                    |
| A_UWPCWRFPA_02       | S3                         |
And created users with following fields:
| Email              | Role           | Agency          |
| U_UWPCWRFPA_S4_02  | agency.admin   | A_UWPCWRFPA_02  |
And added existing user 'U_UWPCWRFPA_S4_02' to agency 'A_UWPCWRFPA_03' with role 'agency.admin'
And logged in with details of 'U_UWPCWRFPA_S4_02'
When I open Create New Work Request popup
And fill following fields on Create New Work Request popup:
| FieldName  | FieldValue       |
| Name       | WR_UWPCWRFPA_S06 |
| Media type | Broadcast        |
| Start date | Today            |
| End date   | Tomorrow         |
And upload brief '/files/image10.jpg' on opened create work request popup
And click Save button on opened Create Work Request popup
And wait while preview is available in folder '/Brief' on work request 'WR_UWPCWRFPA_S06' files page
Then I 'should' see file 'image10.jpg' on work request 'WR_UWPCWRFPA_S06' folder '/Brief' files page

