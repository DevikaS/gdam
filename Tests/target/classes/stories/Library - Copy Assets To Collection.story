Meta:

Feature:          Library - Copy Assets To Collection
Narrative:
In order to
As a              AgencyAdmin
I want to         Check filter in folders on library view

Scenario: check that Assets can be copied from One Collection to Other
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish1-Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_ACTC_S01' from collection 'Everything'NEWLIB
And I go to  library page for collection 'Everything'NEWLIB
And I select asset 'test.mp3' in the 'Everything'  library pageNEWLIB
And wait for '2' seconds
And copy to 'C_ACTC_S01'  from 'Everything' library page
And I go to  Library page for collection 'C_ACTC_S01'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov,test.mp3' in the collection 'C_ACTC_S01'NEWLIB
And I 'should not' see assets 'test.ogg' in the collection 'C_ACTC_S01'NEWLIB

Scenario: check that correct files are appear in categoty when filter Video/Audio/Documents/Images/Other/Digital 'on'
Meta:@gdam
@library
Given I created 'P_LFS_S2_1' project
And I created '/F_LFS_S2_1' folder for project 'P_LFS_S2_1'
And I uploaded into project 'P_LFS_S2_1' following files:
| FileName                                     | Path        |
| /files/Fish Ad.mov                           | /F_LFS_S2_1 |
| /files/index.html                            | /F_LFS_S2_1 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /F_LFS_S2_1 |
| /files/test.ogg                              | /F_LFS_S2_1 |
| /files/test.mp3                              | /F_LFS_S2_1 |
| /files/video10s.avi                          | /F_LFS_S2_1 |
| /files/GWGTestfile064v3.pdf                  | /F_LFS_S2_1 |
| /files/CCITT_1.TIF                           | /F_LFS_S2_1 |
| /files/ISO_12233-reschart.svg                | /F_LFS_S2_1 |
| /images/logo.bmp                             | /F_LFS_S2_1 |
| /images/logo.png                             | /F_LFS_S2_1 |
| /images/logo.jpeg                            | /F_LFS_S2_1 |
And I am on project 'P_LFS_S2_1' folder '/F_LFS_S2_1' page
And waited while transcoding is finished in folder '/F_LFS_S2_1' on project 'P_LFS_S2_1' files page
And I moved following files into library:
| ProjectName | Path        | FileName                              | SubType |
| P_LFS_S2_1  | /F_LFS_S2_1 | Fish Ad.mov                           |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | index.html                            |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | Tesco_Trade_Meat_Wine_PANTS939015.wav |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | test.ogg                              |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | test.mp3                              |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | video10s.avi                          |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | GWGTestfile064v3.pdf                  |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | CCITT_1.TIF                           |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | ISO_12233-reschart.svg                |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | logo.bmp                              |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | logo.png                              |         |
| P_LFS_S2_1  | /F_LFS_S2_1 | logo.jpeg
When I go to the Library page for collection 'Everything'NEWLIB
And I switch 'on' media type filter '<Filter>' for collection 'Everything' on the page LibraryNEWLIB
Then I 'should' see assets '<Assets>' in the collection 'Everything'NEWLIB

Examples:
| Filter                          | Assets                                                                                                                                                                                              | AssetsExclude                                                                                                                                                                            |
| VIDEO                           | video10s.avi,Fish Ad.mov                                                                                                                                                    | test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,GWGTestfile064v3.pdf,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp,index.html                                   |
| AUDIO                           | test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav                                                                                                                                             | video10s.avi,Fish Ad.mov,GWGTestfile064v3.pdf,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp,index.html                                              |
| PRINT                           | GWGTestfile064v3.pdf                                                                                                                                                                                | video10s.avi,Fish Ad.mov,test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp,index.html           |
| IMAGE                           | logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp                                                                                                                                      | video10s.avi,Fish Ad.mov,test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,GWGTestfile064v3.pdf,index.html                                                     |
| DIGITAL                         | index.html                                                                                                                                                                                          | video10s.avi,Fish Ad.mov,test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,GWGTestfile064v3.pdf,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp |
| AUDIO,PRINT                     | test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,GWGTestfile064v3.pdf                                                                                                                        | video10s.avi,Fish Ad.mov,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp,index.html                                                                   |
| IMAGE,AUDIO,VIDEO,PRINT,DIGITAL | video10s.avi,Fish Ad.mov,test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,index.html,GWGTestfile064v3.pdf,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp | test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,GWGTestfile064v3.pdf,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp,index.html |                                                                                                                                                                                          |

