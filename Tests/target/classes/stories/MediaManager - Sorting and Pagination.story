Feature:         Sorting and pagination
Narrative:
In order to
As a
I want to   be able to sort and pagination between the pages in Media Manager


Scenario: Check pagination in media uploader and History
!--QA-1053
Meta:@mediamanager
     @mediamanagersortingpagination
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When I go to Media Manager Uploads page
Then I am able to navigate between the pages in uploader
When go to Media Manager History page
Then I am able to navigate between the pages in History page
And I logout from media manager


Scenario: Check Sorting by old date in Uploads page
!--QA-1053
Meta:@mediamanager
     @mediamanagersortingpagination
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When I upload media file in to media uploader via UI:
|MediaFilePath|
|/files/sd_pass.mov|
And fill meta data in media manager file info page:
|Market       |advertiser |product|agency        | clockNumber  |Duration|
|Germany      |SAPAdr2    |SAPP2  |DefaultAgency | SAPCN2       |0 hours,0 minutes,1 second   |
And I sort media files by 'old' date in uploads page
Then I 'should not' see the file 'sd_pass.mov' in first place


Scenario: Check number of assets per page in uploader and history as MM user
!--QA-1053
Meta:@mediamanager
     @mediamanagersortingpagination
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
Then should see the number of files display per page is '8'
And I should see following pagination sizes with default size '8' in the dropdown in MM upload page:
|PaginationSize|
|8 per page|
|16 per page|
|24 per page|
When I go to Media Manager History page
Then should see the number of results displayed per MM history page is '8'
And I should see following pagination sizes with default size '8' in the dropdown in MM History page:
|PaginationSize|
|8 per page|
|16 per page|
|24 per page|


