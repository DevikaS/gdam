!--NGN-7053
Feature:          Custom metadata - Simple search
Narrative:        QA internal task
In order to
As a              GlobalAdmin
I want to         check global search by custom metadata

Scenario: Check projects/templates search by custom String (Campaign)
Meta:@projects
     @gdam
Given I created the agency 'A_CMSS_S01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSS_S01 | agency.admin | A_CMSS_S01   |
And logged in with details of 'U_CMSS_S01'
And created new project with following fields:
| FieldName  | FieldValue        |
| Name       | <ProjectName>     |
| Media type | Broadcast         |
| Advertiser | Little Black Book |
| Brand      | LBB Brand         |
| Sub Brand  | LBB Sub Brand     |
| Product    | LBB Product       |
| Campaign   | <CampaignName>    |
| Start date | Today             |
| End date   | Tomorrow          |
When I go to Dashboard page
And search by text '<SearchQyery>'
And click show all link for global user search for object 'Projects / Work Requests'
Then I 'should' see following projects on the project search page '<SearchResult>'

Examples:
| ProjectName  | CampaignName | SearchQyery | SearchResult |
| P_CMSS_S01_1 | DBook        | DBook       | P_CMSS_S01_1 |
| P_CMSS_S01_2 | E-Book       | E-Book      | P_CMSS_S01_2 |
| P_CMSS_S01_3 | F_Book       | F_Book      | P_CMSS_S01_3 |




Scenario: Check video Assets search by Description (Multiline)
Meta:@projects
     @gdam
Given I created the agency 'A_CMSS_S03' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSS_S03 | agency.admin | A_CMSS_S03   |
And logged in with details of 'U_CMSS_S03'
And created 'P_CMSS_S03' project
And created '/F_CMSS_S03' folder for project 'P_CMSS_S03'
And uploaded into project 'P_CMSS_S03' following files:
| FileName                   | Path        |
| /files/correct.avi         | /F_CMSS_S03 |
| /files/13DV-CAPITAL-10.mpg | /F_CMSS_S03 |
And waited while transcoding is finished in folder '/F_CMSS_S03' on project 'P_CMSS_S03' files page
When I go to file '<FileName>' info page in folder '/F_CMSS_S03' project 'P_CMSS_S03'
And 'save' file info by next information:
| FieldName    | FieldValue        |
| Description  | <FileDescription> |
| Clock number | testcn            |
When I go to Dashboard page
And search by text '<SearchQyery>'
And click show all link for global user search for object 'Files & Folders'
Then I '<Condition>' see following files & folders on the search page '<SearchResult>' for object 'File'

Examples:
| FileName            | FileDescription | SearchQyery | SearchResult        | Condition  |
| correct.avi         | Des_bot2        | Des         | correct.avi         | should     |
| 13DV-CAPITAL-10.mpg | worMoouu        | worMoouu    | 13DV-CAPITAL-10.mpg | should     |


Scenario: Check video Assets search empty result by Description (Multiline)
Meta:@projects
     @gdam
Given I created the agency 'A_CMSS_S04' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSS_S04 | agency.admin | A_CMSS_S04   |
And logged in with details of 'U_CMSS_S04'
When I go to Dashboard page
And search by text 'Moo'
Then I 'should not' see search object '13DV-CAPITAL-10.mpg' with type 'File' after wrap according to search 'Moo' with 'Name' type
And 'should not' see show all results link on quick search menu



Scenario: Check video Assets search by CMM in Library
Meta:@gdam
@bug
@library
!--UIR-1069
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_CMSS_S05' with default attributes
And I opened role 'agency.admin' page with parent 'A_CMSS_S05'
And I clicked element 'CopyButton' on page 'Roles'
And I changed role name to 'A_CMSS_S05_R1'
And I clicked element 'SaveButton' on page 'Roles'
And update role 'A_CMSS_S05_R1' role by following 'dictionary.add_on_the_fly,asset.create,asset.write,asset_filter_collection.create,asset_filter_category.create,inbox.read,asset.share' permissions for advertiser 'A_CMSS_S05'
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| U_CMSS_S05 | A_CMSS_S05_R1 | A_CMSS_S05   |streamlined_library,dashboard|
And logged in with details of 'U_CMSS_S05'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I 'save' asset 'Fish Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName                   | FieldValue                       |
| Category                    | <Category>                             |
| Country                     | <Country>                          |
| Producer                    | <Producer>                    |
| Clock number                | TestClk1          |
And I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName                   | FieldValue                       |
| Category                    | <Category>                              |
| Country                     | <Country>                           |
| Producer                    | <Producer>                    |
| Clock number                | TestClk2          |
And go to Dashboard page
And search by text '<SearchQyery>'
And click show all link for global user search for object 'Assets'
And wait for '5' seconds
Then I 'should' see assets 'Fish Ad.mov,Fish1-Ad.mov' on the library search results pageNEWLIB

Examples:
| SearchQyery      |Category|Country|Producer|
| Test Producer    |Food|Albania|Test producer|
| Austria          |Home|Austria|Producer|


