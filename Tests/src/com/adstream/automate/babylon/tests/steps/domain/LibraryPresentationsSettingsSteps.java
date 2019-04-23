package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsSettingsPage;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankPresentationPreviewPage;
import com.adstream.automate.utils.Common;
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
 * Date: 29.10.12
 * Time: 9:49
 */
public class LibraryPresentationsSettingsSteps  extends LibraryPresentationsSteps{

    public AdbankLibraryPresentationsSettingsPage getLibraryPresentationsPage() {
        return getSut().getPageCreator().getLibraryPresentationsSettingsPage();
    }

    public AdbankLibraryPresentationsSettingsPage getLibraryPresentationsPage(String presentationId) {
        return getSut().getPageNavigator().getLibraryPresentationsSettingsPage(presentationId);
    }


    @Given("{I |}am on the presentation '$presentationName' settings page")
    @When("{I |}go to the presentation '$presentationName' settings page")
    public AdbankLibraryPresentationsSettingsPage openPresentationsSettingsPage(String presentationName) {
        String presentationId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        return getLibraryPresentationsPage(presentationId);
    }

    @Given("{I |}changed presentation name from '$currentName' to '$newName'")
    @When("{I |}change presentation name from '$currentName' to '$newName'")
    public void changePresentationName(String currentName, String newName) {
        openPresentationsSettingsPage(currentName).fillPresentationNameField(wrapPathWithTestSession(newName));
    }

    @When("{I |}change presentation description to '$newDescription' for current presentation")
    public void changePresentationDescription(String newDescription) {
        getSut().getPageCreator().getLibraryPresentationsSettingsPage().fillDescriptionField(newDescription);
    }

    @When("{I |}fill field '$fieldName' with value '$fieldValue' on presentation settings page")
    public void fillPresentationField(String fieldName, String fieldValue) {
        AdbankLibraryPresentationsSettingsPage page = getSut().getPageCreator().getLibraryPresentationsSettingsPage();

        if (fieldName.equalsIgnoreCase("presentation name")) {
            page.fillPresentationNameField(wrapVariableWithTestSession(fieldValue));
        } else if (fieldName.equalsIgnoreCase("description")) {
            page.fillDescriptionField(fieldValue);
        } else if (fieldName.equalsIgnoreCase("seconds of black between each asset")) {
            page.fillBetweenAssetField(fieldValue);
        } else if (fieldName.equalsIgnoreCase("if assets have no duration display for")) {
            page.fillNoDurationForField(fieldValue);
        } else {
            throw new IllegalArgumentException(String.format("Unknown field '%s' for presentation settings tab", fieldName));
        }
    }

    @Given("{I |}saved settings for current presentation")
    @When("{I |}save settings for current presentation")
    public void saveSettings() {
        getSut().getPageCreator().getLibraryPresentationsSettingsPage().clickSaveButton();
    }

    @When("{I |}cancel settings for current presentation")
    public void cancelSettings() {
        getSut().getPageCreator().getLibraryPresentationsSettingsPage().clickCancelLink();
    }

    @Then("{I |}'$condition' see presentation name '$name' on presentation settings page")
    public void checkThatPresentationNameDisplayedCorrectly(String condition, String name) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualName = getSut().getPageCreator().getLibraryPresentationsSettingsPage().getFieldValue("Name");
        String expectedName = wrapVariableWithTestSession(name);

        assertThat(actualName, shouldState ? equalTo(expectedName) : not(equalTo(expectedName)));
    }

    @Then("{I |}'$condition' see presentation description '$expectedDescription' on presentation settings page")
    public void checkThatPresentationDescriptionDisplayedCorrectly(String condition, String expectedDescription) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualDescription = getSut().getPageCreator().getLibraryPresentationsSettingsPage().getFieldValue("Description");

        assertThat(actualDescription, shouldState ? equalTo(expectedDescription) : not(equalTo(expectedDescription)));
    }
    // NGN-16214-Presentations / Reels autoplay code changes starts
    @Then("{I |}'$condition' see autoplay '$state' on presentation settings page")
    public void checkThatPresentationAutoplaycheckedBydefault(String condition, boolean state) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualstate = getSut().getPageCreator().getLibraryPresentationsSettingsPage().isAutoPlayChecked();
        assertThat(actualstate, shouldState ? equalTo(state) : not(equalTo(state)));
    }

    @When("{I |} '$action' Autoplay option with value '$state' on presentation settings page")
    public void checkAutoPlay(String action,boolean state) {
        AdbankLibraryPresentationsSettingsPage page = getSut().getPageCreator().getLibraryPresentationsSettingsPage();
        page.checkAutoplayElement(action,state);
        page.clickSaveButton();
    }

    @Then("{I |}'$should' see autoplayable preview on presentation preview page")
    public void isPlayserAvailable(String should) {
        boolean shouldState = should.equalsIgnoreCase("should");
        AdbankPresentationPreviewPage page = getSut().getPageCreator().getPresentationPreviewPage();
        Common.sleep(1000);
        boolean actualState = page.isAutoPlayable();
        assertThat("Video player are not available", shouldState == actualState);
    }

    // NGN-16214-Presentations / Reels autoplay code changes Ends

    // | Name | Description |
    @Then("{I |}'$condition' see following data on presentation settings page: $data")
    public void checkThatPresentationInfoDisplayedCorrectly(String condition, ExamplesTable data) {
        Map<String, String> fields = parametrizeTabularRow(data);

        checkThatPresentationNameDisplayedCorrectly(condition, fields.get("Name"));
        checkThatPresentationDescriptionDisplayedCorrectly(condition, fields.get("Description"));
    }

}