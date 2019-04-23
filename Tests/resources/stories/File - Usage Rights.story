!--NGN-2959 NGN-1402 NGN-8320
Feature:          File - Usage Rights
Narrative:
In order to
As a              AgencyAdmin
I want to         Check usage rights for files

Scenario: check creation of 'General' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S01' project
And created '/F_PFUR_S01' folder for project 'P_PFUR_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S01' folder for 'P_PFUR_S01' project
And waited while transcoding is finished in folder '/F_PFUR_S01' on project 'P_PFUR_S01' files page
When I add 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S01' and project 'P_PFUR_S01' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
Then I 'should' see 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S01' and project 'P_PFUR_S01' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |


Scenario: check updating of 'General' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S02' project
And created '/F_PFUR_S02' folder for project 'P_PFUR_S02'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S02' folder for 'P_PFUR_S02' project
And waited while transcoding is finished in folder '/F_PFUR_S02' on project 'P_PFUR_S02' files page
And added 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S02' and project 'P_PFUR_S02' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2002     |
When I edit entry of 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S02' and project 'P_PFUR_S02' Usage Rights page:
| EntryNumber | StartDate  | ExpirationDate |
| 1           | 02.02.2002 | 20.02.2020     |
Then I 'should' see 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S02' and project 'P_PFUR_S02' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |


Scenario: check removing of 'General' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S03' project
And created '/F_PFUR_S03' folder for project 'P_PFUR_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S03' folder for 'P_PFUR_S03' project
And waited while transcoding is finished in folder '/F_PFUR_S03' on project 'P_PFUR_S03' files page
And added 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S03' and project 'P_PFUR_S03' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And refreshed the page
When I remove '1' entry of 'General' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S03' and project 'P_PFUR_S03' Usage Rights page
And refresh the page
Then I 'should not' see 'General' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S03' and project 'P_PFUR_S03' Usage Rights page


Scenario: check creation of 'Countries' usage rigth for project file
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I created 'P_PFUR_S04' project
And created '/F_PFUR_S04' folder for project 'P_PFUR_S04'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S04' folder for 'P_PFUR_S04' project
And waited while transcoding is finished in folder '/F_PFUR_S04' on project 'P_PFUR_S04' files page
When I add 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S04' and project 'P_PFUR_S04' Usage Rights page:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And refresh the page
Then I 'should' see 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S04' and project 'P_PFUR_S04' Usage Rights page:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |


Scenario: check updating of 'Countries' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S05' project
And created '/F_PFUR_S05' folder for project 'P_PFUR_S05'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S05' folder for 'P_PFUR_S05' project
And waited while transcoding is finished in folder '/F_PFUR_S05' on project 'P_PFUR_S05' files page
And added 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S05' and project 'P_PFUR_S05' Usage Rights page:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2002     |
And refreshed the page
When I edit entry of 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S05' and project 'P_PFUR_S05' Usage Rights page:
| EntryNumber | Country | StartDate  | ExpirationDate |
| 1           | Nigeria | 02.02.2002 | 20.02.2020     |
And refresh the page
Then I 'should' see 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S05' and project 'P_PFUR_S05' Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Nigeria | 02.02.2002 | 20.02.2020     |


Scenario: check removing of 'Countries' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S06' project
And created '/F_PFUR_S06' folder for project 'P_PFUR_S06'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S06' folder for 'P_PFUR_S06' project
And waited while transcoding is finished in folder '/F_PFUR_S06' on project 'P_PFUR_S06' files page
And added 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S06' and project 'P_PFUR_S06' Usage Rights page:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And refreshed the page
When I remove '1' entry of 'Countries' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S06' and project 'P_PFUR_S06' Usage Rights page
And refresh the page
Then I 'should not' see 'Countries' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S06' and project 'P_PFUR_S06' Usage Rights page


Scenario: check creation of 'Media Types' usage rigth for project file
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I created 'P_PFUR_S07' project
And created '/F_PFUR_S07' folder for project 'P_PFUR_S07'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S07' folder for 'P_PFUR_S07' project
And waited while transcoding is finished in folder '/F_PFUR_S07' on project 'P_PFUR_S07' files page
When I add 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S07' and project 'P_PFUR_S07' Usage Rights page:
| Type           | Comment      |
| Generic Master | test comment |
And refresh the page
Then I 'should' see 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S07' and project 'P_PFUR_S07' Usage Rights page:
| Type           | Comment      |
| Generic Master | test comment |


Scenario: check updating of 'Media Types' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S08' project
And created '/F_PFUR_S08' folder for project 'P_PFUR_S08'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S08' folder for 'P_PFUR_S08' project
And waited while transcoding is finished in folder '/F_PFUR_S08' on project 'P_PFUR_S08' files page
And added 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S08' and project 'P_PFUR_S08' Usage Rights page:
| Type           | Comment                     |
| Generic Master | Generic Master test comment |
And refreshed the page
When I edit entry of 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S08' and project 'P_PFUR_S08' Usage Rights page:
| EntryNumber | Type           | Comment      |
| 1           | Generic Master | test comment |
And refresh the page
Then I 'should' see 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S08' and project 'P_PFUR_S08' Usage Rights page:
| Type           | Comment      |
| Generic Master | test comment |


Scenario: check removing of 'Media Types' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S09' project
And created '/F_PFUR_S09' folder for project 'P_PFUR_S09'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S09' folder for 'P_PFUR_S09' project
And waited while transcoding is finished in folder '/F_PFUR_S09' on project 'P_PFUR_S09' files page
And added 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S09' and project 'P_PFUR_S09' Usage Rights page:
| Type           | Comment      |
| Generic Master | test comment |
And refreshed the page
When I remove '1' entry of 'Media Types' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S09' and project 'P_PFUR_S09' Usage Rights page
And refresh the page
Then I 'should not' see 'Media Types' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S09' and project 'P_PFUR_S09' Usage Rights page


Scenario: check creation of 'Visual Talent' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S10' project
And created '/F_PFUR_S10' folder for project 'P_PFUR_S10'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S10' folder for 'P_PFUR_S10' project
And waited while transcoding is finished in folder '/F_PFUR_S10' on project 'P_PFUR_S10' files page
When I add 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S10' and project 'P_PFUR_S10' Usage Rights page:
| ArtistName | Role         | StartDate  | ExpirationDate |
| Stan Marsh | neutral role | 02.02.2002 | 20.02.2020     |
And refresh the page
Then I 'should' see 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S10' and project 'P_PFUR_S10' Usage Rights page:
| ArtistName | Role         | StartDate  | ExpirationDate |
| Stan Marsh | neutral role | 02.02.2002 | 20.02.2020     |


Scenario: check updating of 'Visual Talent' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S11' project
And created '/F_PFUR_S11' folder for project 'P_PFUR_S11'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S11' folder for 'P_PFUR_S11' project
And waited while transcoding is finished in folder '/F_PFUR_S11' on project 'P_PFUR_S11' files page
And added 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S11' and project 'P_PFUR_S11' Usage Rights page:
| ArtistName   | Role       | StartDate  | ExpirationDate |
| Eric Cartman | some role  | 02.02.2002 | 20.02.2002     |
And waited for '3' seconds
And refreshed the page
When I edit entry of 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S11' and project 'P_PFUR_S11' Usage Rights page:
| EntryNumber | ArtistName | Role         | StartDate  | ExpirationDate |
| 1           | Stan Marsh | neutral role | 02.02.2002 | 20.02.2020     |
And refresh the page
Then I 'should' see 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S11' and project 'P_PFUR_S11' Usage Rights page:
| ArtistName | Role         | StartDate  | ExpirationDate |
| Stan Marsh | neutral role | 02.02.2002 | 20.02.2020     |


Scenario: check removing of 'Visual Talent' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S12' project
And created '/F_PFUR_S12' folder for project 'P_PFUR_S12'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S12' folder for 'P_PFUR_S12' project
And waited while transcoding is finished in folder '/F_PFUR_S12' on project 'P_PFUR_S12' files page
And added 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S12' and project 'P_PFUR_S12' Usage Rights page:
| ArtistName | Role         | StartDate  | ExpirationDate |
| Stan Marsh | neutral role | 02.02.2002 | 20.02.2020     |
And refreshed the page
When I remove '1' entry of 'Visual Talent' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S12' and project 'P_PFUR_S12' Usage Rights page
And refresh the page
Then I 'should not' see 'Visual Talent' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S12' and project 'P_PFUR_S12' Usage Rights page


Scenario: check creation of 'Music' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S13' project
And created '/F_PFUR_S13' folder for project 'P_PFUR_S13'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S13' folder for 'P_PFUR_S13' project
And waited while transcoding is finished in folder '/F_PFUR_S13' on project 'P_PFUR_S13' files page
When I add 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S13' and project 'P_PFUR_S13' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And refresh the page
Then I 'should' see 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S13' and project 'P_PFUR_S13' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |


Scenario: check updating of 'Music' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S14' project
And created '/F_PFUR_S14' folder for project 'P_PFUR_S14'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S14' folder for 'P_PFUR_S14' project
And waited while transcoding is finished in folder '/F_PFUR_S14' on project 'P_PFUR_S14' files page
And added 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S14' and project 'P_PFUR_S14' Usage Rights page:
| ArtistName   | TrackTitle    | StartDate  | ExpirationDate | Composer      | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Eric Cartman | the best song | 20.02.2002 | 02.02.2002     | Liane Cartman | 12          | testLabel   | testSubLabel | white penguin        | textArranger | -ABC-123-  | 111      | some details   | some contacts  |
And refreshed the page
When I edit entry of 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S14' and project 'P_PFUR_S14' Usage Rights page:
| EntryNumber | ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| 1           | Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 222      | some details   | some contacts  |
And refresh the page
Then I 'should' see 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S14' and project 'P_PFUR_S14' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 222      | some details   | some contacts  |


Scenario: check removing of 'Music' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S15' project
And created '/F_PFUR_S15' folder for project 'P_PFUR_S15'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S15' folder for 'P_PFUR_S15' project
And waited while transcoding is finished in folder '/F_PFUR_S15' on project 'P_PFUR_S15' files page
And added 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S15' and project 'P_PFUR_S15' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And refreshed the page
When I remove '1' entry of 'Music' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S15' and project 'P_PFUR_S15' Usage Rights page
And refresh the page
Then I 'should not' see 'Music' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S15' and project 'P_PFUR_S15' Usage Rights page


Scenario: check creation of 'Voice-over Artist' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S16' project
And created '/F_PFUR_S16' folder for project 'P_PFUR_S16'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S16' folder for 'P_PFUR_S16' project
And waited while transcoding is finished in folder '/F_PFUR_S16' on project 'P_PFUR_S16' files page
When I add 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S16' and project 'P_PFUR_S16' Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And refresh the page
Then I 'should' see 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S16' and project 'P_PFUR_S16' Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |


Scenario: check updating of 'Voice-over Artist' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S17' project
And created '/F_PFUR_S17' folder for project 'P_PFUR_S17'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S17' folder for 'P_PFUR_S17' project
And waited while transcoding is finished in folder '/F_PFUR_S17' on project 'P_PFUR_S17' files page
And added 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S17' and project 'P_PFUR_S17' Usage Rights page:
| ArtistName   | Role         | StartDate  | ExpirationDate | BaseFee | Agent         | AgentTel  | Email            | Union      | MoreInfo  |
| Eric Cartman | neutral role | 20.02.2002 | 02.02.2020     | 17%     | Liane Cartman | 555-69-69 | liane-c@mail.com | test union | some info |
And refreshed the page
When I edit entry of 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S17' and project 'P_PFUR_S17' Usage Rights page:
| EntryNumber | ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| 1           | Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And refresh the page
Then I 'should' see 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S17' and project 'P_PFUR_S17' Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |


Scenario: check removing of 'Voice-over Artist' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S18' project
And created '/F_PFUR_S18' folder for project 'P_PFUR_S18'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S18' folder for 'P_PFUR_S18' project
And waited while transcoding is finished in folder '/F_PFUR_S18' on project 'P_PFUR_S18' files page
And added 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S18' and project 'P_PFUR_S18' Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And refreshed the page
When I remove '1' entry of 'Voice-over Artist' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S18' and project 'P_PFUR_S18' Usage Rights page
And refresh the page
Then I 'should not' see 'Voice-over Artist' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S18' and project 'P_PFUR_S18' Usage Rights page


Scenario: check creation of 'Other usage' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S19' project
And created '/F_PFUR_S19' folder for project 'P_PFUR_S19'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S19' folder for 'P_PFUR_S19' project
And waited while transcoding is finished in folder '/F_PFUR_S19' on project 'P_PFUR_S19' files page
When I add 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S19' and project 'P_PFUR_S19' Usage Rights page:
| Comment      |
| test comment |
And wait for '3' seconds
And refresh the page
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S19' and project 'P_PFUR_S19' Usage Rights page:
| Comment      |
| test comment |


Scenario: check updating of 'Other usage' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S20' project
And created '/F_PFUR_S20' folder for project 'P_PFUR_S20'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S20' folder for 'P_PFUR_S20' project
And waited while transcoding is finished in folder '/F_PFUR_S20' on project 'P_PFUR_S20' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S20' and project 'P_PFUR_S20' Usage Rights page:
| Comment           |
| some test comment |
And refreshed the page
When I edit entry of 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S20' and project 'P_PFUR_S20' Usage Rights page:
| EntryNumber | Comment      |
| 1           | test comment |
And refresh the page
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S20' and project 'P_PFUR_S20' Usage Rights page:
| Comment      |
| test comment |


Scenario: check removing of 'Other usage' usage rigth for project file
Meta:@gdam
@projects
Given I created 'P_PFUR_S21' project
And created '/F_PFUR_S21' folder for project 'P_PFUR_S21'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S21' folder for 'P_PFUR_S21' project
And waited while transcoding is finished in folder '/F_PFUR_S21' on project 'P_PFUR_S21' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S21' and project 'P_PFUR_S21' Usage Rights page:
| Comment      |
| test comment |
And refreshed the page
When I remove '1' entry of 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S21' and project 'P_PFUR_S21' Usage Rights page
And refresh the page
Then I 'should not' see 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_PFUR_S21' and project 'P_PFUR_S21' Usage Rights page


Scenario: check creation of usage rights for project file
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I created 'P_PFUR_S22' project
And created '/F_PFUR_S22' folder for project 'P_PFUR_S22'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S22' folder for 'P_PFUR_S22' project
And waited while transcoding is finished in folder '/F_PFUR_S22' on project 'P_PFUR_S22' files page
When I add 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And add 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And add 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| Type           | Comment      |
| Generic Master | test comment |
And add 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| ArtistName | Role         | StartDate  | ExpirationDate |
| Stan Marsh | neutral role | 02.02.2002 | 20.02.2020     |
And add 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And add 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And add 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| Comment      |
| test comment |
And refresh the page
Then I 'should' see 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And 'should' see 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And 'should' see 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| Type           | Comment      |
| Generic Master | test comment |
And 'should' see 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| ArtistName | Role         | StartDate  | ExpirationDate |
| Stan Marsh | neutral role | 02.02.2002 | 20.02.2020     |
And 'should' see 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And 'should' see 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S22' and project 'P_PFUR_S22' Usage Rights page:
| Comment      |
| test comment |


Scenario: check creation of usage rights for project file after page refresh
Meta:@gdam
@projects
Given I created 'P_PFUR_S23' project
And created '/F_PFUR_S23' folder for project 'P_PFUR_S23'
And uploaded '/files/Fish Ad.mov' file into '/F_PFUR_S23' folder for 'P_PFUR_S23' project
And waited while transcoding is finished in folder '/F_PFUR_S23' on project 'P_PFUR_S23' files page
And added 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And added 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And added 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| Type           | Comment      |
| Generic Master | test comment |
And added 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| ArtistName | Role         | StartDate  | ExpirationDate |
| Stan Marsh | neutral role | 02.02.2002 | 20.02.2020     |
And added 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And added 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| Comment      |
| test comment |
Then I 'should' see 'General' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And 'should' see 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And 'should' see 'Media Types' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| Type           | Comment      |
| Generic Master | test comment |
And 'should' see 'Visual Talent' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| ArtistName | Role         | StartDate  | ExpirationDate |
| Stan Marsh | neutral role | 02.02.2002 | 20.02.2020     |
And 'should' see 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And 'should' see 'Voice-over Artist' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_PFUR_S23' and project 'P_PFUR_S23' Usage Rights page:
| Comment      |
| test comment |

Scenario: Check that file metadata is editable when usage right is added
Meta:@gdam
@projects
Given I created 'P_PFUR_S24' project
And created '/F_PFUR_S24' folder for project 'P_PFUR_S24'
And uploaded '/files/image10.jpg' file into '/F_PFUR_S24' folder for 'P_PFUR_S24' project
And waited while transcoding is finished in folder '/F_PFUR_S24' on project 'P_PFUR_S24' files page
And added 'General' usage rule with following fields on file 'image10.jpg' and folder '/F_PFUR_S24' and project 'P_PFUR_S24' Usage Rights page:
| StartDate  | ExpirationDate |
| 2 days ago | 2 days since   |
When I go to file 'image10.jpg' info page in folder '/F_PFUR_S24' project 'P_PFUR_S24'
And 'save' file info by next information:
| FieldName  | FieldValue   |
| Title      | IMG PFUR S24 |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue   |
| Title      | IMG PFUR S24 |


Scenario: check creation of 'Countries' usage rigth with value 'Europe' for project file
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I created 'P_PFUR_S25' project
And created '/F_PFUR_S25' folder for project 'P_PFUR_S25'
And uploaded '/files/image10.jpg' file into '/F_PFUR_S25' folder for 'P_PFUR_S25' project
And waited while transcoding is finished in folder '/F_PFUR_S25' on project 'P_PFUR_S25' files page
When I add 'Countries' usage rule with following fields on file 'image10.jpg' and folder '/F_PFUR_S25' and project 'P_PFUR_S25' Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Europe  | 2 days ago | 2 days since   |
And refresh the page
Then I 'should' see 'Countries' usage rule with following fields on file 'image10.jpg' and folder '/F_PFUR_S25' and project 'P_PFUR_S25' Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Europe  | 2 days ago | 2 days since   |