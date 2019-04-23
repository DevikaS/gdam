package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesInfoPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFilesPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.EditFilePopup;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.ItemAlreadyExistInLibraryPopUp;
import com.adstream.automate.babylon.sut.pages.library.collections.AdbankLibraryPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetFramesPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsDestinationPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AddAssetToProjectPopUpWindow;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.babylon.tests.steps.core.SpecDbSteps;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.StringUtils;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.By;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 30.10.12
 * Time: 15:49
 */
public class LibraryAssetsViewSteps extends LibrarySteps {

    private AdbankLibraryAssetsInfoPage openLibraryAssetsInfoPage(String collectionId, String assetId) {
        return getSut().getPageNavigator().getLibraryAssetsInfoPage(collectionId, assetId);
    }

    @Given("{I |}removed asset '$assetName' from collection '$categoriesName' on info page in Library")
    @When("{I |}remove asset '$assetName' from collection '$categoriesName' on info page in Library")
    public void removeAssetFromInfoPage(String assetName, String collectionName) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage = openAssetInfoPage(assetName, collectionName);
        libraryAssetsInfoPage.clickMoreButton();
        libraryAssetsInfoPage.clickRemoveButton().action.click();
    }

    @When("{I |}remove asset from opened asset details page")
    public void removeAsset() {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        page.clickMoreButton();
        page.clickRemoveButton().action.click();
    }

    @When("{I |}click More button on opened asset details page")
    public void clickMoreButton() {
        getLibraryAssetsInfoPage().clickMoreButton();
    }

    @When("{I |}click Remove button on opened asset details page")
    public void clickRemoveButton() {
        getLibraryAssetsInfoPage().clickRemoveButton();
    }

    // assetName it is ID on New asset form . It is must be a unique value, because may be some collision with selecting right asset
    // Id asset also equals asset name in case directly upload to library
    @Given("{I am |}on asset '$assetName' info page in Library for collection '$categoriesName'")
    @When("{I |}go to asset '$assetName' info page in Library for collection '$categoriesName'")
    @Then("{I |}should see '$assetName' file in Library for collection '$categoriesName'")
    public AdbankLibraryAssetsInfoPage openAssetInfoPage(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        return openLibraryAssetsInfoPage(collectionId, asset.getId());
    }


    @Given("{I am |}on asset '$assetName' info page in Library for client collection '$categoriesName' for '$email'")
    @When("{I |}go to asset '$assetName' info page in Library for client collection '$categoriesName' for '$email'")
    @Then("{I |}should see '$assetName' file in Library for collection '$categoriesName' for client '$email'")
    public AdbankLibraryAssetsInfoPage openAssetInfoPageForClient(String assetName, String collectionName,String email) {
        User user =getCoreApi().getUserByEmail(email);
        String userId = user.getId();
        String collectionId = getCategoryIdForClient(wrapCollectionName(collectionName), userId);
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        return openLibraryAssetsInfoPage(collectionId, asset.getId());
    }
    @Given("I am on uploaded by user '$userName' asset '$assetName' info page in Library for collection '$categoriesName'")
    @When("{I |}go to uploaded by user '$userName' asset '$assetName' info page in Library for collection '$categoriesName'")
    @Alias("{I |}go to accepted by user '$userName' asset '$assetName' info page in Library for collection '$categoriesName'")
    public AdbankLibraryAssetsInfoPage openUserAssetInfoPage(String userName, String assetName, String categoryName) {
        Common.sleep(1000);
        String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId();
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getLastUploadedUserAsset(collectionId, userId, assetName);
        if (asset == null)
            asset = getLastUploadedUserAsset(collectionId, userId, wrapVariableWithTestSession(assetName));
        return openLibraryAssetsInfoPage(collectionId, asset.getId());
    }

    @When("{I |}download original file on asset '$assetName' info page for collection '$categoriesName'")
    public void downloadOriginalFileFromInfoPage(String assetName, String categoryName) {
        openAssetInfoPage(assetName, categoryName).triggerDownloadOriginalEventWithoutDownloading();
    }

    @When("{I |}download '$type' file on asset '$assetName' info page for collection '$categoriesName'")
    public void downloadFileFromInfoPage(String type, String assetName, String categoryName) {
        AdbankLibraryAssetsInfoPage adbankLibraryAssetsInfoPage = openAssetInfoPage(assetName, categoryName);
        if (type.equalsIgnoreCase("original")) {
            adbankLibraryAssetsInfoPage.triggerDownloadOriginalEventWithoutDownloading();
        } else if (type.equalsIgnoreCase("proxy")) {
            adbankLibraryAssetsInfoPage.triggerDownloadProxyEventWithoutDownloading();
        } else {
            throw new IllegalArgumentException(String.format("Unknown download type: '%s'", type));
        }

    }

    // action: select, do not select
    @When("{I |}'$action' next folder '$path' of project '$projectName' on Add Asset to Project popup while adding asset '$assetName' of collection '$collectionName'")
    public void actionWithFolderAddAssetToProjectPopUp(String action, String path, String projectName, String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName);
        actionWithFolderAddAssetToProjectPopUpOnOpenedAssetInfoPage(action, path, projectName);
    }

    // action: select, do not select
    @When("{I |}'$action' folder '$path' of project '$projectName' on Add Asset to Project popup while adding asset on opened info page")
    public void actionWithFolderAddAssetToProjectPopUpOnOpenedAssetInfoPage(String action, String path, String projectName) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        page.clickMoreButton();
        AddAssetToProjectPopUpWindow popUpWindow = page.selectAddToProjectOption();
        popUpWindow.typeSearchText(wrapVariableWithTestSession(projectName));
        popUpWindow.clickSearchButton();
        if (action.equals("select")){
            popUpWindow.selectFolder("/");
            popUpWindow.selectFolder(wrapPathWithTestSession(path));
        }
    }

    @When("{I |}type following project '$projectName' in search field on Add Asset to Project popup while adding asset '$assetName' of collection '$collectionName'")
    public void typeProjectName(String projectName, String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName);
        typeProjectNameOnOpenedAssetInfoPage(projectName);
    }

    @When("{I |}cancel asset on opened info page")
    public void clickCancelAssetButton(){
        getLibraryAssetsInfoPage().clickCancelButtom().action.click();
    }

    @When("{I |}type following project '$projectName' in search field on Add Asset to Project popup while adding asset on opened info page")
    public void typeProjectNameOnOpenedAssetInfoPage(String projectName) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        page.clickMoreButton();
        AddAssetToProjectPopUpWindow popUpWindow = page.selectAddToProjectOption();
        popUpWindow.typeSearchText(projectName);
    }

    @Given("{I |}added following asset '$assetName' of collection '$collectionName' to project '$projectName' folder '$path'")
    @When("{I |}add following asset '$assetName' of collection '$collectionName' to project '$projectName' folder '$path'")
    public void moveAssetToProjectsFolder(String assetName, String collectionName, String projectName, String path) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        Content folder = createFolderOverCoreApi(path, projectName);
        getCoreApi().addAssetToProjectFolder(asset.getId(), folder.getId());
        long deadline = System.currentTimeMillis() + 10000;
        while (getCoreApi().getFileByName(folder.getId(), asset.getName()) == null) {
            if (System.currentTimeMillis() > deadline) {
                break;
            }
            Common.sleep(1000);
        }
    }

    @Given("{I |}added following asset '$assetName' of collection '$collectionName' to template '$projectName' folder '$path'")
    @When("{I |}add following asset '$assetName' of collection '$collectionName' to template '$projectName' folder '$path'")
    public void moveAssetToTemplatesFolder(String assetName, String collectionName, String projectName, String path) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        Content folder = createFolderTemplateOverCoreApi(path, projectName);
        getCoreApi().addAssetToProjectFolder(asset.getId(), folder.getId());
        long deadline = System.currentTimeMillis() + 10000;
        while (getCoreApi().getFileByName(folder.getId(), asset.getName()) == null) {
            if (System.currentTimeMillis() > deadline) {
                break;
            }
            Common.sleep(1000);
        }
    }

    @Given("{I |}added following asset '$assetName' of collection '$collectionName' to work request '$projectName' folder '$path'")
    @When("{I |}add following asset '$assetName' of collection '$collectionName' to work request '$projectName' folder '$path'")
    public void moveAssetToWorkRequestFolder(String assetName, String collectionName, String projectName, String path) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        Content folder = createFolderOverCoreApi(path, projectName);
        getCoreApi().addAssetToProjectFolder(asset.getId(), folder.getId());
        long deadline = System.currentTimeMillis() + 10000;
        while (getCoreApi().getFileByName(folder.getId(), asset.getName()) == null) {
            if (System.currentTimeMillis() > deadline) {
                break;
            }
            Common.sleep(1000);
        }
    }

    @When("{I |}add uploaded by user '$userName' asset '$assetName' of collection '$collectionName' to project '$projectName' folder '$path'")
    public void moveUserAssetToProjectsFolder(String userName, String assetName, String collectionName, String projectName, String path) {
        String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId();
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getLastUploadedUserAsset(collectionId, userId, assetName);
        Content folder = createFolderOverCoreApi(path, projectName);
        getCoreApi().addAssetToProjectFolder(asset.getId(), folder.getId());
        long deadline = System.currentTimeMillis() + 10000;
        while (getCoreApi().getFileByName(folder.getId(), asset.getName()) == null) {
            if (System.currentTimeMillis() > deadline) {
                break;
            }
            Common.sleep(1000);
        }
    }

    @When("{I |}click on Added to project '$projectName' link on asset info page")
    public void clickAddedToProjectLink(String projectName) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage = getLibraryAssetsInfoPage();
        libraryAssetsInfoPage.clickAddedToProjectLink(wrapVariableWithTestSession(projectName));
    }

    @When("{I |}click Download Proxy button on asset '$assetName' info page in Library for collection '$categoriesName'")
    public void clickDownloadProxyButton(String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName).triggerDownloadProxyEventWithoutDownloading();
    }

    @When("{I |}click Download Original button on asset '$assetName' info page in Library for collection '$categoriesName'")
    public void clickDownloadOriginalButton(String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName).triggerDownloadOriginalEventWithoutDownloading();
    }

    @When("{I |}'$action' Add Asset to Project popup while adding asset '$assetName' of collection '$collectionName to project '$projectName' folder '$path'")
    public void actionWithAddAssetToProjectPopUp(String action, String assetName, String collectionName, String projectName, String path) {
        openAssetInfoPage(assetName, collectionName);
        actionWithAddAssetToProjectPopUpOnOpenedAssetInfoPage(action, projectName, path);
    }

    @When("{I |}click Edit link on asset info page")
    public void clickEditLink() {
        getLibraryAssetsInfoPage().clickEditLink();
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @When("{I |}'$action' asset '$assetNames' info of collection '$collectionName' by following information: $data")
    public void editAssetInfoFields(String action, String assetNames, String collectionName, ExamplesTable data) {
        for (String assetName : assetNames.split(",")) {
            openAssetInfoPage(assetName, collectionName);
            editAssetInfoFields(action, data);
        }
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Given("{I |}filled asset info by following information on opened Edit Asset popup on asset info page: $data")
    @When("{I |}fill asset info by following information on opened Edit Asset popup on asset info page: $data")
    public void fillAssetInfoFields(ExamplesTable data) {
        new EditFilePopup(getLibraryAssetsInfoPage()).fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Given("{I |}'$action' asset info by following information on opened asset info page: $data")
    @When("{I |}'$action' asset info by following information on opened asset info page: $data")
    public void editAssetInfoFields(String action, ExamplesTable data) {
        EditFilePopup popup = getLibraryAssetsInfoPage().clickEditLink();
        popup.fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));
        action = action.toLowerCase();

        if (action.matches("save|saved")) {
            popup.save();
        } else if (action.matches("cancel|canceled")) {
            popup.cancel();
        } else if (action.matches("close|closed")) {
            popup.close();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action '%s' for edit file popup", action));
        }
    }



    @When("{I |}'$action' asset info by following information after edit operation on asset info page: $data")
    public void editAssetInfoFields_new(String action, ExamplesTable data) {
        EditFilePopup popup = getLibraryAssetsInfoPage().clickEditLink();
        popup.fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));
        action = action.toLowerCase();

        if (action.matches("save|saved")) {
            popup.clickSaveButton();
        } else if (action.matches("cancel|canceled")) {
            popup.cancel();
        } else if (action.matches("close|closed")) {
            popup.close();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action '%s' for edit file popup", action));
        }
    }

    @When("{I |}generate auto code value for field '$fieldName' in section '$sectionName' on opened Edit Asset popup")
    public void generateAutoCodeForAsset(String fieldName, String sectionName) {
        new EditFilePopup(getLibraryAssetsInfoPage()).generateAutoCode(Localization.findByKey(fieldName), sectionName);
    }

    @When("{I |}generate auto code value for custom code field '$fieldName' on opened Edit Asset popup")
    public void generateAutoCodeForCustomCodeField(String fieldName) {
        new EditFilePopup(getLibraryAssetsInfoPage()).clickAutoCodeButtonForCustomCode();
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @When("{I |}'$action' Add Asset to Project popup while adding asset to project '$projectName' folder '$path'")
    public void actionWithAddAssetToProjectPopUpOnOpenedAssetInfoPage(String action, String projectName, String path) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        page.clickMoreButton();
        AddAssetToProjectPopUpWindow popup = page.selectAddToProjectOption();
        popup.typeSearchText(wrapVariableWithTestSession(projectName));
        popup.clickSearchButton();
        Common.sleep(2000);
        popup.selectFolder("/");
        popup.selectFolder(wrapPathWithTestSession(path));

        switch (action) {
            case "cancel":
                popup.cancel.click();
                break;
            case "close":
                popup.close.click();
                break;
            case "apply":
                popup.action.click();
                break;
            default:
                throw new IllegalArgumentException(String.format("Unknown action '%s' for Add Asset to Project popup", action));
        }
        Common.sleep(1000);
    }

    @When("{I |}add assets '$assets' from collection '$collection' to project '$project' folder '$folderPath'")
    public void addAssetsToProject(String assets, AssetFilter collection, Project project, String folderPath) {
        AdbankLibraryPage page = getSut().getPageNavigator().getLibraryPage(collection.getId());
        for (String assetName : assets.split(",")) {
            page.selectFileByFileName(assetName);
        }
        AddAssetToProjectPopUpWindow popup = page.clickAddToProject();
        popup.typeSearchText(project.getName());
        popup.clickSearchButton();
        popup.selectFolder("/");
        popup.selectFolder(wrapPathWithTestSession(folderPath));
        popup.action.click();
        Common.sleep(1000);
    }

    @Given("{I |}set playout for following agency '$agencyName'")
    @When("{I |}set playout for following agency '$agencyName'")
    public void setIsPayout(String agency) {
        SpecDbSteps.setIsPayoutForAgency(getCoreApi().getAgencyByName(wrapAgencyName(agency)).getId());
    }

    @Then("{I |}'$condition' see opened confirmation popup on opened asset details page")
    public void checkThatConfirmationPopupPresentedOnAssetInfoPage(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getLibraryAssetsInfoPage().isConfirmationPopupPresented();
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see Usage Rights tab on asset '$assetName' details page for category '$categoryName'")
    public void checkThatUsageRightsTabPresents(String condition, String assetName, String categoryName) {
        openAssetInfoPage(assetName, categoryName).isUsageRightsTabPresent();
        checkThatUsageRightsTabPresentsOnOpenedPage(condition);
    }

    @Then("{I |}'$condition' see 'Usage Rights' tab on opened asset info page")
    public void checkThatUsageRightsTabPresentsOnOpenedPage(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getLibraryAssetsInfoPage().isUsageRightsTabPresent();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see 'Activities' tab on opened asset info page")
    public void checkThatActivitiesTabPresentsOnOpenedPage(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getLibraryAssetsInfoPage().isActivityTabPresent();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see Edit link on asset '$assetName' info page in Library for collection '$categoriesName'")
    public void checkVisibilityEditLink(String condition, String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName);
        checkVisibilityEditLinkOnOpenedInfoPage(condition);
    }

    @Then("{I |}'$condition' see Edit link on opened asset info page")
    public void checkVisibilityEditLinkOnOpenedInfoPage(String condition) {
        boolean expectedState = condition.equals("should");
        boolean actualState = getLibraryAssetsInfoPage().isEditLinkVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$shouldState' see Download Original button on asset '$assetName' info page in Library for collection '$collectionName'")
    public void checkVisibilityDownloadOriginalButton(String shouldState, String assetName, String collectionName) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage = openAssetInfoPage(assetName, collectionName);
        boolean should = shouldState.equals("should");
        assertThat(libraryAssetsInfoPage.isDownloadOriginalButtonVisible(), equalTo(should));
    }

    @Then("{I |}'$shouldState' see Download Original button on asset for client '$assetName' info page in Library for collection '$collectionName' for '$email'")
    public void checkVisibilityDownloadOriginalButtonForClient(String shouldState, String assetName, String collectionName,String email) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage = openAssetInfoPageForClient(assetName, collectionName, email);
        boolean should = shouldState.equals("should");
        assertThat(libraryAssetsInfoPage.isDownloadOriginalButtonVisible(), equalTo(should));
    }

    @Then("{I |}'$shouldState' see Download Proxy button on asset '$assetName' info page in Library for collection '$categoriesName'")
    public void checkVisibilityDownloadProxyBtnForAsset(String shouldState, String assetName, String collectionName) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage = openAssetInfoPage(assetName, collectionName);
        boolean should = shouldState.equals("should");
        assertThat(libraryAssetsInfoPage.isDownloadProxyButtonVisible(), equalTo(should));
    }

    @Then("{I |}'$shouldState' see Download Master Using NVerge button on asset '$assetName' info page in Library for collection '$collectionName'")
    public void checkVisibilityDownloadMasterUsingNVergeButton(String shouldState, String assetName, String collectionName) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage = openAssetInfoPage(assetName, collectionName);
        boolean should = shouldState.equals("should");
        assertThat(libraryAssetsInfoPage.isDownloadMasterUsingNVergeButtonVisible(), equalTo(should));
    }

    @Then("{I |}'$shouldState' see Download button in the top menu of asset '$assetName' info page in Library for collection '$collectionName'")
    public void checkVisibilityDownloadButton(String shouldState, String assetName, String collectionName) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage = openAssetInfoPage(assetName, collectionName);
        Common.sleep(3000);
        boolean should = shouldState.equals("should");
        assertThat(libraryAssetsInfoPage.isDownloadButtonVisibleOnMenu(), equalTo(should));
    }

    @Then("{I |}'$condition' be on the asset info page")
    public void checkThatOpenedPageIsAssetInfo(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        try {
            getLibraryAssetsInfoPage();
            assertThat(true, is(expectedState));
        } catch (Exception e) {
            assertThat(false, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see Add to project option in More button menu on asset '$assetName' info page in Library for collection '$collectionName'")
    public void checkVisibilityMoreButtonOptions(String condition, String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName);
        checkVisibilityMoreButtonOptionsOnOpenedAssetInfoPage(condition);
    }
    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code starts
    @Then("{I |}'$condition' see Add to WorkRequest option in More button menu on asset '$assetName' info page in Library for collection '$collectionName'")
    public void checkVisibilityMoreButtonWROptions(String condition, String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName);
        checkVisibilityMoreButtonWROptionsOnOpenedAssetInfoPage(condition);
    }

    public void checkVisibilityMoreButtonWROptionsOnOpenedAssetInfoPage(String condition) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean shouldState = condition.equals("should");

        if (page.isMoreButtonVisible()) {
            page.clickMoreButton();
            assertThat("'Add to Work Request' button visible", page.isAddToWorkRequesttOptionVisible(), is(shouldState));
        } else {
            assertThat("'Add to Work Request' button visible", page.isAddToWorkRequesttOptionVisible(), is(false));
        }
    }
    @Then("{I |}'$condition' see Add to Presentation option in More button menu on asset '$assetName' info page in Library for collection '$collectionName'")
    public void checkVisibilityMoreButtonPROptions(String condition, String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName);
        checkVisibilityMoreButtonPROptionsOnOpenedAssetInfoPage(condition);
    }

    public void checkVisibilityMoreButtonPROptionsOnOpenedAssetInfoPage(String condition) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean shouldState = condition.equals("should");
        if (shouldState) {
            assertThat("'Add to Presentation' button visible", page.isAddToPresentationOptionVisible(), is(shouldState));
        } else {
            assertThat("'Add to Work Presentation' button visible", page.isAddToPresentationOptionVisible(), is(false));
        }
    }

    @Then("{I |}'$condition' see Send To Delivery option in More button menu on asset '$assetName' info page in Library for collection '$collectionName'")
    public void checkVisibilityMoreButtonDROptions(String condition, String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName);
        checkVisibilityMoreButtonOptionsDROnOpenedAssetInfoPage(condition);
    }

    public void checkVisibilityMoreButtonOptionsDROnOpenedAssetInfoPage(String condition) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean shouldState = condition.equals("should");
        if (page.isMoreButtonVisible())  {
            page.clickMoreButton();
            assertThat("'Send to Delivery' button visible", page.isSendToDeliveryOptionVisible(), is(shouldState));
        } else {
            assertThat("'Send to Delivery' button visible", page.isSendToDeliveryOptionVisible(), is(false));
        }
    }


    // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Ends
    @Then("{I |}'$condition' see Add to project option in More button menu on opened asset info page")
    public void checkVisibilityMoreButtonOptionsOnOpenedAssetInfoPage(String condition) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean shouldState = condition.equals("should");

        if (page.isMoreButtonVisible()) {
            page.clickMoreButton();
            assertThat("'Add to project' button visible", page.isAddToProjectOptionVisible(), is(shouldState));
        } else {
            assertThat("'Add to project' button visible", page.isAddToProjectOptionVisible(), is(false));
        }
    }

    @Then("{I |}should see following folders of project '$projectName' on Add Asset to Project popup while adding asset '$assetName' of collection '$collectionName' : $data")
    public void checkFoldersInPopUp(String projectName, String assetName, String collectionName, ExamplesTable data) {
        openAssetInfoPage(assetName, collectionName);
        checkFoldersInPopUpOnOpenedAssetInfoPage(projectName, data);
    }

    // | folder |
    @Then("{I |}should see following folders of project '$projectName' on Add Asset to Project popup while adding asset on opened info page: $data")
    public void checkFoldersInPopUpOnOpenedAssetInfoPage(String projectName, ExamplesTable data) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        page.clickMoreButton();
        AddAssetToProjectPopUpWindow popup = page.selectAddToProjectOption();
        popup.typeSearchText(wrapVariableWithTestSession(projectName));
        popup.clickSearchButton();
        popup.clickRootFolderAssetPOPUP();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            assertThat("Is folder exists", popup.isFolderExists(wrapPathWithTestSession(row.get("folder"))), is(true));
        }
    }

    @Then("{I |}'$shouldState' see Add Asset to Project popup window on asset info page in Library")
    public void checkVisibilityAddAssetToProjectPopUp(String shouldState) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage = getLibraryAssetsInfoPage();
        boolean should = shouldState.equals("should");
        assertThat(libraryAssetsInfoPage.isAddAssetToProjectPopUpVisible(), equalTo(should));
    }

    @Then("{I |}'$shouldState' see asset '$assetName' info page for collection '$collectionName' in Library")
    public void checkVisibilityAssetsInfoPage(String shouldState, String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        boolean should = shouldState.equals("should");
        String expectedPage = String.format("collections/%s/assets/%s/info", collectionId, asset.getId());
        assertThat(expectedPage, should ? equalToIgnoringCase(BabylonSteps.getCurrentPageName()) : not(equalToIgnoringCase(BabylonSteps.getCurrentPageName())));
    }

    @Then("{I |}'$condition' see uploaded by user '$userName' asset '$assetName' info page in collection '$categoryName'")
    public void checkVisibilityUserAssetsInfoPage(String condition, String userName, String assetName, String categoryName) {
        boolean shouldState = condition.equals("should");
        String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId();
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getLastUploadedUserAsset(collectionId, userId, assetName);
        if (asset == null)
            asset = getLastUploadedUserAsset(collectionId, userId, wrapVariableWithTestSession(assetName));
        String expectedPage = String.format("collections/%s/assets/%s/info", collectionId, asset.getId());
        String actualPage = BabylonSteps.getCurrentPageName();

        assertThat(actualPage, shouldState ? equalToIgnoringCase(expectedPage) : not(equalToIgnoringCase(expectedPage)));
    }

    @Then("{I |}'$condition' see projects '$projects' are available for selecting on Add Asset to Project popup")
    public void checkProjectsSearch(String condition, String projects) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AddAssetToProjectPopUpWindow popup = new AddAssetToProjectPopUpWindow(getLibraryAssetsInfoPage());
        List<String> actualProjectsList = popup.getAvailableForSearchProjectsListAsText();

        for (String project : projects.split(",")) {
            String expectedProjectName = wrapVariableWithTestSession(project);
            assertThat(actualProjectsList, shouldState ? hasItem(expectedProjectName) : not(hasItem(expectedProjectName)));
        }
    }

    @Then("{I |}'$condition' see Added to project '$projectName' link on asset '$assetName' info page in Library for collection '$collectionName'")
    public void checkVisibilityAddedToProjectLink(String condition, String projectName, String assetName, String collectionName) {
        openAssetInfoPage(assetName, collectionName);
        checkVisibilityAddedToProjectLink(condition, projectName);
    }

    @Then("{I |}'$condition' see Added to project '$projectName' link on opened asset info page")
    public void checkVisibilityAddedToProjectLink(String condition, String projectName) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean expectedState = condition.equals("should");
        boolean actualState = page.isAddToProjectLinkVisible(wrapVariableWithTestSession(projectName));

        assertThat(String.format("Added to project link %s be visible!", condition), actualState, is(expectedState));
    }

    @Then("{I |}'$shouldState' see download original file '$fileName' on asset '$assetName' info page for collection '$collectionName' after clicking Download original btn")
    public void checkStartedDownloadOriginalFile(String condition, String fileName, String assetName, String collectionName) {
        AdbankLibraryAssetsInfoPage page = openAssetInfoPage(assetName, collectionName);
        page.clickDownloadOriginalButton();

        boolean expectedState = condition.equals("should");
        File file = new File(getContext().testsTempFolder, fileName);
        boolean actualState = file.exists();
        assertThat("File " + fileName + " " + condition + " be downloaded!", actualState, is(expectedState));

        if (expectedState) {
            if (!file.delete()) throw new IllegalArgumentException("Delete file " + fileName + " : deletion failed!");
        }
    }

    @Then("{I |}'$condition' see '$button' button on opened asset info page")
    public void checkVisibilityOfDownloadButton(String condition, String button) {
        AdbankLibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean expectedState = condition.equals("should");
        boolean actualState;
        button = button.toLowerCase();

        switch(button) {
            case "download proxy":
                actualState = page.isDownloadProxyButtonVisible();
                break;
            case "download original":
                actualState = page.isDownloadOriginalButtonVisible();
                break;
            case "download master using nverge":
                actualState = page.isDownloadMasterUsingNVergeButtonVisible();
                break;
            case "download low res pdf":
                actualState = page.isDownloadDownloadLowResPDFButtonVisible();
                break;
            case "download storyboard":
                actualState = page.isDownloadStoryBoardButtonVisible();
                break;
            case "cancel":
                actualState = page.isCancelButtonVisible();
                break;
            default: throw new IllegalArgumentException(String.format("Unknown button name '%s'", button));
        }

        String message = String.format("Button '%s' is not present on opened asset info page", button);
        assertThat(message, actualState, equalTo(expectedState));
    }

    @Then("{I |}'$should' see playable preview on asset info page")
    public void checkVideoPlayablePreview(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryAssetsInfoPage().isPlayerAvailable();

        assertThat("Playable preview is not available", shouldState == actualState);
    }

    @Then("{I |}'$should' see playable preview on asset info page for assets '$assetName' collection '$collectionName'")
    public void checkPreviewOnAssetInfoPage(String condition,String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        AdbankLibraryPage libraryPage =getSut().getPageNavigator().getLibraryPage(collectionId);
        String[] fileArray = assetName.split(",");
        for (String file : fileArray) {
            Content asset = getAsset(collectionId, wrapVariableWithTestSession(file));
            if (asset == null)
                asset = getAsset(collectionId, file);
            openLibraryAssetsInfoPage(collectionId, asset.getId());
            boolean shouldState = condition.equalsIgnoreCase("should");
            boolean actualState = getSut().getPageCreator().getLibraryAssetsInfoPage().isPreviewAvailable(file);
            assertThat("Preview asset " + file + " should be visible!", actualState, is(true));
        }
    }
    @Then("I should see preview on the library assets info page for asset '$assetName' collection '$collectionName'")
    public void checkPreviewImageOnAssetInfoPage(String assetName, String collectionName) {
        AdbankLibraryAssetsInfoPage assetsInfoPage = openAssetInfoPage(assetName, collectionName);
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null)
            asset = getAsset(collectionId, assetName);
        boolean actual = assetsInfoPage.isFilePreviewVisible(asset.getId());
        assertThat("Preview asset should be visible!", actual, is(true));
    }

    @Then("I should see preview on the library assets info page for assets '$assetName' collection '$collectionName'")
    public void checkPreviewImagesOnAssetInfoPage(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        AdbankLibraryPage libraryPage =getSut().getPageNavigator().getLibraryPage(collectionId);
        String[] fileArray = assetName.split(",");
        for (String file : fileArray) {
            Content asset = getAsset(collectionId, wrapVariableWithTestSession(file));
            if (asset == null)
                asset = getAsset(collectionId, file);
            boolean actual = libraryPage.isFilePreviewVisible(asset.getId());
            assertThat("Preview asset " + file + " should be visible!", actual, is(true));
        }
    }
    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following '$fieldType' fields with values on opened Edit asset popup: $data")
    public void checkDropdownFieldsValues(String condition, String fieldType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        EditFilePopup popup = new EditFilePopup(getLibraryAssetsInfoPage());

        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            List<String> actualValues;

            if (fieldType.equalsIgnoreCase("dropdown")) {
                actualValues = popup.getAvailableComboBoxValues(row.getKey(), row.getSection());
                //NGN-16223-QAA: User can see Collections based on Market code changes starts
            } else if(fieldType.equalsIgnoreCase("autoSuggest")){
                actualValues = popup.getAvailableAutoSuggestBoxValues(row.getKey(), row.getSection());
            }//NGN-16223-QAA: User can see Collections based on Market code changes Ends
            else if (fieldType.equalsIgnoreCase("radio buttons")) {
                actualValues = popup.getAvailableRadioButtonsValues(row.getKey(), row.getSection());
            } else {
                throw new IllegalArgumentException(String.format("Unknown field type '%s'", fieldType));
            }

            for (String expectedValue : row.getValue().split(","))
                assertThat(actualValues, shouldState ? hasItem(expectedValue) : not(hasItem(expectedValue)));
        }
    }

    @Then ("{I |} '$condition' see following '$fieldType' fields with expected values on opened Edit asset popup: $data")
    public void checkDropdownFieldsValuesWithSizeCheck(String condition, String fieldType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        EditFilePopup popup = new EditFilePopup (getLibraryAssetsInfoPage());
        List<String> actualValues;
        List<String> expectedValues = new ArrayList<String>();
        int counter = 0;

        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (fieldType.equalsIgnoreCase("dropdown")) {
                actualValues = popup.getAvailableComboBoxValues(row.getKey(), row.getSection());
                if (actualValues.get(0).isEmpty())
                    actualValues.remove(0);
                //NGN-16223-QAA: User can see Collections based on Market code changes starts
            } else {
                throw new IllegalArgumentException(String.format("Unknown field type '%s'", fieldType));
            }

            assertThat("Expected values list doesn't match the size of the Actual values list",actualValues.size()== row.getValue().split(",").length);
            for (String expectedValue : row.getValue().split(","))
                assertThat(actualValues, shouldState ? hasItem(expectedValue) : not(hasItem(expectedValue)));
        }
    }

    // | FieldName |
    @Then("{I |}'$condition' see following fields on opened Edit asset popup: $data")
    public void checkEditAssetPopupFieldsVisibility(String condition, ExamplesTable data) {
        List<String> fieldsList = new ArrayList<String>();
        for (Map<String, String> row : parametrizeTableRows(data)) fieldsList.add(row.get("FieldName"));
        checkEditAssetPopupVisibility(condition, StringUtils.join(fieldsList, ","));
    }

    @Then("{I |}'$condition' see fields '$fields' on opened Edit asset popup")
    public void checkEditAssetPopupVisibility(String condition, String fields) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFields = new EditFilePopup(getLibraryAssetsInfoPage()).getAvailableFieldNames();

        for (String expectedField : fields.split(","))
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    // | FieldName |
    @Then("{I |}'$condition' see following '$fieldsType' field labels on opened asset info page: $data")
    public void checkAssetInfoFieldsVisibility(String condition, String fieldsType, ExamplesTable data) {
        List<String> fieldsList = new ArrayList<String>();
        for (Map<String, String> row : parametrizeTableRows(data)) fieldsList.add(row.get("FieldName"));
        checkAssetInfoFieldsVisibility(condition, fieldsType, StringUtils.join(fieldsList, ","));
    }

    //|AssetName|DefaultProxy|CustomProxy|
    @Given("{I |}verify below proxies text is displayed for the video/audio assets in Library for collection '$collectionName': $proxyTable")
    @When("{I |}verify below proxies text is displayed for the video/audio assets in Library for collection '$collectionName': $proxyTable")
    public void checkProxyGenerated(String collectionName,ExamplesTable proxyTable) {
        AdbankLibraryAssetsInfoPage libraryAssetsInfoPage;

        for (int i = 0; i < proxyTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(proxyTable, i);
            libraryAssetsInfoPage = openAssetInfoPage( row.get("AssetName"), collectionName);
            assertThat("DefaultProxy is generated", libraryAssetsInfoPage.getDefaultProxyText().contains(row.get("DefaultProxy")), is(true));
            assertThat("CustomProxy is generated", libraryAssetsInfoPage.getCustomProxyText().contains( row.get("CustomProxy")), is(true));
        }
    }

    @Then("{I |}'$condition' see '$fieldsType' field labels '$fields' on opened asset info page")
    public void checkAssetInfoFieldsVisibility(String condition, String fieldsType, String fields) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFields;

        if (fieldsType.equalsIgnoreCase("asset information")) {
            actualFields = getLibraryAssetsInfoPage().getAssetInformationFieldNames();
        } else if (fieldsType.equalsIgnoreCase("custom metadata")) {
            actualFields = getLibraryAssetsInfoPage().getCustomFieldNames();
        } else if (fieldsType.equalsIgnoreCase("specification")) {
            actualFields = getLibraryAssetsInfoPage().getSpecificationFieldNames();
        } else {
            throw new IllegalArgumentException(String.format("Unknown fields type given: '%s'", fieldsType));
        }

        for (String expectedField : fields.split(","))
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following '$fieldsType' fields on opened asset info page: $data")
    public void checkAssetInformation(String condition, String fieldsType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");
        List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (MetadataItem expectedField : expectedFields)
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    @Then("{I |}'$condition' see following xmp fields '$fieldsType' on opened asset info page for agency '$agency': $data")
    public void checkAssetXMPInformation(String condition, String fieldsType, String agency, ExamplesTable data) {
        try {
            boolean shouldState = condition.equalsIgnoreCase("should");
            List<MetadataItem> expectedFields = convertMetadataFields(data, "FieldName", "FieldValue");
            List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);

            if (!data.getHeaders().contains("SectionName"))
                for (MetadataItem field : actualFields) field.setSection(null);

            for (MetadataItem expectedField : expectedFields)
                assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));

        } finally {
            SpecDbSteps.removeXMPTranscodingAgencyId(getCoreApi().getAgencyByName(wrapAgencyName(agency)).getId());
            GenericSteps.removeXMPMappingFromMongo();
        }
    }

    // | FieldName | FieldValue |
    // SectionName - is not required
    // used for checking asset information for each asset clone
    @Then("{I |}'$shouldState' see for each asset clone with name '$assetName' in collection '$collectionName' following '$fieldsType' fields on opened asset info page: $data")
    public void checkAssetClonesInformation(String shouldState, String assetName, String collectionName, String fieldsType, ExamplesTable data) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        List<Content> assetsList = getCoreApi().getAllAssetByName(collectionId, prepareAssetName(assetName));
        if (assetsList.isEmpty()) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        for (Content asset: assetsList) {
            openLibraryAssetsInfoPage(collectionId, asset.getId());
            List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");
            List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);
            if (!data.getHeaders().contains("SectionName"))
                for (MetadataItem field : actualFields) field.setSection(null);
            for (MetadataItem expectedField : expectedFields)
                assertThat(actualFields, shouldState.equals("should") ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following '$fieldsType' fields on opened Edit asset popup: $data")
    public void checkAssetInformationOnEditAssetPopup(String condition, String fieldsType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> actualFields = getActualEditFilePopupFields(fieldsType);
        List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (MetadataItem expectedField : expectedFields)
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    // state: locked,required,disabled,available,validation error
    @Then("{I |}'$shouldState' see following fields '$fieldNamesList' in '$state' state on opened Edit asset popup")
    public void checkAssetFieldsCondition(String shouldState, String fieldNamesList, String state) {
        List<MetadataItem> actualFields = getActualEditFilePopupFields(state);
        List<String> names = new ArrayList<String>();
        for (MetadataItem actualField : actualFields)
            names.add(actualField.getKey());
        for (String fieldName: fieldNamesList.split(",")) {
            fieldName = Localization.findByKey(fieldName);
            assertThat("Check is field: " + fieldName + " in following state: " + state, names, shouldState.equalsIgnoreCase("should")
                                                                                  ? hasItem(fieldName) : not(hasItem(fieldName)));
        }
    }

    @Then("{I |}should see following auto generated code '$autoCodePattern' for field '$fieldName' in section '$sectionName' on opened Edit Asset popup")
    public void checkAutoGeneratedCodeForAsset(String autoCodePattern, String fieldName, String sectionName) {
        assertThat("Check auto generated code for asset: ", new EditFilePopup(getLibraryAssetsInfoPage()).getTextFieldValue(Localization.findByKey(fieldName), sectionName),
                                                            StringByRegExpCheck.matches(autoCodePattern));
    }

    @Then("{I |}'$shouldState' see following custom code{s|} '$customCodeNames' on Select from existing formats popup on opened Edit Asset popup")
    public void checkVisibilityPopUpCustomCodesForAsset(String shouldState, String customCodeNames) {
        List<String> visibleCustomCodeNames = new EditFilePopup(getLibraryAssetsInfoPage()).getSelectFromExistingFormatsPopUp().getVisibleAdCodeNames();
        for (String customCodeName : customCodeNames.split(","))
            assertThat("Check visibility custom code name on popup for asset: " + customCodeName, visibleCustomCodeNames, shouldState.equals("should")
                                                                                                  ? hasItem(wrapVariableWithTestSession(customCodeName))
                                                                                                  : not(hasItem(wrapVariableWithTestSession(customCodeName))));
    }

    // state: active, inactive
    @Then("{I |}should see '$state' Auto code button on opened Edit Asset popup")
    public void checkAutoGenerateCodeButtonState(String state) {
        assertThat("Check Auto generate code button state on Edit Asset popup: ", new EditFilePopup(getLibraryAssetsInfoPage()).isAutoCodeBtnActive(), is(state.equals("active")));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following '$fieldsType' fields in the following order on opened asset info page: $data")
    public void checkAssetInformationOrderedAndPresented(String condition, String fieldsType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");
        List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (int i = 0; i < expectedFields.size(); i++)
            assertThat(actualFields.get(i), shouldState ? equalTo(expectedFields.get(i)) : not(equalTo(expectedFields.get(i))));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following fields in the following order on opened Edit asset popup: $data")
    public void checkAssetInformationOnEditAssetPopupOrderedAndPresented(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> actualFields = getActualEditFilePopupFields("available");
        List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (int i = 0; i < expectedFields.size(); i++)
            assertThat(actualFields.get(i), shouldState ? equalTo(expectedFields.get(i)) : not(equalTo(expectedFields.get(i))));
    }

    @Then("{I |}'$condition' see error message 'Please select a new value' for field '$fieldName' on opened Edit asset popup")
    public void checkThatErrorMassageAppearsOnField(String condition, String fieldName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = new EditFilePopup(getLibraryAssetsInfoPage()).isErrorAppearsOnField(fieldName);

        assertThat(String.format("Is message 'Please select a new value for \"%s\"' appears", fieldName), actualState, is(expectedState));
    }
    //!--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Starts
    @Then("{I '$condition' see |} warning message as  '$text' in send to library pop up")
    public static void checkAlert(String condition,String text) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        By locator = By.cssSelector(".popupWindow.dijitDialogFixed.dijitDialog");
        assertThat(getSut().getWebDriver().isElementVisible(locator) , shouldState ? equalTo(true) : not(equalTo(false)));
        String actualMessage = new ItemAlreadyExistInLibraryPopUp(getSut().getPageCreator().getAdbankFilesPage()).warningMessage().trim();
        assertThat(actualMessage , shouldState ? equalTo(text) : not(equalTo(text)));
    }
    @Then("{I '$condition' see |} warning message as  '$text' in send to library pop up on FileInfo page")
    public static void checkAlertinfileinfo(String condition,String text) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        By locator = By.cssSelector(".popupWindow.dijitDialogFixed.dijitDialog");
        assertThat(getSut().getWebDriver().isElementVisible(locator) , shouldState ? equalTo(true) : not(equalTo(false)));
        String actualMessage = new ItemAlreadyExistInLibraryPopUp(getSut().getPageCreator().getProjectFileInfoPage()).warningMessage().trim();
        assertThat(actualMessage , shouldState ? equalTo(text) : not(equalTo(text)));
    }

    // !--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Ends
    @Then("{I |}I '$condition' see on asset '$assetName' info page for collection '$collectionName' in Download popup download '$linkType' link")
    public void checkThatDownloadLinkVisibleOnPopup(String condition, String assetName, String collectionName, String linkType) {
        if (!linkType.equalsIgnoreCase("original") && !linkType.equalsIgnoreCase("proxy"))
            throw new IllegalArgumentException("Type of link for check file download defines incorrect. It must be 'original' or 'preview' ");

        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openAssetInfoPage(assetName, collectionName).clickDownloadButton().isLinkVisible(linkType);

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' be able to play clip on asset '$assetName' info page for collection '$collectionName'")
    public void checkThatPlayerAvailable(String condition, String assetName, String collectionName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openAssetInfoPage(assetName, collectionName).isPlayerAvailable();

        assertThat(actualState, is(expectedState));
    }

    private AdbankLibraryAssetsInfoPage getLibraryAssetsInfoPage() {
        return getSut().getPageCreator().getLibraryAssetsInfoPage();
    }

    private Map<String, String> getMapByValue(List<Map<String, String>> listMap, String value) {
        for (Map<String, String> map : listMap)
            if (map.containsValue(value))
                return map;
        throw new NullPointerException("There is no any value: " + value + " in the map.");
    }

    private List<MetadataItem> getActualEditFilePopupFields(String fieldsType) {
        if (fieldsType.equalsIgnoreCase("required")) {
            return new EditFilePopup(getLibraryAssetsInfoPage()).getRequiredFieldsInfo();
        } else if (fieldsType.equalsIgnoreCase("disabled")) {
            return new EditFilePopup(getLibraryAssetsInfoPage()).getDisabledFieldsInfo();
        } else if (fieldsType.equalsIgnoreCase("available")) {
            return new EditFilePopup(getLibraryAssetsInfoPage()).getAvailableFieldsInfo();
        } else if (fieldsType.equals("locked")) {
            return new EditFilePopup(getLibraryAssetsInfoPage()).getLockedFieldsInfo();
        } else if (fieldsType.equals("validation error")) {
            return new EditFilePopup(getLibraryAssetsInfoPage()).getValidationErrorFieldsInfo();
        } else {
            throw new IllegalArgumentException(String.format("Unknown fields type given: '%s'", fieldsType));
        }
    }

    private List<MetadataItem> getActualFileInfoFields(String fieldsType) {
        if (fieldsType.equalsIgnoreCase("asset information")) {
            return getLibraryAssetsInfoPage().getAssetInformationFields();
        } else if (fieldsType.equalsIgnoreCase("custom metadata")) {
            return getLibraryAssetsInfoPage().getCustomMetadataFields();
        } else if (fieldsType.equalsIgnoreCase("specification")) {
            return getLibraryAssetsInfoPage().getSpecificationFields();
        } else {
            throw new IllegalArgumentException(String.format("Unknown fields type given: '%s'", fieldsType));
        }
    }

    //QA-358-Frame Grabber Code Changes Starts
    @Given("{I am |}on asset '$assetName' frames page in Library for collection '$categoriesName'")
    @When("{I |}go to asset '$assetName' frames page in Library for collection '$categoriesName'")
    @Then("{I |}should see '$assetName' frames in Library for collection '$categoriesName'")
    public AdbankLibraryAssetsInfoPage openAssetframesPage(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        return openLibraryAssetsframesPage(collectionId, asset.getId());
    }

    private AdbankLibraryAssetFramesPage openLibraryAssetsframesPage(String collectionId, String assetId) {
        return getSut().getPageNavigator().getLibraryAssetsFramesPage(collectionId, assetId);
    }

    @When("{I |}click '$action' TAB on opened asset info page")
    @Given("{I |}clicked '$action' TAB on opened asset info page")
    public void editUsageRightsFields(String action){
        getLibraryAssetsInfoPage().clickEditLink(action);
    }


    @When("{I |}manually push an asset to destination:$fields")
    public void sendManual(ExamplesTable fields)
    {
       AdbankLibraryAssetsDestinationPage order= getSut().getPageCreator().getAdbankLibraryAssetsDestinationPage();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            order.selectMarket(row.get("Market"));
            order.selectDestination(row.get("Destination"));
            order.selectServiceLevel(row.get("Service Level"));
            order.clickSend();
        }

    }

}