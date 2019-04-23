Feature: Direct Vendor Payment Rules
Narrative:
In order to
As a GovernanceManager
I want to verify direct payment vendor rules functionality for usage buyout cost


Scenario: Check Vendor will only be visible in the drop down when the Vendor category and the Budget region matches the Traffic Cost type
Meta:@adcost
     @directPaymentRules
!--QA-1074
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
| Name          | Category                    | SAP Vendor Code | Preferred Supplier | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType                 |
| DPVRTDVendor1 | Distribution & Trafficking  | DPVRTDSAP1     |  true               | true           | US Dollar        | Total Costs     |0                  | 100         | true                    | IMEA         | 0               | DPVRTDDPRule1  | Trafficking/Distribution |
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | DPVRTDCT1 | DPVRTDD1   | Aaron Royer (Grey) | 30000                | DPVRTDATN1            | Greater China | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I am on cost items page of cost title 'DPVRTDCT1'
Then I 'should not' see following vendor dropdown on cost item page:
| Vendor to which payment will go |
| DPVRTDVendor1                  |
And I 'should not' be able to add vendor 'DPVRTDVendor1A' on the fly


Scenario: Check Vendor payment split rules of fifty and hundred percent for cost greater than zero within IMEA region for Traffic Distribution cost
Meta:@adcost
     @directPaymentRules
!--QA-1074
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
| Name           | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType                |
| DPVRTDVendor2 | DistributionTrafficking | DPVRTDSAP2      |  true               | true           | EUR              | CostTotal       | 0.5               | 1           | true                    | Europe       | 0;GreaterThan   | DPVRTDDPRule2  | Trafficking/Distribution|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | DPVRTDCT2  | DPVRTDD2    | Aaron Royer (Grey) | 60000                | DPVRTDATN2             | Europe        | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I am on cost items page of cost title 'DPVRTDCT2'
And filled direct vendor details on Cost Item Page for 'DistributionTrafficking' cost:
| Vendor to which payment will go    |
| DPVRTDVendor2;GBP - British Pound  |
And I filled Cost Line Items with following fields:
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 60000                          |  1234567890                       |
And added below approvers for cost title 'DPVRTDCT2':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRTDCT2'
And on cost review page of cost item with title 'DPVRTDCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
Then should see AMQ receives below request for cost title 'DPVRTDCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name     | Vendor     |
| 60000        | 30000          | GBP      | 1234567890 | DefaultBrand | DPVRTDCD2  | brandDescription | DPVRTDSAP2 |
When cost with title 'DPVRTDCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRTDCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRTDCT2':
| Trafficking/Distribution Costs |
| 80000                          |
And 'Submit' the cost with title 'DPVRTDCT2'
And on cost review page of cost item with title 'DPVRTDCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
| Final Actual      | 30000.00                         | 50000.00                    | 80000.00 |
When cost with title 'DPVRTDCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRTDCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      | Vendor     |
| 80000        | 50000          | GBP      | 1234567890 | DefaultBrand  |DPVRTDCD2    | brandDescription | DPVRTDSAP2 |


Scenario: Check Direct vendor payment split zero and hundred percent for cost greater than zero within IMEA region for traffic distribution type cost
Meta:@adcost
     @directPaymentRules
     @adcostCriticalTests
!--QA-1074
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
| Name           | Category                | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType                |
| DPVRTDVendor3 | DistributionTrafficking | DPVRTDSAP3     |  true               | true           | USD                | CostTotal       | 0                 | 1           | true                    | IMEA         | 0;GreaterThan   | DPVRTDDPRule3  | Trafficking/Distribution|
And I logged in with details of 'CostOwner'
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title  | Description  | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | DPVRTDCT3   | DPVRTDD3     | Aaron Royer (Grey)  | 30000                | DPVRTDATN3             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I am on cost items page of cost title 'DPVRTDCT3'
And filled direct vendor details on Cost Item Page for 'DistributionTrafficking' cost:
| Vendor to which payment will go |
| DPVRTDVendor3                   |
And I filled Cost Line Items with following fields:
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 20000                          |  1234567890                       |
And added below approvers for cost title 'DPVRTDCT3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRTDCT3'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'DPVRTDCT3'
And on cost review page of cost item with title 'DPVRTDCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
Then should see AMQ receives below request for cost title 'DPVRTDCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      | Vendor    |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand  | DPVRTDD3   | brandDescription | DPVRTDSAP3 |
When cost with title 'DPVRTDCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRTDCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRTDCT3':
| Trafficking/Distribution Costs |
| 40000                          |
And 'Submit' the cost with title 'DPVRTDCT3'
And on cost review page of cost item with title 'DPVRTDCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 40000.00                    | 40000.00 |
When cost with title 'DPVRTDCT3' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRTDCT3' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      | Vendor      |
| 40000        | 40000          | USD      | 1234567890 | DefaultBrand  |DPVRTDD3    | brandDescription | DPVRTDSAP3 |


Scenario: Check that Traffic Distribution Direct Payment vendor not able to change currency and direct vendor related fields after initial stage is approved
Meta:@adcost
     @directPaymentRules
!--QA-1074, ADC-2623, QA-1141
Given I am on costs overview page
And I 'created' vendor with following VendorDetails:
| Name           | Category                | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType                |
| DPVRTDVendor4 | DistributionTrafficking | DPVRTDSAP4     |  true               | true           | USD                | CostTotal       | 0                 | 1           | true                    | IMEA         | 0;GreaterThan   | DPVRTDDPRule4  | Trafficking/Distribution|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | DPVRTDCT4  | DPVRTDD4    | Aaron Royer (Grey) | 60000                | DPVRTDATN4             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I am on cost items page of cost title 'DPVRTDCT4'
And filled direct vendor details on Cost Item Page for 'DistributionTrafficking' cost:
| Vendor to which payment will go |
| DPVRTDVendor4                  |
And I filled Cost Line Items with following fields:
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 60000                          |  1234567890                       |
And added below approvers for cost title 'DPVRTDCT4':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRTDCT4'
And cost with title 'DPVRTDCT4' is 'Reject' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I click 'Reopen' and 'Yes, reopen this cost' on title 'DPVRTDCT4' from costs overview page
And I edit vendor currency with following fields for cost title 'DPVRTDCT4' on cost item page:
| Distribution & Trafficking Payment Currency  |
| GBP - British Pound                          |
Then I 'should' see sections currency as 'GBP - British Pound' on cost item page
When I click 'Continue' button on Adcost system page
And I 'Submit' the cost with title 'DPVRTDCT4'
And cost with title 'DPVRTDCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRTDCT4'
Then I 'should not' able to edit the currency field for catagory 'DistributionTrafficking' on cost item page for costTitle 'DPVRTDCT4'
And I 'should not' able to edit the currency field on cost item page for different sections for costTitle 'DPVRTDCT4'
And I 'should' see following currency symbols for grand total on cost Item page:
| CurrencyGroup   | Currency Symbol  |
| Local           | £                |
| Default         | $                |
Then I 'should not' able to edit the vendor field 'Vendor to which payment will go' on cost item page for costTitle 'DPVRTDCT4'


Scenario: Check that Traffic Distribution cost can be created and submitted without selecting any direct vendor payment
Meta:@adcost
     @directPaymentRules
!--QA-1074
Given I am on costs overview page
And I filled following data on vendor creation page to create new vendor:
| Name           | Category                    | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType                |
| DPVRTDVendor5 | Distribution & Trafficking   | DPVRTDSAP5      |  true               | true           | US Dollar        | Total Costs     |50                 | 100         | true                    | Japan        | 0               | DPVRTDDPRule5  | Trafficking/Distribution|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | DPVRTDCT5  | DPVRTDD5    | Aaron Royer (Grey)  | 30000                | DPVRTDATN5             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And filled Cost Line Items with following fields for cost title 'DPVRTDCT5':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 20000                          |  1234567890                       |
And added below approvers for cost title 'DPVRTDCT5':
| Coupa Requisitioner     |
| BrandManagementApprover |
When 'Submit' the cost with title 'DPVRTDCT5'
Then I 'should' see following data for 'DPVRTDCT5' cost item on Adcost overview page:
| Cost Stage        | Cost Status            |
| Original Estimate | Pending Brand Approval |


Scenario: Check Direct vendor payment split hundred and hundred percent for cost greater than zero within IMEA region for traffic distribution type cost
Meta:@adcost
     @directPaymentRules
     @adcostSmokeUAT
     @adcostSmoke
!--QA-1074, rule no-78
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
| Name           | Category                | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType                |
| DPVRTDVendor6  | DistributionTrafficking | DPVRTDSAP6      |  true               | true           | USD              | CostTotal       | 1                 | 1           | true                    | AAK          | 0;GreaterThan   | DPVRTDDPRule6  | Trafficking/Distribution|
And I logged in with details of 'CostOwner'
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title  | Description  | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | DPVRTDCT6   | DPVRTDD6     | Aaron Royer (Grey)  | 30000                | DPVRTDATN6             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I am on cost items page of cost title 'DPVRTDCT6'
And filled direct vendor details on Cost Item Page for 'DistributionTrafficking' cost:
| Vendor to which payment will go |
| DPVRTDVendor6                  |
And I filled Cost Line Items with following fields:
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 30000                          |  1234567890                       |
And added below approvers for cost title 'DPVRTDCT6':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRTDCT6'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'DPVRTDCT6'
And on cost review page of cost item with title 'DPVRTDCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 0.00                        | 30000.00 |
Then should see AMQ receives below request for cost title 'DPVRTDCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      | Vendor      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand  | DPVRTDD6   | brandDescription | DPVRTDSAP6 |
When cost with title 'DPVRTDCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRTDCT6'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRTDCT6':
| Trafficking/Distribution Costs |
| 40000                          |
And 'Submit' the cost with title 'DPVRTDCT6'
And on cost review page of cost item with title 'DPVRTDCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 0.00                        | 30000.00 |
| Final Actual      | 30000.00                         | 10000.00                    | 40000.00 |
When cost with title 'DPVRTDCT6' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRTDCT6' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      | Vendor     |
| 40000        | 10000          | USD      | 1234567890 | DefaultBrand  |DPVRTDD6     | brandDescription | DPVRTDSAP6 |