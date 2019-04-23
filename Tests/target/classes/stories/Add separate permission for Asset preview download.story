!--NGN-9307
Feature:          Add separate permission for Asset preview download
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check separate permission for Asset preview download

Scenario: Check that proxy.download permission enabled by default for library.admin and library.user roles
Meta:@globaladmin
     @gdam
Given I created the agency 'A_ASPFAPD_S01' with default attributes
And logged in with details of 'GlobalAdmin'
When I open role '<GlobalRole>' page with parent 'A_ASPFAPD_S01'
Then I 'should' see '<PermissionState>' permissions 'proxy.download' on opened global role page

Examples:
| GlobalRole    | PermissionState |
| library.admin | selected        |
| library.user  | selected        |


Scenario: Check that after share category for user without proxy.download permission in library role, download buttons for proxy and custom formats does not avalable in asset
Meta:@gdam
     @library
Given I created users with following fields:
| Email         | Role        |Access|
| U_ASPFAPD_S02 | agency.user |streamlined_library|
And created 'LR_ASPFAPD_S02' role in 'library' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| file.download              |
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_ASPFAPD_S02' category
When I add users 'U_ASPFAPD_S02' for category 'C_ASPFAPD_S02' with role 'LR_ASPFAPD_S02'
And login with details of 'U_ASPFAPD_S02'
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'C_ASPFAPD_S02'NEWLIB
Then I 'should not' see 'download proxy' button on opened asset info pageNEWLIB

Scenario: Check that after share folder for user, with proxy.download permission in library role, download buttons for proxy and custom formats are avalable in asset (Asset > Info > Download button)
Meta:@library
     @gdam
Given I created users with following fields:
| Email         | Role        | Access          |
| U_ASPFAPD_S04 | agency.user | streamlined_library,folders |
And created 'LR_ASPFAPD_S04' role in 'library' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| file.download              |
| proxy.download             |
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_ASPFAPD_S04' category
And added users 'U_ASPFAPD_S04' for category 'C_ASPFAPD_S04' with role 'LR_ASPFAPD_S04'
And logged in with details of 'U_ASPFAPD_S04'
And created 'P_ASPFAPD_S04' project
And created '/F_ASPFAPD_S04' folder for project 'P_ASPFAPD_S04'
When I add following asset 'Fish1-Ad.mov' of collection 'C_ASPFAPD_S04' to project 'P_ASPFAPD_S04' folder '/F_ASPFAPD_S04'NEWLIB
And go to project 'P_ASPFAPD_S04' folder '/F_ASPFAPD_S04' page
And select file 'Fish1-Ad.mov' on project files page
Then I 'should' see Download link for 'proxy' type on Download popup for project 'P_ASPFAPD_S04' folder '/F_ASPFAPD_S04'
Then I 'should' see Download link for 'proxy' type on Download popup on file 'Fish1-Ad.mov' info page for project 'P_ASPFAPD_S04' folder '/F_ASPFAPD_S04'
And 'should' see Download proxy button on file 'Fish1-Ad.mov' info page in folder '/F_ASPFAPD_S04' project 'P_ASPFAPD_S04'



Scenario: Check that after share category for user with proxy.download permission in library role, asset could be playouted (mov, mpg, wmv, mp3)
Meta:@gdam
     @library
Given I created users with following fields:
| Email          | Role         |Access|
| AU_ASPFAPD_S05 | agency.admin |streamlined_library,library|
| U_ASPFAPD_S05  | agency.user  |streamlined_library,library|
And created 'LR_ASPFAPD_S05' role in 'library' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| file.download              |
| proxy.download             |
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And uploaded file '/files/Fish1-Ad.mpg' into libraryNEWLIB
And uploaded file '/files/Fish1-Ad.wmv' into libraryNEWLIB
And uploaded file '/files/Fish1-Ad.mp3' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_ASPFAPD_S05' category
And added users 'U_ASPFAPD_S05' for category 'C_ASPFAPD_S05' with role 'LR_ASPFAPD_S05'
And logged in with details of 'U_ASPFAPD_S05'
Then I 'should' be able to play 'video' clip on asset 'Fish1-Ad.mov' info page for collection 'C_ASPFAPD_S05' NEWLIB
And I 'should' be able to play 'video' clip on asset 'Fish1-Ad.mpg' info page for collection 'C_ASPFAPD_S05' NEWLIB
And I 'should' be able to play 'video' clip on asset 'Fish1-Ad.wmv' info page for collection 'C_ASPFAPD_S05' NEWLIB
And I 'should' be able to play 'audio' clip on asset 'Fish1-Ad.mp3' info page for collection 'C_ASPFAPD_S05' NEWLIB


