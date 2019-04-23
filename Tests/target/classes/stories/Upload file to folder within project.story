!--NGN-259
Feature:          Upload file to folder within project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check uploading file to folder within project

Scenario: Check that file can be uploaded to project folder simple
Meta: @skip
      @gdam
Given I created 'UFP1' project
And created '/UFF1' folder for project 'UFP1'
And I am on project 'UFP1' folder '/UFF1' upload page
When I add to jumploader in folder '/UFF1' of project 'UFP1' following files:
| File                    |
| /files/for_babylon43.7z |
And start jumploader upload in folder '/UFF1' of project 'UFP1' and 'wait' for finish
Then I should see following files inside '/UFF1' folder for 'UFP1' project:
| FileName         |
| for_babylon43.7z |


Scenario: Check that file can be uploaded to project folder extended
Meta: @skip
      @gdam
Given I created 'UFP1' project
And created '/UFF1' folder for project 'UFP1'
And I am on project 'UFP1' folder '/UFF1' upload page
When I add to jumploader in folder '/UFF1' of project 'UFP1' following files:
| File                                         |
| /files/!@#$%^&()_+;,.Document.txt            |
| /files/ÄäDocumentÖö.txt                      |
| /files/13DV-CAPITAL-10.mpg                   |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav |
| /files/GWGTestfile064v3.pdf                  |
| /files/New Text Document.txt                 |
| /files/New'Text'Document.txt                  |
| /files/New&Text&Document.txt                 |
| /files/Català Česky.avi                      |
| /files/Nødhjælp.doc                          |
And start jumploader upload in folder '/UFF1' of project 'UFP1' and 'wait' for finish
Then I should see following files inside '/UFF1' folder for 'UFP1' project:
| FileName                              |
| !@#$%^&()_+;,.Document.txt            |
| ÄäDocumentÖö.txt                      |
| 13DV-CAPITAL-10.mpg                   |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |
| GWGTestfile064v3.pdf                  |
| New Text Document.txt                 |


Scenario: Check that the same file CAN'T be uploaded to project folder from different folders
Meta: @skip
      @gdam
Given I created 'UFP2' project
And created '/UFF2' folder for project 'UFP2'
And I am on project 'UFP2' folder '/UFF2' upload page
When I add to jumploader in folder '/UFF2' of project 'UFP2' following files:
| File                                   |
| /files/New Text Document.txt           |
| /files/duplicate/New Text Document.txt |
And start jumploader upload in folder '/UFF2' of project 'UFP2' and 'wait' for finish
Then I should see following files inside '/UFF2' folder for 'UFP2' project:
| FileName              | FilesCount |
| New Text Document.txt | 1          |


Scenario: Check that file uploading can be paused
Meta: @skip
      @gdam
Given I created 'UFP3' project
And created '/UFF3' folder for project 'UFP3'
And created file '/temp/300mb.file' with length '314572800' bytes
And I am on project 'UFP3' folder '/UFF3' upload page
When I add to jumploader in folder '/UFF3' of project 'UFP3' following files:
| File             |
| /temp/300mb.file |
And start jumploader upload in folder '/UFF3' of project 'UFP3' and 'do not wait' for finish
And stop jumploader upload in folder '/UFF3' of project 'UFP3' after '15000000' bytes uploaded
Then I should see jumploader uploading 'is not' in progress in folder '/UFF3' of project 'UFP3'


Scenario: Check that file uploading can be resumed
Meta: @skip
 @gdam
Given I created 'UFP4' project
And created '/UFF4' folder for project 'UFP4'
And created file '/temp/300mb.file' with length '314572800' bytes
And I am on project 'UFP4' folder '/UFF4' upload page
When I add to jumploader in folder '/UFF4' of project 'UFP4' following files:
| File             |
| /temp/300mb.file |
And start jumploader upload in folder '/UFF4' of project 'UFP4' and 'do not wait' for finish
And stop jumploader upload in folder '/UFF4' of project 'UFP4' after '15000000' bytes uploaded
And resume jumploader upload in folder '/UFF4' of project 'UFP4' and 'do not wait' for finish
Then I should see jumploader uploaded '15000000' bytes in folder '/UFF4' of project 'UFP4'


Scenario: Check that file uploading can be resumed and finished
Meta: @skip
      @gdam
Given I created 'UFP5' project
And created '/UFF5' folder for project 'UFP5'
And created file '/temp/300mb.file' with length '314572800' bytes
And I am on project 'UFP5' folder '/UFF5' upload page
When I add to jumploader in folder '/UFF5' of project 'UFP5' following files:
| File             |
| /temp/300mb.file |
And start jumploader upload in folder '/UFF5' of project 'UFP5' and 'do not wait' for finish
And stop jumploader upload in folder '/UFF5' of project 'UFP5' after '15000000' bytes uploaded
And resume jumploader upload in folder '/UFF5' of project 'UFP5' and 'wait' for finish
Then I 'should' see '300mb.file' file inside '/UFF5' folder for 'UFP5' project


Scenario: Check that file uploading can be paused, select more files and resume upload
Meta: @skip
     @gdam
Given I created 'UFP6' project
And created '/UFF6' folder for project 'UFP6'
And created file '/temp/300mb.file' with length '314572800' bytes
And I am on project 'UFP6' folder '/UFF6' upload page
When I add to jumploader in folder '/UFF6' of project 'UFP6' following files:
| File             |
| /temp/300mb.file |
And start jumploader upload in folder '/UFF6' of project 'UFP6' and 'do not wait' for finish
And stop jumploader upload in folder '/UFF6' of project 'UFP6' after '15000' bytes uploaded
And add to jumploader in folder '/UFF6' of project 'UFP6' following files:
| File                         |
| /files/New Text Document.txt |
And start jumploader upload in folder '/UFF6' of project 'UFP6' and 'do not wait' for finish
And resume jumploader upload in folder '/UFF6' of project 'UFP6' and 'wait' for finish
Then I should see following files inside '/UFF6' folder for 'UFP6' project:
| FileName              |
| 300mb.file            |
| New Text Document.txt |


Scenario: Check that 'Remove All' removes all files from Jumploader
Meta: @skip
      @gdam
Given I created 'UFP7' project
And created '/UFF7' folder for project 'UFP7'
And I am on project 'UFP7' folder '/UFF7' upload page
When I add to jumploader in folder '/UFF7' of project 'UFP7' following files:
| File                         |
| /files/for_babylon43.7z      |
| /files/New Text Document.txt |
And remove all files from jumploader in folder '/UFF7' of project 'UFP7'
Then I should see files count '0' in jumploader in folder '/UFF7' of project 'UFP7'


Scenario: Check that 'Remove' removes specific file from Jumploader
Meta: @skip
      @gdam
Given I created 'UFP8' project
And created '/UFF8' folder for project 'UFP8'
And I am on project 'UFP8' folder '/UFF8' upload page
When I add to jumploader in folder '/UFF8' of project 'UFP8' following files:
| File                         |
| /files/for_babylon43.7z      |
| /files/New Text Document.txt |
And remove file index '1' from jumploader in folder '/UFF8' of project 'UFP8'
Then I should see files count '1' in jumploader in folder '/UFF8' of project 'UFP8'


Scenario: Check that button upload is absent in project without folders
!--NGN-508 NGN-1478
Meta: @skip
     @gdam
Given I created 'UFP9' project
When I open project 'UFP9' files page
Then I should not see upload button for project 'UFP9'