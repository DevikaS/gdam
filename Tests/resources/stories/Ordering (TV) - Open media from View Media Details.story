!--ORD-1448
Feature: Media from View Media Details
Narrative:
In order to:
As a AgencyAdmin
I want to check media content from view media details page


Scenario: Media from View media details with checking destination
Meta: @qaorderingsmoke
      @uatorderingsmoke
!-- On UAT's scenario would fail if BU created with S3 storage, FAB-767 should fix the issue
Given I created the following agency:
| Name        | A4User        |
| OTVOMFVMDA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| OTVOMFVMDU1 | agency.admin | OTVOMFVMDA1  |streamlined_library,ordering|
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVOMFVMDA1':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVOMFVMDAR1 | OTVOMFVMDBR1 | OTVOMFVMDSB1 | OTVOMFVMDP1 |
And on the global 'common custom' metadata page for agency 'OTVOMFVMDA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVOMFVMDU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVOMFVMDAR1 | OTVOMFVMDBR1 | OTVOMFVMDSB1 | OTVOMFVMDP1 | OTVOMFVMDC1 | OTVOMFVMDCN1 | 20       | 12/14/2022     | HD 1080i 25fps | OTVOMFVMDT1 | Already Supplied   | GEO News:Standard |
And hold for approval 'tv' order items with following clock numbers 'OTVOMFVMDCN1'
And add to 'tv' order item with clock number 'OTVOMFVMDCN1' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And complete order contains item with clock number 'OTVOMFVMDCN1' with following fields:
| Job Number   | PO Number    |
| OTVOMFVMDJN1 | OTVOMFVMDPN1 |
When I go to View Media Details page for order that contains QCed asset with following clock number 'OTVOMFVMDCN1'
Then I should see following media information on View Media Details page:
| Clock Number | Advertiser   | Brand        | Sub Brand    | Product     | Title        | Duration | First Air Date | Additional Details  | Video Format                                | Aspect Ratio | Video Standard |
| OTVOMFVMDCN1 | OTVOMFVMDAR1 | OTVOMFVMDBR1 | OTVOMFVMDSB1 | OTVOMFVMDP1 | Fish1-Ad.mov | 6s 33ms  | 12/14/2022     | automated test info | Broadcast SD PAL 16x9 Program Stream master | 16x9         | 720x576i@25fps |
And should see destination delivered for order contains item with clock number 'OTVOMFVMDCN1' with following fields:
| Order # | Destination        | Date Ordered  | Ordered by  | Status         |
| Digit   | GEO News | DateSubmitted | OTVOMFVMDU1 | Received Media |



Scenario: Media from View media details without destination
!--ORD-1549, ORD-1541
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVOMFVMDA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| OTVOMFVMDU1 | agency.admin | OTVOMFVMDA1  |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVOMFVMDA1':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVOMFVMDAR1 | OTVOMFVMDBR2 | OTVOMFVMDSB2 | OTVOMFVMDP2 |
And logged in with details of 'OTVOMFVMDU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish2-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish2-Ad.mov'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required |
| automated test info    | OTVOMFVMDAR1 | OTVOMFVMDBR2 | OTVOMFVMDSB2 | OTVOMFVMDP2 | OTVOMFVMDC2 | OTVOMFVMDCN2 | 20       | 12/14/2022     | HD 1080i 25fps | OTVOMFVMDT2 | Already Supplied   |
And add to 'tv' order item with clock number 'OTVOMFVMDCN2' following asset 'Fish2-Ad.mov' of collection 'My Assets'
When I open order item with following clock number 'OTVOMFVMDCN2'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And save as draft order
And completed order contains item with clock number 'OTVOMFVMDCN2' with following fields:
| Job Number   | PO Number    |
| OTVOMFVMDJN2 | OTVOMFVMDPN2 |
And wait for '2' seconds
And go to View Media Details page for order that contains QCed asset with following clock number 'OTVOMFVMDCN2'
Then I should see following media information on View Media Details page:
| Clock Number | Advertiser   | Brand        | Sub Brand    | Product     | Title        | Duration | First Air Date | Additional Details  | Video Format                                     | Aspect Ratio | Video Standard   |
| OTVOMFVMDCN2 | OTVOMFVMDAR1 | OTVOMFVMDBR2 | OTVOMFVMDSB2 | OTVOMFVMDP2 | Fish2-Ad.mov | 6s 33ms  | 12/14/2022     | automated test info | Broadcast HD 1080i 25fps Transport Stream master | 16x9         | 1920x1080i@25fps |
And 'should not' see destinations delivered list on View Media Details page



Scenario: Media from Order Summary for QC asset using different distinations
Meta: @ordering
!--NGN-19262, instead of skipping scenario, removed this line from THEN step (| Digit   | BSkyB Green Button | DateSubmitted | OTVOMFVMDU1 | Received Media |
Given I created the following agency:
| Name        | A4User        |
| OTVOMFVMDA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| OTVOMFVMDU1 | agency.admin | OTVOMFVMDA1  |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVOMFVMDA1':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVOMFVMDAR1 | OTVOMFVMDBR3 | OTVOMFVMDSB3 | OTVOMFVMDP3 |
And logged in with details of 'OTVOMFVMDU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish3-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish3-Ad.mov'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVOMFVMDAR1 | OTVOMFVMDBR3 | OTVOMFVMDSB3 | OTVOMFVMDP3 | OTVOMFVMDC3 | OTVOMFVMDCN3_1 | 20       | 12/14/2022     | HD 1080i 25fps | OTVOMFVMDT3 | Already Supplied   | BSkyB Green Button:Standard |
And hold for approval 'tv' order items with following clock numbers 'OTVOMFVMDCN3_1'
And add to 'tv' order item with clock number 'OTVOMFVMDCN3_1' following asset 'Fish3-Ad.mov' of collection 'My Assets'
And complete order contains item with clock number 'OTVOMFVMDCN3_1' with following fields:
| Job Number     | PO Number      |
| OTVOMFVMDJN3_1 | OTVOMFVMDPN3_1 |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number   | Destination                |
| OTVOMFVMDCN3_2 | Universal Ireland:Standard |
And add to 'tv' order item with clock number 'OTVOMFVMDCN3_2' following qc asset 'Fish3-Ad.mov' of collection 'My Assets'
And complete order with market 'Republic of Ireland' with following fields:
| Job Number     | PO Number      |
| OTVOMFVMDJN3_2 | OTVOMFVMDPN3_2 |
When I go to View Media Details page for order with market 'Republic of Ireland' contains item with clock number 'OTVOMFVMDCN3_1'
Then I should see following media information on View Media Details page:
| Clock Number   | Advertiser   | Brand        | Sub Brand    | Product     | Title        | Duration | First Air Date | Additional Details  | Video Format                                | Aspect Ratio | Video Standard |
| OTVOMFVMDCN3_1 | OTVOMFVMDAR1 | OTVOMFVMDBR3 | OTVOMFVMDSB3 | OTVOMFVMDP3 | Fish3-Ad.mov | 6s 33ms  | 12/14/2022     | automated test info | Broadcast SD PAL 16x9 Program Stream master | 16x9         | 720x576i@25fps |
And should see destinations delivered for orders with markets 'Republic of Ireland' with following fields:
| Order # | Destination        | Date Ordered  | Ordered by  | Status         |
| Digit   | Universal Ireland  | DateSubmitted | OTVOMFVMDU1 | Order Placed   |



Scenario: check View Media details with specific clock number
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVOMFVMDA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVOMFVMDU1 | agency.admin | OTVOMFVMDA1  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVOMFVMDA1':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVOMFVMDAR1 | OTVOMFVMDBR4 | OTVOMFVMDSB4 | OTVOMFVMDP4 |
And logged in with details of 'OTVOMFVMDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVOMFVMDAR1 | OTVOMFVMDBR4 | OTVOMFVMDSB4 | OTVOMFVMDP4 | OTVOMFVMDC4 | OTVOMFVMD/CN/4 | 20       | 12/14/2022     | HD 1080i 25fps | OTVOMFVMDT4 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVOMFVMD/CN/4' with following fields:
| Job Number   | PO Number    |
| OTVOMFVMDJN4 | OTVOMFVMDPN4 |
When I go to View Media Details page for order contains item with following clock number 'OTVOMFVMD/CN/4'
Then I should see following media information on View Media Details page:
| Clock Number   | Advertiser   | Brand        | Sub Brand    | Product     | Title       | Duration | First Air Date | Additional Details  | Video Format                                | Aspect Ratio | Video Standard |
| OTVOMFVMD/CN/4 | OTVOMFVMDAR1 | OTVOMFVMDBR4 | OTVOMFVMDSB4 | OTVOMFVMDP4 | OTVOMFVMDT4 | 20       | 12/14/2022     | automated test info | Broadcast SD PAL 16x9 Program Stream master | 16x9         | 720x576i@25fps |
And should see destination delivered for order contains item with clock number 'OTVOMFVMD/CN/4' with following fields:
| Order # | Destination        | Date Ordered  | Ordered by  | Status       |
| Digit   | BSkyB Green Button | DateSubmitted | OTVOMFVMDU1 | Order Placed |

Scenario: check opening of View Media details page for asset in Library
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVOMFVMDA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVOMFVMDU1 | agency.admin | OTVOMFVMDA1  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVOMFVMDA1':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVOMFVMDAR1 | OTVOMFVMDBR5 | OTVOMFVMDSB5 | OTVOMFVMDP5 |
And logged in with details of 'OTVOMFVMDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number   | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVOMFVMDAR1 | OTVOMFVMDBR5 | OTVOMFVMDSB5 | OTVOMFVMDP5 | OTVOMFVMDC5 | OTVOMFVMDCN5_1 | 20       | 12/14/2022     | HD 1080i 25fps | OTVOMFVMDT5 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number   |
| OTVOMFVMDCN5_2 |
And complete order contains item with clock number 'OTVOMFVMDCN5_1' with following fields:
| Job Number   | PO Number    |
| OTVOMFVMDJN5 | OTVOMFVMDPN5 |
When I go to View Media Details page of qc asset 'OTVOMFVMDT5' of collection 'My Assets' from order contains item with following clock number 'OTVOMFVMDCN5_1'
Then I should see following media information on View Media Details page:
| Clock Number   | Advertiser   | Brand        | Sub Brand    | Product     | Title       | Duration | First Air Date | Additional Details  | Video Format                                | Aspect Ratio | Video Standard |
| OTVOMFVMDCN5_1 | OTVOMFVMDAR1 | OTVOMFVMDBR5 | OTVOMFVMDSB5 | OTVOMFVMDP5 | OTVOMFVMDT5 | 20       | 12/14/2022     | automated test info | Broadcast SD PAL 16x9 Program Stream master | 16x9         | 720x576i@25fps |
And should see destination delivered for order contains item with clock number 'OTVOMFVMDCN5_1' with following fields:
| Order # | Destination        | Date Ordered  | Ordered by  | Status       |
| Digit   | BSkyB Green Button | DateSubmitted | OTVOMFVMDU1 | Order Placed |