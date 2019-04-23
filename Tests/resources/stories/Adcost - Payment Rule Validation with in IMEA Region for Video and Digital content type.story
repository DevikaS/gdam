Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split for IMEA region for Video and Digital Content Type


Scenario: Check AIPE OriginalEstimation and FinalActual payment split for target budget greater than 50k within IMEA region for video and Post Production only
Meta:@adcost
     @paymentRules
     @aipe
!--QA-685, rule no-108
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | PRVIRVDCTCT1 | PRVIRVDCTCD1 | Aaron Royer (Grey)  | 50000                | Video        | Post Production Only | PRVIRVDCTATN1          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | true |
And filled Cost Line Items with following fields for cost title 'PRVIRVDCTCT1':
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRVDCTCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'PRVIRVDCTCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVIRVDCTCT1'
And I am on cost review page of cost item with title 'PRVIRVDCTCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe  | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
And should see AMQ receives below request for cost title 'PRVIRVDCTCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 50000.0      | 25000.0        | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD1 | brandDescription |
When cost with title 'PRVIRVDCTCT1' is 'Approve' on behalf of MyPurchases application with page refresh
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 50000        | 25000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD1 | brandDescription |
When I click 'Next Stage' button and 'Confirm' on cost review page
And add production details for cost title 'PRVIRVDCTCT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'PRVIRVDCTCT1':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRVDCTAT1 | 10:10:10          | Version | Tv               | 10/11/2018               | HD         | Yes      | Yes       | JAPAN   |
And fill Cost Line Items with following fields for cost title 'PRVIRVDCTCT1':
| Audio finalization | Offline edits | P&G insurance |
| 25000              | 35000         | 20000         |
And I upload following supporting documents to cost title 'PRVIRVDCTCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVIRVDCTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRVDCTCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRVDCTCT1'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 80000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD1 | brandDescription |
When cost with title 'PRVIRVDCTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRVDCTCT1'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVIRVDCTCT1':
| Audio finalization | Offline edits | P&G insurance |
| 35000              | 35000         | 30000         |
And I upload following supporting documents to cost title 'PRVIRVDCTCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Supplier winning bid (budget form)         |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVIRVDCTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PRVIRVDCTCT1'
And I am on cost review page of cost item with title 'PRVIRVDCTCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Final Actual | 25000.00            | 0.00                             | 75000.00                    | 100000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRVDCTCT1'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 100000       | 75000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD1 | brandDescription |
When cost with title 'PRVIRVDCTCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 100000       | 75000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD1 | brandDescription |


Scenario: Check payment split for cost less than 50k within IMEA region for video content type and Post Production Only
Meta:@adcost
     @paymentRules
!--QA-685, rule no-103
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRVDCTCT2 | PRVIRVDCTCD2 | Aaron Royer (Grey)  | 49000                | Video        | Post Production Only | PRVIRVDCTATN2          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVIRVDCTCT2' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVIRVDCTCT2':
| Initiative | Asset Title   | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRVDCTATN2 | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVIRVDCTCT2':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 10000              | 10000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRVDCTCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'PRVIRVDCTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVIRVDCTCT2'
And on cost review page of cost item with title 'PRVIRVDCTCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 25000.00                    | 25000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVIRVDCTCT2'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 25000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD2 | brandDescription |
When cost with title 'PRVIRVDCTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVIRVDCTCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVIRVDCTCT2' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVIRVDCTCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVIRVDCTCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVIRVDCTCT2'
And on cost review page of cost item with title 'PRVIRVDCTCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 25000.00                    | 25000.00 |
| Final Actual      | 0.00                             | 25000.00                    | 25000.00 |


Scenario: Check payment split for cost less than 50k within IMEA region for video content type and CGI Animation
Meta:@adcost
     @paymentRules
!--QA-685, rule no-101
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRVDCTCT3 | PRVIRVDCTCD3 | Aaron Royer (Grey)  | 49000                | Video        | CGI/Animation   | PRVIRVDCTATN3          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVIRVDCTCT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVIRVDCTCT3':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRVDCTAT3 | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVIRVDCTCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 10000              | 10000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRVDCTCT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRVDCTCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVIRVDCTCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 25000.00                    | 25000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVIRVDCTCT3'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 25000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD3 | brandDescription |
When cost with title 'PRVIRVDCTCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVIRVDCTCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVIRVDCTCT3' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVIRVDCTCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVIRVDCTCT3':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVIRVDCTCT3'
And on cost review page of cost item with title 'PRVIRVDCTCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 25000.00                    | 25000.00 |
| Final Actual      | 0.00                             | 25000.00                    | 25000.00 |

Scenario: Check payment split for cost greater than 50k within IMEA region for video content type and Post Production Only
Meta:@adcost
     @paymentRules
!--QA-685, rule no-102
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRVDCTCT4 | PRVIRVDCTCD4 | Aaron Royer (Grey)  | 50000                | Video        | Post Production Only | PRVIRVDCTATN4          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVIRVDCTCT4' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVIRVDCTCT4':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRVDCTAT4 | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVIRVDCTCT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 30000              | 20000         | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRVDCTCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRVDCTCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVIRVDCTCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVIRVDCTCT4'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD4 | brandDescription |
When cost with title 'PRVIRVDCTCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD4 | brandDescription |
When I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVIRVDCTCT4'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVIRVDCTCT4':
| Audio finalization | Offline edits | Agency travel|
| 5000               | 10000         | 5000         |
And I upload following supporting documents to cost title 'PRVIRVDCTCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVIRVDCTCT4':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVIRVDCTCT4'
And on cost review page of cost item with title 'PRVIRVDCTCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 30000.00                         | -10000.00                   | 20000.00 |


Scenario: Check payment split for cost greater than 50k within IMEA region for video content type and CGI Animation
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-685, rule no-100
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRVDCTCT5 | PRVIRVDCTCD5 | Aaron Royer (Grey)  | 50000                | Video        | CGI/Animation   | PRVIRVDCTATN5          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVIRVDCTCT5' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVIRVDCTCT5':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRVDCTAT5 | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVIRVDCTCT5':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 30000              | 20000         | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRVDCTCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRVDCTCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVIRVDCTCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVIRVDCTCT5'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT5' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD5 | brandDescription |
When cost with title 'PRVIRVDCTCT5' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT5' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD5 | brandDescription |
When I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVIRVDCTCT5'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVIRVDCTCT5':
| Audio finalization | Offline edits | Agency travel|
| 5000               | 10000         | 5000         |
And I upload following supporting documents to cost title 'PRVIRVDCTCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVIRVDCTCT5':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVIRVDCTCT5'
And on cost review page of cost item with title 'PRVIRVDCTCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 30000.00                         | -10000.00                   | 20000.00 |


Scenario: Check AIPE OriginalEstimation and FinalActual payment split for target budget greater than 50k within IMEA region for Digital and Post Production Only
Meta:@adcost
     @paymentRules
     @aipe
!--QA-685, rule no -107, bug-ADC-1748
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type        | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | PRVIRVDCTCT6 | PRVIRVDCTCD6 | Aaron Royer (Grey)  | 50000                | Digital Development | Post Production Only | PRVIRVDCTATN6          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | true |
And filled Cost Line Items with following fields for cost title 'PRVIRVDCTCT6':
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRVDCTCT6':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'PRVIRVDCTCT6':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVIRVDCTCT6'
And I am on cost review page of cost item with title 'PRVIRVDCTCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe  | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
And should see AMQ receives below request for cost title 'PRVIRVDCTCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 50000.0      | 25000.0        | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD6 | brandDescription |
When cost with title 'PRVIRVDCTCT6' is 'Approve' on behalf of MyPurchases application with page refresh
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT6' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 50000        | 25000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD6 | brandDescription |
When I click 'Next Stage' button and 'Confirm' on cost review page
And add production details for cost title 'PRVIRVDCTCT6' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And add expected asset details for cost title 'PRVIRVDCTCT6':
| Initiative | Asset Title  | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRVDCTAT6 | Tv               | 12/12/2017               | Yes      | Yes       | Japan   |
And fill Cost Line Items with following fields for cost title 'PRVIRVDCTCT6':
| Adaptation   | Virtual Reality | P&G insurance |
| 25000        | 35000           | 20000         |
And I upload following supporting documents to cost title 'PRVIRVDCTCT6' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVIRVDCTCT6':
| Technical Approver |
| IPMuser   |
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRVDCTCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRVDCTCT6'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 80000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD6 | brandDescription |
When cost with title 'PRVIRVDCTCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRVDCTCT6'
And I click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVIRVDCTCT6' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVIRVDCTCT6':
| FileName            | FormName                                   |
| /files/EditWord.doc | Supplier winning bid (budget form)         |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVIRVDCTCT6':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVIRVDCTCT6'
And I am on cost review page of cost item with title 'PRVIRVDCTCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |


Scenario: Check payment split for cost greater than 50k within IMEA region for Digital type
Meta:@adcost
     @paymentRules
!--QA-685, rule no-90
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRVDCTCT7 | PRVIRVDCTCD7 | Aaron Royer (Grey)  | 50000                | Digital Development | PRVIRVDCTATN7          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVIRVDCTCT7' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'PRVIRVDCTCT7':
| Initiative | Asset Title  | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRVDCTAT7 | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PRVIRVDCTCT7':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000        | 20000           | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRVDCTCT7' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRVDCTCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRVDCTCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRVDCTCT7'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT7' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD7 | brandDescription |
When cost with title 'PRVIRVDCTCT7' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT7' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD7 | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRVDCTCT7'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVIRVDCTCT7' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVIRVDCTCT7':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVIRVDCTCT7':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVIRVDCTCT7'
And I am on cost review page of cost item with title 'PRVIRVDCTCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 30000.00                         | 30000.00                    | 60000.00 |


Scenario: Check payment split for cost less than 50k within IMEA region for Digital type
Meta:@adcost
     @paymentRules
     @GLMGCcodes
!--QA-685, rule no-91, QA-812
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRVDCTCT8 | PRVIRVDCTCD8 | Aaron Royer (Grey)  | 10000                | Digital Development | PRVIRVDCTATN8          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVIRVDCTCT8' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'PRVIRVDCTCT8':
| Initiative | Asset Title  | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRVDCTAT8 | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PRVIRVDCTCT8':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 10000        | 20000           | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRVDCTCT8' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRVDCTCT8':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRVDCTCT8'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRVDCTCT8'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT8' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      | CategoryId | Gl       |
| 40000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD8 | brandDescription | S821018AU  | 33500001 |
When cost with title 'PRVIRVDCTCT8' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRVDCTCT8'
And click 'Next Stage' button and 'Confirm' on cost review page
And I am on expected assets page of cost title 'PRVIRVDCTCT8'
And add expected asset details for cost title 'PRVIRVDCTCT8':
| Initiative | Asset Title   | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRVDCTAT8A | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And fill Cost Line Items with following fields for cost title 'PRVIRVDCTCT8':
| Adaptation   |
| 20000        |
And I upload following supporting documents to cost title 'PRVIRVDCTCT8':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'PRVIRVDCTCT8'
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVIRVDCTCT8'
And I am on cost review page of cost item with title 'PRVIRVDCTCT8'
Then I should see AMQ receives below request for cost title 'PRVIRVDCTCT8' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      | CategoryId | Gl       |
| 50000        | 50000          | USD      | 1234567890 | DefaultBrand | PRVIRVDCTCD8 | brandDescription | S821018AU  | 33500001 |
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 50000.00                    | 50000.00 |