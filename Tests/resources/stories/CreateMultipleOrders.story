Feature: Mutliple Order Confirmation -- To help manual QA for TD-324 manual testing
Narrative:
In order to:
As a AgencyAdmin
I want to check mutlitple orders are created

Scenario: Confirmation of multiple orders with 2 destinations
Given I created the following agency:
| Name  | A4User        |
| CMOA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| CMOU1 | agency.admin | CMOA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CMOA1':
| Advertiser | Brand  | Sub Brand | Product |
| CMOAR1     | CMOBR1 | CMOSB1    | CMOPR1  |
And logged in with details of 'CMOU1'
And create 'tv' with '150' multiple orders with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | CMOAR1     | CMOBR1 | CMOSB1    | CMOPR1  | CMOC1    | CMOCN       | 20       | 10/14/2022     | HD 1080i 25fps | CMOT1 | Already Supplied   | BSkyB Green Button:Standard;Talk Sport:Standard |


Scenario: Confirmation of multiple orders with mutliple clocks
Given I created the following agency:
| Name  | A4User        |
| MCOA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| MCOU1 | agency.admin | MCOA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCOA1':
| Advertiser | Brand  | Sub Brand | Product |
| MCOAR1     | MCOBR1 | MCOSB1    | MCOPR1  |
And logged in with details of 'MCOU1'
And create 'tv' with '10' multiple orders with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | MCOAR1     | MCOBR1 | MCOSB1    | MCOPR1  | MCOC1    | MCOCN1       | 20       | 10/14/2022     | HD 1080i 25fps | MCOT1 | Already Supplied   | BSkyB Green Button:Standard;Talk Sport:Standard |
| automated test info    | MCOAR2     | MCOBR2 | MCOSB2    | MCOPR2  | MCOC2    | MCOCN2       | 20       | 10/14/2022     | HD 1080i 25fps | MCOT2 | Already Supplied   | Aastha:Standard                                 |
| automated test info    | MCOAR3     | MCOBR3 | MCOSB3    | MCOPR3  | MCOC3    | MCOCN3       | 20       | 10/14/2022     | HD 1080i 25fps | MCOT3 | Already Supplied   | PTV Prime:Standard |
| automated test info    | MCOAR4     | MCOBR4 | MCOSB4    | MCOPR4  | MCOC4    | MCOCN4       | 20       | 10/14/2022     | HD 1080i 25fps | MCOT4 | Already Supplied   | ABP News:Standard |
| automated test info    | MCOAR5     | MCOBR5 | MCOSB5    | MCOPR5  | MCOC5    | MCOCN5       | 20       | 10/14/2022     | HD 1080i 25fps | MCOT5 | Already Supplied   | Zee TV:Standard |
| automated test info    | MCOAR6     | MCOBR6 | MCOSB6    | MCOPR6  | MCOC6    | MCOCN6       | 20       | 10/14/2022     | HD 1080i 25fps | MCOT6 | Already Supplied   | Aastha:Standard |
| automated test info    | MCOAR7     | MCOBR7 | MCOSB7    | MCOPR7  | MCOC7    | MCOCN7       | 20       | 10/14/2022     | HD 1080i 25fps | MCOT7 | Already Supplied   | PTV Prime:Standard |
| automated test info    | MCOAR8     | MCOBR8 | MCOSB8    | MCOPR8  | MCOC8    | MCOCN8       | 20       | 10/14/2022     | HD 1080i 25fps | MCOT8 | Already Supplied   | ABP News:Standard |


