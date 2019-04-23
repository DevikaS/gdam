!--NGN-11668
Feature:          User should be able to switch between List view and Tile view in Library
Narrative:
In order to:
As a              AgencyAdmin
I want to         Check that user is prompted to accept TnC before accessing project



Scenario: Check correctness of sorting in List view in Library
Meta: @gdam
@library
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email                 | Role         | AgencyUnique           |Access|
| <User> | agency.admin | <Agency> |streamlined_library,library|
And logged in with details of '<User>'
And uploaded file '/images/logo.jpeg' into libraryNEWLIB
And uploaded file '/files/logo1.gif' into libraryNEWLIB
And uploaded file '/files/test.mp3' into libraryNEWLIB
And uploaded file '/files/13DV-CAPITAL-10.mpg' into libraryNEWLIB
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And I am on  library page for collection 'Everything'NEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
And I have refreshed the page
When I switch to 'list' view from the collection 'Everything' pageNEWLIB
And I wait for '5' seconds
And I sort files list view in library for collection 'Everything' by column '<columnName>' order '<order>'NEWLIB
Then I should see assets sorting by '<Result>' for collection 'Everything' on the library pageNEWLIB
Examples:
| columnName   | order   | Result              |User|Agency|
| Last Updated | asc     | Last Uploaded Last  |U_CTUUATSFTVTLVIT_S01|BU_CTUUATSFTVTLVIT_S01|
| Last Updated | desc    | Last Uploaded First |U_CTUUATSFTVTLVIT_S02|BU_CTUUATSFTVTLVIT_S02|
| File Size    | asc     | Size (Ascending)    |U_CTUUATSFTVTLVIT_S03|BU_CTUUATSFTVTLVIT_S03|
| File Size    | desc    | Size (Descending)   |U_CTUUATSFTVTLVIT_S04|BU_CTUUATSFTVTLVIT_S04|
| Title        | asc     | Title (A to Z)      |U_CTUUATSFTVTLVIT_S05|BU_CTUUATSFTVTLVIT_S05|
| Title        | desc    | Title (Z to A)      |U_CTUUATSFTVTLVIT_S06|BU_CTUUATSFTVTLVIT_S06|


Scenario: Check correctness of sorting in List view in Shared Collections
Meta: @gdam
@library
Given I created the agency 'A_LASIC_S05_1' with default attributes
And created the agency 'A_LASIC_S05_2' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_LASIC_S05_2 | new-library-dev-version |
And added agency 'A_LASIC_S05_1' as a partner to agency 'A_LASIC_S05_2'
And created users with following fields:
| Email         | Role         | Agency        |  Access              |
| U_LASIC_S05_1 | agency.admin | A_LASIC_S05_1 |  streamlined_library  |
| U_LASIC_S05_2 | agency.admin | A_LASIC_S05_2 | streamlined_library   |
And logged in with details of 'U_LASIC_S05_1'
And created following categories:
| Name         | Media Type |
| C_LASIC_S05  | video      |
And uploaded following assetsNEWLIB:
| Name                   |
|/files/Fish1-Ad.mov     |
|/files/Fish2-Ad.mov     |
|/images/logo.jpeg       |
|/files/test.mp3         |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_LASIC_S05  | A_LASIC_S05_2 |
And logged in with details of 'U_LASIC_S05_2'
When I go to the collections page
And I go to the Shared Collection 'C_LASIC_S05' from agency 'A_LASIC_S05_1' pageNEWLIB
And I switch to 'list' view on shared category pageNEWLIB
And I sort files on list view by column '<columnName>' order '<order>' on shared category pageNEWLIB
Then I should see assets sorting by '<Result>' for category 'C_LASIC_S05' for agency 'A_LASIC_S05_1' on the shared categories pageNEWLIB

Examples:
| columnName   | order   | Result              |
| Title        | asc     | Title (A to Z)      |
| Title        | desc    | Title (Z to A)      |




Scenario: Check that user selected view type is remembered
Meta: @gdam
@library
Given I created the agency 'BU_CTUUATSFTVTLVIT_S011' with default attributes
And created users with following fields:
| Email                 | Role         | AgencyUnique           |Access|
| U_CTUUATSFTVTLVIT_S01 | agency.admin | BU_CTUUATSFTVTLVIT_S011 |streamlined_library,library,dashboard|
And logged in with details of 'U_CTUUATSFTVTLVIT_S01'
And uploaded following assetsNEWLIB:
| Name                                         |
| /images/logo.jpeg                            |
| /images/logo.png                             |
| /images/logo.bmp                             |
And I am on  library page for collection 'Everything'NEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I switch to 'list' view from the collection 'Everything' pageNEWLIB
And I go to Dashboard page
And I go to  library page for collection 'Everything'NEWLIB
Then I should see assets in the 'list' view in the collection 'Everything' pageNEWLIB


Scenario: Check that sorting display correct results after scrolling inside the list view grid
Meta: @gdam
@library
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email                 | Role         | AgencyUnique           |Access|
| <User> | agency.admin | <Agency> |streamlined_library,library|
And logged in with details of '<User>'
And uploaded file '/images/logo.jpeg' into libraryNEWLIB
And uploaded file '/images/logo.png' into libraryNEWLIB
And uploaded file '/files/logo1.gif' into libraryNEWLIB
And uploaded file '/files/test.mp3' into libraryNEWLIB
And uploaded file '/files/13DV-CAPITAL-10.mpg' into libraryNEWLIB
And I am on  library page for collection 'Everything'NEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I switch to 'list' view from the collection 'Everything' pageNEWLIB
And I wait for '3' seconds
And I sort files list view in library for collection 'Everything' by column '<columnName>' order '<order>'NEWLIB
And I wait for '3' seconds
And scroll down to file number '5' on library page for collection 'Everything'NEWLIB
Then I should see assets sorting by '<Result>' for collection 'Everything' on the library pageNEWLIB

Examples:
| columnName   | order   | Result            |User                  |Agency|
| File Size    | asc     | Size (Ascending)  |U_CTUUATSFTVTLVIT_S07 |BU_CTUUATSFTVTLVIT_S07|
| Title        | asc     | Title (A to Z)    |U_CTUUATSFTVTLVIT_S08 |BU_CTUUATSFTVTLVIT_S08|


Scenario: check that user is able to switch from Tile view to List view in Trash
Meta: @gdam
@library
Given I created the agency 'BU_CTUUATSFTVTLVIT_S01' with default attributes
And created users with following fields:
| Email                 | Role         | AgencyUnique           |Access|
| U_CTUUATSFTVTLVIT_S01 | agency.admin | BU_CTUUATSFTVTLVIT_S01 |streamlined_library|
And logged in with details of 'U_CTUUATSFTVTLVIT_S01'
And uploaded asset '/files/image10.jpg' into libraryNEWLIB
And uploaded asset '/files/logo3.jpg' into libraryNEWLIB
And I am on  library page for collection 'Everything'NEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
And selected asset 'image10.jpg,logo3.jpg' in the 'Everything' library pageNEWLIB
And I removed asset in 'Everything' library page
And waited for '2' seconds
When I go to library trash pageNEWLIB
And I switch to 'list' view on library trash pageNEWLIB
Then I should see for library trash page files in the 'list' viewNEWLIB



Scenario: Check the correctness of asset names after switch from Tile vie to List
Meta: @gdam
@library
Given I created the agency 'BU_CTUUATSFTVTLVIT_S01' with default attributes
And created users with following fields:
| Email                 | Role         | AgencyUnique           |Access|
| U_CTUUATSFTVTLVIT_S01 | agency.admin | BU_CTUUATSFTVTLVIT_S01 |streamlined_library|
And logged in with details of 'U_CTUUATSFTVTLVIT_S01'
And uploaded following assetsNEWLIB:
| Name                                         |
| /files/audio01.mp3                           |
| /images/SB_Logo.png                          |
|  /files/logo1.gif                            |
And I am on  library page for collection 'Everything'NEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I switch to 'list' view from the collection 'Everything' pageNEWLIB
Then I 'should' see assets with titles 'audio01.mp3,SB_Logo.png,logo1.gif' in the collection 'Everything'NEWLIB


Scenario: Check correcntess of filters work in List view
Meta: @gdam
@library
Given I created the agency 'BU_CTUUATSFTVTLVIT_S01' with default attributes
And created users with following fields:
| Email                 | Role         | AgencyUnique           |Access|
| U_CTUUATSFTVTLVIT_S01 | agency.admin | BU_CTUUATSFTVTLVIT_S01 |streamlined_library|
And logged in with details of 'U_CTUUATSFTVTLVIT_S01'
And uploaded following assetsNEWLIB:
| Name                                         |
| /images/logo.jpeg                            |
| /images/logo.png                             |
| /files/logo1.gif                             |
| /files/Fish Ad.mov                           |
| /files/audio01.mp3                           |
And I am on  library page for collection 'Everything'NEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
When I switch to 'list' view from the collection 'Everything' pageNEWLIB
And I switch on media type filter '<MediaFilter>' from collection 'Everything'NEWLIB
Then I 'should' see assets '<Asset>' in the list view on collection 'Everything'NEWLIB
And I 'should not' see assets '<AssetExclude>' in the list view on collection 'Everything'NEWLIB

Examples:
| MediaFilter | Asset                                                      | AssetExclude                                                                                                                                                          |
| image       | logo.jpeg,logo.png                                         | logo1.gif,Fish Ad.mov,audio01.mp3                                        |
| audio       | audio01.mp3                                                | logo.jpeg,logo.png,logo1.gif,Fish Ad.mov                                                             |
| video       | Fish Ad.mov                                                |logo.jpeg,logo.png,logo1.gif,audio01.mp3                                                 |
| digital     | logo1.gif                                                  |logo.jpeg,logo.png,audio01.mp3,Fish Ad.mov              |
