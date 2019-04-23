!--NGN-42 NGN-1095
Feature:          Add Administrators to Template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Adding Administrators to Template

Scenario: add template owner by template owner
Meta: @gdam
      @projects
Given I created users with following fields:
| Email | Role       |
| AATU1 | guest.user |
And created 'AAT1' template
And I am on template 'AAT1' settings page
When I edit the following fields for 'AAT1' template:
| Name | Administrators |
| AAT1 | AATU1          |
And click on element 'SaveButton'
And open template 'AAT1' settings page
Then I 'should' see administrator 'AATU1' on template 'AAT1' settings tab
When I login with details of 'AATU1'
And go to template list page
Then I should see 'AAT1' template in template list


Scenario: add template owner by added template administrator
Meta: @gdam
      @projects
Given I created users with following fields:
| Email | Role       |
| AATU2 | guest.user |
And I logged in with details of 'AATU1'
And I am on template 'AAT1' settings page
When I edit the following fields for 'AAT1' template:
| Name | Administrators |
| AAT1 | AATU2          |
And click on element 'SaveButton'
And open template 'AAT1' settings page
Then I 'should' see administrator 'AATU2' on template 'AAT1' settings tab
When I login with details of 'AATU2'
And go to template list page
Then I should see 'AAT1' template in template list


Scenario: add several template owners
Meta: @gdam
      @projects
Given I created users with following fields:
| Email   | Role       |
| AATU3_1 | guest.user |
| AATU3_2 | guest.user |
| AATU3_3 | guest.user |
And created 'AAT3' template
And I am on template 'AAT3' settings page
When I edit the following fields for 'AAT3' template:
| Name | Administrators          |
| AAT3 | AATU3_1,AATU3_2,AATU3_3 |
And click on element 'SaveButton'
And open template 'AAT3' settings page
Then I 'should' see administrator 'AATU3_1' on template 'AAT3' settings tab
And 'should' see administrator 'AATU3_2' on template 'AAT3' settings tab
And 'should' see administrator 'AATU3_3' on template 'AAT3' settings tab


Scenario: delete template owner
Meta: @gdam
      @projects
Given I created users with following fields:
| Email   | Role       |
| AATU4_1 | guest.user |
| AATU4_2 | guest.user |
And the following templates were created:
| Name | Administrators  |
| AAT4 | AATU4_1,AATU4_2 |
And I am on template 'AAT4' settings page
When I remove administrator 'AATU4_2' from template 'AAT4'
And click on element 'SaveButton'
Then I 'should not' see administrator 'AATU4_2' on template 'AAT4' settings tab
When I login with details of 'AATU4_2'
And go to template list page
Then I should see 'AAT4' template in template list


Scenario: Check that Remove link isn't active if only one template administrator is setup
Meta: @gdam
      @projects
Given I created following users:
| User Name |
| AATU5_1   |
| AATU5_2   |
And created following templates:
| Name           | Administrators   |
| <TemplateName> | <Admins>         |
When I open template '<TemplateName>' settings page
Then I '<Should>' see delete link for users '<Admins>' on template '<TemplateName>' settings page

Examples:
| TemplateName | Admins          | Should     |
| AAT5_1       |                 | should not |
| AAT5_2       | AATU5_1,AATU5_2 | should     |


Scenario: Check that user from Address Book can be specified as template owner
Meta: @gdam
      @projects
Given I created 'AATU6' User
And added user 'AATU6' into address book
And created 'AAT6' template
And I am on template 'AAT6' settings page
When I edit the following fields for 'AAT6' template:
| Name | Administrators |
| AAT6 | AATU6          |
Then I 'should' see administrator 'AATU6' on template 'AAT6' settings tab


Scenario: Check that another agency user from Address Book can be specified as template owner
Meta: @gdam
      @projects
Given I logged in as 'AnotherAgencyAdmin'
And I created users with following fields:
| Agency        | Email |
| AnotherAgency | AATU7 |
And I logged in as 'AgencyAdmin'
And added user 'AATU7' into address book
And created 'AAT7' template
And I am on template 'AAT7' settings page
When I edit the following fields for 'AAT7' template:
| Name | Administrators |
| AAT7 | AATU7          |
Then I 'should' see administrator 'AATU7' on template 'AAT7' settings tab


Scenario: Check that easy share user from Address Book can be specified as template owner
Meta: @gdam
      @projects
Given I added user 'AATU8' into address book
And created 'AAT8' template
And I am on template 'AAT8' settings page
When I edit the following fields for 'AAT8' template:
| Name | Administrators |
| AAT8 | AATU8          |
Then I 'should' see administrator 'AATU8' on template 'AAT8' settings tab


Scenario: Check setting up template owner user removed from Address Book
Meta: @gdam
      @projects
Given I created 'AATU9' User
And added user 'AATU9' into address book
And created 'AAT9' template
And removed user 'AATU9' from address book
And I am on template 'AAT9' settings page
When I edit the following fields for 'AAT9' template:
| Name | Administrators |
| AAT9 | AATU9          |
Then I 'should' see administrator 'AATU9' on template 'AAT9' settings tab


Scenario: Check setting up template owner another agency user removed from Address Book
Meta: @gdam
      @projects
Given I logged in as 'AnotherAgencyAdmin'
And I created users with following fields:
| Agency        | Email  |
| AnotherAgency | AATU10 |
And I logged in as 'AgencyAdmin'
And added user 'AATU10' into address book
And created 'AAT10' template
And removed user 'AATU10' from address book
And I am on template 'AAT10' settings page
When I edit the following fields for 'AAT10' template:
| Name  | Administrators |
| AAT10 | AATU10         |
Then I 'should not' see administrator 'AATU10' on template 'AAT10' settings tab


Scenario: Check setting up template owner easy share user removed from Address Book
Meta: @gdam
      @projects
Given I added user 'AATU11' into address book
And created 'AAT11' template
And removed user 'AATU11' from address book
And I am on template 'AAT11' settings page
When I edit the following fields for 'AAT11' template:
| Name  | Administrators  |
| AAT11 | AATU11          |
Then I 'should not' see administrator 'AATU11' on template 'AAT11' settings tab


Scenario: Check that removing user from Address Book doesn't affect template owner added before
Meta: @gdam
      @projects
Given I created 'AATU12' User
And added user 'AATU12' into address book
And created following templates:
| Name  | Administrators |
| AAT12 | AATU12         |
And removed user 'AATU12' from address book
When I open template 'AAT12' settings page
Then I 'should' see administrator 'AATU12' on template 'AAT12' settings tab


Scenario: Check that removing another agency user from Address Book doesn't affect template owner added before
Meta: @gdam
      @projects
Given I logged in as 'AnotherAgencyAdmin'
And I created users with following fields:
| Agency        | Email  |
| AnotherAgency | AATU13 |
And I logged in as 'AgencyAdmin'
And added user 'AATU13' into address book
And created following templates:
| Name  | Administrators |
| AAT13 | AATU13         |
And removed user 'AATU13' from address book
When I open template 'AAT13' settings page
Then I 'should' see administrator 'AATU13' on template 'AAT13' settings tab


Scenario: Check setting up template owner easy share user removed from Address Book 2
Meta: @gdam
      @projects
Given I added user 'AATU14' into address book
And created following templates:
| Name  | Administrators |
| AAT14 | AATU14         |
And removed user 'AATU14' from address book
When I open template 'AAT14' settings page
Then I 'should' see administrator 'AATU14' on template 'AAT14' settings tab


Scenario: Check that template creator automatically added as Project Administrator during template creation
Meta: @gdam
      @projects
Given I am on Create New Template page
Then I 'should' see administrator 'AgencyAdmin' on create new template page


Scenario: Check that template creator added as Project Administrator after template creation
Meta: @gdam
      @projects
Given I am on Create New Template page
When I create 'AAT15' template with 'MandatoryFields'
And open template 'AAT15' settings page
Then I 'should' see administrator 'AgencyAdmin' on template 'AAT15' settings tab