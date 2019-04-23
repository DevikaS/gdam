!--ORD-3057
!--ORD-3150
Feature: Connect to Pub ID system for France
Narrative:
In order to:
As a AgencyAdmin
I want to check connect to Pub ID system for France

!--Critical obug found --- Rerun entire story and deobug only after - https://jira.adstream.com/browse/NGN-16931 is fixed


Scenario: LogIn to ARPP system
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And logged in with details of 'CPISFU1'
And create 'tv' order with market 'France' and items with following fields:
| Clock Number |
| CPISFCN1     |
When I open order item with following clock number 'CPISFCN1'
And fill following fields for ARPP login popup of Add information form on order item page:
| Login         | Password      |
| miktestwsuser | niw8935682uat |
And push Login on ARPP login popup of Add information form
Then I should see following ARPP hint message 'You are now logged into' on Add information form of order item page

Scenario: Validation while logging to ARPP system
!--ORD-3321
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And logged in with details of 'CPISFU1'
And create 'tv' order with market 'France' and items with following fields:
| Clock Number |
| CPISFCN2     |
When I open order item with following clock number 'CPISFCN2'
And fill following fields for ARPP login popup of Add information form on order item page:
| Login         |
| miktestwsuser |
And click Login button on ARPP login popup of Add information form
Then I 'should not' see validation error for following fields 'Password' on ARPP login popup of Add information form

Scenario: check that data is populated from ARPP
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And logged in with details of 'CPISFU1'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Clock Number |
| CPISFCN3     |
When I open order item with following clock number 'CPISFCN3'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Type De Mentions   | Mentions                                                                        |
| Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé |
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Clock Number                 | Title                      | Duration | First Air Date | Format      | Subtitles Required | Type De Mentions   | Mentions                                                                        | ARPP Version Number | ARPP Submission Results |
| Public Comment         | TEST CLIENT | FR_TSTM_MIKT_PRDA_0009_020_F | Titre d'un produit de test | 20       | 10/29/2010     | SD PAL 16x9 | None               | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | 0009                | NOT_ENTERED             |

Scenario: check populated from ARPP data on Add Information form after saving order as draft
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 |
And logged in with details of 'CPISFU1'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Clock Number |
| CPISFCN4     |
When I open order item with following clock number 'CPISFCN4'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Campaign | Subtitles Required | Type De Mentions   | Mentions                                                                        | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| CPISFC4  | Already Supplied   | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | CPISFSN4               | CPISFCC4                      | CPISFSD4                |
And save as draft order
And open order item with following clock number 'FR_TSTM_MIKT_PRDA_0009_020_F'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Brand | Sub Brand | Product | Campaign | Clock Number                 | Title                      | Duration | First Air Date | Format      | Subtitles Required | Type De Mentions   | Mentions                                                                        | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
| Public Comment         | TEST CLIENT |       |           |         | CPISFC4  | FR_TSTM_MIKT_PRDA_0009_020_F | Titre d'un produit de test | 20       | 10/29/2010     | SD PAL 16x9 | Already Supplied   | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | 0009                | CPISFSN4               | NOT_ENTERED             | CPISFCC4                      | CPISFSD4                |

Scenario: check working Clear action for populated from ARPP data
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA5 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU5 | agency.admin | CPISFA5      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA5':
| Advertiser | Brand    | Sub Brand | Product  |
| CPISFAR5   | CPISFBR5 | CPISFSB5  | CPISFPR5 |
And logged in with details of 'CPISFU5'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Title   | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           |
| automated test info    | CPISFAR5   | CPISFBR5 | CPISFSB5  | CPISFPR5 | CPISFC5  | CPISFCN5     | CPISFT5 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas |
When I open order item with following clock number 'CPISFCN5'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| CPISFSN5               | CPISFCC5                      | CPISFSD5                |
And save as draft order
And open order item with following clock number 'FR_TSTM_MIKT_PRDA_0009_020_F'
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Title | Duration | First Air Date | Format | Subtitles Required | Type De Mentions | Mentions | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
|                        |            |       |           |         |          |              |       |          |                |        | None               |                  |          |                     |                        |                         |                               |                         |

Scenario: check data after changing market with populated from ARPP data
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 |
And logged in with details of 'CPISFU1'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Title   | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           |
| automated test info    | CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 | CPISFC6  | CPISFCN6     | CPISFT6 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas |
When I open order item with following clock number 'CPISFCN6'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| CPISFSN6               | CPISFCC6                      | CPISFSD6                |
And select following market 'United Kingdom' on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Brand    | Sub Brand | Product  | Campaign | Clock Number                 | Title                      | Duration | First Air Date | Format      | Subtitles Required |
| Public Comment         | TEST CLIENT | CPISFBR4 | CPISFSB4  | CPISFPR4 |          | FR_TSTM_MIKT_PRDA_0009_020_F | Titre d'un produit de test | 20       | 10/29/2010     | SD PAL 16x9 | Already Supplied   |
And 'should not' see following fields 'Type De Mentions,Mentions,ARPP Version Number,ARPP Submission Number,ARPP Submission Results,ARPP Submission Comments Code,ARPP Submission Details' for order item on Add information form

Scenario: check confirm order with populated from ARPP data
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 |
And logged in with details of 'CPISFU1'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Clock Number | Title   | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           | Destination      |
| automated test info    | CPISFCN7     | CPISFT7 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas | Canal J:Standard |
When I open order item with following clock number 'CPISFCN7'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Advertiser | Brand    | Sub Brand | Product  | Campaign | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 | CPISFC7  | CPISFSN7               | CPISFCC7                      | CPISFSD7                |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| CPISFJN7   | CPISFPN7  |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item title 'Titre d'un produit de test' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Sub Brand | Product  | Market | PO Number | Job #    | NoClocks | Status        |
| Digit  | CurrentTime | CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 | France | CPISFPN7  | CPISFJN7 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains item title 'Titre d'un produit de test' and items with following fields:
| Clock Number                 | Advertiser  | Product  | Title                      | First Air Date | Format      | Duration | Status        |
| FR_TSTM_MIKT_PRDA_0009_020_F | CPISFAR4    | CPISFPR4 | Titre d'un produit de test | 10/29/2010     | SD PAL 16x9 | 20       | 0/1 Delivered |

Scenario: check data after retrieving from Library QC asset for France market
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 |
And logged in with details of 'CPISFU1'
And logged into ARPP system by default user
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 | CPISFC8  | CPISFCN8_1   | 20       | 10/14/2022     | HD 1080i 25fps | CPISFT8 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'France' and items with following fields:
| Clock Number |
| CPISFCN8_2   |
And complete order contains item with clock number 'CPISFCN8_1' with following fields:
| Job Number | PO Number |
| CPISFJN8   | CPISFPN8  |
And add to 'tv' order item with clock number 'CPISFCN8_2' following qc asset 'CPISFT8' of collection 'My Assets'
When I open order item with clock number 'CPISFCN8_1' for order with market 'France'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Title   | Duration | First Air Date | Format      | Subtitles Required | Type De Mentions | Mentions | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
|                        | CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 | CPISFC8  | CPISFCN8_1   | CPISFT8 | 20       | 10/14/2022     | SD PAL 16x9 | Already Supplied   |                  |          |                     |                        |                         |                               |                         |
And should see 'disabled' following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Campaign,Title,Duration,Format' for order item on Add information form
And should see 'enabled' following fields 'Additional Information,First Air Date' for order item on Add information form

Scenario: check working Copy current after populated data from ARPP
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 |
And logged in with details of 'CPISFU1'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Title   | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           |
| automated test info    | CPISFAR4   | CPISFBR4 | CPISFSB4  | CPISFPR4 | CPISFC9  | CPISFCN9     | CPISFT9 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas |
When I open order item with following clock number 'CPISFCN9'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Type De Mentions   | Mentions                                                                        | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | CPISFSN9               | CPISFCC9                      | CPISFSD9                |
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Brand    | Sub Brand | Product  | Campaign | Clock Number                 | Title                      | Duration | First Air Date | Format      | Subtitles Required | Type De Mentions   | Mentions                                                                        | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
| Public Comment         | TEST CLIENT | CPISFBR4 | CPISFSB4  | CPISFPR4 |          | FR_TSTM_MIKT_PRDA_0009_020_F | Titre d'un produit de test | 20       | 10/29/2010     | SD PAL 16x9 | Already Supplied   | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | 0009                | CPISFSN9               | NOT_ENTERED             | CPISFCC9                      | CPISFSD9                |

Scenario: check working Copy To All after populated data from ARPP
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name     | A4User        |
| CPISFA10 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| CPISFU10 | agency.admin | CPISFA10     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA10':
| Advertiser | Brand     | Sub Brand | Product   |
| CPISFAR10  | CPISFBR10 | CPISFSB10 | CPISFPR10 |
And logged in with details of 'CPISFU10'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Clock Number | Title    | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           |
| automated test info    | CPISFCN10_1  | CPISFT10 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas |
|                        | CPISFCN10_2  |          |          |                |                |                    |                    |                                                                    |
When I open order item with following clock number 'CPISFCN10_1'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Advertiser | Brand     | Sub Brand | Product   | Campaign | Type De Mentions   | Mentions                                                                        | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| CPISFAR10  | CPISFBR10 | CPISFSB10 | CPISFPR10 | CPISFC10 | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | CPISFSN10              | CPISFCC10                     | CPISFSD10               |
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with following clock number 'FR_TSTM_MIKT_PRDA_0009_020_F' on cover flow
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number                 | Title                      | Duration | First Air Date | Format      | Subtitles Required | Type De Mentions   | Mentions                                                                        | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
| Public Comment         | CPISFAR10  | CPISFBR10 | CPISFSB10 | CPISFPR10 | CPISFC10 | FR_TSTM_MIKT_PRDA_0009_020_F | Titre d'un produit de test | 20       | 10/29/2010     | SD PAL 16x9 | Already Supplied   | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | 0009                | CPISFSN10              | NOT_ENTERED             | CPISFCC10                     | CPISFSD10               |

Scenario: check data after transfering order for France market
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name       | A4User        |
| CPISFA11_1 | DefaultA4User |
| CPISFA11_2 | DefaultA4User |
And added agency 'CPISFA11_2' as a partner to agency 'CPISFA11_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| CPISFU11_1 | agency.admin | CPISFA11_1   |
| CPISFU11_2 | agency.admin | CPISFA11_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA11_1':
| Advertiser | Brand     | Sub Brand | Product   |
| CPISFAR11  | CPISFBR11 | CPISFSB11 | CPISFPR11 |
And logged in with details of 'CPISFU11_1'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           |
| automated test info    | CPISFAR11  | CPISFBR11 | CPISFSB11 | CPISFPR11 | CPISFC11 | CPISFCN11    | CPISFT11 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas |
When I open order item with following clock number 'CPISFCN11'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Type De Mentions   | Mentions                                                                        | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | CPISFSN11              | CPISFCC11                     | CPISFSD11               |
And save as draft order
And transfer order contains item with clock number 'FR_TSTM_MIKT_PRDA_0009_020_F' to user 'CPISFU11_2' with following message 'autotest transfer message'
And login with details of 'CPISFU11_2'
And open order item with following clock number 'FR_TSTM_MIKT_PRDA_0009_020_F'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Brand     | Sub Brand | Product   | Campaign | Clock Number                 | Title                      | Duration | First Air Date | Format      | Subtitles Required | Type De Mentions   | Mentions                                                                        | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
| Public Comment         | TEST CLIENT | CPISFBR11 | CPISFSB11 | CPISFPR11 |          | FR_TSTM_MIKT_PRDA_0009_020_F | Titre d'un produit de test | 20       | 10/29/2010     | SD PAL 16x9 | Already Supplied   | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | 0009                | CPISFSN11              | NOT_ENTERED             | CPISFCC11                     | CPISFSD11               |

Scenario: check that there is no ARPP metadata fields for music order on Add Information form
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And logged in with details of 'CPISFU1'
And logged into ARPP system by default user
And create 'music' order with market 'France' and items with following fields:
| ISRC Code |
| CPISFCN12 |
When I open order item with following isrc code 'CPISFCN12'
Then I 'should not' see following fields 'Type De Mentions,Mentions,ARPP Version Number,ARPP Submission Number,ARPP Submission Results,ARPP Submission Comments Code,ARPP Submission Details' for order item on Add information form

Scenario: check working Auto code generating after populated data from ARPP
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name     | A4User        |
| CPISFA13 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| CPISFU13 | agency.admin | CPISFA13     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA13':
| Advertiser | Brand     | Sub Brand | Product   |
| ARCPISF13  | BRCPISF13 | SBCPISF13 | PRCPISF13 |
And update custom code 'Clock number' of schema 'video' agency 'CPISFA13' by following fields:
| Name      | Sequential Number | Free Text | Metadata Elements                        | Enabled |
| CPISFCC13 | 7                 | /;-;#     | Brand:2,Sub Brand:2,Product:3,Duration:2 | should  |
And logged in with details of 'CPISFU13'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Clock Number | Title      | Duration | Format         |
| automated test info    | CPISFCN13    | TCPISF13_1 | 20       | HD 1080i 25fps |
When I open order item with following clock number 'CPISFCN13'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Advertiser | Brand     | Sub Brand | Product   | Campaign |
| ARCPISF13  | BRCPISF13 | SBCPISF13 | PRCPISF13 | CPISFC13 |
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,7}/-#BRSBPRC20' for field 'Clock Number' on Add information form of order item page

Scenario: check validation while trying to proceed order with confirmed populated from ARPP clock number
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name     | A4User        |
| CPISFA14 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| CPISFU14 | agency.admin | CPISFA14     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA14':
| Advertiser | Brand     | Sub Brand | Product   |
| CPISFAR14  | CPISFBR14 | CPISFSB14 | CPISFPR14 |
And logged in with details of 'CPISFU14'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Clock Number | Title      | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           | Destination      |
| automated test info    | CPISFCN14_1  | CPISFT14_1 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas | Canal J:Standard |
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Clock Number | Title      | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           | Destination      |
| automated test info    | CPISFCN14_2  | CPISFT14_2 | 15       | 10/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas | Canal J:Standard |
When I open order item with following clock number 'CPISFCN14_1'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Advertiser | Brand     | Sub Brand | Product   | Campaign   | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| CPISFAR14  | CPISFBR14 | CPISFSB14 | CPISFPR14 | CPISFC14_1 | CPISFSN14_1            | CPISFCC14_1                   | CPISFSD14_1             |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| CPISFJN14  | CPISFPN14 |
And confirm order on Order Proceed page
And open order item with following clock number 'CPISFCN14_2'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Advertiser | Brand     | Sub Brand | Product   | Campaign   | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| CPISFAR14  | CPISFBR14 | CPISFSB14 | CPISFPR14 | CPISFC14_2 | CPISFSN14_2            | CPISFCC14_2                   | CPISFSD14_2             |
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page

Scenario: check working Copy To All after populated data from ARPP and create new order item
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name     | A4User        |
| CPISFA15 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| CPISFU15 | agency.admin | CPISFA15     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA15':
| Advertiser | Brand     | Sub Brand | Product   |
| CPISFAR15  | CPISFBR15 | CPISFSB15 | CPISFPR15 |
And logged in with details of 'CPISFU15'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Title      | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           |
| automated test info    | CPISFAR15  | CPISFBR15 | CPISFSB15 | CPISFPR15 | CPISFC15_1 | CPISFCN15_1  | CPISFT15_1 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas |
| automated test info    | CPISFAR15  | CPISFBR15 | CPISFSB15 | CPISFPR15 | CPISFC15_2 | CPISFCN15_2  | CPISFT15_2 | 15       | 10/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas |
When I open order item with following clock number 'CPISFCN15_2'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Type De Mentions   | Mentions                                                                        | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | CPISFSN15_2            | CPISFCC15_2                   | CPISFSD15_2             |
And 'create new' order item by Add Commercial button on order item page
And select order item with following clock number 'FR_TSTM_MIKT_PRDA_0009_020_F' on cover flow
And copy data from 'Add information' section of order item page to all other items
And select '3' order item with following clock number 'FR_TSTM_MIKT_PRDA_0009_020_F' on cover flow
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Brand     | Sub Brand | Product   | Campaign | Clock Number                 | Title                      | Duration | First Air Date | Format      | Subtitles Required | Type De Mentions   | Mentions                                                                        | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
| Public Comment         | TEST CLIENT | CPISFBR15 | CPISFSB15 | CPISFPR15 |          | FR_TSTM_MIKT_PRDA_0009_020_F | Titre d'un produit de test | 20       | 10/29/2010     | SD PAL 16x9 | Already Supplied   | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | 0009                | CPISFSN15_2            | NOT_ENTERED             | CPISFCC15_2                   | CPISFSD15_2             |

Scenario: check data populated from ARPP for first order item after Copy current
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name     | A4User        |
| CPISFA16 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| CPISFU16 | agency.admin | CPISFA16     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA16':
| Advertiser | Brand     | Sub Brand | Product   |
| CPISFAR16  | CPISFBR16 | CPISFSB16 | CPISFPR16 |
And logged in with details of 'CPISFU16'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           |
| automated test info    | CPISFAR16  | CPISFBR16 | CPISFSB16 | CPISFPR16 | CPISFC16 | CPISFCN16    | CPISFT16 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas |
When I open order item with following clock number 'CPISFCN16'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Type De Mentions   | Mentions                                                                        | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | CPISFSN16              | CPISFCC16                     | CPISFSD16               |
And 'copy current' order item by Add Commercial button on order item page
And select '1' order item with following clock number 'FR_TSTM_MIKT_PRDA_0009_020_F' on cover flow
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser  | Brand     | Sub Brand | Product   | Campaign | Clock Number                 | Title                      | Duration | First Air Date | Format      | Subtitles Required | Type De Mentions   | Mentions                                                                        | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
| Public Comment         | TEST CLIENT | CPISFBR16 | CPISFSB16 | CPISFPR16 |          | FR_TSTM_MIKT_PRDA_0009_020_F | Titre d'un produit de test | 20       | 10/29/2010     | SD PAL 16x9 | Already Supplied   | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | 0009                | CPISFSN16              | NOT_ENTERED             | CPISFCC16                     | CPISFSD16               |

Scenario: check data for assignee after transfering order for France market
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name       | A4User        |
| CPISFA17_1 | DefaultA4User |
| CPISFA17_2 | DefaultA4User |
And added agency 'CPISFA17_2' as a partner to agency 'CPISFA17_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| CPISFU17_1 | agency.admin | CPISFA17_1   |
| CPISFU17_2 | agency.admin | CPISFA17_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'CPISFA17_1':
| Advertiser | Brand     | Sub Brand | Product   |
| CPISFAR17  | CPISFBR17 | CPISFSB17 | CPISFPR17 |
And logged in with details of 'CPISFU17_1'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Subtitles Required | Type De Mentions   | Mentions                                                           |
| automated test info    | CPISFAR17  | CPISFBR17 | CPISFSB17 | CPISFPR17 | CPISFC17 | CPISFCN17    | CPISFT17 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   | Food / Alimentaire | Mention D : Pour votre santé, évitez de grignotter entre les repas |
When I open order item with following clock number 'CPISFCN17'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Type De Mentions   | Mentions                                                                        | ARPP Submission Number | ARPP Submission Comments Code | ARPP Submission Details |
| Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | CPISFSN17              | CPISFCC17                     | CPISFSD17               |
And save as draft order
And transfer order contains item with clock number 'FR_TSTM_MIKT_PRDA_0009_020_F' to user 'CPISFU17_2' with following message 'autotest transfer message'
And open order item with following clock number 'FR_TSTM_MIKT_PRDA_0009_020_F'
Then I should see following read-only 'common' data for order item on Add information form:
| Additional Information | Advertiser  | Brand     | Sub Brand | Product   | Campaign | Clock Number                 | Title                      | Duration | First Air Date | Format      | Subtitles Required | Type De Mentions   | Mentions                                                                        | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
| Public Comment         | TEST CLIENT | CPISFBR17 | CPISFSB17 | CPISFPR17 |          | FR_TSTM_MIKT_PRDA_0009_020_F | Titre d'un produit de test | 20       | 10/29/2010     | SD PAL 16x9 | Already Supplied   | Food / Alimentaire | Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé | 0009                | CPISFSN17              | NOT_ENTERED             | CPISFCC17                     | CPISFSD17               |

Scenario: check that clock number is not saved to list of Pub Ids
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And logged in with details of 'CPISFU1'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Clock Number |
| CPISFCN18_1  |
When I open order item with following clock number 'CPISFCN18_1'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0009_020_F |
And fill following fields for Add information form on order item page:
| Clock Number | Title    |
| CPISFCN18_2  | CPISFT18 |
And save as draft order
And open order item with following clock number 'CPISFCN18_2'
Then I 'should not' see available following pub ids 'CPISFCN18_2' in Pub Id field on Add Information form

Scenario: check adding Usage Right after populated data from ARPP
!--FAB-494
Meta: @ordering
      @obug
Given I created the following agency:
| Name    | A4User        |
| CPISFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| CPISFU1 | agency.admin | CPISFA1      |
And logged in with details of 'CPISFU1'
And logged into ARPP system by default user
And create 'tv' order with market 'France' and items with following fields:
| Clock Number |
| CPISFCN19    |
When I open order item with following clock number 'CPISFCN19'
And fill following fields for Add information form on order item page:
| Clock Number                 |
| FR_TSTM_MIKT_PRDA_0001_010_F |
And wait for '10' seconds
Then I should see following fields for usage right 'Music' on order item page:
| Artist | Track Title | Start Date | Expire Date |
| Test   | Test        |            |             |