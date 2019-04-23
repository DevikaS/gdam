Feature:          User uploads a media file
Narrative:
In order to
As a
I want to         upload the valid medai file via uploader

Scenario: Check external user can upload QC Pass video and submit in uploads page to the order created in A5
!--QA-922
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               |  Message        |  Already Supplied|Deadline Date |DestinationID|Motivnummer|
| automated test info    | UUMFAR1    | UUMFBR1 | UUMFSB1   | UUMFPR1 | UUMFC1   | UUMFCN1      | 1       | 10/14/2022     | HD 1080i 25fps | UUMFT1 | FTP         | autotest@adstream.com   | automated test  | should not       |12/14/2022        |6228          | 123|
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And search the media file by 'UUMFCN1'
And waited while order with clock number 'UUMFCN1' is available in media manager
Then I should see the following data for media file in upload page:
|Clock no.|Title |Market   |Advertiser|Product     |
|UUMFCN1  |UUMFT1|Germany  |UUMFAR1   |UUMFPR1     |
And I 'should' see button 'View details' present on Uploads page for file 'N/A'
And I 'should' see button 'Upload video' present on Uploads page for file 'N/A'
When I upload file '/files/DeuSd_PASS.mov' to order with 'UUMFCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
Then I 'should' see the uploaded video name 'UUMFCN1'
And I should see the following data for media file in upload page:
|QC Message|
|QC Passed |
When I submit files with clocknumber 'UUMFCN1' in upload page
And wait for '3' seconds
Then I 'should not' see the tile 'UUMFCN1' in Uploads page


Scenario: Check external user uploads QC video via Info page for the order created in A5
Meta:@mediamanager
!--QA-922
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market '<Market>' and items with following fields :
| Additional Information | Advertiser   | Brand  | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title    |  Subtitles Required|Supply Via  | Assignee               |  Message        | Deadline Date |DestinationID  |ServiceLevel|Motivnummer|
| automated test info    | <Advertiser> | UUMFBR2 |UUMFSB2    | <Product>  | UUMFC2    | <Clock>      | 1       | 10/14/2022     | HD 1080i 25fps | <Title>  |  Already Supplied  | FTP        | autotest@adstream.com  | automated test  | 12/14/2022    |<DestinationID>| 2          |123|
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And search the media file by '<Clock>'
And waited while order with clock number '<Clock>' is available in media manager
Then I should see the following data for media file in upload page:
| Clock no.| Title  | Market   | Advertiser     | Product     |
| <Clock>  | <Title>| <Market> | <Advertiser>   | <Product>   |
When I click view details
And I upload file '<filePath>' to order with '<Clock>' in to media 'Info' page via UI
And wait until QC process spinner disappers in 'Info' page
And click element 'QC Report Button' on page 'MediaManagerFileInfoPage'
And refresh the page
And wait for '2' seconds
Then I 'should' see the QC status message '<Status>'

Examples:
|Clock    |Title |Market          |DestinationID|Advertiser|Product     | filePath                 |Status    |
|UUMFCN2  |UUMFT2|Germany         |6683         |UUMFAR2   |UUMFPR2     |/files/DeuSd_PASS.mov     | QC Passed|
|UUMFCN3  |UUMFT3|United Kingdom  |1            |UUMFAR3   |UUMFPR3     |/files/GbrSd_FAIL.mov     | This file has critical errors and cannot be repaired with Autofix or AdPro.A new file will need to be uploaded before the request can be sent to broadcast.|


Scenario: Check external user cannot upload video with different order name
Meta:@mediamanager
     @mmbug
!--QA-922
!-- Bug MM-576
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration |  First Air Date | Format         | Title    |  Subtitles Required|Supply Via  | Assignee               |  Message        | Deadline Date |DestinationID|ServiceLevel|
| automated test info    | UUMFAR     | UUMFBR |UUMFSB    | UUMFPR  | UUMFC     | UUMFCN        | 1      | 10/14/2022      | HD 1080i 25fps  | UUMFT    |  Already Supplied   | FTP        | autotest@adstream.com  | automated test  | 12/14/2022    |1           |2|
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And waited while order with clock number 'UUMFCN' is available in media manager
When I upload file '/files/DeuSd_PASS.mov' to order with 'UUMFCN' in uploader page via UI
Then I 'should' see error message 'File "DeuSd_PASS.mov" can't be registered. Can't match against given order request.' in media uploader page


Scenario: Check safe title is off by default in media file info page
!--QA-973
Meta:@mediamanager
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath        |
|/files/GbrSd_PASS.mov|
And wait until QC process spinner disappers in 'Info' page
Then I should see the safe tile is 'off'


Scenario: Check Media Player Safe Title for Germany market in media file info page
!--QA-973, QA-1129
Meta:@mediamanager
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And uploaded media file in to media uploader via UI:
|MediaFilePath|
|/files/sd_pass.mov|
When fill meta data in media manager file info page:
| Market       | advertiser    | product      | agency            | clockNumber   | Duration                     |
| Germany      | UUMFAR5       | UUMFP5       | DefaultAgency     | UUMFCN5       | 0 hours,0 minutes,1 second   |
And I click view details
And wait until QC process spinner disappers in 'Info' page
And I click Safe Tile check box
Then the safe frames should be 'visible'
And I should see safe title dotted outline from the border of the video as:
|Dotted line |Outlines                                     |
|First       |top: 5%; bottom: 5%; left: 5%; right: 5%;    |
|Second      |top: 10%; bottom: 10%; left: 15%; right: 15%;|


Scenario: Check Media Player Safe Title for different markets in media file info page
!--QA-1129
Meta:@mediamanager
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And uploaded media file in to media uploader via UI:
|MediaFilePath|
|<MediaFilePath>|
When fill meta data in media manager file info page:
| Market       | advertiser    | product      | agency            | clockNumber   |title  | Duration                     |
| <Market>      | UUMFAR6       | UUMFP6      | DefaultAgency     | UUMFCN6       | UUMFT6|0 hours,0 minutes,1 second   |
And I click view details
And wait until QC process spinner disappers in 'Info' page
When I click Safe Tile check box
Then the safe frames should be 'visible'
And I should see safe title dotted outline from the border of the video as:
|Outlines      |
|<Outlines>    |


Examples:
|MediaFilePath        |Market|Outlines                                     |
|/files/GbrSd_PASS.mov|United Kingdom|top: 5%; bottom: 5%; left: 5%; right: 5%;    |
|/files/MenHd_PASS.mov|Algeria       |top: 5%; bottom: 5%; left: 5%; right: 5%;    |



Scenario: Uploading invalid file
Meta:@mediamanager
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/Fish3-Ad.mov|
Then I should see Error popup


Scenario: Check external user can see the request specification details in mediamanager
!--QA-1084
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Supply Via  | Assignee               |  Message        |  Already Supplied|Deadline Date |DestinationID|Motivnummer|
| automated test info    | UUMFAR4    | UUMFBR4 | UUMFSB4   | UUMFPR4 | UUMFC4   | UUMFCN4      | 1       | 04/04/2022     | HD 1080i 25fps | UUMFT4 | FTP         | autotest@adstream.com   | automated test  | should not       |12/04/2022        |6228          | 423|
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'UUMFCN4'
And waited while order with clock number 'UUMFCN4' is available in media manager
And click view details
Then I 'should' see order details data form in Media File Info page:
|FieldName   |Value          |
|Market	     |  Germany      |
|Agency	     |  DefaultAgency|
|Clock Number|	UUMFCN4      |
|Advertiser	 |  UUMFAR4      |
|Product	 |  UUMFPR4      |
|Title	     |  UUMFT4       |
|Duration	 |  00:00:01:00  |
|Uploader	 | AgencyAdmin   |


Scenario: Check that media file is playable in file info page.
Meta:@mediamanager
!--QA-847
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/DeuSd_PASS.mov|
And wait until QC process spinner disappers in 'Info' page
Then 'should' see on media file info page that file is playable


Scenario: Check antivirus running on UI
!--QA-1140
Meta:@mediamanager
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath        |
|/files/GbrHd_PASS.mov|
And wait for '2' seconds
Then I 'should' see progress message is displayed as 'Checking the file for viruses'
When fill meta data in media manager file info page:
| Market         | advertiser    | product      | agency            | clockNumber   | Duration                     |
| United Kingdom | UUMFAR7       | UUMFP7       | DefaultAgency     | UUMFCN7       | 0 hours,0 minutes,1 second   |
And search the media file by 'UUMFCN7'
And I 'should' see the asset tile text as 'Auto QC in progress...'


Scenario:  Check QC Passed asset in uploader uploaded by external user
Meta:@mediamanager
     @mediamanagerUATSmoke
!--QA-1127
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When I upload media file in to media uploader via UI:
|MediaFilePath|
|/files/ger_hd_pass.mov|
And fill meta data in media manager file info page:
| Market       | advertiser | product  | agency | clockNumber    | Duration                      |
| Germany      |UUMFAR8     | UUMFP8   | UUMFA8 | UUMFCN8        | 0 hours,0 minutes,1 second    |
And search the media file by 'UUMFCN8'
And wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
|QC Message|
|QC Passed |

