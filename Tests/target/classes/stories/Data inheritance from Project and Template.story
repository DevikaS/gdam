!--NGN-7300
Feature:          Data inheritance from Project and Template
Narrative:
In order to
As a              GlobalAdmin
I want to         Check proper data inheritance from Project/Template in case to upload file, move file to library, add asset to a project

Scenario: Check that uploaded file inherits data of Common Custom fields in project
Meta:@projects
     @gdam
Given I created the agency 'A_DIFPT_S01' with default attributes
And created users with following fields:
| Email       | Role         | Agency       |
| U_DIFPT_S01 | agency.admin | A_DIFPT_S01  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_DIFPT_S01':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_DIFPT_S01 | BR_DIFPT_S01 | SBR_DIFPT_S01 | PR_DIFPT_S01 |
And created following 'common' custom metadata fields for agency 'A_DIFPT_S01':
| FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| string       | CMSF DIFPT  |          |                 |             |                           |
| dropdown     | CMDDF DIFPT | true     | true            |             |                           |
| date         | CMDF DIFPT  |          |                 | MM/DD/YEAR  |                           |
| radioButtons | CMRBF DIFPT |          |                 |             | CMRBFV DIFPT,CMRBSV DIFPT |
And logged in with details of 'U_DIFPT_S01'
When I create new project with following fields:
| FieldName   | FieldValue   |
| Name        | P_DIFPT_S01  |
| Media type  | Broadcast    |
| CMSF DIFPT  | CMSFV DIFPT  |
| CMDDF DIFPT | CMDDFV DIFPT |
| CMDF DIFPT  | 12/12/2015   |
| CMRBF DIFPT | CMRBFV DIFPT |
| Start date  | Today        |
| End date    | Tomorrow     |
And create '/F_DIFPT_S01' folder for project 'P_DIFPT_S01'
And upload '/files/Fish Ad.mov' file into '/F_DIFPT_S01' folder for 'P_DIFPT_S01' project
And wait while transcoding is finished in folder '/F_DIFPT_S01' on project 'P_DIFPT_S01' files page
And go to file 'Fish Ad.mov' info page in folder '/F_DIFPT_S01' project 'P_DIFPT_S01'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName   | FieldValue   |
| Title       | Fish Ad.mov  |
| Media type  | video        |
| CMSF DIFPT  | CMSFV DIFPT  |
| CMDDF DIFPT | CMDDFV DIFPT |
| CMDF DIFPT  | 12/12/2015   |
| CMRBF DIFPT | CMRBFV DIFPT |


Scenario: Check that uploaded file inherits data of Common Custom fields in template
Meta:@projects
     @gdam
Given I created the agency 'A_DIFPT_S02' with default attributes
And created users with following fields:
| Email       | Role         | Agency       |
| U_DIFPT_S02 | agency.admin | A_DIFPT_S02  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_DIFPT_S02':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_DIFPT_S02 | BR_DIFPT_S02 | SBR_DIFPT_S02 | PR_DIFPT_S02 |
And created following 'common' custom metadata fields for agency 'A_DIFPT_S02':
| FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| string       | CMSF DIFPT  |          |                 |             |                           |
| dropdown     | CMDDF DIFPT | true     | true            |             |                           |
| date         | CMDF DIFPT  |          |                 | MM/DD/YEAR  |                           |
| radioButtons | CMRBF DIFPT |          |                 |             | CMRBFV DIFPT,CMRBSV DIFPT |
And logged in with details of 'U_DIFPT_S02'
When I create new template with following fields:
| FieldName   | FieldValue   |
| Name        | T_DIFPT_S02  |
| Media type  | Broadcast    |
| CMSF DIFPT  | CMSFV DIFPT  |
| CMDDF DIFPT | CMDDFV DIFPT |
| CMDF DIFPT  | 12/12/2015   |
| CMRBF DIFPT | CMRBFV DIFPT |
| Start date  | Today        |
| End date    | Tomorrow     |
And create '/F_DIFPT_S02' folder for template 'T_DIFPT_S02'
And upload '/files/Fish Ad.mov' file into '/F_DIFPT_S02' folder for 'T_DIFPT_S02' template
And wait while transcoding is finished in folder '/F_DIFPT_S02' on template 'T_DIFPT_S02' files page
And go to file 'Fish Ad.mov' info page in folder '/F_DIFPT_S02' template 'T_DIFPT_S02'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName   | FieldValue   |
| Title       | Fish Ad.mov  |
| Media type  | video        |
| CMSF DIFPT  | CMSFV DIFPT  |
| CMDDF DIFPT | CMDDFV DIFPT |
| CMDF DIFPT  | 12/12/2015   |
| CMRBF DIFPT | CMRBFV DIFPT |


Scenario: Check that changing inherited data in file isn't affected common data in projects
Meta:@projects
     @gdam
Given I created the agency 'A_DIFPT_S04' with default attributes
And created users with following fields:
| Email       | Role         | Agency       |
| U_DIFPT_S04 | agency.admin | A_DIFPT_S04  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_DIFPT_S04':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_DIFPT_S04 | BR_DIFPT_S04 | SBR_DIFPT_S04 | PR_DIFPT_S04 |
And created following 'common' custom metadata fields for agency 'A_DIFPT_S04':
| FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| string       | CMSF DIFPT  |          |                 |             |                           |
| dropdown     | CMDDF DIFPT | true     | true            |             |                           |
| date         | CMDF DIFPT  |          |                 | MM/DD/YEAR  |                           |
| radioButtons | CMRBF DIFPT |          |                 |             | CMRBFV DIFPT,CMRBSV DIFPT |
And logged in with details of 'U_DIFPT_S04'
When I create new project with following fields:
| FieldName   | FieldValue   |
| Name        | P_DIFPT_S04  |
| Media type  | Broadcast    |
| CMSF DIFPT  | CMSFV DIFPT  |
| CMDDF DIFPT | CMDDFV DIFPT |
| CMDF DIFPT  | 12/12/2015   |
| CMRBF DIFPT | CMRBFV DIFPT |
| Start date  | Today        |
| End date    | Tomorrow     |
And create '/F_DIFPT_S04' folder for project 'P_DIFPT_S04'
And upload '/files/Fish Ad.mov' file into '/F_DIFPT_S04' folder for 'P_DIFPT_S04' project
And wait while transcoding is finished in folder '/F_DIFPT_S04' on project 'P_DIFPT_S04' files page
And go to file 'Fish Ad.mov' info page in folder '/F_DIFPT_S04' project 'P_DIFPT_S04'
And 'save' file info by next information:
| FieldName    | FieldValue    |
| Clock number | testcn        |
| CMSF DIFPT   | CMSFUV DIFPT  |
| CMDDF DIFPT  | CMDDFUV DIFPT |
Then I 'should' see following fields on opened Project 'P_DIFPT_S04' Overview page:
| FieldName   | FieldValue   |
| CMSF DIFPT  | CMSFV DIFPT  |
| CMDDF DIFPT | CMDDFV DIFPT |
| CMDF DIFPT  | 12/12/2015   |
| CMRBF DIFPT | CMRBFV DIFPT |



Scenario: Check that inherited data from common custom fields aren't transferred to asset in case to add asset to project
Meta: @skip
     @gdam
!--18/08 confirmed with Maria that this test can be skipped as its not longer important to be tested
Given I created the agency 'A_DIFPT_S07' with default attributes
And created users with following fields:
| Email       | Role         | Agency       |
| U_DIFPT_S07 | agency.admin | A_DIFPT_S07  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_DIFPT_S07':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_DIFPT_S07 | BR_DIFPT_S07 | SBR_DIFPT_S07 | PR_DIFPT_S07 |
And created following 'common' custom metadata fields for agency 'A_DIFPT_S07':
| FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| string       | CMSF DIFPT  |          |                 |             |                           |
| dropdown     | CMDDF DIFPT | true     | true            |             |                           |
| date         | CMDF DIFPT  |          |                 | MM/DD/YEAR  |                           |
| radioButtons | CMRBF DIFPT |          |                 |             | CMRBFV DIFPT,CMRBSV DIFPT |
And logged in with details of 'U_DIFPT_S07'
When I create new project with following fields:
| FieldName   | FieldValue    |
| Name        | P_DIFPT_S07   |
| Media type  | Broadcast     |
| Advertiser  | ADV_DIFPT_S07 |
| Brand       | BR_DIFPT_S07  |
| Sub Brand   | SBR_DIFPT_S07 |
| Product     | PR_DIFPT_S07  |
| Campaign    | Test Campaign |
| CMSF DIFPT  | CMSFPV DIFPT  |
| CMDDF DIFPT | CMDDFPV DIFPT |
| CMRBF DIFPT | CMRBFV DIFPT  |
| Start Date  | Today         |
| End Date    | Tomorrow      |
And create '/F_DIFPT_S07' folder for project 'P_DIFPT_S07'
And upload file '/files/Fish-Ad.mov' into library
And wait while transcoding is finished in collection 'My Assets'
And go to asset 'Fish-Ad.mov' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName    | FieldValue         |
| Advertiser   | FADV_DIFPT_S07     |
| Brand        | FBR_DIFPT_S07      |
| Sub Brand    | FSBR_DIFPT_S07     |
| Product      | FPR_DIFPT_S07      |
| Campaign     | Test file Campaign |
| CMSF DIFPT   | CMSFV DIFPT        |
| CMDDF DIFPT  | CMDDFV DIFPT       |
| CMRBF DIFPT  | CMRBSV DIFPT       |
| Clock number | testcn             |
And add following asset 'Fish-Ad.mov' of collection 'My Assets' to project 'P_DIFPT_S07' folder '/F_DIFPT_S07'
And go to file 'Fish-Ad.mov' info page in folder '/F_DIFPT_S07' project 'P_DIFPT_S07'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName    | FieldValue         |
| Advertiser   | FADV_DIFPT_S07     |
| Brand        | FBR_DIFPT_S07      |
| Sub Brand    | FSBR_DIFPT_S07     |
| Product      | FPR_DIFPT_S07      |
| Campaign     | Test file Campaign |
| CMSF DIFPT   | CMSFV DIFPT        |
| CMDDF DIFPT  | CMDDFV DIFPT       |
| CMRBF DIFPT  | CMRBSV DIFPT       |


Scenario: Check that data of media type's fields are transferred to file in case to add asset to project
Meta: @skip
      @gdam
!-- 18/08 --confirmed with Maria that this test can be skipped as its not important
Given I created the agency 'A_DIFPT_S08' with default attributes
And created users with following fields:
| Email       | Role         | Agency       |
| U_DIFPT_S08 | agency.admin | A_DIFPT_S08  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_DIFPT_S08':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_DIFPT_S08 | BR_DIFPT_S08 | SBR_DIFPT_S08 | PR_DIFPT_S08 |
And created following 'common' custom metadata fields for agency 'A_DIFPT_S08':
| FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| string       | CMSF DIFPT  |          |                 |             |                           |
| dropdown     | CMDDF DIFPT | true     | true            |             |                           |
| date         | CMDF DIFPT  |          |                 | MM/DD/YEAR  |                           |
| radioButtons | CMRBF DIFPT |          |                 |             | CMRBFV DIFPT,CMRBSV DIFPT |
And logged in with details of 'U_DIFPT_S08'
When I create new project with following fields:
| FieldName   | FieldValue    |
| Name        | P_DIFPT_S08   |
| Media type  | Broadcast     |
| Advertiser  | ADV_DIFPT_S08 |
| Brand       | LBB Brand     |
| Sub Brand   | LBB Sub Brand |
| Product     | LBB Product   |
| Campaign    | Test Campaign |
| CMSF DIFPT  | CMSFPV DIFPT  |
| CMDDF DIFPT | CMDDFPV DIFPT |
| CMRBF DIFPT | CMRBFV DIFPT  |
| CMDF DIFPT  | 12/12/2015    |
| Start Date  | Today         |
| End Date    | Tomorrow      |
And upload file '/files/GWGTest2.pdf' into library
And create '/F_DIFPT_S08' folder for project 'P_DIFPT_S08'
And wait while transcoding is finished in collection 'My Assets'
And go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName                   | FieldValue                       |
| Advertiser                  | FADV_DIFPT_S08                   |
| Campaign                    | Test file Campaign               |
| CMSF DIFPT                  | CMSFV DIFPT                      |
| CMDDF DIFPT                 | CMDDFV DIFPT                     |
| CMRBF DIFPT                 | CMRBSV DIFPT                     |
| CMDF DIFPT                  | 12/12/2015                       |
| Title                       | Print Ad.pdf                     |
| Media type                  | print                            |
| Country                     | Austria                          |
| Shoot Date                  | 12/12/2015                       |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Genre                       | Comedy                           |
| Account Director            | Test Account Director            |
| Account Manager             | Test Account Manager             |
| Advertising agency          | Test Advertising agency          |
| Agency Planner              | Test Agency Planner              |
| Art Director                | Test Art Director                |
| Artbuyer                    | Test Artbuyer                    |
| Brief                       | Test Brief                       |
| Chief Creative Officer      | Test Chief Creative Officer      |
| Copywriter                  | Test Copywriter                  |
| Creative Director           | Test Creative Director           |
| Description                 | Test Description                 |
| Executive Creative Director | Test Executive Creative Director |
| Location/Studio             | Test Location or Studio          |
| Market Sector               | Test Market Sector               |
| Media Agency                | Test Media Agency                |
| Media Agency Planner        | Test Media Agency Planner        |
| Media Planner               | Test Media Planner               |
| Photographer                | Test Photographer                |
| Planner                     | Test Planner                     |
| Retoucher                   | Test Retoucher                   |
| Strategist                  | Test Strategist                  |
| Studio Name                 | Test Studio Name                 |
And add following asset 'Print Ad.pdf' of collection 'My Assets' to project 'P_DIFPT_S08' folder '/F_DIFPT_S08'
And go to file 'Print Ad.pdf' info page in folder '/F_DIFPT_S08' project 'P_DIFPT_S08'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName                   | FieldValue                       |
| Advertiser                  | FADV_DIFPT_S08                   |
| Campaign                    | Test file Campaign               |
| CMSF DIFPT                  | CMSFV DIFPT                      |
| CMDDF DIFPT                 | CMDDFV DIFPT                     |
| CMRBF DIFPT                 | CMRBSV DIFPT                     |
| CMDF DIFPT                  | 12/12/2015                       |
| Title                       | Print Ad.pdf                     |
| Media type                  | print                            |
| Country                     | Austria                          |
| Shoot Date                  | 12/12/2015                       |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Genre                       | Comedy                           |
| Account Director            | Test Account Director            |
| Account Manager             | Test Account Manager             |
| Advertising agency          | Test Advertising agency          |
| Agency Planner              | Test Agency Planner              |
| Art Director                | Test Art Director                |
| Artbuyer                    | Test Artbuyer                    |
| Brief                       | Test Brief                       |
| Chief Creative Officer      | Test Chief Creative Officer      |
| Copywriter                  | Test Copywriter                  |
| Creative Director           | Test Creative Director           |
| Description                 | Test Description                 |
| Executive Creative Director | Test Executive Creative Director |
| Location/Studio             | Test Location or Studio          |
| Market Sector               | Test Market Sector               |
| Media Agency                | Test Media Agency                |
| Media Agency Planner        | Test Media Agency Planner        |
| Media Planner               | Test Media Planner               |
| Photographer                | Test Photographer                |
| Planner                     | Test Planner                     |
| Retoucher                   | Test Retoucher                   |
| Strategist                  | Test Strategist                  |
| Studio Name                 | Test Studio Name                 |


Scenario: Check that inherited data is transferred to asset in case to move file to library (will be checked common custom and video/print custom)
Meta:@gdam
     @library
     @bug
!--UIR-1069
Given I created the agency 'A_DIFPT_S05' with default attributes
And created users with following fields:
| Email       | Role         | Agency       |Access|
| U_DIFPT_S05 | agency.admin | A_DIFPT_S05  |streamlined_library,adkits,folders,library |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_DIFPT_S05':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_DIFPT_S05 | BR_DIFPT_S05 | SBR_DIFPT_S05 | PR_DIFPT_S05 |
And created following 'common' custom metadata fields for agency 'A_DIFPT_S05':
| FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| string       | CMSF DIFPT  |          |                 |             |                           |
| dropdown     | CMDDF DIFPT | true     | true            |             |                           |
| date         | CMDF DIFPT  |          |                 | MM/DD/YEAR  |                           |
| radioButtons | CMRBF DIFPT |          |                 |             | CMRBFV DIFPT,CMRBSV DIFPT |
And logged in with details of 'U_DIFPT_S05'
When I create new project with following fields:
| FieldName   | FieldValue    |
| Name        | P_DIFPT_S05   |
| Media type  | Broadcast     |
| Advertiser  | ADV_DIFPT_S05 |
| Brand       | BR_DIFPT_S05  |
| Sub Brand   | SBR_DIFPT_S05 |
| Product     | PR_DIFPT_S05  |
| Campaign    | Test Campaign |
| CMSF DIFPT  | CMSFV DIFPT   |
| CMDDF DIFPT | CMDDFV DIFPT  |
| CMRBF DIFPT | CMRBFV DIFPT  |
| CMDF DIFPT  | 12/12/2015    |
| Start date  | Today         |
| End date    | Tomorrow      |
And create '/F_DIFPT_S05' folder for project 'P_DIFPT_S05'
And upload '/files/Fish Ad.mov' file into '/F_DIFPT_S05' folder for 'P_DIFPT_S05' project
And wait while transcoding is finished in folder '/F_DIFPT_S05' on project 'P_DIFPT_S05' files page
And go to file 'Fish Ad.mov' info page in folder '/F_DIFPT_S05' project 'P_DIFPT_S05'
And 'save' file info by next information:
| FieldName                   | FieldValue                       |
| Title                       | Tortoise Ad.mov                  |
| Media type                  | video                            |
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
And move file 'Tortoise Ad.mov' from project 'P_DIFPT_S05' folder '/F_DIFPT_S05' to new library page
And go to asset 'Tortoise Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Title                       | Tortoise Ad.mov                  |
| Media type                  | video                            |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Genre                       | Comedy                           |
| Air Date                    | 12/12/2015                       |
| Shoot Dates                 | 12/12/2015                       |                  |
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


Scenario: Check that inherited data (Advertiser/Brand/Sub Brand/Product) can be changed on New Assets form in case to move file to library
Meta:@gdam
     @library
Given I created the agency 'A_DIFPT_S06' with default attributes
And created users with following fields:
| Email       | Role         | Agency       |Access|
| U_DIFPT_S06 | agency.admin | A_DIFPT_S06  |streamlined_library,adkits,folders,library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_DIFPT_S06':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_DIFPT_S06 | BR_DIFPT_S06 | SBR_DIFPT_S06 | PR_DIFPT_S06 |
And created following 'common' custom metadata fields for agency 'A_DIFPT_S06':
| FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| string       | CMSF DIFPT  |          |                 |             |                           |
| dropdown     | CMDDF DIFPT | true     | true            |             |                           |
| date         | CMDF DIFPT  |          |                 | MM/DD/YEAR  |                           |
| radioButtons | CMRBF DIFPT |          |                 |             | CMRBFV DIFPT,CMRBSV DIFPT |
And logged in with details of 'U_DIFPT_S06'
When I create new project with following fields:
| FieldName   | FieldValue    |
| Name        | P_DIFPT_S06   |
| Media type  | Broadcast     |
| Advertiser  | ADV_DIFPT_S06 |
| Campaign    | Test Campaign |
| CMSF DIFPT  | CMSFV DIFPT   |
| CMDDF DIFPT | CMDDFV DIFPT  |
| CMRBF DIFPT | CMRBFV DIFPT  |
| CMDF DIFPT  | 12/12/2015    |
| Start date  | Today         |
| End date    | Tomorrow      |
And create '/F_DIFPT_S06' folder for project 'P_DIFPT_S06'
And upload '/files/Fish Ad.mov' file into '/F_DIFPT_S06' folder for 'P_DIFPT_S06' project
And wait while transcoding is finished in folder '/F_DIFPT_S06' on project 'P_DIFPT_S06' files page
And select file 'Fish Ad.mov' on project  files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill add file to library page with Advertiser 'FADV_DIFPT_S06' and clock number 'testcn'
And wait for '2' seconds
And click on element 'SaveButton'
And wait for '3' seconds
And go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName   | FieldValue     |
| Advertiser  | FADV_DIFPT_S06 |
| Campaign    | Test Campaign  |
| Title       | Fish Ad.mov    |
| CMSF DIFPT  | CMSFV DIFPT    |
| CMDDF DIFPT | CMDDFV DIFPT   |
| CMRBF DIFPT | CMRBFV DIFPT   |
| CMDF DIFPT  | 12/12/2015     |




