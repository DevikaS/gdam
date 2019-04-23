!--ORD-4744
!--ORD-4934
Feature: Change Upload Request email to look more like in A4
Narrative:
In order to:
As a AgencyAdmin
I want to check that changed Upload Request email is looking more like in A4

Scenario: Check that changed media transfer request email is sent for BU with nordic label for new master FTP
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        | Labels |
| CUREA1 | DefaultA4User | nordic |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | CUREA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CUREA1':
| Advertiser | Brand   | Sub Brand | Product |
| CUREAR1    | CUREBR1 | CURESB1   | CUREP1  |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                              |
| automated test info    | CUREAR1    | CUREBR1 | CURESB1   | CUREP1  | CUREC1   | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | CURET1 | Adtext             | BSkyB Green Button:Standard;Overseas Property TV:Express |
And add for 'tv' order to item with clock number '<ClockNumber>' a New Master with following fields:
| Supply Via          | Assignee    | Already Supplied | Message        | Deadline Date |
| <UploadRequestType> | <UserEmail> | should not       | automated test | 02/14/2023    |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| CUREJN1    | CUREPN1   |
Then I 'should' see email notification for 'Adstream Upload Request for' with field to '<UserEmail>' and subject 'Adstream Upload Request for' contains following attributes:
| Agency | Account Type | UserEmail   | Deadline Date | Clock Number  | Advertiser | Product | Title  | Duration | Format      | Message        | First Air Date | Destinations                            |
| CUREA1 | nordic       | <UserEmail> | 02/14/2023    | <ClockNumber> | CUREAR1    | CUREP1  | CURET1 | 20       | SD PAL 16x9 | automated test | 12/14/2022     | BSkyB Green Button,Overseas Property TV |

Examples:
| UserEmail | ClockNumber | UploadRequestType |
| CUREU1_1  | CURECN1_1   | FTP               |


Scenario: Check that changed media transfer request email is sent for BU with nordic label for new master Physical
!--NGN-17004, FAB-726
Meta: @ordering
      @obug
      @orderingemails
Given I created the following agency:
| Name   | A4User        | Labels |
| CUREA6 | DefaultA4User | nordic |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | CUREA6     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CUREA6':
| Advertiser | Brand   | Sub Brand | Product |
| CUREAR1    | CUREBR1 | CURESB1   | CUREP1  |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                              |
| automated test info    | CUREAR1    | CUREBR1 | CURESB1   | CUREP1  | CUREC6   | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | CURET6| Adtext             | BSkyB Green Button:Standard;Overseas Property TV:Express |
And add for 'tv' order to item with clock number '<ClockNumber>' a New Master with following fields:
| Supply Via          | Assignee    | Already Supplied | Message        | Deadline Date |
| <UploadRequestType> | <UserEmail> | should not       | automated test | 12/14/2024    |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| CUREJN6    | CUREPN6   |
Then I 'should' see email notification for 'Adstream Upload Request for' with field to '<UserEmail>' and subject 'Adstream Upload Request for' contains following attributes:
| Agency | Account Type | UserEmail   | Deadline Date | Clock Number  | Advertiser | Product | Title  | Duration | Format      | Message        | First Air Date | Destinations                            |
| CUREA6 | nordic       | <UserEmail> | 12/14/2024    | <ClockNumber> | CUREAR1    | CUREP1  | CURET6 | 20       | SD PAL 16x9 | automated test | 12/14/2022     | BSkyB Green Button,Overseas Property TV |

Examples:
| UserEmail | ClockNumber | UploadRequestType |
| CUREU1_2  | CURECN1_2   | Physical          |



Scenario: Check that changed upload request email is sent in case QC & Ingest Only
!--ORD-4933
!--FAB-394 logged due to incorrect subject
Meta: @ordering
      @orderingemails
      @obug
Given I created the following agency:
| Name   | A4User        | Labels |
| CUREA1 | DefaultA4User | nordic |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| CUREU2 | agency.admin | CUREA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CUREA1':
| Advertiser | Brand   | Sub Brand | Product |
| CUREAR1    | CUREBR1 | CURESB1   | CUREP1  |
And logged in with details of 'CUREU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | CUREAR1    | CUREBR1 | CURESB1   | CUREP1  | CUREC2   | CURECN2      | 20       | 12/14/2022     | HD 1080i 25fps | CURET2 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'CURECN2' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | CUREU2   | should not       | automated test | 12/14/2024    |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'CURECN2'
And complete order contains item with clock number 'CURECN2' with following fields:
| Job Number | PO Number |
| CUREJN2    | CUREPN2   |
Then I 'should' see email notification for 'Adstream Upload Request for' with field to 'CUREU2' and subject 'Adstream Upload Request for' contains following attributes:
| Agency | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product | Title  | Duration | Format         | Message        | First Air Date |
| CUREA1 | nordic       | CUREU2    | 12/14/2024    | CURECN2      | CUREAR1    | CUREP1  | CURET2 | 20       | HD 1080i 25fps | automated test | 12/14/2022     |

Scenario: Check that changed upload request email is sent in case Assign order from Live tab
!--ORD-5135
!--ORD-5442
!--FAB-319
Meta: @ordering
      @obug
      @orderingemails
Given I created the following agency:
| Name   | A4User        | Labels |
| CUREA1 | DefaultA4User | nordic |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| CUREU3 | agency.admin | CUREA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CUREA1':
| Advertiser | Brand   | Sub Brand | Product |
| CUREAR1    | CUREBR1 | CURESB1   | CUREP1  |
And logged in with details of 'CUREU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                              |
| automated test info    | CUREAR1    | CUREBR1 | CURESB1   | CUREP1  | CUREC3   | CURECN3      | 20       | 12/14/2022     | HD 1080i 25fps | CURET3 | Adtext             | BSkyB Green Button:Standard;Overseas Property TV:Express |
And complete order contains item with clock number 'CURECN3' with following fields:
| Job Number | PO Number |
| CUREJN3    | CUREPN3   |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'CURECN3' in 'live' order list
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee | Message        |
| CUREU3   | automated test |
And send order to supply media by someone on ordering page
Then I 'should' see email notification for 'Media Transfer Request' with field to 'CUREU3' and subject 'Media Transfer Request' contains following attributes:
| Agency | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product | Title  | Duration | Format      | Message        | First Air Date | Destinations                            |
| CUREA1 | adstream     | CUREU3    | 12/14/2022    | CURECN3      | CUREAR1    | CUREP1  | CURET3 | 20       | SD PAL 16x9 | automated test | 12/14/2022     | BSkyB Green Button,Overseas Property TV |

Scenario: Check that if BU has Beam and Nordic tags only Beam should work
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        | Labels      |
| CUREA4 | DefaultA4User | Beam,nordic |
And created users with following fields:
| Email  | Role         | AgencyUnique | Language |
| CUREU4 | agency.admin | CUREA4       | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CUREA4':
| Advertiser | Brand   | Sub Brand | Product |
| CUREAR4    | CUREBR4 | CURESB4   | CUREP4  |
And logged in with details of 'CUREU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | CUREAR4    | CUREBR4 | CURESB4   | CUREP4  | CUREC4   | CURECN4      | 20       | 12/14/2022     | HD 1080i 25fps | CURET4 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'CURECN4' a New Master with following fields:
| Supply Via | Post House | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | CUREU4     | CUREU4   | should not       | automated test | 02/14/2023    |
And complete order contains item with clock number 'CURECN4' with following fields:
| Job Number | PO Number |
| CUREJN4    | CUREPN4   |
Then I 'should' see email notification for 'Media Transfer Request' with field to 'CUREU4' and subject 'Media Transfer Request' contains following attributes:
| Agency | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product | Title  | Duration | Format         | Message        |
| CUREA4 | beam         | CUREU4    | 02/14/2023    | CURECN4      | CUREAR4    | CUREP4  | CURET4 | 20       | HD 1080i 25fps | automated test |

Scenario: Check that own list of destinations are displayed per asset's clone in upload request email
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        | Labels |
| CUREA5 | DefaultA4User | nordic |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| CUREU5 | agency.admin | CUREA5       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CUREA5':
| Advertiser | Brand   | Sub Brand | Product |
| CUREAR5    | CUREBR5 | CURESB5   | CUREP5  |
And logged in with details of 'CUREU5'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | CUREAR5    | CUREBR5 | CURESB5   | CUREP5  | CUREC5   | CURECN5_1    | 20       | 10/14/2022     | HD 1080i 25fps | CURET5 | None               | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave   | Destination        |
| CURECN5_2    | CURECL5 | Gol TV HD:Standard |
And add for 'tv' order to item with clock number 'CURECN5_2' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | CUREU5   | should not       | automated test | 02/14/2023    |
And complete order contains item with clock number 'CURECN5_1' with following fields:
| Job Number | PO Number  |
| CUREJN5_1  | CUREPN5_1  |
And add to 'tv' order item with clock number 'CURECN5_2' following qc asset 'CURET5' of collection 'My Assets'
When I open order item with clock number 'CURECN5_1' for order with market 'Spain'
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'CURECN5_1' of QC View summary on Order Proceed page
And fill following fields on Order Proceed page:
| Manage Format Conversions | Job Number | PO Number  |
| should                    | CUREJN5_2  | CUREPN5_2  |
And confirm order on Order Proceed page
Then I 'should' see email notification for 'Adstream Upload Request for' with field to 'CUREU5' and subject 'Adstream Upload Request for' contains following attributes:
| Agency | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product | Title  | Duration | Format         | Message        | First Air Date | Destinations |
| CUREA5 | nordic       | CUREU5    | 02/14/2023    | CURECN5_1    | CUREAR5    | CUREP5  | CURET5 | 20       | HD 1080i 25fps | automated test | 10/14/2022     | Gol TV HD    |