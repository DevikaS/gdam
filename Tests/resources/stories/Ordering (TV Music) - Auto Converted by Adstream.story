!--ORD-2170
!--ORD-2329
!--ORD-4172
Feature: Auto converted formats
Narrative:
In order to:
As a GlobalAdmin
I want to check auto converted formats

Scenario: check autoconverting formats for one order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                                 |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC1 | OTVACFCN1    | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT1 | Sony Singapore:Standard;Tatasky HD:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'OTVACFCN1'
When I fill following fields on Order Proceed page:
| Manage Format Conversions |
| should                    |
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title    | Duration | Format                     | Archive    |
| OTVACFCN1    | OTVACFAR1  | OTVACFT1 | 20       | HD 1080i 25fps::SD PAL 4x3 | should not |

Scenario: check autoconverting formats for two order items with different destinations
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Destination                                 |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC2_1 | OTVACFCN2_1  | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT2_1 | Sony Singapore:Standard;Tatasky HD:Standard |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC2_2 | OTVACFCN2_2  | 15       | 10/14/2022     | HD 1080i 25fps | OTVACFT2_2 | Sony Singapore:Standard;Tatasky HD:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'OTVACFCN2_1'
When I fill following fields on Order Proceed page:
| Manage Format Conversions |
| should                    |
Then I should see '2' QC View Summary items on Order Proceed page
And should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title      | Duration | Format                     | Archive    |
| OTVACFCN2_1  | OTVACFAR1  | OTVACFT2_1 | 20       | HD 1080i 25fps::SD PAL 4x3 | should not |
| OTVACFCN2_2  | OTVACFAR1  | OTVACFT2_2 | 15       | HD 1080i 25fps::SD PAL 4x3 | should not |

Scenario: check autoconverting formats after back and add new item
Meta: @ordering
      @obug
!--FAB-491
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title      | Destination                                 |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC3 | OTVACFCN3_1  | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT3_1 | Sony Singapore:Standard;Tatasky HD:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'OTVACFCN3_1'
When I fill following fields on Order Proceed page:
| Manage Format Conversions |
| should                    |
And back to order item page from Order Proceed page
And 'copy current' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Clock Number | Title      | Duration |
| OTVACFCN3_2  | OTVACFT3_2 | 15       |
And click Proceed button on order item page
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title      | Duration | Format                     | Archive    |
| OTVACFCN3_1  | OTVACFAR1  | OTVACFT3_1 | 20       | HD 1080i 25fps::SD PAL 4x3 | should not |
| OTVACFCN3_2  | OTVACFAR1  | OTVACFT3_2 | 15       | HD 1080i 25fps::SD PAL 4x3 | should not |

Scenario: check autoconverting formats after back and remove item
Meta: @ordering
      @obug
!--FAB-491
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Destination                                 |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC4_1 | OTVACFCN4_1  | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT4_1 | Sony Singapore:Standard;Tatasky HD:Standard |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC4_2 | OTVACFCN4_2  | 15       | 10/14/2022     | HD 1080i 25fps | OTVACFT4_2 | Sony Singapore:Standard;Tatasky HD:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'OTVACFCN4_1'
When I fill following fields on Order Proceed page:
| Manage Format Conversions |
| should                    |
And back to order item page from Order Proceed page
And select order item with following clock number 'OTVACFCN4_2' on cover flow
And delete active order item on cover flow
And click Proceed button on order item page
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title      | Duration | Format                     | Archive    |
| OTVACFCN4_1  | OTVACFAR1  | OTVACFT4_1 | 20       | HD 1080i 25fps::SD PAL 4x3 | should not |

Scenario: check autoconverting formats with SD QC asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Clock Number | Destination         |
| OTVACFCN5_1  | Tatasky HD:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC5 | OTVACFCN5_2  | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT5_2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVACFCN5_2' with following fields:
| Job Number | PO Number |
| OTVACFJN5  | OTVACFPN5 |
And add to 'tv' order item with clock number 'OTVACFCN5_1' following qc asset 'OTVACFT5_2' of collection 'My Assets'
And I am on Order Proceed page for order with market 'India' and item with following clock number 'OTVACFCN5_2'
When I fill following fields on Order Proceed page:
| Manage Format Conversions |
| should                    |
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title      | Duration | Format                      | Archive    |
| OTVACFCN5_2  | OTVACFAR1  | OTVACFT5_2 | 20       | SD PAL 16x9::HD 1080i 25fps | should not |

Scenario: check autoconverting formats with HD QC asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Clock Number | Destination             |
| OTVACFCN6_1  | Sony Singapore:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                  |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC6 | OTVACFCN6_2  | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT6_2 | Already Supplied   | New Station - UK HD:Standard |
And complete order contains item with clock number 'OTVACFCN6_2' with following fields:
| Job Number | PO Number |
| OTVACFJN6  | OTVACFPN6 |
And add to 'tv' order item with clock number 'OTVACFCN6_1' following qc asset 'OTVACFT6_2' of collection 'My Assets'
And I am on Order Proceed page for order with market 'India' and item with following clock number 'OTVACFCN6_2'
When I fill following fields on Order Proceed page:
| Manage Format Conversions |
| should                    |
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title      | Duration | Format                     | Archive    |
| OTVACFCN6_2  | OTVACFAR1  | OTVACFT6_2 | 20       | HD 1080i 25fps::SD PAL 4x3 | should not |

Scenario: check autoconverting formats for HD station and HD QC asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Clock Number | Destination         |
| OTVACFCN7_1  | Tatasky HD:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                  |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC7 | OTVACFCN7_2  | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT7_2 | Already Supplied   | New Station - UK HD:Standard |
And complete order contains item with clock number 'OTVACFCN7_2' with following fields:
| Job Number | PO Number |
| OTVACFJN7  | OTVACFPN7 |
And add to 'tv' order item with clock number 'OTVACFCN7_1' following qc asset 'OTVACFT7_2' of collection 'My Assets'
And I am on Order Proceed page for order with market 'India' and item with following clock number 'OTVACFCN7_2'
Then I 'should not' see following fields 'Manage Format Conversions' for order on Order Proceed page
And should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title      | Duration | Format         | Archive |
| OTVACFCN7_2  | OTVACFAR1  | OTVACFT7_2 | 20       | HD 1080i 25fps | should  |

Scenario: check autoconverting formats for SD station and SD QC asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Clock Number | Destination             |
| OTVACFCN8_1  | Sony Singapore:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC8 | OTVACFCN8_2  | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT8_2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVACFCN8_2' with following fields:
| Job Number | PO Number |
| OTVACFJN8  | OTVACFPN8 |
And add to 'tv' order item with clock number 'OTVACFCN8_1' following qc asset 'OTVACFT8_2' of collection 'My Assets'
And I am on Order Proceed page for order with market 'India' and item with following clock number 'OTVACFCN8_2'
When I fill following fields on Order Proceed page:
| Manage Format Conversions |
| should                    |
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title      | Duration | Format                  | Archive    |
| OTVACFCN8_2  | OTVACFAR1  | OTVACFT8_2 | 20       | SD PAL 16x9::SD PAL 4x3 | should not |

Scenario: check warning for mixture of SD and HD assets
!--ORD-4018
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                                 |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC9 | OTVACFCN9    | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT9 | Sony Singapore:Standard;Tatasky HD:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'OTVACFCN9'
Then I should see following warning 'You have selected a combination of SD and HD destinations for the same commercial' for mixture of SD and HD assets on Order Proceed page

Scenario: check that Manage Format Conversions checkbox is not shown when nothing to convert
!--ORD-4172
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Destination             |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC10 | OTVACFCN10   | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT10 | Sony Singapore:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'OTVACFCN10'
Then I 'should not' see following fields 'Manage Format Conversions' for order on Order Proceed page

Scenario: check AllowUserToChangeManageConversion option can be overridden at BU level (NGN-16219)
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'GlobalAdmin'
And I updated agency 'OTVACFA1' with following fields on agency overview page:
| FieldName                                   | FieldValue      |
| Default Value of Manage Conversion Flag     | <AllowDefaults> |
| Allow User to Change Manage Conversion Flag | <CanEdit>       |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Destination                                 |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC11 | OTVACFCN11   | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT11 | Sony Singapore:Standard;Tatasky HD:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'OTVACFCN11'
Then I should see Manage Format Conversions field is '<State>' and '<Status>'

Examples:
| AllowDefaults | CanEdit | State     | Status       |
| true          | true    | checked   | editable     |
| true          | false   | checked   | not editable |
| false         | true    | unchecked | editable     |

Scenario: check default settings of AllowUserToChangeManageConversion option at BU level (NGN-16219)
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVACFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVACFU1 | agency.admin | OTVACFA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACFA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 |
And logged in with details of 'OTVACFU1'
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Destination                                 |
| automated test info    | OTVACFAR1  | OTVACFBR1 | OTVACFSB1 | OTVACFPR1 | OTVACFC12 | OTVACFCN12   | 20       | 10/14/2022     | HD 1080i 25fps | OTVACFT12 | Sony Singapore:Standard;Tatasky HD:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'OTVACFCN11'
Then I should see Manage Format Conversions field is 'unchecked' and 'editable'

Scenario: Check that Manage Conversion flag settings picked based on on-behalf-of BU selection - Part 1 (NGN-16219)
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA1_1 | DefaultA4User |
| OBA1_2 | DefaultA4User |
And added agency 'OBA1_2' as a partner for agency 'OBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU1_1 | agency.admin | OBA1_1       |
| OBU1_2 | agency.admin | OBA1_2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 |
And added existing user 'OBU1_2' to agency 'OBA1_1' with role 'agency.admin'
And logged in with details of 'GlobalAdmin'
And I updated agency 'OBA1_1' with following fields on agency overview page:
| FieldName                                   | FieldValue              |
| Default Value of Manage Conversion Flag     | <AllowDefaults_FirstBU> |
| Allow User to Change Manage Conversion Flag | <CanEdit_FirstBU>       |
And I updated agency 'OBA1_2' with following fields on agency overview page:
| FieldName                                   | FieldValue               |
| Default Value of Manage Conversion Flag     | <AllowDefaults_SecondBU> |
| Allow User to Change Manage Conversion Flag | <CanEdit_SecondBU>       |
And logged in with details of 'OBU1_2'
And create 'tv' order with market 'India' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| OBA1_1          | OBA1_1                  |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title |
| automated test info    | OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 | OBC11    | <ClockNumber> | 15       | 08/14/2022     | HD 1080i 25fps | OBT11 |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard       |
| Sony Singapore |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard       |
| Tatasky HD     |
And click Proceed button on order item page
Then I should see Manage Format Conversions field is '<State>' and '<Status>'

Examples:
| ClockNumber | AllowDefaults_FirstBU | CanEdit_FirstBU | AllowDefaults_SecondBU | CanEdit_SecondBU | State     | Status       |
| OBCN24_1    | true                  | true            | false                  | true             | checked   | editable     |
| OBCN24_2    | true                  | false           | false                  | true             | checked   | not editable |
| OBCN24_3    | false                 | true            | true                   | false            | unchecked | editable     |

Scenario: Check that Manage Conversion flag settings picked based on on-behalf-of BU selection - Part 2 (NGN-16219)
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OBA1_1 | DefaultA4User |
| OBA1_2 | DefaultA4User |
And added agency 'OBA1_2' as a partner for agency 'OBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OBU1_1 | agency.admin | OBA1_1       |
| OBU1_2 | agency.admin | OBA1_2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OBA1_2':
| Advertiser | Brand   | Sub Brand | Product |
| OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 |
And added existing user 'OBU1_2' to agency 'OBA1_1' with role 'agency.admin'
And logged in with details of 'GlobalAdmin'
And I updated agency 'OBA1_1' with following fields on agency overview page:
| FieldName                                   | FieldValue              |
| Default Value of Manage Conversion Flag     | <AllowDefaults_FirstBU> |
| Allow User to Change Manage Conversion Flag | <CanEdit_FirstBU>       |
And I updated agency 'OBA1_2' with following fields on agency overview page:
| FieldName                                   | FieldValue               |
| Default Value of Manage Conversion Flag     | <AllowDefaults_SecondBU> |
| Allow User to Change Manage Conversion Flag | <CanEdit_SecondBU>       |
And logged in with details of 'OBU1_2'
And create 'tv' order with market 'India' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU |
| OBA1_2          |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title |
| automated test info    | OBAR3_1    | OBBR3_1 | OBSB3_1   | OBPR3_1 | OBC11    | <ClockNumber> | 15       | 08/14/2022     | HD 1080i 25fps | OBT11 |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard       |
| Sony Singapore |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard       |
| Tatasky HD     |
And click Proceed button on order item page
Then I should see Manage Format Conversions field is '<State>' and '<Status>'

Examples:
| ClockNumber | AllowDefaults_FirstBU | CanEdit_FirstBU | AllowDefaults_SecondBU | CanEdit_SecondBU | State     | Status       |
| OBCN25_1    | false                 | true            | true                   | true             | checked   | editable     |
| OBCN25_2    | false                 | true            | true                   | false            | checked   | not editable |
| OBCN25_3    | true                  | false           | false                  | true             | unchecked | editable     |