Feature:          Agency Admin - MediaChecker
Narrative:
In order to
As a              AgencyAdmin
I want to         check all the media checker status flows

Scenario: Check the confirmed status in media checker for asset attached to request
!--QA-1064 --Bug MM-443
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               | Message         | Already Supplied| Deadline Date  | DestinationID | Motivnummer|
| automated test info    | MCSCAR1    | MCSCBR1 | MCSCSB1   | MCSCPR1 | MCSCC1   | MCSCCN1      | 1        | 10/14/2022     | HD 1080i 25fps | MCSCT1   | FTP         | autotest@adstream.com  | automated test  | should not      | 12/14/2022     | 6685          | 123        |
When I go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN1' in Media Checker page
And wait until the request with clocknumber 'MCSCCN1' appears in Media Checker
Then I should see following details for asset in media checker:
| Status|
| New   |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'MCSCCN1'
And I upload file '/files/ger_hd_pass.mov' to order with 'MCSCCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'MCSCCN1' in upload page
And I go to babylon Login page
And I login as 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN1' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Confirmed|

Scenario:  Check completed status in media checker for file awaiting for matching order
Meta:@mediamanager
!--QA-1064
Given I am on Media Manager Login page
And I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/ger_hd_pass.mov|
And fill meta data in media manager file info page:
| Market       | advertiser    | product | agency            | clockNumber   | Duration                     |
| Germany      | MCSCAR0       | MCSCPR0 | DefaultAgency     | MCSCCN0       | 0 hours,0 minutes,1 second   |
And search the media file by 'MCSCCN0'
And wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
| QC Message|
| QC Passed |
When I go to babylon Login page
And I login as 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN0' in Media Checker page
Then I should see following details for asset in media checker:
| Status   |
| Upload Completed|


Scenario:  Check submitted status in media checker for file awaiting for matching order
Meta:@mediamanager
!--QA-1064
Given I am on Media Manager Login page
And I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
| MediaFilePath         |
| /files/ger_hd_pass.mov|
And fill meta data in media manager file info page:
| Market       | advertiser    | product  | agency            | clockNumber   | Duration                     |
| Germany      | MCSCAR2       | MCSCPR2  | DefaultAgency     | MCSCCN2       | 0 hours,0 minutes,1 second   |
And search the media file by 'MCSCCN2'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber 'MCSCCN2' in upload page
And wait for '10' seconds
Then I should see the following data for media file in upload page:
| QC Message          |
| File awaiting match |
When I go to babylon Login page
And I login as 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN2' in Media Checker page
Then I should see following details for asset in media checker:
| Status   |
| Submitted|


Scenario:  Check Adpro status in media checker and media uploader for a completed asset
Meta:@mediamanager
     @qamediamanagersmoke
!--QA-1064
Given I am on Media Manager Login page
And I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
| MediaFilePath         |
| /files/ger_hd_pass.mov|
And fill meta data in media manager file info page:
| Market       | advertiser | product      | agency            | clockNumber  | Duration                     |
| Germany      | MCSCAR3    | MCSCPR3      | DefaultAgency     | MCSCCN3      | 0 hours,0 minutes,1 second   |
And search the media file by 'MCSCCN3'
And wait until QC process spinner disappers in 'Uploads' page
And I go to babylon Login page
And I login as 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN3' in Media Checker page
When open on tile with clock number 'MCSCCN3' in Media Checker page
And 'Send to AdPro' the request tile via media checker Master Info Page
And open on tile with clock number 'MCSCCN3' in Media Checker page
Then I 'should not' see the 'Send to AdPro' button
When I go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN3' in Media Checker page
Then I should see following details for asset in media checker:
| Status|
| AdPro |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And search the media file by 'MCSCCN3'
Then I should see the following data for media file in upload page:
| QC Message |
| With Adpro |


Scenario: Check the Adpro status in media checker for confirmed request
!--QA-1064 -- MM-443 bug, QA-978
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Motivnummer|
| automated test info    | MCSCAR4    | MCSCBR4 | MCSCSB4   | MCSCPR4 | MCSCC4  | MCSCCN4      | 1        | 10/14/2022     | HD 1080i 25fps | MCSCT4   | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 6685          | 123        |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'MCSCCN4'
And waited while order with clock number 'MCSCCN4' is available in media manager
And I upload file '/files/ger_hd_pass.mov' to order with 'MCSCCN4' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'MCSCCN4' in upload page
And I go to babylon Login page
And I login as 'AgencyAdmin'
And go to Media Checker page
When open on tile with clock number 'MCSCCN4' in Media Checker page
And 'Send to AdPro' the request tile via media checker Master Info Page
And open on tile with clock number 'MCSCCN4' in Media Checker page
Then I 'should not' see the 'Send to AdPro' button
When I go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN4' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|AdPro|
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And search the media file by 'MCSCCN4'
Then I should see the following data for media file in upload page:
|QC Message |
|With Adpro |


Scenario:  Check status in media checker for matched assets
Meta:@mediamanager
     @qamediamanagersmoke
!--QA-1064
!--MM -783
Given I am on Media Manager Login page
And I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
| MediaFilePath  |
| <MediaFilePath>|
And fill meta data in media manager file info page:
| Market    | advertiser    | product     | clockNumber   | title     | agency     | Duration  |
| <Market>  | <advertiser>  | <product>   | <clockNumber> | <title>   | <agency>   | <Duration>|
And upload media file in to media uploader via UI:
| MediaFilePath  |
| <MediaFilePath>|
And fill meta data in media manager file info page:
| Market    | advertiser    | product     | clockNumber   | title     | agency     | Duration|
| <Market>  | <advertiser>  | <product>   | <clockNumber> | <title>   |<agency>    | <Duration>|
And search the media file by '<clockNumber>'
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber '<clockNumber>' in upload page
And I logout from media manager
When I go to babylon Login page
And login with details of 'AgencyAdmin'
And create 'tv' streamline order with market '<Market>' and items with following fields :
| Additional Information | Advertiser     | Brand  | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | DestinationID  | Motivnummer| Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | <advertiser>   | MCBR   |MCSB       | <product> | MCC      | <clockNumber>| 1        | 10/14/2022     | HD 1080i 25fps | <title> | Already Supplied   | <DestinationID>| 124        | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
And click element 'MediaManager' on page 'Projects'
And waited while order with clock number '<clockNumber>' is available in media manager
Then I should see the following data for media file in upload page:
|QC Message|
|Multiple ID matches with assets|
When I go to Media Checker page
And search the media file by 'clock no.' with '<clockNumber>' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Possible asset match|
|Possible asset match|
|Possible asset match|
When open on tile with clock number '<clockNumber>' in Media Checker page
And I click 'View matching assets' in media manger file info page
And I select asset '1'  in the Select an asset popup
And I attach asset
And I go to Media Checker page
And search the media file by 'clock no.' with '<clockNumber>' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Confirmed|
|Submitted|

Examples:
|MediaFilePath         | Market     | advertiser | product  | clockNumber |title    |agency        | Duration                     | DestinationID|
|/files/ger_hd_pass.mov| Germany    | MCSCAR5    | MCSCP5   | MCSCCN5     | MCSCT5  |DefaultAgency | 0 hours,0 minutes,1 second   | 6685         |


Scenario: Check committed status in MC for a confirmed asset attached to request
!--QA-1064
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Motivnummer|
| automated test info    | MCSCAR6    | MCSCBR6 | MCSCSB6   | MCSCPR6 | MCSCC6   | MCSCCN6      | 1        | 10/14/2022     | HD 1080i 25fps | MCSCT6   | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 6685          | 123        |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'MCSCCN6'
And waited while order with clock number 'MCSCCN6' is available in media manager
When I upload file '/files/ger_hd_pass.mov' to order with 'MCSCCN6' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'MCSCCN6' in upload page
And I go to babylon Login page
And login with details of 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN6' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Confirmed|
When open on tile with clock number 'MCSCCN6' in Media Checker page
And click tab 'MezzInfo'
And 'Commit' the request tile via media checker Mezz Info Page
And go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN6' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Committed|


Scenario: Check deleted asset in MC status in MC for a confirmed asset attached to request
!--QA-1064 --Bug MM-443
!--QA-1307
Meta:@mediamanager
     @qamediamanagersmoke
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               | Message         | Already Supplied | Deadline Date | DestinationID| Subtitles Required  |
| automated test info    | MCSCAR7    | MCSCBR7 | MCSCSB7   |MCSCPR7  |MCSCC7    | MCSCCN7      |1         | 10/14/2022     | HD 1080i 25fps | MCSCT7   | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 1            | Adtext HD           |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'MCSCCN7'
And waited while order with clock number 'MCSCCN7' is available in media manager
When I upload file '/files/GbrSd_PASS.mov' to order with 'MCSCCN7' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
When I submit files with clocknumber 'MCSCCN7' in upload page
And I go to babylon Login page
And login with details of 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'MCSCCN7' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Confirmed|
When open on tile with clock number 'MCSCCN7' in Media Checker page
And wait for '2' seconds
Then I 'should' see the 'Send to AdPro' button
And I 'should' see the 'Download original' button
And I 'should' see the 'Delete' button
And I 'should' see the 'Send request back to uploader' button
And I 'should' see the 'Send for subtitling' button
When 'Delete' the request tile via media checker Master Info Page
And wait for '2' seconds
And refresh the page without delay
And search the media file by 'clock no.' with 'MCSCCN7' in Media Checker page
And wait for '2' seconds
Then I should see following details for asset in media checker:
|Status|
|New|

