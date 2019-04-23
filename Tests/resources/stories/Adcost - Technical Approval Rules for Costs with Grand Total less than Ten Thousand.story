Feature: Approvals Behaviour for Cost Total less than Ten Thousand
Narrative:
In order to
As a CostOwner
I want to check Technical Approver Rules for Cost Total less than Ten Thousand


Scenario: Check Technical Approver not displayed throughout lifecycle when Cost total for buyout cost is less than Ten Thousand
Meta:@adcost
!--QA-836
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number    | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject| true | OriginalEstimate              | Athletes  | Buyout                | CGTLTTTCT1 | CGTLTTCD1   | Lily Ross (Publicis) | CGTLTTATN1             | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CGTLTTTCT1' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 9000           |
And added negotiated terms page for cost title 'CGTLTTTCT1' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CGTLTTTCT1'
When I fill Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 4000              | 4000                       | 1234567890                        |
And I upload following supporting documents to cost title 'CGTLTTTCT1' and click continue:
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
Then 'should not' see 'technical' approver section on cost approval page
When add below approvers for cost title 'CGTLTTTCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'Submit' the cost with title 'CGTLTTTCT1'
And cost with title 'CGTLTTTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'CreateRevision' the cost with title 'CGTLTTTCT1'
And I add cost item details for cost title 'CGTLTTTCT1' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 4000              | 5000                       |
And I upload following supporting documents to cost title 'CGTLTTTCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
Then 'should not' see 'technical' approver section on cost approval page
When I 'Submit' the cost with title 'CGTLTTTCT1'
And cost with title 'CGTLTTTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'CGTLTTTCT1'
And I upload following supporting documents to cost title 'CGTLTTTCT1':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
Then 'should not' see 'technical' approver section on cost approval page


Scenario: Check Technical Approver not displayed throughout lifecycle when Cost total for production cost is less than Ten Thousand
Meta:@adcost
!--QA-836
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CGTLTTTCT2 | CGTLTTTD2   | Aaron Royer (Grey)  | 9000                 | Video        | Full Production | CGTLTTTATN2            | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CGTLTTTCT2' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CGTLTTTCT2':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CGTLTTTAT1  | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
When fill Cost Line Items with following fields for cost title 'CGTLTTTCT2':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 5000               | 2000          | 2000          | 1234567890                        |
And upload following supporting documents to cost title 'CGTLTTTCT2' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
Then 'should not' see 'technical' approver section on cost approval page
When add below approvers for cost title 'CGTLTTTCT2':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And refresh the page without delay
And I click 'Submit' button and 'Send for approval' on approval Page
And cost with title 'CGTLTTTCT2' is 'Approve' on behalf of MyPurchases application
And I am on cost review page of cost item with title 'CGTLTTTCT2'
And 'CreateRevision' the cost with title 'CGTLTTTCT2'
And I add cost item details for cost title 'CGTLTTTCT2' with 'USD' currency:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 4000               | 3000          | 2500          | 1234567890                        |
And I am on supporting documents of cost title 'CGTLTTTCT2'
And I upload following supporting documents to cost title 'CGTLTTTCT2' and click continue:
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
Then 'should not' see 'technical' approver section on cost approval page
When 'Submit' the cost with title 'CGTLTTTCT2'
And cost with title 'CGTLTTTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'CGTLTTTCT2'
And I am on supporting documents of cost title 'CGTLTTTCT2'
And I upload following supporting documents to cost title 'CGTLTTTCT2' and click continue:
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
Then 'should not' see 'technical' approver section on cost approval page
When 'Submit' the cost with title 'CGTLTTTCT2'
And cost with title 'CGTLTTTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'CGTLTTTCT2'
And I add cost item details for cost title 'CGTLTTTCT2' with 'USD' currency:
| Talent fees | Offline edits |
| 500         | 2500          |
And I am on supporting documents of cost title 'CGTLTTTCT2'
And I upload following supporting documents to cost title 'CGTLTTTCT2' and click continue:
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
Then 'should not' see 'technical' approver section on cost approval page
When 'Submit' the cost with title 'CGTLTTTCT2'
And login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CGTLTTTCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And I am on supporting documents of cost title 'CGTLTTTCT2'
And I upload following supporting documents to cost title 'CGTLTTTCT2' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
Then 'should not' see 'technical' approver section on cost approval page


Scenario: Check technical approver is not available when cost total is changed from greater than ten thousand to less than ten thousand
Meta:@adcost
!--QA-836
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CGTLTTTCT3 | CGTLTTTD3   | Aaron Royer (Grey)  | 9000                 | Video        | CGI/Animation   | CGTLTTTATN3            | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CGTLTTTCT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CGTLTTTCT3':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CGTLTTTAT2  | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
When fill Cost Line Items with following fields for cost title 'CGTLTTTCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 9000               | 8000          | 9000          | 1234567890                        |
And upload following supporting documents to cost title 'CGTLTTTCT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
Then 'should' see 'technical' approver section on cost approval page
When add below approvers for cost title 'CGTLTTTCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CGTLTTTCT3'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CGTLTTTCT3'
And cost with title 'CGTLTTTCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'CGTLTTTCT3'
And fill Cost Line Items with following fields for cost title 'CGTLTTTCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 5000               | 3000          | 1000          | 1234567890                        |
And I upload following supporting documents to cost title 'CGTLTTTCT3' and click continue:
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
Then 'should not' see 'technical' approver section on cost approval page
And 'should not' see 'brand' approver section on cost approval page