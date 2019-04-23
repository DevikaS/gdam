Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split for AIPE within AAK region


Scenario: Check AIPE OriginalEstimation and FinalActual payment split for target budget greater than 50k within AAK region for CGI Animation
Meta:@adcost
     @paymentRules
     @aipe
!--QA-618 (From Matt on 19-Oct: AIPE is NOT being tested in UAT and is likely to be turned off on the cost module, so please don't bother testing AIPE at the moment)
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | PRVARPCCT1 | PRVARPCCD1  | Aaron Royer (Grey)  | 50000                | Video        | CGI/Animation   | PRVARPCATN1            | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | true |
And filled Cost Line Items with following fields for cost title 'PRVARPCCT1':
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVARPCCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'PRVARPCCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVARPCCT1'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Aipe' for cost title 'PRVARPCCT1'
And open cost item with title 'PRVARPCCT1' from costs overview page
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe  | 0.00                | 25000.00                         | 25000.00                    | 50000.00 |
And should see AMQ receives below request for cost title 'PRVARPCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 50000.0      | 0.0            | USD      | 1234567890 | DefaultBrand | PRVARPCCD1  | brandDescription |
When cost with title 'PRVARPCCT1' is 'Approve' on behalf of MyPurchases application with page refresh
And click 'Next Stage' button and 'Confirm' on cost review page
And add production details for cost title 'PRVARPCCT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'PRVARPCCT1':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVARPCAT1  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And fill Cost Line Items with following fields for cost title 'PRVARPCCT1':
| Audio finalization | Offline edits | Agency travel |
| 25000              | 35000         | 20000         |
And upload following supporting documents to cost title 'PRVARPCCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVARPCCT1':
| Technical Approver |
| IPMuser            |
And click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVARPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe              | 0.00                | 25000.00                         | 25000.00                    | 50000.00 |
| Original Estimate | 0.00                | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'   
And on cost review page of cost item with title 'PRVARPCCT1'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVARPCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 80000        | 40000          | USD      | 1234567890 | DefaultBrand | PRVARPCCD1  | brandDescription |
When cost with title 'PRVARPCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVARPCCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And upload following supporting documents to cost title 'PRVARPCCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Supplier winning bid (budget form)         |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVARPCCT1':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVARPCCT1'
And on cost review page of cost item with title 'PRVARPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe              | 0.00                | 25000.00                         | 25000.00                    | 50000.00 |
| Original Estimate | 0.00                | 40000.00                         | 40000.00                    | 80000.00 |
| Final Actual      | 0.00                | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVARPCCT1'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVARPCCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 80000        | 40000          | USD      | 1234567890 | DefaultBrand | PRVARPCCD1  | brandDescription |


Scenario: Check AIPE OriginalEstimation and Final Actual payment split for target budget greater than 50k within AAK region for Post Production Only
Meta:@adcost
     @paymentRules
     @aipe
!--QA-627 (From Matt on 19-Oct: AIPE is NOT being tested in UAT and is likely to be turned off on the cost module, so please don't bother testing AIPE at the moment)
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | PRVARPCCT2 | PRVARPCCD2  | Aaron Royer (Grey)  | 50000                | Video        | Post Production Only | PRVARPCATN2            | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | true |
And filled Cost Line Items with following fields for cost title 'PRVARPCCT2':
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVARPCCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'PRVARPCCT2':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVARPCCT2'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Aipe' for cost title 'PRVARPCCT1'
And open cost item with title 'PRVARPCCT2' from costs overview page
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe  | 0.00                | 25000.00                         | 25000.00                    | 50000.00 |
And should see AMQ receives below request for cost title 'PRVARPCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 50000.0      | 0.0            | USD      | 1234567890 | DefaultBrand | PRVARPCCD2  | brandDescription |
When cost with title 'PRVARPCCT2' is 'Approve' on behalf of MyPurchases application with page refresh
And I click 'Next Stage' button and 'Confirm' on cost review page
And add production details for cost title 'PRVARPCCT2' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'PRVARPCCT2':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVARPCAT2  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And fill Cost Line Items with following fields for cost title 'PRVARPCCT2':
| Audio finalization | Offline edits | Agency travel |
| 25000              | 35000         | 20000         |
And I upload following supporting documents to cost title 'PRVARPCCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVARPCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And open cost item with title 'PRVARPCCT2' from costs overview page
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe              | 0.00                | 25000.00                         | 25000.00                    | 50000.00 |
| Original Estimate | 0.00                | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVARPCCT2'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVARPCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 80000        | 40000          | USD      | 1234567890 | DefaultBrand | PRVARPCCD2  | brandDescription |
When cost with title 'PRVARPCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVARPCCT2'
And I click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'PRVARPCCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Supplier winning bid (budget form)         |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVARPCCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVARPCCT2'
And open cost item with title 'PRVARPCCT2' from costs overview page
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe              | 0.00                | 25000.00                         | 25000.00                    | 50000.00 |
| Original Estimate | 0.00                | 40000.00                         | 40000.00                    | 80000.00 |
| Final Actual      | 0.00                | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVARPCCT2'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVARPCCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 80000        | 40000          | USD      | 1234567890 | DefaultBrand | PRVARPCCD2  | brandDescription |


Scenario: Check payment split for cost line items less than 50k within AAK region for CGI Animation
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-619
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVARPCCT3 | PRVARPCCD3  | Aaron Royer (Grey)  | 49000                | Video        | CGI/Animation   | PRVARPCATN3            | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'PRVARPCCT3':
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVARPCCT3':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVARPCAT3  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVARPCCT3':
| Audio finalization | Offline edits | Agency travel | FX (Loss) & Gain  | Please enter a 10-digit IO number |
| 1000               | 1000          | 40000         | -1000             | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVARPCCT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVARPCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And open cost item with title 'PRVARPCCT3' from costs overview page
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 41000.00                    | 41000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVARPCCT3'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVARPCCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 41000        | 0              | USD      | 1234567890 | DefaultBrand | PRVARPCCD3  | brandDescription |
When cost with title 'PRVARPCCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVARPCCT3'
And I upload following supporting documents to cost title 'PRVARPCCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'PRVARPCCT3'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'PRVARPCCT3'
And on cost review page of cost item with title 'PRVARPCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 41000.00                    | 41000.00 |
| Final Actual      | 0.00                             | 41000.00                    | 41000.00 |


Scenario: Check payment split for cost line items less than 50k within AAK region for Post Production Only
Meta:@adcost
     @paymentRules
!--QA-620
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVARPCCT4 | PRVARPCCD4  | Aaron Royer (Grey)  | 49000                | Video        | Post Production Only | PRVARPCATN4            | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVARPCCT4' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And filled Expected Assets form with following details for cost title 'PRVARPCCT4':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVARPCAT4  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 1000               | 1000          | 40000         | 1234567890                        |
And I uploaded following supporting documents via UI to cost title 'PRVARPCCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'PRVARPCCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'PRVARPCCT4'
And open cost item with title 'PRVARPCCT4' from costs overview page
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 42000.00                    | 42000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVARPCCT4'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVARPCCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 42000        | 0              | USD      | 1234567890 | DefaultBrand | PRVARPCCD4  | brandDescription |
When cost with title 'PRVARPCCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVARPCCT4'
And I am on supporting documents of cost title 'PRVARPCCT4'
And I upload following supporting documents via UI to cost title 'PRVARPCCT4' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVARPCCT4':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVARPCCT4'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'PRVARPCCT4'
And on cost review page of cost item with title 'PRVARPCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 42000.00                    | 42000.00 |
| Final Actual      | 0.00                             | 42000.00                    | 42000.00 |