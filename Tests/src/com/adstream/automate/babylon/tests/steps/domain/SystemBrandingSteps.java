package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch.AgencyList;
import com.adstream.automate.babylon.sut.pages.admin.branding.GlobalAdminSystemBrandingPage;
import com.adstream.automate.babylon.tests.RelativePathConverter;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.branding.AdminSystemBrandingPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.io.File;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.equalToIgnoringCase;
import static org.hamcrest.Matchers.not;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 27.11.12
 * Time: 12:01
 */
public class SystemBrandingSteps extends BaseStep {

    @Given("{I |}am on {the|} system branding page")
    @When("{I |}go to {the|} system branding page")
    public AdminSystemBrandingPage openSystemBrandingPage() {
        return getSut().getPageNavigator().getAdminSystemBrandingPage();
    }

    @Given("{I |}am on {the|} Global Admin system branding page of '$agency'")
    @When("{I |}go to {the|} Global Admin system branding page of '$agency'")
    public GlobalAdminSystemBrandingPage openGlobalAdminSystemBrandingPage(Agency agency ) {
        return getSut().getPageNavigator().getGlobalAdminSystemBrandingPage(agency.getId());
    }

    @Given(value = "{I |}uploaded logo '$logo' and color '$color' on system branding page", priority = 1)
    public void setBrandingOverCore(String logo, String color) {
        File file = null;
        if (logo != null && !logo.isEmpty()) {
            file = new File(RelativePathConverter.getFullPath(logo));
        }
        if (color != null && color.isEmpty()) {
            color = null;
        }
        getCoreApi().uploadBrandingLogo(getCoreApi().getCurrentAgency().getId(), color, file);
    }

    @Given("{I |}uploaded logo '$logo' on system branding page")
    @When("{I |}upload logo '$logo' on system branding page")
    public void uploadSBLogo(String logo) {
        AdminSystemBrandingPage systemBrandingPage = getSut().getPageCreator().getAdminSystemBrandingPage();
        String fileName = RelativePathConverter.getFullPath(logo);
        systemBrandingPage.uploadLogo(fileName);
    }

    @Given("{I |}selected color '$color' on system branding page")
    @When("{I |}select color '$color' on system branding page")
    public void selectColor(String color) {
        getSut().getPageCreator().getAdminSystemBrandingPage().clickBackgroundColorButton().typeColor(color);
    }

    @Given("{I |}selected color on system branding page according to next parameters '$params'")
    @When("{I |}select color on system branding page according to next parameters '$params")
    public void selectColorAccordingTo(String params) {
        AdminSystemBrandingPage systemBrandingPage = getSut().getPageCreator().getAdminSystemBrandingPage();
        systemBrandingPage.clickBackgroundColorButton();
        systemBrandingPage.setColorByParams(params);
    }


    @Given("{I |}clicked save on the system branding page")
    @When("{I |}click save on the system branding page")
    public void clickSave() {
        getSut().getPageCreator().getAdminSystemBrandingPage().clickSaveButton();
    }

    @Given("{I |}clicked save on the Global system branding page")
    @When("{I |}click save on the Global system branding page")
    public void clickGlobalAdminSave() {
        getSut().getPageCreator().getGlobalAdminSystemBrandingPage().clickSaveButton();
    }

    @When("{I |}'$action' remove logo from the system branding page")
    public void removeLogo(String action) {
        AdminSystemBrandingPage systemBrandingPage = getSut().getPageCreator().getAdminSystemBrandingPage();
        PopUpWindow popUpWindow = systemBrandingPage.clickRemoveLink();
        if (action.toLowerCase().contains("confirm")) popUpWindow.action.click();
        else if (action.toLowerCase().contains("cancel")) popUpWindow.cancel.click();
        else if (action.toLowerCase().contains("close")) popUpWindow.close.click();
        else popUpWindow.action.click();
    }

    @Given("{I |}filled From custom Url field with text '$url' on Global system branding page of '$agencyName'")
    @When("{I |}fill From custom Url field with text '$url' on Global system branding page of '$agencyName'")
    public void fillCustomUrlField(String url,Agency agencyName) {
        if(url!=null) {
            openGlobalAdminSystemBrandingPage(agencyName).typeCustomUrl(url);
            openGlobalAdminSystemBrandingPage(agencyName).clickSaveButton();
        }
    }

    @Given("{I |}filled From email field with text '$email' on system branding page")
    @When("{I |}fill From email field with text '$email' on system branding page")
    public void fillFromEmailField(String email) {
        getSut().getPageNavigator().getAdminSystemBrandingPage().typeFromEmail(email);
    }

    @Given("{I |}filled From email Url field with text '$url' on Global system branding page of '$agencyName'")
    @When("{I |}fill From email Url field with text '$url' on Global system branding page of '$agencyName'")
    public void fillEmailUrlField(String url,Agency agencyName) {
        if(url!=null) {
            openGlobalAdminSystemBrandingPage(agencyName).typeEmailUrl(url);
            openGlobalAdminSystemBrandingPage(agencyName).clickSaveButton();
        }
    }

    @Then("{I |}'$condition' see From email field with text '$expectedEmail' on system branding page")
    public void checkFromEmailFieldValue(String condition, String expectedEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualEmail = getSut().getPageNavigator().getAdminSystemBrandingPage().getFromEmailFieldValue();

        assertThat(actualEmail, shouldState ? equalToIgnoringCase(expectedEmail) : not(equalToIgnoringCase(expectedEmail)));
    }

    @Then("{I |}'$condition' see error hint '$expectedHint' under From email field on opened system branding page")
    public void checkFromEmailFieldErrorHint(String condition, String expectedHint) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualHint = getSut().getPageNavigator().getAdminSystemBrandingPage().FromEmailFieldErrorHintText();

        assertThat(actualHint, shouldState ? equalToIgnoringCase(expectedHint) : not(equalToIgnoringCase(expectedHint)));
    }

    @Then("I should see that branding menu item is first")
    public void checkThatBrandingMenuItemIsFirst() {
        AdminSystemBrandingPage systemBrandingPage = getSut().getPageCreator().getAdminSystemBrandingPage();
        assertThat("Branding", equalTo(systemBrandingPage.getAppMenuItems().get(0)));
    }

    @Then("I '$condition' see that logo on the system branding page is default")
    public void checkThatLogoIsNotDefault(String condition) {
        AdminSystemBrandingPage systemBrandingPage = getSut().getPageCreator().getAdminSystemBrandingPage();
        assertThat(systemBrandingPage.isLogoDefault(), equalTo(condition.equalsIgnoreCase("should")));
    }

    // | Element | State |
    @Then("I should see following elements on the system branding page: $elementsTable")
    public void checkElementVisibility(ExamplesTable elementsTable) {
        AdminSystemBrandingPage systemBrandingPage = getSut().getPageCreator().getAdminSystemBrandingPage();

        for (Map<String, String> row : parametrizeTableRows(elementsTable)) {
            if (row.get("Element") == null) throw new IllegalArgumentException(String.format("Incorrect argument: is null"));

            boolean shouldState = row.get("State") != null && row.get("State").equalsIgnoreCase("should");
            if (row.get("Element").equalsIgnoreCase("BackgroundColorInput")) {
                assertThat(systemBrandingPage.isBackgroundColorInputVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("BackgroundColorButton")) {
                assertThat(systemBrandingPage.isBackgroundColorButtonVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("Logo")) {
                assertThat(systemBrandingPage.isLogoVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("Browse")) {
                assertThat(systemBrandingPage.isBrowseButtonVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("Save")) {
                assertThat(systemBrandingPage.isSaveButtonVisible(), equalTo(shouldState));
            }
        }
    }
}
