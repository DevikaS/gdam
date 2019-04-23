Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split for IMEA region for StillImage and Audio Content Type


Scenario: Check AIPE OriginalEstimation and FinalActual payment split for target budget greater than 50k within IMEA region for still image and Post Production Only
Meta:@adcost
     @paymentRules
     @aipe
!--QA-685, rule no -106
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | PRVIRSACTCT1 | PRVIRSACTCD1 | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only | PRVIRSACTATN1          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | true |
And I filled Cost Line Items with following fields:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRSACTCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRSACTCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVIRSACTCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe  | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
And should see AMQ receives below request for cost title 'PRVIRSACTCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 50000.0      | 25000.0        | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD1 | brandDescription |
When cost with title 'PRVIRSACTCT1' is 'Approve' on behalf of MyPurchases application with page refresh
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 50000        | 25000          | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD1 | brandDescription |
When I click 'Next Stage' button and 'Confirm' on cost review page
And fill Production Details with following fields for cost title 'PRVIRSACTCT1':
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And fill Expected Assets form with following fields:
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRSACTAT1 | Version | Digital          | 12/12/2017               | Yes      | Yes       | JAPAN   |
And fill Cost Line Items with following fields:
| Mark up (if applicable) | Agency Artwork / Packs | Retouching |
| 25000                   | 35000                  | 20000      |
And I upload following supporting documents to cost title 'PRVIRSACTCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVIRSACTCT1':
| Technical Approver | Brand Management Approver        |
| IPMuser   | BrandManagementApprover |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVIRSACTCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRSACTCT1'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 80000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD1 | brandDescription |
When cost with title 'PRVIRSACTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRSACTCT1'
And I click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'PRVIRSACTCT1' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Supplier winning bid (budget form)         |
| /files/EditWord.doc | Final (online) version approval from brand |
And I fill below approvers for cost title 'PRVIRSACTCT1':
| Technical Approver |
| IPMuser            |
And I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVIRSACTCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |


Scenario: Check AIPE OriginalEstimation and FinalActual payment split for target budget greater than 50k within IMEA region for audio and Post Production Only
Meta:@adcost
     @paymentRules
     @aipe
!--QA-685, rule no -105
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | PRVIRSACTCT2 | PRVIRSACTCD2 | Aaron Royer (Grey)  | 50000                | Audio        | Post Production Only | PRVIRSACTATN2          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | true |
And I filled Cost Line Items with following fields:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRSACTCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRSACTCT2':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe  | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
And should see AMQ receives below request for cost title 'PRVIRSACTCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 50000.0      | 25000.0        | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD2 | brandDescription |
When cost with title 'PRVIRSACTCT2' is 'Approve' on behalf of MyPurchases application with page refresh
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 50000        | 25000          | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD2 | brandDescription |
When I click 'Next Stage' button and 'Confirm' on cost review page
And fill Production Details with following fields for cost title 'PRVIRSACTCT2':
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And fill Expected Assets form with following fields:
| Initiative | Country | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan   | PRVIRSACTAT2 | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And fill Cost Line Items with following fields:
| VO recording sessions | P&G insurance | Talent fees |
| 25000                 | 35000         | 20000       |
And I upload following supporting documents to cost title 'PRVIRSACTCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVIRSACTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRSACTCT2'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 80000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD2 | brandDescription |
When cost with title 'PRVIRSACTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRSACTCT2'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVIRSACTCT2':
| VO recording sessions | P&G insurance | Talent fees   |
| 35000                 | 35000         | 30000         |
And I upload following supporting documents to cost title 'PRVIRSACTCT2' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Supplier winning bid (budget form)         |
| /files/EditWord.doc | Final (online) version approval from brand |
And I fill below approvers for cost title 'PRVIRSACTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Final Actual | 25000.00            | 0.00                             | 75000.00                    | 100000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRSACTCT2'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 100000       | 75000          | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD2 | brandDescription |
When cost with title 'PRVIRSACTCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 100000       | 75000          | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD2 | brandDescription |


Scenario: Check AIPE OriginalEstimation and FinalActual payment split for target budget greater than 50k within IMEA region for audio and full Production
Meta:@adcost
     @paymentRules
     @aipe
!--QA-685, rule no -104, bug-ADC-1763
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | PRVIRSACTCT3 | PRVIRSACTCD3 | Aaron Royer (Grey)  | 50000                | Audio        | Full Production | PRVIRSACTATN3          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | true |
And I filled Cost Line Items with following fields:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRSACTCT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRSACTCT3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Aipe  | 25000.00            | 0.00                             | 25000.00                    | 50000.00 |
When cost with title 'PRVIRSACTCT3' is 'Approve' on behalf of MyPurchases application with page refresh
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Production Details with following fields for cost title 'PRVIRSACTCT3':
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And fill Expected Assets form with following fields:
| Initiative | Country | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan   | PRVIRSACTAT3 | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And fill Cost Line Items with following fields:
| VO recording sessions | P&G insurance | Talent fees |
| 25000                 | 35000         | 20000       |
And I upload following supporting documents to cost title 'PRVIRSACTCT3' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And fill below approvers for cost title 'PRVIRSACTCT3':
| Technical Approver |
| IPMuser            |
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 25000.00            | 0.00                             | 55000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRSACTCT3'
And I click 'Approve' button and 'Approve' on cost review page
When cost with title 'PRVIRSACTCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRSACTCT3'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVIRSACTCT3':
| VO recording sessions | P&G insurance | Talent fees |
| 35000                 | 35000         | 30000       |
And I upload following supporting documents to cost title 'PRVIRSACTCT3' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Supplier winning bid (budget form)         |
| /files/EditWord.doc | Final (online) version approval from brand |
And I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Aipe payment amount | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Final Actual | 25000.00            | 0.00                             | 75000.00                    | 100000.00 |


Scenario: Check payment split for cost less than 50k within IMEA region for Audio and Post Production Only
Meta:@adcost
     @paymentRules
!--QA-685, rule no-86
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRSACTCT4 | PRVIRSACTCD4 | Aaron Royer (Grey)  | 40000                | Audio        | Post Production Only | PRVIRSACTATN4          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'PRVIRSACTCT4':
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And filled Expected Assets form with following fields:
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | PRVIRSACTAT4 | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields:
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRSACTCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRSACTCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRSACTCT4'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 30000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD4 | brandDescription |
When cost with title 'PRVIRSACTCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'PRVIRSACTCT4'
And I am on supporting documents of cost title 'PRVIRSACTCT4'
And I upload following supporting documents to cost title 'PRVIRSACTCT4' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost less than 50k within IMEA region for Still image and post production only
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-685, rule no-99
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRSACTCT5 | PRVIRSACTCD5 | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | PRVIRSACTATN5          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And filled Expected Assets form with following fields:
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRSACTAT5 | Version | Digital          | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields:
| Agency Artwork / Packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000                | 20000       | 10000              | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRSACTCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVIRSACTCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRSACTCT5'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT5' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 40000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD5 | brandDescription |
When cost with title 'PRVIRSACTCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRSACTCT5'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVIRSACTCT5':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain |
| 5000                 | 20000      | 5000               |
And I upload following supporting documents to cost title 'PRVIRSACTCT5' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than 50k within IMEA region for Still image and post production only
Meta:@adcost
     @paymentRules
!--QA-685, rule no-98, QA-1062
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRSACTCT6 | PRVIRSACTCD8 | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only | PRVIRSACTATN6          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Production Details with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
Then I 'should' see fields contains following values on ExpectedAssets form page for cost title 'PRVIRSACTCT6':
| Media/Touchpoint                                                                              |
| not for air;N/A;In-store;Direct to consumer;PR/Influencer;streaming audio;Out of home;Digital |
When I fill Expected Assets form with following fields:
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVIRSACTAT6 | Version | Digital          | 12/12/2017               | Yes      | Yes       | JAPAN   |
And fill Cost Line Items with following fields:
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 30000                | 20000      | 10000              | 1234567890                        |
And I upload following supporting documents to cost title 'PRVIRSACTCT6' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVIRSACTCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRSACTCT6'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD6 | brandDescription |
When cost with title 'PRVIRSACTCT6' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT6' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD6 | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRSACTCT6'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVIRSACTCT6':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain |
| 20000                | 20000      | 10000              |
And I upload following supporting documents to cost title 'PRVIRSACTCT6' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 30000.00                         | 20000.00                    | 50000.00 |


Scenario: Check payment split for cost greater than 50k within IMEA region for Audio and Post Production Only
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-685, rule no-85, QA-1062
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And I created a new 'production' cost with following CostDetails:
| Project Number   | Cost Title   | Description    | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVIRSACTCT7 | PRVIRSACTCD7 | Aaron Royer (Grey)  | 50000                | Audio        | Post Production Only | PRVIRSACTATN7          | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Production Details with following fields for cost title 'PRVIRSACTCT7':
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
Then I 'should' see fields contains following values on ExpectedAssets form page for cost title 'PRVIRSACTCT7':
| Media/Touchpoint                                                                                        |
| not for air;N/A;In-store;Direct to consumer;PR/Influencer;streaming audio;Out of home;Cinema;Digital;Tv |
When I fill Expected Assets form with following fields:
| Initiative | Country | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan   | PRVIRSACTAT7 | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And fill Cost Line Items with following fields:
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I upload following supporting documents to cost title 'PRVIRSACTCT7' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVIRSACTCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVIRSACTCT7'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT7' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 80000        | 40000          | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD7 | brandDescription |
When cost with title 'PRVIRSACTCT7' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVIRSACTCT7' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 80000        | 40000          | USD      | 1234567890 | DefaultBrand | PRVIRSACTCD7 | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRSACTCT7'
And click 'Next Stage' button and 'Confirm' on cost review page
And I am on supporting documents of cost title 'PRVIRSACTCT7'
And I upload following supporting documents to cost title 'PRVIRSACTCT7' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'PRVIRSACTCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 40000.00                         | 40000.00                    | 80000.00 |