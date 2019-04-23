!--ORD-2149
!--ORD-2301
Feature: Validate Add information section when user hitted QC Ingest Only button
Narrative:
In order to:
As a AgencyAdmin
I want to check validation of Add information section when user hitted QC Ingest Only button

Scenario: Check that all required fields are marked with red border after clicking QC & Ingest Only button
!--ORD-2294
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| VAISA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| VAISE1 | agency.admin | VAISA1       |
And logged in with details of 'VAISE1'
And I am on View Draft Orders tab of '<OrderType>' order on ordering page
When I create '<OrderType>' order on View Draft Orders tab on ordering page
And do QC & Ingest Only for active order item at Select Broadcast Destinations
Then I 'should' see that following fields '<Fields>' are required for order item on Add information form

Examples:
| OrderType | Fields                                                                  |
| tv        | Advertiser,Brand,Sub Brand,Product,Title,Duration,First Air Date,Format |
| music     | Record Company,Brand,Sub Brand,Label,Title,Release Date,Format          |

Scenario: Check that all required fields remains marked with red border after unclicking QC & Ingest Only button except Format field
!--ORD-2294
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| VAISA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| VAISE1 | agency.admin | VAISA1       |
And logged in with details of 'VAISE1'
And I am on View Draft Orders tab of '<OrderType>' order on ordering page
When I create '<OrderType>' order on View Draft Orders tab on ordering page
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And do QC & Ingest Only for active order item at Select Broadcast Destinations
Then I 'should' see that following fields '<Fields>' are required for order item on Add information form

Examples:
| OrderType | Fields                                                           |
| tv        | Advertiser,Brand,Sub Brand,Product,Title,Duration,First Air Date |
| music     | Record Company,Brand,Sub Brand,Label,Title,Release Date          |