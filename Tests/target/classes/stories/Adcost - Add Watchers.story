Feature: Add Watchers
Narrative:
In order to
As a CostOwner
I want to Add Watchers in cost module

Scenario: Check that users from another BU cannot be added to Watchers list including Cost Consultants
Meta:@adcost
     @adcostEmails
!--QA-743, QA-1038, QA-1037, QA-1081
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name | A4User        | Country        | Labels                                                                       | Application Access    |
| AWBU | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG,Cyclone | adcost,folders,adkits |
And created users with following fields and waited until replication to Cost Module:
| Email                     | Role        | AgencyUnique | Access                                    |
| AWAnohterBUuser           | agency.user | AWBU         | dashboard,adkits,approvals,folders,adcost |
| AWAnohterBUCostConsultant | agency.user | AWBU         | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email                     | User Role       | Approval limit | Access Type | Condition   |
| AWAnohterBUuser           | Agency Admin    |                | Client      | CCPCASICTBU |
| AWAnohterBUCostConsultant | Cost Consultant |                | Client      | CCPCASICTBU |
And I logged in as 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | AWCT1      | AWCD1       | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  AWATN1                 | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Cost Line Items with following fields for cost title 'AWCT1':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
Then I 'should not' see below approvers on approval form page for cost title 'AWCT1':
| Add Watcher                               |
| AWAnohterBUuser;AWAnohterBUCostConsultant |
Then I 'should' see below approvers on approval form page for cost title 'AWCT1':
| Add Watcher    |
| CostConsultant |


Scenario: Check that multiple watchers receives cost approval notifications including Cost Consultants
Meta:@adcost
     @adcostEmails
!--QA-743, QA-1038, QA-1037, QA-1081
Given I created users with following fields and waited until replication to Cost Module:
| Email            | Role        | Agency        | Access                                    |
| AWAddWatcherUser | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And assigned user with following access in cost module:
| Email            | User Role    | Approval limit | Access Type | Condition   |
| AWAddWatcherUser | Agency Admin |                | Client      | CCPCASICTBU |
And I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | AWAT2      | AWCD2       | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  AWATN2                 | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'AWAT2' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'AWAT2':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | AWAT2       | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'AWAT2':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'AWAT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'AWAT2':
| Technical Approver | Coupa Requisitioner     | Add Watcher                     |
| IPMuser            | BrandManagementApprover | AWAddWatcherUser;CostConsultant |
And I 'Submit' the cost with title 'AWAT2'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'AWAT2'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CostConsultant' and subject 'AWAT2' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | AWAT2      | AWAT2   | Still Image  | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN2            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'AWAddWatcherUser' and subject 'AWAT2' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | AWAT2      | AWAT2   | Still Image  | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN2            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
When cost with title 'AWAT2' is 'Approve' on behalf of MyPurchases application
Then I 'should' see cost email notification for 'Cost Approved In Coupa' with field to 'CostConsultant' and subject 'AWAT2' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IoNumberOwner | Original Estimate | AWAT2      | AWAT2   | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN2            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved In Coupa' with field to 'AWAddWatcherUser' and subject 'AWAT2' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IoNumberOwner | Original Estimate | AWAT2      | AWAT2   | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN2            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |


Scenario: Check that TA changed at Current Revision stage still displays in distribution section at Next Stage
Meta:@adcost
!--QA-1061
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | AWCT3      | AWCD3       | Aaron Royer (Grey)  | 50000                | Video        | Full Production | AWATN3                 | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'AWCT3' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'AWCT3':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | AWAT3       | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'AWCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 18000              | 13000         | 6000          | 1234567890                        |
And uploaded following supporting documents to cost title 'AWCT3' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'AWCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
When I login with details of 'IPMuser'
When I 'Approve' the cost with title 'AWCT3'
When cost with title 'AWCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'AWCT3'
And fill Cost Line Items with following fields for cost title 'AWCT3':
| Audio finalization |
| 28000              |
And I upload following supporting documents to cost title 'AWCT3' and click continue:
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
Then I 'should' see below approvers on cost approval page:
| Technical Approver |
| IPMuser            |
When I 'Delete' approver 'IPMuser' from 'technical' approver section on approvals page
And fill below approvers for cost title 'AWCT3':
| Technical Approver |
| AnotherIPMuser     |
And 'Submit' the cost with title 'AWCT3'
When I login with details of 'AnotherIPMuser'
When I 'Approve' the cost with title 'AWCT3'
When cost with title 'AWCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'AWCT3'
And I am on cost approval page of cost title 'AWCT3'
Then I 'should' see below approvers on cost approval page:
| Technical Approver |
| AnotherIPMuser     |


Scenario: Check that TA changed in one stage still displays in distribution section in further Stages
Meta:@adcost
!--QA-1061
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | AWCT4      | AWCD4       | Aaron Royer (Grey)  | 50000                | Video        | Full Production | AWATN4                 | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'AWCT4' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'AWCT4':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | AWAT4       | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'AWCT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 18000              | 13000         | 6000          | 1234567890                        |
And uploaded following supporting documents to cost title 'AWCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'AWCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
When I login with details of 'IPMuser'
When I 'Approve' the cost with title 'AWCT4'
When cost with title 'AWCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'AWCT4'
And fill Cost Line Items with following fields for cost title 'AWCT4':
| Audio finalization |
| 28000              |
And upload following supporting documents to cost title 'AWCT4' and click continue:
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
Then I 'should' see below approvers on cost approval page:
| Technical Approver |
| IPMuser            |
When I 'Delete' approver 'IPMuser' from 'technical' approver section on approvals page
And fill below approvers for cost title 'AWCT4':
| Technical Approver |
| AnotherIPMuser     |
And 'Submit' the cost with title 'AWCT4'
When I login with details of 'AnotherIPMuser'
When I 'Approve' the cost with title 'AWCT4'
When cost with title 'AWCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'AWCT4'
And I am on cost approval page of cost title 'AWCT4'
Then I 'should' see below approvers on cost approval page:
| Technical Approver |
| AnotherIPMuser     |


Scenario: Check all watchers receives notifications after technical and coupa approvals
Meta:@adcost
     @adcostEmails
!--QA-1081
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | AWCT5      | AWCD5       | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  AWATN5                 | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'AWCT5' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'AWCT5':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | AWAT5       | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'AWCT5':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'AWCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'AWCT5':
| Technical Approver | Coupa Requisitioner     | Add Watcher                |
| IPMuser            | BrandManagementApprover | AgencyOwner;CostConsultant |
And I 'Submit' the cost with title 'AWCT5'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'AWCT5'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'AgencyOwner' and subject 'AWCT5' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | AWCT5      | AWCT5   | Still Image  | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN5            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CostConsultant' and subject 'AWCT5' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                 | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | AWCT5      | AWCT5   | Still Image  | Post Production Only | Pending Brand Approval | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN5            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
When cost with title 'AWCT5' is 'Approve' on behalf of MyPurchases application
Then I 'should' see cost email notification for 'Cost Approved In Coupa' with field to 'AgencyOwner' and subject 'AWCT5' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IoNumberOwner | Original Estimate | AWCT5      | AWCT5   | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN5            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved In Coupa' with field to 'CostConsultant' and subject 'AWCT5' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IoNumberOwner | Original Estimate | AWCT5      | AWCT5   | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN5            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |


Scenario: Check that watchers can be added at different stages
Meta:@adcost
     @adcostEmails
!--QA-1081
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | AWCT6      | AWCD6       | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  AWATN6                 | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'AWCT6' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'AWCT6':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | AWAT5       | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'AWCT6':
| Artwork/packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000      | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'AWCT6' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'AWCT6':
| Technical Approver | Coupa Requisitioner     | Add Watcher    |
| IPMuser            | BrandManagementApprover | CostConsultant |
And I 'Submit' the cost with title 'AWCT6'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'AWCT6'
When cost with title 'AWCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'AWCT6'
And click 'Create Revision' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'AWCT6':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And I am on cost approval page of cost title 'AWCT6'
And fill below approvers for cost title 'AWCT6':
| Add Watcher |
| AgencyOwner |
And I 'Submit' the cost with title 'AWCT6'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'AWCT6'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'AgencyOwner' and subject 'AWCT6' contains following attributes:
| Cost Approver | Stage            | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Current Revision | AWCT6      | AWCT6   | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN6            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CostConsultant' and subject 'AWCT6' contains following attributes:
| Cost Approver | Stage            | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Current Revision | AWCT6      | AWCT6   | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN6            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'AWCT6'
And I 'NextStage' the cost with title 'AWCT6'
And I upload following supporting documents to cost title 'AWCT6':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I am on cost approval page of cost title 'AWCT6'
And fill below approvers for cost title 'AWCT6':
| Add Watcher       |
| PurchasingSupport |
And I 'Submit' the cost with title 'AWCT6'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'AWCT6'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'AgencyOwner' and subject 'AWCT6' contains following attributes:
| Cost Approver | Stage        | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Final Actual | AWCT6      | AWCT6   | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN6            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CostConsultant' and subject 'AWCT6' contains following attributes:
| Cost Approver | Stage       | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Final Actual | AWCT6      | AWCT6   | Still Image  | Post Production Only | Approved | Aaron Royer (Grey) | CostOwner    | another qa agency | Afghanistan     | AWATN6            | DefaultCostProject | DefaultCostProject | North America | IPMuser            | DefaultBrand | Today     |