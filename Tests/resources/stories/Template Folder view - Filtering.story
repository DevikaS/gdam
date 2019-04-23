!--NGN-526 NGN-2266
Feature:          Template Folder view - Filtering
Narrative:
In order to
As a              AgencyAdmin
I want to         Check filter in folders on template view

Scenario: check all files are appear in folder when all filters 'off'
Meta:@gdam
@projects
Given I created 'PFFT1' template
And created '/PFFF1' folder for template 'PFFT1'
And uploaded into template 'PFFT1' following files:
| FileName                    | Path   |
| /images/logo.jpeg           | /PFFF1 |
| /images/logo.png            | /PFFF1 |
| /files/GWGTestfile064v3.pdf | /PFFF1 |
| /files/video10s.avi         | /PFFF1 |
And I am on template 'PFFT1' folder '/PFFF1' page
When I wait while transcoding is finished in folder '/PFFF1' on template 'PFFT1' files page
And select media type filters '' on template 'PFFT1' folder '/PFFF1' page
Then I should see following files inside '/PFFF1' folder for 'PFFT1' template:
| FileName             |
| logo.jpeg            |
| logo.png             |
| GWGTestfile064v3.pdf |
| video10s.avi         |


Scenario: check that correct files are appear in folder when filter Video/Audio/Documents/Images/Other 'on' for template
Meta:@gdam
@projects
!--This test fails until FAB-200 is fixed
Given I created 'PFFT2' template
And created '/PFFF2' folder for template 'PFFT2'
And uploaded into template 'PFFT2' following files:
| FileName                                     | Path   |
| /images/logo.jpeg                            | /PFFF2 |
| /images/logo.png                             | /PFFF2 |
| /images/logo.bmp                             | /PFFF2 |
| /files/ISO_12233-reschart.svg                | /PFFF2 |
| /files/CCITT_1.TIF                           | /PFFF2 |
| /files/GWGTestfile064v3.pdf                  | /PFFF2 |
| /files/video10s.avi                          | /PFFF2 |
| /files/test.mp3                              | /PFFF2 |
| /files/test.ogg                              | /PFFF2 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /PFFF2 |
| /files/index.html                            | /PFFF2 |
| /files/Fish Ad.mov                           | /PFFF2 |
| /files/13DV-CAPITAL-10.mpg                   | /PFFF2 |
And I am on template 'PFFT2' folder '/PFFF2' page
When I wait while transcoding is finished in folder '/PFFF2' on template 'PFFT2' files page
And select media type filters '<Filter>' on template 'PFFT2' folder '/PFFF2' page
Then I should see files '<Files>' inside '/PFFF2' folder for 'PFFT2' template

Examples:
| Filter        | Files                                                                                                |
| VIDEO,AUDIO   | video10s.avi,Fish Ad.mov,13DV-CAPITAL-10.mpg,test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav |
| PRINT,IMAGE   | GWGTestfile064v3.pdf,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp                  |
| VIDEO,DIGITAL | video10s.avi,Fish Ad.mov,13DV-CAPITAL-10.mpg,index.html                                              |
| AUDIO,PRINT   | test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,GWGTestfile064v3.pdf                         |


Scenario: check that sub-type greyed out when some/all filter 'on'
Meta:@gdam
@projects
Given I created 'PFFT3' template
And created '/PFFF3' folder for template 'PFFT3'
When I go to template 'PFFT3' folder '/PFFF3' page
And select media type filters '<Filter>' on template 'PFFT3' folder '/PFFF3' page
Then I '<Should>' see element 'DisabledMediaSubTypeCombo' on page 'FilesPage'

Examples:
| Filter                          | Should     |
| IMAGE                           | should not |
| VIDEO                           | should not |
| VIDEO,IMAGE                     | should     |


Scenario: check that correct files are appear in folder when filter 'on' and sub-type 'on' for template
Meta:@gdam
@projects
Given I created 'PFFT2' template
And created '/PFFF2' folder for template 'PFFT2'
And uploaded into template 'PFFT2' following files:
| FileName                                     | Path   |
| /images/logo.jpeg                            | /PFFF2 |
| /images/logo.png                             | /PFFF2 |
| /images/logo.bmp                             | /PFFF2 |
| /files/ISO_12233-reschart.svg                | /PFFF2 |
| /files/CCITT_1.TIF                           | /PFFF2 |
| /files/GWGTestfile064v3.pdf                  | /PFFF2 |
| /files/video10s.avi                          | /PFFF2 |
| /files/test.mp3                              | /PFFF2 |
| /files/test.ogg                              | /PFFF2 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /PFFF2 |
| /files/index.html                            | /PFFF2 |
| /files/Fish Ad.mov                           | /PFFF2 |
| /files/13DV-CAPITAL-10.mpg                   | /PFFF2 |
And I am on template 'PFFT2' folder '/PFFF2' page
When I wait while transcoding is finished in folder '/PFFF2' on template 'PFFT2' files page
And set media subtype for following files in template 'PFFT2':
| Path   | FileName                              | SubType        |
| /PFFF2 | video10s.avi                          | Generic Master |
| /PFFF2 | 13DV-CAPITAL-10.mpg                   | Cinema Master  |
| /PFFF2 | test.mp3                              | TV             |
| /PFFF2 | test.ogg                              | TV             |
| /PFFF2 | Tesco_Trade_Meat_Wine_PANTS939015.wav | MUSIC          |
| /PFFF2 | logo.jpeg                             | Generic Master |
| /PFFF2 | logo.png                              | Generic Master |
| /PFFF2 | ISO_12233-reschart.svg                | Generic Master |
| /PFFF2 | CCITT_1.TIF                           | Print          |
And select media type filters '<Filter>' on template 'PFFT2' folder '/PFFF2' page
And select media subtype filter '<Subtype>' on template 'PFFT2' folder '/PFFF2' page
Then I should see files '<Files>' inside '/PFFF2' folder for 'PFFT2' template

Examples:
| Filter | Subtype        | Files                                     |
| VIDEO  | Generic Master | video10s.avi                              |
| AUDIO  | TV             | test.mp3,test.ogg                         |
| IMAGE  | Generic master | logo.jpeg,logo.png,ISO_12233-reschart.svg |


Scenario: check that filters 'off' when user change folder
Meta:@gdam
@projects
Given I created 'PFFT1' template
And created in 'PFFT1' template next folders:
| folder |
| /PFFF1 |
| /PFFF2 |
And uploaded into template 'PFFT1' following files:
| FileName                    | Path   |
| /images/logo.jpeg           | /PFFF1 |
| /images/logo.png            | /PFFF1 |
| /files/GWGTestfile064v3.pdf | /PFFF1 |
| /files/video10s.avi         | /PFFF1 |
And I am on template 'PFFT1' folder '/PFFF1' page
When I wait while transcoding is finished in folder '/PFFF1' on template 'PFFT1' files page
And go to template 'PFFT1' folder '/PFFF2' page
And select media type filters 'VIDEO,AUDIO,PRINT,IMAGE,DIGITAL' on template 'PFFT1' folder '/PFFF2' page
And go to template 'PFFT1' folder '/PFFF1' page
Then I should see following media type filter status on template 'PFFT1' folder '/PFFF1' page:
| Media Type | Enabled |
| VIDEO      | false   |
| AUDIO      | false   |
| PRINT      | false   |
| IMAGE      | false   |
| DIGITAL    | false   |
And I should see following files inside '/PFFF1' folder for 'PFFT1' template:
| FileName             |
| logo.jpeg            |
| logo.png             |
| GWGTestfile064v3.pdf |
| video10s.avi         |