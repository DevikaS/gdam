!--ORD-4014
!--ORD-4043
Feature: Email notification translations to Spanish
Narrative:
In order to:
As a AgencyAdmin
I want to check email notification translations to Spanish

Scenario: Check order confirmation email for user with selected Spanish(Argentina) language
Meta: @ordering
      @orderingemails
      @obug
!--Bug # QAB-955
Given I created the following agency:
| Name   | A4User        |
| ENTSA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique | Language |
| ENTSU1 | agency.admin | ENTSA1       | es-ar    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ENTSA1':
| Advertiser | Brand   | Sub Brand | Product |
| ENTSAR1    | ENTSBR1 | ENTSSB1   | ENTSPR1 |
And logged in with details of 'ENTSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ENTSAR1    | ENTSBR1 | ENTSSB1   | ENTSPR1 | ENTSC1   | ENTSCN1      | 20       | 10/14/2022     | HD 1080i 25fps | ENTST1 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ENTSCN1' with following fields:
| Job Number | PO Number |
| ENTSJN1    | ENTSPN1   |
Then I 'should' see email notifications for 'Order Confirmation' with field to 'ENTSU1' and subject 'de Pedido' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number |
| adstream     | ENTSU1   | ENTSCN1      | ENTSJN1    | ENTSPN1   |

Scenario: Check physical or ftp media transfer order email for user with selected Spanish(Argentina) language
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        |
| ENTSA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique | Language |
| <UserEmail> | agency.admin | ENTSA1       | es-ar    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ENTSA1':
| Advertiser | Brand   | Sub Brand | Product |
| ENTSAR1    | ENTSBR1 | ENTSSB1   | ENTSPR1 |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ENTSAR1    | ENTSBR1 | ENTSSB1   | ENTSPR1 | ENTSC2   | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | ENTST2 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number '<ClockNumber>' a New Master with following fields:
| Supply Via          | Assignee    | Already Supplied | Message        | Deadline Date |
| <UploadRequestType> | <UserEmail> | should not       | automated test | 02/14/2023    |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| ENTSJN2    | ENTSPN2   |
Then I 'should' see email notifications for 'Media Transfer Request' with field to '<UserEmail>' and subject 'Pedido especial de envio' contains following attributes:
| Agency | Account Type | UserEmail   | Deadline Date | Clock Number  | Advertiser | Product | Title  | Duration | Format         | Message        | SupplyVia           |
| ENTSA1 | adstream     | <UserEmail> | 02/14/2023    | <ClockNumber> | ENTSAR1    | ENTSPR1 | ENTST2 | 20       | HD 1080i 25fps | automated test | <UploadRequestType> |

Examples:
| UserEmail | ClockNumber | UploadRequestType |
| ENTSU2_1  | ENTSCN2_1   | FTP               |
| ENTSU2_2  | ENTSCN2_2   | Physical          |

Scenario: Check transferred order email for user with selected Spanish(Argentina) language
!--ORD-4534
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        |
| ENTSA3_1 | DefaultA4User |
| ENTSA3_2 | DefaultA4User |
And added agency 'ENTSA3_2' as a partner to agency 'ENTSA3_1'
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| ENTSU3_1 | agency.admin | ENTSA3_1     | es-ar    |
| ENTSU3_2 | agency.admin | ENTSA3_2     | es-ar    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ENTSA3_1':
| Advertiser | Brand   | Sub Brand | Product |
| ENTSAR3    | ENTSBR3 | ENTSSB3   | ENTSPR3 |
And logged in with details of 'ENTSU3_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | ENTSAR3    | ENTSBR3 | ENTSSB3   | ENTSPR3 | ENTSC3   | ENTSCN3      | 20       | 10/14/2022     | HD 1080i 25fps | ENTST3 | Already Supplied   |
And transfered order contains item with clock number 'ENTSCN3' to user 'ENTSU3_2' with following message 'autotest transfer message'
Then I 'should' see email notification for 'Transfer Order' with field to 'ENTSU3_2' and subject 'Se le ha transferido un Pedido' contains following attributes:
| Agency   | Account Type | UserEmail | Clock Number | Message                   |
| ENTSA3_1 | adstream     | ENTSU3_1  | ENTSCN3      | autotest transfer message |

Scenario: Check delivery order confimation report for user with selected Spanish(Argentina) language
!--ORD-4535
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ENTSA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique | Language |
| ENTSU1 | agency.admin | ENTSA1       | es-ar    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ENTSA1':
| Advertiser | Brand   | Sub Brand | Product |
| ENTSAR1    | ENTSBR1 | ENTSSB1   | ENTSPR1 |
And logged in with details of 'ENTSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ENTSAR1    | ENTSBR1 | ENTSSB1   | ENTSPR1 | ENTSC4   | ENTSCN4      | 20       | 10/14/2022     | HD 1080i 25fps | ENTST4 | Already Supplied   | BSkyB Green Button:Standard |
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand   | Sub Brand | Product | Title  | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| ENTSCN4      |            |           | 1                 | 1                 | United Kingdom | ENTSAR1    | ENTSBR1 | ENTSSB1   | ENTSPR1 | ENTST4 | 20       | HD 1080i 25fps |                 |               | 10/14/2022     | No      | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |