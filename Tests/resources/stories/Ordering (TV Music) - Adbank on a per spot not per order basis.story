!--ORD-2036
!--ORD-2197
Feature: Adbank on a per spot not per order basis
Narrative:
In order to:
As a AgencyAdmin
I want to check adbank on a per spot not per order basis

Scenario: Check default checking of Adbank checkbox according to user's settings
Meta: @ordering
      @skip
!--Reason to Skip- 'Always Adbank' option no more available on deliver setting page
Given I created the following agency:
| Name     | A4User        |
| OTVAPSA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVAPSU1 | agency.admin | OTVAPSA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVAPSA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVAPSA1'
And logged in with details of 'OTVAPSU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Adbank |
| <CheckState>  |
And save own Delivery Setting
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info    | OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 | OTVAPSC1 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVAPST1 | BSkyB Green Button:Standard |
And go to Order Proceed page for order contains order item with following clock number '<ClockNumber>'
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number  | Archive          |
| <ClockNumber> | <ArchiveChecked> |

Examples:
| ClockNumber | CheckState | ArchiveChecked |
| OTVAPSCN1_1 | should     | should         |
| OTVAPSCN1_2 | should not | should not     |

Scenario: Check that value of Adbank checkbox is saved using Back button
Meta: @ordering
      @skip
!--Reason to Skip- 'Always Adbank' option no more available on deliver setting page
Given I created the following agency:
| Name     | A4User        |
| OTVAPSA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVAPSU1 | agency.admin | OTVAPSA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVAPSA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVAPSA1'
And logged in with details of 'OTVAPSU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Always Adbank |
| <CheckState>  |
And save own Delivery Setting
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 | OTVAPSC2 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVAPST2 | Already Supplied   | BSkyB Green Button:Standard |
And go to Order Proceed page for order contains order item with following clock number '<ClockNumber>'
And '<checkStateArchive>' checkbox Archive for following clock number '<ClockNumber>' of QC View summary on Order Proceed page
And back to order item page from Order Proceed page
And click Proceed button on order item page
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number  | Archive          |
| <ClockNumber> | <ArchiveChecked> |

Examples:
| ClockNumber | CheckState | checkStateArchive | ArchiveChecked |
| OTVAPSCN2_1 | should     | uncheck           | should not     |
| OTVAPSCN2_2 | should not | check             | should         |

Scenario: Do not show Advertiser column if there is no Mark as Advertiser
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Advertiser |
| <Agency> | DefaultA4User | <Field>            |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVAPSAR3  | OTVAPSBR3 | OTVAPSSB3 | OTVAPSPR3 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency '<Agency>'
And logged in with details of '<User>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info    | OTVAPSAR3  | OTVAPSBR3 | OTVAPSSB3 | OTVAPSPR3 | OTVAPSC3 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVAPST3 | BSkyB Green Button:Standard |
And I am on Order Proceed page for order contains order item with following clock number '<ClockNumber>'
Then I 'should' see following headers '<Headers>' of QC View Summary info on Order Proceed page

Examples:
| Agency     | User       | Field      | ClockNumber | Headers                                                          |
| OTVAPSA3_1 | OTVAPSU3_1 | Advertiser | OTVAPSCN3_1 | Clock number,Advertiser,Title,Duration,Format,Save in my Library |
| OTVAPSA3_2 | OTVAPSU3_2 | Brand      | OTVAPSCN3_2 | Clock number,Brand,Title,Duration,Format,Save in my Library      |
| OTVAPSA3_3 | OTVAPSU3_3 |            | OTVAPSCN3_3 | Clock number,Title,Duration,Format,Save in my Library            |

Scenario: Check that correct data is displayed on Order Summary in case to select Broadcast Destination
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVAPSA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVAPSU1 | agency.admin | OTVAPSA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVAPSA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 |
| OTVAPSAR4  | OTVAPSBR4 | OTVAPSSB4 | OTVAPSPR4 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVAPSA1'
And logged in with details of 'OTVAPSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Destination                 |
| automated test info    | OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 | OTVAPSC4_1 | OTVAPSCN4_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVAPST4_1 | BSkyB Green Button:Standard |
| automated test info    | OTVAPSAR4  | OTVAPSBR4 | OTVAPSSB4 | OTVAPSPR4 | OTVAPSC4_2 | OTVAPSCN4_2  | 15       | 10/14/2022     | SD PAL 16x9    | OTVAPST4_2 | PTV Prime:Standard          |
When I go to Order Proceed page for order contains order item with following clock number 'OTVAPSCN4_1'
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title      | Duration | Format      | Archive    |
| OTVAPSCN4_1  | OTVAPSAR1  | OTVAPST4_1 | 20       | SD PAL 16x9 | should not |
| OTVAPSCN4_2  | OTVAPSAR4  | OTVAPST4_2 | 15       | SD PAL 16x9 | should not |

Scenario: Check that QC View Summary isn't displayed on Order Summary in case to select Additional Service
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVAPSA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVAPSU1 | agency.admin | OTVAPSA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVAPSA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVAPSA1'
And logged in with details of 'OTVAPSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    |
| automated test info    | OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 | OTVAPSC5 | OTVAPSCN5    | 20       | 08/14/2022     | HD 1080i 25fps | OTVAPST5 |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City     | Post Code | Country  |
| Physical | OTVAPSDN5        | OTVAPSCnN5   | OTVAPSCD5       | OTVAPSSA5      | OTVAPSC5 | OTVAPSPC5 | OTVAPSC5 |
And create for 'tv' order with item clock number 'OTVAPSCN5' additional services with following fields:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                                     | Notes & Labels        | Express |
| Data DVD | OTVAPSDN5   | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | OTVAPSDN5 OTVAPSCnN5 OTVAPSCD5 OTVAPSSA5 OTVAPSC5 OTVAPSPC5 OTVAPSC5 | automated test notes  | should  |
When I go to Order Proceed page for order contains order item with following clock number 'OTVAPSCN5'
Then I 'should not' see QC View Summary info on Order Proceed page

Scenario: Check that data is changed on Order Summary in case to change data
!--ORD-2211
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVAPSA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVAPSU1 | agency.admin | OTVAPSA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVAPSA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 |
| OTVAPSAR6  | OTVAPSBR6 | OTVAPSSB6 | OTVAPSPR6 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVAPSA1'
And logged in with details of 'OTVAPSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVAPSAR1  | OTVAPSBR1 | OTVAPSSB1 | OTVAPSPR1 | OTVAPSC6_1 | OTVAPSCN6_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVAPST6_1 | Already Supplied   | BSkyB Green Button:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'OTVAPSCN6_1'
And back to order item page from Order Proceed page
And select following market 'Republic of Ireland' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      |
| automated test info    | OTVAPSAR6  | OTVAPSBR6 | OTVAPSSB6 | OTVAPSPR6 | OTVAPSC6_2 | OTVAPSCN6_2  | 15       | 10/14/2022     | HD 1080i 25fps | OTVAPST6_2 |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard          |
| Universal Ireland |
And click Proceed button on order item page
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title      | Duration | Format      | Archive    |
| OTVAPSCN6_2  | OTVAPSAR6  | OTVAPST6_2 | 15       | SD PAL 16x9 | should not |