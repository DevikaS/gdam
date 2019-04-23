package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Notification;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.babylon.sut.pages.adbank.notifications.AdBankNotificationsPage;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.DateTimeUtils;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.openqa.selenium.By;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 15.08.12
 * Time: 20:20
 */
public class NotificationSteps extends BabylonSteps {

    @Given("{I am |}on notifications page")
    @When("{I |}go on notifications page")
    public AdBankNotificationsPage openNotificationsPage() {
        return getSut().getPageNavigator().getNotificationsPage();
    }

    @When("I remove notification about user '$user' '$action' '$folder' on notifications page")
    public void removeNotification(String user, String action, String folder){
        AdBankNotificationsPage adBankNotificationsPage = this.openNotificationsPage();
        adBankNotificationsPage.removeNotification(user, action, wrapPathWithTestSession(folder).substring(1));
    }

    @When("I press 'Remove' button")
    public void pressRemoveButton(){
        AdBankNotificationsPage adBankNotificationsPage = this.openNotificationsPage();
        adBankNotificationsPage.clickRemoveButton();
    }

    @When("I click on notification about user '$user' '$action' '$folder' on notifications page")
    public void selectNotification(String user, String action, String folder){
        AdBankNotificationsPage adBankNotificationsPage = this.openNotificationsPage();
        adBankNotificationsPage.selectNotification(user, action, wrapPathWithTestSession(folder).substring(1));
    }

    @When("I select filter '$filterName' on notifications page")
    public void selectFilter(String filterName){
        AdBankNotificationsPage adBankNotificationsPage = this.openNotificationsPage();
        adBankNotificationsPage.selectFilterTab(filterName);
    }

    @Then("I should see filter '$filter' is selected")
    public void checkFilterSelected(String filterName){
        AdBankNotificationsPage adBankNotificationsPage = getSut().getPageCreator().getNotificationsPage();
        assertThat(adBankNotificationsPage.isFilterTabSelected(filterName),equalTo(true));
    }

    @When("I check 'SelectAll' checkbox")
    public void checkSelectAll(){
        AdBankNotificationsPage adBankNotificationsPage = getSut().getPageCreator().getNotificationsPage();
        adBankNotificationsPage.clickSelectAllCheckBox();
    }

    @Then("{I |}should see next counter '$count' notifications")
    public void checkCounterNotifications(int count) {
        GenericSteps.refreshPage();
        BaseAdBankPage page = getSut().getPageCreator().getBaseAdBankPage();
        assertThat(page.getNotificationsCounter(), equalTo(count));
    }

    @Then("{I |}should see in notifications dropdown next counter '$count' notifications")
    public void checkCountNotificationsInDropDown(int count) {
        BaseAdBankPage page = getSut().getPageCreator().getBaseAdBankPage();
        assertThat(page.getCountNotReadNotificationsInDropDown(), equalTo(count));
    }


    @When("{I |}click on share folder link '$path' for project '$projectName' in notifications dropdown")
    public void clickShareFolderLinkInNotificationsDropDown(String path, String projectName) {
        String projectId = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName)).getId();
        String folderName = normalizePath(wrapPathWithTestSession(path));
        getSut().getPageCreator().getBaseAdBankPage().clickFolderLinkInNotificationsDropDown(projectId, folderName);
    }

    @When("{I |}click on share '$type' link '$fileName' on notifications page")
    public void clickFileLinkOnNotificationsPage(String type, String fileName) {
        getSut().getPageNavigator().getNotificationsPage().clickSharedFileLinkByName(type, fileName);
    }

    @Then("{I |}should see next counter '$count' all notifications on Notifications page")
    public void checkCounterAllNotifications(int count) {
        AdBankNotificationsPage notificationsPage = getSut().getPageNavigator().getNotificationsPage();
        assertThat("Counter all notifications is wrong!!!",notificationsPage.getNotificationsAllCounter(), equalTo(count));
    }

    @Then("{I |}should see label '$label' for upper and bottom page counters")
    public void checkPageCounters(String label){
        AdBankNotificationsPage notificationsPage = getSut().getPageCreator().getNotificationsPage();
        assertThat(notificationsPage.getUpperPageLabel(), equalTo(label));
        assertThat(notificationsPage.getBottomPageLabel(), equalTo(label));
    }

    @Then("{I |}should see next sub counter '$count' notifications on Notifications page")
    public void checkSubCounterNotifications(int count) {
        AdBankNotificationsPage notificationsPage = getSut().getPageNavigator().getNotificationsPage();
        assertThat("Sub counter by period is wrong!!!",notificationsPage.getNotificationsSubCounter(), equalTo(count));
    }

    @Then("{I |}should see next count '$count' notifications items on Notifications page")
    public void checkCountNotificationsItem(int count) {
        AdBankNotificationsPage notificationsPage = getSut().getPageNavigator().getNotificationsPage();
        assertThat("Count notifications items is wrong!!!",notificationsPage.getCountNotificationsItemsOnPage(), equalTo(count));
    }

    @Then("{I |}should see on period tab '$tabName' notifications info for following folders '$folders' shared one by one by user '$userName'")
    public void checkNotificationsInfo(String tabName, String folders, String userName){
        AdBankNotificationsPage notificationsPage = getSut().getPageNavigator().getNotificationsPage();
        //notificationsPage.selectPeriodTabByName(tabName);    // right panel with opportunity to selecting period of notifications will be hidden
        String userEmail = wrapUserEmailWithTestSession(userName);
        User user = getCoreApi().getUserByEmail(userEmail);
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery("_subtype:element");
        query.setSortingField("_created");
        query.setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING);
        List<Notification> notifications = getCoreApi().getNotifications(false, query).getResult();
        int countNotifications = getCoreApi().getNotificationsCount(false);
        if (user != null) {
            List<String> userNames = notificationsPage.getUsersNameLink(true);
            assertThat("User's names is absent on notifications page!!!",userNames, not(nullValue()));
            List<String> foldersLink = notificationsPage.getFoldersLink(true);
            List<String> dateTimeCreateNotifications = notificationsPage.getDateTimeNotifications();
            String[] foldersArray = folders.split(",");
            assertThat("Count notifications is wrong !!!",userNames.size(), equalTo(countNotifications));
            assertThat("Notifications info is not present for all shared folders!!!",foldersLink.size(), equalTo(foldersArray.length));
            for (int i = 0; i < userNames.size(); i++) {
                assertThat(userNames.get(i), equalTo(user.getFullName()));
                String folder = normalizePath(wrapPathWithTestSession(foldersArray[i]));
                assertThat(foldersLink.get(i), equalTo(folder));
                DateTime dateCreated = notifications.get(i).getCreated();
                String dateTimeFormat = getData().getCurrentUser().getDateTimeFormatter().getDateTimeFormat();
                String dateCreateUI = DateTimeUtils.getFormattedUTCDate(dateTimeCreateNotifications.get(i), dateTimeFormat);
                String dateCreatedNotification = DateTimeUtils.formatDate(dateCreated, dateTimeFormat);
                assertThat(dateCreatedNotification, equalTo(dateCreateUI));
            }
        }  else {
            throw new NullPointerException("User wasn't found by following email " + userEmail + " .Please re-check user's email!!!");
        }
    }

    // | User | Folders |
    @Then("{I |}should see on period tab '$tabName' following notifications info : $notificationsTable")
    public void checkNotificationsInfoPage(String tabName, ExamplesTable notificationsTable) {
        AdBankNotificationsPage notificationsPage = getSut().getPageNavigator().getNotificationsPage();
        //notificationsPage.selectPeriodTabByName(tabName);  // right panel with opportunity to selecting period of notifications will be hidden
        List<String> userNames = notificationsPage.getUsersNameLink(false);
        List<String> foldersLink = notificationsPage.getFoldersLink(false);
        List<String> dateTimeCreateNotifications = notificationsPage.getDateTimeNotifications();
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery("_subtype:element");
        query.setSortingField("_created");
        query.setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING);
        List<Notification> notifications = getCoreApi().getNotifications(false, query).getResult();
        int countNotifications = getCoreApi().getNotificationsCount(false);
        assertThat("Count notifications is wrong !!!", userNames.size(),equalTo(countNotifications));
        for (int i=0; i < notificationsTable.getRowCount(); i++ ) {
            Map<String, String> row = parametrizeTabularRow(notificationsTable, i);
            String userEmail = wrapUserEmailWithTestSession(row.get("User"));
            User user = getCoreApi().getUserByEmail(userEmail);
            if (user != null) {
                assertThat(userNames.get(i), equalTo(user.getFullName()));
                String folders = row.get("Folders");
                String[] foldersArray = folders.split(",");
                assertThat("Check shared folders size on Notifications page:",foldersLink.size()==foldersArray.length); // To handle NGN-19534, Ignoring folders order
                for (int k = 0; k < foldersArray.length; k++) {
                    String folder = normalizePath(wrapPathWithTestSession(foldersArray[k]));
                    assertThat("Check shared folders on Notifications page",foldersLink.contains(folder)); // To handle NGN-19534, Ignoring folders order
                    //assertThat(foldersLink.get(k),equalTo(folder)); // To check the folder order
                }
                DateTime dateCreated = notifications.get(i).getCreated();
                String dateTimeFormat = getData().getCurrentUser().getDateTimeFormatter().getDateTimeFormat();
                String dateCreateUI = DateTimeUtils.getFormattedUTCDate(dateTimeCreateNotifications.get(i), dateTimeFormat);
                String dateCreatedNotification = DateTimeUtils.formatDate(dateCreated, dateTimeFormat);
                assertThat(dateCreatedNotification, equalTo(dateCreateUI));
            }   else {
                throw new NullPointerException("User wasn't found by following email " + userEmail + " .Please re-check user's email!!!");
            }
        }
    }

    @When("{I |}click on share folder link '$path' shared by user '$userName' on notifications page")
    public void clickShareFolderLinkOnNotificationsPage(String path, String userName) {
        AdBankNotificationsPage notificationsPage = getSut().getPageNavigator().getNotificationsPage();
        path = normalizePath(wrapPathWithTestSession(path));
        String userEmail = wrapUserEmailWithTestSession(userName);
        User user = getCoreApi().getUserByEmail(userEmail);
        if (user != null) {
            notificationsPage.clickFoldersLinkOnNotificationsPage(path, user.getFullName());
        }  else {
            throw new NullPointerException("User wasn't found by following email " + userEmail + " .Please re-check user's email!!!");
        }
    }

    @When("{I |}click on notifications menu in header on Project list page")
    @Alias("{I |}click on notifications menu in header")
    public void clickNotificationsCounter() {
        getSut().getPageCreator().getBaseAdBankPage().clickNotificationsMenuInHeader();
    }

    @When("{I |}click 'Next' button for bottom pagination on notifications page")
    public void clickBottomNextButton(){
        AdBankNotificationsPage adBankNotificationsPage = getSut().getPageCreator().getNotificationsPage();
        adBankNotificationsPage.clickNextButtonForBottomPagination();
    }

    @When("{I |}click 'Next' button for upper pagination on notifications page")
    public void clickUpperNextButton(){
        AdBankNotificationsPage adBankNotificationsPage = getSut().getPageCreator().getNotificationsPage();
        adBankNotificationsPage.clickNextButtonForUpperPagination();
    }

    @Then("I should see that notifications dropdown contains username '$userName' and folder '$folder'")
    public void checkNotificationDropDownText(String email, String folder) {
        BaseAdBankPage page = getSut().getPageCreator().getBaseAdBankPage();
        String name = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(email)).getFullName();
        assertThat(page.getNotificationDropdownText(), containsString(name));
        assertThat(page.getNotificationDropdownText(), containsString(wrapVariableWithTestSession(folder)));
    }


    @Then("{I |}'$condition' see that notifications dropdown contains info about sharing project '$projectName'")
    public void checkThatNotificationContainsProjectName(String condition, String projectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualNotification = getSut().getPageCreator().getBaseAdBankPage().getNotificationDropdownText();
        String expectedSubstring = wrapVariableWithTestSession(projectName);
        assertThat(actualNotification, shouldState ? containsString(expectedSubstring) : not(containsString(expectedSubstring)));
    }

    @Then("I should see 'Remove' button is disabled")
    public void checkRemoveButtonIsDisabled(){
        AdBankNotificationsPage adBankNotificationsPage = getSut().getPageCreator().getNotificationsPage();
        assertThat(adBankNotificationsPage.isRemoveButtonEnabled(), equalTo(true));
    }

    // | UserName | FileName |
    @Then("{I |}'$condition' see following notifications about sharing '$type' on notification page: $data")
    public void checkNotificationsAboutAssetSharing(String condition, String type, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualNotifications = getSut().getPageNavigator().getNotificationsPage().getListOfNotificationsAboutFileSharing(type);

        for (Map<String,String> row : parametrizeTableRows(data)) {
            Map<String,String> expectedNotification = new HashMap<String,String>();
            expectedNotification.put("UserName", new EmailSteps().getUserFullName(row.get("UserName")));
            expectedNotification.put("FileName", row.get("FileName"));

            assertThat(actualNotifications, shouldState ? hasItem(expectedNotification) : not(hasItem(expectedNotification)));
        }
    }
}