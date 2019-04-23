!--NGN-9827
Feature:          User with presentation.public_share.create permission can create public link for presentation
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check that user with presentation.public_share.create permission can create public link for presentation

Scenario: Check that presentation.public_share.create permission by default enabled only for agency.admin role
Meta:@globaladmin
    @gdam
Given I logged in as 'GlobalAdmin'
When I open role '<GlobalRole>' page with parent 'DefaultAgency'
Then I 'should' see '<PermissionState>' permissions 'presentation.public_share.create' on opened global role page

Examples:
| GlobalRole    | PermissionState |
| agency.admin  | selected        |
| agency.user   | unselected      |
| guest.user    | unselected      |
| library.admin | unselected      |
| library.user  | unselected      |


Scenario: User with presentation.public_share.create permission should see Public Share functionality on send presentation popup
Meta:@library
     @gdam
Given I created 'LR_UPPSCPCPL_S01_1' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| presentation.create        |
And created 'LR_UPPSCPCPL_S01_2' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission                       |
| asset_filter_category.read       |
| asset.read                       |
| presentation.create              |
| presentation.public_share.create |
And created users with following fields:
| Email       | Role         |
| <UserEmail> | <GlobalRole> |
And logged in with details of '<UserEmail>'
And created following reels:
| Name               |
| <PresentationName> |
And on the presentations assets page '<PresentationName>'
When I open Send presentation popup
Then '<Condition>' see elements 'PublicShareTab,PublicLinkAccessTab' on page 'SendPresentationPopUp'

Examples:
| UserEmail         | GlobalRole         | PresentationName  | Condition  |
| P_UPPSCPCPL_S01_1 | agency.admin       | P_UPPSCPCPL_S01_1 | should     |
| P_UPPSCPCPL_S01_2 | agency.user        | P_UPPSCPCPL_S01_2 | should not |
| P_UPPSCPCPL_S01_3 | LR_UPPSCPCPL_S01_1 | P_UPPSCPCPL_S01_3 | should not |
| P_UPPSCPCPL_S01_4 | LR_UPPSCPCPL_S01_2 | P_UPPSCPCPL_S01_4 | should     |