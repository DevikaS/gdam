!--NGN-11518
Feature:          User can filter Activity on File/Asset on Activity tab
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check user can filter Activity on File/Asset on Activity tab


Scenario: Check that filter by user works in asset (filter by share_user from current BU/another BU)
Meta:@gdam
@library
Given I created the agency 'A_UCFAOFAA_S01' with default attributes
And created the agency 'A_UCFAOFAA_S02' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| E_UCFAOFAA_S01 | agency.admin | A_UCFAOFAA_S01 |streamlined_library|
| E_UCFAOFAA_S02 | agency.admin | A_UCFAOFAA_S02 |streamlined_library|
And logged in with details of 'E_UCFAOFAA_S01'
When I upload file '/files/image9.jpg' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And create 'C_UCFAOFAA_S01' category
And shared next agencies for following categories:
| CategoryName   | AgencyName     |
| C_UCFAOFAA_S01 | A_UCFAOFAA_S02 |
And login with details of 'E_UCFAOFAA_S02'
And I go to the collections page
And I go to the Shared Collection 'C_UCFAOFAA_S01' from agency 'A_UCFAOFAA_S01' pageNEWLIB
And I select asset 'image9.jpg' for collection 'C_UCFAOFAA_S01' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to asset 'image9.jpg' info page in Library for collection 'My Assets'NEWLIB
And go to asset 'image9.jpg' activity page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And I search on activity page in Library:
|ActivityType   |
|Viewed asset |
Then I 'should' see the following activities on asset 'image9.jpg' activity page for collection 'My Assets'NEWLIB:
| UserName       | Message        | Value |
| E_UCFAOFAA_S02 | Viewed by      |       |



Scenario: Check that filter could be switch off
Meta:@gdam
@library
Given I created the agency 'A_UCFAOFAA_S01' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| E_UCFAOFAA_S03 | agency.admin | A_UCFAOFAA_S01 |streamlined_library|
And logged in with details of 'E_UCFAOFAA_S03'
When I upload file '/files/image9.jpg' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And go to asset 'image9.jpg' activity page in Library for collection 'My Assets'NEWLIB
And I search on activity page in Library:
|ActivityType   |
|Preview transcoded |
Then I 'should' see the following activities on asset 'image9.jpg' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message        | Value |
| E_UCFAOFAA_S03 | Asset transcoded by      |       |
And I 'should not' see the following activities on asset 'image9.jpg' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message        | Value |
| E_UCFAOFAA_S03 | Uploaded by      |       |
When I refresh the page
Then I 'should' see the following activities on asset 'image9.jpg' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message        | Value |
| E_UCFAOFAA_S03 | Uploaded by      |       |



Scenario: Check that filter by activity works with filter by user for files
Meta:@gdam
@projects
Given I created 'P_UCFAOFAA_S03' project
And created 'F_UCFAOFAA_S03' folder for project 'P_UCFAOFAA_S03'
And uploaded '/files/image9.jpg' file into '/F_UCFAOFAA_S03' folder for 'P_UCFAOFAA_S03' project
And waited while preview is available in folder 'F_UCFAOFAA_S03' on project 'P_UCFAOFAA_S03' files page
And opened activity page in project 'P_UCFAOFAA_S03' folder '/F_UCFAOFAA_S03' of file 'image9.jpg'
When I choose next filter on Recent Activity: action 'File was transcoded' and user 'AgencyAdmin' on file activity page
Then I 'should not' see activity where user 'AgencyAdmin' viewed file on current page