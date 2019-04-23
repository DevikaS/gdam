!--ORD-3060
!--ORD-3085
!--ORD-4292
Feature: Ordering confirmation email notification for Beam agency
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of ordering confirmation email notification for Beam agency


Scenario: Check metadata in Beam order confirm email notification
!--This scenario passed in 5.5.28 bug run without ADR-462 is fixed..so removed bug tag
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| OCENFBA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| OCENFBU1 | agency.admin | OCENFBA1     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OCENFBA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 |
And logged in with details of 'OCENFBU1'
And create 'tv' order with market 'Switzerland' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Suisa    | Language | Destination        |
| automated test info    | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBC2 | OCENFBCN2    | 20       | 12/14/2022     | HD 1080i 25fps | OCENFBT2 | OCENFBS2 | English  | Tele Top:Standard  |
And add for 'tv' order to item with clock number 'OCENFBCN2' a New Master with following fields:
| Supply Via | Assignee | Post House | Already Supplied | Message        | Deadline Date | Arrival Time |
| FTP        | OCENFBU1 | OCENFBU2   | should not       | automated test | 12/14/2024    | 20:00        |
And upload to 'tv' order item with clock number 'OCENFBCN2' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'OCENFBCN2' with following fields:
| Job Number | PO Number |
| OCENFBJN2  | OCENFBPN2 |
Then I 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU1' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country     | Spot Code | Advertiser  | Brand       | Sub Brand   | Product     | Title    | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Suisa    | Language Metadata | Delivery Points | Destination Group | Destination | Service Level |
| beam         | OCENFBU1 | OCENFBCN2    | OCENFBJN2  | OCENFBPN2 | 1                 | 1                 | Switzerland | OCENFBCN2 | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBT2 | 20       | HD 1080i 25fps | FTP             | 12/14/2024    | 20:00        | OCENFBU2       | 12/14/2022     | Yes     | automated test info | file_2.txt  | OCENFBS2 | English           | 1               | Switzerlan        | Tele Top    | Standard      |

Scenario: Check that Beam agency recieves order confirm email notification using Beam template
!--ORD-3272
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| OCENFBA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| OCENFBU1 | agency.admin | OCENFBA1     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OCENFBA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 |
| OCENFBAR1_2 | OCENFBBR1_2 | OCENFBSB1_2 | OCENFBPR1_2 |
And logged in with details of 'OCENFBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                  |
| automated test info 1  | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBC1_1 | OCENFBCN1_1  | 20       | 12/14/2022     | HD 1080i 25fps | OCENFBT1_1 | Adtext             | BSkyB Green Button:Standard  |
| automated test info 2  | OCENFBAR1_2 | OCENFBBR1_2 | OCENFBSB1_2 | OCENFBPR1_2 | OCENFBC1_2 | OCENFBCN1_2  | 15       | 12/14/2020     | SD PAL 16x9    | OCENFBT1_2 | Already Supplied   | Overseas Property TV:Express |
And add for 'tv' order to item with clock number 'OCENFBCN1_1' a New Master with following fields:
| Supply Via | Assignee | Post House | Already Supplied | Message        | Deadline Date | Arrival Time |
| FTP        | OCENFBU1 | OCENFBU1_1 | should not       | automated test | 12/14/2024    | 20:00        |
And add for 'tv' order to item with clock number 'OCENFBCN1_2' a New Master with following fields:
| Supply Via | Assignee | Post House | Already Supplied | Message        | Deadline Date | Arrival Time |
| Physical   | OCENFBU1 | OCENFBU1_2 | should not       | automated test | 12/14/2023    | 15:00        |
And hold for approval 'tv' order items with following clock numbers 'OCENFBCN1_1'
And complete order contains item with clock number 'OCENFBCN1_1' with following fields:
| Job Number | PO Number | Adbank     |
| OCENFBJN1  | OCENFBPN1 | should not |
Then I 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU1' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code   | Advertiser  | Brand       | Sub Brand   | Product     | Title      | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                  | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination         | Service Level |
| beam         | OCENFBU1 | OCENFBCN1_1  | OCENFBJN1  | OCENFBPN1 | 2                 | 1                 | United Kingdom | OCENFBCN1_1 | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBT1_1 | 20       | HD 1080i 25fps | FTP             | 12/14/2024    | 20:00        | OCENFBU1_1     | 12/14/2022     | No      | automated test info 1 |             | Adtext             | 1               | BSkyB             | BSkyB Green Button  | Standard      |
And 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU1' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code   | Advertiser  | Brand       | Sub Brand   | Product     | Title      | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                  | Attachments | Subtitles Required | Delivery Points | Destination Group  | Destination          | Service Level |
| beam         | OCENFBU1 | OCENFBCN1_2  | OCENFBJN1  | OCENFBPN1 | 2                 | 2                 | United Kingdom | OCENFBCN1_2 | OCENFBAR1_2 | OCENFBBR1_2 | OCENFBSB1_2 | OCENFBPR1_2 | OCENFBT1_2 | 15       | SD PAL 16x9    | Tape            | 12/14/2023    | 15:00        | OCENFBU1_2     | 12/14/2020     | No      | automated test info 2 |             | Already Supplied   | 1               | Other Broadcasters | Overseas Property TV | Express       |


Scenario: Check additional instruction and archive in Beam order confirm email notification
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |Save In Library |Allow To Save In Library|
| OCENFBA1 | DefaultA4User | Beam   |should          |should                  |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| OCENFBU1 | agency.admin | OCENFBA1     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OCENFBA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 |
And logged in with details of 'OCENFBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination      |
| automated test info    | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBC3 | OCENFBCN3    | 20       | 12/14/2022     | HD 1080i 25fps | OCENFBT3 | BTI Studios        | ABP News:Standard|
And add for 'tv' order to item with clock number 'OCENFBCN3' a New Master with following fields:
| Supply Via | Assignee | Post House | Already Supplied | Message        | Deadline Date | Arrival Time |
| FTP        | OCENFBU1 | OCENFBU3   | should not       | automated test | 12/14/2024    | 20:00        |
When I open order item with following clock number 'OCENFBCN3'
And fill for destination 'ABP News' following additional instruction 'auto test additional instruction' on Select Broadcast Destinations form
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'OCENFBCN3' of QC View summary on Order Proceed page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OCENFBJN3  | OCENFBPN3 |
And confirm order on Order Proceed page
And wait for '20' seconds
Then I 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU1' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser  | Brand       | Sub Brand   | Product     | Title    | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Subtitles Required | Destination Group|Destination | Service Level | Additional Instruction           |
| beam         | OCENFBU1 | OCENFBCN3    | OCENFBJN3  | OCENFBPN3 | 1                 | 1                 | United Kingdom | OCENFBCN3 | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBT3 | 20       | HD 1080i 25fps | FTP             | 12/14/2024    | 20:00        | OCENFBU3       | 12/14/2022     | Yes     | automated test info |             | BTI Studios        | Exodus           |ABP News    | Standard      | auto test additional instruction |


Scenario: Check that Beam agency recieves order confirm email notification using Beam template in case new advertiser structure
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| OCENFBA4 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| OCENFBU4 | agency.admin | OCENFBA4     | en-beam  |
And created following 'common' custom metadata fields for agency 'OCENFBA4':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCENFBA4' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCENFBU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                  |
| automated test info    | OCENFBCN4    | 20       | 12/14/2022     | HD 1080i 25fps | OCENFBT4 | Adtext SD          | Aastha:Standard  |
When I open order item with following clock number 'OCENFBCN4'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCENFBAR4         | OCENFBBR4    | OCENFBPR4      | OCENFBC4        |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OCENFBJN4  | OCENFBPN4 |
And confirm order on Order Proceed page
Then I 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU4' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser Custom | Brand Custom | Product Custom | Campaign Custom | Title    | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Subtitles Required | Destination Group | Destination        | Service Level |
| beam         | OCENFBU4 | OCENFBCN4    | OCENFBJN4  | OCENFBPN4 | 1                 | 1                 | United Kingdom | OCENFBCN4 | OCENFBAR4         | OCENFBBR4    | OCENFBPR4      | OCENFBC4        | OCENFBT4 | 20       | HD 1080i 25fps |                 |               |              |                | 12/14/2022     | No      | automated test info |             | Adtext             | ZMTV             | Aastha             | Standard      |


Scenario: Check that Beam agency recieves order confirm email notification using Beam template with correct value of Delivery Points
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| OCENFBA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| OCENFBU1 | agency.admin | OCENFBA1     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OCENFBA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 |
And logged in with details of 'OCENFBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                                              |
| automated test info    | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBC5 | OCENFBCN5    | 20       | 12/14/2022     | HD 1080i 25fps | OCENFBT5 | Adtext             | BSkyB Green Button:Standard;Overseas Property TV:Express |
And complete order contains item with clock number 'OCENFBCN5' with following fields:
| Job Number | PO Number |
| OCENFBJN5  | OCENFBPN5 |
Then I 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU1' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser  | Brand       | Sub Brand   | Product     | Title    | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination         | Service Level    |
| beam         | OCENFBU1 | OCENFBCN5    | OCENFBJN5  | OCENFBPN5 | 1                 | 1                 | United Kingdom | OCENFBCN5 | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBT5 | 20       | HD 1080i 25fps |                 |               |              |                |                | Yes     | automated test info |             | Adtext             | 2               | BSkyB             | BSkyB Green Button  | Standard,Express |
And 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU1' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser  | Brand       | Sub Brand   | Product     | Title    | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group  | Destination          | Service Level    |
| beam         | OCENFBU1 | OCENFBCN5    | OCENFBJN5  | OCENFBPN5 | 1                 | 1                 | United Kingdom | OCENFBCN5 | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBT5 | 20       | HD 1080i 25fps |                 |               |              |                |                | Yes     | automated test info |             | Adtext             | 2               | Other Broadcasters | Overseas Property TV | Standard,Express |

Scenario: Check that Beam agency recieves order confirm email notification using Beam template with correct value of Media Compile
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| OCENFBA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| OCENFBU1 | agency.admin | OCENFBA1     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OCENFBA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 |
And logged in with details of 'OCENFBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBC6 | OCENFBCN6    | 20       | 12/14/2022     | HD 1080i 25fps | OCENFBT6 | Adtext             | BSkyB Green Button:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City     | Post Code | Country  |
| Physical | OCENFBDN6        | OCENFBCnN6   | OCENFBCD6       | OCENFBSA6      | OCENFBC6 | OCENFBPC6 | OCENFBC6 |
And create for 'tv' order with item clock number 'OCENFBCN6' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                     | Notes & Labels        | Express |
| Data DVD | OCENFBDN6   | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OCENFBDN6 OCENFBCnN6 OCENFBCD6 OCENFBSA6 OCENFBC6 OCENFBPC6 OCENFBC6 | automated test notes  | should  |
And complete order contains item with clock number 'OCENFBCN6' with following fields:
| Job Number | PO Number |
| OCENFBJN6  | OCENFBPN6 |
Then I 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU1' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser  | Brand       | Sub Brand   | Product     | Title    | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination         | Service Level | Additional Service Type | Additional Service Destination | Notes & Labels       | Additional Service Format | No copies | Media Compile | Additional Service Level |
| beam         | OCENFBU1 | OCENFBCN6    | OCENFBJN6  | OCENFBPN6 | 1                 | 1                 | United Kingdom | OCENFBCN6 | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBT6 | 20       | HD 1080i 25fps |                 |               |              |                |                | Yes     | automated test info |             | Adtext             | 3               | BSkyB             | BSkyB Green Button  | Standard      | Data DVD                | OCENFBDN6                      | automated test notes | Avid DNxHD                | 2         | Compile 2     | Express                  |


Scenario: Check that duplicated attached files aren't sent in confirmation email
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| OCENFBA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| OCENFBU1 | agency.admin | OCENFBA1     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OCENFBA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 |
And logged in with details of 'OCENFBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                  |
| automated test info 1  | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBC7_1 | OCENFBCN7_1  | 20       | 12/14/2022     | HD 1080i 25fps | OCENFBT7_1 | Adtext             | BSkyB Green Button:Standard  |
| automated test info 2  | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBC7_2 | OCENFBCN7_2  | 15       | 12/14/2020     | SD PAL 16x9    | OCENFBT7_2 | Already Supplied   | Overseas Property TV:Express |
And upload to 'tv' order item with clock number 'OCENFBCN7_1' following documents:
| Document          |
| /files/file_2.txt |
And upload to 'tv' order item with clock number 'OCENFBCN7_2' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'OCENFBCN7_1' with following fields:
| Job Number | PO Number |
| OCENFBJN7  | OCENFBPN7 |
Then I 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU1' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code   | Advertiser  | Brand       | Sub Brand   | Product     | Title      | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                  | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination         | Service Level |
| beam         | OCENFBU1 | OCENFBCN7_1  | OCENFBJN7  | OCENFBPN7 | 2                 | 1                 | United Kingdom | OCENFBCN7_1 | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBT7_1 | 20       | HD 1080i 25fps |                 |               |              |                | 12/14/2022     | Yes     | automated test info 1 | file_2.txt  | Adtext             | 1               | BSkyB             | BSkyB Green Button  | Standard      |
And 'should' see email notification for 'Order Confirmation' with field to 'OCENFBU1' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code   | Advertiser  | Brand       | Sub Brand   | Product     | Title      | Duration | Format      | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                  | Attachments | Subtitles Required | Delivery Points | Destination Group  | Destination          | Service Level |
| beam         | OCENFBU1 | OCENFBCN7_2  | OCENFBJN7  | OCENFBPN7 | 2                 | 2                 | United Kingdom | OCENFBCN7_2 | OCENFBAR1_1 | OCENFBBR1_1 | OCENFBSB1_1 | OCENFBPR1_1 | OCENFBT7_2 | 15       | SD PAL 16x9 |                 |               |              |                | 12/14/2020     | Yes     | automated test info 2 |             | Already Supplied   | 1               | Other Broadcasters | Overseas Property TV | Express       |
