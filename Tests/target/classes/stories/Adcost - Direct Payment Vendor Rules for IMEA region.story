Feature: Direct Vendor Payment Rules
Narrative:
In order to
As a GovernanceManager
I want to verify direct payment vendor rules functionality for IMEA region


Scenario: Check Vendor payment split rules for cost greater than zero within IMEA region for Audio and Post Production Only
Meta:@adcost
     @directPaymentRules
!--QA-686, rule no-82
Given I am on cost overview page
When I filled following data on vendor creation page to create new vendor:
|  Name           | Category             | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType      | TotalCostAmount | Rule name    | CostType  |
| DPVRIRVendor1   | Audio/Music Company  |  DPVRIRSAP1     |  true               | true           | US Dollar        | Total Costs     |50                 | 100         | true                    | IMEA         | Audio       | Post Production Only| 0               | DPVRIRDPRule | Production|
Then I 'should' see following vendor details for vendor 'DPVRIRVendor1':
| Name              | Category             |  SAP Vendor Code | Default Currency | Original Estimate | Final Actual|BudgetRegion | ContentType | ProductionType      | TotalCostAmount |
| DPVRIRVendor1     | Audio/Music Company  |  DPVRIRSAP1      | US Dollar        | 50.00             | 100.00      | IMEA        | Audio       | Post Production Only| 0               |
When I login with details of 'CostOwner'
And I am on costs overview page
And create a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRIRCT1    | DPVRIRCD1    |  Aldrin Anthony Galang (Grey) | 40000                | Audio        | Post Production Only | DPVRIRATN1             | IMEA        | DefaultCampaign | BFO          | USD - US Dollar         |
And fill Production Details with following fields for cost title 'DPVRIRCT1':
| Audio/Music Company |
| DPVRIRVendor1;true  |
And add expected asset details for cost title 'DPVRIRCT1':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | AAK          | DPVRIRAT4    | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And fill Cost Line Items with following fields for cost title 'DPVRIRCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And I upload following supporting documents to cost title 'DPVRIRCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'DPVRIRCT1':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And 'Submit' the cost with title 'DPVRIRCT1'
And I am on cost review page of cost item with title 'DPVRIRCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 15000.00                         | 15000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRIRCT1'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRIRCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 30000        | 15000          | USD      | 1234567890 | DefaultBrand   | DPVRIRCD1    | brandDescription |
When cost with title 'DPVRIRCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRIRCT1'
And I upload following supporting documents to cost title 'DPVRIRCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DPVRIRCT1'
And I am on cost review page of cost item with title 'DPVRIRCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 15000.00                         | 15000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than zero within IMEA region for Digital type
Meta:@adcost
    @directPaymentRules
    @adcostCriticalTests
!--QA-686, rule no-87
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name          | Category                      | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType         | TotalCostAmount | Rule name     | CostType  |
|  DPVRIRVendor2 | DigitalDevelopmentCompany     | DPVRIRSAP2      |  true               | true           | USD              | CostTotal       | 0                 | 1           | true                    | IMEA         | Digital Development | 0;GreaterThan   | DPVRIRDPRule2 | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art  | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRIRCT2    | DPVRIRCD2    | Aaron Royer (Grey)   | 50000                | Digital Development | DPVRIRATN2             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRIRCT2' with following fields:
| Digital Development Company | Digital Development Company Activate Direct Billing |
| DPVRIRVendor2               | Yes                                                 |
And added expected asset details for cost title 'DPVRIRCT2':
| Initiative | Asset Title  | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRIRAT2    | Digital          | 12/12/2017               | Yes      | Yes       | IMEA    |
And filled Cost Line Items with following fields for cost title 'DPVRIRCT2':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000        | 20000           | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRIRCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRIRCT2':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When I 'Submit' the cost with title 'DPVRIRCT2'
And I am on cost review page of cost item with title 'DPVRIRCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 60000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRIRCT2'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRIRCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 0              | USD      | 1234567890 | DefaultBrand   | DPVRIRCD2    | brandDescription |
When cost with title 'DPVRIRCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRIRCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'DPVRIRCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'DPVRIRCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'DPVRIRCT2'
And I am on cost review page of cost item with title 'DPVRIRCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 60000.00                    | 60000.00 |


Scenario: Check payment split for cost greater than zero within IMEA region for Still image and post production only
Meta:@adcost
    @directPaymentRules
!--QA-686, rule no-97
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name         | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType      | TotalCostAmount | Rule name       | CostType  |
| DPVRIRVendor3 | Photographer Company   | DPVRIRSAP3      |  true               | true           | US Dollar        | CostTotal       |100                | 100         | true                    | IMEA         | Still Image | Post Production Only| 0               | DPVRIRDPRule3   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRIRCT3  | DPVRIRCD3   | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | DPVRIRATN3             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRIRCT3':
| Photographer Company  |
| DPVRIRVendor3;true    |
And added expected asset details for cost title 'DPVRIRCT3':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country         |
| Giggles    | DPVRIRAT3   |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Greater China   |
And filled Cost Line Items with following fields for cost title 'DPVRIRCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 10000                  | 20000           | 10000              | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRIRCT3':
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And added below approvers for cost title 'DPVRIRCT3':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When I 'Submit' the cost with title 'DPVRIRCT3'
And I am on cost review page of cost item with title 'DPVRIRCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 0.00                        | 40000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRIRCT3'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRIRCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 40000        | 40000          | USD      | 1234567890 | DefaultBrand | DPVRIRCD3   | brandDescription |
When cost with title 'DPVRIRCT3' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRIRCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRIRCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   |
| 15000                  | 20000           | 15000              |
And I upload following supporting documents to cost title 'DPVRIRCT3' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'DPVRIRCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 0.00                        | 40000.00 |
| Final Actual      | 40000.00                         | 10000.00                    | 50000.00 |


Scenario: Check payment split for cost more than zero within IMEA region for Audio content type and Full production
Meta:@adcost
    @directPaymentRules
    @adcostSmokeUAT
    @adcostSmoke
!--QA-686, rule no-81
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name         | Category         | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType   | TotalCostAmount | Rule name       | CostType  |
| DPVRIRVendor4 | TalentCompany    | DPVRIRSAP4      |  true               | true           | GBP              | CostTotal       | 0.5               | 1           | true                    | IMEA          | Audio       | Full Production   |0;GreaterThan   | DPVRIRDPRule4   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art         | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRIRCT4   | DPVRIRCD14    | Adam Furman (Leo Burnett) | 20000                | Audio        | Full Production | DPVRIRATN4             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRIRCT4' with following fields:
| Talent Company  | Recording Date | Recording Days | Recording Country | Recording City | Talent Company Activate Direct Billing |
| DPVRIRVendor4   | 01/07/2019     | 2              | India             | New Delhi      | Yes                                    |
And added expected asset details for cost title 'DPVRIRCT4':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | DPVRIRAT4     | 10:10:10        | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRIRCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRIRCT4':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'DPVRIRCT4':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When I 'Submit' the cost with title 'DPVRIRCT4'
And on cost review page of cost item with title 'DPVRIRCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRIRCT4'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRIRCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 80000        | 40000          | GBP      | 1234567890 | DefaultBrand  | DPVRIRCD14     |
When cost with title 'DPVRIRCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRIRCT4'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRIRCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 35000                 | 35000         | 30000       | 1234567890                        |
And I upload following supporting documents to cost title 'DPVRIRCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'DPVRIRCT4':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And 'Submit' the cost with title 'DPVRIRCT4'
And on cost review page of cost item with title 'DPVRIRCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 40000.00                         | 40000.00                    | 80000.00  |
| Final Actual      | 40000.00                         | 60000.00                    | 100000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRIRCT4'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRIRCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 60000          | GBP      | 1234567890 | DefaultBrand  | DPVRIRCD14   |
When cost with title 'DPVRIRCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRIRCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 60000          | GBP      | 1234567890 | DefaultBrand  | DPVRIRCD14  |

Scenario: Check Direct Payment Vendor Rules within IMEA for Still Image Content Type and Full Production
Meta:@adcost
     @adcostSmokeUAT
     @adcostSmoke
!--QA-686, ruleNo-92
Given I am on cost overview page
And 'created' vendor with following VendorDetails:
|  Name            | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType    | TotalCostAmount | Rule name       | CostType  |
| DPVRIRVendor5    | PhotographyCompany     | DPVRIRSAP5      |  true               | true           | INR              | CostTotal       | 0                 | 1            | true                    | IMEA         | Still Image | Full Production   | 0;GreaterThan   | DPVRIRDPRule5   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number    | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject| DPVRIRCT5  | DPVRIRD5    | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | DPVRIRATN5             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRIRCT5' with following fields:
| Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Photographer Company Activate Direct Billing |
| DPVRIRVendor5        | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | Yes                                          |
And added expected asset details for cost title 'DPVRIRCT5':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRIRAT5   |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'DPVRIRCT5':
| Preproduction | Retouching | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 4000000       | 800000     | 4000000            | 1234567890                        |
And uploaded following supporting documents to cost title 'DPVRIRCT5':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRIRCT5':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When I 'Submit' the cost with title 'DPVRIRCT5'
And on cost review page of cost item with title 'DPVRIRCT5'
And I refresh the page without delay
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 8800000.00                  | 8800000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRIRCT5'
And cost with title 'DPVRIRCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRIRCT5'
And I upload following supporting documents to cost title 'DPVRIRCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DPVRIRCT5'
And I am on cost review page of cost item with title 'DPVRIRCT5'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | Final Actual payment amount | PO Total   |
| Original Estimate  | 0.00                             | 8800000.00                  | 8800000.00 |
| Final Actual       | 0.00                             | 8800000.00                  | 8800000.00 |

Scenario: Check that duplicate SAP vendor code is not allowed while creating a new vendor
Meta:@adcost
     @directPaymentRules
!--QA-863
Given I am on cost overview page
And I am on cost overview page
When I am on vendor section under admin page
Then I 'should' see error message while creating new vendor with duplicate SAP Vendor code using following data:
|  Name           | Category             | SAP Vendor Code |
| DPVRIRVendor6   | Audio/Music Company  |  DPVRIRSAP5     |


Scenario: Check that Direct Payment vendor not able to change direct vendor related fields after revision is created for cost
Meta:@adcost
    @directPaymentRules
!--QA-1141
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name         | Category         | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType   | TotalCostAmount | Rule name       | CostType  |
| DPVRIRVendor7 | TalentCompany    | DPVRIRSAP6      |  true               | true           | GBP              | CostTotal       | 0.5               | 1           | true                    | IMEA          | Audio       | Full Production   |0;GreaterThan   | DPVRIRDPRule6   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art         | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRIRCT6   | DPVRIRCD16    | Adam Furman (Leo Burnett) | 20000                | Audio        | Full Production | DPVRIRATN6             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRIRCT6' with following fields:
| Talent Company  | Recording Date | Recording Days | Recording Country | Recording City | Talent Company Activate Direct Billing |
| DPVRIRVendor7   | 01/07/2019     | 2              | India             | New Delhi      | Yes                                    |
And added expected asset details for cost title 'DPVRIRCT6':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | DPVRIRAT4     | 10:10:10        | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRIRCT6':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRIRCT6':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'DPVRIRCT6':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When I 'Submit' the cost with title 'DPVRIRCT6'
And on cost review page of cost item with title 'DPVRIRCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRIRCT6'
And I 'Approve' the cost with title 'DPVRIRCT6'
And cost with title 'DPVRIRCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'DPVRIRCT6'
Then I 'should not' able to edit the currency field for catagory 'Talent Company' on production detail page for costTitle 'DPVRIRCT6'
And I 'should not' able to edit the currency field on cost item page for different sections for costTitle 'DPVRIRCT6'
And I 'should not' be able to edit the vendor field 'Talent Company' on production detail page for costTitle 'DPVRIRCT6'
And I 'should not' able to edit the activate vendor radio buttons for category 'Talent Company' on production detail page for costTitle 'DPVRIRCT6'