!--ORD-2762
!--ORD-2855
Feature: New nVerge option within New Master functionality
Narrative:
In order to:
As a AgencyAdmin
I want to check nVerge option within New Master functionality

Scenario: check saving nVerge data after save as draft action
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ONVWNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ONVWNMU1 | agency.admin | ONVWNMA1     |
And logged in with details of 'ONVWNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ONVWNMCN1    |
When I open order item with following clock number 'ONVWNMCN1'
And fill following fields for New Master of order item that supply via 'nVerge' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| ONVWNMU1 | should not       | automated test | 12/14/2022    |
And save as draft order
And open order item with following clock number 'ONVWNMCN1'
Then I should see following data on New Master form for order item that supply via 'nVerge':
| Assignee | Already Supplied | Message        | Deadline Date |
| ONVWNMU1 | should not       | automated test | 12/14/2022    |

Scenario: check copy current for nVerge option
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ONVWNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ONVWNMU1 | agency.admin | ONVWNMA1     |
And logged in with details of 'ONVWNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ONVWNMCN2    |
And add for 'tv' order to item with clock number 'ONVWNMCN2' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge     | ONVWNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'ONVWNMCN2'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data on New Master form for order item that supply via 'nVerge':
| Assignee | Already Supplied | Message        | Deadline Date |
| ONVWNMU1 | should not       | automated test | 12/14/2022    |
And should see for active order item on cover flow following data:
| Media Request                 |
| Media requested from ONVWNMU1 |

Scenario: check copy to all for nVerge option
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ONVWNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ONVWNMU1 | agency.admin | ONVWNMA1     |
And logged in with details of 'ONVWNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ONVWNMCN3_1  |
| ONVWNMCN3_2  |
And add for 'tv' order to item with clock number 'ONVWNMCN3_1' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge     | ONVWNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'ONVWNMCN3_1'
And copy data from 'Add media' section of order item page to all other items
And select order item with following clock number 'ONVWNMCN3_2' on cover flow
Then I should see for active order item on cover flow following data:
| Media Request                 |
| Media requested from ONVWNMU1 |
And should see following data on New Master form for order item that supply via 'nVerge':
| Assignee | Already Supplied | Message        | Deadline Date |
| ONVWNMU1 | should not       | automated test | 12/14/2022    |

Scenario: check clear action for nVerge option
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ONVWNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ONVWNMU1 | agency.admin | ONVWNMA1     |
And logged in with details of 'ONVWNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ONVWNMCN4    |
And add for 'tv' order to item with clock number 'ONVWNMCN4' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge     | ONVWNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'ONVWNMCN4'
And clear 'Add media' section on order item page
Then I should see for active order item on cover flow following data:
| Media Request |
|               |
And should see 'enabled' New master button for order item on Add media form
And should see 'enabled' Retrieve from Library button for order item at Add media to your order form
And should see 'enabled' Retrieve from Project button for order item at Add media to your order form

Scenario: check confirm order with nVerge option
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ONVWNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ONVWNMU1 | agency.admin | ONVWNMA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ONVWNMA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ONVWNMAR5  | ONVWNMBR5 | ONVWNMSB5 | ONVWNMPR5 |
And logged in with details of 'ONVWNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ONVWNMAR5  | ONVWNMBR5 | ONVWNMSB5 | ONVWNMPR5 | ONVWNMC5 | ONVWNMCN5    | 20       | 10/14/2022     | HD 1080i 25fps | ONVWNMT5 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'ONVWNMCN5' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge     | ONVWNMU1 | should not       | automated test | 12/14/2022    |
And complete order contains item with clock number 'ONVWNMCN5' with following fields:
| Job Number | PO Number |
| ONVWNMJN5  | ONVWNMPN5 |
When I go to View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item clock number 'ONVWNMCN5' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product   | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | ONVWNMAR5  | ONVWNMBR5 | ONVWNMSB5 | ONVWNMPR5 | United Kingdom | ONVWNMPN5 | ONVWNMJN5 | 1        | 0/1 Delivered |

Scenario: check locked Add Media content with nVerge option after transfer order
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| ONVWNMA6_1 | DefaultA4User |
| ONVWNMA6_2 | DefaultA4User |
And added agency 'ONVWNMA6_1' as a partner to agency 'ONVWNMA6_2'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| ONVWNMU6_1 | agency.admin | ONVWNMA6_1   |
| ONVWNMU6_2 | agency.admin | ONVWNMA6_2   |
And logged in with details of 'ONVWNMU6_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ONVWNMCN6    |
And add for 'tv' order to item with clock number 'ONVWNMCN6' a New Master with following fields:
| Supply Via | Assignee   | Already Supplied | Message        | Deadline Date |
| nVerge     | ONVWNMU6_1 | should not       | automated test | 12/14/2022    |
And transfered order contains item with clock number 'ONVWNMCN6' to user 'ONVWNMU6_2' with following message 'autotest transfer message'
When I open order item with following clock number 'ONVWNMCN6'
Then I 'should' see Back button on order item page
And should see following title 'Transferred Order View Only' on order item page
And should see 'disabled' New master button for order item on Add media form

Scenario: check locked Add Media content with nVerge option for assignee
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| ONVWNMA6_1 | DefaultA4User |
| ONVWNMA6_2 | DefaultA4User |
And added agency 'ONVWNMA6_1' as a partner to agency 'ONVWNMA6_2'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| ONVWNMU6_1 | agency.admin | ONVWNMA6_1   |
| ONVWNMU6_2 | agency.admin | ONVWNMA6_2   |
And logged in with details of 'ONVWNMU6_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ONVWNMCN7    |
And add for 'tv' order to item with clock number 'ONVWNMCN7' a New Master with following fields:
| Supply Via | Assignee   | Already Supplied | Message        | Deadline Date |
| nVerge     | ONVWNMU6_1 | should not       | automated test | 12/14/2022    |
And transfered order contains item with clock number 'ONVWNMCN7' to user 'ONVWNMU6_2' with following message 'autotest transfer message'
And logged in with details of 'ONVWNMU6_2'
When I open order item with following clock number 'ONVWNMCN7'
Then I 'should not' see Back button on order item page
And should see 'disabled' New master button for order item on Add media form