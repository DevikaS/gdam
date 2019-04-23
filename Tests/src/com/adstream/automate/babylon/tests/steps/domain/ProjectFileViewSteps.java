package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectFileInfoPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.file.preview.AnnotationsPage;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.StringUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import org.openqa.selenium.*;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.io.*;
import java.util.*;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;


/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 17.09.12
 * Time: 15:06
 */
public class ProjectFileViewSteps extends AbstractFileViewSteps {

    String originalFileSize = null;
    String actualProxyFileSize = null;
    String parentHandle = null;
    AnnotationsPage annotationsPage;

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
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileCommentsPage();
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileUsageRightsPage();
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
    //QA358-Frame Grabber Changes Ends

    @Given(value = "I am on file '$filePath' info page in folder '$path' project '$projectName' of user '$userPlan'", priority = 1)
    @When(value = "{I |}go to file '$filePath' info page in folder '$path' project '$projectName' of user '$userPlan'", priority = 1)
    public AdbankFilesInfoPage openFileInfo(String filePath, String path, String projectName, String userPlan) {
        try {
            return openFileInfoPage(userPlan, new File(filePath).getName(), path, projectName);
        } catch (Exception e) {
            return null;
        }
    }

    @Given("{I am |}on file '$filePath' info page in folder '$path' project '$projectName'")
    @When("{I |}go to file '$filePath' info page in folder '$path' project '$projectName'")
    @Then("{I |}go to file '$filePath' info page in folder '$path' project '$projectName'")
    public AdbankFilesInfoPage openFileInfo(String filePath, String path, String projectName) {
        return openFileInfoPage(new File(filePath).getName(), path, projectName);
    }

    //!--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Starts
    @When("{I |}send file '$filePath' on project '$projectName' folder '$path' on opened file info page")
    public void sendProjectsFileToLibrary(String filePath, String projectName, String path) {
        getProjectFileInfoPage().clickMoreButton();
        getProjectFileInfoPage().clickSendToLibrary();
    }


    @When("{I |} click send file '$filePath' on project '$projectName' folder '$path' on opened file info page")
    public void clickSendProjectsFileToLibrary(String filePath, String projectName, String path) {
        getProjectFileInfoPage().clickMoreButton();
        getProjectFileInfoPage().clickSendToLibraryButton();
    }
    //   !--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Ends
    @Given("I am on file '$filePath' version history page in folder '$path' project '$projectName'")
    @When("{I |}go to file '$filePath' version history page in folder '$path' project '$projectName'")
    public AdbankFileVersionHistoryPage openFileVersionHistory(String filePath, String path, String projectName) {
        return openFileVersionHistoryPage(new File(filePath).getName(), path, projectName);
    }
    @Given("I am on file '$filePath' version history page in folder '$path' client project '$projectName'")
    @When("{I |}go to file '$filePath' version history page in folder '$path' client project '$projectName'")
    public AdbankFileVersionHistoryPage openClientFileVersionHistory(String filePath, String path, String projectName) {
        return openClientFileVersionHistoryPage(new File(filePath).getName(), path, projectName);
    }
    @Given("{I am |}on file '$filePath' approvals page in folder '$path' project '$projectName'")
    @When("{I |}go to file '$filePath' approvals page in folder '$path' project '$projectName'")
    public AdbankFileApprovalsPage openFileApprovals(String filePath, String path, String projectName) {
        return openFileApprovalsPage(new File(filePath).getName(), path, projectName);
    }

    @Given("{I am |}on file '$filePath' approvals page in folder '$path' client project '$projectName'")
    @When("{I |}go to file '$filePath' approvals page in folder '$path' client project '$projectName'")
    public AdbankFileApprovalsPage openFileApprovalsForClient(String filePath, String path, String projectName) {
        return openFileApprovalsPageForClient(new File(filePath).getName(), path, projectName);
    }
    @Given("{I |}selected tab '$tabName' on opened file info page")
    @When("{I |}select tab '$tabName' on opened file info page")
    public void selectTabInFile(String tabName) {
        if (!tabName.endsWith("Projects"))
            getProjectFileInfoPage().selectNavigationTab(tabName.toLowerCase());
        else
            getProjectFileInfoPage().selectNavigationTab(tabName);
    }

    @Given("{I |}waited while proxy is visible on file info page")
    @When("{I |}wait while proxy is visible on file info page")
    public void waitWhileProxyIsVisible() {
        AdbankProjectFileInfoPage page = getProjectFileInfoPage();
        final String fileId = page.getCurrentFileId();

        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getCoreApi().getContent(fileId));
            }

            @Override
            public void doActionWhileWaiting() {
                getProjectFileInfoPage();
            }
        }.process(true);

        getSut().getWebDriver().navigate().refresh();
        getProjectFileInfoPage();
    }

    @Given("{I |}waited while pdf file is loaded on file info page")
    @When("{I |}waited while pdf file is loaded on file info page")
    public void waitWhilePDFIsLoaded() {
        AdbankProjectFileInfoPage adbankProjectFileInfoPage = getProjectFileInfoPage();
        boolean finished;
        long start = System.currentTimeMillis();
        do {
            Common.sleep(3000);
            finished = adbankProjectFileInfoPage.isPDFLoaded();
            if (!finished) {
                Common.sleep(7000);
                getSut().getWebDriver().navigate().refresh();
            }
        } while (System.currentTimeMillis() - start < 120000 && !finished); // wait 2 minutes
        if (!finished) throw new TimeoutException("Timeout while waiting for pdf file is loaded");
    }

    @When("{I |}click image button expand dropdown for file name in file info page")
    public void clickImageButtonExpandDropdownForFileName() {
        getProjectFileInfoPage().clickImageButtonForExpandDropdown();
        Common.sleep(1000);
    }

    @Given("{I |}played clip on file '$fileName' info page in folder '$path' project '$projectName'")
    @When("{I |}play clip on file '$fileName' info page in folder '$path' project '$projectName'")
    public void playProjectClip(String fileName, String path, String projectName) {
        playClip(fileName, path, projectName);
    }




    @When("{I |}select revision '$revision' from Version drop down list")
    public void selectVersion(String revision) {
        AdbankProjectFileInfoPage adbankProjectFileInfoPage = getProjectFileInfoPage();
        adbankProjectFileInfoPage.setFileVersion(revision);
        Common.sleep(2000);
    }

    @When("{I |}downloaded file '$filePath' on folder '$path' project '$projectName' file info page")
    public void downloadProjectsFile(String filePath, String path, String projectName) {
        downloadFile(filePath, path, projectName);
    }

    @Then("{I |}check downloaded master file size")
    public void downloadSize(){
        File file =new File(System.getenv("USERPROFILE")+"\\Downloads\\rev-1-Fish1-Ad_master.mov");
        String abspath = file.getAbsolutePath();
        long fileSize = file.length();
        long fileSizeKB = (fileSize/1024);
        String actualFileSize = Long.toString(fileSizeKB);
        //System.out.println("AbsolutePath: " + abspath);
        System.out.println("Size of Downloaded Master (bytes): " + fileSize);
        System.out.println("Size of Downloaded Master (KB): " + fileSizeKB);
        Assert.assertEquals(actualFileSize,originalFileSize);
        file.delete();
    }

    @Then("{I |}check downloaded proxy file size")
    public void downloadedProxySize(){
        File file =new File(System.getenv("USERPROFILE")+"\\Downloads\\rev-1-Fish1-Ad_proxy.mp4");
        String abspath = file.getAbsolutePath();
        long proxyFileSize = file.length();
        long proxyFileSizeKB = (proxyFileSize/1024);
        String actualFileSize = Long.toString(proxyFileSizeKB);
        //System.out.println("AbsolutePath: " + abspath);
        System.out.println("Size of Downloaded Proxy (bytes): " + proxyFileSize);
        System.out.println("Size of Downloaded Proxy (KB): " + proxyFileSizeKB);
        Assert.assertEquals(actualFileSize,actualProxyFileSize);
        file.delete();
    }

    //   @Then("{I |}get size of original")

    @Then("{I |}get size of original")
    public void originalSize(){
        WebElement element = getSut().getWebDriver().findElement(By.xpath("//div[@id='common_downloadRevisionFile_0']"));
        String originalTxt = element.getText().toString();
        //Pattern pattern = Pattern.compile("\\d+(?:\\.\\d+)?");
        Pattern pattern = Pattern.compile("\\d+");
        Matcher matcher = pattern.matcher(originalTxt);
        if(matcher.find()){
            System.out.println("Size of Original File =" +matcher.group());
        }
        originalFileSize = matcher.group();
    }

    @Then("{I |}get size of proxy")
    public void proxySize(){
        WebElement element = getSut().getWebDriver().findElement(By.xpath("//div[@id='common_downloadRevisionFile_1']"));
        String previewTxt = element.getText().toString();
        //Pattern pattern = Pattern.compile("\\d+(?:\\.\\d+)?");
        Pattern pattern = Pattern.compile("\\d+");
        Matcher matcher = pattern.matcher(previewTxt);
        if(matcher.find()){
            System.out.println("Size of Preview File =" +matcher.group());
        }
        actualProxyFileSize = matcher.group();
    }

    @Then("{I |}download original master")
    public void downloadOriginal(){
        WebElement element = getSut().getWebDriver().findElement(By.xpath("//div[@id='common_downloadRevisionFile_0']"));
        element.click();

    }



    @Then("{I |}download proxy file")
    public void downloadProxy() throws Exception{
        WebElement element = getSut().getWebDriver().findElement(By.xpath("//div[@id='common_downloadRevisionFile_1']"));
        element.click();
        String parentWindowHandler = getSut().getWebDriver().getWindowHandle(); // Store your parent window
        String subWindowHandler = null;

        Set<String> handles = getSut().getWebDriver().getWindowHandles(); // get all window handles
        Iterator<String> iterator = handles.iterator();
        while (iterator.hasNext()){
            subWindowHandler = iterator.next();
        }
        getSut().getWebDriver().switchTo().window(subWindowHandler); // switch to popup window
        Robot rb =new Robot();
        Thread.sleep(2000);
        rb.keyPress(KeyEvent.VK_ALT);
        rb.keyPress(KeyEvent.VK_S);
        rb.keyRelease(KeyEvent.VK_S);
        rb.keyRelease(KeyEvent.VK_ALT);
        rb.keyPress(KeyEvent.VK_ENTER);
        rb.keyRelease(KeyEvent.VK_ENTER);
        getSut().getWebDriver().switchTo().window(parentWindowHandler);  // switch back to parent window
    }

    @When("{I |}download '$type' file '$filePath' on folder '$path' project '$projectName' file info page")
    public void downloadProjectsFile(String type, String filePath, String path, String projectName) {
        downloadFile(type, filePath, path, projectName);
    }

    @When("{I |}click Edit link on file info page")
    public void clickEditLink() {
        getProjectFileInfoPage().clickEditLink();
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @When("{I |}fill Edit file popup with following information: $data")
    public void fillEditFilePopup(ExamplesTable data) {
        EditFilePopup popup = new EditFilePopup(getProjectFileInfoPage());
        popup.fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @When("{I |}'$action' file info by next information: $data")
    public void editInfoFields(String action, ExamplesTable data) {
        EditFilePopup popup = getProjectFileInfoPage().clickEditLink();
        popup.fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));

        if (action.equalsIgnoreCase("save")) {
            popup.save();
        } else if (action.equalsIgnoreCase("cancel")) {
            popup.cancel();
        } else if (action.equalsIgnoreCase("close")) {
            popup.close();
        } else {
            if (!action.equalsIgnoreCase("fill"))
                throw new IllegalArgumentException(String.format("Unknown action '%s' for edit file popup", action));
        }
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @When("{I |}'$action' file '$fileNames' info in folder '$folderName' on project '$projectName' by following information: $data")
    public void editInfoFields(String action, String fileNames, String folderName, String projectName, ExamplesTable data) {
        for (String fileName : fileNames.split(",")) {
            openFileInfo(fileName, folderName, projectName);
            editInfoFields(action, data);
        }
    }
    //open and fill edit popup
    @When("{I |}Open and fill Edit file popup with following information: $data")
    public void OpenfillEditFilePopup(ExamplesTable data) {
        EditFilePopup popup = getProjectFileInfoPage().clickEditLink();
        popup.fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));
    }


    @When("{I |}generate auto code value for field '$fieldName' in section '$sectionName' on opened Edit File popup")
    public void generateAutoCodeForFile(String fieldName, String sectionName) {
        new EditFilePopup(getProjectFileInfoPage()).generateAutoCode(Localization.findByKey(fieldName), sectionName);
    }

    @When("{I |}'$action' file with comment '$comment' on opened file info page")
    public void approveOrRejectFile(String action, String comment) {
        AdbankProjectFileInfoPage page = getProjectFileInfoPage();
        ApprovalCommentPopUp popup = page.clickApprovalButton(action);
        Common.sleep(1000);
        popup.typeComment(comment);
        popup.clickOkButton();
        Common.sleep(2000);
    }

    @Then("{I |}'$condition' see approvals buttons on opened file details page")
    public void checkApprovalsButtons(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getProjectFileInfoPage().isApprovalsButtonsVisible();
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see message '$message' instead of approval stage")
    public void checkMessagePresentInApprovalsStage(String condition, String message) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getProjectFileInfoPage().isMessagePresentInApprovalsStage(message);
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' be able to play clip on file '$fileName' info page for project '$projectName' folder '$path'")
    public void checkThatPlayerAvailable(String condition, String fileName, String projectName, String path) {
        super.checkThatPlayerAvailable(condition, fileName, path, projectName);
    }

    @Then("{I |}'$condition' see Download link for '$linkType' type on Download popup on file '$fileName' info page for project '$projectName' folder '$path'")
    public void checkDownloadLinksOnFileDownloadPopup(String condition, String linkType, String fileName, String projectName, String path) {
        super.checkDownloadLinksOnFileDownloadPopup(condition, linkType, fileName, path, projectName);
    }

    @Then("{I |}'$condition' see Download link for '$linkType' type on file '$fileName' info page for project '$projectName' folder '$path'")
    public void checkDownloadLinks(String condition, String linkType, String fileName, String projectName, String path) {
        super.checkDownloadLinks(condition, linkType, fileName, path, projectName);
    }

    @Then("{I |}'$condition' see download button '$button' ready to download file on file '$fileName' info page in folder '$path' for project '$projectName'")
    public void checkDownloadingFileName(String condition, String button, String fileName, String path, String projectName) {
        super.checkDownloadingVideoFileName(condition, button, fileName, path, projectName);
    }

    @Then("{I |}'$shouldState' see Download button in the top menu of file '$fileName' info page in folder '$path' for project '$projectName'")
    public void checkVisibilityDownloadButtonOnTopMenu(String condition, String fileName, String path, String projectName) {
        super.checkVisibilityDownloadButtonOnTopMenu(condition, fileName, path, projectName);
    }


    @Then("{I |}'$shouldState' see Download Original button on file '$filePath' info page in folder '$path' project '$projectName'")
    public void checkVisibilityDownloadOriginalBtnProjectsFile(String shouldState, String filePath, String path, String projectName) {
        checkVisibilityDownloadOriginalBtn(shouldState, filePath, path, projectName);
    }

    @Then("{I |}'$shouldState' see Download master using nVerge button on file '$filePath' info page in folder '$path' project '$projectName'")
    public void checkVisibilityDownloadMasterUsingNVergeBtnProjectsFile(String shouldState, String filePath, String path, String projectName) {
        checkVisibilityDownloadMasterUsingNVergeBtn(shouldState, filePath, path, projectName);
    }

    @Then("{I |}'$shouldState' see Download proxy button on file '$filePath' info page in folder '$path' project '$projectName'")
    public void checkVisibilityDownloadProxyBtnProjectsFile(String shouldState, String filepath, String path, String projectName) {
        checkVisibilityDownloadProxyButton(shouldState, filepath, path, projectName);
    }

    @Then("{I |}'$shouldState' see Download button in the top menu of opened file info page")
    public void checkVisibilityDownloadButtonOnTopMenu(String condition) {
        super.checkVisibilityDownloadButtonOnTopMenu(condition);
    }


    @Then("{I |}'$shouldState' see Download Original button on opened file info page")
    public void checkVisibilityDownloadOriginalBtnProjectsFile(String shouldState) {
        checkVisibilityDownloadOriginalBtn(shouldState);
    }

    @Then("{I |}'$shouldState' see Download master using nVerge button on opened file info page")
    public void checkVisibilityDownloadMasterUsingNVergeBtnProjectsFile(String shouldState) {
        checkVisibilityDownloadMasterUsingNVergeBtn(shouldState);
    }

    @Then("{I |}'$shouldState' see Download proxy button on opened file info page")
    public void checkVisibilityDownloadProxyBtnProjectsFile(String shouldState) {
        checkVisibilityDownloadProxyButton(shouldState);
    }

    @Then("{I |}'$shouldState' see Upload new version button on file '$filePath' info page in folder '$path' project '$projectName'")
    public void checkVisibilityUploadNewVersionyBtnProjectsFile(String shouldState, String filepath, String path, String projectName) {
        checkVisibilityUploadNewVersionBtn(shouldState, filepath, path, projectName);
    }
    @Then("{I |}'$shouldState' see '$button' button on upload dropdown on file '$filePath' info page in folder '$path' project '$projectName'")
    public void checkVisibilityOnUploadDropdownOnProjectsFilePage(String shouldState, String button, String filepath, String path, String projectName) {
        checkVisibilityOnUploadDropdownOnProjectsFilesPage(shouldState, button, filepath, path, projectName);
    }

    //QA-442 Edit Office doc feature
    @When("{I |}click Edit Document button on file '$filePath' info page in folder '$path' project '$projectName'")
    public void ClickEditDocumentBtnProjectsFile(String filepath, String path, String projectName) {
        clickEditDocumentButton(filepath, path, projectName);
    }

    @Then("{I |}'$shouldState' see proxy of video file '$filePath' on info page in folder '$path' project '$projectName'")
    public void checkProxyVideoProjectsFile(String shouldState, String filePath, String path, String projectName) {
        checkAvailabilityProxyVideoFile(shouldState, filePath, path, projectName);
    }

    @Then("{I |}'$condition' see file version drop down on file '$filePath' info page in folder '$path' project '$projectName'")
    public void checkVisibilityVersionDropDownProjectsFile(String condition, String filePath, String path, String projectName) {
        checkVisibilityVersionsDropDown(condition, filePath, path, projectName);
    }

    @Then("{I |}'$condition' see next values '$values' in Select Version drop down list")
    public void checkValuesIsSelectVersionDropDown(String condition, String values) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankProjectFileInfoPage adbankProjectFileInfoPage = getProjectFileInfoPage();
        List<String> comboBoxValues = adbankProjectFileInfoPage.getValuesFromSelectVersionComboBox();
        String[] valuesArray = values.split(",");
        assertThat(comboBoxValues, shouldState ? hasItems(valuesArray) : not(hasItems(valuesArray)));
    }

    @Then("{I |}should see following tabs on file '$filePath' info page in folder '$path' project '$projectName': $data")
    public void checkProjectsTabsVisibility(String filePath, String path, String projectName, ExamplesTable data) {
        checkTabsVisibility(filePath, path, projectName, data);
    }

    @Then("{I |}'$condition' see active '$tabName' tab on file '$filePath' info page in folder '$path' project '$projectName'")
    public void checkThatActivityTabPresent(String condition, String tabName, String filePath, String path, String projectName) {
        if (tabName.equalsIgnoreCase("Activity")) {
            checkActivityTabAvailability(condition, filePath, path, projectName);
        } else if (tabName.equalsIgnoreCase("Version History")) {
            checkVersionHistoryTabAvailability(condition, filePath, path, projectName);
        } else if (tabName.equalsIgnoreCase("Usage Rights")) {
            checkUsageRightsTabAvailability(condition, filePath, path, projectName);
        } else if (tabName.equalsIgnoreCase("Frames")) {
            checkFramesTabAvailability(condition, filePath, path, projectName);
        }else {
            throw new IllegalArgumentException(String.format("Unknown tab name '%s' on file info page", tabName));
        }
    }

    @Then("I '$condition' see proxy of file '$fileType' on file info page")
    public void checkProxyVisibilityState(String condition, String fileType) {
        boolean should = condition.equals("should");
        AdbankProjectFileInfoPage adbankProjectFileInfoPage = getProjectFileInfoPage();
        if (fileType.equalsIgnoreCase("video") || fileType.equalsIgnoreCase("audio")) {
            assertThat(adbankProjectFileInfoPage.isProxyForVideoVisible(), equalTo(should));
            return;
        }
        if (fileType.equalsIgnoreCase("pdf") || fileType.equalsIgnoreCase("document")) {
            assertThat(adbankProjectFileInfoPage.isPDFLoaded(), equalTo(should));
            return;
        }
        Assert.fail("file's type is defined incorrect");
    }

    @Then("{I |}should see preview of video file on opened file details page")
    public void checkPreviewImageOnFileInfoPage() {
        assertThat(getProjectFileInfoPage().isPreviewVisible(), is(true));
    }

    @Then("I should see preview on file details page for file '$filePath' folder '$path' project '$objectName'")
    public void checkPreviewImageOnFileInfoPage(String filePath, String path, String objectName) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = createFolderOverCoreApi(path, objectName);
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankProjectFileInfoPage page = getSut().getPageNavigator().getProjectFileInfoPage(object.getId(), folder.getId(), file.getId());
        boolean actual = page.isFilePreviewVisible(file.getId());

        assertThat("Preview file should be visible!", actual, is(true));
    }

    @Then("I '$condition' see project '$projectName' on file info page")
    public void checkProjectNameOnFileInfoPage(String condition, String projectName) {
        AdbankProjectFileInfoPage adbankProjectFileInfoPage = getProjectFileInfoPage();
        boolean should = condition.equals("should");
        projectName = wrapVariableWithTestSession(projectName);
        assertThat(adbankProjectFileInfoPage.getProjectNameText(), should ? equalTo(projectName) : not(projectName));
    }

    @Then("I should see highlighted folder '$folderName' and project '$projectName' on file info page")
    public void checkHighlightedFolderOnFileInfoPage(String folderName, String projectName) {
        AdbankProjectFileInfoPage page = getProjectFileInfoPage();

        folderName = wrapVariableWithTestSession(folderName.replaceAll("/", ""));
        projectName = wrapVariableWithTestSession(projectName);

        assertThat(page.isFolderHighlightedOnDropdownTreeContainer(folderName), equalTo(true));
        assertThat(page.isObjectNameExistOnDropdownTreeContainerAsTitle(projectName), equalTo(true));
    }

    @Then("{I |}should see file '$filePath' info page in folder '$path' project '$projectName'")
    public void checkVisibilityFilesInfoPage(String filePath, String path, String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        String expectedPage = String.format("projects/projects/%s/folders/%s/files/%s/info", project.getId(), folder.getId(), file.getId());
        BabylonSteps.checkCurrentHashPage(expectedPage);
    }

    // | FieldValue |
    @Then("{I |}'$condition' see that combo box '$field' has following values on Edit File popup on file '$file' info page in folder '$path' project '$project': $data")
    public void checkScreenFieldAvailableValuesProjectsFile(String condition, String field, String file, String path, String project, ExamplesTable data) {
        List<String> values = new ArrayList<>();
        for (Map<String, String> row : parametrizeTableRows(data)) values.add(row.get("FieldValue"));
        checkThatComboboxHasValues(condition, field, values, file, path, project);
    }

    @Then("{I |}'$condition' see that combo box '$field' has following values '$fieldValues' on Edit File popup on file '$file' info page in folder '$path' project '$project'")
    public void checkScreenFieldAvailableValuesProjectsFile(String condition, String field, String fieldValues, String file, String path, String project) {
        List<String> values = new ArrayList<>();
        Collections.addAll(values, fieldValues.split(","));
        checkThatComboboxHasValues(condition, field, values, file, path, project);
    }

    @Then("{I |}'$condition' see field '$fieldNames' with size '$fieldSize' on opened Edit file popup")
    public void checkFieldSizeOnEditFilePopup(String condition, String fieldNames, String fieldSize) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        EditFilePopup popup = new EditFilePopup(getProjectFileInfoPage());

        for (String fieldName : fieldNames.split(",")) {
            actualState = popup.isFieldHaveSize(fieldName, fieldSize);
            assertThat(actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see field '$fieldName' with size '$fieldSize' on opened file info page")
    public void checkFieldSizeOnFileInfoPage(String condition, String fieldNames, String fieldSize) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        AdbankProjectFileInfoPage page = getProjectFileInfoPage();

        for (String fieldName : fieldNames.split(",")) {
            actualState = page.isFieldHaveSize(fieldName, fieldSize);
            assertThat(actualState, is(expectedState));
        }
    }

    // | FieldName |
    @Then("{I |}'$condition' see following fields on opened Edit file popup: $data")
    public void checkEditFilePopupFieldsVisibility(String condition, ExamplesTable data) {
        List<String> fieldsList = new ArrayList<>();
        for (Map<String, String> row : parametrizeTableRows(data)) fieldsList.add(row.get("FieldName"));
        checkEditFilePopupVisibility(condition, StringUtils.join(fieldsList, ","));
    }

    @Then("{I |}'$condition' see fields '$fields' on opened Edit file popup")
    public void checkEditFilePopupVisibility(String condition, String fields) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFields = new EditFilePopup(getProjectFileInfoPage()).getAvailableFieldNames();

        for (String expectedField : fields.split(","))
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    @Then("{I |}'$condition' see multiline field '$fieldName' with rows count '$linesNumber' on opened Edit file popup")
    public void checkMultilineFiledLinesOnEditFilePopup(String condition, String fieldName, String expectedRowsCount) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualRowsCount = new EditFilePopup(getProjectFileInfoPage()).getMultilineFieldRowsCount(fieldName);

        assertThat(actualRowsCount, shouldState ? equalTo(expectedRowsCount) : not(equalTo(expectedRowsCount)));
    }

    // | FieldName |
    @Then("{I |}'$condition' see following '$fieldsType' field labels on opened file info page: $data")
    public void checkFileInfoFieldsVisibility(String condition, String fieldsType, ExamplesTable data) {
        List<String> fieldsList = new ArrayList<>();
        for (Map<String, String> row : parametrizeTableRows(data)) fieldsList.add(row.get("FieldName"));
        checkFileInfoFieldsVisibility(condition, fieldsType, StringUtils.join(fieldsList, ","));
    }

    @Then("{I |}'$condition' see '$fieldsType' field labels '$fields' on opened file info page")
    public void checkFileInfoFieldsVisibility(String condition, String fieldsType, String fields) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFields;

        if (fieldsType.equalsIgnoreCase("asset information")) {
            actualFields = getProjectFileInfoPage().getAssetInformationFieldNames();
        } else if (fieldsType.equalsIgnoreCase("custom metadata")) {
            actualFields = getProjectFileInfoPage().getCustomFieldNames();
        } else if (fieldsType.equalsIgnoreCase("specification")) {
            actualFields = getProjectFileInfoPage().getSpecificationFieldNames();
        } else {
            throw new IllegalArgumentException(String.format("Unknown fields type given: '%s'", fieldsType));
        }

        for (String expectedField : fields.split(","))
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following '$fieldsType' fields on opened file info page: $data")
    public void checkAssetInformation(String condition, String fieldsType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> expectedFields;

        if (fieldsType.equalsIgnoreCase("specification")) {
            expectedFields = convertMetadataFields(data, "FieldName", "FieldValue");
        } else {
            expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");
        }

        List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (MetadataItem expectedField : expectedFields) {
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }

    //| FieldName | FieldValue | on file Info page
    @Then("{I |}'$condition' see following meta data fields on opened file info page: $data")
    public void checkFiledValue(String condition,ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualValue = null;

        for(int i= 0;i<data.getRowCount();i++){
            actualValue = getProjectFileInfoPage().getMetaDataFieldValue( parametrizeTabularRow(data, i).get("FieldName"));
            assertThat("Meta Data Value", actualValue,is(parametrizeTabularRow(data, i).get("FieldValue")));
        }
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following '$fieldsType' fields on opened Edit file popup: $data")
    public void checkAssetInformationOnEditFilePopup(String condition, String fieldsType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> actualFields = getActualEditFilePopupFields(fieldsType);
        List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (MetadataItem expectedField : expectedFields)
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following '$fieldsType' fields in the following order on opened file info page: $data")
    public void checkAssetInformationOrderedAndPresented(String condition, String fieldsType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");
        List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (int i = 0; i < expectedFields.size(); i++)
            assertThat(actualFields.get(i), shouldState ? equalTo(expectedFields.get(i)) : not(equalTo(expectedFields.get(i))));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following fields in the following order on opened Edit file popup: $data")
    public void checkAssetInformationOnEditFilePopupOrderedAndPresented(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> actualFields = getActualEditFilePopupFields("available");
        List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (int i = 0; i < expectedFields.size(); i++)
            assertThat(actualFields.get(i), shouldState ? equalTo(expectedFields.get(i)) : not(equalTo(expectedFields.get(i))));
    }

    @Then("{I |}'$condition' see approval status icon '$expectedStatusIcon' on file '$fileName' info page in folder '$path' for project '$projectName'")
    public void checkFileApprovalStatusIcon(String condition, String expectedStatusIcon, String fileName, String path, String projectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankFilesInfoPage filesInfoPage = openFileInfo(fileName, path, projectName);
        Common.sleep(3000);
        String actualStatusIcon = filesInfoPage.getApprovalStatus();
        //String actualStatusIcon = openFileInfo(fileName, path, projectName).getApprovalStatus();

        assertThat(actualStatusIcon, shouldState ? equalToIgnoringCase(expectedStatusIcon) : not(equalToIgnoringCase(expectedStatusIcon)));
    }

    @Then("{I |}'$condition' be on the file info page")
    public void checkThatOpenedPageIsFileInfo(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        try {
            getProjectFileInfoPage();
            assertThat(true, is(expectedState));
        } catch (Exception e) {
            assertThat(false, is(expectedState));
        }
    }

    @Then("{I |}should see following auto generated code '$autoCodePattern' for field '$fieldName' in section '$sectionName' on opened Edit File popup")
    public void checkAutoGeneratedCodeForFile(String autoCodePattern, String fieldName, String sectionName) {
        assertThat("Check auto generated code for file: ", new EditFilePopup(getProjectFileInfoPage()).getTextFieldValue(Localization.findByKey(fieldName), sectionName),
                StringByRegExpCheck.matches(autoCodePattern));
    }


    @When("I click on '$attachtab' tab on opened file info page")
    public void clickOnTab(String attachtab) {
        AdbankProjectFileInfoPage pageObject = getSut().getPageCreator().getProjectFileInfoPage();
        pageObject.clickOnTab(attachtab);
    }

    private AdbankProjectFileInfoPage getProjectFileInfoPage() {
        return getSut().getPageCreator().getProjectFileInfoPage();
    }

    private List<MetadataItem> getActualEditFilePopupFields(String fieldsType) {
        if (fieldsType.equalsIgnoreCase("required")) {
            return new EditFilePopup(getProjectFileInfoPage()).getRequiredFieldsInfo();
        } else if (fieldsType.equalsIgnoreCase("disabled")) {
            return new EditFilePopup(getProjectFileInfoPage()).getDisabledFieldsInfo();
        } else if (fieldsType.equalsIgnoreCase("available")) {
            return new EditFilePopup(getProjectFileInfoPage()).getAvailableFieldsInfo();
        } else {
            throw new IllegalArgumentException(String.format("Unknown fields type given: '%s'", fieldsType));
        }
    }

    private List<MetadataItem> getActualFileInfoFields(String fieldsType) {
        if (fieldsType.equalsIgnoreCase("asset information")) {
            return getProjectFileInfoPage().getAssetInformationFields();
        } else if (fieldsType.equalsIgnoreCase("custom metadata")) {
            return getProjectFileInfoPage().getCustomMetadataFields();
        } else if (fieldsType.equalsIgnoreCase("specification")) {
            return getProjectFileInfoPage().getSpecificationFields();
        } else {
            throw new IllegalArgumentException(String.format("Unknown fields type given: '%s'", fieldsType));
        }
    }

    private void setParentHandle(String parentHandleName) {
        parentHandle = parentHandleName;
    }

    private String getParentHandle() {
        return parentHandle;
    }
}
