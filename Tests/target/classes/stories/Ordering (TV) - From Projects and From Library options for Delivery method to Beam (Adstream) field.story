!--ORD-4477
!--ORD-5259
Feature: From Projects and From Library options for Delivery method to Beam (Adstream) field
Narrative:
In order to:
As a AgencyAdmin
I want to check From Projects and From Library options for Delivery method to Beam (Adstream) field

Scenario: Check that From Library is shown in Delivery method to Adstream on View Destination Details popup
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FPFLOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| FPFLOU1 | agency.admin | FPFLOA1      |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FPFLOA1':
| Advertiser | Brand    | Sub Brand | Product |
| FPFLOAR1   | FPFLOBR1 | FPFLOSB1  | FPFLOP1 |
And logged in with details of 'FPFLOU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | FPFLOAR1   | FPFLOBR1 | FPFLOSB1  | FPFLOP1 | FPFLOC1  | FPFLOCN1     | 20       | 12/14/2022     | HD 1080i 25fps | FPFLOT1 | Already Supplied   | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'FPFLOCN1' following asset 'Fish1-Ad.mov' of collection 'My Assets'
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand    | Sub Brand | Product | Title        | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| FPFLOCN1     |            |           | 1                 | 1                 | United Kingdom | FPFLOAR1   | FPFLOBR1 | FPFLOSB1  | FPFLOP1 | Fish1-Ad.mov | 6s 33ms  | HD 1080i 25fps | From Library    |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |


Scenario: Check that From Library is shown in Delivery method to Beam on View Destination Details popup
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Labels |
| FPFLOA2 | DefaultA4User | Beam   |
And created users with following fields:
| Email   | Role         | AgencyUnique | Language |Access|
| FPFLOU2 | agency.admin | FPFLOA2      | en-beam  |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FPFLOA2':
| Advertiser | Brand    | Sub Brand | Product |
| FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 |
And logged in with details of 'FPFLOU2'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 | FPFLOC2  | FPFLOCN2     | 20       | 12/14/2022     | HD 1080i 25fps | FPFLOT2 | Already Supplied   | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'FPFLOCN2' following asset 'Fish1-Ad.mov' of collection 'My Assets'
Then I should see following data for order items on View 'Beam' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand    | Sub Brand | Product | Title        | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| FPFLOCN2     |            |           | 1                 | 1                 | United Kingdom | FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 | Fish1-Ad.mov | 6s 33ms  | HD 1080i 25fps | From Library    |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |


Scenario: Check that From Projects is shown in Delivery method to Adstream on View Destination Details popup
Meta: @ordering
      @skip
!--Reason to skip - Invalid scenario considering transcoded file doesn't have all metadata. When file is updated with metadata then scenario works fine and a valid scenario too.
Given I created the following agency:
| Name    | A4User        |
| FPFLOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| FPFLOU1 | agency.admin | FPFLOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FPFLOA1':
| Advertiser | Brand    | Sub Brand | Product |
| FPFLOAR1   | FPFLOBR1 | FPFLOSB1  | FPFLOP1 |
And logged in with details of 'FPFLOU1'
And created new project with following fields:
| FieldName          | FieldValue        |
| Name               | FPFLOP3         |
| Advertiser         | FPFLOAR1        |
| Brand              | FPFLOBR1        |
| Sub Brand          | FPFLOSB1        |
| Product            | FPFLOP1         |
| Media type         | Broadcast        |
| Start Date         | Today            |
| End Date           | Tomorrow         |
And created '/FPFLOF3' folder for project 'FPFLOP3'
And uploaded into project 'FPFLOP3' following files:
| FileName             | Path     |
| /files/Fish1-Ad.mov  | /FPFLOF3 |
And waited while transcoding is finished in folder '/FPFLOF3' on project 'FPFLOP3' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | FPFLOAR1   | FPFLOBR1 | FPFLOSB1  | FPFLOP1 | FPFLOC3  | FPFLOCN3     | 20       | 12/14/2022     | HD 1080i 25fps | FPFLOT3 | Already Supplied   | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'FPFLOCN3' following file '/files/Fish1-Ad.mov' from folder '/FPFLOF3' of project 'FPFLOP3'
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand    | Sub Brand | Product | Title        | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| FPFLOCN3     |            |           | 1                 | 1                 | United Kingdom | FPFLOAR1   | FPFLOBR1 | FPFLOSB1  | FPFLOP1 | Fish1-Ad.mov | 6s 33ms  | HD 1080i 25fps | From Projects   |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |


Scenario: Check that From Projects is shown in Delivery method to Beam on View Destination Details popup
Meta: @ordering
      @skip
!--Reason to skip - Invalid scenario considering transcoded file doesn't have all metadata. When file is updated with metadata then scenario works fine and a valid scenario too.
Given I created the following agency:
| Name    | A4User        | Labels |
| FPFLOA2 | DefaultA4User | Beam   |
And created users with following fields:
| Email   | Role         | AgencyUnique | Language |
| FPFLOU2 | agency.admin | FPFLOA2      | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FPFLOA2':
| Advertiser | Brand    | Sub Brand | Product |
| FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 |
And logged in with details of 'FPFLOU2'
And created new project with following fields:
| FieldName          | FieldValue        |
| Name               | FPFLOP4         |
| Advertiser         | FPFLOAR2        |
| Brand              | FPFLOBR2        |
| Sub Brand          | FPFLOSB2        |
| Product            | FPFLOP2         |
| Media type         | Broadcast        |
| Start Date         | Today            |
| End Date           | Tomorrow         |
And created '/FPFLOF4' folder for project 'FPFLOP4'
And uploaded into project 'FPFLOP4' following files:
| FileName             | Path     |
| /files/Fish1-Ad.mov  | /FPFLOF4 |
And waited while transcoding is finished in folder '/FPFLOF4' on project 'FPFLOP4' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 | FPFLOC4  | FPFLOCN4     | 20       | 12/14/2022     | HD 1080i 25fps | FPFLOT4 | Already Supplied   | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'FPFLOCN4' following file '/files/Fish1-Ad.mov' from folder '/FPFLOF4' of project 'FPFLOP4'
Then I should see following data for order items on View 'Beam' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand    | Sub Brand | Product | Title        | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| FPFLOCN4     |            |           | 1                 | 1                 | United Kingdom | FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 | Fish1-Ad.mov | 6s 33ms  | HD 1080i 25fps | From Projects   |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |


Scenario: Check that From Library is shown in Delivery method to Beam in confirmation email
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        | Labels |
| FPFLOA2 | DefaultA4User | Beam   |
And created users with following fields:
| Email   | Role         | AgencyUnique | Language |Access|
| FPFLOU2 | agency.admin | FPFLOA2      | en-beam  |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FPFLOA2':
| Advertiser | Brand    | Sub Brand | Product |
| FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 |
And logged in with details of 'FPFLOU2'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 | FPFLOC5  | FPFLOCN5     | 20       | 12/14/2022     | HD 1080i 25fps | FPFLOT5 | Already Supplied   | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'FPFLOCN5' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And complete order contains item with clock number 'FPFLOCN5' with following fields:
| Job Number | PO Number |
| FPFLOJN5   | FPFLOPN5  |
Then I 'should' see email notification for 'Order Confirmation' with field to 'FPFLOU2' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser | Brand    | Sub Brand | Product | Title        | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination         | Service Level |
| beam         | FPFLOU2  | FPFLOCN5     | FPFLOJN5   | FPFLOPN5  | 1                 | 1                 | United Kingdom | FPFLOCN5  | FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 | Fish1-Ad.mov | 6s 33ms  | HD 1080i 25fps | From Library    |               | 12/14/2022     | Yes     | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button  | Standard      |


Scenario: Check that From Projects is shown in Delivery method to Beam in confirmation email
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        | Labels |
| FPFLOA2 | DefaultA4User | Beam   |
And created users with following fields:
| Email   | Role         | AgencyUnique | Language |
| FPFLOU2 | agency.admin | FPFLOA2      | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FPFLOA2':
| Advertiser | Brand    | Sub Brand | Product |
| FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 |
And logged in with details of 'FPFLOU2'
And created new project with following fields:
| FieldName          | FieldValue        |
| Name               | FPFLOP4         |
| Advertiser         | FPFLOAR2        |
| Brand              | FPFLOBR2        |
| Sub Brand          | FPFLOSB2        |
| Product            | FPFLOP2         |
| Media type         | Broadcast        |
| Start date         | Today            |
| End date           | Tomorrow         |
And created '/FPFLOF4' folder for project 'FPFLOP4'
And uploaded into project 'FPFLOP4' following files:
| FileName             | Path     |
| /files/Fish1-Ad.mov  | /FPFLOF4 |
And waited while transcoding is finished in folder '/FPFLOF4' on project 'FPFLOP4' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 | FPFLOC6  | FPFLOCN6     | 20       | 12/14/2022     | HD 1080i 25fps | FPFLOT6 | Already Supplied   | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'FPFLOCN6' following file '/files/Fish1-Ad.mov' from folder '/FPFLOF4' of project 'FPFLOP4'
And complete order contains item with clock number 'FPFLOCN6' with following fields:
| Job Number | PO Number |
| FPFLOJN6   | FPFLOPN6  |
And waited for '30' seconds
Then I 'should' see email notification for 'Order Confirmation' with field to 'FPFLOU2' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser | Brand    | Sub Brand | Product | Title        | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination         | Service Level |
| beam         | FPFLOU2  | FPFLOCN6     | FPFLOJN6   | FPFLOPN6  | 1                 | 1                 | United Kingdom | FPFLOCN6  | FPFLOAR2   | FPFLOBR2 | FPFLOSB2  | FPFLOP2 | Fish1-Ad.mov | 6s 33ms  | HD 1080i 25fps | From Projects   |               | 12/14/2022     | Yes     | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button  | Standard      |