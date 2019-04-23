!--ORD-2768
!--ORD-3407
Feature: Market Specific metadata fed to Library
Narrative:
In order to:
As a AgencyAdmin
I want to check that market specific metadata correctly works for Library

Scenario: Check that data specific market is loaded for specific market into order item in case to retrieve from Library qc asset
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MSMFLA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MSMFLU1 | agency.admin | MSMFLA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSMFLA1':
| Advertiser | Brand    | Sub Brand | Product  |
| MSMFLAR1   | MSMFLBR1 | MSMFLSB1  | MSMFLPR1 |
And logged in with details of 'MSMFLU1'
And create 'tv' order with market 'Brasil' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | CNPJ       | CRT       | Date of Ancine Registration | Director | Market Segment | Number of Versions | Type     | Subtitles Required | Destination          |
| automated test info    | MSMFLAR1   | MSMFLBR1 | MSMFLSB1  | MSMFLPR1 | MSMFLC1  | MSMFLCN1_1   | 20       | 10/14/2022     | HD 1080i 25fps | MSMFLT1 | MSMFLCNPJ1 | MSMFLCRT1 | 10/14/2024                  | MSMFLD1  | MSMFLMS1       | 2                  | MSMFLTP1 | Yes                | Bloomberg Brasil:Standard |
And create 'tv' order with market 'Brasil' and items with following fields:
| Clock Number | Additional Information |
| MSMFLCN1_2   | automated test info 2  |
And complete order contains item with clock number 'MSMFLCN1_1' with following fields:
| Job Number | PO Number |
| MSMFLJN1   | MSMFLPN1  |
And add to 'tv' order item with clock number 'MSMFLCN1_2' following qc asset 'MSMFLT1' of collection 'My Assets'
When I open order item with following clock number 'MSMFLCN1_1'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format      | Title   | CNPJ       | CRT       | Date of Ancine Registration | Director | Market Segment | Number of Versions | Type     | Subtitles Required |
| automated test info 2  | MSMFLAR1   | MSMFLBR1 | MSMFLSB1  | MSMFLPR1 | MSMFLC1  | MSMFLCN1_1   | 20       | 10/14/2022     | SD NTSC 4x3 | MSMFLT1 | MSMFLCNPJ1 | MSMFLCRT1 | 10/14/2024                  | MSMFLD1  | MSMFLMS1       | 2                  | MSMFLTP1 | Already Supplied   |

Scenario: Check that data into market specific is correctly displayed on asset details of QC-ed asset after confirming order
Meta: @ordering
      @obug
!--UIR-1022
Given I created the following agency:
| Name    | A4User        |
| MSMFLA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| MSMFLU1 | agency.admin | MSMFLA1      |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSMFLA1':
| Advertiser | Brand    | Sub Brand | Product  |
| MSMFLAR1   | MSMFLBR1 | MSMFLSB1  | MSMFLPR1 |
And logged in with details of 'MSMFLU1'
And create 'tv' order with market 'Brasil' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | CNPJ       | CRT       | Date of Ancine Registration | Director | Market Segment | Number of Versions | Type     | Subtitles Required | Destination          |
| automated test info    | MSMFLAR1   | MSMFLBR1 | MSMFLSB1  | MSMFLPR1 | MSMFLC2  | MSMFLCN2     | 20       | 10/14/2022     | HD 1080i 25fps | MSMFLT2 | MSMFLCNPJ2 | MSMFLCRT2 | 10/14/2024                  | MSMFLD2  | MSMFLMS2       | 2                  | MSMFLTP2 | Yes                | Bloomberg Brasil:Standard |
And complete order contains item with clock number 'MSMFLCN2' with following fields:
| Job Number | PO Number |
| MSMFLJN2   | MSMFLPN2  |
And I am on asset 'MSMFLT2' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue |
| CNPJ                        | MSMFLCNPJ2 |
| CRT                         | MSMFLCRT2  |
| Date of Ancine Registration | 10/14/2024   |
| Director                    | MSMFLD2    |
| Market Segment              | MSMFLMS2   |
| Number of Versions          | 2          |
| Type                        | MSMFLTP2   |
| Subtitles Required          | Yes        |








Scenario: Check that data specific market with market specific fields cannot be specified on files details in project
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MSMFLA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MSMFLU1 | agency.admin | MSMFLA1      |
And logged in with details of 'MSMFLU1'
And created 'MSMFLP10' project
And created '/MSMFLF10' folder for project 'MSMFLP10'
And uploaded into project 'MSMFLP10' following files:
| FileName             | Path      |
| /files/Fish8-Ad.mov  | /MSMFLF10 |
And waited while transcoding is finished in folder '/MSMFLF10' on project 'MSMFLP10' files page
And I am on file 'Fish8-Ad.mov' info page in folder '/MSMFLF10' project 'MSMFLP10'
When I click Edit link on file info page
Then I 'should not' see following fields on opened Edit file popup:
| FieldName |
| Market    |

Scenario: Check that data into market specific fields are indentical for all clones except master
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MSMFLA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| MSMFLU1 | agency.admin | MSMFLA1      |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSMFLA1':
| Advertiser | Brand    | Sub Brand | Product  |
| MSMFLAR1   | MSMFLBR1 | MSMFLSB1  | MSMFLPR1 |
And logged in with details of 'MSMFLU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Subtitles Required | Destination                 |
| automated test info    | MSMFLAR1   | MSMFLBR1 | MSMFLSB1  | MSMFLPR1 | MSMFLC11 | MSMFLCN11_1  | 20       | 10/14/2022     | HD 1080i 25fps | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave     | Destination        |
| MSMFLCN11_2  | MSMFLCL11 | Gol TV HD:Standard |
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish9-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish9-Ad.mov'NEWLIB
And add to 'tv' order item with clock number 'MSMFLCN11_1' following asset 'Fish9-Ad.mov' of collection 'My Assets'
And update 'tv' order item with clock number 'MSMFLCN11_1' by following fields:
| Title    |
| MSMFLT11 |
And complete order contains item with clock number 'MSMFLCN11_1' with following fields:
| Job Number  | PO Number   |
| MSMFLJN11_1 | MSMFLPN11_1 |
And add to 'tv' order item with clock number 'MSMFLCN11_2' following qc asset 'MSMFLT11' of collection 'My Assets'
And complete order with market 'Spain' with following fields:
| Job Number  | PO Number   |
| MSMFLJN11_2 | MSMFLPN11_2 |
When I go to asset 'MSMFLT11' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName          | FieldValue       |
| Subtitles Required | Already Supplied |
| Clave              | MSMFLCL11        |
When I go to asset 'Fish9-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should not' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName          | FieldValue       |
| Subtitles Required | Already Supplied |
| Clave              | MSMFLCL11        |


