!--NGN-19004
Feature:          Watermarking Upload and Download
Narrative:
In order to
As a              AgencyAdmin
I want to         enable watermarking upload and download

Scenario: Check that watermarking preview is generated on admin page
Meta:@gdam
     @globaladmin
Given I created the agency 'AAWAA1' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_AAW_01 | agency.admin | AAWAA1   |
| U_AAW_02 | agency.user | AAWAA1   |
And logged in with details of 'U_AAW_01'
And I am on WaterMarking Management page
When I fill following fields for watermark upload:
|Logo|Logo Position|Logo Opacity|Watermark Text|Watermark Text Position|Watermark Text Opacity|
|PNG|top-right|100|Verify upload text|centre|100|
And I fill following fields for watermark download:
|Watermark Text|Watermark Text Font|
|<username>|15|
And I click on save button
And I refresh the page
Then I should see watermark preview on watermarking page





