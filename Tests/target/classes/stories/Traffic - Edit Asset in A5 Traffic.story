Feature:    Edit Asset in A5 from Traffic application
Narrative:
In order to
As a              AgencyAdmin
I want to Edit Asset in A5 from Traffic application


Scenario: Check that Traffic Manager is able to share assets (Edit Asset via Traffic UI)
Meta:@traffic
     @tbug  !--NIR-1303 NIR-1223
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand  | Sub Brand  | Product   |
| TMEATAR1     | TMEATBR1 | TMEATSB1     | TMEATSP1    |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TMEATAR1   | TMEATBR1   | TMEATSB1   | TMEATSP1    | TMEATSC1    | TMEATC_1       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TTVBTVST1     |  Facebook DE:Express   |
And complete order contains item with clock number 'TMEATC_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TMEATC_1' to A4
And I ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency    | TMEATC_1  |
And I logged in with details of 'trafficManager'
And waited till order with clockNumber 'TMEATC_1' will be available in Traffic
And waited till order with clockNumber 'TMEATC_1' will have next status 'Completed' in Traffic
And I amon order item details page of clockNumber 'TMEATC_1'
When I click on 'Edit Asset' button on order item details page in traffic
And I share asset 'TMEATC_1' from collection 'My Assets' to following users:
| UserEmails   |
| AgencyAdmin |
And I login with details of 'AgencyAdmin'
And open link from email when user 'AgencyAdmin' received email with next subject 'has been shared'
Then I 'should' be on asset preview page
And I 'should' see following 'custom metadata' fields on opened asset info page:
| FieldName                       | FieldValue             |
| Title                           | TTVBTVST1              |


Scenario: Check that Traffic Manager is able to edit UR for assets (Edit Asset via Traffic UI)
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product   | Campaign  | Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TMEATAR1   | TMEATBR1 | TMEATSB1  | TMEATSP1  | TTVBTVSC1 | TMEURCN9_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
When I open order item with following clock number 'TMEURCN9_1'
And fill following fields for usage right 'General' on order item page:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And save usage information for 'General' usage right on order item page
And completed order contains item with clock number 'TMEURCN9_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMEURCN9_1' will be available in Traffic
And I amon order item details page of clockNumber 'TMEURCN9_1'
When I click on 'Edit Asset' button on order item details page in traffic
And I click 'Usage Rights' TAB on opened asset info page
And I edit entry of 'General' usage rule with following fields on opened asset Usage Rights page:
|EntryNumber | StartDate  | ExpirationDate |
|1           | 02.02.2020 | 02.02.2027     |
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2020 | 02.02.2027     |

Scenario: Check that Traffic Manager can Edit Asset in A5 from Traffic UI
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TMEATAR1   | TMEATBR1 | TMEATSB1  | TMEATSP1 | TTVBTVSC1 | TMEACN9_2     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TMEACN9_2' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMEACN9_2' will be available in Traffic
And I amon order item details page of clockNumber 'TMEACN9_2'
When I click on 'Edit Asset' button on order item details page in traffic
And 'saved' asset info by following information on opened asset info page:
| FieldName                       | FieldValue             |
| Title                           | IMG LAUR S24           |
| Description                     | Spring season          |
| Advertiser                      | ADV_UEMDSA_S01         |
| Brand                           | BR_UEMDSA_S01          |
| Sub Brand                       | SBR_UEMDSA_S01         |
| Product                         | PR_UEMDSA_S01          |
| Campaign                        | C_UIRPEMD_S07          |
Then I 'should' see following 'custom metadata' fields on opened asset info page:
| FieldName                       | FieldValue             |
| Title                           | IMG LAUR S24           |
| Description                     | Spring season          |
| Advertiser                      | ADV_UEMDSA_S01         |
| Brand                           | BR_UEMDSA_S01          |
| Sub Brand                       | SBR_UEMDSA_S01         |
| Product                         | PR_UEMDSA_S01          |
| Campaign                        | C_UIRPEMD_S07          |



Scenario: Check that Traffic Manager is able to edit attachments for assets (Edit Asset via Traffic UI)
Meta:@traffic
     @devopstests
     @devopsuattests
Given I created the following agency:
| Name         |    A4User     | AgencyType     |     Application Access     |
| TMEATA1_1    | DefaultA4User | Advertiser     |      ordering,streamlined_library      |
| TMEATI1_1    | DefaultA4User |   Ingest       |      adpath                |
And created users with following fields:
| Email       |            Role           | AgencyUnique     |  Access          |
| TMEATU1_1   |       agency.admin        |   TMEATA1_1      | ordering,streamlined_library |
| TMEATU2_1   | traffic.traffic.manager   |   TMEATI1_1      |  adpath          |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TMEATA1_1':
| Advertiser | Brand  | Sub Brand  | Product |
| TEAA1      | TEABR1 | TEASB1     | TEAP1   |
And logged in with details of 'TMEATU1_1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number   | Duration | First Air Date | Subtitles Required | Format          |Motivnummer | Title     | Destination         |
| automated test info    | TEAA1      | TEABR1 | TEASB1    | TEAP1   | TTVBTVSC1 | TMEATCN9_1     | 20       | 12/14/2022     |  Already Supplied  | HD 1080i 25fps  |12 | TTVBTVST1 | Facebook DE:Express |
And upload to 'tv' order item with clock number 'TMEATCN9_1' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'TMEATCN9_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TMEATCN9_1' to A4
And logged in with details of 'TMEATU2_1'
And waited till order with clockNumber 'TMEATCN9_1' will be available in Traffic
And I amon order item details page of clockNumber 'TMEATCN9_1'
When I click on 'Edit Asset' button on order item details page in traffic
And I click 'Attachments' TAB on opened asset info page
And wait for '5' seconds
And I fill following fields on Edit attached file 'file_2.txt' popup on asset attachments page:
| Name           | Description |
| file_2_new.txt | auto test   |
And save editing of attached file 'file_2.txt' on asset attachments page
And wait for '5' seconds
Then I should see following data on asset attachments page for qc asset of order with market 'United Kingdom' and item clock number 'TMEATCN9_1':
| File Name      | Size | Description |
| file_2_new.txt | 13 B | auto test   |


