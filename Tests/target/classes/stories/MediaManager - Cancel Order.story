Feature:          Cancel a order
Narrative:
In order to
As a AgencyAdmin
I want to         Cancel a order

Scenario: Check that after cancelling the request you can place a request with Same metadata in Media Manager and status is Possible asset match
!--QA-1180
Meta:@mediamanager
Given I logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser  | Brand       | Sub Brand      | Product      | Campaign      | Clock Number  | Duration | First Air Date | Format         | Title        | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | SCADLCASAR2 | SCADLCASBR2 | SSCADLCASSB2   | SSCADLCASPR2 | SSCADLCASC2   | SSCADLCASCN3  | 1        | 10/14/2022     | HD 1080i 25fps | SSCADLCAST3  | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 1             | Already Supplied  |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'SSCADLCASCN3'
And waited while order with clock number 'SSCADLCASCN3' is available in media manager
When I upload file '/files/GbrSd_PASS.mov' to order with 'SSCADLCASCN3' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'SSCADLCASCN3' in upload page
And I go to babylon Login page
And login with details of 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'SSCADLCASCN3' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Confirmed|
When login with details of 'trafficManager'
And wait till order with clockNumber 'SSCADLCASCN3' will be available in Traffic
When I create tab with name 'Tab_1' and type 'Order' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value      |
|  Market     |   Match        | United Kingdom |
And wait till order list will be loaded
And enter search criteria 'SSCADLCASCN3' in simple search form on Traffic Order List page
When I open order details with clockNumber 'SSCADLCASCN3' from Traffic UI
And I amon order item details page of clockNumber 'SSCADLCASCN3'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And wait till order item with clockNumber 'SSCADLCASCN3' will have next status 'Cancelled' in Traffic
And login with details of 'AgencyAdmin'
And I go to  Library page for collection 'Everything'NEWLIB
Then I 'should not' see assets with titles 'SSCADLCASCN3' in the collection 'Everything'NEWLIB
When open Order List page
And I select 'View Completed Orders' tab on ordering page
Then I should see TV order in 'complete' order list with item clock number 'SSCADLCASCN3' and following fields:
| Order# | DateTime    | Market      |
| Digit  | CurrentTime | United Kingdom     |
When go to Media Checker page
And search the media file by 'title' with 'SSCADLCASCN3' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Submitted|
When create 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser  | Brand       | Sub Brand      | Product      | Campaign      | Clock Number  | Duration | First Air Date | Format         | Title        | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | SCADLCASAR2 | SCADLCASBR2 | SSCADLCASSB2   | SSCADLCASPR2 | SSCADLCASC2   | SSCADLCASCN3  | 1        | 10/14/2022     | HD 1080i 25fps | SSCADLCAST3  | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 1             | Already Supplied  |
And wait until the request with clocknumber 'SSCADLCASCN3' appears in Media Checker
And wait for '5' seconds
And refresh the page
And wait for '10' seconds
And search the media file by 'title' with 'SSCADLCASCN3' in Media Checker page
And wait for '10' seconds
Then I should see following details for asset in media checker:
|Status|
| Possible asset match |
| Possible asset match |

Scenario: Check that after cancelling the asset the request is deleted from library and asset status is changed to submitted
!--QA-1106
Meta:@mediamanager
Given I logged in with details of 'AgencyAdmin'
And created 'tv' streamline order with market 'United Kingdom' and items with following fields :
| Additional Information | Advertiser  | Brand       | Sub Brand      | Product      | Campaign      | Clock Number  | Duration | First Air Date | Format         | Title        | Supply Via  | Assignee               |  Message        |  Already Supplied| Deadline Date | DestinationID | Subtitles Required|
| automated test info    | SCADLCASAR2 | SCADLCASBR2 | SSCADLCASSB2   | SSCADLCASPR2 | SSCADLCASC2   | SSCADLCASCN2  | 1        | 10/14/2022     | HD 1080i 25fps | SSCADLCAST2  | FTP         | autotest@adstream.com  | automated test  | should not       | 12/14/2022    | 1             | Already Supplied  |
When I go to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
And I search the media file by 'SSCADLCAST2'
And waited while order with clock number 'SSCADLCASCN2' is available in media manager
When I upload file '/files/GbrSd_PASS.mov' to order with 'SSCADLCASCN2' in to media 'Uploader' page via UI
And wait until QC process spinner disappers in 'Uploads' page
And I submit files with clocknumber 'SSCADLCASCN2' in upload page
And I go to babylon Login page
And login with details of 'AgencyAdmin'
And go to Media Checker page
And search the media file by 'clock no.' with 'SSCADLCASCN2' in Media Checker page
And open on tile with clock number 'SSCADLCASCN2' in Media Checker page
And click tab 'MezzInfo'
And 'Commit' the request tile via media checker Mezz Info Page
And go to Media Checker page
And search the media file by 'clock no.' with 'SSCADLCASCN2' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Committed|
When login with details of 'trafficManager'
And wait till order with clockNumber 'SSCADLCASCN2' will be available in Traffic
When I create tab with name 'Tab_1' and type 'Order' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type |  Value      |
|  Market     |   Match        | United Kingdom |
And wait till order list will be loaded
And enter search criteria 'SSCADLCASCN2' in simple search form on Traffic Order List page
When I open order details with clockNumber 'SSCADLCASCN2' from Traffic UI
And I amon order item details page of clockNumber 'SSCADLCASCN2'
And I click on 'Edit Asset' button on order item details page in traffic
And cancel asset on opened info page
And wait till order item with clockNumber 'SSCADLCASCN2' will have next status 'Cancelled' in Traffic
And login with details of 'AgencyAdmin'
And I go to Library page for collection 'Everything'NEWLIB
Then I 'should not' see assets with titles 'SSCADLCASCN2' in the collection 'Everything'NEWLIB
When go to Media Checker page
And search the media file by 'title' with 'SSCADLCASCN2' in Media Checker page
Then I should see following details for asset in media checker:
|Status|
|Submitted|




