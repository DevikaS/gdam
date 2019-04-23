Feature:          User can add Assets to Project from Library Assets List
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user can add Assets to Project from Library Assets List


Scenario: Check that user who does not have download master permission in library, cannot download master from folder after moving asset from library to folder
Meta:@gdam
@projects
Given I uploaded asset '/files/_file1.gif' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I created 'UCAATP_R1' role in 'library' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| asset.read                 |
| asset_filter_category.read |
| proxy.download             |
|asset.create|
|asset.write|
And created 'UCAATP_C1' category
And I created users with following fields:
| Email     | Role        |Access|
| UCAATP_U1 | agency.user |streamlined_library,library,folders|
And added users 'UCAATP_U1' for category 'UCAATP_C1' with role 'UCAATP_R1'
And logged in with details of 'UCAATP_U1'
And created 'UCAATP_P1' project
And created '/UCAATP_F1' folder for project 'UCAATP_P1'
When I go to the library page for collection 'UCAATP_C1'NEWLIB
And I add assets '_file1.gif' to project 'UCAATP_P1' and folder 'UCAATP_F1' from collection 'UCAATP_C1' pageNEWLIB
And go to project 'UCAATP_P1' folder 'UCAATP_F1' page
And select file '_file1.gif' on project files page
Then I 'should not' see Download link for 'original' type on Download popup for project 'UCAATP_P1' folder 'UCAATP_F1'

Scenario: Check that Added to project files are available in search results
Meta:@gdam
@projects
Given I uploaded asset '/files/_file1.gif' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'UCAATP_C3' category
And I created users with following fields:
| Email     | Role        |Access|
| UCAATP_U3 | agency.user |streamlined_library,library,folders|
And added users 'UCAATP_U3' for category 'UCAATP_C3' with role 'library.user'
And logged in with details of 'UCAATP_U3'
And created 'UCAATP_P3' project
And created '/UCAATP_F3' folder for project 'UCAATP_P3'
When I add following asset '_file1.gif' of collection 'UCAATP_C3' to project 'UCAATP_P3' folder '/UCAATP_F3'NEWLIB
And go to project list page
And search by text '_file1.gif'
And click show all link for global user search for object 'Files & Folders'
Then 'should' see following projects on the project search page 'UCAATP_P3'


Scenario: Check that added to project file could be edited
Meta:@gdam
@projects
Given I uploaded asset '/files/_file1.gif' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'UCAATP_C4' category
And I created users with following fields:
| Email     | Role        |Access|
| UCAATP_U4 | agency.user |streamlined_library,library,folders|
And added users 'UCAATP_U4' for category 'UCAATP_C4' with role 'library.user'
And logged in with details of 'UCAATP_U4'
And created 'UCAATP_P4' project
And created '/UCAATP_F4' folder for project 'UCAATP_P4'
When I go to asset '_file1.gif' info page in Library for collection 'UCAATP_C4'NEWLIB
And I add following asset '_file1.gif' of collection 'UCAATP_C4' to project 'UCAATP_P4' folder '/UCAATP_F4'NEWLIB
And go to file '_file1.gif' info page in folder 'UCAATP_F4' project 'UCAATP_P4'
And 'save' file info by next information:
| FieldName | FieldValue       |
| Title     | UCAATP_FILE4.gif |
And I go to project 'UCAATP_P4' folder 'UCAATP_F4' page
Then I 'should' see file 'UCAATP_FILE4.gif' on project files page
And I 'should not' see file '_file1.gif' on project files page


Scenario: Check that several assets with different media types
Meta:@gdam
@projects
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/_file1.gif  |
| /files/Fish Ad.mov |
| /files/test.mp3    |
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'UCAATP_C2' category
And I created users with following fields:
| Email     | Role        |Access|
| UCAATP_U2 | agency.user |streamlined_library,library,folders,adkits|
And added users 'UCAATP_U2' for category 'UCAATP_C2' with role 'library.user'
And logged in with details of 'UCAATP_U2'
And created 'UCAATP_P2' project
And created '/UCAATP_F2' folder for project 'UCAATP_P2'
When I go to the library page for collection 'UCAATP_C2'NEWLIB
And I add following asset '_file1.gif' of collection 'UCAATP_C2' to project 'UCAATP_P2' folder '/UCAATP_F2'NEWLIB
And I add following asset 'Fish Ad.mov' of collection 'UCAATP_C2' to project 'UCAATP_P2' folder '/UCAATP_F2'NEWLIB
And I add following asset 'test.mp3' of collection 'UCAATP_C2' to project 'UCAATP_P2' folder '/UCAATP_F2'NEWLIB
Then should see files '_file1.gif,Fish Ad.mov,test.mp3' inside '/UCAATP_F2' folder for 'UCAATP_P2' project


