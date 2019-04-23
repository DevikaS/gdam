!--ORD-1240
!--ORD-1862
Feature: Additional Services section
Narrative:
In order to:
As a AgencyAdmin
I want to check additional services section

Scenario: Filling Delivery Details Textbox with Using Physical Methods
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code  |
| <ISRCCode> |
When I open order item with following isrc code '<ISRCCode>'
And fill following fields for Additional Services section on order item page:
| Type   |
| <Type> |
And fill following fields for 'Add' Physical Delivery Destination form of Additional Services section on order item page:
| Destination Name | Contact Name | Street Address | City      | Post Code  | Country   |
| <Destinaton>     | OTVMASSCnN1  | OTVMASSSA1     | OTVMASSC1 | OTVMASSPC1 | OTVMASSC1 |
And add delivery destination for Additional Services section on order item page during 'Add' destination
And fill following fields for Additional Services section on order item page:
| Destination  |
| <Destinaton> |
Then I should see following data for order item on Additional Services section:
| Type   | Delivery Details  |
| <Type> | <DeliveryDetails> |

Examples:
| ISRCCode     | Type     | Destinaton   | DeliveryDetails                                                    |
| OTVMASSCN1_1 | Data DVD | OTVMASSDN1_1 | OTVMASSDN1_1 OTVMASSCnN1 OTVMASSSA1 OTVMASSC1 OTVMASSPC1 OTVMASSC1 |
| OTVMASSCN1_2 | DVD      | OTVMASSDN1_2 | OTVMASSDN1_2 OTVMASSCnN1 OTVMASSSA1 OTVMASSC1 OTVMASSPC1 OTVMASSC1 |
| OTVMASSCN1_3 | Tape     | OTVMASSDN1_3 | OTVMASSDN1_3 OTVMASSCnN1 OTVMASSSA1 OTVMASSC1 OTVMASSPC1 OTVMASSC1 |

Scenario: Filling Delivery Details Textbox with FTP Method
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN2   |
When I open order item with following clock number 'OTVMASSCN2'
And fill following fields for Additional Services section on order item page:
| Type       |
| FTP Upload |
And fill following fields for 'Add' FTP Delivery Destination form of Additional Services section on order item page:
| FTP Destination Name | FTP Host Name | FTP User Name | FTP Password | FTP Path   |
| OTVMASSFDN2          | OTVMASSFHN2   | OTVMASSFUN2   | OTVMASSFP2   | OTVMASSFP2 |
And add delivery destination for Additional Services section on order item page during 'Add' destination
And fill following fields for Additional Services section on order item page:
| Destination |
| OTVMASSFDN2 |
Then I should see following data for order item on Additional Services section:
| Delivery Details                                          |
| OTVMASSFDN2 OTVMASSFHN2 OTVMASSFUN2 OTVMASSFP2 OTVMASSFP2 |

Scenario: Cleaning fields if you change method type
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN3  |
And create additional destinations with following fields:
| Type     | Destination Name |
| Physical | OTVMASSDN3      |
When I open order item with following clock number 'OTVMASSCN3'
And fill following fields for Additional Services section on order item page:
| Type | Destination |
| DVD  | OTVMASSDN3 |
And fill following fields for Additional Services section on order item page:
| Type        |
| FTP Upload  |
Then I should see following data for order item on Additional Services section:
| Type       | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels | Standard   | Express    |
| FTP Upload |             |        |               |               |           |                  |                | should not | should not |

Scenario: check correct data for Additional services section
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN4  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City      | Post Code  | Country   |
| Physical | OTVMASSDN4       | OTVMASSCnN4  | OTVMASSSA4     | OTVMASSC4 | OTVMASSPC4 | OTVMASSC4 |
And create for 'tv' order with item clock number 'OTVMASSCN4' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                 | Notes & Labels        | Standard |
| Data DVD | OTVMASSDN4  | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN4 OTVMASSCnN4 OTVMASSSA4 OTVMASSC4 OTVMASSPC4 OTVMASSC4 | automated test notes  | should   |
When I open order item with following clock number 'OTVMASSCN4'
Then I should see following data for order item on Additional Services section:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                 | Notes & Labels        | Standard | Express    |
| Data DVD | OTVMASSDN4  | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN4 OTVMASSCnN4 OTVMASSSA4 OTVMASSC4 OTVMASSPC4 OTVMASSC4 | automated test notes  | should   | should not |

Scenario: check correct data for Additional services section after Save as draft
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN5   |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City      | Post Code  | Country   |
| Physical | OTVMASSDN5       | OTVMASSCnN5  | OTVMASSSA5     | OTVMASSC5 | OTVMASSPC5 | OTVMASSC5 |
When I open order item with following clock number 'OTVMASSCN5'
And fill following fields for Additional Services section on order item page:
| Type     | Destination | Format     | Specification  | Media Compile | No copies | Notes & Labels       | Standard |
| Data DVD | OTVMASSDN5  | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2         | automated test notes | should   |
And save as draft order
And open order item with following clock number 'OTVMASSCN5'
Then I should see following data for order item on Additional Services section:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                 | Notes & Labels        | Standard | Express    |
| Data DVD | OTVMASSDN5  | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN5 OTVMASSCnN5 OTVMASSSA5 OTVMASSC5 OTVMASSPC5 OTVMASSC5 | automated test notes  | should   | should not |

Scenario: Add Additional Services items
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN6   |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City      | Post Code  | Country   |
| Physical | OTVMASSDN6       | OTVMASSCnN6  | OTVMASSSA6     | OTVMASSC6 | OTVMASSPC6 | OTVMASSC6 |
And create for 'tv' order with item clock number 'OTVMASSCN6' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                 | Notes & Labels        | Standard |
| Data DVD | OTVMASSDN6  | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN6 OTVMASSCnN6 OTVMASSSA6 OTVMASSC6 OTVMASSPC6 OTVMASSC6 | automated test notes  | should   |
When I open order item with following clock number 'OTVMASSCN6'
And add '1' new Non Broadcast Destination group for Additional Services section on order item page
Then I should see following data for order item on Additional Services section:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                 | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN6  | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN6 OTVMASSCnN6 OTVMASSSA6 OTVMASSC6 OTVMASSPC6 OTVMASSC6 | automated test notes  | should     | should not |
|          |             |            |                |               |            |                                                                  |                       | should not | should not |

Scenario: Delete Additional Services items
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN7   |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City      | Post Code  | Country   |
| Physical | OTVMASSDN7       | OTVMASSCnN7  | OTVMASSSA7     | OTVMASSC7 | OTVMASSPC7 | OTVMASSC7 |
And create for 'tv' order with item clock number 'OTVMASSCN7' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                 | Notes & Labels        | Standard |
| Data DVD | OTVMASSDN7  | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN7 OTVMASSCnN7 OTVMASSSA7 OTVMASSC7 OTVMASSPC7 OTVMASSC7 | automated test notes  | should   |
When I open order item with following clock number 'OTVMASSCN7'
And add '1' new Non Broadcast Destination group for Additional Services section on order item page
And delete '1' Non Broadcast Destination group of Additional Services section on order item page
Then I should see following data for order item on Additional Services section:
| Type | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels | Standard   | Express    |
|      |             |        |               |               |           |                  |                | should not | should not |

Scenario: Copy current Additional Services items
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN8   |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Street Address | City        | Post Code    | Country     |
| Physical | OTVMASSDN8_1     | OTVMASSCnN8_1 | OTVMASSSA8_1   | OTVMASSC8_1 | OTVMASSPC8_1 | OTVMASSC8_1 |
| Physical | OTVMASSDN8_2     | OTVMASSCnN8_2 | OTVMASSSA8_2   | OTVMASSC8_2 | OTVMASSPC8_2 | OTVMASSC8_2 |
And create for 'tv' order with item clock number 'OTVMASSCN8' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                             | Notes & Labels        | Standard |
| Data DVD | OTVMASSDN8_1 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN8_1 OTVMASSCnN8_1 OTVMASSSA8_1 OTVMASSC8_1 OTVMASSPC8_1 OTVMASSC8_1 | automated test notes  | should   |
| Data DVD | OTVMASSDN8_2 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN8_2 OTVMASSCnN8_2 OTVMASSSA8_2 OTVMASSC8_2 OTVMASSPC8_2 OTVMASSC8_2 | automated test notes  | should   |
When I open order item with following clock number 'OTVMASSCN8'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data for order item on Additional Services section:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                             | Notes & Labels        | Standard | Express    |
| Data DVD | OTVMASSDN8_1 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN8_1 OTVMASSCnN8_1 OTVMASSSA8_1 OTVMASSC8_1 OTVMASSPC8_1 OTVMASSC8_1 | automated test notes  | should   | should not |
| Data DVD | OTVMASSDN8_2 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN8_2 OTVMASSCnN8_2 OTVMASSSA8_2 OTVMASSC8_2 OTVMASSPC8_2 OTVMASSC8_2 | automated test notes  | should   | should not |

Scenario: Additional Services destinations after confirming
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASSAR9 | OTVMASSBR9 | OTVMASSSB9 | OTVMASSPR9 |
And on the global 'common custom' metadata page for agency 'OTVMASSA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVMASSAR9 | OTVMASSBR9 | OTVMASSSB9 | OTVMASSPR9 | OTVMASSC9 | OTVMASSCN9   | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST9 | Already Supplied   | GEO News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Street Address | City        | Post Code    | Country     |
| Physical | OTVMASSDN9_1     | OTVMASSCnN9_1 | OTVMASSSA9_1   | OTVMASSC9_1 | OTVMASSPC9_1 | OTVMASSC9_1 |
| Physical | OTVMASSDN9_2     | OTVMASSCnN9_2 | OTVMASSSA9_2   | OTVMASSC9_2 | OTVMASSPC9_2 | OTVMASSC9_2 |
And create for 'tv' order with item clock number 'OTVMASSCN9' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                             | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN9_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVMASSDN9_1 OTVMASSCnN9_1 OTVMASSSA9_1 OTVMASSC9_1 OTVMASSPC9_1 OTVMASSC9_1 | automated test notes  | should     | should not |
| DVD      | OTVMASSDN9_2 | Auto-loop  | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN9_2 OTVMASSCnN9_2 OTVMASSSA9_2 OTVMASSC9_2 OTVMASSPC9_2 OTVMASSC9_2 | automated test notes  | should not | should     |
And complete order contains item with clock number 'OTVMASSCN9' with following fields:
| Job Number | PO Number  |
| OTVMASSJN9 | OTVMASSPN9 |
When I go to Order Summary page for order contains item with following clock number 'OTVMASSCN9'
Then I should see clock delivery 'OTVMASSCN9' contains destinations with following fields on 'tv' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| GEO News | Order Placed | -                | Standard |
| OTVMASSDN9_1       | Order Placed | -                | Standard |
| OTVMASSDN9_2       | Order Placed | -                | Express  |

Scenario: Additional Services destinations on the Order Summery with action QC and Ingest Only
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASSAR9 | OTVMASSBR9 | OTVMASSSB9 | OTVMASSPR9 |
And logged in with details of 'OTVMASSU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label      | Artist     | ISRC Code   | Release Date | Format         | Title      |
| automated test info    | OTVMASSAR9     | OTVMASSBR9 | OTVMASSSB9 | OTVMASSPR9 | OTVMASSC10 | OTVMASSCN10 | 08/14/2022   | HD 1080i 25fps | OTVMASST10 |
And enable QC & Ingest Only for 'music' order for item with following isrc code 'OTVMASSCN10'
And create additional destinations with following fields:
| Type | FTP Destination Name | FTP Host Name | FTP User Name | FTP Password | FTP Path    |
| FTP  | OTVMASSFDN10         | OTVMASSFHN10  | OTVMASSFUN10  | OTVMASSFP10  | OTVMASSFP10 |
And create for 'music' order with item isrc code 'OTVMASSCN10' additional services with following fields:
| Type       | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                               | Notes & Labels        | Standard   |
| FTP Upload | OTVMASSFDN10 | JPEG 72dpi | HD 1080i 25fps | Compile 1     | 1          | OTVMASSFDN10 OTVMASSFHN10 OTVMASSFUN10 OTVMASSFP10 OTVMASSFP10 | automated test notes  | should     |
And complete order contains item with isrc code 'OTVMASSCN10' with following fields:
| Job Number  | PO Number   |
| OTVMASSJN10 | OTVMASSPN10 |
When I go to Order Summary page for order contains item with following isrc code 'OTVMASSCN10'
Then I should see clock delivery 'OTVMASSCN10' contains destinations with following fields on 'music' order summary page:
| Destination  | Status       | Time of Delivery | Priority |
| OTVMASSFDN10 | Order Placed | -                | Standard |

Scenario: Updating Edit Destinations fields
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN11  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name   | Street Address | City         | Post Code     | Country      |
| Physical | OTVMASSDN11_1    | OTVMASSCnN11_1 | OTVMASSSA11_1  | OTVMASSC11_1 | OTVMASSPC11_1 | OTVMASSC11_1 |
When I open order item with following clock number 'OTVMASSCN11'
And fill following fields for Additional Services section on order item page:
| Type     | Destination   |
| Data DVD | OTVMASSDN11_1 |
And fill following fields for 'Edit' Physical Delivery Destination form of Additional Services section on order item page:
| Destination Name | Contact Name   | Street Address | City         | Post Code     | Country      |
| OTVMASSDN11_2    | OTVMASSCnN11_2 | OTVMASSSA11_2  | OTVMASSC11_2 | OTVMASSPC11_2 | OTVMASSC11_2 |
And add delivery destination for Additional Services section on order item page during 'Edit' destination
And fill following fields for Additional Services section on order item page:
| Type     | Destination   |
| Data DVD | OTVMASSDN11_2 |
Then I should see following data for order item on Additional Services section:
| Type     | Destination   | Delivery Details                                                                   |
| Data DVD | OTVMASSDN11_2 | OTVMASSDN11_2 OTVMASSCnN11_2 OTVMASSSA11_2 OTVMASSC11_2 OTVMASSPC11_2 OTVMASSC11_2 |

