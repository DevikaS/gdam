package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.dashboard.AdbankDashboardPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsActivityPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 21.05.12 17:49
 */
public class DashboardSteps extends BaseStep implements FileActivity, ProjectActivity {

    private AdbankDashboardPage getDashboardPage() {
        return getSut().getPageCreator().getDashboardPage();
    }

    @Given("I am on Dashboard page")
    @When("{I |}go to Dashboard page")
    public AdbankDashboardPage openDashboardPage() {
        boolean needsRefresh = getSut().getPageUrl().startsWith("/projects");
        AdbankDashboardPage page = getSut().getPageNavigator().getDashboardPage();
        if (needsRefresh) {
            GenericSteps.refreshPage();
            Common.sleep(2000);
            page = getSut().getPageCreator().getDashboardPage();
        }
        return page;
    }

    @When("{I |}go to Delivery page")
    public void openDeliveryPage() {
        getDashboardPage().openDelivery();
    }

    @When("{I |}open link 'Upload to your library' in current window on Dashboard Page")
    public void openUploadYourLibraryLink() {
        openDashboardPage().openUploadYourLibraryLinkInCurrentWindow();
    }

    @When("{I |}open link 'Explore your library' on Dashboard Page")
    public void openExploreYourLibraryLink() {
        openDashboardPage().openExploreYourLibraryLink();
    }

    @When("{I |}click link 'Create a new presentation' on Dashboard Page")
    public void clickLinkCreateNewPresentation() {
        openDashboardPage().clickLinkCreateNewPresentation();
    }

    @When("{I |}click asset '$assetName' thumbnail in '$sectionName' section on Dashboard page")
    public void clickAssetThumbnailOnFilesSection(String assetName, String sectionName) {
        openDashboardPage().clickAssetThumbnailOnFilesSection(sectionName, assetName);
    }

    @When("{I |}click file '$assetName' link in '$activityMessage' activity in My Recent Activity section on Dashboard page")
    public void clickFileLinkOnRecentActivitySection(String assetName, String activityMessage) {
        openDashboardPage().clickFileLinkOnRecentActivitySection(assetName, activityMessage);
    }

    @When("{I |}click presentation '$presentationName' in 'Presentations' section on dashboard page")
    public void clickPresentationOnPresentationsSection(String presentationName) {
        openDashboardPage().clickPresentationOnPresentationsSection(wrapVariableWithTestSession(presentationName));
    }

    @When("{I |}click file '$fileName' in '$tabName' tab in 'Approvals' section on dashboard page")
    public void clickFileLinkOnApprovalsSection(String fileName, String tabName) {
        openDashboardPage().switchSectionTab(tabName, "Approvals");
        getDashboardPage().clickFileLinkOnApprovalsSection(fileName);
    }

    @When("{I |}fill 'New Presentation' popup with name '$presentationName' and description '$description' on Dashboard Page")
    public void fillNewPresentationPopup(String presentationName, String description) {
        getDashboardPage().fillNewPresentationPopup(wrapVariableWithTestSession(presentationName), description);
    }

    @Given("{I |}minimized '$sectionName' section on Dashboard page")
    @When("{I |}minimize '$sectionName' section on Dashboard page")
    public void minimizeSection(String sectionName) {
        AdbankDashboardPage page = getDashboardPage();
        if (page.isSectionExpanded(sectionName)) page.clickSectionMinimizeButton(sectionName);
    }

    @Given("{I |}maximized '$sectionName' section on Dashboard page")
    @When("{I |}maximize '$sectionName' section on Dashboard page")
    public void maximizeSection(String sectionName) {
        AdbankDashboardPage page = getDashboardPage();
        if (page.isSectionCollapsed(sectionName)) page.clickSectionMaximizeButton(sectionName);
    }

    @Given("{I |}switched tab to '$tabName' for section '$sectionName' on Dashboard page")
    @When("{I |}switch tab to '$tabName' for section '$sectionName' on Dashboard page")
    public void switchSectionTab(String tabName, String sectionName) {
        AdbankDashboardPage page = getDashboardPage();
        if (!page.isSectionTabActive(tabName, sectionName)) page.switchSectionTab(tabName, sectionName);
    }

    @Given("{I |}clicked link '$linkText' in '$sectionName' section on Dashboard page")
    @When("{I |}click link '$linkText' in '$sectionName' section on Dashboard page")
    public void clickMaximizedSectionLink(String linkText, String sectionName) {
        AdbankDashboardPage page = getDashboardPage();
        if (page.isSectionCollapsed(sectionName)) page.clickExpandedLinkOnSection(linkText, sectionName);
    }

    @Given("{I |}clicked go to top button on opened Dashboard page")
    @When("{I |}click go to top button on opened Dashboard page")
    public void clickGoToTopButton() {
        getDashboardPage().clickGoToTopButton();
    }

    @Given("{I |}scrolled down to footer on opened Dashboard page")
    @When("{I |}scroll down to footer on opened Dashboard page")
    public void scrollDownToFooter() {
        getDashboardPage().scrollDownToFooter();
    }

    @Given("{I |}scrolled down to footer '$times' times on opened Dashboard page")
    @When("{I |}scroll down to footer '$times' times on opened Dashboard page")
    public void scrollDownToFooter(int times) {
        for (int i = 0; i < times; i++) {
            getDashboardPage().scrollDown();
            Common.sleep(3000);
        }
    }

    @Given("{I |}clicked by last terms and condition in activity on Dashboard page")
    @When("{I |}click by last terms and condition in activity on Dashboard page")
    public void clickByLastTermsAndCondition() {
        openDashboardPage().clickByLastTermsAndConditionInActivity();
    }

    @Given("{I |}clicked following activity '$activity' on Dashboard page")
    @When("{I |}click following activity '$activity' on Dashboard page")
    public void clickOnActivity(String activity) {
        getSut().getPageCreator().getDashboardPage().clickLinkActivity(activity);
        Common.sleep(1000);
    }

    @Given("{I |}clicked Start a new project link on Dashboard page")
    @When("{I |}click Start a new project link on Dashboard page")
    public void clickCreateProjectLink() {
        openDashboardPage().clickStartNewProjectLink();
    }

    @Given("{I |}choosed next filter on Recent Activity: action '$action' and user '$user' on Dashboard page")
    @When("{I |}choose next filter on Recent Activity: action '$action' and user '$user' on Dashboard page")
    public void chooseFilter(String action, String user) {
        AdbankDashboardPage adbankDashboardPage = getSut().getPageCreator().getDashboardPage();
        AdbankDashboardPage.DashboardActivityFilter dashboardActivityFilter = adbankDashboardPage.new DashboardActivityFilter(this.getDashboardPage());
        dashboardActivityFilter.chooseFilter(action, user.isEmpty() ? "" : wrapUserEmailWithTestSession(user));
    }

    @Then("{I |}'$condition' see go to top counter with value '$expectedValue' opened Dashboard page")
    public void checkPageCounter(String condition, String expectedValue) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualValue = getDashboardPage().getPageCounterValue();

        assertThat(actualValue, shouldState ? equalTo(expectedValue) : not(equalTo(expectedValue)));
    }

    @Then("{I |}'$condition' be on top of the Dashboard page")
    public void checkItemsCounterIsNotVisible(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = !getDashboardPage().isItemsCounterVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}should see count '$count' of activity items on the Dashboard page")
    public void checkCountOfItemsOnProjectSearchPage(int count) {
        assertThat(getSut().getPageCreator().getDashboardPage().getActivityItemsCount(), equalTo(count));
    }

    @Then("{I |}'$condition' be on the Dashboard page")
    public void checkThatDashboardPageOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;

        try {
            getSut().getPageCreator().getDashboardPage();
        } catch (Exception e) {
            actualState = false;
        } finally {
            assertThat(actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see collapsed section '$sectionName' on Dashboard page")
    public void checkThatSectionCollapsed(String condition, String sectionName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getDashboardPage().isSectionCollapsed(sectionName);

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see expanded section '$sectionName' on Dashboard page")
    public void checkThatSectionExpanded(String condition, String sectionName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getDashboardPage().isSectionExpanded(sectionName);

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see section '$sectionNames' on Dashboard page")
    public void checkThatSectionPresent(String condition, String sectionNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        openDashboardPage();

        for (String sectionName : sectionNames.split(",")) {
            if (sectionName.isEmpty()) {
                continue;
            }
            String message = String.format("Section '%s' %s be presented", sectionName, condition);
            assertThat(message, getDashboardPage().isSectionPresent(sectionName), is(shouldState));
        }
    }

    @Then("{I |}'$condition' see link '$text' for collapsed section '$sectionName' on Dashboard page")
    public void checkThatLinkPresentOnCollapsedSection(String condition, String text, String sectionName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getDashboardPage().isLinkPresentOnCollapsedSection(text, sectionName);

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see text '$text' for expanded section '$sectionName' on Dashboard page")
    public void checkThatTextPresentOnExpandedSection(String condition, String text, String sectionName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getDashboardPage().isTextPresentOnExpandedSection(text, sectionName);

        assertThat(actualState, is(expectedState));
    }

    // | Name | Condition |
    @Then("{I |}should see following files in 'Latest Library Uploads' section on Dashboard page: $data")
    public void checkThatFilePresentOnLibraryFilesSection(ExamplesTable data) {
        List<String> actualFilesList = getDashboardPage().getFilesFromLibraryFilesSection();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            boolean shouldState = row.get("Condition").equalsIgnoreCase("should");
            assertThat(actualFilesList, shouldState ? hasItem(row.get("Name")) : not(hasItem(row.get("Name"))));
        }
    }

    // | Name | Condition |
    @Then("{I |}should see following presentations in 'Presentations' section on Dashboard page: $data")
    public void checkThatPresentationsPresentOnPresentationsSection(ExamplesTable data) {
        List<String> actualPresentationsList = openDashboardPage().getPresentationsFromPresentationsSection();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            boolean shouldState = row.get("Condition").equalsIgnoreCase("should");
            String expectedPresentationName = wrapVariableWithTestSession(row.get("Name"));
            assertThat(actualPresentationsList, shouldState ? hasItem(expectedPresentationName) : not(hasItem(expectedPresentationName)));
        }
    }

    @Then("{I |}'$condition' see '$files' file in 'Files in your projects' section on Dashboard page")
    public void checkThatFilePresentOnProjectFilesSection(String condition, String files) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (String file : files.split(",")) {
            assertThat(getDashboardPage().getFilesFromProjectFilesSection(), shouldState ? hasItem(file) : not(hasItem(file)));
        }
    }

    @Then("{I |}'$condition' see '$projectNames' project in 'My Projects' section on Dashboard page")
    public void checkThatProjectPresentOnProjectsSection(String condition, String projectNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualProjectsList = getDashboardPage().getProjectsFromProjectsSection();
        String expectedProject;

        for (String projectName : projectNames.split(",")) {
            expectedProject = wrapVariableWithTestSession(projectName);
            assertThat(actualProjectsList, shouldState ? hasItem(expectedProject) : not(hasItem(expectedProject)));
        }
    }

    @Then("{I |}'$condition' see '$presentationName' presentation in 'Presentations' section on Dashboard page")
    public void checkThatPresentationPresentOnPresentationsSection(String condition, String presentationNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualPresentationsList = getDashboardPage().getPresentationsFromPresentationsSection();

        for (String presentationName : presentationNames.split(",")) {
            String expectedPresentation = wrapVariableWithTestSession(presentationName);
            assertThat(actualPresentationsList, shouldState ? hasItem(expectedPresentation) : not(hasItem(expectedPresentation)));
        }
    }

    @Then("{I |}'$condition' see 'Quick start' links '$links'")
    public void checkThatQuickStartLinkPresent(String condition, String links) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> expectedLinksList = new ArrayList<String>();
        List<String> actualLinksList = openDashboardPage().getQuickStartLinksList();

        Collections.addAll(expectedLinksList, links.isEmpty() ? new String[]{} : links.split(","));
        Collections.sort(expectedLinksList);
        Collections.sort(actualLinksList);

        if (!actualLinksList.isEmpty() || !expectedLinksList.isEmpty())
            assertThat(actualLinksList, shouldState ? equalTo(expectedLinksList) : not(equalTo(expectedLinksList)));
    }

    // | UserName | Message | Value |
    @Deprecated
    @Then("{I |}'$condition' see following activities in 'Recent Activity' section on Dashboard page: $data")
    public void checkThatActivityPresentOnRecentActivitySection(String condition, ExamplesTable data) {
        openDashboardPage();
        checkThatActivityPresentOnOpenedRecentActivitySection(condition, data);
    }

    @Then("{I |}'$condition' see activity where user '$user' shared file '$file' to user '$userFullName' on Dashboard")
    public void checkSharedFileToUserActivity(String condition, String user, String file, String userFullName) {
        openDashboardPage();
        sharedFileToUserActivity(condition, user, file, userFullName);
    }

    @Then("{I |}'$condition' see activity where user '$user' shared asset '$file' to user '$userFullName' on Dashboard")
    public void checkSharedAssetToUserActivity(String condition, String user, String file, String userFullName) {
        openDashboardPage();
        sharedAssetToUserActivity(condition, user, file, userFullName);
    }

    @Then("{I |}'$condition' see activity where user '$user' shared folder '$project' to user '$userFullName' on Dashboard")
    public void checkSharedFolderToUserActivity(String condition, String user, String folder, String userFullName) {
        openDashboardPage();
        sharedFolderToUserActivity(condition, user, folder, userFullName);
    }

    @Then("{I |}'$condition' see activity where user '$user' shared project '$project' to user '$userFullName' on Dashboard")
    public void checkSharedProjectToUserActivity(String condition, String user, String project, String userFullName) {
        openDashboardPage();
        sharedProjectToUserActivity(condition, user, project, userFullName);
    }

    @Then("{I |}'$condition' see activity where user '$sharedUserEmail' has shared for approval '$fileName' on Dashboard")
    public void checkSharedForApproval(String condition, String sharedUserEmail, String fileName) {
        openDashboardPage();
        sharedForApproval(condition, sharedUserEmail, fileName);
    }

    // | UserName | Message | Value |
    @Then("{I |}'$condition' see following activities in 'Recent Activity' section on opened Dashboard page: $data")
    public void checkThatActivityPresentOnOpenedRecentActivitySection(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getDashboardPage().getRecentActivitiesList();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            String expectedActivity = createActivity(row.get("UserName"), row.get("Message"), row.get("Value"));
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    // | UserName | Message | Value |
    @Then("{I |}'$condition' see following activities in 'Recent Activity' new section on opened Dashboard page: $data")
    public void checkThatActivityPresentOnOpenedRecentActivitySectionNew(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getDashboardPage().getRecentActivitiesList();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            String expectedActivity = createActivity(row.get("UserName"), row.get("Message"), wrapVariableWithTestSession(row.get("Value")));
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    @When("{I |} type an userName '$userName' on activity filter Dashboard Page")
    public void typUsesNameFilter(String userName) {

        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        getDashboardPage().typeFilterUserName(user.getFullName());
    }

    @When("{I |}click link 'Filter' on Dashboard Page")
    public void clickFilterRecentActivityButton() {
        getDashboardPage().clickFilterOnRecentActivitySection();
    }

    @When("{I |}click link 'Cancel' on Dashboard Page")
    public void clickCancelRecentActivityButton() {
        getDashboardPage().clickCancelOnRecentActivitySection();
    }

    @When("{I |}set Action '$action' on Dashboard Page")
    public void setActionActivityComboBox(String action) {
        getDashboardPage().setActivityType(action);
    }

    @When("{I |}click on '$FileName' file in '$activity' activity on Dashboard Recent activity")
    public void clickOnFileLinkinActivity(String FileName, String activity) {
        getDashboardPage().clickFileLinkOnRecentActivitySection(FileName, activity);
    }

    @Then("{I |}'$condition' see activity: '$user' moved folder from '$basedProjectName' to '$destinationProjectName' and value '$value' on Dashboard")
    public void checkMovedActivity(String condition, String user, String basedProjectName, String destinationProjectName, String value) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getDashboardPage().getRecentActivitiesList();

        String expectedActivity = createMoveFolderdActivity(user, basedProjectName, destinationProjectName, value);
        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Then("{I |}'$condition' see assets count '$expectedAssetsCount' for presentation '$presentationName' on Dashboard page")
    public void checkAssetsCountForPresentation(String condition, String expectedAssetsCount, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualAssetsCount = openDashboardPage().getPresentationAssetsCount(wrapVariableWithTestSession(presentationName));

        assertThat(actualAssetsCount, shouldState ? equalTo(expectedAssetsCount) : not(equalTo(expectedAssetsCount)));
    }

    @Then("{I |}'$condition' see Duration '$expectedDuration' for presentation '$presentationName' on Dashboard page")
    public void checkThatAssetsTotalDurationIsCorrectlyDisplayed(String condition, String expectedDuration, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualDuration = openDashboardPage().getPresentationTotalDuration(wrapVariableWithTestSession(presentationName));

        assertThat(actualDuration, shouldState ? equalTo(expectedDuration) : not(equalTo(expectedDuration)));
    }

    @Then("{I |}'$condition' see files '$files' in 'Approvals' section on Dashboard page")
    public void checkThatFilesDisplayedOnApprovalsSection(String condition, String files) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFileList = getDashboardPage().getApprovalsFileList();

        for (String expectedFile : files.split(",")) {
            assertThat(actualFileList, shouldState ? hasItem(expectedFile) : not(hasItem(expectedFile)));
        }
    }

    @Then("{I |}'$condition' see the '$linkText' link in the navigation menu")
    public void isNavigationMenuProjectsLinkVisible(String condition, String linkText) {
        AdbankDashboardPage page = openDashboardPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = page.isMenuLinkVisible(linkText);

        assertThat(shouldState, equalTo(actualState));
    }

    @Deprecated
    protected String createActivity(String userName, String message, String value) {
        int lastSpaceIndex = message.lastIndexOf(" ");
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        if (message.matches("^(created (the |)project|updated (the |)project|clone the project|downloaded presentation|hat Projekt erstellt|" +
                "(created (the |)presentation)|(updated (the |)presentation)|(deleted (the |)presentation)" +
                "|Création d'un projet|creó el proyecto |downloaded folder)$")
                || value.matches("^Terms and Conditions for the project.+$")) {
            value = wrapVariableWithTestSession(value);
        } else if (message.matches("^(copied the file|moved the file).*")) {
            String[] parts = message.split("\"");
            String[] partsValue = value.split("/");
            value = String.format("/%s/%s", wrapVariableWithTestSession(partsValue[1]), partsValue[2]);
            message = String.format("%s\"%s\"%s\"%s\"",
                    parts[0], wrapPathWithTestSession(parts[1]), parts[2], wrapPathWithTestSession(parts[3]));
        } else if (message.matches("(^(commented|uploaded|downloaded|played|subió)|.*hochgeladen|.*Téléchargement).*")) {
            int lastSlashIndex = value.lastIndexOf("/");
            if (lastSlashIndex >= 0) {
                String path = value.substring(0, lastSlashIndex);
                String file = value.substring(lastSlashIndex);
                value = wrapPathWithTestSession(path) + file;
            }
        } else if (message.matches(".* (un)?shared (file|asset|folder|project|.*) (with|from|to).*")) {
            User sharedUser = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(message.substring(lastSpaceIndex + 1)));
            if (sharedUser.getFullName() == null){
                message = String.format("%s %s", message.substring(0, lastSpaceIndex), sharedUser.getEmail());
                value = wrapVariableWithTestSession(value);
            } else if (userName.isEmpty()) {
                return String.format("%s %s (%s) %s", message.substring(0, lastSpaceIndex), sharedUser.getFullName(), sharedUser.getEmail(), value);
            } else {
                message = String.format("%s %s (%s)", message.substring(0, lastSpaceIndex), sharedUser.getFullName(), sharedUser.getEmail());
            }
        }
        return String.format("%s %s %s", user.getFullName(), message, value);
    }

    private static String createMoveFolderdActivity(String userName, String basedProject, String destinationProject, String value) {
        String sessionId = getData().getSessionId();
        String userFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName)).getFullName();
        String wrappedPath = "";
        String wrappedBasePath = "";
        for (String part : destinationProject.split("/")) {
            wrappedPath += part + sessionId + "/";
        }
        wrappedPath = wrappedPath.substring(0, wrappedPath.length()-1);

        for (String part : basedProject.split("/")) {
            wrappedBasePath += part + sessionId + "/";
        }
        wrappedBasePath = wrappedBasePath.substring(0, wrappedBasePath.length()-1);

        return String.format("%s moved folder from \"%s\" to \"%s\" %s", userFullName, wrappedBasePath, wrappedPath, wrapVariableWithTestSession(value));
    }

    @Override
    public void transcodedFileActivity() {

    }

    @Override
    public void sharedFileToUserActivity(String condition, String sender, String file, String recipient) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getDashboardPage().getRecentActivitiesList();
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String expectedActivity = String.format("%s has shared %s to %s %s", senderFullName, file, wrapUserEmailWithTestSession(recipient), file);

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    public void sharedAssetToUserActivity(String condition, String sender, String file, String recipient) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getDashboardPage().getRecentActivitiesList();
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipient)).getFullName();
        String expectedActivity = String.format("%s has shared %s to %s (%s) %s",
                senderFullName, file, recipientFullName, wrapUserEmailWithTestSession(recipient), file);

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void sharedFolderToUserActivity(String condition, String sender, String folder, String recipient) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getDashboardPage().getRecentActivitiesList();
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String expectedActivity = String.format("%s has shared folder to %s %s", senderFullName, wrapUserEmailWithTestSession(recipient), wrapPathWithTestSession(folder));

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void sharedProjectToUserActivity(String condition, String sender, String project, String recipient) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getDashboardPage().getRecentActivitiesList();
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String expectedActivity = String.format("%s has shared project to %s %s", senderFullName, wrapUserEmailWithTestSession(recipient), wrapPathWithTestSession(project));

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Override
    public void uploadFileActivity(String condition, String uploaderEmail, String filePath) {

    }

    @Override
    public void createObject(String condition, String author, String objectName) {

    }

    @Override
    public void createFolder(String condition, String author, String folderName) {

    }

    @Override
    public void sharedFileToUser(String condition, String sharedUserEmail, String fileName, String recipientEmail) {

    }

    @Override
    public void updateObject(String condition, String author, String objectName) {

    }

    @Override
    public void downloadMasterFile(String condition, String uploader, String filePath) {

    }

    @Override
    public void commentedFileActivity() {

    }

    @Override
    public void movedFileFromFolderToFolder(String condition, String movedUserEmail, String folderName, String toFolderName, String fileName) {

    }

    @Override
    public void uploadedFileActivity() {

    }

    @Override
    public void viewedActivity(String condition, String viewerFullName) {

    }

    @Override
    public void sharedForApproval(String condition, String sharedUserEmail, String fileName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String sharedUserFullName = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(sharedUserEmail)).getFullName();
        List<String> actualActivities = getDashboardPage().getRecentActivitiesList();
        String expectedActivity = String.format("%s has shared for approval %s", sharedUserFullName, fileName);

        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    @Then("{I |}'$condition' see activity where user '$sender' shared folder '$project' to user '$receipient' on Dashboard Page")
    public void checkSharedFolderToUserActivityForWRFolder(String condition, String sender, String folder, String receipient) {
        openDashboardPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualActivities = getDashboardPage().getRecentActivitiesList();
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(receipient)).getFullName();
        String expectedActivity = String.format("%s has shared folder to %s (%s) %s",
                senderFullName,
                recipientFullName,
                wrapUserEmailWithTestSession(receipient),
                wrapVariableWithTestSession(folder));
        assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }
}