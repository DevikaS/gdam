Feature:          Check message when user does not library permissions
Narrative:
In order to
As a              AgencyAdmin
I want to         check message when user does not library permissions


Scenario: Check that message is displayed on library assets and collections page when user do not have asset.create and inbox.read permission
Meta:@gdam
@library
Given I created the agency 'LAC_A1' with default attributes
And created 'LAC_R1' role with 'asset_filter_category.read,asset.read' permissions in 'library' group for advertiser 'LAC_A1'
And I created users with following fields:
| Email       | Role         |Access                     | Agency|
| LAC_U01     | LAC_R1       |streamlined_library,library|LAC_A1 |
And logged in with details of 'LAC_U01'
When I am on the library assets page
Then I 'should' see message 'You do not have any library materials yet. Please contact your business unit administrator.' on library assets page
When I go to the collections page
Then I 'should' see message 'You do not have any library materials yet. Please contact your business unit administrator.' on collection page

Scenario: Check that message is displayed on library assets and My assets not shown on collections page when category is shared to user who is part of partner BU
Meta:@gdam
@library
Given I created the agency 'LAC_A2' with default attributes
And I created the agency 'LAC_A3' with default attributes
And I added agencies 'LAC_A3' as a partner to agency 'LAC_A2'
And created 'LAC_R2' role with 'asset_filter_category.read,asset.read' permissions in 'library' group for advertiser 'LAC_A2'
And I created users with following fields:
| Email       | Role           |Access                     | Agency|
| LAC_U02     | agency.admin   |streamlined_library,library|LAC_A2 |
| LAC_U03     | LAC_R2         |streamlined_library,library|LAC_A3 |
And logged in with details of 'LAC_U02'
And created following categories:
| Name         | MediaType |
| LAC_CAT_1 | video     |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| LAC_CAT_1     | LAC_U03  | library.admin  |
And logged in with details of 'LAC_U03'
When I am on the library assets page
Then I 'should' see message 'You do not have any library materials yet. Please contact your business unit administrator.' on library assets page
When I go to the collections page
Then I 'should not' see list of collections 'My Assets' on the collection pageNEWLIB

Scenario: Check that message is displayed on library assets and My assets not shown on collections page when category is shared to user who is part of same BU
Meta:@gdam
@library
Given I created the agency 'LAC_A4' with default attributes
And I created the agency 'LAC_A5' with default attributes
And I added agencies 'LAC_A5' as a partner to agency 'LAC_A4'
And created 'LAC_R3' role with 'asset_filter_category.read,asset.read' permissions in 'library' group for advertiser 'LAC_A4'
And I created users with following fields:
| Email       | Role           |Access                     | Agency|
| LAC_U04     | agency.admin   |streamlined_library,library|LAC_A4 |
| LAC_U05     | LAC_R3         |streamlined_library,library|LAC_A5 |
And logged in with details of 'LAC_U04'
And created following categories:
| Name         | MediaType |
| LAC_CAT_2 | video     |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| LAC_CAT_2     | LAC_U05  | library.admin  |
And logged in with details of 'LAC_U05'
When I am on the library assets page
Then I 'should' see message 'You do not have any library materials yet. Please contact your business unit administrator.' on library assets page
When I go to the collections page
Then I 'should not' see list of collections 'My Assets' on the collection pageNEWLIB

Scenario: Check that message is displayed on library assets and My assets not shown on collections page when category is shared to BU
Meta:@gdam
@library
Given I created the agency 'LAC_A6' with default attributes
And I created the agency 'LAC_A7' with default attributes
And I added agencies 'LAC_A7' as a partner to agency 'LAC_A6'
And created 'LAC_R4' role with 'asset_filter_category.read,asset.read' permissions in 'library' group for advertiser 'LAC_A6'
And I created users with following fields:
| Email       | Role           |Access                     | Agency|
| LAC_U06     | agency.admin   |streamlined_library,library|LAC_A6 |
| LAC_U07     | LAC_R4         |streamlined_library,library|LAC_A7 |
And logged in with details of 'LAC_U06'
And created following categories:
| Name         | MediaType |
| LAC_CAT_3 | video     |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| LAC_CAT_3 | LAC_A7 |
And logged in with details of 'LAC_U07'
When I am on the library assets page
Then I 'should' see message 'You do not have any library materials yet. Please contact your business unit administrator.' on library assets page
When I go to the collections page
Then I 'should not' see list of collections 'My Assets' on the collection pageNEWLIB

Scenario: Check that My assets is shown on collections page when user has asset.create permission
Meta:@gdam
@library
Given I created the agency 'LAC_A8' with default attributes
And created 'LAC_R5' role with 'asset_filter_category.read,asset.read,asset.create' permissions in 'library' group for advertiser 'LAC_A8'
And I created users with following fields:
| Email       | Role         |Access                     | Agency|
| LAC_U08     | LAC_R5       |streamlined_library,library|LAC_A8 |
And logged in with details of 'LAC_U08'
When I go to the collections page
Then I 'should' see list of collections 'My Assets' on the collection pageNEWLIB


Scenario: Check that user is redirected to library assets page when a asset is sending to library from projects
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And created 'P_URTLA' project
And created '/F_URTLA' folder for project 'P_URTLA'
And uploaded '/images/empty.logo.png' file into '/F_URTLA' folder for 'P_URTLA' project
And waited while preview is available in folder '/F_URTLA' on project 'P_URTLA' files page
When I send file 'empty.logo.png' on project 'P_URTLA' folder '/F_URTLA' page to Library
And click Save button on Add file to new library page
Then I 'should' be on 'NewLibrary' PageNEWLIB

