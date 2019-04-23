!--FAB-197
Feature:          Strict Search
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Strict Search


Scenario: Check projects strict search (Project name)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I created following projects:
| Name       |
| Prj_StrictSearch_S04_2   |
| Prj_StrictSearch_S04_22   |
| Prj_StrictSearch_S04_222 |
And created '/F_StrictSearch_S04_222' folder for project 'Prj_StrictSearch_S04_2'
And created '/F_StrictSearch_S04_222' folder for project 'Prj_StrictSearch_S04_22'
And created '/F_StrictSearch_S04_222' folder for project 'Prj_StrictSearch_S04_222'
When I 'check' match all words for strict search
And I search by text with test session 'Prj StrictSearch S04 222'
Then I 'should' see search object 'Prj_StrictSearch_S04_222' with type 'Project' after wrap according to search 'Prj StrictSearch S04 222' with 'Name' type
And I 'should not' see items 'F_StrictSearch_S04_222' of type 'Files & Folders' in global search result
And I 'should not' see items 'Prj_StrictSearch_S04_2,Prj_StrictSearch_S04_22' of type 'Project' in global search result
When I click show all link for global user search
Then I 'should' see following projects on the project search page 'Prj_StrictSearch_S04_222'
And 'should not' see following projects on the project search page 'Prj_StrictSearch_S04_2,Prj_StrictSearch_S04_22'


Scenario: Check 'show all' projects strict search results
Meta:@gdam
@projects
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      |
| ASR SS S05 | FBR SS S05 |
| ASR SS S05 | SBR SS S05 |
And logged in with details of '<UserEmail>'
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_SS_S05_1 |
| Media type | Broadcast  |
| Advertiser | ASR SS S05 |
| Brand      | FBR SS S05 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_SS_S05_2 |
| Media type | Broadcast  |
| Advertiser | ASR SS S05 |
| Brand      | SBR SS S05 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       |P_SS_S05_3 |
| Media type | Broadcast  |
| Advertiser | ASR SS S05 |
| Brand      | FBR SS S05 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/F_SS_S05' folder for project 'P_SS_S05_1'
And created '/F_SS_S05' folder for project 'P_SS_S05_2'
And created '/F_SS_S05' folder for project 'P_SS_S05_3'
When I 'check' match all words for strict search
And I search by text with test session '<SearchQuery>'
Then should see next count '<Count>' found items
When I click show all link for global user search
Then I 'should' see following projects on the project search page '<SearchResult>'

Examples:
| Agency     | UserEmail  | SearchQuery | Count |SearchResult                     |
| A_SS_S05_1 | U_SS_S05_1 | asr ss s05  | 3     |P_SS_S05_1,P_SS_S05_2,P_SS_S05_3 |
| A_GS_S05_3 | U_GS_S05_3 | sbr ss s05  | 1     |P_SS_S05_2                       |


Scenario: Check 'show all' user search results
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName  | Email      |
| Kenny     | Starsh | U_SS_S03_1 |
| Karen     | Starsh | U_SS_S03_2 |
| Kevin     | Starsh | U_SS_S03_3 |
And I added following users to address book:
| UserName   |
| U_SS_S03_1 |
| U_SS_S03_2 |
| U_SS_S03_3 |
And refreshed the page
When I 'check' match all words for strict search
And I search by text 'Karen Starsh'
Then I 'should' see search object 'Karen Starsh'
And should see next count '1' found items
When I click show all link for global user search
Then I should see address book page with next users 'Karen Starsh'


Scenario: Check user strict search by email (smoke)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I created users with following fields:
| FirstName | LastName  | Email       |
| Rebecca   | Hannoy    | U_GZS_S02_1 |
| Henry     | Hannoy    | U_GZS_S02_2 |
| Rebecca   | Kallala   | U_GZS_S02_3 |
| Randy     | Hannoy    | U_GZS_S02_4 |
And added following users to address book:
| UserName    |
| U_GZS_S02_1 |
When I 'check' match all words for strict search
And I search by email 'U_GZS_S02_1'
And wait for '4' seconds
Then I 'should' see search object 'Rebecca Hannoy'
And should see next count '1' found items
And 'should' see show all results link on quick search menu
When I click show all link for global user search
Then I should see address book page with next users 'Rebecca Hannoy'


Scenario: Check Files & Folders strict search
Meta:@gdam
@projects
Given I created the agency 'A_SS_S08_2' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_SS_S08_2 | agency.admin  | A_SS_S08_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_SS_S08_2':
| Advertiser | Brand      |
| ASR SS S08 | FBR SS S08 |
| ASR SS S08 | SBR SS S08 |
And logged in with details of 'U_SS_S08_2'
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_SS_S08_1 |
| Media type | Broadcast  |
| Advertiser | ASR SS S08 |
| Brand      | FBR SS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_SS_S08_2 |
| Media type | Broadcast  |
| Advertiser | ASR SS S08 |
| Brand      | SBR SS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_SS_S08_3 |
| Media type | Broadcast  |
| Advertiser | ASR SS S08 |
| Brand      | FBR SS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/Fish_SS_S08_1' folder for project 'P_SS_S08_1'
And created '/Fish_SS_S08_2' folder for project 'P_SS_S08_2'
And created '/Fish_SS_S08_3' folder for project 'P_SS_S08_3'
And uploaded into project 'P_SS_S08_1' following files:
| FileName           | Path       |
| /files/file_1.avi  | Fish_SS_S08_1 |
| /files/index.html  | Fish_SS_S08_1 |
| /files/Fish-Ad.mov | Fish_SS_S08_1 |
And uploaded into project 'P_SS_S08_2' following files:
| FileName             | Path       |
| /files/Fish-AdTests.mov| Fish_SS_S08_2 |
| /files/Fish2-Ad.mov  | Fish_SS_S08_2 |
And uploaded into project 'P_SS_S08_3' following files:
| FileName            | Path       |
| /files/fi3le.avi    | Fish_SS_S08_3 |
| /files/Fish-Ad.mov  | Fish_SS_S08_3 |
| /files/file_1.avi   | Fish_SS_S08_3 |
| /files/Fish-Ad.mov  | Fish_SS_S08_3 |
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_SS_S08_1 |
| Media type | Broadcast  |
| Advertiser | ASR SS S08 |
| Brand      | FBR SS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_SS_S08_2 |
| Media type | Broadcast  |
| Advertiser | ASR SS S08 |
| Brand      | SBR SS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_SS_S08_3 |
| Media type | Broadcast  |
| Advertiser | ASR SS S08 |
| Brand      | FBR SS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/Fish_SS_S08_1' folder for template 'T_SS_S08_1'
And created '/Fish_SS_S08_2' folder for template 'T_SS_S08_2'
And created '/Fish_SS_S08_3' folder for template 'T_SS_S08_3'
And I uploaded into template 'T_SS_S08_1' following files:
| FileName           | Path       |
| /files/file_1.avi  | Fish_SS_S08_1 |
| /files/index.html  | Fish_SS_S08_1 |
| /files/Fish-Ad.mov | Fish_SS_S08_1 |
And I uploaded into template 'T_SS_S08_2' following files:
| FileName             | Path       |
| /files/file_2.avi    | Fish_SS_S08_2 |
| /files/Fish2-Ad.mov  | Fish_SS_S08_2 |
And I uploaded into template 'T_SS_S08_3' following files:
| FileName            | Path       |
| /files/fi3le.avi    | Fish_SS_S08_3 |
| /files/Fish-Ad.mov  | Fish_SS_S08_3 |
| /files/file_1.avi   | Fish_SS_S08_3 |
| /files/Fish-AdTests.mov | Fish_SS_S08_3 |
When I 'check' match all words for strict search
And I search by text 'Fish-Ad.mov'
Then I 'should' see search object 'Fish-Ad.mov' with type 'Files & Folders' after wrap according to search 'Fish-Ad.mov' with 'Name' type
And should see next count '3' found items
When I click show all link for global user search for object 'Files & Folders'
Then I 'should' see following files & folders on the search page 'Fish-Ad.mov' for object 'Name'


Scenario: Check that results not included in 'myassets' collection are showed in all strict search results
Meta:@gdam
@library
Given I created the agency 'A_SS_S11' with default attributes
And created users with following fields:
| Email      | Access                                | Role         | AgencyUnique |
| U_SS_S11_1 | dashboard,folders,streamlined_library | agency.admin | A_SS_S11     |
| U_SS_S11_2 | dashboard,folders,streamlined_library | agency.user  | A_SS_S11     |
And logged in with details of 'U_SS_S11_1'
And created 'LR_SS_S11' role in 'library' group for advertiser 'A_SS_S11'
And I created following categories:
| Name     | MediaType |
| fazan    | image     |
| sezan    | audio     |
| debazan  | video     |
| kurtizan | digital   |
And I uploaded following assetsNEWLIB:
| Name                      |
| /images/admin.logo.jpg    |
| /images/big.logo.png      |
| /images/branding_logo.png |
| /images/empty.logo.png    |
And waited while preview is visible on library page for collection 'My Assets' for assets 'admin.logo.jpg,big.logo.png,branding_logo.png,empty.logo.png'NEWLIB
And I added next users for following categories:
| CategoryName | UserName   | RoleName  |
| fazan        | U_SS_S11_2 | LR_SS_S11 |
| sezan        | U_SS_S11_2 | LR_SS_S11 |
| debazan      | U_SS_S11_2 | LR_SS_S11 |
| kurtizan     | U_SS_S11_2 | LR_SS_S11 |
And logged in with details of 'U_SS_S11_2'
And uploaded following assetsNEWLIB:
| Name                           |
| /images/empty.project.logo.png |
| /images/logo.bmp               |
| /images/logo.gif               |
| /images/logo.jpeg              |
| /images/logo.jpg               |
| /images/logo.png               |
And waited for '5' seconds
And waited while preview is visible on library page for collection 'My Assets' for assets 'empty.project.logo.png,logo.bmp,logo.gif,logo.jpeg,logo.jpg,logo.png'NEWLIB
When I go to Dashboard page
And I 'check' match all words for strict search
And I search by text 'logo.png'
Then I should see next count '3' found items
When I click show all link for global user search for object 'Assets'
Then I 'should' see asset count '5' on the library search results pageNEWLIB
And I 'should' see assets 'big.logo.png,branding_logo.png,empty.logo.png,empty.project.logo.png,logo.png' on the library search results pageNEWLIB

Scenario: Strict search for files that was moved from project to library
Meta:@gdam
@library
Given I created the agency 'A_SS_S13' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |Access|
| U_SS_S13 | agency.admin | A_SS_S13 |dashboard,streamlined_library|
And logged in with details of 'U_SS_S13'
And created 'P_SS_S13' project
And created '/F_SS_S13' folder for project 'P_SS_S13'
And uploaded '/images/empty.logo.png' file into '/F_SS_S13' folder for 'P_SS_S13' project
And waited while preview is available in folder '/F_SS_S13' on project 'P_SS_S13' files page
When I send file 'empty.logo.png' on project 'P_SS_S13' folder '/F_SS_S13' page to Library
And click Save button on Add file to new library page
And go to Dashboard page
When I 'check' match all words for strict search
And search by text 'A SS'
And I click show all link for global user search for object 'Assets'
Then I 'should' see asset count '1' on the library search results pageNEWLIB
And I 'should' see assets 'empty.logo.png' on the library search results pageNEWLIB

Scenario:Quick Presentations strict search
Meta:@gdam
@projects
Given I created users with following fields:
| Email    | Role        |
| ATP_U_01 | agency.admin |
And logged in with details of 'ATP_U_01'
And I created following reels:
| Name           | Description |
| Reel_SS_S1     | description |
| Reel_SS_S2     | description |
| Reel_SS_S3     | description |
| Reel_SS_S4     | description |
When I go to Dashboard page
When I 'check' match all words for strict search
And search by text with test session 'Reel_SS_S2'
Then I should see next count '1' found items


Scenario: Check file metadata consists of the strict search word
Meta: @uatgdamsmoke
Given I logged in as 'GlobalAdmin'
And waited for '3' seconds
And I impersonated as Client user 'Thomas.D.Wang@disney.com' on opened page
When I 'check' match all words for strict search
And I search by text 'INDIA MICKEY FINAL'
And wait for '6' seconds
And click file 'INDIA MICKEY FINAL (HINDI).pdf' link on search results popup
And wait for '3' seconds
Then I 'should' see following 'custom metadata' fields on opened asset info page:
| FieldName  | FieldValue   |
| Title      | INDIA MICKEY FINAL (HINDI).pdf |


Scenario: Check strict search count while scroll and with Global search count
Meta: @uatgdamsmoke

Given I logged in as 'GlobalAdmin'
And waited for '3' seconds
And I impersonated as Client user 'Thomas.D.Wang@disney.com' on opened page
When I 'check' match all words for strict search
And I search by text 'INDIA MICKEY'
And I click show all link for global user search for object 'Files & Folders'
Then check the total 'Files & Folders' count remains same during scrolling
And check strict search 'Files & Folders' total count is less than the Global search count


Scenario: Check templates strict search
!--FAB-467
Meta: @bug
      @gdam
      @projects
Given I created following templates:
| Name       |
| Tmpl_SS_S06_2 |
| Tmpl_SS_S06_22 |
| Tmpl_SS_S06_222 |
| Tmpl_SS_S06_2222 |
And created '/F_SS_S06_2222' folder for template 'Tmpl_SS_S06_2'
And created '/F_SS_S06_2222' folder for template 'Tmpl_SS_S06_22'
And created '/F_SS_S06_2222' folder for template 'Tmpl_SS_S06_222'
And created '/F_SS_S06_2222' folder for template 'Tmpl_SS_S06_2222'
When I 'check' match all words for strict search
And I search by text 'Tmpl SS S06 2222'
Then I 'should' see search object 'Tmpl_SS_S06_2222' with type 'Templates' after wrap according to search 'Tmpl SS S06 2222' with 'Name' type
And I 'should' see show all results link on quick search menu
And I 'should not' see items 'F_SS_S06_2222' of type 'Files & Folders' in global search result
And I 'should not' see items 'Tmpl_SS_S06_2,Tmpl_SS_S06_22,Tmpl_SS_S06_222' of type 'Template' in global search result
When I click show all link for global user search
Then I 'should' see following templates on the template search page 'Tmpl_SS_S06_2222'
And 'should not' see following templates on the template search page 'Tmpl_SS_S06_2,Tmpl_SS_S06_22,Tmpl_SS_S06_222'

