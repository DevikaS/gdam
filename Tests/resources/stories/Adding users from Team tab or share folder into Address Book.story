!--NGN-1939
Feature:          Adding users from Team tab or share folder into Address Book
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check adding users from Team tab or share folder into Address Book

Scenario: Adding users from Team tab of project into Address Book
Meta: @gdam
      @projects
Given I created 'PTP5' project
And created '/PTF5' folder for project 'PTP5'
And created 'PTR5' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PTP5' teams page
When I add user 'ptu5' into project 'PTP5' team with role 'PTR5' expired '12.12.2021' for folder '/PTF5'
Then I 'should' see easyshare user 'ptu5' with role 'PTR5' in the project 'PTP5' on the team tab
And I 'should' see easyshare users 'ptu5' on the Address Book page


Scenario: Adding users from Share folder of project into Address Book
Meta: @gdam
      @projects
Given I created 'PTP4' project
And created '/PTF4' folder for project 'PTP4'
And created 'PTR4' role in 'project' group for advertiser 'DefaultAgency'
And I am on project 'PTP4' folder '/PTF4' page
When I open Share window from popup menu for folder '/PTF4' on project 'PTP4'
And fill Share popup of project folder for user 'PTU4' with role 'PTR4' expired '12.12.2021' and 'should not' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Then I 'should' see easyshare user 'PTU4' with role 'PTR4' in the project 'PTP4' on the team tab
And I 'should' see easyshare users 'PTU4' on the Address Book page


Scenario: Adding users from Team tab of template into Address Book
Meta: @gdam
      @projects
Given I created 'PTP5' template
And created '/PTF5' folder for template 'PTP5'
And created 'PTR5' role in 'project' group for advertiser 'DefaultAgency'
And I am on template 'PTP5' teams page
When I add user 'ptu6' into template 'PTP5' team with role 'PTR5' expired '12.12.2021' for folder '/PTF5'
Then I 'should' see easyshare user 'ptu6' with role 'PTR5' in the template 'PTP5' on the team tab
And I 'should' see easyshare users 'ptu6' on the Address Book page


Scenario: Adding users from Share folder of template into Address Book
Meta: @gdam
      @projects
Given I created 'PTP4' template
And created '/PTF4' folder for template 'PTP4'
And created 'PTR4' role in 'project' group for advertiser 'DefaultAgency'
And I am on template 'PTP4' folder '/PTF4' page
When I open Share window from popup menu for folder '/PTF4' on template 'PTP4'
And fill Share popup of template folder for user 'PTU4' with role 'PTR4' expired '12.12.2021' and 'should not' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Then I 'should' see easyshare user 'ptu4' with role 'PTR4' in the template 'PTP4' on the team tab
And I 'should' see easyshare users 'ptu4' on the Address Book page


Scenario: Check that other users from Team tab of shared project aren't added into Address Book
Meta: @gdam
      @projects
!--NGN-1902
Given I created the following agency:
| Name      | AgencyType |
| Adpath    | Advertiser |
| qa agency | Advertiser |
And I created users with following fields:
| AgencyUnique | Email | Role         |
| qa agency    | UAU_1 | agency.user  |
| Adpath       | UAU_2 | agency.user  |
| Adpath       | UA_1  | agency.admin |
And added user 'UA_1' into address book
And created following projects:
| Name | Administrators |
| PTP5 | UA_1           |
And created '/PTF5' folder for project 'PTP5'
And created 'PTR5' role in 'project' group for advertiser 'DefaultAgency'
And added users 'UAU_1,UAU_2,UA_1' to project 'PTP5' team folders '/PTF5' with role 'PTR5' expired '12.12.2021'
And I logged in with details of 'UA_1'
When I go on Address Book page
Then I should see next users in Address book:
| Email | Should     |
| UAU_1 | should not |
| UAU_2 | should not |
And I 'should not' see user type 'AgencyAdmin' in AddressBook
And I 'should' see less or equals users '1' in AddressBook