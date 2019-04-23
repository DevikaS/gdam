!--ORD-5147
Scenario: Mail Templates. Cannot add the text with arguments to the confirmation email
!--ORD-5148
Scenario:  Fields, created in the Custome common Metadata for BU are not displayed in the email
!--ORD-5143
Scenario:  In the body-viewer is missed added new fields from Common Ordering metadata section
!--ORD-5146
Scenario: Body for FTP email shows with empty fields: Media Agency, Creative Agency, Posthouse, Spotgate Code, Motivenumber
Given I loged in as Global admin
And choose next <Markets> in the 'Common Ordering Metadata':
| Markets   |
| <Markets> |
And add to the new custom fields:
| Media Agency | Creative Agency | Posthouse | Spotgate Code | Motivenumber | Custome date test | Custom Code | Megatime Code | Drop field | Radio field | String field | Data picker field | Catalog field |
| Media Agency | Creative Agency | Posthouse | Spotgate Code | Motivenumber | Custome date test | Custom Code | Megatime Code | drop       | radio       | String field | Data picker | Catalog field |
And click on the 'Mail templates' Tab
And choose the next fields:
| BU            | Activity   | Language |
| KievTest 4 0 5| <Activity> | English  |
And click on the button 'Edit Template'
And edit to the 'Body' the following text:
|Text |
|<br>
Agency Physical:<br/><br/>
test :@MarketMetadata("String field")<br/><br/>
radio: @MarketMetadata("Radio field")<br/><br/>
catalog: @MarketMetadata("Catalog field")<br/><br/>
drop: @MarketMetadata("Drop field")<br/><br/>
date test: @MarketMetadata("Data picker field")<br/><br/>
Megatime code : @MarketMetadata("Megatime Code")<br/><br/>
Media agency: @MarketMetadata("Media Agency")<br/><br/>
Creative agency: @MarketMetadata("Creative Agency")<br/><br/>
Post House: @MarketMetadata("Posthouse")<br/><br/>
cust code: @MarketMetadata("cust code")<br/><br/>
Spotgate Code : @MarketMetadata("Spotgate Code")<br/><br/>
Motivenumber: @MarketMetadata("Motivenumber")<br/><br/> |
And create an order by norway@qa.com (Kiev Test 4 0 5) with the following market:
| Markets |
|<Markets>|
And choose the following <Activity> in the 'Add Media' section:
| Activity   |
| <Activity> |
And confirm the order
When I open the mailbox
Then I should see all filled fields in the email template:
| Media Agency | Creative Agency | Posthouse | Spotgate Code | Motivenumber | Custome date test | Custom Code | Megatime Code | Drop field | Radio field | String field | Data picker field | Catalog field |
| Media Agency | Creative Agency | Posthouse | Spotgate Code | Motivenumber | Custome date test | Custom Code | Megatime Code | drop       | radio       | String field | Data picker | Catalog field |

Example:
|<Markets>| <Activity>
|Finland  | order_media_ftp_upload_reminder        |
|Germany  | order_media_ftp_upload_requested       |
          | order_media_nverge_upload_reminder     |
          | order_media_nverge_upload_requested    |
          | order_media_physical_upload_reminder   |
          | order_media_physical_upload_requested  |
          | order_completed activity               |

