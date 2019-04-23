!--ORD-321
!--ORD-2062
Feature: Recepients control
Narrative:
In order to:
As a AgencyAdmin
I want to check Recepients control

Scenario: Check that emails specified before are remembered on Order Procced page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVRCA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVRCU1 | agency.admin | OTVRCA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRCA1':
| Advertiser | Brand    | Sub Brand | Product  |
| OTVRCAR1   | OTVRCBR1 | OTVRCSB1  | OTVRCPR1 |
And logged in with details of 'OTVRCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVRCAR1   | OTVRCBR1 | OTVRCSB1  | OTVRCPR1 | OTVRCC1_1 | OTVRCCN1_1   | 1mn      | 08/14/2022     | HD 1080i 25fps | OTVRCT1_1 | Already Supplied   | Aastha:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'OTVRCCN1_1'
When I fill following fields on Order Proceed page:
| Order Confirmed Recipients                  |
| RCE@1test.com,RCE@2test.com |
And confirm order on Order Proceed page
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVRCAR1   | OTVRCBR1 | OTVRCSB1  | OTVRCPR1 | OTVRCC1_2 | OTVRCCN1_2   | 1mn      | 08/14/2022     | HD 1080i 25fps | OTVRCT1_2 | Already Supplied   | BSkyB Green Button:Standard |
And go to Order Proceed page for order contains order item with following clock number 'OTVRCCN1_2'
And fill following fields on Order Proceed page:
| Order Confirmed Recipients  |
| RCE@       |
Then I should see auto complete emails count '2' under Recipients on Order Proceed page

Scenario: Check that emails specified before are remembered for New Master under Add Media section
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVRCA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVRCU1 | agency.admin | OTVRCA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRCA1':
| Advertiser | Brand    | Sub Brand | Product  |
| OTVRCAR1   | OTVRCBR1 | OTVRCSB1  | OTVRCPR1 |
And logged in with details of 'OTVRCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | OTVRCAR1   | OTVRCBR1 | OTVRCSB1  | OTVRCPR1 | OTVRCC2  | OTVRCCN2     | 1mn      | 08/14/2022     | HD 1080i 25fps | OTVRCT2 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVRCCN2'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| RCE2     | should not       | automated test | 12/14/2022    |
And click Proceed button on order item page
And confirm order on Order Proceed page
And create 'tv' order on View Draft Orders tab on ordering page
And fill following fields for New Master of order item that supply via '' on Add media form:
| Assignee |
| RCE2     |
Then I should see auto complete emails count '1' under Assignee for New Master on Add media form

Scenario: Check that email is remembered for next order item into New Master
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVRCA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVRCU1 | agency.admin | OTVRCA1      |
And logged in with details of 'OTVRCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVRCCN3     |
When I open order item with following clock number 'OTVRCCN3'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| RCE3     | should not       | automated test | 12/14/2022    |
And 'create' order item by Add Commercial button on order item page
And fill following fields for New Master of order item that supply via '' on Add media form:
| Assignee |
| RCE3     |
Then I should see auto complete emails count '1' under Assignee for New Master on Add media form

Scenario: Check that email specified into Assignee control of New Master isn't available into Additional recipients of Order Procced page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVRCA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVRCU1 | agency.admin | OTVRCA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRCA1':
| Advertiser | Brand    | Sub Brand | Product  |
| OTVRCAR1   | OTVRCBR1 | OTVRCSB1  | OTVRCPR1 |
And logged in with details of 'OTVRCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | OTVRCAR1   | OTVRCBR1 | OTVRCSB1  | OTVRCPR1 | OTVRCC4  | OTVRCCN4     | 1mn      | 08/14/2022     | HD 1080i 25fps | OTVRCT4 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVRCCN4'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee      | Already Supplied | Message        | Deadline Date |
| RCE4@test.com | should not       | automated test | 12/14/2022    |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Order Confirmed Recipients |
| RCE4@      |
Then I should see auto complete emails count '0' under Recipients on Order Proceed page


Scenario: Check that email is remembered for next order item into New Master created as result of copying
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVRCA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVRCU1 | agency.admin | OTVRCA1      |
And logged in with details of 'OTVRCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVRCCN5     |
When open order item with following clock number 'OTVRCCN5'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| RCE5_1   | should not       | automated test | 12/14/2022    |
And 'create' order item by Add Commercial button on order item page
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| RCE5_2   | should not       | automated test | 12/14/2022    |
And 'copy' order item by Add Commercial button on order item page
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee |
| RCE5_2   |
Then I should see auto complete emails count '1' under Assignee for New Master on Add media form