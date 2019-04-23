Feature: check Cost Consultant Technical Fee
Narrative:
In order to
As a CostOwner
I want to check Cost Consultant Technical Fee


Scenario: Check that correct Cost consultant technical fee is applied for usage buyout cost
Meta:@adcost
!--QA-810
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | CCTFCT1    | CCTFCD1     | Aaron Royer (Grey)  | CCTFATN1               | IMEA          | DefaultCampaign |  BFO         | GBP - British Pound     |
And added UsageBuyout details for cost title 'CCTFCT1' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 10000          |
And added negotiated terms page for cost title 'CCTFCT1' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CCTFCT1'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 15000             | 20000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCTFCT1':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CCTFCT1':
| Technical Approver | Coupa Requisitioner       |
| CostConsultant     | BrandManagementApprover   |
And refreshed the page without delay
And I am on cost approval page of cost title 'CCTFCT1'
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'CCTFCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate Local | Original Estimate |
| Usage/Residuals/Buyout Fee    | £ 20,000.00             | $ 24,366.47       |
| Base Compensation             | £ 15,000.00             | $ 18,274.85       |
| Technical fee (if applicable) | £ 115.00                | $ 140.11          |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCTFCT1'
And cost with title 'CCTFCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'CCTFCT1'
And I upload following supporting documents to cost title 'CCTFCT1':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I 'Submit' the cost with title 'CCTFCT1'
And I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCTFCT1'
And cost with title 'CCTFCT1' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCTFCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Usage/Residuals/Buyout Fee           | $ 24,366.47       | £ 20,000.00        | $ 24,366.47  |
| Base Compensation                    | $ 18,274.85       | £ 15,000.00        | $ 18,274.85  |
| Technical fee (if applicable)        | $ 140.11          | £ 115.00           | $ 140.11     |



Scenario: Check that Cost consultant technical fee must remain even if they are replaced at subsequent cost stage by a IPM Technical approver.
Meta:@adcost
!--QA-810
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description  | Agency Producer/Art  | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCTFCT2    | CCTFCD2      | Aaron Royer (Grey)   | 50000                | Digital Development | CCTFATN2               | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCTFCT2' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'CCTFCT2':
| Initiative | Asset Title | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CCTFAT2     | Digital          | 12/12/2019               | Yes      | Yes       | IMEA    |
And filled Cost Line Items with following fields for cost title 'CCTFCT2':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000        | 20000           | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCTFCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCTFCT2':
| Technical Approver | Coupa Requisitioner       |
| CostConsultant     | BrandManagementApprover   |
And refreshed the page without delay
And I am on cost approval page of cost title 'CCTFCT2'
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'CCTFCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate Local | Original Estimate |
| Adaptation                    | $ 30,000.00             | $ 30,000.00       |
| Virtual Reality               | $ 20,000.00             | $ 20,000.00       |
| P&G insurance                 | $ 10,000.00             | $ 10,000.00       |
| Technical fee (if applicable) | $ 433.00                | $ 433.00          |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCTFCT2'
And cost with title 'CCTFCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCTFCT2'
And click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CCTFCT2':
| Adaptation   | Virtual Reality | P&G insurance |
| 32000        | 25000           | 13000         |
And I upload following supporting documents to cost title 'CCTFCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCTFCT2'
And I am on cost review page of cost item with title 'CCTFCT2'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Current Revision Local | Current Revision |
| Adaptation                    | $ 30,000.00       | $ 32,000.00            | $ 32,000.00      |
| Virtual Reality               | $ 20,000.00       | $ 25,000.00            | $ 25,000.00      |
| P&G insurance                 | $ 10,000.00       | $ 13,000.00            | $ 13,000.00      |
| Technical fee (if applicable) | $ 433.00          | $ 433.00               | $ 433.00         |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCTFCT2'
And cost with title 'CCTFCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCTFCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'CCTFCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I am on cost approval page of cost title 'CCTFCT2'
And I 'Delete' approver 'CostConsultant' from 'technical' approver section on approvals page
And fill below approvers for cost title 'CCTFCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'CCTFCT2'
And I am on cost review page of cost item with title 'CCTFCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Final Actual Local | Final Actual |
| Adaptation                    | $ 30,000.00       | $ 32,000.00        | $ 32,000.00  |
| Virtual Reality               | $ 20,000.00       | $ 25,000.00        | $ 25,000.00  |
| P&G insurance                 | $ 10,000.00       | $ 13,000.00        | $ 13,000.00  |
| Technical fee (if applicable) | $ 433.00          | $ 433.00           | $ 433.00     |



Scenario: Check that correct Cost consultant technical fee is applied within Greater China region for Still Image and Full production cost
Meta:@adcost
!--QA-810
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description  | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCTFCT3    | CCTFD3       | Christine Meyer (Leo Burnett) | 12000                | Still Image  | Full Production | CCTFATN3               | Greater China | DefaultCampaign | BFO          | HKD - Hong Kong Dollar  |
And added production details for cost title 'CCTFCT3' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And added expected asset details for cost title 'CCTFCT3':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CCTFAT3     |  Version | Digital          | 12/12/2019               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CCTFCT3':
| Preproduction | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 50000         | 30000      | 20000            | 1234567890                        |
And uploaded following supporting documents to cost title 'CCTFCT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCTFCT3':
| Technical Approver | Coupa Requisitioner       |
| CostConsultant     | BrandManagementApprover   |
And refreshed the page without delay
And I am on cost approval page of cost title 'CCTFCT3'
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'CCTFCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate Local | Original Estimate |
| Preproduction                 | $ 50,000.00             | $ 6,443.55        |
| Retouching                    | $ 30,000.00             | $ 3,866.13        |
| FX (Loss) & Gain              | $ 20,000.00             | $ 2,577.42        |
| Technical fee (if applicable) | $ 2,736.55              | $ 352.66          |



Scenario: Check that correct Cost consultant technical fee is applied within Greater China region for Video and post production cost
Meta:@adcost
!--QA-810
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCTFCT4    | CCTFCTD1    | Aaron Royer (Grey)  | 15000                | Video        | Post Production Only | CCTFCTATN4             | Greater China | DefaultCampaign | BFO          | HKD - Hong Kong Dollar  |
And added production details for cost title 'CCTFCT4' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCTFCT4':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCTFCTAT4   | 10:10:10          | Version | Tv               | 12/31/2019               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCTFCT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 80000              | 90000         | 70000          | 1234567890                       |
And uploaded following supporting documents to cost title 'CCTFCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCTFCT4':
| Technical Approver | Coupa Requisitioner     |
| CostConsultant     | BrandManagementApprover |
And refreshed the page without delay
And I am on cost approval page of cost title 'CCTFCT4'
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'CCTFCT4'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate Local | Original Estimate |
| Offline edits                 | $ 90,000.00             | $ 11,598.39       |
| Audio finalization            | $ 80,000.00             | $ 10,309.68       |
| Agency travel                 | $ 70,000.00             | $ 9,020.97        |
| Technical fee (if applicable) | $ 652.00                | $ 84.02           |



Scenario: Check that correct Cost consultant technical fee is applied within North Ameria region for Video and CGI/Animation cost
Meta:@adcost
!--QA-810
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCTFCT5    | CCTFCTD5    | Aaron Royer (Grey)  | 15000                | Video        | CGI/Animation    | CCTFCTATN5             | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCTFCT5' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCTFCT5':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCTFCTAT5   | 10:10:10          | Version | Tv               | 12/31/2019               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCTFCT5':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 30000              | 40000         | 20000          | 1234567890                       |
And uploaded following supporting documents to cost title 'CCTFCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCTFCT5':
| Technical Approver | Coupa Requisitioner     |
| CostConsultant     | BrandManagementApprover |
And refreshed the page without delay
And I am on cost approval page of cost title 'CCTFCT5'
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'CCTFCT5'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate Local | Original Estimate |
| Offline edits                 | $ 40,000.00             | $ 40,000.00       |
| Audio finalization            | $ 30,000.00             | $ 30,000.00       |
| Agency travel                 | $ 20,000.00             | $ 20,000.00       |
| Technical fee (if applicable) | $ 743.00                | $ 743.00          |



Scenario: Check that Cost consultant technical fee is removed from the Original Estimate cost stage before the cost stage has been fully approved by approvers
Meta:@adcost
!--QA-810
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type    |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCTFCT6    | CCTFD6      | Christine Meyer (Leo Burnett) | 50000                | Audio        | Full Production    |  CCTFATN6               | Europe        | DefaultCampaign | BFO          | GBP - British Pound     |
And added production details for cost title 'CCTFCT6' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019      | 2              | India             | New Delhi      | GlobalDefaultVendor |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       9     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'CCTFCT6':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | CCTFAT6     | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCTFCT6':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And uploaded following supporting documents to cost title 'CCTFCT6':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'CCTFCT6':
| Technical Approver | Coupa Requisitioner       |
| CostConsultant     | BrandManagementApprover   |
And refreshed the page without delay
And I am on cost approval page of cost title 'CCTFCT6'
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'CCTFCT6'
Then I should see following data in cost section on Cost Review page:
| Section Name                       | Original Estimate Local | Original Estimate |
| STUDIO COSTS;VO recording sessions | £ 10,000.00             | $ 12,183.24       |
| STUDIO COSTS;Talent fees           | £ 10,000.00             | $ 12,183.24       |
| OTHER COSTS;P&G insurance          | £ 10,000.00             | $ 12,183.24       |
| Technical fee (if applicable)      | £ 115.00                | $ 140.11          |
| Grand Total                        | £  30,115.00            | $  36,689.81      |
When I login with details of 'CostConsultant'
And 'Request Changes' the cost with title 'CCTFCT6'
And I login with details of 'CostOwner'
And 'Reopen' the cost with title 'CCTFCT6'
And I am on cost approval page of cost title 'CCTFCT6'
And I 'Delete' approver 'CostConsultant' from 'technical' approver section on approvals page
And fill below approvers for cost title 'CCTFCT2':
| Technical Approver |
| IPMuser            |
When I 'Submit' the cost with title 'CCTFCT6'
And I am on cost review page of cost item with title 'CCTFCT6'
Then I should see following data in cost section on Cost Review page:
| Section Name                       | Original Estimate Local | Original Estimate |
| STUDIO COSTS;VO recording sessions | £ 10,000.00             | $ 12,183.24       |
| STUDIO COSTS;Talent fees           | £ 10,000.00             | $ 12,183.24       |
| OTHER COSTS;P&G insurance          | £ 10,000.00             | $ 12,183.24       |
| Technical fee (if applicable)      | £ 0.00                  | $ 0.00            |
| Grand Total                        | £  30,000.00            | $  36,549.71      |



Scenario: Check that correct Cost consultant technical fee is applied within Europe region for Video and Full production cost
Meta:@adcost
!--QA-810
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | CCTFCT7    | CCTFD7      | Aaron Royer (Grey)   | 9000                 | Video        | Full Production | CCTFATN7               | Europe        | DefaultCampaign | BFO          | GBP - British Pound     |
And added production details for cost title 'CCTFCT7' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCTFCT7':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCTFAT7     | 10:10:10          | Version | Tv               | 12/31/2019               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCTFCT7':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 30000              | 20000         | 20000         | 1234567890                        |
And uploaded following supporting documents to cost title 'CCTFCT7' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'CCTFCT7':
| Technical Approver | Coupa Requisitioner       |
| CostConsultant     | BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CCTFCT7'
And on cost review page of cost item with title 'CCTFCT7'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate Local | Original Estimate |
| Offline edits                 | £ 20,000.00             | $ 24,366.47       |
| Audio finalization            | £ 30,000.00             | $ 36,549.71       |
| SUBTOTAL POST PRODUCTION COST | £ 50,000.00             | $ 60,916.18       |
| Agency travel                 | £ 20,000.00             | $ 24,366.47       |
| SUBTOTAL AGENCY COSTS         | £ 20,000.00             | $ 24,366.47       |
| Technical fee (if applicable) | £ 450.00                | $ 548.25          |
| Grand Total                   | £  70,450.00            | $  85,830.90      |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCTFCT7'
And cost with title 'CCTFCT7' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'CCTFCT7'
And I fill Cost Line Items with following fields for cost title 'CCTFCT7':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 50000              | 30000         | 40000         | 1234567890                        |
Then I 'should not' see below approvers on approval form page for cost title 'CCTFCT7':
| Cost Consultant |
| CostConsultant  |
Then I 'should' see below approvers on approval form page for cost title 'CCTFCT7':
| Technical Approver |
| IPMuser            |


Scenario: Check that correct Cost consultant technical fee is applied within North Ameria region for Atheletes and buyout cost
Meta:@adcost
!--QA-810
Given I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number           | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject| true | OriginalEstimate              | Athletes  | Buyout                | CCTFCT8    | CCTFCD8     | Aaron Royer (Grey)  | CCTFATN8               | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CCTFCT8' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CCTFCT8' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And filled Cost Line Items with following fields for cost title 'CCTFCT8':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 10000             | 10000                      |
And I uploaded following supporting documents to cost title 'CCTFCT8':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CCTFCT8':
| Technical Approver | Brand Management Approver |
| CostConsultant     | BrandManagementApprover   |
And refreshed the page without delay
And I am on cost approval page of cost title 'CCTFCT8'
When I click 'Submit' button and 'Send for approval' on approval Page
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CCTFCT8'
And on cost review page of cost item with title 'CCTFCT8'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate Local  | Original Estimate |
| Usage/Residuals/Buyout Fee    | $ 10,000.00              | $ 10,000.00       |
| Base Compensation             | $ 10,000.00              | $ 10,000.00       |
| Technical fee (if applicable) | $ 149.00                 | $ 149.00          |
| Grand Total                   | $  20,149.00             | $  20,149.00      |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCTFCT8'
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCTFCT8'
And I login with details of 'CycloneCostOwner'
And 'CreateRevision' the cost with title 'CCTFCT8'
And I add cost item details for cost title 'CCTFCT8' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'CCTFCT8':
| FileName            | FormName                           |
| /files/EditWord.doc | Scope change approval form         |
And I 'Submit' the cost with title 'CCTFCT8'
And on cost review page of cost item with title 'CCTFCT8'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee    | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Base Compensation             | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Technical fee (if applicable) | $ 149.00          | $ 149.00               | $ 149.00         |
| Grand Total                   | $  20,149.00      | $  30,149.00           | $  30,149.00     |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCTFCT8'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCTFCT8'
And I login with details of 'CycloneCostOwner'
And 'NextStage' the cost with title 'CCTFCT8'
And I add cost item details for cost title 'CCTFCT8' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 25000             | 25000                      |
And I upload following supporting documents to cost title 'CCTFCT8':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I am on cost approval page of cost title 'CCTFCT8'
And I 'Delete' approver 'CostConsultant' from 'technical' approver section on approvals page
And fill below approvers for cost title 'CCTFCT8':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'CCTFCT8'
And on cost review page of cost item with title 'CCTFCT8'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Base Compensation                    | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Technical fee (if applicable)        | $ 149.00          | $ 149.00           | $ 149.00     |
| Grand Total                          | $  20,149.00      | $  50,149.00       | $  50,149.00 |