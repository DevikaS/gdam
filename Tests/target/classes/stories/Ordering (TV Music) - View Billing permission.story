!--ORD-2104
!--ORD-2350
!--ORD-4443
Feature: View billing permission
Narrative:
In order to:
As a AgencyAdmin
I want to check view billing permission

Scenario: Check tv view billing permission
Meta: @ordering
Given I created the following agency:
| Name  | A4User        | Country        | SAP ID       |
| VBPA1 | DefaultA4User | United Kingdom | DefaultSapID |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'VBPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | VBPA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'VBPA1':
| Advertiser | Brand  | Sub Brand | Product |
| VBPAR1     | VBPBR1 | VBPSB1    | VBPPR1  |
And logged in with details of '<Email>'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title | Destination                 |
| automated test info    | VBPAR1     | VBPBR1 | VBPSB1    | VBPPR1  | VBPC1    | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | VBPT1 | BSkyB Green Button:Standard |
When I go to Order Proceed page for order contains order item with following clock number '<ClockNumber>'
Then I '<ShouldState>' see Billing information on Order Proceed page

Examples:
| Email   | Role    | Permissions                                                                                          | ClockNumber | ShouldState |
| VBPU1_1 | VBPR1_1 | tv_order.write,tv_order.read,tv_order.delete,tv_order.create,tv_order.complete,tv_order.view_billing | VBPCN1_1    | should      |
| VBPU1_2 | VBPR1_2 | tv_order.write,tv_order.read,tv_order.delete,tv_order.create,tv_order.complete                       | VBPCN1_2    | should not  |

Scenario: Check music view billing permission
Meta: @ordering
Given I created the following agency:
| Name  | A4User        | Country        | SAP ID       |
| VBPA1 | DefaultA4User | United Kingdom | DefaultSapID |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'VBPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | VBPA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'VBPA1':
| Advertiser | Brand  | Sub Brand | Product |
| VBPAR1     | VBPBR1 | VBPSB1    | VBPPR1  |
And logged in with details of '<Email>'
And 'enable' Billing Service
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Artist | ISRC Code  | Release Date | Format         | Title | Destination                 |
| automated test info    | VBPAR1     | VBPBR1 | VBPSB1    | VBPPR1  | VBPC2  | <ISRCCode> | 10/14/2022   | HD 1080i 25fps | VBPT2 | BSkyB Green Button:Standard |
When I go to Order Proceed page for order contains order item with following isrc code '<ISRCCode>'
Then I '<ShouldState>' see Billing on Order Proceed page

Examples:
| Email   | Role    | Permissions                                                                                                                              | ISRCCode | ShouldState |
| VBPU2_1 | VBPR2_1 | tv_order_music.write,tv_order_music.read,tv_order_music.delete,tv_order_music.create,tv_order_music.complete,tv_order_music.view_billing | VBPCN2_1 | should      |
| VBPU2_2 | VBPR2_2 | tv_order_music.write,tv_order_music.read,tv_order_music.delete,tv_order_music.create,tv_order_music.complete                             | VBPCN2_2 | should not  |

Scenario: Check View Billing button visibility depends on tv_order.view_billing permission
!--ORD-4443
Meta: @ordering
Given I created the following agency:
| Name  | A4User        | Country        | SAP ID       |
| VBPA1 | DefaultA4User | United Kingdom | DefaultSapID |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'VBPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | VBPA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'VBPA1':
| Advertiser | Brand  | Sub Brand | Product |
| VBPAR1     | VBPBR1 | VBPSB1    | VBPPR1  |
And logged in with details of '<Email>'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | VBPAR1     | VBPBR1 | VBPSB1    | VBPPR1  | VBPC3    | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | VBPT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| VBPJN3     | VBPPN3    |
When I go to Order Summary page for order contains item with following clock number '<ClockNumber>'
Then I '<ShouldState>' see 'View Billing' button on order summary page

Examples:
| Email   | Role    | Permissions                                                                                          | ClockNumber | ShouldState |
| VBPU3_1 | VBPR3_1 | tv_order.write,tv_order.read,tv_order.delete,tv_order.create,tv_order.complete,tv_order.view_billing | VBPCN3_1    | should      |
| VBPU3_2 | VBPR3_2 | tv_order.write,tv_order.read,tv_order.delete,tv_order.create,tv_order.complete                       | VBPCN3_2    | should not  |