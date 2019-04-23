!--ORD-3278
!--ORD-3567
Feature: Default notifications in Settings
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of bookmarks

Scenario: check saving ticking checkboxes Always notify when passed QC and Always notify when delivered in the Delivery Settings
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| DNSA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DNSU1 | agency.admin | DNSA1        |
And logged in with details of 'DNSU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Notify When Passed QC | Always Notify When Delivered |
| should                       | should                       |
And save own Delivery Setting
And refresh the page without delay
Then I should see following data for Delivery Setting form on user delivery setting page:
| Always Notify When Passed QC | Always Notify When Delivered |
| should                       | should                       |

Scenario: check saving ticking checkboxes Notify About Delivery and Notify About Passed QC on the Order Summary page
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| DNSA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DNSU1 | agency.admin | DNSA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DNSA1':
| Advertiser | Brand  | Sub Brand | Product |
| DNSAR2     | DNSBR2 | DNSSB2    | DNSPR2  |
And logged in with details of 'DNSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | DNSAR2     | DNSBR2 | DNSSB2    | DNSPR2  | DNSC2    | DNSCN2       | 20       | 10/14/2022     | HD 1080i 25fps | DNST2 | Already Supplied   | BSkyB Green Button:Standard |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Notify When Passed QC | Always Notify When Delivered |
| should                       | should                       |
And save own Delivery Setting
And go to Order Proceed page for order contains order item with following clock number 'DNSCN2'
Then I should see following data for order on Order Proceed page:
| Notify About Delivery | Notify About Passed QC |
| should                | should                 |

Scenario: check saving ticking checkboxes Notify About Delivery and Notify About Passed QC on the Order Summary page for music
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| DNSA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DNSU1 | agency.admin | DNSA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DNSA1':
| Advertiser | Brand  | Sub Brand | Product |
| DNSAR2     | DNSBR2 | DNSSB2    | DNSPR2  |
And logged in with details of 'DNSU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Artist | ISRC Code | Release Date | Format         | Title | Destination                 |
| automated test info    | DNSAR2     | DNSBR2 | DNSSB2    | DNSPR2  | DNSC3  | DNSCN3    | 10/14/2022   | HD 1080i 25fps | DNST3 | BSkyB Green Button:Standard |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Notify When Passed QC | Always Notify When Delivered |
| should                       | should                       |
And save own Delivery Setting
And go to Order Proceed page for order contains order item with following isrc code 'DNSCN3'
Then I should see following data for order on Order Proceed page:
| Notify About Delivery | Notify About Passed QC |
| should                | should                 |

Scenario: check saving unticking checkboxes Always notify when passed QC and Always notify when delivered in the Delivery Settings
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| DNSA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DNSU1 | agency.admin | DNSA1        |
And logged in with details of 'DNSU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Notify When Passed QC | Always Notify When Delivered |
| should                       | should                       |
And save own Delivery Setting
And fill following fields for Delivery Setting form on user delivery setting page:
| Always Notify When Passed QC | Always Notify When Delivered |
| should not                   | should not                   |
And save own Delivery Setting
And refresh the page without delay
Then I should see following data for Delivery Setting form on user delivery setting page:
| Always Notify When Passed QC | Always Notify When Delivered |
| should not                   | should not                   |

Scenario: check saving unticking checkboxes Notify About Delivery and Notify About Passed QC on the Order Summary page
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| DNSA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DNSU1 | agency.admin | DNSA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DNSA1':
| Advertiser | Brand  | Sub Brand | Product |
| DNSAR2     | DNSBR2 | DNSSB2    | DNSPR2  |
And logged in with details of 'DNSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | DNSAR2     | DNSBR2 | DNSSB2    | DNSPR2  | DNSC5    | DNSCN5       | 20       | 10/14/2022     | HD 1080i 25fps | DNST5 | Already Supplied   | BSkyB Green Button:Standard |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Notify When Passed QC | Always Notify When Delivered |
| should not                   | should not                   |
And save own Delivery Setting
And go to Order Proceed page for order contains order item with following clock number 'DNSCN5'
Then I should see following data for order on Order Proceed page:
| Notify About Delivery | Notify About Passed QC |
| should not            | should not             |