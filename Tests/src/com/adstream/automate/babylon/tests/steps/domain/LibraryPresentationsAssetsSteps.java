package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.SendPresentationPopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsAssetsPage;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;


/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.10.12
 * Time: 18:52

 */
public class LibraryPresentationsAssetsSteps extends LibraryPresentationsSteps{

    public AdbankLibraryPresentationsAssetsPage getLibraryPresentationsPage() {
        return getSut().getPageCreator().getLibraryPresentationsAssetsPage();
    }

    public AdbankLibraryPresentationsAssetsPage getLibraryPresentationsPage(String presentationId) {
        return getSut().getPageNavigator().getLibraryPresentationsAssetsPage(presentationId);
    }

    @When("I delete asset '$assetName' from '$presentationName' presentation")
    public void deleteAssetFromPresentation(String assetName, String presentationName) {
        getLibraryPresentationsPage(getCoreApiAdmin().getReelByName(wrapVariableWithTestSession(presentationName)).getId());
        deleteAssetFromCurrentPresentation(assetName);
    }


    @Given("{I am |}on the presentations assets page '$presentationName'")
    @When("{I |}go to the presentations assets page '$presentationName'")
    public AdbankLibraryPresentationsAssetsPage openLibraryPresentationAssetsPage(String presentationName) {
        String presentationId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        return getSut().getPageNavigator().getLibraryPresentationsAssetsPage(presentationId);
    }

    @When("I open Send presentation popup")
    public SendPresentationPopUpWindow openSendPresentationPopup() {
        return getLibraryPresentationsPage().clickSendPresentationButton().clickSendToUserButton();
    }

    @Given("I am on the presentations assets page")
    @When("{I |}go to the presentations assets page")
    public void openLibraryPresentationAssetsPage() {
        getSut().getPageNavigator().getLibraryAllPresentationsPage();
    }

    @Given("{I |}scrolled down to footer '$times' times on opened Presentation page")
    @When("{I |}scroll down to footer '$times' times on opened Presentation page")
    public void scrollDownToFooter(int times) {
        for (int i = 0; i < times; i++) getSut().getPageCreator().getLibraryPresentationsPage().scrollDownToFooter();
    }

    // | Name | Description |
    @Given("{I |}created following reels: $reelsTable")
    @When("{I |}create following reels: $reelsTable")
    public void createReels(ExamplesTable reelsTable) {
        createReel(reelsTable);
    }

    @Given("{I |}created '$presentationNames' reels with description '$description'")
    @When("{I |}create '$presentationNames' reels with description '$description'")
    public void createReels(String presentationNames, String description) {
        createReel(presentationNames.split(","), description);
    }

    @Given("{I |}created new presentation with name '$presentationName' and description '$description' from presentation page")
    @When("{I |}create new presentation with name '$presentationName' and description '$description' from presentation page")
    public void createNewPresentation(String presentationName, String description) {
        addNewPresentation(presentationName, description);
    }

    @Given("I '$action' add presentation with name '$presentationName' and description '$description' from presentation page")
    @When("I '$action' add presentation with name '$presentationName' and description '$description' from presentation page")
    public void crossCancelCreateNewPresentation(String action, String presentationName, String description) {
        cancelAddNewPresentation(presentationName, description, action);
    }

    // option: Originals, Proxies, Original + Proxy
    @Given(value = "{I |}sent presentation '$presentationName' to user '$userName' with personal message '$message' and download option '$option'", priority = 1)
    @When(value = "{I |}send presentation '$presentationName' to user '$userName' with personal message '$message' and download option '$option'", priority = 1)
    public void sendPresentationToUser(String presentationName, String userName, String message, String option) {
        sendPresentationForUser(presentationName, userName, message, option);
    }

    @Given("{I |}sent presentation '$presentationName' to user '$userName' with personal message '$message'")
    @When("{I |}send presentation '$presentationName' to user '$userName' with personal message '$message'")
    public void sendPresentationToUser(String presentationName, String userName, String message) {
        sendPresentationForUser(presentationName, userName, message, "Original + Proxy");
    }

    @Given("{I |}sent presentation '$presentationName' to user '$userName' with personal message '$message' and without download permission")
    @When("{I |}send presentation '$presentationName' to user '$userName' with personal message '$message' and without download permission")
    public void sendPresentationToUserWithoutDownloadPermission(String presentationName, String userName, String message) {
        sendPresentationForUser(presentationName, userName, message, "");
    }

    @Given("{I |}on the presentation '$presentationName' popup on tab '$tabName'")
    @When("{I |}go to the presentation '$presentationName' popup on tab '$tabName'")
    public void openPresentationSharePopUp(String presentationName, String tabName) {
        AdbankLibraryPresentationsAssetsPage page = openLibraryPresentationAssetsPage(presentationName);
        SendPresentationPopUpWindow popup = page.clickSendPresentationButton().clickSendToUserButton();
        popup.switchBetweenTab(tabName);
    }

    @Given("{I |}clicked activate public share button for presentation '$presentationName'")
    @When("{I |}click activate public share button for presentation '$presentationName'")
    public void clickActivateButton(String presentationName) {
        AdbankLibraryPresentationsAssetsPage page = openLibraryPresentationAssetsPage(presentationName);
        SendPresentationPopUpWindow popup = page.clickSendPresentationButton().clickSendToUserButton();
        popup.switchBetweenTab("Public share");
        popup.clickActivateButton();
    }

    @Given("{I |}sent presentation '$presentationName' by public link to user '$userName' with personal message '$message' with option '$option'")
    @When("{I |}send presentation '$presentationName' by public link to user '$userName' with personal message '$message' with option '$option'")
    public void sendPresentationByPublicShare(String presentationName, String userName, String message, String option) {
        AdbankLibraryPresentationsAssetsPage page = openLibraryPresentationAssetsPage(presentationName);
        String email = wrapUserEmailWithTestSession(userName);
        SendPresentationPopUpWindow popup = page.clickSendPresentationButton().clickSendToUserButton();
        popup.switchBetweenTab("Public share");
        popup.clickActivateButton();
        popup.selectPublicShareUser(email);
        popup.typeMessagePublicShare(message);
        popup.setDownloadOption(option, SendPresentationPopUpWindow.TypeOfShare.PUBLIC);
        popup.clickSendButton();
    }

    @Given("{I |}setted '$type' experation date '$date' for current presentation on opened popup")
    @When("{I |}set '$type' experation date '$date' for current presentation on opened popup")
    public void setExperationDateForCurrentPresentation(String type, String date) {
        SendPresentationPopUpWindow popUp = new SendPresentationPopUpWindow(this.getLibraryPresentationsPage());
        DateTime expiredDateTime = DateTimeFormat.forPattern(TestsContext.getInstance().storiesDateTimeFormat).parseDateTime(date);
        popUp.switchBetweenTab(type);
        popUp.setExpirationDate(expiredDateTime.toString(getData().getCurrentUser().getDateTimeFormatter().getDateFormat()));
    }

    @When("{I |}switch '$state' Allow presentation download checkbox with selecting option '$option' for presentation '$presentationName' for '$type'")
    public void selectDownloadOptions(String state, String option, String presentationName, String type) {
        SendPresentationPopUpWindow popUp = new SendPresentationPopUpWindow(this.getLibraryPresentationsPage());
        boolean stateOn = state.equals("on");
        popUp.setAllowPresentationDownloadByState(stateOn);
        SendPresentationPopUpWindow.TypeOfShare tab = (type.equalsIgnoreCase("public")) ?
                SendPresentationPopUpWindow.TypeOfShare.PUBLIC :
                SendPresentationPopUpWindow.TypeOfShare.SECURE;
        if (stateOn) popUp.setDownloadOption(option, tab);
    }

    @Given("{I |}shared presentation '$presentationName' to user '$userName' with personal message '$message'")
    @When("{I |}share presentation '$presentationName' to user '$userName' with personal message '$message'")
    public void sharePresentationToUser(String presentationName, String userEmails, String message) {
        String presentationId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        List<String> userIds = new ArrayList<>();
        for (String userEmail : userEmails.split(",")) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
            userIds.add(user == null ? wrapUserEmailWithTestSession(userEmail) : user.getId());
        }

        getCoreApi().sharePresentationToUsers(presentationId, userIds, message);
    }

    @Given("{I |}sent presentation '$presentationName' to library team '$libraryTeamName' with personal message '$message'")
    @When("{I |}send presentation '$presentationName' to library team '$libraryTeamName' with personal message '$message'")
    public void sendPresentationToLibraryTeam(String presentationName, String libraryTeamName, String message) {
        SendPresentationPopUpWindow popup = openLibraryPresentationAssetsPage(presentationName).clickSendPresentationButton().clickSendToLibraryTeamButton();
        popup.selectRecipients(wrapVariableWithTestSession(libraryTeamName));
        popup.typeMessage(message);
        popup.clickAction();
    }

    @Given("{I |}deleted share for '$userEmail' agency user from '$presentationName' presentation")
    @When("{I |}delete share for '$userEmail' agency user from '$presentationName' presentation")
    public void deleteShareForPresentation(String userEmail, String presentationName) {
        SendPresentationPopUpWindow popup = openLibraryPresentationAssetsPage(presentationName).clickSendPresentationButton().clickSendToUserButton();
        popup.openUsersViewingThisPresentationTab();
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
        popup.removeUser(user.getFirstName(), user.getLastName()).action.click();
        Common.sleep(1000);
        popup.cancel.click();
        Common.sleep(1000);
    }

    @Given("{I |}deleted share for '$userEmail' user from '$presentationName' presentation to Library team popup")
    @When("{I |}delete share for '$userEmail' user from '$presentationName' presentation to Library team popup")
    public void deleteShareForUserFromShareToLibraryTeam(String userEmail, String presentationName) {
        SendPresentationPopUpWindow popup = openLibraryPresentationAssetsPage(presentationName).clickSendPresentationButton().clickSendToLibraryTeamButton();
        popup.openUsersViewingThisPresentationTab();
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
        popup.removeUser(user.getFirstName(), user.getLastName()).action.click();
        Common.sleep(1000);
        popup.cancel.click();
        Common.sleep(1000);
    }

    @When("{I |}initiate deleting '$userEmail' from '$presentationName' presentation")
    public void initDeletingShareForPresentation(String userEmail, String presentationName) {
        SendPresentationPopUpWindow popup = openLibraryPresentationAssetsPage(presentationName).clickSendPresentationButton().clickSendToUserButton();
        popup.openUsersViewingThisPresentationTab();
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
        popup.removeUser(user.getFirstName(), user.getLastName());
    }

    @When("{I |}click Send Presentation button on presentation '$presentationName' assets page")
    public void clickSendPresentationButton(String presentationName) {
        openLibraryPresentationAssetsPage(presentationName).clickSendPresentationButton();
    }

    @When("{I |}click '$elementName' on 'Users viewing this presentation' tab of 'Send presentation' popup")
    public void clickElementOnDeleteConfirmationPopup(String elementName) {
        PopUpWindow confirmationPopup = new PopUpWindow(getLibraryPresentationsPage());
        if (elementName.equalsIgnoreCase("ok")) {
            confirmationPopup.action.click();
        } else if (elementName.equalsIgnoreCase("cancel")) {
            confirmationPopup.cancel.click();
        } else if (elementName.equalsIgnoreCase("cross")) {
            confirmationPopup.close.click();
        }
    }

    // | Presentation | User | Message |
    @Given("{I |}sent following presentations next to users: $dataTable")
    @When("{I |}send following presentations next to users: $dataTable")
    public void sendPresentationsToUsers(ExamplesTable dataTable) {
        for (int i = 0; i < dataTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(dataTable, i);
            String message = (row.get("Message")!=null && !row.get("Message").isEmpty())?row.get("Message"):"";
            sendPresentationToUser(row.get("Presentation"), row.get("User"), message);
        }
    }

    @When("I '$action' asset '$assetName' in the current presentation page")
    public void clickAssets(String action, String assetName) {
        AdbankLibraryPresentationsAssetsPage libraryPresentationsAssetsPage = getSut().getPageCreator().getLibraryPresentationsAssetsPage();
        for (String fileName: assetName.split(",")) {
            boolean isAssetSelected = libraryPresentationsAssetsPage.getClassOfAssetByFileName(fileName).contains("selected".toLowerCase());
            if ((!isAssetSelected && action.equalsIgnoreCase("select")) || (isAssetSelected && action.equalsIgnoreCase("deselect"))) {
                libraryPresentationsAssetsPage.clickAssetByFileName(fileName);
            }
        }

    }

    @When("I drag and drop '$assetName' asset into '$destinationAssetName' asset place")
    public void moveAssetToAnotherAssetPlace(String assetName, String destinationAssetName) {
        AdbankLibraryPresentationsAssetsPage libraryPresentationsAssetsPage = getSut().getPageCreator().getLibraryPresentationsAssetsPage();
        libraryPresentationsAssetsPage.moveAssetToAnotherAssetPlace(assetName, destinationAssetName);
    }

    @When("I click 'Select all' checkbox on asset presentation page")
    public void clickSelectAllCheckbox() {
        AdbankLibraryPresentationsAssetsPage libraryPresentationsAssetsPage = getSut().getPageCreator().getLibraryPresentationsAssetsPage();
        libraryPresentationsAssetsPage.clickSelectAllCheckbox();
    }

    @When("I delete asset '$assetName' from current presentation page")
    public void deleteAssetFromCurrentPresentation(String assetName) {
        AdbankLibraryPresentationsAssetsPage libraryPresentationsAssetsPage = getSut().getPageCreator().getLibraryPresentationsAssetsPage();

        for (String fileName: assetName.split(",")) {
            if (!libraryPresentationsAssetsPage.getClassOfAssetByFileName(fileName).contains("selected".toLowerCase())) {
                libraryPresentationsAssetsPage.clickAssetByFileName(fileName);
            }
        }

        PopUpWindow popUpWindow = libraryPresentationsAssetsPage.clickDeleteButton();
        popUpWindow.action.click();
        Common.sleep(2000);
    }

    @When("I click 'Open File' link on asset '$assetName'")
    public void clickOpenFileLink(String assetName) {
        getSut().getPageCreator().getLibraryPresentationsAssetsPage().clickOpenFileLink(assetName);
    }

    @When("I try to add user '$userEmail' on 'Send presentation' popup")
    public void tryToAddUsersIntoPresentation(String userEmail) {
        SendPresentationPopUpWindow popup = new SendPresentationPopUpWindow(getLibraryPresentationsPage());
        popup.typeTextIntoUserEmailField(wrapUserEmailWithTestSession(userEmail));
    }

    @When("{I |}try to add library team '$teamName' on 'Send presentation' popup")
    public void tryToAddLibraryTeamIntoPresentation(String teamName) {
        getLibraryPresentationsPage().clickSendPresentationButton().clickSendToLibraryTeamButton().
                typeTextIntoUserEmailField(wrapVariableWithTestSession(teamName));
    }

    @Given("{I |}clicked following activity '$activity' on opened presentations page")
    @When("{I |}click following activity '$activity' on opened presentations page")
    public void clickOnActivity(String activity) {
        getSut().getPageCreator().getLibraryPresentationsPage().clickLinkActivity(wrapVariableWithTestSession(activity));
    }


    @Then("{I |}'$condition' see Send To User button on opened presentation page")
    public void checkThatSendToUserButtonVisible(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getLibraryPresentationsPage().isSendToUserButtonVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see Send To Library Team button on opened presentation page")
    public void checkThatSendToLibraryTeamButtonVisible(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getLibraryPresentationsPage().isSendToLibraryTeamButtonVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see presentation '$presentationName' on the page")
    public void checkPresentationInThePresentationMenu(String condition, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (String pN: presentationName.split(",")) {
            checkThatPresentationExistInMenu(shouldState, pN);
        }
    }

    // | Name |
    @Then("I '$condition' see the following presentations in presentations '$presentationPlace': $presentationsTable")
    public void checkPresentationsInPresentationMenuOrList(String condition, String presentationPlace, ExamplesTable presentationsTable) {
        Common.sleep(1000);
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (Map<String, String> row : presentationsTable.getRows()) {
            if (presentationPlace.equalsIgnoreCase("menu")) {
                checkThatPresentationExistInMenu(shouldState, row.get("Name"));
            } else if (presentationPlace.equalsIgnoreCase("list")) {
                checkThatPresentationExistInList(shouldState, row.get("Name"));
            }
        }
    }

    // | Name |
    @Then("I '$condition' see the following presentations in presentations menu and list: $presentationsTable")
    public void checkPresentationsInPresentationMenuAndList(String condition, ExamplesTable presentationsTable) {
        checkPresentationsInPresentationMenuOrList(condition, "menu", presentationsTable);
        checkPresentationsInPresentationMenuOrList(condition, "list", presentationsTable);
    }

    @Then("I '$condition' see $selectedCondition all presentations in the list")
    public void checkAllPresentationsSelected(String condition, String selectedCondition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean selectedState = selectedCondition.equalsIgnoreCase("selected");

        if (selectedState) {
            checkThatAllPresentationsSelected(shouldState);
        } else {
            checkThatAllPresentationsDeselected(shouldState);
        }
    }

    // | Cell | Value |
    @Then("I '$condition' see the following information for '$presentationName' presentation on presentation list: $presentationCellTable")
    public void checkThatPresentationHasInformation(String condition, String presentationName, ExamplesTable presentationCellTable) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        for(Map<String, String>row : presentationCellTable.getRows()) {
            if (row.get("Cell").equalsIgnoreCase("datecreated") || row.get("Cell").equalsIgnoreCase("datemodified")) {
                String expectedDateCreated = row.get("Value");
                String dateTimeFormat = getData().getCurrentUser().getDateTimeFormatter().getDateTimeFormat();
                if (expectedDateCreated.equalsIgnoreCase("Today")) {
                    Reel reel = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName));
                    expectedDateCreated = DateTimeUtils.formatDate(reel.getCreated(), dateTimeFormat);
                } else {
                    expectedDateCreated = DateTimeUtils.formatDate(new DateTime(expectedDateCreated), dateTimeFormat);
                }
                checkThatPresentationCreatedDateIsCorrect(shouldState, expectedDateCreated, wrapVariableWithTestSession(presentationName), dateTimeFormat);
            } else if (row.get("Cell").equalsIgnoreCase("duration")) {
                checkThatPresentationDurationIsCorrect(shouldState, row.get("Value"), wrapVariableWithTestSession(presentationName));
            } else if (row.get("Cell").equalsIgnoreCase("views")) {
                checkThatPresentationViewsIsCorrect(shouldState, row.get("Value"), wrapVariableWithTestSession(presentationName));
            }
        }
    }

    @Then("{I |}should see items count '$count' on the presentations page")
    public void checkCountOfItemsOnProjectSearchPage(String count) {
        AdbankLibraryPresentationsAssetsPage presentationsAssetsPage = getSut().getPageCreator().getLibraryPresentationsAssetsPage();
        assertThat(presentationsAssetsPage.getItemsCount(), equalTo(Integer.parseInt(count)));
    }

    @Then("{I |}'$condition' be on Presentation Assets page")
    public void checkThatPresentationAssetsPageOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;
        try {
            getLibraryPresentationsPage();
        } catch (Exception e) {
            actualState = false;
        }

        assertThat(actualState, is(expectedState));
    }

    @Then("I '$condition' see user '$userEmail' is available for selecting on Send presentation popup")
    public void checkUserIsAvailableInSearchResults(String condition, String userEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        SendPresentationPopUpWindow sendPresentationPopUpWindow = new SendPresentationPopUpWindow(getLibraryPresentationsPage());
        userEmail = wrapUserEmailWithTestSession(userEmail);
        boolean actual = sendPresentationPopUpWindow.isUserPresentInAddUserSearchResults(userEmail);
        assertThat("User with email " + userEmail + " is available for selecting", actual, is(shouldState));
    }

    @Then("{I |}'$condition' see library team '$teamName' is available for selecting on Send presentation popup")
    public void checkLibraryTeamIsAvailableInSearchResults(String condition, String teamName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = new SendPresentationPopUpWindow(getLibraryPresentationsPage()).
                isLibraryTeamPresentInAddUserSearchResults(wrapVariableWithTestSession(teamName));

        assertThat(actualState, is(expectedState));
    }

    @Then("I '$condition' see the folloving assets ordering: $orderingTable")
    public void checkAssetsOrdering(String condition, ExamplesTable orderingTable) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPresentationsAssetsPage libraryPresentationsAssetsPage = getSut().getPageCreator().getLibraryPresentationsAssetsPage();
        for(Map<String, String>row : orderingTable.getRows()) {
            String actualNumbed = libraryPresentationsAssetsPage.getAssetOrderNumber(row.get("AssetsName"));
            String expectedNumbed = row.get("Number");
            assertThat(actualNumbed, shouldState ? equalTo(expectedNumbed) : not(equalTo(expectedNumbed)));
        }
    }

    @Then("{I |}'$condition' see asset '$assetName' in the current presentation")
    public void checkAssetVisibility(String condition, String assetName) {
        AdbankLibraryPresentationsAssetsPage page = getSut().getPageCreator().getLibraryPresentationsAssetsPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (String asset: assetName.split(",")) {
            assertThat(page.isFilesPresent(asset), equalTo(shouldState));
        }
    }

    @Then("{I |}'$shouldState' see assets '$assetName' in presentation '$presentationName'")
    public void checkPresentationsAssets(String shouldState, String assetName, String presentationName) {
        String presentationId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        AdbankLibraryPresentationsAssetsPage presentationsAssetsPage = getSut().getPageNavigator().getLibraryPresentationsAssetsPage(presentationId);
        boolean should = shouldState.equals("should");
        for (String asset : assetName.split(",")) {
            assertThat(presentationsAssetsPage.isFilesPresent(asset), equalTo(should));
        }
    }

    @Then("{I |}should count '$count' thumbnails in the current presentation")
    public void checkCountOfThumbnails(int count) {
        assertThat(getSut().getPageCreator().getLibraryPresentationsAssetsPage().getPreviewCountOnThePage(), equalTo(count));
    }

    @Then("{I |}should see '$count' assets in the current presentation")
    public void checkCountOfAssets(int count) {
        assertThat(getSut().getPageCreator().getLibraryPresentationsAssetsPage().getPresentationAssetsCount(), equalTo(count));
    }

    @Then("I should see count '$count' assets '$assetName' in the current presentation")
    public void checkCountOfAssets(int count, String assetName) {
        assertThat(getSut().getPageCreator().getLibraryPresentationsAssetsPage().getFilesCountByFileName(assetName), equalTo(count));
    }

    @Then("I '$condition' see displayed presentations '$presentations' on search popup")
    public void checkThatSearchPopupContainsPresentation(String condition, String presentations) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        for(String presentationName : presentations.split(",")) {
            checkThatPresentationSearchPopupHasPresentation(shouldState, wrapVariableWithTestSession(presentationName));
        }
    }

    @Then("I '$condition' see opened tab '$tabName' on '$presentationName' presentation page")
    public void checkThatTabOpenedOnPresentationPage(String condition, String tabName, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        checkThatOpenedPresentationIs(shouldState, wrapVariableWithTestSession(presentationName));
        checkThatOpenedTabIs(shouldState, tabName);
    }

    @Then("I '$condition' see selected assets counter '$counter'")
    public void checkThatSelectedAssetsCounterPresentedCorrectly(String condition, String counter) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualCounter = getSut().getPageCreator().getLibraryPresentationsAssetsPage().getPresentationAssetsCounter();
        assertThat(actualCounter, shouldState ? equalTo(counter) : not(equalTo(counter)));
    }

    @Then("All assets '$condition' be selected on asset presentation page")
    public void checkThatSelectedAssetsCounterPresentedCorrectly(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryPresentationsAssetsPage libraryPresentationsAssetsPage = getSut().getPageCreator().getLibraryPresentationsAssetsPage();

        int allAssets = libraryPresentationsAssetsPage.getPresentationAssetsCount();
        int selectedAssets = libraryPresentationsAssetsPage.getSelectedPresentationAssetsCount();

        assertThat(allAssets, shouldState ? equalTo(selectedAssets) : not(equalTo(selectedAssets)));
    }

    @Then("{I |}'$condition' be on Presentations page")
    public void checkThatPresentationPageOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;
        try {
            getSut().getPageCreator().getLibraryPresentationsPage();
        } catch (Exception e) {
            actualState = false;
        }

        assertThat(actualState, is(expectedState));
    }

    // | FieldName | FieldValue |
    @Then("{I |}'$condition' see following data for asset '$assetName' on info drop down menu: $assetsData")
    public void hoverCursorToAssetInfoButton(String condition, String assetName, ExamplesTable expectedAssetInfoTable) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        String dateTimeFormat = getData().getCurrentUser().getDateTimeFormatter().getDateTimeFormat();

        Map<String, String> expectedAssetInfo = new HashMap<>();
        AssetFilter collection = getCoreApi().getAssetsFilterByName("Everything", "", 0);
        if (collection == null) collection = getCoreApi().getAssetsFilterByName("My Assets", "", 0);
        List<Content> assetsList = getCoreApi().getAllAssetByName(collection.getId(), assetName);
        Content asset = assetsList.get(assetsList.size() - 1);

        for (Map<String, String> row : expectedAssetInfoTable.getRows()) {
            if (row.get("FieldName").equalsIgnoreCase("Uploaded by")) {
                expectedAssetInfo.put(row.get("FieldName"), UserSteps.wrapNameAndGetUser(row.get("FieldValue")).getFullName());
            } else if (row.get("FieldName").equalsIgnoreCase("Uploaded at")) {
                DateTime assetDateCreated = asset.getLastRevision().getMaster().getCreated();
                expectedAssetInfo.put(row.get("FieldName"), DateTimeUtils.formatDate(assetDateCreated, dateTimeFormat));
            } else if (row.get("FieldName").equalsIgnoreCase("ID")) {
                expectedAssetInfo.put("ID", asset.getShortId());
                   } else {
                expectedAssetInfo.put(row.get("FieldName"), row.get("FieldValue"));
            }
        }

        Map<String, String> actualAssetInfo = getSut().getPageCreator().getLibraryPresentationsAssetsPage().getAssetInfo(assetName);
        if (!expectedAssetInfo.containsKey("ID"))
            actualAssetInfo.remove("ID");
        if (actualAssetInfo.get("Uploaded at") != null && !actualAssetInfo.get("Uploaded at").isEmpty())
            actualAssetInfo.put("Uploaded at", DateTimeUtils.getFormattedUTCDate(actualAssetInfo.get("Uploaded at"), dateTimeFormat));

        assertThat(actualAssetInfo, shouldState ? equalTo(expectedAssetInfo) : not(equalTo(expectedAssetInfo)));
    }

    @Then("I '$condition' see preview for asset '$assetName' on opened assets presentation page")
    public void checkPreviewForAsset(String condition, String assetName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryPresentationsAssetsPage().isPreviewForAssetAvailable(assetName);
        String errorMessage = String.format("Preview for asset '%s' is not presented on presentation page", assetName);
        assertThat(errorMessage, actualState, is(expectedState));
    }

    // | FileName | Duration | Size | AspectRatio | Type |
    @Then("{I |}should see for presentation '$presentationName' assets page following files metadata : $metadata")
    public void checkFilesMetadata(String presentationName, ExamplesTable metadata) {
        AdbankLibraryPresentationsAssetsPage page = openLibraryPresentationAssetsPage(presentationName);

        for (Map<String, String> expectedMetadata : parametrizeTableRows(metadata)) {
            Map<String, String> actualMetadata = page.getAssetMetadataFields(expectedMetadata.get("FileName"));
            expectedMetadata.remove("FileName");

            for (String key : expectedMetadata.keySet()) assertThat(actualMetadata.get(key), equalTo(expectedMetadata.get(key)));
        }
    }

    @Then("{I |}'$condition' see correctly generated url for presentation '$presentationName' in public url section")
    public void checkPublicUrlConstantPart(String condition, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        SendPresentationPopUpWindow popup = new SendPresentationPopUpWindow(this.openLibraryPresentationAssetsPage(presentationName));
        String actualLink = popup.getPublicUrl();
        User buAdminUser = getData().getUserByType("AgencyAdmin");
        String presentationId = getCoreApi(buAdminUser).getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        String publicLinkToken =  getCoreApi(buAdminUser).getPresentationPublicToken(presentationId);
        String expectedLink = String.format("%s/presentation/%s/", TestsContext.getInstance().applicationUrl.toString().replace("https","http"), publicLinkToken);

        assertThat(actualLink, shouldState ? equalToIgnoringCase(expectedLink) : not(equalToIgnoringCase(expectedLink)));
    }


    public void sendPresentationForUser(String presentationName, String userName, String message, String downloadOption) {
        AdbankLibraryPresentationsAssetsPage page = openLibraryPresentationAssetsPage(presentationName);
        String email = wrapUserEmailWithTestSession(userName);
        SendPresentationPopUpWindow popup = page.clickSendPresentationButton().clickSendToUserButton();
        popup.switchBetweenTab("Secure share");
        popup.selectRecipients(email);
        popup.typeMessage(message);
        popup.setDownloadOption(downloadOption, SendPresentationPopUpWindow.TypeOfShare.SECURE);
        popup.clickSendButton();
    }
}
