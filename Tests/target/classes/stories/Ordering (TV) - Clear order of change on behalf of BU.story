!--ORD-4428
!--ORD-4515
Feature: Ordering (TV) - Clear order of change on behalf of BU
Narrative:
In order to:
As a AgencyAdmin
I want to check clearing order of change on behalf of BU

Scenario: Check that order item page is cleared after changing on behalf of BU
Meta: @ordering
Given I created the following agency:
| Name    | A4User                     | A4 Agency Id                         |
| COBA1_1 | porsche-admin@adbank.me.ua | 60DBE905-6E3D-4D7F-A34C-409D7BC5E706 |
| COBA1_2 | DefaultA4User              |                                      |
And added agency 'COBA1_2' as a partner for agency 'COBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| COBU1_1 | agency.admin | COBA1_1      |
| COBU1_2 | agency.admin | COBA1_2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'COBA1_2':
| Advertiser | Brand  | Sub Brand | Product |
| COBAR1     | COBBR1 | COBSB1    | COBPR1  |
And added existing user 'COBU1_2' to agency 'COBA1_1' with role 'agency.admin'
And logged in with details of 'COBU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | COBAR1     | COBBR1 | COBSB1    | COBPR1  | COBC1    | COBCN1       | 20       | 12/14/2022     | HD 1080i 25fps | COBT1 | Adtext             | BSkyB Green Button:Standard |
When I open order item with following clock number 'COBCN1'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| COBA1_1         | COBA1_1                 |
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format | Title | Subtitles Required |
|                        |            |       |           |         |          |              |          |                |        |       |                    |
And 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard           |
| BSkyB Green Button |

Scenario: Check clear order item after copy current action and then changing on behalf of BU
Meta: @ordering
Given I created the following agency:
| Name    | A4User                     | A4 Agency Id                         |
| COBA1_1 | porsche-admin@adbank.me.ua | 60DBE905-6E3D-4D7F-A34C-409D7BC5E706 |
| COBA1_2 | DefaultA4User              |                                      |
And added agency 'COBA1_2' as a partner for agency 'COBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| COBU1_1 | agency.admin | COBA1_1      |
| COBU1_2 | agency.admin | COBA1_2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'COBA1_2':
| Advertiser | Brand  | Sub Brand | Product |
| COBAR1     | COBBR1 | COBSB1    | COBPR1  |
And added existing user 'COBU1_2' to agency 'COBA1_1' with role 'agency.admin'
And logged in with details of 'COBU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | COBAR1     | COBBR1 | COBSB1    | COBPR1  | COBC2    | COBCN2       | 20       | 12/14/2022     | HD 1080i 25fps | COBT2 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'COBCN2' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | COBU1_2  | should not       | automated test | 12/14/2022    |
And add usage right 'General' for order contains item with clock number 'COBCN2' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City  | Post Code | Country |
| Physical | COBDN2           | COBCnN2      | COBSA2         | COBC2 | COBPC2    | COBC2   |
And create for 'tv' order with item clock number 'COBCN2' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                         | Notes & Labels        | Standard   |
| Data DVD | COBDN2      | Avid DNxHD | Same as Master | Compile 1     | 1          | COBDN2 COBCnN2 COBSA2 COBC2 COBPC2 COBC2 | automated test notes  | should     |
When I open order item with following clock number 'COBCN2'
And 'copy current' order item by Add Commercial button on order item page
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| COBA1_1         | COBA1_1                 |
And refresh the page without delay
Then I should see selected following market 'United Kingdom' on order item page
And should see for active order item on cover flow following data:
| Media Request |
|               |
And should see 'enabled' New master button for order item on Add media form
And should see 'enabled' Retrieve from Library button for order item at Add media to your order form
And should see 'enabled' Retrieve from Project button for order item at Add media to your order form
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format | Title | Subtitles Required |
|                        |            |       |           |         |          |              |          |                |        |       |                    |
And 'should not' see following usage rights 'General' on order item page
And 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard           |
| BSkyB Green Button |
And should see following data for order item on Additional Services section:
| Type | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels | Standard   | Express    |
|      |             |        |               |               |           |                  |                | should not | should not |

Scenario: Check copy current action after changing on behalf of BU
Meta: @ordering
Given I created the following agency:
| Name    | A4User                     | A4 Agency Id                         |
| COBA1_1 | porsche-admin@adbank.me.ua | 60DBE905-6E3D-4D7F-A34C-409D7BC5E706 |
| COBA1_2 | DefaultA4User              |                                      |
And added agency 'COBA1_2' as a partner for agency 'COBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| COBU1_1 | agency.admin | COBA1_1      |
| COBU1_2 | agency.admin | COBA1_2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'COBA1_2':
| Advertiser | Brand  | Sub Brand | Product |
| COBAR1     | COBBR1 | COBSB1    | COBPR1  |
And added existing user 'COBU1_2' to agency 'COBA1_1' with role 'agency.admin'
And logged in with details of 'COBU1_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| COBCN3       |
When I open order item with following clock number 'COBCN3'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| COBA1_1         | COBA1_1                 |
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |