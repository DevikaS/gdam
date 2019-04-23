package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.format.DateTimeFormat;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 03.10.12
 * Time: 18:20
 */
public class ProjectFileCommentsSteps extends AbstractFileViewSteps  {

    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    @Override
    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getProjectByName(objectName);
    }

    @Override
    protected AdbankFileActivityPage getFileActivityPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileActivityPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileInfoPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileCommentsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileUsageRightsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileApprovalsPage getFileApprovalsPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileAttachmentsPage getFileAttachmentsPage(String projectId, String folderId, String fileId) {
        return null;
    }
    //QA358-Frame Grabber Changes Starts
    @Override
    protected AdbankFileFramesPage getFileFramesPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileFramesPage(projectId, folderId, fileId);
    }
     //QA358-Frame Grabber Changes Ends

    @Given("{I am |}on the file comments page project '$projectName' and folder '$folderName' and file '$filePath'")
    @When("{I |}go to the file comments page project '$projectName' and folder '$folderName' and file '$filePath'")
    public AdbankFileCommentsPage openFileInfo(String projectName, String path, String filePath) {
        return openFileCommentsPage(projectName, path, new File(filePath).getName());
    }

    @Given("{I |}added comment '$comment' on file '$filePath' comments page on folder '$path' in project '$projectName'")
    @When("{I |}add comment '$comment' on file '$filePath' comments page on folder '$path' in project '$projectName'")
    public void addFileComment(String comment, String filePath, String path, String projectName) {
        AdbankFileCommentsPage page = openFileInfo(projectName, path, filePath);
        page.typeComment(comment);
        page.clickComment();
    }

    @Given("{I |}added comment '$comment' into current file")
    @When("{I |}add comment '$comment' into current file")
    public void addCommentIntoCurrentFile(String comment) {
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
                fileCommentsPage.typeComment(comment);
        fileCommentsPage.clickComment();
    }

    @Given("{I |}added comment '$comment' into current file UI")
    @When("{I |}add comment '$comment' into current file UI")
    public void addCommentIntoCurrentFileUI(String comment) {
        AdbankFileCommentsPage fileCommentsPage = new AdbankFileCommentsPage(getSut().getWebDriver());
        fileCommentsPage.typeComment(comment);
        fileCommentsPage.clickComment();
    }

    // | Name | Sleep |
    @When("I add following comments into current file: $commentsTable")
    public void addCommentIntoCurrentFile(ExamplesTable commentsTable) {
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
        for (int i = 0; i < commentsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(commentsTable, i);
            if (row.get("Name")!= null) {
                fileCommentsPage.typeComment(row.get("Name"));
                fileCommentsPage.clickComment();
            }
            if (row.get("Sleep")!= null) Common.sleep(Integer.parseInt(row.get("Sleep")));
        }
    }

    @When("{I |}replay '$replayText' on comment '$parentText' for file '$fileName' in project '$projectName' and folder '$folderName'")
    public void replayOnComment(String replayText, String parentText, String fileName, String projectName, String folderName) {
        Common.sleep(2000);
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(folderName));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        String commentId = getCommentId(parentText, fileName, projectName, folderName, file.getRevisions().length - 1);
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
        fileCommentsPage.clickReplyLink(commentId);
        fileCommentsPage.typeReplyText(commentId, replayText);
        fileCommentsPage.clickReplyButton(commentId);
    }

    @Given("I removed comment '$commentText' for file '$fileName' in project '$projectName' and folder '$folderName'")
    @When("I remove comment '$commentText' for file '$fileName' in project '$projectName' and folder '$folderName'")
    public void removeComment(String commentText, String fileName, String projectName, String folderName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(folderName));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        String commentId = getCommentId(commentText, fileName, projectName, folderName, file.getRevisions().length - 1);
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
        fileCommentsPage.clickRemoveLink(commentId);
    }

    @Given("I removed comment '$commentText' for file '$fileName' in project '$projectName' and folder '$folderName' from '$userPlan' user")
    @When("I remove comment '$commentText' for file '$fileName' in project '$projectName' and folder '$folderName' from '$userPlan' user")
    public void removeComment(String commentText, String fileName, String projectName, String folderName, String
            userPlan){
                Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(folderName));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        String commentId = getCommentId(commentText, fileName, projectName, folderName, file.getRevisions().length - 1);
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
        fileCommentsPage.clickRemoveLink(commentId);
    }

    @When("I find all comments for file '$fileName' in the project '$projectName' and folder '$folderName'")
            public void findAllCommentFileName(String fileName, String projectName, String folderName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(folderName));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        getCoreApi().findComments(file.getId(), 1);

    }

    @Then("{I |}'$condition' see comment '$expectedComment' on file '$filePath' comments page on folder '$path' in project '$projectName'")
    public void checkCommentOnTheCurrentFilePage(String condition, String expectedComment, String filePath, String path, String projectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualCommentsList = openFileInfo(projectName, path, filePath).getListOfPostedComments();

        assertThat(actualCommentsList, shouldState ? hasItem(expectedComment) : not(hasItem(expectedComment)));
    }

    @Then("{I |}'$condition' see comment '$comment' for current file")
    public void checkCommentOnTheCurrentFilePage(String condition, String comment) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankFileCommentsPage page = getSut().getPageCreator().getProjectFileCommentsPage();
        Map<String,String> expectedComment = new HashMap<>();
        Map<String,String> actualComment = new HashMap<>();

        expectedComment.put("UserName", getData().getCurrentUser().getFullName());
        expectedComment.put("Comment", comment);
        actualComment.put("UserName", page.getListOfUsersWhoPostedComments().get(0));
        actualComment.put("Comment", page.getListOfPostedComments().get(0));

        assertThat(actualComment, shouldState ? equalTo(expectedComment) : not(equalTo(expectedComment)));
    }

    @Then("{I |}'$condition' see client's comment '$comment' for current file")
    public void checkClientCommentOnTheCurrentFilePage(String condition, String expectedComment) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankFileCommentsPage page = getSut().getPageCreator().getProjectFileCommentsPage();

        assertThat(page.getListOfPostedComments().get(0), shouldState ? equalTo(expectedComment) : not(equalTo(expectedComment)));
    }

    // | Name | Email | Logo | UserType |
    @Then("I should see following comments for current file: $commentsTable")
    public void checkCommentOnTheCurrentFilePage(ExamplesTable commentsTable) {
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
        List<String> comments = fileCommentsPage.getListOfPostedComments();
        List<String> userNames = fileCommentsPage.getListOfUsersWhoPostedComments();

        assertThat("Comments count", comments.size(), equalTo(commentsTable.getRowCount()));

        for (int i = 0; i < commentsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(commentsTable, i);

            assertThat(row.get("Name"), equalTo(comments.get(i)));

            if ((row.get("UserType") != null) && (!row.get("UserType").isEmpty())) {
                assertThat(getData().getUserByType(row.get("UserType")).getFullName(), equalTo(userNames.get(i)));
            } else if ((row.get("Email") == null) || (row.get("Email").isEmpty())) {
                assertThat(getData().getCurrentUser().getFullName(), equalTo(userNames.get(i)));
            } else {
                User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("Email")));
                assertThat(user.getFullName(), equalTo(userNames.get(i)));
            }

            if ((row.get("FirstName")!=null) && (row.get("LastName")!=null)) {
                String fullName = row.get("FirstName").concat(" ").concat(row.get("LastName"));
                assertThat(fullName, equalTo(userNames.get(i)));
            }

            if ((row.get("Logo")!=null)&&(!row.get("Logo").isEmpty())) checkLogo(fileCommentsPage, i, row.get("Logo"));

            checkCommentDateTimeFormat(true, fileCommentsPage.getListOfCommentDates().get(i));
        }
    }

    @Then("I '$condition' see remove link for file comment '$commentText' for file '$fileName' in project '$projectName' and folder '$folderName'")
    public void checkVisibilityRemoveLink(String condition, String commentText, String fileName, String projectName, String folderName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(folderName));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        String commentId = getCommentId(commentText, fileName, projectName, folderName, file.getRevisions().length - 1);
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
        assertThat(fileCommentsPage.isRemoveLinkVisible(commentId), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then("I '$condition' see reply link for file comment '$commentText' for file '$fileName' in project '$projectName' and folder '$folderName'")
    public void checkVisibilityReplyLink(String condition, String commentText, String fileName, String projectName, String folderName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(folderName));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        String commentId = getCommentId(commentText, fileName, projectName, folderName, file.getRevisions().length - 1);
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
        assertThat(fileCommentsPage.isReplyLinkVisible(commentId), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then("I '$condition' see comment textarea on current file comment page")
    public void checkVisibilityCommentTextArea(String condition) {
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
        assertThat(fileCommentsPage.isCommentTextAreaVisible(), equalTo(condition.equalsIgnoreCase("should")));
    }

    // | UserName | Comment |
    @Then("{I |}'$condition' see following child comments for current file: $data")
    public void checkChildCommentOnTheCurrentFilePage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> expectedComments = new ArrayList<>();

        for (Map<String,String> expectedComment : parametrizeTableRows(data)) {
            expectedComment.put("UserName", getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(expectedComment.get("UserName"))).getFullName());
            expectedComments.add(expectedComment);
        }

        List<String> usersList = getSut().getPageCreator().getProjectFileCommentsPage().getListOfUsersWhoPostedComments();
        List<String> commentsList = getSut().getPageCreator().getProjectFileCommentsPage().getListOfChildComments();
        List<Map<String,String>> actualComments = parametrizeTableRows(data);

        for (int i = 0; i < commentsList.size(); i++) {
            Map<String,String> actualComment = new HashMap<>();
            actualComment.put("UserName", usersList.get(i));
            actualComment.put("Comment", commentsList.get(i));
            actualComments.add(actualComment);
        }

        for (Map<String,String> expectedComment : expectedComments) {
            assertThat(actualComments, shouldState ? hasItem(expectedComment) : not(hasItem(expectedComment)));
        }

        for (String dateTime : getSut().getPageCreator().getProjectFileCommentsPage().getListOfCommentDates()) {
            checkCommentDateTimeFormat(shouldState, dateTime);
        }
    }

    @Then("There are not any comments on the comments page for current file")
    public void checkThatFileHasNotGotAnyComments() {
        AdbankFileCommentsPage fileCommentsPage = getSut().getPageCreator().getProjectFileCommentsPage();
        assertThat(fileCommentsPage.getListOfPostedComments().size(), equalTo(0));
    }

    private void checkCommentDateTimeFormat(boolean expectedState, String dateTime) {
        boolean actualState = true;
        String message = "Check date format according to user locale";

        try {
            String format = getData().getCurrentUser().getDateTimeFormatter().getCommentDateTimeFormat();
            DateTimeFormat.forPattern(format).parseDateTime(dateTime);
        } catch (IllegalArgumentException e){
            actualState = false;
            message = e.getMessage();
        }

        assertThat(message, actualState, is(expectedState));
    }

    private void checkLogo(AdbankFileCommentsPage fileCommentsPage, int num, String logo) {
        byte[] emptyLogo = Logo.EMPTY.getBytes();
        byte[] projectLogo = fileCommentsPage.getListLogoOnPopup().get(num);
        if (logo.equals("EMPTY")) {
            assertThat("Logo length", projectLogo.length, equalTo(emptyLogo.length));
            for (int i = 0; i < emptyLogo.length; i++) {
                assertThat(projectLogo[i], equalTo(emptyLogo[i]));
            }
        } else {
            log.debug("projectLogo.length = " + projectLogo.length);
            assertThat("Logo length", projectLogo.length, not(equalTo(emptyLogo.length)));
        }
    }

    private String getCommentId(String commentText, String fileName, String projectName, String folderName, int revisionNum) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(folderName));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        int objRevision = file.getRevisions()[revisionNum].getRevisionId();
        return getCoreApi().getFirstCommentIdByText(file.getId(), objRevision, commentText);
    }
}