!--ORD-3046
Feature: Assignee of New Master functionality
Narrative:
In order to:
As a AgencyAdmin
I want to check Assignee of New Master functionality

Scenario:  Should can select email address in case it was previously replaced with another one
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ANMFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ANMFU1_1 | agency.admin | ANMFA1       |
And logged in with details of 'ANMFU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ANMFCN1      |
When I open order item with following clock number 'ANMFCN1'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee |
| ANMFU1_1 |
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee          | Already Supplied | Message        | Deadline Date |
| ANMFU1_2,ANMFU1_1 | should not       | automated test | 12/14/2022    |
Then I should see for active order item on cover flow following data:
| Media Request                          |
| Media requested from ANMFU1_2,ANMFU1_1 |
And should see following data on New Master form for order item that supply via 'FTP':
| Assignee          | Already Supplied | Message        | Deadline Date |
| ANMFU1_2,ANMFU1_1 | should not       | automated test | 12/14/2022    |

Scenario: Just selected email address shouldn't highligh in lookup when another email is entered
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ANMFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ANMFU1_1 | agency.admin | ANMFA1       |
And logged in with details of 'ANMFU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| ANMFCN2_1    |
| ANMFCN2_2    |
When I open order item with following clock number 'ANMFCN2_1'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee          | Already Supplied | Message        | Deadline Date |
| ANMFU1_1,ANMFU1_2 | should not       | automated test | 12/14/2022    |
And select order item with following clock number 'ANMFCN2_2' on cover flow
And fill following fields for New Master of order item that supply via '' on Add media form:
| Assignee          |
| ANMFU1_1,ANMFU1_3 |
Then I should see auto complete emails count '0' under Assignee for New Master on Add media form