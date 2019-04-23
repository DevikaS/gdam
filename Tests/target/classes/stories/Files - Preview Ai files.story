!--NGN-1963
Feature:          Files - Preview Ai files
Narrative:
In order to
As a              AgencyAdmin
I want to         Check preview for Ai files

Scenario: Check that preview for Ai files available in Folders
Meta:@gdam
@projects
Given I created 'FpfaF_P1' project
And created '/FpfaF_F1' folder for project 'FpfaF_P1'
And uploaded 'files/4002c.ai' file into '/FpfaF_F1' folder for 'FpfaF_P1' project
And waited while preview is available in folder '/FpfaF_F1' on project 'FpfaF_P1' files page
Then I 'should' see preview file '4002c.ai' on project 'FpfaF_P1' folder '/FpfaF_F1' page
And I should see following files metadata on project 'FpfaF_P1' overview page:
| FileName | Type |
| 4002c.ai | AI   |
And I should see preview on file details page for file '4002c.ai' folder '/FpfaF_F1' project 'FpfaF_P1'


Scenario: Check that Ai preview is available after upload revision
Meta:@gdam
@projects
Given I created 'FpfaF_P2' project
And created '/FpfaF_F2' folder for project 'FpfaF_P2'
And uploaded 'files/4002c.ai' file into '/FpfaF_F2' folder for 'FpfaF_P2' project
And waited while preview is available in folder '/FpfaF_F2' on project 'FpfaF_P2' files page
When I upload into project 'FpfaF_P2' following revisions:
| FileName        | Path      | MasterFileName |
| /files/4002c.ai | /FpfaF_F2 | 4002c.ai       |
And wait while preview is available in folder '/FpfaF_F2' on project 'FpfaF_P2' files page
Then I 'should' see preview file '4002c.ai' on project 'FpfaF_P2' folder '/FpfaF_F2' page
And I should see following files metadata on project 'FpfaF_P2' overview page:
| FileName | Type |
| 4002c.ai | AI   |
And I should see preview on file details page for file '4002c.ai' folder '/FpfaF_F2' project 'FpfaF_P2'



Scenario: Check that preview for Ai files available in Library
Meta:@gdam
@library
Given I am on  Library pageNEWLIB
And I uploaded asset 'files/4002c.ai' into libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset '4002c.ai'NEWLIB
When I go to  library page for collection 'Everything'NEWLIB
Then I 'should' see preview for asset '4002c.ai' in collection 'Everything'NEWLIB
When I go to asset '4002c.ai' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'specification' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| File name | 4002c.ai    |
| File type  | AI        |
And I should see preview on the library assets info page for asset '4002c.ai' in collection 'Everything'NEWLIB


Scenario: Check that Ai preview is available after moving to library
Meta:@gdam
@library
Given I created 'FpfaF_P3' project
And created '/FpfaF_F3' folder for project 'FpfaF_P3'
And uploaded 'files/4002c.ai' file into '/FpfaF_F3' folder for 'FpfaF_P3' project
And waited while preview is available in folder '/FpfaF_F3' on project 'FpfaF_P3' files page
And I moved following files into library:
| ProjectName | Path      | FileName |
| FpfaF_P3    | /FpfaF_F3 | 4002c.ai |
When I go to library page for collection 'My Assets'NEWLIB
Then I 'should' see preview for asset '4002c.ai' in collection 'My Assets'NEWLIB
When I go to asset '4002c.ai' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'specification' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| File name | 4002c.ai    |
| File type  | AI        |
And I should see preview on the library assets info page for asset '4002c.ai' in collection 'My Assets'NEWLIB

Scenario: Check that Ai preview is available in shared presentation
Meta:@gdam
@library
Given I created 'FpfaF_U1' User
And I am on  Library page for collection 'My Assets'NEWLIB
And I uploaded asset 'files/4002c.ai' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for asset '4002c.ai'NEWLIB
And I add assets '4002c.ai' to new presentation 'FpfaF_Pres2' from collection 'My Assets' pageNEWLIB
When I send presentation 'FpfaF_Pres2' to user 'FpfaF_U1' with personal message 'some message'
And login with details of 'FpfaF_U1'
And I open link from letter with subject 'FpfaF_Pres2' for presentation
Then I should see on the presentation 'FpfaF_Pres2' oreview page count previews '1' of assets

Scenario: Check that preview for Ai files available in Presentations
Meta:@gdam
@library
Given I am on  Library page for collection 'My Assets'NEWLIB
And I uploaded asset 'files/4002c.ai' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for asset '4002c.ai'NEWLIB
And I add assets '4002c.ai' to new presentation 'FpfaF_Pres1' from collection 'My Assets' pageNEWLIB
When I go to the presentations assets page 'FpfaF_Pres1'
Then I 'should' see preview for asset '4002c.ai' on opened assets presentation page
And I should see for presentation 'FpfaF_Pres1' assets page following files metadata :
| FileName | Type |
| 4002c.ai | AI   |
Then I should see on the presentation 'FpfaF_Pres1' oreview page count previews '1' of assets

