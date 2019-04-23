!--NGN-2474
Feature:          Move action on file activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check move action on file activity log


Scenario: Check that move action is displayed on Activity tab within project (file info page)
Meta:@gdam
@projects
Given I created 'MAFAP1' project
And created in 'MAFAP1' project next folders:
| folder    |
| /MAFAF1_1 |
| /MAFAF1_2 |
And uploaded into project 'MAFAP1' following files:
| FileName               | Path      |
| /files/atCalcImage.jpg | /MAFAF1_1 |
And waited while transcoding is finished in folder '/MAFAF1_1' on project 'MAFAP1' files page
And moved '/files/atCalcImage.jpg' file into 'MAFAF1_2' folder from folder 'MAFAF1_1' for 'MAFAP1' project
And I am on project 'MAFAP1' folder '/MAFAF1_2' page
And waited for '10' seconds
When I go to file '/files/atCalcImage.jpg' info page in folder '/MAFAF1_2' project 'MAFAP1'
Then I 'should' see on Activity tab for file '/files/atCalcImage.jpg' in folder '/MAFAF1_2' project 'MAFAP1' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage                                                      |
| AgencyAdmin | EMPTY | moved        | moved file from "MAFAP1/MAFAP1/MAFAF1_1" to "MAFAP1/MAFAP1/MAFAF1_2" |


Scenario: Check that move action is displayed for move of file on Recent user's activity within project (project team page)
Meta:@gdam
@projects
Given I created 'MAFAP2' project
And created in 'MAFAP2' project next folders:
| folder    |
| /MAFAF2_1 |
| /MAFAF2_2 |
And uploaded into project 'MAFAP2' following files:
| FileName               | Path      |
| /files/atCalcImage.jpg | /MAFAF2_1 |
And waited while transcoding is finished in folder '/MAFAF2_1' on project 'MAFAP2' files page
And moved '/files/atCalcImage.jpg' file into '/MAFAF2_2' folder from folder '/MAFAF2_1' for 'MAFAP2' project
And waited for '5' seconds
When I go to project 'MAFAP2' teams page
And refresh the page
Then I 'should' see activity for user 'AgencyAdmin' on project team page with message 'moved file from "MAFAP2/MAFAP2/MAFAF2_1" to "MAFAP2/MAFAP2/MAFAF2_2"' and value 'atCalcImage.jpg'


Scenario: Check that move action is displayed for move of file on Recent user's activity within project (project overview page)
Meta:@gdam
@projects
Given I created 'MAFAP3' project
And created in 'MAFAP3' project next folders:
| folder    |
| /MAFAF3_1 |
| /MAFAF3_2 |
And uploaded into project 'MAFAP3' following files:
| FileName               | Path      |
| /files/atCalcImage.jpg | /MAFAF3_1 |
And waited while transcoding is finished in folder '/MAFAF3_1' on project 'MAFAP3' files page
And moved '/files/atCalcImage.jpg' file into '/MAFAF3_2' folder from folder '/MAFAF3_1' for 'MAFAP3' project
And refreshed the page
When I go to project 'MAFAP3' overview page
Then I 'should' see activity where user 'AgencyAdmin' moved file 'atCalcImage.jpg' from folder 'MAFAP3/MAFAP3/MAFAF3_1' to folder 'MAFAP3/MAFAP3/MAFAF3_2' on project 'MAFAP3' on Overview page


Scenario: Check that move action is displayed on Activity tab within template (file info page)
!--NGN-2822
Meta:@gdam
@projects
Given I created 'MAFAT4' template
And created in 'MAFAT4' template next folders:
| folder    |
| /MAFAF4_1 |
| /MAFAF4_2 |
And uploaded into template 'MAFAT4' following files:
| FileName               | Path      |
| /files/atCalcImage.jpg | /MAFAF4_1 |
And waited while transcoding is finished in folder '/MAFAF4_1' on template 'MAFAT4' files page
And move '/files/atCalcImage.jpg' file into '/MAFAF4_2' folder from folder '/MAFAF4_1' for 'MAFAT4' template
And I am on template 'MAFAT4' folder '/MAFAF4_2' page
And waited for '10' seconds
When I go to file 'atCalcImage.jpg' info page in folder '/MAFAF4_2' template 'MAFAT4'
Then I 'should' see on Activity tab for file '/files/atCalcImage.jpg' in folder '/MAFAF4_2' template 'MAFAT4' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage                                                      |
| AgencyAdmin | EMPTY | moved        | moved file from "MAFAT4/MAFAT4/MAFAF4_1" to "MAFAT4/MAFAT4/MAFAF4_2" |


Scenario: Check that move action is displayed for move of file on Recent user's activity within template (template team page)
!--NGN-2824 NGN-2764
Meta: @skip
      @gdam
Given I created 'MAFAT5' template
And created in 'MAFAT5' template next folders:
| folder    |
| /MAFAF5_1 |
| /MAFAF5_2 |
And uploaded into template 'MAFAT5' following files:
| FileName               | Path      |
| /files/atCalcImage.jpg | /MAFAF5_1 |
And waited while transcoding is finished in folder '/MAFAF5_1' on template 'MAFAT5' files page
And move '/files/atCalcImage.jpg' file into '/MAFAF5_2' folder from folder '/MAFAF5_1' for 'MAFAT5' template
And refreshed the page
When I go to template 'MAFAT5' teams page
Then I 'should' see activity for user 'AgencyAdmin' on template team page with message 'moved the file from 'MAFAT5/MAFAF5_1' to 'MAFAT5/MAFAF5_2'' and value 'atCalcImage.jpg'


Scenario: Check that changed file title is displayed on activity added early
!--NGN-2284
Meta: @skip
      @gdam
Given I created 'MAFAP6' project
And created in 'MAFAP6' project next folders:
| folder    |
| /MAFAF6_1 |
| /MAFAF6_2 |
And uploaded into project 'MAFAP6' following files:
| FileName               | Path      |
| /files/atCalcImage.jpg | /MAFAF6_1 |
And waited while transcoding is finished in folder '/MAFAF6_1' on project 'MAFAP6' files page
And moved '/files/atCalcImage.jpg' file into '/MAFAF6_2' folder from folder '/MAFAF6_1' for 'MAFAP6' project
And refreshed the page
When I changing title of file '/files/atCalcImage.jpg' to following title 'New Text Document changed.txt' on project 'MAFAP6' folder '/MAFAF6_2' page
And go to project 'MAFAP6' folder '/MAFAF6_2' page
And I go to file '/files/New Text Document changed.txt' info page in folder '/MAFAF6_2' project 'MAFAP6'
Then I 'should' see on Activity tab for file '/files/New Text Document changed.txt' in folder '/MAFAF6_2' project 'MAFAP6' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage                                              |
| AgencyAdmin | EMPTY | moved        | moved the file from '/MAFAP6/MAFAF6_1' to '/MAFAP6/MAFAF6_2' |


Scenario: Check that changed logo, first name, last name is displayed on activity added early after move
!--NGN-2408
Meta: @skip
      @gdam
Given I created users with following fields:
| FirstName | LastName | Email  | Role         | Logo |
| UserFN7   | UserLN7  | MAFAU7 | agency.admin | GIF  |
And I logged in with details of 'MAFAU7'
And created 'MAFAP7' project
And created in 'MAFAP7' project next folders:
| folder    |
| /MAFAF7_1 |
| /MAFAF7_2 |
And uploaded into project 'MAFAP7' following files:
| FileName               | Path      |
| /files/atCalcImage.jpg | /MAFAF7_1 |
And moved '/files/atCalcImage.jpg' file into '/MAFAF7_2' folder from folder '/MAFAF7_1' for 'MAFAP7' project
When I edit user 'MAFAU7' with following fields:
| FirstName | LastName | Logo | Email  | Role         |
| first7    | last7    | PNG  | MAFAU7 | agency.admin |
And go to project 'MAFAP7' folder '/MAFAF7_2' page
And go to file '/files/atCalcImage.jpg' info page in folder '/MAFAF7_2' project 'MAFAP7'
Then I 'should' see on Activity tab for file '/files/atCalcImage.jpg' in folder '/MAFAF7_2' project 'MAFAP7' following recent user's activity :
| User   | Logo | ActivityType | ActivityMessage                                              |
| MAFAU7 | PNG  | moved        | moved the file from '/MAFAP7/MAFAF7_1' to '/MAFAP7/MAFAF7_2' |


Scenario: Check that after click on username , current user is selected on the team page
!-- NGN-1285
!--As per QA-678 Modified test
Meta:@gdam
@projects
Given I created 'MAFAP9' project
And created in 'MAFAP9' project next folders:
| folder    |
| /MAFAF9_1 |
| /MAFAF9_2 |
And uploaded into project 'MAFAP9' following files:
| FileName               | Path      |
| /files/atCalcImage.jpg | /MAFAF9_1 |
And moved '/files/atCalcImage.jpg' file into '/MAFAF9_2' folder from folder '/MAFAF9_1' for 'MAFAP9' project
When I go to project 'MAFAP9' folder '/MAFAF9_2' page
And go to file '/files/atCalcImage.jpg' info page in folder '/MAFAF9_2' project 'MAFAP9'
And click on user name 'AgencyAdmin' in Activity tab on open uploaded file '/files/atCalcImage.jpg' in folder '/MAFAF9_2' project 'MAFAP9'
Then I 'should not' see selected user 'AgencyAdmin' into project 'MAFAP9' team page


Scenario: Check that move file activity is displayed for project owner from current agency
!--NGN-2788
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName  | Email   | Role         | Logo |
| AdminFN10 | AdminLN10 | MAFAU10 | agency.admin | GIF  |
| UserFN10  | UserLN10  | MAFAU11 | agency.user  | PNG  |
And I logged in with details of 'MAFAU10'
And created 'MAFAP10' project
And created in 'MAFAP10' project next folders:
| folder     |
| /MAFAF10_1 |
| /MAFAF10_2 |
And uploaded into project 'MAFAP10' following files:
| FileName               | Path       |
| /files/atCalcImage.jpg | /MAFAF10_1 |
And waited while transcoding is finished in folder '/MAFAF10_1' on project 'MAFAP10' files page
And moved 'atCalcImage.jpg' file into '/MAFAF10_2' folder from folder '/MAFAF10_1' for 'MAFAP10' project
And added user 'MAFAU11' to Address book
And I am on project 'MAFAP10' settings page
When I edit the following fields for 'MAFAP10' project:
| Name    | Administrators |
| MAFAP10 | MAFAU11        |
And click on element 'SaveButton'
And login with details of 'MAFAU11'
And go to project 'MAFAP10' folder '/MAFAF10_2' page
And go to file 'atCalcImage.jpg' info page in folder '/MAFAF10_2' project 'MAFAP10'
Then I 'should' see on Activity tab for file '/files/atCalcImage.jpg' in folder '/MAFAF10_2' project 'MAFAP10' following recent user's activity :
| User    | Logo | ActivityType | ActivityMessage                                                            |
| MAFAU10 | GIF  | moved        | moved file from "MAFAP10/MAFAP10/MAFAF10_1" to "MAFAP10/MAFAP10/MAFAF10_2" |


Scenario: Check that move file activity is displayed for project owner from another agency
!--NGN-2788
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName  | Email   | Role         | Logo | Agency        |
| AdminFN11 | AdminLN11 | MAFAU12 | agency.admin | GIF  | ##            |
| UserFN11  | UserLN11  | MAFAU13 | agency.user  | PNG  | AnotherAgency |
And I logged in with details of 'MAFAU12'
And added user 'MAFAU13' into address book
And created 'MAFAP11' project
And created in 'MAFAP11' project next folders:
| folder     |
| /MAFAF11_1 |
| /MAFAF11_2 |
And uploaded into project 'MAFAP11' following files:
| FileName               | Path       |
| /files/atCalcImage.jpg | /MAFAF11_1 |
And waited while transcoding is finished in folder '/MAFAF11_1' on project 'MAFAP11' files page
And moved 'atCalcImage.jpg' file into '/MAFAF11_2' folder from folder '/MAFAF11_1' for 'MAFAP11' project
And I am on project 'MAFAP11' settings page
When I edit the following fields for 'MAFAP11' project:
| Name    | Administrators |
| MAFAP11 | MAFAU13        |
And click on element 'SaveButton'
And login with details of 'MAFAU13'
And go to project 'MAFAP11' folder '/MAFAF11_2' page
And go to file 'atCalcImage.jpg' info page in folder '/MAFAF11_2' project 'MAFAP11'
Then I 'should' see on Activity tab for file '/files/atCalcImage.jpg' in folder '/MAFAF11_2' project 'MAFAP11' following recent user's activity :
| User    | Logo | ActivityType | ActivityMessage                                                            |
| MAFAU12 | GIF  | moved        | moved file from "MAFAP11/MAFAP11/MAFAF11_1" to "MAFAP11/MAFAP11/MAFAF11_2" |