!--ORD-2254
!--ORD-2648
Feature: Advanced search using csv files
Narrative:
In order to:
As a AgencyAdmin
I want to check advanced search using csv files

Scenario: Check correct work searching in case to upload csv file
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN1    |
When I open order item with following clock number 'OASCSVCN1'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| File                |
| /files/syscodes.csv |
And do searching by uploaded syscodes on Advanced Search form of Select Broadcast Destination section
Then I 'should' see following destinations 'Comcast/North East, CO;Comcast/Salida, CO;Comcast/South East, CO;Comcast/Sterling, CO' in destination table on Select Broadcast Destinations form

Scenario: Check that rest fields are locked in case to upload csv file into Select Broadcast Destinations
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN2    |
When I open order item with following clock number 'OASCSVCN2'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| File                |
| /files/syscodes.csv |
And 'cancel' Your multiple search results popup on Advanced Search form of Select Broadcast Destination section
Then I should see 'disabled' following fields 'Market,Destination Type,Syscode,Delivery Type,Syscodes' for order item on Advanced search form of Select Broadcast Destinations section

Scenario: Check correct work in case to upload csv with existed syscodes and non existed
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN3    |
When I open order item with following clock number 'OASCSVCN3'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| File                      |
| /files/syscodes_wrong.csv |
And do searching by uploaded syscodes on Advanced Search form of Select Broadcast Destination section
Then I 'should' see following destinations 'Comcast/North East, CO;Comcast/Salida, CO;Comcast/South East, CO;Comcast/Sterling, CO' in destination table on Select Broadcast Destinations form
And 'should not' see following destinations 'USA Comcast HD 370050' in destination table on Select Broadcast Destinations form

Scenario: Check that empty CSV file cannot be uploaded
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN4    |
When I open order item with following clock number 'OASCSVCN4'
And fill upload file field for Advanced search form on Select Broadcast Destination section:
| File                      |
| /files/syscodes_empty.csv |
Then I 'should' see validation file type error next to upload File field on Advanced Search form of Select Broadcast Destination section

Scenario: Check uploading csv with 3000 syscodes
!--ORD-2605
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN5    |
When I open order item with following clock number 'OASCSVCN5'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| File                        |
| /files/syscodes3000_new.csv |
And do searching by uploaded syscodes on Advanced Search form of Select Broadcast Destination section
Then I 'should' see following destinations 'Comcast/Atlanta East U-verse, GA;Comcast/Portland, OR I+ SC, OR;Comcast/Salt Lake City I+ SC, UT' in destination table on Select Broadcast Destinations form

Scenario: Check that Reset button removes uploaded csv file from Browse button
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN6    |
When I open order item with following clock number 'OASCSVCN6'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| File                |
| /files/syscodes.csv |
And 'cancel' Your multiple search results popup on Advanced Search form of Select Broadcast Destination section
And reset filter options on Advanced Search form of Select Broadcast Destination section
Then I should see 'enabled' following fields 'Market,Destination Type,Syscode,Delivery Type,Syscodes,File' for order item on Advanced search form of Select Broadcast Destinations section

Scenario: Check that Reset button removes validation file type error next to upload file field
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN7    |
When I open order item with following clock number 'OASCSVCN7'
And fill upload file field for Advanced search form on Select Broadcast Destination section:
| File                      |
| /files/syscodes_empty.csv |
And reset filter options on Advanced Search form of Select Broadcast Destination section
Then I 'should not' see validation file type error next to upload File field on Advanced Search form of Select Broadcast Destination section

Scenario: Check that Clear Section removes uploaded csv file from Browse button
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN8    |
When I open order item with following clock number 'OASCSVCN8'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| File                |
| /files/syscodes.csv |
And do searching by uploaded syscodes on Advanced Search form of Select Broadcast Destination section
And clear 'Select Broadcast Destinations' section on order item page
Then I should see 'enabled' following fields 'Market,Destination Type,Syscode,Delivery Type,Syscodes,File' for order item on Advanced search form of Select Broadcast Destinations section

Scenario: Check that order of syscodes on Your multiple search results in case to upload csv is the same as in uploaded csv
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN9   |
When I open order item with following clock number 'OASCSVCN9'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| File                |
| /files/syscodes.csv |
Then I should see following 'found' syscodes '3250,5434,3251,8036' in the right order on Your multiple search results popup on Advanced Search form of Select Broadcast Destination section

Scenario: Check visibilty not found syscodes on Your multiple search results in case to upload csv
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN10   |
When I open order item with following clock number 'OASCSVCN10'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| File                      |
| /files/syscodes_wrong.csv |
Then I 'should' see following 'not found' syscode '370050' on Your multiple search results popup on Advanced Search form of Select Broadcast Destination section

Scenario: Check visibilty found and not found syscodes on Your multiple search results in case to upload csv
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OASCSVA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OASCSVU1 | agency.admin | OASCSVA1     |
And logged in with details of 'OASCSVU1'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Clock Number |
| OASCSVCN11   |
When I open order item with following clock number 'OASCSVCN11'
And fill following fields for Advanced search form on Select Broadcast Destination section:
| File                      |
| /files/syscodes_wrong.csv |
Then I 'should' see following 'found' syscode '3250,5434,3251,8036' on Your multiple search results popup on Advanced Search form of Select Broadcast Destination section
And 'should' see following 'not found' syscode '370050' on Your multiple search results popup on Advanced Search form of Select Broadcast Destination section