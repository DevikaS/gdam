!--ORD-1849
!--ORD-2082
Feature: Copy to All for Additional services section
Narrative:
In order to:
As a AgencyAdmin
I want to check Copy to All for Additional services section

Scenario: Copy to All for Additional services section
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name        | A4User        |
| OTVMCAASSA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVMCAASSU1 | agency.admin | OTVMCAASSA1  |
And logged in with details of 'OTVMCAASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number   |
| OTVMCAASSCN1_1 |
| OTVMCAASSCN1_2 |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Street Address | City        | Post Code    | Country     |
| Physical | OTVMCAASSDN1     | OTVMCAASSCnN1 | OTVMCAASSSA1   | OTVMCAASSC1 | OTVMCAASSPC1 | OTVMCAASSC1 |
And create for 'tv' order with item clock number 'OTVMCAASSCN1_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                             | Notes & Labels        | Standard |
| Data DVD | OTVMCAASSDN1 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMCAASSDN1 OTVMCAASSCnN1 OTVMCAASSSA1 OTVMCAASSC1 OTVMCAASSPC1 OTVMCAASSC1 | automated test notes  | should   |
When I open order item with following clock number 'OTVMCAASSCN1_1'
And copy data from 'Additional Services' section of order item page to all other items
And select order item with following clock number 'OTVMCAASSCN1_2' on cover flow
Then I should see following data for order item on Additional Services section:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                             | Notes & Labels        | Standard | Express    |
| Data DVD | OTVMCAASSDN1 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMCAASSDN1 OTVMCAASSCnN1 OTVMCAASSSA1 OTVMCAASSC1 OTVMCAASSPC1 OTVMCAASSC1 | automated test notes  | should   | should not |

Scenario: Copy to All for Additional services section for Draft order
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVMCAASSA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVMCAASSU1 | agency.admin | OTVMCAASSA1  |
And logged in with details of 'OTVMCAASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number   |
| OTVMCAASSCN2_1 |
| OTVMCAASSCN2_2 |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Street Address | City        | Post Code    | Country     |
| Physical | OTVMCAASSDN2     | OTVMCAASSCnN2 | OTVMCAASSSA2   | OTVMCAASSC2 | OTVMCAASSPC2 | OTVMCAASSC2 |
When I open order item with following clock number 'OTVMCAASSCN2_1'
And fill following fields for Additional Services section on order item page:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies | Notes & Labels       | Standard |
| Data DVD | OTVMCAASSDN2 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2         | automated test notes | should   |
And save as draft order
And open order item with following clock number 'OTVMCAASSCN2_1'
And copy data from 'Additional Services' section of order item page to all other items
And select order item with following clock number 'OTVMCAASSCN2_2' on cover flow
Then I should see following data for order item on Additional Services section:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                             | Notes & Labels        | Standard | Express    |
| Data DVD | OTVMCAASSDN2 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMCAASSDN2 OTVMCAASSCnN2 OTVMCAASSSA2 OTVMCAASSC2 OTVMCAASSPC2 OTVMCAASSC2 | automated test notes  | should   | should not |