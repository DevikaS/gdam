!--NGN-7616 NGN-9383
Feature:          User locale - Date format
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user sees dates in Date format according to his selected locale

Scenario: Check that user sees date in format according to his locale on Dashboard page
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Language       |
| <UserEmail> | <UserLanguage> |
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And created '/F_ULDF_S01' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULDF_S01' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ULDF_S01' on project '<ProjectName>' files page
When I go to Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName    | Message                  | Value                                                  |
| <UserEmail> | <FileActivityMessage>    | P_ULDF_S01_1/P_ULDF_S01_1/F_ULDF_S01/128_shortname.jpg |
| <UserEmail> | <ProjectActivityMessage> | <ProjectName>                                          |

Examples:
| UserEmail    | UserLanguage | ProjectName  | FileActivityMessage                | ProjectActivityMessage |
| U_ULDF_S01_1 | en-au        | P_ULDF_S01_1 | uploaded 1 files 128_shortname.jpg | created project        |


Scenario: Check that user sees date in format according to his locale in activity on Project Overview page
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Language       |
| <UserEmail> | <UserLanguage> |
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And waited for '5' seconds
And refreshed the page
Then I 'should' see activity for user '<UserEmail>' on project '<ProjectName>' overview page with message '<ProjectActivityMessage>' and value '<ProjectName>'

Examples:
| UserEmail    | UserLanguage | ProjectName  | ProjectActivityMessage |
| U_ULDF_S02_1 | en-beam-us   | P_ULDF_S02_1 | created project        |
| U_ULDF_S02_2 | es-es        | P_ULDF_S02_2 | creó el proyecto       |
| U_ULDF_S02_3 | es-ar        | P_ULDF_S02_3 | proyecto creado        |


Scenario: Check that user sees date in format according to his locale in activity on Project Team page
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Language       |
| <UserEmail> | <UserLanguage> |
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And waited for '5' seconds
When I go to project '<ProjectName>' teams page
And refresh the page
Then I 'should' see activity for user '<UserEmail>' on project team page with message '<ProjectActivityMessage>' and value '<ProjectName>'

Examples:
| UserEmail    | UserLanguage | ProjectName  | ProjectActivityMessage |
| U_ULDF_S03_1 | en-gb        | P_ULDF_S03_1 | created project        |
| U_ULDF_S03_2 | de           | P_ULDF_S03_2 | hat Projekt erstellt   |
| U_ULDF_S03_3 | es-ar        | P_ULDF_S03_3 | proyecto creado        |


Scenario: Check that user sees date in format according to his locale in comment on File Comments page
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Language       |
| <UserEmail> | <UserLanguage> |
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And created '/F_ULDF_S04' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULDF_S04' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ULDF_S04' on project '<ProjectName>' files page
And on the file comments page project '<ProjectName>' and folder '/F_ULDF_S04' and file '128_shortname.jpg'
When I add comment 'hi' into current file
Then I 'should' see comment 'hi' for current file

Examples:
| UserEmail    | UserLanguage | ProjectName  |
| U_ULDF_S04_1 | fr           | P_ULDF_S04_1 |
| U_ULDF_S04_2 | de           | P_ULDF_S04_2 |
| U_ULDF_S04_3 | es-es        | P_ULDF_S04_3 |


Scenario: Check that user sees date in format according to his locale in activity on File Activity page
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Language       |
| <UserEmail> | <UserLanguage> |
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And created '/F_ULDF_S05' folder for project '<ProjectName>'
When I upload '/files/128_shortname.jpg' file into '/F_ULDF_S05' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_ULDF_S05' on project '<ProjectName>' files page
Then I 'should' see on Activity tab for file '128_shortname.jpg' in folder '/F_ULDF_S05' project '<ProjectName>' following recent user's activity :
| User        | Logo  | ActivityType | ActivityMessage       |
| <UserEmail> | EMPTY | created      | <FileActivityMessage> |

Examples:
| UserEmail    | UserLanguage | ProjectName  | FileActivityMessage |
| U_ULDF_S05_1 | en-beam-us   | P_ULDF_S05_1 | created file        |
| U_ULDF_S05_2 | en-us        | P_ULDF_S05_2 | created file        |
| U_ULDF_S05_3 | de           | P_ULDF_S05_3 | hat Datei erstellt  |


Scenario: Check that user sees date in format according to his locale in activity on Asset Activity page
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Language       |Access|
| <UserEmail> | <UserLanguage> |streamlined_library|
And logged in with details of '<UserEmail>'
When I upload file '/files/128_shortname.jpg' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset '128_shortname.jpg' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset '128_shortname.jpg' activity page for collection 'My Assets'NEWLIB:
| UserName    | Message                | Value |
| <UserEmail> | <AssetActivityMessage> |       |

Examples:
| UserEmail    | UserLanguage | AssetActivityMessage      |
| U_ULDF_S06_1 | en           | Uploaded by          |
| U_ULDF_S06_3 | de           | Datei wurde transkodiert von     |


Scenario: Check that user sees date in format according to his locale in usage rights on File Usage Rights page
Meta:@gdam
@projects
Given I created the agency 'A_ULDF_S07' with default attributes
And created users with following fields:
| Email       | Language       | Agency     |
| AU_ULDF_S07 | en-us          | A_ULDF_S07 |
| <UserEmail> | <UserLanguage> | A_ULDF_S07 |
And logged in with details of 'AU_ULDF_S07'
And created 'P_ULDF_S07' project
And created '/F_ULDF_S07' folder for project 'P_ULDF_S07'
And uploaded '/files/128_shortname.jpg' file into '/F_ULDF_S07' folder for 'P_ULDF_S07' project
And waited while transcoding is finished in folder '/F_ULDF_S07' on project 'P_ULDF_S07' files page
When I add 'General' usage rule with following fields on file '128_shortname.jpg' and folder '/F_ULDF_S07' and project 'P_ULDF_S07' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And login with details of '<UserEmail>'
Then I 'should' see 'General' usage rule with following fields on file '128_shortname.jpg' and folder '/F_ULDF_S07' and project 'P_ULDF_S07' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |

Examples:
| UserEmail    | UserLanguage |
| U_ULDF_S07_1 | de           |
| U_ULDF_S07_2 | es-es        |
| U_ULDF_S07_3 | es-ar        |


Scenario: Check that user sees date in format according to his locale in usage rights on Asset Usage Rights page
Meta:@gdam
@library
@uitobe
Given I created the agency 'A_ULDF_S08' with default attributes
And created users with following fields:
| Email       | Language       | Agency     |Access|
| AU_ULDF_S08 | en-us          | A_ULDF_S08 |streamlined_library|
| <UserEmail> | <UserLanguage> | A_ULDF_S08 |streamlined_library|
And logged in with details of 'AU_ULDF_S08'
And uploaded file '/files/128_shortname.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'General' for asset '128_shortname.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And login with details of '<UserEmail>'
When go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see following data for usage type 'General' on asset '128_shortname.jpg' usage rights page for collection 'Everything'NEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |

Examples:
| UserEmail    | UserLanguage |
| U_ULDF_S08_1 | fr           |
| U_ULDF_S08_2 | de           |
| U_ULDF_S08_3 | es-es        |


Scenario: Check that user sees date in format according to his locale on Presentation list page
Meta:@gdam
@library
Given I created the agency 'A_ULDF_S09' with default attributes
And created users with following fields:
| Email       | Language       | Agency     |
| <UserEmail> | <UserLanguage> | A_ULDF_S09 |
And logged in with details of '<UserEmail>'
Given I created 'P_ULDF_S09' reels with description 'description'
When I go to the all presentations page
Then I 'should' see the following information for 'P_ULDF_S09' presentation on presentation list:
| Cell         | Value |
| DateCreated  | Today |
| DateModified | Today |

Examples:
| UserEmail    | UserLanguage |
| U_ULDF_S09_1 | en           |
| U_ULDF_S09_2 | en-au        |
| U_ULDF_S09_3 | es-ar        |