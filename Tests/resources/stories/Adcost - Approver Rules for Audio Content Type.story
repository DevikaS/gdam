Feature: Audio Content Type
Narrative:
In order to
As a CostOwner
I want to check Approvers in Cost module for Audio Content Type

Scenario: Check that both Techincal and Brand Management Approvers are available for selection when budget is greater than ten thousand for Audio content type and Full Production type within AAK region
Meta:@adcost
     @approverRules
!--QA-631, QA-829, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT1   | ARACTD1     | Aaron Royer (Grey)  | 20000                | Audio        | Full Production | ARACTATN1              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I am on production details page of cost title 'ARACTCT1'
Then I 'should' see info as 'Fill all the required information about your Audio Full Production.' on Production details page
When I am on cost items page of cost title 'ARACTCT1'
Then I 'should' see following Cost Line Items:
| Section Name | Cost Line Items                                                                                                                                                                      |
| Studio costs | STUDIO COSTS;Item description;Talent fees;VO recording sessions;Sound design & final mix;Music composition & recording sessions;Studio mark up (if applicable);SUBTOTAL STUDIO COSTS |
| Other costs  | OTHER COSTS;Item description;Tax (if applicable);P&G insurance;Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS                                                   |
When I fill Cost Line Items with following fields:
| Talent fees | FX (Loss) & Gain | P&G insurance | Please enter a 10-digit IO number |
| 8000        | 3000             | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARACTCT1':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand for Audio content type and Full Production type within Greater China region
Meta:@adcost
     @approverRules
!--QA-653, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT2   | ARACTD2     | Aaron Royer (Grey)  | 20000                | Audio        | Full Production | ARACTATN2              | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARACTCT2':
| Talent fees | FX (Loss) & Gain | P&G insurance | Please enter a 10-digit IO number |
| 8000        | 3000             | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT2':
| Technical Approver | Cost Consultant | Coupa Requisitioner       |
| IPMuser            | CostConsultant  | BrandManagementApprover   |


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand for Audio content type and Post Production for Latin America region
Meta:@adcost
     @approverRules
!--QA-631, QA-829, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency | AIPE  |
| DefaultCostProject | ARACTCT3   | ARACTD3     | Aaron Royer (Grey)  | 100000               | Audio        | Post Production Only | ARACTATN3              | Latin America  | DefaultCampaign | BFO          | USD - US Dollar         | false |
When I am on production details page of cost title 'ARACTCT3'
Then I 'should' see info as 'Fill all the required information about your Audio Post Production.' on Production details page
When I am on cost items page of cost title 'ARACTCT3'
Then I 'should' see following Cost Line Items:
| Section Name | Cost Line Items                                                                                                                                                                      |
| Studio costs | STUDIO COSTS;Item description;Talent fees;VO recording sessions;Sound design & final mix;Music composition & recording sessions;Studio mark up (if applicable);SUBTOTAL STUDIO COSTS |
| Other costs  | OTHER COSTS;Item description;Tax (if applicable);P&G insurance;Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS                                                   |
When I fill Cost Line Items with following fields:
| Talent fees | VO recording sessions | P&G insurance | Please enter a 10-digit IO number |
| 8000        | 3000                  | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT3':
| Technical Approver | Cost Consultant | Coupa Requisitioner       |
| IPMuser            | CostConsultant  | BrandManagementApprover   |


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand for Audio content type and Post Production Only within IMEA region
Meta:@adcost
     @approverRules
!--QA-653, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT4   | ARACTD4     | Aaron Royer (Grey)  | 10000                | Audio        | Post Production Only | ARACTATN4              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARACTCT4':
| Talent fees | VO recording sessions | P&G insurance | Please enter a 10-digit IO number |
| 8000        | 3000                  | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT4':
| Technical Approver | Cost Consultant | Coupa Requisitioner       |
| IPMuser            | CostConsultant  | BrandManagementApprover   |


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Audio Content Type and Post Production type within AAK region
Meta:@adcost
     @approverRules
!--QA-630, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT5   | ARACTD5     | Aaron Royer (Grey)  | 9000                 | Audio        | Post Production Only | ARACTATN5              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARACTCT5':
| Talent fees | VO recording sessions | P&G insurance | Please enter a 10-digit IO number |
| 5000        | 3000                  | 1000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT5':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Audio Content Type and Post Production type within North America region
Meta:@adcost
     @approverRules
!--QA-642, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT6   | ARACTD6     | Aaron Royer (Grey)  | 9000                 | Audio        | Post Production Only | ARACTATN6              | North America | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARACTCT6':
| Talent fees | VO recording sessions | P&G insurance | Please enter a 10-digit IO number |
| 5000        | 3000                  | 1000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT6':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Audio Content Type and Post Production type within Japan region
Meta:@adcost
     @approverRules
!--QA-652, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT7   | ARACTD7     | Aaron Royer (Grey)  | 9000                 | Audio        | Post Production Only | ARACTATN7              | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARACTCT7':
| Talent fees | VO recording sessions | P&G insurance | Please enter a 10-digit IO number |
| 5000        | 3000                  | 1000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT7':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Audio Content Type and Full Production type within AAK region
Meta:@adcost
     @approverRules
!--QA-630, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT8   | ARACTD8     | Aaron Royer (Grey)  | 9000                 | Audio        | Full Production | ARACTATN8              | AAK            | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARACTCT8':
| Talent fees | Sound design & final mix | P&G insurance | Please enter a 10-digit IO number |
| 5000        | 3000                     | 1000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT8':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Audio Content Type and Full Production type within Greater China region
Meta:@adcost
     @approverRules
!--QA-642, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT9   | ARACTD9     | Aaron Royer (Grey)  | 9000                 | Audio        | Full Production | ARACTATN9              | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARACTCT9':
| Talent fees | Sound design & final mix | P&G insurance | Please enter a 10-digit IO number |
| 5000        | 3000                     | 1000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT9':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Audio Content Type and Full Production type within Europe region
Meta:@adcost
     @approverRules
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-652, QA-1067
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT10  | ARACTD10    | Aaron Royer (Grey)  | 9000                 | Audio        | Full Production | ARACTATN10             | Europe         | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARACTCT10':
| Talent fees | Sound design & final mix | P&G insurance | Please enter a 10-digit IO number |
| 5000        | 3000                     | 1000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT10':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only IPM user and Brand Management Approver is available for selection when budget is greater than hundred thousand for Audio Content Type and Full Production type within Greater China region
Meta:@adcost
     @approverRules
!--QA-642, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARACTCT11   | ARACTD9     | Aaron Royer (Grey)  | 9000                 | Audio        | Full Production | ARACTATN9              | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARACTCT11':
| Talent fees | Sound design & final mix | P&G insurance | Please enter a 10-digit IO number |
| 50000       | 30000                    | 30000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARACTCT11':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'should not' see below approvers on approval form page for cost title 'ARACTCT11':
| Cost Consultant|
| CostConsultant |