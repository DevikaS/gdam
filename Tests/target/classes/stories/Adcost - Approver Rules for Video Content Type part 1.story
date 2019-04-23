Feature: Video Content Type
Narrative:
In order to
As a CostOwner
I want to check Approvers in Adcost module for Video Content Type


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Video Content Type and PostProduction Only within AAK region
Meta:@adcost
     @approverRules
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-639, QA-829, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTD1    | ARVCTD1     | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | ARVCTAT1               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I am on cost items page of cost title 'ARVCTD1'
Then I 'should' see following Cost Line Items:
| Section Name         | Cost Line Items                                                                                                                                                          |
| Post Production cost | POST PRODUCTION COST;Item description;Offline edits;Audio finalization;Online video finalization;CGI/animation;PPH mark up (if applicable);SUBTOTAL POST PRODUCTION COST |
| Agency costs         | AGENCY COSTS;Item description;Agency artwork/packs;Agency travel;Insurance (if not covered by P&G);Music;SUBTOTAL AGENCY COSTS                                                  |
| Other costs          | OTHER COSTS;Item description;Tax (if applicable);P&G insurance;Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS                                       |
When I fill Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 3000               | 3000          | 3000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTD1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Video Content Type and PostProduction Only within Greater China region
Meta:@adcost
     @approverRules
!--QA-645, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTD2    | ARVCTD2     | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | ARVCTAT2               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When fill Cost Line Items with following fields for cost title 'ARVCTD2':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 3000               | 3000          | 3000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTD2':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Video Content Type and PostProduction Only within Japan region
Meta:@adcost
     @approverRules
!--QA-658, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTD3    | ARVCTD3     | Aaron Royer (Grey)  | 9000                 | Video        | Full Production  | ARVCTAT3               | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
When fill Cost Line Items with following fields for cost title 'ARVCTD3':
| Audio finalization | Offline edits | Please enter a 10-digit IO number |
| 3000               | 3000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTD3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only IPM user and Brand Management Approver is available for selection when budget is greater than ten thousand for Video Content Type and CGI Animation within AAK region
Meta:@adcost
     @approverRules
!--QA-639, QA-829, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTD4    | ARVCTD4     | Aaron Royer (Grey)  | 9000                 | Video        | CGI/Animation   | ARVCTAT4               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I am on cost items page of cost title 'ARVCTD4'
Then I 'should' see following Cost Line Items:
| Section Name         | Cost Line Items                                                                                                                                                          |
| Post Production cost | POST PRODUCTION COST;Item description;Offline edits;Audio finalization;Online video finalization;CGI/animation;PPH mark up (if applicable);SUBTOTAL POST PRODUCTION COST |
| Agency costs         | AGENCY COSTS;Item description;Agency artwork/packs;Agency travel;Insurance (if not covered by P&G);Music;SUBTOTAL AGENCY COSTS                                                  |
| Other costs          | OTHER COSTS;Item description;Tax (if applicable);P&G insurance;Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS                                       |
When I fill Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 3000               | 8000          | 3000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTD4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
Then I 'should not' see below approvers on approval form page for cost title 'ARVCTD4':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that only IPM user and Brand Management Approver is available for selection when budget is greater than hundred thousand for Video Content Type and CGI Animation within Greater China region
Meta:@adcost
     @approverRules
!--QA-645, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTD5    | ARVCTD5     | Aaron Royer (Grey)  | 9000                 | Video        | CGI/Animation   | ARVCTAT5               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When fill Cost Line Items with following fields for cost title 'ARVCTD5':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 35000              | 50000         | 30000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTD5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
Then I 'should not' see below approvers on approval form page for cost title 'ARVCTD5':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Video Content Type and CGI Animation within Japan region
Meta:@adcost
     @approverRules
!--QA-658, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTD6    | ARVCTD6     | Aaron Royer (Grey)  | 9000                 | Video        | CGI/Animation   | ARVCTAT6               | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
When I am on production details page of cost title 'ARVCTD6'
Then I 'should' see info as 'Fill all the required information about your Video CGI/Animation.' on Production details page
When fill Cost Line Items with following fields for cost title 'ARVCTD6':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 3000               | 3000          | 3000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTD6':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approver is available for selection when budget is less than ten thousand for Video Content Type and Full Production within IMEA region
Meta:@adcost
     @approverRules
!--QA-639, QA-829, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTCT7   | ARVCTD7     | Aaron Royer (Grey)  | 9000                 | Video        | Full Production | ARVCTAT7               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
When I am on production details page of cost title 'ARVCTCT7'
Then I 'should' see info as 'Fill all the required information about your Video Full Production.' on Production details page
When I am on cost items page of cost title 'ARVCTCT7'
Then I 'should' see following Cost Line Items:
| Section Name         | Cost Line Items                                                                                                                                                                                                                                                                |
| Production cost      | PRODUCTION COST;Item description;Pre production/casting;Talent fees;Director fees;Crew salaries;Equipment;Transport/catering;Art department;Travel (exc. Agency travel);Insurance (if not covered by P&G);Directors cut (if managed by PH);PH mark up;SUBTOTAL PRODUCTION COST |
| Post Production cost | POST PRODUCTION COST;Item description;Offline edits;Audio finalization;Online video finalization;CGI/animation;PPH mark up (if applicable);SUBTOTAL POST PRODUCTION COST                                                                                                       |
| Agency costs         | AGENCY COSTS;Item description;Agency Artwork/packs;Agency travel;Music;Casting;Insurance;SUBTOTAL AGENCY COSTS                                                                                                                                                                 |
| Other costs          | OTHER COSTS;Item description;Tax (if applicable);P&G insurance;Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS                                                                                                                                             |
When I fill Cost Line Items with following fields:
| Audio finalization | Offline edits | P&G insurance | Please enter a 10-digit IO number |
| 3000               | 3000          | 3000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTCT7':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that All approvers are available for selection when budget is greater than ten thousand for Video Content Type and Full Production within Greater China region
Meta:@adcost
     @approverRules
!--QA-645, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTCT8   | ARVCTD8     | Aaron Royer (Grey)  | 9000                 | Video        | Full Production | ARVCTAT8               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When fill Cost Line Items with following fields for cost title 'ARVCTCT8':
| Audio finalization | Offline edits | P&G insurance | Please enter a 10-digit IO number |
| 3000               | 8000          | 3000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTCT8':
| Technical Approver | Coupa Requisitioner       | Cost Consultant |
| IPMuser            | BrandManagementApprover   | CostConsultant  |


Scenario: Check that only IPM user and Brand Management Approver is available for selection when budget is greater than hundred thousand for Video Content Type and FullProduction within Latin America region
Meta:@adcost
     @approverRules
!--QA-658, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTCT9   | ARVCTD9     | Aaron Royer (Grey)  | 9000                 | Video        | Full Production | ARVCTAT9               | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
When fill Cost Line Items with following fields for cost title 'ARVCTCT9':
| Audio finalization | Offline edits | P&G insurance | Please enter a 10-digit IO number |
| 30000              | 40000         | 35000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTCT9':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARVCTCT9':
| Cost Consultant |
| CostConsultant  |

Scenario: Check that both Techincal and Brand Management Approvers are available for selection when budget is greater than ten thousand for Video Content Type and PostProduction Only within AAK region
Meta:@adcost
     @approverRules
!--QA-640, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTCT10  | ARVCTD10    | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | ARVCTAT10              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I am on production details page of cost title 'ARVCTCT10'
Then I 'should' see info as 'Fill all the required information about your Video Post Production.' on Production details page
When I fill Cost Line Items with following fields for cost title 'ARVCTCT10':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTCT10':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARVCTCT10':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand for Video Content Type and PostProduction Only within IMEA region
Meta:@adcost
     @approverRules
!--QA-647, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARVCTCT11  | ARVCTD11    | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | ARVCTAT11              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARVCTCT11':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 64000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARVCTCT11':
| Technical Approver | Coupa Requisitioner       | Cost Consultant |
| IPMuser            | BrandManagementApprover   | CostConsultant  |