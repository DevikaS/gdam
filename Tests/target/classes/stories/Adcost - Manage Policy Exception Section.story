Feature: check value reporting section on cost review
Narrative:
In order to
As a CostOwner
I want to check value reporting section in cost review


Scenario: Check that cost owner can add policy exception for usage buyout cast
Meta:@adcost
     @costPolicyexception
!--QA-731
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | MPESCT1    | MPESCD1     | Aaron Royer (Grey)  | MPESATN1               | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'MPESCT1' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 90000          |
And added negotiated terms page for cost title 'MPESCT1' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'MPESCT1'
When I fill the policy exception on cost item page:
| Exception type | Reason    | Cost implication |
| expt2          | test exp2 | test exp2        |
| expt3          | test exp3 | test exp3        |
| expt4          | test exp4 | test exp4        |
Then I 'should' see following data in Policy Exception section on Cost item page:
| Exception type | Reason    | Cost implication | Status           |
| expt2          | test exp2 | test exp2        | Pending Approval |
| expt3          | test exp3 | test exp3        | Pending Approval |
| expt4          | test exp4 | test exp4        | Pending Approval |
When I fill Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And upload following supporting documents to cost title 'MPESCT1' and click continue:
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And add below approvers for cost title 'MPESCT1':
| Technical Approver | Coupa Requisitioner       |
| CostConsultant     | BrandManagementApprover   |
And refresh the page without delay
And I click 'Submit' button and 'Send for approval' on approval Page
When I am on cost review page of cost item with title 'MPESCT1'
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status           |
| expt2          | test exp2 | test exp2        | Pending Approval |
| expt3          | test exp3 | test exp3        | Pending Approval |
| expt4          | test exp4 | test exp4        | Pending Approval |
When I login with details of 'CostConsultant'
And I am on cost review page of cost item with title 'MPESCT1'
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status           |
| expt2          | test exp2 | test exp2        | Pending Approval |
| expt3          | test exp3 | test exp3        | Pending Approval |
| expt4          | test exp4 | test exp4        | Pending Approval |
When click 'Approve Exceptions' button and 'Approve' on cost review page for policy exception
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status   |
| expt2          | test exp2 | test exp2        | Approved |
| expt3          | test exp3 | test exp3        | Approved |
| expt4          | test exp4 | test exp4        | Approved |


Scenario: Check that technical approver can approve policy exception during normal cost approval process
Meta:@adcost
     @costPolicyexception
!--QA-731
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | MPESCT2    | MPESD2      | Aaron Royer (Grey)  | 50000                | Video        | Full Production | MPESATN2               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'MPESCT2' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'MPESCT2':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | MPESAT2     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And I am on cost items page of cost title 'MPESCT2'
And filled the policy exception on cost item page:
| Exception type | Reason    | Cost implication |
| expt2          | test exp2 | test exp2        |
| expt3          | test exp3 | test exp3        |
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 18000              | 13000         | 6000          | 1234567890                        |
And uploaded following supporting documents to cost title 'MPESCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'MPESCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'MPESCT2'
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status           |
| expt2          | test exp2 | test exp2        | Pending Approval |
| expt3          | test exp3 | test exp3        | Pending Approval |
And I should see following data for policy exception approval during normal Cost Approval process:
|PolicyExceptionChecked | ApproveButtonEnabled |
| should not            | should not           |
When click 'Approve' button and 'Approve' on cost review page for policy exceptions approval as well
And I am on cost overview page
And I am on cost review page of cost item with title 'MPESCT2'
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status   |
| expt2          | test exp2 | test exp2        | Approved |
| expt3          | test exp3 | test exp3        | Approved |
When cost with title 'MPESCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'MPESCT2'
And I fill the policy exception on cost item page for cost title 'MPESCT2' and click continue:
| Exception type | Reason    | Cost implication |
| expt6          | test exp6 | test exp6        |
And I upload following supporting documents to cost title 'MPESCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'MPESCT2'
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'MPESCT2'
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status           |
| expt3          | test exp3 | test exp3        | Approved         |
| expt2          | test exp2 | test exp2        | Approved         |
| expt6          | test exp6 | test exp6        | Pending Approval |
When click 'Approve Exceptions' button and 'Approve' on cost review page for policy exception
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status   |
| expt3          | test exp3 | test exp3        | Approved |
| expt2          | test exp2 | test exp2        | Approved |
| expt6          | test exp6 | test exp6        | Approved |


Scenario: Check that technical approver can reject the policy exception and then cost get rejected itself
Meta:@adcost
     @costPolicyexception
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-731
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | MPESCT3    | MPESD1      | Aaron Royer (Grey)  | 50000                | Video        | Full Production | MPESATN2               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'MPESCT3' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'MPESCT3':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | MPESAT2     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And I am on cost items page of cost title 'MPESCT3'
And I filled the policy exception on cost item page:
| Exception type | Reason    | Cost implication |
| expt2          | test exp2 | test exp2        |
| expt3          | test exp3 | test exp3        |
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 18000              | 13000         | 6000          | 1234567890                        |
And uploaded following supporting documents to cost title 'MPESCT3' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'MPESCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'MPESCT3'
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status           |
| expt2          | test exp2 | test exp2        | Pending Approval |
| expt3          | test exp3 | test exp3        | Pending Approval |
When click 'Approve Exceptions' button and 'Approve' on cost review page for policy exception
And click 'Approve' button and 'Approve' on cost review page
And cost with title 'MPESCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'MPESCT3'
And I fill the policy exception on cost item page for cost title 'MPESCT3' and click continue:
| Exception type | Reason        | Cost implication     |
| expt4          | test exp4     | test exp4            |
And I upload following supporting documents to cost title 'MPESCT3':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
And 'Submit' the cost with title 'MPESCT3'
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'MPESCT3'
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status           |
| expt2          | test exp2 | test exp2        | Approved         |
| expt3          | test exp3 | test exp3        | Approved         |
| expt4          | test exp4 | test exp4        | Pending Approval |
When click 'Reject Exceptions' button and 'Reject' on cost review page for policy exception
Then I 'should' see following data in 'Policy Exception' section on Cost Review page:
| Exception type | Reason    | Cost implication | Status           |
| expt2          | test exp2 | test exp2        | Approved         |
| expt3          | test exp3 | test exp3        | Approved         |
| expt4          | test exp4 | test exp4        | Pending Approval |
Then I 'should' see following fields in cost stage section on cost review page:
| Stage              | Status                 |
| First Presentation | Returned to Originator |