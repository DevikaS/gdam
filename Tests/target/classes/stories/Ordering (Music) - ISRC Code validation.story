!--ORD-1533
Feature: ISRC Code validation
Narrative:
In order to:
As a AgencyAdmin
I want to check work of ISRC Code validation

Scenario: Check that yellow triangle appears in case to specify indentical isrc code in the same order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCNVA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1      |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCNVA1'
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code  |
| OMCNVCN1_1 |
When I open order item with following isrc code 'OMCNVCN1_1'
And 'create new' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| ISRC Code  | Artist  |
| <ISRCCode> | OMCNVC1 |
Then I '<ShouldState>' see warning icon next following fields 'ISRC Code' for order item on Add information form

Examples:
| ISRCCode   | ShouldState |
| OMCNVCN1_1 | should      |
| omcnvcn1_1 | should      |
| OMCNVCN1_2 | should not  |

Scenario: Check that yellow triangle appears with correct popup message in case to specify indentical isrc code in the same order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCNVA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1      |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCNVA1'
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code  |
| OMCNVCN1_3 |
When I open order item with following isrc code 'OMCNVCN1_3'
And 'create new' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| ISRC Code  | Artist    |
| OMCNVCN1_3 | OMCNVC1_3 |
Then I 'should' see warning icon next following fields 'ISRC Code' for order item on Add information form
And should see warning tooltip with following message 'This commercial has already been selected for this order. Please amend details.' next field 'ISRC Code' for order item on Add information form

Scenario: Check that yellow triangle appears with correct popup message in case to specify isrc code of already confirmed order item
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCNVA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCNVA1':
| Advertiser | Brand    | Sub Brand | Product |
| OMCNVAR2   | OMCNVBR2 | OMCNVSB2  | OMCNVP2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCNVA1'
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code  | Release Date | Format         | Title   | Destination                 |
| automated test info    | OMCNVAR2       | OMCNVBR2 | OMCNVSB2  | OMCNVP2 | OMCNVC2 | <ISRCCode> | 08/14/2022   | HD 1080i 25fps | OMCNVT2 | BSkyB Green Button:Standard |
And complete order contains item with isrc code '<ISRCCode>' with following fields:
| Job Number | PO Number |
| OMCNVJN2  | OMCNVPN2 |
And I am on View Draft Orders tab of 'music' order on ordering page
When I create 'music' order on View Draft Orders tab on ordering page
And fill following fields for Add information form on order item page:
| ISRC Code        | Artist  |
| <dublicateClock> | OMCNVC2 |
Then I '<ShouldState>' see warning icon next following fields 'ISRC Code' for order item on Add information form

Examples:
| ISRCCode    | dublicateClock | ShouldState |
| OMCNVCN2_1  | OMCNVCN2_1     | should      |
| OMCNVCN2_2  | omcnvcn2_2     | should      |
| OMCNVCN2_3  | OMCNVCN2_4     | should not  |

Scenario: Check that yellow triangle doesn't appear in case to add retrieved from Library QC-ed asset for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCNVA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCNVA1':
| Advertiser | Brand    | Sub Brand | Product |
| OMCNVAR2   | OMCNVBR3 | OMCNVSB3  | OMCNVP3 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCNVA1'
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist   | ISRC Code | Release Date | Format         | Title   | Destination                 |
| automated test info    | OMCNVAR2       | OMCNVBR3 | OMCNVSB3  | OMCNVP3 | OMCNVC3  | OMCNVCN3  | 08/14/2022   | HD 1080i 25fps | OMCNVT3 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'OMCNVCN3' with following fields:
| Job Number | PO Number |
| OMCNVJN3   | OMCNVPN3  |
And I am on View Draft Orders tab of 'music' order on ordering page
When I create 'music' order on View Draft Orders tab on ordering page
And add to order for order item at Add media to your order form following qc assets 'OMCNVT3'
Then I 'should not' see warning icon next following fields 'ISRC Code' for order item on Add information form

Scenario: Check that yellow triangle disappears in case to change duplicate isrc code to unique value
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCNVA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1      |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCNVA1'
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMCNVCN4 |
When I open order item with following isrc code 'OMCNVCN4'
And 'create new' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| ISRC Code | Artist  |
| OMCNVCN4  | OMCNVC4 |
And fill following fields for Add information form on order item page:
| ISRC Code  | Artist  |
| OMCNVCN4_1 | OMCNVC4 |
Then I 'should not' see warning icon next following fields 'ISRC Code' for order item on Add information form

Scenario: Check that yellow triangle appears after open saved order with incorrect isrc code
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCNVA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1      |
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code        | Title     |
| <ISRCCode>       | OMCNVT4_1 |
| <dublicateClock> | OMCNVT4_2 |
When I open order item with following title 'OMCNVT4_1' and isrc code '<ISRCCode>'
Then I '<ShouldState>' see warning icon next following fields 'ISRC Code' for order item on Add information form
When I open order item with following title 'OMCNVT4_2' and isrc code '<dublicateClock>'
And refresh the page without delay
Then I '<ShouldState>' see warning icon next following fields 'ISRC Code' for order item on Add information form

Examples:
| ISRCCode    | dublicateClock | ShouldState |
| OMCNVCN4_1  | OMCNVCN4_1     | should      |
| OMCNVCN4_2  | omcnvcn4_2     | should      |
| OMCNVCN4_3  | OMCNVCN4_4     | should not  |

Scenario: Check that yellow triangle appears with correct message in case to specify spaces in isrc code
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OMCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1     |
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code      |
| OMCNVCN5 clock |
When I open order item with following isrc code 'OMCNVCN5 clock'
Then I 'should' see warning icon next following fields 'ISRC Code' for order item on Add information form

Scenario: Check that yellow triangle disappears in case to remove spaces in isrc code
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCNVA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1      |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCNVA1'
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code      |
| OMCNVCN6 clock |
When I open order item with following isrc code 'OMCNVCN6 clock'
Then I 'should' see warning icon next following fields 'ISRC Code' for order item on Add information form
When I fill following fields for Add information form on order item page:
| ISRC Code      | Artist  |
| OMCNVCN6_clock | OMCNVC6 |
Then I 'should not' see warning icon next following fields 'ISRC Code' for order item on Add information form

Scenario: Check that yellow triangle appears in case to Clear Section for retrieved QC-ed asset for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCNVA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMCNVA1':
| Advertiser | Brand    | Sub Brand | Product |
| OMCNVAR2   | OMCNVBR7 | OMCNVSB7  | OMCNVP7 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMCNVA1'
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code  | Release Date | Format         | Title   | Destination                |
| automated test info    | OMCNVAR2       | OMCNVBR7 | OMCNVSB7  | OMCNVP7 | OMCNVC7 | OMCNVCN7_1 | 08/14/2022   | HD 1080i 25fps | OMCNVT7 | Universal Ireland:Standard |
And complete order contains item with isrc code 'OMCNVCN7_1' with following fields:
| Job Number | PO Number |
| OMCNVJN7   | OMCNVPN7  |
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code  |
| OMCNVCN7_2 |
When I added to 'music' order item with isrc code 'OMCNVCN7_2' following qc asset 'OMCNVT7' of collection 'My Assets'
And open order item with isrc code 'OMCNVCN7_1' for order with market 'United Kingdom'
And clear 'Add media' section on order item page
Then I 'should' see warning icon next following fields 'ISRC Code' for order item on Add information form

Scenario: Check that localization of isrc code in warning message according to selected market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCNVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCNVU1 | agency.admin | OTVCNVA1     |
And logged in with details of 'OTVCNVU1'
And create 'music' order with market '<Market>' and items with following fields:
| ISRC Code       |
| OTVCNVCN8 clock |
When I open order item with isrc code 'OTVCNVCN8 clock' for order with market '<Market>'
Then I 'should' see warning icon next following fields 'ISRC Code' for order item on Add information form
And should see warning tooltip with following message '<Message>' next field 'ISRC Code' for order item on Add information form

Examples:
| Market              | Message                                                |
| United Kingdom      | Key Number is too long or contains illegal characters. |
| France		      | Key Number is too long or contains illegal characters. |
| Australia		      | Key Number is too long or contains illegal characters. |
| Republic of Ireland | Key Number is too long or contains illegal characters. |
| South Africa	      | Key Number is too long or contains illegal characters. |

Scenario: Validation for indentical isrc code for users from different agencies for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMCNVA1 | DefaultA4User |
| OMCNVA2 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMCNVU1 | agency.admin | OMCNVA1      |
| OMCNVU3 | agency.user  | OMCNVA2      |
And logged in with details of 'OMCNVU3'
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| ISRC Code |
| OMCNVCN10 |
And logged in with details of 'OMCNVU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMCNVCN10 |
When I open order item with isrc code 'OMCNVCN10' for order with market 'United Kingdom'
Then I 'should not' see warning icon next following fields 'ISRC Code' for order item on Add information form