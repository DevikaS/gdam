!--ORD-781
!--ORD-821
!--ORD-1038
Feature: Clock Number validation
Narrative:
In order to:
As a AgencyAdmin
I want to check correctness of clock number validation

Scenario: Check that yellow triangle appears in case to specify indentical clock number in the same order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCNVA1'
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCNVCN1_1  |
When I open order item with following clock number 'OTVCNVCN1_1'
And 'create new' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Clock Number  | Campaign |
| <ClockNumber> | OTVCNVC1 |
Then I '<ShouldState>' see warning icon next following fields 'Clock Number' for order item on Add information form

Examples:
| ClockNumber | ShouldState |
| OTVCNVCN1_1 | should      |
| otvcnvcn1_1 | should      |
| OTVCNVCN1_2 | should not  |

Scenario: Check that yellow triangle appears with correct popup message in case to specify indentical clock number in the same order
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCNVA1'
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCNVCN1_3  |
When I open order item with following clock number 'OTVCNVCN1_3'
And 'create new' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Clock Number | Campaign   |
| OTVCNVCN1_3  | OTVCNVC1_3 |
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
And should see warning tooltip with following message 'This commercial has already been selected for this order. Please amend details.' next field 'Clock Number' for order item on Add information form

Scenario: Check that yellow triangle appears with correct popup message in case to specify clock number of already confirmed order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCNVA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVCNVAR2  | OTVCNVBR2 | OTVCNVSB2 | OTVCNVP2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCNVA1'
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVCNVAR2  | OTVCNVBR2 | OTVCNVSB2 | OTVCNVP2 | OTVCNVC2 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVCNVT2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| OTVCNVJN2  | OTVCNVPN2 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And fill following fields for Add information form on order item page:
| Clock Number     | Campaign |
| <dublicateClock> | OTVCNVC2 |
Then I '<ShouldState>' see warning icon next following fields 'Clock Number' for order item on Add information form

Examples:
| ClockNumber | dublicateClock | ShouldState |
| OTVCNVCN2_1 | OTVCNVCN2_1    | should      |
| OTVCNVCN2_2 | otvcnvcn2_2    | should      |
| OTVCNVCN2_3 | OTVCNVCN2_4    | should not  |

Scenario: Check that yellow triangle doesn't appear in case to add retrieved from Library QC-ed asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCNVA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVCNVAR2  | OTVCNVBR3 | OTVCNVSB3 | OTVCNVP3 |
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVCNVAR2  | OTVCNVBR3 | OTVCNVSB3 | OTVCNVP3 | OTVCNVC3 | OTVCNVCN3    | 20       | 08/14/2022     | HD 1080i 25fps | OTVCNVT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVCNVCN3' with following fields:
| Job Number | PO Number |
| OTVCNVJN3  | OTVCNVPN3 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And add to order for order item at Add media to your order form following qc assets 'OTVCNVT3'
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: Check that yellow triangle disappears in case to change duplicate clock number to unique value
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCNVA1'
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCNVCN4    |
When I open order item with following clock number 'OTVCNVCN4'
And 'create new' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Clock Number | Campaign |
| OTVCNVCN4    | OTVCNVC4 |
And fill following fields for Add information form on order item page:
| Clock Number | Campaign |
| OTVCNVCN4_1  | OTVCNVC4 |
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: Check that yellow triangle appears after open saved order with incorrect clock number
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number     | Title      |
| <ClockNumber>    | OTVCNVT4_1 |
| <dublicateClock> | OTVCNVT4_2 |
When I open order item with following title 'OTVCNVT4_1' and clock number '<ClockNumber>'
Then I '<ShouldState>' see warning icon next following fields 'Clock Number' for order item on Add information form
When I open order item with following title 'OTVCNVT4_2' and clock number '<dublicateClock>'
And refresh the page without delay
Then I '<ShouldState>' see warning icon next following fields 'Clock Number' for order item on Add information form

Examples:
| ClockNumber      | dublicateClock   | ShouldState |
| OTVCNVCN4_1      | OTVCNVCN4_1      | should      |
| OTVCNVCN4_2      | otvcnvcn4_2      | should      |
| OTVCNVCN4_3      | OTVCNVCN4_4      | should not  |

Scenario: Check that yellow triangle appears with correct message in case to specify spaces in clock number
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number    |
| OTVCNVCN5 clock |
When I open order item with following clock number 'OTVCNVCN5 clock'
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: Check that yellow triangle disappears in case to remove spaces in clock number
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCNVA1'
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number    |
| OTVCNVCN6 clock |
When I open order item with following clock number 'OTVCNVCN6 clock'
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
When I fill following fields for Add information form on order item page:
| Clock Number    | Campaign |
| OTVCNVCN6_clock | OTVCNVC6 |
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: Check that yellow triangle appears in case to Clear Section for retrieved QC-ed asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCNVA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVCNVAR2  | OTVCNVBR7 | OTVCNVSB7 | OTVCNVP7 |
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                |
| automated test info    | OTVCNVAR2  | OTVCNVBR7 | OTVCNVSB7 | OTVCNVP7 | OTVCNVC7 | OTVCNVCN7_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVCNVT7 | Already Supplied   | Universal Ireland:Standard |
And complete order contains item with clock number 'OTVCNVCN7_1' with following fields:
| Job Number | PO Number |
| OTVCNVJN7  | OTVCNVPN7 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCNVCN7_2  |
When I added to 'tv' order item with clock number 'OTVCNVCN7_2' following qc asset 'OTVCNVT7' of collection 'My Assets'
And open order item with clock number 'OTVCNVCN7_1' for order with market 'United Kingdom'
And clear 'Add media' section on order item page
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: Check that localization of clock number in warning message according to selected market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market '<Market>' and items with following fields:
| Clock Number    |
| OTVCNVCN8 clock |
When I open order item with clock number 'OTVCNVCN8 clock' for order with market '<Market>'
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
And should see warning tooltip with following message '<Message>' next field 'Clock Number' for order item on Add information form

Examples:
| Market              | Message                                                  |
| United Kingdom      | Clock Number is too long or contains illegal characters. |
| France		      | Pub ID is too long or contains illegal characters.       |
| Australia		      | Key Number is too long or contains illegal characters.   |
| Republic of Ireland | Clock Number is too long or contains illegal characters. |
| South Africa	      | Flight Code is too long or contains illegal characters.  |

Scenario: Validation for indentical clock number if user places it again by user with agency.user role
!--ORD-1162
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
| OTVCNVU2 | agency.user  | OTVCNVA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCNVA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVCNVAR2  | OTVCNVBR9 | OTVCNVSB9 | OTVCNVP9 |
And logged in with details of '<User1>'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                |
| automated test info    | OTVCNVAR2  | OTVCNVBR9 | OTVCNVSB9 | OTVCNVP9 | OTVCNVC9 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVCNVT9 | Already Supplied   | Universal Ireland:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| OTVCNVJN9  | OTVCNVPN9 |
And logged in with details of '<user2>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with clock number '<ClockNumber>' for order with market 'United Kingdom'
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form

Examples:
| User1    | user2    | ClockNumber |
| OTVCNVU1 | OTVCNVU2 | OTVCNVCN9_1 |
| OTVCNVU2 | OTVCNVU1 | OTVCNVCN9_2 |

Scenario: Validation for indentical clock number for users from different agencies
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
| OTVCNVA2 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
| OTVCNVU3 | agency.user  | OTVCNVA2     |
And logged in with details of 'OTVCNVU3'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OTVCNVCN10   |
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCNVCN10   |
When I open order item with clock number 'OTVCNVCN10' for order with market 'United Kingdom'
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: Check that yellow triangle appears with correct message in case to specify illegal characters in clock number
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  | Title   |
| <ClockNumber> | <Title> |
When I open order item with next title '<Title>'
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
And should see warning tooltip with following message 'Clock Number is too long or contains illegal characters.' next field 'Clock Number' for order item on Add information form

Examples:
| ClockNumber        | Title       |
| ÇçĞğİıÖöŞşÜüCN11_1 | OTVCNVT11_1 |
| !@%^.&*()+;'11_2   | OTVCNVT11_2 |

Scenario: Check that warning message appears when the clock number is more than 100 characters
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCNVA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVCNVAR2  | OTVCNVBR3 | OTVCNVSB3 | OTVCNVP3 |
And logged in with details of 'OTVCNVU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And fill following fields for Add information form on order item page:
| Clock Number                                                                                             | Advertiser |
| Lorem_ipsum_door_sit_amet_consectetuer_adipiscing_elit_Aenean_commodo_ligula_eget_dolor_Aenean_master    | OTVCNVAR2  |
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
And should see warning tooltip with following message 'Maximum value length is 100 symbols' next field 'Clock Number' for order item on Add information form
When fill following fields for Add information form on order item page:
| Additional Information | Advertiser   | Brand     | Sub Brand   | Product   | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title    | Subtitles Required |
| automated test info    | OTVCNVAR2    | OTVCNVBR3 | OTVCNVSB3   | OTVCNVP3  | OTVCNVP3   | OTVCNVP3      | 20       | 12/14/2022     | HD 1080i 25fps | OTVCNVP3 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Bangla TV          |
And save as draft order
And open order item with clock number 'OTVCNVP3' for order with market 'United Kingdom'
And fill following fields for Add information form on order item page:
| Clock Number                                                                                              | Campaign |
| Lorem_ipsum_door_sit_amet_consectetuer_adipiscing_elit_575001_commodo_ligula_eget_dolor_Aenean_BM00045    | OTVCNVC4 |
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
And should see warning tooltip with following message 'Maximum value length is 100 symbols' next field 'Clock Number' for order item on Add information form

Scenario: Check that warning message appears when the clock number is more than 100 characters in a multiple clock order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCNVA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVCNVAR2  | OTVCNVBR3 | OTVCNVSB3 | OTVCNVP3 |
And logged in with details of 'OTVCNVU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVCNVAR2  | OTVCNVBR3 | OTVCNVSB3 | OTVCNVP3 | OTVCNVC3 | OTVCNVMC3    | 20       | 08/14/2022     | HD 1080i 25fps | OTVCNVT3 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number 'OTVCNVMC3'
And 'create new' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Clock Number                                                                                              | Advertiser |
| _Lorem_ipsum_door_sit_amet_consectetuer_adipiscing_elit_Aenean_commodo_ligula_eget_dolor_Aenean_MASTER_    | OTVCNVAR2 |
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
And should see warning tooltip with following message 'Maximum value length is 100 symbols' next field 'Clock Number' for order item on Add information form
