!--NGN-8874
Feature:          User locale - Email localisation
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check localization of the most important part in email notifications

Scenario: Check that user receives email about file sharing in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S01' with default attributes
And created users with following fields:
| Email       | Agency     | Role         | Language       |
| AU_ULEL_S01 | A_ULEL_S01 | agency.admin | en-us          |
| <UserEmail> | A_ULEL_S01 | agency.user  | <UserLanguage> |
And logged in with details of 'AU_ULEL_S01'
And created 'P_ULEL_S01' project
And created '/F_ULEL_S01' folder for project 'P_ULEL_S01'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S01' folder for 'P_ULEL_S01' project
And waited while transcoding is finished in folder '/F_ULEL_S01' on project 'P_ULEL_S01' files page
When I add secure share for file '128_shortname.jpg' from folder '/F_ULEL_S01' and project 'P_ULEL_S01' to following users:
| UserEmails  | Message |
| <UserEmail> | hi dude |
Then I 'should' see email notification for 'File sharing with user' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName    | Agency     | FileName          | Message |
| AU_ULEL_S01 | A_ULEL_S01 | 128_shortname.jpg | hi dude |

Examples:
| UserEmail    | UserLanguage | EmailSubject                                 |
| U_ULEL_S01_1 | en           | File has been shared with you                |
| U_ULEL_S01_8 | es-ar        | Adbank - Se ha compartido un archivo contigo |
| U_ULEL_S01_0 | en-beam-us   | File has been shared with you                |


Scenario: Check that user receives email about file public sharing in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S02' with default attributes
And created users with following fields:
| Email       | Agency     | Role         | Language       |
| AU_ULEL_S02 | A_ULEL_S02 | agency.admin | en-us          |
| <UserEmail> | A_ULEL_S02 | agency.user  | <UserLanguage> |
And logged in with details of 'AU_ULEL_S02'
And created 'P_ULEL_S02' project
And created '/F_ULEL_S02' folder for project 'P_ULEL_S02'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S02' folder for 'P_ULEL_S02' project
And waited while transcoding is finished in folder '/F_ULEL_S02' on project 'P_ULEL_S02' files page
When I send public link of file '128_shortname.jpg' from folder '/F_ULEL_S02' and project 'P_ULEL_S02' to following users:
| UserEmails  | Message |
| <UserEmail> | hi dude |
Then I 'should' see email notification for 'File sharing' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName    | Agency     | FileName          | Message |
| AU_ULEL_S02 | A_ULEL_S02 | 128_shortname.jpg | hi dude |

Examples:
| UserEmail    | UserLanguage | EmailSubject                     |
| U_ULEL_S02_2 | en-au        | has shared file with you         |
| U_ULEL_S02_5 | de           | hat eine Datei mit Ihnen geteilt |
| U_ULEL_S02_0 | en-beam-us   | A file has been shared with you  |


Scenario: Check that user receives email about folder sharing in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S03' with default attributes
And created users with following fields:
| Email       | Agency     | Role         | Language       |
| AU_ULEL_S03 | A_ULEL_S03 | agency.admin | en-us          |
| <UserEmail> | A_ULEL_S03 | agency.user  | <UserLanguage> |
And logged in with details of 'AU_ULEL_S03'
And created 'P_ULEL_S03' project
And created '/F_ULEL_S03' folder for project 'P_ULEL_S03'
And added users '<UserEmail>' to project 'P_ULEL_S03' team folders '/F_ULEL_S03' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
Then I 'should' see email notification for 'Folder sharing for User' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName    | Agency     | ProjectName | FolderName |
| AU_ULEL_S03 | A_ULEL_S03 | P_ULEL_S03  | F_ULEL_S03 |

Examples:
| UserEmail    | UserLanguage | EmailSubject                                    |
| U_ULEL_S03_3 | en-gb        | Adbank - Folder(s) has been shared with you     |
| U_ULEL_S03_7 | es-es        | Adbank - Se ha(n) compartido carpeta(s) contigo |
| U_ULEL_S03_9 | en-beam      | A Project Folder(s) has been shared with you    |


Scenario: Check that user receives email about asset sharing in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S04' with default attributes
And created users with following fields:
| Email       | Agency     | Role         | Language       |
| AU_ULEL_S04 | A_ULEL_S04 | agency.admin | en-us          |
| <UserEmail> | A_ULEL_S04 | agency.user  | <UserLanguage> |
And logged in with details of 'AU_ULEL_S04'
And uploaded file '/files/128_shortname.jpg' into library
And waited while preview is available in collection 'My Assets'
When I add secure share for asset '128_shortname.jpg' from collection 'My Assets' to following users:
| UserEmails  | Message  |
| <UserEmail> | Hi dude! |
Then I 'should' see email notification for 'Asset sharing with user' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName    | UserName1   | Agency     | FileName          | Message  |
| AU_ULEL_S04 | <UserEmail> | A_ULEL_S04 | 128_shortname.jpg | Hi dude! |

Examples:
| UserEmail    | UserLanguage | EmailSubject                |
| U_ULEL_S04_4 | en-us        | has been shared with        |
| U_ULEL_S04_6 | fr           | partage un fichier avec     |
| U_ULEL_S04_7 | es-es        | Se ha compartido el archivo |


Scenario: Check that user receives email about asset public sharing in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S05' with default attributes
And created users with following fields:
| Email       | Agency     | Role         | Language       |
| AU_ULEL_S05 | A_ULEL_S05 | agency.admin | en-us          |
| <UserEmail> | A_ULEL_S05 | agency.user  | <UserLanguage> |
And logged in with details of 'AU_ULEL_S05'
And uploaded file '/files/128_shortname.jpg' into library
And waited while preview is available in collection 'My Assets'
When I send public link of asset '128_shortname.jpg' from collection 'My Assets' to following users:
| UserEmails  | Message  |
| <UserEmail> | Hi dude! |
Then I 'should' see email notification for 'Asset sharing' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName    | Agency     | FileName          | Message  |
| AU_ULEL_S05 | A_ULEL_S05 | 128_shortname.jpg | Hi dude! |

Examples:
| UserEmail    | UserLanguage | EmailSubject                     |
| U_ULEL_S05_5 | de           | hat eine Datei mit Ihnen geteilt |
| U_ULEL_S05_6 | fr           | partage un fichier avec vous     |
| U_ULEL_S05_7 | es-es        | ha compartido un archivo contigo |


Scenario: Check that user receives email about presentation sharing in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S06' with default attributes
And created users with following fields:
| Email       | Agency     | Role         | Language       |
| AU_ULEL_S06 | A_ULEL_S06 | agency.admin | en-us          |
| <UserEmail> | A_ULEL_S06 | agency.user  | <UserLanguage> |
And logged in with details of 'AU_ULEL_S06'
And created following reels:
| Name       | Description |
| P_ULEL_S06 | Desctiption |
When I send presentation 'P_ULEL_S06' to user '<UserEmail>' with personal message 'Hi dude!'
Then I 'should' see email notification for 'Shared presentation' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName    | Agency     | Message  | PresentationName |
| AU_ULEL_S06 | A_ULEL_S06 | Hi dude! | P_ULEL_S06       |

Examples:
| UserEmail    | UserLanguage | EmailSubject                     |
| U_ULEL_S06_5 | de           | wurde mit Ihnen geteilt          |
| U_ULEL_S06_6 | fr           | est partagé avec vous            |
| U_ULEL_S06_8 | es-ar        | Se ha compartido la presentación |


Scenario: Check that user receives email about asset sharing with invite in language according to sender locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S07' with default attributes
And created users with following fields:
| Email            | Agency     | Role         | Language         |
| <AdminUserEmail> | A_ULEL_S07 | agency.admin | <SenderLanguage> |
And logged in with details of '<AdminUserEmail>'
And uploaded file '/files/128_shortname.jpg' into library
And waited while preview is available in collection 'My Assets'
When I add secure share for asset '128_shortname.jpg' from collection 'My Assets' to following users:
| UserEmails  | Message  |
| <UserEmail> | Hi dude! |
Then I 'should' see email notification for 'Asset sharing with easy user' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| EmailLanguage    | UserName         | Agency     | Message  |
| <SenderLanguage> | <AdminUserEmail> | A_ULEL_S07 | Hi dude! |

Examples:
| AdminUserEmail | UserEmail    | SenderLanguage | EmailSubject                                            |
| AU_ULEL_S07_5  | U_ULEL_S07_5 | de             | Sie wurden als neuer Benutzer für die Adbank eingeladen |
| AU_ULEL_S07_6  | U_ULEL_S07_6 | fr             | Vous êtes invité(e) à vous connecter à Adbank           |
| AU_ULEL_S07_0  | U_ULEL_S07_0 | en-beam-us     | You are invited to Beam                                 |


Scenario: Check that user receives email about comment written in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S08' with default attributes
And created users with following fields:
| Email       | Agency     | Role         | Language       |
| AU_ULEL_S08 | A_ULEL_S08 | agency.admin | en-us          |
| <UserEmail> | A_ULEL_S08 | agency.admin | <UserLanguage> |
| U_ULEL_S08  | A_ULEL_S08 | agency.user  | en-us          |
And logged in with details of 'AU_ULEL_S08'
And set following notification settings for users:
| UserEmail   | SettingName    | SettingState |
| <UserEmail> | File Commented | on           |
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And created '/F_ULEL_S08' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S08' folder for '<ProjectName>' project
When I add secure share for file '128_shortname.jpg' from folder '/F_ULEL_S08' and project '<ProjectName>' to following users:
| UserEmails |
| U_ULEL_S08 |
And login with details of 'U_ULEL_S08'
And open link from email when user 'U_ULEL_S08' received email with next subject 'File(s) has been shared with you'
And open comments tab on opened file preview page
And add comment 'hello admin' on opened file preview comments page
And login with details of '<UserEmail>'
Then I 'should' see email notification for 'Comment on secure shared file' with field to '<UserEmail>' and subject '<CommentEmailSubject>' contains following attributes:
| Agency     | UserName   | FileName          | Comment     | ProjectName   |
| A_ULEL_S08 | U_ULEL_S08 | 128_shortname.jpg | hello admin | <ProjectName> |

Examples:
| UserEmail    | ProjectName  | UserLanguage | CommentEmailSubject                        |
| U_ULEL_S08_5 | P_ULEL_S08_5 | de           | Neuer Kommentar zur Datei                  |
| U_ULEL_S08_6 | P_ULEL_S08_6 | fr           | Un commentaire a été ajouté sur le fichier |
| U_ULEL_S08_7 | P_ULEL_S08_7 | es-es        | Se ha añadido un comentario en             |


Scenario: Check that user receives email about file downloading in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S09' with default attributes
And created users with following fields:
| Email       | Agency     | Role         | Language       |
| AU_ULEL_S09 | A_ULEL_S09 | agency.admin | en-us          |
| <UserEmail> | A_ULEL_S09 | agency.admin | <UserLanguage> |
| U_ULEL_S09  | A_ULEL_S09 | agency.user  | en-us          |
And logged in with details of 'AU_ULEL_S09'
And set following notification settings for users:
| UserEmail   | SettingName               | SettingState |
| <UserEmail> | File Downloaded As Master | on           |
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And created '/F_ULEL_S09' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S09' folder for '<ProjectName>' project
And fill Share popup by users 'U_ULEL_S09' in project '<ProjectName>' folders '/F_ULEL_S09' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And waited while transcoding is finished in folder '/F_ULEL_S09' on project '<ProjectName>' files page
When I login with details of 'U_ULEL_S09'
And downloaded file '128_shortname.jpg' on folder '/F_ULEL_S09' project '<ProjectName>' file info page
And login with details of '<UserEmail>'
Then I 'should' see email notification for 'Download file' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| Agency     | UserName   | FileName          | ProjectName   | FolderName |
| A_ULEL_S09 | U_ULEL_S09 | 128_shortname.jpg | <ProjectName> | F_ULEL_S09 |

Examples:
| UserEmail    | ProjectName  | UserLanguage | EmailSubject                      |
| U_ULEL_S09_1 | P_ULEL_S09_1 | en           | has been successfully downloaded  |
| U_ULEL_S09_5 | P_ULEL_S09_5 | de           | wurde erfolgreich heruntergeladen |
| U_ULEL_S09_7 | P_ULEL_S09_7 | es-es        | ha sido descargado                |


Scenario: Check that user receives email about file uploading in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S10' with default attributes
And created users with following fields:
| Email       | Agency     | Role         | Language       |
| AU_ULEL_S10 | A_ULEL_S10 | agency.admin | en-us          |
| <UserEmail> | A_ULEL_S10 | agency.admin | <UserLanguage> |
| U_ULEL_S10  | A_ULEL_S10 | agency.user  | en-us          |
And logged in with details of 'AU_ULEL_S10'
And set following notification settings for users:
| UserEmail   | SettingName    | SettingState |
| <UserEmail> | Files Uploaded | on           |
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And created '/F_ULEL_S10' folder for project '<ProjectName>'
And fill Share popup by users 'U_ULEL_S10' in project '<ProjectName>' folders '/F_ULEL_S10' with role 'project.contributor' expired '12.02.2021' and 'should' access to subfolders
When I login with details of 'U_ULEL_S10'
And upload '/files/128_shortname.jpg' file into '/F_ULEL_S10' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_ULEL_S10' on project '<ProjectName>' files page
And login with details of '<UserEmail>'
Then I 'should' see email notification for 'File Uploaded to Projects' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName   | Agency     | ProjectName   | FolderName | FileName          |
| U_ULEL_S10 | A_ULEL_S10 | <ProjectName> | F_ULEL_S10 | 128_shortname.jpg |

Examples:
| UserEmail    | ProjectName  | UserLanguage | EmailSubject                   |
| U_ULEL_S10_5 | P_ULEL_S10_5 | de           | wurde erfolgreich hochgeladen  |
| U_ULEL_S10_6 | P_ULEL_S10_6 | fr           | est uploadé avec succès        |
| U_ULEL_S10_7 | P_ULEL_S10_7 | es-es        | se ha subido al proyecto       |


Scenario: Check that user receives email about asset uploading in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created the agency 'A_ULEL_S11' with default attributes
And created users with following fields:
| Email        | Agency     | Role         | Language       |
| AU_ULEL_S11  | A_ULEL_S11 | agency.admin | en-us          |
| <UserEmail>  | A_ULEL_S11 | agency.admin | <UserLanguage> |
| <MoverEmail> | A_ULEL_S11 | agency.user  | en-us          |
And logged in with details of 'AU_ULEL_S11'
And set following notification settings for users:
| UserEmail   | SettingName            | SettingState |
| <UserEmail> | Files Moved To Library | on           |
And logged in with details of '<UserEmail>'
And created '<ProjectName>' project
And created '/F_ULEL_S11' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S11' folder for '<ProjectName>' project
And created 'PR_ULEL_S11' role in 'project' group for advertiser 'A_ULEL_S11' with following permissions:
| Permission              |
| element.read            |
| element.write           |
| element.send_to_library |
| folder.read             |
And fill Share popup by users '<MoverEmail>' in project '<ProjectName>' folders '/F_ULEL_S11' with role 'PR_ULEL_S11' expired '12.02.2021' and 'should' access to subfolders
And waited while transcoding is finished in folder '/F_ULEL_S11' on project '<ProjectName>' files page
When I login with details of '<MoverEmail>'
And move file '128_shortname.jpg' from project '<ProjectName>' folder '/F_ULEL_S11' to library page
And login with details of '<UserEmail>'
Then I 'should' see email notification for 'File moved to library' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName     | Agency     | ProjectName   | FolderName | FileName          |
| <MoverEmail> | A_ULEL_S11 | <ProjectName> | F_ULEL_S11 | 128_shortname.jpg |

Examples:
| UserEmail    | MoverEmail    | ProjectName  | UserLanguage | EmailSubject                    |
| U_ULEL_S11_5 | MU_ULEL_S11_5 | P_ULEL_S11_5 | de           | wurde in die Library verschoben |
| U_ULEL_S11_6 | MU_ULEL_S11_6 | P_ULEL_S11_6 | fr           | est copié dans la médiathèque   |
| U_ULEL_S11_7 | MU_ULEL_S11_7 | P_ULEL_S11_7 | es-es        | se ha enviado a la Biblioteca   |


Scenario: Check that user receives email about approval request in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created users with following fields:
| Email       | Role        | Language       |
| <UserEmail> | agency.user | <UserLanguage> |
And created '<ProjectName>' project
And created '/F_ULEL_S12' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S12' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_ULEL_S12' on project '<ProjectName>' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_ULEL_S12' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_ULEL_S12 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
Then I 'should' see email notification for 'Approval request' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| Agency        | UserEmail   | UserName    | ApprovalMessage  | ProjectName   | FileName          | RequiredDate |
| DefaultAgency | AgencyAdmin | AgencyAdmin | test description | <ProjectName> | 128_shortname.jpg | 01/05/2023   |

Examples:
| UserEmail    | ProjectName  | UserLanguage | EmailSubject                  |
| U_ULEL_S12_6 | P_ULEL_S12_6 | fr           | a demandé votre approbation   |
| U_ULEL_S12_7 | P_ULEL_S12_7 | es-es        | solicita tu aprobación        |
| U_ULEL_S12_0 | P_ULEL_S12_0 | en-beam-us   | has requested your approval   |


Scenario: Check that user receives email about approval request to not registered user in language according to sender locale
Meta: @skip
      @gdam
      @gdamemails
Given I created users with following fields:
| Email            | Role         | Language       |
| <AdminUserEmail> | agency.admin | <UserLanguage> |
And logged in with details of '<AdminUserEmail>'
And created '<ProjectName>' project
And created '/F_ULEL_S13' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S13' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_ULEL_S13' on project '<ProjectName>' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_ULEL_S13' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_ULEL_S13 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
Then I 'should' see email notification for 'Approval request' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| EmailLanguage  | Agency        | UserEmail        | UserName         | ApprovalMessage  | ProjectName   | FileName          | RequiredDate |
| <UserLanguage> | DefaultAgency | <AdminUserEmail> | <AdminUserEmail> | test description | <ProjectName> | 128_shortname.jpg | 01/05/2023   |

Examples:
| AdminUserEmail | UserEmail    | ProjectName  | UserLanguage | EmailSubject                  |
| AU_ULEL_S13_5  | U_ULEL_S13_5 | P_ULEL_S13_5 | de           | bittet um Freigabe            |
| AU_ULEL_S13_6  | U_ULEL_S13_6 | P_ULEL_S13_6 | fr           | a demandé votre approbation   |
| AU_ULEL_S13_7  | U_ULEL_S13_7 | P_ULEL_S13_7 | es-es        | solicita tu aprobación        |


Scenario: Check that user receives email about approval reminder in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created users with following fields:
| Email       | Role         | Language       |
| AU_ULEL_S14 | agency.admin | en-us          |
| <UserEmail> | agency.user  | <UserLanguage> |
And logged in with details of 'AU_ULEL_S14'
And created '<ProjectName>' project
And created '/F_ULEL_S14' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S14' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_ULEL_S14' on project '<ProjectName>' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_ULEL_S14' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_ULEL_S14 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
And on file '128_shortname.jpg' approvals page in folder '/F_ULEL_S14' project '<ProjectName>'
When I send reminder for 'AS_ULEL_S14' approval stage
Then I 'should' see email notification for 'Approval required reminder' with field to '<UserEmail>' and subject '<EmailSubject>' contains following attributes:
| Agency        | UserName    | ApprovalMessage  | ProjectName   | FileName          | RequiredDate |
| DefaultAgency | AU_ULEL_S14 | test description | <ProjectName> | 128_shortname.jpg | 01/05/2023   |

Examples:
| UserEmail    | ProjectName  | UserLanguage | EmailSubject                        |
| U_ULEL_S14_1 | P_ULEL_S14_1 | en           | Approval required - reminder!       |
| U_ULEL_S14_5 | P_ULEL_S14_5 | de           | Freigabe erforderlich - Erinnerung! |
| U_ULEL_S14_8 | P_ULEL_S14_8 | es-ar        | Aprobación requerida - Recordatorio |


Scenario: Check that user receives email about approval completed in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created users with following fields:
| Email            | Role         | Language       |
| <AdminUserEmail> | agency.admin | <UserLanguage> |
| U_ULEL_S15       | agency.user  | en-us          |
And logged in with details of '<AdminUserEmail>'
And created '<ProjectName>' project
And created '/F_ULEL_S15' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S15' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_ULEL_S15' on project '<ProjectName>' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_ULEL_S15' project '<ProjectName>':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_ULEL_S15 | U_ULEL_S15 | 01/05/2023 12:15 | test description | true    |
And logged in with details of 'U_ULEL_S15'
When I open link from email when user 'U_ULEL_S15' received email with next subject 'has requested your approval'
And 'approve' file with comment 'test comment' on opened file info page
And login with details of '<AdminUserEmail>'
Then I 'should' see email notification for 'Approval completed' with field to '<AdminUserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_ULEL_S15 | DefaultAgency | 128_shortname.jpg | AS_ULEL_S15   |

Examples:
| AdminUserEmail | ProjectName  | UserLanguage | EmailSubject        |
| U_ULEL_S15_5   | P_ULEL_S15_5 | de           | wurde abgeschlossen |
| U_ULEL_S15_8   | P_ULEL_S15_8 | es-ar        | se ha completado    |
| U_ULEL_S15_9   | P_ULEL_S15_9 | en-beam      | has completed       |


Scenario: Check that user receives email about stage approved in language according to his locale
Meta: @skip
      @gdam
      @gdamemails
Given I created users with following fields:
| Email            | Role         | Language       |
| <AdminUserEmail> | agency.admin | <UserLanguage> |
| U_ULEL_S16       | agency.user  | en-us          |
And logged in with details of '<AdminUserEmail>'
And created '<ProjectName>' project
And created '/F_ULEL_S16' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_ULEL_S16' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_ULEL_S16' on project '<ProjectName>' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_ULEL_S16' project '<ProjectName>':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_ULEL_S16 | U_ULEL_S16 | 01/05/2023 12:15 | test description | true    |
And logged in with details of 'U_ULEL_S16'
When I open link from email when user 'U_ULEL_S16' received email with next subject 'has requested your approval'
And 'approve' file with comment 'test comment' on opened file info page
And login with details of '<AdminUserEmail>'
Then I 'should' see email notification for 'Approved by user' with field to '<AdminUserEmail>' and subject '<EmailSubject>' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_ULEL_S16 | DefaultAgency | 128_shortname.jpg | AS_ULEL_S16   |

Examples:
| AdminUserEmail | ProjectName  | UserLanguage | EmailSubject |
| U_ULEL_S16_5   | P_ULEL_S16_5 | de           | freigegeben  |
| U_ULEL_S16_6   | P_ULEL_S16_6 | fr           | a approuvé   |
| U_ULEL_S16_7   | P_ULEL_S16_7 | es-ar        | ha aprobado  |


Scenario: Check 'project.published' email template in 'es' locale
!--NGN-9833
Meta: @skip
      @gdam