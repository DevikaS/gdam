!--ORD-4207
!--ORD-4494
Feature: Popup alert and confirmation window for UK BSKyB destination
Narrative:
In order to:
As a AgencyAdmin
I want to check popup alert and confirmation window for UK BSKyB destination

Scenario: Check BSkyB confirmation popup visibility
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PABDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PABDU1 | agency.admin | PABDA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PABDA1':
| Advertiser | Brand   | Sub Brand | Product |
| PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 |
And logged in with details of 'PABDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 | PABDC1   | PABDCN1      | 20       | 10/14/2022     | HD 1080i 25fps | PABDT1 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number 'PABDCN1'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see BSkyB confirmation popup on order item page

Scenario: Check action with BSkyB confirmation popup
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PABDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PABDU1 | agency.admin | PABDA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PABDA1':
| Advertiser | Brand   | Sub Brand | Product |
| PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 |
And logged in with details of 'PABDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 | PABDC2   | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | PABDT2 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number '<ClockNumber>'
And click active Proceed button on order item page
And '<Action>' BSkyB confirmation popup on order item page
Then I 'should not' see BSkyB confirmation popup on order item page

Examples:
| ClockNumber | Action |
| PABDCN2_1   | cancel |
| PABDCN2_2   | close  |

Scenario: Check confirming BSkyB confirmation popup
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PABDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PABDU1 | agency.admin | PABDA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PABDA1':
| Advertiser | Brand   | Sub Brand | Product |
| PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 |
And logged in with details of 'PABDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 | PABDC3   | PABDCN3      | 20       | 10/14/2022     | HD 1080i 25fps | PABDT3 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number 'PABDCN3'
And click active Proceed button on order item page
And 'confirm' reading BSkyB confirmation popup on order item page
And 'accept' BSkyB confirmation popup on order item page
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| PABDJN3    | PABDPN3   |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'PABDCN3' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit# | CurrentTime | PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 | United Kingdom | PABDPN3   | PABDJN3 | 1        | 0/1 Delivered |

Scenario: Check saving data in the local storage after confirming BSkyB confirmation popup
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PABDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PABDU4 | agency.admin | PABDA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PABDA1':
| Advertiser | Brand   | Sub Brand | Product |
| PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 |
And logged in with details of 'PABDU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 | PABDC4_1 | PABDCN4_1    | 20       | 10/14/2022     | HD 1080i 25fps | PABDT4_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | PABDAR1    | PABDBR1 | PABDSB1   | PABDPR1 | PABDC4_2 | PABDCN4_2    | 20       | 10/14/2022     | HD 1080i 25fps | PABDT4_2 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number 'PABDCN4_1'
And click active Proceed button on order item page
And 'confirm' reading BSkyB confirmation popup on order item page
And 'accept' BSkyB confirmation popup on order item page
And save as draft order
And open order item with following clock number 'PABDCN4_2'
And click Proceed button on order item page
Then I 'should' see Order Proceed page