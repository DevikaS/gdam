Feature: Direct Vendor Payment Rules
Narrative:
In order to
As a GovernanceManager
I want to verify direct payment vendor rules functionality for Europe region

Scenario: Check Vendor payment split rules for cost greater than zero within Europe region for Audio and Post Production Only
Meta:@adcost
     @directPaymentRules
!--QA-699, rule no-10
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name         | Category            | SAP Vendor Code | Preferred Supplier | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType       | TotalCostAmount | Rule name    | CostType   |
| DPVRERVendor1 | Audio/Music Company | DPVRERSAP1      | true               | true           | US Dollar        | CostTotal       |0                  | 100         | true                    | Europe       | Audio       | Post Production Only | 0               | DPVRERDPRule | Production |
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title     | Description    | Agency Producer/Art              | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRERCT1      | DPVRERCD1      |  Aldrin Anthony Galang (Grey)    | 40000                | Audio        | Post Production Only | DPVRERATN1             | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRERCT1':
| Audio/Music Company |
| DPVRERVendor1;true  |
And added expected asset details for cost title 'DPVRERCT1':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | AAK          | DPVRERAT1      | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRERCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRERCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRERCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRERCT1'
And I am on cost review page of cost item with title 'DPVRERCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRERCT1'
And click 'Approve' button and 'Approve' on cost review page
And cost with title 'DPVRERCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRERCT1'
And I am on supporting documents of cost title 'DPVRERCT1'
And I upload following supporting documents to cost title 'DPVRERCT1' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I 'Submit' the cost with title 'DPVRERCT1'
And I am on cost review page of cost item with title 'DPVRERCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than zero within Europe region for Digital type
Meta:@adcost
     @directPaymentRules
!--QA-699, rule no-19
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name          | Category                  | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType         | TotalCostAmount | Rule name       | CostType  |
|  DPVRERVendor2 | DigitalDevelopmentCompany | DPVRERSAP2      |  true               | true           | USD              | CostTotal       | 1                 | 1           | true                    | Europe       | Digital Development | 0;GreaterThan   | DPVRERDPRule2   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art  | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRERCT2    | DPVRERCD2    | Aaron Royer (Grey)   | 50000                | Digital Development | DPVRERATN2               | Europe      | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRERCT2' with following fields:
| Digital Development Company | Digital Development Company Activate Direct Billing |
| DPVRERVendor2               | Yes                                                 |
And added expected asset details for cost title 'DPVRERCT2':
| Initiative | Asset Title  | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRERAT2    | Digital          | 12/12/2017               | Yes      | Yes       | IMEA   |
And filled Cost Line Items with following fields for cost title 'DPVRERCT2':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000        | 20000           | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRERCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRERCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRERCT2'
And I am on cost review page of cost item with title 'DPVRERCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 60000.00                         | 0.00                        | 60000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRERCT2'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRERCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 60000          | USD      | 1234567890 | DefaultBrand   | DPVRERCD2    | brandDescription |
When cost with title 'DPVRERCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRERCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And add cost item details for cost title 'DPVRERCT2' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'DPVRERCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'DPVRERCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'DPVRERCT2'
And I am on cost review page of cost item with title 'DPVRERCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 60000.00                         | 0.00                        | 60000.00 |


Scenario: Check payment split for cost greater than zero within Europe region for Still image and post production only
Meta:@adcost
     @directPaymentRules
!--QA-699, rule no-23
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name         | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType      | TotalCostAmount | Rule name     | CostType  |
| DPVRERVendor3 | Photographer Company   | DPVRERSAP3      |  true               | true           | US Dollar        | CostTotal       |0                 | 100         | true                    | Europe        | Still Image | Post Production Only| 0               | DPVRERDPRule3 | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRERCT3    | DPVRERCD3 | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | DPVRERATN3             | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRERCT3':
| Photographer Company  |
| DPVRERVendor3;true      |
And added expected asset details for cost title 'DPVRERCT3':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country         |
| Giggles    | DPVRERAT3   |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Greater China   |
And filled Cost Line Items with following fields for cost title 'DPVRERCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 10000                  | 20000           | 10000              | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRERCT3':
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And added below approvers for cost title 'DPVRERCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRERCT3'
And on cost review page of cost item with title 'DPVRERCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRERCT3'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRERCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 40000        | 0              | USD      | 1234567890 | DefaultBrand | DPVRERCD3   | brandDescription |
When cost with title 'DPVRERCT3' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRERCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRERCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   |
| 15000                  | 20000           | 15000              |
And I upload following supporting documents to cost title 'DPVRERCT3' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And I 'Submit' the cost with title 'DPVRERCT3'
And on cost review page of cost item with title 'DPVRERCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
| Final Actual      | 0.00                             | 50000.00                    | 50000.00 |


Scenario: Check payment split for cost more than zero within Europe region for Audio content type and Full production
Meta:@adcost
     @directPaymentRules
!--QA-699, rule no-13
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name         | Category        | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType   | TotalCostAmount | Rule name       | CostType  |
| DPVRERVendor4 | TalentCompany   | DPVRERSAP4      |  true               | true           | GBP              | CostTotal       | 1                 | 1           | true                    | Europe        | Audio       | Full Production   |0;GreaterThan   | DPVRERDPRule4   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art         | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRERCT4   | DPVRERCD14  | Adam Furman (Leo Burnett)   | 20000                | Audio        | Full Production | DPVRERATN4             | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRERCT4' with following fields:
| Talent Company  | Recording Date | Recording Days | Recording Country | Recording City | Talent Company Activate Direct Billing |
| DPVRERVendor4     | 01/07/2019     | 2              | India             | New Delhi      | Yes                                  |
And added expected asset details for cost title 'DPVRERCT4':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | DPVRERAT4   | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRERCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRERCT4':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'DPVRERCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRERCT4'
And on cost review page of cost item with title 'DPVRERCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 80000.00                         | 0.00                        | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRERCT4'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRERCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 80000        | 80000          | GBP      | 1234567890 | DefaultBrand  | DPVRERCD14  |
When cost with title 'DPVRERCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRERCT4'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRERCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 35000                 | 35000         | 30000       | 1234567890                        |
And I upload following supporting documents to cost title 'DPVRERCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'DPVRERCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'DPVRERCT4'
And on cost review page of cost item with title 'DPVRERCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 80000.00                             | 0.00                    | 80000.00  |
| Final Actual      | 80000.00                             | 20000.00                | 100000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRERCT4'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRERCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 20000          | GBP      | 1234567890 | DefaultBrand  | DPVRERCD14  |
When cost with title 'DPVRERCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRERCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 20000          | GBP      | 1234567890 | DefaultBrand  | DPVRERCD14  |


Scenario: Check Direct Payment Vendor Rules within Europe for Still Image Content Type and Full Production
Meta:@adcost
     @directPaymentRules
!--QA-699, rule no-24
Given I am on cost overview page
And 'created' vendor with following VendorDetails:
|  Name            | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType      | TotalCostAmount | Rule name     | CostType  |
| DPVRERVendor5    | PhotographyCompany     | DPVRERSAP5      |  true               | true           | INR              | CostTotal       | 0.5             | 1            | true                    | Europe         | Still Image | Full Production    | 0;GreaterThan     | DPVRERDPRule5 | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number    | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject| DPVRERCT5  | DPVRERD5    | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | DPVRERATN5             | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRERCT5' with following fields:
| Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Photographer Company Activate Direct Billing |
| DPVRERVendor5          | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | Yes                                          |
And added expected asset details for cost title 'DPVRERCT5':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRERAT5   |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'DPVRERCT5':
| Preproduction | Retouching | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 4000000       | 800000     | 4000000            | 1234567890                        |
And uploaded following supporting documents to cost title 'DPVRERCT5':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRERCT5':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When 'Submit' the cost with title 'DPVRERCT5'
And on cost review page of cost item with title 'DPVRERCT5'
And I refresh the page without delay
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total   |
| Original Estimate | 4400000.00                       | 4400000.00                  | 8800000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRERCT5'
And cost with title 'DPVRERCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRERCT5'
And I upload following supporting documents to cost title 'DPVRERCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DPVRERCT5'
And I am on cost review page of cost item with title 'DPVRERCT5'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | Final Actual payment amount | PO Total   |
| Original Estimate  | 4400000.00                       | 4400000.00                  | 8800000.00 |
| Final Actual       | 4400000.00                       | 4400000.00                  | 8800000.00 |