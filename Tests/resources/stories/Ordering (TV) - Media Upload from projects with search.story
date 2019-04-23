!--ORD-361
!--ORD-253
!--ORD-1229
Feature: Media upload from projects with search
Narrative:
In order to:
As a AgencyAdmin
I want to check media upload from projects with search

Scenario: Check correct paging after retrieve from projects
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU1 | agency.admin | OTVMUFPA1    |
And logged in with details of 'OTVMUFPU1'
And created 'OTVMUFPP1' project
And created '/OTVMUFPF1' folder for project 'OTVMUFPP1'
And uploaded into project 'OTVMUFPP1' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /OTVMUFPF1 |
| /files/Fish2-Ad.mov  | /OTVMUFPF1 |
| /files/Fish3-Ad.mov  | /OTVMUFPF1 |
| /files/Fish4-Ad.mov  | /OTVMUFPF1 |
| /files/Fish5-Ad.mov  | /OTVMUFPF1 |
| /files/Fish6-Ad.mov  | /OTVMUFPF1 |
| /files/Fish7-Ad.mov  | /OTVMUFPF1 |
| /files/Fish8-Ad.mov  | /OTVMUFPF1 |
| /files/Fish9-Ad.mov  | /OTVMUFPF1 |
| /files/Fish10-Ad.mov | /OTVMUFPF1 |
| /files/Fish11-Ad.mov | /OTVMUFPF1 |
And waited while transcoding is finished in folder '/OTVMUFPF1' on project 'OTVMUFPP1' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN1   |
When I open order item with following clock number 'OTVMUFPCN1'
Then I 'should' see for order item at Add media to your order form following files over pages retrieved from project 'OTVMUFPP1' folder '/OTVMUFPF1':
| Name          |
| Fish1-Ad.mov  |
| Fish2-Ad.mov  |
| Fish3-Ad.mov  |
| Fish4-Ad.mov  |
| Fish5-Ad.mov  |
| Fish6-Ad.mov  |
| Fish7-Ad.mov  |
| Fish8-Ad.mov  |
| Fish9-Ad.mov  |
| Fish10-Ad.mov |
| Fish11-Ad.mov |

Scenario: Check that only video files are available in case to retrieve from Projects
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA2 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU2 | agency.admin | OTVMUFPA2    |
And logged in with details of 'OTVMUFPU2'
And created 'OTVMUFPP2' project
And created '/OTVMUFPF2' folder for project 'OTVMUFPP2'
And uploaded into project 'OTVMUFPP2' following files:
| FileName                   | Path       |
| /files/13DV-CAPITAL-10.mpg | /OTVMUFPF2 |
| /files/GWGTest2.pdf        | /OTVMUFPF2 |
| /files/audio02.mp3         | /OTVMUFPF2 |
| /files/logo3.jpg           | /OTVMUFPF2 |
| /files/index.html          | /OTVMUFPF2 |
| /files/BDDStandards.doc    | /OTVMUFPF2 |
And waited while transcoding is finished in folder '/OTVMUFPF2' on project 'OTVMUFPP2' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN2   |
When I open order item with following clock number 'OTVMUFPCN2'
Then I 'should' see for order item at Add media to your order form following files retrieved from project 'OTVMUFPP2' folder '/OTVMUFPF2':
| Name                |
| 13DV-CAPITAL-10.mpg |
And 'should not' see for order item at Add media to your order form following files retrieved from project 'OTVMUFPP2' folder '/OTVMUFPF2':
| Name             |
| GWGTest2.pdf     |
| audio02.mp3      |
| logo3.jpg        |
| index.html       |
| BDDStandards.doc |

Scenario: Check that files are searchable by Clock Number within projects
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA3 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU3 | agency.admin | OTVMUFPA3    |
And logged in with details of 'OTVMUFPU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN3   |
And created 'OTVMUFPP3' project
And created '/OTVMUFPF3' folder for project 'OTVMUFPP3'
And uploaded into project 'OTVMUFPP3' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /OTVMUFPF3 |
| /files/Fish2-Ad.mov  | /OTVMUFPF3 |
And waited while transcoding is finished in folder '/OTVMUFPF3' on project 'OTVMUFPP3' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OTVMUFPF3' project 'OTVMUFPP3'
When I 'save' file info by next information:
| FieldName    | FieldValue      |
| Clock number | ABook\and/clock |
And open order item with following clock number 'OTVMUFPCN3'
And retrieve files from projects for order item at Add media to your order form
And open project 'OTVMUFPP3' at Add media to your order form for retrieving folders and files
And fill Search field by value 'ABook\and/cl' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish1-Ad.mov |
And 'should not' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish2-Ad.mov |

Scenario: Check that files are searchable by Advertiser within projects
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA3 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU3 | agency.admin | OTVMUFPA3    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMUFPA3':
| Advertiser      |
| ABookAR4 AR new |
And logged in with details of 'OTVMUFPU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN4   |
And created 'OTVMUFPP3' project
And created '/OTVMUFPF3' folder for project 'OTVMUFPP3'
And uploaded into project 'OTVMUFPP3' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /OTVMUFPF3 |
| /files/Fish2-Ad.mov  | /OTVMUFPF3 |
And waited while transcoding is finished in folder '/OTVMUFPF3' on project 'OTVMUFPP3' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OTVMUFPF3' project 'OTVMUFPP3'
When I 'save' file info by next information:
| FieldName    | FieldValue      |
| Advertiser   | ABookAR4 AR new |
| Clock number | FileCN4         |
And open order item with following clock number 'OTVMUFPCN4'
And retrieve files from projects for order item at Add media to your order form
And open project 'OTVMUFPP3' at Add media to your order form for retrieving folders and files
And fill Search field by value 'ABookAR4 AR' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish1-Ad.mov |
And 'should not' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish2-Ad.mov |

Scenario: Check that files are searchable by Product within projects
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA3 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU3 | agency.admin | OTVMUFPA3    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMUFPA3':
| Advertiser | Brand      | Sub Brand  | Product  |
| OTVMUFPAR5 | OTVMUFPBR5 | OTVMUFPSB5 | ABookPR5 |
And logged in with details of 'OTVMUFPU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN5   |
And created 'OTVMUFPP3' project
And created '/OTVMUFPF3' folder for project 'OTVMUFPP3'
And uploaded into project 'OTVMUFPP3' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /OTVMUFPF3 |
| /files/Fish2-Ad.mov  | /OTVMUFPF3 |
And waited while transcoding is finished in folder '/OTVMUFPF3' on project 'OTVMUFPP3' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OTVMUFPF3' project 'OTVMUFPP3'
When I 'save' file info by next information:
| FieldName    | FieldValue |
| Advertiser   | OTVMUFPAR5 |
| Brand        | OTVMUFPBR5 |
| Sub Brand    | OTVMUFPSB5 |
| Product      | ABookPR5   |
| Clock number | FileCN5    |
And open order item with following clock number 'OTVMUFPCN5'
And retrieve files from projects for order item at Add media to your order form
And open project 'OTVMUFPP3' at Add media to your order form for retrieving folders and files
And fill Search field by value 'abook' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish1-Ad.mov |
And 'should not' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish2-Ad.mov |

Scenario: Check that files are searchable by Title within projects
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA6 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU6 | agency.admin | OTVMUFPA6    |
And logged in with details of 'OTVMUFPU6'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN6   |
And created 'OTVMUFPP6' project
And created '/OTVMUFPF6' folder for project 'OTVMUFPP6'
And uploaded into project 'OTVMUFPP6' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /OTVMUFPF6 |
| /files/Fish2-Ad.mov  | /OTVMUFPF6 |
And waited while transcoding is finished in folder '/OTVMUFPF6' on project 'OTVMUFPP6' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OTVMUFPF6' project 'OTVMUFPP6'
When I 'save' file info by next information:
| FieldName    | FieldValue       |
| Title        | ABook'and"/title |
| Clock number | FileCN6          |
And open order item with following clock number 'OTVMUFPCN6'
And retrieve files from projects for order item at Add media to your order form
And open project 'OTVMUFPP6' at Add media to your order form for retrieving folders and files
And fill Search field by value 'ABook'and"/t' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following files retrieved from project:
| Name             |
| ABook'and"/title |
And 'should not' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish2-Ad.mov |

Scenario: Check that assets are searchable by FileName of files within Projects after changing Title
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA7 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU7 | agency.admin | OTVMUFPA7    |
And logged in with details of 'OTVMUFPU7'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN7   |
And created 'OTVMUFPP7' project
And created '/OTVMUFPF7' folder for project 'OTVMUFPP7'
And uploaded into project 'OTVMUFPP7' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /OTVMUFPF7 |
| /files/Fish2-Ad.mov  | /OTVMUFPF7 |
And waited while transcoding is finished in folder '/OTVMUFPF7' on project 'OTVMUFPP7' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OTVMUFPF7' project 'OTVMUFPP7'
When I 'save' file info by next information:
| FieldName    | FieldValue    |
| Title        | f1-video.Nike |
| Clock number | FileCN7       |
And open order item with following clock number 'OTVMUFPCN7'
And retrieve files from projects for order item at Add media to your order form
And open project 'OTVMUFPP7' at Add media to your order form for retrieving folders and files
And fill Search field by value 'Fish1-Ad.mov' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following files retrieved from project:
| Name          |
| f1-video.Nike |
And 'should not' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish2-Ad.mov |

Scenario: Check that search doesn't works through projects
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA8 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU8 | agency.admin | OTVMUFPA8    |
And logged in with details of 'OTVMUFPU8'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN8   |
And created 'OTVMUFPP8' project
And created '/OTVMUFPF8/OTVMUFPSF8' folder for project 'OTVMUFPP8'
And uploaded into project 'OTVMUFPP8' following files:
| FileName             | Path                  |
| /files/Fish1-Ad.mov  | /OTVMUFPF8/OTVMUFPSF8 |
And waited while transcoding is finished in folder '/OTVMUFPF8/OTVMUFPSF8' on project 'OTVMUFPP8' files page
When I open order item with following clock number 'OTVMUFPCN8'
And retrieve files from projects for order item at Add media to your order form
And fill Search field by value 'Fish1-Ad.mov' for Add media to your order form on order item page
Then I 'should not' see for order item at Add media to your order form following files retrieved from project:
| Name         |
| Fish1-Ad.mov |

Scenario: Check that correct data is showed on file’s thumbnail in case to retrieve from project
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA9 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU9 | agency.admin | OTVMUFPA9    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMUFPA9':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMUFPAR9 | OTVMUFPBR9 | OTVMUFPSB9 | OTVMUFLPR9 |
And logged in with details of 'OTVMUFPU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN9   |
And created 'OTVMUFPP9' project
And created '/OTVMUFPF9' folder for project 'OTVMUFPP9'
And uploaded into project 'OTVMUFPP9' following files:
| FileName                   | Path       |
| /files/13DV-CAPITAL-10.mpg | /OTVMUFPF9 |
And waited while transcoding is finished in folder '/OTVMUFPF9' on project 'OTVMUFPP9' files page
And I am on file '13DV-CAPITAL-10.mpg' info page in folder '/OTVMUFPF9' project 'OTVMUFPP9'
When I 'save' file info by next information:
| FieldName    | FieldValue    |
| Title        | OTVMUFPT9.mpg |
| Advertiser   | OTVMUFPAR9    |
| Brand        | OTVMUFPBR9    |
| Sub Brand    | OTVMUFPSB9    |
| Product      | OTVMUFLPR9    |
| Clock number | FileCN9       |
And open order item with following clock number 'OTVMUFPCN9'
And retrieve files from projects for order item at Add media to your order form
And open project 'OTVMUFPP9' at Add media to your order form for retrieving folders and files
And fill Search field by value '13DV-CAPITAL-10.mpg' for Add media to your order form on order item page
Then I should see for 'tv' order item at Add media to your order form following files metadata:
| Title         | Clock Number | Format | Aspect Ratio | Clock Number Label |
| OTVMUFPT9.mpg | FileCN9      | MPEG   | 16:9         | Clock number            |


Scenario: Check that file’s metadata is transferred to active order item under Add Information section
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFPA9 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMUFPU9 | agency.admin | OTVMUFPA9    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMUFPA9':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMUFPAR9 | OTVMUFPBR9 | OTVMUFPSB9 | OTVMUFLPR9 |
And logged in with details of 'OTVMUFPU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN10  |
And created 'OTVMUFPP9' project
And created '/OTVMUFPF9' folder for project 'OTVMUFPP9'
And uploaded into project 'OTVMUFPP9' following files:
| FileName                   | Path       |
| /files/13DV-CAPITAL-10.mpg | /OTVMUFPF9 |
And waited while transcoding is finished in folder '/OTVMUFPF9' on project 'OTVMUFPP9' files page
And I am on file '13DV-CAPITAL-10.mpg' info page in folder '/OTVMUFPF9' project 'OTVMUFPP9'
When I 'save' file info by next information:
| FieldName    | FieldValue       |
| Title        | !@#\$%^.&*()_+;' |
| Advertiser   | OTVMUFPAR9       |
| Brand        | OTVMUFPBR9       |
| Sub Brand    | OTVMUFPSB9       |
| Product      | OTVMUFLPR9       |
| Clock number | !@#\$%^.&*()_+;' |
| Duration     | 8s               |
And open order item with following clock number 'OTVMUFPCN10'
And add to order for order item at Add media to your order form following files '!@#\$%^.&*()_+;'' from folder '/OTVMUFPF9' of project 'OTVMUFPP9'
Then I should see following data for order item on Add information form:
| Advertiser | Clock Number     | Duration | Product    | Title           |
| OTVMUFPAR9 | !@#\$%^.&*()_+;' | 8s       | OTVMUFLPR9 | !@#\$%^.&*()_+;'|

Scenario: Check that file’s metadata is transferred to active order item in cover flow
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMUFPA11 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique  |
| OTVMUFPU11 | agency.admin | OTVMUFPA11    |
And logged in with details of 'OTVMUFPU11'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN11  |
And created 'OTVMUFPP11' project
And created '/OTVMUFPF11' folder for project 'OTVMUFPP11'
And uploaded into project 'OTVMUFPP11' following files:
| FileName            | Path        |
| /files/Fish1-Ad.mov | /OTVMUFPF11 |
And waited while transcoding is finished in folder '/OTVMUFPF11' on project 'OTVMUFPP11' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OTVMUFPF11' project 'OTVMUFPP11'
When I 'save' file info by next information:
| FieldName    | FieldValue       |
| Title        | !@#\$%^.&*()_+;' |
| Clock number | !@#\$%^.&*()_+;' |
| Duration     | 8s               |
And open order item with following clock number 'OTVMUFPCN11'
And add to order for order item at Add media to your order form following files '!@#\$%^.&*()_+;'' from folder '/OTVMUFPF11' of project 'OTVMUFPP11'
Then I should see for active order item on cover flow following data:
| Title            | Duration | Clock Number     |
| !@#\$%^.&*()_+;' | 8s       | !@#\$%^.&*()_+;' |

Scenario: Check multiple adding files from projects to order
!--ORD-1200
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMUFPA12 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique  |
| OTVMUFPU12 | agency.admin | OTVMUFPA12    |
And logged in with details of 'OTVMUFPU12'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN12  |
And created 'OTVMUFPP12' project
And created '/OTVMUFPF12' folder for project 'OTVMUFPP12'
And uploaded into project 'OTVMUFPP12' following files:
| FileName            | Path        |
| /files/Fish1-Ad.mov | /OTVMUFPF12 |
| /files/Fish2-Ad.mov | /OTVMUFPF12 |
| /files/Fish3-Ad.mov | /OTVMUFPF12 |
And waited while transcoding is finished in folder '/OTVMUFPF12' on project 'OTVMUFPP12' files page
When I open order item with following clock number 'OTVMUFPCN12'
And add to order for order item at Add media to your order form following files 'Fish1-Ad.mov,Fish2-Ad.mov,Fish3-Ad.mov' from folder '/OTVMUFPF12' of project 'OTVMUFPP12'
Then I should see count '3' cover flow order items in carousel
And should see for active order item on cover flow following data:
| Title        | Counter |
| Fish1-Ad.mov | 1 of 3  |

Scenario: Check correct navigation in case to retrieve files from projects
!--ORD-745
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMUFPA12 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique  |
| OTVMUFPU12 | agency.admin | OTVMUFPA12    |
And logged in with details of 'OTVMUFPU12'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And created 'OTVMUFPP13' project
And created '<Path>' folder for project 'OTVMUFPP13'
When I open order item with following clock number '<ClockNumber>'
And retrieve files from projects for order item at Add media to your order form
And open project 'OTVMUFPP13' folder '<Path>' at Add media to your order form for retrieving files
Then I should see following navigation path '<NavigationPath>' in projects folder at Add media to your order form

Examples:
| ClockNumber   | Path                                       | NavigationPath                                                |
| OTVMUFPCN13_1 | /OTVMUFPF13_1/OTVMUFPSF13_1                | Projects>OTVMUFPP13>OTVMUFPF13_1>OTVMUFPSF13_1                |
| OTVMUFPCN13_2 | /OTVMUFPF13_2/OTVMUFPSF13_2/OTVMUFPCSF13_2 | Projects>OTVMUFPP13>OTVMUFPF13_2>OTVMUFPSF13_2>OTVMUFPCSF13_2 |

Scenario: Search within projects titles
!--ORD-1258
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMUFPA12 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique  |
| OTVMUFPU12 | agency.admin | OTVMUFPA12    |
And logged in with details of 'OTVMUFPU12'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And created following projects:
| Name                                |
| Project{}[]                         |
| Project test                        |
| Project{}#~!@:.;,=<>\"'?%$&^+/_-*№ |
| AnotherNewProject                   |
When I open order item with following clock number '<ClockNumber>'
And retrieve files from projects for order item at Add media to your order form
And fill Search field by value '<SearchFilter>' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following projects:
| Name        |
| <NameFound> |
And 'should not' see for order item at Add media to your order form following projects:
| Name           |
| <NameNotFound> |

Examples:
| ClockNumber   | SearchFilter                        | NameFound                                                          | NameNotFound                                                            |
| OTVMUFPCN14_1 | Project                             | Project{}[], Project test, Project{}#~!@:.;,=<>\\\\"'?%\$&^+/_-*№ | AnotherNewProject                                                       |
| OTVMUFPCN14_2 | Project{}                           | Project{}[], Project{}#~!@:.;,=<>\\\\"'?%\$&^+/_-*№               | AnotherNewProject, Project test                                         |
| OTVMUFPCN14_3 | Project t                           | Project test                                                       | AnotherNewProject, Project{}[], Project{}#~!@:.;,=<>\\\\"'?%\$&^+/_-*№ |
| OTVMUFPCN14_4 | Project{}#~!@:.;,=<>\"'?%$&^+/_-*№ | Project{}#~!@:.;,=<>\\\\"'?%\$&^+/_-*№                            | AnotherNewProject, Project{}[], Project test                            |

Scenario: Search within projects titles (negative)
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMUFPA15 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique  |
| OTVMUFPU15 | agency.admin | OTVMUFPA15    |
And logged in with details of 'OTVMUFPU15'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFPCN15  |
And created following projects:
| Name       |
| ProjectNew |
When I open order item with following clock number 'OTVMUFPCN15'
And retrieve files from projects for order item at Add media to your order form
And fill Search field by value 'test' for Add media to your order form on order item page
Then I 'should not' see for order item at Add media to your order form following projects:
| Name       |
| ProjectNew |