Feature: Digital Content Type
Narrative:
In order to
As a CostOwner
I want to check Approvers in Adcost module for Digital Content Type

Scenario: Check that both Techincal and Brand Management Approvers are available for selection when budget is greater than ten thousand for Digital content type within AAK region
Meta:@adcost
     @approverRules
!--QA-633, QA-829, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARDCTCT1   | ARDCTD1     | Aaron Royer (Grey)  | 20000                | Digital Development | ARDCTATN1              | AAK            | DefaultCampaign | BFO          | USD - US Dollar         |
When I am on production details page of cost title 'ARDCTCT1'
Then I 'should' see info as 'Fill all the required information about your Digital Development.' on Production details page
When I am on cost items page of cost title 'ARDCTCT1'
Then I 'should' see following Cost Line Items:
| Section Name                 | Cost Line Items                                                                                                                                                                                              |
| Digital Production cost      | DIGITAL PRODUCTION COST;Item description;Master;Adaptation;Social;Project Management/Producer;Digital Strategy/Design;Development;Quality Assurance;Mark up (if applicable);SUBTOTAL DIGITAL PRODUCTION COST |
| Digital Post Production cost | DIGITAL POST PRODUCTION COST;Item description;SAAS Licensing;UGC Integration;Virtual Reality;Augmented Reality;Hosting Microsite;Mark up (if applicable);SUBTOTAL DIGITAL POST PRODUCTION COST               |
| Other costs                  | OTHER COSTS;Item description;Tax (if applicable);P&G insurance;Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS                                                                           |
When I fill Cost Line Items with following fields:
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 8000       | 3000            | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARDCTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARDCTCT1':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that both Techincal and Brand Management Approvers are available for selection when budget is greater than ten thousand for Digital content type within Japan region
Meta:@adcost
     @approverRules
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-655, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARDCTCT2   | ARDCTD2     | Aaron Royer (Grey)  | 20000                | Digital Development | ARDCTATN2              | Japan          | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARDCTCT2':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 8000       | 3000            | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARDCTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARDCTCT2':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Digital Content Type within AAK region
Meta:@adcost
     @approverRules
!--QA-632, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARDCTCT3   | ARDCTD3     | Aaron Royer (Grey)  | 20000                | Digital Development | ARDCTATN3              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARDCTCT3':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 8000       | 300             | 1000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARDCTCT3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Digital Content Type within Greater China region
Meta:@adcost
     @approverRules
!--QA-643, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARDCTCT4   | ARDCTD4     | Aaron Royer (Grey)  | 20000                | Digital Development | ARDCTATN4              | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARDCTCT4':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 8000       | 300             | 1000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARDCTCT4':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Digital Content Type within Latin America region
Meta:@adcost
     @approverRules
!--QA-654, QA-1067
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARDCTCT5   | ARDCTD5     | Aaron Royer (Grey)  | 20000                | Digital Development | ARDCTATN5              | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARDCTCT5':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 8000       | 300             | 1000          | 1234567890                        |
And I am on cost approval page of cost title 'ARDCTCT5'
Then I 'should' see below approvers on approval form page for cost title 'ARDCTCT5':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand for Digital Content Type within North America region
Meta:@adcost
     @approverRules
!--QA-654, QA-1067
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARDCTCT6   | ARDCTD6     | Aaron Royer (Grey)  | 20000                | Digital Development | ARDCTATN5              | North America | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARDCTCT6':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 8000       | 3000            | 9000          | 1234567890                        |
And I am on cost approval page of cost title 'ARDCTCT6'
Then I 'should' see below approvers on approval form page for cost title 'ARDCTCT6':
| Technical Approver | Coupa Requisitioner       | Cost Consultant |
| IPMuser            | BrandManagementApprover   | CostConsultant  |

Scenario: Check that only IPM user and Brand management Approvers are available for selection when budget is greater than hundred thousand for Digital Content Type within IMEA region
Meta:@adcost
     @approverRules
!--QA-654, QA-1067
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARDCTCT7   | ARDCTD7     | Aaron Royer (Grey)  | 20000                | Digital Development | ARDCTATN7              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARDCTCT7':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 90000      | 9000            | 9000          | 1234567890                        |
And I am on cost approval page of cost title 'ARDCTCT7'
Then I 'should' see below approvers on approval form page for cost title 'ARDCTCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
Then I 'should not' see below approvers on approval form page for cost title 'ARDCTCT7':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand for Digital Content Type within Europe region
Meta:@adcost
     @approverRules
!--QA-654, QA-1067
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARDCTCT8   | ARDCTD5     | Aaron Royer (Grey)  | 20000                | Digital Development | ARDCTATN5              | Europe         | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARDCTCT8':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 8000       | 3000            | 1000          | 1234567890                        |
And I am on cost approval page of cost title 'ARDCTCT8'
Then I 'should' see below approvers on approval form page for cost title 'ARDCTCT8':
| Technical Approver | Coupa Requisitioner       | Cost Consultant |
| IPMuser            | BrandManagementApprover   | CostConsultant  |