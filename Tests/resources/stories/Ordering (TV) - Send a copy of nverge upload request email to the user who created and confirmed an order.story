!--ORD-3512
!--ORD-3563
Feature: Send a copy of nverge upload request email to the user who created and confirmed an order
Narrative:
In order to:
As a AgencyAdmin
I want to check sending a copy of nverge upload request email to the user who created and confirmed an order

Scenario: Check that user who confirms order recieved email about nverge upload in cc
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name       | A4User        | AgencyType | Ingest Location |
| SCNUREA1_1 | DefaultA4User | Ingest     |                 |
| SCNUREA1_2 | DefaultA4User | Advertiser | SCNUREA1_1      |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| SCNUREU1_1 | agency.admin | SCNUREA1_1   |
| SCNUREU1_2 | agency.admin | SCNUREA1_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SCNUREA1_2':
| Advertiser | Brand     | Sub Brand | Product  |
| SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 |
And logged in with details of 'SCNUREU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 | SCNUREC1 | SCNURECN1    | 20       | 10/14/2022     | HD 1080i 25fps | SCNURET1 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'SCNURECN1' a New Master with following fields:
| Supply Via | Assignee     | Already Supplied | Message        | Deadline Date |
| nVerge     | SCNUREU1_1_1 | should not       | automated test | 12/14/2022    |
And complete order contains item with clock number 'SCNURECN1' with following fields:
| Job Number | PO Number |
| SCNUREJN1  | SCNUREPN1 |
Then I 'should' see email notification for 'nVerge Upload Request' with field to 'SCNUREU1_1_1' and subject 'SendPlus Upload Request' contains following attributes:
| Agency     | Account Type | UserEmail    | Deadline Date | Clock Number | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | First Air Date | Message        | Destination        |
| SCNUREA1_2 | adstream     | SCNUREU1_1_1 | 12/14/2022    | SCNURECN1    | SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 | SCNURET1 | 20       | 10/14/2022     | automated test | BSkyB Green Button |
And 'should' see email notification for 'nVerge Upload Request' with field to 'SCNUREU1_2' and subject 'SendPlus Upload Request' contains following attributes:
| Agency     | Account Type | UserEmail    | Deadline Date | Clock Number | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | First Air Date | Message        | Destination        |
| SCNUREA1_2 | adstream     | SCNUREU1_1_1 | 12/14/2022    | SCNURECN1    | SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 | SCNURET1 | 20       | 10/14/2022     | automated test | BSkyB Green Button |

Scenario: Check that Creator and Owner are recieved email about nverge upload in cc if order has been reassigned and confirmed by another user
!--11/11 - Actually user - SCNUREU2_1 shouldnt be getting an email.However he gets an email saying SCNUREU2_1 has requested file for upload!!
!--According to Maria --[11:31:43] Maria Makovska: lets leave it as is[11:31:52] Maria Makovska: no one is using that transfer workflow anyway
!--So as per Maria only Asignee should get email and not owner/Creator But at the moment Assignee and Owner are getting
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name       | A4User        | AgencyType | Ingest Location |
| SCNUREA1_1 | DefaultA4User | Ingest     |                 |
| SCNUREA1_2 | DefaultA4User | Advertiser | SCNUREA1_1      |
| SCNUREA2_1 | DefaultA4User | Advertiser | SCNUREA1_1      |
And added agency 'SCNUREA2_1' as a partner to agency 'SCNUREA1_2'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| SCNUREU1_1 | agency.admin | SCNUREA1_1   |
| SCNUREU1_2 | agency.admin | SCNUREA1_2   |
| SCNUREU2_1 | agency.admin | SCNUREA2_1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SCNUREA1_2':
| Advertiser | Brand     | Sub Brand | Product  |
| SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 |
And logged in with details of 'SCNUREU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 | SCNUREC2 | SCNURECN2    | 20       | 10/14/2022     | HD 1080i 25fps | SCNURET2 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'SCNURECN2' a New Master with following fields:
| Supply Via | Assignee     | Already Supplied | Message        | Deadline Date |
| nVerge     | SCNUREU2_1_1 | should not       | automated test | 12/14/2022    |
And transfered order contains item with clock number 'SCNURECN2' to user 'SCNUREU2_1' with following message 'autotest transfer message'
And logged in with details of 'SCNUREU2_1'
And complete order contains item with clock number 'SCNURECN2' with following fields:
| Job Number | PO Number |
| SCNUREJN2  | SCNUREPN2 |
And waited for '30' seconds
Then I 'should' see email notification for 'nVerge Upload Request' with field to 'SCNUREU2_1_1' and subject 'SendPlus Upload Request' contains following attributes:
| Agency     | Account Type | UserEmail    | Deadline Date | Clock Number | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | First Air Date | Message        | Destination        |
| SCNUREA2_1 | adstream     | SCNUREU2_1_1 | 12/14/2022    | SCNURECN2    | SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 | SCNURET2 | 20       | 10/14/2022     | automated test | BSkyB Green Button |
And 'should' see email notification for 'nVerge Upload Request' with field to 'SCNUREU2_1' and subject 'SendPlus Upload Request' contains following attributes:
| Agency     | Account Type | UserEmail    | Deadline Date | Clock Number | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | First Air Date | Message        | Destination        |
| SCNUREA2_1 | adstream     | SCNUREU2_1_1 | 12/14/2022    | SCNURECN2    | SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 | SCNURET2 | 20       | 10/14/2022     | automated test | BSkyB Green Button |

Scenario: Check that user who doesn't create order and doesn't confirm order doesn't recieve email about nverge upload in cc even if he has been owner of current
!--11/11 - Actually user - SCNUREU2_1 shouldnt be getting an email.However he gets an email saying SCNUREU2_1 has requested file for upload!!
!--According to Maria --[11:31:43] Maria Makovska: lets leave it as is[11:31:52] Maria Makovska: no one is using that transfer workflow anyway
!--So as per Maria only Asignee should get email and not owner/Creator But at the moment Assignee and Owner are getting
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name       | A4User        | AgencyType | Ingest Location |
| SCNUREA1_1 | DefaultA4User | Ingest     |                 |
| SCNUREA1_2 | DefaultA4User | Advertiser | SCNUREA1_1      |
| SCNUREA3_1 | DefaultA4User | Advertiser | SCNUREA1_1      |
| SCNUREA3_2 | DefaultA4User | Advertiser | SCNUREA1_1      |
And added agency 'SCNUREA3_1' as a partner to agency 'SCNUREA1_2'
And added agency 'SCNUREA3_2' as a partner to agency 'SCNUREA3_1'
And added agency 'SCNUREA3_2' as a partner to agency 'SCNUREA1_2'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| SCNUREU1_1 | agency.admin | SCNUREA1_1   |
| SCNUREU1_2 | agency.admin | SCNUREA1_2   |
| SCNUREU3_1 | agency.admin | SCNUREA3_1   |
| SCNUREU3_2 | agency.admin | SCNUREA3_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SCNUREA1_2':
| Advertiser | Brand     | Sub Brand | Product  |
| SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 |
And logged in with details of 'SCNUREU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 | SCNUREC3 | SCNURECN3    | 20       | 10/14/2022     | HD 1080i 25fps | SCNURET3 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'SCNURECN3' a New Master with following fields:
| Supply Via | Assignee     | Already Supplied | Message        | Deadline Date |
| nVerge     | SCNUREU3_1_1 | should not       | automated test | 12/14/2022    |
And transfered order contains item with clock number 'SCNURECN3' to user 'SCNUREU3_1' with following message 'autotest transfer message 1'
And logged in with details of 'SCNUREU3_1'
And transfered order contains item with clock number 'SCNURECN3' to user 'SCNUREU3_2' with following message 'autotest transfer message 2'
And logged in with details of 'SCNUREU3_2'
And complete order contains item with clock number 'SCNURECN3' with following fields:
| Job Number | PO Number |
| SCNUREJN3  | SCNUREPN3 |
And waited for '30' seconds
Then I 'should' see email notification for 'nVerge Upload Request' with field to 'SCNUREU3_1_1' and subject 'SendPlus Upload Request' contains following attributes:
| Agency     | Account Type | UserEmail    | Deadline Date | Clock Number | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | First Air Date | Message        | Destination        |
| SCNUREA3_2 | adstream     | SCNUREU3_1_1 | 12/14/2022    | SCNURECN3    | SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 | SCNURET3 | 20       | 10/14/2022     | automated test | BSkyB Green Button |
And 'should' see email notification for 'nVerge Upload Request' with field to 'SCNUREU3_2' and subject 'SendPlus Upload Request' contains following attributes:
| Agency     | Account Type | UserEmail    | Deadline Date | Clock Number | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | First Air Date | Message        | Destination        |
| SCNUREA3_2 | adstream     | SCNUREU3_1_1 | 12/14/2022    | SCNURECN3    | SCNUREAR1  | SCNUREBR1 | SCNURESB1 | SCNUREP1 | SCNURET3 | 20       | 10/14/2022     | automated test | BSkyB Green Button |
