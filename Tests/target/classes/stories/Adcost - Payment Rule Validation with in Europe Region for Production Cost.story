Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split for Video Content Type within Europe region


Scenario: Check AIPE OriginalEstimation and Final Actual payment split for target budget greater than 50k within Europe region for video content and Post Production Only
Meta:@adcost
     @paymentRules
     @aipe
!--QA-626
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | PRVERPCCT1 | PRVERPCCD1  | Aaron Royer (Grey)  | 50000                | Video        | Post Production Only | PRVERPCATN1            | Europe        | DefaultCampaign | BFO          | USD - US Dollar         | true |
And filled Cost Line Items with following fields for cost title 'PRVERPCCT1':
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVERPCCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'PRVERPCCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVERPCCT1'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Aipe' for cost title 'PRVERPCCT1'
And open cost item with title 'PRVERPCCT1' from costs overview page
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe  | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
And should see AMQ receives below request for cost title 'PRVERPCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 50000.0      | 25000.0        | USD      | 1234567890 | DefaultBrand | PRVERPCCD1  | brandDescription |
When cost with title 'PRVERPCCT1' is 'Approve' on behalf of MyPurchases application with page refresh
Then I should see AMQ receives below request for cost title 'PRVERPCCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 50000        | 25000          | USD      | 1234567890 | DefaultBrand | PRVERPCCD1  | brandDescription |
When I click 'Next Stage' button and 'Confirm' on cost review page
And add production details for cost title 'PRVERPCCT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'PRVERPCCT1':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVERPCAT1  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And fill Cost Line Items with following fields for cost title 'PRVERPCCT1':
| Audio finalization | Offline edits | Agency travel |
| 25000              | 35000         | 20000         |
And I upload following supporting documents to cost title 'PRVERPCCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVERPCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVERPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe              | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
| Original Estimate | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVERPCCT1'
Then I should see AMQ receives below request for cost title 'PRVERPCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 80000        | 0              | USD      | 1234567890 | DefaultBrand | PRVERPCCD1  | brandDescription |
When cost with title 'PRVERPCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVERPCCT1'
And I upload following supporting documents to cost title 'PRVERPCCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Supplier winning bid (budget form)         |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVERPCCT1':
| Technical Approver |
| IPMuser     |
And 'Submit' the cost with title 'PRVERPCCT1'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'PRVERPCCT1'
And on cost review page of cost item with title 'PRVERPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe              | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
| Original Estimate | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |
| Final Actual      | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |


Scenario: Check AIPE OriginalEstimation and Final Actual payment split for target budget greater than 50k within Europe region for video content and CGI Animation
Meta:@adcost
     @paymentRules
     @aipe
!--QA-625
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | PRVERPCCT2 | PRVERPCCD2  | Aaron Royer (Grey)  | 50000                | Video        | CGI/Animation   | PRVERPCATN2            | Europe        | DefaultCampaign | BFO          | USD - US Dollar         | true |
And filled Cost Line Items with following fields for cost title 'PRVERPCCT2':
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVERPCCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'PRVERPCCT2':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVERPCCT2'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Aipe' for cost title 'PRVERPCCT2'
And open cost item with title 'PRVERPCCT2' from costs overview page
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe  | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
And should see AMQ receives below request for cost title 'PRVERPCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 50000.0      | 25000.0        | USD      | 1234567890 | DefaultBrand | PRVERPCCD2  | brandDescription |
When cost with title 'PRVERPCCT2' is 'Approve' on behalf of MyPurchases application with page refresh
Then I should see AMQ receives below request for cost title 'PRVERPCCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 50000        | 25000          | USD      | 1234567890 | DefaultBrand | PRVERPCCD2  | brandDescription |
When I click 'Next Stage' button and 'Confirm' on cost review page
And add production details for cost title 'PRVERPCCT2' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'PRVERPCCT2':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVERPCAT2  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And fill Cost Line Items with following fields for cost title 'PRVERPCCT2':
| Audio finalization | Offline edits | Agency travel |
| 25000              | 35000         | 20000         |
And I upload following supporting documents to cost title 'PRVERPCCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVERPCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVERPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe              | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
| Original Estimate | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVERPCCT2'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVERPCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 80000        | 0              | USD      | 1234567890 | DefaultBrand | PRVERPCCD2  | brandDescription |
When cost with title 'PRVERPCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVERPCCT2'
And I click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'PRVERPCCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Supplier winning bid (budget form)         |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVERPCCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVERPCCT2'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'PRVERPCCT2'
And on cost review page of cost item with title 'PRVERPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe              | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
| Original Estimate | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |
| Final Actual      | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |


Scenario: Check payment split for target budget greater than 50k within Europe region for video content and CGI Animation
Meta:@adcost
     @paymentRules
!--QA-621
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVERPCCT3 | PRVERPCCD3  | Aaron Royer (Grey)  | 50000                | Video        | CGI/Animation   | PRVERPCATN3            | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVERPCCT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVERPCCT3':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVERPCAT3  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVERPCCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 30000              | 20000         | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVERPCCT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVERPCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVERPCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVERPCCT3'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVERPCCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVERPCCD3  | brandDescription |
When cost with title 'PRVERPCCT3' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVERPCCT3' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVERPCCD3  | brandDescription |
When I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVERPCCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'PRVERPCCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVERPCCT3':
| Technical Approver |
| IPMuser     |
And 'Submit' the cost with title 'PRVERPCCT3'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'PRVERPCCT3'
And on cost review page of cost item with title 'PRVERPCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
| Final Actual      | 30000.00                         | 30000.00                    | 60000.00 |


Scenario: Check payment split for target budget greater than 50k within Europe region for video content and Post Production Only
Meta:@adcost
     @paymentRules
!--QA-623
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVERPCCT4 | PRVERPCCD4  | Aaron Royer (Grey)  | 50000                | Video        | Post Production Only | PRVERPCATN4            | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVERPCCT4' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVERPCCT4':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVERPCAT4  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVERPCCT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 30000              | 20000         | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVERPCCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVERPCCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVERPCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVERPCCT4'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVERPCCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVERPCCD4  | brandDescription |
When cost with title 'PRVERPCCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVERPCCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVERPCCD4  | brandDescription |
When I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVERPCCT4'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'PRVERPCCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVERPCCT4':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVERPCCT4'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'PRVERPCCT4'
And on cost review page of cost item with title 'PRVERPCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
| Final Actual      | 30000.00                         | 30000.00                    | 60000.00 |


Scenario: Check payment split for cost line items less than 50k within Europe region for video content and CGI Animation
Meta:@adcost
     @paymentRules
!--QA-622
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVERPCCT5 | PRVERPCCD5  | Aaron Royer (Grey)  | 49000                | Video        | CGI/Animation   | PRVERPCATN5            | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVERPCCT5' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVERPCCT5':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVERPCAT5  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVERPCCT5':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 10000              | 10000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVERPCCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVERPCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVERPCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 25000.00                    | 25000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVERPCCT5'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVERPCCT5' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 25000        | 0              | USD      | 1234567890 | DefaultBrand | PRVERPCCD5  | brandDescription |
When cost with title 'PRVERPCCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVERPCCT5'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'PRVERPCCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVERPCCT5':
| Technical Approver |
| IPMuser     |
And 'Submit' the cost with title 'PRVERPCCT5'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'PRVERPCCT5'
And on cost review page of cost item with title 'PRVERPCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 25000.00                    | 25000.00 |
| Final Actual      | 0.00                             | 25000.00                    | 25000.00 |


Scenario: Check payment split for cost line items less than 50k within Europe region for video content and Post Production Only
Meta:@adcost
     @paymentRules
!--QA-624
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVERPCCT6 | PRVERPCCD6  | Aaron Royer (Grey)  | 49000                | Video        | Post Production Only | PRVERPCATN6            | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVERPCCT6' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVERPCCT6':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVERPCAT5  | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVERPCCT6':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 10000              | 10000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVERPCCT6' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVERPCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVERPCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 25000.00                    | 25000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVERPCCT6'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVERPCCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 25000        | 0              | USD      | 1234567890 | DefaultBrand | PRVERPCCD6  | brandDescription |
When cost with title 'PRVERPCCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVERPCCT6'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'PRVERPCCT6':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVERPCCT6':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVERPCCT6'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'PRVERPCCT6'
And on cost review page of cost item with title 'PRVERPCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 25000.00                    | 25000.00 |
| Final Actual      | 0.00                             | 25000.00                    | 25000.00 |