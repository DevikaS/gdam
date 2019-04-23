Feature:          Check Duration mismatch error messages
Narrative:
In order to
As a
I want to         Check Duration mismatch error messages for Different Markets
!-- As a  User is removed above because all the login is from media manager


Scenario:  Check for Duration mismatch errors of uploaded asset for German market
Meta:@mediamanager
@qamediamanagersmoke
!--QA-1116
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/DeuSd_PASS.mov|
And fill meta data in media manager file info page:
|Market  |advertiser |product |clockNumber |title |agency          | Duration                   |
|Germany |DM_Adver1  |DM_P1   |DM_CN1      |DM_T1 |DefaultAgency   | 0 hours,0 minutes,1 second |
And search the media file by 'DM_CN1'
When I click view details
Then I 'should not' see the duration error message in info page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the stated ad duration. This file cannot be submitted. Please review and re-upload.'
When click file info button
And I fill meta data in media manager file info page:
| Duration                     |
| 0 hours,0 minutes,5 seconds  |
Then I 'should' see the duration error message in info page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the stated ad duration. This file cannot be submitted. Please review and re-upload.'
When I wait until QC process spinner disappers in 'Info' page
And I click QC Report button in media manager file info page
Then I should see the duration error message in report page as 'Your file duration isn't sufficient to contain an appropriate headbuild with your stated ad duration. Expected additional length to accommodate headbuild is 0 seconds. This file cannot be submitted. Please review and re-upload.'
When I close the view details page
And search the media file by 'DM_CN1'
Then I should see the following data for media file in upload page:
|QC Message|
|Duration mismatch. Click "View details"|
And I 'should not' see button 'Submit now' present on Uploads page for file 'DeuSd_PASS.mov'


Scenario:  Check for Duration mismatch errors of uploaded asset for UK market
Meta:@mediamanager
!--QA-1116
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/GbrSd_PASS.mov|
And fill meta data in media manager file info page:
|Market         |advertiser |product |clockNumber |title |agency          | Duration                     |
|United Kingdom |DM_Adver2  |DM_P2   |DM_CN2      |DM_T2 |DefaultAgency   | 0 hours,0 minutes,1 second   |
And search the media file by 'DM_CN2'
When I click view details
Then I 'should not' see the duration error message in info page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the stated ad duration. This file cannot be submitted. Please review and re-upload.'
When click file info button
And I fill meta data in media manager file info page:
| Duration                     |
| 0 hours,0 minutes,5 seconds |
And refresh the page without delay
Then I 'should' see the duration error message in info page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the stated ad duration. This file cannot be submitted. Please review and re-upload.'
When I click QC Report button in media manager file info page
And refresh the page without delay
Then I should see the duration error message in report page as 'Your file duration isn't sufficient to contain an appropriate headbuild with your stated ad duration. Expected additional length to accommodate headbuild is 20 seconds. This file cannot be submitted. Please review and re-upload.'
And 'should' see 'reupload' button
When I close the view details page
And search the media file by 'DM_CN2'
Then I 'should not' see button 'Submit now' present on Uploads page for file 'GbrSd_PASS.mov'

Scenario:  Check for Duration mismatch errors of uploaded asset for MENA market
Meta:@mediamanager
!--QA-1116
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
|Market  |advertiser |product |clockNumber |title |agency          | Duration                   |
|Algeria |DM_Adver3  |DM_P3   |DM_CN3      |DM_T3 |DefaultAgency   | 0 hours,0 minutes,1 second |
When I search the media file by 'DM_CN3'
And I click view details
And click file info button
Then I 'should not' see the duration error message in info page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the stated ad duration. Your material may be rejected at the Broadcaster.'
When I fill meta data in media manager file info page:
| Duration                     |
| 0 hours,0 minutes,3 seconds  |
Then I 'should' see the duration error message in info page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the stated ad duration. Your material may be rejected at the Broadcaster.'
When I wait until QC process spinner disappers in 'Info' page
And I click QC Report button in media manager file info page
Then I should see the duration error message in report page as 'Your file duration isn't sufficient to contain an appropriate headbuild with your stated ad duration. Expected additional length to accommodate headbuild is 0 seconds. Your material may be rejected at the Broadcaster.'
When I close the view details page
And search the media file by 'DM_CN3'
Then I should see the following data for media file in upload page:
|QC Message|
|Duration mismatch. Click "View details"|
And I 'should' see button 'Submit now' present on Uploads page for file 'MenHd_PASS.mov'
And submit files with clocknumber 'DM_CN3' in upload page


Scenario: Check Duration mismatch errors for German market request with attached asset
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Supply Via  | Assignee               |  Message        |  Already Supplied|Deadline Date |DestinationID|Motivnummer|
| automated test info    | DMAR1      | DMBR1 | DMSB1     | DMPR1   | DMC1     | DMCN1        | 10       | 10/14/2022     | HD 1080i 25fps | DMFT1 | FTP         | autotest@adstream.com  | automated test  | should not       |12/14/2022    |6685         | 123       |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'DMCN1'
And waited while order with clock number 'DMCN1' is available in media manager
When I upload file '/files/ger_hd_pass.mov' to order with 'DMCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
|QC Message|
|Duration mismatch. Click "View details"|
And I 'should not' see button 'Submit now' for request with clock 'DMCN1' in Uploads page
When I click view details
Then I should see the duration error message in report page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the order ad duration. Expected additional length to accommodate headbuild is 0 seconds. This file cannot be submitted. Please review and re-upload.'


Scenario: Check Duration mismatch errors for MENA market request with attached asset
Meta:@mediamanager
@qamediamanagersmoke
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Algeria' and items with following fields :
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  |Supply Via  | Assignee               |  Message        | Deadline Date |DestinationID  |
| automated test info    | DMAR3      | DMBR3  | DMSB3     | DMPR3   | DMC3     | DMCN3        | 10       | 12/14/2022     | HD 1080i 25fps | DMFT3  | FTP        | autotest@adstream.com  | automated test  | 12/14/2022    |30508          |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'DMCN3'
And waited while order with clock number 'DMCN3' is available in media manager
When I upload file '/files/MenHd_PASS.mov' to order with 'DMCN3' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
|QC Message|
|Duration mismatch. Click "View details"|
And I 'should' see button 'Submit now' for request with clock 'DMCN3' in Uploads page
When I click view details
Then I should see the duration error message in report page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the order ad duration. Expected additional length to accommodate headbuild is 0 seconds. Your material may be rejected at the Broadcaster.'


Scenario: Check Duration mismatch errors for UK market request with attached asset
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser   | Brand   | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title    |  Subtitles Required|Supply Via  | Assignee               |  Message        | Deadline Date |DestinationID  |ServiceLevel|
| automated test info    | DMAR2        | DMBR2   | DMSB2      | DMPR2      | DMC2      | DMCN2        | 20       | 10/14/2022     | HD 1080i 25fps | DMFT2    | Already Supplied   | FTP        | autotest@adstream.com  | automated test  | 12/14/2022    |1              |2           |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'DMCN2'
And waited while order with clock number 'DMCN2' is available in media manager
When I upload file '/files/GbrSd_PASS.mov' to order with 'DMCN2' in to media 'Uploader' page via UI
When I wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
|QC Message|
|QC Failed. Click "View details"|
Then I 'should not' see button 'Submit now' for request with clock 'DMCN2' in Uploads page
When I click view details
Then I should see the duration error message in report page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the order ad duration. Expected additional length to accommodate headbuild is 20 seconds. This file cannot be submitted. Please review and re-upload.'


Scenario:  Check for banner messages for duration changes for German market asset
Meta:@mediamanager
!--QA-1116
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/DeuSd_PASS.mov|
And fill meta data in media manager file info page:
|Market  |advertiser |product |clockNumber |title |agency          | Duration                   |
|Germany |DM_Adver4  |DM_P4   |DM_CN4      |DM_T4 |DefaultAgency   | 0 hours,0 minutes,1 second |
And search the media file by 'DM_CN4'
When I click view details
Then I 'should not' see the duration error message in info page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the stated ad duration. This file cannot be submitted. Please review and re-upload.'
When click file info button
And I fill meta data in media manager file info page:
| Duration                     |
| 0 hours,0 minutes,5 seconds |
Then I 'should' see the duration error message in info page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the stated ad duration. This file cannot be submitted. Please review and re-upload.'
When I click QC Report button in media manager file info page
Then I should see the duration error message in report page as 'Your file duration isn't sufficient to contain an appropriate headbuild with your stated ad duration. Expected additional length to accommodate headbuild is 0 seconds. This file cannot be submitted. Please review and re-upload.'
When I close the view details page
And search the media file by 'DM_CN4'
Then I should see the following data for media file in upload page:
|QC Message|
|Duration mismatch. Click "View details"|
And I 'should not' see button 'Submit now' present on Uploads page for file 'DeuSd_PASS.mov'
When I click view details
And click file info button
When I fill meta data in media manager file info page:
| Duration                   |
| 0 hours,0 minutes,1 second |
Then I 'should not' see the duration error message in info page as 'Your file duration isn't sufficient to contain an appropriate headbuild with the stated ad duration. This file cannot be submitted. Please review and re-upload.'
When I close the view details page
And search the media file by 'DM_CN4'
Then I should see the following data for media file in upload page:
|QC Message|
|QC Passed |
And I 'should' see button 'Submit now' present on Uploads page for file 'DeuSd_PASS.mov'
