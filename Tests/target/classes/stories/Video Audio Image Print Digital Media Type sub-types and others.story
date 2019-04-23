!-- NGN-2511
Feature:          Video Audio Image Print Digital Media Type sub-types and others
Narrative:
In order to
As a              AgencyAdmin
I want to         Check video, audio, image, print, digital media type and sub-type

Scenario: Check that Screen metadata field appears on File Info for video files
Meta: @skip
      @gdam
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '<FileName>' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '<FileName>' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
Then I '<ShouldState>' see following 'custom metadata' field labels on opened file info page:
| FieldName |
| Screen    |

Examples:
| FileName                    | ShouldState |
| /files/13DV-CAPITAL-10.mpg  | should      |
| /files/test.mp3             | should not  |
| /files/GWGTestfile064v3.pdf | should not  |
| /files/index.html           | should not  |
| /files/128_shortname.jpg    | should not  |


Scenario: Check that the Screen metadata field accepts correct values
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
Then I 'should' see that combo box 'Screen' has following values on Edit File popup on file '13DV-CAPITAL-10.mpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1':
| FieldValue                       |
| Spot                             |
| Spons Billboard                  |
| Spons Break bumper               |
| Spons Billboard and break bumper |
| Trailer                          |
| Ident & Blip                     |
| Programme                        |
| Music Promo                      |
| Infomercial                      |


Scenario: Check that the saved value of Screen metadata field is displayed correctly
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '13DV-CAPITAL-10.mpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName    | FieldValue |
| Screen       | <Value>    |
| Clock number | CNVAIPDMT1 |
And refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName | FieldValue |
| Screen    | <Value>    |

Examples:
| Value       |
| Spot        |
| Infomercial |


Scenario: Check that the Sub-Type metadata field accepts correct values
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '<FileName>' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
Then I 'should' see that combo box 'Media sub-type' has following values '<Values>' on Edit File popup on file '<FileName>' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'

Examples:
| FileName                   | Values                                                                                                                                |
| /files/13DV-CAPITAL-10.mpg | Generic Master,Cinema Master,Titled Master,Elements,Distribution Master,Raw Video,Rushes,Stock Footage                                |
| /files/test.mp3            | Radio Final Mix,Music Track (please pull Id3 Tag's),Library Tracks (ID3 tags),TV,Cinema,Elements,V/O,MUSIC,M&E,SFX,FINAL MIX          |
| /files/index.html          | Video Spot,Publication,Out of Home,Rich Media,Application,Flash,Banner (All Types),Web Page,Skin,Device,Interactive,Social,3D,Toolkit |
| /files/128_shortname.jpg   | Print,Generic master,Titled master,Photography,Illustration,Stock Images                                                              |


Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for video file
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '13DV-CAPITAL-10.mpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
| Clock number   | CNVAIPDMT2 |
And refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |

Examples:
| Value          |
| Generic Master |
| Stock Footage  |


Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for audio file
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/test.mp3' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file 'test.mp3' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
And refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |

Examples:
| Value                               |
| Music Track (please pull Id3 Tag's) |
| FINAL MIX                           |


Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for image file
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/128_shortname.jpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '128_shortname.jpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
And refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |

Examples:
| Value        |
| Print        |
| Stock Images |


Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for digital file
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/index.html' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file 'index.html' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
And refresh the page
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |

Examples:
| Value       |
| Video Spot  |
| Publication |



Scenario: Check that the Sub-Type metadata field accepts correct values in Library
Meta:@gdam
@library
Given I am on Library pageNEWLIB
And uploaded asset '<AssetPath>' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset '<AssetName>' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And I click Edit link on asset info pageNEWLIB
Then I 'should' see following dropdown fields with values under section 'Technical' on opened Edit asset popup NEWLIB:
| FieldName      | FieldValue   |
| Media sub-type | <Values>     |
Examples:
|AssetType | AssetPath                  | AssetName          | Values                                                                                                                                   |
| video    | /files/13DV-CAPITAL-10.mpg | 13DV-CAPITAL-10.mpg| Generic Master,Cinema Master,Titled Master,Elements,Distribution Master,Raw Video,Rushes,Stock Footage,Director's Cut                    |
| audio    | /files/test.mp3            | test.mp3           | Radio Final Mix,Music Track (please pull Id3 Tag's),Library Tracks (ID3 tags),TV,Cinema,Elements,V/O,MUSIC,M&E,SFX,FINAL MIX             |
| digital  | /files/index.html          | index.html         | Video Spot,Publication,Out of Home,Rich Media,Application,Flash,Banner (All Types),Web Page,Skin,Device,Interactive,Social,3D,Toolkit    |
| image    | /files/128_shortname.jpg   | 128_shortname.jpg  | Generic master,Illustration,Photography,Print,Stock Images,Titled master                                                                 |


Scenario: Check that the Sub-Type metadata field accepts correct values in Library on Edit all selected popup
Meta:@gdam
@library
Given I am on Library pageNEWLIB
And uploaded asset '<AssetPath>' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I go to the Library page for collection 'My Assets'NEWLIB
When I select asset '<AssetName>' in the 'My Assets'  library pageNEWLIB
And I go to edit Asset Metadata page on 'My Assets' collection
Then I 'should' see following 'dropdown' fields with expected values for assetType '<AssetType>' on opened Edit all selected asset popupNEWLIB:
| FieldName      | FieldValue   |
| Media sub-type | <Values>     |

Examples:
|AssetType | AssetPath                  | AssetName          | Values                                                                                                                                   |
| audio    | /files/test.mp3            | test.mp3           | Radio Final Mix,Music Track (please pull Id3 Tag's),Library Tracks (ID3 tags),TV,Cinema,Elements,V/O,MUSIC,M&E,SFX,FINAL MIX             |
| digital  | /files/index.html          | index.html         | Video Spot,Publication,Out of Home,Rich Media,Application,Flash,Banner (All Types),Web Page,Skin,Device,Interactive,Social,3D,Toolkit    |
| image    | /files/128_shortname.jpg   | 128_shortname.jpg  | Generic master,Illustration,Photography,Print,Stock Images,Titled master                                                                 |



Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for digital file on New Assets form
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/index.html' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file 'index.html' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
And send file 'index.html' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
Then I should see following data on add file to library page:
| Title      | Media Type | Sub Media Type |
| index.html | digital    | <Value>        |

Examples:
| Value |
| Flash |
| Skin  |

Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for image file on New Assets form
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/128_shortname.jpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '128_shortname.jpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
And send file '128_shortname.jpg' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
Then I should see following data on add file to library page:
| Title             | Media Type | Sub Media Type |
| 128_shortname.jpg | image      | <Value>        |

Examples:
| Value        |
| Print        |
| Stock Images |

Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for audio file on New Assets form
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/test.mp3' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file 'test.mp3' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
And send file 'test.mp3' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
Then I should see following data on add file to library page:
| Title    | Media Type | Sub Media Type |
| test.mp3 | audio      | <Value>        |

Examples:
| Value           |
| Radio Final Mix |
| FINAL MIX       |


Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for video file on New Assets form
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '13DV-CAPITAL-10.mpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
| Clock number   | CNVAIPDMT3 |
And send file '13DV-CAPITAL-10.mpg' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
Then I should see following data on add file to library page:
| Title               | Media Type | Sub Media Type |
| 13DV-CAPITAL-10.mpg | video      | <Value>        |

Examples:
| Value         |
| Cinema Master |
| Rushes        |


Scenario: Check that the saved value of Screen metadata field is displayed correctly for video file on New Assets form
Meta:@gdam
@projects
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '13DV-CAPITAL-10.mpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName    | FieldValue |
| Screen       | <Value>    |
| Clock number | CNVAIPDMT4 |
And send file '13DV-CAPITAL-10.mpg' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
Then I should see following data on add file to library page:
| Title               | Media Type | Screen  |
| 13DV-CAPITAL-10.mpg | video      | <Value> |

Examples:
| Value        |
| Ident & Blip |
| Music Promo  |


Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for digital file after moving to Library
Meta:@gdam
@library
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/index.html' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file 'index.html' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
And send file 'index.html' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
And wait for '2' seconds
And fill following data on add file to library page:
| ID   |
| <Id> |
And click Save button on Add file to new library page
And go to asset '<Id>' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |

Examples:
| Value       | Id            |
| Video Spot  | VAIPDMTFF19_1 |
| Publication | VAIPDMTFF19_5 |

Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for image file after moving to Library
Meta:@gdam
@library
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/128_shortname.jpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '128_shortname.jpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
And send file '128_shortname.jpg' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
And fill following data on add file to library page:
| ID   |
| <Id> |
And click Save button on Add file to new library page
And go to asset '<Id>' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |

Examples:
| Value        | Id            |
| Print        | VAIPDMTFF20_1 |
| Stock Images | VAIPDMTFF20_6 |


Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for audio file after moving to Library
Meta:@gdam
@library
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/test.mp3' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file 'test.mp3' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
And send file 'test.mp3' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
And wait for '5' seconds
And fill following data on add file to library page:
| ID   |
| <Id> |
And click Save button on Add file to new library page
And go to asset '<Id>' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |

Examples:
| Value           | Id            |
| Radio Final Mix | VAIPDMTFF21_1 |
| M&E             | VAIPDMTFF21_9 |

Scenario: Check that the saved value of Sub-Type metadata field is displayed correctly for video file after moving to Library
Meta:@gdam
@library
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '13DV-CAPITAL-10.mpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |
| Clock number   | CNVAIPDMT5 |
And send file '13DV-CAPITAL-10.mpg' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
And wait for '3' seconds
And fill following data on add file to library page:
| ID   |
| <Id> |
And click Save button on Add file to new library page
And go to asset '<Id>' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue |
| Media sub-type | <Value>    |

Examples:
| Value          | Id            |
| Generic Master | VAIPDMTFF22_1 |
| Stock Footage  | VAIPDMTFF22_8 |


Scenario: Check that the saved value of Screen metadata field is displayed correctly for video file after moving to Library
Meta:@gdam
@library
Given I created 'VAIPDMTP1' project
And created '/VAIPDMTF1' folder for project 'VAIPDMTP1'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/VAIPDMTF1' folder for 'VAIPDMTP1' project
And waited while transcoding is finished in folder '/VAIPDMTF1' on project 'VAIPDMTP1' files page
When I go to file '13DV-CAPITAL-10.mpg' info page in folder '/VAIPDMTF1' project 'VAIPDMTP1'
And 'save' file info by next information:
| FieldName    | FieldValue  |
| Screen       | <Value>     |
| Clock number | CNVAIPDMT6  |
And send file '13DV-CAPITAL-10.mpg' on project 'VAIPDMTP1' folder '/VAIPDMTF1' page to Library
And wait for '5' seconds
And fill following data on add file to library page:
| ID   |
| <Id> |
And click Save button on Add file to new library page
And go to asset '<Id>' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue |
| Screen    | <Value>    |

Examples:
| Value       | Id            |
| Spot        | VAIPDMTFF23_1 |
| Infomercial | VAIPDMTFF23_9 |
