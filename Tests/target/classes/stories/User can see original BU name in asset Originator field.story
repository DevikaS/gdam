!--NGN-9790
Feature:          User can see original BU name in asset Originator field
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user can see original BU name in asset Originator field

Scenario: Check that after share category on BU, and accept asset, in details will be displayed Originator field with BU name of owner
Meta:@gdam
@library
Given I created the agency 'A_USOBUNOF_S01_1' with default attributes
And created the agency 'A_USOBUNOF_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |Access|
| U_USOBUNOF_S01_1 | agency.admin | A_USOBUNOF_S01_1 |streamlined_library|
| U_USOBUNOF_S01_2 | agency.admin | A_USOBUNOF_S01_2 |streamlined_library|
And logged in with details of 'U_USOBUNOF_S01_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And created 'C_USOBUNOF_S01_1' category
And shared next agencies for following categories:
| CategoryName     | AgencyName       |
| C_USOBUNOF_S01_1 | A_USOBUNOF_S01_2 |
When I login with details of 'U_USOBUNOF_S01_2'
When I go to the collections page
When I go to the Shared Collection 'C_USOBUNOF_S01_1' from agency 'A_USOBUNOF_S01_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_USOBUNOF_S01_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'asset information' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue       |
| Business Unit | A_USOBUNOF_S01_2 |
| Originator    | A_USOBUNOF_S01_1 |

Scenario: Check that Originator field isn't displayed on asset edit page
Meta:@gdam
@library
Given I created the agency 'A_USOBUNOF_S02_1' with default attributes
And created the agency 'A_USOBUNOF_S02_2' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |Access|
| U_USOBUNOF_S02_1 | agency.admin | A_USOBUNOF_S02_1 |streamlined_library|
| U_USOBUNOF_S02_2 | agency.admin | A_USOBUNOF_S02_2 |streamlined_library|
And logged in with details of 'U_USOBUNOF_S02_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_USOBUNOF_S02_1' category
And shared next agencies for following categories:
| CategoryName     | AgencyName       |
| C_USOBUNOF_S02_1 | A_USOBUNOF_S02_2 |
When I login with details of 'U_USOBUNOF_S02_2'
And I go to the collections page
And I go to the Shared Collection 'C_USOBUNOF_S02_1' from agency 'A_USOBUNOF_S02_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_USOBUNOF_S02_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I '<shouldState>' see following 'metadata' fields on edit asset popup NEWLIB:
| FieldName      | shouldState       |
| Originator    | should not |



Scenario: Check that Business Unit field with BU name of owner will be displayed in file after share folder
Meta:@gdam
@projects
Given I created the agency 'A_USOBUNOF_S03_1' with default attributes
And created the agency 'A_USOBUNOF_S03_2' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |
| U_USOBUNOF_S03_1 | agency.admin | A_USOBUNOF_S03_1 |
| U_USOBUNOF_S03_2 | agency.admin | A_USOBUNOF_S03_2 |
And logged in with details of 'U_USOBUNOF_S03_1'
And created 'P_USOBUNOF_S03' project
And created '/F_USOBUNOF_S03' folder for project 'P_USOBUNOF_S03'
And uploaded '/files/Fish1-Ad.mov' file into '/F_USOBUNOF_S03' folder for 'P_USOBUNOF_S03' project
And waited while transcoding is finished in folder '/F_USOBUNOF_S03' on project 'P_USOBUNOF_S03' files page
And fill Share popup by users 'U_USOBUNOF_S03_2' in project 'P_USOBUNOF_S03' folders '/F_USOBUNOF_S03' with role 'project.contributor' expired '12.12.2021' and 'should' access to subfolders
When I login with details of 'U_USOBUNOF_S03_2'
And go to file 'Fish1-Ad.mov' info page in folder '/F_USOBUNOF_S03' project 'P_USOBUNOF_S03'
Then I 'should' see following 'asset information' fields on opened file info page:
| FieldName      | FieldValue       |
| Business Unit: | A_USOBUNOF_S03_1 |


Scenario: Check that Business Unit field with BU name of owner will be displayed in file after secure share
Meta:@gdam
@gdamemails
Given I created the agency 'A_USOBUNOF_S04_1' with default attributes
And created the agency 'A_USOBUNOF_S04_2' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |
| U_USOBUNOF_S04_1 | agency.admin | A_USOBUNOF_S04_1 |
| U_USOBUNOF_S04_2 | agency.user  | A_USOBUNOF_S04_2 |
And logged in with details of 'U_USOBUNOF_S04_1'
And created 'P_USOBUNOF_S04' project
And created '/F_USOBUNOF_S04' folder for project 'P_USOBUNOF_S04'
And uploaded '/files/Fish1-Ad.mov' file into '/F_USOBUNOF_S04' folder for 'P_USOBUNOF_S04' project
And waited while preview is available in folder '/F_USOBUNOF_S04' on project 'P_USOBUNOF_S04' files page
And added secure share for file 'Fish1-Ad.mov' from folder '/F_USOBUNOF_S04' and project 'P_USOBUNOF_S04' to following users:
| ExpireDate | UserEmails       | Message |
| 12.12.21   | U_USOBUNOF_S04_2 | hi dude |
When I login with details of 'U_USOBUNOF_S04_2'
And open link from email when user 'U_USOBUNOF_S04_2' received email with next subject 'Files have been shared with'
Then I 'should' see following 'asset information' fields on opened file info page:
| FieldName      | FieldValue       |
| Business Unit: | A_USOBUNOF_S04_1 |


Scenario: Check that Originator and Business Unit fields with BU name of owner will be displayed in asset after secure share
Meta:@gdam
@gdamemails
Given I created the agency 'A_USOBUNOF_S05_1' with default attributes
Given I created the agency 'A_USOBUNOF_S05_2' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |Access|
| U_USOBUNOF_S05_1 | agency.admin | A_USOBUNOF_S05_1 |streamlined_library|
| U_USOBUNOF_S05_2 | agency.user  | A_USOBUNOF_S05_2 |streamlined_library|
And logged in with details of 'U_USOBUNOF_S05_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added secure share for asset 'Fish1-Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails       | Message |
| 12.12.2021 | U_USOBUNOF_S05_2 | hi dude |
When I login with details of 'U_USOBUNOF_S05_2'
And open link from email when user 'U_USOBUNOF_S05_2' received email with next subject 'has been shared'
Then I 'should' see following 'asset information' fields on opened file info page:
| FieldName      | FieldValue       |
| Business Unit: | A_USOBUNOF_S05_1 |
| Originator:    | A_USOBUNOF_S05_1 |