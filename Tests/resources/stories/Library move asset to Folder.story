!--NGN-899 NGN-3423
Feature:          Library move asset to Folder
Narrative:
In order to
As a              AgencyAdmin
I want to         Check moving asset to Folder from Library

Scenario: Check that visibility of 'Add to Project' button depends on 'Folders' checkbox
Meta:@gdam
@uitobe
!--can't be done until UIR-793 or QA-785 is fixed
Given I created users with following fields:
| Email       | Role        | Access   |
| <UserEmail> | agency.user | <Access> |
And logged in with details of '<UserEmail>'
And uploaded asset '/files/New Text Document.txt' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'New Text Document.txt'NEWLIB
When I go to asset 'New Text Document.txt' info page in Library for collection 'My Assets'NEWLIB
Then I '<Condition>' see Add to project option in More button menu on asset 'New Text Document.txt' info page in Library for collection 'My Assets'

Examples:
| UserEmail     | Access          | Condition  |
| U_LMATF_S01_1 | folders,library | should     |
| U_LMATF_S01_2 | library         | should not |



Scenario: Check proper displaying folder hierarchy on Add Asset to Project pop-up
Meta:@gdam
@library
Given I created 'P_LMATF_S05' project
And created in 'P_LMATF_S05' project next folders:
| folder       |
| /F2/F21/F211 |
And uploaded asset '/files/New Text Document.txt' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'New Text Document.txt'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
And I refresh the page
Then I should see folder 'F211' under 'F2/F21/F211' of project 'P_LMATF_S05' on Add Asset to Project popup while adding asset 'New Text Document.txt' from collection 'My Assets' pageNEWLIB



Scenario: Check that after adding asset to project, there should appear a link Added to project [Project Name] on asset details
!--NGN-2711, NGN-3520
Meta: @skip
      @gdam
Given I created users with following fields:
| Email       | Role         |
| U_LMATF_S08 | agency.admin |
And logged in with details of 'U_LMATF_S08'
And created 'P_LMATF_S08' project
And created '/F1' folder for project 'P_LMATF_S08'
And uploaded asset '/files/New Text Document.txt' into library
And waited while transcoding is finished in collection 'My Assets'
When I add following asset 'New Text Document.txt' of collection 'My Assets' to project 'P_LMATF_S08' folder '/F1'
And go to asset 'New Text Document.txt' info page in Library for collection 'My Assets'
Then I 'should' see Added to project 'P_LMATF_S08' link on asset 'New Text Document.txt' info page in Library for collection 'My Assets'
When I click on Added to project 'P_LMATF_S08' link on asset info page
Then I should see file '/files/New Text Document' info page in folder '/F1' project 'P_LMATF_S08'


Scenario: Check that after adding asset into project it remains in Library
!--NGN-3514
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| U_LMATF_S09 | agency.admin |folders,streamlined_library|
And logged in with details of 'U_LMATF_S09'
And created 'P_LMATF_S09' project
And created '/F1' folder for project 'P_LMATF_S09'
And uploaded asset '/files/image9.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add following asset 'image9.jpg' of collection 'My Assets' to project 'P_LMATF_S09' folder '/F1'NEWLIB
And go to library page for collection 'My Assets'NEWLIB
Then I 'should' see assets 'image9.jpg' in the collection 'My Assets'NEWLIB
And 'should' see file 'image9.jpg' on project 'P_LMATF_S09' folder '/F1' files page

Scenario: Check that deletion asset in Library doesn't delete it from project
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access
| U_LMATF_S11 | agency.admin |folders,streamlined_library|
And logged in with details of 'U_LMATF_S11'
And created 'P_LMATF_S11' project
And created '/F1' folder for project 'P_LMATF_S11'
And uploaded asset '/files/image10.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add following asset 'image10.jpg' of collection 'My Assets' to project 'P_LMATF_S11' folder '/F1'
And delete asset 'image10.jpg' from collection 'My Assets' in new library
Then I 'should' see file 'image10.jpg' on project 'P_LMATF_S11' folder '/F1' files page
When I go to library page for collection 'My Assets'NEWLIB
Then I 'should not' see assets 'image10.jpg' in the collection 'My Assets'NEWLIB


Scenario: Check that file can be copied to folder where the same file is already exist
Meta:@gdam
@library
Given I created 'P_LMATF_S13' project
And created '/F1' folder for project 'P_LMATF_S13'
And uploaded '/files/image9.jpg' file into '/F1' folder for 'P_LMATF_S13' project
And uploaded asset '/files/image9.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add following asset 'image9.jpg' of collection 'My Assets' to project 'P_LMATF_S13' folder '/F1'NEWLIB
Then I 'should' see files 'image9.jpg,image9.jpg' on project 'P_LMATF_S13' folder '/F1' files page



Scenario: Check that changing asset details in Library doesn't affect added file into project
!--NGN-3520
Meta:@gdam
@library
!--This scenario fails due to long expansion of section on asset edit form on FF we are using...need to update FF
Given opened role 'agency.admin' page with parent 'DefaultAgency'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'newrole'
And I clicked element 'SaveButton' on page 'Roles'
And added following permissions 'dictionary.add_on_the_fly' to role 'newrole' in agency 'DefaultAgency'
And I created users with following fields:
| Email       | Role         | Access           |
| U_LMATF_S14 | newrole      | streamlined_library  |
And logged in with details of 'U_LMATF_S14'
And created 'P_LMATF_S14' project
And created '/F1' folder for project 'P_LMATF_S14'
And uploaded asset '/files/13DV-CAPITAL-10.mpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset '13DV-CAPITAL-10.mpg' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset '13DV-CAPITAL-10.mpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName                   | FieldValue                       |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Air Date                    | 12/12/15                       |
| Shoot Dates                 | 12/12/15                       |
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
| Production Company Producer | Test Production Company Producer |
| Production Designer         | Test Production Designer         |
| Production Manager          | Test Production Manager          |
| Production company          | Test Production company          |
| Recording Engineer          | Test Recording Engineer          |
| Producer                    | Test Producer                    |
| Shoot Supervisor            | Test Shoot Supervisor            |
| Sound Design                | Test Sound Design                |
| Strategist                  | Test Strategist                  |
| Studio                      | Test Studio                      |
| Studio/Location             | Test Studio or Location          |
| VFX  Producer                | Test VFX Producer               |
| Voice Over Artist           | Test Voice Over Artist           |
| Production Assistant        | Test Production Assistant        |
And add following asset '13DV-CAPITAL-10.mpg' of collection 'My Assets' to project 'P_LMATF_S14' folder '/F1'
And 'save' asset '13DV-CAPITAL-10.mpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName                   | FieldValue |
| Category                    |            |
| Air Date                    |            |
| Shoot Dates                 |            |
| Country                     |            |
| Screen                      |            |
| Duration                    |            |
| Approved For Broadcast      |            |
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
| VFX  Producer               |            |
| Studio/Location             |            |
| Voice Over Artist           |            |
| Production Assistant        |            |
And go to file '13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'P_LMATF_S14'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName                   | FieldValue                       |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
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
| VFX Producer                | Test VFX Producer                |
| Studio/Location             | Test Studio or Location          |
| Voice Over Artist           | Test Voice Over Artist           |
| Production Assistant        | Test Production Assistant        |


Scenario: Check that preview, proxy and metadata of asset are correctly and completely transferred for added to project file
Meta:@gdam
@bug
@library
!--UIR-1069
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAFAR1     | TAFBR1     | TAFSB1     | TAFSP1    |
And opened role 'agency.admin' page with parent 'DefaultAgency'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'newrole1'
And I clicked element 'SaveButton' on page 'Roles'
And added following permissions 'dictionary.add_on_the_fly' to role 'newrole1' in agency 'DefaultAgency'
And I created users with following fields:
| Email       | Role         | Access           |
| U_LMATF_S12 | newrole1      | streamlined_library  |
And logged in with details of 'U_LMATF_S12'
And created 'P_LMATF_S12' project
And created '/F1' folder for project 'P_LMATF_S12'
And uploaded asset '/files/13DV-CAPITAL-10.mpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I go to asset '13DV-CAPITAL-10.mpg' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset '13DV-CAPITAL-10.mpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName                   | FieldValue                       |
| Title                       | FT_LMATF.S12                     |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Air Date                    | 12/12/15                       |
| Shoot Dates                 | 12/12/15                       |
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
| Production Company Producer | Test Production Company Producer |
| Production Designer         | Test Production Designer         |
| Production Manager          | Test Production Manager          |
| Production company          | Test Production company          |
| Recording Engineer          | Test Recording Engineer          |
| Producer                    | Test Producer                    |
| Shoot Supervisor            | Test Shoot Supervisor            |
| Sound Design                | Test Sound Design                |
| Strategist                  | Test Strategist                  |
| Studio                      | Test Studio                      |
| Studio/Location             | Test Studio or Location          |
| Voice Over Artist           | Test Voice Over Artist           |
| Production Assistant        | Test Production Assistant        |
And add following asset 'FT_LMATF.S12' of collection 'My Assets' to project 'P_LMATF_S12' folder '/F1'
And go to project 'P_LMATF_S12' folder '/F1' page
Then I 'should' see preview file 'FT_LMATF.S12' on project 'P_LMATF_S12' folder '/F1' page
When I go to file 'FT_LMATF.S12' info page in folder '/F1' project 'P_LMATF_S12'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName                   | FieldValue                       |
| Title                       | FT_LMATF.S12                     |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Country                     | Austria                          |
| Screen                      | Spot                             |
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
| Copywriter                  | Test Copywriter                  |
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
And 'should' see proxy of video file 'FT_LMATF.S12' on info page in folder '/F1' project 'P_LMATF_S12'
And 'should' see Download proxy button on file 'FT_LMATF.S12' info page in folder '/F1' project 'P_LMATF_S12'
