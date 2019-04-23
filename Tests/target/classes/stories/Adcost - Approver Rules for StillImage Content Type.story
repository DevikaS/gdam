Feature: Still Image Content Type
Narrative:
In order to
As a CostOwner
I want to check Approvers in Adcost module for Still Image Content Type


Scenario: Check that both Techincal and Brand Management Approvers are available for selection when budget is greater than ten thousand for Still Image content type and Full Production type for AAK region
Meta:@adcost
     @approverRules
!--QA-638, QA-829, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT1  | ARSICTD1    | Aaron Royer (Grey)  | 20000                | Still Image  | Full Production | ARSICTATN1             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I am on production details page of cost title 'ARSICTCT1'
Then I 'should' see info as 'Fill all the required information about your Still Image Full Production.' on Production details page
When I am on cost items page of cost title 'ARSICTCT1'
Then I 'should' see following Cost Line Items:
| Section Name                     | Cost Line Items                                                                                                                                                                                                                                                      |
| Still Image Production cost      | STILL IMAGE PRODUCTION COST;Item description;Preproduction;Talent fees;Photographer;Crew salaries;Equipment;Location/studio/art department/sets;Travel (excl. Agency);Insurance (if not covered by P&G);Mark up (if applicable);SUBTOTAL STILL IMAGE PRODUCTION COST |
| Still Image Post Production cost | STILL IMAGE POST PRODUCTION COST;Item description;Retouching;Artwork/packs;Mark up (if applicable);SUBTOTAL STILL IMAGE POST PRODUCTION COST                                                                                                                         |
| Agency costs                     | AGENCY COSTS;Item description;Agency Artwork / Packs;Agency Travel;SUBTOTAL AGENCY COSTS                                                                                                                                                                             |
| Other costs                      | OTHER COSTS;Item description;Tax (if applicable);P&G insurance;Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS                                                                                                                                   |
When I fill Cost Line Items with following fields:
| Photographer | Retouching | P&G insurance | Please enter a 10-digit IO number |
| 8000         | 3000       | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARSICTCT1':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand for Still Image content type and Full Production within Greater China region
Meta:@adcost
     @approverRules
!--QA-646, QA-1067,
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT2  | ARSICTD2    | Aaron Royer (Grey)  | 2000                 | Still Image  | Full Production | ARSICTATN2             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT2':
| Photographer | Retouching | P&G insurance | Please enter a 10-digit IO number |
| 8000         | 3000       | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT2':
| Technical Approver | Cost Consultant | Coupa Requisitioner       |
| IPMuser            | CostConsultant  | BrandManagementApprover   |


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand for Still Image content type and Full Production within Europe region
Meta:@adcost
     @approverRules
!--QA-657, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT3  | ARSICTD3    | Aaron Royer (Grey)  | 2000                 | Still Image  | Full Production | ARSICTATN3             | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT3':
| Photographer | Retouching | P&G insurance | Please enter a 10-digit IO number |
| 8000         | 3000       | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT3':
| Technical Approver | Coupa Requisitioner       | Cost Consultant |
| IPMuser            | BrandManagementApprover   | CostConsultant  |


Scenario: Check that All Approvers are available for selection when budget is greater than ten thousand for Still Image content type and Full Production within Latin America region
Meta:@adcost
     @approverRules
!--QA-638, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT3_1 | ARSICTD3_1  | Aaron Royer (Grey)  | 2000                 | Still Image  | Full Production | ARSICTATN3_1           | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT3_1':
| Photographer | Retouching | P&G insurance | Please enter a 10-digit IO number |
| 8000         | 3000       | 10000         | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT3_1':
| Technical Approver | Cost Consultant | Coupa Requisitioner       |
| IPMuser            | CostConsultant  | BrandManagementApprover   |


Scenario: Check that both Techincal and Brand Management Approvers are available for selection when budget is greater than ten thousand for Still Image content type and Post Production Only with North America region
Meta:@adcost
     @approverRules
!--QA-646, QA-829, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT4  | ARSICTD4    | Aaron Royer (Grey)  | 2000                 | Still Image  | Post Production Only | ARSICTATN4             | North America  | DefaultCampaign | BFO          | USD - US Dollar         |
When I am on production details page of cost title 'ARSICTCT4'
Then I 'should' see info as 'Fill all the required information about your Still Image Post Production.' on Production details page
When I am on cost items page of cost title 'ARSICTCT4'
Then I 'should' see following Cost Line Items:
| Section Name                     | Cost Line Items                                                                                                                              |
| Still Image Post Production cost | STILL IMAGE POST PRODUCTION COST;Item description;Retouching;Artwork/packs;Mark up (if applicable);SUBTOTAL STILL IMAGE POST PRODUCTION COST |
| Agency costs                     | AGENCY COSTS;Item description;Agency Artwork / Packs;Agency Travel;SUBTOTAL AGENCY COSTS                                                     |
| Other costs                      | OTHER COSTS;Item description;Tax (if applicable);P&G insurance;Technical fee (if applicable);FX (Loss) & Gain;SUBTOTAL OTHER COSTS           |
When I fill Cost Line Items with following fields:
| Retouching | Please enter a 10-digit IO number |
| 31000      | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT4':
| Technical Approver | Coupa Requisitioner       | Cost Consultant |
| IPMuser            | BrandManagementApprover   | CostConsultant  |


Scenario: Check that both Techincal and Brand Management Approvers are available for selection when budget is greater than ten thousand for Still Image content type and Post Production Only with Japan region
Meta:@adcost
     @approverRules
!--QA-657, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT5  | ARSICTD5    | Aaron Royer (Grey)  | 2000                 | Still Image  | Post Production Only | ARSICTATN5             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT5':
| Retouching | Please enter a 10-digit IO number |
| 31000      | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARSICTCT5':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that both Techincal and Brand Management Approvers are available for selection when budget is greater than ten thousand for Still Image content type and Post Production Only with AAK region
Meta:@adcost
     @approverRules
!--QA-638, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT6  | ARSICTD6    | Aaron Royer (Grey)  | 2000                 | Still Image  | Post Production Only | ARSICTATN6             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT6':
| Retouching | Please enter a 10-digit IO number |
| 31000      | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'should not' see below approvers on approval form page for cost title 'ARSICTCT6':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that only Brand Management Approvers is available for selection when budget is less than ten thousand for Still Image content type and Full Production type with AIPE for AAK region
Meta:@adcost
     @approverRules
!--QA-637, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE  |
| DefaultCostProject  | ARSICTCT7  | ARSICTD7    | Aaron Royer (Grey) | 200                  | Still Image  | Full Production | ARSICTATN7             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | false |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT7':
| Photographer | Retouching | P&G insurance | Please enter a 10-digit IO number |
| 8000         | 1000       | 100           | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT7':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approvers are available for selection when budget is less than ten thousand for Still Image content type and Full Production within Greater China region
Meta:@adcost
     @approverRules
!--QA-644, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT8  | ARSICTD8    | Aaron Royer (Grey)  | 2000                 | Still Image  | Full Production | ARSICTATN8             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT8':
| Photographer | Retouching | P&G insurance | Please enter a 10-digit IO number |
| 6000         | 3000       | 100           | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT8':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approvers are available for selection when budget is less than ten thousand for Still Image content type and Full Production within Japan region
Meta:@adcost
     @approverRules
!--QA-656, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT9  | ARSICTD9    | Aaron Royer (Grey)  | 2000                 | Still Image  | Full Production | ARSICTATN9             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT9':
| Photographer | Retouching | P&G insurance | Please enter a 10-digit IO number |
| 6000         | 3000       | 100           | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT9':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approvers are available for selection when budget is less than ten thousand for Still Image content type and Full Production within AAK region
Meta:@adcost
     @approverRules
!--QA-637, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT9_1 | ARSICTD9_1  | Aaron Royer (Grey)  | 2000                 | Still Image  | Full Production | ARSICTATN9_1           | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT9_1':
| Photographer | Retouching | P&G insurance | Please enter a 10-digit IO number |
| 6000         | 3000       | 100           | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT9_1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approvers are available for selection when budget is less than ten thousand for Still Image content type and Post Production Only within Greater China region
Meta:@adcost
     @approverRules
!--QA-644, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT10 | ARSICTD10   | Aaron Royer (Grey)  | 2000                 | Still Image  | Post Production Only | ARSICTATN10            | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT10':
| Retouching | Please enter a 10-digit IO number |
| 9100       | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT10':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approvers are available for selection when budget is less than ten thousand for Still Image content type and Post Production Only within IMEA region
Meta:@adcost
     @approverRules
!--QA-656, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT11 | ARSICTD11   | Aaron Royer (Grey)  | 2000                 | Still Image  | Post Production Only | ARSICTATN11            | IMEA         | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT11':
| Retouching | Please enter a 10-digit IO number |
| 9100       | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT11':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only Brand Management Approvers are available for selection when budget is less than ten thousand for Still Image content type and Post Production Only within AAK region
Meta:@adcost
     @approverRules
!--QA-637, QA-1067
Given I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT12 | ARSICTD12   | Aaron Royer (Grey)  | 2000                 | Still Image  | Post Production Only | ARSICTATN12            | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT12':
| Retouching | Please enter a 10-digit IO number |
| 9100       | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT12':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And 'should not' see 'technical' approver section on cost approval page


Scenario: Check that only IPM and Brand Management Approvers are available for selection when budget is greater than Hundred thousand for Still Image content type for China region and Full Production
Meta:@adcost
     @approverRules
!--QA-648, QA-1067
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | ARSICTCT13 | ARSICTD13   | Aaron Royer (Grey)  | 2000                 | Still Image  | Full Production | ARSICTATN13            | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT13':
| Photographer | Retouching | P&G insurance | Please enter a 10-digit IO number |
| 80000        | 30000      | 1100          | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT13':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
Then I 'should not' see below approvers on approval form page for cost title 'ARSICTCT13':
| Cost Consultant |
| CostConsultant  |


Scenario: Check that only IPM and Brand Management Approvers are available for selection when budget is greater than Hundred thousand for Still Image content type for China region and Post Production Only
Meta:@adcost
     @approverRules
!--QA-648, QA-1067
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And filled Cost Details with following fields for 'production' cost:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation |
| DefaultCostProject | ARSICTCT14 | ARSICTD14   | Aaron Royer (Grey)  | 120000               | Still Image  | Post Production Only | ARSICTATN14            | Greater China | DefaultCampaign | BFO          |
When I fill Cost Line Items with following fields for cost title 'ARSICTCT14':
| Retouching | Please enter a 10-digit IO number |
| 101000     | 1234567890                        |
Then I 'should' see below approvers on approval form page for cost title 'ARSICTCT14':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
Then I 'should not' see below approvers on approval form page for cost title 'ARSICTCT14':
| Cost Consultant |
| CostConsultant  |