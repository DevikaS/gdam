!--ORD-1747
!--ORD-2109
Feature: Copy to All functionality for Add media section
Narrative:
In order to:
As a AgencyAdmin
I want to check copy to all functionality for Add media section

Scenario: Didn't update data on the coverflow if you use action Copy to All for Add media section
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| CTAFFAMSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| CTAFFAMSE1 | agency.admin | CTAFFAMSA1   |streamlined_library|
And logged in with details of 'CTAFFAMSE1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| CTAFFAMS1_CN1 |
| CTAFFAMS1_CN2 |
When added for 'tv' order to item with clock number 'CTAFFAMS1_CN1' a New Master with following fields:
| Supply Via | Assignee   | Message        | Deadline Date |
| FTP        | CTAFFAMSE1 | automated test | 12/14/2022    |
And added to 'tv' order item with clock number 'CTAFFAMS1_CN2' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And open order item with following clock number 'CTAFFAMS1_CN1'
And copy data from 'Add media' section of order item page to all other items
And select order item with following clock number 'CTAFFAMS1_CN2' on cover flow
Then I should see for active order item on cover flow following data:
| Media requested                 |
| Media requested from CTAFFAMSE1 |


Scenario: Copy values from the Add media section if you didn't click on the button Add to the order
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| CTAFFAMSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| CTAFFAMSE1 | agency.admin | CTAFFAMSA1   |
And logged in with details of 'CTAFFAMSE1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code     |
| CTAFFAMS2_CN1 |
| CTAFFAMS2_CN2 |
When I open order item with following isrc code 'CTAFFAMS2_CN1'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee   | Already Supplied | Message        | Deadline Date |
| CTAFFAMSE1 | should not       | automated test | 12/14/2022    |
And copy data from 'Add media' section of order item page to all other items
And select order item with following isrc code 'CTAFFAMS2_CN2' on cover flow
Then I 'should' see expanded following sections 'Add media' on order item page
And should see following data on New Master form for order item that supply via 'FTP':
| Assignee   | Already Supplied | Message        | Deadline Date |
| CTAFFAMSE1 | should not       | automated test | 12/14/2022    |

Scenario: Copy to All for the second order item
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| CTAFFAMSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| CTAFFAMSE1 | agency.admin | CTAFFAMSA1   |
And logged in with details of 'CTAFFAMSE1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| CTAFFAMS3_CN1 |
| CTAFFAMS3_CN2 |
When added for 'tv' order to item with clock number 'CTAFFAMS3_CN1' a New Master with following fields:
| Supply Via | Assignee   | Message        | Deadline Date |
| FTP        | CTAFFAMSE1 | automated test | 12/14/2022    |
And open order item with following clock number 'CTAFFAMS3_CN1'
And copy data from 'Add media' section of order item page to all other items
And select order item with following isrc code 'CTAFFAMS3_CN2' on cover flow
Then I should see for active order item on cover flow following data:
| Media requested                 |
| Media requested from CTAFFAMSE1 |
And should see following data on New Master form for order item that supply via 'FTP':
| Assignee   | Message        | Deadline Date |
| CTAFFAMSE1 | automated test | 12/14/2022    |

Scenario: Copy to All visibility for the second order item with QC asset
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| CTAFFAMSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| CTAFFAMSE1 | agency.admin | CTAFFAMSA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CTAFFAMSA1':
| Advertiser | Brand      | Sub Brand   | Product    |
| CTAFFAMSA4 | CTAFFAMSB4 | CTAFFAMSSB4 | CTAFFAMSP4 |
And logged in with details of 'CTAFFAMSE1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand   | Product    | Artist      | ISRC Code     | Release Date | Format         | Title      | Destination                 |
| automated test info    | CTAFFAMSA4 | CTAFFAMSB4 | CTAFFAMSSB4 | CTAFFAMSP4 | CTAFFAMSPC4 | CTAFFAMS4_CN1 | 12/14/2022   | HD 1080i 25fps | CTAFFAMST4 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'CTAFFAMS4_CN1' with following fields:
| Job Number  | PO Number   |
| CTAFFAMSJN4 | CTAFFAMSPN4 |
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| ISRC Code     |
| CTAFFAMS4_CN2 |
| CTAFFAMS4_CN3 |
And add to 'music' order item with isrc code 'CTAFFAMS4_CN2' following qc asset 'CTAFFAMST4' of collection 'My Assets'
When I open order item with isrc code 'CTAFFAMS4_CN1' for order with market 'Republic of Ireland'
Then I 'should not' see Copy to All link next to following sections 'Add media' on order item page

Scenario: Copy to All visibility for the second order item with none-QC asset
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| CTAFFAMSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| CTAFFAMSE1 | agency.admin | CTAFFAMSA1   |
And logged in with details of 'CTAFFAMSE1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| CTAFFAMS5_CN1 |
| CTAFFAMS5_CN2 |
And created 'CTAFFAMSP5' project
And created '/CTAFFAMSF5' folder for project 'CTAFFAMSP5'
And uploaded into project 'CTAFFAMSP5' following files:
| FileName             | Path        |
| /files/Fish1-Ad.mov  | /CTAFFAMSF5 |
And waited while transcoding is finished in folder '/CTAFFAMSF5' on project 'CTAFFAMSP5' files page
And add to 'tv' order item with clock number 'CTAFFAMS5_CN1' following file '/files/Fish1-Ad.mov' from folder '/CTAFFAMSF5' of project 'CTAFFAMSP5'
When open order item with following clock number 'CTAFFAMS5_CN1'
Then I 'should not' see Copy to All link next to following sections 'Add media' on order item page

Scenario: Copied New Master details with QC
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| CTAFFAMSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| CTAFFAMSE1 | agency.admin | CTAFFAMSA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CTAFFAMSA1':
| Advertiser | Brand      | Sub Brand   | Product    |
| CTAFFAMSA4 | CTAFFAMSB4 | CTAFFAMSSB4 | CTAFFAMSP4 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'CTAFFAMSA1'
And logged in with details of 'CTAFFAMSE1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand   | Product    | Artist      | ISRC Code     | Release Date | Format         | Title      | Destination                 |
| automated test info    | CTAFFAMSA4 | CTAFFAMSB4 | CTAFFAMSSB4 | CTAFFAMSP4 | CTAFFAMSPC6 | CTAFFAMS6_CN1 | 12/14/2022   | HD 1080i 25fps | CTAFFAMST6 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'CTAFFAMS6_CN1' with following fields:
| Job Number  | PO Number   |
| CTAFFAMSJN6 | CTAFFAMSPN6 |
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| ISRC Code     |
| CTAFFAMS6_CN2 |
| CTAFFAMS6_CN3 |
And add for 'music' order to item with isrc code 'CTAFFAMS6_CN2' a New Master with following fields:
| Supply Via | Assignee   | Message        | Deadline Date |
| FTP        | CTAFFAMSE1 | automated test | 12/14/2022    |
And add to 'music' order item with isrc code 'CTAFFAMS6_CN3' following qc asset 'CTAFFAMST6' of collection 'My Assets'
When I open order item with following isrc code 'CTAFFAMS6_CN2'
And copy data from 'Add media' section of order item page to all other items
And select order item with isrc code 'CTAFFAMS6_CN1' on cover flow for order with market 'Republic of Ireland'
Then I should see for active order item on cover flow following data:
| Media requested                 |
| Media requested from CTAFFAMSE1 |
And should see following data on New Master form for order item that supply via 'FTP':
| Assignee   | Message        | Deadline Date |
| CTAFFAMSE1 | automated test | 12/14/2022    |
And should see 'enabled' following fields 'Additional Information,Artist,Title,Advertiser,Brand,Sub Brand,Product,ISRC Code,Format,Release Date' for order item on Add information form

Scenario: Copied New Master details with none-QC
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| CTAFFAMSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| CTAFFAMSE1 | agency.admin | CTAFFAMSA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CTAFFAMSA1':
| Advertiser | Brand      | Sub Brand   | Product    |
| CTAFFAMSA4 | CTAFFAMSB4 | CTAFFAMSSB4 | CTAFFAMSP4 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'CTAFFAMSA1'
And logged in with details of 'CTAFFAMSE1'
And created 'CTAFFAMSP7' project
And created '/CTAFFAMSF7' folder for project 'CTAFFAMSP7'
And uploaded into project 'CTAFFAMSP7' following files:
| FileName             | Path        |
| /files/Fish1-Ad.mov  | /CTAFFAMSF7 |
And waited while transcoding is finished in folder '/CTAFFAMSF7' on project 'CTAFFAMSP7' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| CTAFFAMS7_CN1 |
| CTAFFAMS7_CN2 |
And add for 'tv' order to item with clock number 'CTAFFAMS7_CN1' a New Master with following fields:
| Supply Via | Assignee   | Message        | Deadline Date |
| FTP        | CTAFFAMSE1 | automated test | 12/14/2022    |
And add to 'tv' order item with clock number 'CTAFFAMS7_CN2' following file '/files/Fish1-Ad.mov' from folder '/CTAFFAMSF7' of project 'CTAFFAMSP7'
When I open order item with following clock number 'CTAFFAMS7_CN1'
And copy data from 'Add media' section of order item page to all other items
And select order item with following clock number 'CTAFFAMS7_CN2' on cover flow
Then I should see for active order item on cover flow following data:
| Media requested                 |
| Media requested from CTAFFAMSE1 |
And should see following data on New Master form for order item that supply via 'FTP':
| Assignee   | Message        | Deadline Date |
| CTAFFAMSE1 | automated test | 12/14/2022    |
And should see 'enabled' following fields 'Additional Information,Campaign,Title,Advertiser,Clock Number,Format,Duration,First Air Date' for order item on Add information form