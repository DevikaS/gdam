!--ORD-3906
!--ORD-4206
Feature: Market Schema fields avaliable to the choose in the thumbnail view
Narrative:
In order to:
As a AgencyAdmin
I want to check avalability to choose market schema fields in the thumbnail view

Scenario: Check saving number order of fields
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MSFATA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MSFATU1 | agency.admin | MSFATA1      |
And logged in with details of 'MSFATU1'
And I am on View Video Asset Management page

Scenario: Save by order fields in the Views section  (Should check for all markets)
Given I logged as admin@asdstream.com
And navigate to the Views Section
And click on the Video link
And in the area for  market enter the values for the following fields:
| Fields     | Value |
| Language   | 2     |
| MBCID Code | 3     |
And save changes
When I refresh the page
Then I should see  the following fields in the previews section:
| Fields     |
| Language   |
| MBCID Code |

Scenario: Reset to default selection

Scenario: Displaying chosen fields in the  thumbnail view when you create an order

Scenario: Check that music section displaying without changes if you set the changes for TV sections

Scenario: Delation the values from fields and check saving

Scenario: Displaying chosen fields in the  thumbnail view when you open the Library

Scenario: Displaying chosen fields in the  thumbnail view when you open the Project

Scenario: Check that markets in Views section are sorted alphabetically

Scenario: Check availability of View section after refreshing the page. Use market Brazil fill all fields
!--ORD-4189

Scenario: Check displaying values of market specific fields in Thumbnail view of Library
!--ORD-4168

Scenario: "Open File" shouldn't show in the Views(Preview) section for miniature
!--ORD-4216