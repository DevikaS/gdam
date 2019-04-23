!--ORD-303
!--ORD-2889
Feature: nVerge upload request
Narrative:
In order to:
As a AgencyAdmin
I want to check nVerge upload request

Scenario: check AXEL F during nVerge upload request
!--TD-202.
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | AgencyType | Ingest Location |
| NURA1_1 | DefaultA4User | Ingest     |                 |
| NURA1_2 | DefaultA4User | Advertiser | NURA1_1         |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| NURU1_1 | agency.admin | NURA1_1      |
| NURU1_2 | agency.admin | NURA1_2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'NURA1_2':
| Advertiser | Brand    | Sub Brand | Product |
| NURAR1_1   | NURBR1_1 | NURSB1_1  | NURP1_1 |
| NURAR1_2   | NURBR1_2 | NURSB1_2  | NURP1_2 |
And logged in with details of 'NURU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info 1  | NURAR1_1   | NURBR1_1 | NURSB1_1  | NURP1_1 | NURC1_1  | NURCN1_1     | 20       | 10/14/2022     | HD 1080i 25fps | NURT1_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info 2  | NURAR1_2   | NURBR1_2 | NURSB1_2  | NURP1_2 | NURC1_2  | NURCN1_2     | 15       | 10/14/2024     | HD 1080i 25fps | NURT1_2 | Already Supplied   | BET:Standard                |
And add for 'tv' order to item with clock number 'NURCN1_1' a New Master with following fields:
| Supply Via | Assignee  | Already Supplied | Message          | Deadline Date |
| nVerge     | NURU1_1_1 | should not       | automated test 1 | 12/14/2022    |
And add for 'tv' order to item with clock number 'NURCN1_2' a New Master with following fields:
| Supply Via | Assignee  | Already Supplied | Message          | Deadline Date |
| nVerge     | NURU1_1_2 | should not       | automated test 2 | 12/14/2024    |
And complete order contains item with clock number 'NURCN1_1' with following fields:
| Job Number | PO Number |
| NURJN1     | NURPN1    |
And logged in with details of 'NURU1_1'
And waited for '95' seconds
Then I should see next '/NURAR1_1-NURCN1_1,/NURAR1_1-NURCN1_1/NURAR1_1-NURCN1_1-NURCN1_1,/NURAR1_2-NURCN1_2,/NURAR1_2-NURCN1_2/NURAR1_2-NURCN1_2-NURCN1_2' folders in 'Adstream Ingest' project

Scenario: check nVerge upload email confirmation during nVerge upload request
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        | AgencyType | Ingest Location |
| NURA1_1 | DefaultA4User | Ingest     |                 |
| NURA1_2 | DefaultA4User | Advertiser | NURA1_1         |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| NURU1_1 | agency.admin | NURA1_1      |
| NURU1_2 | agency.admin | NURA1_2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'NURA1_2':
| Advertiser | Brand    | Sub Brand | Product |
| NURAR1_1   | NURBR1_1 | NURSB1_1  | NURP1_1 |
| NURAR1_2   | NURBR1_2 | NURSB1_2  | NURP1_2 |
And logged in with details of 'NURU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info 1  | NURAR1_1   | NURBR1_1 | NURSB1_1  | NURP1_1 | NURC2_1  | NURCN2_1     | 20       | 10/14/2022     | HD 1080i 25fps | NURT2_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info 2  | NURAR1_2   | NURBR1_2 | NURSB1_2  | NURP1_2 | NURC2_2  | NURCN2_2     | 15       | 10/14/2024     | SD PAL 16x9    | NURT2_2 | Already Supplied   | BET:Standard                |
And add for 'tv' order to item with clock number 'NURCN2_1' a New Master with following fields:
| Supply Via | Assignee  | Already Supplied | Message          | Deadline Date |
| nVerge     | NURU2_1_1 | should not       | automated test 1 | 12/14/2022    |
And add for 'tv' order to item with clock number 'NURCN2_2' a New Master with following fields:
| Supply Via | Assignee  | Already Supplied | Message          | Deadline Date |
| nVerge     | NURU2_1_2 | should not       | automated test 2 | 02/14/2023    |
And complete order contains item with clock number 'NURCN2_1' with following fields:
| Job Number | PO Number |
| NURJN2     | NURPN2    |
Then I 'should' see email notification for 'nVerge Upload Request' with field to 'NURU2_1_1' and subject 'SendPlus Upload Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Brand    | Sub Brand | Product | Title   | Duration | First Air Date | Message          | Destination        |
| NURA1_2 | adstream     | NURU2_1_1 | 12/14/2022    | NURCN2_1     | NURAR1_1   | NURBR1_1 | NURSB1_1  | NURP1_1 | NURT2_1 | 20       | 10/14/2022     | automated test 1 | BSkyB Green Button |
And 'should' see email notification for 'nVerge Upload Request' with field to 'NURU2_1_2' and subject 'SendPlus Upload Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Brand    | Sub Brand | Product | Title   | Duration | First Air Date | Message          | Destination |
| NURA1_2 | adstream     | NURU2_1_2 | 02/14/2023    | NURCN2_2     | NURAR1_2   | NURBR1_2 | NURSB1_2  | NURP1_2 | NURT2_2 | 15       | 10/14/2024     | automated test 2 | BET         |

Scenario: check AXEL F during nVerge upload request for Beam agency
!--TD-202
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | AgencyType | Ingest Location | Labels |
| NURA3_1 | DefaultA4User | Ingest     |                 | Beam   |
| NURA3_2 | DefaultA4User | Advertiser | NURA3_1         | Beam   |
And created users with following fields:
| Email   | Role         | AgencyUnique | Language |
| NURU3_1 | agency.admin | NURA3_1      | en-beam  |
| NURU3_2 | agency.admin | NURA3_2      | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'NURA3_2':
| Advertiser | Brand    | Sub Brand | Product |
| NURAR3_1   | NURBR3_1 | NURSB3_1  | NURP3_1 |
| NURAR3_2   | NURBR3_2 | NURSB3_2  | NURP3_2 |
And logged in with details of 'NURU3_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info 1  | NURAR3_1   | NURBR3_1 | NURSB3_1  | NURP3_1 | NURC3_1  | NURCN3_1     | 20       | 10/14/2022     | HD 1080i 25fps | NURT3_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info 2  | NURAR3_2   | NURBR3_2 | NURSB3_2  | NURP3_2 | NURC3_2  | NURCN3_2     | 15       | 10/14/2024     | SD PAL 16x9    | NURT3_2 | Already Supplied   | BET:Standard                |
And add for 'tv' order to item with clock number 'NURCN3_1' a New Master with following fields:
| Supply Via | Post House | Assignee  | Already Supplied | Message          | Deadline Date |
| nVerge     | NURU3      | NURU3_1_1 | should not       | automated test 1 | 12/14/2022    |
And add for 'tv' order to item with clock number 'NURCN3_2' a New Master with following fields:
| Supply Via | Post House | Assignee  | Already Supplied | Message          | Deadline Date |
| nVerge     | NURU3      | NURU3_1_2 | should not       | automated test 2 | 12/14/2024    |
And complete order contains item with clock number 'NURCN3_1' with following fields:
| Job Number | PO Number |
| NURJN3     | NURPN3    |
And logged in with details of 'NURU3_1'
And waited for '65' seconds
Then I should see next '/NURAR3_1-NURCN3_1,/NURAR3_1-NURCN3_1/NURAR3_1-NURCN3_1-NURCN3_1,/NURAR3_2-NURCN3_2,/NURAR3_2-NURCN3_2/NURAR3_2-NURCN3_2-NURCN3_2' folders in 'Adstream Ingest' project

Scenario: check nVerge upload email confirmation during nVerge upload request for Beam agency
!--ORD-3588
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        | AgencyType | Ingest Location | Labels |
| NURA3_1 | DefaultA4User | Ingest     |                 | Beam   |
| NURA3_2 | DefaultA4User | Advertiser | NURA3_1         | Beam   |
And created users with following fields:
| Email   | Role         | AgencyUnique | Language |
| NURU3_1 | agency.admin | NURA3_1      | en-beam  |
| NURU3_2 | agency.admin | NURA3_2      | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'NURA3_2':
| Advertiser | Brand    | Sub Brand | Product |
| NURAR3_1   | NURBR3_1 | NURSB3_1  | NURP3_1 |
| NURAR3_2   | NURBR3_2 | NURSB3_2  | NURP3_2 |
And logged in with details of 'NURU3_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info 1  | NURAR3_1   | NURBR3_1 | NURSB3_1  | NURP3_1 | NURC4_1  | NURCN4_1     | 20       | 10/14/2022     | HD 1080i 25fps | NURT4_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info 2  | NURAR3_2   | NURBR3_2 | NURSB3_2  | NURP3_2 | NURC4_2  | NURCN4_2     | 15       | 10/14/2024     | SD PAL 16x9    | NURT4_2 | Already Supplied   | BET:Standard                |
And add for 'tv' order to item with clock number 'NURCN4_1' a New Master with following fields:
| Supply Via | Post House | Assignee  | Already Supplied | Message          | Deadline Date |
| nVerge     | NURU4      | NURU4_1_1 | should not       | automated test 1 | 12/14/2022    |
And add for 'tv' order to item with clock number 'NURCN4_2' a New Master with following fields:
| Supply Via | Post House | Assignee  | Already Supplied | Message          | Deadline Date |
| nVerge     | NURU4      | NURU4_1_2 | should not       | automated test 2 | 02/14/2023    |
And complete order contains item with clock number 'NURCN4_1' with following fields:
| Job Number | PO Number |
| NURJN4     | NURPN4    |
Then I 'should' see email notification for 'nVerge Upload Request' with field to 'NURU4_1_1' and subject 'nVerge Upload Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Brand    | Sub Brand | Product | Title   | Duration | First Air Date | Message          | Destination        |
| NURA3_2 | beam         | NURU4_1_1 | 12/14/2022    | NURCN4_1     | NURAR3_1   | NURBR3_1 | NURSB3_1  | NURP3_1 | NURT4_1 | 20       | 10/14/2022     | automated test 1 | BSkyB Green Button |
And 'should' see email notification for 'nVerge Upload Request' with field to 'NURU4_1_2' and subject 'nVerge Upload Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Brand    | Sub Brand | Product | Title   | Duration | First Air Date | Message          | Destination |
| NURA3_2 | beam         | NURU4_1_2 | 02/14/2023    | NURCN4_2     | NURAR3_2   | NURBR3_2 | NURSB3_2  | NURP3_2 | NURT4_2 | 15       | 10/14/2024     | automated test 2 | BET         |

Scenario: check navigation by nVerge link in the email
Meta: @skip
!--NGN-17164 --[Maria]--These templates were amended manually on live.And they can be amended any time by support.Please remove this test.
Given I created the following agency:
| Name    | A4User        | AgencyType | Ingest Location |
| NURA1_1 | DefaultA4User | Ingest     |                 |
| NURA1_2 | DefaultA4User | Advertiser | NURA1_1         |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| NURU1_1 | agency.admin | NURA1_1      |
| NURU1_2 | agency.admin | NURA1_2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'NURA1_2':
| Advertiser | Brand    | Sub Brand | Product |
| NURAR1_1   | NURBR1_1 | NURSB1_1  | NURP1_1 |
And logged in with details of 'NURU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info 1  | NURAR1_1   | NURBR1_1 | NURSB1_1  | NURP3   | NURC5    | NURCN5       | 20       | 10/14/2022     | HD 1080i 25fps | NURT5 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'NURCN5' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge     | NURU5    | should not       | automated test | 12/14/2022    |
And complete order contains item with clock number 'NURCN5' with following fields:
| Job Number | PO Number |
| NURJN5     | NURPN5    |
When I open link from email when user 'NURU5' received email with next subject 'Sendplus Upload Request'
And wait for '10' seconds
Then I should see following title 'Sendplus' of new window