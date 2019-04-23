Feature:          Mandatory Metadata for Different Markets
Narrative:
In order to
As a
I want to         Check Mandatory Metadata fields for Different Markets


Scenario:  Check unmatched assets metadata is editable in media checker
Meta:@mediamanager
!--QA-1127
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
When I click element 'MediaManager' on page 'Projects'
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/ger_hd_pass.mov|
And fill meta data in media manager file info page:
| Market       | advertiser     | product  | agency        | clockNumber    | Duration                      |
| Germany      | EMAQCAdver1    | EMAQCP1  | DefaultAgency | EMAQCCN1       | 0 hours,0 minutes,1 second    |
And search the media file by 'EMAQCCN1'
And wait until QC process spinner disappers in 'Uploads' page
And go to Media Checker page
And search the media file by 'clock no.' with 'EMAQCCN1' in Media Checker page
And open on tile with clock number 'EMAQCCN1' in Media Checker page
And click edit button in media checker info page
And update meta data in media checker file edit page:
| advertiser  | product     | agency     |title   |clockNumber| TC in      |TC out      |
| EMAQCA2     | EMAQCP2     | EMAQCA2    |EMAQCT2 |EMAQCCN2   | 00:00:00:10|00:00:00:24 |
Then should see below 'MasterInfo' details in media checker page:
| FieldName      | Value       |
| Market	     | Germany     |
| Agency	     | EMAQCA2     |
| Clock Number   | EMAQCCN2    |
| Advertiser	 | EMAQCA2     |
| Product	     | EMAQCP2     |
| Title	         | EMAQCT2     |
| Duration	     | 00:00:01:00 |
| TC Out	     | 00:00:00:24 |
| TC In	         | 00:00:00:10 |
| Uploader	     | AgencyAdmin |


Scenario:  Check matched assets metadata is editable in media checker
Meta:@mediamanager
     @mmbug
!--QA-1127
!--Bug raised - MM-717
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And created 'tv' streamline order with market 'Germany' and items with following fields :
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required  | DestinationID |Motivnummer| Supply Via | Assignee              | Already Supplied | Message        | Deadline Date |
| automated test info    | EMAQCA3    | EMAQCBR3 |EMAQCSB3   | EMAQCPR3| EMAQCC3  | EMAQCCN3     | 1        | 10/14/2022     | HD 1080i 25fps |EMAQCT3 | Already Supplied   | 6683          |124        | FTP        | autotest@adstream.com | should not       | automated test | 12/14/2022    |
When I click element 'MediaManager' on page 'Projects'
And upload media file in to media uploader via UI:
|MediaFilePath|
|/files/sd_pass.mov|
And fill meta data in media manager file info page:
|Market  |advertiser    |product    |title    |clockNumber |agency          | Duration                     |
|Germany |EMAQCA3       |EMAQCPR3   |EMAQCT3  |EMAQCCN3    |DefaultAgency   | 0 hours,0 minutes,1 second   |
And search the media file by 'EMAQCCN3'
And wait until QC process spinner disappers in 'Uploads' page
And submit files with clocknumber 'EMAQCCN3' in upload page
And go to Media Checker page
And search the media file by 'clock no.' with 'EMAQCCN3' in Media Checker page
When open on tile with clock number 'EMAQCCN3' in Media Checker page
And attach asset
And open on tile with clock number 'EMAQCCN3' in Media Checker page
And wait for '4' seconds
And click tab 'MezzInfo'
And click edit button in media checker Mezz info page
Then I 'should' see disabled metadata for the matched asset in Media Checker edit page
When I set at playhead for TC in and TC out
Then should see below 'MezzInfo' details in media checker page:
| FieldName      | Value         |
| Market	     | Germany       |
| Agency	     | DefaultAgency |
| Clock Number   | EMAQCCN3      |
| Advertiser	 | EMAQCA3       |
| Product	     | EMAQCPR3      |
| Title	         | EMAQCT3       |
| Duration	     | 00:00:01:00   |
| TC Out	     | 00:00:01:00   |
| TC In	         | 00:00:00:12   |
| Uploader	     | AgencyAdmin   |

Scenario: Check that A5 user can see the QC Fail with minor issues and submit
Meta:@mediamanager
!--QA-855
Given I am on babylon Login page
And I logged in as 'AgencyAdmin'
And clicked element 'MediaManager' on page 'Projects'
When upload media file in to media uploader via UI:
| MediaFilePath            |
| /files/GerMinorIssues.mov|
And fill meta data in media manager file info page:
| Market      | advertiser       | product       | agency     | Duration                  |
| Germany     | GerMinorAdver    | GerProductVal | GerAgency  | 0 hours,0 minutes,1 second|
And I search the media file by 'GerMinorAdver'
And wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
| QC Message                            |
| Minor QC Issues. Click "View details" |
When I click view details
Then I 'should' see the below media file details on QC Report in UI:
| Errors                                                                                         |
| Audio loud zone found using EBU Integrated Relative method with max loudness value -19.90 LUFS.|
And I 'should'  see the below media file details on QC Report download via API:
| Status  |
| failed  |
And wait for '2' seconds
When I click 'Fix and submit' in file report page
And go to Media Manager Uploads page
And search the media file by 'GerMinorAdver'
Then I should see the following data for media file in upload page:
| QC Message          |
| File awaiting match |


Scenario: Check that A5 user can see QC Pass download report data via api and UI
Meta:@mediamanager
!--QA-853
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name       | A4User        | Country     | Application Access    |
| MMEMQC_BU1 | DefaultA4User | <MarketVal> | adkits,folders,media_manager,media_checker|
And I created users with following fields:
| Email     | Role        |AgencyUnique| Access       |
| MMEMQC_U1 | agency.user |MMEMQC_BU1  |adkits,folders,media_manager,media_checker |
When I login with details of 'MMEMQC_U1'
And click element 'MediaManager' on page 'Projects'
And upload media file in to media uploader via UI:
|MediaFilePath|
|<MediaFilePath>|
And fill meta data in media manager file info page:
|Market      |advertiser         |product      |agency     | Duration|clockNumber|
|<MarketVal> |<AdvertiserVal>    |<ProductVal> |<Agencyval>|<TimeDuration>|<ClockNumber>|
And search the media file by '<AdvertiserVal>'
And wait until QC process spinner disappers in 'Uploads' page
And click view details
Then I 'should' see the QC status message 'QC Passed'
And I 'should' see the below media file details on QC Report in UI:
|audioCodec     |fileType        |fileSize   |videoCodec |firstFrameTimeCode|length      |
|<audioCodec>   |QuickTime Stream|7.45 MB   |ProRes     |00:00:00:00       |00:00:01:000|
And I 'should'  see the below media file details on QC Report download via API:
|audioCodec      |fileType          |fileSize |videoCodec|firstFrameTimeCode  |length       |Status    |Errors |
|<audioCodec>    |QuickTime Stream  |7.45 MB  |ProRes    |00:00:00:00         |00:00:01:000 | passed   |0      |


Examples:
|MarketVal      |MediaFilePath         |FileName           |AdvertiserVal|ProductVal         |Agencyval     |TimeDuration                |audioCodec  |ClockNumber|
|Germany        |/files/DeuSd_PASS.mov |DeuSd_PASS.mov     |GermanyAdver |GermanyProductVal  |GermanyAgency | 0 hours,0 minutes,1 second | SOWT PCM    |GerClock2|
|United Kingdom |/files/GbrSd_PASS.mov |GbrSd_PASS.mov     |UKAdver      |UKProductVal       |UKAgency      | 0 hours,0 minutes,1 second | SOWT PCM    |UKclock2|


Scenario: Check that A5 user can see the QC Fail download report data via UI and API for UK
Meta:@mediamanager
!--QA-855
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name       | A4User        | Country     | Application Access    |
| MMEMQC_BU2 | DefaultA4User | <MarketVal> | adkits,folders,media_manager,media_checker|
And I created users with following fields:
| Email  | Role         |AgencyUnique| Access       |
| MMEMQC_U2 | agency.admin |MMEMQC_BU2        |adkits,folders,media_manager,media_checker |
And refreshed the page
When I login with details of 'MMEMQC_U2'
And click element 'MediaManager' on page 'Projects'
And upload media file in to media uploader via UI:
|MediaFilePath|
|<MediaFilePath>|
And fill meta data in media manager file info page:
|Market      |advertiser         |product      |agency     | Duration|     clockNumber|
|<MarketVal> |<AdvertiserVal>    |<ProductVal> |<Agencyval>|<TimeDuration>|<ClockNumber>|
And search the media file by '<AdvertiserVal>'
And wait until QC process spinner disappers in 'Uploads' page
And click view details
And refresh the page
Then I 'should' see the QC status message 'This file has critical errors and cannot be repaired with Autofix or AdPro.A new file will need to be uploaded before the request can be sent to broadcast.'
And I 'should' see the below media file details on QC Report in UI:
|Errors |
|Video scan mode found Progressive does not match with the user-defined value of Interlaced.|
|Audio codec does not match. User-defined value(s) Generic Ver 1 AES3 8 CHANNEL, AES3-S302M, AES3 PCM, IN24 PCM, LPCM, SOWT PCM, TWOS PCM, MPEG-1(Layer 2) but found to be IN32 PCM.|
|Bitrate does not match. User-defined min value is 384000.00 and max value is 2304000.00 but found to be 3072000.00.|
|Bit per sample does not match. User-defined value(s) 16, 24 but found to be 32.|
And I 'should'  see the below media file details on QC Report download via API:
|Audio codec does not match. User-defined value(s) IN24 PCM, LPCM, SOWT PCM, TWOS PCM, MPEG-1(Layer 2) but found to be IN32 PCM.|
|Bitrate does not match. User-defined min value is 384000.00 and max value is 2304000.00 but found to be 3072000.00.|
|Bit per sample does not match. User-defined value(s) 16, 24 but found to be 32.|
And I 'should'  see the below media file details on QC Report download via API:
|Status  |
|failed  |

Examples:
|MarketVal      |MediaFilePath         |FileName      |AdvertiserVal  |ProductVal         |Agencyval       |TimeDuration                |ClockNumber |
|United Kingdom |/files/GbrSd_FAIL.mov |GbrSd_FAIL.mov|UKAdver        |UKProduct          |UKAgency1       | 0 hours,0 minutes,1 second |UKclock1    |

Scenario: Check that A5 user can see the QC Fail download report data via UI and API for Germany
Meta:@mediamanager
!--QA-855
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name       | A4User        | Country     | Application Access    |
| MMEMQC_BU2 | DefaultA4User | <MarketVal> | adkits,folders,media_manager,media_checker|
And I created users with following fields:
| Email  | Role         |AgencyUnique| Access       |
| MMEMQC_U2 | agency.admin |MMEMQC_BU2        |adkits,folders,media_manager,media_checker |
And refreshed the page
When I login with details of 'MMEMQC_U2'
And click element 'MediaManager' on page 'Projects'
And upload media file in to media uploader via UI:
|MediaFilePath|
|<MediaFilePath>|
And fill meta data in media manager file info page:
|Market      |advertiser         |product      |agency     | Duration|     clockNumber|
|<MarketVal> |<AdvertiserVal>    |<ProductVal> |<Agencyval>|<TimeDuration>|<ClockNumber>
And search the media file by '<AdvertiserVal>'
And wait until QC process spinner disappers in 'Uploads' page
And click view details
And refresh the page
Then I 'should' see the QC status message 'This file has critical errors and cannot be repaired with Autofix or AdPro.A new file will need to be uploaded before the request can be sent to broadcast.'
And I 'should' see the below media file details on QC Report in UI:
|Errors |
|Audio codec does not match. User-defined value(s) Generic Ver 1 AES3 8 CHANNEL, IN24 PCM, LPCM, SOWT PCM, TWOS PCM, MPEG-1(Layer 2) but found to be IN32 PCM.|
|Bitrate does not match. User-defined min value is 384000.00 and max value is 2304000.00 but found to be 3072000.00.|
|Bit per sample does not match. User-defined value(s) 16, 24 but found to be 32.|
|Video scan mode found Progressive does not match with the user-defined value of Interlaced.|
And I 'should'  see the below media file details on QC Report download via API:
|Audio codec does not match. User-defined value(s) IN24 PCM, LPCM, SOWT PCM, TWOS PCM, MPEG-1(Layer 2) but found to be IN32 PCM.|
|Bitrate does not match. User-defined min value is 384000.00 and max value is 2304000.00 but found to be 3072000.00.|
|Bit per sample does not match. User-defined value(s) 16, 24 but found to be 32.|
And I 'should'  see the below media file details on QC Report download via API:
|Status  |
|failed  |

Examples:
|MarketVal      |MediaFilePath         |FileName      |AdvertiserVal  |ProductVal         |Agencyval       |TimeDuration                |ClockNumber |
|Germany        |/files/DeuSd_FAIL.mov |DeuSd_FAIL.mov|GermanyAdver   |GermanyProductVal  |GermanyAgency   | 0 hours,0 minutes,1 second |GerClock1   |


Scenario:  check QC Pass Re run when market changes
Meta:@mediamanager
!--QA-1083
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/GbrHd_PASS.mov|
And fill meta data in media manager file info page:
|Market              |advertiser |product      |agency         | Duration|clockNumber                       |
|United Kingdom      |UKAdver1   |UKProduct1    |UKAgency1     | 0 hours,0 minutes,1 second   |ukclock3     |
And I search the media file by 'UKAdver1'
And wait until QC process spinner disappers in 'Uploads' page
And click view details
Then I 'should' see the below media file details on QC Report in UI:
|Template                  |
|Gbr1080i25fpsActiveOnly   |
When I click file info button
And fill meta data in media manager file info page:
|Market   |
|Germany  |
And close the view details page
And I search the media file by 'UKAdver1'
Then I should see the following data for media file in upload page:
|Market   |
|Germany  |
When I wait until QC process spinner disappers in 'Uploads' page
And click view details
Then I 'should' see the below media file details on QC Report in UI:
|Template                  |
|Deu1080i25fpsActiveOnly   |


Scenario:  check QC Fail Re run when market changes
Meta:@mediamanager
!--QA-1083
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/GbrHd_FAIL.mov|
And fill meta data in media manager file info page:
|Market         |advertiser  |product    |agency     | Duration|clockNumber                       |
|United Kingdom |UKAdver2    |UKProduct2 |UKAgency2  | 0 hours,0 minutes,1 second   |ukclock4     |
And I search the media file by 'UKAdver2'
And wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
|QC Message|
|QC Failed. Click "View details"|
When click view details
And I click file info button
And fill meta data in media manager file info page:
|Market         |
|Germany |
And close the view details page
And I search the media file by 'UKAdver2'
And I wait until QC process spinner disappers in 'Uploads' page
Then I should see the following data for media file in upload page:
|Market        |
|Germany|
And I should see the following data for media file in upload page:
|QC Message|
|QC Failed. Click "View details"|


Scenario: Check warning messages for UK market for not filling mandatory fields
Meta:@mediamanager
!--QA-847
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/sd_pass.mov|
And fill meta data in media manager file info page:
|Market      |
|United Kingdom |
Then I 'should' see the warning messages 'Agency is a required property.,Duration is a required property.' for mandatory fields


Scenario: Check warning messages for German market for not filling mandatory fields
Meta:@mediamanager
!--QA-847
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/sd_pass.mov|
And fill meta data in media manager file info page:
|Market  |
|Germany |
Then I 'should' see the warning messages 'Advertiser is a required property.,Product is a required property.,Agency is a required property.,Duration is a required property.' for mandatory fields


Scenario: Check mandatory fields error messages for MENA market
Meta:@mediamanager
!--QA-1085
Given I login to media manager with username 'autotest@adstream.com' and password 'abcdefghA1'
When upload media file in to media uploader via UI:
|MediaFilePath|
|/files/MenHd_PASS.mov|
And fill meta data in media manager file info page:
|Market         |
|Algeria        |
Then I should see the error messages:
|Error messages|
|Advertiser is a required property.|
|Product is a required property.|
|Title is a required property.|
|Agency is a required property.|
|Duration is a required property.|



Scenario: Check that  Mezz Info and Mezz Report tab is disabled for new, completed and submitted asset
Meta:@mediamanager
!--QA-1307
Given I am on babylon Login page
And logged in with details of 'AgencyAdmin'
When I click element 'MediaManager' on page 'Projects'
And I upload media file in to media uploader via UI:
|MediaFilePath|
|/files/ger_hd_pass.mov|
And fill meta data in media manager file info page:
| Market       | advertiser | product  | agency | clockNumber    | Duration                      |
| Germany      | MMIRDAR    | MMIRDP   | MMIRDA | MMIRDCN        | 0 hours,0 minutes,1 second    |
And I go to Media Checker page
And search the media file by 'clock no.' with 'MMIRDCN' in Media Checker page
Then I should see following details for asset in media checker:
| Status   |
| Upload Completed|
When open on tile with clock number 'MMIRDCN' in Media Checker page
Then I 'should not' see 'MezzInfo' tab enabled
And I 'should not' see 'MezzReport' tab enabled
When go to Media Manager Uploads page
And search the media file by 'MMIRDCN'
And wait until QC process spinner disappers in 'Uploads' page
And submit unattached files in upload page
And I go to Media Checker page
And search the media file by 'clock no.' with 'MMIRDCN' in Media Checker page
Then I should see following details for asset in media checker:
| Status    |
| Submitted |
When open on tile with clock number 'MMIRDCN' in Media Checker page
Then I 'should not' see 'MezzInfo' tab enabled
And I 'should not' see 'MezzReport' tab enabled
