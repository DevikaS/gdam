
Feature:          Integration with Sendplus S3
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Integration with Sendplus S3(api testing)


Scenario: Check of upload to projects via sendplus to S3 storage
Meta: @sendplusUATgdamsmoke
	  @livegdamsmoke
Given I logged in as 'GlobalAdmin'
And updated the following agency:
| Name      | Storage        |
| DefaultAgency | S3 |
And I logged in as 'AgencyAdmin'
And I created 'IWNVP' project
And created '/IWNVF2' folder for project 'IWNVP'
And uploaded '/files/logo3.jpg' file into '/IWNVF2' folder for 'IWNVP' project using sendplus middle tier api
And waited while preview is available in folder '/IWNVF2' on project 'IWNVP' files page
Then I 'should' see on Activity tab for file '/files/logo3.jpg' in folder '/IWNVF2' project 'IWNVP' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_uploaded | uploaded file |


Scenario: Check of upload/download to library via sendplus to S3 storage
Meta:@sendplusUATgdamsmoke
     @livegdamsmoke
Given I logged in as 'GlobalAdmin'
And updated the following agency:
| Name      | Storage        |
| DefaultAgency | S3 |
And I logged in as 'AgencyAdmin'
And I uploaded '/files/logo3.jpg' file into  library folder using sendplus middle tier api
And I waited while preview is visible on library page for collection 'My Assets' for asset 'logo3.jpg'NEWLIB
And on asset 'logo3.jpg' info page in Library for collection 'My Assets'NEWLIB
When I 'download master' on opened asset info page using sendplus
Then I should see message in jabber for asset 'logo3.jpg' from collection 'My Assets'