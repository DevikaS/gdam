Feature: Email notifications Part 2
Narrative:
In order to
As a CostOwner
I want to check email notifications in adcost


Scenario: Check that notifications triggered to both previous cost owner and new cost owner when cost owner is reassigned in Draft status
Meta:@adcost
     @adcostEmails
!--QA-1075
Given I created users with following fields and waited until replication to Cost Module:
| Email         | Role        | Agency        | Access                                    |
| CENPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'CENPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email         | User Role    | Approval limit | Access Type | Condition |
| CENPCostOwner | Agency Owner |                | Client      | CENPBU    |
And I am on costs overview page
When I create a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | CENPCT1    | CENPCD1     | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CENPATN1               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And add production details for cost title 'CENPCT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'CENPCT1':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | CENPTAT1     | 10:10:10          | Version | Tv               | 12/12/2025               | HD         | Yes      | Yes       | JAPAN   |
And I update the cost owner field in quick view for cost title 'CENPCT1' with new owner 'CENPCostOwner'
Then I 'should' see cost email notification for 'Cost Owner Changed' with field to 'CostOwner' and subject 'CENPCT1' contains following attributes:
| Old Cost Owner | Cost Owner    | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status  | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Brand        | Timestamp | DDMYFTimestamp |
| CostOwner      | CENPCostOwner | Original Estimate | CENPCT1    | CENPCT1 | Video        | Post Production Only | Draft   | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN1          | DefaultCostProject | DefaultCostProject | AAK           | DefaultBrand | Today     | Today          |
And I 'should' see cost email notification for 'Cost Owner Changed' with field to 'CENPCostOwner' and subject 'CENPCT1' contains following attributes:
| Old Cost Owner | Cost Owner    | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status  | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Brand        | Timestamp | DDMYFTimestamp |
| CostOwner      | CENPCostOwner | Original Estimate | CENPCT1    | CENPCT1 | Video        | Post Production Only | Draft   | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN1          | DefaultCostProject | DefaultCostProject | AAK           | DefaultBrand | Today     | Today          |
When I login with details of 'CENPCostOwner'
When I fill Cost Line Items with following fields for cost title 'CENPCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And upload following supporting documents to cost title 'CENPCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'CENPCT1':
| Technical Approver | Coupa Requisitioner       | Add Watcher  |
| IPMuser            | BrandManagementApprover   | AgencyOwner  |
When I 'Submit' the cost with title 'CENPCT1'
Then I 'should' see cost email notification for 'Cost Submitted' with field to 'CENPCostOwner' and subject 'CENPCT1' contains following attributes:
| Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner  | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENPCT1    | CENPCT1 | Video        | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN1          | DefaultCostProject | DefaultCostProject | AAK           | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Submitted' with field to 'CostOwner' and subject 'CENPCT1' contains following attributes:
| Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                     | Agency Producer    | Agency Owner  | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| Original Estimate | CENPCT1    | CENPCT1 | Video        | Post Production Only | Pending Technical Approval | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN1          | DefaultCostProject | DefaultCostProject | AAK           | IPMuser            | DefaultBrand | Today     |


Scenario: Check that notifications triggered to old cost owner, new cost owner and IPM User and wathers when cost owner is changed after submitting the cost
Meta:@adcost
     @adcostEmails
!--QA-1075
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
Given I created users with following fields and waited until replication to Cost Module:
| Email         | Role        | Agency        | Access                                    |
| CENPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'CENPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email         | User Role    | Approval limit | Access Type | Condition |
| CENPCostOwner | Agency Owner |                | Client      | CENPBU    |
And I am on costs overview page
When I create a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | CENPCT2    | CENPCD2     | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CENPATN2               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And add production details for cost title 'CENPCT2' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'CENPCT2':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | CENPTAT2     | 10:10:10          | Version | Tv               | 12/12/2025                | HD         | Yes      | Yes       | JAPAN   |
And I fill Cost Line Items with following fields for cost title 'CENPCT2':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And upload following supporting documents to cost title 'CENPCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'CENPCT2':
| Technical Approver | Coupa Requisitioner       | Add Watcher  |
| IPMuser            | BrandManagementApprover   | AgencyOwner  |
And I 'Submit' the cost with title 'CENPCT2'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CENPCT2'
When I update the cost owner field in quick view for cost title 'CENPCT2' with new owner 'CENPCostOwner'
Then I 'should' see cost email notification for 'Cost Owner Changed' with field to 'CostOwner' and subject 'CENPCT2' contains following attributes:
| Old Cost Owner | Cost Owner   | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                       | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Brand        | Timestamp | DDMYFTimestamp | Technical Approver |
| CostOwner      | CENPCostOwner | Original Estimate | CENPCT2    | CENPCT2 | Video        | Post Production Only | Pending Technical Approval   | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN2          | DefaultCostProject | DefaultCostProject | AAK           | DefaultBrand | Today     | Today          | IPMuser            |
And I 'should' see cost email notification for 'Cost Owner Changed' with field to 'CENPCostOwner' and subject 'CENPCT2' contains following attributes:
| Old Cost Owner | Cost Owner   | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                       | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Brand        | Timestamp | DDMYFTimestamp | Technical Approver |
| CostOwner      | CENPCostOwner | Original Estimate | CENPCT2    | CENPCT2 | Video        | Post Production Only | Pending Technical Approval   | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN2          | DefaultCostProject | DefaultCostProject | AAK           | DefaultBrand | Today     | Today          | IPMuser            |
And I 'should' see cost email notification for 'Cost Owner Changed' with field to 'IPMuser' and subject 'CENPCT2' contains following attributes:
| Old Cost Owner | Cost Owner   | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                       | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Brand        | Timestamp | DDMYFTimestamp | Technical Approver |
| CostOwner      | CENPCostOwner | Original Estimate | CENPCT2    | CENPCT2 | Video        | Post Production Only | Pending Technical Approval   | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN2          | DefaultCostProject | DefaultCostProject | AAK           | DefaultBrand | Today     | Today          | IPMuser            |
And I 'should' see cost email notification for 'Cost Owner Changed' with field to 'AgencyOwner' and subject 'CENPCT2' contains following attributes:
| Old Cost Owner | Cost Owner   | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status                       | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Brand        | Timestamp | DDMYFTimestamp | Technical Approver |
| CostOwner      | CENPCostOwner | Original Estimate | CENPCT2    | CENPCT2 | Video        | Post Production Only | Pending Technical Approval   | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN2          | DefaultCostProject | DefaultCostProject | AAK           | DefaultBrand | Today     | Today          | IPMuser            |



Scenario: Check that the old cost owner should not receive any notification for recalled cost
Meta:@adcost
     @adcostEmails
!--QA-1075
Given I updated the following agency:
| Name              | Email Notification URL |
| DefaultAgency     | application_url        |
| another qa agency | application_url        |
And I created users with following fields and waited until replication to Cost Module:
| Email         | Role        | Agency        | Access                                    |
| CENPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'CENPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email         | User Role    | Approval limit | Access Type | Condition |
| CENPCostOwner | Agency Owner |                | Client      | CENPBU    |
And I am on costs overview page
When I create a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  |CENPCT3     | CENPCD3     | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CENPATN3               | IMEA           | DefaultCampaign | BFO          | USD - US Dollar         |
And add production details for cost title 'CENPCT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'CENPCT3':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | CENPTAT1     | 10:10:10          | Version | Tv               | 12/12/2025                | HD         | Yes      | Yes       | JAPAN   |
When I fill Cost Line Items with following fields for cost title 'CENPCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And upload following supporting documents to cost title 'CENPCT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'CENPCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CENPCT3'
And I update the cost owner field in quick view for cost title 'CENPCT3' with new owner 'CENPCostOwner'
And I login with details of 'CENPCostOwner'
And I 'Recall' the cost with title 'CENPCT3'
Then I 'should' see cost email notification for 'Cost Recalled for Cost Owners' with field to 'CENPCostOwner' and subject 'CENPCT3' contains following attributes:
| Cost Owner    | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner  | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| CENPCostOwner | Original Estimate | CENPCT3    | CENPCT3 | Video        | Post Production Only | Recalled | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN3          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should' see cost email notification for 'Cost Recalled for Cost Approvers' with field to 'IPMuser' and subject 'CENPCT3' contains following attributes:
| Cost Owner    | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner  | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| CENPCostOwner | Original Estimate | CENPCT3    | CENPCT3 | Video        | Post Production Only | Recalled | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN3          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Recalled for Cost Owners' with field to 'CostOwner' and subject 'CENPCT3' contains following attributes:
| Cost Owner    | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner  | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| CENPCostOwner | Original Estimate | CENPCT3    | CENPCT3 | Video        | Post Production Only | Recalled | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN3          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |



Scenario: Check that the old cost owner should not receive any notification for cost rejected by Approver
Meta:@adcost
     @adcostEmails
!--QA-1075
Given I created users with following fields and waited until replication to Cost Module:
| Email         | Role        | Agency        | Access                                    |
| CENPCostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'CENPCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email         | User Role    | Approval limit | Access Type | Condition |
| CENPCostOwner | Agency Owner |                | Client      | CENPBU    |
And I am on costs overview page
When I create a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | CENPCT4    | CENPCD4     | Aaron Royer (Grey)  | 9000                 | Audio        | Post Production Only | CENPATN4               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And add production details for cost title 'CENPCT4' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And add expected asset details for cost title 'CENPCT4':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | CENPCAT4     | 10:10:10          | Version | Tv               | 12/12/2025                | Yes      | Yes       |
When I fill Cost Line Items with following fields for cost title 'CENPCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And upload following supporting documents to cost title 'CENPCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'CENPCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CENPCT4'
And I update the cost owner field in quick view for cost title 'CENPCT4' with new owner 'CENPCostOwner'
When login with details of 'IPMuser'
And I 'Request Changes' the cost with comments 'auto test comment' and title 'CENPCT4'
Then I 'should' see cost email notification for 'Cost Request Changes' with field to 'CENPCostOwner' and subject 'CENPAT4' contains following attributes:
| Comments          | Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| auto test comment | IPMuser       | Original Estimate | CENPCT4    | CENPCT4 | Audio        | Post Production Only | Returned | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN4          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Request Changes' with field to 'CostOwner' and subject 'CENPAT4' contains following attributes:
| Comments          | Cost Approver | Stage             | Cost Title | Cost Id | Content Type | Production Type      | Status   | Agency Producer    | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| auto test comment | IPMuser       | Original Estimate | CENPCT4    | CENPCT4 | Audio        | Post Production Only | Returned | Aaron Royer (Grey) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN4          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |



Scenario: Check that the old cost owner should not receive any notification for cost approved by approver
Meta:@adcost
     @adcostEmails
!--QA-743, ADC-1075
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | CENPCT5    | CENPCD5     | Christine Meyer (Leo Burnett) | 50000                | Digital Development | CENPATN5               | IMEA          | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'CENPCT5' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'CENPCT5':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CENPAT10    | Digital          | 12/12/2025              | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CENPCT5':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000      | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'CENPCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CENPCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And 'Submit' the cost with title 'CENPCT5'
When I update the cost owner field in quick view for cost title 'CENPCT5' with new owner 'CENPCostOwner'
When login with details of 'IPMuser'
And 'Approve' the cost with title 'CENPCT5'
Then I 'should' see cost email notification for 'Cost Approved In Cost Module' with field to 'CENPCostOwner' and subject 'CENPCT5' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type         | Status                 | Agency Producer               | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | CENPCT5    | CENPCT5 | Digital Development  | Pending Brand Approval | Christine Meyer (Leo Burnett) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN5          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Approved In Cost Module' with field to 'CostOwner' and subject 'CENPCT5' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type         | Status                 | Agency Producer               | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IPMuser       | Original Estimate | CENPCT5    | CENPCT5 | Digital Development  | Pending Brand Approval | Christine Meyer (Leo Burnett) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN5          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
When cost with title 'CENPCT5' is 'Approve' on behalf of MyPurchases application
Then I 'should' see cost email notification for 'Cost Approved In Coupa' with field to 'CENPCostOwner' and subject 'CENPCT5' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type         | Status   | Agency Producer               | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IoNumberOwner | Original Estimate | CENPCT5    | CENPCT5 | Digital Development  | Approved | Christine Meyer (Leo Burnett) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN5          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |
And I 'should not' see cost email notification for 'Cost Approved In Coupa' with field to 'CostOwner' and subject 'CENPCT5' contains following attributes:
| Cost Approver | Stage             | Cost Title | Cost Id | Content Type         | Status   | Agency Producer               | Agency Owner | Agency Name       | Agency Location | Agency Tracking # | Project Name       | Project ID         | Budget Region | Technical Approver | Brand        | Timestamp |
| IoNumberOwner | Original Estimate | CENPCT5    | CENPCT5 | Digital Development  | Approved | Christine Meyer (Leo Burnett) | CENPCostOwner | another qa agency | Afghanistan     | CENPATN5          | DefaultCostProject | DefaultCostProject | IMEA          | IPMuser            | DefaultBrand | Today     |