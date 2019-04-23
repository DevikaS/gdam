package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddNewPresentationPopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankLibraryPresentationsPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.hamcrest.Matcher;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.10.12
 * Time: 18:51

 */
public abstract class LibraryPresentationsSteps  extends BaseStep {

    public abstract AdbankLibraryPresentationsPage getLibraryPresentationsPage();

    public abstract AdbankLibraryPresentationsPage getLibraryPresentationsPage(String presentationId);

    public void checkThatPresentationExistInMenu(boolean shouldState, String presentationName) {
        String expectedReelName = wrapVariableWithTestSession(presentationName);
        List<String> actualReelNamesList = getSut().getPageCreator().getLibraryPresentationsPage().getReelsItemsList();
        assertThat(actualReelNamesList, shouldState ? hasItem(expectedReelName) : not(hasItem(expectedReelName)));
    }

    public void checkThatPresentationExistInList(boolean shouldState, String presentationName) {
        presentationName = wrapVariableWithTestSession(presentationName);
        AdbankLibraryPresentationsPage libraryPresentationsPage = getSut().getPageCreator().getLibraryPresentationsPage();
        Matcher matcher = shouldState ? isIn(libraryPresentationsPage.getPresentationsList()) : not(isIn(libraryPresentationsPage.getPresentationsList()));
        assertThat(presentationName, matcher);
    }


    public void checkThatAllPresentationsSelected(boolean shouldState) {
        AdbankLibraryPresentationsPage libraryPresentationsPage = getSut().getPageCreator().getLibraryPresentationsPage();
        assertThat(libraryPresentationsPage.getPresentationsList("unselected").isEmpty(), is(shouldState));
    }

     public void checkThatAllPresentationsDeselected(boolean shouldState) {
        AdbankLibraryPresentationsPage libraryPresentationsPage = getSut().getPageCreator().getLibraryPresentationsPage();
        assertThat(libraryPresentationsPage.getPresentationsList("selected").isEmpty(), is(shouldState));
    }

    public void checkThatPresentationCreatedDateIsCorrect(boolean shouldState, String expectedDate, String presentationName, String dateTimeFormat) {
        AdbankLibraryPresentationsPage libraryPresentationsPage = getSut().getPageCreator().getLibraryPresentationsPage();
        String actualDate = DateTimeUtils.getFormattedUTCDate(libraryPresentationsPage.getPresentationDateCreated(presentationName), dateTimeFormat);
        assertThat(actualDate, shouldState ? equalTo(expectedDate) : not(equalTo(expectedDate)));
    }

    public void checkThatPresentationDurationIsCorrect(boolean shouldState, String expectedDuration, String presentationName) {
        AdbankLibraryPresentationsPage libraryPresentationsPage = getSut().getPageCreator().getLibraryPresentationsPage();
        String actualDuration = libraryPresentationsPage.getPresentationDuration(presentationName);
        assertThat(actualDuration, shouldState ? equalTo(expectedDuration) : not(equalTo(expectedDuration)));
    }

    public void checkThatPresentationViewsIsCorrect(boolean shouldState, String expectedViews, String presentationName) {
        AdbankLibraryPresentationsPage libraryPresentationsPage = getSut().getPageCreator().getLibraryPresentationsPage();
        String actualViews = libraryPresentationsPage.getPresentationViews(presentationName);
        assertThat(actualViews, shouldState ? equalTo(expectedViews) : not(equalTo(expectedViews)));
    }

    public void checkThatPresentationSearchPopupHasPresentation(boolean shouldState, String presentationName) {
        List<String> presentations = getSut().getPageCreator().getLibraryPresentationsPage().getPresentationSearchResultItems();
        if (presentationName.isEmpty()) {
            assertThat(presentations.isEmpty(), shouldState ? is(shouldState) : not(is(shouldState)));
        } else {
            assertThat(presentations, shouldState ? hasItem(presentationName) : not(hasItem(presentationName)));
        }
    }

    public void checkThatOpenedTabIs(boolean shouldState, String expectedTabName) {
        expectedTabName = expectedTabName.toLowerCase();
        String actualTabName = getSut().getPageCreator().getLibraryPresentationsPage().getActiveTabName().toLowerCase();
        assertThat(actualTabName, shouldState ? equalTo(expectedTabName) : not(equalTo(expectedTabName)));
    }

    public void checkThatOpenedPresentationIs(boolean shouldState, String expectedPresentationName) {
        expectedPresentationName = expectedPresentationName.toLowerCase();
        String actualPresentationName = getSut().getPageCreator().getLibraryPresentationsPage().getPresentationName().toLowerCase();
        assertThat(actualPresentationName, shouldState ? equalTo(expectedPresentationName) : not(equalTo(expectedPresentationName)));
    }

    public void checkThatPresentationsListDisplayedCorrectly(boolean shouldState, List<String> actualPresentations, List<String> expectedPresentations) {
        assertThat(actualPresentations, shouldState ? equalTo(expectedPresentations) : not(equalTo(expectedPresentations)));
    }

    public void createReel(ExamplesTable reelFields) {
        for (int i = 0; i < reelFields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(reelFields, i);
            Reel reel = new Reel();
            reel.setName(wrapVariableWithTestSession(row.get("Name")));
            if (row.get("Description") == null)
                row.put("Description", "");
            reel.setDescription(row.get("Description"));
            if (getCoreApi().getReelByName(reel.getName(), 0) == null) {
                getCoreApi().createReel(reel);
                getCoreApi().getReelByName(reel.getName());
            }
        }
    }

    public void createReel(String[] NameArray, String description) {
        for (String reelName : NameArray) {
            Reel reel = new Reel();
            reel.setName(wrapVariableWithTestSession(reelName));
            reel.setDescription(description);
            if (getCoreApi().getReelByName(reel.getName(), 0) == null) {
                getCoreApi().createReel(reel);
                getCoreApi().getReelByName(reel.getName());
            }
        }
    }

    protected void addNewPresentation(String presentationName, String description) {
        presentationName = wrapVariableWithTestSession(presentationName);
        Common.sleep(1000);
        AdbankLibraryPresentationsPage libraryPresentationsPage = getSut().getPageCreator().getLibraryPresentationsPage();
        AddNewPresentationPopUpWindow newPresentationPopUpWindow = libraryPresentationsPage.clickAddToPresentationButton();
        newPresentationPopUpWindow.setName(wrapVariableWithTestSession(presentationName));
        newPresentationPopUpWindow.setDescription(description);
        newPresentationPopUpWindow.action.click();
        Common.sleep(1500);
    }

    protected void cancelAddNewPresentation(String presentationName, String description, String action) {
        presentationName = wrapVariableWithTestSession(presentationName);
        AdbankLibraryPresentationsPage libraryPresentationsPage = getSut().getPageCreator().getLibraryPresentationsPage();
        AddNewPresentationPopUpWindow newPresentationPopUpWindow = libraryPresentationsPage.clickAddToPresentationButton();
        newPresentationPopUpWindow.setName(presentationName);
        newPresentationPopUpWindow.setDescription(description);
        if (action.equalsIgnoreCase("Cross")) newPresentationPopUpWindow.close.click();
        else if (action.equalsIgnoreCase("Cancel")) newPresentationPopUpWindow.cancel.click();
        else Assert.fail("Please verify example parametrs!");
        Common.sleep(1000);
    }

    protected void createNewReelThroughUI(String reelName, String descriptionName) {
        AdbankLibraryPresentationsPage libraryPresentationsPage = getLibraryPresentationsPage();
        AddNewPresentationPopUpWindow newPresentationPopUpWindow = libraryPresentationsPage.clickAddToPresentationButton();
        newPresentationPopUpWindow.setName(wrapVariableWithTestSession(reelName));
        newPresentationPopUpWindow.setDescription(descriptionName);
        newPresentationPopUpWindow.action.click();
    }
}