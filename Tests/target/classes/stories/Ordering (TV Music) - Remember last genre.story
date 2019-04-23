!--ORD-2520
!--ORD-2828
Feature: Remember last genre
Narrative:
In order to:
As a AgencyAdmin
I want to check remembering last genre

Scenario:  Check that application remembers last genre after logout
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ORLGA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ORLGU1 | agency.admin | ORLGA1       |
And logged in with details of 'ORLGU1'
And I am on View Draft Orders tab of '<OrderType>' order on ordering page
And I logout from account
And logged in with details of 'ORLGU1'
When I go to Delivery page
Then I 'should' see selected '<OrderType>' switcher on ordering page

Examples:
| OrderType |
| tv        |
| music     |

Scenario:  Check that application remembers last genre of logged user even if several users logins using browser on the same host
!--ORD-2830
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ORLGA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ORLGU1 | agency.admin | ORLGA1       |
| ORLGU2 | agency.admin | ORLGA1       |
And logged in with details of 'ORLGU1'
And I am on View Draft Orders tab of 'music' order on ordering page
And I logout from account
And logged in with details of 'ORLGU2'
When I go to Delivery page
Then I 'should not' see selected 'music' switcher on ordering page