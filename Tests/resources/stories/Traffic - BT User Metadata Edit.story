Feature:    Traffic Edit Metadata Functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check that BT user can edit order item metadata

Lifecycle:
Before:
Given updated the following agency:
| Name                      | Escalation Enabled | Approval Type | Proxy Approver               | Master Approver              |
| BroadCasterAgencyTwoStage | true               | two           | broadcasterTrafficManagerTwo | broadcasterTrafficManagerTwo |


Scenario: Check that after edit metadata, changes will be reflected in Order item list
Meta: @traffic
Given I logged in as 'GlobalAdmin'
And waited for '5' seconds
And I opened role 'broadcast.traffic.manager' page with parent 'BroadCasterAgencyTwoStage'
And refreshed the page
And I clicked element 'CopyButton' on page 'Roles'
And waited for '20' seconds
And I changed role name to 'editRole'
And clicked element 'SaveButton' on page 'Roles'
And update role 'editRole' role by following 'traffic.edit.housenumber,traffic.tab.default.view.all,traffic.metadata.editable,' permissions for advertiser 'BroadCasterAgencyTwoStage'
And created users with following fields:
| Email    | Role     | Agency                    | Access | Password   |
| TEMFU1_2 | editRole | BroadCasterAgencyTwoStage | adpath | abcdefghA1 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand     | Sub Brand | Product   |
| TBTUMEAR1  | TBTUMEBR1 | TBTUMESB1 | TBTUMEPR1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TBTUMEAR1  | TBTUMEBR1 | TBTUMESB1 | TBTUMEPR1 | TAFCP1   | TEMFCN1      | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express   |
And complete order contains item with clock number 'TEMFCN1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
When login as 'TEMFU1_2' of Agency 'BroadCasterAgencyTwoStage'
And wait till order with clockNumber 'TEMFCN1' will be available in Traffic
And I amon order item details page of clockNumber 'TEMFCN1'
And fill the following fields on order item traffic page:
|     Title    |     Product    |     Advertiser    |   Media Agency     |
| ChangedTitle | ChangedProduct | ChangedAdvertiser | ChangedMediaAgency |
And refresh the page
Then I should see the following fields on order item traffic page:
|     Title    |     Product    |     Advertiser    |   Media Agency     |
| ChangedTitle | ChangedProduct | ChangedAdvertiser | ChangedMediaAgency |
When open Traffic Order List page
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'TEMFCN1' in simple search form on Traffic Order List page
Then I should see order item with clockNumber 'TEMFCN1' in traffic order list that have following data:
|     Title    |     Product    |     Advertiser    |   Media Agency     |
| ChangedTitle | ChangedProduct | ChangedAdvertiser | ChangedMediaAgency |



Scenario: Check that after editing metadata, changes will not be replicated to a5 library
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TBTUMEAR1     | TBTUMEBR1     | TBTUMESB1     | TBTUMEPR1    | TAFCP1    | TEMFCN2       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express   |
And complete order contains item with clock number 'TEMFCN2' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
When login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber 'TEMFCN2' will be available in Traffic
And I amon order item details page of clockNumber 'TEMFCN2'
And fill the following fields on order item traffic page:
|     Title     |     Product     |     Advertiser     |   Media Agency      |
| ChangedTitle2 | ChangedProduct2 | ChangedAdvertiser2 | ChangedMediaAgency2 |
And login with details of 'AgencyAdmin'
And go to asset 'TAFT1' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName    | FieldValue   |
| Advertiser   | TBTUMEAR1       |
| Product      | TBTUMEPR1       |



Scenario: Check that after edit metadata, changes will be reflected in email and order item details page
Meta: @traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TBTUMEAR1     | TBTUMEBR1     | TBTUMESB1     | TBTUMEPR1    | TAFCP1    | <ClockNumber>       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |   Motorvision TV:Express   |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number '<ClockNumber>' to A4
When ingested assests through A5 with following fields:
 | agencyName |    clockNumber     |
 | DefaultAgency      |   <ClockNumber>    |
When login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber '<ClockNumber>'
And refresh the page without delay
And wait for '4' seconds
And fill the following fields on order item traffic page:
|     Title     |     Product     |     Advertiser     |   Media Agency      |
| ChangedTitle3 | ChangedProduct3 | ChangedAdvertiser3 | ChangedMediaAgency3 |
And click on '<Button>' button on order item details page in traffic
And fill the following fields on approval traffic pop up:
|   Email  |  Comment  |
|  <Email> |    Test   |
Then I 'should' see email with subject '<Subject>' sent to user '<Email>' and body contains '<BodyText>'

Examples:
|ClockNumber  |     Button     |      Subject      |      Email         |      BodyText      |
|  TEMFCN3    | Approve Proxy  | has been approved | test4 |    ChangedTitle3   |
|  TEMFCN3_1  |  Reject Proxy  | has been rejected | test5 | ChangedAdvertiser3 |


Scenario: Check that BT user without edit metadata permission, cannot edit metadata
Meta: @traffic
Given created 'TEMFR1' role with 'traffic.order.view.all,traffic.tab.default.view.all' permissions in 'global' group for advertiser 'BroadCasterAgencyTwoStage'
And created users with following fields:
| Email        |           Role         | Agency |  Access  | Password |
| TEMFU4_2     |           TEMFR1       |   BroadCasterAgencyTwoStage   |  adpath  | abcdefghA1 |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |   Destination          |
| automated test info    | TBTUMEAR1     | TBTUMEBR1     | TBTUMESB1     | TBTUMEPR1    | TAFCP1    | TEMFCN4       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TAFT1     |  Motorvision TV:Express   |
And complete order contains item with clock number 'TEMFCN4' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
When login as 'TEMFU4_2' of Agency 'BroadCasterAgencyTwoStage'
And wait till order with clockNumber 'TEMFCN4' will be available in Traffic
And I amon order item details page of clockNumber 'TEMFCN4'
Then I 'should not' see 'Edit Title,Edit Metadata' button on order item details page in traffic