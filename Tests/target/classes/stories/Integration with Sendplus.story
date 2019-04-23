
Feature:          Integration with Sendplus
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Integration with Sendplus (api testing)


Scenario: Check of the download via Sendplus from folder
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created 'IWNVP' project
And created '/IWNVF' folder for project 'IWNVP'
And uploaded '/files/logo3.jpg' file into '/IWNVF' folder for 'IWNVP' project
And waited while preview is available in folder '/IWNVF' on project 'IWNVP' files page
And I am on file '/files/logo3.jpg' info page in folder '/IWNVF' project 'IWNVP'
When I click element 'DownloadMasterUsingSendplus' on page 'FileInfoPage'
And click element 'ConfirmDownloadMasterUsingSendplus' on page 'FileInfoPage'
Then I should see message in jabber for file 'logo3.jpg' from folder '/IWNVF' project 'IWNVP'

Scenario: Check that download via Sendplus from folder generate activity record
Meta: @sendplusUATgdamsmoke
      @livegdamsmoke
Given I created 'IWNVP' project
And created '/IWNVF' folder for project 'IWNVP'
And uploaded '/files/logo3.jpg' file into '/IWNVF' folder for 'IWNVP' project
And waited while preview is available in folder '/IWNVF' on project 'IWNVP' files page
And I am on file '/files/logo3.jpg' info page in folder '/IWNVF' project 'IWNVP'
When I click element 'DownloadMasterUsingSendplus' on page 'FileInfoPage'
And click element 'ConfirmDownloadMasterUsingSendplus' on page 'FileInfoPage'
And wait for '15' seconds
Then I 'should' see on Activity tab for file '/files/logo3.jpg' in folder '/IWNVF' project 'IWNVP' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file master |
When I go to project 'IWNVP' overview page
Then I 'should' see activity for user 'AgencyAdmin' on project 'IWNVP' overview page with message 'downloaded file master' and value '/IWNVP/IWNVF/logo3.jpg'
When I go to Dashboard page
And maximize 'Recent Activity' section on Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName        | Message                      | Value                                                  |
| AgencyAdmin | downloaded file master | /IWNVP/IWNVF/logo3.jpg |


Scenario: Check of the download via Sendplus from library
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I uploaded file '/files/logo2.png' into my libraryNEWLIB
And I waited while preview is visible on library page for collection 'My Assets' for asset 'logo2.png'NEWLIB
And on asset 'logo2.png' info page in Library for collection 'My Assets'NEWLIB
When I 'download master' on opened asset info page using sendplus
Then I should see message in jabber for asset 'logo2.png' from collection 'My Assets'

Scenario: Check that download via Sendplus from library should generate activity record
Meta: @sendplusUATgdamsmoke
      @livegdamsmoke
Given I am on Dashboard page
And uploaded file '/files/logo2.png' into my libraryNEWLIB
And I waited while preview is visible on library page for collection 'My Assets' for asset 'logo2.png'NEWLIB
And on asset 'logo2.png' info page in Library for collection 'My Assets'NEWLIB
When I 'download master' on opened asset info page using sendplus
And wait for '5' seconds
And I go to asset 'logo2.png' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'logo2.png' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message        | Value |
| AgencyAdmin | Downloaded by|       |
When I go to Dashboard page
Then I 'should' see the following activities on asset 'logo2.png' activity page for collection 'My Assets':
| UserName    | Message                 | Value |
| AgencyAdmin | downloaded asset master |       |


Scenario: Check of upload to projects via sendplus
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created 'IWNVP' project
And created '/IWNVF2' folder for project 'IWNVP'
And uploaded '/files/logo3.jpg' file into '/IWNVF2' folder for 'IWNVP' project using sendplus middle tier api
And waited while preview is available in folder '/IWNVF2' on project 'IWNVP' files page

Scenario: Check that upload to projects via Sendplus  generates activity record
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created 'IWNVP' project
And created '/IWNVF2' folder for project 'IWNVP'
And uploaded '/files/logo3.jpg' file into '/IWNVF2' folder for 'IWNVP' project using sendplus middle tier api
And waited while preview is available in folder '/IWNVF2' on project 'IWNVP' files page
Then I 'should' see on Activity tab for file '/files/logo3.jpg' in folder '/IWNVF2' project 'IWNVP' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_uploaded | uploaded file |

Scenario: Check of upload to library via sendplus
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I uploaded '/files/logo3.jpg' file into  library folder using sendplus middle tier api
And I waited while preview is visible on library page for collection 'My Assets' for asset 'logo3.jpg'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see assets with titles 'logo3.jpg' in the collection 'My Assets'NEWLIB


Scenario: Check that upload to library via Sendplus  generates activity record
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I uploaded '/files/logo3.jpg' file into  library folder using sendplus middle tier api
And I waited while preview is visible on library page for collection 'My Assets' for asset 'logo3.jpg'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see assets with titles 'logo3.jpg' in the collection 'My Assets'NEWLIB
When I go to asset 'logo3.jpg' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'logo3.jpg' activity page for collection 'My Assets'NEWLIB:
| UserName    | Message                 | Value |
| AgencyAdmin | Uploaded by          |       |

Scenario: Check that downloading multiple files with both master and proxy via sendplus from folder
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
And uploaded into project 'POGP1' following files:
| FileName                    | Path |
| /files/logo1.gif            | /F1  |
| /files/logo2.png            | /F1  |
When I wait while transcoding is finished in folder '/F1' on project 'POGP1' files page
And I go to project 'POGP1' overview page
And I click on download via sendplus from folder 'F1' in project 'POGP1'
Then I should see message in jabber for the following files from folder '/F1' project 'POGP1':
| FileName     |
| logo1_master.gif |
| logo1_proxy.gif  |
| logo2_master.png |
| logo2_proxy.png  |


Scenario: Check that files downloaded in sendplus are based on the download permisssion (file download and proxy download)
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created '<Role>' role with '<Permission>' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email           | Role         |
| <User>  | agency.user  |
And created '<Project>' project
And created '/IWNVP_F01' folder for project '<Project>'
And uploaded into project '<Project>' following files:
| FileName                    | Path |
| /files/logo1.gif            | /IWNVP_F01  |
And I waited while transcoding is finished in folder '/IWNVP_F01' on project '<Project>' files page
And I am on project '<Project>' folder '/IWNVP_F01' page
When go to project '<Project>' folder 'root' page
And select folder '/IWNVP_F01' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share popup of project folder for user '<User>' with role '<Role>' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And login with details of '<User>'
When I go to project '<Project>' overview page
And I click on download via sendplus from folder 'IWNVP_F01' in project '<Project>'
Then I see the following files downloaded in jabber from folder '/IWNVP_F01' project '<Project>':
| FileName     |Should|
| <MasterFile> |<IsMasterDisplayed>|
| <ProxyFile> |<IsProxyDisplayed>|
Examples:
|Permission|Role|MasterFile|IsMasterDisplayed|ProxyFile|IsProxyDisplayed|User|Project|
|element.share,folder.read,element.read,project.read,folder.share,file.download,proxy.download|IWNVP_R01|logo1_master.gif|should|logo1_proxy.gif|should|IWNVP_U01|IWNVP_P01|
|element.share,folder.read,element.read,project.read,folder.share,proxy.download|IWNVP_R02|logo1_master.gif|should not|logo1_proxy.gif|should|IWNVP_U02|IWNVP_P02|
|element.share,folder.read,element.read,project.read,folder.share,file.download|IWNVP_R03|logo1_master.gif|should|logo1_proxy.gif|should not|IWNVP_U03|IWNVP_P03|


Scenario: Check of upload file revision using sendplus and make sure it generates the activity
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
And uploaded into project 'POGP1' following files:
| FileName                    | Path |
| /files/logo1.gif            | /F1  |
And I waited while transcoding is finished in folder '/F1' on project 'POGP1' files page
When I go to file 'logo1.gif' info page in folder '/F1' project 'POGP1'
And I upload an revision '/files/logo3.jpg' to file 'logo1.gif' in folder '/F1' project 'POGP1' using sendplus middletier api
And I refresh the page
And I click element 'VersionHistory' on page 'FilesPage'
Then I should see next version 'V2' on version history tab
And I 'should' see on Activity tab for file '/files/logo1.gif' in folder '/F1' project 'POGP1' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_uploaded | uploaded file revision |
When I go to project 'POGP1' overview page
Then I 'should' see activity for user 'AgencyAdmin' on project 'POGP1' overview page with message 'uploaded file revision' and value '/POGP1/F1/logo1.gif'
When I go to Dashboard page
And maximize 'Recent Activity' section on Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName        | Message                      | Value                                                  |
| AgencyAdmin | uploaded file revision | /POGP1/F1/logo1.gif |


Scenario: Check of upload attachment to asset using sendplus and make sure it generates the activity
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I uploaded following assetsNEWLIB:
| Name              |
| /files/logo2.png |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I am on asset 'logo2.png' info page in Library for collection 'My Assets' on attachment assets pageNEWLIB
When I upload an attachment '/files/logo3.jpg' to asset 'logo2.png' for collection 'My Assets' using sendplus middletier api
And I go to Dashboard page
And I refresh the page
And maximize 'Recent Activity' section on Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName        | Message                      | Value                                                  |
| AgencyAdmin |  uploaded attachment(s) logo3.jpg to logo2.png |logo2.png |
When I go to asset 'logo2.png' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'logo2.png' activity page for collection 'My Assets'NEWLIB:
| UserName       | Message                               | Value       |
| AgencyAdmin | Attachment Created by |   |
When I go to asset 'logo2.png' info page in Library for collection 'My Assets' on attachment assets pageNEWLIB
Then I should see following data on asset attachments page:
| File Name  |Size|
| logo3.jpg |2.9KB|



Scenario: Check of upload of project file attachment using sendplus and make sure it generates the activity
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
And uploaded into project 'POGP1' following files:
| FileName                    | Path |
| /files/logo1.gif            | /F1  |
And I waited while transcoding is finished in folder '/F1' on project 'POGP1' files page
When I go to file 'logo1.gif' info page in folder '/F1' project 'POGP1' tab attachments files
And I upload an file attachment '/files/logo3.jpg' to file 'logo1.gif' in folder '/F1' project 'POGP1' using sendplus middletier api
And I refresh the page
Then I 'should' see attached file 'logo3.jpg' on file info page in tab attachments files
And I 'should' see on Activity tab for file '/files/logo1.gif' in folder '/F1' project 'POGP1' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_uploaded | uploaded attachment(s) logo3.jpg to logo1.gif |
And I 'should' see activity for user 'AgencyAdmin' on project 'POGP1' overview page with message 'uploaded attachment(s) logo3.jpg to logo1.gif' and value '/POGP1/F1/logo1.gif'
When I go to Dashboard page
And maximize 'Recent Activity' section on Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName        | Message                      | Value                                                  |
| AgencyAdmin | uploaded attachment(s) logo3.jpg to logo1.gif | /POGP1/F1/logo1.gif |

Scenario: Check activity when folder is downloaded via Sendplus
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created 'IWNVP' project
And created '/IWNVF' folder for project 'IWNVP'
And uploaded '/files/logo3.jpg' file into '/IWNVF' folder for 'IWNVP' project
And waited while preview is available in folder '/IWNVF' on project 'IWNVP' files page
And I am on project 'IWNVP' folder '/IWNVF' page
When I click Download By Sendplus from context menu for folder '/IWNVF' on project 'IWNVP'
And wait for '2' seconds
And refresh the page
And go to project 'IWNVP' overview page
Then I 'should' see activity for user 'AgencyAdmin' on project 'IWNVP' overview page with message 'downloaded folder' and value 'IWNVF'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName    | Message                            | Value   |
| AgencyAdmin | downloaded folder                  | IWNVF   |

Scenario: Check activity when project is downloaded via Sendplus
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created 'IWNVP' project
And created '/IWNVF' folder for project 'IWNVP'
And uploaded '/files/logo3.jpg' file into '/' folder for 'IWNVP' project
And waited while preview is available in folder '/' on project 'IWNVP' files page
And I am on project 'IWNVP' folder '/' page
When I click Download By Sendplus from context menu for folder '' on project 'IWNVP'
And wait for '2' seconds
And refresh the page
And go to project 'IWNVP' overview page
Then I 'should' see activity for user 'AgencyAdmin' on project 'IWNVP' overview page with message 'downloaded folder' and value 'IWNVP'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName    | Message                            | Value   |
| AgencyAdmin | downloaded folder                  | IWNVP   |

Scenario: Check activity when Master and Proxy is downloaded via Sendplus
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I created following projects:
| Name  | Job Number |
| MAPP1 | POGJ1      |
And created '/F1' folder for project 'MAPP1'
And uploaded into project 'MAPP1' following files:
| FileName                    | Path |
| /files/logo1.gif            | /F1  |
| /files/logo2.png            | /F1  |
When I wait while transcoding is finished in folder '/F1' on project 'MAPP1' files page
And I go to project 'MAPP1' folder '/F1' page
And I select file 'logo1.gif,logo2.png' on project files page
And I click Download button on project files page
When I select checkbox 'master,proxy' and click download by Sendplus
And wait for '2' seconds
And refresh the page
And go to file '/files/logo1.gif' info page in folder '/F1' project 'MAPP1'
Then I 'should' see on Activity tab for file '/files/logo1.gif' in folder '/F1' project 'MAPP1' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage           |
| AgencyAdmin | EMPTY | downloaded   | downloaded file master    |
| AgencyAdmin | EMPTY | downloaded   | downloaded file preview   |
And go to file '/files/logo2.png' info page in folder '/F1' project 'MAPP1'
Then I 'should' see on Activity tab for file '/files/logo2.png' in folder '/F1' project 'MAPP1' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage           |
| AgencyAdmin | EMPTY | downloaded   | downloaded file master    |
| AgencyAdmin | EMPTY | downloaded   | downloaded file preview   |
When go to project 'MAPP1' overview page
Then I 'should' see activity for user 'AgencyAdmin' on project 'MAPP1' overview page with message 'downloaded file master' and value '/MAPP1/F1/logo1.gif'
And I 'should' see activity for user 'AgencyAdmin' on project 'MAPP1' overview page with message 'downloaded file preview' and value '/MAPP1/F1/logo1.gif'
And I 'should' see activity for user 'AgencyAdmin' on project 'MAPP1' overview page with message 'downloaded file master' and value '/MAPP1/F1/logo2.png'
And I 'should' see activity for user 'AgencyAdmin' on project 'MAPP1' overview page with message 'downloaded file preview' and value '/MAPP1/F1/logo2.png'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName    | Message                            | Value                 |
| AgencyAdmin | downloaded file master             | /MAPP1/F1/logo1.gif   |
| AgencyAdmin | downloaded file preview            | /MAPP1/F1/logo1.gif   |
| AgencyAdmin | downloaded file master             | /MAPP1/F1/logo2.png   |
| AgencyAdmin | downloaded file preview            | /MAPP1/F1/logo2.png   |
