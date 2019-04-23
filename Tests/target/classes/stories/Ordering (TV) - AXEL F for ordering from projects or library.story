!--ORD-2669
!--ORD-2738
!--ORD-2998
Feature: AXEL F for ordering from projects or library
Narrative:
In order to:
As a AgencyAdmin
I want to check AXEL F for ordering from projects or library

Scenario: check AXEL F for ordering from projects or library
!--TD-202.
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | AgencyType | Ingest Location |
| AFFOA1_1 | DefaultA4User | Ingest     |                 |
| AFFOA1_2 | DefaultA4User | Advertiser | AFFOA1_1        |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| AFFOU1_1 | agency.admin | AFFOA1_1     |streamlined_library,folders|
| AFFOU1_2 | agency.admin | AFFOA1_2     |streamlined_library,folders|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AFFOA1_2':
| Advertiser | Brand     | Sub Brand | Product  |
| AFFOAR1_1  | AFFOBR1_1 | AFFOSB1_1 | AFFOP1_1 |
| AFFOAR1_2  | AFFOBR1_2 | AFFOSB1_2 | AFFOP1_2 |
And logged in with details of 'AFFOU1_2'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'AFFOP1' project
And created '/AFFOF1' folder for project 'AFFOP1'
And uploaded into project 'AFFOP1' following files:
| FileName             | Path    |
| /files/Fish2-Ad.mov  | /AFFOF1 |
And waited while transcoding is finished in folder '/AFFOF1' on project 'AFFOP1' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | AFFOAR1_1  | AFFOBR1_1 | AFFOSB1_1 | AFFOP1_1 | AFFOC1_1 | AFFOCN1_1    | 20       | 10/14/2022     | HD 1080i 25fps | AFFOT1_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | AFFOAR1_2  | AFFOBR1_2 | AFFOSB1_2 | AFFOP1_2 | AFFOC1_2 | AFFOCN1_2    | 15       | 10/14/2024     | HD 1080i 25fps | AFFOT1_2 | Already Supplied   | BET:Standard                |
And add to 'tv' order item with clock number 'AFFOCN1_1' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And add to 'tv' order item with clock number 'AFFOCN1_2' following file 'Fish2-Ad.mov' from folder '/AFFOF1' of project 'AFFOP1'
And complete order contains item with clock number 'AFFOCN1_1' with following fields:
| Job Number | PO Number |
| AFFOJN1    | AFFOPN1   |
And logged in with details of 'AFFOU1_1'
When I pass to project 'Adstream Ingest' folder '/AFFOAR1_1-AFFOCN1_1/AFFOAR1_1-AFFOCN1_1-AFFOCN1_1' page
Then I 'should' see next file 'Fish1-Ad.mov' on project 'Adstream Ingest' folder '/AFFOAR1_1-AFFOCN1_1/AFFOAR1_1-AFFOCN1_1-AFFOCN1_1' page
When I pass to project 'Adstream Ingest' folder '/AFFOAR1_2-AFFOCN1_2/AFFOAR1_2-AFFOCN1_2-AFFOCN1_2' page
Then I 'should' see next file 'Fish2-Ad.mov' on project 'Adstream Ingest' folder '/AFFOAR1_2-AFFOCN1_2/AFFOAR1_2-AFFOCN1_2-AFFOCN1_2' page