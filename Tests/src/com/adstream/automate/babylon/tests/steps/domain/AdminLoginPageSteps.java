package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.admin.branding.AdminSystemBrandingPage;
import com.adstream.automate.babylon.tests.RelativePathConverter;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import com.adstream.automate.babylon.sut.pages.admin.branding.AdminLoginPage;
import org.jbehave.core.model.ExamplesTable;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.not;

/**
 * Created with IntelliJ IDEA.
 * User: sobolev-a
 * Date: 20.11.13
 * Time: 13:57
 */
public class AdminLoginPageSteps extends BaseStep {

    @Given("{I am |}on Admin Branding login page")
    @When("{I |}go to Admin Branding login page")
    public AdminLoginPage openSystemBrandingLoginPage() {
        return getSut().getPageNavigator().getAdminLoginPage();
    }

    @When("{I |}upload logo '$logo' on admin branding login page")
    public void uploadSBPLogo(String logo) {
        AdminLoginPage page = getSut().getPageCreator().getAdminLoginPage();
        String fileName = RelativePathConverter.getFullPath(logo);
        page.uploadLogo(fileName);
    }

    @When("{I |}remove '$element' from the system branding login page")
    public void removeLogoOrBackground(String element) {
        if(element.equalsIgnoreCase("background"))
            getSut().getPageCreator().getAdminLoginPage().clickRemoveBackground().action.click();
        else if (element.equalsIgnoreCase("logo"))
            getSut().getPageCreator().getAdminLoginPage().clickRemoveLogo().action.click();
        Common.sleep(1000);
    }

    @When("I '$condition' see that logo on the system branding page is default")
    public void checkThatLogoIsNotDefault(String condition) {
        AdminSystemBrandingPage page = getSut().getPageCreator().getAdminSystemBrandingPage();
        assertThat(page.isLogoDefault(), equalTo(condition.equalsIgnoreCase("should")));
    }

    @When("{I |}uploaded background image '$filename' and set up Background Colour '$bgColour'")
    public void uploadBackgroundImg(String fileName, String bgColour) {
        AdminLoginPage page = getSut().getPageCreator().getAdminLoginPage();
        String backgroundImage = RelativePathConverter.getFullPath(fileName);
        page.uploadBackgroundImage(backgroundImage);
        page.clickBackgroundColourButton();
        page.typeBackgroundColour(bgColour);
    }

    @When("{I |} set Button Colour '$buttonColour' Link Colour '$linkColour'  Text Colour '$textColour' on admin branding login page")
    public void setColourForButtonLinkText(String buttonColour, String linkColour, String textColour) {
        AdminLoginPage page = getSut().getPageCreator().getAdminLoginPage();
        page.clickButtonColourButton();
        page.typeButtonColour(buttonColour);
        page.clickLinkColourButton();
        page.typeLinkColour(linkColour);
        getSut().getPageCreator().getAdminLoginPage().clickSaveButton();
        page.clickTextColourButton();
        page.typeTextColour(textColour);
    }

    @When("{I |}type Welcome Message '$message'")
    public void typeWelcomeMessage(String message) {
        getSut().getPageCreator().getAdminLoginPage().typeTextWelcomeMessage(message);
    }

    @When("{I |}click save on the custom login page")
    public void clickSave() {
        getSut().getPageCreator().getAdminLoginPage().clickSaveButton();
    }

    @When("{I |}uploaded logo '$logo' and set Footer Colour '$footerColour' on admin branding login page")
    public void uploadLogoAndFooterColour(String logo, String footerColour) {
        AdminLoginPage page = getSut().getPageCreator().getAdminLoginPage();
        String fileName = RelativePathConverter.getFullPath(logo);
        page.uploadLogo(fileName);
        page.clickBackgroundFooterColourButton();
        page.typeFooterColour(footerColour);
    }

    @When("{I |}uploaded Background Image '$backgroundImage' and set Background Colour '$backgroundColour'")
    public void uploadBackgroundAndBackgroundColour(String backgroundImage, String backgroundColour) {
        AdminLoginPage page = getSut().getPageCreator().getAdminLoginPage();
        String fileName = RelativePathConverter.getFullPath(backgroundImage);
        page.uploadBackgroundImage(fileName);
        page.clickBackgroundFooterColourButton();
        page.typeFooterColour(backgroundColour);
    }

    @Then("{I |}should see following elements on the system admin branding login page: $elementsTable")
    public void checkElementVisibility(ExamplesTable elementsTable) {
        AdminLoginPage page = getSut().getPageCreator().getAdminLoginPage();

        for (Map<String, String> row : parametrizeTableRows(elementsTable)) {
            if (row.get("Element") == null) throw new IllegalArgumentException(String.format("Incorrect argument: is null"));

            boolean shouldState = row.get("State") != null && row.get("State").equalsIgnoreCase("should");
            if (row.get("Element").equalsIgnoreCase("BackgroundColorInput")) {
                assertThat(page.isBackgroundColourInputVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("BackgroundColorButton")) {
                assertThat(page.isBackgroundColourButtonVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("FooterColourInput")) {
                assertThat(page.isBackgroundFooterColourInputVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("FooterColourButton")) {
                assertThat(page.isBackgroundFooterColourButtonVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("BackgroundImage")) {
                assertThat(page.isBackgroundImageVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("Logo")) {
                assertThat(page.isLogoVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("ButtonColourInput")) {
                assertThat(page.isButtonColourInputVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("ButtonColourButton")) {
                assertThat(page.isButtonColourButtonVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("TextColourInput")) {
                assertThat(page.isTextColourInputVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("TextColourButton")) {
                assertThat(page.isTextColourButtonVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("LinkColourInput")) {
                assertThat(page.isLinkColourInputVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("LinkColourButton")) {
                assertThat(page.isLinkColourButtonVisible(), equalTo(shouldState));
            } else if (row.get("Element").equalsIgnoreCase("Save")) {
                assertThat(page.isSaveButtonVisible(), equalTo(shouldState));
            }
        }
    }

    @Then("I '$condition' see that logo on the system branding login page is default")
    public void checkOnNewLogo(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        int expectedLogoBase64Size = 0;
        int actualLogoBase64Size = getSut().getPageCreator().getAdminLoginPage().checkOnDefaultLogo();
        assertThat(actualLogoBase64Size, shouldState ? equalTo(expectedLogoBase64Size) : not(equalTo(expectedLogoBase64Size)));
    }
}
