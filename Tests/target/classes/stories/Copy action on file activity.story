!--NGN-2474
Feature:          Copy action on file activity
Narrative:
In order to
As a              AgencyAdmin
I want to         check copy action on file activity log

Scenario: Check that copy action is displayed for copy of file on Activity tab within project (file info page)
Meta:@gdam
      @projects
Given I created 'CAFAP1' project
And created in 'CAFAP1' project next folders:
| folder    |
| /CAFAF1_1 |
| /CAFAF1_2 |
And uploaded into project 'CAFAP1' following files:
| FileName          | Path      |
| /files/_file1.gif | /CAFAF1_1 |
And waited while transcoding is finished in folder '/CAFAF1_1' on project 'CAFAP1' files page
And copy '/files/_file1.gif' file into '/CAFAF1_2' folder from folder '/CAFAF1_1' for 'CAFAP1' project
And refreshed the page
And I am on project 'CAFAP1' folder '/CAFAF1_2' page
When I go to file '/files/_file1.gif' info page in folder '/CAFAF1_2' project 'CAFAP1'
Then I 'should' see on Activity tab for file '/files/_file1.gif' in folder '/CAFAF1_2' project 'CAFAP1' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage                                                       |
| AgencyAdmin | EMPTY | copied       | copied file from "CAFAP1/CAFAP1/CAFAF1_1" to "CAFAP1/CAFAP1/CAFAF1_2" |


Scenario: Check that copy action is displayed for copy of file on Recent user's activity within project (project team page)
Meta:@gdam
     @bug
     @projects
!--FAB-495
Given I created 'CAFAP2' project
And created in 'CAFAP2' project next folders:
| folder    |
| /CAFAF2_1 |
| /CAFAF2_2 |
And uploaded into project 'CAFAP2' following files:
| FileName          | Path      |
| /files/_file1.gif | /CAFAF2_1 |
And waited while transcoding is finished in folder '/CAFAF2_1' on project 'CAFAP2' files page
And copy '/files/_file1.gif' file into '/CAFAF2_2' folder from folder '/CAFAF2_1' for 'CAFAP2' project
And refreshed the page
When I go to project 'CAFAP2' teams page
Then I 'should' see activity for user 'AgencyAdmin' on project team page with message 'copied file from "CAFAP2/CAFAP2/CAFAF2_1" to "CAFAP2/CAFAP2/CAFAF2_2"' and value '_file1.gif'


Scenario: Check that copy action is displayed for copy of file on Recent user's activity within project (project overview page)
Meta:@gdam
     @bug
     @projects
!--FAB-495
Given I created 'CAFAP3' project
And created in 'CAFAP3' project next folders:
| folder    |
| /CAFAF3_1 |
| /CAFAF3_2 |
And uploaded into project 'CAFAP3' following files:
| FileName          | Path      |
| /files/_file1.gif | /CAFAF3_1 |
And copy '/files/_file1.gif' file into '/CAFAF3_2' folder from folder '/CAFAF3_1' for 'CAFAP3' project
And refreshed the page
When I go to project 'CAFAP3' overview page
Then I 'should' see activity for user 'AgencyAdmin' on project 'CAFAP3' overview page with message 'copied file from "CAFAP3/CAFAP3/CAFAF3_1" to "CAFAP3/CAFAP3/CAFAF3_2"' and value '_file1.gif'


Scenario: Check that copy action is displayed for copy of file on Activity tab within template (file info page)
Meta:@gdam
     @projects
Given I created 'CAFAT4' template
And created in 'CAFAT4' template next folders:
| folder    |
| /CAFAF4_1 |
| /CAFAF4_2 |
And uploaded into template 'CAFAT4' following files:
| FileName          | Path      |
| /files/_file1.gif | /CAFAF4_1 |
And waited while transcoding is finished in folder '/CAFAF4_1' on template 'CAFAT4' files page
And copy '/files/_file1.gif' file into '/CAFAF4_2' folder from folder '/CAFAF4_1' for 'CAFAT4' template
And refreshed the page
And I am on template 'CAFAT4' folder '/CAFAF4_2' page
When I go to file '/files/_file1.gif' info page in folder '/CAFAF4_2' template 'CAFAT4'
Then I 'should' see on Activity tab for file '/files/_file1.gif' in folder '/CAFAF4_2' template 'CAFAT4' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage                                                       |
| AgencyAdmin | EMPTY | copied       | copied file from "CAFAT4/CAFAT4/CAFAF4_1" to "CAFAT4/CAFAT4/CAFAF4_2" |


Scenario: Check that copy action is displayed for copy of file on Recent user's activity within template (template team page)
!--NGN-2764
Meta: @skip
      @gdam
Given I created 'CAFAP5' template
And created in 'CAFAP5' template next folders:
| folder    |
| /CAFAF5_1 |
| /CAFAF5_2 |
And uploaded into template 'CAFAP5' following files:
| FileName          | Path      |
| /files/_file1.gif | /CAFAF5_1 |
And waited while transcoding is finished in folder '/CAFAF5_1' on template 'CAFAP5' files page
And copy '/files/_file1.gif' file into '/CAFAF5_2' folder from folder '/CAFAF5_1' for 'CAFAP5' template
And refreshed the page
When I go to template 'CAFAP5' teams page
Then I 'should' see activity for user 'AgencyAdmin' on template team page with message 'copied the file from 'CAFAP5/CAFAP5/CAFAF5_1' to 'CAFAP5/CAFAP5/CAFAF5_2'' and value '_file1.gif'


Scenario: Check that copy action is displayed for original file on Activity tab within project
Meta:@gdam
     @projects
Given I created 'CAFAP6' project
And created in 'CAFAP6' project next folders:
| folder    |
| /CAFAF6_1 |
| /CAFAF6_2 |
And uploaded into project 'CAFAP6' following files:
| FileName          | Path      |
| /files/_file1.gif | /CAFAF6_1 |
And waited while transcoding is finished in folder '/CAFAF6_1' on project 'CAFAP6' files page
And copy '/files/_file1.gif' file into '/CAFAF6_2' folder from folder '/CAFAF6_1' for 'CAFAP6' project
And refreshed the page
And I am on project 'CAFAP6' folder '/CAFAF6_1' page
When I go to file '/files/_file1.gif' info page in folder '/CAFAF6_1' project 'CAFAP6'
Then I 'should' see on Activity tab for file '/files/_file1.gif' in folder '/CAFAF6_1' project 'CAFAP6' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage                                                       |
| AgencyAdmin | EMPTY | copied       | copied file from "CAFAP6/CAFAP6/CAFAF6_1" to "CAFAP6/CAFAP6/CAFAF6_2" |


Scenario: Check that copy action is displayed for original file on Activity tab within template
Meta:@gdam
     @projects
!--FAB-401 open bug exist
Given I created 'CAFAT7' template
And created in 'CAFAT7' template next folders:
| folder    |
| /CAFAF7_1 |
| /CAFAF7_2 |
And uploaded into template 'CAFAT7' following files:
| FileName          | Path      |
| /files/_file1.gif | /CAFAF7_1 |
And waited while transcoding is finished in folder '/CAFAF7_1' on template 'CAFAT7' files page
And copy '/files/_file1.gif' file into '/CAFAF7_2' folder from folder '/CAFAF7_1' for 'CAFAT7' template
And refreshed the page
And I am on template 'CAFAT7' folder '/CAFAF7_1' page
When I go to file '/files/_file1.gif' info page in folder '/CAFAF7_1' template 'CAFAT7'
Then I 'should' see on Activity tab for file '/files/_file1.gif' in folder '/CAFAF7_1' template 'CAFAT7' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage                                                       |
| AgencyAdmin | EMPTY | copied       | copied file from "CAFAT7/CAFAT7/CAFAF7_1" to "CAFAT7/CAFAT7/CAFAF7_2" |


Scenario: Check that after click on username, current user is selected on the team page
Meta:@gdam
     @projects
!-- NGN-1285
!--As per QA-678 Modified test
Given I created 'CAFAP11' project
And created in 'CAFAP11' project next folders:
| folder     |
| /CAFAF11_1 |
| /CAFAF11_2 |
And uploaded into project 'CAFAP11' following files:
| FileName          | Path       |
| /files/_file1.gif | /CAFAF11_1 |
And copy '/files/_file1.gif' file into '/CAFAF11_2' folder from folder '/CAFAF11_1' for 'CAFAP11' project
When I go to project 'CAFAP11' folder '/CAFAF11_2' page
And go to file '/files/_file1.gif' info page in folder '/CAFAF11_2' project 'CAFAP11'
And click on user name 'AgencyAdmin' in Activity tab on open uploaded file '/files/_file1.gif' in folder '/CAFAF11_2' project 'CAFAP11'
Then I 'should not' see selected user 'AgencyAdmin' into project 'CAFAP11' team page


Scenario: Check that copy file activity is displayed for project owner from current agency
Meta:@gdam
     @projects
!--NGN-2788
Given I created users with following fields:
| FirstName | LastName  | Email   | Role         | Logo |
| AdminFN12 | AdminLN12 | CAFAU12 | agency.admin | GIF  |
| UserFN12  | UserLN12  | CAFAU13 | agency.user  | PNG  |
And I logged in with details of 'CAFAU12'
And created 'CAFAP12' project
And created in 'CAFAP12' project next folders:
| folder     |
| /CAFAF12_1 |
| /CAFAF12_2 |
And uploaded into project 'CAFAP12' following files:
| FileName          | Path       |
| /files/_file1.gif | /CAFAF12_1 |
And waited while transcoding is finished in folder '/CAFAF12_1' on project 'CAFAP12' files page
And copy '/files/_file1.gif' file into '/CAFAF12_2' folder from folder '/CAFAF12_1' for 'CAFAP12' project
And added user 'CAFAU13' into address book
And I am on project 'CAFAP12' settings page
When I edit the following fields for 'CAFAP12' project:
| Name    | Administrators |
| CAFAP12 | CAFAU13        |
And click on element 'SaveButton'
And login with details of 'CAFAU13'
And wait for '5' seconds
And go to project 'CAFAP12' folder '/CAFAF12_2' page
And go to file '/files/_file1.gif' info page in folder '/CAFAF12_2' project 'CAFAP12'
Then I 'should' see on Activity tab for file '/files/_file1.gif' in folder '/CAFAF12_2' project 'CAFAP12' following recent user's activity :
| User    | Logo | ActivityType | ActivityMessage                                                             |
| CAFAU12 | GIF  | copied       | copied file from "CAFAP12/CAFAP12/CAFAF12_1" to "CAFAP12/CAFAP12/CAFAF12_2" |


Scenario: Check that copy file activity is displayed for project owner from another agency
Meta:@gdam
     @projects
!--NGN-2788
Given I created users with following fields:
| FirstName | LastName  | Email   | Role         | Logo | Agency        |
| AdminFN13 | AdminLN13 | CAFAU14 | agency.admin | GIF  | ##            |
| UserFN13  | UserLN13  | CAFAU15 | agency.user  | PNG  | AnotherAgency |
And I logged in with details of 'CAFAU14'
And added user 'CAFAU15' into address book
And created 'CAFAP13' project
And created in 'CAFAP13' project next folders:
| folder     |
| /CAFAF13_1 |
| /CAFAF13_2 |
And uploaded into project 'CAFAP13' following files:
| FileName          | Path       |
| /files/_file1.gif | /CAFAF13_1 |
And waited while transcoding is finished in folder '/CAFAF13_1' on project 'CAFAP13' files page
And copy '/files/_file1.gif' file into '/CAFAF13_2' folder from folder '/CAFAF13_1' for 'CAFAP13' project
And I am on project 'CAFAP13' settings page
When I edit the following fields for 'CAFAP13' project:
| Name    | Administrators |
| CAFAP13 | CAFAU15        |
And click on element 'SaveButton'
And login with details of 'CAFAU15'
And go to project 'CAFAP13' folder '/CAFAF13_2' page
And go to file '/files/_file1.gif' info page in folder '/CAFAF13_2' project 'CAFAP13'
Then I 'should' see on Activity tab for file '/files/_file1.gif' in folder '/CAFAF13_2' project 'CAFAP13' following recent user's activity :
| User    | Logo | ActivityType | ActivityMessage                                                             |
| CAFAU14 | GIF  | copied       | copied file from "CAFAP13/CAFAP13/CAFAF13_1" to "CAFAP13/CAFAP13/CAFAF13_2" |


Scenario: Check that for copy of file previous activity shouldn't be visible
Meta:@gdam
     @projects
Given I created 'CAFAP14' project
And created in 'CAFAP14' project next folders:
| folder     |
| /CAFAF14_1 |
| /CAFAF14_2 |
And uploaded into project 'CAFAP14' following files:
| FileName         | Path       |
| /files/logo3.png | /CAFAF14_1 |
And copy '/files/logo3.png' file into '/CAFAF14_2' folder from folder '/CAFAF14_1' for 'CAFAP14' project
And I am on project 'CAFAP14' folder '/CAFAF14_2' page
When I go to file '/files/logo3.png' info page in folder '/CAFAF14_2' project 'CAFAP14'
Then I 'should' see on Activity tab for file '/files/logo3.png' in folder '/CAFAF14_2' project 'CAFAP14' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage                                                             |
| AgencyAdmin | EMPTY | copied       | copied file from "CAFAP14/CAFAP14/CAFAF14_1" to "CAFAP14/CAFAP14/CAFAF14_2" |
And should see count '1' activity on activity tab 'Activity' for file '/files/logo3.png' in folder '/CAFAF14_2' project 'CAFAP14'