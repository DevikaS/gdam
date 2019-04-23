!--ORD-2164
!--ORD-2267
Feature: Add media mandatory permission
Narrative:
In order to:
As a AgencyAdmin
I want to check add media mandatory permission

Scenario: Check that tv_order.add_media_mandatory permission correctly works
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AMMPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'AMMPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | AMMPA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AMMPA1':
| Advertiser | Brand   | Sub Brand | Product |
| AMMPAR1    | AMMPBR1 | AMMPSB1   | AMMPPR1 |
And logged in with details of '<Email>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Destination                 |
| automated test info    | AMMPAR1    | AMMPBR1 | AMMPSB1   | AMMPPR1 | AMMPC1   | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | AMMPT1 | BSkyB Green Button:Standard |
When I open order item with following clock number '<ClockNumber>'
Then I should see '<State>' Proceed button on order item page

Examples:
| Email    | Role     | Permissions                                                                                                 | State   | ClockNumber |
| AMMPU1_1 | AMMPR1_1 | tv_order.write,tv_order.read,tv_order.delete,tv_order.create,tv_order.complete,tv_order.add_media_mandatory | enabled | AMMPCN1_1   |
| AMMPU1_2 | AMMPR1_2 | tv_order.write,tv_order.read,tv_order.delete,tv_order.create,tv_order.complete                              | enabled | AMMPCN1_2   |

Scenario: Check that tv_order_music.add_media_mandatory permission correctly works
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| AMMPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'AMMPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | AMMPA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AMMPA1':
| Advertiser | Brand   | Sub Brand | Product |
| AMMPAR1    | AMMPBR1 | AMMPSB1   | AMMPPR1 |
And logged in with details of '<Email>'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Artist | ISRC Code  | Release Date | Format         | Title  | Destination                 |
| automated test info    | AMMPAR1    | AMMPBR1 | AMMPSB1   | AMMPPR1 | AMMPC2 | <ISRCCode> | 08/14/2022   | HD 1080i 25fps | AMMPT2 | BSkyB Green Button:Standard |
When I open order item with following isrc code '<ISRCCode>'
Then I should see '<State>' Proceed button on order item page

Examples:
| Email   | Role     | Permissions                                                                                                                                     | State   | ISRCCode  |
| AMMP2_1 | AMMPR2_1 | tv_order_music.write,tv_order_music.read,tv_order_music.delete,tv_order_music.create,tv_order_music.complete,tv_order_music.add_media_mandatory | enabled | AMMPCN2_1 |
| AMMP2_2 | AMMPR2_2 | tv_order_music.write,tv_order_music.read,tv_order_music.delete,tv_order_music.create,tv_order_music.complete                                    | enabled | AMMPCN2_2 |