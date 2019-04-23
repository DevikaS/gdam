Feature: ACL
Narrative:
In order to
As a GlobalAdmin
I want to check PnG user roles

Scenario: Check that user with PnG role can view costs from all agencies
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name            | A4User        | Country        | Labels                                                                       | Application Access    |
| AACLPGBUCyclone | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG,Cyclone | adcost,folders,adkits |
And I created users with following fields and waited until replication to Cost Module:
| Email             | Role        | AgencyUnique    | Access                                    |
| AACLPGAgencyOwner | agency.user | AACLPGBUCyclone | dashboard,adkits,approvals,folders,adcost |
And I added existing user 'AACLPGAgencyOwner' to agency 'DefaultAgency' with role 'agency.user'
And I assigned user with following access in cost module:
| Email             | User Role    | Approval limit | Access Type | Condition       |
| AACLPGAgencyOwner | Agency Owner |                | Client      | AACLPGBUCyclone |
And I logged in with details of 'AACLPGAgencyOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| AACLPGProject | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | SMO          | Agency Payment Currency |
| AACLPGProject  | AACLPGCT1  | AACLPGDC1   | Christine Meyer (Leo Burnett) | 20000                | Digital Development | AACLPGATN1             | IMEA          | DefaultCampaign | BFO          | INDIA GROUP  | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| AACLPGProject  | true | OriginalEstimate              | Athletes  | Buyout                | AACLPGCT2  | AACLPGDC2   | Aaron Royer (Grey)  | AACLPGATN2             | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And I logged in with details of 'CostOwner'
And created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | AACLPGCT3  | AACLPGDC3   | Aaron Royer (Grey) | 50000                | AACLPGATN3             | North America | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
When I login with details of 'IPMuser'
And I am on cost overview page
Then I 'should' see 'AACLPGCT1,AACLPGCT2,AACLPGCT3' cost item on Adcost overview page
When I login with details of 'GovernanceManager'
And I am on cost overview page
Then I 'should' see 'AACLPGCT1,AACLPGCT2,AACLPGCT3' cost item on Adcost overview page
When I login with details of 'FinanceManager'
And I am on cost overview page
Then I 'should' see 'AACLPGCT1,AACLPGCT2,AACLPGCT3' cost item on Adcost overview page
When I login with details of 'InsuranceUser'
And I am on cost overview page
Then I 'should' see 'AACLPGCT1,AACLPGCT2,AACLPGCT3' cost item on Adcost overview page
When I login with details of 'PurchasingSupport'
And I am on cost overview page
Then I 'should' see 'AACLPGCT1,AACLPGCT2,AACLPGCT3' cost item on Adcost overview page


Scenario: Check that admin section visibility for IPMuser role
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1781
Given I logged in with details of 'IPMuser'
When I am on costs overview page
Then I 'should not' see admin section on toolbar
When I try to access admin section using direct URL
Then I 'should not' see admin page


Scenario: Check that GovernanceManager has access to admin section
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1775
Given I logged in with details of 'GovernanceManager'
When I am on costs overview page
Then I 'should' see admin section on toolbar
When I am on admin section of adcost
Then I 'should' see 'User Access,Dictionaries,Currency,Vendors,Budget Form' tabs under admin section
And I should see for agency 'DefaultAgency' following data:
| Labels       |
| CM_Prime_P&G |


Scenario: Check that GovernanceManager can only see PnG roles
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1775
Given I logged in with details of 'GovernanceManager'
When I am on costs overview page
And I am on admin section of adcost
Then I see below roles in user role drop down on user access page for 'GovernanceManager' user:
| User Roles                                                                                                                                  | Condition  |
| Integrated Production Manager;Brand Management Approver;Finance Manager;Region Support;Purchasing Support;Insurance User;Governance Manager | should     |
| Regional Agency User;Agency Owner;Central Adaptation Supplier;Agency Finance Manager;Agency Admin                                           | should not |


Scenario: Check that GovernanceManager can assign users roles
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1775, QA-1040
Given created users with following fields and waited until replication to Cost Module:
| Email              | Role        | Agency        | Access                                    |
| ACLUFinanceManager | agency.user | DefaultAgency | dashboard,adkits,approvals,folders,adcost |
| ACLUUBrandManager  | agency.user | DefaultAgency | dashboard,adkits,approvals,folders,adcost |
And I logged in with details of 'GovernanceManager'
When I am on costs overview page
And I am on admin section of adcost
Then I 'should' see below budget regions in budget regions drop down on user access page for 'ACLUFinanceManager' user and 'Finance Manager' user role:
| Budget Regions                                                  |
| AAK;Europe;Greater China;Japan;IMEA;Latin America;North America |
When I try to assign 'Finance Manager' role to the user 'ACLUFinanceManager' under admin section without passing mandatory fields
Then I 'should' see save button is disabled
When I assign 'Finance Manager' role to the user 'ACLUFinanceManager' for 'AAK' region under admin section
And I assign 'Brand Management Approver' role to the user 'ACLUUBrandManager' under admin section
Then I 'should' be able to see assigned 'Finance Manager' role and 'AAK' budget region to the user 'ACLUFinanceManager' under admin section
And I 'should' be able to see assigned 'Brand Management Approver' role to the user 'ACLUUBrandManager' under admin section
And I 'should not' be able to assign following 'Adstream Admin' role to the user 'ACLUUBrandManager' under admin section