package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.sut.pages.admin.agency.*;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: Devika Subramanian
 * Date: 15.02.16
 * Time:
 */
public class AgencyGlobalAccessRulesPageSteps extends BaseStep {

    private AgencyGlobalAccessRulesPage getAgencyGlobalAccessRulesPage() {
        return getSut().getPageCreator().getAgencyGlobalAccessRulesPage();
    }

    @Given("{I am |}on agency '$agencyName' global access rules page")
    @When("{I |}go to agency '$agencyName' global access rules page")
    public AgencyGlobalAccessRulesPage openAgencyGlobalAccessRulesPage(Agency agency) {
        return getSut().getPageNavigator().getAgencyGlobalAccessRulesPage(agency.getId());
    }

    @Given("{I |} select global role '$globalRole'")
    @When("{I |} select global role '$globalRole'")
    public void selectGlobalRole(String globalRole){
        AgencyGlobalAccessRulesPage page = getSut().getPageCreator().getAgencyGlobalAccessRulesPage();
        page.selectGolbalRole(globalRole);
    }

    @Then("{I |} should see the global rule saved with data '$rule'")
    public void verifyGlobalRuleIsSaved(String rule){
        AgencyGlobalAccessRulesPage page = getSut().getPageCreator().getAgencyGlobalAccessRulesPage();
        String[] criteria = rule.split(",");
        HashMap<String, String> globalRule = page.verifyGolbalRuleIsSaved();
        Assert.assertEquals("Check UserType",criteria[0],globalRule.get("UserType"));
        Assert.assertEquals("Check MetaData",criteria[1],globalRule.get("MetaData"));
        Assert.assertEquals("Check Role", criteria[2], globalRule.get("Role"));
        Assert.assertEquals("Check NeverExpired", criteria[3], globalRule.get("NeverExpired"));
    }

    @Given("{I |} select meta data '$metaAttribute' with value '$metaValue'")
    @When("{I |} select meta data '$metaAttribute' with value '$metaValue'")
    public void selectMetaData(String metaAttribute, String metaValue){
        AgencyGlobalAccessRulesPage page = getSut().getPageCreator().getAgencyGlobalAccessRulesPage();
        page.selectMetaData(metaAttribute, metaValue);
    }

    @Given("{I |} select project role '$projectRole'")
    @When("{I |} select project role '$projectRole'")
    public void selectProjectRole(String projectRole){
        AgencyGlobalAccessRulesPage page = getSut().getPageCreator().getAgencyGlobalAccessRulesPage();
        page.selectProjectRole(projectRole);
    }

    @Given("{I |} click on save button")
    @When("{I |} click on save button")
    public void clickSave(){
        AgencyGlobalAccessRulesPage page = getSut().getPageCreator().getAgencyGlobalAccessRulesPage();
        page.clickSave();
    }



}
