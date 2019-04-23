Feature: Check that if user clicks on Originated in Project link in related files of asset moved from folder to Library he is taken to folder with original file
Narrative:
In order to work with the system
As a AgencyAdmin
I want to check that Originated in Project link works


Scenario: check that if user clicks on "Originated in Project" link in related files of asset moved from folder to Library he is taken to folder with original file
Meta:@gdam
     @library
Given I created the agency 'BU_OIP_S1' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |
| U_OIP_S1 | agency.admin | BU_OIP_S1    |
And logged in with details of 'U_OIP_S1'
And created 'P_OIP_S1' project
And created '/F_OIP_S1' folder for project 'P_OIP_S1'
And uploaded into project 'P_OIP_S1' following files:
| FileName         | Path      |
| /images/logo.gif | /F_OIP_S1 |
And waited while preview is available in folder '/F_OIP_S1' on project 'P_OIP_S1' files page
When I move file 'logo.gif' from project 'P_OIP_S1' folder '/F_OIP_S1' to new library page
And go to the Library page for collection 'Everything'NEWLIB
And click related project 'P_OIP_S1' on asset 'logo.gif' related projects info page in Library for collection 'Everything' NEWLIB
Then I 'should' be on the project 'P_OIP_S1' overview page
