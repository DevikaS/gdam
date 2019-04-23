!--NGN-2914
Feature:          Add sub-types to Document media type
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Document madia sub-types

Scenario: Check media type for documents in project folder
Meta: @gdam
      @projects
Given I created 'P_ASTTDMT_S01' project
And I created 'F_ASTTDMT_S01' folder for project 'P_ASTTDMT_S01'
And uploaded into project 'P_ASTTDMT_S01' following files:
| FileName                | Path        |
| /files/BDDStandards.doc | /F_ASTTDMT_S01 |
| /files/perfromance.xlsx | /F_ASTTDMT_S01 |
| /files/presentation.ppt | /F_ASTTDMT_S01 |
And waited while transcoding is finished in folder 'F_ASTTDMT_S01' on project 'P_ASTTDMT_S01' files page
And I am on file '<FileName>' info page in folder 'F_ASTTDMT_S01' project 'P_ASTTDMT_S01'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue |
| Media type | document   |

Examples:
| FileName         |
| BDDStandards.doc |
| perfromance.xlsx |
| presentation.ppt |


Scenario: Check that all media sub-types for document type available in projects
Meta: @gdam
      @projects
Given I created 'P_ASTTDMT_S02' project
And I created 'F_ASTTDMT_S02' folder for project 'P_ASTTDMT_S02'
And uploaded '/files/BDDStandards.doc' file into 'F_ASTTDMT_S02' folder for 'P_ASTTDMT_S02' project
And waited while transcoding is finished in folder 'F_ASTTDMT_S02' on project 'P_ASTTDMT_S02' files page
And I am on file 'BDDStandards.doc' info page in folder 'F_ASTTDMT_S02' project 'P_ASTTDMT_S02'
When I click Edit link on file info page
Then I 'should' see following 'dropdown' fields with values on opened Edit asset popup:
| FieldName      | FieldValue                     |
| Media sub-type | Activity Grid / Marketing Plan |
| Media sub-type | Agenda                         |
| Media sub-type | Analysis                       |
| Media sub-type | Brief                          |
| Media sub-type | Concept                        |
| Media sub-type | Contract                       |
| Media sub-type | Copy                           |
| Media sub-type | Estimate                       |
| Media sub-type | Guideline                      |
| Media sub-type | Integrated Campaign Plan       |
| Media sub-type | Invoice                        |
| Media sub-type | Media Schedule                 |
| Media sub-type | Other                          |
| Media sub-type | Planning                       |
| Media sub-type | Presentation                   |
| Media sub-type | Production Schedule            |
| Media sub-type | Purchase Order                 |
| Media sub-type | Report                         |
| Media sub-type | Research                       |
| Media sub-type | Script                         |
| Media sub-type | Strategy                       |
| Media sub-type | Template                       |
| Media sub-type | Timeline                       |
| Media sub-type | Toolkit                        |


Scenario: Check that media sub-type for document type can be saved in projects
Meta: @gdam
      @projects
Given I created 'P_ASTTDMT_S03' project
And I created 'F_ASTTDMT_S03' folder for project 'P_ASTTDMT_S03'
And uploaded '/files/BDDStandards.doc' file into 'F_ASTTDMT_S03' folder for 'P_ASTTDMT_S03' project
And waited while transcoding is finished in folder 'F_ASTTDMT_S03' on project 'P_ASTTDMT_S03' files page
And I am on file 'BDDStandards.doc' info page in folder 'F_ASTTDMT_S03' project 'P_ASTTDMT_S03'
When I 'save' file info by next information:
| FieldName      | FieldValue                     |
| Media sub-type | Activity Grid / Marketing Plan |
And go to file 'BDDStandards.doc' info page in folder 'F_ASTTDMT_S03' project 'P_ASTTDMT_S03'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName      | FieldValue                     |
| Media sub-type | Activity Grid / Marketing Plan |



Scenario: Check that media sub-type not changed after move to library for document
Meta: @gdam
      @library
Given I created 'P_ASTTDMT_S04' project
And I created 'F_ASTTDMT_S04' folder for project 'P_ASTTDMT_S04'
And uploaded 'files/BDDStandards.doc' file into 'F_ASTTDMT_S04' folder for 'P_ASTTDMT_S04' project
And waited while transcoding is finished in folder 'F_ASTTDMT_S04' on project 'P_ASTTDMT_S04' files page
And I am on file 'BDDStandards.doc' info page in folder 'F_ASTTDMT_S04' project 'P_ASTTDMT_S04'
When I 'save' file info by next information:
| FieldName      | FieldValue |
| Media sub-type | Agenda     |
And I send file 'BDDStandards.doc' on project 'P_ASTTDMT_S04' folder 'F_ASTTDMT_S04' page to Library
And fill following data on add file to library page:
| Title          |
| AT_ASTTDMT.S04 |
And click Save button on Add file to new library page
And I go to asset 'AT_ASTTDMT.S04' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue |
| Media sub-type  | Agenda |



Scenario: Check that assets with media sub-type appear at library after sharing to other agency
Meta: @gdam
      @library
Given I created the agency 'A_ASTTDMT_S05' with default attributes
And updated the following agency:
| Name         | Labels                  |
| A_ASTTDMT_S05 | new-library-dev-version |
And I created users with following fields:
| Email         | Agency        |Access|
| U_ASTTDMT_S05 | A_ASTTDMT_S05 |streamlined_library,library|
And I created following categories:
| Name          |
| C_ASTTDMT_S05 |
And I shared next agencies for following categories:
| CategoryName  | AgencyName    |
| C_ASTTDMT_S05 | A_ASTTDMT_S05 |
When I go to collection 'C_ASTTDMT_S05' on administration area collections page
And I switch 'on' media type filter 'document' on administration area collections page
And I select media subtype 'Agenda' for current category
And I click save button for metadata of current category
And upload file '/files/perfromance.xlsx' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I 'save' asset 'perfromance.xlsx' info of collection 'My Assets' by following informationNEWLIB:
| FieldName      | FieldValue |
| Media sub-type | Agenda     |
And I login with details of 'U_ASTTDMT_S05'
And I go to the collections page
And I refresh the page
When I go to the Shared Collection 'C_ASTTDMT_S05' from agency 'DefaultAgency' pageNEWLIB
And I select asset 'perfromance.xlsx' for collection 'C_ASTTDMT_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to asset 'perfromance.xlsx' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue |
| Media sub-type | Agenda     |


Scenario: Check media type for documents in library
Meta: @gdam
      @library
Given I am on the Library pageNEWLIB
And uploaded following assetsNEWLIB:
| Name                    |
| <AssetUpload> |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset '<AssetName>' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Media type | document   |

Examples:
| AssetUpload       |AssetName|
| /files/BDDStandards.doc |BDDStandards.doc|
| /files/perfromance.xlsx |perfromance.xlsx|
| /files/presentation.ppt |presentation.ppt|


Scenario: Check that all media sub-types for document type available in library
Meta:@gdam
      @library
Given I am on the Library pageNEWLIB
And uploaded file 'files/BDDStandards.doc' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'BDDStandards.doc' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
And I click Edit link on asset info pageNEWLIB
Then I 'should' see following dropdown fields with values under section 'Technical' on opened Edit asset popup NEWLIB:
| FieldName      | FieldValue                     |
| Media sub-type | Activity Grid / Marketing Plan,Agenda,Analysis,Brief,Concept,Contract,Copy,Estimate,Guideline,Invoice,Other,Planning,Purchase Order,Research,Script,Strategy,Template,Toolkit,Integrated Campaign Plan,Media Schedule,Production Schedule,Report,Timeline,Presentation|


Scenario: Check that media sub-type for document type can be saved in library
Meta: @gdam
      @library
Given I am on the Library pageNEWLIB
And uploaded file 'files/BDDStandards.doc' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I 'save' asset 'BDDStandards.doc' info of collection 'My Assets' by following informationNEWLIB:
| FieldName      | FieldValue               |
| Media sub-type | Integrated Campaign Plan |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue               |
| Media sub-type | integrated campaign plan |



