!--NGN-16206
Feature:          Agency Global Rule and Project Access Rule - For Projects
Narrative:
In order to
As a              AgencyAdmin
I want to         Validate the Global and project access rules against projects

Scenario: Check that users assigned to the project against Global-Access-Rule cannot have access to the unpublished project and project owner can have access to unpublished project
Meta:@gdam
@projects
Given I created the agency 'PARAA1' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_01 | agency.admin | PARAA1   |
| U_PAR_02 | agency.user | PARAA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA1':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I am on agency 'PARAA1' global access rules page
And I select global role 'Agency User'
And I select meta data 'Media type' with value 'Broadcast'
And I select project role 'Project Contributor'
And I click on save button
And I waited for '3' seconds
And logged in with details of 'U_PAR_01'
And the following projects were created:
| Name | Advertiser    | Media Type | Start date | End date   |Published|
| PAR_P1 | PARAR | Broadcast    | [Today]    | [Tomorrow] |false|
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_01| PAR_P1|should|
|U_PAR_02| PAR_P1|should|
And I should see 'PAR_P1' project in project list
When I login with details of 'U_PAR_02'
Then I shouldn't see 'PAR_P1' project in project list

Scenario: Check that users assigned to the project against Global-Access-Rule and project owner can have access to the published project
Meta:@gdam
@projects
Given I created the agency 'PARAA2' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_03 | agency.admin | PARAA2   |
| U_PAR_04 | agency.user | PARAA2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA2':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I am on agency 'PARAA2' global access rules page
And I select global role 'Agency User'
And I select meta data 'Advertiser' with value 'PARAR'
And I select project role 'Project Contributor'
And I click on save button
And I waited for '3' seconds
And logged in with details of 'U_PAR_03'
And the following projects were created:
| Name | AdvertiserUnique    | Media Type | Start date | End date   |
| PAR_P2 | PARAR | Broadcast    | [Today]    | [Tomorrow] |
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_03| PAR_P2|should|
|U_PAR_04| PAR_P2|should|
And I should see 'PAR_P2' project in project list
When I login with details of 'U_PAR_04'
Then I should see 'PAR_P2' project in project list

Scenario: Check that users are not displayed in project team tab when project is created in such a way that not matching the meta data defined in Global-Access-Rule
Meta:@gdam
@projects
Given I created the agency 'PARAA5' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_05 | agency.admin | PARAA5  |
| U_PAR_06 | agency.user | PARAA5  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA5':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I am on agency 'PARAA5' global access rules page
And I select global role 'Agency User'
And I select meta data 'Media type' with value 'Broadcast'
And I select project role 'Project User'
And I click on save button
And I waited for '3' seconds
And logged in with details of 'U_PAR_05'
And the following projects were created:
| Name | Advertiser    | Media Type | Start date | End date   |
| PAR_P5 | PARAR | Digital    | [Today]    | [Tomorrow] |
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_05| PAR_P5|should|
|U_PAR_06| PAR_P5|should not|

Scenario: Check that project owner cannot remove the users added to the project through Global-Access-Rule in teams tab
Meta:@gdam
@projects
Given I created the agency 'PARAA6' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_07 | agency.admin | PARAA6  |
| U_PAR_08 | agency.user | PARAA6   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA6':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I am on agency 'PARAA6' global access rules page
And I select global role 'Agency User'
And I select meta data 'Media type' with value 'Print'
And I select project role 'Project Contributor'
And I click on save button
And I waited for '3' seconds
And logged in with details of 'U_PAR_07'
And the following projects were created:
| Name | Advertiser    | Media Type | Start date | End date   |
| PAR_P6 | PARAR | Print    | [Today]    | [Tomorrow] |
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_07| PAR_P6|should|
|U_PAR_08| PAR_P6|should|
When I select user 'U_PAR_08' on project 'PAR_P6' team page
Then I should see element 'RemoveButton' on page 'TeamsPage' in following state 'disabled'

Scenario: Check that project owner cannot remove the permission added to the project through Global-Access-Rule in Manage permission pop-up
Meta: @gdam
@projects
!--NGN-18039, Randomly it fails. So refer bug for actual failure
Given I created the agency 'PARAA7' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_09 | agency.admin | PARAA7  |
| U_PAR_10 | agency.user | PARAA7   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA7':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I am on agency 'PARAA7' global access rules page
And I select global role 'Agency User'
And I select meta data 'Media type' with value 'Broadcast'
And I select project role 'Project Contributor'
And I click on save button
And I waited for '3' seconds
And logged in with details of 'U_PAR_09'
And the following projects were created:
| Name | Advertiser    | Media Type | Start date | End date   |
| PAR_P7 | PARAR | Broadcast    | [Today]    | [Tomorrow] |
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_09| PAR_P7|should|
|U_PAR_10| PAR_P7|should|
When I open user 'U_PAR_10' permissions on project 'PAR_P7' team page
Then I should see role 'Project Contributor' is displayed in manage permissions popup of project 'PAR_P7' team for user 'U_PAR_10'
And I 'should not' see the remove icon on manage permissions popup of project team tab

Scenario: Check that project owner can see the users added to the project through Global-Access-Rule and users who have access to project individually in teams tab
Meta:@gdam
@projects
Given I created the agency 'PARAA8' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_11 | agency.admin | PARAA8  |
| U_PAR_12 | agency.user | PARAA8   |
| U_PAR_13 | guest.user | PARAA8   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA8':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I am on agency 'PARAA8' global access rules page
And I select global role 'Agency User'
And I select meta data 'Media type' with value 'Broadcast'
And I select project role 'Project Contributor'
And I click on save button
And I waited for '3' seconds
And logged in with details of 'U_PAR_11'
And the following projects were created:
| Name | Advertiser    | Media Type | Start date | End date   |
| PAR_P8 | PARAR | Broadcast    | [Today]    | [Tomorrow] |
And created '/PARF1' folder for project 'PAR_P8'
And created 'PARR11' role in 'project' group for advertiser 'PARAA8'
And I am on project 'PAR_P8' teams page
When I add user 'U_PAR_13' into project 'PAR_P8' team with role 'PARR11' expired '12.12.2021' for folder on popup '/PARF1'
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_11| PAR_P8|should|
|U_PAR_12| PAR_P8|should|
|U_PAR_13| PAR_P8|should|



Scenario: Check that project owner cannot override the Global-Access-Rule
Meta:@gdam
@projects
Given I created the agency 'PARAA9' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_14 | agency.admin | PARAA9  |
| U_PAR_15 | agency.user | PARAA9   |
| U_PAR_16 | guest.user | PARAA9   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA9':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I am on agency 'PARAA9' global access rules page
And I select global role 'Agency User'
And I select meta data 'Media type' with value 'Broadcast'
And I select project role 'Project User'
And I click on save button
And I waited for '3' seconds
And logged in with details of 'U_PAR_14'
And the following projects were created:
| Name | Advertiser    | Media Type | Start date | End date   |
| PAR_P9 | PARAR | Broadcast    | [Today]    | [Tomorrow] |
And created '/PARF1' folder for project 'PAR_P9'
And created 'PARR12' role in 'project' group for advertiser 'PARAA9'
And I am on project 'PAR_P9' teams page
When I add user 'U_PAR_16' into project 'PAR_P9' team with role 'PARR12' expired '12.12.2021' for folder on popup '/PARF1'
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_14| PAR_P9|should|
|U_PAR_15| PAR_P9|should|
|U_PAR_16| PAR_P9|should|
When I select user 'U_PAR_15' on project 'PAR_P9' team page
And I select user 'U_PAR_16' on project 'PAR_P9' team page
And I clicked on Remove button on project team page
Then I 'should' see user 'U_PAR_15' name in teams of project 'PAR_P9'

Scenario: Check that Global-Access-Rule is saved
Meta:@gdam
@projects
Given I created the agency 'PARAA10' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_17| agency.admin | PARAA10   |
| U_PAR_18 | agency.user | PARAA10   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA10':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I am on agency 'PARAA10' global access rules page
And I select global role 'Agency User'
And I select meta data 'Media type' with value 'Broadcast'
And I select project role 'Project Contributor'
And I click on save button
And I have refreshed the page
Then I should see the global rule saved with data 'Agency User,Media type,Project Contributor,Never expired'

Scenario: Check that user created against Global-Access-Rule have access to the existing project that was created before creating Global-Access-Rule
Meta:@gdam
@projects
Given I created the agency 'PARAA11' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_19 | agency.admin | PARAA11   |
| U_PAR_20 | agency.user | PARAA11   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA11':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And logged in with details of 'U_PAR_19'
And the following projects were created:
| Name | Advertiser    | Media Type | Start date | End date   |
| PAR_P11 | PARAR | Broadcast    | [Today]    | [Tomorrow] |
And I logged in as 'GlobalAdmin'
And I am on agency 'PARAA11' global access rules page
And I select global role 'Agency User'
And I select meta data 'Media type' with value 'Broadcast'
And I select project role 'Project Contributor'
And I click on save button
And I waited for '3' seconds
And logged in with details of 'U_PAR_19'
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_19| PAR_P11|should|
|U_PAR_20| PAR_P11|should|
When I login with details of 'U_PAR_20'
Then I should see 'PAR_P11' project in project list

Scenario: Check that users assigned to the project against Project-Access-Rule cannot have access to the unpublished project and project owner can have access to unpublished project
Meta: @gdam
@projects
Given I created the agency 'PARAA12' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_21 | agency.admin | PARAA12  |
| U_PAR_22 | agency.user | PARAA12  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA12':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I updated agency 'PARAA12' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'U_PAR_21'
And waited for '3' seconds
And I am on the 'project' metadata page
And I clicked 'Project Type' button in 'editable metadata' section on opened metadata page
And I created following Catalogue Structure chains on opened Settings and Customization page:
|MetaDataValue|
|Internal|
And I created new project with following fields:
| FieldName  | FieldValue    |
| Name       | PAR_P12       |
| Media type | Broadcast     |
| Project Type | Internal    |
| Advertiser | PARAR     |
| Start date | Today         |
| End date   | Tomorrow|
And I am on Users list page
And waited for '5' seconds
When I select user 'U_PAR_22' on Users page
And refresh the page
And I create project access rule:
| MetaData     | MetaValue | Role         |
| Project Type | Internal  |Project User  |
And refresh the page
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_21| PAR_P12|should|
|U_PAR_22| PAR_P12|should|
And I should see 'PAR_P12' project in project list
When I login with details of 'U_PAR_22'
Then I shouldn't see 'PAR_P12' project in project list


Scenario: Check that users assigned to the project against Project-Access-Rule and Project Owner can have access to the published project
Meta:@gdam
@projects
Given I created the agency 'PARAA13' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_23 | agency.admin | PARAA13  |
| U_PAR_24 | agency.user | PARAA13  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA13':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I updated agency 'PARAA13' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'U_PAR_23'
And I am on the 'project' metadata page
And I clicked 'Project Type' button in 'editable metadata' section on opened metadata page
And I created following Catalogue Structure chains on opened Settings and Customization page:
|MetaDataValue|
|Internal|
And I created new project with following fields:
| FieldName  | FieldValue    |
| Name       | PAR_P13 |
| Media type | Broadcast     |
| Project Type | Internal     |
| Advertiser | PARAR     |
| Start date | Today         |
| End date   | Tomorrow|
And I am on Users list page
When I select user 'U_PAR_24' on Users page
And refresh the page
And I create project access rule:
| MetaData     | MetaValue | Role         |
| Project Type | Internal  | project.user |
And publish the project 'PAR_P13'
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_23| PAR_P13|should|
|U_PAR_24| PAR_P13|should|
And I should see 'PAR_P13' project in project list
When I login with details of 'U_PAR_24'
Then I should see 'PAR_P13' project in project list

Scenario: Check that users are not displayed in team tab when project is created in such a way that not matching the meta data defined in Project-Access Rule
Meta:@gdam
@projects
Given I created the agency 'PARAA14' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_25 | agency.admin | PARAA14  |
| U_PAR_26 | agency.user | PARAA14  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA14':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I updated agency 'PARAA14' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'U_PAR_25'
And I created new project with following fields:
| FieldName  | FieldValue    |
| Name       | PAR_P14 |
| Media type | Broadcast     |
|Campaign    |TV             |
| Start date | Today         |
| End date   | Tomorrow|
And waited for '5' seconds
And I am on Users list page
And refreshed the page
When I select user 'U_PAR_25' on Users page
And I select user 'U_PAR_26' on Users page
And refresh the page
And I create project access rule:
| MetaData     | MetaValue | Role         |
| Campaign | Radio  | Project Contributor |
And publish the project 'PAR_P14'
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_25| PAR_P14|should|
|U_PAR_26| PAR_P14|should not|

Scenario: Check that project owner cannot remove the users added to the project through Project-Access-Rule in teams tab
Meta:@gdam
@projects
Given I created the agency 'PARAA15' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_27 | agency.admin | PARAA15  |
| U_PAR_28 | agency.user | PARAA15  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA15':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I updated agency 'PARAA15' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'U_PAR_27'
And I created new project with following fields:
| FieldName  | FieldValue    |
| Name       | PAR_P15 |
| Media type | Broadcast     |
|Campaign    |TV             |
| Start date | Today         |
| End date   | Tomorrow|
And waited for '5' seconds
And I am on Users list page
And refreshed the page
When I select user 'U_PAR_27' on Users page
And I select user 'U_PAR_28' on Users page
And I create project access rule:
| MetaData     | MetaValue | Role         |
| Campaign | TV  | project.contributor |
And publish the project 'PAR_P15'
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_27| PAR_P15|should|
|U_PAR_28| PAR_P15|should|
When I select user 'U_PAR_28' on project 'PAR_P15' team page
Then I should see element 'RemoveButton' on page 'TeamsPage' in following state 'disabled'

Scenario: Check that project owner cannot remove the permission added to the project through Project-Access-Rule in Manage permission pop-up
Meta:@gdam
@projects
!--bug has been added for this NGN-20215
Given I created the agency 'PARAA16' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_29 | agency.admin | PARAA16  |
| U_PAR_30 | agency.user | PARAA16  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA16':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And waited for '2' seconds
And I updated agency 'PARAA16' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'U_PAR_29'
And the following projects were created:
| Name | Advertiser    | Media Type | Start date | End date   |
| PAR_P16 | PARAR | Broadcast    | [Today]    | [Tomorrow] |
And waited for '5' seconds
And I am on Users list page
And refreshed the page
When I select user 'U_PAR_29' on Users page
And I select user 'U_PAR_30' on Users page
And I create project access rule:
| MetaData     | MetaValue | Role        |
| Advertiser   | PARAR     | Project User    |
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_29| PAR_P16|should|
|U_PAR_30| PAR_P16|should|
When I open user 'U_PAR_30' permissions on project 'PAR_P16' team page
Then I should see role 'Project User' is displayed in manage permissions popup of project 'PAR_P16' team for user 'U_PAR_30'
And I 'should not' see the remove icon on manage permissions popup of project team tab


Scenario: Check that project owner can see the users added to the project through Project-Access-Rule and users who have access to project individually in teams tab
Meta:@gdam
@projects
Given I created the agency 'PARAA17' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_31 | agency.admin | PARAA17  |
| U_PAR_32 | agency.user | PARAA17  |
| U_PAR_33 | guest.user | PARAA17   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA17':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I updated agency 'PARAA17' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'U_PAR_31'
And I created new project with following fields:
| FieldName  | FieldValue    |
| Name       | PAR_P17 |
| Media type | Broadcast     |
|Campaign|TV|
| Start date | Today         |
| End date   | Tomorrow|
And created '/PARF1' folder for project 'PAR_P17'
And published the project 'PAR_P17'
And created 'PARR13' role in 'project' group for advertiser 'PARAA17'
And I am on Users list page
When I select user 'U_PAR_32' on Users page
And refresh the page
And I create project access rule:
| MetaData     | MetaValue | Role         |
| Campaign | TV  | project.user |
And I go to project 'PAR_P17' teams page
And I add user 'U_PAR_33' into project 'PAR_P17' team with role 'PARR13' expired '12.12.2021' for folder on popup '/PARF1'
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_31| PAR_P17|should|
|U_PAR_32| PAR_P17|should|
|U_PAR_33| PAR_P17|should|


Scenario: Check that project owner cannot override the Project-Access-Rule
Meta:@gdam
@projects
Given I created the agency 'PARAA18' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PAR_34 | agency.admin | PARAA18  |
| U_PAR_35 | agency.user | PARAA18  |
| U_PAR_36 | guest.user | PARAA18   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PARAA18':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR    | PARBR | PARSB   | PARPR |
And I logged in as 'GlobalAdmin'
And I updated agency 'PARAA18' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'U_PAR_34'
And I created new project with following fields:
| FieldName  | FieldValue    |
| Name       | PAR_P18 |
| Media type | Broadcast     |
|Campaign|TV|
| Start date | Today         |
| End date   | Tomorrow|
And created '/PARF1' folder for project 'PAR_P18'
And published the project 'PAR_P18'
And created 'PARR14' role in 'project' group for advertiser 'PARAA18'
And I am on Users list page
When I select user 'U_PAR_35' on Users page
And refresh the page
And I create project access rule:
| MetaData     | MetaValue | Role         |
| Campaign | TV  | project.user |
And I go to project 'PAR_P18' teams page
And I add user 'U_PAR_36' into project 'PAR_P18' team with role 'PARR14' expired '12.12.2021' for folder on popup '/PARF1'
Then I '<Should>' see the following users on project team page with interval:
|UserName|Project|Should|
|U_PAR_34| PAR_P18|should|
|U_PAR_35| PAR_P18|should|
|U_PAR_36| PAR_P18|should|
When I select user 'U_PAR_35' on project 'PAR_P18' team page
And I select user 'U_PAR_36' on project 'PAR_P18' team page
And I clicked on Remove button on project team page
Then I 'should' see user 'U_PAR_35' name in teams of project 'PAR_P18'









