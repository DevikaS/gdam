!--NGN-4996 NGN-5056 NGN-4929
Feature:          Agency Admin - Rework Library Teams
Narrative:
In order to
As a              AgencyAdmin
I want to         Check adding users and library teams to category

Scenario: Check adding team with 'Add Library team' button on Asset categories and permission page
Meta:@gdam
     @library
Given I created users with following fields:
| Email         | Role         |
| U_AARLT_S01_1 | agency.admin |
| U_AARLT_S01_2 | agency.user  |
| U_AARLT_S01_3 | guest.user   |
And created 'LR_AARLT_S01' role with 'asset_filter_category.read,asset.create' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S01 |
When I add 'U_AARLT_S01_1,U_AARLT_S01_2,U_AARLT_S01_3' users to 'LT_AARLT_S01' library team on Users list page
And add library teams 'LT_AARLT_S01' for category 'C_AARLT_S01' with role 'LR_AARLT_S01'
Then I 'should' see Library Teams 'LT_AARLT_S01' for category 'C_AARLT_S01' on Asset Categories and Permissions page


Scenario: Check that library team cannot be added on 'Add User' pop up
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |
| U_AARLT_S02 | agency.user |
And created following categories:
| Name        |
| C_AARLT_S02 |
And added 'U_AARLT_S02' users to 'LT_AARLT_S02' library team on Users list page
And I am on collection 'C_AARLT_S02' on administration area collections page
And clicked element 'AddUsersButton' on page 'AdminCategoryPage'
When I fill users field with text 'LT_AARLT_S02' on Add Users popup on on Categories and Permissions page
Then I 'should not' see library teams 'LT_AARLT_S02' in drop down on Add Users popup on Categories and Permissions page


Scenario: Check that team users appear on library team pop up
Meta:@gdam
     @library
Given I created users with following fields:
| Email         | Role         |
| U_AARLT_S03_1 | agency.admin |
| U_AARLT_S03_2 | agency.user  |
| U_AARLT_S03_3 | guest.user   |
And created 'LR_AARLT_S03' role with 'asset_filter_category.read,asset.create' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S03 |
When I add 'U_AARLT_S03_1,U_AARLT_S03_2,U_AARLT_S03_3' users to 'LT_AARLT_S03' library team on Users list page
And add library teams 'LT_AARLT_S03' for category 'C_AARLT_S03' with role 'LR_AARLT_S03'
And click library team 'LT_AARLT_S03' for category 'C_AARLT_S03' on Categories and Permissions page
Then I 'should' see following user names 'U_AARLT_S03_1,U_AARLT_S03_2,U_AARLT_S03_3' on Manage Users Categories popup


Scenario: Check that a new one user appear on library team pop up after adding to team
Meta:@gdam
     @library
Given I created users with following fields:
| Email         | Role         |
| U_AARLT_S04_1 | agency.admin |
| U_AARLT_S04_2 | agency.user  |
| U_AARLT_S04_3 | guest.user   |
And created 'LR_AARLT_S04' role with 'asset_filter_category.read,asset.create' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S04 |
When I add 'U_AARLT_S04_1,U_AARLT_S04_2' users to 'LT_AARLT_S04' library team on Users list page
And add library teams 'LT_AARLT_S04' for category 'C_AARLT_S04' with role 'LR_AARLT_S04'
And add 'U_AARLT_S04_3' users to 'LT_AARLT_S04' library team on Users list page
And click library team 'LT_AARLT_S04' for category 'C_AARLT_S04' on Categories and Permissions page
Then I 'should' see following user names 'U_AARLT_S04_1,U_AARLT_S04_2,U_AARLT_S04_3' on Manage Users Categories popup


Scenario: Check that user appears in 'Users' section if added individually to the category (not as part of Team)
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role         |
| U_AARLT_S05 | agency.user  |
And created 'LR_AARLT_S05' role with 'asset_filter_category.read,asset.create' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S05 |
When I add users 'U_AARLT_S05' to category 'C_AARLT_S05' with role 'LR_AARLT_S05' by users details
Then I 'should' see Users 'U_AARLT_S05' for category 'C_AARLT_S05' on on Asset Categories and Permissions page


Scenario: Check that user does not appear at pop up after delete from team
Meta:@gdam
     @library
Given I created users with following fields:
| Email         | Role         |
| U_AARLT_S06_1 | agency.admin |
| U_AARLT_S06_2 | agency.user  |
| U_AARLT_S06_3 | guest.user   |
And created 'LR_AARLT_S06' role with 'asset_filter_category.read,asset.create' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S06 |
When I add 'U_AARLT_S06_1,U_AARLT_S06_2,U_AARLT_S06_3' users to 'LT_AARLT_S06' library team on Users list page
And add library teams 'LT_AARLT_S06' for category 'C_AARLT_S06' with role 'LR_AARLT_S06'
And remove users 'U_AARLT_S06_3' from 'library' team 'LT_AARLT_S06'
And click library team 'LT_AARLT_S06' for category 'C_AARLT_S06' on Categories and Permissions page
Then I 'should not' see following user names 'U_AARLT_S06_3' on Manage Users Categories popup


Scenario: Check that library team do not appear at category after team delete
Meta:@gdam
     @library
Given I created users with following fields:
| Email         | Role        |
| U_AARLT_S07_1 | agency.user |
| U_AARLT_S07_2 | guest.user  |
And created 'LR_AARLT_S07' role with 'asset_filter_category.read,asset.create' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S07 |
When I add 'U_AARLT_S07_1,U_AARLT_S07_2' users to 'LT_AARLT_S07' library team on Users list page
And add library teams 'LT_AARLT_S07' for category 'C_AARLT_S07' with role 'LR_AARLT_S07'
And delete library team 'LT_AARLT_S07'
Then I 'should not' see 'LT_AARLT_S07' 'library' team on Users list page
And 'should not' see Library Teams 'LT_AARLT_S07' for category 'C_AARLT_S07' on Asset Categories and Permissions page



Scenario: Check adding user with the same role that has been assigned for category for it's library team
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |
| U_AARLT_S12 | agency.user |
And created 'LR_AARLT_S12' role with 'asset_filter_category.read,asset.create' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S12 |
When I add 'U_AARLT_S12' users to 'LT_AARLT_S12' library team on Users list page
And add library teams 'LT_AARLT_S12' for category 'C_AARLT_S12' with role 'LR_AARLT_S12'
And add users 'U_AARLT_S12' to category 'C_AARLT_S12' with role 'LR_AARLT_S12' by users details
Then I 'should' see Users 'U_AARLT_S12' for category 'C_AARLT_S12' on on Asset Categories and Permissions page


Scenario: Check that you can edit permissions for category for user if it has been added individually
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |
| U_AARLT_S14 | agency.user |
And created 'LR_AARLT_S14' role with 'asset_filter_category.read' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S14 |
When I add users 'U_AARLT_S14' to category 'C_AARLT_S14' with role 'LR_AARLT_S14' by users details
And click user 'U_AARLT_S14' for category 'C_AARLT_S14' on Categories and Permissions page
Then I 'should' be able to change role for category 'C_AARLT_S14' on library tab for opened user details on users page


Scenario: Check that you cannot edit permissions for category for user if it has been added through team
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |
| U_AARLT_S15 | agency.user |
And created 'LR_AARLT_S15' role with 'asset_filter_category.read' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S15 |
When I add 'U_AARLT_S15' users to 'LT_AARLT_S15' library team on Users list page
And add library teams 'LT_AARLT_S15' for category 'C_AARLT_S15' with role 'LR_AARLT_S15'
And click library team 'LT_AARLT_S15' for category 'C_AARLT_S15' on Categories and Permissions page
Then I 'should not' see roles select box on Manage Users Categories popup
When I go to user 'U_AARLT_S15' library page in administration area
Then I 'should not' be able to change role for category 'C_AARLT_S15' on library tab for opened user details on users page


Scenario: Check that changes on library tab of user details are reflected on Categories
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |
| U_AARLT_S16 | agency.user |
And created 'LR_AARLT_S16_1' role with 'asset_filter_category.read' permissions in 'library' group for advertiser 'DefaultAgency'
And created 'LR_AARLT_S16_2' role with 'asset_filter_category.read' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S16 |
When I add users 'U_AARLT_S16' to category 'C_AARLT_S16' with role 'LR_AARLT_S16_1' by users details
And go to user 'U_AARLT_S16' library page in administration area
And assign role 'LR_AARLT_S16_2' for category 'C_AARLT_S16' on library tab for opened user details on users page
And save user details on users page
When I click user 'U_AARLT_S16' for category 'C_AARLT_S16' on Categories and Permissions page
Then I 'should' be able to change role for category 'C_AARLT_S16' on library tab for opened user details on users page


Scenario: Check that users have access to category after adding team,on which they are included
Meta: @gdam
      @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @library
Given I created users with following fields:
| Email         | Role        |Access|
| U_AARLT_S08_1 | agency.user |streamlined_library|
| U_AARLT_S08_2 | agency.user |streamlined_library|
And created following categories:
| Name        |
| C_AARLT_S08 |
And added users 'U_AARLT_S08_1' to library team 'LT_AARLT_S08'
And added following library teams for following categories:
| CategoryName | TeamName     | RoleName     |
| C_AARLT_S08  | LT_AARLT_S08 | library.user |
When I add users 'U_AARLT_S08_2' to library team 'LT_AARLT_S08'
And login with details of 'U_AARLT_S08_2'
And I go to the collections page
Then I 'should' see on the library page collections 'C_AARLT_S08'NEWLIB


Scenario: Check that users don't have access to category after deletion team, which they are included
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |Access|
| U_AARLT_S09 | agency.user |streamlined_library,library|
And created 'LR_AARLT_S09' role with 'asset_filter_category.read,asset.create' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name        |
| C_AARLT_S09 |
When I add 'U_AARLT_S09' users to 'LT_AARLT_S09' library team on Users list page
And add library teams 'LT_AARLT_S09' for category 'C_AARLT_S09' with role 'LR_AARLT_S09'
And remove library teams 'LT_AARLT_S09' from category 'C_AARLT_S09'
And login with details of 'U_AARLT_S09'
And I go to the collections page
Then I 'should not' see on the library page collections 'C_AARLT_S09'NEWLIB

Scenario: Check that adding user to Library Team automatically allows access for this user to all categories where this team has been assigned
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |Access|
| U_AARLT_S11 | agency.user |streamlined_library,library|
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And created 'LR_AARLT_S11' role with 'asset_filter_category.read,asset.create,asset.delete' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name          |
| C_AARLT_S11_1 |
| C_AARLT_S11_2 |
When I add 'U_AARLT_S11' users to 'LT_AARLT_S11' library team on Users list page
And add library teams 'LT_AARLT_S11' for category 'C_AARLT_S11_1' with role 'LR_AARLT_S11'
And add library teams 'LT_AARLT_S11' for category 'C_AARLT_S11_2' with role 'LR_AARLT_S11'
And login with details of 'U_AARLT_S11'
And I go to the collections page
Then I 'should' see on the library page collections 'C_AARLT_S11_1,C_AARLT_S11_2'NEWLIB
When I select asset 'Fish Ad.mov' in the 'C_AARLT_S11_1'  library pageNEWLIB
Then I 'should' see remove asset confirmation popup for collection 'C_AARLT_S11_1' on opened library page NEWLIB
When I cancel the remove asset confirmation popup from collection 'C_AARLT_S11_1'NEWLIB
And I select asset 'Fish Ad.mov' in the 'C_AARLT_S11_2'  library pageNEWLIB
Then I 'should' see remove asset confirmation popup for collection 'C_AARLT_S11_2' on opened library page NEWLIB


Scenario: Check that if user has been added to some category individually, their individual access should remain after team delete
Meta:@gdam
     @library
Given I created users with following fields:
| Email       | Role        |Access|
| U_AARLT_S13 | agency.user |streamlined_library,library|
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And created 'LR_AARLT_S13_1' role with 'asset_filter_category.read,asset.create' permissions in 'library' group for advertiser 'DefaultAgency'
And created 'LR_AARLT_S13_2' role with 'asset_filter_category.read,asset.create,asset.delete' permissions in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name          |
| C_AARLT_S13_1 |
When I add 'U_AARLT_S13' users to 'LT_AARLT_S13' library team on Users list page
And add library teams 'LT_AARLT_S13' for category 'C_AARLT_S13_1' with role 'LR_AARLT_S13_1'
And add users 'U_AARLT_S13' to category 'C_AARLT_S13_1' with role 'LR_AARLT_S13_2' by users details
And remove library teams 'LT_AARLT_S13' from category 'C_AARLT_S13_1'
And login with details of 'U_AARLT_S13'
And go to the Library page for collection 'My Assets'NEWLIB
And go to the Library page for collection 'C_AARLT_S13_1'NEWLIB
And I refresh the page
And I select asset 'Fish Ad.mov' in the 'C_AARLT_S13_1'  library pageNEWLIB
Then I 'should' see 'Remove' option in menu for collection 'C_AARLT_S13_1'NEWLIB



