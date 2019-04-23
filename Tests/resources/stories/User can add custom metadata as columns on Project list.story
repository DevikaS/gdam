!--NGN-11920
Feature:          User can add custom metadata as columns on Project list
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user can add custom metadata as columns on Project list

Scenario: Check that custom metadata dropdown field could be added as coulumn to project list
Meta:@gdam
@projects
Given I created the agency 'A_UACMCFP_S01' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_UACMCFP_S01 | agency.admin | A_UACMCFP_S01 |
And created following 'common' custom metadata fields for agency 'A_UACMCFP_S01':
| FieldType | Description   | AddOnFly | MultipleChoices |
| dropdown  | CMDDF UACMCFP | true     | true            |
And logged in with details of 'U_UACMCFP_S01'
When I create new project with following fields:
| FieldName     | FieldValue           |
| Media type    | Broadcast            |
| Start date    | Today                |
| End date      | Tomorrow             |
| CMDDF UACMCFP | CMDDFV UACMCFP S01 1 |
| Name          | P_UACMCFP_S01_1      |
And create new project with following fields:
| FieldName     | FieldValue           |
| Media type    | Broadcast            |
| Start date    | Today                |
| End date      | Tomorrow             |
| CMDDF UACMCFP | CMDDFV UACMCFP S01 2 |
| Name          | P_UACMCFP_S01_2      |
And go to project list page
And select additional columns on project list page:
| FieldName     |
| CMDDF UACMCFP |
Then I 'should' see following project fields on project list page:
| Name            | CMDDF UACMCFP        |
| P_UACMCFP_S01_1 | CMDDFV UACMCFP S01 1 |
| P_UACMCFP_S01_2 | CMDDFV UACMCFP S01 2 |


Scenario: Check that custom metadata radio button field could be added as coulumn to project list
Meta:@gdam
@projects
Given I created the agency 'A_UACMCFP_S02' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_UACMCFP_S02 | agency.admin | A_UACMCFP_S02 |
And created following 'common' custom metadata fields for agency 'A_UACMCFP_S02':
| FieldType    | Description   | Choices                                   |
| radioButtons | CMRBF UACMCFP | CMRBFV UACMCFP S02 1,CMRBFV UACMCFP S02 2 |
And logged in with details of 'U_UACMCFP_S02'
When I create new project with following fields:
| FieldName     | FieldValue           |
| Media type    | Broadcast            |
| Start date    | Today                |
| End date      | Tomorrow             |
| CMRBF UACMCFP | CMRBFV UACMCFP S02 1 |
| Name          | P_UACMCFP_S02_1      |
And create new project with following fields:
| FieldName     | FieldValue           |
| Media type    | Broadcast            |
| Start date    | Today                |
| End date      | Tomorrow             |
| CMRBF UACMCFP | CMRBFV UACMCFP S02 2 |
| Name          | P_UACMCFP_S02_2      |
And go to project list page
And select additional columns on project list page:
| FieldName     |
| CMRBF UACMCFP |
Then I 'should' see following project fields on project list page:
| Name            | CMRBF UACMCFP        |
| P_UACMCFP_S02_1 | CMRBFV UACMCFP S02 1 |
| P_UACMCFP_S02_2 | CMRBFV UACMCFP S02 2 |


Scenario: Check that custom metadata catalogue structure field could be added as coulumn to project list
Meta:@gdam
@projects
Given I created the agency 'A_UACMCFP_S03' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_UACMCFP_S03 | agency.admin | A_UACMCFP_S03 |
And created following 'common' custom metadata fields for agency 'A_UACMCFP_S03':
| FieldType          | Description    | AddOnFly | MultipleChoices | Parent         |
| catalogueStructure | CMCSPF UACMCFP | true     | true            |                |
| catalogueStructure | CMCSCF UACMCFP | true     | true            | CMCSPF UACMCFP |
And logged in with details of 'U_UACMCFP_S03'
When I create new project with following fields:
| FieldName      | FieldValue            |
| Media type     | Broadcast             |
| Start date     | Today                 |
| End date       | Tomorrow              |
| CMCSPF UACMCFP | CMCSPFV UACMCFP S03 1 |
| CMCSCF UACMCFP | CMCSCFV UACMCFP S03 1 |
| Name           | P_UACMCFP_S03_1       |
And create new project with following fields:
| FieldName      | FieldValue            |
| Media type     | Broadcast             |
| Start date     | Today                 |
| End date       | Tomorrow              |
| CMCSPF UACMCFP | CMCSPFV UACMCFP S03 2 |
| CMCSCF UACMCFP | CMCSCFV UACMCFP S03 2 |
| Name           | P_UACMCFP_S03_2       |
And go to project list page
And select additional columns on project list page:
| FieldName      |
| CMCSPF UACMCFP |
| CMCSCF UACMCFP |
Then I 'should' see following project fields on project list page:
| Name            | CMCSPF UACMCFP        | CMCSCF UACMCFP        |
| P_UACMCFP_S03_1 | CMCSPFV UACMCFP S03 1 | CMCSCFV UACMCFP S03 1 |
| P_UACMCFP_S03_2 | CMCSPFV UACMCFP S03 2 | CMCSCFV UACMCFP S03 2 |


Scenario: Check that custom metadata date field could be added as coulumn to project list
Meta:@gdam
@projects
Given I created the agency 'A_UACMCFP_S04' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_UACMCFP_S04 | agency.admin | A_UACMCFP_S04 |
And created following 'common' custom metadata fields for agency 'A_UACMCFP_S04':
| FieldType | Description  |
| date      | CMDF UACMCFP |
And logged in with details of 'U_UACMCFP_S04'
When I create new project with following fields:
| FieldName    | FieldValue      |
| Media type   | Broadcast       |
| Start date   | Today           |
| End date     | Tomorrow        |
| CMDF UACMCFP | 11/11/2022      |
| Name         | P_UACMCFP_S04_1 |
And create new project with following fields:
| FieldName    | FieldValue      |
| Media type   | Broadcast       |
| Start date   | Today           |
| End date     | Tomorrow        |
| CMDF UACMCFP | 12/12/2022      |
| Name         | P_UACMCFP_S04_2 |
And go to project list page
And select additional columns on project list page:
| FieldName    |
| CMDF UACMCFP |
Then I 'should' see following project fields on project list page:
| Name            | CMDF UACMCFP |
| P_UACMCFP_S04_1 | 11/11/2022   |
| P_UACMCFP_S04_2 | 12/12/2022   |


Scenario: Check that after adding several metadata fields to project schema count of colums are not changed
Meta: @skip
      @gdam
!--NGN-16884 logged but Maria said it wont be fixed and we can remove this test
Given I created the agency 'A_UACMCFP_S05' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_UACMCFP_S05 | agency.admin | A_UACMCFP_S05 |
And logged in with details of 'U_UACMCFP_S05'
When I go to project list page
And wait for '3' seconds
And deselect additional columns on project list page:
| FieldName       |
| Last Activity   |
| Project Creator |
And select additional columns on project list page:
| FieldName  |
| Name       |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
And create following 'common' custom metadata fields for agency 'A_UACMCFP_S05':
| FieldType    | Description   | AddOnFly | MultipleChoices | Choices            |
| dropdown     | CMDDF UACMCFP | true     | true            |                    |
| radioButtons | CMRBF UACMCFP |          |                 | CMRBFV UACMCFP S05 |
And go to Dashboard page
And create new project with following fields:
| FieldName     | FieldValue         |
| Media type    | Broadcast          |
| Start Date    | Today              |
| End Date      | Tomorrow           |
| CMDDF UACMCFP | CMDDFV UACMCFP S05 |
| CMRBF UACMCFP | CMRBFV UACMCFP S05 |
| Name          | P_UACMCFP_S05      |
And upload file '/files/image10.jpg' into library
And wait while transcoding is finished in collection 'My Assets'
And go to project list page
Then I 'should' see following project fields on project list page:
| Name          | Advertiser | Brand | Sub Brand | Product |
| P_UACMCFP_S05 |            |       |           |         |
And 'should not' see following project fields on project list page:
| Last Activity | Project Creator | CMDDF UACMCFP      | CMRBF UACMCFP      |
|               |                 | CMDDFV UACMCFP S05 | CMRBFV UACMCFP S05 |
And 'should' see following project fields in the following order on project list page:
| FieldName  |
| Name       |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |


Scenario: Check that sorting by added metadata fields as columns work proper
Meta:@gdam
@projects
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email       | Role         | Agency       |
| <UserEmail> | agency.admin | <AgencyName> |
And created following 'common' custom metadata fields for agency '<AgencyName>':
| FieldType    | Description   | Choices                                   |
| radioButtons | CMRBF UACMCFP | CMRBFV UACMCFP S06 1,CMRBFV UACMCFP S06 2 |
And logged in with details of '<UserEmail>'
When I create new project with following fields:
| FieldName     | FieldValue           |
| Media type    | Broadcast            |
| Start date    | Today                |
| End date      | Tomorrow             |
| CMRBF UACMCFP | CMRBFV UACMCFP S06 1 |
| Name          | P_UACMCFP_S06_1      |
And create new project with following fields:
| FieldName     | FieldValue           |
| Media type    | Broadcast            |
| Start date    | Today                |
| End date      | Tomorrow             |
| CMRBF UACMCFP | CMRBFV UACMCFP S06 2 |
| Name          | P_UACMCFP_S06_2      |
And wait for '3' seconds
And select additional columns on project list page:
| FieldName     |
| CMRBF UACMCFP |
And refresh the page
And wait for '3' seconds
And sort project list by field 'CMRBF UACMCFP' with order '<OrderCriteria>' on project list page
And wait for '5' seconds
Then I 'should' see following project fields on project list page with '<OrderCriteria>':
| CMRBF UACMCFP        |
| CMRBFV UACMCFP S06 1 |
| CMRBFV UACMCFP S06 2 |

Examples:
| AgencyName      | UserEmail       | OrderCriteria |
| A_UACMCFP_S06_1 | U_UACMCFP_S06_1 | asc           |
| A_UACMCFP_S06_2 | U_UACMCFP_S06_2 | desc          |