Feature:          Agency Admin - MediaChecker
Narrative:
In order to
As a              AgencyAdmin
I want to         execute all the Download Mezzanine file scenarios in Media Checker


Scenario:  Check Download Mezzanine File for confirmed request for MENA market
Meta:@mediamanager
     @mmbug
!--QA-1128 --Bug MM-543
Given I am on babylon Login page
And logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'United Arab Emirates' and items with following fields :
| Additional Information | Advertiser| Brand    | Sub Brand| Product  | Campaign|Clock Number| Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | MCDMAR1   | MCDMBR1  | MCDMSB1  | MCDMP1   | MCDMC1  |MCDMCN1     | 1        | 10/14/2022     | HD 1080i 25fps | MCDMT1   | Already Supplied     | 344             | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
When I click element 'MediaManager' on page 'Projects'
And search the media file by 'MCDMCN1'
And waited while order with clock number 'MCDMCN1' is available in media manager
And I upload file '/files/MenHd_PASS.mov' to order with 'MCDMCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber 'MCDMCN1' in upload page
And I go to Media Checker page
And wait until the request with clocknumber 'MCDMCN1' appears in Media Checker
And search the media file by 'clock no.' with 'MCDMCN1' in Media Checker page
And open on tile with clock number 'MCDMCN1' in Media Checker page
And wait for '2' seconds
And click tab 'MezzReport'
And wait until QC process spinner disappers in 'MezzReport' page
And wait for '2' seconds
And click tab 'MezzInfo'
Then I 'should' see 'Showing mezzanine proxy video.' on top of the asset in Media Checker Mezz Info page
And I 'should' see the 'Mezzanine' option for asset in Media Checker Mezz info page
And I 'should' see the 'Download Mezzanine' option for asset in Media Checker Mezz info page
And I 'should' see the 'Commit' option for asset in Media Checker Mezz info page
When 'Download Mezzanine' type in media checker


Scenario:  Check Download Mezzanine File does not appear for New request status in media checker
Meta:@mediamanager
!--QA-1128
Given I am on babylon Login page
And logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign |Clock Number| Duration | First Air Date | Format         | Title | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |Motivnummer|
| automated test info    | MCDMAR2    | MCDMR2  | MCDMSB2    | MCDMP2   | MCDMC2 |MCDMCN2     | 1        | 10/14/2022     | HD 1080i 25fps |MCDMT2 | 6685            | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |423|
When I click element 'MediaManager' on page 'Projects'
And search the media file by 'MCDMCN2'
And waited while order with clock number 'MCDMCN2' is available in media manager
And I go to Media Checker page
And wait until the request with clocknumber 'MCDMCN2' appears in Media Checker
And search the media file by 'clock no.' with 'MCDMCN2' in Media Checker page
And open on tile with clock number 'MCDMCN2' in Media Checker page
Then I 'should not' see 'MezzInfo' tab enabled
And I 'should not' see 'MezzReport' tab enabled


Scenario:  Check  Mezzanine Info and Report does not appear for Completed and Submitted asset status in media checker
Meta:@mediamanager
!--QA-1064
!--QA-1307
Given I am on babylon Login page
And logged in with details of 'AgencyAdmin'
When I click element 'MediaManager' on page 'Projects'
And I upload media file in to media uploader via UI:
|MediaFilePath|
|/files/ger_hd_pass.mov|
And fill meta data in media manager file info page:
| Market       | advertiser | product  | agency | clockNumber    | Duration                      |
| Germany      | MMIRDAR    | MMIRDP   | MMIRDA | MMIRDCN        | 0 hours,0 minutes,1 second    |
And I go to Media Checker page
And search the media file by 'clock no.' with 'MMIRDCN' in Media Checker page
Then I should see following details for asset in media checker:
| Status   |
| Upload Completed|
When open on tile with clock number 'MMIRDCN' in Media Checker page
Then I 'should not' see 'MezzInfo' tab enabled
And I 'should not' see 'MezzReport' tab enabled
When go to Media Manager Uploads page
And search the media file by 'MMIRDCN'
And wait until QC process spinner disappers in 'Uploads' page
And submit unattached files in upload page
And I go to Media Checker page
And search the media file by 'clock no.' with 'MMIRDCN' in Media Checker page
Then I should see following details for asset in media checker:
| Status    |
| Submitted |
When open on tile with clock number 'MMIRDCN' in Media Checker page
Then I 'should not' see 'MezzInfo' tab enabled
And I 'should not' see 'MezzReport' tab enabled

