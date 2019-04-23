!--NGN-569 NGN-3406
Feature:          Library upload a new asset
Narrative:
In order to
As a              AgencyAdmin
I want to         Check uploading a new asset into Library




Scenario: Check that too long titles of assets are wrapped
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        | Access          |
| U_LUNA_S08 | agency.user | streamlined_library |
When I login with details of 'U_LUNA_S08'
And upload file '/images/logo.gif' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I refresh the page
When I go to asset 'logo.gif' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName    | FieldValue |
| Title   | qwertyuioasdfghjklzxcvbnqwerty.gif   |
And go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see asset 'qwertyuioasdfghjklzxcvbnqwerty.gif' with wrapped name in collection 'My Assets'NEWLIB



Scenario: Check that visibility 'Upload' button depend on 'Create Asset' permissions
Meta:@gdam
@library
Given I created '<GlobalRole>' role with '<Permissions>' permissions in 'global' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Role         | Access             |
| <UserEmail> | <GlobalRole> | streamlined_library   |
When I login with details of '<UserEmail>'
And go to the library page for collection 'My Assets'NEWLIB
Then I '<Condition>' see Upload button on collection 'My Assets' in LibraryNEWLIB

Examples:
| UserEmail    | GlobalRole   | Permissions  | Condition  |
| U_LUNA_S01_1 | R_LUNA_S01_1 | asset.create | should     |
| U_LUNA_S01_2 | R_LUNA_S01_2 |              | should not |


Scenario: Check that files with indentical names can be uploaded
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        | Access          |
| U_LUNA_S02 | agency.user | folders,streamlined_library |
When I login with details of 'U_LUNA_S02'
And upload file '/images/logo.jpg' into my libraryNEWLIB
And upload file '/images/logo.jpg' into my libraryNEWLIB
And go to the library page for collection 'My Assets'NEWLIB
Then I should see assets 'logo.jpg' count '2' in 'My Assets' libraryNEWLIB


Scenario: Check that metadata of asset is correct after uploading asset
Meta:@gdam
@library
Given I created the following agency:
| Name       | Application Access      |
| A_LUNA_S03 | streamlined_library     |
And created users with following fields:
| Email       | Role         | Agency     | Access              |
| AU_LUNA_S03 | agency.admin | A_LUNA_S03 | streamlined_library |
And logged in with details of 'AU_LUNA_S03'
And created users with following fields:
| Email      | Role        | Access          | Agency     |
| U_LUNA_S03 | agency.user | folders,streamlined_library | A_LUNA_S03 |
And logged in with details of 'U_LUNA_S03'
And uploaded following assetsNEWLIB:
| Name              |
| /files/_file1.gif |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset '_file1.gif' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue |
| Title     | _file1.gif |
And 'should' see following 'asset information' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue |
| Business Unit  | A_LUNA_S03 |


Scenario: Check that Title of Asset is equal to name of uploaded file
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        | Access          |
| U_LUNA_S04 | agency.user | folders,streamlined_library |
And logged in with details of 'U_LUNA_S04'
And uploaded following assetsNEWLIB:
| Name                           |
| /files/atCalcImage.jpg         |
| /files/_file1.gif              |
| /files/file2_.gif              |
| /files/file4!@#$%^&()+-=~_.mpg |
When I go to the library page for collection 'My Assets'NEWLIB
Then I 'should' see asset with following titles on opened 'My Assets' Library pageNEWLIB:
| AssetTitle              |
| atCalcImage.jpg         |
| _file1.gif              |
| file2_.gif              |
| file4!@#$%^&()+-=~_.mpg |


Scenario: Check that uploaded assets are displayed in My Assets category
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        | Access          |
| U_LUNA_S05 | agency.user | folders,streamlined_library |
And logged in with details of 'U_LUNA_S05'
And uploaded file '/files/Fish1-Ad.mpg' into libraryNEWLIB
When I go to the library page for collection 'My Assets'NEWLIB
Then 'should' see assets 'Fish1-Ad.mpg' in the collection 'My Assets'NEWLIB



Scenario: Check that file metadata is correctly shown on category
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        | Access          |
| U_LUNA_S06 | agency.user | folders,streamlined_library |
When I login with details of 'U_LUNA_S06'
And upload following assetsNEWLIB:
| Name                        |
| /files/logo1.gif            |
| /files/logo2.png            |
| /files/logo3.jpg            |
| /files/logo4.bmp            |
| /files/13DV-CAPITAL-10.mpg  |
| /files/128_shortname.jpg    |
| /files/CCITT_1.TIF          |
| /files/test.ogg             |
| /files/GWGTestfile064v3.pdf |
| /files/index.html           |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
Then I should see for collection 'My Assets' in Library following files metadataNEWLIB :
| FileName             | Duration | Size     | AspectRatio | Type |
| logo1.gif            |          | 4.4 KB   |             | GIF  |
| logo2.png            |          | 3 KB     |             | PNG  |
| logo3.jpg            |          | 2.9 KB   |             | JPEG |
| logo4.bmp            |          | 12.1 KB  |             | BMP  |
| 13DV-CAPITAL-10.mpg  | 3s 120ms | 408 KB   | 16:9        | MPEG |
| 128_shortname.jpg    |          | 42.5 KB  |             | JPEG |
| CCITT_1.TIF          |          | 18 KB    |             | TIFF |
| test.ogg             | 1mn 29s  | 665.1 KB |             | OGG  |
| GWGTestfile064v3.pdf |          | 644.4 KB |             | PDF  |
| index.html           |          | 1.5 KB   |             | HTML |


Scenario: Check that thumbnails for transcoded files is displayed
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        | Access          |
| U_LUNA_S07 | agency.user | folders,streamlined_library |
When I login with details of 'U_LUNA_S07'
And upload file '/images/logo.gif' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
Then I should see available preview for asset 'logo.gif' in collection 'My Assets'NEWLIB