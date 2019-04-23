package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.*;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.library.elements.*;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.babylon.tests.steps.core.SpecDbSteps;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAssetsInfoPage;
import com.adstream.automate.babylon.tests.steps.domain.BabylonSteps;
import com.adstream.automate.utils.Common;
import org.hamcrest.Matchers;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.core.Is.is;

/**
 * Created by Janaki.Kamat on 01/05/2017.
 */

public class NewLibraryAssetsViewSteps extends NewLibrarySteps {

    private LibraryAssetsInfoPage openLibraryAssetsInfoPage(String collectionId, String assetId) {
        return getSut().getPageNavigator().getLibraryAssetsInfoPageNEWLIB(collectionId, assetId);
    }

    private LibraryAssetsInfoPage openLibraryAssetsInfoPage_InboxCollecton(String collectionId, String assetId) {
        return getSut().getPageNavigator().getLibraryAssetsInfoPage_InboxNEWLIB(collectionId, assetId);
    }






    @Given("{I am |}on asset '$assetName' info page in Library for collection '$categoriesName'NEWLIB")
    @When("{I |}go to asset '$assetName' info page in Library for collection '$categoriesName'NEWLIB")
    @Then("{I |}should see '$assetName' file in Library for collection '$categoriesName'NEWLIB")
    public LibraryAssetsInfoPage openAssetInfoPage(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
         return openLibraryAssetsInfoPage(collectionId, asset.getId());
    }


    @Then("{I |}'$condition' be on the asset info pageNEWLIB")
    public void checkThatOpenedPageIsAssetInfoNewLib(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        try {
            LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
            assertThat(true, is(expectedState));
        } catch (Exception e) {
            assertThat(false, is(expectedState));
        }
    }

    @When("{I |}go to asset '$assetName' info page in library for collection '$categoriesName' for user '$email'NEWLIB")
    public LibraryAssetsInfoPage openAssetInfoPageForClientNEWLIB(String assetName, String collectionName,String email) {
        User user =getCoreApi().getUserByEmail(email);
        String userId = user.getId();
        String collectionId = getCategoryIdForClient(wrapCollectionName(collectionName),userId);
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        return openLibraryAssetsInfoPage(collectionId, asset.getId());
    }


    @When("{I |}go to asset '$assetName' info page in library for collection '$categoriesName' impersonated as '$userName'NEWLIB")
    public LibraryAssetsInfoPage openAssetInfoPageByImpersonate(String assetName, String collectionName,String userName) {
        userName = wrapUserEmailWithTestSession(userName);
        User user =getCoreApi().getUserByEmail(userName);
        String collectionId = getCategoryIdForClient(wrapCollectionName(collectionName),user.getId());
        Content asset = getAssetForClient(collectionId, wrapVariableWithTestSession(assetName), user.getId());
        if (asset == null) {
            asset = getAssetForClient(collectionId, assetName, user.getId());
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        return openLibraryAssetsInfoPage(collectionId, asset.getId());
    }
    @When("I delete the asset from asset info pageNEWLIB")
    public void deleteAssetFromAssetInfoPage() {
        LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        page.openPopupOnAssetInfoPage().clickRemoveButton().clickRemoveFileButton();
    }



    @Given("{I am |}on asset '$assetName' info page in Library for inbox collection '$categoriesName' of Agency '$agencyName'")
    @When("{I |}go to asset '$assetName' info page in Library for inbox collection '$categoriesName' of Agency '$agencyName'")
    @Then("{I |}should see '$assetName' file in Library for inbox collection '$categoriesName' of Agency '$agencyName'")
    public LibraryAssetsInfoPage openAssetInfoPage_InboxCollection(String assetName, String collectionName,String agencyName) {
        String collectionId = getCoreApi().getInboxCategoryByName(getAgencyIdByName(wrapAgencyName(agencyName)),wrapCollectionName(collectionName)).getId();
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        return openLibraryAssetsInfoPage_InboxCollecton(collectionId, asset.getId());
    }

    @Then("{I |}'$condition' see '$option' tab on opened asset info pageNEWLIB")
    public void checkThatTabPresentsOnOpenedPageNewlib(String condition,String option) {
        LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = false;
        switch (option.toLowerCase()) {
            case "usage rights":
                actualState = page.isUsageRightsTabPresent();
                break;
            case "activity":
                actualState = page.isActivityTabPresent();
                break;
            case "share asset":
                actualState = page.isShareAssetOptionPresent();
                break;
            case "more":
                actualState = page.openPopup().isMenuOptionVisible();
                break;

            default:
                throw new IllegalArgumentException(String.format("Unknown option name '%s'", option));
        }
                assertThat(actualState, is(expectedState));
        }



    @When("{I |}click Edit link on asset info pageNEWLIB")
    public void clickEditLink() {
        getLibraryAssetsInfoPage().clickEditLink();
    }

    @Then("{I |}'$condition' see remove asset confirmation popup on asset info page NEWLIB")
    public void checkThatConfirmationPopupPresentedOnAssetInfoPage(String condition) {

        boolean expectedState = condition.equalsIgnoreCase("should");
        LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean actualState=page.openPopupOnAssetInfoPage().clickRemoveButton().isPopUpVisible();
        assertThat(actualState, is(expectedState));


    }


    @Then("{I |}'$condition' see '$option' option in menu on opened asset info page NEWLIB")
    public void checkVisibilityOfOptionsinMenu(String condition, String option) {
        LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean expectedState = condition.equals("should");
        boolean actualState = false;
        option = option.toLowerCase();
        switch (option) {
            case "remove":
                actualState = page.openPopupOnAssetInfoPage().isRemoveOptionVisible();
                break;

            default:
                throw new IllegalArgumentException(String.format("Unknown option name '%s'", option));
        }

        String message = String.format("Option '%s' is not present on asset info page", option);
        assertThat(message, actualState, equalTo(expectedState));

    }

    @Then("{I |}'$condition' be able to play '$type' clip on asset '$assetName' info page for collection '$collectionName' NEWLIB")
    public void checkThatPlayerAvailableOnNewLibrary(String condition, String type,String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }

        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openLibraryAssetsInfoPage(collectionId, asset.getId()).checkIsPlayerAvailable(type);

        assertThat(actualState, is(expectedState));
    }




    @When("{I |}click related projects on asset info page NEWLIB")
    public void clickRelatedProjects() {
        getLibraryAssetsInfoPage().clickRelatedProjects();
    }


    @Then("{I |}'$condition' see following dropdown fields with values under section '$sectionName' on opened Edit asset popup NEWLIB: $data")
    public void checkDropdownFieldsValues(String condition, String sectionName,ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibEditFilePopup popup = new LibEditFilePopup(getLibraryAssetsInfoPage());
        List<String> actualValues=new ArrayList<>();
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            actualValues = popup.getAvailableComboBoxValuesOnEditAssetPopup(row.getKey(),sectionName);
            for (String expectedValue : row.getValue().split(",")){
                assertThat(actualValues, shouldState ? hasItem(expectedValue.trim()) : not(hasItem(expectedValue.trim())));}
        }
    }

    @Then("{I |}'$condition' see following '$fieldType' fields with values by scroll down to option '$scrollOption' on opened Edit asset popup NEWLIB: $data")
    public void checkDropdownFieldsValuesWithScroll(String condition, String fieldType, String scrollOption,ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibEditFilePopup popup = new LibEditFilePopup(getLibraryAssetsInfoPage());
        List<String> actualValues=new ArrayList<>();

        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (fieldType.equalsIgnoreCase("dropdown")) {
                actualValues = popup.getAvailableComboBoxValuesWithScroll(row.getKey(), scrollOption);
            } else {
                throw new IllegalArgumentException(String.format("Unknown field type '%s'", fieldType));
            }
            for (String expectedValue : row.getValue().split(","))
                assertThat(actualValues, shouldState ? hasItem(expectedValue) : not(hasItem(expectedValue)));
        }
    }

    @Then("{I |}'$condition' see following '$fieldType' fields on edit asset popup NEWLIB: $data")
    public void checkPresenceOfFieldsNewLib(String condition, String fieldType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibEditFilePopup popup = new LibEditFilePopup(getLibraryAssetsInfoPage());
        boolean actualState=false;
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (fieldType.equalsIgnoreCase("metadata")) { //this checks only product info Advertiser,Brand,SubBrand,Product,Campaign,Title,any Custom fields
                actualState = popup.verifyPresenceOfMetadataFieldsOnEditPopup(row.get("FieldName"));
            }
        }
        assertThat(actualState, shouldState ? is(true) : is(false));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @When("{I |}'$action' asset '$assetNames' info of collection '$collectionName' by following informationNEWLIB: $data")
    public void editAssetInfoFields(String action, String assetNames, String collectionName, ExamplesTable data) {
        for (String assetName : assetNames.split(",")) {
            openAssetInfoPage(assetName, collectionName);
            editAssetInfoFields(action, data);
        }
    }


    @Then("{I |}'$condition' see following '$fieldType' fields with value on edit asset popup NEWLIB: $data")
    public void checkFieldsValuesOnEditAssetPopupNewLib(String condition,String fieldType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibEditFilePopup popup = new LibEditFilePopup(getLibraryAssetsInfoPage());
        String actualValue="";
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (fieldType.equalsIgnoreCase("metadata")) {
                actualValue = popup.verifyMetadataValuesOnEditAssetPopup(row.get("FieldName"),row.get("SectionName"));
                String[] expectedValue = row.get("FieldValue").split(",");
                for (String expected_value : expectedValue) {
                    assertThat(actualValue, shouldState ? containsString(expected_value.trim()) : not(containsString(expected_value.trim())));
                }
            }

        }

    }

    @Then("{I |}'$condition' see following '$fieldType' fields disabled on edit asset popup NEWLIB: $data")
    public void checkFieldsDisablednEditAssetPopupNewLib(String condition,String fieldType, ExamplesTable data) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        LibEditFilePopup popup = new LibEditFilePopup(getLibraryAssetsInfoPage());
        boolean actualState;
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (fieldType.equalsIgnoreCase("metadata")) {
                actualState = popup.verifyFieldsDisabledOnEditAssetPopup(row.get("FieldName"),row.get("SectionName"));
                assertThat(actualState, equalTo(expectedState));
            }

        }

    }


    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Given("{I |}filled asset info by following information on opened Edit Asset popup on asset info pageNEWLIB: $data")
    @When("{I |}fill asset info by following information on opened Edit Asset popup on asset info pageNEWLIB: $data")
    public void fillAssetInfoFields(ExamplesTable data) {
        new LibEditFilePopup(getLibraryAssetsInfoPage()).fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Given("{I |}'$action' asset info by following information on opened asset info pageNEWLIB: $data")
    @When("{I |}'$action' asset info by following information on opened asset info pageNEWLIB: $data")
    public void editAssetInfoFields(String action, ExamplesTable data) {
       LibEditFilePopup popup = getLibraryAssetsInfoPage().clickEditLink();
        Common.sleep(2000);
        popup.fillEditFilePopup(wrapMetadataFieldsAssets(data, "FieldName", "FieldValue"));
        action = action.toLowerCase();
        Common.sleep(1000);
        if (action.matches("save|saved")) {
            popup.save();
        } else if (action.matches("cancel|canceled")) {
            LibEditAssetClosePopup libEditAssetClosePopup=popup.cancel();
            libEditAssetClosePopup.clickClose();
        } else if (action.matches("close|closed")) {
            popup.close();
        } else if (action.matches("Save and accept")) {
           popup.saveAndAccept();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action '%s' for edit file popup", action));
        }
    }

    @Given("{I |}set following file info for next assets from collection '$collectionName'NEWLIB: $assetsTable")
    @When("{I |}set following file info for next assets from collection '$collectionName'NEWLIB: $assetsTable")
    public void setFileInfoForAssetsNewlib(String collectionName, ExamplesTable assetsTable) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        for (int i = 0; i < assetsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(assetsTable, i);
            Content asset = getAsset(collectionId, row.get("Name"));
            Common.sleep(2000);
            if (row.get("SubType") != null && !row.get("SubType").isEmpty())
                asset.setMediaSubType(row.get("SubType"));
            if (true) {
                if (row.get("Country") != null && !row.get("Country").isEmpty())
                    asset.setMetadataField("video", "country", row.get("Country"));
                if (row.get("Producer") != null && !row.get("Producer").isEmpty())
                    asset.setMetadataField("video", "Producer", row.get("Producer"));
                if (row.get("Market") != null && !row.get("Market").isEmpty()) {
                    asset.setMarket(new String[]{row.get("Market")});
                    asset.setMarketId(new String[]{getCoreApi().getMarketKey(row.get("Market"))});
                }
                if (row.get("Screen") != null && !row.get("Screen").isEmpty())
                    asset.setMetadataField("video", "screen", asList(row.get("Screen")));
                if (row.get("ClockNumber") != null && !row.get("ClockNumber").isEmpty())
                    asset.setMetadataField("video", "clockNumber", wrapVariableWithTestSession(row.get("ClockNumber")));
                if (row.get("Duration") != null && !row.get("Duration").isEmpty())
                    asset.setMetadataField("video", "duration", row.get("Duration"));
                if (row.get("Advertiser") != null && !row.get("Advertiser").isEmpty())
                    asset.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                if (row.get("Brand") != null && !row.get("Brand").isEmpty())
                    asset.setBrand(wrapVariableWithTestSession(row.get("Brand")));
                if (row.get("Campaign") != null && !row.get("Campaign").isEmpty())
                    asset.setCampaign(row.get("Campaign"));
                if (row.get("Title") != null && !row.get("Title").isEmpty())
                    asset.setName(row.get("Title"));
                if (row.get("AccountDirector") != null && !row.get("AccountDirector").isEmpty())
                    asset.setMetadataField("video", "accountDirector", row.get("AccountDirector"));
                if (row.get("AgencyTVProducer") != null && !row.get("AgencyTVProducer").isEmpty())
                    asset.setMetadataField("video", "agencyTVProducer", row.get("AgencyTVProducer"));
                if (row.get("ArtDirector") != null && !row.get("ArtDirector").isEmpty())
                    asset.setMetadataField("video", "artDirector", row.get("ArtDirector"));
                if (row.get("Copywriter") != null && !row.get("Copywriter").isEmpty())
                    asset.setMetadataField("video", "copywriter", row.get("Copywriter"));
                if (row.get("CreativeDirector") != null && !row.get("CreativeDirector").isEmpty())
                    asset.setMetadataField("video", "creativeDirector", row.get("CreativeDirector"));
                if (row.get("Director") != null && !row.get("Director").isEmpty())
                    asset.setMetadataField("video", "director", row.get("Director"));
                if (row.get("ExecutiveProducer") != null && !row.get("ExecutiveProducer").isEmpty())
                    asset.setMetadataField("video", "executiveProducer", row.get("ExecutiveProducer"));
                if (row.get("HeadOfTV") != null && !row.get("HeadOfTV").isEmpty())
                    asset.setMetadataField("video", "headOfTV", row.get("HeadOfTV"));
                if (row.get("ProductionCompany") != null && !row.get("ProductionCompany").isEmpty())
                    asset.setMetadataField("video", "productionCompany", row.get("ProductionCompany"));
                if (row.get("Category") != null && !row.get("Category").isEmpty())
                    asset.setMetadataField("video", "Category", asList(row.get("Category")));

            } else if (asset.getMediaType().equals("print")) {
                if (row.get("PrintMedia") != null && !row.get("PrintMedia").isEmpty())
                    asset.setMetadataField("print", "printMedia", asList(row.get("PrintMedia")));
                if (row.get("PrintStatus") != null && !row.get("PrintStatus").isEmpty())
                    asset.setMetadataField("print", "printStatus", asList(row.get("PrintStatus")));
            }

            getCoreApi().updateAsset(asset);
        }
    }


    @Then("{I |}'$shouldState' see asset '$assetName' info page for collection '$collectionName' in LibraryNEWLIB")
    public void checkVisibilityAssetsInfoPage(String shouldState, String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        boolean should = shouldState.equals("should");
        String expectedPage = String.format("collections/%s/assets/%s/info", collectionId, asset.getId());
        assertThat(expectedPage, should ? equalToIgnoringCase(BabylonSteps.getCurrentPageName()) : not(equalToIgnoringCase(BabylonSteps.getCurrentPageName())));
    }



    @When("{I |}'$downloadOption' on opened asset info pageNEWLIB")
    public void downloadOriginalFileFromInfoPage(String downloadOption) {
        LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
       switch(downloadOption.toLowerCase()) {
            case "download original":
                page.clickDownloadOnLibrary().selectDownloadMaster();
                LibDownLoadPopup popupMaster = new LibDownLoadPopup(page);
                popupMaster.clickDownloadButton();
                break;
           case "download proxy":
               page.clickDownloadOnLibrary().selectDownloadProxy();
               LibDownLoadPopup popupProxy = new LibDownLoadPopup(page);
               popupProxy.clickDownloadButton();
               break;
           default: throw new IllegalArgumentException(String.format("Unknown download options '%s'", downloadOption));
        }
   }


    @Then("{I |}'$condition' see '$button' button on opened asset info pageNEWLIB")
    public void checkVisibilityOfDownloadButton(String condition, String button) {
        LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        boolean expectedState = condition.equals("should");
        boolean actualState=false;
        button = button.toLowerCase();
        switch(button) {
            case "download":
                actualState = page.isDownloadButtonVisible();
                break;
            case "share asset":
                actualState = page.isShareAssetVisible();
                break;
            case "change media":
                actualState = page.isChangeMediaButtonVisible();
                break;
            case "download proxy":
                actualState = page.clickDownloadOnLibrary().isProxyDownloadVisible();
                break;
            case "download original":
                try{
                actualState = page.clickDownloadOnLibrary().isMasterDownloadVisible();}
                catch(Exception e){}
                break;
            case "download sendplus":
                actualState = page.clickDownloadOnLibrary().isDownloadSendplusButtonVisible();
                break;
            case "remove":
                actualState = page.isRemoveButtonVisible();
                break;
            case "attachments":
                actualState = page.isAttachmentsIconVisible();
                break;
            case "usage rights":
                actualState = page.isUsageRightsIconVisible();
                break;
            case "activities":
                actualState = page.isActivitiesIconVisible();
                break;
            case "projects":
                actualState = page.isProjectsIconVisible();
                break;
            case "info":
                actualState = page.isInfoIconVisible();
                break;
            case "deliveries":
                actualState = page.isAttachmentsIconVisible();
                break;
            default: throw new IllegalArgumentException(String.format("Unknown button name '%s'", button));
        }

        String message = String.format("Button '%s' is not present on opened asset info page", button);
        assertThat(message, actualState, equalTo(expectedState));
    }

    @When("{I |}add asset to project '$projectName' and folder '$folderName' on opened asset info pageNEWLIB")
    public void actionWithAddAssetToProjectPopUpOnOpenedAssetInfoPageNewLIB(String projectName, String folderName) {
        LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        page.openPopup().clickAddToProject();
        AddToProjectPopUp addToProjectPopup = new AddToProjectPopUp(page);
        addToProjectPopup.addToProjectFolder(wrapVariableWithTestSession(projectName), wrapVariableWithTestSession(folderName));
        addToProjectPopup.clickAdd();
    }


    @When("{I |}click on activities icon")
    public void clickActivities(){
        LibraryAssetsInfoPage assetInfoPage = getSut().getPageCreator().getLibraryAssetsInfoPageNEWLIB();
        assetInfoPage.clickActvities();
    }


    @Given("{I |}add assets '$assetName' to new presentation '$presentationName' on opened asset info pageNEWLIB")
    @When("{I |}add assets '$assetName' to new presentation '$presentationName' on opened asset info pageNEWLIB")
    public void AddAssetToNewPresentationOnAssetInfoPage(String assetName, String presentationName) {

        LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        page.openPopup().clickAddToPresentation();
        AddToPresentationPopUp addToPresentationPopup = new AddToPresentationPopUp(page);
        addToPresentationPopup.addTonewPresentation(wrapVariableWithTestSession(presentationName));

    }



    @Then("I should see preview on the library assets info page for asset '$assetName' in collection '$collectionName'NEWLIB")
    public void checkPreviewImageOnAssetInfoPageNEWLIB(String assetNames, String collectionName) {

        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        String[] assetArray = assetNames.split(",");
        for (String assetName : assetArray) {
        Content asset = getAsset(collectionId, assetName);
            LibraryAssetsInfoPage page =openLibraryAssetsInfoPage(collectionId, asset.getId());
        assertThat(page.isPreviewForFileAvailable(asset.getId(),assetName), equalTo(true));}

    }

    private LibraryAssetsInfoPage getLibraryAssetsInfoPage() {
        return getSut().getPageCreator().getLibraryAssetsInfoPageNEWLIB();
    }

    @Then("{I |}'$condition' see following xmp fields '$fieldsType' on opened asset info page for agency '$agency'NEWLIB: $data")
    public void checkAssetXMPInformationNEWLIB(String condition, String fieldsType, String agency, ExamplesTable data) {
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

   @Then("{I |}'$condition' see following '$fieldsType' fields on opened asset info pageNEWLIB: $data")
    public void checkAssetInformation(String condition, String fieldsType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> expectedFields = wrapMetadataFieldsAssets(data, "FieldName", "FieldValue");
        List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);
        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (MetadataItem expectedField : expectedFields)
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
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

    @Then("{I |}'$condition' see Edit link on opened asset info pageNEWLIB")
    public void checkVisibilityEditLink(String condition) {
        boolean expectedState = condition.equals("should");
        boolean actualState = getLibraryAssetsInfoPage().isEditLinkVisible();
        assertThat(actualState, is(expectedState));
        }

    @Then("{I |}should see following hyperlink fields on opened asset info pageNEWLIB:$fields")
    public void verifyHyperlinkFieldsonAssetInfoPage(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            String linkText = getLibraryAssetsInfoPage().getHyperlinkCustomMetadataValue(row.get("FieldName"));
            assertThat("Verify Hyperlink fields ", linkText, equalTo(row.get("FieldValue")));
        }
    }


    @Then("{I |}'$shouldState' see Download Original button on asset '$assetName' info page in Library for collection '$collectionName'NEWLIB")
    public void checkVisibilityDownloadOriginalButton(String shouldState, String assetName, String collectionName) {
        boolean actualState=false;
        boolean should = shouldState.equals("should");
        try{
            actualState=openAssetInfoPage(assetName,collectionName).isDownloadOriginalVisible();
        }
        catch(NullPointerException e){
            actualState=false;
        }
        assertThat(actualState, equalTo(should));
    }

    @Then("{I |}'$condition' see Edit link on asset '$assetName' info page in Library for collection '$categoriesName'NEWLIB")
    public void checkVisibilityEditLink(String condition, String assetName, String collectionName) {
        boolean expectedState = condition.equals("should");
        boolean actualState=false;
        try{
            actualState=openAssetInfoPage(assetName,collectionName).isEditLinkVisible();
        }
        catch(NullPointerException e){
            actualState=false;
        }
        assertThat(actualState, equalTo(expectedState));
    }




    @Given("{I |}click back to library Button on asset info page")
    @When("{I |}click back to library Button on asset info page")
    public void whenClickBackToLibraryButtonOnAssetInfoPage() {
        getLibraryAssetsInfoPage().clickBackToLibrary();
    }

    @Then("{I |}'$condition' see '$option' option in top level menu on collection '$collectionName'NEWLIB")
    public void checkVisibilityOfOptionsinTopLevelMenu(String condition, String option,String collectionName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        page.checkTopLevelMenuExist(option);
    }


    @When("{I |}click '$button' button on asset info page")
    public void clickSlateStoryBoard(String button){
        getLibraryAssetsInfoPage().openSlateStoryBoardMenu().clickSlateStoryBoardButton(button);
    }

    @When("{I |}select the slit image and '$resize' it")
        public void resizeSlitImage(String resize){
          switch (resize){
              case "maximize":
                  getLibraryAssetsInfoPage().expandSlitImage();
                  break;
              case "minimize":
                  getLibraryAssetsInfoPage().minimizeSlitImage();
                  break;
              default:
                  throw new IllegalArgumentException(String.format("Incorrect option %s in storyboard view",resize));

        }
    }

    @Then("{I |}'$condition' see slit image expanded")
        public void checkExapndedSlitImage(String condition){
          boolean should="should".equalsIgnoreCase(condition);
          assertThat(getLibraryAssetsInfoPage().checkExapndedSlitImage(),is(should));
        }
  /*  @Then("{I } should see the metadata in Asset Info page:$data")
    public void checkAssetMetadata(ExamplesTable data){
        List<MetadataItem> expectedFields = wrapMetadataFieldsAssets(data, "FieldName", "FieldValue");
        List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);
        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (MetadataItem expectedField : expectedFields)
            assertThat(actualFields, hasItem(expectedField));
    }*/

    @Then("{I |}'$condition' be able to see options '$menuOptions' on the asset info page")
    public void checkMenuOptions_slateStoryBoard(String condition,String menuOptions){
        Boolean should = condition.equalsIgnoreCase("should");
        List<String> options=getLibraryAssetsInfoPage().openSlateStoryBoardMenu().getStateStoryBoardOptions();
        for(String option:menuOptions.split(","))
            assertThat(option.toUpperCase(),should ? isIn(options):not(isIn(options)));
    }

    @Then("{I |}'$condition' see slate view on the asset info page")
    public void checkPresenceOfSlateView(String condition){
        Boolean should = condition.equalsIgnoreCase("should");
        assertThat(should,is(getLibraryAssetsInfoPage().isVideo_inSlateMode()));
    }

    @Then("{I |}'$condition' see storyboard view on the asset info page")
    public void checkPresenceOfStoryBoardView(String condition){
        Boolean should = condition.equalsIgnoreCase("should");
        assertThat(should,is(getLibraryAssetsInfoPage().isVideo_inStoryBoardMode()));
    }

    @Then("{I |}'$condition' be able to see '$errorMessage' error for '$field'")
    public void checkPresenceOfErrorMessage(String condition,String errorMessage,String field){
        Boolean should = condition.equalsIgnoreCase("should");
        assertThat(should,is(new LibEditFilePopup(getLibraryAssetsInfoPage()).getErrorMessage(field).equalsIgnoreCase(errorMessage)));
    }

    @Then("{I |}'$condition' see '$button' enabled")
    public void checkSaveButtonDisabled(String condition,String button){
        Boolean should = condition.equalsIgnoreCase("should");
        assertThat(should,is(new LibEditFilePopup(getLibraryAssetsInfoPage()).checkButtonEnabled(button)));
    }

    @When("{I |} click '$buttonName' button for the asset of the shared category on the asset info page")
    public void acceptRejectAssetSharedCategory(String buttonName){
        LibraryAssetsInfoPage assetInfoPage = getLibraryAssetsInfoPage();
        LibAcceptAssetSharedCategory acceptAssetSharedCategory = assetInfoPage.sharedCategoryButton(buttonName);
    }

    @When("{I |}wait for message '$message' in the asset info page")
    public void waitforAssetAcceptRejectMessage(String message){
        LibraryAssetsInfoPage assetInfoPage = getLibraryAssetsInfoPage();
        assetInfoPage.waitForMessage(message);
    }

    @When("{I |} click '$confirm' button in accept reject assets in assets info page")
    public void confirmAcceptRejectAssetSharedCategory(String confirm){
        LibAcceptAssetSharedCategory acceptAssetSharedCategory = new LibAcceptAssetSharedCategory(getLibraryAssetsInfoPage());
        switch (confirm){
            case "yes":
                acceptAssetSharedCategory.clickYes();
                break;
            case "cancel":
                acceptAssetSharedCategory.clickCancel();
                break;
            default:
                throw new IllegalArgumentException(String.format("%s is a incorrect option in this context",confirm));
        }
    }

    @Given("{I |}click '$action' on edit asset popup")
    @When("{I |}click '$action' on edit asset popup")
    public void clickSaveCancelAssetMetdata(String action){
        LibEditFilePopup popup = new LibEditFilePopup(getLibraryAssetsInfoPage());
        if (action.matches("cancel|canceled")) {
            LibEditAssetClosePopup libEditAssetClosePopup=popup.cancel();
            libEditAssetClosePopup.clickClose();
        } else if (action.matches("close|closed")) {
            popup.close();
        } else if (action.matches("Save and accept")) {
            popup.saveAndAccept();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action '%s' for edit file popup", action));
        }
    }

    @When("{I |} click Restore button on opened asset info pageNEWLIB")
    public void clickRestoreNewLib() {
        getLibraryAssetsInfoPage().clickRestore().action.click();
    }

    @Then("{I |}'$condition' be able to play clip on opened asset info pageNEWLIB")
    public void checkThatPlayerAvailableOnNewLib(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getLibraryAssetsInfoPage().isPlayerAvailable();
        assertThat(actualState, Matchers.is(expectedState));
    }

    @When("{I |}'$downloadOption' on opened asset info page using sendplus")
    public void downloadUsingSendplus(String downloadOption) {
        LibraryAssetsInfoPage page = getLibraryAssetsInfoPage();
        switch(downloadOption.toLowerCase()) {
            case "download master":
                page.clickDownloadOnLibrary().selectDownloadMaster();
                LibDownLoadPopup sendplusDownload = new LibDownLoadPopup(page);
                sendplusDownload.clicksendPlusDownload();
                break;
            default: throw new IllegalArgumentException(String.format("Unknown download options '%s'", downloadOption));
        }
    }

    @Then("{I |}'$condition' see usage expired text '$text' on opened asset info pageNEWLIB")
    public void checkUsageExpiredLabelPresentOnAssetInfoPage(String condition,String text) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState=getLibraryAssetsInfoPage().isUsageIndicatorLabelExist(text);
        assertThat(actualState, is(expectedState));
    }

}