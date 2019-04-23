package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;

/**
 * Created by sobolev-a on 23.06.2014.
 */
public class AdbankProjectFileRelatedFilesSteps extends AbstractFileViewSteps {

    @Override
    protected Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    @Override
    protected Project getObjectByName(String objectName, User user) {
        return null;
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectRelativeFilesPage(projectId, folderId, fileId);
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
        return null;
    }
    //QA358-Frame Grabber Changes Starts
    @Override
    protected AdbankFileFramesPage getFileFramesPage(String projectId, String folderId, String fileId) {
        return null;
    }
     //QA358-Frame Grabber Changes Ends

    @Given("{I |}opened file '$fileId' in '$folderId' in project '$projectId' on related files page")
    @When("{I |}go to file '$fileId' in '$folderId' in project '$projectId' on related files page")
    public void openProjectFileRelatedFilesPage(String fileId, String folderId, String projectId) {
        openProjectRelatedFilesPage(fileId, folderId, projectId);
    }

    @Given("{I |}typed related file '$filename' on related files page on pop-up")
    @When("{I |}type related file '$filename' on related files page on pop-up")
    public void typeRelatedFileName(String fileName) {
        AdbankProjectFileRelatedFilesPage adbankProjectFileRelatedFilesPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        adbankProjectFileRelatedFilesPage.clickLinkToExistingButton();
        adbankProjectFileRelatedFilesPage.typeRelatedFileName(fileName);
    }

    @Given("{I |}selected and save following related files '$files' on related file pop-up")
    @When("{I |}select and save following related files '$files' on related file pop-up")
    public void selectAndSaveFollowingRelatedFiles(String files) {
        AdbankProjectFileRelatedFilesPage adbankProjectFileRelatedFilesPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        selectRelatedFile(adbankProjectFileRelatedFilesPage, files);
        adbankProjectFileRelatedFilesPage.clickSaveButton();
        Common.sleep(3000);
    }

    @When("{I |}select following related files '$files' on related file pop-up")
    public void selectFollowingRelatedFiles(String files) {
        AdbankProjectFileRelatedFilesPage adbankProjectFileRelatedFilesPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        selectRelatedFile(adbankProjectFileRelatedFilesPage, files);
    }

    @When("{I |}search and select following files '$files' on related file pop-up")
    public void searchAndSelectFiles(String files) {
        AdbankProjectFileRelatedFilesPage adbankProjectFileRelatedFilesPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        adbankProjectFileRelatedFilesPage.clickLinkToExistingButton();
        String[] filez = files.split(",");
        for (String file : filez) {
            adbankProjectFileRelatedFilesPage.typeRelatedFileName(file);
            Common.sleep(500);
            adbankProjectFileRelatedFilesPage.selectRelatedFiles(file);
        }
        adbankProjectFileRelatedFilesPage.clickSaveButton();
    }

    @When("{I |}selected type of files become as '$roleType' on related file pop-up")
    public void selectFilesBecome(String roleType) {
        AdbankProjectFileRelatedFilesPage adbankProjectFileRelatedFilesPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        adbankProjectFileRelatedFilesPage.selectFileBecomeAsType(roleType);
        Common.sleep(1000);
    }

    @When ("{I |}click on save button on related file pop-up")
    public void clicksaveonrelatedFilePopup()
    {
        AdbankProjectFileRelatedFilesPage adbankProjectFileRelatedFilesPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        adbankProjectFileRelatedFilesPage.clickSaveButton();
    }

    @Given("{I |}added related file '$fileName' such as '$asType' for file from folder '$folderName' from project '$projectName' to file '$parentFile'")
    @When("{I |}add related file '$fileName' such as '$asType' for file from folder '$folderName' from project '$projectName' to file '$parentFile'")
    public void addRelatedFileWithType(String childFile, String asType, String folder, String projectName, String parentFile) {
        String projectId = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName)).getId();
        String folderId = getCoreApi().getFolderByName(projectId, projectId, wrapVariableWithTestSession(folder)).getId();
        String childFileId = getCoreApi().getFileByName(folderId, childFile).getId();
        String parentFileId = getCoreApi().getFileByName(folderId, parentFile).getId();
        getCoreApi().addRelationBetweenFiles(getCoreApi().getCurrentAgency().getId(), asType, childFileId, parentFileId);
    }

    @Given("{I |}deleted following files '$files' on related files page")
    @When("{I |}delete following files '$files' on related files page")
    public void deleteFollowingFiles(String files) {
        AdbankProjectFileRelatedFilesPage adbankFileAttachmentsPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        for (String file : files.split(",")) {
            adbankFileAttachmentsPage.deleteRelatedFile(file);
        }
    }

    @Then("{I |}should see following count '$count' of related files")
    public void checkCountOfRelatedFiles(String count) {
        AdbankProjectFileRelatedFilesPage adbankProjectFileRelatedFilesPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        int expectedState = Integer.parseInt(count);
        int actualState =  adbankProjectFileRelatedFilesPage.getCountOfRelatedFiles();

        assertThat("Wrong count of related files: ", actualState, equalTo(expectedState));
    }

    @Then("{I |}should see following count '$count' of related files on project files page")
    public void checkCountOfRelatedFilesProjectPage(String count) {
        AdbankProjectFilesPage adbankProjectFileRelatedFilesPage = getSut().getPageCreator().getProjectFilesPage();
        int expectedState = Integer.parseInt(count);
        int actualState =  adbankProjectFileRelatedFilesPage.relatedFilesCount();

        assertThat("Wrong count of related files on project files page: ", actualState, equalTo(expectedState));
    }

    @Then("{I |}'$condition' see LinkToExisting button on related files page")
    public void checkLinkToExisting(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage().isLinkToExistButtonExist();

        assertThat(actualState, is(shouldState));
    }

    @Then("{I |}'$shouldState' see following files '$file' on related files page")
    public void checkIsRelatedFiles(String should, String file) {
        boolean shouldState = should.equalsIgnoreCase("should");
        AdbankProjectFileRelatedFilesPage pageObject = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();

        for (String f : file.split(",")) {
           assertThat("Bad file on related files page: ", shouldState, is(pageObject.isRelatedFileNotExist(f)));
        }
    }

    @Then("{I |}'$should' see remove button of following related files '$files'")
    public void checkRemoveButton(String should, String files) {
        boolean shouldState = should.equalsIgnoreCase("should");
        AdbankProjectFileRelatedFilesPage pageObject = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();

        for (String f : files.split(",")) {
            assertThat(shouldState, is(pageObject.isRelatedFileDeleteButtonExist(f)));
        }
    }

    @Then("{I |}'$should' see '$tab' tab on file info page")
    public void checkRelatedFileTab(String condition, String tab) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getProjectFileInfoPage().isTabVisible(tab);
        assertThat(String.format("Something is wrong with tab %s on file info page", tab), shouldState, is(actualState));
    }

    @Then("{I |}'$should' see following related files on related files page: $exampleTable")
    public void checkRelatedFiles(String should, ExamplesTable examplesTable) {
        boolean expectedState = should.equalsIgnoreCase("should");
        AdbankProjectFileRelatedFilesPage relatedFilesPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        Common.sleep(2000);
        for (int i = 0; i < examplesTable.getRowCount(); i++) {
            assertThat("Wrong file name: ", parametrizeTabularRow(examplesTable, i).get("FileName").equals(relatedFilesPage.getRelatedFileNames().get(i)));
            assertThat("Wrong project name: ",
                    wrapVariableWithTestSession(parametrizeTabularRow(examplesTable, i).get("ProjectName"))
                    .equals(relatedFilesPage.getAllProjectNames().get(i)));
            assertThat("Wrong is related as: ", parametrizeTabularRow(examplesTable, i).get("IsRelatedAs").equals(relatedFilesPage.getAllRelatedFilesStatus().get(i)));
        }
    }

    @Then("I '$condition' see destination role '$roleName' on related file pop-up")
    public void checkDestinationRole(String condition, String roleName) {
        AdbankProjectFileRelatedFilesPage relatedFilesPage = getSut().getPageCreator().getAdbankProjectFileRelatedFilesPage();
        boolean expectedState = condition.equalsIgnoreCase("should");
       // boolean actualState = relatedFilesPage.isDestinationType(roleName);
        boolean actualState = relatedFilesPage.isRelatedType(roleName);
        assertThat("Wrong actual state", expectedState == actualState);
    }

    private void selectRelatedFile(AdbankProjectFileRelatedFilesPage page, String files) {
        for (String file : files.split(",")) {
            page.selectRelatedFiles(file);
            Common.sleep(1000);
        }
    }
}
