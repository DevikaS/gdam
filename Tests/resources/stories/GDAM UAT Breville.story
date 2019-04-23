!--QA-459
Feature:    Breville Scenario
Narrative:
In order to
As a              GlobalAdmin
I want to check Breville feature

Scenario: Check Projects Custom Meta Data Edit and Comments scenarios of breville
Meta:@ClientScenarioBreville
Given I impersonated as Client user 'brevillelive@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Name                                      | AAP3               |
| ProjectID                                 | Auto               |
| Project Type                              | Product            |
| Country                                   | United Kingdom     |
| Brand                                     | Breville           |
| Description                               | Desc               |
|Is Active                                  | Yes                |
And I publish the project 'AAP3'
And I create sub folder 'AAF' in folder '/AAP3' in project 'AAP3' using button NewFolder
And upload '/files/128_shortname.jpg' file into '/AAF' folder for 'AAP3' client 'brevillelive@adbank.me'
And upload '/files/Fish Ad.mov' file into '/AAF' folder for 'AAP3' client 'brevillelive@adbank.me'
And refresh the page
And I wait while preview is available in folder '/AAF' on project 'AAP3' files page for Client User 'brevillelive@adbank.me'
And I open file '128_shortname.jpg' on project 'AAP3' overview page
And I 'save' file info by next information:
| FieldName       | FieldValue |
|Country          | Australia  |
|Image Type       | Digital    |
And I refresh the page
Then I 'should' see following meta data fields on opened file info page:
| FieldName       | FieldValue |
|Country          | Australia  |
|Image Type       | Digital    |
When I click on 'Comments' tab on opened file info page
And I add comment 'It is my point of view' into current file UI
Then I 'should' see client's comment 'It is my point of view' for current file

Scenario: Check Projects Share scenarios of breville
Meta:@ClientScenarioBreville
Given I impersonated as Client user 'brevillelive@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Name                                      | AAP7               |
| ProjectID                                 | Auto               |
| Project Type                              | Product            |
| Country                                   | United Kingdom     |
| Brand                                     | Breville           |
| Description                               | Desc               |
|Is Active                                  | Yes                |
And I publish the project 'AAP7'
And I create sub folder 'AAF' in folder '/AAP7' in project 'AAP7' using button NewFolder
And upload '/files/128_shortname.jpg' file into '/AAF' folder for 'AAP7' client 'brevillelive@adbank.me'
And upload '/files/Fish Ad.mov' file into '/AAF' folder for 'AAP7' client 'brevillelive@adbank.me'
And refresh the page
And I wait while preview is available in folder '/AAF' on project 'AAP7' files page for Client User 'brevillelive@adbank.me'
And I send public link of file '128_shortname.jpg' to following client users:
| ExpireDate | UserEmails                   | Message |
| Today      |Pantry.Admin@breville.com.au  | hi dude |
And refresh the page
And I add secure share for file 'Fish Ad.mov' to following client users:
| UserEmails                   |
|  Pantry.Admin@breville.com.au|
And I go to project 'AAP7' overview page
And I create '/AAF2' folder in 'AAP7' project
And I open Share window from popup menu for folder '/AAF2' on client project 'AAP7'
And I fill Share popup of project folder for user 'Pantry.Admin@breville.com.au' with role 'Project Contributor' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'Pantry.Admin@breville.com.au' on opened page
And I go to project list page
And I go to project 'AAP7' overview page
Then I 'should' see '/AAF2' folder in 'AAP7' project
When I go to project 'AAP7' overview page
And select folder '/AAF' in project 'AAP7'
Then I 'should' see '128_shortname.jpg' file inside '/AAF' folder for 'AAP7' client project
And I 'should' see 'Fish Ad.mov' file inside '/AAF' folder for 'AAP7' client project

Scenario: Check Projects File revisions scenarios of breville
Meta:@ClientScenarioBreville
Given I impersonated as Client user 'brevillelive@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Name                                      | AAP8               |
| ProjectID                                 | Auto               |
| Project Type                              | Product            |
| Country                                   | United Kingdom     |
| Brand                                     | Breville           |
| Description                               | Desc               |
|Is Active                                  | Yes                |
And I publish the project 'AAP8'
And I create sub folder 'AAF' in folder '/AAP8' in project 'AAP8' using button NewFolder
And upload '/files/128_shortname.jpg' file into '/AAF' folder for 'AAP8' client 'brevillelive@adbank.me'
And upload '/files/Fish Ad.mov' file into '/AAF' folder for 'AAP8' client 'brevillelive@adbank.me'
And refresh the page
And I wait while preview is available in folder '/AAF' on project 'AAP8' files page for Client User 'brevillelive@adbank.me'
And I upload into client project 'AAP8' following revisions:
| FileName                 | Path      | MasterFileName        | Email                       |
| /files/128_shortname.jpg | /AAF      | 128_shortname.jpg     |Pantry.Admin@breville.com.au |
And refresh the page
And I wait while preview is available in folder '/AAF' on project 'AAP8' files page for Client User 'Pantry.Admin@breville.com.au'
And I go to file '128_shortname.jpg' version history page in folder '/AAF' client project 'AAP8'
Then I 'should' see revision '2' on file '128_shortname.jpg' version history page in folder '/AAF' client project 'AAP8' marked as Current

Scenario: Check Approval scenarios of breville
Meta:@ClientScenarioBreville
Given I impersonated as Client user 'brevillelive@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Name                                      | AAP9               |
| ProjectID                                 | Auto               |
| Project Type                              | Product            |
| Country                                   | United Kingdom     |
| Brand                                     | Breville           |
| Description                               | Desc               |
|Is Active                                  | Yes                |
And I publish the project 'AAP9'
And I create sub folder 'AAF' in folder '/AAP9' in project 'AAP9' using button NewFolder
And upload '/files/128_shortname.jpg' file into '/AAF' folder for 'AAP9' client 'brevillelive@adbank.me'
And upload '/files/Fish Ad.mov' file into '/AAF' folder for 'AAP9' client 'brevillelive@adbank.me'
And refresh the page
And I wait while preview is available in folder '/AAF' on project 'AAP9' files page for Client User 'brevillelive@adbank.me'
And I go to project 'AAP9' overview page
And select folder '/AAF' in project 'AAP9'
And I select file '128_shortname.jpg' on project files page
And click Send for Approval button in More dropdown on project files page
And click Create new approval on Submit files for approval popup
And fill approval stage on opened Add a new Stage popup with following information for client:
|Name          | Approvers                           | Deadline         | Description      |
|Adstream Admin| Pantry.Admin@breville.com.au        | 01/05/2023 12:15 | test description |
And click 'Start' element on opened Add a new Stage popup
And logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'Pantry.Admin@breville.com.au' on opened page
And click file '128_shortname.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
And logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'brevillelive@adbank.me' on opened page
And I go to project 'AAP9' overview page
And select folder '/AAF' in project 'AAP9'
And go to file '128_shortname.jpg' approvals page in folder 'AAF' client project 'AAP9'
Then I 'should' see approval stages with the following information:
| Name                         | Status   |
| Adstream Admin               | Approved |

Scenario: Check all possible Projects template scenarios of breville
Meta:@ClientScenarioBreville
Given I created users with following fields with no tests session:
| FirstName  |LastName         | Email                             | Role           | Agency                 |access                                                                            |
|Andy        |Smithe             | andy.smithe@sageappliances.co.uk  |guest.user      | Breville               |library,folders,approvals,annotations,frame_grabber,presentations,dashboard       |
And I impersonated as Client user 'brevillelive@adbank.me' on opened page
When I create new template with following fields for Client:
| FieldName                                 | FieldValue         |
| ProjectID                                 | Auto               |
| Project Type                              | Product            |
| Country                                   | United Kingdom     |
| Brand                                     | Breville           |
| Name                                      | AAT3               |
| Description                               | Desc               |
| Is Active                                 | Yes                |
And I go to add contact popup page
When I select user with name 'andy.smithe@sageappliances.co.uk' in AddUsersPopUp with email
And click element 'AddButton' on page 'AddressBookAddUsersPopUp'
When I go on Address Book page
And I select 'andy.smithe@sageappliances.co.uk' on Address Book with no Test Session
And I click Add to team template for users 'andy.smithe@sageappliances.co.uk' with no Test Session
And I fill team templates 'Temp' as 'new' with no test session
And I click add button on the Add users team template popup
And I create sub folder 'AAFT' in folder '/AAT3' in template 'AAT3' using button NewFolder
And wait for '2' seconds
And I go to template 'AAT3' teams page
And I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberTeamTemplateItem' on page 'TeamsPage'
And fill client add team template popup with team 'Temp' into template 'AAT3' team expired '12.12.2021' for folder '/AAFT'
And click Add role button on permissions popup of template team tab
And click Save button on permissions popup of project team tab
And refresh the page
And I go to Create New Project page
And I specify template name 'AAT3' on Create New Project popup via UI
And fill following fields on Create New Project popup for Client:
| FieldName     | FieldValue          |
| Name          | AAP4                |
And click on element 'SaveButton'
And I publish the project 'AAP4'
And wait for '10' seconds
And I go to project 'AAP4' teams page
Then I 'should' see user 'Andy Smithe' name in teams for client project 'AAP4'


Scenario: Check all possible Library and Edit MetaData scenarios of breville
Meta:@ClientScenarioBreville
Given I created users with following fields with no tests session:
| FirstName  |LastName         | Email                             | Role           | Agency                 |access                                                                            |
|Andy        |Smithe             | andy.smithe@sageappliances.co.uk  |guest.user      | Breville               |streamlined_library,folders,approvals,annotations,frame_grabber,presentations,dashboard       |
And I impersonated as Client user 'brevillelive@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue                 |
| Name                                      | AAP5                       |
| ProjectID                                 | Auto                       |
| Project Type                              | Product                    |
| Country                                   | United Kingdom             |
| Brand                                     | Breville                   |
| Description                               | Desc                       |
|Is Active                                  | Yes                        |
|Project Owners                             |Pantry.Admin@breville.com.au|
And I go to project 'AAP5' teams page
Then I 'should' see user 'Pantry Admin' name in teams for client project 'AAP5'
When I publish the project 'AAP5'
And I create '/AAF' folder in 'AAP5' project
And upload '/files/128_shortname.jpg' file into '/AAF' folder for 'AAP5' client 'brevillelive@adbank.me'
And upload '/files/Fish Ad.mov' file into '/AAF' folder for 'AAP5' client 'brevillelive@adbank.me'
And upload '/files/image9.jpg' file into '/AAF' folder for 'AAP5' client 'brevillelive@adbank.me'
And upload '/files/_file1.gif' file into '/AAF' folder for 'AAP5' client 'brevillelive@adbank.me'
And refresh the page
And wait for '3' seconds
And I wait while preview is available in folder '/AAF' on project 'AAP5' files page for Client User 'brevillelive@adbank.me'
And select files on project files page:
|FileName|
|128_shortname.jpg|
|Fish Ad.mov|
|image9.jpg|
|_file1.gif|
And I click Edit 'All' Selected link from More drop down from project folder page and fill with below data for '4' files:
| FieldName         | FieldValue        |
|  Country          | USA               |
And select files on project files page:
|FileName         |
|128_shortname.jpg|
|Fish Ad.mov      |
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And click on element 'SaveButton'
And I refresh the page
When I go to administration area collections page
And I create category 'coll_1' via UI
And add users via UI 'andy.smithe@sageappliances.co.uk' to category 'coll_1' with role 'Library User' by users details
And add following metadata on opened category page:
| FilterName         | FilterValue             |
| Country            | USA                     |
And I create category 'coll_2' via UI
And add users via UI 'andy.smithe@sageappliances.co.uk' to category 'coll_2' with role 'library.viewer' by users details
And add following metadata on opened category page:
| FilterName         | FilterValue             |
| Country            | Australia               |
When I go to the library page of collection 'coll_1' for user 'brevillelive@adbank.me'NEWLIB
And I wait for '10' seconds
Then I 'should' see assets '128_shortname.jpg,Fish Ad.mov' in the collection 'coll_1'NEWLIB
When I logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'Pantry.Admin@breville.com.au' on opened page
And I wait for '5' seconds
And I go to project 'AAP5' overview page
And select folder '/AAF' in project 'AAP5'
And select files on project files page:
|FileName  |
|image9.jpg|
|_file1.gif|
And I click Edit 'One by one' Selected link from More drop down from project folder page and fill with below data for '2' files:
| FieldName         | FieldValue        |
|  Country          |Australia          |
And I select file 'image9.jpg' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And click on element 'SaveButton'
And I refresh the page
And I logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'brevillelive@adbank.me' on opened page
And I wait for '5' seconds
When I go to the library page of collection 'coll_2' for user 'brevillelive@adbank.me'NEWLIB
And I wait for '10' seconds
Then I 'should' see assets 'image9.jpg' in the collection 'coll_2'NEWLIB
And I 'should not' see assets 'Fish Ad.mov' in the collection 'coll_2'NEWLIB
When I logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'andy.smithe@sageappliances.co.uk' on opened page
When I go to the library page of collection 'coll_1' for user 'andy.smithe@sageappliances.co.uk'NEWLIB
When I go to asset 'Fish Ad.mov' info page in library for collection 'coll_1' for user 'andy.smithe@sageappliances.co.uk'NEWLIB
Then I 'should' see 'download original' button on opened asset info pageNEWLIB
When I go to the library page of collection 'coll_2' for user 'andy.smithe@sageappliances.co.uk'NEWLIB
When I go to asset 'image9.jpg' info page in library for collection 'coll_2' for user 'andy.smithe@sageappliances.co.uk'NEWLIB
Then I 'should not' see 'download original' button on opened asset info pageNEWLIB
And 'Original' files 'Fish Ad.mov' is downloaded for client as 'Fish_Ad_master-rev-1.mov' in collection 'coll_1' from Library for 'andy.smithe@sageappliances.co.uk'


