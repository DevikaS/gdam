!--ORD-3061
!--ORD-3699
Feature: Production Services in Additional Services
Narrative:
In order to:
As a AgencyAdmin
I want to check production services in Additional Services

Scenario: check correct data for Production Services of Additional Services section after Save as draft order
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| PSASCN1      |
When I open order item with following clock number 'PSASCN1'
And fill following fields for Production Services of Additional Services section on order item page:
| Type       | Notes                  |
| Reslate SD | automated test notes 1 |
| Tagging HD | automated test notes 2 |
And save as draft order
And open order item with following clock number 'PSASCN1'
Then I should see following data for Production Services of Additional Services section on order item page:
| Type       | Notes                  |
| Reslate SD | automated test notes 1 |
| Tagging HD | automated test notes 2 |

Scenario: check correct data for Production Services of Additional Services section
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| PSASCN2      |
And create for 'tv' order with item clock number 'PSASCN2' production additional services with following fields:
| Type       | Notes                  |
| Tagging SD | automated test notes 1 |
| Reslate HD | automated test notes 2 |
When I open order item with following clock number 'PSASCN2'
Then I should see following data for Production Services of Additional Services section on order item page:
| Type       | Notes                  |
| Tagging SD | automated test notes 1 |
| Reslate HD | automated test notes 2 |


Scenario: Check that correct billing product is displayed on Order Summary in case to select Production Services
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
!--NGN-19470 ---Added enable QC & Ingest step and edited the Billing data
Given I created the following agency:
| Name   | A4User        | Labels              | Country        | SAP ID       |
| PSASA3 | DefaultA4User | production_services | United Kingdom | DefaultSapID |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU3 | agency.admin | PSASA3       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PSASA3':
| Advertiser | Brand   | Sub Brand | Product |
| PSASAR3    | PSASBR3 | PSASSB3   | PSASPR3 |
And logged in with details of 'PSASU3'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | PSASAR3    | PSASBR3 | PSASSB3   | PSASPR3 | PSASC3   | PSASCN3      | 20       | 10/14/2022     | HD 1080i 25fps | PSAST3 | BTI Studios        |
And create for 'tv' order with item clock number 'PSASCN3' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'PSASCN3'
When I go to Order Proceed page for order contains order item with following clock number 'PSASCN3'
Then I should see following Billing data on Order Proceed page:
| Item                               | QTY | Unit      | TotalPerItem   | Subtotal | Tax   | Total   |
| Subtitling: Standard (BTI Studios) | 1   | 42.00     | 42.00          | 360.00   | 75.60 | 435.60  |
| QC & Ingest Fee                    | 1   | 200.00    | 200.00         | 360.00   | 75.60 | 435.60  |
| Production service: Tagging SD     | 1   | 118.00    | 118.00         | 360.00   | 75.60 | 435.60  |

Scenario: Check that production services and dubbing services can be selected and order confirmed
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PSASA1':
| Advertiser | Brand   | Sub Brand | Product |
| PSASAR4    | PSASBR4 | PSASSB4   | PSASPR4 |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | PSASAR4    | PSASBR4 | PSASSB4   | PSASPR4 | PSASC4   | PSASCN4      | 20       | 10/14/2022     | HD 1080i 25fps | PSAST4 | BTI Studios        |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City   | Post Code | Country |
| Physical | PSASDN4          | PSASCnN4     | PSASCD4         | PSASSA4        | PSASC4 | PSASPC4   | PSASC4  |
And create for 'tv' order with item clock number 'PSASCN4' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                       | Notes & Labels        | Standard |
| Data DVD | PSASDN4     | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | PSASDN4 PSASCnN4 PSASCD4 PSASSA4 PSASC4 PSASPC4 PSASC4 | automated test notes  | should   |
And create for 'tv' order with item clock number 'PSASCN4' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
And complete order contains item with clock number 'PSASCN4' with following fields:
| Job Number | PO Number |
| PSASJN4    | PSASPN4   |
When I go to Order Summary page for order contains item with following clock number 'PSASCN4'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Brand   | Sub Brand | Product | Title  | First Air Date | Format         | Duration | Status        | Approve |
| PSASCN4      | PSASAR4    | PSASBR4 | PSASSB4   | PSASPR4 | PSAST4 | 10/14/22       | HD 1080i 25fps | 20       | 0/2 Delivered |         |
And should see clock delivery 'PSASCN4' contains destinations with following fields on 'tv' order summary page:
| Destination | Status       | Time of Delivery | Priority |
| PSASDN4     | Order Placed | -                | Standard |
| Tagging SD  | Order Placed | -                |          |



Scenario: Check that production services are displayed in View Order Summary popup and in saved as pdf report
!--QA-396 Validated the ViewDestination Details Report in UI as well
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PSASA1':
| Advertiser | Brand   | Sub Brand | Product |
| PSASAR4    | PSASBR4 | PSASSB4   | PSASPR4 |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | PSASAR4    | PSASBR4 | PSASSB4   | PSASPR4 | PSASC5   | PSASCN5      | 20       | 10/14/2022     | HD 1080i 25fps | PSAST5 | BTI Studios        | BSkyB Green Button:Standard |
And create for 'tv' order with item clock number 'PSASCN5' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
When I go to Order Proceed page for order contains order item with following clock number 'PSASCN5'
When I click ViewDestinationDetails button on Order Proceed page
Then I should see following data for order items on View 'Adstream' Delivery Report page using Core and UI:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand   | Sub Brand | Product | Title  | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level | Additional Production Service Type | Additional Production Service Note |
| PSASCN5      |            |           | 1                 | 1                 | United Kingdom | PSASAR4    | PSASBR4 | PSASSB4   | PSASPR4 | PSAST5 | 20       | HD 1080i 25fps |                 |               | 10/14/2022     | No      | automated test info |             | BTI Studios        | 1               | BSkyB             | BSkyB Green Button | Standard      | Tagging SD                         | automated test notes               |

Scenario: Check copy current for production services
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| PSASCN6      |
And create for 'tv' order with item clock number 'PSASCN6' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
When I open order item with following clock number 'PSASCN6'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data for Production Services of Additional Services section on order item page:
| Type       | Notes                |
| Tagging SD | automated test notes |

Scenario: Check Copy to all for production services
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| PSASCN7_1    |
| PSASCN7_2    |
And create for 'tv' order with item clock number 'PSASCN7_1' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
When I open order item with following clock number 'PSASCN7_1'
And copy data from 'Additional Services' section of order item page to all other items
And select order item with following clock number 'PSASCN7_2' on cover flow
Then I should see following data for Production Services of Additional Services section on order item page:
| Type       | Notes                |
| Tagging SD | automated test notes |

Scenario: Check cleaning of production services
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| PSASCN8      |
And create for 'tv' order with item clock number 'PSASCN8' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
When I open order item with following clock number 'PSASCN8'
And clear 'Additional Services' section on order item page
Then I should see following data for Production Services of Additional Services section on order item page:
| Type | Notes |
|      |       |

Scenario: Check adding new production service group
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| PSASCN9      |
When I open order item with following clock number 'PSASCN9'
And add '1' new Production Services group for Additional Services section on order item page
Then I should see '2' Production Services groups for Additional Services section on order item page

Scenario: Check removing of production service group
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| PSASCN10     |
When I open order item with following clock number 'PSASCN10'
And add '1' new Production Services group for Additional Services section on order item page
And delete '1' Production Service group of Additional Services section on order item page
Then I should see '1' Production Services groups for Additional Services section on order item page

Scenario: Check that confirmation email is sent with correct destination in attached email
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        | Labels              |
| PSASA1 | DefaultA4User | production_services |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PSASU1 | agency.admin | PSASA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PSASA1':
| Advertiser | Brand   | Sub Brand | Product |
| PSASAR4    | PSASBR4 | PSASSB4   | PSASPR4 |
And logged in with details of 'PSASU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | PSASAR4    | PSASBR4 | PSASSB4   | PSASPR4 | PSASC11  | PSASCN11     | 20       | 10/14/2022     | HD 1080i 25fps | PSAST11 | BTI Studios        | BSkyB Green Button:Standard |
And create for 'tv' order with item clock number 'PSASCN11' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
And complete order contains item with clock number 'PSASCN11' with following fields:
| Job Number | PO Number |
| PSASJN11   | PSASPN11  |
Then I 'should' see email notification for 'Order Confirmation' with field to 'PSASU1' and subject 'Order Confirmation:' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number |
| adstream     | PSASU1   | PSASCN11     | PSASJN11   | PSASPN11  |

Scenario: Check that confirmation email is sent with correct destination in attached email for Beam agency
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        | Labels                   |
| PSASA12 | DefaultA4User | Beam,production_services |
And created users with following fields:
| Email   | Role         | AgencyUnique | Language |
| PSASU12 | agency.admin | PSASA12      | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PSASA12':
| Advertiser | Brand    | Sub Brand | Product  |
| PSASAR12   | PSASBR12 | PSASSB12  | PSASPR12 |
And logged in with details of 'PSASU12'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | PSASAR12   | PSASBR12 | PSASSB12  | PSASPR12 | PSASC12  | PSASCN12     | 20       | 10/14/2022     | HD 1080i 25fps | PSAST12 | BTI Studios        | BSkyB Green Button:Standard |
And create for 'tv' order with item clock number 'PSASCN12' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
And complete order contains item with clock number 'PSASCN12' with following fields:
| Job Number | PO Number |
| PSASJN12   | PSASPN12  |
Then I 'should' see email notification for 'Order Confirmation' with field to 'PSASU12' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser | Brand    | Sub Brand | Product  | Title   | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Subtitles Required | Destination Group | Destination         | Service Level | Additional Production Service Type | Additional Production Service Note |
| beam         | PSASU12  | PSASCN12     | PSASJN12   | PSASPN12  | 1                 | 1                 | United Kingdom | PSASCN12  | PSASAR12   | PSASBR12 | PSASSB12  | PSASPR12 | PSAST12 | 20       | HD 1080i 25fps |                 |               |              |                | 10/14/2022     | Yes     | automated test info |             | BTI Studios        | BSkyB             | BSkyB Green Button  | Standard      | Tagging SD                         | automated test notes               |


Scenario: Check the type displayed for production services under additional servcies section when the market is Australia and New Zealand
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |Labels|
| OTVMASSA33 | DefaultA4User |au,dubbing_services,nVerge,Physical,FTP,production_services |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU33 | agency.admin | OTVMASSA33    |
And logged in with details of 'OTVMASSU33'
And create 'tv' order with market 'Australia and New Zealand' and items with following fields:
| Clock Number |
| OTVSDOCN33    |
When I open order item with following clock number 'OTVSDOCN33'
Then I should see available following types '<AvailableTypes>' in Type field of Production Services section on order item page

Examples:
| AvailableTypes              |                                                                                                                                        |
| Aspect Ratio,Asset Account Transfer Fee,Booking fee,Clapper,DVD Duplicate(s),DVD Menu Buttons,Editing services (per hour),Frame extension,FreeTV (CAD) Application,HD down conversion,Legalise,Loudness Correction,Master Physical Storage,Master Physical Release,Opening fee,Re-ingest,Resend,Restripe,Script creation,Special Compile request,Standards conversion,TVCAB Application,Caption 90 sec new,Caption 90 sec revision,Caption 45/60 sec new,Caption 45/60 sec revision,Caption 30 sec new,Caption 30 sec revision,Caption 15 sec new,Caption 15 sec revision,Caption Billboards new,Caption Billboards revision,Cinema:Digital Archive Fee,Cinema:Audio Conversion,Cinema:Video Conversion,Cinema:Extended Material,Cinema:Resend Fee,Cinema: External Production Services,Cinema:Priority Service,Express Courier,Standard Courier,Interstate Courier |


Scenario: Check the type displayed for production services under additional servcies section when the market is Australia
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |Labels|
| OTVMASSA34 | DefaultA4User |au,dubbing_services,nVerge,Physical,FTP,production_services |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU34 | agency.admin | OTVMASSA34    |
And logged in with details of 'OTVMASSU34'
And create 'tv' order with market 'Australia' and items with following fields:
| Clock Number |
| OTVSDOCN34    |
When I open order item with following clock number 'OTVSDOCN34'
Then I should see available following types '<AvailableTypes>' in Type field of Production Services section on order item page

Examples:
| AvailableTypes              |                                                                                                                                        |
| Aspect Ratio,Asset Account Transfer Fee,Booking fee,Clapper,DVD Duplicate(s),DVD Menu Buttons,Editing services (per hour),Frame extension,FreeTV (CAD) Application,HD down conversion,Legalise,Loudness Correction,Master Physical Storage,Master Physical Release,Opening fee,Re-ingest,Resend,Restripe,Script creation,Special Compile request,Standards conversion,TVCAB Application,Caption 90 sec new,Caption 90 sec revision,Caption 45/60 sec new,Caption 45/60 sec revision,Caption 30 sec new,Caption 30 sec revision,Caption 15 sec new,Caption 15 sec revision,Caption Billboards new,Caption Billboards revision,Cinema:Digital Archive Fee,Cinema:Audio Conversion,Cinema:Video Conversion,Cinema:Extended Material,Cinema:Resend Fee,Cinema: External Production Services,Cinema:Priority Service,Express Courier,Standard Courier,Interstate Courier |


