!--NGN-1114 NGN-3272
Feature:          Global Search
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Global Search


Scenario: Check user search by email (smoke)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
Given I created users with following fields:
| FirstName | LastName | Email      |
| Stan      | Marsh    | U_GS_S02_1 |
| Randy     | Marsh    | U_GS_S02_2 |
| Shelly    | Marsh    | U_GS_S02_3 |
And added following users to address book:
| UserName   |
| U_GS_S02_1 |
| U_GS_S02_2 |
When I search by email 'U_GS_S02_1'
Then I 'should' see search object 'Stan Marsh'
And 'should' see show all results link on quick search menu


Scenario: Check 'show all' user search results
Meta:@gdam
Given I created users with following fields:
| FirstName | LastName  | Email      |
| Kenny     | McCormick | U_GS_S03_1 |
| Stuart    | McCormick | U_GS_S03_2 |
| Mrs       | McCormick | U_GS_S03_3 |
| Karen     | McCormick | U_GS_S03_4 |
| Kevin     | McCormick | U_GS_S03_5 |
And I added following users to address book:
| UserName   |
| U_GS_S03_1 |
| U_GS_S03_2 |
| U_GS_S03_3 |
| U_GS_S03_4 |
| U_GS_S03_5 |
And refreshed the page
When I search by text '<SearchQuery>'
And I click show all link for global user search
Then I should see address book page with next users '<SearchResult>'

Examples:
| SearchQuery | SearchResult                                                                   |
| kenny       | Kenny McCormick                                                                |
| mccormick   | Kenny McCormick,Stuart McCormick,Mrs McCormick,Karen McCormick,Kevin McCormick |


Scenario: Check projects search
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
Given I created following projects:
| Name       |
| Prj_GlobalSearch_S04_1 |
| Prj_GlobalSearch_S04_2 |
| Prj_GlobalSearch_S04_3 |
| Prj_GlobalSearch_S04_4 |
And created '/F_GS_S04' folder for project 'Prj_GlobalSearch_S04_1'
And created '/F_GS_S04' folder for project 'Prj_GlobalSearch_S04_2'
And created '/F_GS_S04' folder for project 'Prj_GlobalSearch_S04_3'
And created '/F_GS_S04' folder for project 'Prj_GlobalSearch_S04_4'
When I search by text 'Prj GlobalSearch'
Then I 'should' see search object 'Prj_GlobalSearch_S04_2,Prj_GlobalSearch_S04_3' with type 'Project' after wrap according to search 'Prj_GlobalSearch' with 'Name' type
And I 'should' see show all results link on quick search menu


Scenario: Check 'show all' projects search results
Meta:@gdam
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      |
| ASR GS S05 | FBR GS S05 |
| ASR GS S05 | SBR GS S05 |
And logged in with details of '<UserEmail>'
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S05_1 |
| Media type | Broadcast  |
| Advertiser | ASR GS S05 |
| Brand      | FBR GS S05 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S05_2 |
| Media type | Broadcast  |
| Advertiser | ASR GS S05 |
| Brand      | SBR GS S05 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S05_3 |
| Media type | Broadcast  |
| Advertiser | ASR GS S05 |
| Brand      | FBR GS S05 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/F_GS_S05' folder for project 'P_GS_S05_1'
And created '/F_GS_S05' folder for project 'P_GS_S05_2'
And created '/F_GS_S05' folder for project 'P_GS_S05_3'
When I search by text '<SearchQuery>'
And click show all link for global user search
Then I 'should' see following projects on the project search page '<SearchResult>'

Examples:
| Agency     | UserEmail  | SearchQuery | SearchResult                     |
| A_GS_S05_1 | U_GS_S05_1 | asr         | P_GS_S05_1,P_GS_S05_2,P_GS_S05_3 |
| A_GS_S05_3 | U_GS_S05_3 | sbr         | P_GS_S05_2                       |


Scenario: Check templates search
!--FAB-467, Randomly it fails. So refer bug for actual failure
Meta: @bug
      @gdam
Given I created following templates:
| Name       |
| Tmpl_GlobSearch_S06_1 |
| Tmpl_GlobSearch_S06_2 |
| Tmpl_GlobSearch_S06_3 |
| Tmpl_GlobSearch_S06_4 |
And created '/F_GS_S06' folder for template 'Tmpl_GlobSearch_S06_1'
And created '/F_GS_S06' folder for template 'Tmpl_GlobSearch_S06_2'
And created '/F_GS_S06' folder for template 'Tmpl_GlobSearch_S06_3'
And created '/F_GS_S06' folder for template 'Tmpl_GlobSearch_S06_4'
When I search by text 'Tmpl GlobSearch'
Then I 'should' see search object 'Tmpl_GlobSearch_S06_2,Tmpl_GlobSearch_S06_3' with type 'Templates' after wrap according to search 'Tmpl_GlobSearch' with 'Name' type
And I 'should' see show all results link on quick search menu

Scenario: Check Files & Folders search
Meta:@gdam
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      |
| ASR GS S08 | FBR GS S08 |
| ASR GS S08 | SBR GS S08 |
And logged in with details of '<UserEmail>'
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S08_1 |
| Media type | Broadcast  |
| Advertiser | ASR GS S08 |
| Brand      | FBR GS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S08_2 |
| Media type | Broadcast  |
| Advertiser | ASR GS S08 |
| Brand      | SBR GS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S08_3 |
| Media type | Broadcast  |
| Advertiser | ASR GS S08 |
| Brand      | FBR GS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/F_GS_S08_1' folder for project 'P_GS_S08_1'
And created '/F_GS_S08_2' folder for project 'P_GS_S08_2'
And created '/F_GS_S08_3' folder for project 'P_GS_S08_3'
And uploaded into project 'P_GS_S08_1' following files:
| FileName           | Path       |
| /files/file_1.avi  | F_GS_S08_1 |
| /files/example.psd | F_GS_S08_1 |
| /files/index.html  | F_GS_S08_1 |
| /files/Fish-Ad.mov | F_GS_S08_1 |
And uploaded into project 'P_GS_S08_2' following files:
| FileName             | Path       |
| /files/file_2.avi    | F_GS_S08_2 |
| /files/example2.indd | F_GS_S08_2 |
| /files/Fish2-Ad.mov  | F_GS_S08_2 |
And uploaded into project 'P_GS_S08_3' following files:
| FileName            | Path       |
| /files/fi3le.avi    | F_GS_S08_3 |
| /files/example3.psd | F_GS_S08_3 |
| /files/Fish-Ad.mov  | F_GS_S08_3 |
| /files/file_1.avi   | F_GS_S08_3 |
| /files/example.psd  | F_GS_S08_3 |
| /files/Fish-Ad.mov  | F_GS_S08_3 |
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_GS_S08_1 |
| Media type | Broadcast  |
| Advertiser | ASR GS S08 |
| Brand      | FBR GS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_GS_S08_2 |
| Media type | Broadcast  |
| Advertiser | ASR GS S08 |
| Brand      | SBR GS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_GS_S08_3 |
| Media type | Broadcast  |
| Advertiser | ASR GS S08 |
| Brand      | FBR GS S08 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/F_GS_S08_1' folder for template 'T_GS_S08_1'
And created '/F_GS_S08_2' folder for template 'T_GS_S08_2'
And created '/F_GS_S08_3' folder for template 'T_GS_S08_3'
And I uploaded into template 'T_GS_S08_1' following files:
| FileName           | Path       |
| /files/file_1.avi  | F_GS_S08_1 |
| /files/example.psd | F_GS_S08_1 |
| /files/index.html  | F_GS_S08_1 |
| /files/Fish-Ad.mov | F_GS_S08_1 |
And I uploaded into template 'T_GS_S08_2' following files:
| FileName             | Path       |
| /files/file_2.avi    | F_GS_S08_2 |
| /files/example2.indd | F_GS_S08_2 |
| /files/Fish2-Ad.mov  | F_GS_S08_2 |
And I uploaded into template 'T_GS_S08_3' following files:
| FileName            | Path       |
| /files/fi3le.avi    | F_GS_S08_3 |
| /files/example3.psd | F_GS_S08_3 |
| /files/Fish-Ad.mov  | F_GS_S08_3 |
| /files/file_1.avi   | F_GS_S08_3 |
| /files/example.psd  | F_GS_S08_3 |
| /files/Fish-Ad.mov  | F_GS_S08_3 |
When I search by text '<SearchQuery>'
Then I 'should' see search object '<SearchResult>' with type 'Files & Folders' after wrap according to search '<SearchQuery>' with 'Name' type
And I 'should' see show all results link on quick search menu

Examples:
| Agency     | UserEmail  | SearchQuery | SearchResult                          |
| A_GS_S08_2 | U_GS_S08_2 | Fish2       | Fish2-Ad.mov                          |
| A_GS_S08_3 | U_GS_S08_3 | example     | example.psd,example3.psd,example5.psd |


Scenario: Check Files & Folders search 2
Meta:@gdam
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      |
| ASR GS S09 | FBR GS S09 |
| ASR GS S09 | SBR GS S09 |
And logged in with details of '<UserEmail>'
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S09_1 |
| Media type | Broadcast  |
| Advertiser | ASR GS S09 |
| Brand      | FBR GS S09 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S09_2 |
| Media type | Broadcast  |
| Advertiser | ASR GS S09 |
| Brand      | SBR GS S09 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S09_3 |
| Media type | Broadcast  |
| Advertiser | ASR GS S09 |
| Brand      | FBR GS S09 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/F_GS_S09_1' folder for project 'P_GS_S09_1'
And created '/F_GS_S09_2' folder for project 'P_GS_S09_2'
And created '/F_GS_S09_3' folder for project 'P_GS_S09_3'
And uploaded into project 'P_GS_S09_1' following files:
| FileName           | Path       |
| /files/file_1.avi  | F_GS_S09_1 |
| /files/example.psd | F_GS_S09_1 |
| /files/index.html  | F_GS_S09_1 |
| /files/Fish-Ad.mov | F_GS_S09_1 |
And uploaded into project 'P_GS_S09_2' following files:
| FileName             | Path       |
| /files/file_2.avi    | F_GS_S09_2 |
| /files/example2.indd | F_GS_S09_2 |
| /files/Fish2-Ad.mov  | F_GS_S09_2 |
And uploaded into project 'P_GS_S09_3' following files:
| FileName            | Path       |
| /files/fi3le.avi    | F_GS_S09_3 |
| /files/example3.psd | F_GS_S09_3 |
| /files/Fish-Ad.mov  | F_GS_S09_3 |
| /files/file_1.avi   | F_GS_S09_3 |
| /files/example.psd  | F_GS_S09_3 |
| /files/Fish-Ad.mov  | F_GS_S09_3 |
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_GS_S09_1 |
| Media type | Broadcast  |
| Advertiser | ASR GS S09 |
| Brand      | FBR GS S09 |
| Start date | Today      |
| End date   | Tomorrow   |
And waited for '3' seconds
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_GS_S09_2 |
| Media type | Broadcast  |
| Advertiser | ASR GS S09 |
| Brand      | SBR GS S09 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_GS_S09_3 |
| Media type | Broadcast  |
| Advertiser | ASR GS S09 |
| Brand      | FBR GS S09 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/F_GS_S09_1' folder for template 'T_GS_S09_1'
And created '/F_GS_S09_2' folder for template 'T_GS_S09_2'
And created '/F_GS_S09_3' folder for template 'T_GS_S09_3'
And I uploaded into template 'T_GS_S09_1' following files:
| FileName           | Path       |
| /files/file_1.avi  | F_GS_S09_1 |
| /files/example.psd | F_GS_S09_1 |
| /files/index.html  | F_GS_S09_1 |
| /files/Fish-Ad.mov | F_GS_S09_1 |
And I uploaded into template 'T_GS_S09_2' following files:
| FileName             | Path       |
| /files/file_2.avi    | F_GS_S09_2 |
| /files/example2.indd | F_GS_S09_2 |
| /files/Fish2-Ad.mov  | F_GS_S09_2 |
And I uploaded into template 'T_GS_S09_3' following files:
| FileName            | Path       |
| /files/fi3le.avi    | F_GS_S09_3 |
| /files/example3.psd | F_GS_S09_3 |
| /files/Fish-Ad.mov  | F_GS_S09_3 |
| /files/file_1.avi   | F_GS_S09_3 |
| /files/example.psd  | F_GS_S09_3 |
| /files/Fish-Ad.mov  | F_GS_S09_3 |
When I search by text '<SearchQuery>'
And I click show all link for global user search for object 'Files & Folders'
Then I 'should' see following files & folders on the search page '<SearchResult>' for object 'Name'

Examples:
| Agency     | UserEmail  | SearchQuery | SearchResult |
| A_GS_S09_2 | U_GS_S09_2 | Fish2       | Fish2-Ad.mov |
| A_GS_S09_3 | U_GS_S09_3 | example     | example.psd  |


Scenario: Check that All Results page for Files & Folders shows project name column (search by file, folder name)
!-- NGN-9093
Meta:@gdam
Given I created the agency 'A_GS_S10' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_GS_S10_1  | agency.admin | A_GS_S10     |
And logged in with details of 'U_GS_S10_1'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_GS_S10':
| Advertiser | Brand      |
| ASR GS S10 | FBR GS S10 |
| ASR GS S11 | SBR GS S11 |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S10_1 |
| Media type | Broadcast  |
| Advertiser | ASR GS S10 |
| Brand      | FBR GS S10 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S10_2 |
| Media type | Broadcast  |
| Advertiser | ASR GS S11 |
| Brand      | SBR GS S11 |
| Start date | Today      |
| End date   | Tomorrow   |
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S10_3 |
| Media type | Broadcast  |
| Advertiser | ASR GS S10 |
| Brand      | FBR GS S10 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/F_GS_S10_1' folder for project 'P_GS_S10_1'
And created '/F_GS_S10_2' folder for project 'P_GS_S10_2'
And created '/F_GS_S10_3' folder for project 'P_GS_S10_3'
And uploaded into project 'P_GS_S10_1' following files:
| FileName           | Path       |
| /files/file_1.avi  | F_GS_S10_1 |
| /files/Fish-Ad.mov | F_GS_S10_1 |
And uploaded into project 'P_GS_S10_2' following files:
| FileName             | Path       |
| /files/file_2.avi    | F_GS_S10_2 |
| /files/Fish2-Ad.mov  | F_GS_S10_2 |
And uploaded into project 'P_GS_S10_3' following files:
| FileName            | Path       |
| /files/Fish-Ad.mov  | F_GS_S10_3 |
| /files/file_1.avi   | F_GS_S10_3 |
When I search by text 'avi'
And I click show all link for global user search for object 'Files & Folders'
Then I 'should' see following files & folders on the search page 'file_1.avi,file_2.avi,file_1.avi' for object 'Files & Folders'


Scenario: Check that Project Name is a link to project (search by Advertiser-Brand case)
!--NGN-9093
Meta:@gdam
Given I created the agency 'A_GS_S11' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_GS_S11_1  | agency.admin | A_GS_S11     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_GS_S11':
| Advertiser | Brand      |
| ASR GS S12 | FBR GS S12 |
And logged in with details of 'U_GS_S11_1'
And created 'P_GS_S11_1' project
And created '/F_GS_S11_1' folder for project 'P_GS_S11_1'
And uploaded into project 'P_GS_S11_1' following files:
| FileName            | Path        |
| /files/example3.psd | /F_GS_S11_1 |
| /files/file_1.avi   | /F_GS_S11_1 |
And waited while transcoding is finished in folder '/F_GS_S11_1' on project 'P_GS_S11_1' files page
When I go to file 'example3.psd' info page in folder '/F_GS_S11_1' project 'P_GS_S11_1'
And 'save' file info by next information:
| FieldName   | FieldValue  |
| Advertiser  | ASR GS S12  |
| Brand       | FBR GS S12  |
And go to file 'file_1.avi' info page in folder '/F_GS_S11_1' project 'P_GS_S11_1'
And 'save' file info by next information:
| FieldName   | FieldValue  |
| Advertiser  | ASR GS S12  |
| Brand       | FBR GS S12  |
And go to Dashboard page
And search by text with test session 'ASR GS S12'
And click show all link for global user search for object 'Files & Folders'
And click by project name 'P_GS_S11_1'
And wait for '2' seconds
Then I should see project 'P_GS_S11_1' overview page


Scenario: Check sorting by project name on Show all results page
!--NGN-9093
Meta:@gdam
Given I created the agency 'A_GS_S11' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_GS_S12_1  | agency.admin | A_GS_S11     |
And logged in with details of 'U_GS_S12_1'
And created 'P_GS_S12_1' project
And created 'P_GS_S12_2' project
And created 'P_GS_S12_3' project
And created 'P_GS_S12_4' project
When I search by text 'P_GS_S12_'
And click show all link for global user search for object 'Projects / Work Requests'
And sorting projects by field 'Title' in order 'asc'
And refresh the page
Then I should see projects sorted by field 'Tite' in order 'asc'
When I sorting projects by field 'Title' in order 'desc'
And refresh the page
Then I should see projects sorted by field 'Title' in order 'desc'


Scenario: Check assets search (smoke)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
Given I created users with following fields:
| Email    | Role        |
| U_GS_S10 | agency.user |
And logged in with details of 'U_GS_S10'
And uploaded following assets:
| Name                        |
| /files/example2.indd        |
| /files/GWGTestfile064v3.pdf |
| /files/example.psd          |
When I search by text 'GWGTestfile064v3.pdf'
Then I 'should' see search object 'GWGTestfile064v3.pdf' with type 'Assets' after wrap according to search 'GWGTestfile064v3.pdf' with 'Name' type
And 'should' see show all results link on quick search menu


Scenario: Check that results not included in 'myassets' collection are showed in all results
Meta:@gdam
Given I created the agency 'A_GS_S11' with default attributes
And created users with following fields:
| Email      | Access          | Role         | AgencyUnique |
| U_GS_S11_1 | folders,library | agency.admin | A_GS_S11     |
| U_GS_S11_2 | folders,library | agency.user  | A_GS_S11     |
And logged in with details of 'U_GS_S11_1'
And created 'LR_GS_S11' role in 'library' group for advertiser 'A_GS_S11'
And I created following categories:
| Name     | MediaType |
| fazan    | image     |
| sezan    | audio     |
| debazan  | video     |
| kurtizan | digital   |
And I uploaded following assets:
| Name                      |
| /images/admin.logo.jpg    |
| /images/big.logo.png      |
| /images/branding_logo.png |
| /images/empty.logo.png    |
And I added next users for following categories:
| CategoryName | UserName   | RoleName  |
| fazan        | U_GS_S11_2 | LR_GS_S11 |
| sezan        | U_GS_S11_2 | LR_GS_S11 |
| debazan      | U_GS_S11_2 | LR_GS_S11 |
| kurtizan     | U_GS_S11_2 | LR_GS_S11 |
And logged in with details of 'U_GS_S11_2'
And uploaded following assets:
| Name                           |
| /images/empty.project.logo.png |
| /images/logo.bmp               |
| /images/logo.gif               |
| /images/logo.jpeg              |
| /images/logo.jpg               |
| /images/logo.png               |
And waited for '5' seconds
When I search by text 'logo'
And I click show all link for global user search for object 'Assets'
Then I should see assets '10' on the library page
And I 'should' see assets 'admin.logo.jpg,big.logo.png,branding_logo.png,empty.logo.png,empty.project.logo.png,logo.bmp,logo.gif,logo.jpeg,logo.jpg,logo.png' on the library search results page


Scenario: quick search for files that was moved from project to library
Meta:@gdam
Given I created the agency 'A_GS_S12' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| U_GS_S12 | agency.admin | A_GS_S12 |
And logged in with details of 'U_GS_S12'
And created 'P_GS_S12' project
And created '/F_GS_S12' folder for project 'P_GS_S12'
And uploaded '/images/empty.logo.png' file into '/F_GS_S12' folder for 'P_GS_S12' project
And waited while preview is available in folder '/F_GS_S12' on project 'P_GS_S12' files page
When I send file 'empty.logo.png' on project 'P_GS_S12' folder '/F_GS_S12' page to Library
And click Save button on Add file to library page
And go to Dashboard page
And search by text 'A GS'
Then I 'should' see search object 'empty.logo.png' with type 'Assets' after wrap according to search 'empty.logo.png' with 'Name' type
And 'should' see show all results link on quick search menu


Scenario: global search for files that was moved from project to library
Meta:@gdam
Given I created the agency 'A_GS_S13' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| U_GS_S13 | agency.admin | A_GS_S13 |
And logged in with details of 'U_GS_S13'
And created 'P_GS_S13' project
And created '/F_GS_S13' folder for project 'P_GS_S13'
And uploaded '/images/empty.logo.png' file into '/F_GS_S13' folder for 'P_GS_S13' project
And waited while preview is available in folder '/F_GS_S13' on project 'P_GS_S13' files page
When I send file 'empty.logo.png' on project 'P_GS_S13' folder '/F_GS_S13' page to Library
And click Save button on Add file to library page
And go to Dashboard page
And search by text 'A GS'
And I click show all link for global user search for object 'Assets'
Then I should see assets '1' on the library page
And I 'should' see assets 'empty.logo.png' on the library search results page


Scenario: Check that Search should ignore any _ which have been used as separators in the metadata and title
Meta:@gdam
Given I created the agency 'A_GS_S14' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| U_GS_S14 | agency.admin | A_GS_S14 |
And logged in with details of 'U_GS_S14'
And created 'P_GS_S14' project
And created '/F_GS_S14' folder for project 'P_GS_S14'
And uploaded into project 'P_GS_S14' following files:
| FileName          | Path     |
| /images/logo.bmp  | F_GS_S14 |
| /images/logo.gif  | F_GS_S14 |
| /images/logo.jpeg | F_GS_S14 |
| /images/logo.jpg  | F_GS_S14 |
| /images/logo.png  | F_GS_S14 |
And uploaded following files into my library:
| Name              |
| /images/logo.bmp  |
| /images/logo.gif  |
| /images/logo.jpeg |
| /images/logo.jpg  |
| /images/logo.png  |
And waited while transcoding is finished in folder 'F_GS_S14' on project 'P_GS_S14' files page
And waited while transcoding is finished in collection 'My Assets'
When I 'save' file 'logo.bmp' info in folder 'F_GS_S14' on project 'P_GS_S14' by following information:
| FieldName | FieldValue  |
| Title     | By_the_book |
And 'save' file 'logo.gif' info in folder 'F_GS_S14' on project 'P_GS_S14' by following information:
| FieldName | FieldValue    |
| Title     | Bookshelf.avi |
| Campaign  | Book shop     |
And 'save' file 'logo.png' info in folder 'F_GS_S14' on project 'P_GS_S14' by following information:
| FieldName | FieldValue         |
| Title     | Home library/books |
And 'save' file 'logo.jpeg' info in folder 'F_GS_S14' on project 'P_GS_S14' by following information:
| FieldName | FieldValue    |
| Title     | Bookshelf.mpg |
And 'save' file 'logo.jpg' info in folder 'F_GS_S14' on project 'P_GS_S14' by following information:
| FieldName | FieldValue    |
| Title     | 5.56 mm round |
And 'save' asset 'logo.bmp' info of collection 'My Assets' by following information:
| FieldName | FieldValue  |
| Title     | By_the_book |
And 'save' asset 'logo.gif' info of collection 'My Assets' by following information:
| FieldName | FieldValue    |
| Title     | Bookshelf.avi |
| Campaign  | Book shop     |
And 'save' asset 'logo.png' info of collection 'My Assets' by following information:
| FieldName | FieldValue         |
| Title     | Home library/books |
And 'save' asset 'logo.jpeg' info of collection 'My Assets' by following information:
| FieldName | FieldValue    |
| Title     | Bookshelf.mpg |
And 'save' asset 'logo.jpg' info of collection 'My Assets' by following information:
| FieldName | FieldValue    |
| Title     | 5.56 mm round |
And go to Dashboard page
And search by text '<SearchQuery>'
Then I 'should' see search object '<SearchResult>' with type 'Files & Folders' after wrap according to search '<SearchQuery>' with 'Name' type
Then I 'should' see search object '<SearchResult>' with type 'Assets' after wrap according to search '<SearchQuery>' with 'Name' type

Examples:
| SearchQuery | SearchResult                |
| book        | By_the_book,Bookshelf.avi   |
| books       | Home library/books          |
| Bookshelf   | Bookshelf.avi,Bookshelf.mpg |
| 5.56 mm     | 5.56 mm round               |


Scenario: Check that search in current project should ignore any _ which have been used as separators in the metadata and title
Meta:@gdam
Given I created the agency 'A_GS_S15' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| U_GS_S15 | agency.admin | A_GS_S15 |
And logged in with details of 'U_GS_S15'
And created 'P_GS_S15' project
And created '/F_GS_S15' folder for project 'P_GS_S15'
And uploaded into project 'P_GS_S15' following files:
| FileName            | Path     |
| /files/Fish1-Ad.mp3 | F_GS_S15 |
| /files/Fish1-Ad.mov | F_GS_S15 |
| /files/Fish1-Ad.mpg | F_GS_S15 |
| /files/Fish1-Ad.wmv | F_GS_S15 |
| /files/4002c.ai     | F_GS_S15 |
And waited while transcoding is finished in folder 'F_GS_S15' on project 'P_GS_S15' files page
When I 'save' file 'Fish1-Ad.mp3' info in folder 'F_GS_S15' on project 'P_GS_S15' by following information:
| FieldName | FieldValue        |
| Title     | coca cola logo.ai |
And 'save' file 'Fish1-Ad.mov' info in folder 'F_GS_S15' on project 'P_GS_S15' by following information:
| FieldName | FieldValue        |
| Title     | Coca-Cola-logo.ai |
And 'save' file '4002c.ai' info in folder 'F_GS_S15' on project 'P_GS_S15' by following information:
| FieldName | FieldValue                    |
| Title     | coca -cola logo-vector-01.png |
And 'save' file 'Fish1-Ad.mpg' info in folder 'F_GS_S15' on project 'P_GS_S15' by following information:
| FieldName | FieldValue          |
| Title     | Coca-Cola_16x9.mpeg |
And 'save' file 'Fish1-Ad.wmv' info in folder 'F_GS_S15' on project 'P_GS_S15' by following information:
| FieldName | FieldValue        |
| Title     | Coca_vova_56.mpeg |
And I go to project 'P_GS_S15' files page
And search by text 'cola'
Then I 'should' see search object 'coca cola logo.ai,Coca-Cola-logo.ai,coca -cola logo-vector-01.png' with type 'File' after wrap according to search 'cola' with 'Name' type
And 'should not' see search object 'Coca-Cola_16x9.mpeg,Coca_vova_56.mpeg' with type 'File' after wrap according to search 'cola' with 'Name' type


Scenario: Users should be able to search assets by stopwords
!-- NGN-10062
Meta:@gdam
Given I created the agency 'A_GS_S16' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| U_GS_S16 | agency.admin | A_GS_S16 |
And logged in with details of 'U_GS_S16'
And uploaded following assets:
| Name                           |
| /images/admin.logo.jpg         |
| /images/bg_img.jpg             |
| /images/big.logo.png           |
| /images/branding_logo.png      |
| /images/empty.logo.png         |
| /images/empty.project.logo.png |
| /images/logo.bmp               |
| /images/logo.gif               |
| /images/logo.jpeg              |
And waited while preview is available in collection 'My Assets'
When changing title of asset 'admin.logo.jpg' to following title 'The journal' on library page for collection 'My Assets'
And changing title of asset 'bg_img.jpg' to following title 'By the journal' on library page for collection 'My Assets'
And changing title of asset 'big.logo.png' to following title 'By apple' on library page for collection 'My Assets'
And changing title of asset 'branding_logo.png' to following title 'By the apple' on library page for collection 'My Assets'
And changing title of asset 'empty.logo.png' to following title 'The wall' on library page for collection 'My Assets'
And changing title of asset 'empty.project.logo.png' to following title 'By the wall' on library page for collection 'My Assets'
And changing title of asset 'logo.bmp' to following title 'The book' on library page for collection 'My Assets'
And changing title of asset 'logo.gif' to following title 'Book by Jonathan' on library page for collection 'My Assets'
And changing title of asset 'logo.jpeg' to following title 'by the book' on library page for collection 'My Assets'
And search by text 'by the book'
Then I 'should' see items 'by the book' of type 'Assets' in global search result


Scenario: Users should be able to search assets by stopwords (additional examples)
!-- NGN-10062
Meta:@gdam
Given I logged in with details of 'U_GS_S16'
When I search by text '<Text>'
Then I 'should' see items '<Result>' of type 'Assets' in global search result

Examples:
| Text     | Result                       |
| by book  | Book by Jonathan,by the book |
| the book | The book,by the book         |


Scenario: check that search is work for parts of clock number split by separator and see show all link
Meta: @skip
      @gdam
Given created the agency 'A_GS_S17' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| U_GS_S17 | agency.admin | A_GS_S17 |
And logged in with details of 'U_GS_S17'
And created 'P_GS_S17' project
And created '/F_GS_S17' folder for project 'P_GS_S17'
And uploaded '/files/Fish1-Ad.mov' file into '/F_GS_S17' folder for 'P_GS_S17' project
And uploaded '/files/Fish2-Ad.mov' file into '/F_GS_S17' folder for 'P_GS_S17' project
And uploaded '/files/Fish3-Ad.mov' file into '/F_GS_S17' folder for 'P_GS_S17' project
And waited while preview is available in folder '/F_GS_S17' on project 'P_GS_S17' files page
When I go to file 'Fish1-Ad.mov' info page in folder '/F_GS_S17' project 'P_GS_S17'
And 'save' file info by next information:
| FieldName    | FieldValue |
| Clock number | ABC/DE/FG  |
And go to file 'Fish2-Ad.mov' info page in folder '/F_GS_S17' project 'P_GS_S17'
And 'save' file info by next information:
| FieldName    | FieldValue |
| Clock number | ABC/FG/DE  |
And search by text '<SearchQuery>'
Then I 'should' see the following files '<SearchResult>' on global search result

Examples:
| SearchQuery | SearchResult              | Condition  |
| ABC/DE      | Fish1-Ad.mov,Fish2-Ad.mov | should     |
| FG/ABC      | Fish1-Ad.mov,Fish2-Ad.mov | should     |
| AB          | Fish1-Ad.mov,Fish2-Ad.mov | should not |


Scenario: check that search is work for Country Usage Right criteteria 'Europe'
Meta:@gdam
@library
Given I created the agency 'A_GS_S18' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |Access|
| U_GS_S18 | agency.admin | A_GS_S18 |streamlined_library|
And logged in with details of 'U_GS_S18'
And created 'C_GS_S18' category
And uploaded asset '/files/image10.jpg' into libraryNEWLIB
And uploaded asset '/files/image11.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'Countries' for asset 'image10.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate |
| Europe  | 2 days ago | 2 days since   |
And add Usage Right 'Countries' for asset 'image11.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country     | StartDate  | ExpirationDate |
| Afghanistan | 2 days ago | 2 days since   |
And I enter input 'Europe' on global search pageNEWLIB
Then I 'should' see assets 'image10.jpg' in the global search pageNEWLIB



Scenario: Check projects search with wildcard characters
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
Given I created following projects:
| Name       |
| Prj_GlobalSearch_S19_1 |
| Prj_GlobalSearch_S19_2 |
| Prj_GlobalSearch_S19_3 |
| Prj_GlobalSearch_S19_4 |
And created '/F_GS_S19' folder for project 'Prj_GlobalSearch_S19_1'
And created '/F_GS_S19' folder for project 'Prj_GlobalSearch_S19_2'
And created '/F_GS_S19' folder for project 'Prj_GlobalSearch_S19_3'
And created '/F_GS_S19' folder for project 'Prj_GlobalSearch_S19_4'
When I search by text '<WildCardSearchQuery>'
Then I 'should' see search object 'Prj_GlobalSearch_S19_2,Prj_GlobalSearch_S19_3' with type 'Project' after wrap according to search '<WildCardSearchQuery>' with 'Name' type

Examples:
| WildCardSearchQuery     |
| "globalSEARCH"          |
| Prj_GlobalSearch_S19_?  |
| Prj*                    |


Scenario: Check templates search with wildcard characters
Meta: @bug
      @gdam
!--FAB-467--only 2 and 3 examples fail
Given I created following templates:
| Name       |
| Tmpl_GlobSearch_S20_1 |
| Tmpl_GlobSearch_S20_2 |
| Tmpl_GlobSearch_S20_3 |
| Tmpl_GlobSearch_S20_4 |
And created '/F_GS_S20' folder for template 'Tmpl_GlobSearch_S20_1'
And created '/F_GS_S20' folder for template 'Tmpl_GlobSearch_S20_2'
And created '/F_GS_S20' folder for template 'Tmpl_GlobSearch_S20_3'
And created '/F_GS_S20' folder for template 'Tmpl_GlobSearch_S20_4'
When I search by text '<WildCardSearchQuery>'
Then I 'should' see search object 'Tmpl_GlobSearch_S20_2,Tmpl_GlobSearch_S20_3' with type 'Templates' after wrap according to search '<WildCardSearchQuery>' with 'Name' type

Examples:
| WildCardSearchQuery   |
| "globSEARCH"          |
| Tmpl_GlobSearch_S20_? |
| Tmpl*                 |



Scenario: Check assets search with wildcard characters(smoke)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
Given I created users with following fields:
| Email    | Role        |
| U_GS_S21 | agency.user |
And logged in with details of 'U_GS_S21'
And uploaded following assets:
| Name                           |
| /files/ZZNew Text Document.txt |
| /files/GWGTestfile064v3.pdf    |
| /files/New Text Document.txt   |
| /files/GWGTest2.pdf            |
| /files/file_1.avi              |
| /files/file_2.avi              |
When I search by text '<SearchQuery>'
Then I 'should' see the following files '<SearchResult>' on global search result

Examples:
| SearchQuery     | SearchResult                                  |
| "Text Document" | ZZNew Text Document.txt,New Text Document.txt |
| GWGTest*        | GWGTestfile064v3.pdf,GWGTest2.pdf             |
| file_?.avi      | file_1.avi,file_2.avi                         |



Scenario: Check Files & Folders search with wildcard characters
Meta:@gdam
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      |
| ASR GS S22 | FBR GS S22 |
| ASR GS S22 | SBR GS S22 |
And logged in with details of '<UserEmail>'
And created new project with following fields:
| FieldName  | FieldValue |
| Name       | P_GS_S22_1 |
| Media type | Broadcast  |
| Advertiser | ASR GS S22 |
| Brand      | FBR GS S22 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/F_GS_S22_1' folder for project 'P_GS_S22_1'
And uploaded into project 'P_GS_S22_1' following files:
| FileName           | Path       |
| /files/file_1.avi  | F_GS_S22_1 |
| /files/example.psd | F_GS_S22_1 |
| /files/index.html  | F_GS_S22_1 |
| /files/Fish-Ad.mov | F_GS_S22_1 |
And created new template with following fields:
| FieldName  | FieldValue |
| Name       | T_GS_S22_1 |
| Media type | Broadcast  |
| Advertiser | ASR GS S22 |
| Brand      | FBR GS S22 |
| Start date | Today      |
| End date   | Tomorrow   |
And created '/F_GS_S22_1' folder for template 'T_GS_S22_1'
And I uploaded into template 'T_GS_S22_1' following files:
| FileName                       | Path       |
| /files/ZZNew Text Document.txt | F_GS_S22_1 |
| /files/GWGTestfile064v3.pdf    | F_GS_S22_1 |
| /files/file_1.avi              | F_GS_S22_1 |
When I search by text '<SearchQuery>'
Then I 'should' see search object '<SearchResult>' with type 'Files & Folders' after wrap according to search '<SearchResult>' with 'Name' type

Examples:
| Agency     | UserEmail  | SearchQuery     | SearchResult            |
| A_GS_S22_1 | U_GS_S22_1 | "Text Document" | ZZNew Text Document.txt |
| A_GS_S22_2 | U_GS_S22_2 | GWGTest*        | GWGTestfile064v3.pdf    |
| A_GS_S22_3 | U_GS_S22_3 | file_?.avi      | file_1.avi              |



Scenario: Check search results with phrase in Title should be scored higher than results with phrases in other metadata fields
Meta:@gdam
Given I created the following agency:
| Name     | A4User        |
| U_GS_S23 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| U_GS_S23 | agency.admin | U_GS_S23     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'U_GS_S23':
| Advertiser | Brand    | Sub Brand | Product  |
| U_GS_S23   | U_GS_S23 | U_GS_S23  | U_GS_S23 |
And logged in with details of 'U_GS_S23'
And created 'U_GS_S23' project
And created '/U_GS_S23' folder for project 'U_GS_S23'
And uploaded into project 'U_GS_S23' following files:
| FileName             | Path      |
| /files/Fish1-Ad.mov  | /U_GS_S23 |
| /files/Fish2-Ad.mov  | /U_GS_S23 |
| /files/Fish3-Ad.mov  | /U_GS_S23 |
| /files/Fish4-Ad.mov  | /U_GS_S23 |
And waited while transcoding is finished in folder '/U_GS_S23' on project 'U_GS_S23' files page
When I go to file 'Fish1-Ad.mov' info page in folder '/U_GS_S23' project 'U_GS_S23'
And 'save' file info by next information:
| FieldName | FieldValue  |
| Title     | U_GS_S23 01 |
When I go to file 'Fish2-Ad.mov' info page in folder '/U_GS_S23' project 'U_GS_S23'
And 'save' file info by next information:
| FieldName | FieldValue  |
| Title     | U_GS_S23 02 |
When I go to file 'Fish3-Ad.mov' info page in folder '/U_GS_S23' project 'U_GS_S23'
And 'save' file info by next information:
| FieldName  | FieldValue |
| Advertiser | U_GS_S23   |
When I go to file 'Fish4-Ad.mov' info page in folder '/U_GS_S23' project 'U_GS_S23'
And 'save' file info by next information:
| FieldName    | FieldValue |
| Clock Number | U_GS_S23   |
And search by text '<SearchQuery>'
Then I 'should' see search object '<SearchResult>' with type 'Files & Folders' after wrap according to search '<SearchQuery>' with 'Name' type

Examples:
| SearchQuery | SearchResult            |
| U_GS_S23    | U_GS_S23 01,U_GS_S23 02 |



Scenario: Check search results with phrase in Title should be scored higher than results with phrases in other metadata fields, 2
Meta: @gdam
@library
!--NGN-17424, Randomly it fails. So refer bug for actual failure
Given I created the following agency:
| Name     | A4User        |
| U_GS_S24 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| U_GS_S24 | agency.admin | U_GS_S24     |streamlined_library,dashboard|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'U_GS_S24':
| Advertiser | Brand    | Sub Brand | Product  |
| U_GS_S24   | U_GS_S24 | U_GS_S24  | U_GS_S24 |
And logged in with details of 'U_GS_S24'
And uploaded following files into my libraryNEWLIB:
| Name              |
| /images/logo.bmp  |
| /images/logo.gif  |
| /images/logo.jpeg |
| /images/logo.png |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When set following file info for next assets from collection 'My Assets'NEWLIB:
| Name          | Title  |
| logo.bmp  | U_GS_S24 01   |
When set following file info for next assets from collection 'My Assets'NEWLIB:
| Name          | Campaign  |
| logo.gif  | U_GS_S24 02   |
When set following file info for next assets from collection 'My Assets'NEWLIB:
| Name          | Title  |
| logo.jpeg  | U_GS_S24 03   |
When set following file info for next assets from collection 'My Assets'NEWLIB:
| Name          | Campaign  |
| logo.png  | 24 campaign   |
And go to Dashboard page
And search by text '<SearchQuery>'
Then I should see items '<SearchResult>' of type 'Assets' with proper order in global search result

Examples:
| SearchQuery | SearchResult                     |
| U_GS_S24    | U_GS_S24 01,U_GS_S24 03,logo.gif |


