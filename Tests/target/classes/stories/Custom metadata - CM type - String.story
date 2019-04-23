!--NGN-7062
Feature:          Custom metadata - CM type - String
Narrative:
In order to:
As a              GlobalAdmin
I want to         Check String control in Project scheme


Scenario: Check deletion of String control on Project Overview
Meta:@projects
     @gdam
Given I created the agency 'A_CMCMTS_S14' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| U_CMCMTS_S14 | agency.admin | A_CMCMTS_S14 |
And created following 'project' custom metadata fields for agency 'A_CMCMTS_S14':
| FieldType | Description    |
| string    | CMF CMCMTS S14 |
When I login with details of 'U_CMCMTS_S14'
And create new project with following fields:
| FieldName      | FieldValue     |
| Name           | P_CMCMTS_S14   |
| Media type     | Broadcast      |
| CMF CMCMTS S14 | CMV_CMCMTS_S14 |
| Start date     | Today          |
| End date       | Tomorrow       |
And login with details of 'GlobalAdmin'
And go to the global 'project' metadata page for agency 'A_CMCMTS_S14'
And remove metadata field 'CMF CMCMTS S14' from metadata page
And wait for '2' seconds
And login with details of 'U_CMCMTS_S14'
And go to project 'P_CMCMTS_S14' overview page
And wait for '5' seconds
Then I 'should not' see following fields on opened Project Overview page:
| FieldName      | FieldValue     |
| CMF CMCMTS S14 | CMV_CMCMTS_S14 |