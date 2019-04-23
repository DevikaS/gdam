!--NGN-11618
Feature:          User invited to other BU project can view edit Project and File metadata according to original BU schema
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that User invited to other BU project can view edit Project and File metadata according to original BU schema


Scenario: Check that values for dropdowns from another agency are picked up at edit asset and could be saved (Check for custom fields such as dropdowns,catalog and radio buttons)
Meta:@library
     @gdam
Given I created the agency 'A_UITOBUPCVEPAFMATOBUS_S01' with default attributes
And created the agency 'A_UITOBUPCVEPAFMATOBUS_S02' with default attributes
And created users with following fields:
| Email                        | Role         | Agency                     |Access|
| U_UITOBUPCVEPAFMATOBUS_S01_1 | agency.admin | A_UITOBUPCVEPAFMATOBUS_S01 |streamlined_library|
| U_UITOBUPCVEPAFMATOBUS_S01_2 | agency.admin | A_UITOBUPCVEPAFMATOBUS_S02 |streamlined_library|
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UITOBUPCVEPAFMATOBUS_S02' to agency 'A_UITOBUPCVEPAFMATOBUS_S01' on partners page
When I login with details of 'U_UITOBUPCVEPAFMATOBUS_S01_1'
And go to the global 'common custom' metadata page for agency 'A_UITOBUPCVEPAFMATOBUS_S01'
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser                    | Brand                        | Sub Brand                     | Product                       |
| AR_UITOBUPCVEPAFMATOBUS_S01_1 | B_UITOBUPCVEPAFMATOBUS_S01_1 | SB_UITOBUPCVEPAFMATOBUS_S01_1 | PT_UITOBUPCVEPAFMATOBUS_S01_1 |
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser                    | Brand                        | Sub Brand                     | Product                      |
| AR_UITOBUPCVEPAFMATOBUS_S01_2 | B_UITOBUPCVEPAFMATOBUS_S01_2 | SB_UITOBUPCVEPAFMATOBUS_S01_2 | B_UITOBUPCVEPAFMATOBUS_S01_2 |
And create following 'common' custom metadata fields for agency 'A_UITOBUPCVEPAFMATOBUS_S01':
| FieldType    | Description                             | Choices     |
| Dropdown     | DROPDOWN_UITOBUPCVEPAFMATOBUS_S01_1     | drop1,drop2 |
| RadioButtons | RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S01_1 | rad1,rad2   |
And upload file '/files/atCalcImage.jpg' '1' times to libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to administration area collections page
And create category 'CAT3_UITOBUPCVEPAFMATOBUS'
And add users 'U_UITOBUPCVEPAFMATOBUS_S01_2' to category 'CAT3_UITOBUPCVEPAFMATOBUS' with role 'library.user' by users details
And go to asset 'atCalcImage.jpg' info page in Library for collection 'CAT3_UITOBUPCVEPAFMATOBUS'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                               | FieldValue                    |
| Advertiser                              | AR_UITOBUPCVEPAFMATOBUS_S01_1 |
| Brand                                   | B_UITOBUPCVEPAFMATOBUS_S01_1  |
| Sub Brand                               | SB_UITOBUPCVEPAFMATOBUS_S01_1 |
| Product                                 | PT_UITOBUPCVEPAFMATOBUS_S01_1 |
| DROPDOWN_UITOBUPCVEPAFMATOBUS_S01_1     | drop1                         |
| RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S01_1 | rad1                          |
And login with details of 'U_UITOBUPCVEPAFMATOBUS_S01_2'
And go to asset 'atCalcImage.jpg' info page in Library for collection 'CAT3_UITOBUPCVEPAFMATOBUS'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                               | FieldValue                    |
| Advertiser                              | AR_UITOBUPCVEPAFMATOBUS_S01_2 |
| Brand                                   | B_UITOBUPCVEPAFMATOBUS_S01_2  |
| Sub Brand                               | SB_UITOBUPCVEPAFMATOBUS_S01_2 |
| Product                                 | B_UITOBUPCVEPAFMATOBUS_S01_2  |
| DROPDOWN_UITOBUPCVEPAFMATOBUS_S01_1     | drop2                         |
| RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S01_1 | rad2                          |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                               | FieldValue                    |
| Advertiser                              | AR_UITOBUPCVEPAFMATOBUS_S01_2 |
| Brand                                   | B_UITOBUPCVEPAFMATOBUS_S01_2  |
| Sub Brand                               | SB_UITOBUPCVEPAFMATOBUS_S01_2 |
| Product                                 | B_UITOBUPCVEPAFMATOBUS_S01_2  |
| RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S01_1 | rad1,rad2                          |
| Title                                   | atCalcImage.jpg               |
| DROPDOWN_UITOBUPCVEPAFMATOBUS_S01_1     | drop2                         |
| Media type                              | image                         |


Scenario: Check that values for dropdowns from another agency are picked up at edit project and could be saved (Check for custom fields such as dropdowns,catalog and radio buttons)
Meta:@projects
     @gdam
Given I created the agency 'A_UITOBUPCVEPAFMATOBUS_S01' with default attributes
And created the agency 'A_UITOBUPCVEPAFMATOBUS_S02' with default attributes
And created users with following fields:
| Email                        | Role         | Agency                     |
| U_UITOBUPCVEPAFMATOBUS_S02_1 | agency.admin | A_UITOBUPCVEPAFMATOBUS_S01 |
| U_UITOBUPCVEPAFMATOBUS_S02_2 | agency.admin | A_UITOBUPCVEPAFMATOBUS_S02 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UITOBUPCVEPAFMATOBUS_S02' to agency 'A_UITOBUPCVEPAFMATOBUS_S01' on partners page
When I login with details of 'U_UITOBUPCVEPAFMATOBUS_S02_1'
And go to the global 'common custom' metadata page for agency 'A_UITOBUPCVEPAFMATOBUS_S01'
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser                    | Brand                        | Sub Brand                     | Product                       |
| AR_UITOBUPCVEPAFMATOBUS_S02_1 | B_UITOBUPCVEPAFMATOBUS_S02_1 | SB_UITOBUPCVEPAFMATOBUS_S02_1 | PT_UITOBUPCVEPAFMATOBUS_S02_1 |
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser                    | Brand                        | Sub Brand                     | Product                       |
| AR_UITOBUPCVEPAFMATOBUS_S02_2 | B_UITOBUPCVEPAFMATOBUS_S02_2 | SB_UITOBUPCVEPAFMATOBUS_S02_2 | PT_UITOBUPCVEPAFMATOBUS_S02_2 |
And create following 'common' custom metadata fields for agency 'A_UITOBUPCVEPAFMATOBUS_S01':
| FieldType    | Description                             | Choices     |
| Dropdown     | DROPDOWN_UITOBUPCVEPAFMATOBUS_S02_1     | drop1,drop2 |
| RadioButtons | RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S02_1 | rad1,rad2   |
And create new project with following fields:
| FieldName                               | FieldValue                    |
| Name                                    | P_UITOBUPCVEPAFMATOBUS_S02_1  |
| Advertiser                              | AR_UITOBUPCVEPAFMATOBUS_S02_1 |
| Brand                                   | B_UITOBUPCVEPAFMATOBUS_S02_1  |
| Sub Brand                               | SB_UITOBUPCVEPAFMATOBUS_S02_1 |
| Product                                 | PT_UITOBUPCVEPAFMATOBUS_S02_1 |
| DROPDOWN_UITOBUPCVEPAFMATOBUS_S02_1     | drop1                         |
| RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S02_1 | rad1                          |
| Media type                              | Broadcast                     |
| Start Date                              | Today                         |
| End Date                                | Tomorrow                      |
And open project 'P_UITOBUPCVEPAFMATOBUS_S02_1' settings page
And edit the following fields for 'P_UITOBUPCVEPAFMATOBUS_S02_1' project:
| Name                         | Administrators               |
| P_UITOBUPCVEPAFMATOBUS_S02_1 | U_UITOBUPCVEPAFMATOBUS_S02_2 |
And click on element 'SaveButton'
And login with details of 'U_UITOBUPCVEPAFMATOBUS_S02_2'
And update project 'P_UITOBUPCVEPAFMATOBUS_S02_1' with following fields on Edit Project popup:
| FieldName                               | FieldValue                    |
| Advertiser                              | AR_UITOBUPCVEPAFMATOBUS_S02_2 |
| Brand                                   | B_UITOBUPCVEPAFMATOBUS_S02_2  |
| Sub Brand                               | SB_UITOBUPCVEPAFMATOBUS_S02_2 |
| Product                                 | PT_UITOBUPCVEPAFMATOBUS_S02_2 |
| DROPDOWN_UITOBUPCVEPAFMATOBUS_S02_1     | drop2                         |
| RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S02_1 | rad2                          |
Then I 'should' see following fields on opened Project 'P_UITOBUPCVEPAFMATOBUS_S02_1' Overview page:
| FieldName                               | FieldValue                    |
| Advertiser                              | AR_UITOBUPCVEPAFMATOBUS_S02_2 |
| Brand                                   | B_UITOBUPCVEPAFMATOBUS_S02_2  |
| Sub Brand                               | SB_UITOBUPCVEPAFMATOBUS_S02_2 |
| Product                                 | PT_UITOBUPCVEPAFMATOBUS_S02_2 |
| DROPDOWN_UITOBUPCVEPAFMATOBUS_S02_1     | drop2                         |
| RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S02_1 | rad2                          |


Scenario: Check that values for dropdowns from another agency are picked up at edit file and could be saved (Check for custom fields such as dropdowns,catalog and radio buttons)
Meta:@projects
     @gdam
Given I created the agency 'A_UITOBUPCVEPAFMATOBUS_S01' with default attributes
And created the agency 'A_UITOBUPCVEPAFMATOBUS_S02' with default attributes
And created users with following fields:
| Email                        | Role         | Agency                     |
| U_UITOBUPCVEPAFMATOBUS_S03_1 | agency.admin | A_UITOBUPCVEPAFMATOBUS_S01 |
| U_UITOBUPCVEPAFMATOBUS_S03_2 | agency.admin | A_UITOBUPCVEPAFMATOBUS_S02 |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_UITOBUPCVEPAFMATOBUS_S02' to agency 'A_UITOBUPCVEPAFMATOBUS_S01' on partners page
When I login with details of 'U_UITOBUPCVEPAFMATOBUS_S03_1'
And go to the global 'common custom' metadata page for agency 'A_UITOBUPCVEPAFMATOBUS_S01'
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser                    | Brand                        | Sub Brand                     | Product                       |
| AR_UITOBUPCVEPAFMATOBUS_S03_1 | B_UITOBUPCVEPAFMATOBUS_S03_1 | SB_UITOBUPCVEPAFMATOBUS_S03_1 | PT_UITOBUPCVEPAFMATOBUS_S03_1 |
And create Advertiser chain with following values on Settings and Customization page:
| Advertiser                    | Brand                        | Sub Brand                     | Product                       |
| AR_UITOBUPCVEPAFMATOBUS_S03_2 | B_UITOBUPCVEPAFMATOBUS_S03_2 | SB_UITOBUPCVEPAFMATOBUS_S03_2 | PT_UITOBUPCVEPAFMATOBUS_S03_2 |
And create following 'common' custom metadata fields for agency 'A_UITOBUPCVEPAFMATOBUS_S01':
| FieldType    | Description                             | Choices     |
| Dropdown     | DROPDOWN_UITOBUPCVEPAFMATOBUS_S03_1     | drop1,drop2 |
| RadioButtons | RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S03_1 | rad1,rad2   |
And create new project with following fields:
| FieldName                               | FieldValue                    |
| Name                                    | P_UITOBUPCVEPAFMATOBUS_S03    |
| Advertiser                              | AR_UITOBUPCVEPAFMATOBUS_S03_1 |
| Brand                                   | B_UITOBUPCVEPAFMATOBUS_S03_1  |
| Sub Brand                               | SB_UITOBUPCVEPAFMATOBUS_S03_1 |
| Product                                 | PT_UITOBUPCVEPAFMATOBUS_S03_1 |
| DROPDOWN_UITOBUPCVEPAFMATOBUS_S03_1     | drop1                         |
| RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S03_1 | rad1                          |
| Media type                              | Broadcast                     |
| Start Date                              | Today                         |
| End Date                                | Tomorrow                      |
And upload '/files/atCalcImage.jpg' file into '/folder2' folder for 'P_UITOBUPCVEPAFMATOBUS_S03' project
And wait while transcoding is finished in folder '/folder2' on project 'P_UITOBUPCVEPAFMATOBUS_S03' files page
And open project 'P_UITOBUPCVEPAFMATOBUS_S03' settings page
And edit the following fields for 'P_UITOBUPCVEPAFMATOBUS_S03' project:
| Name                       | Administrators               |
| P_UITOBUPCVEPAFMATOBUS_S03 | U_UITOBUPCVEPAFMATOBUS_S03_2 |
And click on element 'SaveButton'
And login with details of 'U_UITOBUPCVEPAFMATOBUS_S03_2'
And go to file 'atCalcImage.jpg' info page in folder '/folder2' project 'P_UITOBUPCVEPAFMATOBUS_S03'
And 'save' file info by next information:
| FieldName                               | FieldValue                    |
| Advertiser                              | AR_UITOBUPCVEPAFMATOBUS_S03_2 |
| Brand                                   | B_UITOBUPCVEPAFMATOBUS_S03_2  |
| Sub Brand                               | SB_UITOBUPCVEPAFMATOBUS_S03_2 |
| Product                                 | PT_UITOBUPCVEPAFMATOBUS_S03_2 |
| DROPDOWN_UITOBUPCVEPAFMATOBUS_S03_1     | drop2                         |
| RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S03_1 | rad2                          |
Then 'should' see following 'custom metadata' fields on opened file info page:
| FieldName                               | FieldValue                    |
| Advertiser                              | AR_UITOBUPCVEPAFMATOBUS_S03_2 |
| Brand                                   | B_UITOBUPCVEPAFMATOBUS_S03_2  |
| Sub Brand                               | SB_UITOBUPCVEPAFMATOBUS_S03_2 |
| Product                                 | PT_UITOBUPCVEPAFMATOBUS_S03_2 |
| DROPDOWN_UITOBUPCVEPAFMATOBUS_S03_1     | drop2                         |
| RADIOBUTTONS_UITOBUPCVEPAFMATOBUS_S03_1 | rad2                          |