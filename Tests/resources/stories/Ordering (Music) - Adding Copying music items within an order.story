!--ORD-1536
Feature: Adding/Copying music videos within an order
Narrative:
In order to:
As a AgencyAdmin
I want to check copy item functionality

Scenario: Check adding new order item in case to use Copy current button for music
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OMACCOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OMACCOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMACCOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMACCOAR1  | OMACCOBR1 | OMACCOSB1 | OMACCOP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMACCOA1'
And logged in with details of '<UserEmail>'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code  | Release Date | Format         | Title    | Destination                                    |
| automated test info    | OMACCOAR1      | OMACCOBR1 | OMACCOSB1 | OMACCOP1 | OMACCOC1 | <ISRCCode> | 12/14/2022   | HD 1080i 25fps | OMACCOT1 | PTV Prime:Express;Health Club Network:Standard |
When I open order item with following isrc code '<ISRCCode>'
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Record Company | Artist   | ISRC Code  | Release Date | Format         | Label    | Title    |
| automated test info    | OMACCOAR1      | OMACCOC1 | <ISRCCode> | 12/14/2022   | HD 1080i 25fps | OMACCOP1 | OMACCOT1 |
And 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard            | Express   |
| Health Club Network | PTV Prime |

Examples:
| UserEmail  | GlobalRole   | ISRCCode    |
| OMACCOU1_1 | agency.admin | OMACCOCN1_1 |
| OMACCOU1_2 | agency.user  | OMACCOCN1_2 |

Scenario: Check adding new order item in case to use Copy current button (guest.user with required permissions) for music
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OMACCOA1 | DefaultA4User |
And created 'OMACCOR1_3' role with 'tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write' permissions in 'global' group for advertiser 'OMACCOA1'
And created users with following fields:
| Email      | Role       | AgencyUnique |
| OMACCOU1_3 | OMACCOR1_3 | OMACCOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMACCOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMACCOAR1  | OMACCOBR1 | OMACCOSB1 | OMACCOP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMACCOA1'
And logged in with details of 'OMACCOU1_3'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code   | Release Date | Format         | Title    | Destination                                    |
| automated test info    | OMACCOAR1      | OMACCOBR1 | OMACCOSB1 | OMACCOP1 | OMACCOC1 | OMACCOCN1_3 | 12/14/2022   | HD 1080i 25fps | OMACCOT1 | PTV Prime:Express;Health Club Network:Standard |
When I open order item with following isrc code 'OMACCOCN1_3'
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Record Company | Artist   | ISRC Code   | Release Date | Format         | Label    | Title    |
| automated test info    | OMACCOAR1      | OMACCOC1 | OMACCOCN1_3 | 12/14/2022   | HD 1080i 25fps | OMACCOP1 | OMACCOT1 |
And 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard            | Express   |
| Health Club Network | PTV Prime |

Scenario: Check adding new order item in case to use Create New button for music
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OMACCOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OMACCOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMACCOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMACCOAR1  | OMACCOBR2 | OMACCOSB2 | OMACCOP2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMACCOA1'
And logged in with details of '<UserEmail>'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code  | Release Date | Format         | Title    | Destination                                    |
| automated test info    | OMACCOAR1      | OMACCOBR2 | OMACCOSB2 | OMACCOP2 | OMACCOC2 | <ISRCCode> | 12/14/2022   | HD 1080i 25fps | OMACCOT2 | PTV Prime:Express;Health Club Network:Standard |
When I open order item with following isrc code '<ISRCCode>'
And 'create new' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Record Company | Artist | ISRC Code | Release Date | Format | Label | Title |
|                        |                |        |           |              |        |       |       |
And 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard            | Express   |
| Health Club Network | PTV Prime |

Examples:
| UserEmail  | GlobalRole   | ISRCCode    |
| OMACCOU1_1 | agency.admin | OMACCOCN2_1 |
| OMACCOU1_2 | agency.user  | OMACCOCN2_2 |

Scenario: Check adding new order item in case to use Create New button (guest.user with required permissions)  for music
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OMACCOA1 | DefaultA4User |
And created 'OMACCOR1_3' role with 'tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write' permissions in 'global' group for advertiser 'OMACCOA1'
And created users with following fields:
| Email      | Role       | AgencyUnique |
| OMACCOU1_3 | OMACCOR1_3 | OMACCOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMACCOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMACCOAR1  | OMACCOBR2 | OMACCOSB2 | OMACCOP2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMACCOA1'
And logged in with details of 'OMACCOU1_3'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code   | Release Date | Format         | Title    | Destination                                    |
| automated test info    | OMACCOAR1      | OMACCOBR2 | OMACCOSB2 | OMACCOP2 | OMACCOC2 | OMACCOCN2_3 | 12/14/2022   | HD 1080i 25fps | OMACCOT2 | PTV Prime:Express;Health Club Network:Standard |
When I open order item with following isrc code 'OMACCOCN2_3'
And 'create new' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Record Company | Artist | ISRC Code | Release Date | Format | Label | Title |
|                        |                |        |           |              |        |       |       |
And 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard            | Express   |
| Health Club Network | PTV Prime |

Scenario: Check that QC & Ingest Only is copied in case to Copy current for music
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OMACCOA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OMACCOU1_1 | agency.admin | OMACCOA1     |
And logged in with details of 'OMACCOU1_1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMACCOCN6 |
When I open order item with following isrc code 'OMACCOCN6'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see 'inactive' QC & Ingest Only button on order item page
And should see 'inactive' Select Broadcast Destinations section on order item page

Scenario: Check that value of market related fields are copied in case to use Copy current button for music
!--ORD-958
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OMACCOA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OMACCOU1_1 | agency.admin | OMACCOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMACCOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMACCOAR1  | OMACCOBR7 | OMACCOSB7 | OMACCOP7 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMACCOA1'
And logged in with details of 'OMACCOU1_1'
And I am on View Draft Orders tab of 'music' order on ordering page
When I create 'music' order on View Draft Orders tab on ordering page
And select following market 'Spain' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Label    | Artist   | ISRC Code | Release Date | Format         | Title    |
| automated test info    | OMACCOAR1  | OMACCOBR7 | OMACCOSB7 | OMACCOP7 | OMACCOC7 | OMACCOCN7 | 12/14/2022   | HD 1080i 25fps | OMACCOT7 |
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Record Company | Artist   | ISRC Code | Release Date | Format         | Label    | Title    |
| automated test info    | OMACCOAR1      | OMACCOC7 | OMACCOCN7 | 12/14/2022   | HD 1080i 25fps | OMACCOP7 | OMACCOT7 |

Scenario: Check that data of order item retrieved from project is copied and file isn’t copied for music
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OMACCOA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OMACCOU1_1 | agency.admin | OMACCOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMACCOA1':
| Advertiser | Brand     | Sub Brand | Product   |
| OMACCOAR1  | OMACCOBR8 | OMACCOSB8 | OMACCOPR8 |
And logged in with details of 'OMACCOU1_1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMACCOCN8 |
And created 'OMACCOP8' project
And created '/OMACCOF8' folder for project 'OMACCOP8'
And uploaded into project 'OMACCOP8' following files:
| FileName             | Path      |
| /files/Fish1-Ad.mov  | /OMACCOF8 |
And waited while transcoding is finished in folder '/OMACCOF8' on project 'OMACCOP8' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OMACCOF8' project 'OMACCOP8'
When I 'save' file info by next information:
| FieldName    | FieldValue   |
| Title        | OMACCOT8.mov |
| Advertiser   | OMACCOAR1    |
| Brand        | OMACCOBR8    |
| Sub Brand    | OMACCOSB8    |
| Screen       | Music Promo  |
| Product      | OMACCOPR8    |
| Clock number | FileMACCOCN8 |
And open order item with following isrc code 'OMACCOCN8'
And add to order for order item at Add media to your order form following files 'OMACCOT8.mov' from folder '/OMACCOF8' of project 'OMACCOP8'
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Title        | ISRC Code    | Counter | Cover Title |
| OMACCOT8.mov | FileMACCOCN8 | 2 of 2  |             |
And should see following data for order item on Add information form:
| Advertiser | ISRC Code    | Product   | Title        |
| OMACCOAR1  | FileMACCOCN8 | OMACCOPR8 | OMACCOT8.mov |