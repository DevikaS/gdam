Feature: Restrict Costs as per Projects
Narrative:
In order to
As a CostOwner
I want to check Cost visibility as per associated project

Scenario: Check that costs restricted to created project when user navigates to Costs via the link on the Project submenu
Meta:@adcost
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-802
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject1 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject2 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| RCBOPProject1  | RCBOPCT1   | RCBOPCD1    | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | RCBOPATN1              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject2  | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT2   | RCBOPCD2    | Lily Ross (Publicis) | RCBOPATN2              | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject2  | RCBOPCT3   | RCBOPCD3    | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | RCBOPATN3              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject1  | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT4   | RCBOPCD4    | Lily Ross (Publicis) | RCBOPATN4              | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And refreshed the page without delay
When I go to project 'RCBOPProject1' overview page
And I select 'Costs' tab on project overview page
Then I 'should' see 'RCBOPCT4,RCBOPCT1' cost item on Adcost overview page
And I 'should not' see 'RCBOPCT3,RCBOPCT2' cost item on Adcost overview page
When I go to project 'RCBOPProject2' overview page
And I select 'Costs' tab on project overview page
Then I 'should' see 'RCBOPCT3,RCBOPCT2' cost item on Adcost overview page
And I 'should not' see 'RCBOPCT4,RCBOPCT1' cost item on Adcost overview page
When I select costs tab in 'top navbar' on costs overview page
Then I 'should' see 'RCBOPCT4,RCBOPCT3,RCBOPCT2,RCBOPCT1' cost item on Adcost overview page


Scenario: Check project name on costs overview page
Meta:@adcost
!--QA-802
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject3 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject4 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| RCBOPProject3  | RCBOPCT5   | RCBOPCD5    | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | RCBOPATN5              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject4  | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT6   | RCBOPCD6    | Lily Ross (Publicis) | RCBOPATN6              | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
When I go to project 'RCBOPProject3' overview page
And I select 'Costs' tab on project overview page
Then I 'should' see project name as 'RCBOPProject3' on costs overview page
When I go to project 'RCBOPProject4' overview page
And I select 'Costs' tab on project overview page
Then I 'should' see project name as 'RCBOPProject4' on costs overview page


Scenario: Check that project number is auto selected in Cost Details section
Meta:@adcost
!--QA-802
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject5 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
When I go to project 'RCBOPProject5' overview page
And I select 'Costs' tab on project overview page
And create a new 'production' cost on AdCosts overview page
And fill Cost Details with following fields for 'production' cost with page refresh:
| Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region  | Campaign        | Organisation |
| RCBOPCT6_1 | RCBOPCD6_1  | Aaron Royer (Grey)  | 9000                 | Video        | Full Production | RCBOPATN6_1            | AAK            | DefaultCampaign | BFO          |
And add production details for cost title 'RCBOPCT6_1' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I am on cost overview page
Then I 'should' see following data for 'RCBOPCT6_1' cost item on Adcost overview page:
| AdCost#    |
| RCBOPCT6_1 |

Scenario: Check project field in filter section on cost overview page
Meta:@adcost
!--QA-802
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name            | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject1_1 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on project 'RCBOPProject1_1' overview page
And I selected 'Costs' tab on project overview page
When I select 'filters' section on cost overview page
Then I 'should' see following in filter section on costs overview page:
| Name    | Value           | Status   |
| Project | RCBOPProject1_1 | Disabled |
When I select costs tab in 'top navbar' on costs overview page
Then I 'should' see following in filter section on costs overview page:
| Name    | Value | Status  |
| Project | All   | Enabled |


Scenario: Check that project number still shows in filter section even without creating any costs
Meta:@adcost
!--QA-802
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject6 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
When I go to project 'RCBOPProject6' overview page
And I select 'Costs' tab on project overview page
Then I 'should' see '0' costs on Adcost overview page
When I am on cost overview page
When search cost with project Id of 'RCBOPProject6' on cost overview page
Then I 'should' see '0' costs on Adcost overview page
When I select 'filters' section on cost overview page
Then I 'should' see following in filter section on costs overview page:
| Name    | Value         | Status   |
| Project | RCBOPProject6 | Disabled |


Scenario: Check that project search filter shows costs based on project name
Meta:@adcost
!--QA-802
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
Given I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject7 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject8 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| RCBOPProject8  | RCBOPCT7   | RCBOPCD7    | Aaron Royer (Grey)  | 60000                | Audio        | Full Production | RCBOPATN7              | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject7  | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT8   | RCBOPCD8    | Lily Ross (Publicis) | RCBOPATN8              | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject8  | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT9   | RCBOPCD9    | Lily Ross (Publicis) | RCBOPATN9              | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on costs overview page
When I select 'filters' section on cost overview page
And I set search filters as:
| Project       |
| RCBOPProject8 |
And I create a new filter by name 'RCBOPFilter1'
Then I 'should' see a filter tab created by name 'RCBOPFilter1' on costs overview page
And I 'should' see costs count as '2' next to 'RCBOPFilter1' filter name on costs overview page
And I 'should' see 'RCBOPCT7,RCBOPCT9' cost item on Adcost overview page
And I 'should not' see 'RCBOPCT8' cost item on Adcost overview page
When I refresh the page without delay
And select costs tab in 'top navbar' on costs overview page
Then I 'should' see 'RCBOPCT7,RCBOPCT8,RCBOPCT9' cost item on Adcost overview page


Scenario: Check that project search filter shows project name for saved filters
Meta:@adcost
!--QA-802
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
Given I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject9 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject10 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| RCBOPProject9  | RCBOPCT10  | RCBOPCD10   | Aaron Royer (Grey)  | 60000                | Audio        | Full Production | RCBOPATN10             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject10 | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT11  | RCBOPCD11   | Lily Ross (Publicis) | RCBOPATN11             | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject9  | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT12  | RCBOPCD12   | Lily Ross (Publicis) | RCBOPATN12             | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on costs overview page
And I selected 'filters' section on cost overview page
And I filled search filters as:
| Project       |
| RCBOPProject9 |
And I created a new filter by name 'RCBOPFilter2'
When I go to project 'RCBOPProject9' overview page
And I select 'Costs' tab on project overview page
And I select 'filters' section on cost overview page
Then I 'should' see following in filter section on costs overview page:
| Name    | Value         | Status   |
| Project | RCBOPProject9 | Disabled |
And I 'should' see that 'RCBOPFilter2' filter tab is 'selected' on costs overview page
And I 'should' see 'RCBOPCT10,RCBOPCT12' cost item on Adcost overview page
And I 'should not' see 'RCBOPCT11' cost item on Adcost overview page
When I select costs tab in 'top navbar' on costs overview page
Then I 'should' see following in filter section on costs overview page:
| Name    | Value | Status   |
| Project | All   | Enabled |
Then I 'should' see 'RCBOPCT10,RCBOPCT11,RCBOPCT12' cost item on Adcost overview page


Scenario: Check Costs can be searched by project Id on Cost overview page
Meta:@adcost
!--QA-802
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject11 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject12 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign         | Organisation | Agency Payment Currency |
| RCBOPProject12 | RCBOPCT13  | RCBOPCD13   | Aaron Royer (Grey)  | 60000                | Audio        | Full Production | RCBOPATN13              | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject11 | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT14  | RCBOPCD14   | Lily Ross (Publicis) | RCBOPATN14             | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| RCBOPProject12 | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT15  | RCBOPCD15   | Lily Ross (Publicis) | RCBOPATN15             | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on costs overview page
When I search cost with project Id of 'RCBOPProject12' on cost overview page
Then I 'should' see 'RCBOPCT13,RCBOPCT15' cost item on Adcost overview page
When I search cost with project Id of 'RCBOPProject11' on cost overview page
Then I 'should' see 'RCBOPCT14' cost item on Adcost overview page


Scenario: Check DownloadProjectTotals button visibility when navigated from Projects tab
Meta:@adcost
     @downloadProjectTotals
!--QA-1054
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject13 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on project 'RCBOPProject13' overview page
When I select 'Costs' tab on project overview page
Then I 'should' see download project totals button on cost overview page


Scenario: Check DownloadProjectTotals button visibility for project filter
Meta:@adcost
     @downloadProjectTotals
!--QA-1054
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCBOPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject14 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
Given I am on costs overview page
Then I 'should not' see download project totals button on cost overview page
When I select 'filters' section on cost overview page
And I set search filters as:
| Project        |
| RCBOPProject14 |
Then I 'should' see download project totals button on cost overview page


Scenario: Check that project details can be downloaded via DownloadProjectTotals API call
Meta:@adcost
     @downloadProjectTotals
!--QA-1054
Given I created users with following fields and waited until replication to Cost Module:
| Email           | Role        | Agency        | Access                                    |
| RCBOPCostOwner1 | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPCostOwner1' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email           | User Role    | Approval limit | Access Type | Condition   |
| RCBOPCostOwner1 | Agency Admin |                | Client      | CCPCASICTBU |
And I logged in with details of 'RCBOPCostOwner1'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPProject15 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
When I create a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| RCBOPProject15 | true | OriginalEstimate              | Athletes | Buyout                | RCBOPCT16  | RCBOPCD16   | Lily Ross (Publicis) | RCBOPATN16             | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And fill Cost Line Items with following fields for cost title 'RCBOPCT16':
| Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 40000                      | 1234567890                        |
And upload following supporting documents to cost title 'RCBOPCT16':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
Then I 'should' be able to download project totals for 'RCBOPProject15' project of cost title 'RCBOPCT16':
| Project Creator | Project Creator Agecny | Sector        | Brand        | User Business Unit | Default currency | Project total USD | Cost Owner      | Title     | Content Type      | Budget Region | Status | Stage Name        |
| RCBOPCostOwner1 | another qa agency      | DefaultSector | DefaultBrand | another qa agency  | USD              | $40,000.000       | RCBOPCostOwner1 | RCBOPCT16 | Buyout - Athletes | AAK           | Draft  | Original Estimate |