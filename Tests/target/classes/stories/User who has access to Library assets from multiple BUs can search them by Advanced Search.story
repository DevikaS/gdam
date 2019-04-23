!--NGN-11688
Feature:          User who has access to Library assets from multiple BUs can search them by Advanced Search
Narrative:
In order to
As a              AgencyAdmin
I want to         User who has access to Library assets from multiple BUs can search them by Advanced Search




Scenario: Check that shared assets are displayed in collection created via advanced search (NGN-11283)
Meta:gdam
@library
Given I created the agency 'UWHATLAFMBUCSTBA_A1' with default attributes
And created the agency 'UWHATLAFMBUCSTBA_A2' with default attributes
And created users with following fields:
| Email                  | Role         | AgencyUnique        |Access|
| UWHATLAFMBUCSTBA_E01   | agency.admin | UWHATLAFMBUCSTBA_A1 |streamlined_library|
| UWHATLAFMBUCSTBA_E01_1 | agency.admin | UWHATLAFMBUCSTBA_A2 |streamlined_library|
And logged in with details of 'GlobalAdmin'
And I created 'test_library_role' role in 'library' group for advertiser 'UWHATLAFMBUCSTBA_A1' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.edit                 |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| file.download              |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And added following partners 'UWHATLAFMBUCSTBA_A2' to agency 'UWHATLAFMBUCSTBA_A1' on partners page
And logged in with details of 'UWHATLAFMBUCSTBA_E01'
When I go to the global 'common custom' metadata page for agency 'UWHATLAFMBUCSTBA_A1'
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser               | Brand                   | Sub Brand                | Product                  |
| AR_UWHATLAFMBUCSTBAS_S01 | B_UWHATLAFMBUCSTBAS_S01 | SB_UWHATLAFMBUCSTBAS_S01 | PT_UWHATLAFMBUCSTBAS_S01 |
And upload following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
And wait while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
And go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue               |
| Advertiser | AR_UWHATLAFMBUCSTBAS_S01 |
| Brand      | B_UWHATLAFMBUCSTBAS_S01  |
| Sub Brand  | SB_UWHATLAFMBUCSTBAS_S01 |
| Product    | PT_UWHATLAFMBUCSTBAS_S01 |
| Clock number      | Clk919          |
And create 'test_col' category
And add users 'UWHATLAFMBUCSTBA_E01_1' to category 'test_col' with role 'test_library_role' by users details
And shared next agencies for following categories:
| CategoryName | AgencyName          |
| test_col     | UWHATLAFMBUCSTBA_A2 |
And login with details of 'UWHATLAFMBUCSTBA_E01_1'
And I go to the collections page
And I go to the Shared Collection 'test_col' from agency 'UWHATLAFMBUCSTBA_A1' pageNEWLIB
And I select asset 'Fish Ad.mov' for collection 'test_col' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to the Library page for collection 'Everything'NEWLIB
And select 'Business Unit' with value 'UWHATLAFMBUCSTBA_A1' in the collection 'Everything'NEWLIB
And select 'Advertiser' with value 'AR_UWHATLAFMBUCSTBAS_S01' in the collection 'Everything'NEWLIB
And I add assets to 'new' collection 'C_USLOBU_S05' from collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish Ad.mov' in the collection 'C_USLOBU_S05'NEWLIB
And I 'should' see asset count '1' in 'C_USLOBU_S05' NEWLIB


Scenario: Check that values for dropdowns from another agency is not picked up in advanced search (NGN-11341)
Meta:@gdam
@library
Given I created the agency 'UWHATLAFMBUCSTBA_A1' with default attributes
And created the agency 'UWHATLAFMBUCSTBA_A2' with default attributes
And created users with following fields:
| Email                  | Role         | AgencyUnique        |Access|
| UWHATLAFMBUCSTBA_E01   | agency.admin | UWHATLAFMBUCSTBA_A1 |streamlined_library|
| UWHATLAFMBUCSTBA_E01_1 | agency.admin | UWHATLAFMBUCSTBA_A2 |streamlined_library|
And logged in with details of 'GlobalAdmin'
And I created 'test_library_role' role in 'library' group for advertiser 'UWHATLAFMBUCSTBA_A1' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.edit                 |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| file.download              |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And added following partners 'UWHATLAFMBUCSTBA_A2' to agency 'UWHATLAFMBUCSTBA_A1' on partners page
And logged in with details of 'UWHATLAFMBUCSTBA_E01'
When I go to the global 'common custom' metadata page for agency 'UWHATLAFMBUCSTBA_A1'
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser               | Brand                   | Sub Brand                | Product                  |
| AR_UWHATLAFMBUCSTBAS_S01 | B_UWHATLAFMBUCSTBAS_S01 | SB_UWHATLAFMBUCSTBAS_S01 | PT_UWHATLAFMBUCSTBAS_S01 |
And upload following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
And wait while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
And go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue               |
| Advertiser | AR_UWHATLAFMBUCSTBAS_S01 |
| Brand      | B_UWHATLAFMBUCSTBAS_S01  |
| Sub Brand  | SB_UWHATLAFMBUCSTBAS_S01 |
| Product    | PT_UWHATLAFMBUCSTBAS_S01 |
| Clock number      | Clk9219          |
And create 'test_col' category
And add users 'UWHATLAFMBUCSTBA_E01_1' to category 'test_col' with role 'test_library_role' by users details
And shared next agencies for following categories:
| CategoryName | AgencyName          |
| test_col     | UWHATLAFMBUCSTBA_A2 |
And login with details of 'UWHATLAFMBUCSTBA_E01_1'
And I go to the collections page
And I go to the Shared Collection 'test_col' from agency 'UWHATLAFMBUCSTBA_A1' pageNEWLIB
And I select asset 'Fish Ad.mov' for collection 'test_col' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And wait while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
And select 'Business Unit' with value 'UWHATLAFMBUCSTBA_A1' in the collection 'Everything'NEWLIB
And select 'Advertiser' with value 'AR_UWHATLAFMBUCSTBAS_S01' in the collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish Ad.mov' in the collection 'Everything'NEWLIB
And I 'should' see asset count '1' in 'Everything' NEWLIB



