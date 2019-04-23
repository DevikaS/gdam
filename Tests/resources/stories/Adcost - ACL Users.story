Feature: Audio Content Type
Narrative:
In order to
As a GlobalAdmin
I want to check ACL Users functionality


Scenario: Check that AdstreamAdmin can access admin section
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1780
Given I logged in with details of 'DefaultGlobalAdmin'
When I try to access admin section using direct URL
Then I 'should' see 'User Access' tabs under admin section
And I 'should not' see 'Dictionaries,Currency,Vendors,Budget Form' tabs under admin section


Scenario: Check that user with AgencyAdmin role can access admin section and also tabs under admin section
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1780
Given I created users with following fields and waited until replication to Cost Module:
| Email            | Role        | Agency        | Access                                    |
| ACLUAgencyAdmin1 | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email            | User Role    | Approval limit | Access Type | Condition  |
| ACLUAgencyAdmin1 | Agency Admin |                | Client      | ACLUBU_1   |
And I logged in with details of 'ACLUAgencyAdmin1'
When I am on admin section of adcost
Then I 'should' see 'User Access' tabs under admin section
And I 'should not' see 'Dictionaries,Currency,Vendors,Budget Form' tabs under admin section
When I am on costs overview page
And I try to access admin section using direct URL
Then I 'should' see admin page


Scenario: Check that AgencyAdmin can only see Agency roles
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1775
Given I created users with following fields and waited until replication to Cost Module:
| Email            | Role        | Agency        | Access                                    |
| ACLUAgencyAdmin2 | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email            | User Role    | Approval limit | Access Type | Condition  |
| ACLUAgencyAdmin2 | Agency Admin |                | Client      | ACLUBU_1   |
And I logged in with details of 'ACLUAgencyAdmin2'
And I am on costs overview page
When I am on admin section of adcost
Then I see below roles in user role drop down on user access page for 'CostOwner' user:
| User Roles                                                                                                                                  | Condition  |
| Regional Agency User;Agency Owner;Central Adaptation Supplier;Agency Finance Manager;Agency Admin                                           | should     |
| Integrated Production Manager;Brand Management Approver;Finance Manager;Region Support;Purchasing Support;Insurance User;Governance Manager | should not |


Scenario: Check that user with AgencyAdmin role can assign only agency roles to users within the agency
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1776, ADC-1779
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name     | A4User        | Country        | Labels                                                               | Application Access    |
| ACLUBU_1 | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG | adcost,folders,adkits |
And I created users with following fields and waited until replication to Cost Module:
| Email            | Role        | Agency        | Access                                    |
| ACLUAgencyAdmin3 | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
| ACLUCostOwner    | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And I created users with following fields and waited until replication to Cost Module:
| Email            | Role        | AgencyUnique | Access                                    |
| ACLUAgencyAdmin4 | agency.user | ACLUBU_1     | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email            | User Role    | Approval limit | Access Type | Condition  |
| ACLUAgencyAdmin3 | Agency Admin |                | Client      | ACLUBU_1   |
| ACLUAgencyAdmin4 | Agency Admin |                | Client      | ACLUBU_1   |
And I logged in with details of 'ACLUAgencyAdmin3'
When I try to access admin section using direct URL
Then I 'should' see users 'AgencyOwner,CostOwner,CostConsultant' in admin section to assign roles
And I 'should not' see users 'IPMuser,FinanceManager,PurchasingSupport,InsuranceUser,BrandManagementApprover,GovernanceManager,ACLUAgencyAdmin4' in admin section to assign roles
When I assign 'Agency Owner' role to the user 'ACLUCostOwner' under admin section
Then I 'should' be able to see assigned 'Agency Owner' role to the user 'ACLUCostOwner' under admin section


Scenario: Check admin section visibility for AgencyFinanceManager role
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1781
Given I created users with following fields and waited until replication to Cost Module:
| Email                    | Role        | Agency        | Access                                    |
| ACLUAgencyFinanceManager | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email                    | User Role              | Approval limit | Access Type | Condition |
| ACLUAgencyFinanceManager | Agency Finance Manager |                | Client      | ACLUBU_1  |
And I logged in with details of 'ACLUAgencyFinanceManager'
When I am on costs overview page
Then I 'should not' see admin section on toolbar
When I try to access admin section using direct URL
Then I 'should not' see admin page


Scenario: Check admin section visibility for AgencyOwner role
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1781
Given I created users with following fields and waited until replication to Cost Module:
| Email           | Role        | Agency        | Access                                    |
| ACLUAgencyOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email           | User Role    | Approval limit | Access Type | Condition |
| ACLUAgencyOwner | Agency Owner |                | Client      | ACLUBU_1  |
And I logged in with details of 'ACLUAgencyOwner'
When I am on costs overview page
Then I 'should not' see admin section on toolbar
When I try to access admin section using direct URL
Then I 'should not' see admin page


Scenario: Check that admin section visibility for CentralAdaptationSupplier role
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1781
Given I created users with following fields and waited until replication to Cost Module:
| Email                         | Role        | Agency        | Access                                    |
| ACLUCentralAdaptationSupplier | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email                         | User Role                   | Approval limit | Access Type | Condition |
| ACLUCentralAdaptationSupplier | Central Adaptation Supplier |                | Client      | ACLUBU_1  |
And I logged in with details of 'ACLUCentralAdaptationSupplier'
When I am on costs overview page
Then I 'should not' see admin section on toolbar
When I try to access admin section using direct URL
Then I 'should not' see admin page


Scenario: Check that user cannot see cost module when access removed in A5
Meta:@adcost
     @adcostACL
!--QA-1072
Given I created users with following fields and waited until replication to Cost Module:
| Email     | Role        | Agency        | Access                                    |
| ACLUuser3 | agency.user | DefaultAgency | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email     | User Role    | Approval limit | Access Type | Condition |
| ACLUuser3 | Agency Owner |                | Client      | ACLUBU_1  |
And I logged in with details of 'AgencyAdmin'
And I set 'off' 'adcost' application checkbox on user 'ACLUuser3' details page
When I login with details of 'ACLUuser3'
Then I 'should not' see cost module in top header


Scenario: Check that reenabling user in A5 gets back cost module access
Meta:@adcost
     @adcostACL
!--QA-1072
Given I created users with following fields and waited until replication to Cost Module:
| Email     | Role        | Agency        | Access                                    |
| ACLUuser4 | agency.user | DefaultAgency | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email     | User Role    | Approval limit | Access Type | Condition |
| ACLUuser4 | Agency Owner |                | Client      | ACLUBU_1  |
And I logged in with details of 'AgencyAdmin'
And I am on user 'ACLUuser4' details page
When I 'check' 'Disable user' checkbox
And I click save on users details page
And I login with details of 'GovernanceManager'
And I am on costs overview page
And I am on admin section of adcost
And I search for user 'ACLUuser4' on adcost admin user access page
Then I 'should' see user with below details:
| Cost User | Flag       | Disabled | Not Editable |
| ACLUuser4 | [DISABLED] | true     | true         |
When I login with details of 'AgencyAdmin'
And I go to user 'ACLUuser4' details page
And I 'uncheck' 'Disable user' checkbox
And I click save on users details page
And I login with details of 'GovernanceManager'
And I am on costs overview page
And I am on admin section of adcost
And I search for user 'ACLUuser4' on adcost admin user access page
Then I 'should' see user with below details:
| Cost User | Disabled | Not Editable |
| ACLUuser4 | false    | false        |


Scenario: Check that reenabling costModule access in A5 user gets back access to cost module
Meta:@adcost
     @adcostACL
!--QA-1072
Given I created users with following fields and waited until replication to Cost Module:
| Email     | Role        | Agency        | Access                                    |
| ACLUuser5 | agency.user | DefaultAgency | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email     | User Role    | Approval limit | Access Type | Condition |
| ACLUuser5 | Agency Owner |                | Client      | ACLUBU_1  |
And I logged in with details of 'AgencyAdmin'
And I set 'off' 'adcost' application checkbox on user 'ACLUuser5' details page
When I login with details of 'GovernanceManager'
And I am on costs overview page
And I am on admin section of adcost
And I search for user 'ACLUuser5' on adcost admin user access page
Then I 'should' see user with below details:
| Cost User | Flag       | Disabled | Not Editable |
| ACLUuser5 | [DISABLED] | true     | true         |
When I login with details of 'AgencyAdmin'
And I set 'on' 'adcost' application checkbox on user 'ACLUuser5' details page
And I login with details of 'GovernanceManager'
And I am on costs overview page
And I am on admin section of adcost
And I search for user 'ACLUuser5' on adcost admin user access page
Then I 'should' see user with below details:
| Cost User | Disabled | Not Editable |
| ACLUuser5 | false    | false        |
When I login with details of 'ACLUuser5'
Then I 'should' see cost module in top header
When I am on cost overview page
Then I 'should' land on cost overview page