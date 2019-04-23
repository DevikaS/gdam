!--ORD-3678
!--ORD-3760
Feature: Popup with draft order summary to be Beam style
Narrative:
In order to:
As a AgencyAdmin
I want to check popup with draft order summary to be Beam style

Scenario: Check showing draft order report in Beam style
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Labels |
| DOSRBSA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| DOSRBSU1 | agency.admin | DOSRBSA1     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DOSRBSA1':
| Advertiser | Brand     | Sub Brand | Product   |
| DOSRBSAR1  | DOSRBSBR1 | DOSRBSSB1 | DOSRBSPR1 |
And logged in with details of 'DOSRBSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination      |
| automated test info    | DOSRBSAR1  | DOSRBSBR1 | DOSRBSSB1 | DOSRBSPR1 | DOSRBSC1 | DOSRBSCN1    | 20       | 10/14/2022     | HD 1080i 25fps | DOSRBST1 | Already Supplied   | Zee TV:Standard |
And add for 'tv' order to item with clock number 'DOSRBSCN1' a New Master with following fields:
| Supply Via | Assignee | Post House | Already Supplied | Message        | Deadline Date | Arrival Time |
| FTP        | DOSRBSU2 | DOSRBSU1   | should not       | automated test | 12/14/2024    | 20:00        |
And hold for approval 'tv' order items with following clock numbers 'DOSRBSCN1'
And upload to 'tv' order item with clock number 'DOSRBSCN1' following documents:
| Document          |
| /files/file_2.txt |
When I open order item with following clock number 'DOSRBSCN1'
And fill for destination 'Zee TV' following additional instruction 'auto test additional instruction' on Select Broadcast Destinations form
And click Proceed button on order item page
Then I should see following data for order items on View 'Beam' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product   | Title    | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points |  Destination | Service Level | Additional Instruction           |
| DOSRBSCN1    |            |           | 1                 | 1                 | United Kingdom | DOSRBSAR1  | DOSRBSBR1 | DOSRBSSB1 | DOSRBSPR1 | DOSRBST1 | 20       | HD 1080i 25fps | FTP             | 12/14/2024    | 20:00        | DOSRBSU1       | 10/14/2022     | No      | automated test info | file_2.txt  | Already Supplied   | 1               |  Zee TV         | Standard      | auto test additional instruction |

Scenario: Check showing draft order report in Beam style in case order has additional services
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Labels |
| DOSRBSA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| DOSRBSU1 | agency.admin | DOSRBSA1     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DOSRBSA1':
| Advertiser | Brand     | Sub Brand | Product   |
| DOSRBSAR1  | DOSRBSBR1 | DOSRBSSB1 | DOSRBSPR1 |
And logged in with details of 'DOSRBSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                  |
| automated test info    | DOSRBSAR1  | DOSRBSBR1 | DOSRBSSB1 | DOSRBSPR1 | DOSRBSC2 | DOSRBSCN2    | 20       | 10/14/2022     | HD 1080i 25fps | DOSRBST2 | BTI Studios        | Aastha:Standard  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City     | Post Code | Country  |
| Physical | DOSRBSDN2        | DOSRBSCnN2   | DOSRBSCD2       | DOSRBSSA2      | DOSRBSC2 | DOSRBSPC2 | DOSRBSC2 |
And create for 'tv' order with item clock number 'DOSRBSCN2' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                     | Notes & Labels        | Express |
| Data DVD | DOSRBSDN2   | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | DOSRBSDN2 DOSRBSCnN2 DOSRBSCD2 DOSRBSSA2 DOSRBSC2 DOSRBSPC2 DOSRBSC2 | automated test notes  | should  |
Then I should see following data for order items on View 'Beam' Delivery Report page:
| Logo | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product   | Title    | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level | Additional Service Type | Additional Service Destination | Notes & Labels       | Additional Service Format | No copies | Media Compile | Additional Service Level |
| BEAM | DOSRBSCN2    |            |           | 1                 | 1                 | United Kingdom | DOSRBSAR1  | DOSRBSBR1 | DOSRBSSB1 | DOSRBSPR1 | DOSRBST2 | 20       | HD 1080i 25fps |                 |               |              |                | 10/14/2022     | No      | automated test info |             | BTI Studios        | 3               | ZMTV              | Aastha             | Standard      | Data DVD                | DOSRBSDN2                      | automated test notes | Avid DNxHD                | 2         | Compile 2     | Express                  |