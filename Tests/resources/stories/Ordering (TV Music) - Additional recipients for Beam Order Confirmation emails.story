!--ORD-2962
!--ORD-3024
Feature: Additional recipients for Beam Order Confirmation emails
Narrative:
In order to:
As a AgencyAdmin
I want to check additional recipients for Beam Order Confirmation emails

Scenario: check additional recipients after confirming Beam order
Meta: @ordering
      @orderingemails
!--Bug logged for UK/ROI market NGN-19458
Given I created the following agency:
| Name     | A4User        | Labels |
| ARBOCEA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email       | Role         | AgencyUnique | Language |
| <UserEmail> | agency.admin | ARBOCEA1     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ARBOCEA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARBOCEAR1  | ARBOCEBR1 | ARBOCESB1 | ARBOCEPR1 |
And logged in with details of '<UserEmail>'
And create 'tv' order with market '<Market>' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    | Subtitles Required  |  Destination   |
| automated test info    | ARBOCEAR1  | ARBOCEBR1 | ARBOCESB1 | ARBOCEPR1 | ARBOCEC1 | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | ARBOCET1 | <SubtitlesRequired> | <Destination> |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number  | PO Number  | Adbank     |
| <JobNumber> | <PONumber> | should not |
Then I 'should' see email notification for 'Order Confirmation' with field to '<UserEmail>' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName    | Clock Number  | Job Number  | PO Number  | Order Items Count | Commercial Number | Country  | Spot Code     | Advertiser | Brand     | Sub Brand | Product   | Title    | Duration | Format         | First Air Date | Archive | Note                | Subtitles Required  | Destination Group | Destination | Service Level |
| beam         | <UserEmail> | <ClockNumber> | <JobNumber> | <PONumber> | 1                 | 1                 | <Market> | <ClockNumber> | ARBOCEAR1  | ARBOCEBR1 | ARBOCESB1 | ARBOCEPR1 | ARBOCET1 | 20       | HD 1080i 25fps | 10/14/2022     | No      | automated test info | <SubtitlesRequired> | <Group>           | <Station>   | Standard      |
And 'should' see email notification for 'Order Confirmation' with field to '<EmailCC>' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName    | Clock Number  | Job Number  | PO Number  | Order Items Count | Commercial Number | Country  | Spot Code     | Advertiser | Brand     | Sub Brand | Product   | Title    | Duration | Format         | First Air Date | Archive | Note                | Subtitles Required  | Destination Group | Destination | Service Level |
| beam         | <UserEmail> | <ClockNumber> | <JobNumber> | <PONumber> | 1                 | 1                 | <Market> | <ClockNumber> | ARBOCEAR1  | ARBOCEBR1 | ARBOCESB1 | ARBOCEPR1 | ARBOCET1 | 20       | HD 1080i 25fps | 10/14/2022     | No      | automated test info | <SubtitlesRequired> | <Group>           | <Station>   | Standard      |

Examples:
| UserEmail  | Market              | ClockNumber | SubtitlesRequired | Destination                         | Group                     | Station                    | JobNumber   | PONumber    | EmailCC               |
| ARBOCEU1_1 | United Kingdom      | ARBOCECN1_1 | Adtext SD         | BSkyB Green Button:Standard         | BSkyB                     | BSkyB Green Button         | ARBOCEJN1_1 | ARBOCEPN1_1 | transmission@beam.tv  |
| ARBOCEU1_2 | Republic of Ireland | ARBOCECN1_2 | BTI Studios       | Universal Ireland:Standard          | BSkyB Republic of Ireland | Universal Ireland          | ARBOCEJN1_2 | ARBOCEPN1_2 | transmission@beam.tv  |
| ARBOCEU1_4 | Belgium             | ARBOCECN1_4 |                   | Discovery Networks Benelux:Standard | Belgium                   | Discovery Networks Benelux | ARBOCEJN1_4 | ARBOCEPN1_4 | International@beam.tv |
| ARBOCEU1_3 | UK & ROI            | ARBOCECN1_3 | Adtext HD         | BSkyB Green Button:Standard         | BSkyB                     | BSkyB Green Button         | ARBOCEJN1_3 | ARBOCEPN1_3 | transmission@beam.tv  |
