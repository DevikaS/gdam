Feature:          A5 Dashboard Library Assets
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 Dashboard Library Assets

Meta: @component dashboard

Scenario: check that link 'Upload to your library' open PLUploader
Meta:@library
     @gdam
When I open link 'Upload to your library' in current window on Dashboard Page
Then I 'should' be on PlUploader page




Scenario: check that link 'Explore your library' open library page
Meta:@library
     @gdam
When I open link 'Explore your library' on Dashboard Page
Then I go to the library pageNEWLIB


Scenario: check that click on asset thumbnail open assetinfo tab
Meta:@library
     @gdam
Given I created the agency 'A_A5DA_S05' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| U_A5DA_S05 | agency.admin | A_A5DA_S05   |streamlined_library,dashboard|
And logged in with details of 'U_A5DA_S05'
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And waited while preview is available in collection 'My Assets'NEWLIB
When I click asset 'Fish Ad.mov' thumbnail in 'Latest Library Uploads' section on Dashboard page
Then I 'should' be on the asset info pageNEWLIB

Scenario: check that User can't see on Dashboard assets from Library that it has no access to
Meta:@library
     @gdam
Given I created the agency 'A_A5DA_S06' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_A5DA_S06 | agency.admin | A_A5DA_S06   |
And uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
| /files/Fish-Ad.mov |
When I login with details of 'U_A5DA_S06'
Then I should see following files in 'Latest Library Uploads' section on Dashboard page:
| Name        | Condition  |
| Fish Ad.mov | should not |
| Fish-Ad.mov | should not |
And 'should' see text 'You have no files in your library' for expanded section 'Latest Library Uploads' on Dashboard page


Scenario: Check that user can't see assets from shared category on dashboard
Meta:@library
     @gdam
Given I created the agency 'A_A5DA_S07' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_A5DA_S07_1 | agency.admin | A_A5DA_S07   |streamlined_library,dashboard|
| U_A5DA_S07_2 | agency.user  | A_A5DA_S07   |streamlined_library,dashboard|
And logged in with details of 'U_A5DA_S07_1'
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
| /files/Fish-Ad.mov |
And I created following categories:
| Name       | MediaType |
| C_A5DA_S07 | video     |
And created 'LR_A5DA_S07' role in 'library' group for advertiser 'A_A5DA_S07' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And added users 'U_A5DA_S07_2' for category 'C_A5DA_S07' with role 'LR_A5DA_S07'
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I login with details of 'U_A5DA_S07_2'
Then I should see following files in 'Latest Library Uploads' section on Dashboard page:
| Name        | Condition  |
| Fish Ad.mov | should not |
| Fish-Ad.mov | should not |

Scenario: Check that asset could be opened from 'My Recent Activity' section via 'viewed asset' activity
Meta:@library
     @gdam
Given I created the agency 'A_A5DA_S08' with default attributes
And created users with following fields:
| Email      | Role         | Agency     |Access|
| U_A5DA_S08 | agency.admin | A_A5DA_S08 |streamlined_library,dashboard|
And logged in with details of 'U_A5DA_S08'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And on asset '128_shortname.jpg' info page in Library for collection 'My Assets'NEWLIB
When I go to Dashboard page
And click file '128_shortname.jpg' link in 'viewed asset' activity in My Recent Activity section on Dashboard page
Then I 'should' be on the asset info pageNEWLIB


Scenario: check that last 10 uploaded assets appear at Latest Library Uploads
Meta:@library
     @gdam
Given I created the agency 'A_A5DA_S03' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| U_A5DA_S03 | agency.admin | A_A5DA_S03   |streamlined_library,adkits,folders,library,dashboard|
And logged in with details of 'U_A5DA_S03'
And uploaded following assetsNEWLIB:
| Name                           |
| /images/admin.logo.jpg         |
| /images/bg_img.jpg             |
| /images/big.logo.png           |
| /images/branding_logo.png      |
| /images/empty.logo.png         |
| /images/empty.project.logo.png |
| /images/logo.bmp               |
| /images/logo.gif               |
| /images/logo.jpeg              |
| /images/logo.jpg               |
| /images/logo.png               |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to Dashboard page
Then I should see following files in 'Latest Library Uploads' section on Dashboard page:
| Name                    | Condition  |
| admin.logo.jpg          | should not |
| bg_img.jpg              | should     |
| big.logo.png            | should     |
| branding_logo.png       | should     |
| empty.logo.png          | should     |
| empty.project.logo.png  | should     |
| logo.bmp                | should     |
| logo.gif                | should     |
| logo.jpeg               | should     |
| logo.jpg                | should     |
| logo.png                | should     |
