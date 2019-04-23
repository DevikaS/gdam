Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split within Latin America region


Scenario: Check payment split for cost greater than zero within Latin America region for audio and full Production
Meta:@adcost
     @paymentRules
!--QA-703
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVLARPCCT1 | PRVLARPCCD1 | Aaron Royer (Grey)  | 60000                | Audio        | Full Production | PRVLARPCATN1           | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVLARPCCT1' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'PRVLARPCCT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan   | PRVLARPCAT1 | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'PRVLARPCCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVLARPCCT1' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And filled below approvers for cost title 'PRVLARPCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVLARPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVLARPCCT1'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVLARPCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description |
| 80000        | 40000          | USD      | 1234567890 | DefaultBrand | PRVLARPCCD1 |
When cost with title 'PRVLARPCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVLARPCCT1'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVLARPCCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 35000                 | 35000         | 30000       | 1234567890                        |
And I upload following supporting documents to cost title 'PRVLARPCCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'PRVLARPCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PRVLARPCCT1'
And on cost review page of cost item with title 'PRVLARPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 40000.00                         | 40000.00                    | 80000.00  |
| Final Actual      | 40000.00                         | 60000.00                    | 100000.00 |


Scenario: Check payment split for cost more than zero within Latin America region for Digital type
Meta:@adcost
     @paymentRules
!--QA-703
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVLARPCCT2 | PRVLARPCCD2 | Aaron Royer (Grey)  | 10000                | Digital Development | PRVLARPCATN2           | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVLARPCCT2' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'PRVLARPCCT2':
| Initiative | Asset Title | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVLARPCAT2 | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PRVLARPCCT2':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 2000       | 8000            | 2000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVLARPCCT2' and click continue:
| FileName            | FormName                           |
| /files/EditPPT.ppt  | Supplier winning bid (budget form) |
| /files/GWGTest2.pdf | P&G Communication Brief            |
And filled below approvers for cost title 'PRVLARPCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVLARPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 6000.00                          | 6000.00                     | 12000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVLARPCCT2'
And click 'Approve' button and 'Approve' on cost review page
And cost with title 'PRVLARPCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVLARPCCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVLARPCCT2' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVLARPCCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVLARPCCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVLARPCCT2'
And on cost review page of cost item with title 'PRVLARPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 6000.00                          | 6000.00                     | 12000.00 |
| Final Actual      | 6000.00                          | 6000.00                     | 12000.00 |


Scenario: Check payment split for cost greater than zero within Latin America region for Still image and post production only
Meta:@adcost
     @paymentRules
!--QA-703
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVLARPCCT3 | PRVLARPCCD3 | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | PRVLARPCATN3           | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And filled Expected Assets form with following fields:
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVLARPCAT3 | Version | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields:
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000                  | 20000      | 10000            | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVLARPCCT3' and click continue:
| FileName                | FormName                           |
| /files/perfromance.xlsx | Supplier winning bid (budget form) |
| /files/usage.docx       | P&G Communication Brief            |
And filled below approvers for cost title 'PRVLARPCCT3':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVLARPCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 20000.00                         | 20000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVLARPCCT3'
And click 'Approve' button and 'Approve' on cost review page
And cost with title 'PRVLARPCCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVLARPCCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVLARPCCT3':
| Agency Artwork / Packs | Retouching  | FX (Loss) & Gain |
| 5000                   | 20000       | 5000             |
And I upload following supporting documents to cost title 'PRVLARPCCT3' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVLARPCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 20000.00                         | 20000.00                    | 40000.00 |
| Final Actual      | 20000.00                         | 10000.00                    | 30000.00 |


Scenario: Check payment split for cost more than zero within Latin America region for Video content type and CGI Animation
Meta:@adcost
     @paymentRules
!--QA-703
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVLARPCCT4 | PRVLARPCCD4 | Aaron Royer (Grey)  | 55000                | Video        | CGI/Animation   | PRVLARPCATN4           | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVLARPCCT4' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVLARPCCT4':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVLARPCAT4 | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PRVLARPCCT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVLARPCCT4' and click continue:
| FileName                                   | FormName                            |
| /files/919.xls                             | Supplier winning bid (budget form)  |
| /files/Audio - All - Summary Only (3).xlsx | P&G Communication Brief             |
And filled below approvers for cost title 'PRVLARPCCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVLARPCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 32500.00                         | 32500.00                    | 65000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVLARPCCT4'
And click 'Approve' button and 'Approve' on cost review page
And cost with title 'PRVLARPCCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVLARPCCT4'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVLARPCCT4' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVLARPCCT4':
| FileName            | FormName                                   |
| /files/filetext.txt | Final (online) version approval from brand |
And add below approvers for cost title 'PRVLARPCCT4':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVLARPCCT4'
And on cost review page of cost item with title 'PRVLARPCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 32500.00                         | 32500.00                    | 65000.00 |
| Final Actual      | 32500.00                         | 32500.00                    | 65000.00 |