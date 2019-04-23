!--NGN-11515
Feature:          Create Work Request from Work Request template
Narrative:
In order to
As a              AgencyAdmin
I want to         check creation of Work Request from Work Request template


Scenario: Check that Template field is presented on 'Create New Work Request' form
Meta:@gdam
@projects
When I open Create New Work Request popup
Then I 'should' see following fields on opened Create Work Request popup:
| FieldName | FieldValue |
| Template  |            |


Scenario: check that new Work Request may be created using 'use template' button on Work Request Template
Meta:@gdam
@projects
Given I created the agency 'A_CWRFWRT_S02' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_CWRFWRT_S02 | agency.admin | A_CWRFWRT_S02 |
And logged in with details of 'U_CWRFWRT_S02'
And created 'WRT_CWRFWRT_S02' work request template
When I go to work request template list page
And click use template button next to work template 'WRT_CWRFWRT_S02' on opened work templates list page
And fill following fields on Create New Work Request popup:
| FieldName | FieldValue     |
| Name      | WR_CWRFWRT_S02 |
And click Save button on opened Create Work Request popup
Then I 'should' see following fields on opened Work Request Overview page:
| FieldName | FieldValue     |
| Name      | WR_CWRFWRT_S02 |


Scenario: check that option is works (Allow other users in my Business Unit to create projects from this template)
Meta:@gdam
@projects
Given I created the agency 'A_CWRFWRT_S03' with default attributes
And created users with following fields:
| Email          | Role         | Agency        |
| AU_CWRFWRT_S03 | agency.admin | A_CWRFWRT_S03 |
| U_CWRFWRT_S03  | agency.user  | A_CWRFWRT_S03 |
And logged in with details of 'AU_CWRFWRT_S03'
And opened Create New Work Request Template popup
And filled following fields on Create New Work Request Template popup:
| FieldName  | FieldValue      |
| Name       | WRT_CWRFWRT_S03 |
| Media type | Broadcast       |
| Start date | yesterday     |
| End date   | tomorrow      |
And checked 'Allow other users in my Business Unit to create projects from this template' on opened Create Work Request Template popup
And clicked Save button on opened Create Work Request Template popup
And logged in with details of 'U_CWRFWRT_S03'
When I go to work request template list page
Then I should see 'WRT_CWRFWRT_S03' work request template in work request template list


Scenario: check that user can create work request without template
Meta:@gdam
@projects
When I create new work request with following fields:
| FieldName  | FieldValue     |
| Name       | WR_CWRFWRT_S04 |
| Media type | Broadcast      |
| Start date | 5 days ago     |
| End date   | 5 days since   |
When I go to work request list page
Then I 'should' see following work request 'WR_CWRFWRT_S04' in work request list


Scenario: check that user can create work request with template
Meta:@gdam
@projects
Given I created 'WRT_CWRFWRT_S05' work request template
When I open Create New Work Request popup
And I specify template name 'WRT_CWRFWRT_S05' on Create New Work Request popup
Then I should see following template inheritance options on opened create work request popup:
| IncludeFolders | IncludeTeam | IncludeFiles |
| true           | true        | false        |


Scenario: check that  WR is created from Template, it should inherit folder structure, team and files according to Template settings
Meta:@gdam
@projects
Given I created 'WRT_CWRFWRT_S06' work request template
And created '/F_CWRFWRT_S06' folder for work request template 'WRT_CWRFWRT_S06'
And uploaded '/files/image10.jpg' file into '/F_CWRFWRT_S06' folder for 'WRT_CWRFWRT_S06' work request template
And created users with following fields:
| Email         |
| U_CWRFWRT_S06 |
And added users 'U_CWRFWRT_S06' to work request template 'WRT_CWRFWRT_S06' team folders '/F_CWRFWRT_S06' with role 'project.user' expired '02.02.2222'
When I open Create New Work Request popup
And I specify template name 'WRT_CWRFWRT_S06' with following inheritance options on Create New Work Request popup:
| IncludeFolders | IncludeTeam | IncludeFiles |
| true           | true        | true         |
And fill following fields on Create New Work Request popup:
| FieldName  | FieldValue     |
| Name       | WR_CWRFWRT_S06 |
| Media type | Broadcast      |
| Start date | 5 days ago     |
| End date   | 5 days since   |
And click Save button on opened Create Work Request Template popup
And go to work request 'WR_CWRFWRT_S06' overview page
Then I 'should' see following folders in 'WR_CWRFWRT_S06' work request:
| folder         |
| /F_CWRFWRT_S06 |
Then I 'should' see file 'image10.jpg' on work request 'WR_CWRFWRT_S06' folder '/F_CWRFWRT_S06' files page
Then I 'should' see user 'U_CWRFWRT_S06' name in teams of work request 'WR_CWRFWRT_S06'


Scenario: User creates WR using template from Library
Meta:@gdam
@skip
!--Either FF needs to be updated or QA-785 to be fixed..not able to scroll to 'create work request' button using JS when a button is not in view port on add request pop up
Given I uploaded asset '/files/Fish7-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'WRT_S05' work request template
And I created '/FWRT_S05' folder for work request template 'WRT_S05'
And uploaded '/files/Fish8-Ad.mov' file into '/FWRT_S05' folder for 'WRT_S05' work request template
And waited while transcoding is finished on Work request template 'WRT_S05' in folder '/FWRT_S05' for 'Fish8-Ad.mov' file
And I am on the Library page for collection 'My Assets'NEWLIB
And I have refreshed the page
And I selected asset 'Fish7-Ad.mov' in the 'My Assets'  library pageNEWLIB
When I click Add to Work Request button on 'My Assets' library page
And I fill following fields on Create New Work Request popup on 'My Assets' pagNEWLIB:
| FieldName           | FieldValue |
| Select template     | WRT_S05    |
| IncludeFiles        | true       |
| Name                | WR_S05     |
| Start date                | Today    |
| End date                | Tomorrow     |
Then I 'should' see file 'Fish7-Ad.mov' on work request 'WR_S05' folder '/Originals' files page
And 'should' see file 'Fish8-Ad.mov' on work request 'WR_S05' folder '/FWRT_S05' files page
