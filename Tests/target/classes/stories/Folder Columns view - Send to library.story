!--NGN-11518
Feature:          User can filter Activity on File/Asset on Activity tab
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check user can filter Activity on File/Asset on Activity tab


Scenario: check that button 'Send to library' (on Folder Columns view) is available only for user accord his permissions
!--FAB-762
Meta:@library
     @gdam
     @bug
Given I created the agency 'A_FCVSTL_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| E_FCVSTL_S01 | agency.admin | A_FCVSTL_S01 |
And logged in with details of 'GlobalAdmin'
When update agency 'A_FCVSTL_S01' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Finder | true       |
And login with details of 'E_FCVSTL_S01'
And create 'P_FCVSTL_S01' project
And create '/F_FCVSTL_S01' folder for project 'P_FCVSTL_S01'
And upload '/files/image9.jpg' file into '/F_FCVSTL_S01' folder for 'P_FCVSTL_S01' project
And wait while transcoding is finished on project 'P_FCVSTL_S01' in folder '/F_FCVSTL_S01' for 'image9.jpg' file
And go to project 'P_FCVSTL_S01' folder '/F_FCVSTL_S01' page
Then I 'should' see column mode for files on opened folder page



Scenario: check 'Send to library' workflow
!--FAB-762
Meta:@gdam
     @bug
     @library
Given I created the agency 'A_FCVSTL_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| E_FCVSTL_S01 | agency.admin | A_FCVSTL_S01 |library,streamlined_library,folders,adkits|
And logged in with details of 'GlobalAdmin'
When update agency 'A_FCVSTL_S01' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Finder | true       |
And login with details of 'E_FCVSTL_S01'
And create 'P_FCVSTL_S01' project
And create '/F_FCVSTL_S01' folder for project 'P_FCVSTL_S01'
And upload '/files/image9.jpg' file into '/F_FCVSTL_S01' folder for 'P_FCVSTL_S01' project
And wait while transcoding is finished on project 'P_FCVSTL_S01' in folder '/F_FCVSTL_S01' for 'image9.jpg' file
And go to project 'P_FCVSTL_S01' folder '/F_FCVSTL_S01' page
And select file 'image9.jpg' from folder 'F_FCVSTL_S01' in column mode on opened folder page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And click on element 'SaveButton'
And go to  Library pageNEWLIB
Then I should see assets 'image9.jpg' count '1' in collection 'Everything'NEWLIB


