!--NGN-7302
Feature:          Simple work with inserted CM data for LBB Agency - Print file and asset
Narrative:        QA internal task
In order to
As a              GlobalAdmin
I want to         check proper data displaying, updating in view form, edit form


Scenario: Check that all specified fields is shown on Edit form of print file
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMD_S01' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_SWICMD_S01 | agency.admin | A_SWICMD_S01 |
And logged in with details of 'U_SWICMD_S01'
And created 'P_LBBP_S01' project
And created '/F_LBBP_S01' folder for project 'P_LBBP_S01'
And uploaded '/files/GWGTest2.pdf' file into '/F_LBBP_S01' folder for 'P_LBBP_S01' project
And waited while transcoding is finished in folder '/F_LBBP_S01' on project 'P_LBBP_S01' files page
When I go to file 'GWGTest2.pdf' info page in folder '/F_LBBP_S01' project 'P_LBBP_S01'
And click Edit link on file info page
Then I 'should' see following fields in the following order on opened Edit file popup:
| SectionName              | FieldName                   | FieldValue   |
| Product Info             | Advertiser                  |              |
| Product Info             | Brand                       |              |
| Product Info             | Sub Brand                   |              |
| Product Info             | Product                     |              |
| Product Info             | Campaign                    |              |
| Product Info             | Title                       | GWGTest2.pdf |
| Admin Information        | Country                     |              |
| Admin Information        | Market Sector               |              |
| Admin Information        | Media type                  | print        |
| Admin Information        | Media sub-type              |              |
| Search Criteria          | Category                    |              |
| Search Criteria          | Sub Category                |              |
| Search Criteria          | Genre                       |              |
| Search Criteria          | Description                 |              |
| Search Criteria          | Brief                       |              |
| Agency Information       | Advertising agency          |              |
| Agency Information       | Account Director            |              |
| Agency Information       | Account Manager             |              |
| Agency Information       | Agency Planner              |              |
| Agency Information       | Art Director                |              |
| Agency Information       | Artbuyer                    |              |
| Agency Information       | Chief Creative Officer      |              |
| Agency Information       | Creative Director           |              |
| Agency Information       | Copywriter                  |              |
| Agency Information       | Executive Creative Director |              |
| Agency Information       | Media Planner               |              |
| Agency Information       | Planner                     |              |
| Agency Information       | Strategist                  |              |
| Production Information   | Photographer                |              |
| Production Information   | Location/Studio             |              |
| Production Information   | Size Description            |              |
| Production Information   | Ad Height                   |              |
| Production Information   | Shoot Date                  |              |
| Production Information   | Ad Width                    |              |
| Studio Information       | Studio Name                 |              |
| Studio Information       | Retoucher                   |              |
| Media Agency Information | Media Agency                |              |
| Media Agency Information | Media Agency Planner        |              |
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
Given I created the agency 'A_SWICMD_S02' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_SWICMD_S02 | agency.admin | A_SWICMD_S02 |streamlined_library|
And logged in with details of 'U_SWICMD_S02'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName              | FieldName                   | FieldValue   |
| Product Info             | Advertiser                  |              |
| Product Info             | Brand                       |              |
| Product Info             | Sub Brand                   |              |
| Product Info             | Product                     |              |
| Product Info             | Campaign                    |              |
| Product Info             | Title                       | GWGTest2.pdf |
| Admin Information        | Country                     |              |
| Admin Information        | Market Sector               |              |
| Admin Information        | Media type                  | print        |
| Admin Information        | Media sub-type              |              |
| Search Criteria          | Category                    |              |
| Search Criteria          | Sub Category                |              |
| Search Criteria          | Genre                       |              |
| Search Criteria          | Description                 |              |
| Search Criteria          | Brief                       |              |
| Agency Information       | Advertising agency          |              |
| Agency Information       | Account Director            |              |
| Agency Information       | Account Manager             |              |
| Agency Information       | Agency Planner              |              |
| Agency Information       | Art Director                |              |
| Agency Information       | Artbuyer                    |              |
| Agency Information       | Chief Creative Officer      |              |
| Agency Information       | Creative Director           |              |
| Agency Information       | Copywriter                  |              |
| Agency Information       | Executive Creative Director |              |
| Agency Information       | Media Planner               |              |
| Agency Information       | Planner                     |              |
| Agency Information       | Strategist                  |              |
| Production Information   | Photographer                |              |
| Production Information   | Location/Studio             |              |
| Production Information   | Shoot Date                  |              |
| Studio Information       | Studio Name                 |              |
| Studio Information       | Retoucher                   |              |
| Media Agency Information | Media Agency                |              |
| Media Agency Information | Media Agency Planner        |              |
| Ad Description           | AD ID                       |              |
| Ad Description           | AD Material ID              |              |
| Ad Description           | Booking Number              |              |
| Ad Destination           | Publication Date            |              |
| Ad Destination           | Publication                 |              |
| Ad Destination           | Section                     |              |
| Ad Destination           | Publisher Name              |              |


Scenario: Check that specified data is displayed on view form of file
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMD_S03' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMD_S03':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMD_S03 | BR_SWICMD_S03 | SBR_SWICMD_S03 | PR_SWICMD_S03 |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_SWICMD_S03 | agency.admin | A_SWICMD_S03 |
And logged in with details of 'U_SWICMD_S03'
And created 'P_LBBP_S03' project
And created '/F_LBBP_S03' folder for project 'P_LBBP_S03'
And uploaded '/files/GWGTest2.pdf' file into '/F_LBBP_S03' folder for 'P_LBBP_S03' project
And waited while transcoding is finished in folder '/F_LBBP_S03' on project 'P_LBBP_S03' files page
When I go to file 'GWGTest2.pdf' info page in folder '/F_LBBP_S03' project 'P_LBBP_S03'
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S03                   |
| Product Info             | Brand                       | BR_SWICMD_S03                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S03                   |
| Product Info             | Product                     | PR_SWICMD_S03                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Admin Information        | Media sub-type              |                                  |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency Planner              | Test Agency Planner              |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Photographer                | Test Photographer                |
| Production Information   | Location/Studio             | Test Location/Studio             |
| Production Information   | Shoot Date                  | 12/12/2015                       |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID                       |
| Ad Description           | AD Material ID              | Test AD Material ID              |
| Ad Description           | Booking Number              | Test Booking Number              |
| Ad Destination           | Publication Date            | 12/12/2015                       |
| Ad Destination           | Publication                 | Test Publication                 |
| Ad Destination           | Section                     | Test Section                     |
| Ad Destination           | Publisher Name              | Test Publisher Name              |
| Production Agency        | Production Contact          | Test Production Contact          |
| Production Agency        | Production Email            | Test Production Email            |
| Production Agency        | Production Company          | Test Production Company          |
Then I 'should' see following 'custom metadata' fields in the following order on opened file info page:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S03                   |
| Product Info             | Brand                       | BR_SWICMD_S03                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S03                   |
| Product Info             | Product                     | PR_SWICMD_S03                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency Planner              | Test Agency Planner              |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Photographer                | Test Photographer                |
| Production Information   | Location/Studio             | Test Location/Studio             |
| Production Information   | Shoot Date                  | 12/12/2015                       |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID                       |
| Ad Description           | AD Material ID              | Test AD Material ID              |
| Ad Description           | Booking Number              | Test Booking Number              |
| Ad Destination           | Publication Date            | 12/12/15                         |
| Ad Destination           | Publication                 | Test Publication                 |
| Ad Destination           | Section                     | Test Section                     |
| Ad Destination           | Publisher Name              | Test Publisher Name              |
| Production Agency        | Production Contact          | Test Production Contact          |
| Production Agency        | Production Email            | Test Production Email            |
| Production Agency        | Production Company          | Test Production Company          |


Scenario: Check that specified data is displayed on view form of asset
Meta:@gdam
     @bug
     @library
!--UIR-1069
!--UIR-1095
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_SWICMD_S04' with default attributes
When I open role 'agency.admin' page with parent 'A_SWICMD_S04'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMD_S04_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMD_S04_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_SWICMD_S04'
And create following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMD_S04':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMD_S04 | BR_SWICMD_S04 | SBR_SWICMD_S04 | PR_SWICMD_S04 |
And create users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_SWICMD_S04 | A_SWICMD_S04_R1 | A_SWICMD_S04 |streamlined_library|
And login with details of 'U_SWICMD_S04'
And upload file '/files/GWGTest2.pdf' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
 |FieldName                   | FieldValue                       |
 |Advertiser                  | ADV_SWICMD_S04                   |
 |Brand                       | BR_SWICMD_S04                    |
 |Sub Brand                   | SBR_SWICMD_S04                   |
 |Product                     | PR_SWICMD_S04                    |
 |Campaign                    | Test Campaign                    |
 |Title                       | GWGTest2.pdf                     |
 | Country                     | Austria                          |
 | Category                    | Food                             |
 | Sub Category                | Meat and Fish                    |
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
 | AD ID                       | Test AD ID                       |
 | AD Material ID              | Test AD Material ID              |
 | Booking Number              | Test Booking Number              |
 | Publication Date            | 12/12/15                         |
 | Publication                 | Test Publication                 |
 | Section                     | Test Section                     |
 | Publisher Name              | Test Publisher Name              |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
 | FieldName                   | FieldValue                       |
 |Advertiser                  | ADV_SWICMD_S04                   |
 |Brand                       | BR_SWICMD_S04                    |
 |Sub Brand                   | SBR_SWICMD_S04                   |
 |Product                     | PR_SWICMD_S04                    |
 |Campaign                    | Test Campaign                    |
 |Title                       | GWGTest2.pdf                     |
 | Country                     | Austria                          |
 | Category                    | Food                             |
 | Sub Category                | Meat and Fish                    |
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
| AD ID                       | Test AD ID                       |
| AD Material ID              | Test AD Material ID              |
| Booking Number              | Test Booking Number              |
| Publication Date            | 12/12/2015                         |
| Publication                 | Test Publication                 |
| Section                     | Test Section                     |
| Publisher Name              | Test Publisher Name              |

Scenario: Check that specified data is displayed on edit form of file
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMD_S05' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMD_S05':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMD_S05 | BR_SWICMD_S05 | SBR_SWICMD_S05 | PR_SWICMD_S05 |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_SWICMD_S05 | agency.admin | A_SWICMD_S05 |
And logged in with details of 'U_SWICMD_S05'
And created 'P_LBBP_S05' project
And created '/F_LBBP_S05' folder for project 'P_LBBP_S05'
And uploaded '/files/GWGTest2.pdf' file into '/F_LBBP_S05' folder for 'P_LBBP_S05' project
And waited while transcoding is finished in folder '/F_LBBP_S05' on project 'P_LBBP_S05' files page
When I go to file 'GWGTest2.pdf' info page in folder '/F_LBBP_S05' project 'P_LBBP_S05'
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S05                   |
| Product Info             | Brand                       | BR_SWICMD_S05                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S05                   |
| Product Info             | Product                     | PR_SWICMD_S05                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Admin Information        | Media sub-type              |                                  |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency Planner              | Test Agency Planner              |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Photographer                | Test Photographer                |
| Production Information   | Location/Studio             | Test Location/Studio             |
| Production Information   | Size Description            | Test Size Description            |
| Production Information   | Ad Height                   | Test Ad Height                   |
| Production Information   | Shoot Date                  | 12/12/2015                       |
| Production Information   | Ad Width                    | Test Ad Width                    |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID                       |
| Ad Description           | AD Material ID              | Test AD Material ID              |
| Ad Description           | Booking Number              | Test Booking Number              |
| Ad Destination           | Publication Date            | 12/12/2015                       |
| Ad Destination           | Publication                 | Test Publication                 |
| Ad Destination           | Section                     | Test Section                     |
| Ad Destination           | Publisher Name              | Test Publisher Name              |
| Production Agency        | Production Contact          | Test Production Contact          |
| Production Agency        | Production Email            | Test Production Email            |
| Production Agency        | Production Company          | Test Production Company          |
And click Edit link on file info page
Then I 'should' see following fields in the following order on opened Edit file popup:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S05                   |
| Product Info             | Brand                       | BR_SWICMD_S05                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S05                   |
| Product Info             | Product                     | PR_SWICMD_S05                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Admin Information        | Media sub-type              |                                  |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency Planner              | Test Agency Planner              |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Photographer                | Test Photographer                |
| Production Information   | Location/Studio             | Test Location/Studio             |
| Production Information   | Size Description            | Test Size Description            |
| Production Information   | Ad Height                   | Test Ad Height                   |
| Production Information   | Shoot Date                  | 12/12/2015                       |
| Production Information   | Ad Width                    | Test Ad Width                    |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID                       |
| Ad Description           | AD Material ID              | Test AD Material ID              |
| Ad Description           | Booking Number              | Test Booking Number              |
| Ad Destination           | Publication Date            | 12/12/2015                       |
| Ad Destination           | Publication                 | Test Publication                 |
| Ad Destination           | Section                     | Test Section                     |
| Ad Destination           | Publisher Name              | Test Publisher Name              |
| Production Agency        | Production Contact          | Test Production Contact          |
| Production Agency        | Production Email            | Test Production Email            |
| Production Agency        | Production Company          | Test Production Company          |


Scenario: Check that specified data is displayed on edit form of asset
Meta: @library
     @gdam
     @bug
!--UIR-1095
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_SWICMD_S06' with default attributes
When I open role 'agency.admin' page with parent 'A_SWICMD_S06'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMD_S06_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMD_S06_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_SWICMD_S06'
And create following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMD_S06':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMD_S06 | BR_SWICMD_S06 | SBR_SWICMD_S06 | PR_SWICMD_S06 |
And create users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_SWICMD_S06 | A_SWICMD_S06_R1 | A_SWICMD_S06 |streamlined_library|
And login with details of 'U_SWICMD_S06'
And upload file '/files/GWGTest2.pdf' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | ADV_SWICMD_S06                   |
| Brand                       | BR_SWICMD_S06                    |
| Sub Brand                   | SBR_SWICMD_S06                   |
| Product                     | PR_SWICMD_S06                    |
| Campaign                    | Test Campaign                    |
| Title                       | GWGTest2.pdf                     |
| Country                     | Austria                          |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Market Sector               | Test Market Sector               |
| Media sub-type              | Other                            |
| Description                 | Test Description                 |
| Brief                       | Test Brief                       |
| Advertising agency          | Test Advertising agency          |
| Account Director            | Test Account Director            |
| Account Manager             | Test Account Manager             |
| Agency Planner              | Test Agency Planner              |
| Art Director                | Test Art Director                |
| Artbuyer                    | Test Artbuyer                    |
| Chief Creative Officer      | Test Chief Creative Officer      |
| Creative Director           | Test Creative Director           |
| Copywriter                  | Test Copywriter                  |
| Executive Creative Director | Test Executive Creative Director |
| Media Planner               | Test Media Planner               |
| Planner                     | Test Planner                     |
| Strategist                  | Test Strategist                  |
| Photographer                | Test Photographer                |
| Location/Studio             | Test Location/Studio             |
| Shoot Date                  | 12/12/15                       |
| Studio Name                 | Test Studio Name                 |
| Retoucher                   | Test Retoucher                   |
| Media Agency                | Test Media Agency                |
| Media Agency Planner        | Test Media Agency Planner        |
| AD ID                       | Test AD ID                       |
| AD Material ID              | Test AD Material ID              |
| Booking Number              | Test Booking Number              |
| Publication Date            | 12/12/15                       |
| Publication                 | Test Publication                 |
| Section                     | Test Section                     |
| Publisher Name              | Test Publisher Name              |
And I refresh the page
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S06                   |
| Product Info             | Brand                       | BR_SWICMD_S06                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S06                   |
| Product Info             | Product                     | PR_SWICMD_S06                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Admin Information        | Media sub-type              |Other                             |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
|Search Criteria           | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency Planner              | Test Agency Planner              |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Photographer                | Test Photographer                |
| Production Information   | Location/Studio             | Test Location/Studio             |
| Production Information   | Shoot Date                  | 12/12/15                       |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID                       |
| Ad Description           | AD Material ID              | Test AD Material ID              |
| Ad Description           | Booking Number              | Test Booking Number              |
| Ad Destination           | Publication Date            | 12/12/2015                       |
| Ad Destination           | Publication                 | Test Publication                 |
| Ad Destination           | Section                     | Test Section                     |
| Ad Destination           | Publisher Name              | Test Publisher Name              |

Scenario: Check that file's data entered before can be updated on view form
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMD_S07' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMD_S07':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMD_S07 | BR_SWICMD_S07 | SBR_SWICMD_S07 | PR_SWICMD_S07 |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_SWICMD_S07 | agency.admin | A_SWICMD_S07 |
And logged in with details of 'U_SWICMD_S07'
And created 'P_LBBP_S07' project
And created '/F_LBBP_S07' folder for project 'P_LBBP_S07'
And uploaded '/files/GWGTest2.pdf' file into '/F_LBBP_S07' folder for 'P_LBBP_S07' project
And waited while transcoding is finished in folder '/F_LBBP_S07' on project 'P_LBBP_S07' files page
When I go to file 'GWGTest2.pdf' info page in folder '/F_LBBP_S07' project 'P_LBBP_S07'
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S07                   |
| Product Info             | Brand                       | BR_SWICMD_S07                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S07                   |
| Product Info             | Product                     | PR_SWICMD_S07                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Admin Information        | Media sub-type              |                                  |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Tttt Description                 |
| Search Criteria          | Brief                       | Tttt Brief                       |
| Agency Information       | Advertising agency          | Tttt Advertising agency          |
| Agency Information       | Account Director            | Tttt Account Director            |
| Agency Information       | Account Manager             | Tttt Account Manager             |
| Agency Information       | Agency Planner              | Tttt Agency Planner              |
| Agency Information       | Art Director                | Tttt Art Director                |
| Agency Information       | Artbuyer                    | Tttt Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Tttt Chief Creative Officer      |
| Agency Information       | Creative Director           | Tttt Creative Director           |
| Agency Information       | Copywriter                  | Tttt Copywriter                  |
| Agency Information       | Executive Creative Director | Tttt Executive Creative Director |
| Agency Information       | Media Planner               | Tttt Media Planner               |
| Agency Information       | Planner                     | Tttt Planner                     |
| Agency Information       | Strategist                  | Tttt Strategist                  |
| Production Information   | Photographer                | Tttt Photographer                |
| Production Information   | Location/Studio             | Tttt Location/Studio             |
| Production Information   | Shoot Date                  | 12/12/2021                       |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID                       |
| Ad Description           | AD Material ID              | Test AD Material ID              |
| Ad Description           | Booking Number              | Test Booking Number              |
| Ad Destination           | Publication Date            | 12/12/2015                       |
| Ad Destination           | Publication                 | Test Publication                 |
| Ad Destination           | Section                     | Test Section                     |
| Ad Destination           | Publisher Name              | Test Publisher Name              |
| Production Agency        | Production Contact          | Test Production Contact          |
| Production Agency        | Production Email            | Test Production Email            |
| Production Agency        | Production Company          | Test Production Company          |
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S07                   |
| Product Info             | Brand                       | BR_SWICMD_S07                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S07                   |
| Product Info             | Product                     | PR_SWICMD_S07                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Admin Information        | Media sub-type              |                                  |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency Planner              | Test Agency Planner              |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Photographer                | Test Photographer                |
| Production Information   | Location/Studio             | Test Location/Studio             |
| Production Information   | Shoot Date                  | 12/12/2015                       |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
Then I 'should' see following 'custom metadata' fields in the following order on opened file info page:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S07                   |
| Product Info             | Brand                       | BR_SWICMD_S07                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S07                   |
| Product Info             | Product                     | PR_SWICMD_S07                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency Planner              | Test Agency Planner              |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Photographer                | Test Photographer                |
| Production Information   | Location/Studio             | Test Location/Studio             |
| Production Information   | Shoot Date                  | 12/12/2015                       |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID                       |
| Ad Description           | AD Material ID              | Test AD Material ID              |
| Ad Description           | Booking Number              | Test Booking Number              |
| Ad Destination           | Publication Date            | 12/12/15                         |
| Ad Destination           | Publication                 | Test Publication                 |
| Ad Destination           | Section                     | Test Section                     |
| Ad Destination           | Publisher Name              | Test Publisher Name              |
| Production Agency        | Production Contact          | Test Production Contact          |
| Production Agency        | Production Email            | Test Production Email            |
| Production Agency        | Production Company          | Test Production Company          |


Scenario: Check that file's data entered before can be updated on edit form
Meta:@projects
     @gdam
Given I created the agency 'A_SWICMD_S08' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMD_S08':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMD_S08 | BR_SWICMD_S08 | SBR_SWICMD_S08 | PR_SWICMD_S08 |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_SWICMD_S08 | agency.admin | A_SWICMD_S08 |
And logged in with details of 'U_SWICMD_S08'
And created 'P_LBBP_S08' project
And created '/F_LBBP_S08' folder for project 'P_LBBP_S08'
And uploaded '/files/GWGTest2.pdf' file into '/F_LBBP_S08' folder for 'P_LBBP_S08' project
And waited while transcoding is finished in folder '/F_LBBP_S08' on project 'P_LBBP_S08' files page
When I go to file 'GWGTest2.pdf' info page in folder '/F_LBBP_S08' project 'P_LBBP_S08'
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S08                   |
| Product Info             | Brand                       | BR_SWICMD_S08                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S08                   |
| Product Info             | Product                     | PR_SWICMD_S08                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Admin Information        | Media sub-type              |                                  |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Tttt Description                 |
| Search Criteria          | Brief                       | Tttt Brief                       |
| Agency Information       | Advertising agency          | Tttt Advertising agency          |
| Agency Information       | Account Director            | Tttt Account Director            |
| Agency Information       | Account Manager             | Tttt Account Manager             |
| Agency Information       | Agency Planner              | Tttt Agency Planner              |
| Agency Information       | Art Director                | Tttt Art Director                |
| Agency Information       | Artbuyer                    | Tttt Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Tttt Chief Creative Officer      |
| Agency Information       | Creative Director           | Tttt Creative Director           |
| Agency Information       | Copywriter                  | Tttt Copywriter                  |
| Agency Information       | Executive Creative Director | Tttt Executive Creative Director |
| Agency Information       | Media Planner               | Tttt Media Planner               |
| Agency Information       | Planner                     | Tttt Planner                     |
| Agency Information       | Strategist                  | Tttt Strategist                  |
| Production Information   | Photographer                | Tttt Photographer                |
| Production Information   | Location/Studio             | Tttt Location/Studio             |
| Production Information   | Shoot Date                  | 12/12/2021                       |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID                       |
| Ad Description           | AD Material ID              | Test AD Material ID              |
| Ad Description           | Booking Number              | Test Booking Number              |
| Ad Destination           | Publication Date            | 12/12/2015                       |
| Ad Destination           | Publication                 | Test Publication                 |
| Ad Destination           | Section                     | Test Section                     |
| Ad Destination           | Publisher Name              | Test Publisher Name              |
| Production Agency        | Production Contact          | Test Production Contact          |
| Production Agency        | Production Email            | Test Production Email            |
| Production Agency        | Production Company          | Test Production Company          |
And 'save' file info by next information:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S08                   |
| Product Info             | Brand                       | BR_SWICMD_S08                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S08                   |
| Product Info             | Product                     | PR_SWICMD_S08                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Admin Information        | Media sub-type              |                                  |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency Planner              | Test Agency Planner              |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Photographer                | Test Photographer                |
| Production Information   | Location/Studio             | Test Location/Studio             |
| Production Information   | Size Description            | Test Size Description            |
| Production Information   | Ad Height                   | Test Ad Height                   |
| Production Information   | Shoot Date                  | 12/12/2015                       |
| Production Information   | Ad Width                    | Test Ad Width                    |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID updated               |
| Ad Description           | AD Material ID              | Test AD Material ID updated      |
| Ad Description           | Booking Number              | Test Booking Number updated      |
| Ad Destination           | Publication Date            | 10/12/2019                       |
| Ad Destination           | Publication                 | Test Publication updated         |
| Ad Destination           | Section                     | Test Section updated             |
| Ad Destination           | Publisher Name              | Test Publisher Name updated      |
| Production Agency        | Production Contact          | Test Production Contact updated  |
| Production Agency        | Production Email            | Test Production Email updated    |
| Production Agency        | Production Company          | Test Production Company updated  |
And click Edit link on file info page
Then I 'should' see following fields in the following order on opened Edit file popup:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S08                   |
| Product Info             | Brand                       | BR_SWICMD_S08                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S08                   |
| Product Info             | Product                     | PR_SWICMD_S08                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media type                  | print                            |
| Admin Information        | Media sub-type              |                                  |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Genre                       | Comedy                           |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Advertising agency          | Test Advertising agency          |
| Agency Information       | Account Director            | Test Account Director            |
| Agency Information       | Account Manager             | Test Account Manager             |
| Agency Information       | Agency Planner              | Test Agency Planner              |
| Agency Information       | Art Director                | Test Art Director                |
| Agency Information       | Artbuyer                    | Test Artbuyer                    |
| Agency Information       | Chief Creative Officer      | Test Chief Creative Officer      |
| Agency Information       | Creative Director           | Test Creative Director           |
| Agency Information       | Copywriter                  | Test Copywriter                  |
| Agency Information       | Executive Creative Director | Test Executive Creative Director |
| Agency Information       | Media Planner               | Test Media Planner               |
| Agency Information       | Planner                     | Test Planner                     |
| Agency Information       | Strategist                  | Test Strategist                  |
| Production Information   | Photographer                | Test Photographer                |
| Production Information   | Location/Studio             | Test Location/Studio             |
| Production Information   | Size Description            | Test Size Description            |
| Production Information   | Ad Height                   | Test Ad Height                   |
| Production Information   | Shoot Date                  | 12/12/2015                       |
| Production Information   | Ad Width                    | Test Ad Width                    |
| Studio Information       | Studio Name                 | Test Studio Name                 |
| Studio Information       | Retoucher                   | Test Retoucher                   |
| Media Agency Information | Media Agency                | Test Media Agency                |
| Media Agency Information | Media Agency Planner        | Test Media Agency Planner        |
| Ad Description           | AD ID                       | Test AD ID updated               |
| Ad Description           | AD Material ID              | Test AD Material ID updated      |
| Ad Description           | Booking Number              | Test Booking Number updated      |
| Ad Destination           | Publication Date            | 10/12/2019                       |
| Ad Destination           | Publication                 | Test Publication updated         |
| Ad Destination           | Section                     | Test Section updated             |
| Ad Destination           | Publisher Name              | Test Publisher Name updated      |
| Production Agency        | Production Contact          | Test Production Contact updated  |
| Production Agency        | Production Email            | Test Production Email updated    |
| Production Agency        | Production Company          | Test Production Company updated  |


Scenario: Check that asset's data entered before can be updated on edit form
Meta:@library
     @gdam
!--This scenario might fail randomly due to long expansion of section on asset edit form on FF we are using..need to update FF
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_SWICMD_S10' with default attributes
When I open role 'agency.admin' page with parent 'A_SWICMD_S10'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMD_S10_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMD_S10_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_SWICMD_S10'
And create following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SWICMD_S10':
| Advertiser     | Brand         | Sub Brand      | Product       |
| ADV_SWICMD_S10 | BR_SWICMD_S10 | SBR_SWICMD_S10 | PR_SWICMD_S10 |
And create users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_SWICMD_S10 | A_SWICMD_S10_R1 | A_SWICMD_S10 |streamlined_library|
And login with details of 'U_SWICMD_S10'
And upload file '/files/GWGTest2.pdf' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | ADV_SWICMD_S10                   |
| Brand                       | BR_SWICMD_S10                   |
| Sub Brand                   | SBR_SWICMD_S10                  |
| Product                     | PR_SWICMD_S10                   |
| Campaign                    | Tttt Campaign                    |
| Title                       | GWGTest2.pdf                     |
| Country                     | Austria                          |
| Market Sector               | Tttt Market Sector               |
| Media sub-type              | Other                            |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Description                 | Tttt Description                 |
| Brief                       | Tttt Brief                       |
| Account Director            | Tttt Account Director            |
| Account Manager             | Tttt Account Manager             |
| Agency Planner              | Tttt Agency Planner              |
| Art Director                | Tttt Art Director                |
And I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
 |FieldName                   | FieldValue                       |
 |Advertiser                  | ADV_SWICMD_S10                   |
  |Brand                       | BR_SWICMD_S10                    |
  |Sub Brand                   | SBR_SWICMD_S10                  |
  |Product                     | PR_SWICMD_S10                   |
  |Campaign                    | Test Campaign                    |
  |Title                       | GWGTest2.pdf                     |
  |Country                     | Austria                          |
  |Market Sector               | Test Market Sector               |
  |Media sub-type              | Newspaper                        |
  |Category                    | Food                             |
  |Sub Category                | Meat and Fish                    |
  |Description                 | Test Description                 |
  |Brief                       | Test Brief                       |
  |Account Director            | Test Account Director            |
  |Account Manager             | Test Account Manager             |
  |Agency Planner              | Test Agency Planner              |
  |Art Director                | Test Art Director                |
And I refresh the page
And click Edit link on asset info pageNEWLIB
Then I 'should' see following 'metadata' fields with value on edit asset popup NEWLIB:
| SectionName              | FieldName                   | FieldValue                       |
| Product Info             | Advertiser                  | ADV_SWICMD_S10                   |
| Product Info             | Brand                       | BR_SWICMD_S10                    |
| Product Info             | Sub Brand                   | SBR_SWICMD_S10                   |
| Product Info             | Product                     | PR_SWICMD_S10                    |
| Product Info             | Campaign                    | Test Campaign                    |
| Product Info             | Title                       | GWGTest2.pdf                     |
| Admin Information        | Country                     | Austria                          |
| Admin Information        | Market Sector               | Test Market Sector               |
| Admin Information        | Media sub-type              | Newspaper                                 |
| Search Criteria          | Category                    | Food                             |
| Search Criteria          | Sub Category                | Meat and Fish                    |
| Search Criteria          | Description                 | Test Description                 |
| Search Criteria          | Brief                       | Test Brief                       |
| Agency Information       | Account Director            | Tttt Account Director,Test Account Director            |
| Agency Information       | Account Manager             | Tttt Account Manager,Test Account Manager             |
| Agency Information       | Agency Planner              | Tttt Agency Planner,Test Agency Planner              |
| Agency Information       | Art Director                | Tttt Art Director,Test Art Director                |


Scenario: Check that entered values into dropdowns/catalogues can be used next time and correctly showed for print assets
Meta:@library
     @gdam
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_SWICMD_S11' with default attributes
When I open role 'agency.admin' page with parent 'A_SWICMD_S11'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'A_SWICMD_S11_R1'
And I click element 'SaveButton' on page 'Roles'
And update role 'A_SWICMD_S11_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions for advertiser 'A_SWICMD_S11'
And update following 'common' custom metadata fields for agency 'A_SWICMD_S11':
| FieldType          | Description | Parent     | AddOnFly |
| catalogueStructure | Advertiser  |            | true     |
| catalogueStructure | Brand       | Advertiser | true     |
| catalogueStructure | Sub Brand   | Brand      | true     |
| catalogueStructure | Product     | Sub Brand  | true     |
And create users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_SWICMD_S11 | A_SWICMD_S11_R1 | A_SWICMD_S11 |streamlined_library|
And login with details of 'U_SWICMD_S11'
And upload file '/files/GWGTest2.pdf' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | NewAdvertiser |
| Brand      | NewBrand      |
| Sub Brand  | NewSubBrand   |
| Product    | NewProduct    |
And upload file '/files/GWGTestfile064v3.pdf' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'GWGTestfile064v3.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | NewAdvertiser |
| Brand      | NewBrand      |
| Sub Brand  | NewSubBrand   |
| Product    | NewProduct    |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
 |FieldName   | FieldValue    |
 | Advertiser | NewAdvertiser |
 | Brand      | NewBrand      |
 | Sub Brand  | NewSubBrand   |
 | Product    | NewProduct    |
