Feature:         MM History
Narrative:
In order to
As a              AgencyAdmin
I want to         be able to see submitted and confirmed status in History


Scenario: Check File submitted status is in history
!--QA-1050
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
When click element 'MediaManager' on page 'Projects'
When upload media file in to media uploader via UI:
| MediaFilePath|
| /files/sd_pass.mov|
And fill meta data in media manager file info page:
| Market  | advertiser  | product        | clockNumber| agency         | Duration                  |
| Germany | GERAdver    | GERProduct     | MMHCN      | GermanyAgency  | 0 hours,0 minutes,1 second|
And wait until QC process spinner disappers in 'Uploads' page
And search the media file by 'MMHCN'
When submit files with clocknumber 'NOCLOCK' in upload page
And I go to Media Manager History page
And refresh the page
And wait for '2' seconds
Then I 'should' see the file with 'MMHCN' as 'File submitted' on 'Today' in 'Media Manager' History page
When I click clocknmuber 'MMHCN' link
Then I 'should' see the details in media manager file info page:
| Market  | Advertiser  | Product        | Clock Number|
| Germany | GERAdver    | GERProduct     | MMHCN      |

Scenario: Check who can see confirmed status in history
!--QA-1050
Meta:@mediamanager
     @qamediamanagersmoke
Given I am on babylon Login page
And I logged in as 'GlobalAdmin'
And I created the following agency:
| Name   | A4User        | Country         | Application Access                         |
| MMHBU1 | DefaultA4User | United Kingdom  | adkits,ordering,media_manager,media_checker|
And I created users with following fields:
| Email | Role          | AgencyUnique   | Access                       |
| MMHU1 | agency.user   | MMHBU1         | adkits,ordering,media_manager|
| MMHU2 | agency.admin  | MMHBU1         | adkits,media_checker         |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MMHBU1':
| Advertiser | Brand  | Sub Brand | Product  |
| MMHAR1     | MMHEBR1| MMHSB1    | MMHPR1   |
And logged in with details of 'MMHU1'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    |  Subtitles Required|Supply Via  | Assignee               |  Message        | Deadline Date |DestinationID|Motivnummer|
| automated test info    | MMHAR1     | MMHBR1 | MMHSB1    | MMHPR1  | MMHC1    | MMHCN1       | 1        | 10/14/2022     | HD 1080i 25fps | ASWOT1_1 |  Already Supplied  | FTP        | autotest@adstream.com  | automated test  | 12/14/2022    |6228         | 122|
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'MMHCN1'
And waited while order with clock number 'MMHCN1' is available in media manager
And I upload file '/files/DeuSd_PASS.mov' to order with 'MMHCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'MMHCN1' in upload page
And I go to Media Manager History page
And refresh the page
And wait for '5' seconds
Then I 'should' see the file with 'MMHCN1' as 'File confirmed' on 'Today' in 'Media Manager' History page
When I go to babylon Login page
And login with details of 'MMHU1'
And I go to Media Manager History page
And refresh the page
And wait for '2' seconds
Then I 'should' see the file with 'MMHCN1' as 'File confirmed' on 'Today' in 'Media Manager' History page
And I logout from media manager
When I go to babylon Login page
And login with details of 'MMHU2'
And I go to Media Checker History page
And refresh the page
And wait for '2' seconds
Then I 'should' see the file with 'MMHCN1' as 'File confirmed' on 'Today' in 'Media Checker' History page


Scenario: Check File confirmed status is in history
!--QA-1050
Meta:@mediamanager
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID| Motivnummer|
| automated test info    | MMHAR2     | MMHBR2  | MMHSB2    | MMHPR2  | MMHC2    | MMHCN2        | 1        | 10/14/2022     | HD 1080i 25fps | MMHT2 | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 6228         | 123        |
When click element 'MediaManager' on page 'Projects'
And search the media file by 'MMHCN2'
And waited while order with clock number 'MMHCN2' is available in media manager
When I upload file '/files/DeuSd_PASS.mov' to order with 'MMHCN2' in to media 'Uploader' page via UI
And I search the media file by 'MMHCN2'
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'MMHCN2' in upload page
And I go to Media Manager History page
And refresh the page
And wait for '5' seconds
Then I 'should' see the file with 'MMHCN2' as 'File confirmed' on 'Today' in 'Media Manager' History page
When I click clocknmuber 'MMHCN2' link
Then I 'should' see the details in media manager file info page:
| Market  | Agency           | Advertiser | Product    | Clock Number |
| Germany | DefaultAgency    | MMHAR2     | MMHPR2     | MMHCN2       |
