Feature:         Sorting and pagination
Narrative:
In order to
As a       AgencyAdmin
I want to   be able to sort and pagination between the pages in Media Checker


Scenario: Check number of assets per page in media checker and history as MC user
!--QA-1053
Meta:@mediamanager
     @mediamanagersortingpagination
Given I am on Media Checker page
Then I should see the number of results display per 'Media Checker' page is '5'
And I should see following pagination sizes with default size '5' in the dropdown in 'Media Checker' page:
|PaginationSize|
|5 per page|
|10 per page|
|20 per page|
|30 per page|
When I go to Media Checker History page
Then I should see following pagination sizes with default size '8' in the dropdown in 'Media Checker History' page:
|PaginationSize|
|8 per page |
|16 per page|
|24 per page|
And I should see the number of results display per 'Media Checker History' page is '8'


Scenario: Check sorting in media checker by old date
!--QA-1053
Meta:@mediamanager
     @mediamanagersortingpagination
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
When click element 'MediaManager' on page 'Projects'
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/sd_pass.mov|
And fill meta data in media manager file info page:
|Market      |advertiser   |product |clockNumber|agency    | Duration|
|Germany     |SAPAdr       |SAPV   |SAPClock   |DefaultAgency | 0 hours,0 minutes,1 second |
And wait until QC process spinner disappers in 'Uploads' page
When I go to Media Checker page
Then I should see following sort by data with default as 'Date - Most Recent First' in the dropdown in MC page:
|Sort by|
|Date - Most Recent First|
|Date - Oldest First|
|Delivery Time - Least Remaining|
|Delivery Time - Most Remaining|
|Status|
When I select sort by 'Date - Oldest First' in media checker
Then I 'should not' see the file in media checker as recent file with value 'SAPClock'
And I logout from media manager


Scenario: Check sorting in media checker by delivery time
!--QA-1053
Meta:@mediamanager
     @mediamanagersortingpagination
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration |  First Air Date | Format         | Title    |  Subtitles Required|Supply Via  | Assignee               |  Message        | Deadline Date |DestinationID|ServiceLevel|
| automated test info    | SAPAdr3    | SAPBR3 |SAPSB3     | SAPP3   | SAPC     | SAPCN3        | 1       | 10/14/2022      | HD 1080i 25fps  | SAMT3  |  Already Supplied   | FTP        | autotest@adstream.com  | automated test  | 12/14/2022    |1            | 2          |
When I click element 'MediaManager' on page 'Projects'
And waited while order with clock number 'SAPCN3' is available in media manager
And I go to Media Checker page
And I select sort by 'Delivery Time - Most Remaining' in media checker
And wait for '2' seconds
Then I 'should' see the file in media checker as recent file with value 'SAPCN3'
When I select sort by 'Delivery Time - Least Remaining' in media checker
Then I 'should not' see the file in media checker as recent file with value 'SAPCN3'


Scenario: Check pagination in media checker and History
!--QA-1053
Meta:@mediamanager
     @mediamanagersortingpagination
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
When go to Media Checker page
Then I am able to navigate between the pages in media checker
When go to Media Checker History page
Then I am able to navigate between the pages in History page
And I logout from media manager