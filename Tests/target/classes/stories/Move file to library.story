!--NGN-134
Feature:          Move file to library
Narrative:
In order to
As a              AgencyAdmin
I want to         Check  ability to move files to library

Scenario: Check that project admin has ability to send file to library from folder
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Role        | Access          | Agency        |
| U_MFTL_S01_1 | agency.user | library,folders | DefaultAgency |
| U_MFTL_S01_2 | agency.user | library,folders | DefaultAgency |
| U_MFTL_S01_3 | agency.user | library,folders | AnotherAgency |
And logged in with details of 'U_MFTL_S01_1'
And created following projects:
| Name       | Job Number  | Product/Brand  | Administrators                         |
| P_MFTL_S01 | JN_MFTL_S01 | DefaultProduct | U_MFTL_S01_1,U_MFTL_S01_2,U_MFTL_S01_3 |
And created '/F1' folder for project 'P_MFTL_S01'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_MFTL_S01' project
And logged in with details of '<UserEmail>'
When I go to project 'P_MFTL_S01' folder '/F1' page
And select file 'logo.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
Then I '<Should>' see element 'SendToLibrary' on page 'FilesPage'

Examples:
| UserEmail    | Should |
| U_MFTL_S01_2 | should |
| U_MFTL_S01_3 | should |


Scenario: Check that project admin has ability to send file to library from file's details
Meta:@gdam
@library
Given I created users with following fields:
| Email        | Role        | Access          | Agency        |
| U_MFTL_S02_1 | agency.user | library,folders | DefaultAgency |
| U_MFTL_S02_2 | agency.user | library,folders | DefaultAgency |
| U_MFTL_S02_3 | agency.user | library,folders | AnotherAgency |
And logged in with details of 'U_MFTL_S02_1'
And created following projects:
| Name       | Job Number  | Product/Brand  | Administrators                         |
| P_MFTL_S02 | JN_MFTL_S02 | DefaultProduct | U_MFTL_S02_1,U_MFTL_S02_2,U_MFTL_S02_3 |
And created '/F1' folder for project 'P_MFTL_S02'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_MFTL_S02' project
And waited while transcoding is finished in folder '/F1' on project 'P_MFTL_S02' files page
And logged in with details of '<UserEmail>'
When I go to file 'logo.png' info page in folder '/F1' project 'P_MFTL_S02'
And click element 'MoreButton' on page 'FilesPage'
Then I '<Should>' see element 'SendToLibrary' on page 'FilesPage'

Examples:
| UserEmail    | Should |
| U_MFTL_S02_2 | should |
| U_MFTL_S02_3 | should |


Scenario: Check that template admin hasn't ability to send file to library from folder
Meta:@gdam
@library
Given I created 'T_MFTL_S03' template
And created '/F1' folder for template 'T_MFTL_S03'
And uploaded '/images/logo.png' file into '/F1' folder for 'T_MFTL_S03' template
When I go to template 'T_MFTL_S03' folder '/F1' page
And select file 'logo.png' on template files page
And click element 'MoreButton' on page 'FilesPage'
Then I 'should not' see element 'SendToLibrary' on page 'FilesPage'


Scenario: Check that template admin hasn't ability to send file to library from file's details
Meta:@gdam
@library
Given I created 'T_MFTL_S04' template
And created '/F1' folder for template 'T_MFTL_S04'
And uploaded '/images/logo.png' file into '/F1' folder for 'T_MFTL_S04' template
When I go to file 'logo.png' info page in folder '/F1' template 'T_MFTL_S04'
And click element 'MoreButton' on page 'FilesPage'
Then I 'should not' see element 'SendToLibrary' on page 'FilesPage'


Scenario: Check that user haven't ability to send file to library
Meta:@gdam
@library
Given I created 'P_MFTL_S05' project
And created '/F1' folder for project 'P_MFTL_S05'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_MFTL_S05' project
And created 'PR_MFTL_S05' role with 'folder.read,element.read' permissions in 'project' group for advertiser 'DefaultAgency'
And added users 'AgencyUser' to project 'P_MFTL_S05' team folders '/F1' with role 'PR_MFTL_S05' expired '12.12.2021'
And logged in with details of 'AgencyUser'
And I am on project 'P_MFTL_S05' folder '/F1' page
When I select file 'logo.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
Then I 'should not' see element 'SendToLibrary' on page 'FilesPage'




Scenario: Check that metadata and asset sub-type are inherited from project file but are editable
Meta:@gdam
@library
Given I created 'P_MFTL_S08' project
And created '/F1' folder for project 'P_MFTL_S08'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_MFTL_S08' project
When I wait while transcoding is finished in folder '/F1' on project 'P_MFTL_S08' files page
And select file 'logo.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
Then I should see elements on page 'AddFileToLibraryPage' in the following state:
| element   | state         |
| ID        | not read only |
| SubType   | not read only |
| MediaType | disabled      |
| Width     | disabled      |
| Height    | disabled      |
| FileType  | disabled      |
| FileSize  | disabled      |



Scenario: Check that user can save asset until file not transcoding (hard to reproduce by autotests)
Meta: @skip
      @gdam
Given I created 'P_MFTL_S12' project
And created '/F1' folder for project 'P_MFTL_S12'
And uploaded '/files/big_background.jpg' file into '/F1' folder for 'P_MFTL_S12' project
When I go to project 'P_MFTL_S12' folder '/F1' page
And select file 'big_background.jpg' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID           |
| FID_MFTL_S12 |
And click on element 'SaveButton'
Then I 'should' see assets 'FID_MFTL_S12' in the collection 'My Assets'
And I should see that asset 'FID_MFTL_S12' has not got specification in the current collection



Scenario: Check that for project owner with global role without 'Create Asset' permission 'Send to Library' option isn't available
Meta: @skip
      @gdam
Given I created '<GlobalRole>' role with '<Permissions>' permissions in 'global' group for advertiser 'DefaultAgency'
And created users with following fields:
| Agency        | Email       | Role         |
| DefaultAgency | <UserEmail> | <GlobalRole> |
And I logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And created '/F1' folder for project '<ProjectName>'
And uploaded '/images/logo.png' file into '/F1' folder for '<ProjectName>' project
When I go to project '<ProjectName>' folder '/F1' page
And select file 'logo.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
Then I '<Condition>' see element 'SendToLibrary' on page 'FilesPage'

Examples:
| ProjectName  | UserEmail    | GlobalRole    | Permissions                                                                                                                                                                                                                                                                                                                                                                                                                                        | Condition  |
| P_MFTL_S17_1 | U_MFTL_S17_1 | GR_MFTL_S17_1 | acl.change,agency.read,agency.write,agency_team.create,agency_team.delete,agency_team.read,agency_team.write,asset.add_to_presentation,asset.create,asset.delete,asset.read,asset.write,folder.create,element.create, folder.delete,element.delete,folder.read,element.read,folder.write,element.write,enum.create,enum.delete,role.create,role.read,role.write,role.delete,enum.read,enum.write,project.create,project.read,project.settings.read | should     |
| P_MFTL_S17_2 | U_MFTL_S17_2 | GR_MFTL_S17_2 | acl.change,agency.read,agency.write,agency_team.create,agency_team.delete,agency_team.read,agency_team.write,asset.add_to_presentation,asset.delete,asset.read,asset.write,folder.create,element.create, folder.delete,element.delete,folder.read,element.read,folder.write,element.write,enum.create,enum.delete,role.create,role.read,role.write,role.delete,enum.read,enum.write,project.create,project.read,project.settings.read              | should not |



Scenario: Check that asset metadata display correct
Meta:@gdam
@library
Given I created 'P_MFTL_S07' project
And created in 'P_MFTL_S07' project next folders:
| folder |
| /F1    |
| /F2    |
| /F3    |
| /F4    |
| /F5    |
| /F6    |
And uploaded into project 'P_MFTL_S07' following files:
| FileName                                     | Path |
| /images/logo.png                             | /F1  |
| /files/Fish Ad.mov                           | /F2  |
| /files/GWGTest2.pdf                          | /F3  |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /F4  |
| /files/uploader.swf                          | /F5  |
| /files/BDDStandards.doc                      | /F6  |
When I wait while transcoding is finished in folder '<Folder>' on project 'P_MFTL_S07' files page
And refresh the page
And select file '<Name>' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
Then I should see following data on add file to library page:
| Title  | Media Type  | Sub Media Type | Duration   | Width   | Height   | Screen   | File Type | File Size |
| <Name> | <MediaType> | <SubType>      | <Duration> | <Width> | <Height> | <Screen> | <Type>    | <Size>    |

Examples:
| Folder | Name                                  | MediaType | SubType       | Duration | Width     | Height    | Screen        | Type | Size     |
| /F1    | logo.png                              | image     | Not specified |          | 64        | 64        |               | PNG  | 3 KB     |
| /F2    | Fish Ad.mov                           | video     | Not specified | 6s 33ms  |           |           | Not specified | MOV  | 383.5 KB |
| /F3    | GWGTest2.pdf                          | print     |               |          | 792       | 595       |               | PDF  | 644.4 KB |
| /F5    | uploader.swf                          | digital   | Not specified |          | 10 pixels | 10 pixels |               | SWF  | 12.5 KB  |
| /F6    | BDDStandards.doc                      | document  | Not specified |          |           |           |               | DOC  | 90 KB    |
| /F4    | Tesco_Trade_Meat_Wine_PANTS939015.wav | audio     | Not specified | 3s       |           |           |               | WAV  | 36.7 KB  |


Scenario: Check that user have ability to move some files to library
Meta:@gdam
@library
Given I created 'P_MFTL_S09' project
And created in 'P_MFTL_S09' project next folders:
| folder |
| /F1    |
| /F2    |
And uploaded into project 'P_MFTL_S09' following files:
| FileName           | Path |
| /images/logo.png   | /F1  |
| /files/Fish Ad.mov | /F2  |
When I wait while transcoding is finished in folder '<Folder>' on project 'P_MFTL_S09' files page
And select file '<Name>' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID   |
| <ID> |
And click on element 'SaveButton'
And go to  Library pageNEWLIB
Then I 'should' see assets with id '<ID>' in the collection 'Everything'NEWLIB

Examples:
| Folder | Name        | ID             |
| /F1    | logo.png    | FID_MFTL_S09_1 |
| /F2    | Fish Ad.mov | FID_MFTL_S09_1 |


Scenario: Check that user have ability to move file with a name that already exists in the library
Meta:@gdam
@library
Given I created 'P_MFTL_S11' project
And created in 'P_MFTL_S11' project next folders:
| folder |
| /F1    |
| /F2    |
And uploaded into project 'P_MFTL_S11' following files:
| FileName         | Path |
| /images/logo.gif | /F1  |
| /images/logo.gif | /F2  |
When I wait while transcoding is finished in folder '<Folder>' on project 'P_MFTL_S11' files page
And select file 'logo.gif' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID   |
| <ID> |
And click on element 'SaveButton'
And go to  Library pageNEWLIB
Then I should see assets '<ID>' count '<Count>' in collection 'Everything'NEWLIB

Examples:
| Folder | ID           | Count |
| /F1    | FID_MFTL_S11 | 1     |
| /F2    | FID_MFTL_S11 | 2     |


Scenario: Check that file sent to Library is marked with 'adbanked' icon in project
Meta:@gdam
@projects
Given I created 'P_MFTL_S14' project
And created '/F1' folder for project 'P_MFTL_S14'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_MFTL_S14' project
And waited while transcoding is finished in folder '/F1' on project 'P_MFTL_S14' files page
When I select file 'logo.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID           |
| FID_MFTL_S14 |
And click on element 'SaveButton'
And go to project 'P_MFTL_S14' folder '/F1' page
Then I should see count '1' of adbank icons for current folder

Scenario: Check that for file not transcoded at moment of sending to Library, thumbnail and proxy are available in Library when transcoding is completed
Meta:@gdam
@library
Given I created 'P_MFTL_S15' project
And created '/F1' folder for project 'P_MFTL_S15'
And uploaded '/files/128_shortname.jpg' file into '/F1' folder for 'P_MFTL_S15' project
And waited while transcoding is finished in folder '/F1' on project 'P_MFTL_S15' files page
When I select file '128_shortname.jpg' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID           |
| FID_MFTL_S15 |
And click on element 'SaveButton'
And go to the Library page for collection 'My Assets'NEWLIB
Then I should see available preview for asset 'FID_MFTL_S15' in collection 'My Assets'NEWLIB


Scenario: Check that file sent to Library from project appears in 'myassets' category
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        |Access|
| U_MFTL_S16 | agency.user |streamlined_library,library|
And logged in with details of 'U_MFTL_S16'
And created 'P_MFTL_S16' project
And created '/F1' folder for project 'P_MFTL_S16'
And uploaded '/images/logo.png' file into '/F1' folder for 'P_MFTL_S16' project
And waited while transcoding is finished in folder '/F1' on project 'P_MFTL_S16' files page
When I select file 'logo.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID           |
| FID_MFTL_S16 |
And click on element 'SaveButton'
And go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see assets with id 'FID_MFTL_S16' in the collection 'My Assets'NEWLIB



Scenario: Check that deletion metadata of file in project doesn't affect asset based on this file in Library
Meta:@gdam
     @bug
     @library
!--UIR-1069
Given I created 'P_MFTL_S18' project
And created '/F1' folder for project 'P_MFTL_S18'
And uploaded '/files/Fish-Ad.mov' file into '/F1' folder for 'P_MFTL_S18' project
And waited while transcoding is finished in folder '/F1' on project 'P_MFTL_S18' files page
When I go to file 'Fish-Ad.mov' info page in folder '/F1' project 'P_MFTL_S18'
And 'save' file info by next information:
| FieldName                   | FieldValue                       |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Genre                       | Comedy                           |
| Air Date                    | 12/12/2015                       |
| Shoot Dates                 | 12/12/2015                       |
| Country                     | Austria                          |
| Screen                      | Spot                             |
| Duration                    | 6s 33ms                          |
| Approved For Broadcast      | No                               |
| Clock number                | testcn                           |
| 2D Artists                  | Test 2D Artists                  |
| 2D Lead Artists             | Test 2D Lead Artists             |
| 2D Supervisor               | Test 2D Supervisor               |
| 3D Artists                  | Test 3D Artists                  |
| 3D Lead Artists             | Test 3D Lead Artists             |
| Account Director            | Test Account Director            |
| Account Manager             | Test Account Manager             |
| Advertising agency          | Test Advertising agency          |
| Agency Job reference        | Test Agency Job reference        |
| Agency TV Producer          | Test Agency TV Producer          |
| Animation company           | Test Animation company           |
| Animator                    | Test Animator                    |
| Art Director                | Test Art Director                |
| Artbuyer                    | Test Artbuyer                    |
| Assist                      | Test Assist                      |
| Audio Post                  | Test Audio Post                  |
| Brief                       | Test Brief                       |
| Chief Creative Officer      | Test Chief Creative Officer      |
| Colourist                   | Test Colourist                   |
| Composer                    | Test Composer                    |
| Copywriter                  | Test Copywriter                  |
| Costume Designer            | Test Costume Designer            |
| Creative Director           | Test Creative Director           |
| Description                 | Test Description                 |
| Director                    | Test Director                    |
| Director of Photography     | Test Director of Photography     |
| Edit Assistant              | Test Edit Assistant              |
| Edit company                | Test Edit company                |
| Editor                      | Test Editor                      |
| Executive Creative Director | Test Executive Creative Director |
| Executive Producer          | Test Executive Producer          |
| Executive Producer          | Test Executive Producer          |
| Executive Producer          | Test Executive Producer          |
| Film Processing Lab         | Test Film Processing Lab         |
| Head of TV                  | Test Head of TV                  |
| ID Film (ARPP Users only)   | Test ID Film ARPP Users only     |
| Lyrical Artist              | Test Lyrical Artist              |
| Lyricist                    | Test Lyricist                    |
| Make up Artist              | Test Make up Artist              |
| Market Sector               | Test Market Sector               |
| Matte Painting              | Test Matte Painting              |
| Media Agency                | Test Media Agency                |
| Media Agency Planner        | Test Media Agency Planner        |
| Media Planner               | Test Media Planner               |
| Motion Graphics             | Test Motion Graphics             |
| Music Arranger              | Test Music Arranger              |
| Music Company               | Test Music Company               |
| Music Performer             | Test Music Performer             |
| Music recorded at           | Test Music recorded at           |
| Planner                     | Test Planner                     |
| Post-production             | Test Post production             |
| Producer                    | Test Producer                    |
| Production Company Producer | Test Production Company Producer |
| Production Designer         | Test Production Designer         |
| Production Manager          | Test Production Manager          |
| Production company          | Test Production company          |
| Recording Engineer          | Test Recording Engineer          |
| Shoot Supervisor            | Test Shoot Supervisor            |
| Sound Design                | Test Sound Design                |
| Strategist                  | Test Strategist                  |
| Studio                      | Test Studio                      |
| Studio/Location             | Test Studio or Location          |
| Voice Over Artist           | Test Voice Over Artist           |
| Production Assistant        | Test Production Assistant        |
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID           |
| FID_MFTL_S18 |
And click on element 'SaveButton'
And go to file 'Fish-Ad.mov' info page in folder '/F1' project 'P_MFTL_S18'
And 'save' file info by next information:
| FieldName                   | FieldValue |
| Category                    |            |
| Sub Category                |            |
| Genre                       |            |
| Air Date                    |            |
| Shoot Dates                 |            |
| Country                     |            |
| Screen                      |            |
| Duration                    |            |
| Approved For Broadcast      |            |
| Clock number                |            |
| 2D Artists                  |            |
| 2D Lead Artists             |            |
| 2D Supervisor               |            |
| 3D Artists                  |            |
| 3D Lead Artists             |            |
| Account Director            |            |
| Account Manager             |            |
| Advertising agency          |            |
| Agency Job reference        |            |
| Agency TV Producer          |            |
| Animation company           |            |
| Animator                    |            |
| Art Director                |            |
| Artbuyer                    |            |
| Assist                      |            |
| Audio Post                  |            |
| Brief                       |            |
| Chief Creative Officer      |            |
| Colourist                   |            |
| Composer                    |            |
| Copywriter                  |            |
| Costume Designer            |            |
| Creative Director           |            |
| Description                 |            |
| Director                    |            |
| Director of Photography     |            |
| Edit Assistant              |            |
| Edit company                |            |
| Editor                      |            |
| Executive Creative Director |            |
| Executive Producer          |            |
| Executive Producer          |            |
| Executive Producer          |            |
| Film Processing Lab         |            |
| Head of TV                  |            |
| ID Film (ARPP Users only)   |            |
| Lyrical Artist              |            |
| Lyricist                    |            |
| Make up Artist              |            |
| Market Sector               |            |
| Matte Painting              |            |
| Media Agency                |            |
| Media Agency Planner        |            |
| Media Planner               |            |
| Motion Graphics             |            |
| Music Arranger              |            |
| Music Company               |            |
| Music Performer             |            |
| Music recorded at           |            |
| Planner                     |            |
| Post-production             |            |
| Producer                    |            |
| Production Company Producer |            |
| Production Designer         |            |
| Production Manager          |            |
| Production company          |            |
| Recording Engineer          |            |
| Shoot Supervisor            |            |
| Sound Design                |            |
| Strategist                  |            |
| Studio                      |            |
| Studio/Location             |            |
| VFX Producer                |            |
| Voice Over Artist           |            |
| Production Assistant        |            |
And wait for '3' seconds
And go to asset 'FID_MFTL_S18' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Genre                       | Comedy                           |
| Air Date                    | 12/12/2015                       |
| Shoot Dates                 | 12/12/2015                       |
| Country                     | Austria                          |
| Screen                      | Spot                             |
| Duration                    | 6s 33ms                          |
| Approved For Broadcast      | No                               |
| Clock number                | testcn                           |
| 2D Artists                  | Test 2D Artists                  |
| 2D Lead Artists             | Test 2D Lead Artists             |
| 2D Supervisor               | Test 2D Supervisor               |
| 3D Artists                  | Test 3D Artists                  |
| 3D Lead Artists             | Test 3D Lead Artists             |
| Account Director            | Test Account Director            |
| Account Manager             | Test Account Manager             |
| Advertising agency          | Test Advertising agency          |
| Agency Job reference        | Test Agency Job reference        |
| Agency TV Producer          | Test Agency TV Producer          |
| Animation company           | Test Animation company           |
| Animator                    | Test Animator                    |
| Art Director                | Test Art Director                |
| Artbuyer                    | Test Artbuyer                    |
| Assist                      | Test Assist                      |
| Audio Post                  | Test Audio Post                  |
| Brief                       | Test Brief                       |
| Chief Creative Officer      | Test Chief Creative Officer      |
| Colourist                   | Test Colourist                   |
| Composer                    | Test Composer                    |
| Copywriter                  | Test Copywriter                  |
| Costume Designer            | Test Costume Designer            |
| Creative Director           | Test Creative Director           |
| Description                 | Test Description                 |
| Director                    | Test Director                    |
| Director of Photography     | Test Director of Photography     |
| Edit Assistant              | Test Edit Assistant              |
| Edit company                | Test Edit company                |
| Editor                      | Test Editor                      |
| Executive Creative Director | Test Executive Creative Director |
| Executive Producer          | Test Executive Producer          |
| Executive Producer          | Test Executive Producer          |
| Executive Producer          | Test Executive Producer          |
| Film Processing Lab         | Test Film Processing Lab         |
| Head of TV                  | Test Head of TV                  |
| ID Film (ARPP Users only)   | Test ID Film ARPP Users only     |
| Lyrical Artist              | Test Lyrical Artist              |
| Lyricist                    | Test Lyricist                    |
| Make up Artist              | Test Make up Artist              |
| Market Sector               | Test Market Sector               |
| Matte Painting              | Test Matte Painting              |
| Media Agency                | Test Media Agency                |
| Media Agency Planner        | Test Media Agency Planner        |
| Media Planner               | Test Media Planner               |
| Motion Graphics             | Test Motion Graphics             |
| Music Arranger              | Test Music Arranger              |
| Music Company               | Test Music Company               |
| Music Performer             | Test Music Performer             |
| Music recorded at           | Test Music recorded at           |
| Planner                     | Test Planner                     |
| Post-production             | Test Post production             |
| Producer                    | Test Producer                    |
| Production Company Producer | Test Production Company Producer |
| Production Designer         | Test Production Designer         |
| Production Manager          | Test Production Manager          |
| Production company          | Test Production company          |
| Recording Engineer          | Test Recording Engineer          |
| Shoot Supervisor            | Test Shoot Supervisor            |
| Sound Design                | Test Sound Design                |
| Strategist                  | Test Strategist                  |
| Studio                      | Test Studio                      |
| Studio/Location             | Test Studio or Location          |
| Voice Over Artist           | Test Voice Over Artist           |
| Production Assistant        | Test Production Assistant        |



Scenario: Check that file could be moved to library only with filled mandatory fields
Meta:@gdam
@library
Given I created 'P_MFTL_S19' project
And created '/F1' folder for project 'P_MFTL_S19'
And uploaded '/files/logo3.png' file into '/F1' folder for 'P_MFTL_S19' project
And waited while transcoding is finished in folder '/F1' on project 'P_MFTL_S19' files page
When I select file 'logo3.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill add file to library page with ID ''
Then I 'should' see red input for fields 'ID' on add file to library page
When I go to  Library pageNEWLIB
Then 'should not' see assets 'logo3.png' in the collection 'Everything'NEWLIB


Scenario: Check that Warning Message popup appears when adding to Library existing asset on asset info page
Meta:@gdam
@projects
Given I created 'ACLOAP5' project
And created '/ACLOAF5' folder for project 'ACLOAP5'
And uploaded '/files/_file1.gif' file into '/ACLOAF5' folder for 'ACLOAP5' project
And waited while transcoding is finished in folder '/ACLOAF5' on project 'ACLOAP5' files page
When I go to file '_file1.gif' info page in folder '/ACLOAF5' project 'ACLOAP5'
When I send file '_file1.gif' on project 'ACLOAP5' folder '/ACLOAF5' on opened file info page
And fill following data on add file to library page:
| ID   |
| <Id> |
And click on element 'SaveButton'
And go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see assets with id '<Id>' in the collection 'My Assets'NEWLIB
When I go to file '_file1.gif' info page in folder '/ACLOAF5' project 'ACLOAP5'
When I click send file '_file1.gif' on project 'ACLOAP5' folder '/ACLOAF5' on opened file info page
Then I '<condition>' see warning message as 'One or more of the files you have selected has already been sent to Library. If you proceed, you may create new assets if any of those files still exist in Library. Are you sure you want to send the file(s)?' in send to library pop up on FileInfo page

Examples:
| condition  | Id         |
| should     | ACLOAID5_1 |



Scenario: Check that Warning Message popup appears when adding to Library existing asset on Project page
Meta:@gdam
@library
Given I created 'ACLOAP5' project
And created '/ACLOAF5' folder for project 'ACLOAP5'
And uploaded '/files/_file1.gif' file into '/ACLOAF5' folder for 'ACLOAP5' project
And waited while transcoding is finished in folder '/ACLOAF5' on project 'ACLOAP5' files page
When I send file '_file1.gif' on project 'ACLOAP5' folder '/ACLOAF5' page to Library
And fill following data on add file to library page:
| ID   |
| <Id> |
And click on element 'SaveButton'
And go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see assets with id '<Id>' in the collection 'My Assets'NEWLIB
When I click send file '_file1.gif' on project 'ACLOAP5' folder '/ACLOAF5' page to Library
Then I '<condition>' see warning message as 'One or more of the files you have selected has already been sent to Library. If you proceed, you may create new assets if any of those files still exist in Library. Are you sure you want to send the file(s)?' in send to library pop up

Examples:
| condition  | Id         |
| should     | ACLOAID5_1 |



