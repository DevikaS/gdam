!--ORD-3227
!--ORD-3273
Feature: When File is sent to delivery directly from project preserve link to original project on the QCed master
Narrative:
In order to:
As a AgencyAdmin
I want to check file is sent to delivery directly from project preserve link to original project on the QCed master

Scenario: When File is sent to delivery directly from project preserve link to original project on the QCed master
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| PLTOPQCA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| PLTOPQCU1 | agency.admin | PLTOPQCA1    |streamlined_library,folders|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PLTOPQCA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| PLTOPQCAR1 | PLTOPQCBR1 | PLTOPQCSB1 | PLTOPQCPR1 |
And logged in with details of 'PLTOPQCU1'
And created 'PLTOPQCP1' project
And created '/PLTOPQCF1' folder for project 'PLTOPQCP1'
And uploaded into project 'PLTOPQCP1' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /PLTOPQCF1 |
And waited while transcoding is finished in folder '/PLTOPQCF1' on project 'PLTOPQCP1' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | PLTOPQCAR1 | PLTOPQCBR1 | PLTOPQCSB1 | PLTOPQCPR1 | PLTOPQCC1 | PLTOPQCCN1   | 20       | 12/14/2022     | HD 1080i 25fps | PLTOPQCT1 | Adtext             | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'PLTOPQCCN1' following file '/files/Fish1-Ad.mov' from folder '/PLTOPQCF1' of project 'PLTOPQCP1'
And complete order contains item with clock number 'PLTOPQCCN1' with following fields:
| Job Number | PO Number  |
| PLTOPQCJN1 | PLTOPQCPN1 |
When I go to asset 'Fish1-Ad.mov' related projects info page in Library for collection 'My Assets' NEWLIB
Then 'should' see following originated project name 'PLTOPQCP1' on assets related projects info page in Library NEWLIB

