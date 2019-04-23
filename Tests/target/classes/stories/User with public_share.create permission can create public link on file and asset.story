!--NGN-9374
Feature:          User with public_share.create permission can create public link on file and asset
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check that user with permission public_share.create permission can create public link on file and asset

Scenario: check that permission public_share.create is available for custom roles
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And created '<RoleName>' role in '<GroupName>' group for advertiser 'DefaultAgency'
When I open role '<RoleName>' page with parent 'DefaultAgency'
Then I '<AssetCondition>' see 'available' permissions 'asset.public_share.create' on opened global role page
Then I '<ElementCondition>' see 'available' permissions 'element.public_share.create' on opened global role page

Examples:
| RoleName         | GroupName | AssetCondition | ElementCondition |
| GR_UPPSCCAPL_S01 | global    | should         | should           |
| LR_UPPSCCAPL_S01 | library   | should         | should not       |
| PR_UPPSCCAPL_S01 | project   | should not     | should           |



Scenario: check that agency user with asset.public_share.create permission can create Public Link on Asset
Meta:@gdamemails
     @gdam
Given I created 'GR_UPPSCCAPL_S04' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission                   |
| asset_filter_category.create |
| asset.create                 |
| asset.write                  |
| asset.share                  |
| asset.public_share.write     |
| asset.public_share.create    |
And created users with following fields:
| Email           | Role             |Access|
| U_UPPSCCAPL_S04 | GR_UPPSCCAPL_S04 |streamlined_library|
| U_UPPSCCAPL_S05 | GR_UPPSCCAPL_S04 |streamlined_library|
And logged in with details of 'U_UPPSCCAPL_S04'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I send public link of asset 'Fish1-Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails        | Message |
| U_UPPSCCAPL_S05 | hi dude |
And logout from account
And open link from email when user 'U_UPPSCCAPL_S05' received email with next subject 'has shared file with you'
Then I 'should' be on public file preview page



Scenario: Check that public_share.create permission by default enabled for agency.admin only
Meta:@globaladmin
     @gdam
Given I created the agency 'A_UPPSCCAPL_S09' with default attributes
And logged in with details of 'GlobalAdmin'
When I open role '<GlobalRole>' page with parent 'A_UPPSCCAPL_S09'
Then I 'should' see '<PermissionState>' permissions 'asset.public_share.create,element.public_share.create' on opened global role page

Examples:
| GlobalRole    | PermissionState |
| agency.admin  | selected        |
| agency.user   | unselected      |
| guest.user    | unselected      |


Scenario: check that agency user with asset.public_share.create permission can create Public Link on Asset (tab public available)
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |Access|
| <UserEmail> | agency.user |streamlined_library,library|
And created '<LibraryRole>' role in 'library' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.share                |
| <Permission>               |
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UPPSCCAPL_S02' category
And added users '<UserEmail>' to category 'C_UPPSCCAPL_S02' with role '<LibraryRole>' by users details
When I login with details of '<UserEmail>'
And go to the Library page for collection 'C_UPPSCCAPL_S02'NEWLIB
And I select asset 'Fish1-Ad.mov' in the 'C_UPPSCCAPL_S02'  library pageNEWLIB
Then I '<Condition>' see 'PUBLIC LINK' tab on opened Share files popup from collection 'C_UPPSCCAPL_S02'NEWLIB

Examples:
| UserEmail         | LibraryRole        | Permission                | Condition  |
| U_UPPSCCAPL_S02_1 | LR_UPPSCCAPL_S02_1 | asset.public_share.create | should     |
| U_UPPSCCAPL_S02_2 | LR_UPPSCCAPL_S02_2 |                           | should not |



Scenario: check that agency user with element.public_share.create permission can create Public Link on Asset (tab public available)
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission    |
| project.read  |
| folder.read   |
| folder.share  |
| element.read  |
| element.write |
| element.share |
| <Permission>  |
And created 'P_UPPSCCAPL_S03' project
And created '/F_UPPSCCAPL_S03' folder for project 'P_UPPSCCAPL_S03'
And uploaded '/files/Fish1-Ad.mov' file into '/F_UPPSCCAPL_S03' folder for 'P_UPPSCCAPL_S03' project
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in folder '/F_UPPSCCAPL_S03' on project 'P_UPPSCCAPL_S03' files page
And fill Share popup by users '<UserEmail>' in project 'P_UPPSCCAPL_S03' for following folders '/F_UPPSCCAPL_S03' with role '<ProjectRole>' expired '12.12.2021' and 'should' access to subfolders
When I login with details of '<UserEmail>'
And go to project 'P_UPPSCCAPL_S03' folder '/F_UPPSCCAPL_S03' page
And select file 'Fish1-Ad.mov' on project files page
And click element 'ShareFiles' on page 'FilesPage'
Then I '<Condition>' see Public share tab on opened Share files popup

Examples:
| UserEmail         | ProjectRole        | Permission                  | Condition  |
| U_UPPSCCAPL_S03_1 | PR_UPPSCCAPL_S03_1 | element.public_share.create | should     |
| U_UPPSCCAPL_S03_2 | PR_UPPSCCAPL_S03_2 |                             | should not |



Scenario: check that with element.public_share.create permission, user should see Public Link Access tab on File Share popup
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission    |
| project.read  |
| folder.read   |
| folder.share  |
| element.read  |
| element.write |
| element.share |
| <Permission>  |
And created 'P_UPPSCCAPL_S08' project
And created '/F_UPPSCCAPL_S08' folder for project 'P_UPPSCCAPL_S08'
And uploaded '/files/Fish1-Ad.mov' file into '/F_UPPSCCAPL_S08' folder for 'P_UPPSCCAPL_S08' project
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in folder '/F_UPPSCCAPL_S08' on project 'P_UPPSCCAPL_S08' files page
And fill Share popup by users '<UserEmail>' in project 'P_UPPSCCAPL_S08' for following folders '/F_UPPSCCAPL_S08' with role '<ProjectRole>' expired '12.12.2021' and 'should' access to subfolders
When I login with details of '<UserEmail>'
And go to project 'P_UPPSCCAPL_S08' folder '/F_UPPSCCAPL_S08' page
And select file 'Fish1-Ad.mov' on project files page
And click element 'ShareFiles' on page 'FilesPage'
Then I '<Condition>' see Public Link Access tab on opened Share files popup

Examples:
| UserEmail         | UserGlobalRole | ProjectRole        | Permission                  | Condition  |
| U_UPPSCCAPL_S08_1 | agency.user    | PR_UPPSCCAPL_S08_1 | element.public_share.create | should     |
| U_UPPSCCAPL_S08_2 | agency.user    | PR_UPPSCCAPL_S08_2 |                             | should not |
| U_UPPSCCAPL_S08_3 | guest.user     | PR_UPPSCCAPL_S08_1 | element.public_share.create | should     |
| U_UPPSCCAPL_S08_4 | guest.user     | PR_UPPSCCAPL_S08_2 |                             | should not |

Scenario: check that agency user with element.public_share.create permission can create Public Link on File
Meta:@gdam
     @gdamemails
Given I created 'GR_UPPSCCAPL_S05' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission                  |
| project.create              |
| folder.create               |
| folder.share                |
| element.create              |
| element.write               |
| element.share               |
| element.public_share.create |
And created users with following fields:
| Email           | Role             |Access|
| U_UPPSCCAPL_S05 | GR_UPPSCCAPL_S05 |folders,adkits|
And logged in with details of 'U_UPPSCCAPL_S05'
And created 'P_UPPSCCAPL_S05' project
And created '/F_UPPSCCAPL_S05' folder for project 'P_UPPSCCAPL_S05'
And uploaded '/files/Fish1-Ad.mov' file into '/F_UPPSCCAPL_S05' folder for 'P_UPPSCCAPL_S05' project
And waited while transcoding is finished in folder '/F_UPPSCCAPL_S05' on project 'P_UPPSCCAPL_S05' files page
When I send public link of file 'Fish1-Ad.mov' from folder '/F_UPPSCCAPL_S05' and project 'P_UPPSCCAPL_S05' to following users:
| UserEmails        | Message |
| NAU_UPPSCCAPL_S05 | hi dude |
And logout from account
And open link from email when user 'NAU_UPPSCCAPL_S05' received email with next subject 'shared file with you'
And I refresh the page
Then I 'should' be on public file preview page

Scenario: check that not Allows user to see Public Link tab on File when project is not published
Meta:@gdam
@projects
Given I created following projects:
| Name            | Published |
| P_UPPSCCAPL_S06 | false     |
And created '/F_UPPSCCAPL_S06' folder for project 'P_UPPSCCAPL_S06'
And uploaded '/files/Fish1-Ad.mov' file into '/F_UPPSCCAPL_S06' folder for 'P_UPPSCCAPL_S06' project
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in folder '/F_UPPSCCAPL_S06' on project 'P_UPPSCCAPL_S06' files page
When I select file 'Fish1-Ad.mov' on project files page
Then I 'should not' see element 'ShareFiles' on page 'FilesPage'


Scenario: check that with asset.public_share.create permission, user should see Public Link Access tab on Asset Share popup
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |Access|
| <UserEmail> | agency.user |streamlined_library,library|
And created '<LibraryRole>' role in 'library' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.share                |
| <Permission>               |
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UPPSCCAPL_S07' category
And added users '<UserEmail>' to category 'C_UPPSCCAPL_S07' with role '<LibraryRole>' by users details
When I login with details of '<UserEmail>'
And go to the Library page for collection 'C_UPPSCCAPL_S07'NEWLIB
And I select asset 'Fish1-Ad.mov' in the 'C_UPPSCCAPL_S07'  library pageNEWLIB
Then I '<Condition>' see 'PUBLIC LINK ACCESS' tab on opened Share files popup from collection 'C_UPPSCCAPL_S07'NEWLIB

Examples:
| UserEmail         | UserGlobalRole | LibraryRole        | Permission                | Condition  |
| U_UPPSCCAPL_S07_1 | agency.user    | LR_UPPSCCAPL_S07_1 | asset.public_share.create | should     |
| U_UPPSCCAPL_S07_3 | guest.user     | LR_UPPSCCAPL_S07_1 | asset.public_share.create | should     |
| U_UPPSCCAPL_S07_2 | agency.user    | LR_UPPSCCAPL_S07_2 |                           | should not |
| U_UPPSCCAPL_S07_4 | guest.user     | LR_UPPSCCAPL_S07_2 |                           | should not |
