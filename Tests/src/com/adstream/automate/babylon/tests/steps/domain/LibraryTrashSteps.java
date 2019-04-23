package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectTrashPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryTrashPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

public class LibraryTrashSteps extends BaseStep {

    @Given("{I am |}on the Library trash page")
    @When("{I |}go to the Library trash page")
    public AdbankLibraryTrashPage openLibraryTrashPage() {
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getLibraryTrashPage();
    }

    @Given("{I |}restored assets '$assets' from library trash page")
    @When("{I |}restore assets '$assets' from library trash page")
    public void restoreAssetFromTrash(String assets) {
        AdbankLibraryTrashPage libraryTrashPage = openLibraryTrashPage();

        for (String asset : assets.split(",")) {
            libraryTrashPage.selectFileByFileName(asset);
        }

        libraryTrashPage.clickRestoreButton().action.click();
        Common.sleep(2000);
    }

    @Given("{I |}selected assets '$assets' on library trash page")
    @When("{I |}select assets '$assets' on library trash page")
    public void selectAssetFromTrash(String assets) {
        AdbankLibraryTrashPage libraryTrashPage = openLibraryTrashPage();

        for (String asset : assets.split(",")) {
            libraryTrashPage.selectFileByFileName(asset);
        }
    }

    @When("{I |}click asset restore button on library trash page")
    public void clickRestoreButtonOnTrashPage() {
        AdbankLibraryTrashPage libraryTrashPage = getSut().getPageCreator().getLibraryTrashPage();
        libraryTrashPage.clickRestoreButton();
        Common.sleep(2000);
    }

    @When("{I |}click element '$element' on restore confirmation popup on library trash page")
    public void clickElementOnRestoreConfirmationPopup(String element) {
        PopUpWindow popup = new PopUpWindow(getSut().getPageCreator().getLibraryTrashPage());

        if (element.equalsIgnoreCase("ok")) {
            popup.action.click();
        } else if (element.equalsIgnoreCase("cancel")) {
            popup.cancel.click();
        } else if (element.equalsIgnoreCase("close")) {
            popup.close.click();
        } else {
            throw new IllegalArgumentException(String.format("Unknown element '%s' for Confirm popup", element));
        }
        Common.sleep(2000);
    }

    @When("{I |}click asset '$assetName' on library trash page")
    public void openAssetDetails(String assetName) {
        getSut().getPageCreator().getLibraryTrashPage().navigateToAssetInfoPage(assetName);
    }

    @When("{I |}select Select All checkbox on library trash page")
    public void selectAllAssets() {
        getSut().getPageCreator().getLibraryTrashPage().selectSelectAllCheckbox();
    }

    @When("{I |}deselect Select All checkbox on library trash page")
    public void deselectAllAssets() {
        getSut().getPageCreator().getLibraryTrashPage().deselectSelectAllCheckbox();
    }

    @When("{I |}switch to '$typeView' view in the library trash page")
    public void switchToFilesView(String typeView) {
        AdbankLibraryTrashPage page = getSut().getPageCreator().getLibraryTrashPage();
        if (typeView.equalsIgnoreCase("tile"))
            page.clickTileView();
        else if (typeView.equalsIgnoreCase("list"))
            page.clickListView();
        else
            throw new IllegalArgumentException("Type of file's view is undefined");
    }


    @When("{I |}click '$element' button on Library trash page")
    public void deselectClickNavigationElement(String element) {
        AdbankLibraryTrashPage libraryTrashPage = getSut().getPageCreator().getLibraryTrashPage();
        if (element.equalsIgnoreCase("next")) {
            libraryTrashPage.clickNextButton();
        } else if (element.equalsIgnoreCase("previous")) {
            libraryTrashPage.clickPrevButton();
        } else {
            throw new IllegalArgumentException(String.format("Unknown navigation element '%s' for trash page", element));
        }
    }

    @Then("{I |}'$condition' see assets with titles '$assetsTitles' in the Library Trash bin")
    public void checkAssetsVisibilityInTrashBin(String condition, String assetsTitles) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = getSut().getPageNavigator().getLibraryTrashPage().getPresentedAssetsTitles();

        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }
    }

    @Then("{I |}'$condition' see '$expectedCount' assets with the same '$expectedAssetTitle' name on Library trash page")
    public void checkAssetsVisibilityInTrashBin(String condition, int expectedCount, String expectedAssetTitle) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = getSut().getPageNavigator().getLibraryTrashPage().getPresentedAssetsTitles();
        int actualCount = 0;

        for (String actualAssetTitle : actualAssetsTitles) {
            if (actualAssetTitle.equalsIgnoreCase(expectedAssetTitle)) actualCount += 1;
        }

        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));
    }

    @Then("{I |}should see '$count' selected note in files counter on Library trash page")
    public void checkSelectedCounter(String count) {
        AdbankLibraryTrashPage libraryTrashPage = getSut().getPageCreator().getLibraryTrashPage();
        assertThat(count, equalTo(libraryTrashPage.getLabelsValueAboutCountSelectedFiles()));
    }

    @Then("{I |}'$condition' see active page '$expectedPageNumber' on Library trash page")
    public void checkCurrentPage(String condition, String expectedPageNumber) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualPageNumber = getSut().getPageCreator().getLibraryTrashPage().getCurrentPageNumber();

        assertThat(actualPageNumber, shouldState ? equalTo(expectedPageNumber) : not(equalTo(expectedPageNumber)));
    }

    @Then("{I |}'$condition' see asset count '$expectedCount' on Library trash page")
    public void checkAssetCount(String condition, int expectedCount) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        int actualCount = getSut().getPageCreator().getLibraryTrashPage().getPresentedAssetsNames().size();

        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));
    }

    @Then("{I |}should see for library trash page files in the '$typeView' view")
    public void checkFilesViewState(String typeView) {
        boolean shouldState = typeView.equalsIgnoreCase("list");
        AdbankLibraryTrashPage page = getSut().getPageCreator().getLibraryTrashPage();
        assertThat(page.isViewOfFilesIsList(), equalTo(shouldState));
    }

}