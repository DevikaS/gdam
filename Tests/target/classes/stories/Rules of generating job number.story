!--NGN-1499
Feature:          Rules of generating job number
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that job number is proper generated

Scenario: Check proper generating for job number (dependence on agency and brand name)
Meta: @skip
      @gdam
Given I created the following agency:
| Name          | Product |
| L'Oreal Paris | Päris   |
| J.P.S.R       | V@3     |
| ä&tipodes     | 342     |
| ö%tec         | F_S     |
And created users with following fields:
| Email | AgencyUnique  |
| JNGU1 | L'Oreal Paris |
| JNGU2 | J.P.S.R       |
| JNGU3 | ä&tipodes     |
| JNGU4 | ö%tec         |
And I logged in with details of '<User>'
When I create 'JNGP1' project
Then I should see valid generated job number for project 'JNGP1'

Examples:
| User  |
| JNGU1 |
| JNGU2 |
| JNGU3 |
| JNGU4 |