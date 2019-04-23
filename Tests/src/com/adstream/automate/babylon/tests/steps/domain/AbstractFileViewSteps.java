package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.approval.Approval;
import com.adstream.automate.babylon.JsonObjects.approval.ApprovalStage;
import com.adstream.automate.babylon.JsonObjects.approval.StageReminder;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.data.UsageRule;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import com.adstream.automate.utils.Common;
import org.apache.commons.httpclient.*;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.junit.Assert;
import org.openqa.selenium.WebElement;

import java.io.File;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 17.09.12
 * Time: 15:04
 */
public abstract class AbstractFileViewSteps extends AbstractProjectTabsSteps {
    public static String APPROVALS_DATE_TIME_FORMAT = "dd/MM/yyyy HH:mm";

    protected abstract Project getObjectByName(String objectName);

    protected abstract Project getObjectByName(String objectName, User user);

    protected abstract AdbankFilesInfoPage getFilesInfoPage(String projectId, String folderId, String fileId);

    protected abstract AdbankFileActivityPage getFileActivityPage(String projectId, String folderId, String fileId);

    protected abstract AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId);

    protected abstract AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId);

    protected abstract AdbankFileVersionHistoryPage getFileVersionHistoryPage(String projectId, String folderId, String fileId);

    protected abstract AdbankFileApprovalsPage getFileApprovalsPage(String projectId, String folderId, String fileId);

    protected abstract AdbankFileAttachmentsPage getFileAttachmentsPage(String projectId, String folderId, String fileId);

    protected abstract AdbankFileFramesPage getFileFramesPage(String projectId, String folderId, String fileId);

    protected abstract AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId);


    protected AdbankFilesInfoPage openFileInfoPage(String fileName, String path, String objectName) {

        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);

        return getFilesInfoPage(fsObject.getId(), folder.getId(), file.getId());
    }

    protected AdbankFilesInfoPage openFileInfoPage(String userPlan, String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        return getFilesInfoPage(fsObject.getId(), folder.getId(), file.getId());
    }

    protected AdbankFileCommentsPage openFileCommentsPage(String objectName, String path, String fileName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        return getFileCommentsPage(fsObject.getId(), folder.getId(), file.getId());
    }
    
    protected AdbankFileUsageRightsPage openFileUsageRightsPage(String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        return getFileUsageRightsPage(fsObject.getId(), folder.getId(), file.getId());
    }

    protected AdbankFileVersionHistoryPage openFileVersionHistoryPage(String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        return getFileVersionHistoryPage(fsObject.getId(), folder.getId(), file.getId());
    }

    protected AdbankFileVersionHistoryPage openClientFileVersionHistoryPage(String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        String[] url =getSut().getPageUrl().split("folders/");
        String[]  splitUrl = url[1].split("/files");
        final String folderId = splitUrl[0];
        Content file = getCoreApi().getFileByName(folderId, fileName);
        return getFileVersionHistoryPage(fsObject.getId(), folderId, file.getId());
    }

    protected AdbankFileApprovalsPage openFileApprovalsPage(String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        GenericSteps.refreshPage();
        return getFileApprovalsPage(fsObject.getId(), folder.getId(), file.getId());
    }
    protected AdbankFoldersTree getFoldersTree(String projectId, String folderId) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        if (folderId == null) {
            return pageFactory.getProjectOverviewPage(projectId);
        } else {
            return pageFactory.getProjectFilesPage(projectId, folderId);
        }
    }
    protected AdbankFileApprovalsPage openFileApprovalsPageForClient(String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        String[] url =getSut().getPageUrl().split("folders/");
        String[]  splitUrl = url[1].split("/files");
        final String folderId = splitUrl[0];
        Content file = getCoreApi().getFileByName(folderId, fileName);
        GenericSteps.refreshPage();
        return getFileApprovalsPage(fsObject.getId(), folderId, file.getId());
    }

    protected AdbankFileAttachmentsPage openFileAttachmentsPage(String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        return getFileAttachmentsPage(fsObject.getId(), folder.getId(), file.getId());
    }

    protected AdbankProjectFileRelatedFilesPage openProjectRelatedFilesPage(String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        return getProjectRelatedFilesPage(fsObject.getId(), folder.getId(), file.getId());
    }

    protected void createApprovalStage(String fileName, String path, String objectName, ExamplesTable data) {
        AdbankFileApprovalsPage page = openFileApprovalsPage(fileName, path, objectName);
        Common.sleep(2000);
        for (Map<String, String> row : parametrizeTableRows(data)) {
            StagePopUp popup = page.clickAddApprovalStage();
            fillApprovalStagePopup(row);
            Common.sleep(2000);
            if (Boolean.parseBoolean(row.get("Started"))) {
                if (page.isStartApprovalButtonPresent()) page.clickStartApproval();
            }else{
                popup.clickSaveAndCloseLink();
            }

        }
    }

    /**
     * @param fileName - is file name
     * @param path - is folder path to file
     * @param objectName - fs object name
     * @param data - data such as: | Name | Approvers | Deadline | Reminder | Started |
     */
    protected void createApprovalStageOverMiddlewareApi(String fileName, String path, String objectName, ExamplesTable data) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);

        for (Map<String, String> row : parametrizeTableRows(data)) {
            getMtApi().createApprovalStage(file, buildApprovalStage(fsObject, folder, file, row));
        }
    }

    protected void clickButtonOnApprovalStagePopup(String element) {
        StagePopUp popup = new StagePopUp(getSut().getPageCreator().getBasePage());

        if (element.equalsIgnoreCase("start")) {
            popup.clickAction();
        } else if (element.equalsIgnoreCase("save and close")) {
            popup.clickSaveAndCloseLink();
        } else if (element.equalsIgnoreCase("add new stage")) {
            popup.clickAddNewStageLink();
        } else {
            throw new IllegalArgumentException(String.format("Unknown element: '%s' for Approval stage popup", element));
        }

        Common.sleep(2000);
    }

    protected void clickButtonOnApprovalStagePopupwithoutdelay(String element) {
        StagePopUp popup = new StagePopUp(getSut().getPageCreator().getBasePage());

        if (element.equalsIgnoreCase("start")) {
            popup.clickAction();
        } else if (element.equalsIgnoreCase("save and close")) {
            popup.clickSaveAndCloseLink();
        } else if (element.equalsIgnoreCase("add new stage")) {
            popup.clickAddNewStageLink();
        } else {
            throw new IllegalArgumentException(String.format("Unknown element: '%s' for Approval stage popup", element));
        }

    }
    protected StagePopUp fillApprovalStagePopup(Map<String, String> fields) {
        StagePopUp popup = new StagePopUp(getSut().getPageCreator().getBasePage());

        if (fields.get("Name") != null) popup.typeName(wrapVariableWithTestSession(fields.get("Name")));
        if (fields.get("Description") != null) popup.typeDescription(fields.get("Description"));
//      if (fields.get("Deadline") != null) popup.setDeadline(parseDateTime(fields.get("Deadline"), APPROVALS_DATE_TIME_FORMAT));
//      if (fields.get("Reminder") != null) popup.setReminder(parseDateTime(fields.get("Reminder"), APPROVALS_DATE_TIME_FORMAT));

        if (fields.get("Deadline") != null)
            popup.setDeadline(parseDateTime(fields.get("Deadline"), APPROVALS_DATE_TIME_FORMAT));
        else
            popup.setDeadline(parseDateTime("01/05/2023 12:15", APPROVALS_DATE_TIME_FORMAT));

        if (fields.get("Reminder") != null)
            popup.setReminder(parseDateTime(fields.get("Reminder"), APPROVALS_DATE_TIME_FORMAT));
        else
            popup.setReminder(parseDateTime("01/05/2023 08:00", APPROVALS_DATE_TIME_FORMAT));


        if (fields.get("Approvers") != null) {
            for (String approver : fields.get("Approvers").split(",")) {
                User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(approver.trim()));

                if (user == null || !user.getAgency().getId().equalsIgnoreCase(getData().getCurrentUser().getAgency().getId())) {
                    popup.addAnonymousApproverToStage(wrapUserEmailWithTestSession(approver.trim()));
                } else {
                    popup.addApproverToStage(user.getFullName(), user.getEmail());
                }
            }
        }

        if (fields.get("SingleApproval") != null || fields.get("AllMustApprove") != null || fields.get("Owner") != null || fields.get("NotifyUsers") != null) {
            popup.clickAdvancedSettingsButton();
            if (fields.get("SingleApproval") != null && fields.get("SingleApproval").equalsIgnoreCase("checked"))
                popup.clickSingleApprovalsRadioButton();
            if (fields.get("AllMustApprove") != null && fields.get("AllMustApprove").equalsIgnoreCase("checked"))
                popup.clickAllMustApproveRadioButton();

            if (fields.get("Owner") != null && !fields.get("Owner").isEmpty()) {
                popup.expandOwnersForm();
                popup.selectOwner(getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(fields.get("Owner"))).getFullName());
                popup.clickMakeStageOwnerButton();
            }
            if (fields.get("NotifyUsers") != null) {
                for (String NotifyUser : fields.get("NotifyUsers").split(",")) {
                    User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(NotifyUser.trim()));
                    if (user == null || !user.getAgency().getId().equalsIgnoreCase(getData().getCurrentUser().getAgency().getId())) {
                        popup.addAnonymoususerToStage(wrapUserEmailWithTestSession(NotifyUser.trim()));
                    } else {
                        popup.selectUsersToNotify(user.getFullName(), user.getEmail());
                    }
                }
            }
            Common.sleep(1000);
            popup.clickSaveAndBack();
        }

        Common.sleep(2000);
        return popup;
    }

    protected StagePopUp fillApprovalStagePopupForClient(Map<String, String> fields) {
        StagePopUp popup = new StagePopUp(getSut().getPageCreator().getBasePage());

        if (fields.get("Name") != null) popup.typeName(wrapVariableWithTestSession(fields.get("Name")));
        if (fields.get("Description") != null) popup.typeDescription(fields.get("Description"));
//      if (fields.get("Deadline") != null) popup.setDeadline(parseDateTime(fields.get("Deadline"), APPROVALS_DATE_TIME_FORMAT));
//      if (fields.get("Reminder") != null) popup.setReminder(parseDateTime(fields.get("Reminder"), APPROVALS_DATE_TIME_FORMAT));

        if (fields.get("Deadline") != null)
            popup.setDeadline(parseDateTime(fields.get("Deadline"), APPROVALS_DATE_TIME_FORMAT));
        else
            popup.setDeadline(parseDateTime("01/05/2023 12:15", APPROVALS_DATE_TIME_FORMAT));

        if (fields.get("Reminder") != null)
            popup.setReminder(parseDateTime(fields.get("Reminder"), APPROVALS_DATE_TIME_FORMAT));
        else
            popup.setReminder(parseDateTime("01/05/2023 08:00", APPROVALS_DATE_TIME_FORMAT));


        if (fields.get("Approvers") != null) {
            for (String approver : fields.get("Approvers").split(",")) {
                popup.addAnonymousApproverToStage(approver.trim());
            }
        }

        if (fields.get("SingleApproval") != null || fields.get("AllMustApprove") != null || fields.get("Owner") != null) {
            popup.clickAdvancedSettingsButton();
            if (fields.get("SingleApproval") != null && fields.get("SingleApproval").equalsIgnoreCase("checked"))
                popup.clickSingleApprovalsRadioButton();
            if (fields.get("AllMustApprove") != null && fields.get("AllMustApprove").equalsIgnoreCase("checked"))
                popup.clickAllMustApproveRadioButton();

            if (fields.get("Owner") != null && !fields.get("Owner").isEmpty()) {
                popup.expandOwnersForm();
                popup.selectOwner(fields.get("Owner"));
                popup.clickMakeStageOwnerButton();
            }
            Common.sleep(1000);
            popup.clickSaveAndBack();
        }

        Common.sleep(2000);
        return popup;
    }

    protected void startApproval(String fileName, String path, String objectName) {
        openFileApprovalsPage(fileName, path, objectName).clickStartApproval();
    }

    protected void approveOrRejectStage(String fileName, String path, String objectName, String stageName, String action, String comment) {
        ApprovalCommentPopUp popup = openFileApprovalsPage(fileName, path, objectName)
                .approveOrRejectStageByName(wrapVariableWithTestSession(stageName), action);
        popup.typeComment(comment);
        popup.action.click();
    }

    protected void checkThatApprovalStagePresent(String condition, String fileName, String path, String objectName, String stageName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String expectedStageName = wrapVariableWithTestSession(stageName);
        List<String> actualStagesNames = openFileApprovalsPage(fileName, path, objectName).getAllApprovalsStages();
        assertThat(actualStagesNames, shouldState ? hasItem(expectedStageName) : not(hasItem(expectedStageName)));
    }

    protected void checkCountActivitiesFileInfoPage(int count, String tabName, String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFileActivityPage fileActivityPage = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId());
        assertThat("Navigation tab " + tabName + " is not present on file info page!", fileActivityPage.isNavigationTabPresent(tabName.toLowerCase()), equalTo(true));
        assertThat(fileActivityPage.getActivitiesCount(), equalTo(count));
    }

    protected void clickUserNameOnActivity(String userName, String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFileActivityPage fileActivityPage = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId());
        assertThat("Navigation tab Activity is not present on file info page!", fileActivityPage.isNavigationTabPresent("activity"), equalTo(true));
        String userEmail = wrapUserEmailWithTestSession(userName);
        User user = getCoreApiAdmin().getUserByEmail(userEmail);
        if (user != null) {
            fileActivityPage.clickUserInActivities(user);
        } else {
            throw new NullPointerException("User was not found by following email " + userEmail + " .Please check that email is correct!!!");
        }
    }

    protected void clickFilterOnActivityTab( String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFileActivityPage fileActivityPage = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId());
        fileActivityPage.clickFilterOnActivities();
    }

    protected void setActionOnActivityTab(String action, String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFileActivityPage fileActivityPage = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId());
        fileActivityPage.setActivityType(action);
    }

    protected void setUserNameOnActivityTab(String userName, String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFileActivityPage fileActivityPage = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId());
        fileActivityPage.typeFilterUserName(wrapUserEmailWithTestSession(userName));
    }


    protected void checkObjectActivityEmpty(String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        List<Map<String, String>> actualActivities = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId()).getActivities();

        assertThat("Activity list is empty!", actualActivities.size(), equalTo(0));
    }

    // | User | Logo | ActivityType | ActivityMessage |
    // activityType: copied, moved, file_uploaded, created, file_downloaded
    protected void checkObjectActivity(boolean shouldState, String filePath, String path, String objectName, ExamplesTable data) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());

        List<Map<String, String>> actualActivities = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId()).getActivities();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("User")));
            if (user == null) {
                throw new NullPointerException("User was not found by following email " + wrapUserEmailWithTestSession(row.get("User")));
            }
            Map<String, String> expectedActivity = new HashMap<>();
            expectedActivity.put("UserName", user.getFullName());

            if (row.get("Logo") == null || row.get("Logo").isEmpty() || row.get("Logo").equals("EMPTY")) {

                expectedActivity.put("Logo", Integer.toString(Logo.EMPTY.getBytes().length));
            } else {
                expectedActivity.put("Logo", Integer.toString(Logo.valueOf(row.get("Logo")).getBytes().length));
            }

            if (row.get("ActivityType").matches("copied|moved")) {

                String quoteSymbol = row.get("ActivityMessage").contains("'") ? "'" : "\"";
                String[] parts = row.get("ActivityMessage").split("['\"]");
                expectedActivity.put("ActivityMessage",
                        parts[0] + quoteSymbol + wrapPathWithTestSession(parts[1]) + quoteSymbol
                        + parts[2] + quoteSymbol + wrapPathWithTestSession(parts[3]) + quoteSymbol);
            } else if(row.get("ActivityType").equals("moved_to_project")){

                expectedActivity.put("ActivityMessage", row.get("ActivityMessage") + " " + filePath);
            } else {

                expectedActivity.put("ActivityMessage", row.get("ActivityMessage"));
            }
           // System.out.println("Expected-------------"+expectedActivity);
           // System.out.println("Actual-------------"+actualActivities);
            assertThat(actualActivities, shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    protected void playClip(String fileName, String path, String objectName) {
        AdbankFilesInfoPage page = openFileInfoPage(fileName, path, objectName);
        FlowPlayerProxy player = page.getFlowPlayer();
        Common.sleep(1000);
        player.play();
    }

    protected void checkActivityFileInfoPage(String shouldState, String userName, String fileName, String objectName, String path, String message, String value) {
        Common.sleep(1000);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        AdbankFileActivityPage page = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId());
        checkActivity(page, shouldState.equals("should"), userName, message, value);
    }

    protected void checkTheActivityFileInfoPage(String shouldState, String fileName, String objectName, String path, ExamplesTable data) {
        Common.sleep(1000);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        AdbankFileActivityPage page = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId());
        List<String> actualActivities = page.getActivityList();
        User user;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            String expectedActivity;
            user  = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName")));
            if (row.get("Value") != null) {
                expectedActivity = String.format("%s %s %s", user.getFullName(), row.get("Message"), row.get("Value"));
            } else {
                expectedActivity = String.format("%s %s %s", user.getFirstName(), user.getLastName(), row.get("Message"));
            }

            assertThat(actualActivities, shouldState.equals("should") ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
        }
    }

    protected void clickUserInFileActivities(String objectName, String path, String fileName, String userName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        AdbankFileActivityPage page = getFileActivityPage(fsObject.getId(), folder.getId(), file.getId());
        page.clickUserInActivities(user);
    }

    protected void checkThatPlayerAvailable(String condition, String file, String path, String objectName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openFileInfoPage(new File(file).getName(), path, objectName).isPlayerAvailable();

        assertThat(actualState, is(expectedState));
    }

    protected void checkDownloadLinksOnFileDownloadPopup(String condition, String linkType, String file, String path, String objectName) {
        if (!linkType.toLowerCase().matches("original|preview|proxy"))
            throw new IllegalArgumentException("Type of link incorrect. It must be 'original' or 'preview'");

        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = openFileInfoPage(new File(file).getName(), path, objectName)
                .clickDownloadButton().isLinkVisible(linkType);

        assertThat(actualState, is(expectedState));
    }

    protected void checkDownloadLinks(String condition, String linkType, String file, String path, String objectName) {
        if (!linkType.equalsIgnoreCase("original") && !linkType.equalsIgnoreCase("preview") && !linkType.equalsIgnoreCase("proxy"))
            throw new IllegalArgumentException("Type of link for check file download defines incorrect. It must be 'original' or 'preview'");

        boolean expectedState = condition.equalsIgnoreCase("should");
        AdbankFileViewPage page = openFileInfoPage(new File(file).getName(), path, objectName);
        boolean actualState = linkType.equalsIgnoreCase("original") ? page.isDownloadOriginalButtonVisible() : page.isDownloadProxyButtonVisible();

        assertThat(actualState, is(expectedState));
    }

    protected void checkDownloadingVideoFileName(String condition, String button, String filePath, String path, String objectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String expectedFileId = "";
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());

        if (button.equalsIgnoreCase("Original")) {
            expectedFileId = file.getLastRevision().getMaster().getFileID();
        } else if (button.equalsIgnoreCase("Preview")) {
            for (FilePreview preview : file.getLastRevision().getPreview())
                if (preview.getA5Type().equals("video_proxy")) expectedFileId = preview.getFileID();
        } else {
            throw new IllegalArgumentException(String.format("Unknown download button: '%s'", button));
        }

        String actualFileId = openFileInfoPage(new File(filePath).getName(), path, objectName).getDownloadingFileId(button);

        assertThat(actualFileId, shouldState ? equalTo(expectedFileId) : not(equalTo(expectedFileId)));
    }

    protected void checkThatComboboxHasValues(String condition, String field, List<String> values, String file, String path, String objectName) {
        checkThatComboboxHasValues(condition, null, field, values, file, path, objectName);
    }

    protected void checkThatComboboxHasValues(String condition, String section, String field, List<String> values, String file, String path, String objectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        EditFilePopup popup = openFileInfoPage(new File(file).getName(), path, objectName).clickEditLink();
        List<String> actualValues = popup.getAvailableComboBoxValues(field, section);
        for (String expectedValue : values)
            assertThat(actualValues, shouldState ? hasItem(expectedValue) : not(hasItem(expectedValue)));
    }

    protected void downloadFile(String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFilesInfoPage filesInfoPage = getFilesInfoPage(fsObject.getId(), folder.getId(), file.getId());
        filesInfoPage.triggerDownloadEventWithoutDownloading(file.getId(), true);
    }

    protected void downloadFile(String type, String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFilesInfoPage filesInfoPage = getFilesInfoPage(fsObject.getId(), folder.getId(), file.getId());

        if (type.equalsIgnoreCase("original")) {
            filesInfoPage.triggerDownloadEventWithoutDownloading(file.getId(), true);
        } else if (type.equalsIgnoreCase("proxy")) {
            filesInfoPage.triggerDownloadEventWithoutDownloading(file.getId(), false);
        } else {
            throw new IllegalArgumentException(String.format("Unknown download type: '%s'", type));
        }

    }

    protected void checkVisibilityDownloadButtonOnTopMenu(String condition, String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        getFilesInfoPage(fsObject.getId(), folder.getId(), file.getId());
        checkVisibilityDownloadButtonOnTopMenu(condition);
    }

    protected void checkVisibilityDownloadOriginalBtn(String shouldState, String filePath, String path, String objectName) {
        openFileInfoPage(new File(filePath).getName(), path, objectName);
        checkVisibilityDownloadOriginalBtn(shouldState);
    }

    protected void checkVisibilityDownloadMasterUsingNVergeBtn(String shouldState, String filePath, String path, String objectName) {
        openFileInfoPage(new File(filePath).getName(), path, objectName);
        checkVisibilityDownloadMasterUsingNVergeBtn(shouldState);
    }

    protected void checkVisibilityDownloadProxyButton(String shouldState, String filePath, String path, String objectName) {
        openFileInfoPage(new File(filePath).getName(), path, objectName);
       // Common.sleep(5000);
        checkVisibilityDownloadProxyButton(shouldState);
    }

    protected void checkVisibilityDownloadButtonOnTopMenu(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getSut().getPageCreator().getProjectFileInfoPage().isDownloadButtonVisibleOnMenu(), is(shouldState));
    }

    protected void checkVisibilityDownloadOriginalBtn(String shouldState) {
        boolean should = shouldState.equals("should");
        assertThat(getSut().getPageCreator().getProjectFileInfoPage().isDownloadOriginalButtonVisible(), equalTo(should));
    }

    protected void checkVisibilityDownloadMasterUsingNVergeBtn(String shouldState) {
        boolean should = shouldState.equals("should");
        assertThat(getSut().getPageCreator().getProjectFileInfoPage().isDownloadMasterUsingNVergeButtonVisible(), equalTo(should));
    }

    protected void checkVisibilityDownloadProxyButton(String shouldState) {
        boolean should = shouldState.equals("should");
        assertThat(getSut().getPageCreator().getProjectFileInfoPage().isDownloadProxyButtonVisible(), equalTo(should));
    }

    //QA-442 Edit Office doc feature
    protected void clickEditDocumentButton(String filePath, String path, String objectName) {
        AdbankFilesInfoPage filesInfoPage = openFileInfoPage(new File(filePath).getName(), path, objectName);
        filesInfoPage.clickEditDocumentButton();
    }

    protected void checkAvailabilityProxyVideoFile(String shouldState, String filePath, String path, String objectName) {
        AdbankFilesInfoPage filesInfoPage = openFileInfoPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        assertThat("Proxy for video file " + shouldState + " be visible!", filesInfoPage.isProxyForVideoVisible(), equalTo(should));
    }

    protected void checkVisibilityUploadNewVersionBtn(String shouldState, String filePath, String path, String objectName) {
        AdbankFilesInfoPage filesInfoPage = openFileInfoPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        if(should) {
            assertThat("Upload new version button " + shouldState + " be visible!", filesInfoPage.isUploadNewVersionButtonVisible(), equalTo(should));
        }else if(should==false){
            assertThat("Upload new version button " + shouldState + " be visible!", filesInfoPage.isUploadNewVersionButtonPresent(), equalTo(should));
        }
    }

    protected void checkVisibilityOnUploadDropdownOnProjectsFilesPage(String shouldState,String button, String filePath, String path, String objectName) {
        AdbankFilesInfoPage filesInfoPage = openFileInfoPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        assertThat(button + shouldState + " be visible!", filesInfoPage.isButtonVisibleOnUploadDropdownOnProjectsFilesPage(button), equalTo(should));
    }

    protected void checkVisibilityVersionsDropDown(String shouldState, String filePath, String path, String objectName) {
        AdbankFilesInfoPage filesInfoPage = openFileInfoPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        assertThat("Upload new version button " + shouldState + " be visible!", filesInfoPage.isVersionsDropDownVisible(), equalTo(should));
    }

    protected void checkVisibilityDownloadOriginalLinkForRevision(String shouldState, String filePath, String path, String objectName, int revision) {
        AdbankFileVersionHistoryPage fileVersionHistoryPage = openFileVersionHistoryPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        assertThat("Download Original link " + shouldState + " be visible!",
                fileVersionHistoryPage.isDownloadOriginalLinkVisibleForRevision(revision), equalTo(should));
    }

    protected void checkVersionInfo(int revision, String username, String agency) {
        String agencyName;
        AdbankFileVersionHistoryPage fileVersionHistoryPage = getSut().getPageCreator().getProjectFileVersionHistoryPage();
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(username));
        agencyName = getData().getAgencyByName(agency).getName();
        assertThat(fileVersionHistoryPage.getRevisionOriginatorUsername(revision), equalTo(user.getFullName()));
        assertThat(fileVersionHistoryPage.getRevisionOriginatorAgency(revision), equalTo(agencyName));
    }

    protected void checkVisibilityDownloadProxyLinkForRevision(String shouldState, String filePath, String path, String objectName, int revision) {
        String fileName = new File(filePath).getName();
        AdbankFileVersionHistoryPage fileVersionHistoryPage = openFileVersionHistoryPage(fileName, path, objectName);
        boolean should = shouldState.equals("should");
        assertThat("Download Preview link " + shouldState + " be visible!",
                fileVersionHistoryPage.isDownloadProxyLinkVisibleForRevision(revision), equalTo(should));
    }

    protected void checkPreviewForRevision(String filePath, String path, String objectName, int revision) {
        String fileName = new File(filePath).getName();
        //AdbankFileVersionHistoryPage fileVersionHistoryPage = openFileVersionHistoryPage(new File(filePath).getName(), path, objectName);
        AdbankFileVersionHistoryPage fileVersionHistoryPage = getSut().getPageCreator().getProjectFileVersionHistoryPage();
        assertThat(fileVersionHistoryPage.isPreviewForRevisionVisible(getRevisionProxyFileId(fileName, path, objectName, revision)), equalTo(true));
    }

    protected void OpenAndcheckPreviewForRevision(String filePath, String path, String objectName, int revision) {
        String fileName = new File(filePath).getName();
        AdbankFileVersionHistoryPage fileVersionHistoryPage = openFileVersionHistoryPage(new File(filePath).getName(), path, objectName);
        assertThat(fileVersionHistoryPage.isPreviewForRevisionVisible(getRevisionProxyFileId(fileName, path, objectName, revision)), equalTo(true));
    }

    protected void checkThatRevisionMarkedAsCurrent(String shouldState, String filePath, String path, String objectName, int revision) {
        AdbankFileVersionHistoryPage fileVersionHistoryPage = openFileVersionHistoryPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        assertThat(fileVersionHistoryPage.isFileMarkedAsCurrentVersion(revision), equalTo(should));
    }

    protected void checkThatClientFileRevisionMarkedAsCurrent(String shouldState, String filePath, String path, String objectName, int revision) {
        AdbankFileVersionHistoryPage fileVersionHistoryPage = openClientFileVersionHistoryPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        assertThat(fileVersionHistoryPage.isFileMarkedAsCurrentVersion(revision), equalTo(should));
    }

    protected void checkApprovalStatusMessage(String condition, String expectedMessage, String filePath, String path, String objectName, int revision) {
        AdbankFileVersionHistoryPage page = openFileVersionHistoryPage(new File(filePath).getName(), path, objectName);
        boolean shouldState = condition.equals("should");
        String actualMessage = page.getRevisionApprovalStatusMessage(revision);
        assertThat(actualMessage, shouldState ? equalTo(expectedMessage) : not(equalTo(expectedMessage)));
    }

    protected void checkVersionHistoryTabAvailability(String shouldState, String filePath, String path, String objectName) {
        AdbankFilesInfoPage filesInfoPage = openFileInfoPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        Common.sleep(3000);
        assertThat(filesInfoPage.isVersionHistoryTabPresent(), is(should));
    }

    protected void checkUsageRightsTabAvailability(String shouldState, String filePath, String path, String objectName) {
        AdbankFilesInfoPage filesInfoPage = openFileInfoPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        assertThat(filesInfoPage.isUsageRightsTabPresent(), is(should));
    }

    //QA358-Frame Grabber Code changes starts
    protected void checkFramesTabAvailability(String shouldState, String filePath, String path, String objectName) {
        AdbankFilesInfoPage filesInfoPage = openFileInfoPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        assertThat(filesInfoPage.isFramesTabPresent(), is(should));
    }

    //QA358-Frame Grabber Code changes Ends
    protected void checkActivityTabAvailability(String shouldState, String filePath, String path, String objectName) {
        AdbankFilesInfoPage filesInfoPage = openFileInfoPage(new File(filePath).getName(), path, objectName);
        boolean should = shouldState.equals("should");
        assertThat(filesInfoPage.isActivityTabPresent(), is(should));
    }

    // | TabName | ShouldState |
    protected void checkTabsVisibility(String filePath, String path, String objectName, ExamplesTable data) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFilesInfoPage filesInfoPage = getFilesInfoPage(fsObject.getId(), folder.getId(), file.getId());
        List<String> allTabs = filesInfoPage.getAllTabsFromPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            boolean shouldState = row.get("ShouldState") == null || row.get("ShouldState").equalsIgnoreCase("should");
            assertThat("", row.get("TabName"), shouldState ? isIn(allTabs) : not(isIn(allTabs)));
        }
    }

    protected void addUsageRule(String objectName, String path, String fileName, String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule)) throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());

        AdbankFileUsageRightsPage page = openFileUsageRightsPage(fileName, path, objectName);

        for (Map<String, String> row : parametrizeTableRows(data)) {
            page.selectUsageType(usageRule);
            AddUsageRightsPopUp popup = page.clickAddUsageType();

            if (row.get("StartDate") != null && !row.get("StartDate").isEmpty())
                row.put("StartDate", parseDateTime(row.get("StartDate")).toString(dateTimeFormatter));

            if (row.get("ExpirationDate") != null && !row.get("ExpirationDate").isEmpty())
                row.put("ExpirationDate", parseDateTime(row.get("ExpirationDate")).toString(dateTimeFormatter));

            switch (usageRule) {
                case UsageRule.GENERAL:
                    popup.fillGeneralFields(row);
                    break;
                case UsageRule.COUNTRIES:
                    popup.fillCountriesFields(row);
                    break;
                case UsageRule.MEDIA_TYPES:
                    popup.fillMediaTypesFields(row);
                    break;
                case UsageRule.VISUAL_TALENT:
                    popup.fillVisualTalentFields(row);
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    popup.fillVoiceOverArtistFields(row);
                    break;
                case UsageRule.MUSIC:
                    popup.fillMusicFields(row);
                    break;
                case UsageRule.OTHER_USAGE:
                    popup.fillOtherUsageFields(row);
                    break;
            }

            if (row.get("NotifyIfExpired") != null && row.get("NotifyIfExpired").equals("true")) {
                popup.checkNotifyIfExpiredCheckbox(usageRule);
                popup.fillDaysFromExpireField(usageRule, row.get("DaysFromExpire"));

                if (row.get("IncludeTeam") != null && row.get("IncludeTeam").equals("true")) {
                    popup.checkIncludeTeamCheckbox(usageRule);
                }
            }

            popup.action.click();
            //GenericSteps.refreshPage();
            Common.sleep(2000);
        }
    }

    protected void updateUsageRule(String objectName, String path, String fileName, String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        AdbankFileUsageRightsPage page = openFileUsageRightsPage(fileName, path, objectName);
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());

        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("EntryNumber") == null) throw new IllegalArgumentException("EntryNumber value must be given");
            int entryNumber = Integer.parseInt(row.get("EntryNumber"));

            page.clickEditLinkForUsageRule(usageRule);

            if (row.get("StartDate") != null && !row.get("StartDate").isEmpty())
                row.put("StartDate", parseDateTime(row.get("StartDate")).toString(dateTimeFormatter));

            if (row.get("ExpirationDate") != null && !row.get("ExpirationDate").isEmpty())
                row.put("ExpirationDate", parseDateTime(row.get("ExpirationDate")).toString(dateTimeFormatter));

            switch (usageRule) {
                case UsageRule.GENERAL:
                    page.fillGeneralFields(entryNumber, row);
                    break;
                case UsageRule.COUNTRIES:
                    page.fillCountriesFields(entryNumber, row);
                    break;
                case UsageRule.MEDIA_TYPES:
                    page.fillMediaTypesFields(entryNumber, row);
                    break;
                case UsageRule.VISUAL_TALENT:
                    page.fillVisualTalentFields(entryNumber, row);
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    page.fillVoiceOverArtistFields(entryNumber, row);
                    break;
                case UsageRule.MUSIC:
                    page.fillMusicFields(entryNumber, row);
                    break;
                case UsageRule.OTHER_USAGE:
                    page.fillOtherUsageFields(entryNumber, row);
                    break;
            }

            page.saveUsageRule(usageRule);
          //  GenericSteps.refreshPage();
        }
    }

    protected void removeUsageRuleEntry(String objectName, String path, String fileName, String usageRule, int entryNumber) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        AdbankFileUsageRightsPage page = openFileUsageRightsPage(fileName, path, objectName);
        page.clickEditLinkForUsageRule(usageRule);
        page.removeUsageRuleEntry(usageRule, entryNumber);
        page.saveUsageRule(usageRule);
    }

    // $usageRule =>        $data
    //
    // General =>           StartDate, ExpirationDate | ExpiresEveryDays
    // Countries =>         Country, StartDate, ExpirationDate | ExpiresEveryDays
    // Media Types =>       Type, Comment
    // Visual Talent =>     ArtistName, Role, StartDate, ExpirationDate[, Logo]
    // Voice-over Artist => ArtistName, Role, StartDate, ExpirationDate | ExpiresEveryDays[, Logo, BaseFee, Agent, AgentTel, Email, Union, MoreInfo]
    // Music =>             ArtistName, TrackTitle, StartDate, ExpirationDate | ExpiresEveryDays [, Composer, TrackNumber, RecordLabel, SubLabel, PublicationPublisher, Arranger, ISRCNumber, LicenseDetails, ContactDetails]
    // Other usage =>       Comment
    protected void checkThatUsageRuleFieldsPresent(String objectName, String path, String fileName, boolean shouldState, String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        AdbankFileUsageRightsPage page = openFileUsageRightsPage(fileName, path, objectName);
        DateTimeFormatter dateFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());
        List<Map<String, String>> actualRules = new ArrayList<>();

        for (Map<String, String> expectedRule : parametrizeTableRows(data)) {
            String startDate = expectedRule.get("StartDate");
            String expireDate = expectedRule.get("ExpirationDate");

            if (startDate != null)
                expectedRule.put("StartDate", startDate.isEmpty() ? "" : parseDateTime(startDate).toString(dateFormatter));

            if (expireDate != null) {
                expectedRule.put("ExpirationDate", expireDate.isEmpty() ? "" : parseDateTime(expireDate).toString(dateFormatter));
            }

            switch (usageRule) {
                case UsageRule.GENERAL:
                    actualRules = page.getGeneralFieldsList();
                    break;
                case UsageRule.COUNTRIES:
                    actualRules = page.getCountriesFieldsList();
                    break;
                case UsageRule.MEDIA_TYPES:
                    actualRules = page.getMediaTypesFieldsList();
                    break;
                case UsageRule.VISUAL_TALENT:
                    actualRules = page.getVisualTalentFieldsList();
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    actualRules = page.getVoiceOverArtistFieldsList();
                    break;
                case UsageRule.MUSIC:
                    actualRules = page.getMusicFieldsList();
                    break;
                case UsageRule.OTHER_USAGE:
                    actualRules = page.getOtherUsageFieldsList();
                    break;
            }

            for (Map<String, String> actualRule : actualRules) {
                for (String key : new HashSet<>(actualRule.keySet())) {
                    if (actualRule.get(key).isEmpty() && !expectedRule.containsKey(key)) {
                        actualRule.remove(key);
                    }
                }
            }

            assertThat(actualRules, shouldState ? hasItem(expectedRule) : not(hasItem(expectedRule)));
        }
    }

    protected void checkThatEditUsageLinkPresent(String objectName, String path, String fileName, boolean shouldState, String usageRule) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        assertThat(openFileUsageRightsPage(fileName, path, objectName).isEditLinkPresentForUsageRule(usageRule), is(shouldState));
    }

    protected void checkThatUsageRulePresent(String objectName, String path, String fileName, boolean shouldState, String usageRule) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        assertThat(openFileUsageRightsPage(fileName, path, objectName).isUsageRulePresent(usageRule), is(shouldState));
    }

    public void approveFileUsingApproveTopButton() {
        AdbankFileApprovalsPage adbankFilesInfoPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        ApprovalCommentPopUp approvalCommentPopUp = adbankFilesInfoPage.clickApproveButton();
        approvalCommentPopUp.clickOkButton();
    }

    public void rejectFileUsingRejectTopButton() {
        AdbankFileApprovalsPage adbankFilesInfoPage = getSut().getPageCreator().getProjectFileApprovalsPage();
        ApprovalCommentPopUp approvalCommentPopUp = adbankFilesInfoPage.clickRejectButton();
        approvalCommentPopUp.clickOkButton();
    }

    protected ApprovalStage buildApprovalStage(Project object, Content folder, final Content file, final Map<String, String> fields) {
        Approval approval = getMtApi().getApproval(file);
        ApprovalStage stage = new ApprovalStage();
        List<String> membersIds = new ArrayList<>();
        List<Object> owners = new ArrayList<>();

        if (fields.get("Approvers") != null) {
            for (String approver : fields.get("Approvers").split(",")) {
                String email = wrapUserEmailWithTestSession(approver.trim());
                User user = getCoreApiAdmin().getUserByEmail(email);
                String userId = user == null ? email : user.getId();
                membersIds.add(userId);

                if (fields.get("Owner") != null && asList(fields.get("Owner").split(",")).contains(approver)) {
                    owners.add(userId);
                    stage.setPermissions(asList("approval.stage.edit"));
                }
            }
        }

        String[] advertiser = object.getCmCommon().getStringArray("advertiser");
        if (advertiser != null) stage.setProjectAdvertiser(asList(advertiser));
        if (approval != null) stage.setApprovalId(approval.getId());
        if (fields.get("Description") != null) stage.setDescription(fields.get("Description"));
        if (fields.get("Deadline") != null){ stage.setDeadline(new StageReminder() {{
            setDate(parseDateTime(fields.get("Deadline"), APPROVALS_DATE_TIME_FORMAT)); }});}
        else{
            stage.setDeadline(new StageReminder() {{
                setDate(parseDateTime("01/05/2023 12:15", APPROVALS_DATE_TIME_FORMAT)); }});
        }
        if (fields.get("Reminder") != null) {stage.setReminder(new StageReminder() {{
            setDate(parseDateTime(fields.get("Reminder"), APPROVALS_DATE_TIME_FORMAT)); }});}
        else {
            stage.setReminder(new StageReminder() {{
                setDate(parseDateTime("01/05/2023 08:00", APPROVALS_DATE_TIME_FORMAT)); }});
        }
        stage.setStartImmediately(!fields.containsKey("Started") || Boolean.parseBoolean(fields.get("Started")));
        stage.setName(wrapVariableWithTestSession(fields.get("Name")));
        stage.setApprovalType(Boolean.parseBoolean(fields.get("SingleApproval")) ? "WaitAny" : "WaitAll");
        stage.setProjectName(object.getName());
        stage.setEntityName(file.getName());
        stage.setProjectId(object.getId());
        stage.setFolderId(folder.getId());
        stage.setYadnFileId(file.getLastRevision().getMaster().getFileID());
        stage.setMembersIds(membersIds);
        stage.setOwners(owners);
        stage.setEntityType(file.getMediaType());
        stage.setShortId(file.getShortId());

        Map<String, String> metadata = new HashMap<>();
        metadata.put("previewFileId", file.getLastRevision().getPreview().get(0).getFileID());
        stage.setMetadata(metadata);

        return stage;
    }
    public String getDownloadUrl(String dowloadtype,Content file, String targetFilename) {
        StringBuilder url = new StringBuilder("/file/");
        String expectedFileId = "";
        if (dowloadtype.equalsIgnoreCase("Original")) {
            url.append(file.getLastRevision().getMaster().getFileID()).append("/filestorage/");
        }
        else if (dowloadtype.equalsIgnoreCase("preview"))
        {
            for (FilePreview preview : file.getLastRevision().getPreview())
                if (preview.getA5Type().equals("video_proxy")) expectedFileId = preview.getFileID();
            url.append(expectedFileId).append("/filestorage/");
        }


        Agency A1= file.getAgency();
        String agencyname = A1.getName();
        Agency A2 = getAgencyByNamenoWrapping(agencyname);
        String storageid = A2.getStorageId();
        url.append(storageid);
        url.append("/System/adbank5/SecuredDownloadUrl?ssl=false&filename=");
        url.append(targetFilename);
        return url.toString();
    }

    //QA-725 - new
    public String getMultipleFrameGrabsDownloadUrl(String userId) {
        String globalAdminUserId = "4ef31ce1766ec96769b399c0";
        StringBuilder url = new StringBuilder("/gdam.net/api/framegrabber/zip/?$id$=id-");
        url.append(userId);
        url.append("&$originId$=id-");
        url.append(globalAdminUserId);
        return url.toString();
    }

    //QA-725 - new
    public String getStillIdsLocation(String fileId, String masterFileId, String userId) {
        String globalAdminUserId = "4ef31ce1766ec96769b399c0";
        StringBuilder url = new StringBuilder("/gdam.net/api/framegrabber/");
        url.append(fileId);
        url.append("/");
        url.append(masterFileId);
        url.append("?$id$=id-");
        url.append(userId);
        url.append("&$originId$=id-");
        url.append(globalAdminUserId);
        return url.toString();
    }

    public String originalorproxySize(String downloadType) {
        String size = null;
        if (downloadType.equalsIgnoreCase("Original")) {
            WebElement element = getSut().getPageCreator().getProjectFileInfoPage().getDownloadingLocators(downloadType);
            String originalTxt = element.getText().toString();
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(originalTxt);
            if (matcher.find()) {
                System.out.println("Size of Preview File =" + matcher.group());
            }
            size = matcher.group();
        }
        else if (downloadType.equalsIgnoreCase("Preview"))
        {
            WebElement element = getSut().getPageCreator().getProjectFileInfoPage().getDownloadingLocators(downloadType);
            String previewTxt = element.getText().toString();
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(previewTxt);
            if(matcher.find()){
                System.out.println("Size of Preview File =" +matcher.group());
            }
            size = matcher.group();

        }
        return (size);


    }

    public HostConfiguration mimicHostConfiguration(String hostURL, int hostPort) {
        HostConfiguration hostConfig = new HostConfiguration();
        hostConfig.setHost(hostURL, hostPort);
        return hostConfig;
    }

    public HttpState mimicCookieState(Set<org.openqa.selenium.Cookie> seleniumCookieSet) {
        HttpState mimicWebDriverCookieState = new HttpState();
        for (org.openqa.selenium.Cookie seleniumCookie : seleniumCookieSet) {
            Cookie httpClientCookie = new Cookie(seleniumCookie.getDomain(), seleniumCookie.getName(), seleniumCookie.getValue(), seleniumCookie.getPath(), seleniumCookie.getExpiry(), seleniumCookie.isSecure());
            mimicWebDriverCookieState.addCookie(httpClientCookie);
        }
        return mimicWebDriverCookieState;
    }

    private CloseableHttpClient httpClient;
    protected CloseableHttpClient getHttpClient() {
        if (httpClient == null) {
            httpClient = HttpClients.createDefault();
        }
        return httpClient;
    }
    public void checkheaderContent(HttpMethod getRequest, String Size, String headerType, String filename)
    {
        if (headerType.equalsIgnoreCase("Content-Length")) {
            String s = headerType;
            Header[] responseAdgateHeaderCL = getRequest.getResponseHeaders(s);
            int index = responseAdgateHeaderCL[0].toString().trim().indexOf(":");
            String DownloadedSize = responseAdgateHeaderCL[0].toString().trim().substring(index + 1);
            long fileSizeKB = Long.parseLong(DownloadedSize.replaceAll("\\s+",""))/1024;
            String actualFileSize = Long.toString(fileSizeKB);
            Assert.assertEquals(actualFileSize, Size);
        }
        else if (headerType.equalsIgnoreCase("Content-Disposition"))
        {
            String s1 = headerType;
            Header[] responseAdgateHeaderCD = getRequest.getResponseHeaders(s1);
            int index1 = responseAdgateHeaderCD[0].toString().trim().indexOf("=");
            String downloadedFileName = responseAdgateHeaderCD[0].toString().trim().substring(index1 + 1).replaceAll("\"","");
             Assert.assertThat(downloadedFileName,containsString(filename));

        }

    }
    public long getContentLength(HttpMethod getRequest, String Size, String headerType, String filename)
    {
        Long fileSizeKB = null;
        if (headerType.equalsIgnoreCase("Content-Length")) {
            String s = headerType;
            Header[] responseAdgateHeaderCL = getRequest.getResponseHeaders(s);
            int index = responseAdgateHeaderCL[0].toString().trim().indexOf(":");
            String DownloadedSize = responseAdgateHeaderCL[0].toString().trim().substring(index + 1);
            fileSizeKB = Long.parseLong(DownloadedSize.replaceAll("\\s+",""))/1024;
            getRequest.releaseConnection();
        }
        return fileSizeKB;
    }

}


