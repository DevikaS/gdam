Feature:    Traffic Localisation functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check Localisation feature in Traffic
!--NGN-17583


!--NIR-809
Scenario: TM can see data based upon localisation
Meta: @traffic
Given I created the following agency:
| Name       |    A4User      | AgencyType     | Application Access |Market    | DestinationID |    A4User        |
| TMCSDLA    | DefaultA4User  |  Advertiser    |      ordering      |          |               |   DefaultA4User  |
And created users with following fields:
| Email       |           Role            | AgencyUnique     |  Access  | Language  |
| TMCSDLU     |       agency.admin        |   TMCSDLA        | ordering | en-us     |
And created users with following fields:
| Email       |           Role            | Agency                             |  Access  | Language  | Password|
| TMCSDLIF    | broadcast.traffic.manager |   BroadCasterAgencyTwoStage        |  adpath  | fr        |abcdefghA1|
| TMCSDLID    | broadcast.traffic.manager |   BroadCasterAgencyTwoStage        |  adpath  | de        |abcdefghA1|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TMCSDLA':
| Advertiser     | Brand          | Sub Brand     | Product      |
| TMCSDLAR       | TMCSDLBR       | TMCSDLSB      | TMCSDLP      |
And logged in with details of 'TMCSDLU'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser     | Brand       | Sub Brand   | Product    | Campaign   | Clock Number    | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title      | Destination           |
| automated test info    | TMCSDLAR       | TMCSDLBR    | TMCSDLSB    | TMCSDLP    | TMCSDC     | TMCSDCN_1 | 20       | 1           | 12/14/2022     |   Already Supplied | HD 1080i 25fps | TLCMOTT2   | Motorvision TV:Express       |
And complete order contains item with clock number 'TMCSDCN_1' with following fields:
| Job Number   | PO Number  |
| TMCSDLSR14   | TMCSDLSR14 |
And wait for finish place order with following item clock number 'TMCSDCN_1' to A4
When login as 'TMCSDLIF' of Agency 'BroadCasterAgencyTwoStage'
And wait till order with clockNumber 'TMCSDCN_1' will be available in Traffic
And I amon order item details page of clockNumber 'TMCSDCN_1'
And I wait for '5' seconds
Then I should see order item with following headers:
|     Agency    |     Product    |     Advertiser    |   Media Agency     | Additional Details       |  Technical Specifications  | Supporting Documents  |
| Agence        | Produit        | Annonceur         | Agence Media       | Détails supplémentaires  |  Spécifications techniques | Documents joints      |
When open Traffic Order List page
And wait till order list will be loaded
Then I should see below fields changed:
|Add New Tab                  |  Configure Order Item              | Download CSV              | All Tab   |
|Ajouter un nouvel onglet     | Configurer la liste des commandes  |Télécharger le format CSV  | Tous      |
When login as 'TMCSDLID' of Agency 'BroadCasterAgencyTwoStage'
And I amon order item details page of clockNumber 'TMCSDCN_1'
And I wait for '5' seconds
Then I should see order item with following headers:
|     Agency    |     Product    |     Advertiser    |   Media Agency     | Additional Details       |  Technical Specifications  | Supporting Documents  |
| Agentur        | Produkt        | Werbekunde        | Mediaagentur      | Zusätzliche Informationen  |  Technische Spezifikationen | Begleitdokumente      |
When open Traffic Order List page
And wait till order list will be loaded
Then I should see below fields changed:
|Add New Tab                  |  Configure Order Item              | Download CSV              | All Tab   |
|Neuen Tab hinzufügen         | Auftragsübersicht anpassen         |CSV-Datei herunterladen    | Alle      |

Scenario: Check that for Traffic Manager Select Destination section title is translated to spanish on order item page for the users with selected Spanish Argentina language
Meta:@traffic
Given I created the following agency:
| Name         |    A4User     |    AgencyType  | Application Access         |
| TMCRTLA1_2   | DefaultA4User |   Advertiser   |      ordering,library      |
| TMCRTLA2_2   | DefaultA4User |   Ingest       |       adpath               |
And created users with following fields:
| Email        |          Role             | AgencyUnique      |  Access          |Language |
| TMCRTCU1_2   |       agency.admin        |   TMCRTLA1_2      | ordering,library |en-us    |
| TMCRTCU2_2   | traffic.traffic.manager   |   TMCRTLA2_2      |  adpath          |es-ar    |
| TMCRTCU3_2   |    agency.admin           |   TMCRTLA2_2      |  adpath          |en-us    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TMCRTLA1_2':
| Advertiser | Brand      | Sub Brand  | Product    |
| TMCRTLCAR3 | TMCRTLCBR3 | TMCRTLCSB3 | TMCRTLCSP3 |
And logged in with details of 'TMCRTCU1_2'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer  |
| automated test info    | TMCRTLCAR3 | TMCRTLCBR3 | TMCRTLCSB3 | TMCRTLCSP3 | TMCRTCC1  | TMCRTLCN10_2   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCRTCST1 | Facebook DE:Standard | 1  |
And completed order contains item with clock number 'TMCRTLCN10_2' with following fields:
| Job Number  | PO Number |
| TMCRTC11      | TMCRTC11  |
And waited for finish place order with following item clock number 'TMCRTLCN10_2' to A4
And I logout from account
And login with details of 'TMCRTCU2_2'
And select 'Todo' tab in Traffic UI
And refresh the page
And open edit page for order with Clock Number 'TMCRTLCN10_2' in Traffic
Then I 'should' see select destination translated as 'Seleccione Destinos' on order item page
When I login with details of 'TMCRTCU3_2'
And I go to User list page
And I go to user 'TMCRTCU2_2' details page
And I filled following fields on user 'TMCRTCU2_2' details page with specific Language:
| Language      |
| English       |
And I click save on users details page
And logout from account
When login with details of 'TMCRTCU2_2'
And select 'All' tab in Traffic UI
And refresh the page
And open edit page for order with Clock Number 'TMCRTLCN10_2' in Traffic
Then I 'should' see select destination translated as 'Select Destinations' on order item page