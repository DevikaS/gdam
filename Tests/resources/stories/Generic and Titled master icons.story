!--NGN-4930
Feature:          Generic and Titled master icons
Narrative:
In order to
As a              AgencyAdmin
I want to         check  Generic and Titled master icons

Scenario: check Generic Master Icon for element
Meta:@gdam
@projects
Given I created 'PRJ_URex_01' project
And created '/F_URex_1' folder for project 'PRJ_URex_01'
And uploaded '/files/Fish-Ad.mov' file into '/F_URex_1' folder for 'PRJ_URex_01' project
And waited while transcoding is finished in folder '/F_URex_1' on project 'PRJ_URex_01' files page
When I go to file 'Fish-Ad.mov' info page in folder '/F_URex_1' project 'PRJ_URex_01'
And 'save' file info by next information:
| FieldName      | FieldValue     |
| Media sub-type | Generic Master |
| Clock number   | CNGTMI1  |
And go to project 'PRJ_URex_01' folder '/F_URex_1' page
Then I 'should' see thumbnail 'GenericMasterIcon' for file 'Fish-Ad.mov' under its preview


Scenario: check Generic Sub Type Filter Icon for elements in User Folders
Meta:@gdam
@projects
Given I created 'PRJ_URex_01' project
And created '/F_URex_1' folder for project 'PRJ_URex_01'
And uploaded '/files/Fish-Ad.mov' file into '/F_URex_1' folder for 'PRJ_URex_01' project
And waited while transcoding is finished in folder '/F_URex_1' on project 'PRJ_URex_01' files page
When I go to file 'Fish-Ad.mov' info page in folder '/F_URex_1' project 'PRJ_URex_01'
And 'save' file info by next information:
| FieldName      | FieldValue     |
| Media sub-type | Generic Master |
| Clock number | CNGTMI2  |
And go to project 'PRJ_URex_01' folder '/F_URex_1' page
And select media type filters 'VIDEO' on project 'PRJ_URex_01' folder '/F_URex_1' page
And select media subtype filter 'Generic Master' on project 'PRJ_URex_01' folder '/F_URex_1' page
Then I should see thumbnail 'GenericMasterIcon' for each file on project 'PRJ_URex_01' folder '/F_URex_1' page


Scenario: check Titled Master Icon for element
Meta:@gdam
@projects
Given I created 'PRJ_URex_01' project
And created '/F_URex_1' folder for project 'PRJ_URex_01'
And uploaded '/files/Fish-Ad.mov' file into '/F_URex_1' folder for 'PRJ_URex_01' project
And waited while transcoding is finished in folder '/F_URex_1' on project 'PRJ_URex_01' files page
When I go to file 'Fish-Ad.mov' info page in folder '/F_URex_1' project 'PRJ_URex_01'
And 'save' file info by next information:
| FieldName      | FieldValue    |
| Media sub-type | Titled Master |
| Clock number | CNGTMI3  |
And go to project 'PRJ_URex_01' folder '/F_URex_1' page
Then I 'should' see thumbnail 'TitledMasterIcon' for file 'Fish-Ad.mov' under its preview


Scenario: check Titled Master Sub Type Filter Icon for elements in User Folders
Meta:@gdam
@projects
Given I created 'PRJ_URex_01' project
And created '/F_URex_1' folder for project 'PRJ_URex_01'
And uploaded '/files/Fish-Ad.mov' file into '/F_URex_1' folder for 'PRJ_URex_01' project
And waited while transcoding is finished in folder '/F_URex_1' on project 'PRJ_URex_01' files page
When I go to file 'Fish-Ad.mov' info page in folder '/F_URex_1' project 'PRJ_URex_01'
And 'save' file info by next information:
| FieldName      | FieldValue    |
| Media sub-type | Titled Master |
| Clock number | CNGTMI4  |
And go to project 'PRJ_URex_01' folder '/F_URex_1' page
And select media type filters 'VIDEO' on project 'PRJ_URex_01' folder '/F_URex_1' page
And select media subtype filter 'Titled Master' on project 'PRJ_URex_01' folder '/F_URex_1' page
Then I should see thumbnail 'TitledMasterIcon' for each file on project 'PRJ_URex_01' folder '/F_URex_1' page



Scenario: Check that icons are visible on shared folders
Meta:@gdam
@projects
Given I created 'qwer' User
And created 'PRJ_URex_01' project
And created '/F_URex_1' folder for project 'PRJ_URex_01'
And uploaded '/files/Fish-Ad.mov' file into '/F_URex_1' folder for 'PRJ_URex_01' project
And waited while transcoding is finished in folder '/F_URex_1' on project 'PRJ_URex_01' files page
When I go to file 'Fish-Ad.mov' info page in folder '/F_URex_1' project 'PRJ_URex_01'
And 'save' file info by next information:
| FieldName      | FieldValue    |
| Media sub-type | Titled Master |
| Clock number | CNGTMI10  |
And filling Share popup by users 'qwer' in project 'PRJ_URex_01' for following folders '/F_URex_1' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
And login with details of 'qwer'
And go to project 'PRJ_URex_01' folder '/F_URex_1' page
Then I 'should' see thumbnail 'TitledMasterIcon' for file 'Fish-Ad.mov' under its preview





