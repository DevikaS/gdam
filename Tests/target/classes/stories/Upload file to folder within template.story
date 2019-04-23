!--NGN-259
Feature:          Upload file to folder within template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check uploading file to folder within template

Scenario: Check that file can be uploaded to template folder
Meta: @skip
      @gdam
Given I created 'UFT1' template
And created '/UFF1' folder for template 'UFT1'
And I am on template 'UFT1' folder '/UFF1' upload page
When I add to jumploader in folder '/UFF1' of template 'UFT1' following files:
| File                                         |
| /files/for_babylon43.7z                      |
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
And start jumploader upload in folder '/UFF1' of template 'UFT1' and 'wait' for finish
Then I should see following files inside '/UFF1' folder for 'UFT1' template:
| FileName                              |
| for_babylon43.7z                      |
| !@#$%^&()_+;,.Document.txt            |
| ÄäDocumentÖö.txt                      |
| 13DV-CAPITAL-10.mpg                   |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |
| GWGTestfile064v3.pdf                  |
| New Text Document.txt                 |


Scenario: Check that the same file CAN'T be uploaded to template folder from different folders
Meta: @skip
      @gdam
Given I created 'UFT2' template
And created '/UFF2' folder for template 'UFT2'
And I am on template 'UFT2' folder '/UFF2' upload page
When I add to jumploader in folder '/UFF2' of template 'UFT2' following files:
| File                                   |
| /files/New Text Document.txt           |
| /files/duplicate/New Text Document.txt |
And start jumploader upload in folder '/UFF2' of template 'UFT2' and 'wait' for finish
Then I should see following files inside '/UFF2' folder for 'UFT2' template:
| FileName              | FilesCount |
| New Text Document.txt | 1          |


Scenario: Check that file uploading can be paused
Meta: @skip
      @gdam
Given I created 'UFT3' template
And created '/UFF3' folder for template 'UFT3'
And created file '/temp/300mb.file' with length '314572800' bytes
And I am on template 'UFT3' folder '/UFF3' upload page
When I add to jumploader in folder '/UFF3' of template 'UFT3' following files:
| File             |
| /temp/300mb.file |
And start jumploader upload in folder '/UFF3' of template 'UFT3' and 'do not wait' for finish
And stop jumploader upload in folder '/UFF3' of template 'UFT3' after '15000000' bytes uploaded
Then I should see jumploader uploading 'is not' in progress in folder '/UFF3' of template 'UFT3'


Scenario: Check that file uploading can be resumed
Meta: @skip
      @gdam
Given I created 'UFT4' template
And created '/UFF4' folder for template 'UFT4'
And created file '/temp/300mb.file' with length '314572800' bytes
And I am on template 'UFT4' folder '/UFF4' upload page
When I add to jumploader in folder '/UFF4' of template 'UFT4' following files:
| File             |
| /temp/300mb.file |
And start jumploader upload in folder '/UFF4' of template 'UFT4' and 'do not wait' for finish
And stop jumploader upload in folder '/UFF4' of template 'UFT4' after '150000000' bytes uploaded
And resume jumploader upload in folder '/UFF4' of template 'UFT4' and 'do not wait' for finish
Then I should see jumploader uploaded '150000000' bytes in folder '/UFF4' of template 'UFT4'


Scenario: Check that file uploading can be resumed and finished
Meta: @skip
      @gdam
Given I created 'UFT5' template
And created '/UFF5' folder for template 'UFT5'
And created file '/temp/300mb.file' with length '314572800' bytes
And I am on template 'UFT5' folder '/UFF5' upload page
When I add to jumploader in folder '/UFF5' of template 'UFT5' following files:
| File             |
| /temp/300mb.file |
And start jumploader upload in folder '/UFF5' of template 'UFT5' and 'do not wait' for finish
And stop jumploader upload in folder '/UFF5' of template 'UFT5' after '15000000' bytes uploaded
And resume jumploader upload in folder '/UFF5' of template 'UFT5' and 'wait' for finish
Then I should see '300mb.file' file inside '/UFF5' folder for 'UFT5' template


Scenario: Check that file uploading can be paused, select more files and resume upload
Meta: @skip
      @gdam
Given I created 'UFT6' template
And created '/UFF6' folder for template 'UFT6'
And created file '/temp/300mb.file' with length '314572800' bytes
And I am on template 'UFT6' folder '/UFF6' upload page
When I add to jumploader in folder '/UFF6' of template 'UFT6' following files:
| File             |
| /temp/300mb.file |
And start jumploader upload in folder '/UFF6' of template 'UFT6' and 'do not wait' for finish
And stop jumploader upload in folder '/UFF6' of template 'UFT6' after '15000' bytes uploaded
And add to jumploader in folder '/UFF6' of template 'UFT6' following files:
| File                         |
| /files/New Text Document.txt |
And start jumploader upload in folder '/UFF6' of template 'UFT6' and 'do not wait' for finish
And resume jumploader upload in folder '/UFF6' of template 'UFT6' and 'wait' for finish
Then I should see following files inside '/UFF6' folder for 'UFT6' template:
| FileName              |
| 300mb.file            |
| New Text Document.txt |


Scenario: Check that 'Remove All' removes all files from Jumploader
Meta: @skip
      @gdam
Given I created 'UFT7' template
And created '/UFF7' folder for template 'UFT7'
And I am on template 'UFT7' folder '/UFF7' upload page
When I add to jumploader in folder '/UFF7' of template 'UFT7' following files:
| File                         |
| /files/for_babylon43.7z      |
| /files/New Text Document.txt |
And remove all files from jumploader in folder '/UFF7' of template 'UFT7'
Then I should see files count '0' in jumploader in folder '/UFF7' of template 'UFT7'


Scenario: Check that 'Remove' removes specific file from Jumploader
Meta: @skip
      @gdam
Given I created 'UFT8' template
And created '/UFF8' folder for template 'UFT8'
And I am on template 'UFT8' folder '/UFF8' upload page
When I add to jumploader in folder '/UFF8' of template 'UFT8' following files:
| File                         |
| /files/for_babylon43.7z      |
| /files/New Text Document.txt |
And remove file index '1' from jumploader in folder '/UFF8' of template 'UFT8'
Then I should see files count '1' in jumploader in folder '/UFF8' of template 'UFT8'