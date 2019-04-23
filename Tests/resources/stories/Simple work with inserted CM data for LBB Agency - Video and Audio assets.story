!--NGN-7298
Feature:          Simple work with inserted CM data for LBB Agency - Video and Audio assets
Narrative:        QA internal task
In order to
As a              GlobalAdmin
I want to         check proper data displaying, updating in view form, edit form

Scenario: Check that all specified fields is shown on Edit form of file
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMDV_S01' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |
| U_SWICMDV_S01 | agency.admin | A_SWICMDV_S01 |
And logged in with details of 'U_SWICMDV_S01'
And created 'P_SWICMDV_S01' project
And created '/F_SWICMDV_S01' folder for project 'P_SWICMDV_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_SWICMDV_S01' folder for 'P_SWICMDV_S01' project
And waited while transcoding is finished in folder '/F_SWICMDV_S01' on project 'P_SWICMDV_S01' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_SWICMDV_S01' project 'P_SWICMDV_S01'
And click Edit link on file info page
Then I 'should' see following fields in the following order on opened Edit file popup:
| SectionName              | FieldName                   | FieldValue  |
| Product Info             | Advertiser                  |             |
| Product Info             | Brand                       |             |
| Product Info             | Sub Brand                   |             |
| Product Info             | Product                     |             |
| Product Info             | Campaign                    |             |
| Product Info             | Title                       | Fish Ad.mov |
| Admin Information        | Clock number                |             |
| Admin Information        | ID Film (ARPP Users only)   |             |
| Admin Information        | Additional Details          |             |
| Admin Information        | Duration                    | 6s 33ms     |
| Admin Information        | Air Date                    |             |
| Admin Information        | Country                     |             |
| Admin Information        | Market Sector               |             |
| Admin Information        | Agency Job reference        |             |
| Admin Information        | Approved For Broadcast      |             |
| Technical                | Media type                  | video       |
| Technical                | Media sub-type              |             |
| Technical                | Screen                      |             |
| Search Criteria          | Category                    |             |
| Search Criteria          | Sub Category                |             |
| Search Criteria          | Genre                       |             |
| Search Criteria          | Description                 |             |
| Search Criteria          | Brief                       |             |
| Agency Information       | Advertising agency          |             |
| Agency Information       | Account Director            |             |
| Agency Information       | Account Manager             |             |
| Agency Information       | Agency TV Producer          |             |
| Agency Information       | Art Director                |             |
| Agency Information       | Artbuyer                    |             |
| Agency Information       | Chief Creative Officer      |             |
| Agency Information       | Creative Director           |             |
| Agency Information       | Copywriter                  |             |
| Agency Information       | Executive Creative Director |             |
| Agency Information       | Executive Producer          |             |
| Agency Information       | Head of TV                  |             |
| Agency Information       | Media Planner               |             |
| Agency Information       | Planner                     |             |
| Agency Information       | Strategist                  |             |
| Production Information   | Production company          |             |
| Production Information   | Production Company Producer |             |
| Production Information   | Director                    |             |
| Production Information   | Director of Photography     |             |
| Production Information   | Executive Producer          |             |
| Production Information   | Production Designer         |             |
| Production Information   | Production Manager          |             |
| Production Information   | Production Assistant        |             |
| Production Information   | Costume Designer            |             |
| Production Information   | Make up Artist              |             |
| Production Information   | Film Processing Lab         |             |
| Production Information   | Studio/Location             |             |
| Production Information   | Shoot Dates                 |             |
| Post Production          | Post-production             |             |
| Post Production          | Assist                      |             |
| Post Production          | 2D Artists                  |             |
| Post Production          | 2D Lead Artists             |             |
| Post Production          | 2D Supervisor               |             |
| Post Production          | 3D Artists                  |             |
| Post Production          | 3D Lead Artists             |             |
| Post Production          | Colourist                   |             |
| Post Production          | Executive Producer          |             |
| Post Production          | Shoot Supervisor            |             |
| Post Production          | Studio                      |             |
| Post Production          | VFX Producer                |             |
| Post Production          | Matte Painting              |             |
| Post Production          | Motion Graphics             |             |
| Editorial                | Edit company                |             |
| Editorial                | Editor                      |             |
| Editorial                | Edit Assistant              |             |
| Music                    | Music Company               |             |
| Music                    | Music Performer             |             |
| Music                    | Music recorded at           |             |
| Music                    | Producer                    |             |
| Music                    | Sound Design                |             |
| Music                    | Audio Post                  |             |
| Music                    | Music Arranger              |             |
| Music                    | Lyrical Artist              |             |
| Music                    | Lyricist                    |             |
| Music                    | Composer                    |             |
| Music                    | Voice Over Artist           |             |
| Music                    | Recording Engineer          |             |
| Animation                | Animation company           |             |
| Animation                | Animator                    |             |
| Media Agency Information | Media Agency                |             |
| Media Agency Information | Media Agency Planner        |             |
Then I 'should not' see following fields in the following order on opened Edit file popup:
| SectionName              | FieldName                   | FieldValue   |
| Production Information   | Size Description            |              |
| Production Information   | Ad Height                   |              |
| Production Information   | Ad Width                    |              |
| Ad Description           | AD ID                       |              |
| Ad Description           | AD Material ID              |              |
| Ad Description           | Booking Number              |              |
| Ad Destination           | Publication Date            |              |
| Ad Destination           | Publication                 |              |
| Ad Destination           | Section                     |              |
| Ad Destination           | Publisher Name              |              |
| Production Agency        | Production Contact          |              |
| Production Agency        | Production Email            |              |
| Production Agency        | Production Company          |              |


Scenario: Check that all specified fields is shown on Edit form of asset
Meta:@library
     @gdam
Given I created the agency 'A_SWICMDV_S02' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_SWICMDV_S02 | agency.admin | A_SWICMDV_S02 |streamlined_library|
And logged in with details of 'U_SWICMDV_S02'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName              | FieldName                   | FieldValue  |
| Product Info             | Advertiser                  |             |
| Product Info             | Brand                       |             |
| Product Info             | Sub Brand                   |             |
| Product Info             | Product                     |             |
| Product Info             | Campaign                    |             |
| Product Info             | Title                       | Fish Ad.mov |
| Admin Information        | Clock number                |             |
| Admin Information        | ID Film (ARPP Users only)   |             |
| Admin Information        | Additional Details          |             |
| Admin Information        | Duration                    | 6s 33ms     |
| Admin Information        | Air Date                    |             |
| Admin Information        | Country                     |             |
| Admin Information        | Market Sector               |             |
| Admin Information        | Agency Job reference        |             |
| Admin Information        | Approved For Broadcast      |             |
| Technical                | Media type                  | video       |
| Technical                | Media sub-type              |             |
| Technical                | Screen                      |             |
| Search Criteria          | Category                    |             |
| Search Criteria          | Sub Category                |             |
| Search Criteria          | Genre                       |             |
| Search Criteria          | Description                 |             |
| Search Criteria          | Brief                       |             |
| Agency Information       | Advertising agency          |             |
| Agency Information       | Account Director            |             |
| Agency Information       | Account Manager             |             |
| Agency Information       | Agency TV Producer          |             |
| Agency Information       | Art Director                |             |
| Agency Information       | Artbuyer                    |             |
| Agency Information       | Chief Creative Officer      |             |
| Agency Information       | Creative Director           |             |
| Agency Information       | Copywriter                  |             |
| Agency Information       | Executive Creative Director |             |
| Agency Information       | Executive Producer          |             |
| Agency Information       | Head of TV                  |             |
| Agency Information       | Media Planner               |             |
| Agency Information       | Planner                     |             |
| Agency Information       | Strategist                  |             |
| Production Information   | Production company          |             |
| Production Information   | Production Company Producer |             |
| Production Information   | Director                    |             |
| Production Information   | Director of Photography     |             |
| Production Information   | Executive Producer          |             |
| Production Information   | Production Designer         |             |
| Production Information   | Production Manager          |             |
| Production Information   | Production Assistant        |             |
| Production Information   | Costume Designer            |             |
| Production Information   | Make up Artist              |             |
| Production Information   | Film Processing Lab         |             |
| Production Information   | Studio/Location             |             |
| Production Information   | Shoot Dates                 |             |
| Post Production          | Post-production             |             |
| Post Production          | Assist                      |             |
| Post Production          | 2D Artists                  |             |
| Post Production          | 2D Lead Artists             |             |
| Post Production          | 2D Supervisor               |             |
| Post Production          | 3D Artists                  |             |
| Post Production          | 3D Lead Artists             |             |
| Post Production          | Colourist                   |             |
| Post Production          | Executive Producer          |             |
| Post Production          | Shoot Supervisor            |             |
| Post Production          | Studio                      |             |
| Post Production          | Matte Painting              |             |
| Post Production          | Motion Graphics             |             |
| Editorial                | Edit company                |             |
| Editorial                | Editor                      |             |
| Editorial                | Edit Assistant              |             |
| Music                    | Music Company               |             |
| Music                    | Music Performer             |             |
| Music                    | Music recorded at           |             |
| Music                    | Producer                    |             |
| Music                    | Sound Design                |             |
| Music                    | Audio Post                  |             |
| Music                    | Music Arranger              |             |
| Music                    | Lyrical Artist              |             |
| Music                    | Lyricist                    |             |
| Music                    | Composer                    |             |
| Music                    | Voice Over Artist           |             |
| Music                    | Recording Engineer          |             |
| Animation                | Animation company           |             |
| Animation                | Animator                    |             |
| Media Agency Information | Media Agency                |             |
| Media Agency Information | Media Agency Planner        |             |

Scenario: Check that specified data is displayed on view form of file
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMDV_S03' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMDV_S03':
| Advertiser      | Brand          | Sub Brand       | Product        |
| ADV_SWICMDV_S03 | BR_SWICMDV_S03 | SBR_SWICMDV_S03 | PR_SWICMDV_S03 |
And created users with following fields:
| Email         | Role         | AgencyUnique  |
| U_SWICMDV_S03 | agency.admin | A_SWICMDV_S03 |
And logged in with details of 'U_SWICMDV_S03'
And created 'P_SWICMDV_S03' project
And created '/F_SWICMDV_S03' folder for project 'P_SWICMDV_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_SWICMDV_S03' folder for 'P_SWICMDV_S03' project
And waited while transcoding is finished in folder '/F_SWICMDV_S03' on project 'P_SWICMDV_S03' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_SWICMDV_S03' project 'P_SWICMDV_S03'
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S03                  |
| Product Info             | Brand                       | BR_SWICMDV_S03                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S03                  |
| Product Info             | Product                     | PR_SWICMDV_S03                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Media sub-type              |                                  |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Test Post-production             |
| Post Production          | Assist                      | Test Assist                      |
| Post Production          | 2D Artists                  | Test 2D Artists                  |
| Post Production          | 2D Lead Artists             | Test 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Test 2D Supervisor               |
| Post Production          | 3D Artists                  | Test 3D Artists                  |
| Post Production          | 3D Lead Artists             | Test 3D Lead Artists             |
| Post Production          | Colourist                   | Test Colourist                   |
| Post Production          | Executive Producer          | Test Executive Producer          |
| Post Production          | Shoot Supervisor            | Test Shoot Supervisor            |
| Post Production          | Studio                      | Test Studio                      |
| Post Production          | VFX Producer                | Test VFX Producer                |
| Post Production          | Matte Painting              | Test Matte Painting              |
| Post Production          | Motion Graphics             | Test Motion Graphics             |
| Editorial                | Edit company                | Test Edit company                |
| Editorial                | Editor                      | Test Editor                      |
| Editorial                | Edit Assistant              | Test Edit Assistant              |
| Music                    | Music Company               | Test Music Company               |
| Music                    | Music Performer             | Test Music Performer             |
| Music                    | Music recorded at           | Test Music recorded at           |
| Music                    | Producer                    | Test Producer                    |
| Music                    | Sound Design                | Test Sound Design                |
| Music                    | Audio Post                  | Test Audio Post                  |
| Music                    | Music Arranger              | Test Music Arranger              |
| Music                    | Lyrical Artist              | Test Lyrical Artist              |
| Music                    | Lyricist                    | Test Lyricist                    |
| Music                    | Composer                    | Test Composer                    |
| Music                    | Voice Over Artist           | Test Voice Over Artist           |
| Music                    | Recording Engineer          | Test Recording Engineer          |
| Animation                | Animation company           | Test Animation company           |
| Animation                | Animator                    | Test Animator                    |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
Then I 'should' see following 'custom metadata' fields in the following order on opened file info page:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S03                  |
| Product Info             | Brand                       | BR_SWICMDV_S03                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S03                  |
| Product Info             | Product                     | PR_SWICMDV_S03                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Test Post-production             |
| Post Production          | Assist                      | Test Assist                      |
| Post Production          | 2D Artists                  | Test 2D Artists                  |
| Post Production          | 2D Lead Artists             | Test 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Test 2D Supervisor               |
| Post Production          | 3D Artists                  | Test 3D Artists                  |
| Post Production          | 3D Lead Artists             | Test 3D Lead Artists             |
| Post Production          | Colourist                   | Test Colourist                   |
| Post Production          | Executive Producer          | Test Executive Producer          |
| Post Production          | Shoot Supervisor            | Test Shoot Supervisor            |
| Post Production          | Studio                      | Test Studio                      |
| Post Production          | VFX Producer                | Test VFX Producer                |
| Post Production          | Matte Painting              | Test Matte Painting              |
| Post Production          | Motion Graphics             | Test Motion Graphics             |
| Editorial                | Edit company                | Test Edit company                |
| Editorial                | Editor                      | Test Editor                      |
| Editorial                | Edit Assistant              | Test Edit Assistant              |
| Music                    | Music Company               | Test Music Company               |
| Music                    | Music Performer             | Test Music Performer             |
| Music                    | Music recorded at           | Test Music recorded at           |
| Music                    | Producer                    | Test Producer                    |
| Music                    | Sound Design                | Test Sound Design                |
| Music                    | Audio Post                  | Test Audio Post                  |
| Music                    | Music Arranger              | Test Music Arranger              |
| Music                    | Lyrical Artist              | Test Lyrical Artist              |
| Music                    | Lyricist                    | Test Lyricist                    |
| Music                    | Composer                    | Test Composer                    |
| Music                    | Voice Over Artist           | Test Voice Over Artist           |
| Music                    | Recording Engineer          | Test Recording Engineer          |
| Animation                | Animation company           | Test Animation company           |
| Animation                | Animator                    | Test Animator                    |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |

Scenario: Check that specified data is displayed on edit form of file
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMDV_S05' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMDV_S05':
| Advertiser      | Brand          | Sub Brand       | Product        |
| ADV_SWICMDV_S05 | BR_SWICMDV_S05 | SBR_SWICMDV_S05 | PR_SWICMDV_S05 |
And created users with following fields:
| Email         | Role         | AgencyUnique  |
| U_SWICMDV_S05 | agency.admin | A_SWICMDV_S05 |
And logged in with details of 'U_SWICMDV_S05'
And created 'P_SWICMDV_S05' project
And created '/F_SWICMDV_S05' folder for project 'P_SWICMDV_S05'
And uploaded '/files/Fish Ad.mov' file into '/F_SWICMDV_S05' folder for 'P_SWICMDV_S05' project
And waited while transcoding is finished in folder '/F_SWICMDV_S05' on project 'P_SWICMDV_S05' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_SWICMDV_S05' project 'P_SWICMDV_S05'
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S05                  |
| Product Info             | Brand                       | BR_SWICMDV_S05                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S05                  |
| Product Info             | Product                     | PR_SWICMDV_S05                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Media sub-type              |                                  |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Test Post-production             |
| Post Production          | Assist                      | Test Assist                      |
| Post Production          | 2D Artists                  | Test 2D Artists                  |
| Post Production          | 2D Lead Artists             | Test 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Test 2D Supervisor               |
| Post Production          | 3D Artists                  | Test 3D Artists                  |
| Post Production          | 3D Lead Artists             | Test 3D Lead Artists             |
| Post Production          | Colourist                   | Test Colourist                   |
| Post Production          | Executive Producer          | Test Executive Producer          |
| Post Production          | Shoot Supervisor            | Test Shoot Supervisor            |
| Post Production          | Studio                      | Test Studio                      |
| Post Production          | VFX Producer                | Test VFX Producer                |
| Post Production          | Matte Painting              | Test Matte Painting              |
| Post Production          | Motion Graphics             | Test Motion Graphics             |
| Editorial                | Edit company                | Test Edit company                |
| Editorial                | Editor                      | Test Editor                      |
| Editorial                | Edit Assistant              | Test Edit Assistant              |
| Music                    | Music Company               | Test Music Company               |
| Music                    | Music Performer             | Test Music Performer             |
| Music                    | Music recorded at           | Test Music recorded at           |
| Music                    | Producer                    | Test Producer                    |
| Music                    | Sound Design                | Test Sound Design                |
| Music                    | Audio Post                  | Test Audio Post                  |
| Music                    | Music Arranger              | Test Music Arranger              |
| Music                    | Lyrical Artist              | Test Lyrical Artist              |
| Music                    | Lyricist                    | Test Lyricist                    |
| Music                    | Composer                    | Test Composer                    |
| Music                    | Voice Over Artist           | Test Voice Over Artist           |
| Music                    | Recording Engineer          | Test Recording Engineer          |
| Animation                | Animation company           | Test Animation company           |
| Animation                | Animator                    | Test Animator                    |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
And click Edit link on file info page
Then I 'should' see following fields in the following order on opened Edit file popup:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S05                  |
| Product Info             | Brand                       | BR_SWICMDV_S05                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S05                  |
| Product Info             | Product                     | PR_SWICMDV_S05                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Media sub-type              |                                  |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Test Post-production             |
| Post Production          | Assist                      | Test Assist                      |
| Post Production          | 2D Artists                  | Test 2D Artists                  |
| Post Production          | 2D Lead Artists             | Test 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Test 2D Supervisor               |
| Post Production          | 3D Artists                  | Test 3D Artists                  |
| Post Production          | 3D Lead Artists             | Test 3D Lead Artists             |
| Post Production          | Colourist                   | Test Colourist                   |
| Post Production          | Executive Producer          | Test Executive Producer          |
| Post Production          | Shoot Supervisor            | Test Shoot Supervisor            |
| Post Production          | Studio                      | Test Studio                      |
| Post Production          | VFX Producer                | Test VFX Producer                |
| Post Production          | Matte Painting              | Test Matte Painting              |
| Post Production          | Motion Graphics             | Test Motion Graphics             |
| Editorial                | Edit company                | Test Edit company                |
| Editorial                | Editor                      | Test Editor                      |
| Editorial                | Edit Assistant              | Test Edit Assistant              |
| Music                    | Music Company               | Test Music Company               |
| Music                    | Music Performer             | Test Music Performer             |
| Music                    | Music recorded at           | Test Music recorded at           |
| Music                    | Producer                    | Test Producer                    |
| Music                    | Sound Design                | Test Sound Design                |
| Music                    | Audio Post                  | Test Audio Post                  |
| Music                    | Music Arranger              | Test Music Arranger              |
| Music                    | Lyrical Artist              | Test Lyrical Artist              |
| Music                    | Lyricist                    | Test Lyricist                    |
| Music                    | Composer                    | Test Composer                    |
| Music                    | Voice Over Artist           | Test Voice Over Artist           |
| Music                    | Recording Engineer          | Test Recording Engineer          |
| Animation                | Animation company           | Test Animation company           |
| Animation                | Animator                    | Test Animator                    |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |


Scenario: Check that specified data is displayed on edit form of asset
Meta:@library
     @gdam
!--This scenario might fail randomly due to long expansion of section on asset edit form on FF we are using..need to upadte FF
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_SWICMDV_S06' with default attributes
When I open role 'agency.admin' page with parent 'A_SWICMDV_S06'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMDV_S06_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMDV_S06_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_SWICMDV_S06'
And create following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMDV_S06':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMD_S06 | BR_SWICMD_S06 | SBR_SWICMD_S06 | PR_SWICMD_S06 |
And create users with following fields:
| Email        | Role         | AgencyUnique |Access|
| ADV_SWICMDV_S06 | A_SWICMDV_S06_R1 | A_SWICMDV_S06 |streamlined_library|
And login with details of 'ADV_SWICMDV_S06'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | ADV_SWICMDV_S06                  |
| Brand                       | BR_SWICMDV_S06                   |
| Sub Brand                   | SBR_SWICMDV_S06                  |
| Product                     | PR_SWICMDV_S06                   |
| Campaign                    | Test Campaign                    |
| Title                       | Fish Ad.mov                      |
| Clock number                | testcn                           |
| ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Additional Details          | Test Additional Details          |
| Duration                    | 6s 33ms                          |
| Air Date                    | 12/12/15                       |
| Country                     | Austria                          |
| Market Sector               | Test Market Sector               |
| Approved For Broadcast      | Yes                              |
| Media sub-type              |  Elements                        |
| Screen                      | Spot                             |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Description                 | Test Description                 |
| Brief                       | Test Brief                       |
| Advertising agency          | Test Advertising agency          |
| Account Director            | Test Account Director            |
| Account Manager             | Test Account Manager             |
| Agency TV Producer          | Test Agency TV Producer          |
| Executive Creative Director | Test Executive Creative Director |
| Head of TV                  | Test Head of TV                  |
| Media Planner               | Test Media Planner               |
| Planner                     | Test Planner                     |
| Strategist                  | Test Strategist                  |
| Production company          | Test Production company          |
| Costume Designer            | Test Costume Designer            |
| Make up Artist              | Test Make up Artist              |
| Film Processing Lab         | Test Film Processing Lab         |
| Studio/Location             | Test Studio/Location             |
| Matte Painting              | Test Matte Painting              |
And I refresh the page
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S06                  |
| Product Info             | Brand                       | BR_SWICMDV_S06                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S06                  |
| Product Info             | Product                     | PR_SWICMDV_S06                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/15                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Media sub-type              |  Elements                                |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |


Scenario: Check that file's data entered before can be updated on view form
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMDV_S07' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMDV_S07':
| Advertiser      | Brand          | Sub Brand       | Product        |
| ADV_SWICMDV_S07 | BR_SWICMDV_S07 | SBR_SWICMDV_S07 | PR_SWICMDV_S07 |
And created users with following fields:
| Email         | Role         | AgencyUnique  |
| U_SWICMDV_S07 | agency.admin | A_SWICMDV_S07 |
And logged in with details of 'U_SWICMDV_S07'
And created 'P_SWICMDV_S07' project
And created '/F_SWICMDV_S07' folder for project 'P_SWICMDV_S07'
And uploaded '/files/Fish Ad.mov' file into '/F_SWICMDV_S07' folder for 'P_SWICMDV_S07' project
And waited while transcoding is finished in folder '/F_SWICMDV_S07' on project 'P_SWICMDV_S07' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_SWICMDV_S07' project 'P_SWICMDV_S07'
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S07                  |
| Product Info             | Brand                       | BR_SWICMDV_S07                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S07                  |
| Product Info             | Product                     | PR_SWICMDV_S07                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Media sub-type              |                                  |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Tttt Post-production             |
| Post Production          | Assist                      | Tttt Assist                      |
| Post Production          | 2D Artists                  | Tttt 2D Artists                  |
| Post Production          | 2D Lead Artists             | Tttt 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Tttt 2D Supervisor               |
| Post Production          | 3D Artists                  | Tttt 3D Artists                  |
| Post Production          | 3D Lead Artists             | Tttt 3D Lead Artists             |
| Post Production          | Colourist                   | Tttt Colourist                   |
| Post Production          | Executive Producer          | Tttt Executive Producer          |
| Post Production          | Shoot Supervisor            | Tttt Shoot Supervisor            |
| Post Production          | Studio                      | Tttt Studio                      |
| Post Production          | VFX Producer                | Tttt VFX Producer                |
| Post Production          | Matte Painting              | Tttt Matte Painting              |
| Post Production          | Motion Graphics             | Tttt Motion Graphics             |
| Editorial                | Edit company                | Tttt Edit company                |
| Editorial                | Editor                      | Tttt Editor                      |
| Editorial                | Edit Assistant              | Tttt Edit Assistant              |
| Music                    | Music Company               | Tttt Music Company               |
| Music                    | Music Performer             | Tttt Music Performer             |
| Music                    | Music recorded at           | Tttt Music recorded at           |
| Music                    | Producer                    | Tttt Producer                    |
| Music                    | Sound Design                | Tttt Sound Design                |
| Music                    | Audio Post                  | Tttt Audio Post                  |
| Music                    | Music Arranger              | Tttt Music Arranger              |
| Music                    | Lyrical Artist              | Tttt Lyrical Artist              |
| Music                    | Lyricist                    | Tttt Lyricist                    |
| Music                    | Composer                    | Tttt Composer                    |
| Music                    | Voice Over Artist           | Tttt Voice Over Artist           |
| Music                    | Recording Engineer          | Tttt Recording Engineer          |
| Animation                | Animation company           | Tttt Animation company           |
| Animation                | Animator                    | Tttt Animator                    |
| Media Agency Information | Media Agency                | Tttt Media Agency                |
| Media Agency Information | Media Agency Planner        | Tttt Media Agency Planner        |
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S07                  |
| Product Info             | Brand                       | BR_SWICMDV_S07                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S07                  |
| Product Info             | Product                     | PR_SWICMDV_S07                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Media sub-type              |                                  |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Test Post-production             |
| Post Production          | Assist                      | Test Assist                      |
| Post Production          | 2D Artists                  | Test 2D Artists                  |
| Post Production          | 2D Lead Artists             | Test 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Test 2D Supervisor               |
| Post Production          | 3D Artists                  | Test 3D Artists                  |
| Post Production          | 3D Lead Artists             | Test 3D Lead Artists             |
| Post Production          | Colourist                   | Test Colourist                   |
| Post Production          | Executive Producer          | Test Executive Producer          |
| Post Production          | Shoot Supervisor            | Test Shoot Supervisor            |
| Post Production          | Studio                      | Test Studio                      |
| Post Production          | VFX Producer                | Test VFX Producer                |
| Post Production          | Matte Painting              | Test Matte Painting              |
| Post Production          | Motion Graphics             | Test Motion Graphics             |
| Editorial                | Edit company                | Test Edit company                |
| Editorial                | Editor                      | Test Editor                      |
| Editorial                | Edit Assistant              | Test Edit Assistant              |
| Music                    | Music Company               | Test Music Company               |
| Music                    | Music Performer             | Test Music Performer             |
| Music                    | Music recorded at           | Test Music recorded at           |
| Music                    | Producer                    | Test Producer                    |
| Music                    | Sound Design                | Test Sound Design                |
| Music                    | Audio Post                  | Test Audio Post                  |
| Music                    | Music Arranger              | Test Music Arranger              |
| Music                    | Lyrical Artist              | Test Lyrical Artist              |
| Music                    | Lyricist                    | Test Lyricist                    |
| Music                    | Composer                    | Test Composer                    |
| Music                    | Voice Over Artist           | Test Voice Over Artist           |
| Music                    | Recording Engineer          | Test Recording Engineer          |
| Animation                | Animation company           | Test Animation company           |
| Animation                | Animator                    | Test Animator                    |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
Then I 'should' see following 'custom metadata' fields in the following order on opened file info page:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S07                  |
| Product Info             | Brand                       | BR_SWICMDV_S07                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S07                  |
| Product Info             | Product                     | PR_SWICMDV_S07                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Test Post-production             |
| Post Production          | Assist                      | Test Assist                      |
| Post Production          | 2D Artists                  | Test 2D Artists                  |
| Post Production          | 2D Lead Artists             | Test 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Test 2D Supervisor               |
| Post Production          | 3D Artists                  | Test 3D Artists                  |
| Post Production          | 3D Lead Artists             | Test 3D Lead Artists             |
| Post Production          | Colourist                   | Test Colourist                   |
| Post Production          | Executive Producer          | Test Executive Producer          |
| Post Production          | Shoot Supervisor            | Test Shoot Supervisor            |
| Post Production          | Studio                      | Test Studio                      |
| Post Production          | VFX Producer                | Test VFX Producer                |
| Post Production          | Matte Painting              | Test Matte Painting              |
| Post Production          | Motion Graphics             | Test Motion Graphics             |
| Editorial                | Edit company                | Test Edit company                |
| Editorial                | Editor                      | Test Editor                      |
| Editorial                | Edit Assistant              | Test Edit Assistant              |
| Music                    | Music Company               | Test Music Company               |
| Music                    | Music Performer             | Test Music Performer             |
| Music                    | Music recorded at           | Test Music recorded at           |
| Music                    | Producer                    | Test Producer                    |
| Music                    | Sound Design                | Test Sound Design                |
| Music                    | Audio Post                  | Test Audio Post                  |
| Music                    | Music Arranger              | Test Music Arranger              |
| Music                    | Lyrical Artist              | Test Lyrical Artist              |
| Music                    | Lyricist                    | Test Lyricist                    |
| Music                    | Composer                    | Test Composer                    |
| Music                    | Voice Over Artist           | Test Voice Over Artist           |
| Music                    | Recording Engineer          | Test Recording Engineer          |
| Animation                | Animation company           | Test Animation company           |
| Animation                | Animator                    | Test Animator                    |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |


Scenario: Check that file's data entered before can be updated on edit form
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMDV_S08' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMDV_S08':
| Advertiser      | Brand          | Sub Brand       | Product        |
| ADV_SWICMDV_S08 | BR_SWICMDV_S08 | SBR_SWICMDV_S08 | PR_SWICMDV_S08 |
And created users with following fields:
| Email         | Role         | AgencyUnique  |
| U_SWICMDV_S08 | agency.admin | A_SWICMDV_S08 |
And logged in with details of 'U_SWICMDV_S08'
And created 'P_SWICMDV_S08' project
And created '/F_SWICMDV_S08' folder for project 'P_SWICMDV_S08'
And uploaded '/files/Fish Ad.mov' file into '/F_SWICMDV_S08' folder for 'P_SWICMDV_S08' project
And waited while transcoding is finished in folder '/F_SWICMDV_S08' on project 'P_SWICMDV_S08' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_SWICMDV_S08' project 'P_SWICMDV_S08'
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S08                  |
| Product Info             | Brand                       | BR_SWICMDV_S08                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S08                  |
| Product Info             | Product                     | PR_SWICMDV_S08                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Tttt Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Media sub-type              |                                  |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Tttt Post-production             |
| Post Production          | Assist                      | Tttt Assist                      |
| Post Production          | 2D Artists                  | Tttt 2D Artists                  |
| Post Production          | 2D Lead Artists             | Tttt 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Tttt 2D Supervisor               |
| Post Production          | 3D Artists                  | Tttt 3D Artists                  |
| Post Production          | 3D Lead Artists             | Tttt 3D Lead Artists             |
| Post Production          | Colourist                   | Tttt Colourist                   |
| Post Production          | Executive Producer          | Tttt Executive Producer          |
| Post Production          | Shoot Supervisor            | Tttt Shoot Supervisor            |
| Post Production          | Studio                      | Tttt Studio                      |
| Post Production          | VFX Producer                | Tttt VFX Producer                |
| Post Production          | Matte Painting              | Tttt Matte Painting              |
| Post Production          | Motion Graphics             | Tttt Motion Graphics             |
| Editorial                | Edit company                | Tttt Edit company                |
| Editorial                | Editor                      | Tttt Editor                      |
| Editorial                | Edit Assistant              | Tttt Edit Assistant              |
| Music                    | Music Company               | Tttt Music Company               |
| Music                    | Music Performer             | Tttt Music Performer             |
| Music                    | Music recorded at           | Tttt Music recorded at           |
| Music                    | Producer                    | Tttt Producer                    |
| Music                    | Sound Design                | Tttt Sound Design                |
| Music                    | Audio Post                  | Tttt Audio Post                  |
| Music                    | Music Arranger              | Tttt Music Arranger              |
| Music                    | Lyrical Artist              | Tttt Lyrical Artist              |
| Music                    | Lyricist                    | Tttt Lyricist                    |
| Music                    | Composer                    | Tttt Composer                    |
| Music                    | Voice Over Artist           | Tttt Voice Over Artist           |
| Music                    | Recording Engineer          | Tttt Recording Engineer          |
| Animation                | Animation company           | Tttt Animation company           |
| Animation                | Animator                    | Tttt Animator                    |
| Media Agency Information | Media Agency                | Tttt Media Agency                |
| Media Agency Information | Media Agency Planner        | Tttt Media Agency Planner        |
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S08                  |
| Product Info             | Brand                       | BR_SWICMDV_S08                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S08                  |
| Product Info             | Product                     | PR_SWICMDV_S08                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Media sub-type              |                                  |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Test Post-production             |
| Post Production          | Assist                      | Test Assist                      |
| Post Production          | 2D Artists                  | Test 2D Artists                  |
| Post Production          | 2D Lead Artists             | Test 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Test 2D Supervisor               |
| Post Production          | 3D Artists                  | Test 3D Artists                  |
| Post Production          | 3D Lead Artists             | Test 3D Lead Artists             |
| Post Production          | Colourist                   | Test Colourist                   |
| Post Production          | Executive Producer          | Test Executive Producer          |
| Post Production          | Shoot Supervisor            | Test Shoot Supervisor            |
| Post Production          | Studio                      | Test Studio                      |
| Post Production          | VFX Producer                | Test VFX Producer                |
| Post Production          | Matte Painting              | Test Matte Painting              |
| Post Production          | Motion Graphics             | Test Motion Graphics             |
| Editorial                | Edit company                | Test Edit company                |
| Editorial                | Editor                      | Test Editor                      |
| Editorial                | Edit Assistant              | Test Edit Assistant              |
| Music                    | Music Company               | Test Music Company               |
| Music                    | Music Performer             | Test Music Performer             |
| Music                    | Music recorded at           | Test Music recorded at           |
| Music                    | Producer                    | Test Producer                    |
| Music                    | Sound Design                | Test Sound Design                |
| Music                    | Audio Post                  | Test Audio Post                  |
| Music                    | Music Arranger              | Test Music Arranger              |
| Music                    | Lyrical Artist              | Test Lyrical Artist              |
| Music                    | Lyricist                    | Test Lyricist                    |
| Music                    | Composer                    | Test Composer                    |
| Music                    | Voice Over Artist           | Test Voice Over Artist           |
| Music                    | Recording Engineer          | Test Recording Engineer          |
| Animation                | Animation company           | Test Animation company           |
| Animation                | Animator                    | Test Animator                    |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
And click Edit link on file info page
Then I 'should' see following fields in the following order on opened Edit file popup:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S08                  |
| Product Info             | Brand                       | BR_SWICMDV_S08                   |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S08                  |
| Product Info             | Product                     | PR_SWICMDV_S08                   |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                      |
| Admin Information        | Clock number                | testcn                           |
| Admin Information        | ID Film (ARPP Users only)   | Tets ID Film ARPP Users only     |
| Admin Information        | Additional Details          | Test Additional Details          |
| Admin Information        | Duration                    | 6s 33ms                          |
| Admin Information        | Air Date                    | 12/12/2015                       |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Agency Job reference        | Test Agency Job reference        |
| Admin Information        | Approved For Broadcast      | Yes                              |
| Technical                | Media type                  | video                            |
| Technical                | Media sub-type              |                                  |
| Technical                | Screen                      | Spot                             |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency TV Producer          | Test Agency TV Producer          |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Executive Producer          | Test Executive Producer          |
| Agency Information       | Head of TV                  | Test Head of TV                  |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Production company          | Test Production company          |
| Production Information   | Production Company Producer | Test Production Company Producer |
| Production Information   | Director                    | Test Director                    |
| Production Information   | Director of Photography     | Test Director of Photography     |
| Production Information   | Executive Producer          | Test Executive Producer          |
| Production Information   | Production Designer         | Test Production Designer         |
| Production Information   | Production Manager          | Test Production Manager          |
| Production Information   | Production Assistant        | Test Production Assistant        |
| Production Information   | Costume Designer            | Test Costume Designer            |
| Production Information   | Make up Artist              | Test Make up Artist              |
| Production Information   | Film Processing Lab         | Test Film Processing Lab         |
| Production Information   | Studio/Location             | Test Studio/Location             |
| Production Information   | Shoot Dates                 | 12/12/2015                       |
| Post Production          | Post-production             | Test Post-production             |
| Post Production          | Assist                      | Test Assist                      |
| Post Production          | 2D Artists                  | Test 2D Artists                  |
| Post Production          | 2D Lead Artists             | Test 2D Lead Artists             |
| Post Production          | 2D Supervisor               | Test 2D Supervisor               |
| Post Production          | 3D Artists                  | Test 3D Artists                  |
| Post Production          | 3D Lead Artists             | Test 3D Lead Artists             |
| Post Production          | Colourist                   | Test Colourist                   |
| Post Production          | Executive Producer          | Test Executive Producer          |
| Post Production          | Shoot Supervisor            | Test Shoot Supervisor            |
| Post Production          | Studio                      | Test Studio                      |
| Post Production          | VFX Producer                | Test VFX Producer                |
| Post Production          | Matte Painting              | Test Matte Painting              |
| Post Production          | Motion Graphics             | Test Motion Graphics             |
| Editorial                | Edit company                | Test Edit company                |
| Editorial                | Editor                      | Test Editor                      |
| Editorial                | Edit Assistant              | Test Edit Assistant              |
| Music                    | Music Company               | Test Music Company               |
| Music                    | Music Performer             | Test Music Performer             |
| Music                    | Music recorded at           | Test Music recorded at           |
| Music                    | Producer                    | Test Producer                    |
| Music                    | Sound Design                | Test Sound Design                |
| Music                    | Audio Post                  | Test Audio Post                  |
| Music                    | Music Arranger              | Test Music Arranger              |
| Music                    | Lyrical Artist              | Test Lyrical Artist              |
| Music                    | Lyricist                    | Test Lyricist                    |
| Music                    | Composer                    | Test Composer                    |
| Music                    | Voice Over Artist           | Test Voice Over Artist           |
| Music                    | Recording Engineer          | Test Recording Engineer          |
| Animation                | Animation company           | Test Animation company           |
| Animation                | Animator                    | Test Animator                    |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |


Scenario: Check that asset's data entered before can be updated on view form
Meta:@library
     @gdam
     @bug
!--UIR-1069
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_SWICMDV_S09' with default attributes
When I open role 'agency.admin' page with parent 'A_SWICMDV_S09'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMDV_S09_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMDV_S09_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_SWICMDV_S09'
And create following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMDV_S09':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMDV_S09 | BR_SWICMDV_S09 | SBR_SWICMDV_S09 | PR_SWICMDV_S09 |
And create users with following fields:
| Email        | Role            | AgencyUnique |Access|
| U_SWICMDV_S09 | A_SWICMDV_S09_R1 | A_SWICMDV_S09 |streamlined_library|
And login with details of 'U_SWICMDV_S09'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | ADV_SWICMDV_S09                   |
| Brand                       | BR_SWICMDV_S09                    |
| Sub Brand                   | SBR_SWICMDV_S09                   |
| Product                     | PR_SWICMDV_S09                    |
| Campaign                    | Tttt Campaign                    |
| Title                       | Fish Ad.mov                     |
| Country                     | Austria                          |
| Clock number                     | testcn                          |
| Market Sector               | Tttt Market Sector               |
| Media sub-type              | Elements                            |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Description                 | Tttt Description                 |
| Brief                       | Tttt Brief                       |
| Advertising agency          | Tttt Advertising agency          |
| Account Director            | Tttt Account Director            |
| Account Manager             | Tttt Account Manager             |
| Art Director                | Tttt Art Director                |
| Artbuyer                    | Tttt Artbuyer                    |
| Chief Creative Officer      | Tttt Chief Creative Officer      |
| Creative Director           | Tttt Creative Director           |
| Copywriter                  | Tttt Copywriter                  |
| Executive Creative Director | Tttt Executive Creative Director |
| Executive Producer          | Tttt Executive Producer  |
| Studio                      | Tttt Studio |
| Editor                      | Tttt Editor |
| Music Performer             | Tttt Music Performer |
| Media Planner               | Tttt Media Planner               |
| Planner                     | Tttt Planner                     |
| Strategist                  | Tttt Strategist                  |
| Shoot Dates                  | 12/12/21                         |
| Media Agency                | Tttt Media Agency                |
| Media Agency Planner        | Tttt Media Agency Planner        |
And I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
|FieldName                   | FieldValue                       |
| Advertiser                  | ADV_SWICMDV_S09                   |
| Brand                       | BR_SWICMDV_S09                    |
| Sub Brand                   | SBR_SWICMDV_S09                   |
| Product                     | PR_SWICMDV_S09                    |
|Campaign                    | Test Campaign                    |
|Title                       | Fish Ad.mov                     |
| Clock number                     | testcn                          |
|Country                     | Austria                          |
|Market Sector               | Test Market Sector               |
|Media sub-type              | Elements                        |
|Category                    | Food                             |
|Sub Category                | Meat and Fish                    |
|Description                 | Test Description                 |
|Brief                       | Test Brief                       |
|Advertising agency          | Test Advertising agency          |
|Account Director            | Test Account Director            |
|Account Manager             | Test Account Manager             |
|Art Director                | Test Art Director                |
|Artbuyer                    | Test Artbuyer                    |
|Chief Creative Officer      | Test Chief Creative Officer      |
|Creative Director           | Test Creative Director           |
|Copywriter                  | Test Copywriter                  |
|Executive Creative Director | Test Executive Creative Director |
| Executive Producer          | Test Executive Producer  |
| Studio                      | Test Studio |
| Editor                      | Test Editor |
| Music Performer             | Test Music Performer |
|Media Planner               | Test Media Planner               |
|Planner                     | Test Planner                     |
|Strategist                  | Test Strategist                  |
|Shoot Dates                  | 12/12/15                         |
|Media Agency                | Test Media Agency                |
|Media Agency Planner        | Test Media Agency Planner        |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
|FieldName                   | FieldValue                       |
| Advertiser                  | ADV_SWICMDV_S09                   |
| Brand                       | BR_SWICMDV_S09                    |
| Sub Brand                   | SBR_SWICMDV_S09                   |
| Product                     | PR_SWICMDV_S09                    |
|Campaign                    | Test Campaign                    |
|Title                       | Fish Ad.mov                     |
|Country                     | Austria                          |
|Market Sector               | Test Market Sector               |
|Media type                  | video                            |
|Media sub-type              | Elements                        |
|Category                    | Food                             |
|Sub Category                | Meat and Fish                    |
|Description                 | Test Description                 |
|Brief                       | Test Brief                       |
|Advertising agency          | Test Advertising agency          |
|Account Director            | Tttt Account Director,Test Account Director            |
|Account Manager             | Tttt Account Manager,Test Account Manager             |
|Art Director                | Tttt Art Director,Test Art Director                |
|Artbuyer                    | Tttt Artbuyer,Test Artbuyer                    |
|Chief Creative Officer      | Tttt Chief Creative Officer,Test Chief Creative Officer      |
|Creative Director           | Tttt Creative Director,Test Creative Director           |
|Copywriter                  | Tttt Copywriter,Test Copywriter                  |
|Executive Creative Director | Tttt Executive Creative Director,Test Executive Creative Director |
| Executive Producer          | Tttt Executive Producer,Test Executive Producer  |
| Studio                      | Tttt Studio,Test Studio |
| Editor                      | Tttt Editor,Test Editor |
| Music Performer             | Tttt Music Performer,Test Music Performer |
|Media Planner               | Tttt Media Planner,Test Media Planner               |
|Planner                     | Tttt Planner,Test Planner                     |
|Strategist                  | Tttt Strategist,Test Strategist                  |
|Shoot Dates                  | 12/12/2015                       |
|Media Agency                | Test Media Agency                |
|Media Agency Planner        | Tttt Media Agency Planner,Test Media Agency Planner        |



Scenario: Check that asset's data entered before can be updated on edit form
Meta:@library
     @gdam
!--This scenario might fail randomly due to long expansion of section on asset edit form on FF we are using..need to update FF
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_SWICMDV_S10' with default attributes
When I open role 'agency.admin' page with parent 'A_SWICMDV_S10'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMDV_S10_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMDV_S10_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_SWICMDV_S10'
And create following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMDV_S10':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMDV_S10 | BR_SWICMDV_S10 | SBR_SWICMDV_S10 | PR_SWICMDV_S10 |
And create users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_SWICMDV_S10 | A_SWICMDV_S10_R1 | A_SWICMDV_S10 |streamlined_library|
And login with details of 'U_SWICMDV_S10'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | ADV_SWICMDV_S10                   |
| Brand                       | BR_SWICMDV_S10                   |
| Sub Brand                   | SBR_SWICMDV_S10                  |
| Product                     | PR_SWICMDV_S10                   |
| Campaign                    | Tttt Campaign                    |
| Title                       | Fish Ad.mov                     |
| Country                     | Austria                          |
| Clock number                | testcn                          |
| Market Sector               | Tttt Market Sector               |
| Media sub-type              | Elements                            |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Description                 | Tttt Description                 |
| Brief                       | Tttt Brief                       |
| Advertising agency          | Tttt Advertising agency          |
| Account Director            | Tttt Account Director            |
| Account Manager             | Tttt Account Manager             |
| Art Director                | Tttt Art Director                |
| Artbuyer                    | Tttt Artbuyer                    |
| Chief Creative Officer      | Tttt Chief Creative Officer      |
| Creative Director           | Tttt Creative Director           |
| Copywriter                  | Tttt Copywriter                  |
| Executive Creative Director | Tttt Executive Creative Director |
And I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And 'save' asset info by following information on opened asset info pageNEWLIB:
|FieldName                    | FieldValue                       |
| Advertiser                  | ADV_SWICMDV_S10                   |
| Brand                       | BR_SWICMDV_S10                    |
| Sub Brand                   | SBR_SWICMDV_S10                   |
| Product                     | PR_SWICMDV_S10                    |
|Campaign                    | Test Campaign                    |
|Title                       | Fish Ad.mov                     |
| Clock number               | testcn                          |
|Country                     | Austria                          |
|Market Sector               | Test Market Sector               |
|Media sub-type              | Elements                        |
|Category                    | Food                             |
|Sub Category                | Meat and Fish                    |
|Description                 | Test Description                 |
|Brief                       | Test Brief                       |
|Account Director            | Test Account Director            |
|Account Manager             | Test Account Manager             |
|Art Director                | Test Art Director                |
|Artbuyer                    | Test Artbuyer                    |
|Chief Creative Officer      | Test Chief Creative Officer      |
|Creative Director           | Test Creative Director           |
|Copywriter                  | Test Copywriter                  |
|Executive Creative Director | Test Executive Creative Director |
And I refresh the page
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMDV_S10                   |
| Product Info             | Brand                       | BR_SWICMDV_S10                    |
| Product Info             | Sub Brand                   | SBR_SWICMDV_S10                   |
| Product Info             | Product                     | PR_SWICMDV_S10                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | Fish Ad.mov                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Technical                | Media sub-type              | Elements                                 |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Account Director            | Tttt Account Director,Test Account Director            |
| Agency Information       | Account Manager             | Tttt Account Manager,Test Account Manager             |
| Agency Information       | Art Director                | Tttt Art Director,Test Art Director                |
| Agency Information       | Artbuyer                    | Tttt Artbuyer,Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Tttt Chief Creative Officer,Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Tttt Creative Director,Test Creative Director           |
| Agency Information       | Copywriter                  | Tttt Copywriter,Test Copywriter                  |
| Agency Information       | Executive Creative Director | Tttt Executive Creative Director,Test Executive Creative Director |


Scenario: Check that common custom fields are displayed for all media types files
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMDV_S11' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |
| U_SWICMDV_S11 | agency.admin | A_SWICMDV_S11 |
And logged in with details of 'U_SWICMDV_S11'
And created 'P_SWICMDV_S11' project
And created '/F_SWICMDV_S11' folder for project 'P_SWICMDV_S11'
And uploaded '<FilePath>' file into '/F_SWICMDV_S11' folder for 'P_SWICMDV_S11' project
And waited while transcoding is finished in folder '/F_SWICMDV_S11' on project 'P_SWICMDV_S11' files page
When I go to file '<Filename>' info page in folder '/F_SWICMDV_S11' project 'P_SWICMDV_S11'
And click Edit link on file info page
Then I 'should' see following 'available' fields on opened Edit file popup:
| FieldName  | FieldValue |
| Advertiser |            |
| Brand      |            |
| Sub Brand  |            |
| Product    |            |
| Campaign   |            |
| Title      | <Filename> |

Examples:
| Filename         | FilePath                |
| audio01.mp3      | /files/audio01.mp3      |
| Fish-Ad.mov      | /files/Fish-Ad.mov      |
| GWGTest2.pdf     | /files/GWGTest2.pdf     |
| index.html       | /files/index.html       |
| BDDStandards.doc | /files/BDDStandards.doc |
| logo2.png        | /files/logo2.png        |


Scenario: Check that common custom fields are displayed for all media types assets
Meta:@library
     @gdam
Given I created the agency 'A_SWICMDV_S12' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_SWICMDV_S12 | agency.admin | A_SWICMDV_S12 |streamlined_library|
And logged in with details of 'U_SWICMDV_S12'
And uploaded file '<FilePath>' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset '<Filename>' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName              | FieldName  | FieldValue |
|Product Info              | Advertiser |            |
|Product Info              | Brand      |            |
|Product Info              | Sub Brand  |            |
|Product Info              | Product    |            |
|Product Info              | Campaign   |            |
|Product Info              | Title      | <Filename> |

Examples:
| Filename         | FilePath                |
| audio01.mp3      | /files/audio01.mp3      |
| Fish-Ad.mov      | /files/Fish-Ad.mov      |
| GWGTest2.pdf     | /files/GWGTest2.pdf     |
| index.html       | /files/index.html       |
| BDDStandards.doc | /files/BDDStandards.doc |
| logo2.png        | /files/logo2.png        |



Scenario: Check that entered values into dropdowns/catalogues can be used next time and correctly showed for print assets
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_SWICMD_S11_1' with default attributes
When I open role 'agency.admin' page with parent 'A_SWICMD_S11_1'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMD_S11_R4'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMD_S11_R4' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_SWICMD_S11_1'
And update following 'common' custom metadata fields for agency 'A_SWICMD_S11_1':
| FieldType          | Description | Parent     | AddOnFly |
| catalogueStructure | Advertiser  |            | true     |
| catalogueStructure | Brand       | Advertiser | true     |
| catalogueStructure | Sub Brand   | Brand      | true     |
| catalogueStructure | Product     | Sub Brand  | true     |
And create users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_SWICMD_S11 | A_SWICMD_S11_R4 | A_SWICMD_S11_1 |streamlined_library|
And login with details of 'U_SWICMD_S11'
And upload file '/files/Fish-Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'Fish-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | NewAdvertiser |
| Brand      | NewBrand      |
| Sub Brand  | NewSubBrand   |
| Product    | NewProduct    |
| Clock number    | testcn    |
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | NewAdvertiser |
| Brand      | NewBrand      |
| Sub Brand  | NewSubBrand   |
| Product    | NewProduct    |
| Clock number    | testcn    |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
 |FieldName   | FieldValue    |
 | Advertiser | NewAdvertiser |
 | Brand      | NewBrand      |
 | Sub Brand  | NewSubBrand   |
 | Product    | NewProduct    |


