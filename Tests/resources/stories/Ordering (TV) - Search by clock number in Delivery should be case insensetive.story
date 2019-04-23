!--ORD-3814
Feature: Search by clock number should be case insensetive
Narrative:
In order to:
As a AgencyAdmin
I want to check that searching by clock number is case insensetive

Scenario: Search by clock number in Delivery should be case insensetive in orders list
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SBCNCIA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SBCNCIU1 | agency.admin | SBCNCIA1     |
And logged in with details of 'SBCNCIU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'draft' order list on ordering page
Then I should see TV order in 'draft' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser | Brand | Sub Brand | Product | Market         | NoClocks | Creator  |
| Digit  | CurrentTime |            |       |           |         | United Kingdom | 1        | SBCNCIU1 |
And should see 'draft' order in 'tv' order list contains items with following fields:
| Clock Number  | Advertiser | Product | Title | First Air Date | Format | Duration |
| <ClockNumber> |            |         |       |                |        |          |

Examples:
| ClockNumber | SearchFilter |
| SBCNCICN1_1 | sbcncicn1_1  |
| sbcncicn1_2 | SBCNCICN1_2  |

Scenario: Search by clock number in Delivery should be case insensetive with action Retrieve from Library
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SBCNCIA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| SBCNCIU1 | agency.admin | SBCNCIA1     |streamlined_library|
And logged in with details of 'SBCNCIU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue    |
| Clock number | <ClockNumber> |
| Duration | 8s |
And open order item with following clock number '<ClockNumber>'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value '<SearchFilter>' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following assets:
| Name         |
| Fish1-Ad.mov |

Examples:
| ClockNumber | SearchFilter |
| SBCNCICN2_1 | sbcncicn2_1  |
| sbcncicn2_2 | SBCNCICN2_2  |


Scenario: Search by clock number in Delivery should be case insensetive with action Retrieve from Project
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SBCNCIA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SBCNCIU1 | agency.admin | SBCNCIA1     |
And logged in with details of 'SBCNCIU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And created 'SBCNCIP3' project
And created '/SBCNCIF3' folder for project 'SBCNCIP3'
And uploaded into project 'SBCNCIP3' following files:
| FileName             | Path      |
| /files/Fish1-Ad.mov  | /SBCNCIF3 |
And waited while transcoding is finished in folder '/SBCNCIF3' on project 'SBCNCIP3' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/SBCNCIF3' project 'SBCNCIP3'
When I 'save' file info by next information:
| FieldName    | FieldValue    |
| Clock number | <ClockNumber> |
And open order item with following clock number '<ClockNumber>'
And retrieve files from projects for order item at Add media to your order form
And open project 'SBCNCIP3' at Add media to your order form for retrieving folders and files
And fill Search field by value '<SearchFilter>' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish1-Ad.mov |

Examples:
| ClockNumber | SearchFilter |
| SBCNCICN3_1 | sbcncicn3_1  |
| sbcncicn3_2 | SBCNCICN3_2  |