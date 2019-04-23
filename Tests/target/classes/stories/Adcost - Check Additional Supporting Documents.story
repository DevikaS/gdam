Feature: Additional Supporting Documents
Narrative:
In order to
As a CostOwner
I want to check Additional Supporting Documents

Scenario: Check that additional supporting documents can be attached to a cost
Meta:@adcost
     @additionalSupportingDocuments
!--QA-1069
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CASDCT1    | CASDD1      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CASDATN1               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CASDCT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CASDCT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CASDAT1     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CASDCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
When I upload following supporting documents to cost title 'CASDCT1':
| FileName                             | FormName                           |
| /files/19.5 MB Docx format File.docx | Additional supporting document     |
| /files/EditWord.doc                  | Supplier winning bid (budget form) |
| /files/19.5 MB Docx format File.docx | P&G Communication Brief            |
And I refresh the page without delay
Then I 'should' see below supporting documents:
| FileName                      | FormName                       |
| 19.5 MB Docx format File.docx | Additional supporting document |
When I click 'Continue' button on Supporting Documents page
And I add below approvers for cost title 'CASDCT1':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And refresh the page without delay
And I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'CASDCT1'
Then I 'should' see following data in 'Supporting Documents' section on Cost Review page:
| Additional supporting document | Supplier winning bid (budget form) | P&G Communication Brief       |
| 19.5 MB Docx format File.docx  | EditWord.doc                       | 19.5 MB Docx format File.docx |
And I 'should' see following data for 'Additional supporting document' supporting document on Cost Review page:
| Document Format | Document Name                 | Download Button |
| DOCX            | 19.5 MB Docx format File.docx | should          |


Scenario: Check that additional supporting documents can be added at next stage
Meta:@adcost
     @additionalSupportingDocuments
!--QA-1069
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | CASDCT3    | CASDCD3     | Aaron Royer (Grey)  | CASDATN3               | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CASDCT3' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints   | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air   | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 9000           |
And added negotiated terms page for cost title 'CASDCT3' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CASDCT3'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'CASDCT3':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CASDCT3':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'CASDCT3'
And I logged in with details of 'IPMuser'
And on cost review page of cost item with title 'CASDCT3'
And clicked 'Approve' button and 'Approve' on cost review page
And cost with title 'CASDCT3' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And on cost review page of cost item with title 'CASDCT3'
And clicked 'Next Stage' button and 'Confirm' on cost review page
When I upload following supporting documents to cost title 'CASDCT3':
| FileName                    | FormName                               |
| /files/EditWord.doc         | Brief/Call for work                    |
| /files/EditWord.doc         | Signed contract or letter of extension |
| /files/GWGTestfile064v3.pdf | Additional supporting document         |
And refresh the page without delay
And 'Submit' the cost with title 'CASDCT3'
And on cost review page of cost item with title 'CASDCT3'
Then I 'should' see following data in 'Supporting Documents' section on Cost Review page:
| Signed contract or letter of extension | Brief/Call for work | Additional supporting document |
| EditWord.doc                           | EditWord.doc        | GWGTestfile064v3.pdf           |
And I 'should' see following data for 'Additional supporting document' supporting document on Cost Review page:
| Document Format | Document Name        | Download Button |
| PDF             | GWGTestfile064v3.pdf | should          |


Scenario: Check that additional supporting documents can be added at revision stage
Meta:@adcost
     @additionalSupportingDocuments
!--QA-1069
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | CASDCT4    | CASDCD4     | Aaron Royer (Grey)  | CASDATN4               | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CASDCT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints   | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air   | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 9000           |
And added negotiated terms page for cost title 'CASDCT4' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CASDCT4'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'CASDCT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CASDCT4':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'CASDCT4'
And I logged in with details of 'IPMuser'
And on cost review page of cost item with title 'CASDCT4'
And clicked 'Approve' button and 'Approve' on cost review page
And cost with title 'CASDCT4' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And 'CreateRevision' the cost with title 'CASDCT4'
When I upload following supporting documents to cost title 'CASDCT4':
| FileName                    | FormName                       |
| /files/EditWord.doc         | Scope change approval form     |
| /files/GWGTestfile064v3.pdf | Additional supporting document |
And refresh the page without delay
And 'Submit' the cost with title 'CASDCT4'
And on cost review page of cost item with title 'CASDCT4'
Then I 'should' see following data in 'Supporting Documents' section on Cost Review page:
| Scope change approval form | Additional supporting document |
| EditWord.doc               | GWGTestfile064v3.pdf           |
And I 'should' see following data for 'Additional supporting document' supporting document on Cost Review page:
| Document Format | Document Name        | Download Button |
| PDF             | GWGTestfile064v3.pdf | should          |


Scenario: Check that supporting documents still attached to cost even when user navigates from page
Meta:@adcost
     @additionalSupportingDocuments
!--QA-1069
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CASDCT5    | CASDD5      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CASDATN5               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CASDCT5' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CASDCT5':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CASDAT5     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CASDCT5':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And I uploaded following supporting documents via UI to cost title 'CASDCT5':
| FileName                    | FormName                           |
| /files/EditWord.doc         | Supplier winning bid (budget form) |
| /files/EditWord.doc         | P&G Communication Brief            |
And I selected 'Overview' tab from left side navigation
When I am on supporting documents of cost title 'CASDCT5'
Then I 'should' see below supporting documents:
| FileName     | FormName                           |
| EditWord.doc | Supplier winning bid (budget form) |
| EditWord.doc | P&G Communication Brief            |


Scenario: Check that additional supporting documents can be removed
Meta:@adcost
     @additionalSupportingDocuments
!--QA-1069
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CASDCT6    | CASDD6      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CASDATN6               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CASDCT6' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CASDCT6':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CASDAT6     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CASDCT6':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And I uploaded following supporting documents via UI to cost title 'CASDCT6':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I uploaded following supporting documents to cost title 'CASDCT6':
| FileName                    | FormName                       |
| /files/GWGTestfile064v3.pdf | Additional supporting document |
And refreshed the page without delay
Then I see remove option for below on supporting documents:
| FormName                           | Condition  |
| Additional supporting document     | should     |
| Supplier winning bid (budget form) | should not |
| P&G Communication Brief            | should not |
When I remove below additional supporting documents:
| FormName                       |
| Additional supporting document |
And I click 'Continue' button on Adcost system page
And I click 'Previous' button on Adcost system page
Then I 'should' see below supporting documents:
| FileName     | FormName                           |
| EditWord.doc | Supplier winning bid (budget form) |
| EditWord.doc | P&G Communication Brief            |
And I 'should not' see below supporting documents:
| FileName             | FormName                       |
| GWGTestfile064v3.pdf | Additional supporting document |


Scenario: Check that multiple additional supporting documents can be uploaded to a cost
Meta:@adcost
     @additionalSupportingDocuments
!--QA-1069
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CASDCT7    | CASDD7      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CASDATN7               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CASDCT7' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CASDCT7':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CASDAT7     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CASDCT7':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
When I upload following supporting documents to cost title 'CASDCT7':
| FileName                    | FormName                           |
| /files/EditWord.doc         | Supplier winning bid (budget form) |
| /files/EditWord.doc         | P&G Communication Brief            |
| /files/EditWord.doc         | Additional supporting document     |
| /files/perfromance.xlsx     | Additional supporting document     |
| /files/GWGTestfile064v3.pdf | Additional supporting document     |
And I add below approvers for cost title 'CASDCT7':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'CASDCT7'
And I am on cost review page of cost item with title 'CASDCT7'
And refresh the page without delay
Then I 'should' see total 'Supporting Documents' count as '5' on Cost Review page
And I 'should' see total 'Additional Supporting Documents' count as '3' on Cost Review page


Scenario: Check that supporting documents are downloadable
Meta:@adcost
     @additionalSupportingDocuments
!--QA-1069
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CASDCT8    | CASDD8      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CASDATN8               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CASDCT8' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CASDCT8':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CASDAT8     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CASDCT8':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
When I upload following supporting documents to cost title 'CASDCT8':
| FileName                    | FormName                           |
| /files/perfromance.xlsx     | Additional supporting document     |
And I refresh the page without delay
And I upload following supporting documents via UI to cost title 'CASDCT8' and click continue:
| FileName                    | FormName                           |
| /files/EditWord.doc         | Supplier winning bid (budget form) |
| /files/perfromance.xlsx     | P&G Communication Brief            |
| /files/GWGTestfile064v3.pdf | Additional supporting document     |
And I add below approvers for cost title 'CASDCT8':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'CASDCT8'
Then I 'should' be able to download below supporting documents on Cost Review page for cost title 'CASDCT8':
| FormName                           | FileName             | Content-Length |
| Supplier winning bid (budget form) | EditWord.doc         | 23040          |
| P&G Communication Brief            | perfromance.xlsx     | 16157          |
| Additional supporting document     | GWGTestfile064v3.pdf | 659823         |


Scenario: Check that supporting documents cannot be uploaded for file size greather than 20 MB
Meta:@adcost
     @additionalSupportingDocuments
!--QA-1073
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | CASDCT9    | CASDD9      | Aaron Royer (Grey)  | CASDATN9               | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
When I am on supporting documents of cost title 'CASDCT9'
Then I 'should not' be able to upload following documents to cost title 'CASDCT9':
| FileName                               | FormName                       |
| /files/PDF Size GreatherThan 20MB.pdf  | Brief/Call for work            |
| /files/XLSX Size GreatherThan 20MB.xls | Additional supporting document |


Scenario: Check that toast message displayed for file size greather than 20 MB
Meta:@adcost
     @additionalSupportingDocuments
!--QA-1073
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | CASDCT10   | CASDD10     | Aaron Royer (Grey)  | CASDATN10              | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
When I am on supporting documents of cost title 'CASDCT10'
When I upload following supporting documents to cost title 'CASDCT10':
| FileName                    | FormName                           |
| /files/perfromance.xlsx     | Additional supporting document     |
And I refresh the page without delay
Then I 'should' see toast message for following files:
| FileName                               | FormName                       | Message                                                                               |
| /files/PDF Size GreatherThan 20MB.pdf  | Brief/Call for work            | Failed to upload supporting document: File size shoudl be less than or equal to 20 MB |
| /files/XLSX Size GreatherThan 20MB.xls | Additional supporting document | Failed to upload supporting document: File size shoudl be less than or equal to 20 MB |