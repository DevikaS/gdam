!--ORD-4040
!--ORD-4725
Feature: Determine billing on behalf BU by metadata not client picking
Narrative:
In order to:
As a GlobalAdmin
I want to check determining billing on behalf BU by metadata not client picking

Scenario: Check correct saving billing rules for partners agency
!--New bug logged NGN-16915, However there is a workaround of adding a refresh step below
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| DBOBA1_1 | DefaultA4User |
| DBOBA1_2 | DefaultA4User |
And logged in with details of 'GlobalAdmin'
And added agency 'DBOBA1_2' as a partner for agency 'DBOBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBOBA1_1':
| Advertiser | Brand     | Sub Brand | Product   |
| DBOBAR1_1  | DBOBBR1_1 | DBOBSB1_1 | DBOBPR1_1 |
And updated metadatas 'Advertiser,Product,Campaign' in schema 'common' of agency 'DBOBA1_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And I am on agency 'DBOBA1_1' partners page
When I fill following fields for Billing Rule Builder form on agency partners page:
| Partner BU | Rules Criterias                                          |
| DBOBA1_2   | Advertiser=DBOBAR1_1,Product=DBOBPR1_1,Campaign=DBOBC1_1 |
And save billing rules on Billing Rule Builder form
And refresh the page
Then I should see following data on Billing Rule Builder form:
| Partner BU | Rules Criterias                                          |
| DBOBA1_2   | Advertiser=DBOBAR1_1,Product=DBOBPR1_1,Campaign=DBOBC1_1 |

Scenario: Check that only fields with checked Make this field available for billing checkbox are displayed in Billing rule builder
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| DBOBA2_1 | DefaultA4User |
| DBOBA2_2 | DefaultA4User |
And added agency 'DBOBA2_2' as a partner for agency 'DBOBA2_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And updated metadatas 'Advertiser' in schema 'common' of agency 'DBOBA2_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And I am on agency 'DBOBA2_1' partners page
Then I 'should' see available following metadata fields 'Advertiser' on Billing Rule Builder form
And 'should not' see available following metadata fields 'Product,Campaign' on Billing Rule Builder form

Scenario: Check that Set up billing button appears after checking Can bill on my behalf checkbox
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| DBOBA1_1 | DefaultA4User |
| DBOBA1_2 | DefaultA4User |
And added agency 'DBOBA1_2' as a partner for agency 'DBOBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And I am on agency 'DBOBA1_1' partners page
Then I 'should' see Set Up Billing button on agency partners page
When I go to agency 'DBOBA1_2' partners page
Then I 'should not' see Set Up Billing button on agency partners page

Scenario: Check that hidden fields aren't available in Billing rule builder
Meta: @ordering
      @obug
!--FAB-492
Given I created the following agency:
| Name     | A4User        |
| DBOBA4_1 | DefaultA4User |
| DBOBA4_2 | DefaultA4User |
And logged in with details of 'GlobalAdmin'
And added agency 'DBOBA4_2' as a partner for agency 'DBOBA4_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And updated metadatas 'Advertiser,Product,Campaign' in schema 'common' of agency 'DBOBA4_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And I am on the global 'common custom' metadata page for agency 'DBOBA4_1'
And clicked 'Product' button in 'common metadata' section on opened metadata page
When I check 'Hide' checkbox on opened string field Settings and Customization page
And save metadata field settings
And go to agency 'DBOBA4_1' partners page
And refresh the page
Then I 'should' see available following metadata fields 'Advertiser,Campaign' on Billing Rule Builder form
And 'should not' see available following metadata fields 'Product' on Billing Rule Builder form

Scenario: Check that user cannot manually change value of Invoice To field on order item page if billing rules work
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| DBOBA5_1 | DefaultA4User |
| DBOBA5_2 | DefaultA4User |
And added agency 'DBOBA5_2' as a partner for agency 'DBOBA5_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| DBOBU5_1 | agency.admin | DBOBA5_1     |
| DBOBU5_2 | agency.admin | DBOBA5_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBOBA5_1':
| Advertiser | Brand     | Sub Brand | Product   |
| DBOBAR5_1  | DBOBBR5_1 | DBOBSB5_1 | DBOBPR5_1 |
And updated metadatas 'Advertiser,Product,Campaign' in schema 'common' of agency 'DBOBA5_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And I am on agency 'DBOBA5_1' partners page
And filled following fields for Billing Rule Builder form on agency partners page:
| Partner BU | Rules Criterias                                          |
| DBOBA5_2   | Advertiser=DBOBAR5_1,Product=DBOBPR5_1,Campaign=DBOBC5_1 |
And saved billing rules on Billing Rule Builder form
And logged in with details of 'DBOBU5_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | DBOBAR5_1  | DBOBBR5_1 | DBOBSB5_1 | DBOBPR5_1 | DBOBC5_1 | DBOBCN5      | 20       | 10/14/2022     | HD 1080i 25fps | DBOBT5 | Already Supplied   |
When I open order item with following clock number 'DBOBCN5'
Then I 'should not' see Invoice To option on order item page

Scenario: Check that after hidding field billing rule based on it disappears
!--ORD-4715
!--FAB-492
Meta: @ordering
      @obug
Given I created the following agency:
| Name     | A4User        |
| DBOBA6_1 | DefaultA4User |
| DBOBA6_2 | DefaultA4User |
And logged in with details of 'GlobalAdmin'
And added agency 'DBOBA6_2' as a partner for agency 'DBOBA6_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBOBA6_1':
| Advertiser | Brand     | Sub Brand | Product   |
| DBOBAR6_1  | DBOBBR6_1 | DBOBSB6_1 | DBOBPR6_1 |
And updated metadatas 'Advertiser,Product,Campaign' in schema 'common' of agency 'DBOBA6_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And I am on agency 'DBOBA6_1' partners page
And filled following fields for Billing Rule Builder form on agency partners page:
| Partner BU | Rules Criterias                                          |
| DBOBA6_2   | Advertiser=DBOBAR6_1,Product=DBOBPR6_1,Campaign=DBOBC6_1 |
And saved billing rules on Billing Rule Builder form
And I am on the global 'common custom' metadata page for agency 'DBOBA6_1'
And clicked 'Product' button in 'common metadata' section on opened metadata page
When I check 'Hide' checkbox on opened string field Settings and Customization page
And save metadata field settings
And go to agency 'DBOBA6_1' partners page
And refresh the page
Then I should see following data on Billing Rule Builder form:
| Partner BU | Rules Criterias                        |
| DBOBA6_2   | Advertiser=DBOBAR6_1,Campaign=DBOBC6_1 |

Scenario: Check that specifiing Billing rules don't affect Ordering on behalf of functionality
!--ORD-4756
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| DBOBA7_1 | DefaultA4User |
| DBOBA7_2 | DefaultA4User |
And added agency 'DBOBA7_2' as a partner for agency 'DBOBA7_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| DBOBU7_1 | agency.admin | DBOBA7_1     |
| DBOBU7_2 | agency.admin | DBOBA7_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBOBA7_1':
| Advertiser | Brand     | Sub Brand | Product   |
| DBOBAR7_1  | DBOBBR7_1 | DBOBSB7_1 | DBOBPR7_1 |
And updated metadatas 'Advertiser,Product,Campaign' in schema 'common' of agency 'DBOBA7_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And added existing user 'DBOBU7_2' to agency 'DBOBA7_1' with role 'agency.admin'
And I am on agency 'DBOBA7_1' partners page
And filled following fields for Billing Rule Builder form on agency partners page:
| Partner BU | Rules Criterias                                          |
| DBOBA7_2   | Advertiser=DBOBAR7_1,Product=DBOBPR7_1,Campaign=DBOBC7_1 |
And saved billing rules on Billing Rule Builder form
And logged in with details of 'DBOBU7_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DBOBCN7      |
When I open order item with following clock number 'DBOBCN7'
Then I 'should' see on behalf of BU option on order item page

Scenario: Check that user cannot manually change value of Invoice To field on order proceed page if billing rules work
!--ORD-4736
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| DBOBA8_1 | DefaultA4User |
| DBOBA8_2 | DefaultA4User |
And added agency 'DBOBA8_2' as a partner for agency 'DBOBA8_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| DBOBU8_1 | agency.admin | DBOBA8_1     |
| DBOBU8_2 | agency.admin | DBOBA8_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBOBA8_1':
| Advertiser | Brand     | Sub Brand | Product   |
| DBOBAR8_1  | DBOBBR8_1 | DBOBSB8_1 | DBOBPR8_1 |
And updated metadatas 'Advertiser,Product,Campaign' in schema 'common' of agency 'DBOBA8_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And I am on agency 'DBOBA8_1' partners page
And filled following fields for Billing Rule Builder form on agency partners page:
| Partner BU | Rules Criterias                                          |
| DBOBA8_2   | Advertiser=DBOBAR8_1,Product=DBOBPR8_1,Campaign=DBOBC8_1 |
And saved billing rules on Billing Rule Builder form
And logged in with details of 'DBOBU8_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | DBOBAR8_1  | DBOBBR8_1 | DBOBSB8_1 | DBOBPR8_1 | DBOBC8_1 | DBOBCN8      | 20       | 10/14/2022     | HD 1080i 25fps | DBOBT8 | Already Supplied   | BSkyB Green Button:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'DBOBCN8'
Then I 'should not' see Invoice To option on order proceed page

Scenario: Check that SAP ID and prices of agency which bill for order is used if billing rules work instead of using SAP ID and prices agency which creates order
!--ORD-5047
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Country        | SAP ID       |
| DBOBA9_1 | DefaultA4User | United Kingdom | DefaultSapID |
| DBOBA9_2 | DefaultA4User | United Kingdom | BM0005       |
And logged in with details of 'GlobalAdmin'
And added agency 'DBOBA9_2' as a partner for agency 'DBOBA9_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| DBOBU9_1 | agency.admin | DBOBA9_1     |
| DBOBU9_2 | agency.admin | DBOBA9_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBOBA9_1':
| Advertiser | Brand     | Sub Brand | Product   |
| DBOBAR9_1  | DBOBBR9_1 | DBOBSB9_1 | DBOBPR9_1 |
And updated metadatas 'Advertiser,Product,Campaign' in schema 'common' of agency 'DBOBA9_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And I am on agency 'DBOBA9_1' partners page
And filled following fields for Billing Rule Builder form on agency partners page:
| Partner BU | Rules Criterias                                          |
| DBOBA9_2   | Advertiser=DBOBAR9_1,Product=DBOBPR9_1,Campaign=DBOBC9_1 |
And saved billing rules on Billing Rule Builder form
And logged in with details of 'DBOBU9_1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | DBOBAR9_1  | DBOBBR9_1 | DBOBSB9_1 | DBOBPR9_1 | DBOBC9_1 | DBOBCN9      | 20       | 10/14/2022     | HD 1080i 25fps | DBOBT9 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'DBOBCN9'
And click Proceed button on order item page
And wait for '15' seconds
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax   | Total  |
| SD Standard Normal (Digital) | 1   | 50.00  | 50.00        | 50.00    | 10.50 | 60.50 |


Scenario: Check that billing rules correctly definite agency which will bill
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | Country        | SAP ID       |
| DBOBA10_1 | DefaultA4User | United Kingdom | DefaultSapID |
| DBOBA10_2 | DefaultA4User | United Kingdom | BM0005       |
And logged in with details of 'GlobalAdmin'
And added agency 'DBOBA10_2' as a partner for agency 'DBOBA10_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| DBOBU10_1 | agency.admin | DBOBA10_1    |
| DBOBU10_2 | agency.admin | DBOBA10_2    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBOBA10_1':
| Advertiser | Brand      | Sub Brand  | Product    |
| DBOBAR10_1 | DBOBBR10_1 | DBOBSB10_1 | DBOBPR10_1 |
And updated metadatas 'Advertiser,Product,Campaign' in schema 'common' of agency 'DBOBA10_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And I am on agency 'DBOBA10_1' partners page
And filled following fields for Billing Rule Builder form on agency partners page:
| Partner BU | Rules Criterias                                             |
| DBOBA10_2  | Advertiser=DBOBAR10_1,Product=DBOBPR10_1,Campaign=DBOBC10_1 |
And saved billing rules on Billing Rule Builder form
And logged in with details of 'DBOBU10_1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | DBOBAR10_1 | DBOBBR10_1 | DBOBSB10_1 | DBOBPR10_1 | DBOBC10_1 | DBOBCN10     | 20       | 10/14/2022     | HD 1080i 25fps | DBOBT10 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'DBOBCN10'
And click Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax   | Total  |
| SD Standard Normal (Digital) | 1   | 50.00  | 50.00        | 50.00    | 10.50 | 60.50 |
When I back to order item page from Order Proceed page
And fill following fields for Add information form on order item page:
| Campaign  |
| DBOBC10_2 |
And click Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
| SD Standard Normal (Digital) | 1   | 40.00   | 40.00        | 40.00    | 8.40   | 48.40 |


Scenario: Check that new custom field is available in Billing rule builder
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| DBOBA11_1 | DefaultA4User |
| DBOBA11_2 | DefaultA4User |
And added agency 'DBOBA11_2' as a partner for agency 'DBOBA11_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And I am on the global 'common custom' metadata page for agency 'DBOBA11_1'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String Custom' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And clicked 'String Custom' button in 'common metadata' section on opened metadata page
And checked 'Make it common for order,Make this field available for billing' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I go to agency 'DBOBA11_1' partners page
Then I 'should' see available following metadata fields 'String Custom' on Billing Rule Builder form

Scenario: Check that billing rules correctly definite agency which will bill in case several agencies
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | Country        | SAP ID       |
| DBOBA12_1 | DefaultA4User | United Kingdom | DefaultSapID |
| DBOBA12_2 | DefaultA4User | United Kingdom | BM0005       |
| DBOBA12_3 | DefaultA4User | United Kingdom | BM0005       |
And logged in with details of 'GlobalAdmin'
And added agency 'DBOBA12_2,DBOBA12_3' as a partner for agency 'DBOBA12_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| DBOBU12_1 | agency.admin | DBOBA12_1    |
| DBOBU12_2 | agency.admin | DBOBA12_2    |
| DBOBU12_3 | agency.admin | DBOBA12_3    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBOBA12_1':
| Advertiser | Brand      | Sub Brand  | Product    |
| DBOBAR12_1 | DBOBBR12_1 | DBOBSB12_1 | DBOBPR12_1 |
| DBOBAR12_2 | DBOBBR12_2 | DBOBSB12_2 | DBOBPR12_2 |
And updated metadatas 'Advertiser,Product,Campaign' in schema 'common' of agency 'DBOBA12_1' by following fields:
| Make it common for order | Make this field available for billing |
| should                   | should                                |
And I am on agency 'DBOBA12_1' partners page
And filled following fields for Billing Rule Builder form on agency partners page:
| Partner BU | Rules Criterias                                             |
| DBOBA12_2  | Advertiser=DBOBAR12_1,Product=DBOBPR12_1,Campaign=DBOBC12_1 |
| DBOBA12_3  | Advertiser=DBOBAR12_2,Product=DBOBPR12_2,Campaign=DBOBC12_2 |
And saved billing rules on Billing Rule Builder form
And logged in with details of 'DBOBU12_1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | DBOBAR12_1 | DBOBBR12_1 | DBOBSB12_1 | DBOBPR12_1 | DBOBC12_1 | DBOBCN12_1   | 20       | 10/14/2022     | HD 1080i 25fps | DBOBT12_1 | Already Supplied   | Aastha:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | DBOBAR12_2 | DBOBBR12_2 | DBOBSB12_2 | DBOBPR12_2 | DBOBC12_2 | DBOBCN12_2   | 15       | 10/14/2022     | HD 1080i 25fps | DBOBT12_2 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'DBOBCN12_1'
And click Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax   | Total  |
| SD Standard Normal (Digital) | 1   | 50.00  | 50.00        | 50.00    | 10.50 | 60.50 |
When I open order item with following clock number 'DBOBCN12_2'
And click Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax   | Total  |
| SD Standard Normal (Digital) | 1   | 50.00 | 50.00       | 50.00      | 10.50 | 60.50  |

Scenario: Billing Rules should not disappear after SAP is enabled for a BU
Meta: @ordering
Given I created the following agency:
| Name            |    A4User      | AgencyType  |
| A_BRDABU_S01_1  | DefaultA4User  |  Advertiser |
| A_BRDABU_S01_2  | DefaultA4User  |  Advertiser |
And I added following partners to agency 'A_BRDABU_S01_1' on partners page:
| Name           |
| A_BRDABU_S01_2 |
And I am on agency 'A_BRDABU_S01_1' overview page
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_BRDABU_S01_1':
| Advertiser | Brand      | Sub Brand  | Product    |
| DBOBAR12_1 | DBOBBR12_1 | DBOBSB12_1 | DBOBPR12_1 |
And updated metadatas 'Advertiser,Product' in schema 'common' of agency 'A_BRDABU_S01_1' by following fields:
| Make it common for order |Make this field available for billing |
| should                   |should                                |
And I updated partners 'A_BRDABU_S01_2' to allow billing from agency 'A_BRDABU_S01_1'
And filled following fields for Billing Rule Builder form on agency partners page:
| Partner BU      | Rules Criterias                          |
| A_BRDABU_S01_2  | Advertiser=DBOBAR12_1,Product=DBOBPR12_1 |
When I save billing rules on Billing Rule Builder form
Then I should see following data on Billing Rule Builder form:
| Partner BU      | Rules Criterias                          |
| A_BRDABU_S01_2  | Advertiser=DBOBAR12_1,Product=DBOBPR12_1 |
When I go to agency 'A_BRDABU_S01_1' overview page
And I update agency 'A_BRDABU_S01_1' with following fields on agency overview page:
| FieldName                  | FieldValue    |
| Enable Traffic Module | true       |
| SAP Enabled                | true          |
| SAP Country                | United Kingdom|
| SAP ID                     | BM0004        |
When I go to agency 'A_BRDABU_S01_1' partners page
Then I should see following data on Billing Rule Builder form:
| Partner BU      | Rules Criterias                          |
| A_BRDABU_S01_2  | Advertiser=DBOBAR12_1,Product=DBOBPR12_1 |

Scenario: Billing Rules should not disappear after SAP is disabled for a BU
Meta: @ordering
Given I created the following agency:
| Name           | A4User        | Country        | SAP ID   |
| A_BRDABU_S02_1 | DefaultA4User | United Kingdom | BM0004   |
And I created the following agency:
| Name            |    A4User      | AgencyType  |
| A_BRDABU_S02_2  | DefaultA4User  |  Advertiser |
And I added following partners to agency 'A_BRDABU_S02_1' on partners page:
| Name           |
| A_BRDABU_S02_2 |
And I am on agency 'A_BRDABU_S02_1' overview page
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_BRDABU_S02_1':
| Advertiser | Brand      | Sub Brand  | Product    |
| DBOBAR12_1 | DBOBBR12_1 | DBOBSB12_1 | DBOBPR12_1 |
And updated metadatas 'Advertiser,Product' in schema 'common' of agency 'A_BRDABU_S02_1' by following fields:
| Make it common for order |Make this field available for billing |
| should                   |should                                |
And I updated partners 'A_BRDABU_S02_2' to allow billing from agency 'A_BRDABU_S02_1'
And filled following fields for Billing Rule Builder form on agency partners page:
| Partner BU      | Rules Criterias                          |
| A_BRDABU_S02_2  | Advertiser=DBOBAR12_1,Product=DBOBPR12_1 |
When I save billing rules on Billing Rule Builder form
Then I should see following data on Billing Rule Builder form:
| Partner BU      | Rules Criterias                          |
| A_BRDABU_S02_2  | Advertiser=DBOBAR12_1,Product=DBOBPR12_1 |
When I go to agency 'A_BRDABU_S02_1' overview page
And I update agency 'A_BRDABU_S02_1' with following fields on agency overview page:
| FieldName                  | FieldValue    |
| SAP Enabled                | false         |
When I go to agency 'A_BRDABU_S02_1' partners page
Then I should see following data on Billing Rule Builder form:
| Partner BU      | Rules Criterias                          |
| A_BRDABU_S02_2  | Advertiser=DBOBAR12_1,Product=DBOBPR12_1 |