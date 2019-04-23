!--ORD-305
!--ORD-1667
!--ORD-1771
Feature: Clear Physical Media and FTP Type requests
Narrative:
In order to:
As a AgencyAdmin
I want to check Clear Physical Media and FTP Type requests functionality

Scenario: check cleaning email address on the coverflow
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMCNMA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMCNMU1 | agency.admin | OTVMCNMA1    |
And logged in with details of 'OTVMCNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMCNMCN1   |
And add for 'tv' order to item with clock number 'OTVMCNMCN1' a New Master with following fields:
| Supply Via | Assignee  | Already Supplied | Message        | Deadline Date |
| FTP        | OTVMCNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'OTVMCNMCN1'
And clear 'Add media' section on order item page
Then I should see for active order item on cover flow following data:
| Media Request |
|               |

Scenario: check clean New Master
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMCNMA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMCNMU1 | agency.admin | OTVMCNMA1    |
And logged in with details of 'OTVMCNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMCNMCN2   |
And add for 'tv' order to item with clock number 'OTVMCNMCN2' a New Master with following fields:
| Assignee  | Already Supplied |
| OTVMCNMU1 | should           |
When I open order item with following clock number 'OTVMCNMCN2'
And clear 'Add media' section on order item page
Then I should see 'enabled' New master button for order item on Add media form
And should see 'enabled' Retrieve from Library button for order item at Add media to your order form
And should see 'enabled' Retrieve from Project button for order item at Add media to your order form