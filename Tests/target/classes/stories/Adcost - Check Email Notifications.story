Feature: Email notifications
Narrative:
In order to
As a CostOwner
I want to check email notifications in cost module


Scenario: Check costSubmitted and approverAdded email notifications for Usage type at Original Estimate stage
Meta:@adcost
     @adcostEmails
     @adcostSmokeUAT
!--QA-743, ADC-797, ADC-796, ADC-2477
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | CENCT1     | CENCD1      | Aaron Royer (Grey)  | CENATN1                | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CENCT1' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 90000          |
And added negotiated terms page for cost title 'CENCT1' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CENCT1'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'CENCT1':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CENCT1':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When 'Submit' the cost with title 'CENCT1'
Then I 'should' see cost email notification for 'Cost Submitted' with field to 'CostOwner' and subject 'CENCT1' contains following attributes:
| Stage             | Cost Title | Cost Id | Cost Type | Usage/Buyout/Contract Type      | Status                     | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCT1     | CENCT1  | Celebrity | Contract (celebrity & athletes) | Pending Technical Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN1           | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'IPMuser' and subject 'CENCT1' contains following attributes:
| Cost Approver | Cost Approver Type | Stage             | Cost Title | Cost Id | Cost Type | Usage/Buyout/Contract Type      | Status                     | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Technical          | Original Estimate | CENCT1     | CENCT1  | Celebrity | Contract (celebrity & athletes) | Pending Technical Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN1           | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Approved' with field to 'FinanceManager' and subject 'CENCT1' contains following attributes:
| Stage             | Cost Title | Cost Id | Cost Type | Usage/Buyout/Contract Type      | Status                     | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCT1     | CENCT1  | Celebrity | Contract (celebrity & athletes) | Pending Technical Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN1           | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCT1' contains following attributes:
| Stage             | Cost Title | Cost Id | Cost Type | Usage/Buyout/Contract Type      | Status                     | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCT1     | CENCT1  | Celebrity | Contract (celebrity & athletes) | Pending Technical Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN1           | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |


Scenario: Check costSubmitted and approverAdded email notifications for Production type at Original Estimate stage
Meta:@adcost
     @adcostEmails
     @adcostSmoke
!--QA-743, ADC-797, ADC-796, QA-1082
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CENCT2     | CEND2       | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  CENATN2                | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCT2' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CENCT2':
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT5 | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'CENCT2':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000        N    | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENCT2':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When I 'Submit' the cost with title 'CENCT2'
Then I 'should' see cost email notification for 'Cost Submitted' with field to 'CostOwner' and subject 'CENCT2' contains following attributes:
| EmailFrom            | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| adcosts@adstream.com | Original Estimate | CENCT2     | CENCT2  | Still Image  | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN2           | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Approver Added' with field to 'IPMuser' and subject 'CENCT2' contains following attributes:
| EmailFrom            | Cost Approver | Cost Approver Type | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| adcosts@adstream.com | IPMuser       | Technical          | Original Estimate | CENCT2     | CENCT2  | Still Image  | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN2           | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |


Scenario: Check costSubmitted and approverAdded email notifications for Trafficking type at original Estimate stage
Meta:@adcost
     @adcostEmails
!--QA-743, ADC-797, ADC-796
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | CENCT3     | CENCD3      | Aaron Royer (Grey)  | 30000                | CENATN3                | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'CENCT3':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 20000                          |  1234567890                       |
And added below approvers for cost title 'CENCT3':
| Coupa Requisitioner     |
| BrandManagementApprover |
When 'Submit' the cost with title 'CENCT3'
Then I 'should' see cost email notification for 'Cost Submitted' with field to 'CostOwner' and subject 'CENCT3' contains following attributes:
| Stage             | Cost Title | Cost Id | Status                 | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Brand        | Timestamp |
| Original Estimate | CENCT3     | CENCT3  | Pending Brand Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN3           | DefaultCostProject | DefaultCostProject | AAK           | DefaultBrand | Today     |


Scenario: Check emails generated after technical and coupa approvals
Meta:@adcost
     @adcostEmails
!--QA-743, ADC-787, ADC-802
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CENCT4     | CEND4       | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  CENATN4                | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCT4' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CENCT4':
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT5 | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'CENCT4':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCT4':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CENCT4'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CENCT4'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CostOwner' and subject 'CENCT4' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | CENCT4     | CENCT4  | Still Image  | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN4           | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
When cost with title 'CENCT4' is 'Approve' on behalf of MyPurchases application
Then I 'should' see cost email notification for 'Cost Approved In Coupa' with field to 'CostOwner' and subject 'CENCT4' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IoNumberOwner | Original Estimate | CENCT4     | CENCT4  | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN4           | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |


Scenario: Check emails notifications are triggered when cost owner recalls
Meta:@adcost
     @adcostEmails
!--QA-743, ADC-785, ADC-784
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CENCT5     | CEND5       | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  CENATN5                | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCT5' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CENCT5':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT5      | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'CENCT5':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCT5':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENCT5':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'CENCT5'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CENCT5'
When I 'Recall' the cost with title 'CENCT5'
Then I 'should' see cost email notification for 'Cost Recalled for Cost Owners' with field to 'CostOwner' and subject 'CENCT5' contains following attributes:
| Cost Owner | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| CostOwner  | Original Estimate | CENCT5     | CENCT5  | Still Image  | Post Production Only | Recalled | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN5           | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Recalled for Cost Approvers' with field to 'IPMuser' and subject 'CENCT5' contains following attributes:
| Cost Owner | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| CostOwner  | Original Estimate | CENCT5     | CENCT5  | Still Image  | Post Production Only | Recalled | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN5           | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Recalled for Cost Approvers' with field to 'BrandManagementApprover' and subject 'CENCT5' contains following attributes:
| Cost Owner | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| CostOwner  | Original Estimate | CENCT5     | CENCT5  | Still Image  | Post Production Only | Recalled | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN5           | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |


Scenario: Check InsuranceUser receives email notifications when Technical Approver Request Changes for Western Europe Agency
Meta:@adcost
     @adcostEmails
!--QA-743, ADC-782, ADC-783
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name   | A4User        | Country        | Labels                                                               | Application Access    |
| CENBU3 | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG | adcost,folders,adkits |
And I updated the following agency:
| Name          | Email Notification URL |
| DefaultAgency | application_url        |
| CENBU3        | http://www.google.com  |
And created users with following fields and waited until replication to Cost Module:
| Email         | Role        | AgencyUnique | Access                                    |
| CENCostOwner3 | agency.user | CENBU3       | dashboard,adkits,approvals,folders,adcost |
And added existing user 'CENCostOwner3' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email         | User Role    | Approval limit | Access Type | Condition |
| CENCostOwner3 | Agency Admin |                | Client      | CENBU3     |
And logged in with details of 'CENCostOwner3'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| CENCAProject3 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject3  | CENAT6     | CEND6       | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  CENATN6                | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CENAT6' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CENAT6':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT6      | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'CENAT6':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'CENAT6':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENAT6':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When I 'Submit' the cost with title 'CENAT6'
Then I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENAT6' contains following attributes:
| Pending Approval | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner  | Agency Name | Agency Location | Agency Tracking # | Project Name  | Project ID    | Budget Region | Technical Approver | Brand        | Timestamp |
| IPM Approval     | Original Estimate | CENAT6     | CENAT6  | Still Image  | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENCostOwner3 | CENBU3      | United Kingdom  | CENATN6           | CENCAProject3 | CENCAProject3 | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'IPMuser'
And I 'Request Changes' the cost with comments 'auto test comment' and title 'CENAT6'
Then I 'should' see cost email notification for 'Cost Request Changes' with field to 'CENCostOwner3' and subject 'CENAT6' contains following attributes:
| Cost URL              | Comments          | Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner  | Agency Name | Agency Location | Agency Tracking # | Project Name  | Project ID    | Budget Region | Technical Approver | Brand        | Timestamp |
| http://www.google.com | auto test comment | IPMuser       | Original Estimate | CENAT6     | CENAT6  | Still Image  | Post Production Only | Returned | Aaron Royer (Grey) | CENCostOwner3 | CENBU3      | United Kingdom  | CENATN6           | CENCAProject3 | CENCAProject3 | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Request Changes for Insurance User' with field to 'InsuranceUser' and subject 'CENAT6' contains following attributes:
| Comments          | Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner  | Agency Name | Agency Location | Agency Tracking # | Project Name   | Project ID    | Budget Region | Technical Approver | Brand        | Timestamp |
| auto test comment | IPMuser       | Original Estimate | CENAT6     | CENAT6  | Still Image  | Post Production Only | Returned | Aaron Royer (Grey) | CENCostOwner3 | CENBU3      | United Kingdom  | CENATN6           | CENCAProject3 | CENCAProject3 | North America | IPMuser            | DefaultBrand | Today     |


Scenario: Check email notification is triggered when cost rejected in Coupa
Meta:@adcost
     @adcostEmails
!--QA-743, QA-1038, ADC-1343
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CENCT7     | CEND7       | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  CENATN7                | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCT7' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CENCT7':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT7      | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'CENCT7':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCT7' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'CENCT7':
| Technical Approver | Coupa Requisitioner     | Add Watcher |
| IPMuser            | BrandManagementApprover | AgencyOwner |
And I 'Submit' the cost with title 'CENCT7'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'CENCT7'
When cost with title 'CENCT7' is 'Reject' on behalf of MyPurchases application
Then I 'should' see cost email notification for 'Cost Request Changes' with field to 'CostOwner' and subject 'CENCT7' contains following attributes:
| Comments         | Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| MockedAMQComment | Coupa         | Original Estimate | CENCT7     | CENCT7  | Still Image  | Post Production Only | Returned | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN7           | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
Then I 'should' see cost email notification for 'Cost Request Changes' with field to 'AgencyOwner' and subject 'CENCT7' contains following attributes:
| Comments         | Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| MockedAMQComment | Coupa         | Original Estimate | CENCT7     | CENCT7  | Still Image  | Post Production Only | Returned | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | CENATN7           | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |


Scenario: Check InsuranceUser and watchers receives email notifications for cost cancelled in coupa for nonCycole and NorthAmerica Agency
Meta:@adcost
     @adcostEmails
!--QA-743, QA-1038, ADC-2476, ADC-803, ADC-804
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name   | A4User        | Country       | Labels                                                               | Application Access    |
| CENBU1 | DefaultA4User | United States | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG | adcost,folders,adkits |
And I updated the following agency:
| Name          | Email Notification URL |
| DefaultAgency | application_url        |
| CENBU1        | http://www.google.com  |
And created users with following fields and waited until replication to Cost Module:
| Email         | Role        | AgencyUnique | Access                                    |
| CENCostOwner1 | agency.user | CENBU1       | dashboard,adkits,approvals,folders,adcost |
| CENWatcher1   | agency.user | CENBU1       | dashboard,adkits,approvals,folders,adcost |
And added existing user 'CENCostOwner1' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email         | User Role    | Approval limit | Access Type | Condition |
| CENCostOwner1 | Agency Admin |                | Client      | CENBU1    |
| CENWatcher1   | Agency Admin |                | Client      | CENBU1    |
And logged in with details of 'CENCostOwner1'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| CENCAProject1 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject1  | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | CAACT8     | CAACD8      | Aaron Royer (Grey)  | CAAATN8                | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CAACT8' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 9000           |
And I filled Cost Line Items with following fields for cost title 'CAACT8':
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'CAACT8' and click continue:
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And filled below approvers for cost title 'CAACT8':
| Technical Approver | Coupa Requisitioner     | Add Watcher |
| IPMuser            | BrandManagementApprover | CENWatcher1 |
And I 'Submit' the cost with title 'CAACT8'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'CAACT8'
And cost with title 'CAACT8' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CENCostOwner1'
When I 'Cancel' the cost with title 'CAACT8'
When cost with title 'CAACT8' is 'Cancel' on behalf of MyPurchases application
Then I 'should' see cost email notification for 'Cost Cancelled' with field to 'CENCostOwner1' and subject 'CAACT8' contains following attributes:
| Cost URL              | Stage             | Cost Title | Cost Id | Cost Type | Usage/Buyout/Contract Type      | Status    | Agency Producer    | Agency Owner  | Agency Name | Agency Location | Agency Tracking # | Project Name  | Project ID    | Budget Region | Technical Approver | Brand        | Timestamp |
| http://www.google.com | Original Estimate | CAACT8     | CAACT8  | Film      | Contract (celebrity & athletes) | Cancelled | Aaron Royer (Grey) | CENCostOwner1 | CENBU1      | United States   | CAAATN8           | CENCAProject1 | CENCAProject1 | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Cancelled' with field to 'InsuranceUser' and subject 'CAACT8' contains following attributes:
| Stage             | Cost Title | Cost Id | Cost Type | Usage/Buyout/Contract Type      | Status    | Agency Producer    | Agency Owner  | Agency Name | Agency Location | Agency Tracking # | Project Name  | Project ID    | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CAACT8     | CAACT8  | Film      | Contract (celebrity & athletes) | Cancelled | Aaron Royer (Grey) | CENCostOwner1 | CENBU1      | United States   | CAAATN8           | CENCAProject1 | CENCAProject1 | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Cancelled' with field to 'CENWatcher1' and subject 'CAACT8' contains following attributes:
| Cost URL              |  Stage            | Cost Title | Cost Id | Cost Type | Usage/Buyout/Contract Type      | Status    | Agency Producer    | Agency Owner  | Agency Name | Agency Location | Agency Tracking # | Project Name  | Project ID    | Budget Region | Technical Approver | Brand        | Timestamp |
| http://www.google.com | Original Estimate | CAACT8     | CAACT8  | Film      | Contract (celebrity & athletes) | Cancelled | Aaron Royer (Grey) | CENCostOwner1 | CENBU1      | United States   | CAAATN8           | CENCAProject1 | CENCAProject1 | IMEA          | IPMuser            | DefaultBrand | Today     |


Scenario: Check that notifications triggered for FAReopenRequested and FAReopenApproved
Meta:@adcost
     @adcostEmails
!--QA-743, ADC-1248, ADC-1246, #14, #15
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | CENCT9     | CENCD9      | Christine Meyer (Leo Burnett) | 50000                | Digital Development | CENATN9                | IMEA          | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCT9' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'CENCT9':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT9     | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CENCT9':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000      | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCT9':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I am on cost approval page of cost title 'CENCT9'
And added below approvers for cost title 'CENCT9':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'CENCT9'
And cost with title 'CENCT9' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'CENCT9'
And filled Cost Line Items with following fields for cost title 'CENCT9':
| Adaptation | Virtual Reality | P&G insurance |
| 40000      | 30000           | 20000         |
And I uploaded following supporting documents to cost title 'CENCT9':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And added below approvers for cost title 'CENCT9':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'CENCT9'
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'CENCT9'
And cost with title 'CENCT9' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CENCT9'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
Then I 'should' see cost email notification for 'Cost Reopen Request' with field to 'GovernanceManager' and subject 'CENCT9' contains following attributes:
| Stage        | Cost Title | Cost Id | Content Type        | Status         | Agency Producer               | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| Final Actual | CENCT9     | CENCT9  | Digital Development | Pending Reopen | Christine Meyer (Leo Burnett) | CostOwner    | another qa agency | Afghanistan     | CENATN9           | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'CENCT9'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
Then I 'should' see cost email notification for 'Cost Reopen Success' with field to 'CostOwner' and subject 'CENCT9' contains following attributes:
| P&G Admin         | Stage        | Cost Title | Cost Id | Content Type        | Status | Agency Producer               | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| GovernanceManager | Final Actual | CENCT9     | CENCT9  | Digital Development | Draft  | Christine Meyer (Leo Burnett) | CostOwner    | another qa agency | Afghanistan     | CENATN9           | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |


Scenario: Check that notifications triggered when PnG admin rejects the final actual reopen request
Meta:@adcost
     @adcostEmails
!--QA-743, ADC-1249, # 16
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | CENCT10    | CENCD10     | Christine Meyer (Leo Burnett) | 50000                | Digital Development | CENATN10               | IMEA          | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCT10' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'CENCT10':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT10   | Digital               | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CENCT10':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000      | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCT10' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENCT10':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'CENCT10'
And cost with title 'CENCT10' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'CENCT10'
And filled Cost Line Items with following fields for cost title 'CENCT10':
| Adaptation | Virtual Reality | P&G insurance |
| 40000      | 30000           | 20000         |
And I uploaded following supporting documents to cost title 'CENCT10':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And added below approvers for cost title 'CENCT10':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CENCT10'
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'CENCT10'
And cost with title 'CENCT10' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CENCT10'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
And I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'CENCT10'
And I click 'Reject Reopen' button and 'Yes, reject the request' on cost review page
Then I 'should' see cost email notification for 'Cost Reopen Reject' with field to 'CostOwner' and subject 'CENCT10' contains following attributes:
| P&G Admin         | Stage        | Cost Title | Cost Id | Content Type        | Status   | Agency Producer               | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| GovernanceManager | Final Actual | CENCT10    | CENCT10 | Digital Development | Approved | Christine Meyer (Leo Burnett) | CostOwner    | another qa agency | Afghanistan     | CENATN10          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |


Scenario: Check that InsuranceUser receives email notifications for Western Europe Agency
Meta:@adcost
     @adcostEmails
!--QA-743, ADC-2476, ADC-2553
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name  | A4User        | Country        | Labels                                                               | Application Access    |
| CENBU | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG | adcost,folders,adkits |
Given I updated the following agency:
| Name          | Email Notification URL |
| DefaultAgency | application_url        |
| CENBU         | http://www.google.com  |
And created users with following fields and waited until replication to Cost Module:
| Email        | Role        | AgencyUnique | Access                                    |
| CENCostOwner | agency.user | CENBU        | dashboard,adkits,approvals,folders,adcost |
And added existing user 'CENCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email        | User Role    | Approval limit | Access Type | Condition |
| CENCostOwner | Agency Admin |                | Client      | CENBU     |
And logged in with details of 'CENCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name         | Custom Code | Advertiser | Sector        | Brand        |
| CENCAProject | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| CENCAProject   | CENCT11    | CEND11      | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  CENATN11               | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCT11' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CENCT11':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT11     | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'CENCT11':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCT11':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENCT11':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'CENCT11'
Then I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCT11' contains following attributes:
| Pending Approval | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner | Agency Name | Agency Location | Agency Tracking # | Project Name | Project ID   | Budget Region | Technical Approver | Brand        | Timestamp |
| IPM Approval     | Original Estimate | CENCT11    | CENCT11 | Still Image  | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENCostOwner | CENBU       | United Kingdom  | CENATN11          | CENCAProject | CENCAProject | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CENCT11'
Then I 'should not' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCT11' contains following attributes:
| Pending Approval | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner | Agency Name | Agency Location | Agency Tracking # | Project Name | Project ID   | Budget Region | Technical Approver | Brand        | Timestamp |
| Brand Approval   | Original Estimate | CENCT11    | CENCT11 | Still Image  | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCostOwner | CENBU       | United Kingdom  | CENATN11          | CENCAProject | CENCAProject | North America | IPMuser            | DefaultBrand | Today     |
When cost with title 'CENCT11' is 'Approve' on behalf of MyPurchases application
Then I 'should' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCT11' contains following attributes:
| Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name | Agency Location | Agency Tracking # | Project Name | Project ID   | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENCT11    | CENCT11 | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CENCostOwner | CENBU       | United Kingdom  | CENATN11          | CENCAProject | CENCAProject | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'CENCostOwner'
And 'CreateRevision' the cost with title 'CENCT11'
And I add cost item details for cost title 'CENCT11' with 'USD' currency:
| Retouching |
| 25000      |
And I upload following supporting documents to cost title 'CENCT11':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
When I 'Submit' the cost with title 'CENCT11'
Then I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCT11' contains following attributes:
| Pending Approval | Stage            | Cost Title | Cost Id | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner | Agency Name | Agency Location | Agency Tracking # | Project Name | Project ID   | Budget Region | Technical Approver | Brand        | Timestamp |
| IPM Approval     | Current Revision | CENCT11    | CENCT11 | Still Image  | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENCostOwner | CENBU       | United Kingdom  | CENATN11          | CENCAProject | CENCAProject | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CENCT11'
Then I 'should not' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCT11' contains following attributes:
| Pending Approval | Stage            | Cost Title | Cost Id | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner | Agency Name | Agency Location | Agency Tracking # | Project Name | Project ID   | Budget Region | Technical Approver | Brand        | Timestamp |
| Brand Approval   | Current Revision | CENCT11    | CENCT11 | Still Image  | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCostOwner | CENBU       | United Kingdom  | CENATN11          | CENCAProject | CENCAProject | North America | IPMuser            | DefaultBrand | Today     |
When cost with title 'CENCT11' is 'Approve' on behalf of MyPurchases application
Then I 'should' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCT11' contains following attributes:
| Stage            | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name | Agency Location | Agency Tracking # | Project Name | Project ID   | Budget Region | Technical Approver | Brand        | Timestamp |
| Current Revision | CENCT11    | CENCT11 | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CENCostOwner | CENBU       | United Kingdom  | CENATN11          | CENCAProject | CENCAProject | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'CENCostOwner'
And 'NextStage' the cost with title 'CENCT11'
And I add cost item details for cost title 'CENCT11' with 'USD' currency:
| Retouching |
| 25000      |
And I upload following supporting documents to cost title 'CENCT11':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
When I 'Submit' the cost with title 'CENCT11'
Then I 'should' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCT11' contains following attributes:
| Pending Approval | Stage        | Cost Title | Cost Id | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner | Agency Name | Agency Location | Agency Tracking # | Project Name | Project ID   | Budget Region | Technical Approver | Brand        | Timestamp |
| IPM Approval     | Final Actual | CENCT11    | CENCT11 | Still Image  | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENCostOwner | CENBU       | United Kingdom  | CENATN11          | CENCAProject | CENCAProject | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CENCT11'
Then I 'should not' see cost email notification for 'Pending Approval' with field to 'InsuranceUser' and subject 'CENCT11' contains following attributes:
| Pending Approval | Stage        | Cost Title | Cost Id | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner | Agency Name | Agency Location | Agency Tracking # | Project Name | Project ID   | Budget Region | Technical Approver | Brand        | Timestamp |
| Brand Approval   | Final Actual | CENCT11    | CENCT11 | Still Image  | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CENCostOwner | CENBU       | United Kingdom  | CENATN11          | CENCAProject | CENCAProject | North America | IPMuser            | DefaultBrand | Today     |
When cost with title 'CENCT11' is 'Approve' on behalf of MyPurchases application
Then I 'should' see cost email notification for 'Cost Approved' with field to 'InsuranceUser' and subject 'CENCT11' contains following attributes:
| Stage        | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name | Agency Location | Agency Tracking # | Project Name | Project ID   | Budget Region | Technical Approver | Brand        | Timestamp |
| Final Actual | CENCT11    | CENCT11 | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CENCostOwner | CENBU       | United Kingdom  | CENATN11          | CENCAProject | CENCAProject | North America | IPMuser            | DefaultBrand | Today     |



Scenario: Check that notifications triggered to both previous approver and new approver when cost approval is reassigned
Meta:@adcost
     @adcostEmails
     @abug
!--QA-743, ADC-790, ADC-791, #6, bug# ADC-2662
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | CENCT12    | CENCD12     | Christine Meyer (Leo Burnett) | 50000                | Digital Development | CENATN12               | IMEA          | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCT12' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'CENCT12':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT12    | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CENCT12':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000      | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCT12':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENCT12':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CENCT12'
When I 'Recall' the cost with title 'CENCT12'
And I 'Reopen' the cost with title 'CENCT12'
And I am on cost approval page of cost title 'CENCT12'
And I 'Delete' approver 'IPMuser' from 'technical' approver section on approvals page
And fill below approvers for cost title 'CENCT12':
| Technical Approver |
| AnotherIPMuser     |
And 'Submit' the cost with title 'CENCT12'
Then I 'should' see cost email notification for 'Cost Approval Reassigned' with field to 'IPMuser' and subject 'CENCT12' contains following attributes:
| Cost Approver  | Cost Approver Type | Stage             | Cost Title | Cost Id | Content Type        | Status                     | Agency Producer               | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp | Cost Owner |
| AnotherIPMuser | Technical          | Original Estimate | CENCT12    | CENCT12 | Digital Development | Pending Technical Approval | Christine Meyer (Leo Burnett) | CostOwner    | another qa agency | Afghanistan     | CENATN12          | DefaultCostProject | DefaultCostProject | IMEA          | AnotherIPMuser     | DefaultBrand | Today     | CostOwner  |
Then I 'should' see cost email notification for 'Approver Added' with field to 'AnotherIPMuser' and subject 'CENCT12' contains following attributes:
| Cost Approver  | Cost Approver Type | Stage             | Cost Title | Cost Id | Content Type        | Status                     | Agency Producer               | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| AnotherIPMuser | Technical          | Original Estimate | CENCT12    | CENCT12 | Digital Development | Pending Technical Approval | Christine Meyer (Leo Burnett) | CostOwner    | another qa agency | Afghanistan     | CENATN12          | DefaultCostProject | DefaultCostProject | IMEA          | AnotherIPMuser     | DefaultBrand | Today     |


Scenario: Check that adcost support team receives email notification when cost rejected by COUPA as Type 4 Error
Meta:@adcost
     @adcostEmails
!--QA-1108, bug # ADC-2648
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CENCT13    | CEND13      | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  CENATN13               | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CENCT13' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CENCT13':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENAT13     | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'CENCT13':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'CENCT13':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENCT13':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'CENCT13'
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'CENCT13'
When COUPA 'Reject' the cost with title 'CENCT13' to introduce type 4 error message:
| ErrorMessages | Type | Message                       |
| Yes           | 4    | Type 4 error email validation |
Then I 'should' see cost email notification for 'Technical Issue With Cost' with field to 'adcostssupport@adstream.com' and subject 'CENCT13' contains following attributes:
| Cost Title | Message                       |
| CENCT13    | Type 4 error email validation |