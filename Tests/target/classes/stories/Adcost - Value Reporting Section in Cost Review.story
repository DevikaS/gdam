Feature: check value reporting section on cost review
Narrative:
In order to
As a CostOwner
I want to check value reporting section in cost review

Scenario: Check that only same technical approver can edit the value reporting section who approved it
Meta:@adcost
     @costValueReporting
     @adcostCriticalTests
!--QA-730, ADC-2246
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | VRSCRCT1   | VRSCRCD1    | Aaron Royer (Grey)  | 50000                | Video        | Full Production | VRSCRATN1              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'VRSCRCT1' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'VRSCRCT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | VRSCRAT1    | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'VRSCRCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 18000              | 13000         | 6000          | 1234567890                        |
And uploaded following supporting documents to cost title 'VRSCRCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'VRSCRCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
Then I 'should not' see value reporting section on review page for cost Title 'VRSCRCT1'
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'VRSCRCT1'
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance | Value added | Hard savings current stage | Total savings |
| $ 0.00         | $ 0.00      | $ 13000.00                 | $ 0.00        |
When I 'Approve' the cost with title 'VRSCRCT1'
And I refresh the page without delay
And I edit the value reporting section with following data and click 'Save' the changes:
| Proven strategy   | Activity          | Cost avoidance | Value added |
| Proven Strategy 1 | Original Estimate | 5000           | 2000        |
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity          | Cost avoidance | Value added | Hard savings current stage | Total savings |
| Proven Strategy 1 | Original Estimate | $ 5000.00      | $ 2000.00   | $ 13000.00                 | $ 20000.00    |
When I login with details of 'AnotherIPMuser'
Then I 'should not' see Edit Value Reporting button on cost review page for cost title 'VRSCRCT1'
When cost with title 'VRSCRCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'VRSCRCT1'
And I upload following supporting documents to cost title 'VRSCRCT1':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
And 'Submit' the cost with title 'VRSCRCT1'
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'VRSCRCT1'
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity          | Cost avoidance | Value added | Hard savings current stage | Total savings |
| Proven Strategy 1 | Original Estimate | $ 5000.00      | $ 2000.00   | $ 13000.00                 | $ 20000.00    |
When I 'Approve' the cost with title 'VRSCRCT1'
And I refresh the page without delay
And I edit the value reporting section for cost Title 'VRSCRCT1' with following data:
| Proven strategy   | Activity     | Cost avoidance | Value added | Total savings |
| Proven Strategy 2 | Final Actual | 7000           | 5000        | 25000         |
And I refresh the page without delay
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity     | Cost avoidance | Value added | Hard savings current stage | Total savings |
| Proven Strategy 2 | Final Actual | $ 7000.00      | $ 5000.00   | $ 13000.00                 | $ 25000.00    |
And I 'should' see following data in value reporting section on 'Approved' status of 'Original Estimate' stage:
| Proven strategy   | Activity          | Cost avoidance | Value added | Hard savings current stage | Total savings |
| Proven Strategy 1 | Original Estimate | $ 5000.00      | $ 2000.00   | $ 13000.00                 | $ 20000.00    |
And I login with details of 'AnotherIPMuser'
Then I 'should not' see Edit Value Reporting button on cost review page for cost title 'VRSCRCT1'
And I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity     | Cost avoidance | Value added | Hard savings current stage | Total savings |
| Proven Strategy 2 | Final Actual | $ 7000.00      | $ 5000.00   | $ 13000.00                 | $ 25000.00    |


Scenario: Check that Cost Consultant can edit value reporting section after reopening the cost after final actual stage
Meta:@adcost
     @costValueReporting
     @adcostSmokeUAT
     @adcostSmoke
!--QA-730, QA-851
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | VRSCRCT2   | VRSCRCD2    | Aaron Royer (Grey)  | VRSCRATN2              | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'VRSCRCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 10000          |
And added negotiated terms page for cost title 'VRSCRCT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'VRSCRCT2'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'VRSCRCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'VRSCRCT2':
| Technical Approver | Coupa Requisitioner       |
| CostConsultant     | BrandManagementApprover   |
And 'Submit' the cost with title 'VRSCRCT2'
And I logged in with details of 'CostConsultant'
And I am on cost review page of cost item with title 'VRSCRCT2'
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| $ 0.00             | $ 0.00        | $ 0.00                     | $ 0.00     |
When I 'Approve' the cost with title 'VRSCRCT2'
And I refresh the page without delay
When edit the value reporting section with following data and click 'Save' the changes:
| Proven strategy   | Activity          | Cost avoidance | Value added |
| Proven Strategy 1 | Original Estimate | 5000           | 4000        |
And wait for '2' seconds
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity          | Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| Proven Strategy 1 | Original Estimate | $ 5000.00          | $ 4000.00     | $ 0.00                     | $ 9000.00     |
When cost with title 'VRSCRCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'VRSCRCT2'
And I upload following supporting documents to cost title 'VRSCRCT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I 'Submit' the cost with title 'VRSCRCT2'
And I login with details of 'CostConsultant'
And 'Approve' the cost with title 'VRSCRCT2'
And cost with title 'VRSCRCT2' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'VRSCRCT2'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'VRSCRCT2'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
When I login with details of 'CostOwner'
And fill Cost Line Items with following fields for cost title 'VRSCRCT2':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 12000             | 15000                      |
And 'Submit' the cost with title 'VRSCRCT2'
When I login with details of 'CostConsultant'
And I am on cost review page of cost item with title 'VRSCRCT2'
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity          | Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| Proven Strategy 1 | Original Estimate | $ 5000.00          | $ 4000.00     | $ 0.00                     | $ 9000.00     |
When I 'Approve' the cost with title 'VRSCRCT2'
And I refresh the page without delay
And edit the value reporting section with following data and click 'Save' the changes:
| Activity          | Cost avoidance     | Value added   |
| Final Actual      | 7000               | 5000          |
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity          | Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| Proven Strategy 1 | Final Actual      | $ 7000.00          | $ 5000.00     | $ 0.00                     | $ 12000.00    |


Scenario: Check that Purchasing and Finance users can only see value reporting section
Meta:@adcost
     @costValueReporting
!--QA-730
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | VRSCRCT3   | VRSCRCD3    | Aaron Royer (Grey)  | 50000                | Video        | Post Production Only | VRSCRATN3              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'VRSCRCT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'VRSCRCT3':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | VRSCRAT2    | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'VRSCRCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 18000              | 30000         | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'VRSCRCT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'VRSCRCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'VRSCRCT3'
And I logged in with details of 'IPMuser'
And I am on cost review page of cost item with title 'VRSCRCT3'
And 'Approve' the cost with title 'VRSCRCT3'
And refreshed the page without delay
When edit the value reporting section with following data and click 'Save' the changes:
| Proven strategy   | Activity          | Cost avoidance     | Value added   |
| Proven Strategy 1 | Original Estimate | 5000               | 4000          |
And I login with details of 'FinanceManager'
Then I 'should not' see Edit Value Reporting button on cost review page for cost title 'VRSCRCT3'
And 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance | Value added | Hard savings current stage | Total savings |
| $ 5000.00      | $ 4000.00   | $ 0.00                     | $ 9000.00     |
When I login with details of 'PurchasingSupport'
Then I 'should not' see Edit Value Reporting button on cost review page for cost title 'VRSCRCT3'
And 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance | Value added | Hard savings current stage | Total savings |
| $ 5000.00      | $ 4000.00   | $ 0.00                     | $ 9000.00     |


Scenario: Check that PnG governance manager can update value reporting section for approved costs
Meta:@adcost
     @costValueReporting
     @adcostSmokeUAT
!--QA-730, ADC-2240
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | VRSCRCT4   | VRSCRCD4    | Aaron Royer (Grey)  | 50000                | Video        | Post Production Only | VRSCRATN4              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'VRSCRCT4' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'VRSCRCT4':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | VRSCRAT3    | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'VRSCRCT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 18000              | 30000         | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'VRSCRCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'VRSCRCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'VRSCRCT4'
And I logged in with details of 'IPMuser'
And I am on cost review page of cost item with title 'VRSCRCT4'
And 'Approve' the cost with title 'VRSCRCT4'
And I logged in with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'VRSCRCT4'
When edit the value reporting section with following data and click 'Save' the changes:
| Proven strategy   | Activity          | Cost avoidance | Value added |
| Proven Strategy 1 | Original Estimate | 15000          | 14000       |
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance | Value added | Hard savings current stage | Total savings |
| $ 15000.00     | $ 14000.00  | $ 0.00                     | $ 29000.00    |


Scenario: Check that approver can see Value editing section for the reopend cost
Meta:@adcost
!--QA-730
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | VRSCRCT5   | VRSCRCD5    | Aaron Royer (Grey)   | 60000                | Video        | CGI/Animation    | VRSCRATN5              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'VRSCRCT5' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'VRSCRCT5':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | VRSCRAT4    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And I am on cost items page of cost title 'VRSCRCT5'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 20000              | 5000          | 40000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'VRSCRCT5':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I am on cost approval page of cost title 'VRSCRCT5'
And added below approvers for cost title 'VRSCRCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'VRSCRCT5'
And I am on cost review page of cost item with title 'VRSCRCT5'
Then I 'should' see hard savings field is disabled
When edit the value reporting section with following data and click 'Save' the changes:
| Proven strategy   | Activity          | Cost avoidance | Value added |
| Proven Strategy 1 | Original Estimate | 15000          | 16000       |
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance | Value added | Hard savings current stage | Total savings |
| $ 15000.00     | $ 16000.00  | $ 0.00                     | $ 31000.00    |
When cost with title 'VRSCRCT5' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And 'NextStage' the cost with title 'VRSCRCT5'
And I upload following supporting documents to cost title 'VRSCRCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'VRSCRCT5'
And I am on cost review page of cost item with title 'VRSCRCT5'
When I click 'Recall Cost' button and 'Yes, recall this cost' on cost review page
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Recalled |
When I click 'Reopen' button and 'Yes, reopen this cost' on cost review page
And add below approvers for cost title 'VRSCRCT5':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'VRSCRCT5'
And I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'VRSCRCT5'
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| $ 15000.00         | $ 16000.00    | $ 0.00                     | $ 31000.00    |

Scenario: Check that IPM user can edit value reporting section after reopening the cost after final actual stage
Meta:@adcost
!--QA-851
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | VRSCRCT6   | VRSCRD4     | Christine Meyer (Leo Burnett) | 50000                | Digital Development | VRSCRATN4              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'VRSCRCT6' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'VRSCRCT6':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | VRSCRAT6   | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'VRSCRCT6':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 10000        | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'VRSCRCT6':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I am on cost approval page of cost title 'VRSCRCT6'
And added below approvers for cost title 'VRSCRCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'VRSCRCT6'
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| $ 0.00             | $ 0.00        | $ 10000.00                 | $ 0.00        |
When I 'Approve' the cost with title 'VRSCRCT6'
And I refresh the page without delay
And edit the value reporting section with following data and click 'Save' the changes:
| Proven strategy   | Activity          | Cost avoidance     | Value added   |
| Proven Strategy 1 | Original Estimate | 5000               | 2000          |
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity          | Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| Proven Strategy 1 | Original Estimate | $ 5000.00          | $ 2000.00     | $ 10000.00                 | $ 17000.00    |
When cost with title 'VRSCRCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'VRSCRCT6'
And I upload following supporting documents to cost title 'VRSCRCT6':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I 'Submit' the cost with title 'VRSCRCT6'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'VRSCRCT6'
And cost with title 'VRSCRCT6' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'VRSCRCT6'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'VRSCRCT6'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
When I login with details of 'CostOwner'
And fill Cost Line Items with following fields for cost title 'VRSCRCT6':
| Adaptation   | Virtual Reality |
| 15000        | 20000           |
And 'Submit' the cost with title 'VRSCRCT6'
And I am on cost review page of cost item with title 'VRSCRCT6'
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'VRSCRCT6'
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity          | Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| Proven Strategy 1 | Original Estimate | $ 5000.00          | $ 2000.00     | $ 5000.00                  | $ 12000.00    |
When I 'Approve' the cost with title 'VRSCRCT6'
And I refresh the page without delay
And edit the value reporting section with following data and click 'Save' the changes:
| Proven strategy   | Activity          | Cost avoidance     | Value added   |
| Proven Strategy 1 | Final Actual      | 7000               | 5000          |
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Proven strategy   | Activity          | Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| Proven Strategy 1 | Final Actual      | $ 7000.00          | $ 5000.00     | $ 5000.00                  | $ 17000.00    |


Scenario: Check that IPM User and PnG governance manager can update value reporting section for approved costs
Meta:@adcost
     @costValueReporting
     @adcostSmokeUAT
     @adcostSmoke
!--QA-730, ADC-2240
Given I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number            | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | true | OriginalEstimate              | Celebrity | Usage                 | VRSCRCT7   | VRSCRCD7    | Aaron Royer (Grey)   | VRSCRATN7              | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'VRSCRCT7' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'VRSCRCT7' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And filled Cost Line Items with following fields for cost title 'VRSCRCT7':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 20000             | 10000                      |
And I uploaded following supporting documents to cost title 'VRSCRCT7':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'VRSCRCT7':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'VRSCRCT7'
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'VRSCRCT7'
And I am on cost review page of cost item with title 'VRSCRCT7'
When I edit the value reporting section with following data and click 'Save' the changes:
| Proven strategy   | Activity          | Cost avoidance     | Value added   |
| Proven Strategy 1 | Original Estimate | 15000              | 14000         |
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| $ 15000.00         | $ 14000.00    | $ 0.00                     | $ 29000.00    |
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'VRSCRCT7'
And I edit the value reporting section with following data and click 'Save' the changes:
| Proven strategy   | Activity          | Cost avoidance     | Value added   |
| Proven Strategy 1 | Original Estimate | 20000              | 15000         |
Then I 'should' see following data in 'Value Reporting' section on Cost Review page:
| Cost avoidance     | Value added   | Hard savings current stage | Total savings |
| $ 20000.00         | $ 15000.00    | $ 0.00                     | $ 35000.00    |