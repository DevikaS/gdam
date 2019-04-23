package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.utils.Common;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.methods.GetMethod;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Date;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by sobolev-a on 22.05.2014.
 */
public class ProjectFileAttachmentsSteps extends AbstractFileViewSteps {


    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    @Override
    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getProjectByName(objectName);
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileActivityPage getFileActivityPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return null;
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
        return getSut().getPageNavigator().getProjectFileAttachmentsPage(projectId, folderId, fileId);
    }
   //Qa-358-Frame Grabber Code change starts
    @Override
    protected AdbankFileFramesPage getFileFramesPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileFramesPage(projectId, folderId, fileId);
    }
    //Qa-358-Frame Grabber Code change Ends
    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Given("{I |}am on file '$filePath' info page in folder '$path' project '$projectName' tab attachments files")
    @When("{I |}go to file '$filePath' info page in folder '$path' project '$projectName' tab attachments files")
    public void openProjectFileAttachmentsPage(String fileName, String path, String objectName) {
        openFileAttachmentsPage(fileName, path, objectName);
    }

    @Given("{I |}edited name '$newName' of file '$oldFileName' on info page in tab attachments files")
    @When("{I |}edit name '$newName' of file '$oldFileName' on info page in tab attachments files")
    public void editAttachmentFileName(String newName, String oldFileName) {
        AdbankFileAttachmentsPage projectFileAttachmentsPage = getSut().getPageNavigator().getProjectFileAttachmentsPage();
        AdbankAttachmentsFileEditPopUp fileEditNamePopUp = projectFileAttachmentsPage.clickByEditButton(oldFileName);
        fileEditNamePopUp.typeName(newName);
        fileEditNamePopUp.clickOkBtn();
        Common.sleep(1000);
    }

 //DOWNLOAD ATTACHMENT
    @Given("{I |}clicked download attached file '$filename' on info page in tab attachments files")
    @When("{I |}clicked download attached file '$filename' on info page in tab attachments files")
    public void downloadAttachedFile(String fileName) {
        AdbankFileAttachmentsPage projectFileAttachmentsPage = getSut().getPageCreator().getProjectFileAttachmentsPage();
        projectFileAttachmentsPage.clickByDownloadButton(fileName);
        Common.sleep(1000);
    }


    @Given("{I |}deleted attached file '$filename' on info page in tab attachments files")
    @When("{I |}delete attached file '$filename' on info page in tab attachments files")
    public void deleteAttachedFile(String fileName) {
        AdbankFileAttachmentsPage projectFileAttachmentsPage = getSut().getPageCreator().getProjectFileAttachmentsPage();
        AdbankAttachmentsFileEditPopUp deleteAttachedFile = projectFileAttachmentsPage.clickByDeletetButton(fileName);
        deleteAttachedFile.clickOkBtn();
        Common.sleep(1000);
    }

    @Given("{I |}update attached file '$filename' on info page in tab attachments files")
    @When("{I |}updated attached file '$filename' on info page in tab attachments files")
    public void updateAttachedFile(String fileName) {
        AdbankFileAttachmentsPage projectFileAttachmentsPage = getSut().getPageCreator().getProjectFileAttachmentsPage();
        AdbankAttachmentsFileEditPopUp updateAttachedFile = projectFileAttachmentsPage.clickByEditButton(fileName);
        updateAttachedFile.typeDescription(fileName + " " + new Date().toString());
        updateAttachedFile.clickOkBtn();
    }

    @Then("{I |}'$condition' see attached file '$fileName' on file info page in tab attachments files")
    public void checkAttachedFileName(String condition, String fileName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualState = getSut().getPageCreator().getProjectFileAttachmentsPage().getAttachedFilesListName();

        for (String v : fileName.split(",")) {
            assertThat(actualState, shouldState ? hasItem(v) : not(hasItem(v)));
        }
    }

    //DOWNLOAD attachement
    @Then("{I |} should sucessfully download attached file '$fileName' for file '$masterFileName' into '$path' folder for '$projectName' project")
    public void downloadAttachedFileToProject(String attachedfileName, String masterFileName, String path, String projectName) throws IOException {

        AdbankFileAttachmentsPage projectFileAttachmentsPage = getSut().getPageCreator().getProjectFileAttachmentsPage();

        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(masterFileName).getName());
        AdbankFilesInfoPage filesInfoPage = getFilesInfoPage(fsObject.getId(), folder.getId(), file.getId());
        final String downloadLocation = TestsContext.getInstance().gdnUrl + getDownloadUrl("Original",file, attachedfileName);
        URL downloadURL = new URL(downloadLocation);
        HttpClient client = new HttpClient();
        client.getParams().setCookiePolicy(CookiePolicy.RFC_2965);
        client.setHostConfiguration(mimicHostConfiguration(downloadURL.getHost(), downloadURL.getPort()));
        client.setState(mimicCookieState(getSut().getWebDriver().manage().getCookies()));
        HttpMethod getRequest = new GetMethod(downloadLocation);
        int status = client.executeMethod(getRequest);
        final String response = getRequest.getResponseBodyAsString();
        HttpMethod getRequestAdgate = new GetMethod(response);
        status = client.executeMethod(getRequestAdgate);
        checkheaderContent(getRequestAdgate, null, "Content-Disposition", attachedfileName);
    }

    @Then("{I |}'$should' see download button for file '$fileName' on info page in tab attachments files")
    public void checkDownloadButtonExist(String condition, String fileName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getProjectFileAttachmentsPage().isDownloadButtonExist(fileName);

        assertThat("Download button is not visible", actualState, is(shouldState));
    }

}
