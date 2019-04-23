Feature:          MediaManager Login
Narrative:
In order to
As a              GlobalAdmin
I want to         execute all the Media manager login scenarios


Scenario: check that A5 user can login to Media manager
Meta:@mediamanager
!--QA-844
Given I created the following agency:
| Name| A4User        | Country        | Application Access    |
| MML_BU1 | DefaultA4User | United Kingdom | adkits,folders,media_manager,media_checker|
And I created users with following fields:
| Email  | Role         |AgencyUnique| Access       |
| MMLU1 | agency.user |MML_BU1         |adkits,folders,media_manager,media_checker |
And I logout from account
When I go to Media Manager Login page
And I click element 'Login with the Adstream Platform' on page 'MediaManagerLoginPage'
And I login with details of 'MMLU1'
And click element 'MediaManager' on page 'Projects'
Then I 'should' see element 'Upload and QC new file' on page 'MediaManagerUploadsPage'
And I logout from media manager


Scenario: check that warning message should be displayed when A5 user has no access to Media manager
Meta:@mediamanager
!--QA-844
Given I created the following agency:
| Name| A4User        | Country            | Application Access    |
| MML_BU2 | DefaultA4User | United Kingdom | adkits,folders|
And I created users with following fields:
| Email  | Role         |AgencyUnique| Access       |
| MMLU2 | agency.admin |MML_BU2         |adkits,folders|
And I logout from account
When I go to Media Manager Login page
And I click element 'Login with the Adstream Platform' on page 'MediaManagerLoginPage'
And I login to Adstream platform with 'MMLU2' via Media manager
Then I should see warning message 'User has no access to media_manager module.'
And I logout from account
When I login with details of 'MMLU2'
Then I 'shouldnot' see following elements on page 'Projects':
| element       |
| MediaManager |
| MediaChecker |


Scenario: Check that warning message should be displayed when non A5 user login with Adstream platform
Meta:@mediamanager
!--QA-844
Given I am on Media Manager Login page
When I entered username 'test' and password '44' in media manager
And I click element 'Login with the Adstream Platform' on page 'MediaManagerLoginPage'
Then I should see warning message 'User has no access to media_manager module.'


Scenario:  Check a newly registered user can upload an asset to the request
Meta:@mediamanager
     @qamediamanagersmoke
!--QA-1127
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required  | DestinationID |Motivnummer| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| automated test info    | MLA1       | MLBR1 |MLSB1      | MLPR1   | MLC1     | MLCN1        | 1        | 10/14/2022     | HD 1080i 25fps |MLT1   | Already Supplied    | 6683          |124        | FTP        | MMLU3    | should not       | automated test | 12/14/2022    |
When I go to Media Manager Login page
And I register a new user with username 'MMLU3' in media manager
And I log in to media manager as 'MMLU3'
And waited while order with clock number 'MLCN1' is available in media manager
When I upload file '/files/sd_pass.mov' to order with 'MLCN1' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
| QC Message|
| QC Passed |

