Feature:    FCTG DAM Scenarios
Narrative:
In order to
As a              GlobalAdmin
I want to         Check Project, Template, SendToLibrary by editing metadata and check download permission cases

Scenario: Check Projects Custom Meta Data Edit and Comments of FCTG
Meta:
@ClientScenarioFCTG
!--QA-460--
Given I impersonated as Client user 'fctgdam@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Brand                                     | Escape Travel      |
| Brand Country                             | United kingdom     |
| Content Category                          | Published Content  |
| Category 1                                | Publications       |
| Category 2                                | Brochure           |
| Category 3                                | Flight Guides      |
| Name                                      | TestFCTG           |
|ProjectId                                  | Auto               |
|Can this be used for Social Media content? | NO                 |
|Is this active?                            | YES                |
| Month                                     | 12. December       |
| Year                                      | 2017               |
And I create sub folder 'AAF' in folder '/TestFCTG' in project 'TestFCTG' using button NewFolder
And upload '/files/128_shortname.jpg' file into '/AAF' folder for 'TestFCTG' client 'fctgdam@adbank.me'
And upload '/files/Fish Ad.mov' file into '/AAF' folder for 'TestFCTG' client 'fctgdam@adbank.me'
And refresh the page
And I wait while preview is available in folder '/AAF' on project 'TestFCTG' files page for Client User 'fctgdam@adbank.me'
And I open file '128_shortname.jpg' on project 'TestFCTG' overview page
And I 'save' file info by next information:
| FieldName       | FieldValue |
| Brand Country   | Australia  |
And I refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName       | FieldValue |
| Brand Country   | Australia  |
When I click on 'Comments' tab on opened file info page
And I add comment 'It is my point of view' into current file UI
Then I 'should' see client's comment 'It is my point of view' for current file

Scenario: Check Projects File Share of FCTG
Meta:
@ClientScenarioFCTG
!--QA-460
Given I created users with following fields with no tests session:
| FirstName       | LastName          | Email                              | Role           | Agency                 |Access                                                                           |
|Leed             | Chapline          | leed_chapline@flightcentre.com      |agency.admin     | FCTG DAM               |streamlined_library,folders,approvals,annotations,frame_grabber,presentations,dashboard    |
And I impersonated as Client user 'fctgdam@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Brand                                     | Escape Travel      |
| Brand Country                             | United kingdom     |
| Content Category                          | Published Content  |
| Category 1                                | Publications       |
| Category 2                                | Brochure           |
| Category 3                                | Flight Guides      |
| Name                                      | ProjectShare       |
|ProjectId                                  | Auto               |
|Can this be used for Social Media content? | NO                 |
|Is this active?                            | YES                |
| Month                                     | 12. December       |
| Year                                      | 2017               |
And I create sub folder 'AAF' in folder '/ProjectShare' in project 'ProjectShare' using button NewFolder
And upload '/files/128_shortname.jpg' file into '/AAF' folder for 'ProjectShare' client 'fctgdam@adbank.me'
And upload '/files/Fish Ad.mov' file into '/AAF' folder for 'ProjectShare' client 'fctgdam@adbank.me'
And refresh the page
And I wait while preview is available in folder '/AAF' on project 'ProjectShare' files page for Client User 'fctgdam@adbank.me'
And I send public link of file '128_shortname.jpg' to following client users:
| ExpireDate | UserEmails                  | Message |
| Today      |leed_chapline@flightcentre.com| hi dude |
And refresh the page
And I add secure share for file '128_shortname.jpg' to following client users:
| UserEmails                   |
| leed_chapline@flightcentre.com|
And I go to project 'ProjectShare' overview page
And I create sub folder 'AAF2' in folder '/ProjectShare' in project 'ProjectShare' using button NewFolder
And I open Share window from popup menu for folder '/AAF2' on client project 'ProjectShare'
And I fill Share popup of project folder for user 'leed_chapline@flightcentre.com' with role 'Project Contributor' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'leed_chapline@flightcentre.com' on opened page
And I go to project list page
And I go to project 'ProjectShare' overview page
Then I 'should' see '/AAF2' folder in 'ProjectShare' project
When I go to project 'ProjectShare' overview page
And select folder '/AAF' in project 'ProjectShare'
Then I 'should' see '128_shortname.jpg' file inside '/AAF' folder for 'ProjectShare' client project
And I 'should' see 'Fish Ad.mov' file inside '/AAF' folder for 'ProjectShare' client project


Scenario: Check Projects File revisions of FCTG
Meta:
@ClientScenarioFCTG
!--QA-460
Given I created users with following fields with no tests session:
| FirstName       | LastName          | Email                              | Role           | Agency                 |Access                                                                           |
|Leed             | Chapline          | leed_chapline@flightcentre.com      |agency.admin     | FCTG DAM               |streamlined_library,folders,approvals,annotations,frame_grabber,presentations,dashboard    |
And I impersonated as Client user 'fctgdam@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Brand                                     | Escape Travel      |
| Brand Country                             | United kingdom     |
| Content Category                          | Published Content  |
| Category 1                                | Publications       |
| Category 2                                | Brochure           |
| Category 3                                | Flight Guides      |
| Name                                      | ProjectFileRevFCTG |
|ProjectId                                  | Auto               |
|Can this be used for Social Media content? | NO                 |
|Is this active?                            | YES                |
| Month                                     | 12. December       |
| Year                                      | 2017               |
And I create sub folder 'AAF' in folder '/ProjectFileRevFCTG' in project 'ProjectFileRevFCTG' using button NewFolder
And upload '/files/128_shortname.jpg' file into '/AAF' folder for 'ProjectFileRevFCTG' client 'fctgdam@adbank.me'
And upload '/files/Fish Ad.mov' file into '/AAF' folder for 'ProjectFileRevFCTG' client 'fctgdam@adbank.me'
And refresh the page
And I wait while preview is available in folder '/AAF' on project 'ProjectFileRevFCTG' files page for Client User 'fctgdam@adbank.me'
And I upload into client project 'ProjectFileRevFCTG' following revisions:
| FileName                 | Path      | MasterFileName        | Email                       |
| /files/128_shortname.jpg | /AAF      | 128_shortname.jpg     |leed_chapline@flightcentre.com|
And refresh the page
And I wait while preview is available in folder '/AAF' on project 'ProjectFileRevFCTG' files page for Client User 'leed_chapline@flightcentre.com'
And I go to file '128_shortname.jpg' version history page in folder '/AAF' client project 'ProjectFileRevFCTG'
Then I 'should' see revision '2' on file '128_shortname.jpg' version history page in folder '/AAF' client project 'ProjectFileRevFCTG' marked as Current

Scenario: Check Projects File Approval of FCTG
Meta:
@ClientScenarioFCTG
!--QA-460
Given I created users with following fields with no tests session:
| FirstName       | LastName          | Email                              | Role           | Agency                 |Access                                                                           |
|Leed             | Chapline          | leed_chapline@flightcentre.com      |agency.admin     | FCTG DAM               |streamlined_library,folders,approvals,annotations,frame_grabber,presentations,dashboard    |
And I impersonated as Client user 'fctgdam@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Brand                                     | Escape Travel      |
| Brand Country                             | United kingdom     |
| Content Category                          | Published Content  |
| Category 1                                | Publications       |
| Category 2                                | Brochure           |
| Category 3                                | Flight Guides      |
| Name                                      | ProjectApprovalFCTG           |
|ProjectId                                  | Auto               |
|Can this be used for Social Media content? | NO                 |
|Is this active?                            | YES                |
| Month                                     | 12. December       |
| Year                                      | 2017               |
And I create sub folder 'AAF' in folder '/ProjectApprovalFCTG' in project 'ProjectApprovalFCTG' using button NewFolder
And upload '/files/128_shortname.jpg' file into '/AAF' folder for 'ProjectApprovalFCTG' client 'fctgdam@adbank.me'
And upload '/files/Fish Ad.mov' file into '/AAF' folder for 'ProjectApprovalFCTG' client 'fctgdam@adbank.me'
And refresh the page
And wait for '2' seconds
And I wait while preview is available in folder '/AAF' on project 'ProjectApprovalFCTG' files page for Client User 'fctgdam@adbank.me'
And I go to project 'ProjectApprovalFCTG' overview page
And select folder '/AAF' in project 'ProjectApprovalFCTG'
And I select file '128_shortname.jpg' on project files page
And click Send for Approval button in More dropdown on project files page
And click Create new approval on Submit files for approval popup
And fill approval stage on opened Add a new Stage popup with following information for client:
|Name      | Approvers                   | Deadline         | Description      |
|FCTG Admin| leed_chapline@flightcentre.com| 01/05/2023 12:15 | test description |
And click 'Start' element on opened Add a new Stage popup
And logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'leed_chapline@flightcentre.com' on opened page
And click file '128_shortname.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
And logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'fctgdam@adbank.me' on opened page
And I go to project 'ProjectApprovalFCTG' overview page
And select folder '/AAF' in project 'ProjectApprovalFCTG'
And go to file '128_shortname.jpg' approvals page in folder 'AAF' client project 'ProjectApprovalFCTG'
Then I 'should' see approval stages with the following information:
| Name                     | Status   |
| FCTG Admin               | Approved |




Scenario: Check all possible Project Template cases of FCTG
Meta:@ClientScenarioFCTG
Given I created users with following fields with no tests session:
| FirstName       | LastName          | Email                               | Role            | Agency                 |Access                                                                           |
|Leed             | Chapline          | leed_chapline@flightcentre.com      |agency.admin     | FCTG DAM               |streamlined_library,folders,approvals,annotations,frame_grabber,presentations,dashboard    |
|harry            | Kane              | harrykane@flightcentre.com          |agency.user      | FCTG DAM               |streamlined_library,folders,approvals,annotations,frame_grabber,presentations,dashboard    |
And I impersonated as Client user 'fctgdam@adbank.me' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Brand                                     | Flight Centre      |
| Brand Country                             | Australia          |
| Content Category                          | Standards & Assets |
| Category 1                                | Elements           |
| Name                                      | FCTGProject    |
|Project Owners                             |leed_chapline@flightcentre.com  |
And I go to project 'FCTGProject' teams page using UI
Then I 'should' see user 'Leed Chapline' name in teams for client project 'FCTGProject'
And I refresh the page
When I create '/FCTG_Folder' folder in 'FCTGProject' project
And upload '/images/bg_img.jpg' file into '/FCTG_Folder' folder for 'FCTGProject' client 'fctgdam@adbank.me'
And upload '/files/GWGTest2.pdf' file into '/FCTG_Folder' folder for 'FCTGProject' client 'fctgdam@adbank.me'
And upload '/files/image9.jpg' file into '/FCTG_Folder' folder for 'FCTGProject' client 'fctgdam@adbank.me'
And upload '/files/doc2.zip' file into '/FCTG_Folder' folder for 'FCTGProject' client 'fctgdam@adbank.me'
And refresh the page
And I wait while preview is available in folder '/FCTG_Folder' on project 'FCTGProject' files page for Client User 'fctgdam@adbank.me'
And select files on project files page:
|FileName|
|bg_img.jpg|
|GWGTest2.pdf|
And I click Edit 'All' Selected link from More drop down from project folder page and fill with below data for '2' files:
| FieldName         | FieldValue        |
| Brand Country     | United Kingdom    |
And wait for '2' seconds
And select files on project files page:
|FileName|
|bg_img.jpg|
|GWGTest2.pdf|
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And click on element 'SaveButton'
And I refresh the page
When I go to administration area collections page
And I create category '1_FCTGcoll' via UI
And add users via UI 'harrykane@flightcentre.com' to category '1_FCTGcoll' with role 'Library User' by users details
And add following metadata on opened category page:
| FilterName        | FilterValue       |
| Brand Country     | United Kingdom    |
And I create category '2_FCTGcoll' via UI
And wait for '5' seconds
And add users via UI 'harrykane@flightcentre.com' to category '2_FCTGcoll' with role 'library.viewer' by users details
And add following metadata on opened category page:
| FilterName        | FilterValue        |
| Brand Country     |   USA              |
When I go to the library page of collection '1_FCTGcoll' for user 'fctgdam@adbank.me'NEWLIB
And I wait for '10' seconds
Then I 'should' see assets 'bg_img.jpg,GWGTest2.pdf' in the collection '1_FCTGcoll'NEWLIB
When I logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'leed_chapline@flightcentre.com' on opened page
And I wait for '5' seconds
And I go to project 'FCTGProject' overview page
And select folder '/FCTG_Folder' in project 'FCTGProject'
And select files on project files page:
|FileName|
|image9.jpg|
|doc2.zip|
And I click Edit 'One by one' Selected link from More drop down from project folder page and fill with below data for '2' files:
| FieldName         | FieldValue         |
| Brand Country     |   USA              |
And select files on project files page:
|FileName|
|image9.jpg|
|doc2.zip|
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And click on element 'SaveButton'
And I logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'fctgdam@adbank.me' on opened page
When I go to the library page of collection '2_FCTGcoll' for user 'fctgdam@adbank.me'NEWLIB
And I wait for '10' seconds
Then I 'should' see assets 'image9.jpg,doc2.zip' in the collection '2_FCTGcoll'NEWLIB
And I 'should not' see assets 'bg_img.jpg,GWGTest2.pdf' in the collection '2_FCTGcoll'NEWLIB
When I logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'harrykane@flightcentre.com' on opened page
When I go to the library page of collection '1_FCTGcoll' for user 'harrykane@flightcentre.com'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in library for collection '1_FCTGcoll' for user 'harrykane@flightcentre.com'NEWLIB
Then I 'should' see 'download original' button on opened asset info pageNEWLIB
When I go to the library page of collection '2_FCTGcoll' for user 'harrykane@flightcentre.com'NEWLIB
When I go to asset 'image9.jpg' info page in library for collection '2_FCTGcoll' for user 'harrykane@flightcentre.com'NEWLIB
Then I 'should not' see 'download original' button on opened asset info pageNEWLIB
And 'Original' files 'GWGTest2.pdf' is downloaded for client as 'GWGTest2_original-rev-1.pdf' in collection '1_FCTGcoll' from Library for 'harrykane@flightcentre.com'







