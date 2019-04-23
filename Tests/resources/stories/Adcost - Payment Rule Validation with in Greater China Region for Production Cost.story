Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split within Greater China region


Scenario: Check payment split for cost greater than zero within Greater China region for audio and full Production
Meta:@adcost
     @paymentRules
!--QA-705, rule no -66
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVGCRPCCT1 | PRVGCRPCCD1 | Aaron Royer (Grey)  | 60000                | Audio        | Full Production | PRVGCRPCATN1           | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVGCRPCCT1' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'PRVGCRPCCT1':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | PRVGCRPCAT1 | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'PRVGCRPCCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRPCCT1' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And filled below approvers for cost title 'PRVGCRPCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 80000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVGCRPCCT1'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVGCRPCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 80000        | 0              | USD      | 1234567890 | DefaultBrand  | PRVGCRPCCD1 |
When cost with title 'PRVGCRPCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVGCRPCCT1'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVGCRPCCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 35000                 | 35000         | 30000       | 1234567890                        |
And I upload following supporting documents to cost title 'PRVGCRPCCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'PRVGCRPCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PRVGCRPCCT1'
And on cost review page of cost item with title 'PRVGCRPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 0.00                             | 80000.00                    | 80000.00  |
| Final Actual      | 0.00                             | 100000.00                   | 100000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVGCRPCCT1'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVGCRPCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 100000         | USD      | 1234567890 | DefaultBrand | PRVGCRPCCD1 |
When cost with title 'PRVGCRPCCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVGCRPCCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description |
| 100000       | 100000         | USD      | 1234567890 | DefaultBrand | PRVGCRPCCD1 |


Scenario: Check payment split for cost more than zero within Greater China region for Digital type
Meta:@adcost
     @paymentRules
!--QA-705, rule no-68
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVGCRPCCT2 | PRVGCRPCCD2 | Aaron Royer (Grey)  | 10000                | Digital Development | PRVGCRPCATN2           | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVGCRPCCT2' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'PRVGCRPCCT2':
| Initiative | Asset Title | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVGCRPCAT2 | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PRVGCRPCCT2':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 2000       | 8000            | 2000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRPCCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVGCRPCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 12000.00                    | 12000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVGCRPCCT2'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVGCRPCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 12000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRPCCD2 |
When cost with title 'PRVGCRPCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVGCRPCCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVGCRPCCT2' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVGCRPCCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVGCRPCCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVGCRPCCT2'
And on cost review page of cost item with title 'PRVGCRPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 12000.00                    | 12000.00 |
| Final Actual      | 0.00                             | 12000.00                    | 12000.00 |


Scenario: Check payment split for cost greater than zero within Greater China region for Still image and post production only
Meta:@adcost
     @paymentRules
!--QA-705, rule no-70
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVGCRPCCT3 | PRVGCRPCCD3 | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | PRVGCRPCATN3           | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And filled Expected Assets form with following fields:
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVGCRPCAT3 | Version | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields:
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000                  | 20000      | 10000            | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRPCCT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVGCRPCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVGCRPCCT3'
And click 'Approve' button and 'Approve' on cost review page
And cost with title 'PRVGCRPCCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVGCRPCCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVGCRPCCT3':
| Agency Artwork / Packs | Retouching  | FX (Loss) & Gain |
| 5000                   | 20000       | 5000             |
And I upload following supporting documents to cost title 'PRVGCRPCCT3' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than zero within Greater China region for Still image and full production
Meta:@adcost
     @paymentRules
!--QA-705, rule no-69
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVGCRPCCT4 | PRVGCRPCCD4 | Aaron Royer (Grey)  | 8000                 | Still Image  | Full Production | PRVGCRPCATN4           | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And filled Expected Assets form with following fields:
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVGCRPCAT4 |  Version | Digital           | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields:
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 4000                   | 2000       | 3000             | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRPCCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVGCRPCCT4':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 9000.00                     | 9000.00  |
When cost with title 'PRVGCRPCCT4' is 'Approve' on behalf of MyPurchases application with page refresh
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVGCRPCCT4':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain |
| 5000                   | 5000       | 5000             |
And I upload following supporting documents to cost title 'PRVGCRPCCT4' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And fill below approvers for cost title 'PRVGCRPCCT4':
| Technical Approver |
| IPMuser            |
And click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 9000.00                     | 9000.00  |
| Final Actual      | 0.00                             | 15000.00                    | 15000.00 |


Scenario: Check payment split for cost more than zero within Greater China region for Video content type and Post Production Only
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-705, rule no-73
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVGCRPCCT5 | PRVGCRPCCD5 | Aaron Royer (Grey)  | 55000                | Video        | Post Production Only | PRVGCRPCATN5           | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVGCRPCCT5' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVGCRPCCT5':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVGCRPCAT5 | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PRVGCRPCCT5':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRPCCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVGCRPCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVGCRPCCT5'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVGCRPCCT5' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 65000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRPCCD5 |
When cost with title 'PRVGCRPCCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVGCRPCCT5'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVGCRPCCT5' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVGCRPCCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVGCRPCCT5':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVGCRPCCT5'
And on cost review page of cost item with title 'PRVGCRPCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
| Final Actual      | 0.00                             | 65000.00                    | 65000.00 |


Scenario: Check payment split for cost more than zero within Greater China region for Video content type and CGI Animation
Meta:@adcost
     @paymentRules
!--QA-705, rule no-71
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVGCRPCCT6 | PRVGCRPCCD6 | Aaron Royer (Grey)  | 55000                | Video        | CGI/Animation   | PRVGCRPCATN6           | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVGCRPCCT6' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVGCRPCCT6':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVGCRPCAT6 | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PRVGCRPCCT6':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRPCCT6' and click continue:
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And filled below approvers for cost title 'PRVGCRPCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVGCRPCCT6'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVGCRPCCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 65000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRPCCD6 |
When cost with title 'PRVGCRPCCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVGCRPCCT6'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVGCRPCCT6' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVGCRPCCT6':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVGCRPCCT6':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVGCRPCCT6'
And on cost review page of cost item with title 'PRVGCRPCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
| Final Actual      | 0.00                             | 65000.00                    | 65000.00 |


Scenario: Check payment split for cost greater than zero within Greater China region for Audio and Post Production Only
Meta:@adcost
     @paymentRules
!--QA-705, rule no-67
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVGCRPCCT7 | PRVGCRPCCD7 | Aaron Royer (Grey)  | 40000                | Audio        | Post Production Only | PRVGCRPCATN7           | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVGCRPCCT7' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'PRVGCRPCCT7':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | PRVGCRPCAT7 | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'PRVGCRPCCT7':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRPCCT7' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVGCRPCCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVGCRPCCT7'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVGCRPCCT7' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 30000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRPCCD7 |
When cost with title 'PRVGCRPCCT7' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVGCRPCCT7'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVGCRPCCT7' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVGCRPCCT7':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVGCRPCCT7':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVGCRPCCT7'
And on cost review page of cost item with title 'PRVGCRPCCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost more than zero within Greater China region for Video and Full Production
Meta:@adcost
     @paymentRules
!--QA-705, rule no-72
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVGCRPCCT8 | PRVGCRPCCD8 | Aaron Royer (Grey)  | 55000                | Video        | Full Production | PRVGCRPCATN8           | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVGCRPCCT8' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVGCRPCCT8':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVGCRPCAT8 | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PRVGCRPCCT8':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRPCCT8' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And filled below approvers for cost title 'PRVGCRPCCT8':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVGCRPCCT8'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVGCRPCCT8'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVGCRPCCT8' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 65000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRPCCD8 |
When cost with title 'PRVGCRPCCT8' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVGCRPCCT8'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVGCRPCCT8' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVGCRPCCT8':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVGCRPCCT8':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVGCRPCCT8'
And on cost review page of cost item with title 'PRVGCRPCCT8'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
| Final Actual      | 0.00                             | 65000.00                    | 65000.00 |