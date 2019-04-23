!--ORD-1850
!--ORD-2083
Feature: Clear action for Additional services section
Narrative:
In order to:
As a AgencyAdmin
I want to check clear action functionality for Additional services

Scenario: Check that clear action deletes data under Additional services section
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name        | A4User        |
| OTVMCSASSA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVMCSASSU1 | agency.admin | OTVMCSASSA1  |
And logged in with details of 'OTVMCSASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMCSASSCN1 |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Street Address | City        | Post Code    | Country     |
| Physical | OTVMCSASSDN1     | OTVMCSASSCnN1 | OTVMCSASSSA1   | OTVMCSASSC1 | OTVMCSASSPC1 | OTVMCSASSC1 |
And create for 'tv' order with item clock number 'OTVMCSASSCN1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                             | Notes & Labels        | Standard |
| Data DVD | OTVMCSASSDN1 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMCSASSDN1 OTVMCSASSCnN1 OTVMCSASSSA1 OTVMCSASSC1 OTVMCSASSPC1 OTVMCSASSC1 | automated test notes  | should   |
When I open order item with following clock number 'OTVMCSASSCN1'
And clear 'Additional Services' section on order item page
Then I should see following data for order item on Additional Services section:
| Type | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels | Standard   | Express    |
|      |             |        |               |               |           |                  |                | should not | should not |

Scenario: Check that clear action deletes data under Additional services section for Draft Order
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVMCSASSA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVMCSASSU1 | agency.admin | OTVMCSASSA1  |
And logged in with details of 'OTVMCSASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMCSASSCN2 |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Street Address | City        | Post Code    | Country     |
| Physical | OTVMCSASSDN2     | OTVMCSASSCnN2 | OTVMCSASSSA2   | OTVMCSASSC2 | OTVMCSASSPC2 | OTVMCSASSC2 |
When I open order item with following clock number 'OTVMCSASSCN2'
And fill following fields for Additional Services section on order item page:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies | Notes & Labels       | Standard |
| Data DVD | OTVMCSASSDN2 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2         | automated test notes | should   |
And save as draft order
And open order item with following clock number 'OTVMCSASSCN2'
And clear 'Additional Services' section on order item page
Then I should see following data for order item on Additional Services section:
| Type | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels | Standard   | Express    |
|      |             |        |               |               |           |                  |                | should not | should not |