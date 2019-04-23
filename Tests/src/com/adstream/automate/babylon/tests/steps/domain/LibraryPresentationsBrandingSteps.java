package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.tests.RelativePathConverter;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsBrandingPage;
import com.adstream.automate.utils.Common;
import org.hamcrest.Matcher;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 08.11.12
 * Time: 11:58

 */
public class LibraryPresentationsBrandingSteps extends LibraryPresentationsSteps {

    public AdbankLibraryPresentationsBrandingPage getLibraryPresentationsPage() {
        return getSut().getPageCreator().getLibraryPresentationsBrandingPage();
    }

    public AdbankLibraryPresentationsBrandingPage getLibraryPresentationsPage(String presentationId) {
        return getSut().getPageNavigator().getLibraryPresentationsBrandingPage(presentationId);
    }

    @Given("{I |}am on the presentation '$presentationName' branding page")
    @When("{I |}go to the presentation '$presentationName' branding page")
    public void openPresentationsBrandingPage(String presentationName) {
        String presentationId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        getSut().getPageNavigator().getLibraryPresentationsBrandingPage(presentationId);
        Common.sleep(1000);
    }

    @When("I select {L|l}ight {T|t}heme for current presentation branding page")
    public void selectLightThemeForCurrentPresentation() {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        libraryPresentationsBrandingPage.clickLightTheme();
    }

    @When("I save current presentation on the branding page")
    public void saveCurrentPresentation() {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        libraryPresentationsBrandingPage.clickSaveButton();
    }

    @When("I click cancel button on the current presentation branding page")
    public void clickCancelOnThePresentationLayoutPage() {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        libraryPresentationsBrandingPage.clickCancelButton();
    }

    @Given("I uploaded '$elementType' by file '$fileName' on the current presentation branding page")
    @When("I upload '$elementType' by file '$fileName' on the current presentation branding page")
    public void uploadObjectOnTheBrandingPage(String elementType, String fileName) {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        fileName = RelativePathConverter.getFullPath(fileName);
        if (elementType.equalsIgnoreCase("logo")) {
            libraryPresentationsBrandingPage.uploadLogo(fileName);
        } else if (elementType.equalsIgnoreCase("background")) {
            libraryPresentationsBrandingPage.uploadBackground(fileName);
        } else {
            throw new IllegalArgumentException(String.format("Parameter object = %s is incorrect. It must be logo or background", elementType));
        }
    }

    @Given("I uploaded '$elementType' by file '$fileName' on the current presentation branding page incorrect element")
    @When("I upload '$elementType' by file '$fileName' on the current presentation branding page incorrect element")
    public void uploadIncorrectObjectOnTheBrandingPage(String elementType, String fileName) {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        fileName = RelativePathConverter.getFullPath(fileName);
        if (elementType.equalsIgnoreCase("logo")) {
            libraryPresentationsBrandingPage.uploadLogoWithoutWaiting(fileName);
        } else if (elementType.equalsIgnoreCase("background")) {
            libraryPresentationsBrandingPage.uploadBackgroundWithoutWaiting(fileName);
        } else {
            throw new IllegalArgumentException(String.format("Parameter object = %s is incorrect. It must be logo or background", elementType));
        }
    }

    @Given("I selected background type '$backgroundType' for current presentation")
    @When("I select background type '$backgroundType' for current presentation")
    public void selectBackgroundType(String backgroundType) {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        if (backgroundType.toLowerCase().contains("scale")) {
            libraryPresentationsBrandingPage.clickScaleToFitScreen();
        } else if (backgroundType.toLowerCase().contains("tile")) {
            libraryPresentationsBrandingPage.clickTile();
        } else {
            throw new IllegalArgumentException(String.format("Parameter for background style is incorrect: %s. It must contains 'scale' or 'tile'", backgroundType));
        }
    }


    @When("I click remove '$elementType' on the current presentation branding page")
    public void clickRemoveElemetFromBrandingRab(String elementType) {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        clickRemoveLink(libraryPresentationsBrandingPage, elementType);
    }

    @When("I remove '$elementType' from the current presentation branding page")
    public void removeElemetFromBrandingRab(String elementType) {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        PopUpWindow removePopUp = clickRemoveLink(libraryPresentationsBrandingPage, elementType);
        removePopUp.action.click();
    }

    @Then("I '$condition' see on the current presentation branding page uploaded '$elementType' according to file '$fileName'")
    public void checkVisibilityOfUploadedElements(String condition, String elementType, String fileName) {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        if (elementType.equalsIgnoreCase("logo")) {
            assertThat(libraryPresentationsBrandingPage.isLogoThumbnailEmpty(), not(equalTo(shouldState)));
            assertThat(libraryPresentationsBrandingPage.isRemoveLogoLinkVisible(), equalTo(shouldState));
        }
        else if (elementType.equalsIgnoreCase("background")) {
            assertThat(libraryPresentationsBrandingPage.isBackgroundThumbnailEmpty(), not(equalTo(shouldState)));
            assertThat(libraryPresentationsBrandingPage.isRemoveBackgroundLinkVisible(), equalTo(shouldState));
        }
        else {
            throw new IllegalArgumentException(String.format("Parameter object = %s is incorrect. It must be logo or background", elementType));
        }
    }

    @Then("I '$condition' see element '$elementName' on the current presentation branding page")
    public void checkVisibilityOfElement(String condition, String elementName) {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        //if (elementName.equalsIgnoreCase())
    }

    // | Element | State | if element present or visible on the page, state must contain true
    @Then("I should see following elements on the current presentation branding tab: $elementsTable")
    public void checkVisibilityOfElementsOnBrandingPresentationTab(ExamplesTable elementsTable) {
        AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage = getSut().getPageCreator().getLibraryPresentationsBrandingPage();
        for (int i=0; i<elementsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(elementsTable, i);
            if ((row.get("Element") == null) || row.get("Element").isEmpty() || (row.get("State") == null) || row.get("State").isEmpty()) {
                throw new IllegalArgumentException("Parameters 'Element' and 'State' must be defined");
            }
            Matcher<Boolean> matcher = equalTo(row.get("State").contains("true"));
            if (row.get("Element").equalsIgnoreCase("Logo thumbnail")) {
                assertThat(!libraryPresentationsBrandingPage.isLogoThumbnailEmpty(), matcher);
            }
            if (row.get("Element").equalsIgnoreCase("Logo filename")) {
                assertThat(libraryPresentationsBrandingPage.isLogoFileNameVisible(), matcher);
            }
            if (row.get("Element").equalsIgnoreCase("Light theme icon")) {
                assertThat(libraryPresentationsBrandingPage.isLightThemeChecked(), matcher);
            }
            if (row.get("Element").equalsIgnoreCase("Dark theme icon")) {
                assertThat(libraryPresentationsBrandingPage.isDarkThemeChecked(), matcher);
            }
            if (row.get("Element").equalsIgnoreCase("Background thumbnail")) {
                assertThat(!libraryPresentationsBrandingPage.isBackgroundThumbnailEmpty(), matcher);
            }
            if (row.get("Element").equalsIgnoreCase("Background filename")) {
                assertThat(libraryPresentationsBrandingPage.isBackgroundFileNameVisible(), matcher);
            }
            if (row.get("Element").equalsIgnoreCase("Scale to fit screen")) {
                assertThat(libraryPresentationsBrandingPage.isScaleToFitScreenRBSelected(), matcher);
            }
            if (row.get("Element").equalsIgnoreCase("Tile")) {
                assertThat(libraryPresentationsBrandingPage.isTileRBSelected(), matcher);
            }
        }
    }

    private PopUpWindow clickRemoveLink(AdbankLibraryPresentationsBrandingPage libraryPresentationsBrandingPage, String elementType) {
        PopUpWindow removePopUp = null;
        if (elementType.equalsIgnoreCase("logo")) {
            removePopUp = libraryPresentationsBrandingPage.clickRemoveLogoLink();
        } else if (elementType.equalsIgnoreCase("background")) {
            removePopUp = libraryPresentationsBrandingPage.clickRemoveBackgroundLink();
        } else {
            throw new IllegalArgumentException(String.format("Parameter object = %s is incorrect. It must be logo or background", elementType));
        }
        Common.sleep(1000);
        return removePopUp;
    }

}
