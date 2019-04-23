!--NGN-7344
Feature:          CM - share the project and files
Narrative:
In order to
As a              GlobalAdmin
I want to         create new or debug existing stories

Scenario: Check transferring of custom metadata in case to share folder to user in current agency/another agency
Meta:@projects
     @gdam
Given I created the agency '<TestedAgency>' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<TestedAgency>':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_CMSPF_S01 | BR_CMSPF_S01 | SBR_CMSPF_S01 | PR_CMSPF_S01 |
And created following 'asset' custom metadata fields for agency '<TestedAgency>':
| Section | FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| video   | string       | CMSF CMSPF  |          |                 |             |                           |
| video   | dropdown     | CMDDF CMSPF | true     | true            |             |                           |
| video   | date         | CMDF CMSPF  |          |                 | MM/DD/YEAR  |                           |
| video   | radioButtons | CMRBF CMSPF |          |                 |             | CMRBFV CMSPF,CMRBSV CMSPF |
And created users with following fields:
| Email         | Role         | Agency         |
| AU_CMSPF_S01  | agency.admin | <TestedAgency> |
| U_CMSPF_S01_1 | agency.user  | <TestedAgency> |
| U_CMSPF_S01_2 | agency.user  | AnotherAgency  |
And logged in with details of 'AU_CMSPF_S01'
When I create new project with following fields:
| FieldName  | FieldValue    |
| Name       | <ProjectName> |
| Media type | Broadcast     |
| Advertiser | ADV_CMSPF_S01 |
| Brand      | BR_CMSPF_S01  |
| Sub Brand  | SBR_CMSPF_S01 |
| Product    | PR_CMSPF_S01  |
| Start date | Today         |
| End date   | Tomorrow      |
And create '/F_CMSPF_S01' folder for project '<ProjectName>'
And upload '/files/Fish Ad.mov' file into '/F_CMSPF_S01' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_CMSPF_S01' on project '<ProjectName>' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMSPF_S01' project '<ProjectName>'
And 'save' file info by next information:
| FieldName    | FieldValue   |
| Clock number | testcn       |
| CMSF CMSPF   | CMSFV CMSPF  |
| CMDDF CMSPF  | CMDDFV CMSPF |
| CMDF CMSPF   | 12/12/2015   |
| CMRBF CMSPF  | CMRBFV CMSPF |
And filling Share popup by users '<TestedUserEmail>' in project '<ProjectName>' folders '/F_CMSPF_S01' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And publish the project '<ProjectName>'
And login with details of '<TestedUserEmail>'
And go to file 'Fish Ad.mov' info page in folder '/F_CMSPF_S01' project '<ProjectName>'
Then I '<ProjectFieldsCondition>' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue    |
| Advertiser | ADV_CMSPF_S01 |
| Brand      | BR_CMSPF_S01  |
| Sub Brand  | SBR_CMSPF_S01 |
| Product    | PR_CMSPF_S01  |
And '<FileFieldsCondition>' see following 'custom metadata' fields on opened file info page:
| FieldName   | FieldValue   |
| CMSF CMSPF  | CMSFV CMSPF  |
| CMDDF CMSPF | CMDDFV CMSPF |
| CMDF CMSPF  | 12/12/2015   |
| CMRBF CMSPF | CMRBFV CMSPF |

Examples:
| TestedAgency  | ProjectName   | TestedUserEmail | ProjectFieldsCondition | FileFieldsCondition |
| A_CMSPF_S01_1 | P_CMSPF_S01_1 | U_CMSPF_S01_1   | should                 | should              |
| A_CMSPF_S01_2 | P_CMSPF_S01_2 | U_CMSPF_S01_2   | should                 | should              |


Scenario: Check transferring of custom metadata in case to add user to folder via Team in current agency/another agency
Meta:@projects
     @gdam
Given I created the agency '<TestedAgency>' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<TestedAgency>':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_CMSPF_S02 | BR_CMSPF_S02 | SBR_CMSPF_S02 | PR_CMSPF_S02 |
And created following 'asset' custom metadata fields for agency '<TestedAgency>':
| Section | FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| video   | string       | CMSF CMSPF  |          |                 |             |                           |
| video   | dropdown     | CMDDF CMSPF | true     | true            |             |                           |
| video   | date         | CMDF CMSPF  |          |                 | MM/DD/YEAR  |                           |
| video   | radioButtons | CMRBF CMSPF |          |                 |             | CMRBFV CMSPF,CMRBSV CMSPF |
And created users with following fields:
| Email         | Role         | Agency         |
| AU_CMSPF_S02  | agency.admin | <TestedAgency> |
| U_CMSPF_S02_1 | guest.user   | <TestedAgency> |
| U_CMSPF_S02_2 | guest.user   | AnotherAgency  |
And logged in with details of 'AU_CMSPF_S02'
When I create new project with following fields:
| FieldName   | FieldValue    |
| Name        | <ProjectName> |
| Media type  | Broadcast     |
| Advertiser  | ADV_CMSPF_S02 |
| Brand       | BR_CMSPF_S02  |
| Sub Brand   | SBR_CMSPF_S02 |
| Product     | PR_CMSPF_S02  |
| Start date  | Today         |
| End date    | Tomorrow      |
And create '/F_CMSPF_S02' folder for project '<ProjectName>'
And upload '/files/Fish Ad.mov' file into '/F_CMSPF_S02' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_CMSPF_S02' on project '<ProjectName>' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMSPF_S02' project '<ProjectName>'
And 'save' file info by next information:
| FieldName    | FieldValue   |
| Clock number | testcn       |
| CMSF CMSPF   | CMSFV CMSPF  |
| CMDDF CMSPF  | CMDDFV CMSPF |
| CMDF CMSPF   | 12/12/2015   |
| CMRBF CMSPF  | CMRBFV CMSPF |
And add users '<TestedUserEmail>' to project '<ProjectName>' team folders '/F_CMSPF_S02' with role 'project.user' expired '12.02.2021'
And publish the project '<ProjectName>'
And login with details of '<TestedUserEmail>'
And go to file 'Fish Ad.mov' info page in folder '/F_CMSPF_S02' project '<ProjectName>'
Then I '<ProjectFieldsCondition>' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue    |
| Advertiser | ADV_CMSPF_S02 |
| Brand      | BR_CMSPF_S02  |
| Sub Brand  | SBR_CMSPF_S02 |
| Product    | PR_CMSPF_S02  |
And '<FileFieldsCondition>' see following 'custom metadata' fields on opened file info page:
| FieldName   | FieldValue   |
| CMSF CMSPF  | CMSFV CMSPF  |
| CMDDF CMSPF | CMDDFV CMSPF |
| CMDF CMSPF  | 12/12/2015   |
| CMRBF CMSPF | CMRBFV CMSPF |

Examples:
| TestedAgency  | ProjectName   | TestedUserEmail | ProjectFieldsCondition | FileFieldsCondition |
| A_CMSPF_S02_1 | P_CMSPF_S02_1 | U_CMSPF_S02_1   | should                 | should              |
| A_CMSPF_S02_2 | P_CMSPF_S02_2 | U_CMSPF_S02_2   | should                 | should              |


Scenario: Check transferring of custom metadata in case to add user as project owner in current agency/another agency
Meta:@projects
     @gdam
Given I created the agency '<TestedAgency>' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<TestedAgency>':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_CMSPF_S03 | BR_CMSPF_S03 | SBR_CMSPF_S03 | PR_CMSPF_S03 |
And created following 'asset' custom metadata fields for agency '<TestedAgency>':
| Section | FieldType    | Description | AddOnFly | MultipleChoices | FieldFormat | Choices                   |
| video   | string       | CMSF CMSPF  |          |                 |             |                           |
| video   | dropdown     | CMDDF CMSPF | true     | true            |             |                           |
| video   | date         | CMDF CMSPF  |          |                 | MM/DD/YEAR  |                           |
| video   | radioButtons | CMRBF CMSPF |          |                 |             | CMRBFV CMSPF,CMRBSV CMSPF |
And created users with following fields:
| Email         | Role         | Agency         |
| AU_CMSPF_S03  | agency.admin | <TestedAgency> |
| U_CMSPF_S03_1 | agency.user  | <TestedAgency> |
| U_CMSPF_S03_2 | agency.admin | AnotherAgency  |
And logged in with details of 'AU_CMSPF_S03'
And added user '<TestedUserEmail>' into address book
When I create new project with following fields:
| FieldName  | FieldValue    |
| Name       | <ProjectName> |
| Media type | Broadcast     |
| Advertiser | ADV_CMSPF_S03 |
| Brand      | BR_CMSPF_S03  |
| Sub Brand  | SBR_CMSPF_S03 |
| Product    | PR_CMSPF_S03  |
| Start date | Today         |
| End date   | Tomorrow      |
And create '/F_CMSPF_S03' folder for project '<ProjectName>'
And upload '/files/Fish Ad.mov' file into '/F_CMSPF_S03' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_CMSPF_S03' on project '<ProjectName>' files page
And go to file 'Fish Ad.mov' info page in folder '/F_CMSPF_S03' project '<ProjectName>'
And 'save' file info by next information:
| FieldName    | FieldValue   |
| Clock number | testcn       |
| CMSF CMSPF   | CMSFV CMSPF  |
| CMDDF CMSPF  | CMDDFV CMSPF |
| CMDF CMSPF   | 12/12/2015   |
| CMRBF CMSPF  | CMRBFV CMSPF |
And open project '<ProjectName>' settings page
And edit the following fields for '<ProjectName>' project:
| Name          | Administrators    |
| <ProjectName> | <TestedUserEmail> |
And click on element 'SaveButton'
And wait for '2' seconds
And login with details of '<TestedUserEmail>'
And go to file 'Fish Ad.mov' info page in folder '/F_CMSPF_S03' project '<ProjectName>'
Then I '<ProjectFieldsCondition>' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue    |
| Advertiser | ADV_CMSPF_S03 |
| Brand      | BR_CMSPF_S03  |
| Sub Brand  | SBR_CMSPF_S03 |
| Product    | PR_CMSPF_S03  |
And '<FileFieldsCondition>' see following 'custom metadata' fields on opened file info page:
| FieldName    | FieldValue   |
| CMSF CMSPF   | CMSFV CMSPF  |
| CMDDF CMSPF  | CMDDFV CMSPF |
| CMDF CMSPF   | 12/12/2015   |
| CMRBF CMSPF  | CMRBFV CMSPF |

Examples:
| TestedAgency  | ProjectName   | TestedUserEmail | ProjectFieldsCondition | FileFieldsCondition |
| A_CMSPF_S03_1 | P_CMSPF_S03_1 | U_CMSPF_S03_1   | should                 | should              |
| A_CMSPF_S03_2 | P_CMSPF_S03_2 | U_CMSPF_S03_2   | should                 | should              |


Scenario: Check inheritance of scheme shared project after upload of file in current agency/another agency
Meta:@projects
     @gdam
Given I created the agency '<TestedAgency>' with default attributes
And created users with following fields:
| Email         | Role         | Agency         |
| AU_CMSPF_S04  | agency.admin | <TestedAgency> |
| U_CMSPF_S04_1 | agency.user  | <TestedAgency> |
| U_CMSPF_S04_2 | agency.admin | AnotherAgency  |
And created following 'common' custom metadata fields for agency '<TestedAgency>':
| FieldType | Description    | Choices         |
| String    | TSF CMSPF S04  |                 |
| Dropdown  | TDDF CMSPF S04 | TDDFV_CMSPF_S04 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<TestedAgency>':
| Advertiser     | Brand          | Sub Brand       | Product        |
| TAFC_CMSPF_S04 | TBFC_CMSPF_S04 | TSBFC_CMSPF_S04 | TPFC_CMSPF_S04 |
When I login with details of 'AU_CMSPF_S04'
And create new project with following fields:
| FieldName      | FieldValue      |
| Name           | <ProjectName>   |
| Media type     | Broadcast       |
| Advertiser     | TAFC_CMSPF_S04  |
| Brand          | TBFC_CMSPF_S04  |
| Sub Brand      | TSBFC_CMSPF_S04 |
| Product        | TPFC_CMSPF_S04  |
| TSF CMSPF S04  | TSFV CMSPF S04  |
| TDDF CMSPF S04 | TDDFV_CMSPF_S04 |
| Start date     | Today           |
| End date       | Tomorrow        |
And create '/F_CMSPF_S04' folder for project '<ProjectName>'
And upload '/files/Fish Ad.mov' file into '/F_CMSPF_S04' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_CMSPF_S04' on project '<ProjectName>' files page
And filling Share popup by users '<TestedUserEmail>' in project '<ProjectName>' folders '/F_CMSPF_S04' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And publish the project '<ProjectName>'
And login with details of '<TestedUserEmail>'
And go to file 'Fish Ad.mov' info page in folder '/F_CMSPF_S04' project '<ProjectName>'
Then I '<FirstCondition>' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue      |
| Advertiser | TAFC_CMSPF_S04  |
| Brand      | TBFC_CMSPF_S04  |
| Sub Brand  | TSBFC_CMSPF_S04 |
| Product    | TPFC_CMSPF_S04  |
And '<SeconfCondition>' see following 'custom metadata' fields on opened file info page:
| FieldName      | FieldValue      |
| TSF CMSPF S04  | TSFV CMSPF S04  |
| TDDF CMSPF S04 | TDDFV_CMSPF_S04 |

Examples:
| TestedAgency  | ProjectName   | TestedUserEmail | FirstCondition | SeconfCondition |
| A_CMSPF_S04_1 | P_CMSPF_S04_1 | U_CMSPF_S04_1   | should         | should          |
| A_CMSPF_S04_2 | P_CMSPF_S04_2 | U_CMSPF_S04_2   | should         | should          |


Scenario: Check that shared project after changing scheme is displayed in list of share user
Meta:@projects
     @gdam
Given I created the agency 'A_CMSPF_S05' with default attributes
And created users with following fields:
| Email         | Role         | Agency      |
| AU_CMSPF_S05  | agency.admin | A_CMSPF_S05 |
| U_CMSPF_S05   | agency.user  | A_CMSPF_S05 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CMSPF_S05':
| Advertiser     | Brand          | Sub Brand       | Product        |
| TAFC_CMSPF_S05 | TBFC_CMSPF_S05 | TSBFC_CMSPF_S05 | TPFC_CMSPF_S05 |
And created following 'common' custom metadata fields for agency 'A_CMSPF_S05':
| FieldType | Description    | Choices                             |
| String    | TSF CMSPF S05  |                                     |
| Dropdown  | TDDF CMSPF S05 | TDDFC_CMSPF_S05_1,TDDFC_CMSPF_S05_2 |
When I login with details of 'AU_CMSPF_S05'
And create new project with following fields:
| FieldName   | FieldValue     |
| Name        | P_CMSPF_S05_1  |
| Media type  | Broadcast      |
| Advertiser  | TAFC_CMSPF_S05 |
| Start date  | Today          |
| End date    | Tomorrow       |
And create '/F_CMSPF_S05' folder for project 'P_CMSPF_S05_1'
And filling Share popup by users 'U_CMSPF_S05' in project 'P_CMSPF_S05_1' folders '/F_CMSPF_S05' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And publish the project 'P_CMSPF_S05_1'
And create new project with following fields:
| FieldName      | FieldValue        |
| Name           | P_CMSPF_S05_2     |
| Media type     | Broadcast         |
| Advertiser     | TAFC_CMSPF_S05    |
| Brand          | TBFC_CMSPF_S05    |
| Sub Brand      | TSBFC_CMSPF_S05   |
| Product        | TPFC_CMSPF_S05    |
| TSF CMSPF S05  | TSFC_CMSPF_S05    |
| TDDF CMSPF S05 | TDDFC_CMSPF_S05_1 |
| Start date     | Today             |
| End date       | Tomorrow          |
And create '/F_CMSPF_S05' folder for project 'P_CMSPF_S05_2'
And filling Share popup by users 'U_CMSPF_S05' in project 'P_CMSPF_S05_2' folders '/F_CMSPF_S05' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And publish the project 'P_CMSPF_S05_2'
And login with details of 'GlobalAdmin'
And go to the global 'common custom' metadata page for agency 'A_CMSPF_S05'
And remove metadata field 'TSF CMSPF S05' from metadata page
And wait for '5' seconds
And login with details of 'U_CMSPF_S05'
And go to project list page
Then I 'should' see only project 'P_CMSPF_S05_1,P_CMSPF_S05_2' in project list