Feature: Restrict Costs as per Projects
Narrative:
In order to
As a CostOwner
I want to check Cost visibility as per associated project


Scenario: Check that project without any cost should not appear on cost creation form, projects list page and advance project search
Meta:@adcost
!--QA-1114
Given I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPPProject1 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
When I delete project 'RCBOPPProject1' on A5 and search the project on cost overview page
Then I 'should' see '0' costs on Adcost overview page
When I create a new 'production' cost on AdCosts overview page
Then I 'should not' see following project Number 'RCBOPPProject1' on cost details page
When I select 'Projects' tab under costs toolbar
Then I 'should not' see project 'RCBOPPProject1' on project list page


Scenario: Check that deleted project with cost from A5 should appear in advance Project search on Cost Overview Page
Meta:@adcost
!--QA-1114
Given I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPPProject2 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on cost overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| RCBOPPProject2 | true | OriginalEstimate              | Athletes | Buyout                | RCBOPPCT2  | RCBOPPCD2   | Lily Ross (Publicis) | RCBOPPATN2             | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
When I delete project 'RCBOPPProject2' on A5 and search the project on cost overview page
Then I 'should' see '1' costs on Adcost overview page
When I create a new 'production' cost on AdCosts overview page
Then I 'should not' see following project Number 'RCBOPPProject2' on cost details page
When I am on cost overview page
And I select 'filters' section on cost overview page
Then I 'should' see following in filter section on costs overview page:
| Name    | Value   |
| Project | All     |
When I set search filters as:
| Project        |
| RCBOPPProject2 |
Then I 'should' see 'RCBOPPCT2' cost item on Adcost overview page

Scenario: Check that cost of deleted project from A5 should be able to complete whole journey of cost
Meta:@adcost
!--QA-1114
Given I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name            | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPPProject3 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on cost overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number  | New | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| RCBOPPProject3 | true | OriginalEstimate              | Athletes | Buyout                | RCBOPPCT3   | RCBOPPCD2   | Lily Ross (Publicis) | RCBOPPATN2             | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
When I delete 'RCBOPPProject3' project
And add UsageBuyout details for cost title 'RCBOPPCT3' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints   | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air   | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And add negotiated terms page for cost title 'RCBOPPCT3' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'RCBOPPCT3'
And I fill Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I upload following supporting documents to cost title 'RCBOPPCT3':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And add below approvers for cost title 'RCBOPPCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'RCBOPPCT3'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'RCBOPPCT3'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'RCBOPPCT3'
And cost with title 'RCBOPPCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCBOPPCT3'
And I 'Submit' the cost with title 'RCBOPPCT3'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'RCBOPPCT3'
And cost with title 'RCBOPPCT3' is 'Approve' on behalf of MyPurchases application
Then I 'should' see following data for 'RCBOPPCT3' cost item on Adcost overview page:
| Cost Stage   | Cost Status |
| Final Actual | Approved    |


Scenario: Check that project without any cost should not appear on cost creation form, projects list page and advance project search
Meta:@adcost
!--QA-1114,bug #ADC-2661(need to merge with first scenario once fix is available)
Given I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| RCBOPPProject4 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
When I delete 'RCBOPPProject4' project
And I am on cost overview page
When I select 'filters' section on cost overview page
Then I 'should not' see following in filter section on costs overview page:
| Name    | Value          |
| Project | RCBOPPProject4 |


Scenario: Check that brand sector is displayed correctly on cost detail page when brand is mapped with multiple sectors
Meta:@adcost
!--QA-1157
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name             | A4User        | Country        | Labels                                                               | Application Access    |
| RCBOPPPNGBU      | DefaultA4User | United Kingdom | nVerge,CM_Prime_P&G,costPG,FTP,Physical,QA,dubbing_services          | adcost,folders,adkits |
| RCBOPPBU         | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG | adcost,folders,adkits |
And created users with following fields and waited until replication to Cost Module:
| Email           | Role        | AgencyUnique | Access                                    |
| RCBOPPCostOwner | agency.user | RCBOPPBU     | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPPCostOwner' to agency 'RCBOPPPNGBU' with role 'agency.user'
And updated following 'common' custom metadata fields for agency 'RCBOPPPNGBU':
| FieldType          | Description | Parent | Deleted  | Validate |
| catalogueStructure | Brand       |        | true     | false    |
| catalogueStructure | Sub Brand   |        | true     | false    |
| catalogueStructure | Product     |        | true     | false    |
And created following 'common' custom metadata fields for agency 'RCBOPPPNGBU':
| FieldType          | Description | Parent      |
| CatalogueStructure | Sector      | Advertiser  |
| CatalogueStructure | Brand       | Sector      |
And updated agency 'RCBOPPPNGBU' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Sector | Mark as Brand      |
| Advertiser         | Sector         | Brand_CostModule   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RCBOPPPNGBU' with custom characters and 'with' session:
| Advertiser   | Sector       | Brand            |
| RCBOPPAdv    | RCBOPPSec1   | RCBOPPbrand;1ADC |
| RCBOPPAdv    | RCBOPPSec2   | RCBOPPbrand;1ADC |
| RCBOPPAdv    | RCBOPPSec3   | RCBOPPbrand;1ADC |
And created new custom code 'ProjectId' of schema 'project' agency 'RCBOPPPNGBU' by following fields:
| Name       | Free Text | Sequential Number | Enabled |
| ProjectId  | PGU       | 4                 | should  |
And assigned user with following access in cost module:
| Email           | User Role    | Approval limit | Access Type | Condition |
| RCBOPPCostOwner | Agency Admin |                | Client      | RCBOPPBU  |
And logged in with details of 'RCBOPPCostOwner'
And I created a project in agency 'RCBOPPPNGBU' with following fileds:
| Name           | Custom Code | Advertiser | Sector     | Brand       |
| RCBOPPProject5 | ProjectId   | RCBOPPAdv  | RCBOPPSec1 | RCBOPPbrand |
| RCBOPPProject6 | ProjectId   | RCBOPPAdv  | RCBOPPSec2 | RCBOPPbrand |
| RCBOPPProject7 | ProjectId   | RCBOPPAdv  | RCBOPPSec3 | RCBOPPbrand |
And I am on costs overview page
When I create a new 'production' cost on AdCosts overview page
When I fill following fields on cost details page:
| Project Number  |
| RCBOPPProject5  |
Then I 'should' see following fields popoulated on cost deatil page for any new cost:
| Project Name   | Brand       | Sector     | Project Number |
| RCBOPPProject5 | RCBOPPbrand | RCBOPPSec1 | RCBOPPProject5 |
When I fill following fields on cost details page:
| Project Number |
| RCBOPPProject6 |
Then I 'should' see following fields popoulated on cost deatil page for any new cost:
| Project Name   | Brand       | Sector     | Project Number   |
| RCBOPPProject6 | RCBOPPbrand | RCBOPPSec2 | RCBOPPProject6   |
When I fill following fields on cost details page:
| Project Number  |
| RCBOPPProject7  |
Then I 'should' see following fields popoulated on cost deatil page for any new cost:
| Project Name   | Brand       | Sector     | Project Number   |
| RCBOPPProject7 | RCBOPPbrand | RCBOPPSec3 | RCBOPPProject7   |


Scenario: Check correct cost displayed when brand mapped with muliple sectors is chosen from advance search brand filter on cost landing page
Meta:@adcost
!--QA-1157
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name             | A4User        | Country        | Labels                                                               | Application Access    |
| RCBOPPPNGBU1     | DefaultA4User | United Kingdom | nVerge,CM_Prime_P&G,costPG,FTP,Physical,QA,dubbing_services          | adcost,folders,adkits |
| RCBOPPBU1        | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG | adcost,folders,adkits |
And created users with following fields and waited until replication to Cost Module:
| Email            | Role        | AgencyUnique | Access                                    |
| RCBOPPCostOwner1 | agency.user | RCBOPPBU1    | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCBOPPCostOwner1' to agency 'RCBOPPPNGBU1' with role 'agency.user'
And updated following 'common' custom metadata fields for agency 'RCBOPPPNGBU1':
| FieldType          | Description | Parent | Deleted  | Validate |
| catalogueStructure | Brand       |        | true     | false    |
| catalogueStructure | Sub Brand   |        | true     | false    |
| catalogueStructure | Product     |        | true     | false    |
And created following 'common' custom metadata fields for agency 'RCBOPPPNGBU1':
| FieldType          | Description | Parent      |
| CatalogueStructure | Sector      | Advertiser  |
| CatalogueStructure | Brand       | Sector      |
And updated agency 'RCBOPPPNGBU1' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Sector | Mark as Brand      |
| Advertiser         | Sector         | Brand_CostModule   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RCBOPPPNGBU1' with custom characters and 'with' session:
| Advertiser   | Sector       | Brand            |
| RCBOPPAdv    | RCBOPPSec1   | RCBOPPbrand;1ADC |
| RCBOPPAdv    | RCBOPPSec2   | RCBOPPbrand;1ADC |
| RCBOPPAdv    | RCBOPPSec3   | RCBOPPbrand;1ADC |
And created new custom code 'ProjectId' of schema 'project' agency 'RCBOPPPNGBU1' by following fields:
| Name       | Free Text | Sequential Number | Enabled |
| ProjectId  | PGU       | 4                 | should  |
And assigned user with following access in cost module:
| Email            | User Role    | Approval limit | Access Type | Condition |
| RCBOPPCostOwner1 | Agency Admin |                | Client      | RCBOPPBU1 |
And logged in with details of 'RCBOPPCostOwner1'
And I created a project in agency 'RCBOPPPNGBU1' with following fileds:
| Name            | Custom Code | Advertiser | Sector     | Brand       |
| RCBOPPProject8  | ProjectId   | RCBOPPAdv  | RCBOPPSec1 | RCBOPPbrand |
| RCBOPPProject9  | ProjectId   | RCBOPPAdv  | RCBOPPSec2 | RCBOPPbrand |
| RCBOPPProject10 | ProjectId   | RCBOPPAdv  | RCBOPPSec3 | RCBOPPbrand |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| RCBOPPProject8 | RCBOPPCT4  | RCBOPPD4    | Aaron Royer (Grey)  | 20000                | Digital Development | RCBOPPATN4             | AAK            | DefaultCampaign | BFO          | USD - US Dollar         |
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| RCBOPPProject9 | RCBOPPCT5  | RCBOPPD5    | Aaron Royer (Grey)  | 20000                | Digital Development | RCBOPPATN5             | AAK            | DefaultCampaign | BFO          | USD - US Dollar         |
And created a new 'production' cost with following CostDetails:
| Project Number  | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| RCBOPPProject10 | RCBOPPCT6  | RCBOPPD6    | Aaron Royer (Grey)  | 20000                | Digital Development | RCBOPPATN6             | AAK            | DefaultCampaign | BFO          | USD - US Dollar         |
When I select 'filters' section on cost overview page
And I set search filters as:
| Brand                  |
| RCBOPPbrand;RCBOPPSec1 |
Then I 'should' see 'RCBOPPCT4' cost item on Adcost overview page
When I set search filters as:
| Brand                  |
| RCBOPPbrand;RCBOPPSec2 |
Then I 'should' see 'RCBOPPCT5' cost item on Adcost overview page
When I set search filters as:
| Brand                  |
| RCBOPPbrand;RCBOPPSec3 |
Then I 'should' see 'RCBOPPCT6' cost item on Adcost overview page

