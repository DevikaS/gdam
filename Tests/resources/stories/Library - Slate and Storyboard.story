Meta:

Narrative:
As a AgencyAdmin
I want to perform an action
So that I can achieve a business goal

Scenario: Check that you can view the slate and storyboard of an asset
Meta: @gdam
@library
!--QA-1096
!--QA-1097
Given I created the following agency:
| Name          | A4User        | Application Access     |
| A_VPSS_S01_1  | DefaultA4User | streamlined_library   |
And created users with following fields:
| Email        | Role         | AgencyUnique  | Access     |
| U_VPSS_S01_1 | agency.admin | A_VPSS_S01_1  | streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_VPSS_S01_1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVPSSAR1   | AVPSSBR1 | AVPSSSB1  | AVPSSPR1 |
And logged in with details of 'U_VPSS_S01_1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination     |     Motivnummer  |
| automated test info    | AVPSSAR1   | AVPSSBR1 | AVPSSSB1  | AVPSSPR1 | SDIILC3  | AVPSSCN1     | 20       | 10/14/2022     | HD 1080i 25fps | AVPSST1 | Already Supplied   | Motorvision TV:Express | 2     |
And complete order contains item with clock number 'AVPSSCN1' with following fields:
| Job Number | PO Number |
| AVPSSJN3   | AVPSSPN3  |
And wait for finish place order with following item clock number 'AVPSSCN1' to A4
When ingested assests through A5 with following fields:
 | agencyName      | clockNumber |
 | A_VPSS_S01_1    | AVPSSCN1    |
When I go to asset 'AVPSST1' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' be able to see options 'slate,storyboard' on the asset info page
When click 'slate' button on asset info page
Then 'should' see slate view on the asset info page
And I 'should' be able to see options 'video,storyboard' on the asset info page
When click 'storyboard' button on asset info page
Then 'should' see storyboard view on the asset info page
And I 'should' be able to see options 'video,slate' on the asset info page


Scenario: check that you can maximize and minimize the slit Image in storyboard
Meta: @gdam
@library
!--QA-1097
Given I created the following agency:
| Name          | A4User        | Application Access     |
| A_CEXS_S01_1  | DefaultA4User | streamlined_library   |
And created users with following fields:
| Email        | Role         | AgencyUnique  | Access     |
| U_CEXS_S01_1 | agency.admin | A_CEXS_S01_1  | streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CEXS_S01_1':
| Advertiser | Brand    | Sub Brand | Product  |
| ACEXSAR1   | ACEXSBR1 | ACEXSBR1  | ACEXSPR1 |
And logged in with details of 'U_CEXS_S01_1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination     |     Motivnummer  |
| automated test info    | ACEXSAR1   | ACEXSBR1 | ACEXSBR1  | ACEXSPR1 | SDIILC3  | ACEXSCN1     | 20       | 10/14/2022     | HD 1080i 25fps | ACEXST1 | Already Supplied   | Motorvision TV:Express | 2     |
And complete order contains item with clock number 'ACEXSCN1' with following fields:
| Job Number | PO Number |
| ACEXSJN3   | ACEXSPN3  |
And wait for finish place order with following item clock number 'ACEXSCN1' to A4
When ingested assests through A5 with following fields:
 | agencyName      | clockNumber |
 | A_CEXS_S01_1    | ACEXSCN1    |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'ACEXST1' info page in Library for collection 'My Assets'NEWLIB
And refresh the page without delay
And click 'storyboard' button on asset info page
And select the slit image and 'maximize' it
Then 'should' see slit image expanded
When select the slit image and 'minimize' it
Then 'should' see storyboard view on the asset info page


Scenario: Check that slate and Story board options are unavailabel in Inbox catergory
Meta:@gdam
@bug
@library
!--UIR-854
!--QA-1097
Given I created the agency 'A_ICSSU_S05_1' with default attributes
And created the agency 'A_ICSSU_S05_2' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_ICSSU_S05_2 | new-library-dev-version |
And added agency 'A_ICSSU_S05_1' as a partner to agency 'A_ICSSU_S05_2'
And created users with following fields:
| Email        | Role         | Agency       |  Access              |
| U_ICSSU_S05_1 | agency.admin | A_ICSSU_S05_1 |  streamlined_library   |
| U_ICSSU_S05_2 | agency.admin | A_ICSSU_S05_2 | streamlined_library   |
And logged in with details of 'U_ICSSU_S05_1'
And created following categories:
| Name            | Media Type |
| C_ICSSU_S01  | video      |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand     | Sub Brand   | Product    | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination     |     Motivnummer  |
| automated test info    | AICSSUAR1   | AICSSUBR1 | AICSSUSBR1  | AICSSUPR1 | SDIILC3  | AICSSUCN1     | 20       | 10/14/2022     | HD 1080i 25fps | AICSSUT1 | Already Supplied   | Motorvision TV:Express | 2     |
And complete order contains item with clock number 'AICSSUCN1' with following fields:
| Job Number | PO Number |
| AICSSUJN3   | AICSSUPN3  |
And wait for finish place order with following item clock number 'AICSSUCN1' to A4
When ingested assests through A5 with following fields:
 | agencyName      | clockNumber |
 | A_ICSSU_S05_1    | AICSSUCN1    |
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ICSSU_S01 | A_ICSSU_S05_2 |
And login with details of 'U_ICSSU_S05_2'
When I go to the collections page
When I click shared collection 'C_ICSSU_S01' on the collection page for Agency 'A_ACTA_S05_1'
And click asset 'AICSSUT1' on the collection page
Then I 'should not' be able to see options 'slate,storyboard' on the asset info page


Scenario: check that you are able to download storyboard for the asset
Meta: @gdam
@library
!--QA-1134
Given I created the following agency:
| Name          | A4User        | Application Access     |
| A_CDS_S01_1  | DefaultA4User | streamlined_library   |
And created users with following fields:
| Email        | Role         | AgencyUnique  | Access     |
| U_CDS_S01_1  | agency.admin | A_CDS_S01_1   | streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CDS_S01_1':
| Advertiser | Brand    | Sub Brand | Product  |
| ACDSAR1    | ACDSSBR1 | ACDSSBR1  | ACDSPR1 |
And logged in with details of 'U_CDS_S01_1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination     |     Motivnummer  |
| automated test info    | ACDSAR1    | ACDSSBR1 | ACDSSBR1  | ACDSPR1  | SDIILC3  | ACDSCN1      | 20       | 10/14/2022     | HD 1080i 25fps | ACDSST1 | Already Supplied   | Motorvision TV:Express | 2     |
And complete order contains item with clock number 'ACDSCN1' with following fields:
| Job Number | PO Number |
| ACEXSJN3   | ACEXSPN3  |
And wait for finish place order with following item clock number 'ACDSCN1' to A4
When ingested assests through A5 with following fields:
 | agencyName      | clockNumber |
 | A_CDS_S01_1     | ACDSCN1     |
When I go to asset 'ACDSST1' info page in Library for collection 'My Assets'NEWLIB
And click 'storyboard' button on asset info page
Then I am able to downloaded storyboard for 'ACDSST1' in collection 'My Assets'

