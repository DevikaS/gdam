!--ORD-3657
!--ORD-3911
!--ORD-3976
!--ORD-3977
!--ORD-3949
!--ORD-4049
!--ORD-4044
!--ORD-4060
Feature: Metadata editor for TV Broadcaster or TV Broadcaster HUB BU
Narrative:
In order to:
As a GlobalAdmin
I want to check a correct working of metadata editor for TV Broadcaster or TV Broadcaster HUB BU

Scenario: Check showing market for selected BU in Trafic Metadata Editor
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | AgencyType     | Market         | DestinationIDUnique |
| MEFTVBA1 | DefaultA4User | TV Broadcaster | United Kingdom | 494                 |
And I am on the global 'common traffic' metadata page for agency 'MEFTVBA1'
Then I should see 'disabled' Market on common traffic metadata page
And should see following market 'United Kingdom' on common traffic metadata page

Scenario: Check saving checkboxes Display this field on your table view and Display this field on your detailed view in Trafic Metadata Editor
!--ORD-4974
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | AgencyType     | Market         | DestinationIDUnique |
| MEFTVBA1 | DefaultA4User | TV Broadcaster | United Kingdom | 494                 |
And I am on the global 'common traffic' metadata page for agency 'MEFTVBA1'
And clicked '<Metadata>' button in 'editable metadata' section on opened metadata page
When I uncheck 'Display this field on your table view,Display this field on your detailed view' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click '<Metadata>' button in 'editable metadata' section on opened metadata page
Then I 'should not' see checked checkbox 'Display this field on your table view,Display this field on your detailed view' on opened string field Settings and Customization page

Examples:
| Metadata           |
| Market             |
| Posthouse          |
| Creative Agency    |
| Media Agency       |
| Subtitles Required |

Scenario: Check showing markets specific metadata fields in Trafic Metadata Editor
!--ORD-3914,ORD-4174
!--02/11 confirmed with Maria that "ARPP is not a part of our custom schema. " and Pubid needs to be manually entered else its clock#
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | AgencyType         | Market   |
| <Agency> | DefaultA4User | TV Broadcaster Hub | <Market> |
And I am on the global 'common traffic' metadata page for agency '<Agency>'
Then I 'should' see button '<MetadataFields>' in 'editable metadata' section on opened metadata page

Examples:
| Agency     | Market    | MetadataFields                                                                                                                                            |
| MEFTVBA3_1 | Australia | Clock number,CAD#,Closed Captions Required                                                                                                                     |
| MEFTVBA3_2 | Canada    | Clock number                                                                                                                                                   |
| MEFTVBA3_3 | Sweden    | Clock number,Type Of Commercial                                                                                                                                |
| MEFTVBA3_4 | France    | Clock number,Mentions,Type De Mentions         |
| MEFTVBA3_5 | Brasil    | Market Segment,CRT,CNPJ,Date of Ancine Registration,Director,Number of Versions                                                                           |

Scenario: Check creation Custome Code in Trafic Metadata Editor
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | AgencyType     | Market         | DestinationIDUnique |
| MEFTVBA1 | DefaultA4User | TV Broadcaster | United Kingdom | 494                 |
And I am on the global 'common traffic' metadata page for agency 'MEFTVBA1'
When I click 'Custom Code' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Custom Code Traffic Auto' on opened Settings and Customization tab
And save metadata field settings
Then I 'should' see button 'Custom Code Traffic Auto' in 'editable metadata' section on opened metadata page

Scenario: Check creation Radio Buttons in Trafic Metadata Editor
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | AgencyType     | Market         | DestinationIDUnique |
| MEFTVBA1 | DefaultA4User | TV Broadcaster | United Kingdom | 494                 |
And I am on the global 'common traffic' metadata page for agency 'MEFTVBA1'
When I click 'Radio Buttons' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Radio Buttons Traffic Auto' on opened Settings and Customization tab
And save metadata field settings
And open available metadata page 'Available Metadata'
Then I 'should' see button 'Radio Buttons Traffic Auto' in 'editable metadata' section on opened metadata page

Scenario: Check creation new Custome Code rule in Trafic Metadata Editor
Meta: @ordering
!--NGN-18611 Sequential number unchecked by default
Given I created the following agency:
| Name     | A4User        | AgencyType     | Market         | DestinationIDUnique |
| MEFTVBA6 | DefaultA4User | TV Broadcaster | United Kingdom | 494                 |
And I am on the global 'common traffic' metadata page for agency 'MEFTVBA6'
When I click 'Custom Code' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Custom Code Traffic Auto' on opened Settings and Customization tab
And save metadata field settings
And click 'Custom Code Traffic Auto' button in 'editable metadata' section on opened metadata page
And fill following fields for 'new' custom code on AdCode Manager form of metadata page:
| Code Name | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name      | Metadata Characters | Free Text | Separator |
| MEFTVBCC6 | should | MMDDYYYY    | 4                   | should            | Advertiser,Product | 3,3                 | should    | -         |
And save metadata field settings
And click 'Custom Code Traffic Auto' button in 'editable metadata' section on opened metadata page
Then I should see following data for custom code 'MEFTVBCC6' on AdCode Manager form of metadata page:
| Code Name | Date   | Date Format | Sequence Characters | Metadata Elements | Metadata Name      | Metadata Characters | Free Text | Separator |
| MEFTVBCC6 | should | MMDDYYYY    | 4                   | should            | Advertiser,Product | 3,3                 | should    | -         |

Scenario: Check metadata field description in Trafic Metadata Editor after changing it in Common Ordering Metadata area
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | AgencyType     | Market              | DestinationIDUnique |
| MEFTVBA7 | DefaultA4User | TV Broadcaster | Republic of Ireland | 123                 |
And I am on the global common ordering metadata page of market 'Republic of Ireland' for agency 'MEFTVBA7'
When I click 'Subtitles Required' button in 'editable metadata' section on opened metadata page
And fill Description field with text 'Subtitles Required Auto Test' on opened Settings and Customization tab
And save metadata field settings
And go to the global common traffic metadata page of market 'Republic of Ireland' for agency 'MEFTVBA7'
Then I 'should' see button 'Subtitles Required Auto Test' in 'editable metadata' section on opened metadata page

Scenario: Check showing common market schema in Trafic Metadata Editor
!--ORD-4974
!--NGN-19611 Delivery Date is removed
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MEFTVBA8 | DefaultA4User |
And I am on the global 'common traffic' metadata page for agency 'MEFTVBA8'
When I select following market 'ALL' on the global common traffic metadata page
Then I 'should' see button 'Additional Details,Aspect Ratio,Clock Number,Duration,First Air Date,Format,Title,Market,Posthouse' in 'editable metadata' section on opened metadata page

Scenario: Check saving checkbox Mark as House Number in Trafic Metadata Editor for existing metadata field
!--ORD-4974
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | AgencyType     | Market   | DestinationIDUnique |
| MEFTVBA9 | DefaultA4User | TV Broadcaster | India | 494           |
And I am on the global 'common traffic' metadata page for agency 'MEFTVBA9'
And clicked 'Format' button in 'editable metadata' section on opened metadata page
When I check 'Mark as House Number' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click 'Format' button in 'editable metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Mark as House Number' on opened string field Settings and Customization page

Scenario: Check showing checkbox Mark as House Number in Trafic Metadata Editor for new metadata field
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | AgencyType     | Market   | DestinationIDUnique |
| MEFTVBA9 | DefaultA4User | TV Broadcaster | India    | 494                 |
And I logged in as 'GlobalAdmin'
And I am on the global 'common traffic' metadata page for agency 'MEFTVBA9'
When I click 'String' button in 'custom metadata' section on opened metadata page
Then I 'should not' see checked checkbox 'Mark as House Number' on opened string field Settings and Customization page

Scenario: Check metadata field description in Trafic Metadata Editor on Active Metadata Preview after changing it in Common Ordering Metadata area
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | AgencyType         | Market    |
| MEFTVBA11 | DefaultA4User | TV Broadcaster Hub | Australia |
And I am on the global common ordering metadata page of market 'Australia' for agency 'MEFTVBA11'
When I click 'Closed Captions Required' button in 'editable metadata' section on opened metadata page
And fill Description field with text 'Closed Captions Required Auto Test' on opened Settings and Customization tab
And save metadata field settings
And go to the global common traffic metadata page of market 'Australia' for agency 'MEFTVBA11'
Then I 'should' see field 'Closed Captions Required Auto Test' in Active Metadata Preview block on opened metadata page

Scenario: Check metadata field description in Trafic Metadata Editor on Active Metadata Preview
!--ORD-4974
!--NGN-19611 Delivery Date is removed
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | AgencyType         | Market |
| MEFTVBA12 | DefaultA4User | TV Broadcaster Hub | Spain  |
And I am on the global 'common traffic' metadata page for agency 'MEFTVBA12'
Then I 'should' see field 'Additional Details,Aspect ratio,Clock Number,Duration,First Air Date,Format,Title,Subtitles Required,Language,Clave,Media Agency Contact,Creative Agency Contact,Watermarking Required,Market,Posthouse' in Active Metadata Preview block on opened metadata page

Scenario: Check metadata field in Trafic Metadata Editor on Active Metadata Preview after adding new custom field and then changing it
!--ORD-4158,ORD-4159,ORD-4173
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | AgencyType         | Market |
| MEFTVBA13 | DefaultA4User | TV Broadcaster Hub | India   |
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'India' for agency ''
When I click 'String' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'String Traffic Auto' on opened Settings and Customization tab
And save metadata field settings
And go to the global common traffic metadata page of market 'India' for agency ''
And go to the global common ordering metadata page of market 'India' for agency 'MEFTVBA13'
And click 'String Traffic Auto' button in 'editable metadata' section on opened metadata page
And fill Description field with text 'String Traffic Auto Next' on opened Settings and Customization tab
And save metadata field settings
And go to the global common traffic metadata page of market 'India' for agency ''
And go to the global common ordering metadata page of market 'India' for agency ''
And click 'Date' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Date Traffic Auto' on opened Settings and Customization tab
And save metadata field settings
And go to the global common traffic metadata page of market 'India' for agency ''
And go to the global common ordering metadata page of market 'India' for agency 'MEFTVBA13'
Then I 'should' see button 'String Traffic Auto Next,Date Traffic Auto' in 'editable metadata' section on opened metadata page
And 'should' see field 'String Traffic Auto Next,Date Traffic Auto' in Active Metadata Preview block on opened metadata page
When I go to the global common traffic metadata page of market 'India' for agency 'MEFTVBA13'
Then I 'should' see button 'String Traffic Auto Next,Date Traffic Auto' in 'editable metadata' section on opened metadata page
And 'should' see field 'String Traffic Auto Next,Date Traffic Auto' in Active Metadata Preview block on opened metadata page

Scenario: Check Metatada elements of new Custom Code in Common Ordering Metadata area
!--ORD-4060
Meta: @ordering
Given I am on the global common ordering metadata page of market 'Germany' for agency ''
When I click 'Custom Code' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Custom Code Traffic Auto Test' on opened Settings and Customization tab
And save metadata field settings
And click 'Custom Code Traffic Auto Test' button in 'editable metadata' section on opened metadata page
And create new custom code on AdCode Manager form of metadata page
Then I 'should' see available following metadata names 'Advertiser,Product,Duration,Title' for custom code on AdCode Manager form of metadata page

Scenario: Check Destinations metatada elements visibility in Trafic Metadata Editor in case when BU is not selected
!--ORD-4974
Meta: @ordering
Given I am on the global common traffic metadata page of market 'United Kingdom' for agency ''
Then I 'should not' see button 'Service Level,Destination,Destination Additional Instructions,Station' in 'editable metadata' section on opened metadata page

Scenario: Check Destinations metatada elements visibility in Trafic Metadata Editor in case selecting BU
!--ORD-4974
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | AgencyType     | Market         | DestinationIDUnique |
| MEFTVBA16 | DefaultA4User | TV Broadcaster | United Kingdom | 123                 |
And I am on the global common traffic metadata page of market 'United Kingdom' for agency 'MEFTVBA16'
Then I 'should not' see button 'Service Level,Destination,Destination Additional Instructions,Station' in 'editable metadata' section on opened metadata page

Scenario: Check Destinations metadata elemets checkboxes state in Trafic Metadata Editor
!--ORD-4974
Meta: @ordering
Given I logged in as 'GlobalAdmin'
And on the global common traffic metadata page of market 'United Kingdom' for agency ''
And clicked '<Metadata>' button in 'editable metadata' section on opened metadata page
Then I 'should not' see checked checkbox 'Mark as House Number' on opened string field Settings and Customization page
And 'should' see checked checkbox 'Display this field on your table view,Display this field on your detailed view' on opened string field Settings and Customization page

Examples:
| Metadata        |
| Market          |

Scenario: Check Destinations metadata elemets checkboxes state in Trafic Metadata Editor 1
!--ORD-4974
Meta: @ordering
@skip
!-- NGN-19266
Given I logged in as 'GlobalAdmin'
And on the global common traffic metadata page of market 'United Kingdom' for agency ''
And clicked '<Metadata>' button in 'editable metadata' section on opened metadata page
Then I 'should not' see checked checkbox 'Mark as House Number' on opened string field Settings and Customization page
And 'should' see checked checkbox 'Display this field on your table view,Display this field on your detailed view' on opened string field Settings and Customization page

Examples:
| Metadata        |
| Posthouse       |
| Creative Agency |
| Media Agency    |