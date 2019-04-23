Feature:    New Library  Localisation functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check Localisation feature in Traffic

Lifecycle:
Before:
Given I created the agency 'A_TNL_S01_1' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |  Access                |  Language      |
| U_TNL_S01_1 | agency.admin | A_TNL_S01_1   |  streamlined_library   |  de            |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_TNL_S01_1':
| Advertiser | Brand     | Sub Brand | Product   |
| ATNLAR1    | ATNLBR1   | ATNLSB1   | ATNLPR1   |
And logged in with details of 'U_TNL_S01_1'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
And waited while transcoding is finished in collection 'Everything'NEWLIB

Scenario: Check for Translations in multi Edit Asset
Meta: @gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/test.mp3            |
When I go to  Library page for collection 'Everything'NEWLIB
And select all assets for collection 'Everything' on the library pageNEWLIB
And go to edit Asset Metadata page on 'Everything' collection
Then I should see below fields in Multi Edit Asset Metadata page:
|Metadata                     |  Product Information       | Save and Close           | Cancel    |  Edit One By One         | Items Collected     |    Edit Details             |
|Metadaten                    | Projektinformationen       |Speichern und schließen   | abbrechen | NACHEINANDER BEARBEITEN  | 2 Dateien ausgewählt| Informationen bearbeiten    |


Scenario: Check for Translations in Edit Asset Info page
Meta: @gdam
@library
When I go to  Library page for collection 'Everything'NEWLIB
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then 'should' see following 'asset information' fields on opened asset info pageNEWLIB:
|FieldName     | FieldValue      |
|Business Unit | A_TNL_S01_1     |
|Dateigröße    | 383 KiB         |
|Format        | Cinepack        |
|Abtastrate    |22.3 KHz         |
|Bildseitenverhältnis |4:3     |
|Frame         | 10.000 fps    |
|Codec         | QuickTime     |
|Kanäle        | 1 channel     |
|Bitrate       | 176.4 Kbps    |
|Breite        | 134           |
|Dateiformat   | MOV           |
|Höhe          | 100           |
|Dateiname     | Fish1-Ad.mov  |
|Medientyp     | video         |

Scenario: Check for Translations in New Library Share Popup
Meta: @gdam
@library
When select asset 'Fish1-Ad.mov' in the 'Everything'  library pageNEWLIB
Then should see below fields in share popup window:
|SHARE                        |  SECURE SHARE              | PUBLIC LINK              | PUBLIC LINK ACCESS                |  Sharing options                          | Download Options  | Add Message  | Download Proxy | Download Original  |  Share never expires  |
|TEILEN                       | GETEILT MIT (0) PERSONEN   |ÖFFENTLICHER LINK         | ZUGRIFF AUF ÖFFENTLICHEN LINK (0) |  Datei mit registrierten Benutzern teilen | Download-Optionen |Nachricht hinzufügen |Darf Proxy (Low-Res) herunterladen | Darf Originaldatei (Hi-Res) herunterladen | Zugriff läuft nie ab |


Scenario: Check for Translations in the Attachments tab
Meta: @gdam
@library
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ATNLAR1    | ATNLBR1   | ATNLSB1   | ATNLPR1   | ATNLTC1  | ATNLCN1      | 20       | 08/14/2022     | HD 1080i 25fps | ATNLTT1 | Already Supplied   | BSkyB Green Button:Standard |
And uploaded to 'tv' order item with clock number 'ATNLCN1' following documents:
| Document          |
| /files/file_2.txt |
And completed order contains item with clock number 'ATNLCN1' with following fields:
| Job Number | PO Number |
| ATNLJN1    | ATNLPN1   |
And go to qc asset 'ATNLTT1' info page in Library for collection 'My Assets' on attachment assets pageNEWLIB
Then I should see below fields in Attachment Tab:
| Asset Attachment Label     |    Upload Attachment    |
| 1 Begleitdokumente         |  BEGLEITDOKUMENT HOCHLADEN  |


Scenario: Check for Translations in the Filter page
Meta: @gdam
@bug
@library
!--UIR-860
When I go to  Library page for collection 'Everything'NEWLIB
And I click on filter link for collection 'Everything'
Then I should see Media Types in the filter page:
|Media Type  |
|Video       |
|Audio       |
|Dokument    |
|Print       |
|Bild        |
|Sonstige    |
|Digital     |
And I should see below fields in New Library:
| Market                   | Advertiser       | Originator      | Campaign         |
| Land                     | Werbekunde       |  Urspung        |  KAMPAGNE        |
When I click Collection Tab on library page
Then I should see below fields in Collection tree:
| My Collection            |    My Assets        |
| Meine Collections        |    Meine Dateien    |


Scenario: Check for Translations in Library page
Meta: @gdam
@library
When I go to  Library page for collection 'Everything'NEWLIB
Then I should see below fields in New Library:
|Library Asset Tab           |  Last Uploaded         | Select All on page       | Unselect All                 | Show on page                    | Upload Button   |
|DATEIEN IN DER LIBRARY       | Zuletzt hochgeladen   |Alle auswählen            |  Auswahl aufheben            |  Dateien pro Seite              | HOCHLADEN     |
When select asset 'Fish1-Ad.mov' in the 'Everything'  library pageNEWLIB
Then I should see below fields in New Library:
| New Collection           |    DownLoad Button  |
| Neue Collection          |    Herunterladen    |
And I 'should' see popup menu options in 'Everything' page:
|Menu      |
|BEARBEITEN |
|TEILEN     |
|KOPIEREN ZU|
|LÖSCHEN    |
|MEDIENTYP ÄNDERN     |
When I close the popup menu on 'Everything' page
And I click on list view Icon on 'Everything' page
Then I 'should' see the list columns in 'Everything' page:
|Title      |
|Thumbnail  |
|Titel      |
|Dateityp   |
|Urspung    |
|Status     |

Scenario: Check for Translations in Chnage Media form
Meta: @gdam
@library
When I go to  Library page for collection 'Everything'NEWLIB
And select asset 'Fish1-Ad.mov' in the 'Everything'  library pageNEWLIB
And click change Media on 'Everything' library page
Then I should see fields in Change Media Form:
| Media type    |   Save      | Change Media Title           | Are you sure you want to change media type for selected files ?                         |  Cancel      |
|   Medientyp   |speichern    | Medientyp für 1 Datei ändern | Sind Sie sicher, dass Sie den Medientyp für die ausgewählten Dateien ändern möchten?    | abbrechen    |



