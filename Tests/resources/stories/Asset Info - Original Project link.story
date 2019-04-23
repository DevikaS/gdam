!--NGN-10447
Feature:          Asset Info - Original Project link
Narrative:
In order to
As a              AgencyAdmin
I want to         Check original project link on asset info


Scenario: check that link to Original Project disappear if project was deleted
Meta:@gdam
    @library
Given I created users with following fields:
| Email        |Access|
| U_AIBTPL_S04 |folders,streamlined_library|
And logged in with details of 'U_AIBTPL_S04'
And created 'P_AIBTPL_S04_1' project
And created 'P_AIBTPL_S04_2' project
And created '/F_AIBTPL_S04' folder for project 'P_AIBTPL_S04_1'
And created '/F_AIBTPL_S04' folder for project 'P_AIBTPL_S04_2'
And uploaded '/files/image10.jpg' file into '/F_AIBTPL_S04' folder for 'P_AIBTPL_S04_1' project
And waited while transcoding is finished in folder '/F_AIBTPL_S04' on project 'P_AIBTPL_S04_1' files page
When I move file 'image10.jpg' from project 'P_AIBTPL_S04_1' folder '/F_AIBTPL_S04' to new library page
And add following asset 'image10.jpg' of collection 'My Assets' to project 'P_AIBTPL_S04_2' folder '/F_AIBTPL_S04'NEWLIB
Then I 'should' see file 'image10.jpg' on project 'P_AIBTPL_S04_2' folder '/F_AIBTPL_S04' files page



Scenario: check that link to Original Project shown only when user opens Asset Info tab
Meta:@gdam
    @library
Given I created users with following fields:
| Email        |Access|
| U_AIBTPL_S01 |streamlined_library,adkits,folders,library|
And logged in with details of 'U_AIBTPL_S01'
And created 'P_AIBTPL_S01' project
And created '/F_AIBTPL_S01' folder for project 'P_AIBTPL_S01'
And uploaded '/files/image10.jpg' file into '/F_AIBTPL_S01' folder for 'P_AIBTPL_S01' project
And waited while transcoding is finished in folder '/F_AIBTPL_S01' on project 'P_AIBTPL_S01' files page
When I move file 'image10.jpg' from project 'P_AIBTPL_S01' folder '/F_AIBTPL_S01' to new library page
And I go to asset 'image10.jpg' related projects info page in Library for collection 'My Assets' NEWLIB
Then 'should' see following originated project name 'P_AIBTPL_S01' on assets related projects info page in Library NEWLIB



Scenario: check that assets uploaded directly to Library should be w/o Original Project field
Meta:@gdam
    @library
Given I created users with following fields:
| Email        |Access|
| U_AIBTPL_S02 |streamlined_library,adkits,folders,library|
And logged in with details of 'U_AIBTPL_S02'
And created 'P_AIBTPL_S02' project
And created '/F_AIBTPL_S02' folder for project 'P_AIBTPL_S02'
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'image10.jpg' info page in Library for collection 'My Assets'NEWLIB
Then I 'should not' see following 'asset information' fields on opened asset info pageNEWLIB:
| FieldName         | FieldValue   |
| Original Project: | P_AIBTPL_S02 |
When I go to asset 'image10.jpg' related projects info page in Library for collection 'My Assets' NEWLIB
Then I should see a message 'No related projects' on assets related projects info page in Library NEWLIB


Scenario: check that user can edit moved assets
Meta:@gdam
    @library
Given I created users with following fields:
| Email        |Access|
| U_AIBTPL_S03 |streamlined_library,adkits,folders,library|
And logged in with details of 'U_AIBTPL_S03'
And created 'P_AIBTPL_S03' project
And created '/F_AIBTPL_S03' folder for project 'P_AIBTPL_S03'
And uploaded '/files/image10.jpg' file into '/F_AIBTPL_S03' folder for 'P_AIBTPL_S03' project
And waited while transcoding is finished in folder '/F_AIBTPL_S03' on project 'P_AIBTPL_S03' files page
When I move file 'image10.jpg' from project 'P_AIBTPL_S03' folder '/F_AIBTPL_S03' to new library page
And go to asset 'image10.jpg' info page in Library for collection 'My Assets'NEWLIB
And I 'save' asset 'image10.jpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName | FieldValue |
| Title     | New Title.txt   |
When I go to asset 'New Title.txt' related projects info page in Library for collection 'My Assets' NEWLIB
Then 'should' see following originated project name 'P_AIBTPL_S03' on assets related projects info page in Library NEWLIB


Scenario: check that link to Original Project disappear if project was deleted 2
Meta:@gdam
    @library
Given I created users with following fields:
| Email        |Access|
| U_AIBTPL_S05 |streamlined_library,adkits,folders,library|
And logged in with details of 'U_AIBTPL_S05'
And created 'P_AIBTPL_S05' project
And created '/F_AIBTPL_S05' folder for project 'P_AIBTPL_S05'
And uploaded '/files/image10.jpg' file into '/F_AIBTPL_S05' folder for 'P_AIBTPL_S05' project
And waited while transcoding is finished in folder '/F_AIBTPL_S05' on project 'P_AIBTPL_S05' files page
When I move file 'image10.jpg' from project 'P_AIBTPL_S05' folder '/F_AIBTPL_S05' to new library page
When I select 'P_AIBTPL_S05' project in Project list page
And click element 'DeleteButton' on page 'Projects'
And click element 'Delete' on page 'DeletePopUp'
And I go to asset 'image10.jpg' related projects info page in Library for collection 'My Assets' NEWLIB
Then I should see a message 'No related projects' on assets related projects info page in Library NEWLIB


Scenario: check that link to Original Project, when initial file has been moved (link is changed to latest project)
Meta:@gdam
    @library
Given I created users with following fields:
| Email        |Access|
| U_AIBTPL_S06 |streamlined_library,adkits,folders,library|
And logged in with details of 'U_AIBTPL_S06'
And created 'P_AIBTPL_S06_1' project
And created 'P_AIBTPL_S06_2' project
And created '/F_AIBTPL_S06' folder for project 'P_AIBTPL_S06_1'
And created '/F_AIBTPL_S06' folder for project 'P_AIBTPL_S06_2'
And uploaded '/files/image10.jpg' file into '/F_AIBTPL_S06' folder for 'P_AIBTPL_S06_1' project
And waited while transcoding is finished in folder '/F_AIBTPL_S06' on project 'P_AIBTPL_S06_1' files page
When I move file 'image10.jpg' from project 'P_AIBTPL_S06_1' folder '/F_AIBTPL_S06' to new library page
And go to project 'P_AIBTPL_S06_1' folder '/F_AIBTPL_S06' page
And click on Want to move files to another project link on move/copy file 'image10.jpg' popup
And enter 'P_AIBTPL_S06_2' in search field on move/copy file popup
And select folder 'F_AIBTPL_S06' on move/copy file popup
And click move button on move/copy files popup
And I go to asset 'image10.jpg' related projects info page in Library for collection 'My Assets' NEWLIB
Then 'should' see following originated project name 'P_AIBTPL_S06_2' on assets related projects info page in Library NEWLIB



Scenario: check that link to Original Project disappear when inital file was deleted
Meta:@gdam
    @library
Given I created users with following fields:
| Email        |Access|
| U_AIBTPL_S07 |streamlined_library,adkits,folders,library|
And logged in with details of 'U_AIBTPL_S07'
And created 'P_AIBTPL_S07' project
And created '/F_AIBTPL_S07' folder for project 'P_AIBTPL_S07'
And uploaded '/files/image10.jpg' file into '/F_AIBTPL_S07' folder for 'P_AIBTPL_S07' project
And waited while transcoding is finished in folder '/F_AIBTPL_S07' on project 'P_AIBTPL_S07' files page
When I move file 'image10.jpg' from project 'P_AIBTPL_S07' folder '/F_AIBTPL_S07' to new library page
And delete file 'image10.jpg' in project 'P_AIBTPL_S07' folder '/F_AIBTPL_S07'
And I go to asset 'image10.jpg' info page in Library for collection 'My Assets'NEWLIB
Then I 'should not' see following 'asset information' fields on opened asset info pageNEWLIB:
| FieldName         | FieldValue   |
| Original Project | P_AIBTPL_S07 |
When I go to asset 'image10.jpg' related projects info page in Library for collection 'My Assets' NEWLIB
Then I should see a message 'No related projects' on assets related projects info page in Library NEWLIB


Scenario: check that link is present in case with when assets and projects was shared from another agencies
Meta:@gdam
    @library
Given I created the agency 'A_AIBTPL_S08_1' with default attributes
And created the agency 'A_AIBTPL_S08_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_AIBTPL_S08_2 | new-library-dev-version |
And I added agencies 'A_AIBTPL_S08_1' as a partner to agency 'A_AIBTPL_S08_2'
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_AIBTPL_S08_1 | agency.admin | A_AIBTPL_S08_1 |streamlined_library,adkits,folders,library|
| U_AIBTPL_S08_2 | agency.admin | A_AIBTPL_S08_2 |streamlined_library,adkits,folders,library|
And logged in with details of 'U_AIBTPL_S08_1'
And created 'C_AIBTPL_S08' category
And created 'P_AIBTPL_S08' project
And created '/F_AIBTPL_S08' folder for project 'P_AIBTPL_S08'
And uploaded '/files/image10.jpg' file into '/F_AIBTPL_S08' folder for 'P_AIBTPL_S08' project
And waited while transcoding is finished in folder '/F_AIBTPL_S08' on project 'P_AIBTPL_S08' files page
And added users 'U_AIBTPL_S08_2' to project 'P_AIBTPL_S08' team with role 'project.contributor' expired '12.02.2021'
And moved file 'image10.jpg' from project 'P_AIBTPL_S08' folder '/F_AIBTPL_S08' to new library page
And shared next agencies for following categories:
| CategoryName | AgencyName     |
| C_AIBTPL_S08 | A_AIBTPL_S08_2 |
And logged in with details of 'U_AIBTPL_S08_2'
When I go to the collections page
And I click shared collection 'C_AIBTPL_S08' on the collection page for Agency 'A_AIBTPL_S08_1'NEWLIB
And I select asset 'image10.jpg' for collection 'C_AIBTPL_S08' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to asset 'image10.jpg' related projects info page in Library for collection 'Everything' NEWLIB
Then 'should' see following originated project name 'P_AIBTPL_S08' on assets related projects info page in Library NEWLIB



