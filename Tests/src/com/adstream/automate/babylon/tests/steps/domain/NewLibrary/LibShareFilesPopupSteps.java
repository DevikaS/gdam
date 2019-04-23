package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibShareFilesPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.ShareFilesPopup;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;

import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by Janaki.Kamat on 17/07/2017.
 */
public class LibShareFilesPopupSteps extends NewLibrarySteps {
    private String publicLinkUrl=null;
    @When("{I |}add secure share for all assets from collection '$collectionName' to following usersNEWLIB: $data")
    public void addSecureShareOfFiles(String collectionName, ExamplesTable data) {
        LibraryAsset page = openLibraryPage(wrapCollectionName(collectionName));
        page.clickSelectAll();
        LibShareFilesPopup popup = page.openPopup().clickShareFilesButton().selectTab("SHARE");
        fillShareAssetPopup(popup, parametrizeTabularRow(data), true);

    }
    @When("{I |}add secure share for multiple assets from collection '$collectionName' to following usersNEWLIB: $data")
    public void addSecureShareOfFilesMultipleAssets(String collectionName, ExamplesTable data) {
        LibraryAsset page = openLibraryPage(wrapCollectionName(collectionName));
        page.clickSelectAll();
        LibShareFilesPopup popup = page.openPopup().clickShareFilesButton();
        fillShareMultipleAssetPopup(popup, parametrizeTabularRow(data), true);

    }

    @When("{I |}add secure share for asset without download permission '$fileName' from collection '$collectionName' to following usersNEWLIB: $data")
    public void addSecureShareOfFileWithoutDownloadpermission(String fileName, String collectionName, ExamplesTable data) {
        LibraryAsset page = openLibraryPage(collectionName);
        page.selectFileByFileName(fileName);
        LibShareFilesPopup popup = page.openPopup().clickShareFilesButton().selectTab("SHARE");
        fillShareAssetPopup(popup, parametrizeTabularRow(data), true);
    }

    @Then("{I |}'$condition' see '$tabName' tab on opened Share files popup from collection '$collectionName'NEWLIB")
    public void checkThatTabPresentsOnSharePopupNEWLIB(String condition, String tabName,String collectionName)
    {
       LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        LibShareFilesPopup popup = page.openPopup().clickShareFilesButton();
       boolean expectedState = condition.equals("should");
        boolean actualState = false;
        tabName = tabName.toLowerCase();
        switch (tabName) {
            case "public link":
                actualState = popup.isPublicLinkTabPresent();
                break;
            case "public link access":
                actualState = popup.isPublicLinkAccessTabPresent();
                break;
            default:
                throw new IllegalArgumentException(String.format("Unknown option name '%s'", tabName));
        }

        String message = String.format("Tab name '%s' is not present on opened asset info page", tabName);
        assertThat(message, actualState, is(expectedState));

    }

    @Then("{I |}'$condition' see following '$userCount' users on Secure Shares tab in Share files popup for asset '$fileName' on '$collection' Library pageNEWLIB: $data")
    public void checkThatUserPresentOnSecureSharesTab(String condition,int userCount,String fileName, String collection, ExamplesTable data) {

        boolean should = condition.equalsIgnoreCase("should") ? true : false;
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(collection);
        page.selectFileByFileName(fileName);
        LibShareFilesPopup popup = page.openPopup().clickShareFilesButton().selectTab("SECURE SHARES ("+userCount+")");
        List<Map<String, String>> actualUsers = popup.getSecurehareUserList();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            Map<String, String> expectedUser = new HashMap<>();
            expectedUser.put("UserName", getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName"))).getFullName());
            assertThat(actualUsers, should ? hasItem(expectedUser) : not(hasItem(expectedUser)));
        }
    }

    @Given("{I }send public link of asset '$fileName' from collection 'collectionName' to following usersNEWLIB: $data")
    @When("{I |}send public link of asset '$fileName' from collection '$collectionName' to following usersNEWLIB: $data")
    public void sendPublicLink(String fileName, String collectionName, ExamplesTable data) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        libraryPage.selectFileByFileName(fileName);
        LibShareFilesPopup popup = libraryPage.openPopup().clickShareFilesButton().selectTab("PUBLIC LINK");
        popup.activatePublicLink();
        fillShareAssetPopup(popup, parametrizeTabularRow(data), false);
    }

    @Given("{I |}added secure share for asset '$fileName' from collection '$collectionName' to following usersNEWLIB: $data")
    @When("{I |}add secure share for asset '$fileName' from collection '$collectionName' to following usersNEWLIB: $data")
    public void addSecureShareOfFileOverCore(String fileName, AssetFilter collection, ExamplesTable data) {
        Map<String, String> fields = parametrizeTabularRow(data);
        DateTime expirationDate = fields.get("ExpireDate")!=null?parseDateTime(fields.get("ExpireDate")):null;
        boolean downloadProxy = Boolean.parseBoolean(fields.get("DownloadProxy"));
        boolean downloadOriginal = Boolean.parseBoolean(fields.get("DownloadOriginal"));
        Content asset = getAsset(collection.getId(), fileName);
        List<String> users = new ArrayList<>();
        for (String email : fields.get("UserEmails").split(",")) {
            users.add(getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(email)).getId());
        }
        getCoreApi().shareAsset(Arrays.asList(asset.getId()), users, expirationDate, fields.get("Message"), downloadProxy, downloadOriginal);
    }

    @Given("{I }add public link of asset '$fileName' from collection 'collectionName' to following usersNEWLIB: $data")
    @When("{I |}add public link of asset '$fileName' from collection '$collectionName' to following usersNEWLIB: $data")
    public void createPublicLinkViaCore(String fileName, AssetFilter collectionName, ExamplesTable data) {
        Map<String, String> fields = parametrizeTabularRow(data);
        DateTime expirationDate = parseDateTime(fields.get("ExpireDate"));
        boolean downloadProxy = Boolean.parseBoolean(fields.get("DownloadProxy"));
        boolean downloadOriginal = Boolean.parseBoolean(fields.get("downloadOriginal"));
        Content asset = getAsset(collectionName.getId(), fileName);
        List<String> users = new ArrayList<>();
        for (String email : fields.get("UserEmails").split(",")) {
            users.add(getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(email)).getId());
        }
        getCoreApi().createAssetPublicShare(String.valueOf(asset.getId()), expirationDate.getMillis(), users);
    }


    @Then("{I |}'$condition' see following users on Public Shares tab in Share files popup for asset '$fileName' on '$collectionName' Library page: $data")
    public void checkThatUserPresentOnPublicSharesTab(String condition, String fileName, String collectionName,ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        getSut().getWebDriver().navigate().refresh();
        getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName)).selectFileByFileName(fileName);
        LibShareFilesPopup popup = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName)).clickShareFilesButton().selectTab("PUBLIC LINK ACCESS (0)");
        List<Map<String, String>> actualUsers = popup.getPublicShareUserList();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            Map<String,String> expectedUser = new HashMap<>();
            expectedUser.put("UserName", getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName"))).getFullName());
            assertThat(actualUsers, shouldState ? hasItem(expectedUser) : not(hasItem(expectedUser)));
        }
    }



    @When("{I |}'$action' public url for asset '$fileName' in collection '$collectionName'NEWLIB")
    public void activatePublicUrlForFileNewLib(String action, String fileName, String collectionName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));;
        page.selectFileByFileName(fileName);
        LibShareFilesPopup popup = page.openPopup().clickShareFilesButton().selectTab("PUBLIC LINK");
        if (action.equalsIgnoreCase("Activate")) {
            popup.activatePublicLink();
            Common.sleep(2000);
            this.publicLinkUrl=popup.getPublicLinkFieldValue();
            popup.clickSave();
        } else if (action.equalsIgnoreCase("Deactivate")) {
            popup.deactivatePublicLink();
            Common.sleep(1000);
            this.publicLinkUrl=popup.getPublicLinkFieldValue();
            popup.clickSave();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action: '%s' for public url", action));
        }
    }


    @When("{I |}open public url from opened Share files popupNEWLIB")
    public void openPublicUrlForFileNewLib() {
        getSut().getWebDriver().get(this.publicLinkUrl);

    }



    @Then("{I |}'$condition' see Public share tab on opened Share files popup in collection '$collectionName'NEWLIB")
    public void checkThatPublicShareTabPresents(String condition,String collectionName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName)).openPopup().clickShareFilesButton().isTabVisible("PUBLIC LINK ACCESS (0)");
        assertThat(actualState, is(expectedState));
    }


    @Then("{I |}should see below fields in share popup window:$data")
    public void checkLocalisationFields_SharesPopup(ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        LibShareFilesPopup shareFilesPopup = getSut().getPageCreator().getNewAdbankLibraryPage().openPopup().clickShareFilesButton();
        if (row.containsKey("SHARE"))
            assertThat("SHARE Tab shows localisation", shareFilesPopup.getShareTabLabel().equalsIgnoreCase(row.get("SHARE")));
        if (row.containsKey("SECURE SHARE"))
            assertThat("SECURE SHARE is not localised", shareFilesPopup.getSecureShareTabLabel().equalsIgnoreCase(row.get("SECURE SHARE")));
        if (row.containsKey("PUBLIC LINK"))
            assertThat("PUBLIC LINK on page is not localised", shareFilesPopup.getPublicLinkLabel().equalsIgnoreCase(row.get("PUBLIC LINK")));
        if (row.containsKey("PUBLIC LINK ACCESS"))
            assertThat("PUBLIC LINK ACCESS on page is not localised", shareFilesPopup.getPublicLinkAccessLabel().equalsIgnoreCase(row.get("PUBLIC LINK ACCESS")));
        if (row.containsKey("Sharing options"))
            assertThat("Sharing options on page is not localised", shareFilesPopup.getSharingOptionsLabel().equalsIgnoreCase(row.get("Sharing options")));
        if (row.containsKey("Download options"))
            assertThat("Download options on page is not localised", shareFilesPopup.getDownloadOptionsLabel().equalsIgnoreCase(row.get("Download Options")));
        if (row.containsKey("Add Message"))
            assertThat("Add Message on page is not localised", shareFilesPopup.getAddMessageLabel().equalsIgnoreCase(row.get("Add Message")));
        if (row.containsKey("Download Proxy"))
            assertThat("Download Proxy on page is not localised", shareFilesPopup.getDownloadProxyLabel().equalsIgnoreCase(row.get("Download Proxy")));
        if (row.containsKey("Download Original"))
            assertThat("Download Master on page is not localised", shareFilesPopup.getDownloadMasterLabel().equalsIgnoreCase(row.get("Download Original")));
        if (row.containsKey("Share never expires"))
            assertThat("Share never expires is not localised", shareFilesPopup.dateNeverExpriresLabel().equalsIgnoreCase(row.get("Share never expires")));
    }


}
