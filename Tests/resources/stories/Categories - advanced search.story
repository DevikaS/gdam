!--NGN-3041
Feature:          Categories - advanced search
Narrative:
In order to
As a              AgencyAdmin
I want to         check advanced search in categories



Scenario: Check that possible to add many metadata for video filter
Meta:@gdam
     @library
!--This scenario fails due to long expansion of section on asset edit form on FF we are using..need to update FF
Given I created the agency 'A_CAS_S01' with default attributes
And I logged in as 'GlobalAdmin'
When I open role 'agency.admin' page with parent 'A_CAS_S01'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_CAS_S01_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_CAS_S01_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_CAS_S01'
And create users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_CAS_S01 | A_CAS_S01_R1 | A_CAS_S01    |streamlined_library|
And login with details of 'U_CAS_S01'
And create following categories:
| Name      |
| C_CAS_S01 |
And I upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Executive Creative Director | Test Executive Creative Director |
| Head of TV                  | Test Head of TV                  |
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
| Clock number                | Clk73              |
And add into category 'C_CAS_S01' following metadata with switched on mediatype 'VIDEO':
| FilterName                  | FilterValue                      |
| Business Unit               | A_CAS_S01                        |
| Executive Creative Director | Test Executive Creative Director |
| Head of TV                  | Test Head of TV                  |
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
Then I 'should' see following metadata for category 'C_CAS_S01' on Categories and Permissions page:
| FilterName                  | FilterValue                      |
| Executive Creative Director | Test Executive Creative Director |
| Head of TV                  | Test Head of TV                  |
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

Scenario: Check that possible to add many metadata for print filter
Meta:@gdam
     @library
Given I created the agency 'A_CAS_S02' with default attributes
And I logged in as 'GlobalAdmin'
When I open role 'agency.admin' page with parent 'A_CAS_S02'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_CAS_S02_R2'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_CAS_S02_R2' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_CAS_S02'
And create users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_CAS_S02 | A_CAS_S02_R2 | A_CAS_S02    |streamlined_library|
And login with details of 'U_CAS_S02'
And create following categories:
| Name      |
| C_CAS_S02 |
And upload file '/files/GWGTest2.pdf' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Country                     | Austria                          |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Genre                       | Comedy                           |
| Shoot Date                  | 12/12/15                       |
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
And add into category 'C_CAS_S02' following metadata with switched on mediatype 'PRINT':
| FilterName                  | FilterValue                      |
| Business Unit               | A_CAS_S02                        |
| Country                     | Austria                          |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Genre                       | Comedy                           |
| Shoot Date                  | 12/12/2015                       |
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
Then I 'should' see following metadata for category 'C_CAS_S02' on Categories and Permissions page:
| FilterName                  | FilterValue                      |
| Country                     | Austria                          |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Genre                       | Comedy                           |
| Shoot Date                  | Select Date,12/12/2015           |
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


Scenario: check that case insensitive for video mediatypes
Meta:@skip
!--data entered in edit asset pop up is case-sensitive in new lib
Given I created the agency 'A_CAS_S03' with default attributes
And updated following 'asset' custom metadata fields for agency 'A_CAS_S03':
| FieldType | Section | Description        | Choices                   |
| dropdown  | video   | Account Director   | Mr. Garrison,mr. Garrison |
And created users with following fields:
| Email     | Role         | Agency    |
| U_CAS_S03 | agency.admin | A_CAS_S03 |
And logged in with details of 'U_CAS_S03'
And created following categories:
| Name           |
| <CategoryName> |
And uploaded file '/files/Fish1-Ad.mov' into library
And uploaded file '/files/Fish2-Ad.mov' into library
And waited while transcoding is finished in collection 'My Assets'
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following information:
| FieldName          | FieldValue      |
| Account Director   | Mr. Garrison    |
| Agency TV Producer | Mr. Mackey      |
| Art Director       | Mr. Slave       |
| Copywriter         | mr. Hankey      |
| Creative Director  | Ms. Choksondik  |
| Executive Producer | Ms. Crabtree    |
| Head of TV         | Mayor McDaniels |
| Production company | Father Maxi     |
And 'save' asset 'Fish2-Ad.mov' info of collection 'My Assets' by following information:
| FieldName          | FieldValue        |
| Account Director   | Mr. Garrison      |
| Agency TV Producer | Kyle Broflovski   |
| Art Director       | Eric Cartman      |
| Copywriter         | Mr. Hankey        |
| Creative Director  | Butters Stotch    |
| Executive Producer | Wendy Testaburger |
| Head of TV         | Tweek Tweak       |
| Production company | Token Black       |
When I add into category '<CategoryName>' following metadata with switched on mediatype 'VIDEO':
| FilterName       | FilterValue       |
| Business Unit    | A_CAS_S03         |
| Account Director | <AccountDirector> |
| Copywriter       | <Copywriter>      |
And I go to library page for collection '<CategoryName>'
Then I 'should' see assets '<AssetName>' in the collection '<CategoryName>'
And I should see assets '<AssetsCount>' on the library page

Examples:
| CategoryName | AccountDirector | Copywriter | AssetName                 | AssetsCount |
| C_CAS_S03_1  | Mr. Garrison    |            | Fish1-Ad.mov,Fish2-Ad.mov | 2           |
| C_CAS_S03_2  |                 | Mr. Hankey | Fish1-Ad.mov,Fish2-Ad.mov | 2           |
| C_CAS_S03_3  | mr. Garrison    |            | Fish1-Ad.mov,Fish2-Ad.mov | 2           |


Scenario: check that case insensitive for print mediatypes for category
Meta:@skip
!--data entered in edit asset pop up is case-sensitive in new lib
Given I created the agency 'A_CAS_S04' with default attributes
And updated following 'asset' custom metadata fields for agency 'A_CAS_S04':
| FieldType | Section | Description        | Choices                   |
| dropdown  | video   | Account Director   | Mr. Garrison,mr. Garrison |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| U_CAS_S04 | agency.admin | A_CAS_S04    |
And logged in with details of 'U_CAS_S04'
And created following categories:
| Name           |
| <CategoryName> |
And uploaded asset '/files/GWGTestfile064v3.pdf' into library
And uploaded asset '/files/GWGTest2.pdf' into library
And waited while transcoding is finished in collection 'My Assets'
When I go to asset 'GWGTestfile064v3.pdf' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName         | FieldValue      |
| Account Director  | Mr. Garrison    |
| Account Manager   | Mr. Mackey      |
| Art Director      | Mr. Slave       |
| Copywriter        | mr. Hankey      |
| Creative Director | Ms. Choksondik  |
| Planner           | Ms. Crabtree    |
| Photographer      | Mayor McDaniels |
| Studio Name       | Father Maxi     |
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName         | FieldValue      |
| Account Director  | Mr. Garrison    |
| Account Manager   | Mr. Mackey      |
| Art Director      | Mr. Slave       |
| Copywriter        | mr. Hankey      |
| Creative Director | Ms. Choksondik  |
| Planner           | Ms. Crabtree    |
| Photographer      | Mayor McDaniels |
| Studio Name       | Father Maxi     |
And add into category '<CategoryName>' following metadata with switched on mediatype 'PRINT':
| FilterName       | FilterValue       |
| Business Unit    | A_CAS_S04         |
| Account Director | <AccountDirector> |
| Copywriter       | <Copywriter>      |
And I go to library page for collection '<CategoryName>'
Then I 'should' see assets '<AssetName>' in the collection '<CategoryName>'
And I should see assets '<AssetsCount>' on the library page

Examples:
| CategoryName | AccountDirector | Copywriter | AssetName                         | AssetsCount |
| C_CAS_S04_1  | Mr. Garrison    |            | GWGTestfile064v3.pdf,GWGTest2.pdf | 2           |
| C_CAS_S04_2  |                 | Mr. Hankey | GWGTestfile064v3.pdf,GWGTest2.pdf | 2           |
| C_CAS_S04_3  | mr. Garrison    |            | GWGTestfile064v3.pdf,GWGTest2.pdf | 2           |


Scenario: Check that when 'off' video this remove added video metadata
Meta:@gdam
     @library
Given I created the agency 'A_CAS_S06' with default attributes
And updated following 'asset' custom metadata fields for agency 'A_CAS_S06':
| FieldType | Section | Description        | Choices                 |
| dropdown  | video   | Account Director   | Officer Barbrady        |
| dropdown  | video   | Agency TV Producer | Sergeant Harrison Yates |
And created users with following fields:
| Email     | Role         | Agency    |
| U_CAS_S06 | agency.admin | A_CAS_S06 |
And logged in with details of 'U_CAS_S06'
And created following categories:
| Name      |
| C_CAS_S06 |
When I go to collection 'C_CAS_S06' on administration area collections page
And switch 'on' media type filter 'VIDEO' on administration area collections page
And add following metadata on opened category page:
| FilterName         | FilterValue             |
| Business Unit      | A_CAS_S06               |
| Account Director   | Officer Barbrady        |
| Agency TV Producer | Sergeant Harrison Yates |
And switch 'off' media type filter 'VIDEO' on administration area collections page
Then I should see following metadata keys on the current categories page:
| Name               | ShouldState |
| Account Director   | should not  |
| Agency TV Producer | should not  |
And I should see following metadata keys in the drop-down menu for current category:
| Name               | ShouldState |
| Account Director   | should not  |
| Agency TV Producer | should not  |
| Art Director       | should not  |
| Copywriter         | should not  |
| Creative Director  | should not  |
| Executive Producer | should not  |
| Head of TV         | should not  |
| Production company | should not  |
| Screen             | should not  |
| Country            | should not  |


Scenario: check additional Media sub-types for video
Meta:@gdam
     @library
Given I created the agency 'A_CAS_S07' with default attributes
And I logged in as 'GlobalAdmin'
When I open role 'agency.admin' page with parent 'A_CAS_S07'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_CAS_S07_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_CAS_S07_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_CAS_S07'
And create users with following fields:
| Email     | Role         | Agency    |Access|
| U_CAS_S07 | A_CAS_S07_R1 | A_CAS_S07 |streamlined_library|
And login with details of 'U_CAS_S07'
And create following categories:
| Name           |
| <CategoryName> |
And upload file '/files/Fish1-Ad.mov' into libraryNEWLIB
And upload file '/files/Fish2-Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName          | FieldValue      |
| Account Director   | Mr. Garrison    |
| Agency TV Producer | Mr. Mackey      |
| Art Director       | Mr. Slave       |
| Copywriter         | Mr. Hankey      |
| Creative Director  | Ms. Choksondik  |
| Executive Producer | Ms. Crabtree    |
| Head of TV         | Mayor McDaniels |
| Production company | Father Maxi     |
| Screen             | Spot            |
| Media sub-type     | Generic Master  |
| Clock number     | Clk12  |
And 'save' asset 'Fish2-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName          | FieldValue        |
| Account Director   | Stan Marsh        |
| Agency TV Producer | Kyle Broflovski   |
| Art Director       | Eric Cartman      |
| Copywriter         | Mr. Hankey        |
| Creative Director  | Butters Stotch    |
| Executive Producer | Wendy Testaburger |
| Head of TV         | Tweek Tweak       |
| Production company | Token Black       |
| Screen             | Trailer           |
| Media sub-type     | Titled Master     |
| Clock number     | Clk132  |
And go to collection '<CategoryName>' on administration area collections page
When switch 'on' media type filter 'video' on administration area collections page
And add following metadata on opened category page:
| FilterName       | FilterValue       |
| Business Unit    | A_CAS_S07         |
| Account Director | <AccountDirector> |
| Copywriter       | <Copywriter>      |
When I click save button for metadata of current category
And I go to library page for collection '<CategoryName>'NEWLIB
Then I 'should' see assets '<AssetName>' in the collection '<CategoryName>'NEWLIB
Then I 'should' see asset count '<AssetsCount>' in '<CategoryName>' NEWLIB

Examples:
| CategoryName | AccountDirector | Copywriter | AssetName                 | AssetsCount |
| C_CAS_S07_1  |                 | Mr. Hankey | Fish1-Ad.mov,Fish2-Ad.mov | 2           |



Scenario: Check that Location/Studio, Photographer, Retoucher, Shoot Date, Studio Name fields are available only for print media type
Meta:@gdam
     @library
Given I created following categories:
| Name      |
| C_CAS_S08 |
When I go to collection 'C_CAS_S08' on administration area collections page
And add following metadata on opened category page:
| FilterName    | FilterValue   |
| Business Unit | DefaultAgency |
And switch 'on' media type filter '<Filter>' on administration area collections page
Then I should see following metadata keys in the drop-down menu for current category:
| Name            | ShouldState |
| Location/Studio | <Condition> |
| Photographer    | <Condition> |
| Retoucher       | <Condition> |
| Shoot Date      | <Condition> |
| Studio Name     | <Condition> |

Examples:
| Filter   | Condition  |
| print    | should     |
| image    | should not |
| audio    | should not |
| video    | should not |
| ditital  | should not |
| document | should not |


Scenario: Check that 2D Artists, 2D Lead Artists, 2D Supervisor, 3D Artists, 3D Lead Artists, Agency Job reference, Agency TV Producer, Animation company, Animator, Assist, Colourist, Costume Designer, Director, Director of Photography, Edit Assistant, Edit company, Editor, Film Processing Lab, Head of TV, ID Film (ARPP Users only), Make up Artist, Matte Painting, Motion Graphics, Post-production, Production Company Producer, Production Designer, Production Manager, Production company, Shoot Dates, Shoot Supervisor, Studio, Studio/Location, VFX Producer, Production Assistant, Screen fields are available only for video media type
Meta:@gdam
     @library
Given I created 'C_CAS_S09' category
When I go to collection 'C_CAS_S09' on administration area collections page
And add following metadata on opened category page:
| FilterName    | FilterValue   |
| Business Unit | DefaultAgency |
And switch 'on' media type filter '<Filter>' on administration area collections page
Then I should see following metadata keys in the drop-down menu for current category:
| Name                        | ShouldState |
| 2D Artists                  | <Condition> |
| 2D Lead Artists             | <Condition> |
| 2D Supervisor               | <Condition> |
| 3D Artists                  | <Condition> |
| 3D Lead Artists             | <Condition> |
| Agency Job reference        | <Condition> |
| Agency TV Producer          | <Condition> |
| Animation company           | <Condition> |
| Animator                    | <Condition> |
| Assist                      | <Condition> |
| Colourist                   | <Condition> |
| Costume Designer            | <Condition> |
| Director                    | <Condition> |
| Director of Photography     | <Condition> |
| Edit Assistant              | <Condition> |
| Edit company                | <Condition> |
| Editor                      | <Condition> |
| Film Processing Lab         | <Condition> |
| Head of TV                  | <Condition> |
| ID Film (ARPP Users only)   | <Condition> |
| Make up Artist              | <Condition> |
| Matte Painting              | <Condition> |
| Motion Graphics             | <Condition> |
| Post-production             | <Condition> |
| Production Company Producer | <Condition> |
| Production Designer         | <Condition> |
| Production Manager          | <Condition> |
| Production company          | <Condition> |
| Shoot Dates                 | <Condition> |
| Shoot Supervisor            | <Condition> |
| Studio                      | <Condition> |
| Studio/Location             | <Condition> |
| VFX Producer                | <Condition> |
| Production Assistant        | <Condition> |
| Screen                      | <Condition> |

Examples:
| Filter   | Condition  |
| video    | should     |
| print    | should not |
| image    | should not |
| audio    | should not |
| ditital  | should not |
| document | should not |


Scenario: Check that Agency Producer, Country of Broadcast, JCN Number, RACC Approval fields are available only for audio media type
Meta:@gdam
     @library
Given I created following categories:
| Name      |
| C_CAS_S10 |
When I go to collection 'C_CAS_S10' on administration area collections page
And add following metadata on opened category page:
| FilterName    | FilterValue   |
| Business Unit | DefaultAgency |
And switch 'on' media type filter '<Filter>' on administration area collections page
Then I should see following metadata keys in the drop-down menu for current category:
| Name                 | ShouldState |
| Agency Producer      | <Condition> |
| Country of Broadcast | <Condition> |
| JCN Number           | <Condition> |
| RACC Approval        | <Condition> |

Examples:
| Filter   | Condition  |
| audio    | should     |
| video    | should not |
| print    | should not |
| image    | should not |
| digital  | should not |
| document | should not |


Scenario: Check that hidden fields are not available for advance search
Meta:@gdam
     @library
Given I created the agency 'A_CAS_S11' with default attributes
And created users with following fields:
| Email     | Role         | AgencyUnique |
| U_CAS_S11 | agency.admin | A_CAS_S11    |
And logged in with details of 'U_CAS_S11'
And created following categories:
| Name      |
| C_CAS_S11 |
When I go to collection 'C_CAS_S11' on administration area collections page
And switch 'on' media type filter 'VIDEO' on administration area collections page
And add following metadata on opened category page:
| FilterName    | FilterValue |
| Business Unit | A_CAS_S11   |
Then I 'should not' see following available metadata filters on opened category page:
| FilterName                         |
| Artist                             |
| Client                             |
| Client supervisor                  |
| Designer                           |
| Director of advertising production |
| Executive producer                 |
| Film editor                        |
| Keywords                           |
| Lighting cameraman                 |
| Made by                            |
| Post house                         |
| Year                               |
| Sound designer                     |
| Volume                             |
| Writer                             |
| Written location                   |


Scenario: Check that hidden fields are not available for advance search for print schema
Meta:@gdam
     @library
Given I created the agency 'A_CAS_S12' with default attributes
And created users with following fields:
| Email     | Role         | AgencyUnique |
| U_CAS_S12 | agency.admin | A_CAS_S12    |
And logged in with details of 'U_CAS_S12'
And created following categories:
| Name      |
| C_CAS_S12 |
When I go to collection 'C_CAS_S12' on administration area collections page
And switch 'on' media type filter 'PRINT' on administration area collections page
And add following metadata on opened category page:
| FilterName    | FilterValue |
| Business Unit | A_CAS_S12   |
Then I 'should not' see following available metadata filters on opened category page:
| FilterName       |
| Ingest languages |