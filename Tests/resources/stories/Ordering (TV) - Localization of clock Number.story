!--NGN-5158
Feature:          A5 Dashboard Approval
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 Dashboard Approval

Scenario: Check that Clock Number field accepts chinese characters for China Market for a asset from Project
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| LOCLANGAG1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique   |
| LOCLANGU1 | agency.admin | LOCLANGAG1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'LOCLANGAG1':
|Advertiser|Brand     |Sub Brand |Product   |
|LOCLANGAR1|LOCLANGBR1|LOCLANGSB1|LOCLANGPR1|
And logged in with details of 'LOCLANGU1'
And create 'tv' order with market 'China' and items with following fields:
| Additional Information | Campaign | Clock Number              | Duration | First Air Date | Format         | Title        | Subtitles Required | Destination                 |
| 对身体好                |全部都做   | 吧多方多港过海家您日      | 20       | 10/14/2022     | HD 1080i 25fps |  走近摄像机   | Already Supplied   | FUJIAN TV - SPORTS:Standard |
And created 'LOCLANGP1' project
And created '/LOCLANGF1' folder for project 'LOCLANGP1'
And uploaded into project 'LOCLANGP1' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /LOCLANGF1 |
And waited while transcoding is finished in folder '/LOCLANGF1' on project 'LOCLANGP1' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/LOCLANGF1' project 'LOCLANGP1'
When I 'save' file info by next information:
| FieldName    | FieldValue       |
| Title        | LOCLANGT11_4.mov |
|Advertiser    | LOCLANGAR1       |
|Brand         | LOCLANGBR1       |
|Sub Brand     | LOCLANGSB1       |
|Product       | LOCLANGPR1       |
When I open order item with following clock number '吧多方多港过海家您日'
And add to order for order item at Add media to your order form following files 'LOCLANGT11_4.mov' from folder '/LOCLANGF1' of project 'LOCLANGP1'
And I wait for '3' seconds
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form
When I click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number    | PO Number    |
| LOCLANGJN4    | LOCLANGPN4   |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number '吧多方多港过海家您日' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Sub Brand | Product   | Market         | PO Number   | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | LOCLANGAR1 | LOCLANGBR1| LOCLANGSB1| LOCLANGPR1| China         | LOCLANGPN4  | LOCLANGJN4 | 1        | 0/1 Delivered |


Scenario: Check that Clock Number field accepts chinese characters for China Market for a asset from Library
Meta: @qaorderingsmoke
      @uatorderingsmoke
!-- On UAT's scenario would fail if BU created with S3 storage, FAB-767 should fix the issue
Given I created the following agency:
| Name       | A4User        |
| LOCLANGAG1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique   |Access|
| LOCLANGU1 | agency.admin | LOCLANGAG1     |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'LOCLANGAG1':
| Advertiser  | Brand      | Sub Brand  | Product    |
| LOCLANGAR1  | LOCLANGBR1 | LOCLANGSB1 | LOCLANGPR1 |
And logged in with details of 'LOCLANGU1'
And on the global 'common custom' metadata page for agency 'LOCLANGAG1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And create 'tv' order with market 'China' and items with following fields:
| Additional Information  | Clock Number            | Duration | First Air Date | Format         | Title        | Subtitles Required | Destination                 | Campaign  |
| 有十秒钟                 | 吧多方多港过海家您日她      | 20       | 10/14/2022     | HD 1080i 25fps |  今天的作业    | Already Supplied   | FUJIAN TV - SPORTS:Standard    |用网络摄像头|
And I am on the Library page for collection 'My Assets'NEWLIB
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue       |
|Advertiser    | LOCLANGAR1       |
|Brand         | LOCLANGBR1       |
|Sub Brand     | LOCLANGSB1       |
|Product       | LOCLANGPR1       |
|Clock number       | 吧多方多港过海家您日她       |
|Screen        |Trailer     |
When I open order item with following clock number '吧多方多港过海家您日她'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form
And I wait for '3' seconds
When I click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number    | PO Number    |
| LOCLANGJN4    | LOCLANGPN4   |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number '吧多方多港过海家您日她' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Sub Brand | Product   | Market         | PO Number   | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | LOCLANGAR1 | LOCLANGBR1| LOCLANGSB1| LOCLANGPR1| China         | LOCLANGPN4  | LOCLANGJN4 | 1        | 0/1 Delivered |
When I go to Order Summary page for order contains item with following clock number '吧多方多港过海家您日她'
Then I should see for order contains item with clock number '吧多方多港过海家您日她' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number   | Flag           | Market         |
| Digit        | LOCLANGAG1   | DateSubmitted  | CreatedBy  | LOCLANGJN4  | LOCLANGPN4 | China          | China          |
And should see clock delivery with following fields on 'tv' order summary page:
| Clock Number             | Advertiser | Brand      | Sub Brand  | Product     | First Air Date | Format         | Duration      | Status        |
| 吧多方多港过海家您日她    | LOCLANGAR1  | LOCLANGBR1 | LOCLANGSB1 | LOCLANGPR1 |10/14/2022      | HD 1080i 25fps  | 6s 33ms       | 0/1 Delivered |



Scenario: Check that Clock Number field accepts chinese characters for China Market for a New Master
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| LOCLANGAG1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique   |
| LOCLANGU1 | agency.admin | LOCLANGAG1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'LOCLANGAG1':
|Advertiser|Brand     |Sub Brand | Product   |
|LOCLANGAR1|LOCLANGBR1|LOCLANGSB1| LOCLANGPR1|
And logged in with details of 'LOCLANGU1'
And create 'tv' order with market 'China' and items with following fields:
| Additional Information | Clock Number      | Duration | First Air Date | Format         | Title        | Subtitles Required | Destination                 |Advertiser | Brand    |Sub Brand | Product   | Campaign |
|  笑一个笑话             | 时钟数量无法通过   | 20       | 10/14/2022     | HD 1080i 25fps |  一直往前走   | Already Supplied   | FUJIAN TV - SPORTS:Standard |LOCLANGAR1 |LOCLANGBR1|LOCLANGSB1| LOCLANGPR1|一周七天  |
When I open order item with next title '一直往前走'
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form
When I click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number    | PO Number    |
| LOCLANGJN3    | LOCLANGPN3   |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number '时钟数量无法通过' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Sub Brand | Product   | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | LOCLANGAR1 | LOCLANGBR1| LOCLANGSB1| LOCLANGPR1| China         | LOCLANGPN3  | LOCLANGJN3 | 1        | 0/1 Delivered |
When I go to View Media Details page for order contains item with following clock number '时钟数量无法通过'
Then I should see following media information on View Media Details page:
| Clock Number         | Advertiser   | Brand        | Sub Brand | Product    |Title           | Duration | First Air Date | Additional Details    | Video Format                                | Aspect Ratio | Video Standard |
| 时钟数量无法通过      | LOCLANGAR1   | LOCLANGBR1   |LOCLANGSB1| LOCLANGPR1  |一直往前走       |20       | 10/14/2022      | 笑一个笑话             | Broadcast SD PAL 4x3 Program Stream master  | 	4x3        | 720x576i@25fps |

Scenario: Check that yellow triangle appears with correct message in case to specify chinese clock number for MArket other than china
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| LOCLANGAG1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique   |
| LOCLANGU1 | agency.admin | LOCLANGAG1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'LOCLANGAG1':
| Advertiser | Brand      | Sub Brand  | Product    |
|LOCLANGAR1  | LOCLANGBR1 | LOCLANGSB1 | LOCLANGPR1 |
And logged in with details of 'LOCLANGU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  | Title        |
| 再英谢谁       |  一直往前走  |
When I open order item with next title '一直往前走'
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
And should see warning tooltip with following message 'Clock Number is too long or contains illegal characters.' next field 'Clock Number' for order item on Add information form

Scenario: Check that copy current and create new works when chinese characters are used
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| LOCLANGAG1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique   |
| LOCLANGU1 | agency.admin | LOCLANGAG1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'LOCLANGAG1':
| Advertiser  | Brand      | Sub Brand  | Product    |
| LOCLANGAR1  | LOCLANGBR1 | LOCLANGSB1 | LOCLANGPR1 |
And logged in with details of 'LOCLANGU1'
And create 'tv' order with market 'China' and items with following fields:
| Additional Information  | Clock Number            | Duration | First Air Date | Format         | Title        | Subtitles Required | Destination                 | Campaign  |
| 有十秒钟                | 吧多多港过海家您日她    | 20       | 10/14/2022     | HD 1080i 25fps |  今天的作业   | Already Supplied   | FUJIAN TV - SPORTS:Standard |用网络摄像头|
When I open order item with following clock number '吧多多港过海家您日她'
Then I should see following data for order item on Add information form:
| Additional Information  | Clock Number            | Duration | First Air Date | Format         | Title        |Campaign  |
| 有十秒钟                | 吧多多港过海家您日她    | 20       | 10/14/2022     | HD 1080i 25fps |  今天的作业   |用网络摄像头|
When I '<action>' order item by Add Commercial button on order item page
Then I should see following data for order item on Add information form:
| Additional Information  | Duration   | First Air Date      | Format         | Title        | Campaign  |
| <Addnl Info>            | <Duratn>   | <Date>              | <Format>       |  <Title>     |<Campaign> |



Examples:
|action      | Addnl Info  | Duratn   |  Date          | Format         | Title        | Campaign  |
|copy current| 有十秒钟     | 20       | 10/14/2022     | HD 1080i 25fps |  今天的作业   |用网络摄像头|
|create new  |             |          |                |                |               |           |


Scenario: Check that Clock Number field accepts chinese characters for China Market for a asset send from Library to Delivery
Meta: @qaorderingsmoke
Given I created the following agency:
| Name       | A4User        |
| LOCLANGAZ1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique   |Access|
| LOCLANGU1 | agency.admin | LOCLANGAZ1     |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'LOCLANGAZ1':
| Advertiser  | Brand      | Sub Brand  | Product    |
| LOCLANGAR1  | LOCLANGBR1 | LOCLANGSB1 | LOCLANGPR1 |
And logged in with details of 'LOCLANGU1'
And on the global 'common custom' metadata page for agency 'LOCLANGAZ1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And I am on the Library page for collection 'My Assets'NEWLIB
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue            |
|Clock number  | 吧多方多港过海家您日她  |
| Title        | LOCLANGT11_3.mov      |
|Advertiser    | LOCLANGAR1            |
|Brand         | LOCLANGBR1            |
|Sub Brand     | LOCLANGSB1            |
|Product       | LOCLANGPR1            |
|Screen        |Trailer|
And go to Library page for collection 'My Assets'NEWLIB
And I refresh the page
And I select asset 'LOCLANGT11_3.mov' in the 'My Assets'  library pageNEWLIB
And I click Send To Delivery from library 'My Assets' collectionNEWLIB
And I wait for '2' seconds
When I open order item with following clock number '吧多方多港过海家您日她'
And select following market 'China' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Duration  | First Air Date  |
| automated test info    |  20       | 12/14/2022      |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard                         |
| BEIJING SATELLITE TV             |
And I wait for '1' seconds
Then I 'should not' see warning icon next following fields 'Clock Number' for order item on Add information form
And I wait for '3' seconds
When I click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number    | PO Number    |
| LOCLANGJN4    | LOCLANGPN4   |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number '吧多方多港过海家您日她' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Sub Brand | Product   | Market         | PO Number   | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | LOCLANGAR1 | LOCLANGBR1| LOCLANGSB1| LOCLANGPR1| China         | LOCLANGPN4  | LOCLANGJN4 | 1        | 0/1 Delivered |
When I go to Order Summary page for order contains item with following clock number '吧多方多港过海家您日她'
Then I should see for order contains item with clock number '吧多方多港过海家您日她' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number   | Flag           | Market         |
| Digit        | LOCLANGAZ1   | DateSubmitted  | CreatedBy  | LOCLANGJN4  | LOCLANGPN4 | China          | China          |


Scenario: Check Select Destination section title is translated to spanish on order item page for the users with selected Spanish(Argentina) language
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        |
| ENTSDA1 | DefaultA4User |
And created 'UWPCELR_1' role with 'tv_order.completed.edit,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'ENTSDA1'
And created users with following fields:
| Email   | Role          | AgencyUnique  | Language |
| ENTSDU1 | UWPCELR_1     | ENTSDA1       | es-ar    |
| ENTSDU2 | agency.admin  | ENTSDA1       | en-us    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ENTSDA1':
| Advertiser | Brand   | Sub Brand | Product |
| ENTSDAR1    | ENTSDBR1 | ENTSDSB1   | ENTSDPR1 |
And logged in with details of 'ENTSDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand    | Sub Brand  | Product  | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | ENTSDAR1    | ENTSDBR1 | ENTSDSB1   | ENTSDPR1 | ENTSDC1   | ENTSDCN1      | 20       | 10/14/2022     | HD 1080i 25fps | ENTSDT1 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number 'ENTSDCN1'
Then I 'should' see select destination translated as 'Seleccione Destinos' on order item page
When I completed order contains item with clock number 'ENTSDCN1' with following fields:
| Job Number  | PO Number   |
| UWPLJO1_2   | UWPLPO1_2   |
When I go to View Live Orders tab of 'TV' order on ordering page
And select 'ENTSDCN1' for edit in 'live' tab
And wait for '3' seconds
Then I 'should' see select destination translated as 'Seleccione Destinos' on order item page
When I login with details of 'ENTSDU2'
And I go to User list page
And I go to user 'ENTSDU1' details page
And I filled following fields on user 'ENTSDU1' details page with specific Language:
| Language      |
| English       |
And I click save on users details page
And logout from account
And login with details of 'ENTSDU1'
When I go to View Live Orders tab of 'TV' order on ordering page
And select 'ENTSDCN1' for edit in 'live' tab
And wait for '3' seconds
Then I 'should' see select destination translated as 'Select Destinations' on order item page

