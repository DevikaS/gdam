!--NGN-1412
Feature:          Rules of naming files for download
Narrative:
In order to
As a              AgencyUser
I want to         Check Rules of naming files for download

Scenario: Check correct naming downloaded master and proxy for video from folder 'Files' tab in Projects
Meta: @skip
      @gdam
Given I created 'P_NFRFD_S01' project
And created '/F_NFRFD_S01' folder for project 'P_NFRFD_S01'
And uploaded '/files/Fish1-Ad.mov' file into '/F_NFRFD_S01' folder for 'P_NFRFD_S01' project
And waited while preview is available in folder '/F_NFRFD_S01' on project 'P_NFRFD_S01' files page
When I select file 'Fish1-Ad.mov' on project 'P_NFRFD_S01' files page
And click Download button on project files page
And click Download link next to '<DownloadType>' file name '<FileName>' on Download popup
And wait for '5' seconds
Then I 'should' see downloaded file '<FileName>'

Examples:
| DownloadType | FileName           |
| original     | Fish1-Ad.mov       |
| proxy        | Fish1-Ad_proxy.mov |


Scenario: Check correct naming downloaded master and proxy for video from asset details tab in Projects
Meta: @skip
      @gdam
Given I created 'P_NFRFD_S02' project
And created '/F_NFRFD_S02' folder for project 'P_NFRFD_S02'
And uploaded '/files/Fish2-Ad.mov' file into '/F_NFRFD_S02' folder for 'P_NFRFD_S02' project
And waited while preview is available in folder '/F_NFRFD_S02' on project 'P_NFRFD_S02' files page
When I download '<DownloadType>' file 'Fish2-Ad.mov' on folder '/F_NFRFD_S02' project 'P_NFRFD_S02' file info page
And wait for '5' seconds
Then I 'should' see downloaded file '<FileName>'

Examples:
| DownloadType | FileName           |
| original     | Fish2-Ad.mov       |
| proxy        | Fish2-Ad_proxy.mov |


Scenario: Check correct naming downloaded master and proxy for video from Version History tab in Projects
Meta: @skip
      @gdam
Given 'Project3' project created
And 'Folder3' folder created inside 'Project3'
And uploaded video file 'Filename3.ext3' in 'Folder3' as 'Asset3'
And preview for 'Asset2' available
And I am 'Asset3' Version History tab
When I click on '<Download>'
Then I should download file with '<downloaded_filename>' name

Examples:
| Download          | downloaded_filename  |
| Download Original | Filename3.ext2       |
| Download Proxy    | Filename3_proxy.ext3 |


Scenario: Check correct naming downloaded master and preview for documents, images and audio from folder 'Files' tab in Projects
Meta: @skip
      @gdam
Given 'Project4' project created
And 'Folder4' folder created inside 'Project4'
And uploaded <file> file 'Filename4.ext4' in 'Folder4' as 'Asset4'
| file     |
| document |
| image    |
| audio    |
And preview for 'Asset4' available
And I am on 'Files' tab of 'Folder4' folder
When I select 'Asset4' asset
And click 'download' link next to the '<dialig_link>' text
Then I should download file with '<downloaded_filename>' name

Examples:
| dialog_link                    | downloaded_filename    |
| original - Filename4.ext4      | Filename4.ext4         |
| preview - Filename4_proxy.ext4 | Filename4_preview.ext4 |


Scenario: Check correct naming downloaded master and preview for documents, images and audio from asset details tab in Projects
Meta: @skip
      @gdam
Given 'Project5' project created
And 'Folder5' folder created inside 'Project5'
And uploaded <file> file 'Filename5.ext5' in 'Folder5' as 'Asset5'
| file     |
| document |
| image    |
| audio    |
And preview for 'Asset5' available
And I am 'Asset5' asset details
When I click on '<Download>'
Then I should download file with '<downloaded_filename>' name

Examples:
| Download          | downloaded_filename    |
| Download Original | Filename5.ext5         |
| Download Preview  | Filename5_preview.ext5 |


Scenario: Check correct naming downloaded master and preview for documents, images and audio from Version History tab in Projects
Meta: @skip
      @gdam
Given 'Project6' project created
And 'Folder6' folder created inside 'Project6'
And uploaded <file> file 'Filename6.ext6' in 'Folder6' as 'Asset6'
| file     |
| document |
| image    |
| audio    |
And preview for 'Asset6' available
And I am 'Asset6' Version History tab
When I click on '<Download>'
Then I should download file with '<downloaded_filename>' name

Examples:
| Download          | downloaded_filename    |
| Download Original | Filename6.ext6         |
| Download preview  | Filename6_preview.ext6 |


Scenario: Check correct downloaded master, proxy and preview for audio files with embedded cover from folder 'Files' tab in Projects
Meta: @skip
      @gdam
Given 'Project7' project created
And 'Folder7' folder created inside 'Project7'
And uploaded audio file with cover 'Filename7.ext7' in 'Folder7' as 'Asset7'
And preview for 'Asset7' available
And I am 'Asset7' asset details
When I click on '<Download>'
Then I should download file with '<downloaded_filename>' name

Examples:
| Download          | downloaded_filename    |
| Download Original | Filename7.ext7         |
| Download Proxy    | Filename7_proxy.ext7   |
| Download Preview  | Filename7_preview.ext7 |


Scenario: Check correct downloaded master, proxy and preview for audio files with embedded cover from asset details tab in Projects
Meta: @skip
      @gdam
Given 'Project8' project created
And 'Folder8' folder created inside 'Project8'
And uploaded audio file with cover 'Filename8.ext8' in 'Folder8' as 'Asset8'
And preview for 'Asset8' available
And I am 'Asset8' asset details
When I click on '<Download>'
Then I should download file with '<downloaded_filename>' name

Examples:
| Download          | downloaded_filename    |
| Download Original | Filename8.ext8         |
| Download Proxy    | Filename8_proxy.ext8   |
| Download Preview  | Filename8_preview.ext8 |


Scenario: Check correct downloaded master, proxy and preview for audio files with embedded cover from Version History tab in Projects
Meta: @skip
      @gdam
Given 'Project9' project created
And 'Folder9' folder created inside 'Project9'
And uploaded audio file with cover 'Filename9.ext9' in 'Folder9' as 'Asset9'
And preview for 'Asset9' available
And I am 'Asset9' Version History tab
When I click on '<Download>'
Then I should download file with '<downloaded_filename>' name

Examples:
| Download          | downloaded_filename    |
| Download Original | Filename9.ext9         |
| Download Proxy    | Filename9_proxy.ext9   |
| Download preview  | Filename9_preview.ext9 |