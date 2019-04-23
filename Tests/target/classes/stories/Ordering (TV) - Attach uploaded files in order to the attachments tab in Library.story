!--ORD-3535
!--ORD-3645
Feature: Attach uploaded files in order to the attachments tab in Library
Narrative:
In order to:
As a AgencyAdmin
I want to check attaching uploaded files in order to the attachments tab in Library



Scenario: Check that attaches in Attachments tab are common for all clones of asset if attach new file for clone
!--ORD-3742
!--FAB-349
Meta: @ordering
      @obug
Given I created the following agency:
| Name     | A4User        |
| AUFTATA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AUFTATU1 | agency.admin | AUFTATA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AUFTATA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 |
And logged in with details of 'AUFTATU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 | AUFTATC3 | AUFTATCN3_1  | 20       | 08/14/2022     | HD 1080i 25fps | AUFTATT3 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave     | Destination        |
| AUFTATCN3_2  | AUFTATCL3 | Gol TV HD:Standard |
And upload to 'tv' order item with clock number 'AUFTATCN3_1' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'AUFTATCN3_1' with following fields:
| Job Number  | PO Number   |
| AUFTATJN3_1 | AUFTATPN3_1 |
And add to 'tv' order item with clock number 'AUFTATCN3_2' following qc asset 'AUFTATT3' of collection 'My Assets'
And complete order with market 'Spain' with following fields:
| Job Number  | PO Number   |
| AUFTATJN3_2 | AUFTATPN3_2 |
And attached new file '/files/New Text Document.txt' into collection 'My Assets' for qc asset 'AUFTATT3' on attachment assets page
Then I 'should' see following attached files 'file_2.txt,New Text Document.txt' on asset attachments page for each qc asset 'AUFTATT3' clone in collection 'My Assets'


Scenario: Check that files uploaded into order item appear in Attachments tab after confirming order and can be edited
!-- At the moment Attachment description and uploaded by are not yet implemented , once implemented then step needs to be modified
!--QA-995
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Application Access    |
| AUFTATA1 | DefaultA4User | streamlined_library   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Access         |
| AUFTATU1 | agency.admin | AUFTATA1     |streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AUFTATA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 |
And logged in with details of 'AUFTATU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 | AUFTATC1 | AUFTATCN1    | 20       | 08/14/2022     | HD 1080i 25fps | AUFTATT1 | Already Supplied   | BSkyB Green Button:Standard |
And upload to 'tv' order item with clock number 'AUFTATCN1' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'AUFTATCN1' with following fields:
| Job Number | PO Number |
| AUFTATJN1  | AUFTATPN1 |
And I am on qc asset 'AUFTATT1' info page in Library for collection 'My Assets' on attachment assets pageNEWLIB
Then I should see following data on asset attachments page for each qc asset 'AUFTATT1' clone of order with market 'United Kingdom' and item clock number 'AUFTATCN1' in collection 'My Assets'NEWLIB:
| File Name  | Size | Description | Uploaded By |
| file_2.txt | 13B |              | AUFTATU1    |
When edit attached file 'file_2.txt' on asset attachments page:
| File Name  | Size | Description |
| Janaki.txt | 13B  | Hello World |
Then I should see following data on asset attachments page:
| File Name  | Description   | Size   |
| Janaki.txt | Hello World   | 13B    |
When cancel editing of attached file 'Janaki.txt' on asset attachments page:
| File Name  | Size  | Description |
| Janaki2.txt | 13B  | Hi World    |
Then I should see following data on asset attachments page:
| File Name  | Description   | Size   |
| Janaki.txt | Hello World   | 13B    |


Scenario: Check that attaches in Attachments tab are common for all clones of asset
!-- At the moment Attachment details are not yet implemented so the then step needs to be modified accordingly
!--ORD-3647
!--FAB-349
Meta: @ordering
      @obug
Given I created the agency 'AUFTATA1' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |   Access                 |
| AUFTATU1 | agency.admin | AUFTATA1     |streamlined_library       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AUFTATA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 |
And logged in with details of 'AUFTATU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 | AUFTATC2 | AUFTATCN2_1  | 20       | 08/14/2022     | HD 1080i 25fps | AUFTATT2 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave     | Destination        |
| AUFTATCN2_2  | AUFTATCL2 | Gol TV HD:Standard |
And upload to 'tv' order item with clock number 'AUFTATCN2_1' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'AUFTATCN2_1' with following fields:
| Job Number  | PO Number   |
| AUFTATJN2_1 | AUFTATPN2_1 |
And add to 'tv' order item with clock number 'AUFTATCN2_2' following qc asset 'AUFTATT2' of collection 'My Assets'
And complete order with market 'Spain' with following fields:
| Job Number  | PO Number   |
| AUFTATJN2_2 | AUFTATPN2_2 |
And waited for '1' seconds
Then I should see following data on asset attachments page for each qc asset 'AUFTATT2' clone of order with market 'United Kingdom' and item clock number 'AUFTATCN2_1' in collection 'My Assets'NEWLIB:
| File Name  | Size | Description | Uploaded By |
| file_2.txt | 13B  |             | AUFTATU1    |

Scenario: Check that attaches in Attachments tab are common for all clones of asset if attach new file for clone
!--ORD-3742
!--FAB-349
Meta: @ordering
      @obug
Given I created the agency 'AUFTATA1' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |   Access              |
| AUFTATU1 | agency.admin | AUFTATA1     | streamlined_library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AUFTATA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 |
And logged in with details of 'AUFTATU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 | AUFTATC3 | AUFTATCN3_1  | 20       | 08/14/2022     | HD 1080i 25fps | AUFTATT3 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave     | Destination        |
| AUFTATCN3_2  | AUFTATCL3 | Gol TV HD:Standard |
And upload to 'tv' order item with clock number 'AUFTATCN3_1' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'AUFTATCN3_1' with following fields:
| Job Number  | PO Number   |
| AUFTATJN3_1 | AUFTATPN3_1 |
And add to 'tv' order item with clock number 'AUFTATCN3_2' following qc asset 'AUFTATT3' of collection 'My Assets'
And complete order with market 'Spain' with following fields:
| Job Number  | PO Number   |
| AUFTATJN3_2 | AUFTATPN3_2 |
And attached new file '/files/New Text Document.txt' into collection 'My Assets' for qc asset 'AUFTATT3' on attachment assets pageNEWLIB
Then I 'should' see following attached files 'file_2.txt,New Text Document.txt' on asset attachments page for each qc asset 'AUFTATT3' clone in collection 'My Assets'NEWLIB


Scenario: Check that attaches in Attachments tab are common for all clones of asset if remove an attached file from clone
!--ORD-3742
!--FAB-349
Meta: @ordering
      @obug
Given I created the agency 'AUFTATA1' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |  Access               |
| AUFTATU1 | agency.admin | AUFTATA1     | streamlined_library,library   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AUFTATA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 |
And logged in with details of 'AUFTATU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 | AUFTATC4 | AUFTATCN4_1  | 20       | 08/14/2022     | HD 1080i 25fps | AUFTATT4 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave     | Destination        |
| AUFTATCN4_2  | AUFTATCL4 | Gol TV HD:Standard |
And upload to 'tv' order item with clock number 'AUFTATCN4_1' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'AUFTATCN4_1' with following fields:
| Job Number  | PO Number   |
| AUFTATJN4_1 | AUFTATPN4_1 |
And add to 'tv' order item with clock number 'AUFTATCN4_2' following qc asset 'AUFTATT4' of collection 'My Assets'
And complete order with market 'Spain' with following fields:
| Job Number  | PO Number   |
| AUFTATJN4_2 | AUFTATPN4_2 |
And attached new file '/files/New Text Document.txt' into collection 'My Assets' for qc asset 'AUFTATT4' on attachment assets pageNEWLIB
And I am on qc asset 'AUFTATT4' info page in Library for collection 'My Assets' on attachment assets pageNEWLIB
When I delete following attached file 'New Text Document.txt' on asset attachments pageNEWLIB
Then I 'should not' see following attached file 'New Text Document.txt' on asset attachments page for each qc asset 'AUFTATT4' clone in collection 'My Assets'NEWLIB

Scenario: Check that attach in Attachments tab of QC-ed assets can be edited
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Application Access       |
| AUFTATA1 | DefaultA4User | streamlined_library      |
And created users with following fields:
| Email    | Role         | AgencyUnique | Access                  |
| AUFTATU1 | agency.admin | AUFTATA1     | streamlined_library,ordering      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AUFTATA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 |
And logged in with details of 'AUFTATU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 | AUFTATC5 | AUFTATCN5    | 20       | 08/14/2022     | HD 1080i 25fps | AUFTATT5 | Already Supplied   | BSkyB Green Button:Standard |
And upload to 'tv' order item with clock number 'AUFTATCN5' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'AUFTATCN5' with following fields:
| Job Number | PO Number |
| AUFTATJN5  | AUFTATPN5 |
When I go to qc asset 'AUFTATT5' info page in Library for collection 'My Assets' on attachment assets pageNEWLIB
And I edit attached files 'file_2.txt' on asset attachments page:
| File Name           | Description |
| file_2_new.txt | auto test   |
Then I should see following data on asset attachments page:
 | File Name      | Size |Description|
 | file_2_new.txt | 13B |auto test|



Scenario: Check attaches for clones after adding new attach for clone and confirm order with it and uploaded file
!--FAB-349
Meta: @ordering
      @obug
Given I created the following agency:
| Name     | A4User        |  Application Access       |
| AUFTATA1 | DefaultA4User |  streamlined_library      |
And created users with following fields:
| Email    | Role         | AgencyUnique |  Access              |
| AUFTATU1 | agency.admin | AUFTATA1     | streamlined_library  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AUFTATA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 |
And logged in with details of 'AUFTATU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 | AUFTATC6 | AUFTATCN6_1  | 20       | 08/14/2022     | HD 1080i 25fps | AUFTATT6 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave     | Destination        |
| AUFTATCN6_2  | AUFTATCL6 | Gol TV HD:Standard |
And upload to 'tv' order item with clock number 'AUFTATCN6_2' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'AUFTATCN6_1' with following fields:
| Job Number  | PO Number   |
| AUFTATJN6_1 | AUFTATPN6_1 |
And attached new file '/files/New Text Document.txt' into collection 'My Assets' for qc asset 'AUFTATT6' on attachment assets pageNEWLIB
And add to 'tv' order item with clock number 'AUFTATCN6_2' following qc asset 'AUFTATT6' of collection 'My Assets'
And complete order with market 'Spain' with following fields:
| Job Number  | PO Number   |
| AUFTATJN6_2 | AUFTATPN6_2 |
And waited for '3' seconds
Then I 'should' see following attached files 'file_2.txt,New Text Document.txt' on asset attachments page for each qc asset 'AUFTATT6' clone in collection 'My Assets'NEWLIB

Scenario: Check attaches for clones after adding new attach for clone and confirm order with it
!--FAB-349
Meta: @ordering
      @obug
Given I created the following agency:
| Name     | A4User        |   Application  Access    |
| AUFTATA1 | DefaultA4User |  streamlined_library     |
And created users with following fields:
| Email    | Role         | AgencyUnique |  Access                  |
| AUFTATU1 | agency.admin | AUFTATA1     |  streamlined_library     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AUFTATA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 |
And logged in with details of 'AUFTATU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | AUFTATAR1  | AUFTATBR1 | AUFTATSB1 | AUFTATPR1 | AUFTATC7 | AUFTATCN7_1  | 20       | 08/14/2022     | HD 1080i 25fps | AUFTATT7 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave     | Destination        |
| AUFTATCN7_2  | AUFTATCL7 | Gol TV HD:Standard |
And complete order contains item with clock number 'AUFTATCN7_1' with following fields:
| Job Number  | PO Number   |
| AUFTATJN7_1 | AUFTATPN7_1 |
And attached new file '/files/New Text Document.txt' into collection 'My Assets' for qc asset 'AUFTATT7' on attachment assets pageNEWLIB
And add to 'tv' order item with clock number 'AUFTATCN7_2' following qc asset 'AUFTATT7' of collection 'My Assets'
And complete order with market 'Spain' with following fields:
| Job Number  | PO Number   |
| AUFTATJN7_2 | AUFTATPN7_2 |
And waited for '3' seconds
Then I 'should' see following attached files 'New Text Document.txt' on asset attachments page for each qc asset 'AUFTATT7' clone in collection 'My Assets'NEWLIB