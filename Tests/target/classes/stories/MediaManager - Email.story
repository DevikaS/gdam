Meta:

Narrative:
As a AgencyAdmin
I want to perform an action
So that I can achieve a business goal

Scenario: Check that you receive email when Send to AdPro is clicked from MediaChecker page
!--QA-1290
Meta:@mediamanager
Given I am on babylon Login page
And logged in with details of 'GlobalAdmin'
And edited mail template with following details:
| Application       |  Business Unit          | Activity           | Preferred Language   | Default Notification Type  |  Button Name  |
| Adbank            |  DefaultAgency          | adProNotification  | English (Australia)   | Immediately                | Save         |
And I logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser  | Brand       | Sub Brand      | Product      | Campaign      | Clock Number  | Duration | First Air Date | Format           | Title        | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | CRESTAAR2   | CRESTABR2   | CRESTASB2      |  CRESTAPR2   | CRESTACM      | CRESTACN1      | 1        | 10/14/2022    | HD 1080i 25fps   | CRESTAT3     | FTP         | autotest@adstream.com  | automated test  | should not       | Yesterday     | 1             | Already Supplied  |
When click element 'MediaManager' on page 'Projects'
And I search the media file by 'CRESTACN1'
And waited while order with clock number 'CRESTACN1' is available in media manager
When I upload file '/files/GbrSd_PASS.mov' to order with 'CRESTACN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'CRESTACN1' in upload page
And go to Media Checker page
And wait until the request with clocknumber 'CRESTACN1' appears in Media Checker
And search the media file by 'clock no.' with 'CRESTACN1' in Media Checker page
And wait for '4' seconds
When open on tile with clock number 'CRESTACN1' in Media Checker page
And wait for '2' seconds
When 'Send to AdPro' the request tile via media checker Master Info Page
Then 'should' see email notification for 'is now with Adpro' with field to 'adpro@adstream.com' and subject 'clockNumber is now with Adpro' contains following attributes:
| Clock Number | Market      |
| CRESTACN1 | United Kingdom |


Scenario: Check that you receive email when asset is matched with the order
!--QA-1290
Meta:@mediamanager
Given I am on babylon Login page
And logged in with details of 'GlobalAdmin'
And edited mail template with following details:
| Application       |  Business Unit          | Activity           | Preferred Language   | Default Notification Type  |  Button Name  |
| Adbank            |  DefaultAgency          | fileMatched        | English (Australia)   | Immediately                | Save         |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
| Market                 |advertiser|product    |title     |agency          | Duration|
| United Arab Emirates   |CFMAEGAR2  |CFMAEGPR2    |CFMAEGAT3   |DefaultAgency   |  0 hours,0 minutes,1 second|
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
|Market                 |advertiser|product    |title      |agency         | Duration|
|United Arab Emirates   |CFMAEGAR3  |CFMAEGPR3    |CFMAEGAT3   |DefaultAgency   |  0 hours,0 minutes,1 second|
And search the media file by 'CFMAEGAT3'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber '' in upload page
And I logout from media manager
And I go to babylon Login page
And login with details of 'AgencyAdmin'
And create 'tv' streamline order with market 'United Arab Emirates' and items with following fields :
| Additional Information | Advertiser  | Brand       | Sub Brand      | Product      | Campaign      | Clock Number  | Duration | First Air Date | Format           | Title        | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | CFMAEGAR2   | CFMAEGBR2   | CFMAEGSB2      |  CFMAEGPR2   | CFMAEGCM      | CFMAEGCN1      | 1        | 10/14/2022    | HD 1080i 25fps   | CFMAEGAT3     | FTP         | autotest@adstream.com  | automated test  | should not       | Yesterday     | 7724          | Already Supplied  |
When click element 'MediaManager' on page 'Projects'
And waited while order with clock number 'CFMAEGCN1' is available in media manager
Then 'should' see email notification for 'has been matched with a file' with field to 'AgencyAdmin' and subject 'has been matched with a file' contains following attributes:
|  FileName      |
| MenHd_PASS.mov |