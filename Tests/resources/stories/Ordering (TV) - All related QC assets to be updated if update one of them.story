!--ORD-3137
!--ORD-3378
Feature: All related QC assets to be updated if update one of them
Narrative:
In order to:
As a AgencyAdmin
I want to check that all related QC assets to be updated if update one of them

Scenario: Service SubtitlingCheck that data is updated for all QC-ed clones in case to retrieve QC-ed asset from Library and change data
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| ARQCUA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| ARQCUU1 | agency.admin | ARQCUA1      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ARQCUA1':
| Advertiser | Brand    | Sub Brand | Product  |
| ARQCUAR1   | ARQCUBR1 | ARQCUSB1  | ARQCUPR1 |
And logged in with details of 'ARQCUU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info 1  | ARQCUAR1   | ARQCUBR1 | ARQCUSB1  | ARQCUPR1 | ARQCUC1  | ARQCUCN1_1   | 20       | 10/14/2022     | HD 1080i 25fps | ARQCUT1 | None             | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave    | Destination        |
| ARQCUCN1_2   | ARQCUCL1 | Gol TV HD:Standard |
And complete order contains item with clock number 'ARQCUCN1_1' with following fields:
| Job Number | PO Number  |
| ARQCUJN1_1 | ARQCUPN1_1 |
And waited for '5' seconds
And add to 'tv' order item with clock number 'ARQCUCN1_2' following qc asset 'ARQCUT1' of collection 'My Assets'
When I open order item with clock number 'ARQCUCN1_1' for order with market 'Spain'
And fill following fields for Add information form on order item page:
| Additional Information | First Air Date |
| automated test info 2  | 12/12/2024     |
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'ARQCUCN1_1' of QC View summary on Order Proceed page
And fill following fields on Order Proceed page:
| Job Number | PO Number  |
| ARQCUJN1_2 | ARQCUPN1_2 |
And confirm order on Order Proceed page
When I go to asset 'ARQCUT1' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName          | FieldValue            |
| Advertiser         | ARQCUAR1              |
| Brand              | ARQCUBR1              |
| Sub Brand          | ARQCUSB1              |
| Product            | ARQCUPR1              |
| Clock number       | ARQCUCN1_1            |
| Additional Details | automated test info 2 |
| Duration           | 20                    |
| Air Date           | 12/12/2024            |
| Media sub-type     | QC-ed master          |


Scenario: Check that data is updated for all QC-ed clones in case to change data by editing any metadata field for one of them
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| ARQCUA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| ARQCUU1 | agency.admin | ARQCUA1      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ARQCUA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARQCUAR2_1 | ARQCUBR2_1 | ARQCUSB2_1 | ARQCUPR2_1 |
| ARQCUAR2_1 | ARQCUBR2_2 | ARQCUSB2_2 | ARQCUPR2_2 |
And logged in with details of 'ARQCUU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info 1  | ARQCUAR2_1 | ARQCUBR2_1 | ARQCUSB2_1 | ARQCUPR2_1 | ARQCUC2  | ARQCUCN2_1   | 20       | 10/14/2022     | HD 1080i 25fps | ARQCUT2 | None               | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave    | Destination        |
| ARQCUCN2_2   | ARQCUCL2 | Gol TV HD:Standard |
And complete order contains item with clock number 'ARQCUCN2_1' with following fields:
| Job Number | PO Number  |
| ARQCUJN2_1 | ARQCUPN2_1 |
And waited for '10' seconds
And add to 'tv' order item with clock number 'ARQCUCN2_2' following qc asset 'ARQCUT2' of collection 'My Assets'
And complete order with market 'Spain' with following fields:
| Job Number | PO Number  |
| ARQCUJN2_2 | ARQCUPN2_2 |
When I 'save' asset 'ARQCUT2' info of collection 'My Assets' by following informationNEWLIB:
| FieldName          | FieldValue            |
| Air Date           | 12/12/24            |
| Additional Details | automated test info 2 |
| Brand              | ARQCUBR2_2            |
| Sub Brand          | ARQCUSB2_2            |
| Product            | ARQCUPR2_2            |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName          | FieldValue            |
| Advertiser         | ARQCUAR2_1            |
| Brand              | ARQCUBR2_2            |
| Sub Brand          | ARQCUSB2_2            |
| Product            | ARQCUPR2_2            |
| Clock number       | ARQCUCN2_1            |
| Additional Details | automated test info 2 |
| Duration           | 20                    |
| Air Date           | 12/12/2024            |


Scenario: Check that data of master isn't updated in case to change data by editing any metadata field of QC-ed asset based on it
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| ARQCUA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| ARQCUU1 | agency.admin | ARQCUA1      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ARQCUA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARQCUAR2_1 | ARQCUBR2_1 | ARQCUSB2_1 | ARQCUPR2_1 |
| ARQCUAR2_1 | ARQCUBR2_2 | ARQCUSB2_2 | ARQCUPR2_2 |
And logged in with details of 'ARQCUU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Format         | Subtitles Required | Destination                 |
| automated test info 1  | ARQCUCN3_1   | HD 1080i 25fps | Adtext             | BSkyB Green Button:Standard |
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName          | FieldValue            |
| Advertiser         | ARQCUAR2_1            |
| Brand              | ARQCUBR2_2            |
| Sub Brand          | ARQCUSB2_2            |
| Product            | ARQCUPR2_2            |
| Campaign           | ARQCUC3               |
| Duration           | 15s                    |
| Air Date           | 12/12/24            |
| Clock number       | ARQCUCN3_2            |
| Additional Details | automated test info 2 |
| Screen       | Trailer    |
And added to 'tv' order item with clock number 'ARQCUCN3_1' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And updated 'tv' order item with clock number 'ARQCUCN3_2' by following fields:
| Title   |
| ARQCUT3 |
And completed order contains item with clock number 'ARQCUCN3_2' with following fields:
| Job Number | PO Number |
| ARQCUJN3   | ARQCUPN3  |
And 'save' asset 'ARQCUT3' info of collection 'My Assets' by following informationNEWLIB:
| FieldName          | FieldValue            |
| Additional Details | automated test info 1 |
| Air Date           | 10/14/22            |
| Brand              | ARQCUBR2_1            |
| Sub Brand          | ARQCUSB2_1            |
| Product            | ARQCUPR2_1            |
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName          | FieldValue            |
| Advertiser         | ARQCUAR2_1            |
| Brand              | ARQCUBR2_2            |
| Sub Brand          | ARQCUSB2_2            |
| Product            | ARQCUPR2_2            |
| Campaign           | ARQCUC3               |
| Clock number       | ARQCUCN3_2            |
| Additional Details | automated test info 2 |
| Duration           | 15s                   |
| Air Date           | 12/12/2024            |

Scenario: Check that data of QC-ed asset isn't updated in case to change data by editing any metadata of its master
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| ARQCUA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| ARQCUU1 | agency.admin | ARQCUA1      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ARQCUA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARQCUAR2_1 | ARQCUBR2_1 | ARQCUSB2_1 | ARQCUPR2_1 |
| ARQCUAR2_1 | ARQCUBR2_2 | ARQCUSB2_2 | ARQCUPR2_2 |
And logged in with details of 'ARQCUU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign | Clock Number | First Air Date | Format         | Subtitles Required | Destination                 |
| automated test info 1  | ARQCUAR2_1 | ARQCUBR2_1 | ARQCUSB2_1 | ARQCUPR2_1 | ARQCUC4  | ARQCUCN4_1   | 10/14/2022     | HD 1080i 25fps | Adtext             | BSkyB Green Button:Standard |
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish2-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish2-Ad.mov'NEWLIB
And add to 'tv' order item with clock number 'ARQCUCN4_1' following asset 'Fish2-Ad.mov' of collection 'My Assets'
And update 'tv' order item with clock number 'ARQCUCN4_1' by following fields:
| Title   |
| ARQCUT4 |
And complete order contains item with clock number 'ARQCUCN4_1' with following fields:
| Job Number | PO Number |
| ARQCUJN4   | ARQCUPN4  |
When I 'save' asset 'Fish2-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName          | FieldValue            |
| Duration           | 8s                    |
| Advertiser         | ARQCUAR2_1            |
| Brand              | ARQCUBR2_2            |
| Sub Brand          | ARQCUSB2_2            |
| Product            | ARQCUPR2_2            |
| Additional Details | automated test info 2 |
| Air Date           | 12/12/24            |
| Clock number       | ARQCUCN4_2            |
And go to asset 'ARQCUT4' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName          | FieldValue            |
| Advertiser         | ARQCUAR2_1            |
| Brand              | ARQCUBR2_1            |
| Sub Brand          | ARQCUSB2_1            |
| Product            | ARQCUPR2_1            |
| Clock number       | ARQCUCN4_1            |
| Additional Details | automated test info 1 |
| Duration           | 6s 33ms               |
| Air Date           | 10/14/2022            |


