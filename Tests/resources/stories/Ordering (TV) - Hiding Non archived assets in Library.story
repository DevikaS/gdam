!--ORD-3353
!--ORD-3560
Feature: Hiding Non archived assets in Library
Narrative:
In order to:
As a AgencyAdmin
I want to check hiding Non archived assets in Library


Scenario: Check that all assets are available in case to Retrieve from Library without dependancy to Archive
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| HNAAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| HNAAU1 | agency.admin | HNAAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'HNAAA1':
| Advertiser | Brand   | Sub Brand | Product |
| HNAAAR1    | HNAABR1 | HNAASB1   | HNAAPR1 |
And logged in with details of 'HNAAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title         | Subtitles Required | Destination                 |
| automated test info    | HNAAAR1    | HNAABR1 | HNAASB1   | HNAAPR1 | HNAAC2_1 | HNAACN2_1    | 20       | 10/14/2022     | HD 1080i 25fps | HNAAT2_1 test | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title         | Subtitles Required | Destination                 |
| automated test info    | HNAAAR1    | HNAABR1 | HNAASB1   | HNAAPR1 | HNAAC2_2 | HNAACN2_2    | 20       | 10/14/2022     | HD 1080i 25fps | HNAAT2_2 test | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| HNAACN2_3    |
And complete order contains item with clock number 'HNAACN2_1' with following fields:
| Job Number | PO Number | Adbank |
| HNAAJN2_1  | HNAAPN2_1 | should |
And waited for '10' seconds
And complete order contains item with clock number 'HNAACN2_2' with following fields:
| Job Number | PO Number | Adbank     |
| HNAAJN2_2  | HNAAPN2_2 | should not |
When I open order item with following clock number 'HNAACN2_3'
Then I 'should' see for order item at Add media to your order form following assets:
| Name          |
| HNAAT2_1 test |
| HNAAT2_2 test |



Scenario: Asset in shared for agency collection should be hidden if Archive hasn't been checked
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| HNAAA5_1 | DefaultA4User |
| HNAAA5_2 | DefaultA4User |
And added agency 'HNAAA5_2' as a partner to agency 'HNAAA5_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| HNAAU5_1 | agency.admin | HNAAA5_1     |streamlined_library,ordering|
| HNAAU5_2 | agency.admin | HNAAA5_2     |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'HNAAA5_1':
| Advertiser | Brand   | Sub Brand | Product |
| HNAAAR5    | HNAABR5 | HNAASB5   | HNAAPR5 |
And logged in with details of 'HNAAU5_1'
And created following categories:
| Name   |
| HNAAC5 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| HNAAC5       | HNAAA5_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | HNAAAR5    | HNAABR5 | HNAASB5   | HNAAPR5 | HNAAC5   | HNAACN5      | 20       | 10/14/2022     | HD 1080i 25fps | HNAAT5 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'HNAACN5' with following fields:
| Job Number | PO Number | Adbank     |
| HNAAJN5    | HNAAPN5   | should not |
And logged in with details of 'HNAAU5_2'
When I go to the collections page
When I go to the Shared Collection 'HNAAC5' from agency 'HNAAA5_1' pageNEWLIB
Then I 'should not' see assets 'HNAAT5' on Shared collection pageNEWLIB



Scenario: Check that assets aren't or are available in Library if archive isn't or is checked
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| HNAAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |Access|
| HNAAU1 | agency.admin | HNAAA1       |streamlined_library,library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'HNAAA1':
| Advertiser | Brand   | Sub Brand | Product |
| HNAAAR1    | HNAABR1 | HNAASB1   | HNAAPR1 |
And logged in with details of 'HNAAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | HNAAAR1    | HNAABR1 | HNAASB1   | HNAAPR1 | HNAAC1   | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | <Title> | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number | Adbank   |
| HNAAJN1    | HNAAPN1   | <Adbank> |
When I go to Library page for collection 'My Assets'NEWLIB
Then I '<ShouldState>' see assets with id '<Title>' in the collection 'My Assets'NEWLIB
Examples:
| ClockNumber | Title    | Adbank     | ShouldState |
| HNAACN1_1   | HNAAT1_1 | should     | should      |
| HNAACN1_2   | HNAAT1_2 | should not | should not  |


Scenario: Check that only selected clone is avaialable in Library if archive has been checked
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |Save In Library |Allow To Save In Library|
| HNAAA1 | DefaultA4User |should          |should                  |
And created users with following fields:
| Email  | Role         | AgencyUnique |Access|
| HNAAU1 | agency.admin | HNAAA1       |streamlined_library,library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'HNAAA1':
| Advertiser | Brand   | Sub Brand | Product |
| HNAAAR1    | HNAABR1 | HNAASB1   | HNAAPR1 |
And logged in with details of 'HNAAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | HNAAAR1    | HNAABR1 | HNAASB1   | HNAAPR1 | HNAAC3_1 | HNAACN3_1    | 20       | 10/14/2022     | HD 1080i 25fps | HNAAT3_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Clave   | Destination        |
| HNAACN3_2    | HNAACL3 | Gol TV HD:Standard |
And complete order contains item with clock number 'HNAACN3_1' with following fields:
| Job Number | PO Number | Adbank     |
| HNAAJN3_1  | HNAAPN3_1 | should not |
When I open order item with following clock number 'HNAACN3_2'
And add to order for order item at Add media to your order form following qc assets 'HNAAT3_1'
And fill following fields for Add information form on order item page:
| Additional Information | First Air Date |
| automated test info    | 12/12/2024     |
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'HNAACN3_1' of QC View summary on Order Proceed page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| HNAAJN3_2  | HNAAPN3_2 |
And confirm order on Order Proceed page
And I go to the Library pageNEWLIB
And I go to Library page for collection 'My Assets'NEWLIB
Then I should see assets 'HNAAT3_1' count '1' in collection 'My Assets'NEWLIB


Scenario: Asset in shared for user collection should be hidden if Archive hasn't been checked
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| HNAAA4_1 | DefaultA4User |
| HNAAA4_2 | DefaultA4User |
And added agency 'HNAAA4_2' as a partner to agency 'HNAAA4_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| HNAAU4_1 | agency.admin | HNAAA4_1     |streamlined_library,library,ordering|
| HNAAU4_2 | agency.admin | HNAAA4_2     |streamlined_library,library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'HNAAA4_1':
| Advertiser | Brand   | Sub Brand | Product |
| HNAAAR4    | HNAABR4 | HNAASB4   | HNAAPR4 |
And logged in with details of 'HNAAU4_1'
And created following categories:
| Name   |
| HNAAC4 |
And added next users for following categories:
| CategoryName | UserName | RoleName      |
| HNAAC4       | HNAAU4_2 | library.admin |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | HNAAAR4    | HNAABR4 | HNAASB4   | HNAAPR4 | HNAAC4   | HNAACN4      | 20       | 10/14/2022     | HD 1080i 25fps | HNAAT4 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'HNAACN4' with following fields:
| Job Number | PO Number | Adbank     |
| HNAAJN4    | HNAAPN4   | should not |
And logged in with details of 'HNAAU4_2'
When I go to the Library page for collection 'HNAAC4'NEWLIB
Then I 'should not' see assets 'HNAAT4' in the collection 'HNAAC4'NEWLIB


Scenario: Non archived assets should be hidden in collection filtered by advertiser
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| HNAAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |Access|
| HNAAU1 | agency.admin | HNAAA1       |streamlined_library,library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'HNAAA1':
| Advertiser | Brand   | Sub Brand | Product |
| HNAAAR6    | HNAABR6 | HNAASB6   | HNAAPR6 |
And logged in with details of 'HNAAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | HNAAAR6    | HNAABR6 | HNAASB6   | HNAAPR6 | HNAAC6   | HNAACN6      | 20       | 10/14/2022     | HD 1080i 25fps | HNAAT6 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'HNAACN6' with following fields:
| Job Number | PO Number | Adbank     |
| HNAAJN6    | HNAAPN6   | should not |
And I am on the Library page for collection 'My Assets'NEWLIB
When I click on filter link for collection 'My Assets'
And I switch 'on' media type filter 'video' on filter page
And I select mediaSubType 'QC-ed master' of 'video' for collection 'My Assets' on the page LibraryNEWLIB
And I select 'Advertiser' with value 'HNAAAR6' as filter collection 'My Assets'NEWLIB
And I add assets to 'sub' collection 'HNAACL6' from collection 'My Assets'NEWLIB
Then I 'should not' see assets 'HNAAT6' in the collection 'HNAACL6'NEWLIB

