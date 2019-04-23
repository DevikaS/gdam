package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.admin.agency.AgencySecurityPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.not;

/**
 * User: lynda-k
 * Date: 03.03.14
 * Time: 12:00
 */
public class AgencySecuritySteps extends BaseStep {
    @Given("{I am |}on agency '$agencyName' security page")
    @When("{I |}go to agency '$agencyName' security page")
    public AgencySecurityPage openAgencySecurityPage(String agencyName) {
        return getSut().getPageNavigator().getAgencySecurityPage(getAgencyIdByName(agencyName));
    }

    @Given("{I |}added password strength: with min. password length: '$minLength', min. number of uppercase A-Z: '$upperCaseCount', min. number of numbers 0-9: '$numbersCount', password expiration in days '$expirationInDays'")
    @When("{I |}add password strength: with min. password length: '$minLength', min. number of uppercase A-Z: '$upperCaseCount', min. number of numbers 0-9: '$numbersCount', password expiration in days '$expirationInDays'")
    public void setPasswordStrength(String minLength, String upperCaseCount, String numbersCount, String expirationInDays) {
        getSut().getPageCreator().getAgencySecurityPage().setPasswordStrengthForm(minLength, upperCaseCount, numbersCount, expirationInDays);
    }

    // | MinimumPasswordLength | UppercaseCharactersCount | NumbersCount | PasswordExpirationInDays |
    @Then("{I |}'$condition' see following parameters values on agency '$agencyName' security page: $data")
    public void checkAgencySecurityParameters(String condition, String agencyName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        Map<String,String> expectedParams = parametrizeTabularRow(data);
        Map<String,String> actualParams = new HashMap<>();
        AgencySecurityPage page = openAgencySecurityPage(agencyName);

        if (expectedParams.get("MinimumPasswordLength") != null)
            actualParams.put("MinimumPasswordLength", page.getMinimumLengthOfPasswordFieldValue());

        if (expectedParams.get("UppercaseCharactersCount") != null)
            actualParams.put("UppercaseCharactersCount", page.getMinimumUppercaseCharsFieldValue());

        if (expectedParams.get("NumbersCount") != null)
            actualParams.put("NumbersCount", page.getMinimumNumbersFieldValue());

        if (expectedParams.get("PasswordExpirationInDays") != null)
            actualParams.put("PasswordExpirationInDays", page.getPasswordExpirationPeriodFieldValue());

        assertThat(actualParams, shouldState ? equalTo(expectedParams) : not(equalTo(expectedParams)));
    }
}