Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split within Japan region


Scenario: Check payment split for cost greater than zero within Japan region for audio and full Production
Meta:@adcost
     @paymentRules
!--QA-707, rule no -123
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVJRPCCT1 | PRVJRPCCD1  | Aaron Royer (Grey)  | 60000                | Audio        | Full Production | PRVJRPCATN1            | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVJRPCCT1' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'PRVJRPCCT1':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date |  Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | PRVJRPCAT1  | 10:10:10          | Version | Tv               | 12/12/2017               |  Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'PRVJRPCCT1':
| VO recording sessions | P&G insurance | Talent fees   | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRPCCT1' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And filled below approvers for cost title 'PRVJRPCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 80000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVJRPCCT1'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVJRPCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 80000        | 0              | USD      | 1234567890 | DefaultBrand | PRVJRPCCD1  | brandDescription |
When cost with title 'PRVJRPCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVJRPCCT1'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVJRPCCT1':
| VO recording sessions | P&G insurance | Talent fees   | Please enter a 10-digit IO number |
| 35000                 | 35000         | 30000         | 1234567890                        |
And I upload following supporting documents to cost title 'PRVJRPCCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'PRVJRPCCT1'
And on cost review page of cost item with title 'PRVJRPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 0.00                             | 80000.00                    | 80000.00 |
| Final Actual      | 0.00                             | 100000.00                   | 100000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVJRPCCT1'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVJRPCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 100000       | 100000         | USD      | 1234567890 | DefaultBrand | PRVJRPCCD1  | brandDescription |
When cost with title 'PRVJRPCCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVJRPCCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 100000       | 100000         | USD      | 1234567890 | DefaultBrand | PRVJRPCCD1  | brandDescription |


Scenario: Check payment split for cost more than zero within Japan region for Digital type
Meta:@adcost
     @paymentRules
!--QA-707, rule no-128, QA-1062
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVJRPCCT2 | PRVJRPCCD2  | Aaron Royer (Grey)| 10000                  | Digital Development | PRVJRPCATN2            | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Production Details with following fields for cost title 'PRVJRPCCT2':
| Digital Development Company |
| GlobalDefaultVendor         |
Then I 'should' see fields contains following values on ExpectedAssets form page for cost title 'PRVJRPCCT2':
| Media/Touchpoint |
| N/A;Digital      |
When I fill Expected Assets form with following fields:
| Initiative | Asset Title | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVJRPCAT2  | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And fill Cost Line Items with following fields:
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 2000         | 8000            | 2000          | 1234567890                        |
And I upload following supporting documents to cost title 'PRVJRPCCT2' and click continue:
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And fill below approvers for cost title 'PRVJRPCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 12000.00                    | 12000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVJRPCCT2'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVJRPCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 12000        | 0              | USD      | 1234567890 | DefaultBrand | PRVJRPCCD2  | brandDescription |
When cost with title 'PRVJRPCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVJRPCCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVJRPCCT2' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVJRPCCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVJRPCCT2':
| Technical Approver |
| IPMuser     |
And 'Submit' the cost with title 'PRVJRPCCT2'
And on cost review page of cost item with title 'PRVJRPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 12000.00                    | 12000.00 |
| Final Actual      | 0.00                             | 12000.00                    | 12000.00 |


Scenario: Check payment split for cost greater than zero within Japan region for Still image and post production only
Meta:@adcost
     @paymentRules
!--QA-707, rule no-136
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVJRPCCT3 | PRVJRPCCD3  | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | PRVJRPCATN3            | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And filled Expected Assets form with following fields:
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVJRPCAT3  |  Version | Digital               | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields:
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000                  | 20000      | 10000            | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRPCCT3' and click continue:
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And filled below approvers for cost title 'PRVJRPCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVJRPCCT3'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVJRPCCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 40000        | 0              | USD      | 1234567890 | DefaultBrand | PRVJRPCCD3  | brandDescription |
When cost with title 'PRVJRPCCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVJRPCCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVJRPCCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain|
| 5000                 | 20000           | 5000               |
And I upload following supporting documents to cost title 'PRVJRPCCT3' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than zero within Japan region for Still image and full production
Meta:@adcost
     @paymentRules
!--QA-707, rule no-135
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVJRPCCT4 | PRVJRPCCD4  | Aaron Royer (Grey)  | 8000                 | Still Image  | Full Production | PRVJRPCATN4            | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And filled Expected Assets form with following fields:
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVJRPCAT4  | Version | Digital               | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields:
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 4000                   | 2000       | 3000             | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRPCCT4' and click continue:
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And filled below approvers for cost title 'PRVJRPCCT4':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 9000.00                     | 9000.00  |
And should see AMQ receives below request for cost title 'PRVJRPCCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 9000         | 0              | USD      | 1234567890 | DefaultBrand | PRVJRPCCD4  | brandDescription |
When cost with title 'PRVJRPCCT4' is 'Approve' on behalf of MyPurchases application with page refresh
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVJRPCCT4':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain |
| 5000                   | 5000            | 5000             |
And I upload following supporting documents to cost title 'PRVJRPCCT4' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And fill below approvers for cost title 'PRVJRPCCT4':
| Technical Approver |
| IPMuser            |
And click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 9000.00                     | 9000.00  |
| Final Actual      | 0.00                             | 15000.00                    | 15000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'PRVJRPCCT4'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVJRPCCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 15000        | 15000          | USD      | 1234567890 | DefaultBrand | PRVJRPCCD4  | brandDescription |
When cost with title 'PRVJRPCCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVJRPCCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 15000        | 15000          | USD      | 1234567890 | DefaultBrand | PRVJRPCCD4  | brandDescription |


Scenario: Check payment split for cost more than zero within Japan region for video content type and Post Production Only
Meta:@adcost
     @paymentRules
!--QA-707, rule no-137, 139, QA-1062
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVJRPCCT5 | PRVJRPCCD5  | Aaron Royer (Grey)  | 55000                | Video        | Post Production Only | PRVJRPCATN5            | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
When I add production details for cost title 'PRVJRPCCT5' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
Then I 'should' see fields contains following values on ExpectedAssets form page for cost title 'PRVJRPCCT5':
| Media/Touchpoint                                                                                        |
| not for air;N/A;In-store;Direct to consumer;PR/Influencer;streaming audio;Out of home;Cinema;Digital;Tv |
When I add expected asset details for cost title 'PRVJRPCCT5':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVJRPCAT5  | 10:10:10          | Version | Digital          | 12/12/2019               | HD         | Yes      | Yes       | JAPAN   |
And refresh the page without delay
And fill Cost Line Items with following fields for cost title 'PRVJRPCCT5':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I upload following supporting documents to cost title 'PRVJRPCCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'PRVJRPCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVJRPCCT5'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVJRPCCT5' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 65000        | 0              | USD      | 1234567890 | DefaultBrand | PRVJRPCCD5  | brandDescription |
When cost with title 'PRVJRPCCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVJRPCCT5'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVJRPCCT5' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVJRPCCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVJRPCCT5':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVJRPCCT5'
And on cost review page of cost item with title 'PRVJRPCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
| Final Actual      | 0.00                             | 65000.00                    | 65000.00 |


Scenario: Check payment split for cost more than zero within Japan region for video content type and CGI Animation
Meta:@adcost
     @paymentRules
!--QA-707, rule no-137, 139
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign         | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVJRPCCT6 | PRVJRPCCD6  | Aaron Royer (Grey)  | 55000                | Video        | CGI/Animation   | PRVJRPCATN6            | Japan          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVJRPCCT6' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVJRPCCT6':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVJRPCAT6  | 10:10:10          | Version | Digital               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVJRPCCT6':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRPCCT6' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And filled below approvers for cost title 'PRVJRPCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVJRPCCT6'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVJRPCCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 65000        | 0              | USD      | 1234567890 | DefaultBrand | PRVJRPCCD6  | brandDescription |
When cost with title 'PRVJRPCCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVJRPCCT6'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVJRPCCT6' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVJRPCCT6':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVJRPCCT6':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVJRPCCT6'
And on cost review page of cost item with title 'PRVJRPCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
| Final Actual      | 0.00                             | 65000.00                    | 65000.00 |


Scenario: Check payment split for cost greater than zero within Japan region for Audio and Post Production Only
Meta:@adcost
     @paymentRules
!--QA-707, rule no-124
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVJRPCCT7 | PRVJRPCCD7  | Aaron Royer (Grey)  | 40000                | Audio        | Post Production Only | PRVJRPCAT7             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVJRPCCT7' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'PRVJRPCCT7':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date |  Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | PRVJRPCAT7  | 10:10:10          | Version | Digital               | 12/12/2017               |  Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'PRVJRPCCT7':
| VO recording sessions | P&G insurance | Talent fees   | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRPCCT7' and click continue:
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And filled below approvers for cost title 'PRVJRPCCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVJRPCCT7'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVJRPCCT7' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 30000        | 0              | USD      | 1234567890 | DefaultBrand | PRVJRPCCD7  | brandDescription |
When cost with title 'PRVJRPCCT7' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVJRPCCT7'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVJRPCCT7' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVJRPCCT7':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVJRPCCT7':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVJRPCCT7'
And on cost review page of cost item with title 'PRVJRPCCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost more than zero within Japan region for Video and Full Production
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-707, rule no-138
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PRVJRPCCT8 | PRVJRPCCD8  | Aaron Royer (Grey)  | 55000                | Video        | Full Production  | PRVJRPCAT8             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PRVJRPCCT8' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PRVJRPCCT8':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | PRVJRPCAT8  | 10:10:10          | Version | Digital               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'PRVJRPCCT8':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRPCCT8' and click continue:
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script)|
And filled below approvers for cost title 'PRVJRPCCT8':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PRVJRPCCT8'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVJRPCCT8'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'PRVJRPCCT8' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 65000        | 0              | USD      | 1234567890 | DefaultBrand | PRVJRPCCD8  | brandDescription |
When cost with title 'PRVJRPCCT8' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVJRPCCT8'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'PRVJRPCCT8' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'PRVJRPCCT8':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PRVJRPCCT8':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PRVJRPCCT8'
And on cost review page of cost item with title 'PRVJRPCCT8'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 65000.00                    | 65000.00 |
| Final Actual      | 0.00                             | 65000.00                    | 65000.00 |