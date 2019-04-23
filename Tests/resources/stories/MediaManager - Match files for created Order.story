Feature:         Matching files for newly created orders
Narrative:
In order to
As a
I want to         be able to confirm an order is matched So I know the correct file is delivered

Scenario:  QC pass file awaiting for matching order
Meta:@mediamanager
!--QA-947
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/DeuSd_PASS.mov|
And fill meta data in media manager file info page:
|Market       |advertiser    |product      |agency    | Duration|
|Germany      |MFFCOAR       |MFFCOP       |MFFCOA    | 0 hours,0 minutes,1 second   |
And search the media file by 'MFFCOAR'
And wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
|QC Message|
|QC Passed |
When submit files with clocknumber '' in upload page
And wait for '10' seconds
Then I should see the following data for media file in upload page:
|QC Message|
|File awaiting match |


Scenario:  Uploader - Confirm Order Match (Single match)
Meta:@mediamanager
     @qamediamanagersmoke
!--QA-947
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/sd_pass.mov|
And fill meta data in media manager file info page:
|Market  |advertiser |product    |clockNumber |title    |agency          | Duration                     |
|Germany |MFFCOAR1   |MFFCOP1    |MFFCOCN1    |MFFCOT1   |DefaultAgency   | 0 hours,0 minutes,1 second   |
And search the media file by 'MFFCOCN1'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber 'MFFCOCN1' in upload page
And I logout from media manager
When I go to babylon Login page
And login with details of 'AgencyAdmin'
And create 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | DestinationID |Motivnummer| Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | MFFCOAR1   | MFFCOBR |MFFCOSB    | MFFCOP1 | MFFCOC   | MFFCOCN1     | 1        | 10/14/2022     | HD 1080i 25fps | MFFCOT1 | Already Supplied   | 6683          |124        | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
And click element 'MediaManager' on page 'Projects'
And waited while order with clock number 'MFFCOCN1' is available in media manager
And search the media file by 'MFFCOCN1'
And wait for '20' seconds
Then I should see the following data for media file in upload page:
|QC Message|
|ID matched with asset |
When I click view details
And I click 'View matching asset' in media manger file info page
And I select asset '1'  in the Select an asset popup
And attach asset
And search the media file by 'MFFCOCN1'
Then I should see '0' media files in uploads page
And I logout from media manager
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And search the media file by 'MFFCOCN1'
Then I should see '0' media files in uploads page


Scenario:  Confirm Order Match by filling manadatory fields (Multiple match)
Meta:@mediamanager
!-- Bug MM-783
!--QA-947
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|<MediaFilePath>|
And fill meta data in media manager file info page:
| Market    |advertiser    |product     |clockNumber   |title     |agency     | Duration|
| <Market>  |<advertiser>  |<product>   |<clockNumber> |<title>   |<agency>   | <Duration>|
And upload media file in to media uploader via UI:
|MediaFilePath|
|<MediaFilePath>|
And fill meta data in media manager file info page:
|Market    |advertiser    |product     |clockNumber   |title     |agency     | Duration|
|<Market>  |<advertiser>  |<product>   |<clockNumber> |<title>   |<agency>   | <Duration>|
And search the media file by '<clockNumber>'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber '<clockNumber>' in upload page
And I logout from media manager
When I go to babylon Login page
And login with details of 'AgencyAdmin'
And create 'tv' streamline order with market '<Market>' and items with following fields :
| Additional Information | Advertiser    | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required   | DestinationID  |Motivnummer| Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | <advertiser>  | MFFCOBR  | MFFCOSB  | <product> | MFFCOC  | <clockNumber>| 1        | 10/14/2022     | HD 1080i 25fps | <title> | Already Supplied   | <DestinationID>|124        | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
And click element 'MediaManager' on page 'Projects'
And I search the media file by '<clockNumber>'
And waited while order with clock number '<clockNumber>' is available in media manager
Then I should see the following data for media file in upload page:
|QC Message|
|Multiple ID matches with assets|
When I click view details
Then I should see text on page contains '2 matching assets found'
When I click 'View matching assets' in media manger file info page
Then I should see '2' assets in the Select an asset popup
When I select asset '1'  in the Select an asset popup
And I click 'Choose another asset' in media manger file info page
And I select asset '2'  in the Select an asset popup
And I attach asset
And search the media file by '<clockNumber>'
Then I should see '1' media files in uploads page

Examples:
| MediaFilePath            | Market         | advertiser| product    | clockNumber   | title   | agency        | Duration                     | DestinationID|
| /files/sd_pass.mov       | Germany        | MFFCOAR3  | MFFCOP3   | MFFCOCN3       | MFFCOT3   | DefaultAgency | 0 hours,0 minutes,1 second   | 6683         |
| /files/GbrHd_PASS.mov    | United Kingdom | MFFCOAR3  | MFFCOP3   | MFFCOCN4       | MFFCOT4   | DefaultAgency | 0 hours,0 minutes,1 second   | 157          |


Scenario:  Check matching rules with same market, title and agency for MENA market
Meta:@mediamanager
!--QA-1117
!-- Bug MM-783
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
| Market                 |advertiser|product    |title     |agency          | Duration|
| United Arab Emirates   |MFFCOAR5  |MFFCOP5    |MFFCOT5   |DefaultAgency   |  0 hours,0 minutes,1 second|
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
|Market                 |advertiser|product    |title      |agency         | Duration|
|United Arab Emirates   |MFFCOAR6  |MFFCOP6    |MFFCOT5   |DefaultAgency   |  0 hours,0 minutes,1 second|
And search the media file by 'MFFCOT5'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber '' in upload page
And I logout from media manager
When I go to babylon Login page
And login with details of 'AgencyAdmin'
And create 'tv' streamline order with market 'United Arab Emirates' and items with following fields :
| Additional Information | Advertiser| Brand    | Sub Brand | Product | Campaign |Clock Number| Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | MFFCOAR   | MFFCOBR  | MFFCOSB  | MFFCOP   | MFFCOC   |MFFCOCN    | 1        | 10/14/2022     | HD 1080i 25fps  | MFFCOT5 | Already Supplied     | 7724            | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
And click element 'MediaManager' on page 'Projects'
And search the media file by 'MFFCOT5'
And waited while order with clock number 'MFFCOCN' is available in media manager
Then I should see the following data for media file in upload page:
|QC Message|
|Multiple ID matches with assets|
When I click view details
Then I should see text on page contains '2 matching assets found'
When I click 'View matching assets' in media manger file info page
Then I should see '2' assets in the Select an asset popup
When I select asset '1'  in the Select an asset popup
And I click 'Choose another asset' in media manger file info page
And I select asset '2'  in the Select an asset popup
And I attach asset
And search the media file by 'MFFCOT5'
Then I should see '1' media files in uploads page


Scenario:  Check matching rules does not meet for one asset with same market, agency, different title for MENA market
Meta:@mediamanager
!--QA-1117
!-- Bug MM-784
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
| Market                 |advertiser|product    |title      |agency         | Duration|
| United Arab Emirates   |MFFCOAR5  |MFFCOP5    |MFFCOT6   |DefaultAgency   |  0 hours,0 minutes,1 second|
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
|Market                 |advertiser|product    |title     |agency          | Duration|
|United Arab Emirates   |MFFCOAR5  |MFFCOP5    |MFFCOT7   |DefaultAgency   |  0 hours,0 minutes,1 second|
And search the media file by 'MFFCOAR5'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber '' in upload page
And I logout from media manager
When I go to babylon Login page
And login with details of 'AgencyAdmin'
And create 'tv' streamline order with market 'United Arab Emirates' and items with following fields :
| Additional Information | Advertiser| Brand    | Sub Brand | Product   | Campaign |Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | MFFCOAR   | MFFCOBR  | MFFCOSB   | MFFCOP    | MFFCOC   |MFFCOCN7     | 1        | 10/14/2022     | HD 1080i 25fps | MFFCOT7 | Already Supplied     | 7724            | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
And click element 'MediaManager' on page 'Projects'
And search the media file by 'MFFCOT7'
And waited while order with clock number 'MFFCOCN7' is available in media manager
Then I should see the following data for media file in upload page:
|QC Message|
|ID matched with asset |
When I click view details
Then I should see text on page contains '1 matching assets found'
When I click 'View matching asset' in media manger file info page
And I select asset '1'  in the Select an asset popup
And I attach asset
And search the media file by 'MFFCOT7'
Then I should see '0' media files in uploads page
When I search the media file by 'MFFCOT6'
Then I should see '1' media files in uploads page


Scenario:  Check allow HD resolution only for MENA market SD order in uploads page
Meta:@mediamanager

!--QA-1117
Given I am on babylon Login page
And logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'United Arab Emirates' and items with following fields :
| Additional Information | Advertiser| Brand    | Sub Brand| Product  | Campaign|Clock Number| Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | MFFCOAR   | MFFCOBR  | MFFCOSB  | MFFCOP   | MFFCOC  |MFFCOCN8    | 1        | 10/14/2022     | HD 1080i 25fps | MFFCOT8 | Already Supplied     | 344             | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
When I click element 'MediaManager' on page 'Projects'
And search the media file by 'MFFCOCN8'
And waited while order with clock number 'MFFCOCN8' is available in media manager
Then I should see the resolution type as 'HD'
When I upload file '/files/MenHd_PASS.mov' to order with 'MFFCOCN8' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
Then I should see the resolution type as 'HD'
And I should see the following data for media file in upload page:
|QC Message|
|QC Passed |


Scenario:  Check allow HD resolution only for MENA market SD order in Media checker page
Meta:@mediamanager
!--QA-1117  --Bug MM-443
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
| Market                 |advertiser|product     |title      |agency          | Duration|
| United Arab Emirates   |MFFCOAR9  |MFFCOP9     |MFFCOT9   |DefaultAgency   |  0 hours,0 minutes,1 second|
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
|Market                 |advertiser|product    |title      |agency         | Duration|
|United Arab Emirates   |MFFCOAR10 |MFFCOP10   |MFFCOT9   |DefaultAgency   |  0 hours,0 minutes,1 second|
And search the media file by 'MFFCOT9'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber '' in upload page
And I logout from media manager
When I go to babylon Login page
And login with details of 'AgencyAdmin'
And create 'tv' streamline order with market 'United Arab Emirates' and items with following fields :
| Additional Information | Advertiser| Brand    | Sub Brand| Product  | Campaign |Clock Number| Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | MFFCOAR   | MFFCOBR  | MFFCOSB  | MFFCOP   | MFFCOC   |MFFCOCN9    | 1        | 10/14/2022     | HD 1080i 25fps | MFFCOT9 | Already Supplied      | 344            | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
And go to Media Checker page
And I select market region as 'United Arab Emirates' in  Media Checker
And search the media file by 'title' with 'MFFCOT9' in Media Checker page
And wait until the request with clocknumber 'MFFCOCN9' appears in Media Checker
Then I should see following details for asset in media checker:
| Status               |
| Possible asset match |
| Possible asset match |
| Possible asset match |
When open on tile with clock number 'MFFCOCN9' in Media Checker page
And I click 'View matching assets' in media manger file info page
And I select asset '1'  in the Select an asset popup
And I attach asset
And I go to Media Checker page
And I select market region as 'United Arab Emirates' in  Media Checker
And search the media file by 'title' with 'MFFCOT9' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Confirmed|
|Submitted|


Scenario:  Check matching criteria Title, Clock , Agency should ignore the case of the text
Meta:@mediamanager
!--QA-1147
!-- Bug MM-783
!-- Bug MM-655
Given I am on babylon Login page
And I logged in as 'GlobalAdmin'
And I created the following agency:
| Name     | A4User        | Country         | Application Access                        |
| MFFCOBU1 | DefaultA4User | United Kingdom  | adkits,folders,ordering,media_manager,media_checker|
And I created users with following fields:
| Email   | Role          | AgencyUnique     | Access                                    |
| MFFCOU1 | agency.admin  | MFFCOBU1         |adkits,folders,ordering,media_manager,media_checker |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MFFCOBU1':
| Advertiser | Brand   | Sub Brand | Product  |
| MFFCOAR11  | MMHEBR11| MFFCOSB11 | MFFCOP11 |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/GbrSd_PASS.mov|
And fill meta data in media manager file info page:
| Market           |advertiser |product    |title     |clockNumber | agency   | Duration                   |
| United Kingdom   |MFFCOAR11  |MFFCOP11   |mffcot11  |mffcocn11   |mffcobu1  |  0 hours,0 minutes,1 second|
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/GbrSd_PASS.mov|
And fill meta data in media manager file info page:
|Market           |advertiser |product   |title     |clockNumber |agency     | Duration|
|United Kingdom   |MFFCOAR11  |MFFCOP11  |MFFcot11  |MFFcoCN11   |MFFcoBU1   |  0 hours,0 minutes,1 second|
And search the media file by 'MFFCOAR11'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber '' in upload page
And I logout from media manager
When I go to babylon Login page
And login with details of 'MFFCOU1'
And create 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser| Brand    | Sub Brand | Product | Campaign |Clock Number| Duration | First Air Date | Format         | Title    | Subtitles Required   | DestinationID   | Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | MFFCOAR11 | MFFCOBR  | MFFCOSB  | MFFCOP   | MFFCOC   |MFFCOCN11   | 1        | 10/14/2022     | HD 1080i 25fps | MFFCOT11 | Already Supplied     |       1         | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
And click element 'MediaManager' on page 'Projects'
And search the media file by 'MFFCOAR11'
And waited while order with clock number 'MFFCOCN11' is available in media manager
Then I should see the following data for media file in upload page:
|QC Message|
|Multiple ID matches with assets|
When I click view details
Then I should see text on page contains '2 matching assets found'
When I click 'View matching assets' in media manger file info page
Then I should see '2' assets in the Select an asset popup
When I select asset '1'  in the Select an asset popup
And I click 'Choose another asset' in media manger file info page
And I select asset '2'  in the Select an asset popup
And I attach asset
And search the media file by 'mffcot11'
Then I should see '1' media files in uploads page

