!--QA-1130
Feature: User can Accept or Reject single asset from Shared Collection asset preview
Narrative:
In order to
As a AgencyAdmin
I want to check User can Accept or Reject single asset from Shared Collection asset preview

Lifecycle:
Before:
Given I created the agency 'A_CARAP_S05_1' with default attributes
And created the agency 'A_CARAP_S05_2' with default attributes
And updated the following agency:
| Name          | Labels                  |
| A_CARAP_S05_2 | new-library-dev-version |
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CARAP_S05_1':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    |
And added agency 'A_CARAP_S05_1' as a partner to agency 'A_CARAP_S05_2'
And created users with following fields:
| Email         | Role         | Agency        |  Access              |
| U_CARAP_S05_1 | agency.admin | A_CARAP_S05_1 |  streamlined_library |
| U_CARAP_S05_2 | agency.admin | A_CARAP_S05_2 | streamlined_library  |
When login with details of 'U_CARAP_S05_1'
And create following categories:
| Name             | Media Type |
| C_CARAP_S05      | video      |
And upload following assetsNEWLIB:
| Name                   |
|/files/Fish1-Ad.mov     |
|/files/Fish2-Ad.mov     |
|/files/Fish3-Ad.mov     |
|/files/Fish4-Ad.mov     |
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name           | Advertiser  |
| Fish4-Ad.mov   | TAFAR1      |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_CARAP_S05  | A_CARAP_S05_2 |

Scenario: Check that user with inbox.read permissions is unable to see attachment,Asset Activity,Delivery,Share,Download etc buttons in the asset preview of the shared category
Meta:@gdam
@library
When login with details of 'U_CARAP_S05_2'
And I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
And click asset 'Fish1-Ad.mov' on the collection page
Then I 'should' be able to play the asset on preview pageNEWLIB
Then I 'should not' see 'activities' button on opened asset info pageNEWLIB
And I 'should not' see 'projects' button on opened asset info pageNEWLIB
And I 'should not' see 'attachments' button on opened asset info pageNEWLIB
And I 'should not' see 'deliveries' button on opened asset info pageNEWLIB
And I 'should' see 'info' button on opened asset info pageNEWLIB
And I 'should not' see 'download' button on opened asset info pageNEWLIB
And 'should not' see 'share asset' button on opened asset info pageNEWLIB


Scenario: Check that user can navigate through the assets in the inbox collection
Meta:@gdam
@library
When login with details of 'U_CARAP_S05_2'
And I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
And click asset 'Fish1-Ad.mov' on the collection page
Then 'should' see 'Fish1-Ad.mov' on asset preview page
When I navigate to asset with title 'Fish2-Ad.mov' on preview pageNEWLIB
Then 'should' see 'Fish2-Ad.mov' on asset preview page
When I navigate to asset with title 'Fish1-Ad.mov' on preview pageNEWLIB
Then 'should' see 'Fish1-Ad.mov' on asset preview page


Scenario: Check that agency user is unable to see the shared category
Meta:@library
     @gdam
Given created users with following fields:
| Email         | Role         | Agency        |  Access              |
| U_CARAP_S05_3 | agency.user | A_CARAP_S05_2 | streamlined_library  |
When login with details of 'U_CARAP_S05_3'
And I go to the collections page
Then I 'should not' see the shared collections for Agency 'A_CARAP_S05_1':
|collection       |
|C_CARAP_S05       |

Scenario: Check that you can accept single Asset from a Shared Category in the Asset Info page
Meta:@gdam
@library
When login with details of 'U_CARAP_S05_2'
And I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
And wait for '2' seconds
And click asset 'Fish1-Ad.mov' on the collection page
And wait for '2' seconds
And I click 'accept' button for the asset of the shared category on the asset info page
And I click 'yes' button in accept reject assets in assets info page
And wait for message 'Asset successfully accepted'
And I go to  Library page for collection 'My Assets'NEWLIB
And refresh the page without delay
And wait for '2' seconds
Then I 'should' see assets with titles 'Fish1-Ad.mov' in the collection 'My Assets'NEWLIB
When I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
Then I 'should not' see assets with titles 'Fish1-Ad.mov' in Shared Category 'C_CARAP_S05'
When I go to the library page for collection 'Everything'NEWLIB
And refresh the page without delay
And wait for '2' seconds
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB


Scenario: Check that asset is not accepted if you click cancel in accept asset popup
Meta:@gdam
@library
When login with details of 'U_CARAP_S05_2'
And I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
And click asset 'Fish3-Ad.mov' on the collection page
And I click 'accept' button for the asset of the shared category on the asset info page
And I click 'cancel' button in accept reject assets in assets info page
And wait for '2' seconds
And I go to  Library page for collection 'My Assets'NEWLIB
Then I 'should not' see assets with titles 'Fish3-Ad.mov' in the collection 'My Assets'NEWLIB
When I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
Then I 'should' see assets with titles 'Fish3-Ad.mov' in Shared Category 'C_CARAP_S05'
When I go to the library page for collection 'Everything'NEWLIB
Then I 'should not' see assets 'Fish3-Ad.mov' in the collection 'Everything'NEWLIB


Scenario: Check that you can reject single Asset from a Shared Category in the Asset Info page
Meta:@gdam
@library
When login with details of 'U_CARAP_S05_2'
When I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
And click asset 'Fish2-Ad.mov' on the collection page
And wait for '2' seconds
And I click 'reject' button for the asset of the shared category on the asset info page
And I click 'yes' button in accept reject assets in assets info page
And wait for message 'Asset successfully rejected' in the asset info page
And wait for '2' seconds
And I go to  Library page for collection 'My Assets'NEWLIB
And refresh the page without delay
And wait for '2' seconds
Then I 'should not' see assets with titles 'Fish2-Ad.mov' in the collection 'My Assets'NEWLIB
When I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
Then I 'should not' see assets with titles 'Fish2-Ad.mov' in Shared Category 'C_CARAP_S05'
When I go to the library page for collection 'Everything'NEWLIB
And refresh the page without delay
And wait for '2' seconds
Then I 'should not' see assets 'Fish2-Ad.mov' in the collection 'Everything'NEWLIB


Scenario: Check that clicking cancel in reject asset popup will not reject the asset
Meta:@gdam
@library
When login with details of 'U_CARAP_S05_2'
When I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
And click asset 'Fish4-Ad.mov' on the collection page
And I click 'reject' button for the asset of the shared category on the asset info page
And I click 'cancel' button in accept reject assets in assets info page
And wait for '2' seconds
And I go to  Library page for collection 'My Assets'NEWLIB
Then I 'should not' see assets with titles 'Fish4-Ad.mov' in the collection 'My Assets'NEWLIB
When I go to the collections page
And I  click shared collection 'C_CARAP_S05' on the collection page for Agency 'A_CARAP_S05_1'
Then I 'should' see assets with titles 'Fish4-Ad.mov' in Shared Category 'C_CARAP_S05'
When I go to the library page for collection 'Everything'NEWLIB
Then I 'should not' see assets 'Fish4-Ad.mov' in the collection 'Everything'NEWLIB




