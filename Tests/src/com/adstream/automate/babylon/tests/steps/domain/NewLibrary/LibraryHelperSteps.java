package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibShareFilesPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.tests.RelativePathConverter;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/**
 * Created by Janaki.Kamat on 17/05/2017.
 */
public class LibraryHelperSteps extends BaseStep {

    protected Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    protected Project getTemplateByName(String templateName) {
        return getCoreApi().getTemplateByName(templateName);
    }

    protected void createAssetIfNotVisibleOnFirstPage(String collectionId, String fileName, int assetsOnPage) {
        String filePath = RelativePathConverter.getFullPath(fileName);
        File file = new File(filePath);
        Content asset = getAssetFromFirstPage(collectionId, file.getName(), assetsOnPage);
        if (asset == null) {
            getCoreApi().uploadAsset(file);
            getAssetFromFirstPage(collectionId, file.getName(), assetsOnPage, 10 * 1000);
        } else {
            Common.sleep(200);
        }
    }

    protected Content getAssetFromFirstPage(String collectionId, String assetId, int assetsOnPage) {
        List<Content> assets = getLastAssets(collectionId, assetsOnPage);
        for (Content asset : assets) {
            if (asset.getName().equals(assetId)) {
                return asset;
            }
        }
        return null;
    }

    protected Content getAssetFromFirstPage(String collectionId, String assetId, int assetsOnPage, long timeout) {
        long deadline = System.currentTimeMillis() + timeout;
        Content asset;
        while ((asset = getAssetFromFirstPage(collectionId, assetId, assetsOnPage)) == null) {
            Common.sleep(1000);
            if (System.currentTimeMillis() > deadline) {
                break;
            }
        }
        return asset;
    }

    protected Content getAsset(String collectionId, String assetId) {
        long timeout = System.currentTimeMillis() + 10 * 1000; // 10 seconds
        do {
            Content asset = getCoreApi().getAssetByName(collectionId, prepareAssetName(assetId));
            if (asset == null) {
                Common.sleep(1000);
            } else {
                return asset;
            }
        } while (System.currentTimeMillis() < timeout);
        return null;
    }

    protected Content getAssetForClient(String collectionId, String assetId,String userId) {
        long timeout = System.currentTimeMillis() + 10 * 1000; // 10 seconds
        do {
            Content asset = getCoreApi().getAssetByNameForClient(collectionId, prepareAssetName(assetId),userId);
            if (asset == null) {
                Common.sleep(1000);
            } else {
                return asset;
            }
        } while (System.currentTimeMillis() < timeout);
        return null;
    }


    public LibraryAsset openLibraryPageWithoutRefresh(String categoriesName) {
        String collectionName = wrapCollectionName(categoriesName);
        if (collectionName.equalsIgnoreCase("Everything") || collectionName.equalsIgnoreCase(""))
           return getSut().getPageCreator().getNewAdbankLibraryPage();
        return getSut().getPageCreator().getCollectionFilterPage();
    }

    protected String getCategoryId(String categoryName) {
        AssetFilter category = getCoreApi().getAssetsFilterByName(categoryName, "");
        if (category != null) {
            return category.getId();
        }
        throw new RuntimeException(String.format("Could not find category '%s'", categoryName));
    }

    protected String getCategoryIdForClient(String categoryName, String userId) {
        AssetFilter category = getCoreApi().getAssetsFilterByNameForClient(categoryName, "", userId);
        if (category != null) {
            return category.getId();
        }
        throw new RuntimeException(String.format("Could not find category '%s'", categoryName));
    }

    protected void createAsset(String fileName) {
        File file = new File(RelativePathConverter.getFullPath(fileName));
        getCoreApi().uploadAsset(file);
    }

    protected void createAsset(String fileName, String agencyId) {
        File file = new File(RelativePathConverter.getFullPath(fileName));
        getCoreApi().uploadAsset(file, null, agencyId);
    }

    protected DateTime parseDateTime(String date) {
        return parseDateTime(date, TestsContext.getInstance().storiesDateTimeFormat);
    }

    protected String prepareAssetName(String assetName) {
        // asset which directly uploaded to library is not wrapped and have some extension
        return assetName.contains(".") ? assetName : wrapVariableWithTestSession(assetName);
    }

    protected Content getLastUploadedUserAsset(String collectionId, String userId, String assetId) {
        // asset which directly uploaded to library is not wrapped and have some extension
        if (!assetId.contains("."))
            assetId = wrapVariableWithTestSession(assetId);
        return getCoreApi().getLastUploadedUserAssetById(collectionId, userId, assetId);
    }

    protected String[] getAssets(String collectionId) {
        long timeout = System.currentTimeMillis() + 10 * 1000; // 10 seconds
        List<String> assetInCollection= new ArrayList<String>();
        do {
            List<Content> assetList = getCoreApi().findAssets(collectionId).getResult();
            if (assetList.size() == 0) {
                Common.sleep(1000);
            } else {
                for(Content asset:assetList){
                    assetInCollection.add(asset.getId());
                }
                return assetInCollection.toArray(new String[assetInCollection.size()]);
            }
        } while (System.currentTimeMillis() < timeout);
        return null;
    }

    protected void createAttachedFile(String attachedFile, String collectionName, String assetName, String assetId) {
        Common.sleep(1000); // waiting for indexing and appearing asset in library
        String filePath = getFilePath(attachedFile);
        Content masterFile = getCoreApi().getAssetByName(collectionName, assetName);
        getCoreApi().uploadAttachedFile(new File(filePath), masterFile, assetId, "asset");
        long start = System.currentTimeMillis();
        do {
            Common.sleep(1000);
        } while (getCoreApi().getAssetByName(collectionName, assetName).getAttachedFiles().length == masterFile.getAttachedFiles().length
                && System.currentTimeMillis() - start < 10000);
    }

    protected List<Content> getLastAssets(String collectionId, int assetsOnPage) {
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setResultsOnPage(assetsOnPage).setSortingField("_created").setSortingOrder("desc");
        return getCoreApi().findAssets(collectionId, query).getResult();
    }


    protected Content createFolderOverCoreApi(String path, String objectName) {
        path = normalizePath(path);
        if (path.isEmpty()) return null;
        path = wrapPathWithTestSession(path);
        Project project = getObjectByName(wrapVariableWithTestSession(objectName));
        return getCoreApi().createFolderRecursive(path, project.getId(), project.getId());
    }

    protected Content createFolderTemplateOverCoreApi(String path, String objectName) {
        path = normalizePath(path);
        if (path.isEmpty()) return null;
        path = wrapPathWithTestSession(path);
        Project project = getTemplateByName(wrapVariableWithTestSession(objectName));
        return getCoreApi().createFolderRecursive(path, project.getId(), project.getId());
    }


    protected void addTermToCollectionQuery(JsonArray terms, String field, String value, boolean encloseInTerms) {
        if (value != null && !value.isEmpty()) {
            JsonArray arr = new JsonArray();
            arr.add(new JsonPrimitive(value));
            JsonObject term = new JsonObject();
            term.add(field, arr);
            if (encloseInTerms) {
                JsonObject obj = new JsonObject();
                obj.add("terms", term);
                terms.add(obj);
            } else {
                terms.add(term);
            }
        }
    }

    protected void fillShareAssetPopup(LibShareFilesPopup popup, Map<String, String> fields, boolean isSecureShare) {
        if (!(fields.get("ExpireDate") == null) && !fields.get("ExpireDate").isEmpty()) {
            popup.setExpirationDate(parseDateTime(fields.get("ExpireDate")).toString("MM/dd/yyyy"));
        }

        for (String userEmail : fields.get("UserEmails").split(","))
            popup.typeUserEmails(wrapUserEmailWithTestSession(userEmail));
        popup.typeMessage(fields.get("Message"), isSecureShare);

        if (Boolean.parseBoolean(fields.get("DownloadProxy"))) {
            popup.checkAllDownloadProxyCheckbox();
        } else {
            popup.uncheckAllDownloadProxyCheckbox();
        }

        if (Boolean.parseBoolean(fields.get("DownloadOriginal"))) {
            popup.checkDownloadOriginalCheckbox();
        } else {
            popup.uncheckDownloadOriginalCheckbox();
        }
        if (!(fields.get("AssetName") == null) && !fields.get("AssetName").isEmpty()) {
            popup.selectAssetToDownload(fields);
        }
        Common.sleep(2000);
        if (getSut().getWebDriver().isElementVisible(By.xpath("//ads-md-button[@click='$ctrl.notifyLink()']/button"))) {
            WebElement ele = getSut().getWebDriver().findElement(By.xpath("//ads-md-button[@click='$ctrl.notifyLink()']/button"));
            getSut().getWebDriver().scrollToElement(ele);
            getSut().getWebDriver().findElement(By.xpath("//ads-md-button[@click='$ctrl.notifyLink()']/button")).click();
        }
        if (getSut().getWebDriver().isElementVisible(By.xpath("//ads-md-button[@click='$ctrl.secureShare()']/button"))) {

            getSut().getWebDriver().clickThroughJavascript(By.xpath("//ads-md-button[@click='$ctrl.secureShare()']/button"));
        }
    }

    protected void fillShareMultipleAssetPopup(LibShareFilesPopup popup, Map<String, String> fields, boolean isSecureShare) {
        if (!(fields.get("ExpireDate") == null) && !fields.get("ExpireDate").isEmpty()) {
            popup.setExpirationDate(parseDateTime(fields.get("ExpireDate")).toString("dd/MM/yyyy"));
        }
        for (String userEmail : fields.get("UserEmails").split(","))
            popup.typeUserEmails(wrapUserEmailWithTestSession(userEmail));
        popup.typeMessage(fields.get("Message"), isSecureShare);
        Common.sleep(2000);
        getSut().getWebDriver().clickThroughJavascript(By.xpath("//ads-md-button[@click='$ctrl.secureShare()']/button"));
    }



    @When("{I }click library asset Tab on library page")
    public void clickLibraryAssetTab() {
       LibraryAsset libraryPage = getSut().getPageCreator().getNewAdbankLibraryPage();
       libraryPage.clickLibraryAssetTab();
       Common.sleep(1000);
    }

    @When("{I }click Collection Tab on library page")
    public void clickCollectionTab() {
        LibraryAsset libraryPage = getSut().getPageCreator().getNewAdbankLibraryPage();
        libraryPage.clickCollectionTab();
        Common.sleep(1000);
    }

    @Then("{I |} should see below fields in New Library:$data")
    public void checkLocalisationFields_LibraryPage(ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        LibraryAsset libraryPage = getSut().getPageCreator().getNewAdbankLibraryPage();
        if (row.containsKey("Library Asset Tab"))
            assertThat("Library Asset Tab is not localised", libraryPage.getLibraryAsset_Field().equalsIgnoreCase(row.get("Library Asset Tab")));
        if (row.containsKey("Last Uploaded"))
            assertThat("Last Uploaded is not localised", libraryPage.getSortByValue().equalsIgnoreCase(row.get("Last Uploaded")));
        if (row.containsKey("Select All on page"))
            assertThat("Select All on page is not localised", libraryPage.getSelectAll_Value().equalsIgnoreCase(row.get("Select All on page")));
        if (row.containsKey("Unselect All"))
            assertThat("Unselect All on page is not localised", libraryPage.getUnselectAll_Value().equalsIgnoreCase(row.get("Unselect All")));
   /*     if(row.containsKey("Show on page"))
            assertThat("Show on page field is not localised",libraryPage.getShowOnPage_Value().equalsIgnoreCase(row.get("Show on page")));
   */     if(row.containsKey("Upload Button"))
            assertThat("Upload Button is not localised",libraryPage.getUploadButton_Value().equalsIgnoreCase(row.get("Upload Button")));
        if(row.containsKey("DownLoad Button"))
            assertThat("Download Button is not localised",libraryPage.getDownloadButton_Value().equalsIgnoreCase(row.get("DownLoad Button")));
        if(row.containsKey("New Collection"))
            assertThat("New Collection is not localised",libraryPage.getNewCollectionButton_Value().equalsIgnoreCase(row.get("New Collection")));
        if(row.containsKey("Market"))
            assertThat("Market is not localised",libraryPage.getMarket_Label().equalsIgnoreCase(row.get("Market")));
        if(row.containsKey("Campaign"))
            assertThat("Campaign is not localised",libraryPage.getCampaign_Label().equalsIgnoreCase(row.get("Campaign")));
        if(row.containsKey("Advertiser"))
            assertThat("Advertiser is not localised",libraryPage.getAdvertiser_Label().equalsIgnoreCase(row.get("Advertiser")));
        if(row.containsKey("Originator"))
            assertThat("Originator is not localised",libraryPage.getOriginator_Label().equalsIgnoreCase(row.get("Originator")));
    }

    @Then("{I |}should see Media Types in the filter page:$data")
    public void checkLocalisationFields_FilterPage(ExamplesTable data) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName("Everything"));
        List<String> mediaTypes=page.getMediaSelector_Labels();
        for(Map<String,String> column:parametrizeTableRows(data)){
            String title=column.get("Media Type");
            assertThat(mediaTypes, hasItem(title));
        }
    }



    @Then("{I }'$condition' see popup menu options in '$collectionName' page: $popupMenuOptions")
    public void verifyColumnTitles(String condition,String collectionName,ExamplesTable popupMenuOptions) {
        boolean should=condition.equalsIgnoreCase("should");
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        List<String> menuNames=page.openPopup().getMenuOptionsInLibrary();
        for(Map<String,String> column:parametrizeTableRows(popupMenuOptions)){
            String title=column.get("Menu");
            assertThat(menuNames,should ? hasItem(title) : not(hasItem(title)));
        }
    }


    @Then("{I }am able to downloaded asset '$assetName' as '$assetType' from collection '$collectionName'")
       public void downloadAsset(String assetName,String assetType,String collectionName) {
        String collectionId=getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        assertThat(String.format("%s asset for %s in collection %s can't be downnloaded",assetType,asset,collectionName),getCoreApi().checkAssetDownloaded_newlibrary(assetName,asset.getId(),assetType).equals(true));
     }

    @Then("{I }am able to downloaded asset '$assetName' as '$assetType' from collection '$collectionName' using sendplus")
    public void downloadAsset_SendPlus(String assetName,String assetType,String collectionName) {
        String collectionId=getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        assertThat(String.format("%s asset for %s in collection %s can't be downnloaded using sendplus",assetType,assetName,collectionName),getCoreApi().checkAssetDownloadedSendplus(assetName,asset.getId(),assetType).equals(true));
    }

    @Then("{I }am able to downloaded storyboard for '$assetName' in collection '$collectionName'")
    public void downloadStoryBoard(String assetName,String collectionName) {
        String collectionId=getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        assertThat(String.format("Storyboard for the asset %s cannot be downloaded",assetName),getCoreApi().checkStoryBoardDownload(asset.getId(),getSut().getPageCreator().getLibraryAssetsInfoPageNEWLIB().getStoryBoardFileIds()).equals(true));
    }



    @When("{I }attach a file '$fileName' to WorkRequest '$workRequestName'")
    public void attachDocumentWorkRequest(String fileName,String workRequestName){
        Project fsObject = getCoreApi().getProjectByName(wrapPathWithTestSession(workRequestName));
        getCoreApi().uploadAttachedFile_WorkRequest(fsObject.getId(),getData().getCurrentUser().getAgency().getId(),new File(getFilePath(fileName)));

    }
}

