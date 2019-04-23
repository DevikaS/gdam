!--ORD-373
!--ORD-3081
Feature: Check showing X Y info for projects files
Narrative:
In order to:
As a AgencyAdmin
I want to check showing X Y info for projects files

Scenario: check files found notification after retrieve from projects
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU1 | agency.admin | SXYIPFA1     |
And logged in with details of 'SXYIPFU1'
And created 'SXYIPFP1' project
And created '/SXYIPFF1' folder for project 'SXYIPFP1'
And uploaded into project 'SXYIPFP1' following files:
| FileName             | Path      |
| /files/Fish1-Ad.mov  | /SXYIPFF1 |
| /files/Fish2-Ad.mov  | /SXYIPFF1 |
| /files/Fish3-Ad.mov  | /SXYIPFF1 |
| /files/Fish4-Ad.mov  | /SXYIPFF1 |
| /files/Fish5-Ad.mov  | /SXYIPFF1 |
| /files/Fish6-Ad.mov  | /SXYIPFF1 |
| /files/Fish7-Ad.mov  | /SXYIPFF1 |
| /files/Fish8-Ad.mov  | /SXYIPFF1 |
| /files/Fish9-Ad.mov  | /SXYIPFF1 |
| /files/Fish10-Ad.mov | /SXYIPFF1 |
| /files/Fish11-Ad.mov | /SXYIPFF1 |
And waited while transcoding is finished in folder '/SXYIPFF1' on project 'SXYIPFP1' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN1    |
When I open order item with following clock number 'SXYIPFCN1'
And open project 'SXYIPFP1' folder '/SXYIPFF1' at Add media to your order form for retrieving files
Then I should see following 'Projects' content counter notification '11 files found. Showing 1 - 10' for order item at Add media to your order form

Scenario: check files found notification for second page after retrieve from projects
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU1 | agency.admin | SXYIPFA1     |
And logged in with details of 'SXYIPFU1'
And created 'SXYIPFP1' project
And created '/SXYIPFF1' folder for project 'SXYIPFP1'
And uploaded into project 'SXYIPFP1' following files:
| FileName             | Path      |
| /files/Fish1-Ad.mov  | /SXYIPFF1 |
| /files/Fish2-Ad.mov  | /SXYIPFF1 |
| /files/Fish3-Ad.mov  | /SXYIPFF1 |
| /files/Fish4-Ad.mov  | /SXYIPFF1 |
| /files/Fish5-Ad.mov  | /SXYIPFF1 |
| /files/Fish6-Ad.mov  | /SXYIPFF1 |
| /files/Fish7-Ad.mov  | /SXYIPFF1 |
| /files/Fish8-Ad.mov  | /SXYIPFF1 |
| /files/Fish9-Ad.mov  | /SXYIPFF1 |
| /files/Fish10-Ad.mov | /SXYIPFF1 |
| /files/Fish11-Ad.mov | /SXYIPFF1 |
And waited while transcoding is finished in folder '/SXYIPFF1' on project 'SXYIPFP1' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN2    |
When I open order item with following clock number 'SXYIPFCN2'
And open project 'SXYIPFP1' folder '/SXYIPFF1' at Add media to your order form for retrieving files
And scroll to page '2' in 'Projects' content for Add media to your order form
Then I should see following 'Projects' content counter notification '11 files found. Showing 11 - 11' for order item at Add media to your order form

Scenario: check files found notification after searching files
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU1 | agency.admin | SXYIPFA1     |
And logged in with details of 'SXYIPFU1'
And created 'SXYIPFP1' project
And created '/SXYIPFF1' folder for project 'SXYIPFP1'
And uploaded into project 'SXYIPFP1' following files:
| FileName             | Path      |
| /files/Fish1-Ad.mov  | /SXYIPFF1 |
| /files/Fish2-Ad.mov  | /SXYIPFF1 |
And waited while transcoding is finished in folder '/SXYIPFF1' on project 'SXYIPFP1' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN3    |
When I open order item with following clock number 'SXYIPFCN3'
And open project 'SXYIPFP1' folder '/SXYIPFF1' at Add media to your order form for retrieving files
And fill Search field by value 'Fish1-Ad' for Add media to your order form on order item page
Then I should see following 'Projects' content counter notification '1 files found. Showing 1 - 1' for order item at Add media to your order form

Scenario: check files found notification after searching files by wrong filter
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU1 | agency.admin | SXYIPFA1     |
And logged in with details of 'SXYIPFU1'
And created 'SXYIPFP1' project
And created '/SXYIPFF1' folder for project 'SXYIPFP1'
And uploaded into project 'SXYIPFP1' following files:
| FileName             | Path      |
| /files/Fish1-Ad.mov  | /SXYIPFF1 |
And waited while transcoding is finished in folder '/SXYIPFF1' on project 'SXYIPFP1' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN4    |
When I open order item with following clock number 'SXYIPFCN4'
And open project 'SXYIPFP1' folder '/SXYIPFF1' at Add media to your order form for retrieving files
And fill Search field by value 'test file' for Add media to your order form on order item page
Then I should see following 'Projects' content counter notification '0 folders and 0 files found. Showing 0 - 0' for order item at Add media to your order form

Scenario: check files found notification after deleting file in project
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU1 | agency.admin | SXYIPFA1     |
And logged in with details of 'SXYIPFU1'
And created 'SXYIPFP5' project
And created '/SXYIPFF5' folder for project 'SXYIPFP5'
And uploaded into project 'SXYIPFP5' following files:
| FileName             | Path      |
| /files/Fish1-Ad.mov  | /SXYIPFF5 |
And waited while transcoding is finished in folder '/SXYIPFF5' on project 'SXYIPFP5' files page
And deleted file 'Fish1-Ad.mov' in project 'SXYIPFP5' folder '/SXYIPFF5'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN5    |
When I open order item with following clock number 'SXYIPFCN5'
And open project 'SXYIPFP5' folder '/SXYIPFF5' at Add media to your order form for retrieving files
And fill Search field by value 'Fish1-Ad' for Add media to your order form on order item page
Then I should see following 'Projects' content counter notification '0 folders and 0 files found. Showing 0 - 0' for order item at Add media to your order form

Scenario: check files found notification for files with Music Promo
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU1 | agency.admin | SXYIPFA1     |
And logged in with details of 'SXYIPFU1'
And created 'SXYIPFP6' project
And created '/SXYIPFF6' folder for project 'SXYIPFP6'
And uploaded into project 'SXYIPFP6' following files:
| FileName             | Path      |
| /files/Fish1-Ad.mov  | /SXYIPFF6 |
And waited while transcoding is finished in folder '/SXYIPFF6' on project 'SXYIPFP6' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/SXYIPFF6' project 'SXYIPFP6'
When I 'save' file info by next information:
| FieldName | FieldValue  |
| Screen    | Music Promo |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN6_1  |
And created 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code   |
| SXYIPFCN6_2 |
And open order item with following clock number 'SXYIPFCN6_1'
And open project 'SXYIPFP6' folder '/SXYIPFF6' at Add media to your order form for retrieving files
Then I should see following 'Projects' content counter notification '0 folders and 0 files found. Showing 0 - 0' for order item at Add media to your order form
When I open order item with following isrc code 'SXYIPFCN6_2'
And refresh the page without delay
And open project 'SXYIPFP6' folder '/SXYIPFF6' at Add media to your order form for retrieving files
Then I should see following 'Projects' content counter notification '1 files found. Showing 1 - 1' for order item at Add media to your order form

Scenario: check projects found notification after retrieve from projects
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA7 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU7 | agency.admin | SXYIPFA7     |
And logged in with details of 'SXYIPFU7'
And created 'SXYIPFP7_1,SXYIPFP7_2,SXYIPFP7_3' projects
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN7    |
When I open order item with following clock number 'SXYIPFCN7'
And retrieve files from projects for order item at Add media to your order form
Then I should see following 'Projects' content counter notification '3 project(s) found. Showing 1 - 3' for order item at Add media to your order form

Scenario: check projects found notification after searching projects
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA7 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU7 | agency.admin | SXYIPFA7     |
And logged in with details of 'SXYIPFU7'
And created 'SXYIPFP7_1,SXYIPFP7_2,SXYIPFP7_3' projects
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN8    |
When I open order item with following clock number 'SXYIPFCN8'
And retrieve files from projects for order item at Add media to your order form
And fill Search field by value 'SXYIPFP7_1' for Add media to your order form on order item page
Then I should see following 'Projects' content counter notification '1 project(s) found. Showing 1 - 1' for order item at Add media to your order form

Scenario: check folders found notification after retrieve from projects
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU1 | agency.admin | SXYIPFA1     |
And logged in with details of 'SXYIPFU1'
And created 'SXYIPFP9' project
And created in 'SXYIPFP9' project next folders:
| folder      |
| /SXYIPFF9_1 |
| /SXYIPFF9_2 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN9    |
When I open order item with following clock number 'SXYIPFCN9'
And open project 'SXYIPFP9' at Add media to your order form for retrieving folders and files
Then I should see following 'Projects' content counter notification '2 folder(s) found. Showing 1 - 2' for order item at Add media to your order form

Scenario: check folders and files found notification after retrieve from projects
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU1 | agency.admin | SXYIPFA1     |
And logged in with details of 'SXYIPFU1'
And created 'SXYIPFP10' project
And created in 'SXYIPFP10' project next folders:
| folder                     |
| /SXYIPFF10_1/SXYIPFF10_1_1 |
And uploaded into project 'SXYIPFP10' following files:
| FileName             | Path         |
| /files/Fish1-Ad.mov  | /SXYIPFF10_1 |
| /files/Fish2-Ad.mov  | /SXYIPFF10_1 |
And waited while transcoding is finished in folder '/SXYIPFF10_1' on project 'SXYIPFP10' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN10   |
When I open order item with following clock number 'SXYIPFCN10'
And open project 'SXYIPFP10' folder '/SXYIPFF10_1' at Add media to your order form for retrieving files
Then I should see following 'Projects' content counter notification '1 folders and 2 files found. Showing 1 - 3' for order item at Add media to your order form

Scenario: check folders and files found notification after searching file
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SXYIPFA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SXYIPFU1 | agency.admin | SXYIPFA1     |
And logged in with details of 'SXYIPFU1'
And created 'SXYIPFP10' project
And created in 'SXYIPFP10' project next folders:
| folder                     |
| /SXYIPFF10_1/SXYIPFF10_1_1 |
And uploaded into project 'SXYIPFP10' following files:
| FileName             | Path         |
| /files/Fish1-Ad.mov  | /SXYIPFF10_1 |
| /files/Fish2-Ad.mov  | /SXYIPFF10_1 |
And waited while transcoding is finished in folder '/SXYIPFF10_1' on project 'SXYIPFP10' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SXYIPFCN11   |
When I open order item with following clock number 'SXYIPFCN11'
And open project 'SXYIPFP10' folder '/SXYIPFF10_1' at Add media to your order form for retrieving files
And fill Search field by value 'Fish1-Ad' for Add media to your order form on order item page
Then I should see following 'Projects' content counter notification '1 files found. Showing 1 - 1' for order item at Add media to your order form