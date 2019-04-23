Meta:
Narrative:
As a AgencyAdmin
I want to check the re-upload functionality in MediaManager
So that I can achieve a business goal


Scenario: Check the re-upload button is not visible for request which doesn't have asset attached
!--QA-1181
Meta:@mediamanager
@qamediamanagersmoke
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Motivnummer|
| automated test info    | ARTR6    | ARTRBR6 | ARTRSB6   | ARTRPR6 | ARTRCC6   | ARTRCN6      | 1        | 10/14/2022     | HD 1080i 25fps | MCSCT6   | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 6685          | 123        |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'ARTRCN6'
And waited while order with clock number 'ARTRCN6' is available in media manager
And I click view details
And wait for '2' seconds
And I click QC Report button in media manager file info page
And wait for '2' seconds
Then 'should not' see 'reupload' button

Scenario: Check asset attached to a request when reuploaded retains the metadata
!--QA-1181
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'United Arab Emirates' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               |  Message        |  Already Supplied|Deadline Date |DestinationID|
| automated test info    | ARTR8      | ARTR8   | ARTRSB8   | ARTRPR8 | ARTRC8    | ARTRCN8       | 1        | 10/14/2022     | HD 1080i 25fps | MCMT6    | FTP         | autotest@adstream.com  | automated test  | should not       |12/14/2022    |344         |
When click element 'MediaManager' on page 'Projects'
And I search the media file by 'ARTRCN8'
And waited while order with clock number 'ARTRCN8' is available in media manager
And I upload file '/files/MenHd_PASS.mov' to order with 'ARTRCN8' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
When I click view details
And wait for '2' seconds
And I click QC Report button in media manager file info page
And wait for '2' seconds
And reupload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And wait for '5' seconds
And wait until QC process spinner disappers in 'info' page
Then I 'should' see the details in media manager file info page:
| Market  | Agency           | Advertiser | Product    | Clock Number |
| United Arab Emirates | DefaultAgency    | ARTR8     | ARTRPR8     | ARTRCN8       |


Scenario: Check that you cannot reupload the asset that is submitted
!--QA-1181
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
When click element 'MediaManager' on page 'Projects'
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/GbrSd_PASS.mov|
And fill meta data in media manager file info page:
|Market  |advertiser |product |clockNumber |title |agency          | Duration                   |
|Germany |DM_Adver2  |DM_P2   |DM_CN2      |DM_T2 |DefaultAgency   | 0 hours,0 minutes,1 second |
And search the media file by 'DM_CN2'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber 'DM_CN2' in upload page
When I click view details
And wait for '2' seconds
And I click QC Report button in media manager file info page
And wait for '2' seconds
Then 'should not' see 'reupload' button

Scenario: Check that you are unable to see reupload button for a file that fails uploading
Meta:@mediamanager
!--QA-1181
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
When click element 'MediaManager' on page 'Projects'
And logout while uploading media file in to media uploader via UI:
|MediaFilePath|
|/files/GbrHd_FAIL.mov|
And I go to babylon Login page
And I login as 'AgencyAdmin'
And click element 'MediaManager' on page 'Projects'
And I click view details
And fill meta data in media manager file info page:
|Market  |advertiser |product |clockNumber |title |agency          | Duration                   |
|Germany |DM_Adver2  |DM_P2   |DM_CN2      |DM_T2 |DefaultAgency   | 0 hours,0 minutes,1 second |
And I click QC Report button in media manager file info page
Then 'should' see the file upload error message in report page as 'File upload is in progress'
And 'should not' see 'reupload' button


Scenario:  Check that on reuploading the same asset metadata of the original asset continues to retain
Meta:@mediamanager
!--QA-1181
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/DeuSd_PASS.mov|
And fill meta data in media manager file info page:
|Market  |advertiser |product |clockNumber |title |agency          | Duration                   |
|Germany |DM_Adver1  |DM_P1   |DM_CN1      |DM_T1 |DefaultAgency   | 0 hours,0 minutes,1 second |
And search the media file by 'DM_CN1'
And wait until QC process spinner disappers in 'Uploads' page
When I click view details
And I click QC Report button in media manager file info page
And reupload media file in to media uploader via UI:
|MediaFilePath|
|/files/DeuSd_PASS.mov|
And wait until QC process spinner disappers in 'info' page
Then I should see Media Metadata:
|Market  |advertiser |product |clockNumber |title |agency          | Duration                   |
|Germany |DM_Adver1  |DM_P1   |DM_CN1      |DM_T1 |DefaultAgency   | 0 hours,0 minutes,1 second |


Scenario:  Check that on reuploading a different asset will retain the metadata of the origial asset
Meta:@mediamanager
!--QA-1181
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/GbrHd_PASS.mov|
And fill meta data in media manager file info page:
|Market  |advertiser |product |clockNumber |title |agency          | Duration                   |
|Germany |DM_Adver3  |DM_P3   |DM_CN3      |DM_T3 |DefaultAgency   | 0 hours,0 minutes,1 second |
And search the media file by 'DM_CN3'
And wait until QC process spinner disappers in 'Uploads' page
When I click view details
And I click QC Report button in media manager file info page
And reupload media file in to media uploader via UI:
|MediaFilePath|
|/files/GbrSd_PASS.mov|
And wait until QC process spinner disappers in 'info' page
Then I should see Media Metadata:
|Market  |advertiser |product |clockNumber |title |agency          | Duration                   |
|Germany |DM_Adver3  |DM_P3   |DM_CN3      |DM_T3 |DefaultAgency   | 0 hours,0 minutes,1 second |