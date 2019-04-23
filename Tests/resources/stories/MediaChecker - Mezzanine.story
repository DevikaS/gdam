Meta:

Narrative:
As a AgencyAdmin
I want to perform an action
So that I can achieve a business goal

Scenario:  Check that you can see Mezz Info in Media Checker and Edit the Info
Meta:@mediamanager
@qamediamanagersmoke
!--QA-1307
Given I am on babylon Login page
And logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser| Brand    | Sub Brand| Product  | Campaign|Clock Number| Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |Motivnummer       |
| automated test info    | MMZAR1    | MMZBR1   | MMZSB1   | MMZMP1   | MMZMC1  |MMZCN1      | 1        | 10/14/2022     | HD 1080i 25fps | MMZT1   | Already Supplied     | 6683             | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    | 1234             |
When I click element 'MediaManager' on page 'Projects'
And search the media file by 'MMZCN1'
And waited while order with clock number 'MMZCN1' is available in media manager
And I upload file '/files/DeuSd_PASS.mov' to order with 'MMZCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber 'MMZCN1' in upload page
And I go to Media Checker page
And wait until the request with clocknumber 'MMZCN1' appears in Media Checker
And search the media file by 'clock no.' with 'MMZCN1' in Media Checker page
And open on tile with clock number 'MMZCN1' in Media Checker page
And wait for '2' seconds
And click tab 'MezzReport'
And wait until QC process spinner disappers in 'MezzReport' page
And click tab 'MezzInfo'
And click edit button in media checker Mezz info page
And update meta data in media checker file edit page:
| TC in      |TC out      |
| 00:00:00:10|00:00:00:24 |
Then should see below 'MezzInfo' details in media checker page:
| FieldName      | Value       |
| Market	     | Germany     |
| Agency	     | DefaultAgency     |
| Clock Number   | MMZCN1    |
| Advertiser	 | MMZAR1      |
| Product	     | MMZMP1      |
| Title	         | MMZT1     |
| Duration	     | 00:00:01:00 |
| TC Out	     | 00:00:00:24 |
| TC In	         | 00:00:00:10 |
| Uploader	     | AgencyAdmin |


Scenario:  Check that you can see Mezz Report in Media Checker for Germany Market
Meta:@mediamanager
!--QA-1307
Given I am on babylon Login page
And logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser| Brand    | Sub Brand | Product  | Campaign |Clock Number| Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date | Motivnummer  |
| automated test info    | MMZRAR1   | MMZRBR1  | MMZRSB1   | MMZRMP1  | MMZRMC1  |MMZRCN1     | 1        | 10/14/2022     | HD 1080i 25fps | MMZRT1   | Already Supplied     | 6683             | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    | 1234        |
When I click element 'MediaManager' on page 'Projects'
And search the media file by 'MMZRCN1'
And waited while order with clock number 'MMZRCN1' is available in media manager
And I upload file '/files/DeuSd_PASS.mov' to order with 'MMZRCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber 'MMZRCN1' in upload page
And I go to Media Checker page
And wait until the request with clocknumber 'MMZRCN1' appears in Media Checker
And search the media file by 'clock no.' with 'MMZRCN1' in Media Checker page
And open on tile with clock number 'MMZRCN1' in Media Checker page
And wait for '2' seconds
And click tab 'MezzReport'
And wait until QC process spinner disappers in 'MezzReport' page
Then I 'should' see the below 'MezzReport' in Media Checker:
|audioCodec     |fileType        |fileSize   |videoCodec |firstFrameTimeCode|length      |
|	AES3-S302M  |Transport Stream|9.27 MB    |MPEG2      |00:00:00:00       |00:00:01:309|


Scenario:  Check that you can see Mezz Report in Media Checker for United Kingdom Market
Meta:@mediamanager
!--QA-1307
Given I am on babylon Login page
And logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser  | Brand      | Sub Brand   | Product    | Campaign   |Clock Number| Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | MMZRAR1_1   | MMZRBR1_1  | MMZRSB1_1   | MMZRMP1_1  | MMZRMC1_1  |MMZRCN1_1   | 1        | 10/14/2022     | HD 1080i 25fps | MMZRT1   | Already Supplied     | 1               | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
When I click element 'MediaManager' on page 'Projects'
And search the media file by 'MMZRCN1_1'
And waited while order with clock number 'MMZRCN1_1' is available in media manager
And I upload file '/files/GbrSd_PASS.mov' to order with 'MMZRCN1_1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber 'MMZRCN1_1' in upload page
And I go to Media Checker page
And wait until the request with clocknumber 'MMZRCN1_1' appears in Media Checker
And search the media file by 'clock no.' with 'MMZRCN1_1' in Media Checker page
And open on tile with clock number 'MMZRCN1_1' in Media Checker page
And wait for '2' seconds
And click tab 'MezzReport'
And wait until QC process spinner disappers in 'MezzReport' page
Then I 'should' see the below 'MezzReport' in Media Checker:
|audioCodec  |fileType          |fileSize |videoCodec|firstFrameTimeCode  |length       |Status    |Errors |
|AES3-S302M    |QuickTime Stream  |7.45 MB  |ProRes    |00:00:00:00         |00:00:01:000 | passed   |0      |


Scenario: Check Error Message in Mezz Report Page when QC fails
Meta:@mediamanager
!--QA-1307
Given I am on babylon Login page
And logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser| Brand    | Sub Brand| Product  | Campaign|Clock Number| Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | MMVCBAR   | MMVCBBR  | MMVCBSB  | MMVCBP   | MMVCBC1 |MMVCBCN1     | 1        | 10/14/2022     | HD 1080i 25fps | MMVCBT1   | Already Supplied     | 157             | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
When I click element 'MediaManager' on page 'Projects'
And search the media file by 'MMVCBCN1'
And waited while order with clock number 'MMVCBCN1' is available in media manager
And I upload file '/files/MezzFail.mov' to order with 'MMVCBCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
When I click view details
And I click 'Fix and submit' in file report page
And I go to Media Checker page
And wait until the request with clocknumber 'MMVCBCN1' appears in Media Checker
And search the media file by 'clock no.' with 'MMVCBCN1' in Media Checker page
And open on tile with clock number 'MMVCBCN1' in Media Checker page
And wait for '4' seconds
When click tab 'MezzReport'
And wait until qc error message appears in 'MezzReport' page
Then 'should' see error message in Mezz Report page:
| QC Error Message|
| This file has critical errors and cannot be repaired with Autofix or AdPro|


