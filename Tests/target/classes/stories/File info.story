!--NGN-509
Feature:          File info
Narrative:
In order to
As a              AgencyAdmin
I want to         Check info tab

Scenario: Check that file info metadata for video asset appears only after click on 'edit' element
Meta:@gdam
@projects
Given I created 'P_FIS_S1_1' project
And created '/F_FIS_S1_1' folder for project 'P_FIS_S1_1'
And uploaded into project 'P_FIS_S1_1' following files:
| FileName                   | Path        |
| /files/Fish Ad.mov         | /F_FIS_S1_1 |
And waited while preview is available in folder '/F_FIS_S1_1' on project 'P_FIS_S1_1' files page
And I am on file 'Fish Ad.mov' info page in folder '/F_FIS_S1_1' project 'P_FIS_S1_1'
When I click element 'EditLink' on page 'FilesPage'
Then I 'should' see following fields on opened Edit asset popup:
| FieldName                   |
| Advertiser                  |
| Brand                       |
| Sub Brand                   |
| Product                     |
| Campaign                    |
| Title                       |
| Category                    |
| Sub Category                |
| Genre                       |
| Air Date                    |
| Shoot Dates                 |
| Country                     |
| Screen                      |
| Duration                    |
| Approved For Broadcast      |
| Clock number                |
| 2D Artists                  |
| 2D Lead Artists             |
| 2D Supervisor               |
| 3D Artists                  |
| 3D Lead Artists             |
| Account Director            |
| Account Manager             |
| Advertising agency          |
| Agency Job reference        |
| Agency TV Producer          |
| Animation company           |
| Animator                    |
| Art Director                |
| Artbuyer                    |
| Assist                      |
| Audio Post                  |
| Brief                       |
| Chief Creative Officer      |
| Colourist                   |
| Composer                    |
| Copywriter                  |
| Costume Designer            |
| Creative Director           |
| Description                 |
| Director                    |
| Director of Photography     |
| Edit Assistant              |
| Edit company                |
| Editor                      |
| Executive Creative Director |
| Executive Producer          |
| Executive Producer          |
| Executive Producer          |
| Film Processing Lab         |
| Head of TV                  |
| ID Film (ARPP Users only)   |
| Lyrical Artist              |
| Lyricist                    |
| Make up Artist              |
| Market Sector               |
| Matte Painting              |
| Media Agency                |
| Media Agency Planner        |
| Media Planner               |
| Motion Graphics             |
| Music Arranger              |
| Music Company               |
| Music Performer             |
| Music recorded at           |
| Planner                     |
| Post-production             |
| Producer                    |
| Production Company Producer |
| Production Designer         |
| Production Manager          |
| Production company          |
| Recording Engineer          |
| Shoot Supervisor            |
| Sound Design                |
| Strategist                  |
| Studio                      |
| Studio/Location             |
| VFX Producer                |
| Voice Over Artist           |
| Production Assistant        |

Scenario: Check that specific asset information is available for different media types
Meta:@gdam
@projects
Given I created 'P_FIS_S2_1' project
And created '/F_FIS_S2_1' folder for project 'P_FIS_S2_1'
And uploaded into project 'P_FIS_S2_1' following files:
| FileName          | Path        |
| /files/<FileName> | /F_FIS_S2_1 |
And waited while preview is available in folder '/F_FIS_S2_1' on project 'P_FIS_S2_1' files page
And I am on file '<FileName>' info page in folder '/F_FIS_S2_1' project 'P_FIS_S2_1'
When click element 'EditLink' on page 'FilesPage'
Then I 'should' see fields '<Fields>' on opened Edit file popup

Examples:
| FileName              | Fields                                                                               |
| 128_shortname.jpg     | Advertiser,Brand,Sub Brand,Product,Title,Media sub-type                              |
| GWGTestfile064v3.pdf  | Advertiser,Brand,Sub Brand,Product,Title,Media type,Media sub-type,Country           |
| test.mp3              | Advertiser,Brand,Sub Brand,Product,Title,Media sub-type,Air date,Duration,Media type |


Scenario: Check that specific fields aren't required for video media type
Meta:@gdam
@projects
Given I created following projects:
| Name       | Job Number |
| P_FIS_S3_1 | J_FIS_S3_1 |
And created '/F_FIS_S3_1' folder for project 'P_FIS_S3_1'
And uploaded into project 'P_FIS_S3_1' following files:
| FileName                     | Path        |
| /files/13DV-CAPITAL-10.mpg   | /F_FIS_S3_1 |
And waited while transcoding is finished in folder '/F_FIS_S3_1' on project 'P_FIS_S3_1' files page
And I am on file '13DV-CAPITAL-10.mpg' info page in folder '/F_FIS_S3_1' project 'P_FIS_S3_1'
When I 'save' file info by next information:
| FieldName    | FieldValue  |
| Clock number | CN_FIS_S3_1 |
Then I 'should' see following 'custom metadata' field labels on opened asset info page:
| FieldName                 |
| Title,Media type,Duration |


Scenario: Check that metadata for video asset information can be changed
Meta:@gdam
@projects
Given I created 'P_FIS_S4_1' project
And created '/F_FIS_S4_1' folder for project 'P_FIS_S4_1'
And uploaded into project 'P_FIS_S4_1' following files:
| FileName                   | Path        |
| /files/13DV-CAPITAL-10.mpg | /F_FIS_S4_1 |
When wait while transcoding is finished in folder '/F_FIS_S4_1' on project 'P_FIS_S4_1' files page
And I go to file '13DV-CAPITAL-10.mpg' info page in folder '/F_FIS_S4_1' project 'P_FIS_S4_1'
And I 'save' file info by next information:
| FieldName                   | FieldValue                |
| Category                    | Food                      |
| Sub Category                | Meat and Fish             |
| Genre                       | Comedy                    |
| Air Date                    | 12/12/2015                |
| Shoot Dates                 | 12/12/2015                |
| Country                     | Austria                   |
| Screen                      | Spot                      |
| Duration                    | 6s 33ms                   |
| Approved For Broadcast      | No                        |
| Clock number                | testcn                    |
| 2D Artists                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| 2D Lead Artists             | &-??j?? ?=/*-+~!@#$%^*()_ |
| 2D Supervisor               | &-??j?? ?=/*-+~!@#$%^*()_ |
| 3D Artists                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| 3D Lead Artists             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Account Director            | &-??j?? ?=/*-+~!@#$%^*()_ |
| Account Manager             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Advertising agency          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Agency Job reference        | &-??j?? ?=/*-+~!@#$%^*()_ |
| Agency TV Producer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Animation company           | &-??j?? ?=/*-+~!@#$%^*()_ |
| Animator                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Art Director                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Artbuyer                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Assist                      | &-??j?? ?=/*-+~!@#$%^*()_ |
| Audio Post                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| Brief                       | &-??j?? ?=/*-+~!@#$%^*()_ |
| Chief Creative Officer      | &-??j?? ?=/*-+~!@#$%^*()_ |
| Colourist                   | &-??j?? ?=/*-+~!@#$%^*()_ |
| Composer                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Copywriter                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| Costume Designer            | &-??j?? ?=/*-+~!@#$%^*()_ |
| Creative Director           | &-??j?? ?=/*-+~!@#$%^*()_ |
| Description                 | &-??j?? ?=/*-+~!@#$%^*()_ |
| Director                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Director of Photography     | &-??j?? ?=/*-+~!@#$%^*()_ |
| Edit Assistant              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Edit company                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Editor                      | &-??j?? ?=/*-+~!@#$%^*()_ |
| Executive Creative Director | &-??j?? ?=/*-+~!@#$%^*()_ |
| Executive Producer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Executive Producer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Executive Producer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Film Processing Lab         | &-??j?? ?=/*-+~!@#$%^*()_ |
| Head of TV                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| ID Film (ARPP Users only)   | &-??j?? ?=/*-+~!@#$%^*()_ |
| Lyrical Artist              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Lyricist                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Make up Artist              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Market Sector               | &-??j?? ?=/*-+~!@#$%^*()_ |
| Matte Painting              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Media Agency                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Media Agency Planner        | &-??j?? ?=/*-+~!@#$%^*()_ |
| Media Planner               | &-??j?? ?=/*-+~!@#$%^*()_ |
| Motion Graphics             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Music Arranger              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Music Company               | &-??j?? ?=/*-+~!@#$%^*()_ |
| Music Performer             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Music recorded at           | &-??j?? ?=/*-+~!@#$%^*()_ |
| Planner                     | &-??j?? ?=/*-+~!@#$%^*()_ |
| Post-production             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Producer                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production Company Producer | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production Designer         | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production Manager          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production company          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Recording Engineer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Shoot Supervisor            | &-??j?? ?=/*-+~!@#$%^*()_ |
| Sound Design                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Strategist                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| Studio                      | &-??j?? ?=/*-+~!@#$%^*()_ |
| Studio/Location             | &-??j?? ?=/*-+~!@#$%^*()_ |
| VFX Producer                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Voice Over Artist           | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production Assistant        | &-??j?? ?=/*-+~!@#$%^*()_ |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName                   | FieldValue                |
| Category                    | Food                      |
| Sub Category                | Meat and Fish             |
| Genre                       | Comedy                    |
| Air Date                    | 12/12/2015                |
| Shoot Dates                 | 12/12/2015                |
| Country                     | Austria                   |
| Screen                      | Spot                      |
| Duration                    | 6s 33ms                   |
| Approved For Broadcast      | No                        |
| Clock number                | testcn                    |
| 2D Artists                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| 2D Lead Artists             | &-??j?? ?=/*-+~!@#$%^*()_ |
| 2D Supervisor               | &-??j?? ?=/*-+~!@#$%^*()_ |
| 3D Artists                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| 3D Lead Artists             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Account Director            | &-??j?? ?=/*-+~!@#$%^*()_ |
| Account Manager             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Advertising agency          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Agency Job reference        | &-??j?? ?=/*-+~!@#$%^*()_ |
| Agency TV Producer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Animation company           | &-??j?? ?=/*-+~!@#$%^*()_ |
| Animator                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Art Director                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Artbuyer                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Assist                      | &-??j?? ?=/*-+~!@#$%^*()_ |
| Audio Post                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| Brief                       | &-??j?? ?=/*-+~!@#$%^*()_ |
| Chief Creative Officer      | &-??j?? ?=/*-+~!@#$%^*()_ |
| Colourist                   | &-??j?? ?=/*-+~!@#$%^*()_ |
| Composer                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Copywriter                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| Costume Designer            | &-??j?? ?=/*-+~!@#$%^*()_ |
| Creative Director           | &-??j?? ?=/*-+~!@#$%^*()_ |
| Description                 | &-??j?? ?=/*-+~!@#$%^*()_ |
| Director                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Director of Photography     | &-??j?? ?=/*-+~!@#$%^*()_ |
| Edit Assistant              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Edit company                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Editor                      | &-??j?? ?=/*-+~!@#$%^*()_ |
| Executive Creative Director | &-??j?? ?=/*-+~!@#$%^*()_ |
| Executive Producer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Executive Producer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Executive Producer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Film Processing Lab         | &-??j?? ?=/*-+~!@#$%^*()_ |
| Head of TV                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| ID Film (ARPP Users only)   | &-??j?? ?=/*-+~!@#$%^*()_ |
| Lyrical Artist              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Lyricist                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Make up Artist              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Market Sector               | &-??j?? ?=/*-+~!@#$%^*()_ |
| Matte Painting              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Media Agency                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Media Agency Planner        | &-??j?? ?=/*-+~!@#$%^*()_ |
| Media Planner               | &-??j?? ?=/*-+~!@#$%^*()_ |
| Motion Graphics             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Music Arranger              | &-??j?? ?=/*-+~!@#$%^*()_ |
| Music Company               | &-??j?? ?=/*-+~!@#$%^*()_ |
| Music Performer             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Music recorded at           | &-??j?? ?=/*-+~!@#$%^*()_ |
| Planner                     | &-??j?? ?=/*-+~!@#$%^*()_ |
| Post-production             | &-??j?? ?=/*-+~!@#$%^*()_ |
| Producer                    | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production Company Producer | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production Designer         | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production Manager          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production company          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Recording Engineer          | &-??j?? ?=/*-+~!@#$%^*()_ |
| Shoot Supervisor            | &-??j?? ?=/*-+~!@#$%^*()_ |
| Sound Design                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Strategist                  | &-??j?? ?=/*-+~!@#$%^*()_ |
| Studio                      | &-??j?? ?=/*-+~!@#$%^*()_ |
| Studio/Location             | &-??j?? ?=/*-+~!@#$%^*()_ |
| VFX Producer                | &-??j?? ?=/*-+~!@#$%^*()_ |
| Voice Over Artist           | &-??j?? ?=/*-+~!@#$%^*()_ |
| Production Assistant        | &-??j?? ?=/*-+~!@#$%^*()_ |


Scenario: Check that Agency presents on file info page
Meta:@gdam
@projects
Given I created the agency 'A_FIS_S5' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| U_FIS_S5 | agency.admin | A_FIS_S5 |
And logged in with details of 'U_FIS_S5'
And created following projects:
| Name       |
| P_FIS_S5_1 |
And created '/F_FIS_S5_1' folder for project 'P_FIS_S5_1'
And uploaded into project 'P_FIS_S5_1' following files:
| FileName        | Path        |
| /files/test.mp3 | /F_FIS_S5_1 |
And waited while transcoding is finished in folder '/F_FIS_S5_1' on project 'P_FIS_S5_1' files page
And I am on file 'test.mp3' info page in folder '/F_FIS_S5_1' project 'P_FIS_S5_1'
Then I 'should' see following 'asset information' fields on opened file info page:
| FieldName      | FieldValue |
| Business Unit: | A_FIS_S5   |

Scenario: Check that specification information of uploaded audio file appears in file info
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I created 'P_FIS_S6_1' project
And created '/F_FIS_S6_1' folder for project 'P_FIS_S6_1'
And uploaded into project 'P_FIS_S6_1' following files:
| FileName          | Path        |
| /files/test.mp3   | /F_FIS_S6_1 |
And waited for '10' seconds
When wait while preview is available in folder '/F_FIS_S6_1' on project 'P_FIS_S6_1' files page
And I go to file 'test.mp3' info page in folder '/F_FIS_S6_1' project 'P_FIS_S6_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName      | FieldValue                          |
| Media type:     | audio                               |
| File type:      | MP3                                 |
| Format:         | MP2/3 (MPEG audio layer 2/3)        |
| Bit rate:       | 256000                              |
| Channels:       | 2                                   |
| Sampling rate:  | 44100                               |
| Name:           | Benjamin Franklin15e                |
| Artist:         | Walter Isaacson                     |
| Album:          | Benjamin Franklin: An American Life |
| Composer:       | Nelson Runger                       |
| Genre:          | Audio Book: History                 |
| Year:           | 2004                                |
| Track Number:   | 5                                   |

Scenario: Check that specification information of uploaded image psd file appears in file info
Meta:@gdam
@projects
Given I created 'P_FIS_S8_1' project
And created '/F_FIS_S8_1' folder for project 'P_FIS_S8_1'
And uploaded into project 'P_FIS_S8_1' following files:
| FileName            | Path        |
| /files/example.psd  | /F_FIS_S8_1 |
When wait while transcoding is finished in folder '/F_FIS_S8_1' on project 'P_FIS_S8_1' files page
And I go to file 'example.psd' info page in folder '/F_FIS_S8_1' project 'P_FIS_S8_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName                   | FieldValue                                    |
| Displayed units x:           | inches                                        |
| Displayed units y:           | inches                                        |
| Technology:                  | Cathode Ray Tube Display                      |
| Num channels:                | 4                                             |
| Y resolution:                | 72                                            |
| Model desc:                  | IEC 61966-2.1 Default RGB colour space - sRGB |
| Profile description:         | sRGB IEC61966-2.1                             |
| Profile copyright:           | Copyright (c) 1998 Hewlett-Packard Company    |
| Media type:                  | print                                         |
| Bit depth:                   | 8                                             |
| Software:                    | Adobe Photoshop CS2 Windows                   |
| Height:                      | 100                                           |
| X resolution:                | 72                                            |
| Device Mfg desc:             | IEC http://www.iec.ch                         |
| Color mode:                  | RGB                                           |
| Orientation:                 | Horizontal (normal)                           |
| Blue matrix column:          | 0.14307 0.06061 0.7141                        |
| File type:                   | PSD                                           |
| Red matrix column:           | 0.43607 0.22249 0.01392                       |
| Exif image height:           | 100                                           |
| Viewing cond desc:           | Reference Viewing Condition in IEC61966-2.1   |
| Green matrix column:         | 0.38515 0.71687 0.09708                       |
| Width:                       | 100                                           |
| Media black point:           | 0 0 0                                         |
| Luminance:                   | 76.03647 80 87.12462                          |
| Media white point:           | 0.95045 1 1.08905                             |
| Resolution unit:             | inches                                        |
| Exif image width:            | 100                                           |
| Color space:                 | sRGB                                          |
| File name:                   | example.psd                                   |


Scenario: Check that specification information of uploaded image pdf file appears in file info
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I created 'P_FIS_S9_1' project
And created '/F_FIS_S9_1' folder for project 'P_FIS_S9_1'
And uploaded into project 'P_FIS_S9_1' following files:
| FileName                    | Path        |
| /files/GWGTestfile064v3.pdf | /F_FIS_S9_1 |
When wait while preview is available in folder '/F_FIS_S9_1' on project 'P_FIS_S9_1' files page
And I go to file 'GWGTestfile064v3.pdf' info page in folder '/F_FIS_S9_1' project 'P_FIS_S9_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName   | FieldValue                        |
| Media type:  | print                             |
| File type:   | PDF                               |
| Create date: | 2006:06:29 10:54:07+02:00         |
| PDF version: | 1.3                               |
| Linearized:  | No                                |
| Page count:  | 1                                 |
| Creator:     | PScript5.dll Version 5.2          |
| Producer:    | Acrobat Distiller 7.0.5 (Windows) |
| Trapped:     | False                             |


Scenario: Check that specification information of uploaded image file appears in file info
Meta:@gdam
@projects
Given I created 'P_FIS_S10_1' project
And created '/F_FIS_S10_1' folder for project 'P_FIS_S10_1'
And uploaded into project 'P_FIS_S10_1' following files:
| FileName              | Path         |
| /files/example2.indd  | /F_FIS_S10_1 |
When wait while transcoding is finished in folder '/F_FIS_S10_1' on project 'P_FIS_S10_1' files page
And I go to file 'example2.indd' info page in folder '/F_FIS_S10_1' project 'P_FIS_S10_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName                   | FieldValue                |
| Media type:                  | print                     |
| File type:                   | INDD                      |
| Width:                       | 256                       |
| Height:                      | 256                       |
| Create date:                 | 2011:04:04 14:49:59+01:00 |
| Colorant swatch name:        | rdf:li                    |


Scenario: Check that specification information of uploaded image file appears in file info
Meta:@gdam
@projects
Given I created 'P_FIS_S11_1' project
And created '/F_FIS_S11_1' folder for project 'P_FIS_S11_1'
And uploaded into project 'P_FIS_S11_1' following files:
| FileName                 | Path         |
| /files/128_shortname.jpg | /F_FIS_S11_1 |
When wait while transcoding is finished in folder '/F_FIS_S11_1' on project 'P_FIS_S11_1' files page
And I go to file '128_shortname.jpg' info page in folder '/F_FIS_S11_1' project 'P_FIS_S11_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName                   | FieldValue       |
| Media type:                  | image            |
| File type:                   | JPEG             |
| Width:                       | 625              |
| Height:                      | 469              |
| Bits per sample:             | 8                |
| Color components:            | 3                |
| Y Cb Cr sub sampling:        | YCbCr4:2:0 (2 2) |


Scenario: Check that specification information of uploaded documnet XLS file appears in file info
Meta:@gdam
@projects
Given I created 'P_FIS_S21_1' project
And created '/F_FIS_S21_1' folder for project 'P_FIS_S21_1'
And uploaded into project 'P_FIS_S21_1' following files:
| FileName       | Path         |
| /files/919.xls | /F_FIS_S21_1 |
When wait while transcoding is finished in folder '/F_FIS_S21_1' on project 'P_FIS_S21_1' files page
And I go to file '919.xls' info page in folder '/F_FIS_S21_1' project 'P_FIS_S21_1'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue |
| Media type | document   |
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName | FieldValue |
| File type: | XLS        |


Scenario: Check that specification information of uploaded documnet doc file appears in file info
Meta:@gdam
@projects
Given I created 'P_FIS_S22_1' project
And created '/F_FIS_S22_1' folder for project 'P_FIS_S22_1'
And uploaded into project 'P_FIS_S22_1' following files:
| FileName                | Path         |
| /files/BDDStandards.doc | /F_FIS_S22_1 |
When wait while transcoding is finished in folder '/F_FIS_S22_1' on project 'P_FIS_S22_1' files page
And I go to file 'BDDStandards.doc' info page in folder '/F_FIS_S22_1' project 'P_FIS_S22_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName  | FieldValue |
| Media type: | document   |
| File type:  | DOC        |


Scenario: Check that specification information of uploaded documnet rar file appears in file info
Meta:@gdam
@projects
Given I created 'P_FIS_S23_1' project
And created '/F_FIS_S23_1' folder for project 'P_FIS_S23_1'
And uploaded into project 'P_FIS_S23_1' following files:
| FileName           | Path         |
| /files/example.rar | /F_FIS_S23_1 |
When wait while transcoding is finished in folder '/F_FIS_S23_1' on project 'P_FIS_S23_1' files page
And I go to file 'example.rar' info page in folder '/F_FIS_S23_1' project 'P_FIS_S23_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName  | FieldValue |
| Media type: | other      |
| File type:  | RAR        |


Scenario: Check that specification information of uploaded documnet txt file appears in file info
Meta:@gdam
@projects
Given I created 'P_FIS_S24_1' project
And created '/F_FIS_S24_1' folder for project 'P_FIS_S24_1'
And uploaded into project 'P_FIS_S24_1' following files:
| FileName                     | Path         |
| /files/New Text Document.txt | /F_FIS_S24_1 |
When wait while transcoding is finished in folder '/F_FIS_S24_1' on project 'P_FIS_S24_1' files page
And I go to file 'New Text Document.txt' info page in folder '/F_FIS_S24_1' project 'P_FIS_S24_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName  | FieldValue            |
| Media type: | other                 |
| File name:  | New Text Document.txt |


Scenario: Check that specification information of uploaded documnet jar file appears in file info
Meta:@gdam
@projects
Given I created 'P_FIS_S25_1' project
And created '/F_FIS_S25_1' folder for project 'P_FIS_S25_1'
And uploaded into project 'P_FIS_S25_1' following files:
| FileName         | Path         |
| /files/test6.jar | /F_FIS_S25_1 |
When wait while transcoding is finished in folder '/F_FIS_S25_1' on project 'P_FIS_S25_1' files page
And I go to file 'test6.jar' info page in folder '/F_FIS_S25_1' project 'P_FIS_S25_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName  | FieldValue |
| Media type: | other      |
| File type:  | ZIP        |


Scenario: Check that data about uploaded audio file cannot be editable
Meta:@gdam
@projects
Given I created 'P_FIS_S13_1' project
And created '/F_FIS_S13_1' folder for project 'P_FIS_S13_1'
And uploaded into project 'P_FIS_S13_1' following files:
| FileName        | Path         |
| /files/test.mp3 | /F_FIS_S13_1 |
When wait while preview is available in folder '/F_FIS_S13_1' on project 'P_FIS_S13_1' files page
And I go to file 'test.mp3' info page in folder '/F_FIS_S13_1' project 'P_FIS_S13_1'
And I click element 'EditLink' on page 'FilesPage'
Then I 'should not' see following fields on opened Edit file popup:
| FieldName     |
| Asset type    |
| File type     |
| Format        |
| Bit rate      |
| Channels      |
| Sampling rate |
| Artist        |
| Album         |
| Year          |
| Track number  |


Scenario: Check that data about uploaded video file cannot be editable
Meta:@gdam
@projects
Given I created 'P_FIS_S26_1' project
And created '/F_FIS_S26_1' folder for project 'P_FIS_S26_1'
And uploaded into project 'P_FIS_S26_1' following files:
| FileName                   | Path         |
| /files/Fish Ad.mov         | /F_FIS_S26_1 |
When wait while preview is available in folder '/F_FIS_S26_1' on project 'P_FIS_S26_1' files page
And I go to file 'Fish Ad.mov' info page in folder '/F_FIS_S26_1' project 'P_FIS_S26_1'
And I click element 'EditLink' on page 'FilesPage'
Then I 'should not' see following fields on opened Edit file popup:
| FieldName            |
| Asset type           |
| File type            |
| Format               |
| Format general       |
| Format version       |
| File size            |
| Display aspect ratio |
| Frame                |
| Width                |
| Height               |


Scenario: Check that after change title, it changes on info tab
Meta:@gdam
@projects
Given I created 'P_FIS_S17_1' project
And created '/F_FIS_S17_1' folder for project 'P_FIS_S17_1'
And uploaded into project 'P_FIS_S17_1' following files:
| FileName           | Path         |
| /files/audio02.mp3 | /F_FIS_S17_1 |
When wait while transcoding is finished in folder '/F_FIS_S17_1' on project 'P_FIS_S17_1' files page
And I go to file 'audio02.mp3' info page in folder '/F_FIS_S17_1' project 'P_FIS_S17_1'
And I 'save' file info by next information:
| FieldName | FieldValue  |
| Title     | <FileTitle> |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName | FieldValue  |
| Title     | <FileTitle> |

Examples:
| FileTitle                                           |
| abcdefghijklmnoprqtsuvwyxz1234567890~!@#%&*()_+=O`" |


Scenario: Check that after change title, it changes on version history tab
Meta:@gdam
@projects
Given I created 'P_FIS_S18_1' project
And created '/F_FIS_S18_1' folder for project 'P_FIS_S18_1'
And uploaded into project 'P_FIS_S18_1' following files:
| FileName        | Path         |
| /files/test.mp3 | /F_FIS_S18_1 |
When wait while transcoding is finished in folder '/F_FIS_S18_1' on project 'P_FIS_S18_1' files page
And I go to file 'test.mp3' info page in folder '/F_FIS_S18_1' project 'P_FIS_S18_1'
And I 'save' file info by next information:
| FieldName | FieldValue |
| Title     | babamiwa   |
And I click element 'VersionHistory' on page 'FilesPage'
Then I should see next title name 'babamiwa' on version history tab


Scenario: Check that data about uploaded image (psd) file cannot be editable
Meta:@gdam
@projects
Given I created 'P_FIS_S30_1' project
And created '/F_FIS_S30_1' folder for project 'P_FIS_S30_1'
And uploaded into project 'P_FIS_S30_1' following files:
| FileName           | Path         |
| /files/example.psd | /F_FIS_S30_1 |
When wait while transcoding is finished in folder '/F_FIS_S30_1' on project 'P_FIS_S30_1' files page
And I go to file 'example.psd' info page in folder '/F_FIS_S30_1' project 'P_FIS_S30_1'
And I click element 'EditLink' on page 'FilesPage'
Then I 'should not' see following fields on opened Edit file popup:
| FieldName                   |
| Asset type                  |
| File type                   |
| Width                       |
| Height                      |
| File modification date/time |
| Num channels                |
| Bit depth                   |
| Color mode                  |
| X resolution                |
| Displayed units x           |
| Y resolution                |
| Displayed units y           |
| Profile copyright           |
| Profile description         |
| Media white point           |
| Media black point           |
| Red matrix column           |
| Green matrix column         |
| Blue matrix column          |
| Device mfg desc             |
| Model desc                  |
| Viewing cond desc           |
| Luminance                   |
| Technology                  |


Scenario: Check that specification information of uploaded video file appears in file info
!-- Please note that this scenario will not pass on S3 storage because of QAB-767. Removed from Live and UAT smoke since we run it on S3 storage now.
Meta: @qagdamsmoke
      @gdam
      @projects
Given I created 'P_FIS_S7_1' project
And created '/F_FIS_S7_1' folder for project 'P_FIS_S7_1'
And uploaded into project 'P_FIS_S7_1' following files:
| FileName                   | Path        |
| /files/13DV-CAPITAL-10.mpg | /F_FIS_S7_1 |
When wait while preview is available in folder '/F_FIS_S7_1' on project 'P_FIS_S7_1' files page
And I go to file '13DV-CAPITAL-10.mpg' info page in folder '/F_FIS_S7_1' project 'P_FIS_S7_1'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName            | FieldValue |
| Media type:           | video      |
| File type:            | MPEG       |
| Format:               | MPEG Video |
| Format general:       | MPEG-PS    |
| Format version:       | Version 1  |
| File size:            | 408 KiB    |
| Display aspect ratio: | 16:9       |
| Frame:                | 25.000 fps |
| Width:                | 768 pixels |
| Height:               | 432 pixels |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName | FieldValue |
| Duration  | 3s 120ms   |


Scenario: Check that specification information of uploaded digital gif file appears in file info
Meta:@gdam
@projects
Given I created 'P_FIS_S8_6' project
And created '/F_FIS_S8_6' folder for project 'P_FIS_S8_6'
And uploaded into project 'P_FIS_S8_6' following files:
| FileName            | Path        |
| /files/logo1.gif    | /F_FIS_S8_6 |
When wait while transcoding is finished in folder '/F_FIS_S8_6' on project 'P_FIS_S8_6' files page
And I go to file 'logo1.gif' info page in folder '/F_FIS_S8_6' project 'P_FIS_S8_6'
Then I 'should' see following 'specification' fields on opened file info page:
| FieldName  | FieldValue |
| Media type: | digital    |
| File type:  | GIF        |



Scenario: Check that specification information of uploaded digital gif file appears in asset info
Meta:@gdam
@library
Given I am on the library pageNEWLIB
And uploaded asset '/files/logo1.gif' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And on asset 'logo1.gif' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'specification' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Media type | digital    |
| File type  | GIF        |
