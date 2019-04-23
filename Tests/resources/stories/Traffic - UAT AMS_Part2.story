!--QA-450
Feature:    AMS Scenario
Narrative:
In order to
As a              GlobalAdmin
I want to check AMS feature

Lifecycle:
Before:
Given updated the following agency:
| Name     |  Labels|
| Arabian Media Services  |  MENA |

Scenario: Check that MBC user can escalate a TVC which is in Master Waiting for Approval Status
!--QA-450
Meta: @ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand    | Sub Brand  | Product  |
| TMCOAR13    | TMCOBR13 | TMCOSB13   | TMCOP13  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser   | Brand    | Sub Brand   | Product    | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination               |
| automated test info    | TMCOAR13     | TMCOBR13 | TMCOSB13    | TMCOP13    | TTVBTVSC1   | TAAFCN1             |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TAMSUAPT12 | MBC group (SD):Express    |
And complete order contains item with clock number 'TAAFCN1' with following fields:
| Job Number   | PO Number |
| TMEATJ13     | GDNTDP13  |
And I wait for finish place order with following item clock number 'TAAFCN1' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |TAAFCN1            |
When I login as 'ams.approval.user@adbank.me'
And wait till order with clockNumber 'TAAFCN1' will be available in Traffic
And wait till order item with clockNumber 'TAAFCN1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber 'TAAFCN1'
And fill the following fields on order item traffic page:
|     Title    |     Product    |     Advertiser    |   Media Agency     |
| ChangedTitle | ChangedProduct | ChangedAdvertiser | ChangedMediaAgency |
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I login as 'mbc.user@adbank.me'
And select 'Waiting for Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber 'TAAFCN1'
And I click on 'Escalate Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_2 | Master Escalated for first order item |
Then I 'should' see 'Master Escalated' Broadcaster Approval Status on on order item details page in traffic

Scenario: Check that MBC user can restore and reject a master
!--QA-450
Meta: @ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand    | Sub Brand  | Product  |
| TMCOAR14    | TMCOBR14 | TMCOSB14   | TMCOP14  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser   | Brand    | Sub Brand   | Product    | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination               |
| automated test info    | TMCOAR14     | TMCOBR14 | TMCOSB14    | TMCOP14    | TTVBTVSC1   | TMBCCRMCN1_2             |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TAMSUAPT12 | MBC group (SD):Express    |
And complete order contains item with clock number 'TMBCCRMCN1_2' with following fields:
| Job Number   | PO Number |
| TMEATJ13     | GDNTDP13  |
And I wait for finish place order with following item clock number 'TMBCCRMCN1_2' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |TMBCCRMCN1_2       |
When I login as 'ams.approval.user@adbank.me'
And I wait till order with clockNumber 'TMBCCRMCN1_2' will be available in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item with clockNumber 'TMBCCRMCN1_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And on order item details page of clockNumber 'TMBCCRMCN1_2'
When I fill the following fields on order item traffic page:
|     Title    |
| ChangedTitle |
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I login as 'mbc.user@adbank.me'
And select 'Waiting for Approval' tab in Traffic UI
And on order item details page of clockNumber 'TMBCCRMCN1_2'
And I click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_3 | Master Rejected for first order item |
And I click on 'Restore Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_4 | Master Restored for first order item |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click on 'Reject Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
| Email                | Comment                               |
| test1_3              | Master Rejected for first order item |
Then I 'should' see 'Master Rejected' Broadcaster Approval Status on on order item details page in traffic
And I should see the following fields on order item traffic page:
|     Title    |
| ChangedTitle |
When I login as 'ams.approval.user@adbank.me'
And I pin 'All' tab in Traffic UI
And select 'All' tab in Traffic UI
And on order item details page of clockNumber 'TMBCCRMCN1_2'
Then I 'should' see 'Master Rejected' Broadcaster Approval Status on on order item details page in traffic

Scenario: Check that AMS User can Edit Metadata and MBC user can t in order item details page
!--QA-450
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand    | Sub Brand  | Product  |
| TMCOAR14    | TMCOBR14 | TMCOSB14   | TMCOP14  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser   | Brand    | Sub Brand   | Product    | Campaign    | Clock Number           |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination               |
| automated test info    | TMCOAR14     | TMCOBR14 | TMCOSB14    | TMCOP14    | TTVBTVSC1   | TBMCEMCN_1             |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TAMSUAPT12 | MBC group (SD):Express    |
And complete order contains item with clock number 'TBMCEMCN_1' with following fields:
| Job Number   | PO Number |
| TMEATJ14     | GDNTDP14  |
And I wait for finish place order with following item clock number 'TBMCEMCN_1' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |TBMCEMCN_1         |
When I login as 'ams.approval.user@adbank.me'
And wait till order with clockNumber 'TBMCEMCN_1' will be available in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And on order item details page of clockNumber 'TBMCEMCN_1'
And wait till order item with clockNumber 'TBMCEMCN_1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And refresh the page
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1                    |    Test   |
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I fill the following fields on order item traffic page:
|     Title    |
| ChangedTitle |
And refresh the page
Then I should see the following fields on order item traffic page:
|     Title    |
| ChangedTitle |
When I login as 'mbc.user@adbank.me'
And select 'Waiting for Approval' tab in Traffic UI
And on order item details page of clockNumber 'TBMCEMCN_1'
Then I 'should not' see 'Edit Metadata' button on order item details page in traffic
And I should see the following fields on order item traffic page:
|     Title    |
| ChangedTitle |

Scenario: Check that MBC user and AMS User can add Send Level Comments
Meta:@ClientScenarioAMS
!--QA-451
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand    | Sub Brand  | Product  |
| TMCOAR15    | TMCOBR15 | TMCOSB15   | TMCOP15  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser   | Brand    | Sub Brand   | Product    | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                |
| automated test info    | TMCOAR15     | TMCOBR15 | TMCOSB15    | TMCOP15    | TTVBTVSC1   | TLCMCNN_2           |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TAMSURPT10 | MBC group (SD):Express    |
And complete order contains item with clock number 'TLCMCNN_2' with following fields:
| Job Number   | PO Number |
| TMEATJ13     | GDNTDP13  |
And I wait for finish place order with following item clock number 'TLCMCNN_2' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |TLCMCNN_2          |
When I login as 'ams.approval.user@adbank.me'
And I wait till order with clockNumber 'TLCMCNN_2' will be available in Traffic
And wait till order item with clockNumber 'TLCMCNN_2' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TLCMCNN_2' in simple search form on Traffic Order List page
And wait for '4' seconds
And I add comment for following clocks:
| clockNumber      | comment |
| TLCMCNN_2        | AAAA     |
And on order item details page of clockNumber 'TLCMCNN_2'
And refresh the page
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_3                    |    Test   |
And wait for '2' seconds
Then I 'should' see 'Master Ready For Approval' Broadcaster Approval Status on on order item details page in traffic
When I click comment button for destination 'MBC group (SD)' in order item details page
Then I should see comment 'AAAA' in order item details page
When I login as 'mbc.user@adbank.me'
And select 'Waiting for Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TLCMCNN_2' in simple search form on Traffic Order List page
And wait for '4' seconds
Then I 'should' see following fields in Order Item send list for Clock Number 'TLCMCNN_2':
| Last Comment |
| AAAA         |
When I add comment for following clocks:
| clockNumber       | comment   |
| TLCMCNN_2         | BBBB      |
And on order item details page of clockNumber 'TLCMCNN_2'
And I click comment button for destination 'MBC group (SD)' in order item details page
Then I should see comment 'BBBB' in order item details page
When click on 'Back' button on order item details page in traffic
And wait till order item list will be loaded in Traffic
Then I 'should' see following fields in Order Item send list for Clock Number 'TLCMCNN_2':
| Last Comment |
| BBBB         |

Scenario: Check that AMS user can edit Metadata in order item details page
!--QA-448
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand    | Sub Brand  | Product  |
| TMCOAR17    | TMCOBR17 | TMCOSB17   | TMCOP17  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser   | Brand    | Sub Brand   | Product    | Campaign    | Clock Number        |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination               |
| automated test info    | TMCOAR17     | TMCOBR17 | TMCOSB17    | TMCOP17    | TTVBTVSC1   | TBMCEMCN_21         |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TAMSURPT9 | MBC group (SD):Express    |
And complete order contains item with clock number 'TBMCEMCN_21' with following fields:
| Job Number   | PO Number |
| TMEATJ17     | GDNTDP17  |
And I wait for finish place order with following item clock number 'TBMCEMCN_21' to A4
And ingested assests through A5 with following fields:
| agencyName         | clockNumber       |
| DefaultAgency      |TBMCEMCN_21        |
When I login as 'ams.approval.user@adbank.me'
And wait till order with clockNumber 'TBMCEMCN_21' will be available in Traffic
And wait till order item with clockNumber 'TBMCEMCN_21' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And on order item details page of clockNumber 'TBMCEMCN_21'
And wait for '2' seconds
And fill the following fields on order item traffic page:
|     Title    |     Product    |     Advertiser    |   Media Agency     |
| ChangedTitle | ChangedProduct | ChangedAdvertiser | ChangedMediaAgency |
And refresh the page
And wait for '2' seconds
Then I should see the following fields on order item traffic page:
|     Title    |     Product    |     Advertiser    |   Media Agency     |
| ChangedTitle | ChangedProduct | ChangedAdvertiser | ChangedMediaAgency |
When click on 'Back' button on order item details page in traffic
And wait till order item list will be loaded in Traffic
When I pin 'All' tab in Traffic UI
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TBMCEMCN_21' in simple search form on Traffic Order List page
And I 'unhide' order item table items:
|Item Name|
|Title|
|Product|
|Advertiser|
|Media Agency|
|Clock number|
And wait for '4' seconds
Then I should see order item with clockNumber 'TBMCEMCN_21' in traffic order list that have following data:
|     Title    |     Product    |  Advertiser    |   Media Agency     |
| ChangedTitle | ChangedProduct |ChangedAdvertiser | ChangedMediaAgency |
When I login as 'mbc.user@adbank.me'
When I pin 'All' tab in Traffic UI
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TBMCEMCN_21' in simple search form on Traffic Order List page
And wait for '4' seconds
Then I 'should' see following fields in Order Item send list for Clock Number 'TBMCEMCN_21':
|     Title    |     Product    |     Advertiser    |
| ChangedTitle | ChangedProduct | ChangedAdvertiser |