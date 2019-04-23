Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Cancel Cost functionality

Scenario: Check Cost can be cancelled at AIPE stage when in approved status
Meta:@adcost
@aipe
!--QA-721
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | CCCOASCT1  | CCCOASCD1   | Aaron Royer (Grey)  | 60000                | Video        | Full Production  | CCCOASATN1             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | true |
And I am on cost items page of cost title 'CCCOASCT1'
And I filled Cost Line Items with following fields:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'CCCOASCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I added below approvers for cost title 'CCCOASCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'CCCOASCT1'
And cost with title 'CCCOASCT1' is 'Approve' on behalf of MyPurchases application with page refresh
And I 'Cancel' the cost with title 'CCCOASCT1'
And I am on cost overview page
Then I 'should' see following data for 'CCCOASCT1' cost item on Adcost overview page:
| Cost Stage | Cost Status          |
| Aipe       | Pending cancellation |
When cost with title 'CCCOASCT1' is 'Cancel' on behalf of MyPurchases application with page refresh
Then I 'should' see following data for 'CCCOASCT1' cost item on Adcost overview page:
| Cost Stage | Cost Status |
| Aipe       | Cancelled   |


Scenario: Check Production Cost can be cancelled when recalled at Original Estimate stage
Meta:@adcost
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-721
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCCOASCT2  | CCCOASCD2   | Aaron Royer (Grey)  | 60000                | Video        | CGI/Animation    | CCCOASATN2             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'CCCOASCT2' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'CCCOASCT2':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | CCCOASAT2    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And I am on cost items page of cost title 'CCCOASCT2'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 20000              | 5000          | 40000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCCOASCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I added below approvers for cost title 'CCCOASCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCCOASCT2'
And login with details of 'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT2'
And cost with title 'CCCOASCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'Cancel' the cost with title 'CCCOASCT2'
And I am on cost review page of cost item with title 'CCCOASCT2'
Then I should see AMQ receives below request for cost title 'CCCOASCT2' and type as 'cancelled':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description   | Basket Name      |  Commodity  | Cost Number | RequisitionerEmail      | Vendor  |
| 65000        | 32500          | USD      | 1234567890 | DefaultBrand | CCCOASCD2     | brandDescription |  Video      | CCCOASCT2   | BrandManagementApprover | VH8888  |
Then I 'should' see following fields in cost stage section on cost review page:
| Stage              | Status               |
| Original Estimate  | Pending cancellation |
When cost with title 'CCCOASCT2' is 'Cancel' on behalf of MyPurchases application with page refresh
Then I 'should' see following fields in cost stage section on cost review page:
| Stage              | Status    |
| Original Estimate  | Cancelled |

Scenario: Check Production Cost can be cancelled at First Presentation stage when in approved status
Meta:@adcost
!--QA-721
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCCOASCT3  | CCCOASCD3   | Aaron Royer (Grey)  | 60000                | Video        | Full Production      | CCCOASATN3             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'CCCOASCT3' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'CCCOASCT3':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | CCCOASAT3    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And I am on cost items page of cost title 'CCCOASCT3'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCCOASCT3':
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script)|
And I added below approvers for cost title 'CCCOASCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCCOASCT3'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT3'
And cost with title 'CCCOASCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'CCCOASCT3'
And I upload following supporting documents to cost title 'CCCOASCT3':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
And I add below approvers for cost title 'CCCOASCT3':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'CCCOASCT3'
And I login with details of  'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT3'
And I login with details of  'CostOwner'
And I am on cost review page of cost item with title 'CCCOASCT3'
And I click 'Cancel Cost' button and 'Yes, cancel this cost' on cost review page
Then I 'should' see following fields in cost stage section on cost review page:
| Stage              | Status               |
| First Presentation | Pending cancellation |
When cost with title 'CCCOASCT3' is 'Cancel' on behalf of MyPurchases application with page refresh
Then I 'should' see following fields in cost stage section on cost review page:
| Stage              | Status    |
| First Presentation | Cancelled |


Scenario: Check Usage Buyout Cost can be cancelled at Original Estimate stage when in approved status
Meta:@adcost
!--QA-721
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number      | New  | Approval stage for submission | Type | Usage/Buyout/Contract          | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | true | OriginalEstimate              | Film | Contract (celebrity & athletes)| CCCOASCT4  | CCCOASCD4   | Aaron Royer (Grey)  | CCCOASATN4             | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CCCOASCT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 9000           |
And I am on cost items page of cost title 'CCCOASCT4'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'CCCOASCT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CCCOASCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CCCOASCT4'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT4'
And cost with title 'CCCOASCT4' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
When I 'Cancel' the cost with title 'CCCOASCT4'
And I am on cost overview page
Then I 'should' see following data for 'CCCOASCT4' cost item on Adcost overview page:
| Cost Stage        | Cost Status          |
| Original Estimate | Pending cancellation |
When cost with title 'CCCOASCT4' is 'Cancel' on behalf of MyPurchases application with page refresh
Then I 'should' see following data for 'CCCOASCT4' cost item on Adcost overview page:
| Cost Stage        | Cost Status   |
| Original Estimate | Cancelled     |


Scenario: Check Usage Buyout Cost can be cancelled at Original Estimate Revision stage when in approved status
Meta:@adcost
!--QA-721
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | CCCOASCT5  | CCCOASCD5   | Aaron Royer (Grey)  | CCCOASATN5             | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CCCOASCT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 30000          |
And I am on cost items page of cost title 'CCCOASCT5'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'CCCOASCT5':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CCCOASCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CCCOASCT5'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT5'
And cost with title 'CCCOASCT5' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'CCCOASCT5'
And I uploaded following supporting documents to cost title 'CCCOASCT5':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And added below approvers for cost title 'CCCOASCT5':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'CCCOASCT5'
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT5'
And I login with details of 'CostOwner'
And I am on cost overview page
When I click 'Cancel Cost' and 'Yes, cancel this cost' on title 'CCCOASCT5' from costs overview page
Then I should see AMQ receives below request for cost title 'CCCOASCT5' and type as 'cancelled':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description   | Basket Name      | LongText        | Commodity  | Cost Number | Vendor  |
| 20000        |     0          | USD      | 1234567890 | DefaultBrand | CCCOASCD5     | brandDescription | CGI/Animation   | Film       | CCCOASCT5   | VH8888  |
Then I 'should' see following data for 'CCCOASCT5' cost item on Adcost overview page:
| Cost Stage       | Cost Status          |
| Current Revision | Pending cancellation |
When cost with title 'CCCOASCT5' is 'Cancel' on behalf of MyPurchases application with page refresh
Then I 'should' see following data for 'CCCOASCT5' cost item on Adcost overview page:
| Cost Stage       | Cost Status |
| Current Revision | Cancelled   |


Scenario: Check Production Cost can be cancelled at First Presentation Revision stage when in approved status
Meta:@adcost
!--QA-721
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCCOASCT6  | CCCOASCD6   | Aaron Royer (Grey)  | 60000                | Video        | Full Production      | CCCOASATN6             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'CCCOASCT6' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'CCCOASCT6':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | CCCOASAT6    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And I am on cost items page of cost title 'CCCOASCT6'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCCOASCT6':
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script)|
And I added below approvers for cost title 'CCCOASCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CCCOASCT6'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT6'
And cost with title 'CCCOASCT6' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'CCCOASCT6'
And I uploaded following supporting documents to cost title 'CCCOASCT6':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
And I added below approvers for cost title 'CCCOASCT6':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'CCCOASCT6'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT6'
And I logged in with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'CCCOASCT6'
And I uploaded following supporting documents to cost title 'CCCOASCT6':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And I added below approvers for cost title 'CCCOASCT6':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'CCCOASCT6'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT6'
And I logged in with details of 'CostOwner'
When I 'Cancel' the cost with title 'CCCOASCT6'
And I am on cost review page of cost item with title 'CCCOASCT6'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage            | Status               |
| Current Revision | Pending cancellation |
When cost with title 'CCCOASCT6' is 'Cancel' on behalf of MyPurchases application with page refresh
Then I 'should' see following fields in cost stage section on cost review page:
| Stage             | Status    |
| Current Revision  | Cancelled |


Scenario: Check Cost can not be cancelled When user selects no for cancellation confirmation
Meta:@adcost
 !--QA-721
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCCOASCT7  | CCCOASCD7   | Aaron Royer (Grey)  | 60000                | Video        | CGI/Animation    | CCCOASATN7             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'CCCOASCT7' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'CCCOASCT7':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | CCCOASAT7    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And I am on cost items page of cost title 'CCCOASCT7'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 20000              | 5000          | 40000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCCOASCT7':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I added below approvers for cost title 'CCCOASCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCCOASCT7'
And login with details of 'IPMuser'
And I 'Approve' the cost with title 'CCCOASCT7'
And cost with title 'CCCOASCT7' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCCOASCT7'
And I click 'Cancel Cost' and 'No' on title 'CCCOASCT7' from costs overview page
Then I 'should' see following data for 'CCCOASCT7' cost item on Adcost overview page:
| Cost Stage        | Cost Status |
| Original Estimate | Approved    |


Scenario: Check Traffic Cost can be cancelled at original estimate stage
Meta:@adcost
     @adcostSmokeUAT
!--QA-721,QA-829
Given I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And created a new 'Trafficking' cost with following CostDetails:
| Project Number            | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCycloneCostProject | CCCOASCT8  | CCCOASCD8   | Aaron Royer (Grey) | 50000                | CCCOASATN8             | North America | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
When I am on cost items page of cost title 'CCCOASCT8'
Then I 'should' see following Cost Line Items:
| Section Name       | Cost Line Items                                                                                                      |
| DISTRIBUTION COSTS | DISTRIBUTION COSTS;Item description;Trafficking/Distribution Costs;SUBTOTAL DISTRIBUTION COSTS                       |
| Other costs        | OTHER COSTS;Item description;Tax (if applicable);Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS |
When I fill Cost Line Items with following fields:
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 80000                          |  1234567890                       |
And I fill below approvers for cost title 'CCCOASCT8':
| Brand Management Approver |
| BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'CCCOASCT8'
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCCOASCT8'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'CCCOASCT8'
And I click 'Cancel Cost' button and 'Yes, cancel this cost' on cost review page
Then I 'should' see following fields in cost stage section on cost review page:
| Stage              | Status    |
| Original Estimate  | Cancelled |