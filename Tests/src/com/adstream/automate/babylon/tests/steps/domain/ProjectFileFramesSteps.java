package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AddNewFrameGrabberPopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetFramesPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsInfoPage;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;


/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 03.06.13
 * Time: 10:41
 */
public class ProjectFileFramesSteps extends AbstractFileViewSteps {

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
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileUsageRightsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileCommentsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileVersionHistoryPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileApprovalsPage getFileApprovalsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileApprovalsPage(projectId, folderId, fileId);
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


    //QA-358-Frame Grabber Code changes starts
    @Given("{I |}opened frames page in project '$projectName' folder '$folderName' of file '$fileName'")
    @When("{I |}open frames page in project '$projectName' folder '$folderName' of file '$fileName'")
    public void openProjectFileFramesPage(String projectName, String folderName, String fileName) {
        String projectId = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName)).getId();
        String folderId = getCoreApi().getFolderByName(projectId, projectId, wrapVariableWithTestSession(folderName)).getId();
        String fileId = getCoreApi().getFileByName(folderId, fileName).getId();

        getFileFramesPage(projectId, folderId, fileId);
    }

    @Given("{I |}clicked Capture Frame button on opened frames page")
    @When("{I |}click Capture Frame button on opened frames page")
    public AddNewFrameGrabberPopUpWindow clickCaptureFrameButton() {
        return getSut().getPageCreator().getProjectFileFramesPage().clickCaptureFrameButton();
    }
    @Given("{I |}clicked Capture Frame button on opened frames page from Library")
    @When("{I |}click Capture Frame button on opened frames page from Library")
    public AddNewFrameGrabberPopUpWindow clickCaptureFrameButtonfromLib() {
        return getSut().getPageCreator().getLibraryAssetsFramesPage().clickCaptureFrameButton();
    }

    @Given("{I |}grab '$grabCount' frame from played clip on opened frames page")
    @When("{I |}grab '$grabCount' frame from played clip on opened frames page")
    public void playProjectClip(int grabCount) {
        grabFrame(grabCount);
    }

    protected void grabFrame(int grabCount) {
        AddNewFrameGrabberPopUpWindow frameGrabWindow = getSut().getPageCreator().getProjectFileFramesPage().clickCaptureFrameButton();
        frameGrabWindow.grabFrame(grabCount);
        Common.sleep(6000);
        frameGrabWindow.close();
    }

    @Given("{I |}grab '$grabCount' frame from played clip on opened frames page from Library")
    @When("{I |}grab '$grabCount' frame from played clip on opened frames page from Library")
    public void playProjectClipFrmLib(int grabCount ) {
        grabFrameFrmLib(grabCount);
    }

    protected void grabFrameFrmLib(int grabCount) {
        AddNewFrameGrabberPopUpWindow frameGrabWindow = getSut().getPageCreator().getLibraryAssetsFramesPage().clickCaptureFrameButton();
        Common.sleep(1000);
        frameGrabWindow.grabFrame(grabCount);
        Common.sleep(6000);
        frameGrabWindow.close();
    }
    @Then("{I |}'$should' be able to see grabbed frames '$grabCount' on opened frames page")
    public void GrabbedFrameCount(String condition,int grabCount) {
        AdbankFileFramesPage page = getSut().getPageCreator().getProjectFileFramesPage();
        Common.sleep(4000);
        int frameCount = page.grabbedFrameCount();
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState =false;
        if(frameCount==grabCount) {
             actualState = true;
        }
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$should' be able to see grabbed frames '$grabCount' on opened frames page from Library")
    public void GrabbedFrameCountFrmLib(String condition,int grabCount) {
        AdbankLibraryAssetFramesPage page = getSut().getPageCreator().getLibraryAssetsFramesPage();
        Common.sleep(4000);
        int frameCount = page.grabbedFrameCount();
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState =false;
        if(frameCount==grabCount) {
            actualState = true;
        }
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$should' be able to see grabbed frames preview on opened frames page")
    public void GrabbedFramePreview(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState =false;
        AdbankFileFramesPage page = getSut().getPageCreator().getProjectFileFramesPage();
        actualState=page.framePreview();
        assertThat(actualState, is(expectedState));
    }
    @Then("{I |}'$should' be able to see grabbed frames preview on opened frames page from Library")
    public void GrabbedFramePreviewFrmLib(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState =false;
        AdbankLibraryAssetFramesPage page = getSut().getPageCreator().getLibraryAssetsFramesPage();
        actualState=page.framePreview();
        assertThat(actualState, is(expectedState));
    }


    //TBD using coreApi call as Robot is not consistent
    @Then("{I |}'$should' be able to download frames on opened frames page")
    public void downloadGrabbedFrame(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState =false;
        AdbankFileFramesPage page = getSut().getPageCreator().getProjectFileFramesPage();
        actualState=page.downloadFrame();
        assertThat(actualState, is(expectedState));
    }

    @When("{I |}select all grabbed frames checkbox")
    public void selectAllGrabbedFramesCheckbox() {
        AdbankFileFramesPage page = getSut().getPageCreator().getProjectFileFramesPage();
        page.selectAllFramesCheckbox();
    }

    @When("{I |}click on download button")
    public void downloadMultipleGrabbedFramesButton() {
        AdbankFileFramesPage page = getSut().getPageCreator().getProjectFileFramesPage();
        page.clickOnDownloadMultipleFramesButton();
    }

    @Then("{I |}'$should' be able to download frames on opened frames page from Library")
    public void downloadGrabbedFrameFrmLib(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState =false;
        AdbankLibraryAssetFramesPage page = getSut().getPageCreator().getLibraryAssetsFramesPage();
        actualState=page.downloadFrame();
        assertThat(actualState, is(expectedState));
    }

    @Given("{I |}remove frame from played clip on opened frames page")
    @When("{I |}remove frame from played clip on opened frames page")
    @Then("{I |}remove frame from played clip on opened frames page")
    public void removeFrame() {
        AdbankFileFramesPage page = getSut().getPageCreator().getProjectFileFramesPage();
        page.removeFrame();
    }

    @Given("{I |}remove frame from played clip on opened frames page from Library")
    @When("{I |}remove frame from played clip on opened frames page from Library")
    @Then("{I |}remove frame from played clip on opened frames page from Library")
    public void removeFrameFrmLib() {
        AdbankLibraryAssetFramesPage page = getSut().getPageCreator().getLibraryAssetsFramesPage();
        page.removeFrame();
    }
    //QA-358-Frame Grabber Code changes Ends

    @Given("{I |}remove multiple frames from played clip on opened frames page")
    @When("{I |}remove multiple frames from played clip on opened frames page")
    @Then("{I |}remove multiple frames from played clip on opened frames page")
    public void removeMultipleFrames() {
        AdbankFileFramesPage page = getSut().getPageCreator().getProjectFileFramesPage();
        page.removeMultipleFrame();
    }

    @Then("{I |}'$should' be able to validate grabbed frames '$frameCount' Timecode on opened frames page")
    public void VerifyGrabbedFrameTimeCode(String condition,int frameCount) {
        AdbankFileFramesPage page = getSut().getPageCreator().getProjectFileFramesPage();
        assertThat("Verify Timecode for framegrabber",page.verifyFrameTimecodeOnHeader(frameCount), is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$should' be able to validate grabbed frames '$frameCount' Timecode on opened frames page from Library")
    public void ValdateGrabbedFrameTimeCode(String condition,int frameCount) {
        AdbankLibraryAssetFramesPage page = getSut().getPageCreator().getLibraryAssetsFramesPage();
        assertThat("Verify Timecode for framegrabber",page.verifyFrameTimecodeOnHeader(frameCount), is(condition.equalsIgnoreCase("should")));
    }
}