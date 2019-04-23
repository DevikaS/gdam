Feature:          Project Filters
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that empty project filters don't show


Scenario: check that if no matching projects than filters show no results for user - do not show them.
Meta:@gdam
@projects
Given I created the agency 'PFDSEF_A1' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PFDSEF_A1':
| Advertiser  |
| PFDSEF_ADV1 |
| PFDSEF_ADV2 |
And turned project filters 'on' for metadata fields 'Advertiser' for agency 'PFDSEF_A1'
And created users with following fields:
| Agency    | Email     | Role         |
| PFDSEF_A1 | PFDSEF_U1 | agency.admin |
And logged in with details of 'PFDSEF_U1'
And created following projects:
| Name      | AdvertiserUnique |
| PFDSEF_P1 | PFDSEF_ADV1      |
When I go to project list page
Then I 'should' see project filters 'PFDSEF_ADV1' on project list page
And I 'should not' see project filters 'PFDSEF_ADV2' on project list page


Scenario: check that if no projects that user can see according to permissions than do not show filtes for this projects.
Meta:@gdam
@projects
Given I created the agency 'PFDSEF_A1' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PFDSEF_A1':
| Advertiser  |
| PFDSEF_ADV1 |
| PFDSEF_ADV2 |
And turned project filters 'on' for metadata fields 'Advertiser' for agency 'PFDSEF_A1'
And created users with following fields:
| Agency    | Email       | Role         |
| PFDSEF_A1 | PFDSEF_U2_1 | agency.admin |
| PFDSEF_A1 | PFDSEF_U2_2 | agency.user  |
And logged in with details of 'PFDSEF_U2_1'
And created following projects:
| Name        | AdvertiserUnique | Administrators |
| PFDSEF_P2_1 | PFDSEF_ADV1      |                |
| PFDSEF_P2_2 | PFDSEF_ADV2      | PFDSEF_U2_2    |
When I login with details of 'PFDSEF_U2_2'
And go to project list page
Then I 'should' see project filters 'PFDSEF_ADV2' on project list page
And I 'should not' see project filters 'PFDSEF_ADV1' on project list page


Scenario: Check that users in multiple BU,should see all Advertiser values in Project Filters
!--NGN-16211
Meta:@gdam
@projects
Given I created the agency 'PFDSEF_A2' with default attributes
And I created the agency 'PFDSEF_A3' with default attributes
And I created the agency 'PFDSEF_A4' with default attributes
And created users with following fields:
| Agency      | Email      | Role         |
| PFDSEF_A2   | PFDSEF_U_3 | agency.admin |
And added existing user 'PFDSEF_U_3' to agency 'PFDSEF_A3' with role 'agency.admin'
And added existing user 'PFDSEF_U_3' to agency 'PFDSEF_A4' with role 'agency.admin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PFDSEF_A2':
| Advertiser  | Brand       | Sub Brand    | Product   |
| PFDSEF_ADV1 | PFDSEF_B1   |PFDSEF_SB1    |PFDSEF_P1  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PFDSEF_A3':
| Advertiser  | Brand       | Sub Brand    | Product   |
| PFDSEF_ADV3 | PFDSEF_B3   |PFDSEF_SB3    |PFDSEF_P3  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PFDSEF_A4':
| Advertiser  | Brand       | Sub Brand    | Product   |
| PFDSEF_ADV5 | PFDSEF_B5   |PFDSEF_SB5    |PFDSEF_P5  |
And turned project filters 'on' for metadata fields 'Advertiser' for agency 'PFDSEF_A2'
And turned project filters 'on' for metadata fields 'Advertiser' for agency 'PFDSEF_A3'
And turned project filters 'on' for metadata fields 'Advertiser' for agency 'PFDSEF_A4'
When I login with details of 'PFDSEF_U_3'
And created following projects with Advertiser hierarchy:
| Name      | AdvertiserUnique |Product/BrandUnique|ProductUnique|SubBrandUnique|Business Unit|
| PFDSEF_P1 | PFDSEF_ADV1      |PFDSEF_B1          |PFDSEF_P1    |PFDSEF_SB1    |PFDSEF_A2    |
| PFDSEF_P3 | PFDSEF_ADV3      |PFDSEF_B3          |PFDSEF_P3    |PFDSEF_SB3    |PFDSEF_A3    |
| PFDSEF_P4 | PFDSEF_ADV5      |PFDSEF_B5          |             |              |PFDSEF_A4    |
And I go to project list page
Then I 'should' see project filter hierarchy 'PFDSEF_ADV1,PFDSEF_B1,PFDSEF_SB1,PFDSEF_P1,PFDSEF_ADV3,PFDSEF_B3,PFDSEF_SB3,PFDSEF_P3,PFDSEF_ADV5,PFDSEF_B5' on project list page
And refresh the page
Then I 'should not' see project filter hierarchy 'PFDSEF_P5,PFDSEF_SB5' on project list page

Scenario: Check that Project filter work correctly for user
!--NGN-16211
Meta:@gdam
@projects
Given I created the agency 'PFDSEF_A4' with default attributes
And created users with following fields:
| Agency      | Email      | Role         |
| PFDSEF_A4   | PFDSEF_U_4 | agency.admin |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PFDSEF_A4':
| Advertiser  | Brand       | Sub Brand    | Product   |
| PFDSEF_ADV5 | PFDSEF_B5   |PFDSEF_SB5    |PFDSEF_P5  |
| PFDSEF_ADV6 | PFDSEF_B6   |PFDSEF_SB6    |PFDSEF_P6  |
And turned project filters 'on' for metadata fields 'Advertiser' for agency 'PFDSEF_A4'
When I login with details of 'PFDSEF_U_4'
And created following projects:
| Name      | AdvertiserUnique |Product/BrandUnique|ProductUnique|SubBrandUnique|Business Unit|
| PFDSEF_P4 | PFDSEF_ADV5      |PFDSEF_B5          |PFDSEF_P5    |PFDSEF_SB5    |PFDSEF_ADV5  |
| PFDSEF_P5 | PFDSEF_ADV6      |PFDSEF_B6          |PFDSEF_P6    |PFDSEF_SB6    |PFDSEF_ADV6  |
And I go to project list page
And I select Project filtering by view '<View>'
Then I 'should' see project '<VisibleObjectsApplyFilter>' on project list page
And I 'should not' see project '<NotVisibleObjectsApplyFilter>' on project list page
When I select clear filter in the Project List Page
Then I 'should' see project '<VisibleObjectsClearFilter>' on project list page
Examples:
|View        |VisibleObjectsClearFilter   |VisibleObjectsApplyFilter|NotVisibleObjectsApplyFilter|
|PFDSEF_ADV5 |PFDSEF_P4,PFDSEF_P5         |PFDSEF_P4                |PFDSEF_P5                   |

