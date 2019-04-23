!--ORD-2702
!--ORD-2872
Feature: Assignee field in Add Media to accept multiple users
Narrative:
In order to:
As a AgencyAdmin
I want to check accept multiple users in assignee field

Scenario: check several emails on the cover flow and Assignee
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OAAMUA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OAAMUU1 | agency.admin | OAAMUA1      |
And logged in with details of 'OAAMUU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OAAMUCN1     |
When I open order item with following clock number 'OAAMUCN1'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee                      | Already Supplied | Message        | Deadline Date |
| OAAMUU1_1,OAAMUU1_2,OAAMUU1_3 | should not       | automated test | 12/14/2022    |
Then I should see for active order item on cover flow following data:
| Media Request                                      |
| Media requested from OAAMUU1_1,OAAMUU1_2,OAAMUU1_3 |
And should see following data on New Master form for order item that supply via 'FTP':
| Assignee                      | Already Supplied | Message        | Deadline Date |
| OAAMUU1_1,OAAMUU1_2,OAAMUU1_3 | should not       | automated test | 12/14/2022    |

Scenario: check several emails on the cover flow and Assignee after Copy current
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OAAMUA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OAAMUU1 | agency.admin | OAAMUA1      |
And logged in with details of 'OAAMUU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OAAMUCN2     |
And add for 'tv' order to item with clock number 'OAAMUCN2' a New Master with following fields:
| Supply Via | Assignee                      | Already Supplied | Message        | Deadline Date |
| FTP        | OAAMUU2_1,OAAMUU2_2,OAAMUU2_3 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'OAAMUCN2'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data on New Master form for order item that supply via 'FTP':
| Assignee                      | Already Supplied | Message        | Deadline Date |
| OAAMUU2_1,OAAMUU2_2,OAAMUU2_3 | should not       | automated test | 12/14/2022    |
And should see for active order item on cover flow following data:
| Media Request                                      |
| Media requested from OAAMUU2_1,OAAMUU2_2,OAAMUU2_3 |

Scenario: check autocompleting of several emails
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OAAMUA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OAAMUU1 | agency.admin | OAAMUA1      |
And logged in with details of 'OAAMUU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OAAMUCN3_1   |
| OAAMUCN3_2   |
When I open order item with following clock number 'OAAMUCN3_1'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee                      | Already Supplied | Message        | Deadline Date |
| OAAMUU3_1,OAAMUU3_2,OAAMUU3_3 | should not       | automated test | 12/14/2022    |
And select order item with following clock number 'OAAMUCN3_2' on cover flow
And fill following fields for New Master of order item that supply via '' on Add media form:
| Assignee  |
| OAAMUU3_1 |
Then I should see auto complete emails count '1' under Assignee for New Master on Add media form
When I fill following fields for New Master of order item that supply via '' on Add media form:
| Assignee  |
| OAAMUU3_2 |
Then I should see auto complete emails count '1' under Assignee for New Master on Add media form
When I fill following fields for New Master of order item that supply via '' on Add media form:
| Assignee  |
| OAAMUU3_3 |
Then I should see auto complete emails count '1' under Assignee for New Master on Add media form

Scenario: check confirmation email with several email adresses for one order item
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        |
| OAAMUA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OAAMUU1 | agency.admin | OAAMUA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OAAMUA1':
| Advertiser | Brand    | Sub Brand | Product  |
| OAAMUAR4   | OAAMUBR4 | OAAMUSB4  | OAAMUPR4 |
And logged in with details of 'OAAMUU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | OAAMUAR4   | OAAMUBR4 | OAAMUSB4  | OAAMUPR4 | OAAMUC4  | OAAMUCN4     | 20       | 10/14/2022     | HD 1080i 25fps | OAAMUT4 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'OAAMUCN4' a New Master with following fields:
| Supply Via | Assignee            | Already Supplied | Message        | Deadline Date |
| FTP        | OAAMUU4_1,OAAMUU4_2 | should not       | automated test | 12/14/2022    |
And complete order contains item with clock number 'OAAMUCN4' with following fields:
| Job Number | PO Number |
| OAAMUJN4   | OAAMUPN4  |
And I am on View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item clock number 'OAAMUCN4' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Sub Brand | Product  | Market         | PO Number | Job #    | NoClocks | Status        |
| Digit  | CurrentTime | OAAMUAR4   | OAAMUBR4 | OAAMUSB4  | OAAMUPR4 | United Kingdom | OAAMUPN4  | OAAMUJN4 | 1        | 0/1 Delivered |
And 'should' see email notification for 'Media Transfer Request' with field to 'OAAMUU4_1' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product  | Title   | Duration | Format         | Message        |
| OAAMUA1 | adstream     | OAAMUU1   | 12/14/2022    | OAAMUCN4     | OAAMUAR4   | OAAMUPR4 | OAAMUT4 | 20       | HD 1080i 25fps | automated test |
And 'should' see email notification for 'Media Transfer Request' with field to 'OAAMUU4_2' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product  | Title   | Duration | Format         | Message        |
| OAAMUA1 | adstream     | OAAMUU1   | 12/14/2022    | OAAMUCN4     | OAAMUAR4   | OAAMUPR4 | OAAMUT4 | 20       | HD 1080i 25fps | automated test |

Scenario: check confirmation email with several email adresses for two order items
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        |
| OAAMUA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OAAMUU1 | agency.admin | OAAMUA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OAAMUA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OAAMUAR5_1 | OAAMUBR5_1 | OAAMUSB5_1 | OAAMUPR5_1 |
| OAAMUAR5_2 | OAAMUBR5_2 | OAAMUSB5_2 | OAAMUPR5_2 |
And logged in with details of 'OAAMUU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OAAMUAR5_1 | OAAMUBR5_1 | OAAMUSB5_1 | OAAMUPR5_1 | OAAMUC5_1 | OAAMUCN5_1   | 20       | 10/14/2022     | HD 1080i 25fps | OAAMUT5_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | OAAMUAR5_2 | OAAMUBR5_2 | OAAMUSB5_2 | OAAMUPR5_2 | OAAMUC5_2 | OAAMUCN5_2   | 15       | 10/14/2022     | SD PAL 16x9    | OAAMUT5_2 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'OAAMUCN5_1' a New Master with following fields:
| Supply Via | Assignee            | Already Supplied | Message          | Deadline Date |
| FTP        | OAAMUU5_1,OAAMUU5_2 | should not       | automated test 1 | 12/14/2022    |
And add for 'tv' order to item with clock number 'OAAMUCN5_2' a New Master with following fields:
| Supply Via | Assignee            | Already Supplied | Message          | Deadline Date |
| FTP        | OAAMUU5_3,OAAMUU5_4 | should not       | automated test 2 | 11/14/2022    |
And complete order contains item with clock number 'OAAMUCN5_1' with following fields:
| Job Number | PO Number |
| OAAMUJN5   | OAAMUPN5  |
And I am on View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item clock number 'OAAMUCN5_1' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #    | NoClocks | Status        |
| Digit  | CurrentTime | Various    | Various | Various   | Various | United Kingdom | OAAMUPN5  | OAAMUJN5 | 2        | 0/2 Delivered |
And 'should' see email notification for 'Media Transfer Request' with field to 'OAAMUU5_1' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product    | Title     | Duration | Format         | Message          |
| OAAMUA1 | adstream     | OAAMUU1   | 12/14/2022    | OAAMUCN5_1   | OAAMUAR5_1 | OAAMUPR5_1 | OAAMUT5_1 | 20       | HD 1080i 25fps | automated test 1 |
And 'should' see email notification for 'Media Transfer Request' with field to 'OAAMUU5_2' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product    | Title     | Duration | Format         | Message          |
| OAAMUA1 | adstream     | OAAMUU1   | 12/14/2022    | OAAMUCN5_1   | OAAMUAR5_1 | OAAMUPR5_1 | OAAMUT5_1 | 20       | HD 1080i 25fps | automated test 1 |
And 'should' see email notification for 'Media Transfer Request' with field to 'OAAMUU5_3' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product    | Title     | Duration | Format      | Message          |
| OAAMUA1 | adstream     | OAAMUU1   | 11/14/2022    | OAAMUCN5_2   | OAAMUAR5_2 | OAAMUPR5_2 | OAAMUT5_2 | 15       | SD PAL 16x9 | automated test 2 |
And 'should' see email notification for 'Media Transfer Request' with field to 'OAAMUU5_4' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product    | Title     | Duration | Format      | Message          |
| OAAMUA1 | adstream     | OAAMUU1   | 11/14/2022    | OAAMUCN5_2   | OAAMUAR5_2 | OAAMUPR5_2 | OAAMUT5_2 | 15       | SD PAL 16x9 | automated test 2 |