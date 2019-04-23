!--ORD-3452
!--ORD-3502
Feature: Already Subtitled should be present for Beam agency
Narrative:
In order to:
As a AgencyAdmin
I want to check that Already Subtitled is present for Beam agency

Scenario: Already Subtitled should be present for Beam agency
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Labels |
| CASFBA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email  | Role         | AgencyUnique | Language   |
| <User> | agency.admin | CASFBA1      | <Language> |
And logged in with details of '<User>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  | Subtitles Required |
| <ClockNumber> | Already Supplied   |
When I open order item with following clock number '<ClockNumber>'
Then I should see following data for order item on Add information form:
| Clock Number  | Subtitles Required |
| <ClockNumber> | Already Subtitled  |

Examples:
| User      | Language   | ClockNumber |
| CASFBU1_1 | en-beam    | CASFBCN1_1  |
| CASFBU1_2 | en-beam-us | CASFBCN1_2  |