Feature: Create order via OneDelivery
Narrative:
In order to
As a GlobalAdmin
I want to place new orders

Scenario: Create Orders via OneDelivery
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand | Sub Brand | Product |
| Adv01      | Br01  | Sbr01     | Prod01  |
And logged in with details of 'AgencyAdmin'
And I clicked new order on OneDelivery home page
And I filled new order with following details for OneDelivery order:
| Select Market  | Who is supplying the media |
| United Kingdom | AgencyAdmin                |
And I filled following clock metadata for OneDelivery order:
| Clock Number | Advertiser | Brand | Sub Brand | Product | Title    | Duration | First Air Date | Subtitles Required | Destinations |
| Clock01      | Adv01      | Br01  | Sbr01     | Prod01  | Title 01 | 10       | 05/10/2021     | None               | ARY News:STD |
And I clicked continue button on OneDelivery billing page
And I placed the order from OneDelivery