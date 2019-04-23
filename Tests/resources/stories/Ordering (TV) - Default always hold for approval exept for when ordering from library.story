!--ORD-3497
!--ORD-3709
Feature: Always hold for approval exept for when ordering from library
Narrative:
In order to:
As a AgencyAdmin
I want to check always holding for approval exept for when ordering from library

Scenario: check saving Always Hold For Approval and Except QCed masters
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAHFAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAHFAU1 | agency.admin | DAHFAA1      |
And logged in with details of 'DAHFAU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval | Except QCed Masters |
| should                   | should              |
And save own Delivery Setting
And refresh the page without delay
Then I should see following data for Delivery Setting form on user delivery setting page:
| Always Hold For Approval | Except QCed Masters |
| should                   | should              |

Scenario: check state of Except QCed masters that depending on Always Hold For Approval state
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAHFAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAHFAU1 | agency.admin | DAHFAA1      |
And logged in with details of 'DAHFAU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval |
| <AlwaysHoldForApproval>  |
And save own Delivery Setting
Then I should see '<State>' following fields 'Except QCed Masters' for Delivery Setting form on user delivery setting page

Examples:
| AlwaysHoldForApproval | State    |
| should not            | disabled |
| should                | enabled  |

Scenario: check Always hold for approval except when QC asset is from Library
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAHFAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAHFAU1 | agency.admin | DAHFAA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DAHFAA1':
| Advertiser | Brand    | Sub Brand | Product  |
| DAHFAAR3   | DAHFABR3 | DAHFASB3  | DAHFAPR3 |
And logged in with details of 'DAHFAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | DAHFAAR3   | DAHFABR3 | DAHFASB3  | DAHFAPR3 | DAHFAC3  | DAHFACN3_1   | 20       | 12/14/2022     | HD 1080i 25fps | DAHFAT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'DAHFACN3_1' with following fields:
| Job Number | PO Number |
| DAHFAJN3   | DAHFAPN3  |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval | Except QCed Masters |
| should                   | should              |
And save own Delivery Setting
And created 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| DAHFACN3_2   |
And added to 'tv' order item with clock number 'DAHFACN3_2' following qc asset 'DAHFAT3' of collection 'My Assets'
And open order item with clock number 'DAHFACN3_1' for order with market 'Republic of Ireland'
Then I 'should not' see order item held for approval for active cover flow
When I hold for approval active order item on cover flow
Then I 'should' see order item held for approval for active cover flow

Scenario: check Always hold for approval except when new asset is from Library
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAHFAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| DAHFAU1 | agency.admin | DAHFAA1      |streamlined_library,ordering|
And logged in with details of 'DAHFAU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval | Except QCed Masters |
| should                   | should              |
And save own Delivery Setting
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DAHFACN4     |
And added to 'tv' order item with clock number 'DAHFACN4' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And open order item with following clock number 'DAHFACN4'
Then I 'should' see order item held for approval for active cover flow



Scenario: check Always hold for approval except when new asset is from Projects
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAHFAA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAHFAU1 | agency.admin | DAHFAA1      |
And logged in with details of 'DAHFAU1'
And created 'DAHFAP5' project
And created '/DAHFAF5' folder for project 'DAHFAP5'
And uploaded into project 'DAHFAP5' following files:
| FileName             | Path     |
| /files/Fish2-Ad.mov  | /DAHFAF5 |
And waited while transcoding is finished in folder '/DAHFAF5' on project 'DAHFAP5' files page
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Hold For Approval | Except QCed Masters |
| should                   | should              |
And save own Delivery Setting
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DAHFACN5     |
And added to 'tv' order item with clock number 'DAHFACN5' following file '/files/Fish2-Ad.mov' from folder '/DAHFAF5' of project 'DAHFAP5'
And open order item with following clock number 'DAHFACN5'
Then I 'should' see order item held for approval for active cover flow
