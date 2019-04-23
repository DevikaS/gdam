!--ORD-4829
!--ORD-5103
Feature: Global Admin can configure Reminders on the material deadline date
Narrative:
In order to:
As a AgencyAdmin
I want to check that Global Admin can configure Reminders on the material deadline date

Scenario: Check that reminders are sent only if value of Media upload reminder is specified for BU with 'nordic' label for case deadline date is expired
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        | Labels | Reminder For Expired |
| GACCRA1 | DefaultA4User | nordic | should               |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GACCRU1 | agency.admin | GACCRA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GACCRA1':
| Advertiser | Brand    | Sub Brand | Product |
| GACCRAR1   | GACCRBR1 | GACCRSB1  | GACCRP1 |
And logged in with details of 'GACCRU1'
And I am on my Notifications Settings page
And set notification 'Order Media Ftp Upload Reminder' into state 'on' for current user
And saved current user notifications setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | GACCRAR1   | GACCRBR1 | GACCRSB1  | GACCRP1 | GACCRC1  | GACCRCN1     | 20       | 11/14/2020     | HD 1080i 25fps | GACCRT1 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'GACCRCN1' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | GACCRU1  | should not       | automated test | Yesterday     |
And complete order contains item with clock number 'GACCRCN1' with following fields:
| Job Number | PO Number |
| GACCRJN1   | GACCRPN1  |
Then I 'should' see email notification for 'Reminder of Media Upload Request' with field to 'GACCRU1' and subject 'Reminder of Media Upload Request' contains following attributes:
| Agency  | Account Type | Reminder Of Media Upload Request Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product | Title   | Duration | Format         | Message        | First Air Date | Destinations       |
| GACCRA1 | nordic       | After Deadline Date                   | GACCRU1   | 12/14/2014    | GACCRCN1     | GACCRAR1   | GACCRP1 | GACCRT1 | 20       | HD 1080i 25fps | automated test | 11/14/2020     | BSkyB Green Button |

Scenario: Check that correct reminder is sent [] days before material upload deadline to media supplier
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        | Labels | Reminder Days |
| GACCRA2 | DefaultA4User | nordic | 2             |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GACCRU2 | agency.admin | GACCRA2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GACCRA2':
| Advertiser | Brand    | Sub Brand | Product |
| GACCRAR2   | GACCRBR2 | GACCRSB2  | GACCRP2 |
And logged in with details of 'GACCRU2'
And I am on my Notifications Settings page
And set notification 'Order Media Ftp Upload Reminder' into state 'on' for current user
And saved current user notifications setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | GACCRAR2   | GACCRBR2 | GACCRSB2  | GACCRP2 | GACCRC2  | GACCRCN2     | 20       | 11/14/2020     | HD 1080i 25fps | GACCRT2 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'GACCRCN2' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | GACCRU2  | should not       | automated test | Tomorrow      |
And complete order contains item with clock number 'GACCRCN2' with following fields:
| Job Number | PO Number |
| GACCRJN2   | GACCRPN2  |
Then I 'should' see email notification for 'Reminder of Media Upload Request' with field to 'GACCRU2' and subject 'Reminder of Media Upload Request' contains following attributes:
| Agency  | Account Type | Reminder Of Media Upload Request Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product | Title   | Duration | Format         | Message        | First Air Date | Destinations       |
| GACCRA2 | nordic       | Before Deadline Date                  | GACCRU2   | 12/14/2024    | GACCRCN2     | GACCRAR2   | GACCRP2 | GACCRT2 | 20       | HD 1080i 25fps | automated test | 11/14/2020     | BSkyB Green Button |

Scenario: Check that reminder is sent at the date of material upload deadline to media supplier
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        | Labels | Reminder On Deadline |
| GACCRA3 | DefaultA4User | nordic | should               |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GACCRU3 | agency.admin | GACCRA3      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GACCRA3':
| Advertiser | Brand    | Sub Brand | Product |
| GACCRAR3   | GACCRBR3 | GACCRSB3  | GACCRP3 |
And logged in with details of 'GACCRU3'
And I am on my Notifications Settings page
And set notification 'Order Media Ftp Upload Reminder' into state 'on' for current user
And saved current user notifications setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | GACCRAR3   | GACCRBR3 | GACCRSB3  | GACCRP3 | GACCRC3  | GACCRCN3     | 20       | 11/14/2020     | HD 1080i 25fps | GACCRT3 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'GACCRCN3' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | GACCRU3  | should not       | automated test | Today         |
And complete order contains item with clock number 'GACCRCN3' with following fields:
| Job Number | PO Number |
| GACCRJN3   | GACCRPN3  |
Then I 'should' see email notification for 'Reminder of Media Upload Request' with field to 'GACCRU3' and subject 'Reminder of Media Upload Request' contains following attributes:
| Agency  | Account Type | Reminder Of Media Upload Request Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product | Title   | Duration | Format         | Message        | First Air Date | Destinations       |
| GACCRA3 | nordic       | On Deadline Date                      | GACCRU3   | 12/14/2024    | GACCRCN3     | GACCRAR3   | GACCRP3 | GACCRT3 | 20       | HD 1080i 25fps | automated test | 11/14/2020     | BSkyB Green Button |