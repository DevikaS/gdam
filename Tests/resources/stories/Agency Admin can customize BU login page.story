Feature:          Agency Admin can customize BU login page
Narrative:
In order to
As a              AgencyAdmin
I want to         Branding login page settings

Scenario: Check default values for login page
Meta:@gdam
     @projects
Given I am on Admin Branding login page
Then I should see following elements on the system admin branding login page:
| Element               | State  |
| BackgroundColorInput  | should |
| BackgroundColorButton | should |
| FooterColourInput     | should |
| FooterColourButton    | should |
| BackgroundImage       | should |
| Logo                  | should |
| ButtonColourInput     | should |
| ButtonColourButton    | should |
| TextColourInput       | should |
| TextColourButton      | should |
| LinkColourInput       | should |
| LinkColourButton      | should |
| Save                  | should |


Scenario: logo images are appear at preview after upload
Meta:@gdam
     @projects
Given I am on Admin Branding login page
When I upload logo '/images/logo.gif' on admin branding login page
Then I 'should not' see that logo on the system branding login page is default


Scenario: Unsuccessfully uploading logo for custom login page
Meta:@gdam
     @projects
Given I am on Admin Branding login page
When I upload logo '/files/GWGTestfile064v3.pdf' on admin branding login page
Then I should see alert text is 'GWGTestfile064v3.pdf has invalid extension. Only gif, jpg, jpeg, png are allowed.'


Scenario: Check successful remove logo
Meta:@gdam
     @projects
Given I am on Admin Branding login page
When I upload logo '/images/SB_Logo.png' on admin branding login page
And remove 'logo' from the system branding login page
Then I 'should' see that logo on the system branding login page is default


Scenario: Check that notification appears after click on 'Save'
Meta:@gdam
     @projects
Given I am on Admin Branding login page
And waited for '3' seconds
When I set Button Colour '#4422e3' Link Colour '#0082dc'  Text Colour '#000000' on admin branding login page
And I uploaded logo '/images/SB_Logo.png' and set Footer Colour '#2d77a8' on admin branding login page
And I type Welcome Message 'bla-bla-bla'
And I click save on the custom login page
And logout from account
Then I 'should' see element 'ButtonColour' has value 'rgb(68, 34, 227)' on login page
And I 'should' see element 'LinkColour' has value 'rgb(0, 130, 220)' on login page
And I 'should' see element 'TextColour' has value 'rgb(0, 0, 0)' on login page
And I 'should' see element 'FooterColour' has value 'rgb(45, 119, 168)' on login page
And I 'should' see element 'WelcomeMessage' has value 'bla-bla-bla' on login page
And I 'should' see custom logo on login page


Scenario: check that logo not appear after delete
Meta:@gdam
     @projects
Given I created the agency 'A_AACCBULP_S07' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |
| U_AACCBULP_S07 | agency.admin | A_AACCBULP_S07 |
And logged in with details of 'U_AACCBULP_S07'
And on Admin Branding login page
When I uploaded logo '/images/SB_Logo.png' and set Footer Colour '#5a3c5a' on admin branding login page
And uploaded Background Image '/images/bg_img.jpg' and set Background Colour '#3a2d2d'
And remove 'logo' from the system branding login page
And remove 'background' from the system branding login page
And click save on the custom login page
And logout from account
Then I 'should' see default 'logo' on login page
And 'should' see default 'background' on login page


Scenario: check that logo  appear after upload
Meta:@gdam
     @projects
Given I created the agency 'A_AACCBULP_S08' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |
| U_AACCBULP_S08 | agency.admin | A_AACCBULP_S08 |
And logged in with details of 'U_AACCBULP_S08'
And on Admin Branding login page
When I uploaded logo '/images/SB_Logo.png' and set Footer Colour '#5a3c5a' on admin branding login page
And uploaded Background Image '/images/bg_img.jpg' and set Background Colour '#3a2d2d'
And click save on the custom login page
And logout from account
Then I 'should' see custom logo on login page
And 'should' see custom background on login page