!--ORD-3677
!--ORD-3780
Feature: Changing to the subtitling emails
Narrative:
In order to:
As a AgencyAdmin
I want to check changing to the subtitling emails

Scenario: check subtitles required email notification for Beam agency
Meta: @ordering
      @obug
      @orderingemails
!--FAB-479 both examples will fail
Given I created the following agency:
| Name   | A4User        | Labels |
| CTSEA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email       | Role         | AgencyUnique | Language |
| <UserEmail> | agency.admin | CTSEA1       | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CTSEA1':
| Advertiser | Brand   | Sub Brand | Product |
| CTSEAR1    | CTSEBR1 | CTSESB1   | CTSEPR1 |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required  | Destination                 |
| automated test info 1  | CTSEAR1    | CTSEBR1 | CTSESB1   | CTSEPR1 | CTSEC1   | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | CTSET1 | <SubtitlesRequired> | BSkyB Green Button:Standard |
And upload to 'tv' order item with clock number '<ClockNumber>' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| CTSEJN1    | CTSEPN1   |
Then I 'should' see email notification for 'Subtitles Required' with field to '<UserEmail>' and subject '<ClockNumber>' contains following attributes:
| Agency | Clock Number  | Advertiser | Product | Title  | Subtitles Required  | Service Level | Message             |
| CTSEA1 | <ClockNumber> | CTSEAR1    | CTSEPR1 | CTSET1 | <SubtitlesRequired> | Standard      | automated test info |

Examples:
| UserEmail | ClockNumber | SubtitlesRequired |
| CTSEU1_1  | CTSECN1_1   | Adtext            |
| CTSEU1_2  | CTSECN1_2   | BTI Studios       |

Scenario: check subtitles required email notification for Beam agency when order has 2 order items with the same Subtitles Required
!--ORD-3909
Meta: @ordering
      @obug
      @orderingemails
!--FAB-479 both examples will fail
Given I created the following agency:
| Name   | A4User        | Labels |
| CTSEA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email       | Role         | AgencyUnique | Language |
| <UserEmail> | agency.admin | CTSEA1       | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CTSEA1':
| Advertiser | Brand   | Sub Brand | Product |
| CTSEAR1    | CTSEBR1 | CTSESB1   | CTSEPR1 |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number     | Duration | First Air Date | Format         | Title    | Subtitles Required  | Destination                  |
| automated test info 1  | CTSEAR1    | CTSEBR1 | CTSESB1   | CTSEPR1 | CTSEC2_1 | <ClockNumberOne> | 20       | 08/14/2022     | HD 1080i 25fps | CTSET2_1 | <SubtitlesRequired> | BSkyB Green Button:Standard  |
| automated test info 2  | CTSEAR1    | CTSEBR1 | CTSESB1   | CTSEPR1 | CTSEC2_2 | <clockNumberTwo> | 15       | 08/14/2024     | SD PAL 16x9    | CTSET2_2 | <SubtitlesRequired> | Overseas Property TV:Express |
And upload to 'tv' order item with clock number '<ClockNumberOne>' following documents:
| Document          |
| /files/file_2.txt |
And upload to 'tv' order item with clock number '<clockNumberTwo>' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number '<ClockNumberOne>' with following fields:
| Job Number | PO Number |
| CTSEJN2    | CTSEPN2   |
Then I 'should' see email notification for 'Subtitles Required' with field to '<UserEmail>' and subject '<Subject>' contains following attributes:
| Agency | Clock Number     | Advertiser | Product | Title    | Subtitles Required  | Service Level | Message               |
| CTSEA1 | <ClockNumberOne> | CTSEAR1    | CTSEPR1 | CTSET2_1 | <SubtitlesRequired> | Express       | automated test info 1 |
And 'should' see email notification for 'Subtitles Required' with field to '<UserEmail>' and subject '<Subject>' contains following attributes:
| Agency | Clock Number     | Advertiser | Product | Title    | Subtitles Required  | Service Level | Message               |
| CTSEA1 | <clockNumberTwo> | CTSEAR1    | CTSEPR1 | CTSET2_2 | <SubtitlesRequired> | Express       | automated test info 2 |

Examples:
| UserEmail | ClockNumberOne | clockNumberTwo | SubtitlesRequired | Subject                 |
| CTSEU2_1  | CTSECN2_1_1    | CTSECN2_1_2    | Adtext            | CTSECN2_1_1,CTSECN2_1_2 |
| CTSEU2_2  | CTSECN2_2_1    | CTSECN2_2_2    | BTI Studios       | CTSECN2_2_1,CTSECN2_2_2 |