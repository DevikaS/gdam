!--ORD-305
!--ORD-1667
!--ORD-1746
!--NGN-16191
Feature: Physical Media and FTP Type requests
Narrative:
In order to:
As a AgencyAdmin
I want to check Physical Media and FTP Type requests functionality

Scenario: Contents Add Media section for different actions
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMNMCN1    |
When I open order item with following clock number 'OTVMNMCN1'
And open New Master for order item on Add media form
And retrieve assets from library for order item at Add media to your order form
Then I should see 'inactive' New master button for order item on Add media form

Scenario: check New Master content
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for New Master of order item that supply via '<UploadRequestType>' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |
Then I should see following data on New Master form for order item that supply via '<UploadRequestType>':
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |

Examples:
| ClockNumber | UploadRequestType |
| OTVMNMCN3_1 | FTP               |
| OTVMNMCN3_2 | Physical          |

Scenario: check New Master content when you use Copy current
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMNMCN4    |
And add for 'tv' order to item with clock number 'OTVMNMCN4' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | OTVMNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'OTVMNMCN4'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data on New Master form for order item that supply via 'FTP':
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |

Scenario: check New Master content when you use create New
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OTVMNMCN5 |
And add for 'music' order to item with isrc code 'OTVMNMCN5' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | OTVMNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following isrc code 'OTVMNMCN5'
And 'create new' order item by Add Commercial button on order item page
And select order item with following isrc code 'OTVMNMCN5' on cover flow
Then I should see following data on New Master form for order item that supply via 'FTP':
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |

Scenario: check showing email adress on the coverflow
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMNMCN6    |
And add for 'tv' order to item with clock number 'OTVMNMCN6' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | OTVMNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'OTVMNMCN6'
Then I should see for active order item on cover flow following data:
| Media Request                 |
| Media requested from OTVMNMU1 |

Scenario: check New Master content when you use Copy to all
!--ORD-1747
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMNMCN7_1  |
| OTVMNMCN7_2  |
And add for 'tv' order to item with clock number 'OTVMNMCN7_1' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | OTVMNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'OTVMNMCN7_1'
And copy data from 'Add media' section of order item page to all other items
And select order item with following clock number 'OTVMNMCN7_2' on cover flow
Then I should see following data on New Master form for order item that supply via 'FTP':
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |

Scenario: check New Master content when you use Save as Draft
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMNMCN8    |
When I open order item with following clock number 'OTVMNMCN8'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |
And save as draft order
And open order item with following clock number 'OTVMNMCN8'
Then I should see following data on New Master form for order item that supply via 'Physical':
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |

Scenario: check New Master content of several items when you use Save as Draft
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
| OTVMNMU2 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMNMCN9_1  |
| OTVMNMCN9_2  |
When I open order item with following clock number 'OTVMNMCN9_1'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| OTVMNMU1 | should not       | automated test | 12/14/2022    |
And select order item with following clock number 'OTVMNMCN9_2' on cover flow
And fill following fields for New Master of order item that supply via '' on Add media form:
| Assignee | Already Supplied |
| OTVMNMU2 | should           |
And save as draft order
And open order item with following clock number 'OTVMNMCN9_1'
Then I should see for active order item on cover flow following data:
| Media Request                 |
| Media requested from OTVMNMU1 |
And should see for order item with clock number 'OTVMNMCN9_2' on cover flow following data:
| Media Request              |
| Media supplied by OTVMNMU2 |

Scenario: check New Master content when update its data
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
| OTVMNMU2 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMNMCN10   |
And add for 'tv' order to item with clock number 'OTVMNMCN10' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | OTVMNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'OTVMNMCN10'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee | Already Supplied | Message            | Deadline Date |
| OTVMNMU2 | should not       | automated test new | 12/14/2024    |
Then I should see following data on New Master form for order item that supply via 'Physical':
| Assignee | Already Supplied | Message            | Deadline Date |
| OTVMNMU2 | should not       | automated test new | 12/14/2024    |

Scenario: check validation for Assignee field
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for New Master of order item that supply via '<UploadRequestType>' on Add media form:
| Assignee   | Message        |
| <Assignee> | automated test |
Then I 'should' see validation error for following fields 'Assignee' of New Master for order item on Add media form

Examples:
| ClockNumber  | UploadRequestType | Assignee      |
| OTVMNMCN11_1 | FTP               | 123@          |
| OTVMNMCN11_2 | Physical          | test@         |
| OTVMNMCN11_3 | FTP               | test@com      |
| OTVMNMCN11_4 | Physical          | test@com.     |
| OTVMNMCN11_5 | FTP               | test@com. com |

Scenario: check media transfer confirmation email for New Master
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | OTVMNMA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMNMA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVMNMAR12 | OTVMNMBR12 | OTVMNMSB12 | OTVMNMP12 |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVMNMAR12 | OTVMNMBR12 | OTVMNMSB12 | OTVMNMP12 | OTVMNMC12 | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | OTVMNMT12 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number '<ClockNumber>' a New Master with following fields:
| Supply Via          | Assignee    | Already Supplied | Message        | Deadline Date |
| <UploadRequestType> | <UserEmail> | should not       | automated test | 02/14/2023    |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number  |
| OTVMNMJN12 | OTVMNMPN12 |
And I am on View Live Orders tab of 'tv' order on ordering page
Then I should see TV 'live' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVMNMAR12 | United Kingdom | OTVMNMPN12 | OTVMNMJN12 | 1        | 0/1 Delivered |
And 'should' see email notification for 'Media Transfer Request' with field to '<UserEmail>' and subject 'Media Transfer Request' contains following attributes:
| Agency   | Account Type | UserEmail   | Deadline Date | Clock Number  | Advertiser | Product   | Title     | Duration | Format         | Message        |
| OTVMNMA1 | adstream     | <UserEmail> | 02/14/2023    | <ClockNumber> | OTVMNMAR12 | OTVMNMP12 | OTVMNMT12 | 20       | HD 1080i 25fps | automated test |

Examples:
| ClockNumber  | UploadRequestType | UserEmail |
| OTVMNMCN12_1 | FTP               | OTVMNMU1  |
| OTVMNMCN12_2 | Physical          | OTVMNMU2  |

Scenario: check that media transfer confirmation email is not sent for New Master when use Already supplied
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMNMU13 | agency.admin | OTVMNMA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMNMA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVMNMAR12 | OTVMNMBR12 | OTVMNMSB12 | OTVMNMP12 |
And logged in with details of 'OTVMNMU13'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVMNMAR12 | OTVMNMBR12 | OTVMNMSB12 | OTVMNMP12 | OTVMNMC13 | OTVMNMCN13   | 20       | 12/14/2022     | HD 1080i 25fps | OTVMNMT13 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'OTVMNMCN13' a New Master with following fields:
| Assignee  | Already Supplied |
| OTVMNMU13 | should           |
And complete order contains item with clock number 'OTVMNMCN13' with following fields:
| Job Number | PO Number  |
| OTVMNMJN13 | OTVMNMPN13 |
And I am on View Live Orders tab of 'tv' order on ordering page
Then I should see TV 'live' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVMNMAR12 | United Kingdom | OTVMNMPN13 | OTVMNMJN13 | 1        | 0/1 Delivered |
And 'should not' see email notification for 'Media Transfer Request' with field to 'OTVMNMU13' and subject 'Media Transfer Request' contains following attributes:
| UserEmail |
| OTVMNMU13 |

Scenario: check New Master content for Beam agency
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVMNMA14 | Beam   | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVMNMU14_1 | agency.admin | OTVMNMA14    |
And logged in with details of 'OTVMNMU14_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVBTVSCN14  |
When I open order item with following clock number 'OTVBTVSCN14'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee    | Post House  | Already Supplied | Message        | Deadline Date | Arrival Time |
| OTVMNMU14_2 | OTVMNMU14_1 | should not       | automated test | 12/14/2024    | 20:00        |
Then I should see following data on New Master form for order item that supply via 'FTP':
| Assignee    | Post House  | Already Supplied | Message        | Deadline Date | Arrival Time |
| OTVMNMU14_2 | OTVMNMU14_1 | should not       | automated test | 12/14/2024    | 20:00        |

Scenario: check media transfer confirmation email for order with New Master for Beam agency
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVMNMA15 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique | Language |
| OTVMNMU15 | agency.admin | OTVMNMA15    | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMNMA15':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVMNMAR15 | OTVMNMBR15 | OTVMNMSB15 | OTVMNMP15 |
And logged in with details of 'OTVMNMU15'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVMNMAR15 | OTVMNMBR15 | OTVMNMSB15 | OTVMNMP15 | OTVMNMC15 | OTVMNMCN15   | 20       | 12/14/2022     | HD 1080i 25fps | OTVMNMT15 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'OTVMNMCN15' a New Master with following fields:
| Supply Via | Post House | Assignee  | Already Supplied | Message        | Deadline Date |
| FTP        | OTVMNMU15  | OTVMNMU15 | should not       | automated test | 02/14/2023    |
And complete order contains item with clock number 'OTVMNMCN15' with following fields:
| Job Number | PO Number  |
| OTVMNMJN15 | OTVMNMPN15 |
And I am on View Live Orders tab of 'tv' order on ordering page
Then I should see TV 'live' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVMNMAR15 | United Kingdom | OTVMNMPN15 | OTVMNMJN15 | 1        | 0/1 Delivered |
And 'should' see email notification for 'Media Transfer Request' with field to 'OTVMNMU15' and subject 'Media Transfer Request' contains following attributes:
| Agency    | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product   | Title     | Duration | Format         | Message        |
| OTVMNMA15 | beam         | OTVMNMU15 | 02/14/2023    | OTVMNMCN15   | OTVMNMAR15 | OTVMNMP15 | OTVMNMT15 | 20       | HD 1080i 25fps | automated test |

Scenario: check New Master content after updated its data by Already Supplied
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMNMCN16   |
And add for 'tv' order to item with clock number 'OTVMNMCN16' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | OTVMNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'OTVMNMCN16'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee | Already Supplied |
| OTVMNMU1 | should           |
Then I should see following data on New Master form for order item that supply via '':
| Assignee | Already Supplied | Message | Deadline Date |
| OTVMNMU1 | should           |         |               |

Scenario: check New Master content after updated its data by Already Supplied and then Copy current
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU1 | agency.admin | OTVMNMA1     |
And logged in with details of 'OTVMNMU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMNMCN17   |
And add for 'tv' order to item with clock number 'OTVMNMCN17' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | OTVMNMU1 | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'OTVMNMCN17'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee | Already Supplied |
| OTVMNMU1 | should           |
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data on New Master form for order item that supply via '':
| Assignee | Already Supplied | Message | Deadline Date |
| OTVMNMU1 | should           |         |               |

Scenario: check that order confirmation email is sent for New Master with Already supplied for Beam agency
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVMNMA15 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique | Language |
| OTVMNMU15 | agency.admin | OTVMNMA15    | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMNMA15':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVMNMAR15 | OTVMNMBR15 | OTVMNMSB15 | OTVMNMP15 |
And logged in with details of 'OTVMNMU15'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVMNMAR15 | OTVMNMBR15 | OTVMNMSB15 | OTVMNMP15 | OTVMNMC18 | OTVMNMCN18   | 20       | 12/14/2022     | HD 1080i 25fps | OTVMNMT18 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'OTVMNMCN18' a New Master with following fields:
| Assignee  | Already Supplied |
| OTVMNMU15 | should           |
And complete order contains item with clock number 'OTVMNMCN18' with following fields:
| Job Number | PO Number  |
| OTVMNMJN18 | OTVMNMPN18 |
Then I 'should' see email notification for 'Order Confirmation' with field to 'OTVMNMU15' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName  | Clock Number | Job Number | PO Number  | Order Items Count | Commercial Number | Country        | Spot Code  | Advertiser | Brand      | Sub Brand  | Product   | Title     | Duration | Format         | Delivery Method  | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive | Note                | Attachments | Subtitles Required | Destination Group | Destination         | Service Level |
| beam         | OTVMNMU15 | OTVMNMCN18   | OTVMNMJN18 | OTVMNMPN18 | 1                 | 1                 | United Kingdom | OTVMNMCN18 | OTVMNMAR15 | OTVMNMBR15 | OTVMNMSB15 | OTVMNMP15 | OTVMNMT18 | 20       | HD 1080i 25fps | Already Supplied |               |              |                | 12/14/2022     | Yes     | automated test info |             | Already Supplied   | BSkyB             | BSkyB Green Button  | Standard      |


Scenario: Check mandatory validation for Media Supply field when FTP or Physical media or Sendplus is chosen and Media Supplier field is set to true in BU settings
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA19 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU19 | agency.admin | OTVMNMA19    |
And logged in with details of 'GlobalAdmin'
And I updated agency 'OTVMNMA19' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Media Supplier | true       |
And logged in with details of 'OTVMNMU19'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for New Master of order item that supply via '<UploadRequestType>' on Add media form:
 | Message        |
 | automated test |
Then I 'should' see mandatory validation for following fields 'Assignee' of New Master for order item on Add media form

Examples:
| ClockNumber  | UploadRequestType |
| OTVMNMCN19_1 | FTP               |
| OTVMNMCN19_2 | Physical          |
| OTVMNMCN19_3 | nVerge            |


Scenario: Check mandatory validation for Media Supply field when FTP or Physical media or Sendplus is chosen and Media Supplier field is set to false in BU settings
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMNMA20 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMNMU20 | agency.admin | OTVMNMA20     |
And logged in with details of 'OTVMNMU20'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for New Master of order item that supply via '<UploadRequestType>' on Add media form:
 | Message        |
 | automated test |
Then I 'should not' see mandatory validation for following fields 'Assignee' of New Master for order item on Add media form

Examples:
| ClockNumber  | UploadRequestType |
| OTVMNMCN20_1 | FTP               |
| OTVMNMCN20_2 | Physical          |
| OTVMNMCN20_3 | nVerge            |
