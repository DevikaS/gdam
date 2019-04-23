Feature:          Agency Admin - MediaChecker
Narrative:
In order to
As a              AgencyAdmin
I want to         execute all the media checker scenarios in Media Manager

Scenario: Check media checker user can see the request specification details in mediachecker
!--QA-1084
Meta:@mediamanager
     @qamediamanagersmoke
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration |  First Air Date | Format         | Title    |  Subtitles Required | Supply Via  | Assignee               |  Message        | Deadline Date |DestinationID|ServiceLevel|
| automated test info    | MCMAR7     | MCMBR7  |MCSB7      | MCMPR7  | MCMC7    | MCMCN7       | 1        | 10/14/2022      | HD 1080i 25fps | MCMT7    |  Already Supplied   | FTP         | autotest@adstream.com  | automated test  | 12/14/2022    |1            | 2          |
When click element 'MediaManager' on page 'Projects'
And waited while order with clock number 'MCMCN7' is available in media manager
And go to Media Checker page
And search the media file by 'clock no.' with 'MCMCN7' in Media Checker page
And open on tile with clock number 'MCMCN7' in Media Checker page
Then I should see below 'MasterInfo' details in media checker page:
| FieldName      | Value             |
| Market	     | United Kingdom    |
| Agency	     | DefaultAgency     |
| Clock Number   | MCMCN7            |
| Advertiser	 | MCMAR7            |
| Product	     | MCMPR7            |
| Title	         | MCMT7             |
| Duration	     | 00:00:01:00       |
| Uploader	     | AgencyAdmin       |
|Subtitles       | Subtitles provided |




Scenario: Check asset is not attached to request after deleting in media checker
!--QA-976
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               |  Message        |  Already Supplied|Deadline Date |DestinationID|Motivnummer|
| automated test info    | MCMAR8     | MCMBR8  | MCMSB8    | MCMPR8  | MCMC8    | MCMCN8       | 1        | 10/14/2022     | HD 1080i 25fps | MCMT6    | FTP         | autotest@adstream.com  | automated test  | should not       |12/14/2022    |6228         | 123       |
When click element 'MediaManager' on page 'Projects'
And I search the media file by 'MCMCN8'
And waited while order with clock number 'MCMCN8' is available in media manager
And I upload file '/files/DeuSd_PASS.mov' to order with 'MCMCN8' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'MCMCN8' in upload page
And go to Media Checker page
And search the media file by 'clock no.' with 'MCMCN8' in Media Checker page
And open on tile with clock number 'MCMCN8' in Media Checker page
And wait for '2' seconds
And 'Delete' the request tile via media checker Master Info Page
And go to Media Manager Uploads page
And I search the media file by 'MCMCN8'
Then I 'shouldnot' see the file 'DeuSd_PASS.mov' attached to request


Scenario: Check that committed asset in media checker is shown in library
!--QA-1106 -- Currently On QA 23 host - For ingest to work we need to disable SAP in agency
Meta:@mediamanager
@qamediamanagersmoke
Given I created the agency 'SIAILA2' with default attributes
And updated the following agency:
| Name    | A4User        | Country        | Application Access                        |
| SIAILA2 | DefaultA4User | United Kingdom | adkits,library,media_manager,media_checker|
And I created users with following fields:
| Email    | Role          |AgencyUnique| Access                                    |
| SIAILU2  | agency.admin  |SIAILA2     |adkits,library,media_manager,media_checker |
And I logout from account
And I logged in with details of 'SIAILU2'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser | Brand    | Sub Brand  | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | SIAILAR2   | SIAILBR2 | SIAILSB2   | SIAILPR2 | SIAILC2   | SIAILCN2      | 1       | 10/14/2022     | HD 1080i 25fps | SIAILT2  | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 1             | Already Supplied  |
And waited for '10' seconds
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'SIAILCN2'
And waited while order with clock number 'SIAILCN2' is available in media manager
When I upload file '/files/GbrSd_PASS.mov' to order with 'SIAILCN2' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'SIAILCN2' in upload page
And I go to babylon Login page
And login with details of 'SIAILU2'
And go to Media Checker page
And search the media file by 'clock no.' with 'SIAILCN2' in Media Checker page
And open on tile with clock number 'SIAILCN2' in Media Checker page
And click tab 'MezzReport'
And wait until QC process spinner disappers in 'MezzReport' page
And click tab 'MezzInfo'
And 'Commit' the request tile via media checker Mezz Info Page
And I go to  Library page for collection 'Everything'
And wait for '100' seconds
And wait while transcoding is finished in collection 'Everything'
And refresh the page
And go to asset 'SIAILT2' info page in Library for collection 'Everything'
And refresh the page
And wait for '5' seconds
Then I 'should' see 'download storyboard' button on opened asset info page
And 'should' see playable preview on asset info page
When I go to  Library page for collection 'Everything'
And select all assets on the library page
And I click Download button on library page
And I select checkbox 'master' and click download on library page download popup
Then 'master' media manager files  'SIAILT2' from Library from collection 'Everything' is downloaded as 'master.zip'


Scenario: Check that in UAT order created via API for committed asset in media checker is shown in library
Meta: @mediamanagerUATSmoke
Given I created the following agency:
| Name      | A4User        |
| SIAILA2   | DefaultA4User |
And updated the following agency:
| Name    | Country        | Application Access                        |
| SIAILA2 | United Kingdom | adkits,library,media_manager,media_checker|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SIAILA2':
| Advertiser | Brand    | Sub Brand | Product |
| SIAILAR2   | SIAILBR2 | SIAILSB2  | SIAILPR2|
And I created users with following fields:
| Email    | Role          |AgencyUnique| Access                                    |
| SIAILU2  | agency.admin  |SIAILA2     |adkits,library,media_manager,media_checker |
And I logout from account
And I logged in with details of 'SIAILU2'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser | Brand    | Sub Brand  | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | SIAILAR2   | SIAILBR2 | SIAILSB2   | SIAILPR2 | SIAILC2   | SIAILCN2N     | 1       | 10/14/2022     | HD 1080i 25fps | SIAILT2  | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 954             | Already Supplied  |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'SIAILCN2N'
And waited while order with clock number 'SIAILCN2N' is available in media manager
When I upload file '/files/GbrSd_PASS.mov' to order with 'SIAILCN2N' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'SIAILCN2N' in upload page
And I go to babylon Login page
And login with details of 'SIAILU2'
And go to Media Checker page
And search the media file by 'clock no.' with 'SIAILCN2N' in Media Checker page
And open on tile with clock number 'SIAILCN2N' in Media Checker page
And click tab 'MezzInfo'
And 'Commit' the request tile via media checker Mezz Info Page
And I go to  Library page for collection 'Everything'
And wait for '100' seconds
And wait while transcoding is finished in collection 'Everything'
And go to asset 'SIAILT2' info page in Library for collection 'Everything'
Then I 'should' see 'download storyboard' button on opened asset info page
And 'should' see playable preview on asset info page
When I go to  Library page for collection 'Everything'
And select all assets on the library page
And I click Download button on library page
And I select checkbox 'master' and click download on library page download popup
Then 'master' media manager files  'SIAILT2' from Library from collection 'Everything' is downloaded as 'master.zip'


Scenario: Check that you see asset missed deadline message after missing the deadline date and asset status continues to be the same
!--QA-1086
Meta:@mediamanager
Given I logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser  | Brand       | Sub Brand      | Product      | Campaign      | Clock Number  | Duration | First Air Date | Format         | Title        | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | CDMSAR2     | CDMSBR2     | CDMSSB2        |  CDMSPR2     | CDMSCM        | CCDMSCN1  | 1        | 10/14/2022     | HD 1080i 25fps     | CCDMST3      | FTP         | autotest@adstream.com  | automated test  | should not       | Yesterday     | 1             | Already Supplied  |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'CCDMSCN1'
And waited while order with clock number 'CCDMSCN1' is available in media manager
When I upload file '/files/GbrSd_PASS.mov' to order with 'CCDMSCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'CCDMSCN1' in upload page
And go to Media Checker page
And wait until the request with clocknumber 'CCDMSCN1' appears in Media Checker
And search the media file by 'clock no.' with 'CCDMSCN1' in Media Checker page
And wait for '4' seconds
Then 'should' see error message:
|Deadline Message                     |
| Asset missed SLA deadline          |
And wait for '4' seconds
And I should see following details for asset in media checker:
|Status|
|Confirmed|


Scenario: Check that you dont see Subtitle in the Additional Services tab in Media Checker for Subtitles None
!--QA-1292
Meta:@mediamanager
Given I am on babylon Login page
When login with details of 'AgencyAdmin'
And create 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser  | Brand       | Sub Brand      | Product      | Campaign      | Clock Number  | Duration | First Air Date | Format         | Title        | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | CSSUBTAR2   | CSSUBTBR2   | CSSUBTSB2      | CSSUBTPR2    | CSSUBTC2      | CSSUBTCN3     | 1        | 10/14/2022     | HD 1080i 25fps | CSSUBTST1    | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 1             | None         |
When I click element 'MediaManager' on page 'Projects'
And search the media file by 'CSSUBTCN3'
And waited while order with clock number 'CSSUBTCN3' is available in media manager
When I upload file '/files/GbrSd_PASS.mov' to order with 'CSSUBTCN3' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'CSSUBTCN3' in upload page
And I go to babylon Login page
And login with details of 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'CSSUBTCN3' in Media Checker page
Then I 'should' see order details in media checker for ClockNumber 'CSSUBTCN3':
| FieldName      | Value             |
| Agency	     | DefaultAgency     |
| Clock Number   | CSSUBTCN3         |
| Status     	 | New               |
| Additional Services      |     |
When open on tile with clock number 'CSSUBTCN3' in Media Checker page
Then I 'should not' see following data in Media File Info page of media checker:
| FieldName      | Value             |
|Subtitles       | None              |
And 'should not' see 'Send for subTitling' the request tile in media checker

Scenario: Check that you can see Subtitle in the Additional Services tab in Media Checker and clicking Send For subtitling shows its value against Subtitle Provider
!--QA-1292
Meta:@mediamanager
Given I am on babylon Login page
When login with details of 'AgencyAdmin'
And create 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser  | Brand       | Sub Brand      | Product      | Campaign      | Clock Number  | Duration | First Air Date | Format         | Title        | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | CSSUBTAR2   | CSSUBTBR2   | CSSUBTSB2      | CSSUBTPR2    | CSSUBTC2      | CSSUBTCN1     | 1        | 10/14/2022     | HD 1080i 25fps | CSSUBTST1    | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 1             | Adtext HD         |
And I click element 'MediaManager' on page 'Projects'
And search the media file by 'CSSUBTCN1'
And waited while order with clock number 'CSSUBTCN1' is available in media manager
And I upload file '/files/GbrSd_PASS.mov' to order with 'CSSUBTCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'CSSUBTCN1' in upload page
And I go to babylon Login page
And login with details of 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'CSSUBTCN1' in Media Checker page
Then I 'should' see order details in media checker for ClockNumber 'CSSUBTCN1':
| FieldName      | Value             |
| Agency	     | DefaultAgency     |
| Clock Number   | CSSUBTCN1         |
| Status     	 | New               |
| Additional Services      |  Adtext HD   |
When open on tile with clock number 'CSSUBTCN1' in Media Checker page
Then I 'should' see following data in Media File Info page of media checker:
| FieldName      | Value             |
|Subtitles       | Awaiting subtitles |
When 'Send for subTitling' the request tile via media checker Master Info Page
Then I 'should' see following data in Media File Info page of media checker:
| FieldName              | Value             |
|Subtitle Provider       | Adtext HD         |


Scenario: Check that Send for Subtitling is not available for Already Supplied subtitle
!--QA-1292
Meta:@mediamanager
Given I am on babylon Login page
When login with details of 'AgencyAdmin'
And create 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser  | Brand       | Sub Brand      | Product      | Campaign      | Clock Number  | Duration | First Air Date | Format         | Title        | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | CSSUBTAR2   | CSSUBTBR2   | CSSUBTSB2      | CSSUBTPR2    | CSSUBTC2      | CSSUBTCN2     | 1        | 10/14/2022     | HD 1080i 25fps | CSSUBTST1    | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 1             | Already Supplied         |
And I click element 'MediaManager' on page 'Projects'
And search the media file by 'CSSUBTCN2'
And waited while order with clock number 'CSSUBTCN2' is available in media manager
And I upload file '/files/GbrSd_PASS.mov' to order with 'CSSUBTCN2' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'CSSUBTCN2' in upload page
And I go to babylon Login page
And login with details of 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'CSSUBTCN2' in Media Checker page
Then I 'should' see order details in media checker for ClockNumber 'CSSUBTCN2':
| FieldName      | Value             |
| Agency	     | DefaultAgency     |
| Clock Number   | CSSUBTCN2         |
| Status     	 | New               |
| Additional Services      |  Subtitles provided   |
When open on tile with clock number 'CSSUBTCN2' in Media Checker page
Then I 'should' see following data in Media File Info page of media checker:
| FieldName      | Value             |
|Subtitles       | Subtitles provided |
Then 'should not' see 'Send for subTitling' the request tile in media checker