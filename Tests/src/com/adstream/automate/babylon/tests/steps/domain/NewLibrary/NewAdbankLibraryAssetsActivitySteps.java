package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibraryAssetsActivityPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;
import static org.hamcrest.core.Is.is;

/**
 * Created by Janaki.Kamat on 26/09/2017.
 */
public class NewAdbankLibraryAssetsActivitySteps extends NewLibraryAssetsViewSteps {
    @Given("I am on asset '$assetName' activity page in Library for collection '$categoryName'NEWLIB")
    @When("{I |}go to asset '$assetName' activity page in Library for collection '$categoryName'NEWLIB")
    public NewAdbankLibraryAssetsActivityPage openActivityPage(String assetName, String categoryName) {
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null)
            asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getNewAdbankLibraryAssetsActivityPage(collectionId, asset.getId());
    }


    @Then("{I |}'$condition' see the following activities on asset '$assetName' activity page for collection '$categoryName'NEWLIB: $data")
    public void checkThatActivity(String condition, String assetName, String categoryName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getSut().getPageCreator().geNewAdbankLibraryAssetsActivityPage().getActivitiesDone();
        User user = null;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            user=getData().getUserByType(row.get("UserName"));
            if(user == null)
               user  = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName")));
            String expectedActivity = createAnActivity(user.getFullName(), row.get("Message"), row.get("Value"),assetName).trim();
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    @Then("{I |}'$condition' see the activities on asset '$assetName' activity page for collection '$categoryName' impersonated as '$userName'NEWLIB: $data")
    public void checkThatActivityUsingImpersonate(String condition, String assetName, String categoryName, String userName,ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        userName = wrapUserEmailWithTestSession(userName);
        User user1 =getCoreApi().getUserByEmail(userName);

        List<String> actualActivities = openActivityPageByImpersonate(assetName, categoryName, user1.getId()).getActivitiesDone();
        User user = null;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            user=getData().getUserByType(row.get("UserName"));
            if(user == null)
                user  = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName")));
            String expectedActivity = createAnActivity(user.getFullName(), row.get("Message"), row.get("Value"),assetName).trim();
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }



    @When("{I |}go to asset '$assetName' activity page in Library for collection '$categoryName'as impersonatedNEWLIB")
    public NewAdbankLibraryAssetsActivityPage openActivityPageByImpersonate(String assetName, String categoryName,String userId) {
        String collectionId = getCategoryIdForClient(wrapCollectionName(categoryName),userId);
        Content asset = getAssetForClient(collectionId, assetName,userId);
        if (asset == null)
            asset = getAssetForClient(collectionId, wrapVariableWithTestSession(assetName),userId);
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getNewAdbankLibraryAssetsActivityPage(collectionId, asset.getId());
    }


    private String createAnActivity(String userName, String message, String value,String assetName) {
          return String.format("%s %s %s", message,userName , value);
    }

    @Given("{I |}played clip on asset '$assetName' activity page for category '$categoryName'NEWLIB")
    @When("{I |}play clip on asset '$assetName' activity page for category '$categoryName'NEWLIB")
    public void playClipOnAssetInfoPage(String assetName, String categoryName) throws InterruptedException {
        NewAdbankLibraryAssetsActivityPage activityPage=openActivityPage(assetName, categoryName);
        activityPage.play();
    }



    @Then("{I |}'$condition' see the following activities under All activities dropdown for asset '$assetName' activity page for collection '$categoryName'NEWLIB: $data")
    public void checkActivityList(String condition, String assetName, String categoryName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = openActivityPage(assetName, categoryName).getListOfActivities();
        for (Map<String, String> row : parametrizeTableRows(data)) {
           assertThat(actualActivities, shouldState ? hasItem(row.get("Activity")) : not(hasItem(row.get("Activity"))));
        }
    }


    @When("{I |}enter user name '$userName' on activity page in Library")
    public void enterUserName(String userName) throws InterruptedException {
        NewAdbankLibraryAssetsActivityPage activityPage=getSut().getPageCreator().geNewAdbankLibraryAssetsActivityPage();
        User user=getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        activityPage.enterUserName(user.getFullName());
    }

    @When("{I |}search on activity page in Library: $data")
    public void searchActivityName(ExamplesTable data) throws InterruptedException {
        NewAdbankLibraryAssetsActivityPage activityPage = getSut().getPageCreator().geNewAdbankLibraryAssetsActivityPage();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            activityPage.searchActivityName(row.get("ActivityType"));
        }
     }


    @When("{I |}remove activities in activity page in Library: $data")
    public void removeActivityName(ExamplesTable data) throws InterruptedException {
        NewAdbankLibraryAssetsActivityPage activityPage = getSut().getPageCreator().geNewAdbankLibraryAssetsActivityPage();
        activityPage.removeActivityName(parametrizeTableRows(data));
    }


    @Then("{I |}'$condition' see the '$count' activities on asset '$assetName' activity page for collection '$categoryName': $data")
    public void checkActivity_Count(String condition, String count,String assetName, String categoryName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        int total = 0;
        List<String> actualActivities = getSut().getPageCreator().geNewAdbankLibraryAssetsActivityPage().getActivitiesDone();
        User user = null;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            user=getData().getUserByType(row.get("UserName"));
            if(user == null)
                user  = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName")));
            String expectedActivity = createAnActivity(user.getFullName(), row.get("Message"), row.get("Value"),assetName).trim();
            for (String activity:actualActivities){
                if(activity.equalsIgnoreCase(expectedActivity))
                    total++;
            }
            assertThat(total, shouldState ? equalTo(Integer.valueOf(count)) : not(equalTo(Integer.valueOf(count))));
        }
    }

    @Then("{I |}'$condition' see usage expired text '$text' on opened asset activity pageNEWLIB")
    public void checkUsageExpiredLabelPresentOnAssetActivityPage(String condition,String text) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState=getSut().getPageCreator().geNewAdbankLibraryAssetsActivityPage().isUsageIndicatorLabelExist(text);
        assertThat(actualState, is(expectedState));
    }

}
