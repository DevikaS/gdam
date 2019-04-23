!--ORD-270
!--ORD-447
Feature: Saving a draft TV Order
Narrative:
In order to:
As a AgencyAdmin
I want to check a correct saving of a draft TV order

Scenario: Check that saving draft order correctly works
Meta: @qaorderingsmoke
      @uatorderingsmoke
!-- ORD-572
Given I created the following agency:
| Name   | A4User        |
| OSDOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OSDOA1       |
And logged in with details of '<UserEmail>'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And save as draft order without delay
Then I should see message success 'Order saved successfully'
And 'should' see selected 'View Draft Orders' tab on ordering page

Examples:
| UserEmail | GlobalRole   |
| OSDOU1_1  | agency.admin |
| OSDOU1_2  | agency.user  |

Scenario: Check that saving draft order correctly works (guest.user with required permissions)
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OSDOA1 | DefaultA4User |
And created 'OSDOR2' role with 'tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'OSDOA1'
And created users with following fields:
| FirstName | LastName | Email  | Role   | AgencyUnique |
| OSDOUFN1  | OSDOULN1 | OSDOU2 | OSDOR2 | OSDOA1       |
And logged in with details of 'OSDOU2'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And save as draft order without delay
Then I should see message success 'Order saved successfully'
And wait for '3' seconds
And 'should' see selected 'View Draft Orders' tab on ordering page

Scenario: Check that saved draft order appears in orders list on View Draft Orders tab
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OSDOA3 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OSDOA3       |
And logged in with details of '<UserEmail>'
And create 'tv' orders with following fields:
| Market   |
| <Market> |
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see TV 'draft' order in order list with following fields:
| Market   |
| <Market> |

Examples:
| UserEmail | GlobalRole   | Market   |
| OSDOU3_1  | agency.admin | Albania  |
| OSDOU3_2  | agency.user  | Bulgaria |

Scenario: Check that counter of draft orders is increased after creating order
!--ORD-1194
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name   | A4User        |
| OSDOA4 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OSDOA4       |
And logged in with details of '<UserEmail>'
And create 'tv' order
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see count orders '<Count>' on 'View Draft Orders' tab in order slider
And should see orders counter '<Count>' above orders list on ordering page

Examples:
| UserEmail | GlobalRole   | Count |
| OSDOU4_1  | agency.admin | 1     |
| OSDOU4_2  | agency.user  | 2     |

Scenario: Check that counter of draft orders is increased in case to click Save as Draft button
!--ORD-1194
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OSDOA5 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OSDOA5       |
And logged in with details of '<UserEmail>'
When I go to View Draft Orders tab of 'tv' order on ordering page
And create 'tv' order on View Draft Orders tab on ordering page
And save as draft order
Then I should see count orders '<Count>' on 'View Draft Orders' tab in order slider
And should see orders counter '<Count>' above orders list on ordering page

Examples:
| UserEmail | GlobalRole   | Count |
| OSDOU5_1  | agency.admin | 1     |
| OSDOU5_2  | agency.user  | 2     |

Scenario: Check that all entered data are correctly saved and displayed on list of draft orders for order
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OSDOA6 | DefaultA4User |
And created users with following fields:
| FirstName | LastName | Email       | Role         | AgencyUnique |
| OSDOUFN6  | OSDOULN6 | <UserEmail> | <GlobalRole> | OSDOA6       |
And logged in with details of '<UserEmail>'
And create 'tv' orders with following fields:
| Market   |
| <Market> |
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see TV 'draft' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market   | NoClocks | Creator     |
| Digit  | CurrentTime |            | <Market> | 1        | <UserEmail> |

Examples:
| UserEmail | GlobalRole   | Market  |
| OSDOU6_1  | agency.admin | Ukraine |
| OSDOU6_2  | agency.user  | Russia  |

Scenario: Check that all entered data are correctly saved and displayed on list of draft orders for order (guest.user with required permissions)
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OSDOA6 | DefaultA4User |
And created 'OSDOR6_3' role with 'tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'OSDOA6'
And created users with following fields:
| FirstName  | LastName   | Email    | Role     | AgencyUnique |
| OSDOUFN6_3 | OSDOULN6_3 | OSDOU6_3 | OSDOR6_3 | OSDOA6       |
And logged in with details of 'OSDOU6_3'
And create 'tv' orders with following fields:
| Market |
| Japan  |
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see TV 'draft' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market | NoClocks | Creator  |
| Digit  | CurrentTime |            | Japan  | 1        | OSDOU6_3 |

Scenario: Check that updating draft order save data into the same order and doesn’t create a new one
Meta: @ordering
!--ORD-666
Given I created the following agency:
| Name   | A4User        |
| OSDOA7 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OSDOU7 | agency.admin | OSDOA7       |
And logged in with details of 'OSDOU7'
And create 'tv' orders with following fields:
| Market         |
| United Kingdom |
When I go to View Draft Orders tab of 'tv' order on ordering page
And open just created 'draft' order from orders list
And save as draft order
Then I should see count orders '1' on 'View Draft Orders' tab in order slider
And should see TV 'draft' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | NoClocks | Creator |
| Digit  | CurrentTime |            | United Kingdom | 1        | OSDOU7  |

Scenario: Check that all entered data are correctly saved and displayed on list of draft orders for order item
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name   | A4User        |
| OSDOA8 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OSDOU8 | agency.admin | OSDOA8       |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OSDOA8':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVSDOAR8  | OTVSDOBR8 | OTVSDOSB8 | OTVSDOP8 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OSDOA8'
And on the global 'common custom' metadata page for agency 'OSDOA8'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OSDOU8'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVSDOCN8    |
When I open order item with following clock number 'OTVSDOCN8' for just created 'draft' order
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    |
| automated test info    | OTVSDOAR8  | OTVSDOBR8 | OTVSDOSB8 | OTVSDOP8 | OTVSDOC8 | OTVSDOCNN8   | 15       | 08/14/2022     | HD 1080i 25fps | OTVSDOT8 |
And save as draft order
Then I should see 'draft' order in 'tv' order list contains items with following fields:
| Clock Number | Advertiser | Product  | Title    | First Air Date | Format         | Duration |
| OTVSDOCNN8   | OTVSDOAR8  | OTVSDOP8 | OTVSDOT8 | 08/14/2022     | HD 1080i 25fps | 15       |

Scenario: Check that all updated data are correctly saved and displayed on orders details for order item in case to open it
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name   | A4User        |
| OSDOA9 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OSDOU9 | agency.admin | OSDOA9       |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OSDOA9':
| Advertiser  | Brand       | Sub Brand   | Product    |
| OTVSDOAR9_1 | OTVSDOBR9_1 | OTVSDOSB9_1 | OTVSDOP9_1 |
| OTVSDOAR9_2 | OTVSDOBR9_2 | OTVSDOSB9_2 | OTVSDOP9_2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OSDOA9'
And on the global 'common custom' metadata page for agency 'OSDOA9'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OSDOU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      |
| automated test info    | OTVSDOAR9_1 | OTVSDOBR9_1 | OTVSDOSB9_1 | OTVSDOP9_1 | OTVSDOC9_1 | OTVSDOCN9_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT9_1 |
When I open order item with following clock number 'OTVSDOCN9_1' for just created 'draft' order
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product    | Campaign   | Clock Number | Duration | First Air Date | Format      | Title      |
| test info new          | OTVSDOAR9_2 | OTVSDOBR9_2 | OTVSDOSB9_2 | OTVSDOP9_2 | OTVSDOC9_2 | OTVSDOCN9_2  | 15       | 10/15/2024     | SD NTSC 4x3 | OTVSDOT9_2 |
And save as draft order
And open order item with following clock number 'OTVSDOCN9_2' for just updated 'draft' order
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Campaign   | Clock Number | Duration | First Air Date | Format      | Product    | Title      |
| test info new          | OTVSDOAR9_2 | OTVSDOC9_2 | OTVSDOCN9_2  | 15       | 10/15/2024     | SD NTSC 4x3 | OTVSDOP9_2 | OTVSDOT9_2 |
And should see selected following market 'United Kingdom' on order item page

Scenario: Check that updated market correctly saved and displayed on orders details for order item in case to open it
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name    | A4User        |
| OSDOA10 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OSDOU10 | agency.admin | OSDOA10      |
And logged in with details of 'OSDOU10'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVSDOCN10   |
When I open order item with following clock number 'OTVSDOCN10' for just created 'draft' order
And select following market 'Austria' on order item page
And save as draft order
And open order item with following clock number 'OTVSDOCN10' for just updated 'draft' order
Then I should see selected following market 'Austria' on order item page

Scenario: Check that correct advertiser is displayed in order list for order (case different advertiser of order items)
Meta: @ordering
!--ORD-554
Given I created the following agency:
| Name    | A4User        |
| OSDOA11 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OSDOU11 | agency.admin | OSDOA11      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OSDOA11':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVSDOAR11_1 | OTVSDOBR11_1 | OTVSDOSB11_1 | OTVSDOP11_1 |
| OTVSDOAR11_2 | OTVSDOBR11_2 | OTVSDOSB11_2 | OTVSDOP11_2 |
And logged in with details of 'OSDOU11'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number  | Duration | First Air Date | Format         | Title       |
| automated test info1   | OTVSDOAR11_1 | OTVSDOBR11_1 | OTVSDOSB11_1 | OTVSDOP11_1 | OTVSDOC11_1 | OTVSDOCN11_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT11_1 |
| automated test info2   | OTVSDOAR11_2 | OTVSDOBR11_2 | OTVSDOSB11_2 | OTVSDOP11_2 | OTVSDOC11_2 | OTVSDOCN11_2  | 15       | 09/15/2024     | SD PAL 16x9    | OTVSDOT11_2 |
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see TV 'draft' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | NoClocks | Creator |
| Digit  | CurrentTime | Various    | United Kingdom | 2        | OSDOU11 |
And should see 'draft' order in 'tv' order list contains items with following fields:
| Clock Number | Advertiser   | Product     | Title       | First Air Date | Format         | Duration |
| OTVSDOCN11_1 | OTVSDOAR11_1 | OTVSDOP11_1 | OTVSDOT11_1 | 08/14/2022     | HD 1080i 25fps | 20       |
| OTVSDOCN11_2 | OTVSDOAR11_2 | OTVSDOP11_2 | OTVSDOT11_2 | 09/15/2024     | SD PAL 16x9    | 15       |

Scenario: Check that correct advertiser is displayed in order list for order (case the same advertiser of order items)
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OSDOA12 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OSDOU12 | agency.admin | OSDOA12      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OSDOA12':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVSDOAR12 | OTVSDOBR12 | OTVSDOSB12 | OTVSDOP12 |
And logged in with details of 'OSDOU12'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign    | Clock Number  | Duration | First Air Date | Format         | Title       |
| automated test info1   | OTVSDOAR12 | OTVSDOBR12 | OTVSDOSB12 | OTVSDOP12 | OTVSDOC12_1 | OTVSDOCN12_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT12_1 |
| automated test info2   | OTVSDOAR12 | OTVSDOBR12 | OTVSDOSB12 | OTVSDOP12 | OTVSDOC12_2 | OTVSDOCN12_2  | 15       | 09/15/2024     | SD PAL 16x9    | OTVSDOT12_2 |
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see TV 'draft' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | NoClocks | Creator |
| Digit  | CurrentTime | OTVSDOAR12 | United Kingdom | 2        | OSDOU12 |


Scenario: Check that destinations are saved in case to save draft order
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name    | A4User        |
| OSDOA12 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OSDOU12 | agency.admin | OSDOA12      |
And logged in with details of 'OSDOU12'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>' for just created 'draft' order
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard   | Express   |
| <Standard> | <Express> |
And save as draft order
And open order item with following clock number '<ClockNumber>' for just updated 'draft' order
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard          | Express          |
| <standardChecked> | <expressChecked> |

Examples:
| ClockNumber  | Standard         | Express                                | standardChecked               | expressChecked                        |
| OTVSDOCN12_1 | PTV Prime        | Zylom;ESI Media                        | PTV Prime                     | ESI Media;London Live;Zylom           |
| OTVSDOCN12_2 | ABN              | Star TV;ITV (Leeds);ITV Ulster (UTV)   | ABN                           | Star TV;ITV (Leeds);ITV Ulster (UTV)  |

Scenario: Check that destinations are saved in case to save draft order # 2
Meta: @ordering
Given I created the following agency:
| Name      | A4User      |
| OSDOA12_1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OSDOU12_1 | agency.admin | OSDOA12_1    |
And logged in with details of 'OSDOU12_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>' for just created 'draft' order
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard   | Express   |
| <Standard> | <Express> |
And save as draft order
And open order item with following clock number '<ClockNumber>' for just updated 'draft' order
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard          | Express          |
| <standardChecked> | <expressChecked> |

Examples:
| ClockNumber  | Standard         | Express                                | standardChecked               | expressChecked                       |
| OTVSDOCN12_3 | Turner           | ESI Media                              | Turner;Scottish Media Group 2 | ESI Media;London Live                |

Scenario: Check that empty advertiser and product are displayed in order list after delete its values
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OSDOA13 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OSDOU13 | agency.admin | OSDOA13      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OSDOA13':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVSDOAR13 | OTVSDOBR13 | OTVSDOSB13 | OTVSDOP13 |
And logged in with details of 'OSDOU13'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     |
| automated test info1   | OTVSDOAR13 | OTVSDOBR13 | OTVSDOSB13 | OTVSDOP13 | OTVSDOC13 | OTVSDOCN13   | 20       | 10/14/2022     | HD 1080i 25fps | OTVSDOT13 |
When I open order item with following clock number 'OTVSDOCN13'
And fill following fields for Add information form on order item page:
| Advertiser | Brand | Sub Brand | Product |
|            |       |           |         |
And save as draft order
And refresh the page without delay
Then I should see TV order in 'draft' order list with item clock number 'OTVSDOCN13' and following fields:
| Order# | DateTime    | Advertiser | Brand | Sub Brand | Product | Market         | NoClocks | Creator |
| Digit  | CurrentTime |            |       |           |         | United Kingdom | 1        | OSDOU13 |
And should see 'draft' order in 'tv' order list contains items with following fields:
| Clock Number | Advertiser | Product | Title     | First Air Date | Format         | Duration |
| OTVSDOCN13   |            |         | OTVSDOT13 | 10/14/2022     | HD 1080i 25fps | 20       |