!--ORD-4558
!--ORD-4727
Feature: Add a validation to check that only assets with the same common fields are sent to the delivery
Narrative:
In order to:
As a AgencyAdmin
I want to check validation to check that only assets with the same common fields are sent to the delivery


Scenario: Check that assets with fields which marked as common and having different values in them cannot be sent to Delivery from Projects
Meta: @ordering
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        |
| AVDSDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDSDU1 | agency.admin | AVDSDA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDSDA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| AVDSDAR1_1 | AVDSDBR1_1 | AVDSDSB1_1 | AVDSDPR1_1 |
| AVDSDAR1_2 | AVDSDBR1_2 | AVDSDSB1_2 | AVDSDPR1_2 |
And I am on the global 'common custom' metadata page for agency 'AVDSDA1'
And clicked 'Advertiser' button in 'common metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'AVDSDU1'
And created 'AVDSDP2' project
And created '/AVDSDF2' folder for project 'AVDSDP2'
And uploaded into project 'AVDSDP2' following files:
| FileName            | Path     |
| /files/Fish1-Ad.mov | /AVDSDF2 |
| /files/Fish2-Ad.mov | /AVDSDF2 |
And waited while transcoding is finished in folder '/AVDSDF2' on project 'AVDSDP2' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/AVDSDF2' project 'AVDSDP2'
When I 'save' file info by next information:
| FieldName    | FieldValue |
| Advertiser   | AVDSDAR1_1 |
| Brand        | AVDSDBR1_1 |
| Sub Brand    | AVDSDSB1_1 |
| Product      | AVDSDPR1_1 |
And go to file 'Fish2-Ad.mov' info page in folder '/AVDSDF2' project 'AVDSDP2'
And 'save' file info by next information:
| FieldName    | FieldValue |
| Advertiser   | AVDSDAR1_2 |
| Brand        | AVDSDBR1_2 |
| Sub Brand    | AVDSDSB1_2 |
| Product      | AVDSDPR1_2 |
And go to project 'AVDSDP2' folder '/AVDSDF2' page
And click Send to Delivery for following files 'Fish1-Ad.mov,Fish2-Ad.mov' on project 'AVDSDP2' folder '/AVDSDF2' page
Then I should see message error 'You are not able to add another commercial to this order with different metadata. Please create a separate order.'


Scenario: Check that assets with fields which marked as common and having the same values in them can be sent to Delivery from Projects
Meta: @ordering
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        |
| AVDSDA3 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDSDU3 | agency.admin | AVDSDA3      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDSDA3':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDSDAR3   | AVDSDBR3 | AVDSDSB3  | AVDSDPR3 |
And I am on the global 'common custom' metadata page for agency 'AVDSDA3'
And clicked 'Advertiser' button in 'common metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'AVDSDU3'
And created 'AVDSDP4' project
And created '/AVDSDF4' folder for project 'AVDSDP4'
And uploaded into project 'AVDSDP4' following files:
| FileName            | Path     |
| /files/Fish1-Ad.mov | /AVDSDF4 |
| /files/Fish2-Ad.mov | /AVDSDF4 |
And waited while transcoding is finished in folder '/AVDSDF4' on project 'AVDSDP4' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/AVDSDF4' project 'AVDSDP4'
When I 'save' file info by next information:
| FieldName    | FieldValue |
| Advertiser   | AVDSDAR3   |
| Brand        | AVDSDBR3   |
| Sub Brand    | AVDSDSB3   |
| Product      | AVDSDPR3   |
And go to file 'Fish2-Ad.mov' info page in folder '/AVDSDF4' project 'AVDSDP4'
And 'save' file info by next information:
| FieldName    | FieldValue |
| Advertiser   | AVDSDAR3   |
| Brand        | AVDSDBR3   |
| Sub Brand    | AVDSDSB3   |
| Product      | AVDSDPR3   |
And go to project 'AVDSDP4' folder '/AVDSDF4' page
And send following files 'Fish1-Ad.mov,Fish2-Ad.mov' on project 'AVDSDP4' folder '/AVDSDF4' page to Delivery
Then I should see for active order item on cover flow following data:
| Title        | Counter |
| Fish2-Ad.mov | 2 of 2  |


Scenario: Check that assets with fields which marked as common and having different values in them cannot be sent to Delivery from Library
Meta:@ordering
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        |
| AVDSDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| AVDSDU1 | agency.admin | AVDSDA1      |streamlined_library,library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDSDA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| AVDSDAR1_1 | AVDSDBR1_1 | AVDSDSB1_1 | AVDSDPR1_1 |
| AVDSDAR1_2 | AVDSDBR1_2 | AVDSDSB1_2 | AVDSDPR1_2 |
And I am on the global 'common custom' metadata page for agency 'AVDSDA1'
And clicked 'Advertiser' button in 'common metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'AVDSDU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov,Fish2-Ad.mov'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
| Advertiser   | AVDSDAR1_1 |
| Brand        | AVDSDBR1_1 |
| Sub Brand    | AVDSDSB1_1 |
| Product      | AVDSDPR1_1 |
|Clock number  | Clk123         |
|Duration  | 15s         |
And I go to asset 'Fish2-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
| Advertiser   | AVDSDAR1_2 |
| Brand        | AVDSDBR1_2 |
| Sub Brand    | AVDSDSB1_2 |
| Product      | AVDSDPR1_2 |
|Clock number  | Clk456         |
|Duration  | 15s         |
And go to the Library page for collection 'My Assets'NEWLIB
And I refresh the page
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' in the 'My Assets'  library pageNEWLIB
And I click Send To Delivery from library 'My Assets' collectionNEWLIB
Then I 'should' see a message 'You are not able to add assets with different metadata to an order' in library collection 'My Assets'


Scenario: Check that assets with fields which marked as common and having the same values in them can be sent to Delivery from Library
Meta:@ordering
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        |
| AVDSDA3 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| AVDSDU3 | agency.admin | AVDSDA3      |streamlined_library,library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDSDA3':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDSDAR3   | AVDSDBR3 | AVDSDSB3  | AVDSDPR3 |
And I am on the global 'common custom' metadata page for agency 'AVDSDA3'
And clicked 'Advertiser' button in 'common metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'AVDSDU3'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
| Advertiser   | AVDSDAR3   |
| Brand        | AVDSDBR3   |
| Sub Brand    | AVDSDSB3   |
| Product      | AVDSDPR3   |
|Clock number  | ClkAVDSDAR3 |
And I go to asset 'Fish2-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
| Advertiser   | AVDSDAR3   |
| Brand        | AVDSDBR3   |
| Sub Brand    | AVDSDSB3   |
| Product      | AVDSDPR3   |
|Clock number  | ClkAVDSDAR4 |
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' in the 'My Assets'  library pageNEWLIB
And I click Send To Delivery from library 'My Assets' collectionNEWLIB
Then I should see for active order item on cover flow following data:
| Title        | Counter |
| Fish2-Ad.mov | 2 of 2  |


Scenario: Check that assets with Campaign field which marked as campaign and as common and having different values in it cannot be sent to Delivery from Library
Meta:@ordering
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        |
| AVDSDA5 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| AVDSDU5 | agency.admin | AVDSDA5      |streamlined_library,library,ordering|
And I am on the global 'common custom' metadata page for agency 'AVDSDA5'
And clicked 'Campaign' button in 'common metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'AVDSDU5'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Campaign   | AVDSDC5_1  |
|Clock number| ClkAVDSDC5_1 |
And I go to asset 'Fish2-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Campaign   | AVDSDC5_2  |
|Clock number| ClkAVDSDC5_2 |
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' in the 'My Assets'  library pageNEWLIB
And I click Send To Delivery from library 'My Assets' collectionNEWLIB
Then I 'should' see a message 'You are not able to add assets with different metadata to an order' in library collection 'My Assets'


Scenario: Check that assets with custom catalogue structure field which marked as common and having different values in it cannot be sent to Delivery from Library
Meta:@ordering
     @skip
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        |
| AVDSDA6 | DefaultA4User |
And I created 'GR_PIFCWLP_02' role in 'global' group for advertiser 'AVDSDA6' with following permissions:
| Permission                     |
| adkit.create                   |
| agency_team.read               |
| asset.create                   |
| asset_filter_collection.create |
| dictionary.read                |
| dictionary.add_on_the_fly      |
| enum.create                    |
| enum.read                      |
| enum.write                     |
| group.agency_enums.read        |
| presentation.create            |
| project.create                 |
| project_template.create        |
| role.read                      |
| user.invite                    |
| user.read                      |
| user_group.read                |
| tv_order.complete              |
| tv_order.create                |
| tv_order.delete                |
| tv_order.read                  |
| tv_order.write                 |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| AVDSDU6 | GR_PIFCWLP_02 | AVDSDA6      |streamlined_library,library,ordering|
And created following 'common' custom metadata fields for agency 'AVDSDA6':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'AVDSDA6' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And I am on the global 'common custom' metadata page for agency 'AVDSDA6'
And clicked 'Advertiser Custom' button in 'common metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'AVDSDU6'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName         | FieldValue |
| Advertiser Custom | AVDSDAR6_1 |
| Brand Custom      | AVDSDBR6_1 |
| Product Custom    | AVDSDSB6_1 |
| Campaign Custom   | AVDSDC6_1  |
|Clock number       | ClkAVDSDAR6_1 |
And I go to asset 'Fish2-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName         | FieldValue |
| Advertiser Custom | AVDSDAR6_2 |
| Brand Custom      | AVDSDBR6_2 |
| Product Custom    | AVDSDSB6_2 |
| Campaign Custom   | AVDSDC6_2  |
|Clock number       | ClkAVDSDAR6_2 |
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' in the 'My Assets'  library pageNEWLIB
And I click Send To Delivery from library 'My Assets' collectionNEWLIB
Then I 'should' see a message 'You are not able to add assets with different metadata to an order' in library collection 'My Assets'


