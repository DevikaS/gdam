Feature:          Usage Buyout Cost Type
Narrative:
In order to
As a CostOwner
I want to check Approvers in Adcost module for Usage Buyout cost

Scenario: Check that only Brand Management Approvers available for selection when budget is less than ten thousand for Contract cost and Film type for Greater China region
Meta:@adcost
     @approverRules
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-650, QA-829, QA-1067
Given I am on costs overview page
And created a new 'buyout' cost on AdCosts overview page
And filled Cost Details with following fields for 'buyout' cost:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | Original Estimate             | Film | Contract (celebrity & athletes) | ARUBCTCT1  | ARUBCTD1    | Aaron Royer (Grey)  | ARUBCTD1               | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
When I am on cost items page of cost title 'ARUBCTCT1'
Then I 'should' see following Cost Line Items:
| Section Name                | Cost Line Items                                                                                                                                                                                                                       |
| USAGE/BUYOUT/CONTRACT COSTS | USAGE/BUYOUT/CONTRACT COSTS;Item description;Usage/Residuals/Buyout Fee;Negotiation/broker agency fee;Other services & fees;Bonus (celebrity only);Base Compensation;Pension & Health (e.g. SAG);SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS |
| OTHER COSTS                 | OTHER COSTS;Item description;Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS                                                                                                                                      |
When I fill Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 0.50              | 0.50                       | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approvers available for selection when budget is less than ten thousand for Usage cost and Actor type for Greater China region
Meta:@adcost
     @approverRules
!--QA-650, QA-1067
Given I am on costs overview page
And created a new 'buyout' cost on AdCosts overview page
And filled Cost Details with following fields for 'buyout' cost:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | Original Estimate             | Actor | Usage                 | ARUBCTCT2  | ARUBCTD2    | Aaron Royer (Grey)  | ARUBCTD2               | Greater China | DefaultCampaign |  BFO         | USD - US Dollar          |
When I fill Cost Line Items with following fields for cost title 'ARUBCTCT2':
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 4000              | 1000                       | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT2':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approvers available for selection when budget is less than ten thousand for Buyout cost and Celebrity type for AAK region
Meta:@adcost
     @approverRules
!--QA-650, QA-1067
Given I am on costs overview page
And created a new 'buyout' cost on AdCosts overview page
And filled Cost Details with following fields for 'buyout' cost:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | Original Estimate             | Celebrity | Buyout                | ARUBCTCT3  | ARUBCTD3    | Aaron Royer (Grey)  | ARUBCTD3               | AAK           | DefaultCampaign |  BFO         | USD - US Dollar          |
When I fill Cost Line Items with following fields for cost title 'ARUBCTCT3':
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 6000              | 3999                       | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that All approvers are available for selection when budget is greater than ten thousand for Buyout cost and Celebrity type for Europe region
Meta:@adcost
     @approverRules
!--QA-650, QA-1067
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Buyout                | ARUBCTCT4  | ARUBCTD4    | Aaron Royer (Grey)  | ARUBCTD3               | Europe        | DefaultCampaign |  BFO         | USD - US Dollar          |
When I fill Cost Line Items with following fields for cost title 'ARUBCTCT4':
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 6000              | 7999                       | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT4':
| Technical Approver | Coupa Requisitioner       | Cost Consultant |
| IPMuser            | BrandManagementApprover   | CostConsultant  |


Scenario: Check that only IPM user and Brand Management Approvers available for selection when budget is greater than hundred thousand for Usage cost and Actor type for Latin America region
Meta:@adcost
     @approverRules
!--QA-650, QA-1067
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | OriginalEstimate              | Actor | Buyout                | ARUBCTCT5  | ARUBCTD5    | Aaron Royer (Grey)  | ARUBCTD2               | Latin America | DefaultCampaign |  BFO         | USD - US Dollar          |
When I fill Cost Line Items with following fields for cost title 'ARUBCTCT5':
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 80000             | 30000                      | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARUBCTCT5':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that only IPM user and Brand Management Approvers available for selection when budget is greater than hundred thousand for usage type cost and Film type for IMEA region
Meta:@adcost
     @approverRules
!--QA-650, QA-829, QA-1067
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Usage                 | ARUBCTCT6  | ARUBCTD6    | Aaron Royer (Grey)  | ARUBCTD6               | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARUBCTCT6':
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 60000             | 50000                      | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARUBCTCT6':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that only IPM user and Brand Management Approvers available for selection when budget is greater than ten thousand for usage type cost and Model type for JAPAN region
Meta:@adcost
     @approverRules
!--QA-650, QA-829, QA-1067
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Model | Usage                 | ARUBCTCT7  | ARUBCTD7    | Aaron Royer (Grey)  | ARUBCTD7               | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on cost items page of cost title 'ARUBCTCT7'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 8000              | 9000                       | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARUBCTCT7':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that only IPM user and Brand Management Approvers available for selection when budget is greater than houndred thousand for usage type cost and Film type for North America region
Meta:@adcost
     @approverRules
!--QA-650, QA-829, QA-1067
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract  | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Actor | Usage                  | ARUBCTCT8  | ARUBCTD8    | Aaron Royer (Grey)  | ARUBCTD7               | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on cost items page of cost title 'ARUBCTCT8'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 78000             | 29000                      | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT8':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARUBCTCT8':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand and less than hundred thousand for usage type cost and Model type for North America region
Meta:@adcost
     @approverRules
!--QA-650, QA-829, QA-1067
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Model | Usage                 | ARUBCTCT9  | ARUBCTD9    | Aaron Royer (Grey)  | ARUBCTD9               | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on cost items page of cost title 'ARUBCTCT9'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 18000             | 49000                      | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT9':
| Technical Approver | Coupa Requisitioner       | Cost Consultant |
| IPMuser            | BrandManagementApprover   | CostConsultant  |


Scenario: Check that only IPM user and Brand Management Approvers available for selection when budget is more than hundred thousand for contract type cost and Actor type for North America region for Cyclone Agency
Meta:@adcost
     @approverRules
!--QA-650, QA-829, QA-1067
Given I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number            | New  | Approval stage for submission | Type  | Usage/Buyout/Contract  | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | true | OriginalEstimate              | Actor | Buyout                 | ARUBCTCT10  | ARUBCTD10   | Aaron Royer (Grey)  | ARUBCTD10              | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on cost items page of cost title 'ARUBCTCT10'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 50000             | 11000                      |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT10':
| Technical Approver | Brand Management Approver | Cost Consultant |
| IPMuser            | BrandManagementApprover   | CostConsultant  |
When I fill Cost Line Items with following fields for cost title 'ARUBCTCT10':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 50000             | 51000                      |
Then I 'should' see below approvers on approval form page for cost title 'ARUBCTCT10':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARUBCTCT10':
| Cost Consultant |
| CostConsultant  |