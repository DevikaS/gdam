!-- NGN-1715
Feature:          Presentation - add asset to Existing Presentation
Narrative:
In order to
As a              AgencyAdmin
I want to         Check ability to add asset to Existent Presenation

Meta:
@component presentation


Scenario: Check that asset can be added to Existent presentation (File from project)
Meta:@gdam
@library
Given I created 'P_PAAEP_S01' project
And created '/F_PAAEP_S01' folder for project 'P_PAAEP_S01'
And I uploaded into project 'P_PAAEP_S01' following files:
| FileName         | Path         |
| /images/logo.png | /F_PAAEP_S01 |
And I created following reels:
| Name        | Description |
| R_PAAEP_S01 | DDD         |
And I waited while preview is available in folder '/F_PAAEP_S01' on project 'P_PAAEP_S01' files page
And I moved following files into library:
| ProjectName | Path         | FileName | SubType |
| P_PAAEP_S01 | /F_PAAEP_S01 | logo.png |         |
When I go to the library page for collection 'My Assets'NEWLIB
And I add assets 'logo.png' to existing presentations 'R_PAAEP_S01' from collection 'My Assets' pageNEWLIB
And I go to the presentations assets page 'R_PAAEP_S01'
Then I 'should' see presentation 'R_PAAEP_S01' on the page
And I 'should' see asset 'logo.png' in the current presentation
And I should count '1' thumbnails in the current presentation

Scenario: Check that asset can be added to Existing presentation (File that uploaded to library)
Meta:@gdam
@library
Given I uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And I created following reels:
| Name        | Description |
| R_PAAEP_S02 | DDD         |
And I am on Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
When I add assets 'Fish Ad.mov' to existing presentations 'R_PAAEP_S02' from collection 'Everything' pageNEWLIB
And I go to the presentations assets page 'R_PAAEP_S02'
Then I 'should' see presentation 'R_PAAEP_S02' on the page
And I 'should' see asset 'Fish Ad.mov' in the current presentation
And I should count '1' thumbnails in the current presentation

Scenario: Check that asset can be added to several existing presentation
Meta:@gdam
@library
Given I uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And I created following reels:
| Name          | Description |
| R_PAAEP_S03_1 | DDD         |
| R_PAAEP_S03_2 | DDD         |
And I waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I am on Library page for collection 'Everything'NEWLIB
And I add assets 'Fish Ad.mov' to existing presentations 'R_PAAEP_S03_1,R_PAAEP_S03_2' from collection 'Everything' pageNEWLIB
When I go to the presentations assets page 'R_PAAEP_S03_1'
Then I 'should' see asset 'Fish Ad.mov' in the current presentation
And I should count '1' thumbnails in the current presentation
When I go to the presentations assets page 'R_PAAEP_S03_2'
Then I 'should' see asset 'Fish Ad.mov' in the current presentation
And I should count '1' thumbnails in the current presentation

Scenario: Check that several assets can be added to several existent presentations
Meta:@gdam
@library
Given I created 'P_PAAEP_S04' project
And created '/F_PAAEP_S04' folder for project 'P_PAAEP_S04'
And I uploaded into project 'P_PAAEP_S04' following files:
| FileName             | Path         |
| /images/logo.gif     | /F_PAAEP_S04 |
| /files/_file1.gif   | /F_PAAEP_S04 |
| /files/128_shortname.jpg | /F_PAAEP_S04 |
And I waited while preview is available in folder '/F_PAAEP_S04' on project 'P_PAAEP_S04' files page
And I moved following files into library:
| ProjectName | Path         | FileName      | SubType |
| P_PAAEP_S04 | /F_PAAEP_S04 | logo.gif      |         |
| P_PAAEP_S04 | /F_PAAEP_S04 | _file1.gif   |         |
| P_PAAEP_S04 | /F_PAAEP_S04 | 128_shortname.jpg |         |
And I created following reels:
| Name          | Description |
| R_PAAEP_S04_1 | DDD_1       |
| R_PAAEP_S04_2 | DDD_2       |
| R_PAAEP_S04_3 | DDD_3       |
When I go to the library page for collection 'My Assets'NEWLIB
And I add asset 'logo.gif,_file1.gif,128_shortname.jpg' into existing presentation 'R_PAAEP_S04_1' from collection 'My Assets'NEWLIB
And I add asset 'logo.gif,_file1.gif,128_shortname.jpg' into existing presentation 'R_PAAEP_S04_2' from collection 'My Assets'NEWLIB
And I add asset 'logo.gif,_file1.gif,128_shortname.jpg' into existing presentation 'R_PAAEP_S04_3' from collection 'My Assets'NEWLIB
And I go to the presentations assets page 'R_PAAEP_S04_1'
Then I 'should' see presentation 'R_PAAEP_S04_1,R_PAAEP_S04_2,R_PAAEP_S04_3' on the page
When I go to the presentations assets page 'R_PAAEP_S04_1'
Then I 'should' see asset 'logo.gif,_file1.gif,128_shortname.jpg' in the current presentation
And I should count '3' thumbnails in the current presentation
When I go to the presentations assets page 'R_PAAEP_S04_2'
Then I 'should' see asset 'logo.gif,_file1.gif,128_shortname.jpg' in the current presentation
And I should count '3' thumbnails in the current presentation
When I go to the presentations assets page 'R_PAAEP_S04_3'
Then I 'should' see asset 'logo.gif,_file1.gif,128_shortname.jpg' in the current presentation
And I should count '3' thumbnails in the current presentation
