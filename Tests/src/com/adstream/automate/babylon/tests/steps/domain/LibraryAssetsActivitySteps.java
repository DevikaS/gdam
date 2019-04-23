package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.dashboard.AdbankDashboardPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsActivityPage;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

public class LibraryAssetsActivitySteps extends LibraryAssetsViewSteps implements AssetActivity {

    @Given("I am on asset '$assetName' activity page in Library for collection '$categoryName'")
    @When("{I |}go to asset '$assetName' activity page in Library for collection '$categoryName'")
    public AdbankLibraryAssetsActivityPage openAssetActivityPage(String assetName, String categoryName) {
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null)
            asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getLibraryAssetsActivityPage(collectionId, asset.getId());
    }

    @When("{I |}click on filter button in Activity tab on asset Activity tab '$assetName' activity page for collection '$categoryName'")
    public void clickOnFilterButton(String assetName, String categoryName) {
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getAsset(collectionId, assetName);
        AdbankLibraryAssetsActivityPage activityPage = getSut().getPageNavigator().getLibraryAssetsActivityPage(collectionId, asset.getId());
        activityPage.clickFilterOnActivities();
    }

    @When("{I |}set Action '$action' on asset Activity tab '$assetName' activity page for collection '$categoryName'")
    public void setActionActivityComboBox(String action, String assetName, String categoryName) {
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getAsset(collectionId, assetName);
        AdbankLibraryAssetsActivityPage activityPage = getSut().getPageNavigator().getLibraryAssetsActivityPage(collectionId, asset.getId());
        activityPage.setActivityType(action);
    }

    @When("{I |} type an userName '$userName' on asset Activity tab '$assetName' activity page for collection '$categoryName'")
    public void typeUserNameFilter(String userName,String assetName, String categoryName) {
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getAsset(collectionId, assetName);
        AdbankLibraryAssetsActivityPage activityPage = getSut().getPageNavigator().getLibraryAssetsActivityPage(collectionId, asset.getId());
        activityPage.typeFilterUserName(wrapUserEmailWithTestSession(userName));
    }

    @When("{I |}play clip on asset '$assetName' activity page for category '$categoryName'")
    public void playClipOnAssetInfoPage(String assetName, String categoryName) {
        FlowPlayerProxy player = openAssetActivityPage(assetName, categoryName).getFlowPlayer();
        Common.sleep(2000);
        player.play();
        Common.sleep(1000);
        long startTime = System.currentTimeMillis();
        while (!player.isPaused()) {
            Common.sleep(1000);
            if (System.currentTimeMillis() - startTime > 120000) {
                Assert.fail("Your clip is very long");
            }
        }
    }

    @Given("{I |}choosed next filter on Recent Activity: action '$action' and user '$user' on asset activity page")
    @When("{I |}choose next filter on Recent Activity: action '$action' and user '$user' on asset activity page")
    public void chooseFilter(String action, String user) {
        AdbankLibraryAssetsActivityPage assetsActivityPage = getSut().getPageCreator().getAdbankLibraryAssetsActivityPage();
        AdbankLibraryAssetsActivityPage.AssetActivityFilter dashboardActivityFilter = assetsActivityPage.new AssetActivityFilter(assetsActivityPage);
        dashboardActivityFilter.chooseFilter(action, user.isEmpty() ? "" : wrapUserEmailWithTestSession(user));
    }

    /**
     * This new method will need to replace 'checkThatActivityPresent' method, because UIActivity is outdated
     * @param condition
     * @param assetName
     * @param categoryName
     * @param data
     */
    // | UserName | Message | Value |
    @Deprecated
    @Then("{I |}'$condition' see the following activities on asset '$assetName' activity page for collection '$categoryName': $data")
    public void checkThatActivity(String condition, String assetName, String categoryName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryAssetsActivityPage activityPage = openAssetActivityPage(assetName, categoryName);
        activityPage.load();
        activityPage.isLoaded();
        List<String> actualActivities = activityPage.getActivityList();
        User user = null;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            user  = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName")));
            String expectedActivity = createAnActivity(user.getFullName(), row.get("Message"), row.get("Value"),assetName).trim();
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    /**
     * This new method will need to replace 'checkThatActivityPresent' method, because UIActivity is outdated
     * @param condition
     * @param assetName
     * @param categoryName
     * @param data
     */
    // | UserName | Message | Value |
    @Deprecated
    @Then("{I |}'$condition' see the following activities on asset without refresh '$assetName' activity page for collection '$categoryName': $data")
    public void checkThatActivityWithoutRefresh(String condition, String assetName, String categoryName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getAsset(collectionId, assetName);
        AdbankLibraryAssetsActivityPage activityPage = getSut().getPageNavigator().getLibraryAssetsActivityPage(collectionId, asset.getId());
        List<String> actualActivities = activityPage.getActivityList();
        User user = null;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            user  = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName")));
            String expectedActivity = createAnActivity(user.getFullName(), row.get("Message"), row.get("Value"),assetName).trim();
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    @Deprecated
    private String createAnActivity(String userName, String message, String value,String assetName) {
        if (message.matches("(added asset to presentation)|(downloaded asset (master|proxy) from presentation)")) {
            message += " \"" + wrapVariableWithTestSession(value) + "\"";
            value = "";
        } else if (message.matches("shared asset with.*")) {
            int lastSpaceIndex = message.lastIndexOf(" ");
            User sharedUser = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(message.substring(lastSpaceIndex + 1)));
            message = String.format("%s %s (%s)", message.substring(0, lastSpaceIndex), sharedUser.getFullName(), sharedUser.getEmail());
        } else if (message.matches("(added asset to work request)")){
            message += ": " + wrapPathWithTestSession(value) + "/Originals/" + assetName;
            return String.format("%s %s", userName, message);
        } else if (message.matches("(added asset to project)")){
            message += ": " + wrapPathWithTestSession(value) + "/" + assetName;
            return String.format("%s %s", userName, message);
        }
        return String.format("%s %s %s", userName, message, value);
    }

    /**
     * Method need for checking activity like: 'Erick Cartman has shared asset to Kenny Winson (kerrywinson@gmail.com)' on asset activity page
     * @param condition should state
     * @param assetName file name in library which been share
     * @param collectionName collection/category name
     * @param senderName sender user email
     * @param recipientName recipient user email
     */
    @Then("{I |}'$condition' see activity on asset '$asset' collection '$collection' where user '$sender' has shared asset for user '$recipient'")
    public void checkSecureShareAssetActivity(String condition, String assetName, String collectionName, String senderName, String  recipientName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        AdbankLibraryAssetsActivityPage activityPage = getSut().getPageNavigator().getLibraryAssetsActivityPage(collectionId, asset.getId());

        secureShareAssetActivity(activityPage, condition, senderName, recipientName);
    }

    @Then("{I |}'$condition' see activity on asset '$assetName' collection '$collection' where user '$uploaderUser' was transcoded an asset")
    public void checkAssetWasTranscodedActivity(String condition, String assetName, String collection, String uploaderUser) {
        String collectionId = getCategoryId(wrapCollectionName(collection));
        Content asset = getAsset(collectionId, assetName);
        AdbankLibraryAssetsActivityPage activityPage = getSut().getPageNavigator().getLibraryAssetsActivityPage(collectionId, asset.getId());

        assetWasTranscodedActivity(activityPage, condition, uploaderUser);
    }

    @Then("{I |}'$condition' see activity on asset '$assetName' collection '$collection' where user '$uploaderUser' uploaded asset")
    public void checkAssetWasUploadedActivity(String condition, String assetName, String collection, String uploaderUser) {
        String collectionId = getCategoryId(wrapCollectionName(collection));
        Content asset = getAsset(collectionId, assetName);
        AdbankLibraryAssetsActivityPage activityPage = getSut().getPageNavigator().getLibraryAssetsActivityPage(collectionId, asset.getId());

        uploadAsset(activityPage, condition, uploaderUser);
    }

    @Then("{I |}'$condition' see activity on asset '$assetName' collection '$collection' where user '$uploaderUser' viewed asset")
    public void checkViewerActivity(String condition, String assetName, String collection, String uploaderUser) {
        String collectionId = getCategoryId(wrapCollectionName(collection));
        Content asset = getAsset(collectionId, assetName);
        AdbankLibraryAssetsActivityPage activityPage = getSut().getPageNavigator().getLibraryAssetsActivityPage(collectionId, asset.getId());

        viewedActivity(condition, uploaderUser);
    }

    @Override
    public void secureShareAssetActivity(AdbankLibraryAssetsActivityPage activityPage, String condition, String senderName, String recipientName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = activityPage.getActivityList();
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(senderName)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipientName)).getFullName();
        String expectedActivity = String.format("%s has shared asset to %s (%s)", senderFullName, recipientFullName, wrapUserEmailWithTestSession(recipientName));

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void viewedActivity(String condition, String viewerFullName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getSut().getPageCreator().getAdbankLibraryAssetsActivityPage().getActivityList();
        String fullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(viewerFullName)).getFullName();
        String expectedActivity = String.format("%s viewed asset", fullName);

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void assetWasTranscodedActivity(AdbankLibraryAssetsActivityPage activityPage, String condition, String uploaderName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = activityPage.getActivityList();
        String uploaderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(uploaderName)).getFullName();
        String expectedActivity = String.format("%s asset was transcoded", uploaderFullName);

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void uploadAsset(AdbankLibraryAssetsActivityPage activityPage, String condition, String uploaderName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = activityPage.getActivityList();
        String uploaderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(uploaderName)).getFullName();
        String expectedActivity = String.format("%s uploaded asset", uploaderFullName);

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }
}