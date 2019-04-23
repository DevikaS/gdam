!--ORD-16189
Feature: Check visibility of market fields
Narrative:
In order to:
As a GlobalAdmin
I want to define market fields

Scenario: Check Global Admin can define which market fields to be shown on the Order proceed page
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OMCSDCMA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OMCSDCMU1 | agency.admin | OMCSDCMA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCSDCMA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMCSDCMAR  | OMCSDCMBR | OMCSDCMSB | OMCSDCMP |
And I am logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'OMCSDCMA1'
And clicked 'Subtitles Required' button in 'Editable Metadata' section on opened metadata page
And checked 'Visible on Order Summary' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'OMCSDCMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required  | Destination                 |
| automated test info    | OMCSDCMAR  | OMCSDCMBR | OMCSDCMSB | OMCSDCMP | OMCSDCMA1_1 | OMCSDCMU1_1  | 20       | 08/14/2022     | HD 1080i 25fps | OMCSDCMA1_1 | Adtext SD           | BSkyB Green Button:Standard |
| automated test info    | OMCSDCMAR  | OMCSDCMBR | OMCSDCMSB | OMCSDCMP | OMCSDCMA1_2 | OMCSDCMU1_2  | 20       | 08/14/2022     | HD 1080i 25fps | OMCSDCMA1_2 | BTI Studios         | PTV Prime:Standard          |
When I go to Order Proceed page for order contains order item with following clock number 'OMCSDCMU1_1'
Then I 'should' see following headers '<Headers>' of QC View Summary info on Order Proceed page
And I should see following QC View Summary info on Order Proceed page:
| Clock Number   | Advertiser | Subtitles Required | Title       | Duration | Format      | Archive    |
| OMCSDCMU1_1    | OMCSDCMAR | Adtext SD          | OMCSDCMA1_1 | 20       | SD PAL 16x9 | should not |
| OMCSDCMU1_2    | OMCSDCMAR | BTI Studios        | OMCSDCMA1_2 | 20       | SD PAL 16x9 | should not |

Examples:
| Headers                                                                             |
| Clock Number,Advertiser,Subtitles Required,Title,Duration,Format,Save in my Library |


Scenario: Check that market field defined by global admin can be filtered on Order summary page
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OMCSDCMA2 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OMCSDCMU2 | agency.admin | OMCSDCMA2    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCSDCMA2':
| Advertiser | Brand     | Sub Brand | Product  |
| OMCSDCMAR  | OMCSDCMBR | OMCSDCMSB | OMCSDCMP |
And I am logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'OMCSDCMA2'
And clicked 'Subtitles Required' button in 'Editable Metadata' section on opened metadata page
And checked 'Visible on Order Summary' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'OMCSDCMU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required  | Destination                 |
| automated test info    | OMCSDCMAR  | OMCSDCMBR | OMCSDCMSB | OMCSDCMP | OMCSDCMA1 | OMCSDCMU2    | 20       | 08/14/2022     | HD 1080i 25fps | OMCSDCMA1_1 | Adtext SD           | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OMCSDCMU2' with following fields:
| Job Number | PO Number  |
| OMCSDCMJN2 | OMCSDCMPN2 |
And I am on Order Summary page for order contains item with following clock number 'OMCSDCMU2'
When I fill following checkboxes for column filters settings on order summary page:
| Subtitles Required |
| should not         |
And back to ordering page from Order Summary page
And go to Order Summary page for order contains item with following clock number 'OMCSDCMU2'
Then I 'should not' see column 'Subtitles Required' for order list on ordering page


Scenario: Check Global Admin can define which market fields to be shown on the Order summary page
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OMCSDCMA3 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OMCSDCMU3 | agency.admin | OMCSDCMA3    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCSDCMA3':
| Advertiser | Brand     | Sub Brand | Product  |
| OMCSDCMAR  | OMCSDCMBR | OMCSDCMSB | OMCSDCMP |
And I am logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'OMCSDCMA3'
And clicked 'Subtitles Required' button in 'Editable Metadata' section on opened metadata page
And checked 'Visible on Order Summary' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'OMCSDCMU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required  | Destination                 |
| automated test info    | OMCSDCMAR  | OMCSDCMBR | OMCSDCMSB | OMCSDCMP | OMCSDCMA1 | OMCSDCMU3    | 20       | 08/14/2022     | HD 1080i 25fps | OMCSDCMA1_1 | Adtext SD           | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OMCSDCMU3' with following fields:
| Job Number | PO Number  |
| OMCSDCMJN3 | OMCSDCMPN3 |
And I am on Order Summary page for order contains item with following clock number 'OMCSDCMU3'
Then I 'should' see column 'Subtitles Required' for order list on ordering page