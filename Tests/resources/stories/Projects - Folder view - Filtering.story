!--NGN-526
Feature:          Projects - Folder view - Filtering
Narrative:
In order to
As a              AgencyAdmin
I want to         Check filter in folders on project view

Scenario: check all files are appear in folder when all filters 'off'
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| PFFP2 | PFFPJ2     |
And created '/PFFF2' folder for project 'PFFP2'
And uploaded into project 'PFFP2' following files:
| FileName                    | Path   |
| /images/logo.jpeg           | /PFFF2 |
| /images/logo.png            | /PFFF2 |
| /files/GWGTestfile064v3.pdf | /PFFF2 |
| /files/video10s.avi         | /PFFF2 |
And I am on project 'PFFP2' folder '/PFFF2' page
When I wait while transcoding is finished in folder '/PFFF2' on project 'PFFP2' files page
And select media type filters '' on project 'PFFP2' folder '/PFFF2' page
Then I should see following files inside '/PFFF2' folder for 'PFFP2' project:
| FileName             |
| logo.jpeg            |
| logo.png             |
| GWGTestfile064v3.pdf |
| video10s.avi         |


Scenario: check that filters 'off' when user change folder
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| PFFP2 | PFFPJ2     |
And created in 'PFFP2' project next folders:
| folder |
| /PFFF2 |
| /PFFF3 |
And uploaded into project 'PFFP2' following files:
| FileName                    | Path   |
| /images/logo.jpeg           | /PFFF2 |
| /images/logo.png            | /PFFF2 |
| /files/GWGTestfile064v3.pdf | /PFFF2 |
| /files/video10s.avi         | /PFFF2 |
And I am on project 'PFFP2' folder '/PFFF2' page
When I wait while transcoding is finished in folder '/PFFF2' on project 'PFFP2' files page
And go to project 'PFFP2' folder '/PFFF3' page
And wait for '3' seconds
And select media type filters 'VIDEO,AUDIO,PRINT,IMAGE,DIGITAL' on project 'PFFP2' folder '/PFFF3' page
And go to project 'PFFP2' folder '/PFFF2' page
Then I should see following media type filter status on project 'PFFP2' folder '/PFFF2' page:
| Media Type | Enabled |
| VIDEO      | false   |
| AUDIO      | false   |
| PRINT      | false   |
| IMAGE      | false   |
| DIGITAL    | false   |
And I should see following files inside '/PFFF2' folder for 'PFFP2' project:
| FileName             |
| logo.jpeg            |
| logo.png             |
| GWGTestfile064v3.pdf |
| video10s.avi         |


Scenario: check that correct files are appear in folder when filter Video/Audio/Documents/Images/Other 'on' for project
Meta:@gdam
@projects
!--NGN-12866
Given I created following projects:
| Name  | Job Number |
| PFFP2 | PFFPJ2     |
And created '/PFFF2' folder for project 'PFFP2'
And uploaded into project 'PFFP2' following files:
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
| /files/test6.jar                             | /PFFF2 |
| /files/syscodes.csv                          | /PFFF2 |
And I am on project 'PFFP2' folder '/PFFF2' page
When I wait while transcoding is finished in folder '/PFFF2' on project 'PFFP2' files page
And select media type filters '<Filter>' on project 'PFFP2' folder '/PFFF2' page
Then I should see files '<Files>' inside '/PFFF2' folder for 'PFFP2' project

Examples:
| Filter                          | Files                                                                                                                                                                                               |
| VIDEO                           | video10s.avi,Fish Ad.mov,13DV-CAPITAL-10.mpg                                                                                                                                                        |
| AUDIO                           | test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav                                                                                                                                             |
| PRINT                           | GWGTestfile064v3.pdf                                                                                                                                                                                |
| IMAGE                           | logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp                                                                                                                                      |
| DIGITAL                         | index.html                                                                                                                                                                                          |
| VIDEO,AUDIO                     | video10s.avi,Fish Ad.mov,13DV-CAPITAL-10.mpg,test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav                                                                                                |
| OTHER                           | test6.jar,syscodes.csv                                                                                                                                                                              |
| IMAGE,AUDIO,VIDEO,PRINT,DIGITAL | video10s.avi,Fish Ad.mov,13DV-CAPITAL-10.mpg,test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,index.html,GWGTestfile064v3.pdf,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp |


Scenario: check that sub-type greyed out when some/all filter 'on'
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| PFFP3 | PFFPJ3     |
And created '/PFFF3' folder for project 'PFFP3'
When I go to project 'PFFP3' folder '/PFFF3' page
And select media type filters '<Filter>' on project 'PFFP3' folder '/PFFF3' page
Then I '<Should>' see element 'DisabledMediaSubTypeCombo' on page 'FilesPage'

Examples:
| Filter                          | Should     |
| IMAGE                           | should not |
| VIDEO                           | should not |
| VIDEO,IMAGE                     | should     |
| VIDEO,AUDIO,PRINT,IMAGE,DIGITAL | should     |


Scenario: check that correct files are appear in folder when filter 'on' and sub-type 'on' for project
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| PFFP2 | PFFPJ2     |
And created '/PFFF2' folder for project 'PFFP2'
And uploaded into project 'PFFP2' following files:
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
And I am on project 'PFFP2' folder '/PFFF2' page
When I wait while transcoding is finished in folder '/PFFF2' on project 'PFFP2' files page
And set media subtype for following files in project 'PFFP2':
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
And select media type filters '<Filter>' on project 'PFFP2' folder '/PFFF2' page
And select media subtype filter '<Subtype>' on project 'PFFP2' folder '/PFFF2' page
Then I should see files '<Files>' inside '/PFFF2' folder for 'PFFP2' project

Examples:
| Filter | Subtype        | Files                                     |
| VIDEO  | Generic Master | video10s.avi                              |
| VIDEO  | Cinema Master  | 13DV-CAPITAL-10.mpg                       |
| AUDIO  | TV             | test.mp3,test.ogg                         |
| AUDIO  | MUSIC          | Tesco_Trade_Meat_Wine_PANTS939015.wav     |
| IMAGE  | Generic master | logo.jpeg,logo.png,ISO_12233-reschart.svg |
| IMAGE  | Print          | CCITT_1.TIF                               |



