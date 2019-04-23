Feature: Email notifications
Narrative:
In order to
As a CostOwner
I want to check email notifications in cost module for Cyclone cost


Lifecycle:
Before:
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        | Country        | Labels                                                                       | Application Access    |
| CENCABU | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG,Cyclone | adcost,folders,adkits |
And created users with following fields and waited until replication to Cost Module:
| Email               | Role        | AgencyUnique | Access                                    |
| CENCACostOwner      | agency.user | CENCABU      | dashboard,adkits,approvals,folders,adcost |
| CENCAFinanceManager | agency.user | CENCABU      | dashboard,adkits,approvals,folders,adcost |
And I created users with following fields and waited until replication to Cost Module:
| Email                       | Role        | Agency        | Access                                    |
| CENCAFinanceManagerAnother  | agency.user | DefaultAgency | dashboard,adkits,approvals,folders,adcost |
| CENCAFinanceManagerAnother1 | agency.user | DefaultAgency | dashboard,adkits,approvals,folders,adcost |
And I updated the following agency:
| Name          | Email Notification URL |
| DefaultAgency | application_url        |
| CENCABU       | application_url        |
And added existing user 'CENCACostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email                       | User Role       | Approval limit | Access Type | Condition | NotificationBudgetRegionId |
| CENCACostOwner              | Agency Admin    |                | Client      | CENCABU   |                            |
| CENCAFinanceManager         | Finance Manager |                | Client      | CENCABU   | North America              |
| CENCAFinanceManagerAnother  | Finance Manager |                | Client      | CENCABU   | AAK                        |
| CENCAFinanceManagerAnother1 | Finance Manager |                | Client      | CENCABU   | North America              |
And logged in with details of 'CENCACostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name           | Custom Code | Advertiser | Sector        | Brand        |
| CENCAProject_1 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |


Scenario: Check email notifications for Cyclone cost until Original Estimate stage is approved
Meta:@adcost
     @adcostEmails
     @adcostCycloneCosts
!--QA-743, ADC-789, ADC-801, ADC-2477, ADC-2476, ADC-2552, ADC-2520
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject_1 | CENCACT1   | CENCAD1     | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CENCAATN1              | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCACT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CENCACT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CENCAAT1    | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CENCACT1':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 3000          | 3000          |
And uploaded following supporting documents to cost title 'CENCACT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENCACT1':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CENCACT1'
Then I 'should' see cost email notification for 'Cost Submitted' with field to 'CENCACostOwner' and subject 'CENCACT1' contains following attributes:
| Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'IPMuser' and subject 'CENCACT1' contains following attributes:
| Cost Approver | Cost Approver Type | Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Technical          | Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCACT1' contains following attributes:
| Pending Approval | Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPM Approval     | Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver FM Added' with field to 'CENCAFinanceManager' and subject 'CENCACT1' contains following attributes:
| Cost Approver | Cost Approver Type | Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp | Pending Approval for FM |
| IPMuser       | Technical;Cyclone  | Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     | True                    |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CENCACT1'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner' and subject 'CENCACT1' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCACT1' contains following attributes:
| Pending Approval | Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Brand Approval   | Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'BrandManagementApprover' and subject 'CENCACT1' contains following attributes:
| Cost Approver           | Cost Approver Type | Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| BrandManagementApprover | Brand;Cyclone      | Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCACT1' contains following attributes:
| Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManager' and subject 'CENCACT1' contains following attributes:
| Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp | Pending Approval for FM |
| Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     | True                    |
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CENCACT1'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner' and subject 'CENCACT1' contains following attributes:
| Cost Approver           | Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| BrandManagementApprover | Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCACT1' contains following attributes:
| Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManager' and subject 'CENCACT1' contains following attributes:
| Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp | OEApprovedForFM |
| Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     | True            |
And I 'should' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManagerAnother1' and subject 'CENCACT1' contains following attributes:
| Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp | OEApprovedForFM |
| Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     | True            |
And I 'should not' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManagerAnother' and subject 'CENCACT1' contains following attributes:
| Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp | OEApprovedForFM |
| Original Estimate | CENCACT1   | CENCACT1 | Video        | Post Production Only | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN1         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     | True            |


Scenario: Check Cycolne cost email notifications at Current Revision and Final Actual stages
Meta:@adcost
     @adcostEmails
     @adcostCycloneCosts
!--QA-743, ADC-789, ADC-801, ADC-2477, ADC-2476, ADC-2520
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject_1 | true | OriginalEstimate              | Athletes  | Buyout                | CENCACT2   | CENCAD2     | Aaron Royer (Grey)  | CENCAATN2              | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CENCACT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CENCACT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And filled Cost Line Items with following fields for cost title 'CENCACT2':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 10000             | 10000                      |
And I uploaded following supporting documents to cost title 'CENCACT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CENCACT2':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CENCACT2'
Given I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'CENCACT2'
And I logged in with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CENCACT2'
When I login with details of 'CENCACostOwner'
And 'CreateRevision' the cost with title 'CENCACT2'
And I add cost item details for cost title 'CENCACT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'CENCACT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
When I 'Submit' the cost with title 'CENCACT2'
Then I 'should' see cost email notification for 'Cost Submitted' with field to 'CENCACostOwner' and subject 'CENCACT2' contains following attributes:
| Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Current Revision | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'IPMuser' and subject 'CENCACT2' contains following attributes:
| Cost Approver | Cost Approver Type | Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Technical          | Current Revision | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCACT2' contains following attributes:
| Pending Approval | Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPM Approval     | Current Revision | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CENCACT2'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner' and subject 'CENCACT2' contains following attributes:
| Cost Approver | Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Current Revision | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCACT2' contains following attributes:
| Pending Approval | Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Brand Approval   | Current Revision | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'BrandManagementApprover' and subject 'CENCACT2' contains following attributes:
| Cost Approver           | Cost Approver Type | Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| BrandManagementApprover | Brand;Cyclone      | Current Revision | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CENCACT2'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner' and subject 'CENCACT2' contains following attributes:
| Cost Approver           | Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| BrandManagementApprover | Current Revision | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCACT2' contains following attributes:
| Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Current Revision | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManager' and subject 'CENCACT2' contains following attributes:
| Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Current Revision | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'CENCACostOwner'
And 'NextStage' the cost with title 'CENCACT2'
And I add cost item details for cost title 'CENCACT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 25000             | 25000                      |
And I upload following supporting documents to cost title 'CENCACT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And 'Submit' the cost with title 'CENCACT2'
Then I 'should' see cost email notification for 'Cost Submitted' with field to 'CENCACostOwner' and subject 'CENCACT2' contains following attributes:
| Stage        | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Final Actual | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'IPMuser' and subject 'CENCACT2' contains following attributes:
| Cost Approver | Cost Approver Type | Stage        | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Technical          | Final Actual | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCACT2' contains following attributes:
| Pending Approval | Stage        | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPM Approval     | Final Actual | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CENCACT2'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner' and subject 'CENCACT2' contains following attributes:
| Cost Approver | Stage        | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Final Actual | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCACT2' contains following attributes:
| Pending Approval | Stage        | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Brand Approval   | Final Actual | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'BrandManagementApprover' and subject 'CENCACT2' contains following attributes:
| Cost Approver           | Cost Approver Type | Stage        | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| BrandManagementApprover | Brand;Cyclone      | Final Actual | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CENCACT2'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner' and subject 'CENCACT2' contains following attributes:
| Cost Approver           | Stage        | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| BrandManagementApprover | Final Actual | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCACT2' contains following attributes:
| Stage        | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Final Actual | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManager' and subject 'CENCACT2' contains following attributes:
| Stage        | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Final Actual | CENCACT2   | CENCACT2 | Athletes  | Buyout                     | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN2         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |



Scenario: Check that notifications triggered to old cost owner, new cost owner and IPM User and wathers when cost owner is changed after submitting the cyclone cost
Meta:@adcost
     @adcostEmails
!--QA-1075
Given I created users with following fields and waited until replication to Cost Module:
| Email            | Role        | AgencyUnique | Access                                    |
| CENCACostOwner1  | agency.user | CENCABU      | dashboard,adkits,approvals,folders,adcost |
| CENCAAgencyOwner | agency.user | CENCABU      | dashboard,adkits,approvals,folders,adcost |
And added existing user 'CENCACostOwner1' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email            | User Role    | Approval limit | Access Type | Condition |
| CENCACostOwner1  | Agency Owner |                | Client      | CENCABU   |
| CENCAAgencyOwner | Agency Owner |                | Client      | CENCABU   |
And I am on costs overview page
When I create a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject_1 | CENCACT3   | CENCACD3    | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CENCAATN3              | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And add production details for cost title 'CENCACT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'CENCACT3':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | CENCATAT3   | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And I fill Cost Line Items with following fields for cost title 'CENCACT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And upload following supporting documents to cost title 'CENCACT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'CENCACT3':
| Technical Approver | Brand Management Approver | Add Watcher       |
| IPMuser            | BrandManagementApprover   | CENCAAgencyOwner  |
And I 'Submit' the cost with title 'CENCACT3'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CENCACT3'
When I update the cost owner field in quick view for cost title 'CENCACT3' with new owner 'CENCACostOwner1'
Then I 'should' see cost email notification for 'Cost Owner Changed' with field to 'CENCACostOwner' and subject 'CENCACT3' contains following attributes:
| Old Cost Owner | Cost Owner      | Stage             | Cost Title | Cost Id   | Content Type | Production Type      | Status                       | Agency Producer    | Agency Owner    | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Brand        | Timestamp | Technical Approver |
| CENCACostOwner | CENCACostOwner1 | Original Estimate | CENCACT3   | CENCACT3  | Video        | Post Production Only | Pending Technical Approval   | Aaron Royer (Grey) | CENCACostOwner1 | CENCABU     | United Kingdom  | CENCAATN3         | CENCAProject_1 | CENCAProject_1 | North America | DefaultBrand | Today     | IPMuser            |
And I 'should' see cost email notification for 'Cost Owner Changed' with field to 'CENCACostOwner1' and subject 'CENCACT3' contains following attributes:
| Old Cost Owner | Cost Owner      | Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                       | Agency Producer    | Agency Owner    | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Brand        | Timestamp | Technical Approver |
| CENCACostOwner | CENCACostOwner1 | Original Estimate | CENCACT3   | CENCACT3 | Video        | Post Production Only | Pending Technical Approval   | Aaron Royer (Grey) | CENCACostOwner1 | CENCABU     | United Kingdom  | CENCAATN3         | CENCAProject_1 | CENCAProject_1 | North America | DefaultBrand | Today     | IPMuser            |
And I 'should' see cost email notification for 'Cost Owner Changed' with field to 'IPMuser' and subject 'CENCACT3' contains following attributes:
| Old Cost Owner | Cost Owner      | Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                       | Agency Producer    | Agency Owner    | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Brand        | Timestamp | Technical Approver |
| CENCACostOwner | CENCACostOwner1 | Original Estimate | CENCACT3   | CENCACT3 | Video        | Post Production Only | Pending Technical Approval   | Aaron Royer (Grey) | CENCACostOwner1 | CENCABU     | United Kingdom  | CENCAATN3         | CENCAProject_1 | CENCAProject_1 | North America | DefaultBrand | Today     | IPMuser            |
And I 'should' see cost email notification for 'Cost Owner Changed' with field to 'CENCAAgencyOwner' and subject 'CENCACT3' contains following attributes:
| Old Cost Owner | Cost Owner      | Stage             | Cost Title  | Cost Id  | Content Type | Production Type      | Status                      | Agency Producer    | Agency Owner    | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Brand        | Timestamp | Technical Approver |
| CENCACostOwner | CENCACostOwner1 | Original Estimate | CENCACT3   | CENCACT3 | Video        | Post Production Only | Pending Technical Approval   | Aaron Royer (Grey) | CENCACostOwner1 | CENCABU     | United Kingdom  | CENCAATN3         | CENCAProject_1 | CENCAProject_1 | North America | DefaultBrand | Today     | IPMuser            |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'CENCACT3'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner1' and subject 'CENCACT3' contains following attributes:
| Cost Approver | Stage             | Cost Title  | Cost Id  | Content Type  | Production Type      | Status                 | Agency Producer    | Agency Owner    | Agency Name  | Agency Location | Agency Tracking #  | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | CENCACT3    | CENCACT3 | Video         | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner1 | CENCABU      | United Kingdom  | CENCAATN3          | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
Then I 'should not' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner' and subject 'CENCACT3' contains following attributes:
| Cost Approver | Stage             | Cost Title  | Cost Id  | Content Type  | Production Type      | Status                 | Agency Producer    | Agency Owner    | Agency Name | Agency Location | Agency Tracking #  | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | CENCACT3    | CENCACT3 | Video         | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner1 | CENCABU     | United Kingdom  | CENCAATN3          | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |



Scenario: Check Cycolne cost email notifications triggered when cost is rejected at original estimation stage
Meta:@adcost
     @adcostEmails
     @adcostCycloneCosts
!--QA-743, ADC-789, ADC-801, ADC-2477, ADC-2476, ADC-2520,QA-1101
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject_1 | true | OriginalEstimate              | Athletes  | Buyout                | CENCACT4   | CENCAD2     | Aaron Royer (Grey)  | CENCAATN4              | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CENCACT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CENCACT4' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And filled Cost Line Items with following fields for cost title 'CENCACT4':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 10000             | 10000                      |
And I uploaded following supporting documents to cost title 'CENCACT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CENCACT4':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CENCACT4'
When I login with details of 'IPMuser'
And I 'Request Changes' the cost with comments 'auto test comment' and title 'CENCACT4'
Then I 'should' see cost email notification for 'Cost Request Changes' with field to 'CENCACostOwner' and subject 'CENCACT4' contains following attributes:
| Comments          | Cost Approver | Stage             | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| auto test comment | IPMuser       | Original Estimate | CENCACT4   | CENCACT4 | Athletes  | Buyout                     | Returned | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN4         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Request Changes for Insurance User' with field to 'InsuranceUser' and subject 'CENCACT4' contains following attributes:
| Comments          | Cost Approver | Stage             | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| auto test comment | IPMuser       | Original Estimate | CENCACT4   | CENCACT4 | Athletes  | Buyout                     | Returned | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN4         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Request Changes for Finance User' with field to 'CENCAFinanceManager' and subject 'CENCACT4' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | CENCACT4   | CENCACT4 | Athletes  | Buyout                     | Returned | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN4         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |



Scenario: Check Cycolne cost email notifications triggered when cost is recalled at original estimation stage
Meta:@adcost
     @adcostEmails
     @adcostCycloneCosts
!--QA-743, ADC-789, ADC-801, ADC-2477, ADC-2476, ADC-2520,QA-1101
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject_1 | true | OriginalEstimate              | Athletes  | Buyout                | CENCACT5   | CENCAD5     | Aaron Royer (Grey)  | CENCAATN5              | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CENCACT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CENCACT5' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And filled Cost Line Items with following fields for cost title 'CENCACT5':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 10000             | 10000                      |
And I uploaded following supporting documents to cost title 'CENCACT5':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CENCACT5':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CENCACT5'
And I 'Recall' the cost with title 'CENCACT5'
Then I 'should' see cost email notification for 'Cost Recalled for Cost Owners' with field to 'CENCACostOwner' and subject 'CENCACT5' contains following attributes:
| Cost Owner     | Stage             | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| CENCACostOwner | Original Estimate | CENCACT5   | CENCACT5 | Athletes  | Buyout                     | Recalled | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN5         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Recalled for Cost Owners' with field to 'CENCAFinanceManager' and subject 'CENCACT5' contains following attributes:
| Cost Owner     | Stage             | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| CENCACostOwner | Original Estimate | CENCACT5   | CENCACT5 | Athletes  | Buyout                     | Recalled | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN5         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |



Scenario: Check Cycolne cost email notifications triggered when cost is cancelled at original estimation stage
Meta:@adcost
     @adcostEmails
     @adcostCycloneCosts
!--QA-743, ADC-789, ADC-801, ADC-2477, ADC-2476, ADC-2520,QA-1101
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject_1 | true | OriginalEstimate              | Athletes  | Buyout                | CENCACT6   | CENCAD6     | Aaron Royer (Grey)  | CENCAATN6              | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CENCACT6' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CENCACT6' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And filled Cost Line Items with following fields for cost title 'CENCACT6':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 10000             | 10000                      |
And I uploaded following supporting documents to cost title 'CENCACT6':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CENCACT6':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CENCACT6'
Given I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'CENCACT6'
And I logged in with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CENCACT6'
When I login with details of 'CENCACostOwner'
When I 'Cancel' the cost with title 'CENCACT6'
Then I 'should' see cost email notification for 'Cost Cancelled' with field to 'CENCACostOwner' and subject 'CENCACT6' contains following attributes:
| Stage             | Cost Title | Cost Id   | Cost Type | Usage/Buyout/Contract Type | Status    | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCACT6   | CENCACT6  | Athletes  | Buyout                     | Cancelled | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN6         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Cancelled' with field to 'InsuranceUser' and subject 'CENCACT6' contains following attributes:
| Stage             | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status    | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCACT6   | CENCACT6 | Athletes  | Buyout                     | Cancelled | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN6         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Cancelled' with field to 'CENCAFinanceManager' and subject 'CENCACT6' contains following attributes:
|  Stage            | Cost Title | Cost Id  | Cost Type | Usage/Buyout/Contract Type | Status    | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCACT6   | CENCACT6 | Athletes  | Buyout                     | Cancelled | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN6         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |


Scenario: Check that cyclone cost email notifications triggered for FAReopenRequested and FAReopenApproved
Meta:@adcost
     @adcostEmails
!--QA-743, ADC-1248, ADC-1246, QA-1101
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| CENCAProject_1 | CENCACT7   | CENCACD7    | Christine Meyer (Leo Burnett) | 50000                | Digital Development | CENCAATN7              | North America          | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCACT7' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'CENCACT7':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENCAAT9     | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CENCACT7':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000      | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCACT7':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I am on cost approval page of cost title 'CENCACT7'
And added below approvers for cost title 'CENCACT7':
| Technical Approver | Brand Management Approver       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'CENCACT7'
And I logged in with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CENCACT7'
And I logged in with details of 'CENCACostOwner'
And I 'NextStage' the cost with title 'CENCACT7'
And filled Cost Line Items with following fields for cost title 'CENCACT7':
| Adaptation | Virtual Reality | P&G insurance |
| 40000      | 30000           | 20000         |
And I uploaded following supporting documents to cost title 'CENCACT7':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And added below approvers for cost title 'CENCACT7':
| Technical Approver | Brand Management Approver     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'CENCACT7'
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'CENCACT7'
And I logged in with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CENCACT7'
When I login with details of 'CENCACostOwner'
And I am on cost review page of cost item with title 'CENCACT7'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
Then I 'should' see cost email notification for 'Cost Reopen Request' with field to 'GovernanceManager' and subject 'CENCACT7' contains following attributes:
| Stage        | Cost Title | Cost Id   | Content Type        | Status         | Agency Producer               | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Final Actual | CENCACT7   | CENCACT7  | Digital Development | Pending Reopen | Christine Meyer (Leo Burnett) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN7         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Pending Reopen' with field to 'CENCAFinanceManager' and subject 'CENCACT7' contains following attributes:
| Stage        | Cost Title | Cost Id   | Content Type        | Status         | Agency Producer               | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Final Actual | CENCACT7   | CENCACT7  | Digital Development | Pending Reopen | Christine Meyer (Leo Burnett) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN7         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'CENCACT7'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
Then I 'should' see cost email notification for 'Cost Reopen Success' with field to 'CENCACostOwner' and subject 'CENCACT7' contains following attributes:
| P&G Admin         | Stage        | Cost Title | Cost Id  | Content Type        | Status | Agency Producer               | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| GovernanceManager | Final Actual | CENCACT7   | CENCACT7 | Digital Development | Draft  | Christine Meyer (Leo Burnett) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN7         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |


Scenario: Check email notifications for Cyclone cost until First Presentation stage is approved
Meta:@adcost
     @adcostEmails
     @adcostCycloneCosts
!--QA-743, ADC-789, ADC-801, ADC-2477, ADC-2476, ADC-2552, ADC-2520
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject_1 | CENCACT8   | CENCAD8     | Aaron Royer (Grey)  | 9000                 | Video        | Full Production  | CENCAATN8              | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCACT8' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CENCACT8':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CENCAAT8   | 10:10:10         | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CENCACT8':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 3000          | 3000          |
And uploaded following supporting documents to cost title 'CENCACT8' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'CENCACT8':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CENCACT8'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CENCACT8'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CENCACT8'
And I login with details of 'CENCACostOwner'
And I 'NextStage' the cost with title 'CENCACT8'
And 'Submit' the cost with title 'CENCACT8'
And fill Cost Line Items with following fields for cost title 'CENCACT8':
| Audio finalization | Offline edits | Agency travel |
| 9000               | 4000          | 6000          |
Then I 'should' see cost email notification for 'Cost Submitted' with field to 'CENCACostOwner' and subject 'CENCACT8' contains following attributes:
| Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'IPMuser' and subject 'CENCACT8' contains following attributes:
| Cost Approver | Cost Approver Type | Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Technical          | First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCACT8' contains following attributes:
| Pending Approval | Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPM Approval     | First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver FM Added' with field to 'CENCAFinanceManager' and subject 'CENCACT8' contains following attributes:
| Cost Approver | Cost Approver Type | Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status                     | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp | Pending Approval for FM |
| IPMuser       | Technical;Cyclone  | First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Pending Technical Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     | True                    |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CENCACT8'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner' and subject 'CENCACT8' contains following attributes:
| Cost Approver | Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCACT8' contains following attributes:
| Pending Approval | Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| Brand Approval   | First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'BrandManagementApprover' and subject 'CENCACT8' contains following attributes:
| Cost Approver           | Cost Approver Type | Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| BrandManagementApprover | Brand;Cyclone      | First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCACT8' contains following attributes:
| Stage             | Cost Title | Cost Id  | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManager' and subject 'CENCACT8' contains following attributes:
| Stage             | Cost Title | Cost Id  | Content Type | Production Type | Status                 | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp | Pending Approval for FM |
| First Presentation | CENCACT8  | CENCACT8 | Video        | Full Production | Pending Brand Approval | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     | True                    |
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CENCACT8'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENCACostOwner' and subject 'CENCACT8' contains following attributes:
| Cost Approver           | Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| BrandManagementApprover | First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCACT8' contains following attributes:
| Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManager' and subject 'CENCACT8' contains following attributes:
| Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManagerAnother1' and subject 'CENCACT8' contains following attributes:
| Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Approved' with field to 'CENCAFinanceManagerAnother' and subject 'CENCACT8' contains following attributes:
| Stage              | Cost Title | Cost Id  | Content Type | Production Type | Status   | Agency Producer    | Agency Owner   | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID     | Budget Region | Technical Approver | Brand        | Timestamp |
| First Presentation | CENCACT8   | CENCACT8 | Video        | Full Production | Approved | Aaron Royer (Grey) | CENCACostOwner | CENCABU     | United Kingdom  | CENCAATN8         | CENCAProject_1 | CENCAProject_1 | North America | IPMuser            | DefaultBrand | Today     |

