!--ORD-2158
!--ORD-1956
Feature: Advertiser hierarchy improvements
Narrative:
In order to:
As a AgencyAdmin
I want to check that all advertiser hieararchy works correctly

Scenario: Check that search by fields of advertiser hierarchy works correctly
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| AHIA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| AHIU1 | agency.admin | AHIA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AHIA1':
| Advertiser | Brand   | Sub Brand  | Product   |
| AHIAR1     | <Brand> | <Subbrand> | <Product> |
And logged in with details of 'AHIU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product   | Campaign | Clock Number  | Duration | First Air Date | Format         | Title |
| automated test info    | AHIAR1      | <Brand> | <Subbrand> | <Product> | AHIC1    | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | AHIT1 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'draft' order list on ordering page
Then I should see TV order in 'draft' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand  | Product   | Market         | NoClocks | Creator |
| Digit  | CurrentTime | AHIAR1     | <Brand> | <Subbrand> | <Product> | United Kingdom | 1        | AHIU1   |

Examples:
| ClockNumber | Brand    | Subbrand | Product  | SearchFilter |
| AHICN1_1    | AHIBR1_1 | AHISB1_1 | AHIPR1_1 | AHIAR1       |
| AHICN1_2    | AHIBR1_2 | AHISB1_2 | AHIPR1_2 | AHIBR1_2     |
| AHICN1_3    | AHIBR1_3 | AHISB1_3 | AHIPR1_3 | AHISB1_3     |
| AHICN1_4    | AHIBR1_4 | AHISB1_4 | AHIPR1_4 | AHIPR1_4     |

Scenario: Check that sorting by fields of advertiser hierarchy works correctly
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>     |
And logged in with details of '<User>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign | Clock Number | Duration | First Air Date | Format         | Title   |
| automated test info    | A_AHIAR2_1 | A_AHIBR2_1 | A_AHISB2_1 | A_AHIPR2_1 | AHIC2_1  | AHICN2_1     | 20       | 10/14/2022     | HD 1080i 25fps | AHIT2_1 |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign | Clock Number | Duration | First Air Date | Format         | Title   |
| automated test info    | C_AHIAR2_2 | C_AHIBR2_2 | C_AHISB2_2 | C_AHIPR2_2 | AHIC2_2  | AHICN2_2     | 20       | 10/14/2022     | HD 1080i 25fps | AHIT2_2 |
And create 'tv' order with market 'Bulgaria' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign | Clock Number | Duration | First Air Date | Format         | Title   |
| automated test info    | P_AHIAR2_3 | P_AHIBR2_3 | P_AHISB2_3 | P_AHIPR2_3 | AHIC2_3  | AHICN2_3     | 20       | 10/14/2022     | HD 1080i 25fps | AHIT2_3 |
And create 'tv' order with market 'Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign | Clock Number | Duration | First Air Date | Format         | Title   |
| automated test info    | T_AHIAR2_4 | T_AHIBR2_4 | T_AHISB2_4 | T_AHIPR2_4 | AHIC2_4  | AHICN2_4     | 20       | 10/14/2022     | HD 1080i 25fps | AHIT2_4 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When sort order list by column '<SortColumn>' with following sorting order '<SortingOrder>' on ordering page
Then I should see following values '<ValuesOrder>' for column '<SortColumn>' of advertiser hierarchy in 'draft' order list

Examples:
| Agency  | User    | SortColumn | SortingOrder | ValuesOrder                                 |
| AHIA2_1 | AHIU2_1 | Advertiser | ASC          | A_AHIAR2_1,C_AHIAR2_2,P_AHIAR2_3,T_AHIAR2_4 |
| AHIA2_2 | AHIU2_2 | Advertiser | DESC         | T_AHIAR2_4,P_AHIAR2_3,C_AHIAR2_2,A_AHIAR2_1 |
| AHIA2_3 | AHIU2_3 | Brand      | ASC          | A_AHIBR2_1,C_AHIBR2_2,P_AHIBR2_3,T_AHIBR2_4 |
| AHIA2_4 | AHIU2_4 | Brand      | DESC         | T_AHIBR2_4,P_AHIBR2_3,C_AHIBR2_2,A_AHIBR2_1 |
| AHIA2_5 | AHIU2_5 | Sub Brand  | ASC          | A_AHISB2_1,C_AHISB2_2,P_AHISB2_3,T_AHISB2_4 |
| AHIA2_6 | AHIU2_6 | Sub Brand  | DESC         | T_AHISB2_4,P_AHISB2_3,C_AHISB2_2,A_AHISB2_1 |
| AHIA2_7 | AHIU2_7 | Product    | ASC          | A_AHIPR2_1,C_AHIPR2_2,P_AHIPR2_3,T_AHIPR2_4 |
| AHIA2_8 | AHIU2_8 | Product    | DESC         | T_AHIPR2_4,P_AHIPR2_3,C_AHIPR2_2,A_AHIPR2_1 |

Scenario: Check that whole advertiser hierarchy is displayed in order list
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| AHIA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| AHIU1 | agency.admin | AHIA1        |
And logged in with details of 'AHIU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
Then 'should' see column 'Advertiser,Brand,Sub Brand,Product' for order list on ordering page

Scenario: Check that whole advertiser hierarchy is displayed on order summary
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| AHIA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| AHIU1 | agency.admin | AHIA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AHIA1':
| Advertiser | Brand  | Sub Brand | Product |
| AHIAR1     | AHIBR1 | AHISB1    | AHIPR1  |
And logged in with details of 'AHIU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | AHIAR1     | AHIBR1 | AHISB1    | AHIPR1  | AHIC4    | AHICN4       | 20       | 10/14/2022     | HD 1080i 25fps | AHIT4 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'AHICN4' with following fields:
| Job Number | PO Number |
| AHIJB4     | AHIPN4    |
When go to Order Summary page for order contains item with following clock number 'AHICN4'
Then I 'should' see column 'Advertiser,Brand,Sub Brand,Product' for clock delivery list on order summary page

Scenario: Check that renamed fields of advertiser hierarchy are correctly displayed on order list
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| AHIA5 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| AHIU5 | agency.admin | AHIA5        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AHIA5':
| Advertiser | Brand  | Sub Brand | Product |
| AHIAR5     | AHIBR5 | AHISB5    | AHIPR5  |
And logged in with details of 'AHIU5'
And updated following 'common' custom metadata fields for agency 'AHIA5':
| FieldType          | Description | NewDescription    |
| CatalogueStructure | Advertiser  | Advertiser Custom |
| CatalogueStructure | Brand       | Brand Custom      |
| CatalogueStructure | Sub Brand   | Sub Brand Custom  |
| CatalogueStructure | Product     | Product Custom    |
And I am on View Draft Orders tab of 'tv' order on ordering page
Then 'should' see column 'Advertiser Custom,Brand Custom,Sub Brand Custom,Product Custom' for order list on ordering page

Scenario: Check that renamed fields of advertiser hierarchy are correctly displayed on order summary
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| AHIA6 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| AHIU6 | agency.admin | AHIA6        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AHIA6':
| Advertiser | Brand  | Sub Brand | Product |
| AHIAR6     | AHIBR6 | AHISB6    | AHIPR6  |
And logged in with details of 'AHIU6'
And updated following 'common' custom metadata fields for agency 'AHIA6':
| FieldType          | Description | NewDescription    |
| CatalogueStructure | Advertiser  | Advertiser Custom |
| CatalogueStructure | Brand       | Brand Custom      |
| CatalogueStructure | Sub Brand   | Sub Brand Custom  |
| CatalogueStructure | Product     | Product Custom    |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | AHIAR6     | AHIBR6 | AHISB6    | AHIPR6  | AHIC6    | AHICN6       | 20       | 10/14/2022     | HD 1080i 25fps | AHIT6 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'AHICN6' with following fields:
| Job Number | PO Number |
| AHIJB6     | AHIPN6    |
When go to Order Summary page for order contains item with following clock number 'AHICN6'
Then I 'should' see column 'Advertiser Custom,Brand Custom,Sub Brand Custom,Product Custom' for clock delivery list on order summary page