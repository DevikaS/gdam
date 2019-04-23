package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.middleware.BabylonSendplusMiddleTierService;
import com.adstream.automate.babylon.sut.data.UsageRule;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.PageCreator;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsOverviewPage;
import com.adstream.automate.babylon.sut.pages.library.AdbankAddFileToLibraryPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankBatchUsageRightEditPopUp;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.library.elements.ConfirmationPopup;
import com.adstream.automate.babylon.sut.pages.mediamanager.MediaManagerUploadPage;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.jbehave.core.steps.Parameters;
import org.joda.time.DateTime;
import org.joda.time.Period;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import javax.xml.bind.JAXBException;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertTrue;


/**
 * User: ruslan.semerenko
 * Date: 03.05.12 12:38
 */
public class ProjectFolderSteps extends AbstractFolderSteps {

    @Override
    protected AdbankFoldersTree getFoldersTree(String projectId, String folderId) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        if (folderId == null) {
            return pageFactory.getProjectOverviewPage(projectId);
        } else {
            return pageFactory.getProjectFilesPage(projectId, folderId);
        }
    }

    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getProjectByName(objectName);
    }

    protected JumpLoaderPage getFilesUploadPage(String projectId, String folderId) {
        return getSut().getPageNavigator().getProjectFilesUploadPage(projectId, folderId);
    }

    protected AdbankFilesPage getFilesPage(String projectId, String folderId) {
        return getSut().getPageNavigator().getProjectFilesPage(projectId, folderId);
    }

    protected AdbankFilesPage getFilesPage() {
        return getSut().getPageCreator().getProjectFilesPage();
    }

    private AdbankAddFileToLibraryPage getAddFileToLibraryPage() {
        return getSut().getPageCreator().getAdbankAddFileToLibraryPage();
    }

    @Given("{I |}created '$path' folder for project '$projectName'")
    @When("{I |}create '$path' folder for project '$projectName'")
    public Content createProjectFolderOverCore(String path, String projectName) {
        return createFolderOverCoreApi(path, projectName);
    }

    @Given("{I |}created '$count' folders for project '$projectName' with name pattern '$namePrefix'")
    @When("{I |}create '$count' folders for project '$projectName' with name pattern '$namePrefix'")
    public void createProjectFoldersOverCore(int count, String projectName, String namePrefix) {
        for (int i = 1; i <= count; i++) createFolderOverCoreApi(String.format("%s_%d", namePrefix, i), projectName);
    }

    // | Message | UserEmails | ExpireDate | DownloadProxy | DownloadOriginal |
    // DownloadProxy and DownloadOriginal are not required properties and may be set as true or false
    @When("{I |}add secure share for file '$fileName' to following client users: $data")
    public void addSecureShareOfFileForClient(String fileName, ExamplesTable data) {
        AdbankFilesPage page = new AdbankFilesPage(getSut().getWebDriver());
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectStareTab();
        fillSharePopup(parametrizeTabularRow(data), true);
        popup.clickOKButton();
    }

    // | folder |
    @Given("{I |}created in '$projectName' project next folders: $foldersTable")
    @When("{I |}create in '$projectName' project next folders: $foldersTable")
    public List<Content> createProjectFoldersOverCore(String projectName, ExamplesTable foldersTable) {
        return createFoldersOverCoreApi(projectName, foldersTable);
    }

    @Given("{I |}uploaded '$fileName' file into '$path' folder for '$projectName' project")
    @When("{I |}upload '$fileName' file into '$path' folder for '$projectName' project")
    public void createProjectFile(String fileName, String path, String projectName) {

        createFile(fileName, path, projectName);
    }

    @Given("{I |}uploaded '$fileName' file into '$path' folder for '$projectName' client '$email'")
    @When("{I |}upload '$fileName' file into '$path' folder for '$projectName' client '$email'")
    public void createClientProjectFile(String fileName, String path, String projectName,String email) {

        createClientFile(fileName, path, projectName, email);

    }

    @Given("{I |}uploaded '$fileName' file into '$path' subfolder for '$projectName' by user '$userName'")
    @When("{I |}upload '$fileName' file into '$path' subfolder for '$projectName' by user '$userName'")
    public void uploadToSubfolder(String fileName, String path, String projectName,String userName) {

        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        createClientFile(fileName, path, projectName, user.getEmail());
    }

    @Given("{I |}attached new file '$fileName' for file '$masterFileName' into '$path' folder for '$projectName' project")
    @When("{I |}attach new file '$fileName' for file '$masterFileName' into '$path' folder for '$projectName' project")
    public void createAttachedFileToProject(String fileName, String masterFileName, String path, String projectName) {

        createAttachedFile(fileName, masterFileName, path, projectName);
    }

    @Given("{I |}uploaded '$fileName' file into '$path' folder for '$projectName' project using sendplus middle tier api")
    @When("{I |}upload '$fileName' file into '$path' folder for '$projectName' project using sendplus middle tier api")
    public void createProjectFileForSendplusUploadToProject(String fileName, String path, String projectName) throws IOException {

        createFileForSendplusUploadToProject(fileName, path, projectName);


    }
    @Given("{I |}uploaded '$fileName' file into library folder using sendplus middle tier api")
    public void createLibraryFileForSendplusUpload(String fileName) throws IOException {

        createFileForSendplusUploadToLibrary(fileName);
    }

    @When("{I |}upload an attachment '$attachment' to asset '$assetName' in Library for collection '$collectionName'")
    public void assetAttachmentViaSendplus(String attachment,String assetName,String collectionName) throws IOException {
        AssetFilter category = getCoreApi().getAssetsFilterByName(collectionName, "");

       // Content asset = getAsset(category.getId(), assetName);
        //uploadattachmentToAssetViaSendplus(attachment);
    }

    @When("{I |}upload an revision '$revisionName' to file '$fileName' in folder '$path' project '$projectName' using sendplus middletier api")
    public void uploadFileRevisionViaSendplus1(String revisionName,String fileName,String path,String projectName) throws IOException {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(),fileName);
        uploadFileRevisionViaSendplus(revisionName, file.getId());
    }

    @When("{I |}upload an file attachment '$attachementName' to file '$fileName' in folder '$path' project '$projectName' using sendplus middletier api")
    public void uploadFileAttachmentViaSendplus(String attachmentName,String fileName,String path,String projectName) throws IOException {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(),fileName);
        uploadFileAttachmentViaSendplus(attachmentName, file.getId());
    }

    @Given("{I |}uploaded new file version '$fileName' for file '$masterFileName' into '$path' folder for '$projectName' project")
    @When("{I |}upload new file version '$fileName' for file '$masterFileName' into '$path' folder for '$projectName' project")
    public void createNewProjectFile(String fileName, String masterFileName, String path, String projectName) {
        createRevision(fileName, path, projectName, masterFileName);
    }

    @Given("{I |}uploaded new file version '$fileName' for file '$masterFileName' into '$subfolderPath' shared subfolder for '$projectName' project")
    @When("{I |}upload new file version '$fileName' for file '$masterFileName' into '$subfolderPath' shared subfolder for '$projectName' project")
    public void createNewFileInSharedsubfolder(String fileName, String masterFileName, String sharedSubFolderPath, String projectName) {
        createRevisionFileInSharedSubFolder(fileName, sharedSubFolderPath, projectName, masterFileName);
    }


    @Given("{I |}uploaded few files '$fileName' with delimiter '$delimiter' into '$path' folder for '$projectName' project")
    @When("{I |}upload few files '$fileName' with delimiter '$delimiter' into '$path' folder for '$projectName' project")
    public void createProjectFile(String fileName, String delimiter, String path, String projectName) {
        String[] fileArray = fileName.split(delimiter);
        for (String file : fileArray) {
            createFile(file, path, projectName);
        }
    }

    // | FileName | Path |
    @Given("{I |}uploaded into project '$projectName' following files: $filesTable")
    @When("{I |}upload into project '$projectName' following files: $filesTable")
    public void createProjectFiles(String projectName, ExamplesTable filesTable) {
        createFiles(projectName, filesTable);
    }

    // | FileName | Path | MasterFileName |
    @Given("{I |}uploaded into project '$projectName' following revisions: $filesTable")
    @When("{I |}upload into project '$projectName' following revisions: $filesTable")
    public void createRevisionFiles(String projectName, ExamplesTable filesTable) {
        createRevisions(projectName, filesTable);
    }

    // | FileName | Path | MasterFileName |
    @Given("{I |}uploaded into client project '$projectName' following revisions: $filesTable")
    @When("{I |}upload into client project '$projectName' following revisions: $filesTable")
    public void createClientRevisionFiles(String projectName, ExamplesTable filesTable) {
        createClientRevisions(projectName, filesTable);
    }
    // | ProjectName | Path | FileName | SubType |
    @Given("{I |}moved following files into library: $fileTable")
    @When("{I |}move following files into library: $fileTable")
    public void moveFiles(ExamplesTable fileTable) {
        for (int i = 0; i < fileTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fileTable, i);

            String fileName = row.get("FileName");
            Content folder = createFolderOverCoreApi(row.get("Path"), row.get("ProjectName"));
            Content file = getCoreApi().getFileByName(folder.getId(), fileName);

            String subType = row.get("SubType");
            if (subType != null && !subType.isEmpty()) {
                file.setMediaSubType(subType);
            }

            if (!getCoreApi().isAssetExist(getCoreApi().getAssetsFilterByName("My Assets", "").getId(), fileName)) {
                getCoreApi().moveFileIntoLibrary(file);
            }
        }
    }



    @Given("I am on project '$projectName' files page")
    @When("{I |}go to project '$projectName' files page")
    public void openProjectFilesPage(String projectName) {
        openObjectFilesPage(projectName);
    }

    @Given("{I am |}on project '$projectName' overview page")
    @When("{I |}go to project '$projectName' overview page")
      public void openProjectOverviewPage(String projectName) {
        Project object = getObjectByName(wrapVariableWithTestSession(projectName));
        getFoldersTree(object.getId(), null);
    }

    @Then("{I |}'$condition' be on the project '$projectName' overview page")
    public void checkThatOpenedPageIsProjectFilesPage(String condition,String projectName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        try {
           Project object = getObjectByName(wrapVariableWithTestSession(projectName));
           getSut().getWebDriver().getCurrentUrl().contains(object.getId());
           // getFoldersTree(object.getId(), null);
            actualState = true;
        } catch (Exception e) {
            e.printStackTrace();
            actualState = false;
        }
        assertThat("I'm on project overview page", actualState, is(expectedState));
    }

    @Given("{I |}selected '$tabname' tab on project overview page")
    @When("{I |}select '$tabname' tab on project overview page")
    public void selectTabOnProjectOverviewPage(String tabName){
        PageCreator page = getSut().getPageCreator();
        AdCostsOverviewPage overviewPage = page.getAdCostsOverviewPage();
        page.getProjectOverviewPage().clickCostsTab();
        overviewPage.waitUntilAdCostsOverviewPageToLoad();
    }

    @When("{I |}click on download via sendplus from folder '$path' in project '$projectName'")
    public void clickDownloadBySendplusFromFolder(String path, String projectName) {

        downloadBySendplusFromFolder(projectName, path);

    }

    @Given("{I am |}on project '$projectName' folder '$path' page")
    @When("{I |}go to project '$projectName' folder '$path' page")
    public AdbankFoldersTree openProjectFolderPage(String projectName, String path) {
        return openObjectFolderPage(projectName, path);
    }

    // used for navigating to project and folder created during AXEL F
    //TD-202 -- Appending the projectName with the year
    @When("{I |}pass to project '$projectName' folder '$path' page")
    public AdbankFoldersTree passToProjectFolderPage(String projectName, String path) {
        projectName = projectName.concat(" - " + String.valueOf(Calendar.getInstance().get(Calendar.YEAR)));
        Project project = getObjectByName(projectName);
        Content folder = getCoreApi().createFolderRecursive(prepareAdstreamIngestPath(path), project.getId(), project.getId());
        return getFoldersTree(project.getId(), folder.getId());
    }

    @Given("I am on project '$projectName' folder '$path' page of user '$userPlan'")
    @When("{I |}go to project '$projectName' folder '$path' page of user '$userPlan'")
    public AdbankFoldersTree openProjectFolderPage(String projectName, String path, String userPlan) {
        User user = getData().getUserByType(userPlan);
        try {
            return openObjectFolderPage(projectName, path, user);
        } catch (Exception e) {
            return null;
        }
    }

    @Given("{I |}published the project '$projectName'")
    @When("{I |}publish the project '$projectName'")
    public void publishProject(String projectName) {
        openProjectOverviewPage(projectName);
        PublishProjectPopup pp = getSut().getPageCreator().getProjectOverviewPage().clickPublishButton();
        pp.clickNotifyButton();
    }
    @When("{I |}publish the project '$projectName' later:$fields")
    public void publishProjectLater(String projectName, ExamplesTable fields) {
        openProjectOverviewPage(projectName);
        PublishProjectLaterPopup pp = getSut().getPageCreator().getProjectOverviewPage().clickPublishLater();
        for (int i = 1; i <= fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields);
            pp.fillPopup(row.get("Publish Date"),row.get("Publish Time"),row.get("Publish DateTimeZone"),row.get("Publish Message"));
            pp.clickSaveButton();
        }
    }

    @Given("{I |} '$projectState' the project '$projectName'")
    public void publishAndUnpublishProject(String projectState,String projectName) {
        openProjectOverviewPage(projectName);
        if(projectState.equals("publish")) {
            getSut().getPageCreator().getProjectOverviewPage().clickPublishButton().action.click();
        }
    }

    @Given("{I |}unpublished the project '$projectName'")
    @When("{I |}unpublish the project '$projectName'")
    public void unPublishProject(String projectName) {
        openProjectOverviewPage(projectName);
        getSut().getPageCreator().getProjectOverviewPage().clickUnpublishButton().action.click();
       // PopUpWindow ss =   getSut().getPageCreator().getProjectOverviewPage().clickUnpublishButton();
        //ss.clickAction();
    }

    @Given("I am on project '$projectName' folder '$path' upload page")
    public AdbankProjectFilesUploadPage openProjectFilesUploadPage(String projectName, String path) {
        openProjectFolderPage(projectName, path);
        return getSut().getPageCreator().getProjectFilesPage().clickUploadButton();
    }

    @Given("{I |}selected folder '$path' in project '$projectName'")
    @When("{I |}select folder '$path' in project '$projectName'")
    public void selectFolderInProjectByName(String path, String projectName) {
        selectFolder(path, projectName).click();
    }

    @Given("{I |}selected folder '$folderName' on project files page")
    @When("{I |}select folder '$folderName' on project files page")
    public void selectProjectsOnProjectFilesPage(String folderName) {
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        String[] folders = folderName.split(",");
        for (String fN : folders) {
            String folder = wrapVariableWithTestSession(fN).replace("/", "");

            if (!adbankProjectFilesPage.isFolderSelected(folder)) {
                adbankProjectFilesPage.selectFileByFileName(folder);
            }
        }
    }

    @Given("{I |}opened share popup in project '$projectName' for folder '$folderName' from root project")
    @When("{I |}open share popup in project '$projectName' for folder '$folderName' from root project")
    public void openSharePopUpFromRootProject(String projectName, String folderName) {
        openProjectFolderPage(projectName, "root");
        selectProjectsOnProjectFilesPage(folderName);
        clickShareUsingShareButton();
    }


    @Given("{I |}selected file '$fileName' on project files page")
    @When("{I |}select file '$fileName' on project files page")
    public void selectFileOnProjectFilesPage(String fileName) {
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        String[] fileNames = fileName.split(",");
        for (String fN : fileNames) {
            adbankProjectFilesPage.selectFileByFileName(fN);
        }
    }

    @Given("{I |}selected file '$fileName' on project '$projectName' files page")
    @When("{I |}select file '$fileName' on project '$projectName' files page")
    public void selectFileOnProjectFilesPage(String fileName, String projectName) {
        getFilesPage(getObjectByName(wrapVariableWithTestSession(projectName)).getId(), null);
        selectFileOnProjectFilesPage(fileName);
    }

    @Given("{I |}clicked Download button on project files page")
    @When("{I |}click Download button on project files page")
    public void clickDownloadButton() {
        getSut().getPageCreator().getProjectFilesPage().clickDownloadButton();
    }

    @Given("{I |}clicked Download link next to '$linkType' file name '$fileName' on Download popup")
    @When("{I |}click Download link next to '$linkType' file name '$fileName' on Download popup")
    public void clickDownloadLinkOnDownloadPopup(String linkType, String fileName) {
        DownloadFilePopUpWindow popup = new DownloadFilePopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        if (linkType.equalsIgnoreCase("original")) {
            popup.clickDownLoadLinkNextToOriginalFileName(fileName);
        } else if (linkType.equalsIgnoreCase("proxy")) {
            popup.clickDownLoadLinkNextToProxyFileName(fileName);
        } else {
            throw new IllegalArgumentException(String.format("Unknown link type: '%s'", linkType));
        }
    }

    @Given("{I |}selected files on project files page: $fileNames")
    @When("{I |}select files on project files page: $fileNames")
    public void selectedSomeFiles(ExamplesTable fileNames) {
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        for (Parameters parameters : fileNames.getRowsAsParameters(true)) {
            adbankProjectFilesPage.selectFileByFileName(parameters.valueAs("FileName", String.class));
        }
    }

    private AdbankLibraryAssetsInfoPage getLibraryAssetsInfoPage() {
        return getSut().getPageCreator().getLibraryAssetsInfoPage();
    }

    @When("{I |}click Edit link on project file info page")
    public void clickEditLink() {

        getLibraryAssetsInfoPage().clickEditLink();

     //   getSut().getWebDriver().findElement(By.cssSelector(".editButton")).click();


    }


    @When("{I |}open file '$fileName' on project '$projectName' overview page")
    public void openProjectOverviewFile(String fileName, String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectOverviewPage page = (AdbankProjectOverviewPage) getFoldersTree(project.getId(), null);
        page.openFile(fileName);
    }

    @When("{I |}delete the following files in next project and folders: $exampleTable")
    public void deleteSelectedFiles(ExamplesTable examplesTable) {
        for (Parameters parameters : examplesTable.getRowsAsParameters(true)) {
            if ((parameters.values().get("Project") != null) && (parameters.values().get("Folder") != null) && (parameters.values().get("FileName") != null)) {
                openObjectFolderPage(parameters.valueAs("Project", String.class), parameters.valueAs("Folder", String.class));
                deleteSelectedFiles("delete", parameters.valueAs("FileName", String.class));
            }
        }
    }

    @When("{I |}delete the following files from project '$projectName' and folder '$folderName': $fileNames")
    public void deleteSelectedFiles(String projectName, String folderName, ExamplesTable fileNames) {
        deleteFiles(projectName, folderName, fileNames);
    }

    @Given("{I |}clicked button '$button' on project '$projectName' Overview page")
    @When("{I |}click button '$button' on project '$projectName' Overview page")
    public void publishProject(String button, String projectName) {
        if (button.equalsIgnoreCase("Publish")) {
            publishProject(projectName);
        } else if (button.equalsIgnoreCase("Unpublish")) {
            unPublishProject(projectName);
        } else {
            throw new IllegalArgumentException(String.format("Unknown button '%s' on project overview page", button));
        }
    }

    @When("{I |}click publish button on project '$projectName' Overview page")
    public void clickPublishButton(String projectName) {
        openProjectOverviewPage(projectName);
        getSut().getPageCreator().getProjectOverviewPage().clickPublishButton();
    }

    @When("I click '$option' button on opened publish project pop-up")
    public void clickNotifyButton(String button) {
          AdbankProjectOverviewPage page = getSut().getPageCreator().getProjectOverviewPage();
        if (button.equalsIgnoreCase("notify")) {
            new PublishProjectPopup(page).clickNotifyButton();
        } else if (button.equalsIgnoreCase("Do not notify")) {
            new PublishProjectPopup(page).clickDoNotNotifyButton();
        } else {
            throw new IllegalArgumentException(String.format("Unknown button '%s' for publish project popup", button));
        }
    }

    @Given("I am on the Project Trash page for project '$projectName'")
    @When("I go to the Project Trash page for project '$projectName'")
    public void goToTheProjectTrashPage(String projectName) {
        Common.sleep(1000);
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        getSut().getPageNavigator().getProjectTrashPage(project.getId(), "");
    }


    @Given("{I |}clicked Edit '$option' Selected link from More drop down from project folder page and fill with below data for '$fileCount' files: $data")
    @When("{I |}click Edit '$option' Selected link from More drop down from project folder page and fill with below data for '$fileCount' files: $data")
    public void openEditAllSelectedPopUp(String option,int fileCount,ExamplesTable data){
        AdbankProjectFilesPage page = getSut().getPageCreator().getProjectFilesPage();
        page.clickMoreButton();
        if(option.equalsIgnoreCase("All")){
        page.clickEditAllSelectedFromMoreDropDown();
        }else if(option.equalsIgnoreCase("One by one")){
            page.clickEditOneByOneSelectedFromMoreDropDown();
        }
        EditFilePopup popup = new EditFilePopup(page);
        popup.fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));
        if(option.equalsIgnoreCase("One by one")){
            for(int i=1;i<fileCount;i++){
                if(popup.isNextButtonVisible()){
                    getSut().getWebDriver().findElement(popup.getNextButtonLocator()).click();
                    Common.sleep(2000);
                    popup.fillEditFilePopup(wrapMetadataFields(data, "FieldName", "FieldValue"));
                }
            }
        }
        popup.save();
    }


    @Given("{I |}clicked Edit Usage Rights button from More drop down from project folder page")
    @When("{I |}click Edit Usage Rights button from More drop down from project folder page")
    public AdbankBatchUsageRightEditPopUp openEditUsageRightsPopUp(){
        AdbankProjectFilesPage page = getSut().getPageCreator().getProjectFilesPage();
        page.clickMoreButton();
        page.clickEditUsageRightsButtonFromMoreDropDown();
        return new AdbankBatchUsageRightEditPopUp(page);
    }


    @Given("{I |}added Batch Usage Right '$usageRule' with following fields on opened Edit Usage Rights pop-up from project folder page: $data")
    @When("{I |}add Batch Usage Right '$usageRule' with following fields on opened Edit Usage Rights pop-up from project folder page: $data")
    public void addUsageRightOnOpenedAssetUsageRightsPage(String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());
        AdbankBatchUsageRightEditPopUp popup = openEditUsageRightsPopUp();
        popup.clickOkOnConfirmationDialog();
        popup.openTabOnAdbankBatchUsageRightEditPopUp(usageRule);
        for (Map<String, String> row : parametrizeTableRows(data)) {
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

            // popup.action.click();
            popup.clickOnSave();

            Common.sleep(2000);
        }
    }

    @When("{I |}'$action' file '$fileName' from project files page")
    public void deleteSelectedFiles(String action, String fileName) {
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        adbankProjectFilesPage.selectFileByFileName(fileName);
        adbankProjectFilesPage.clickMoreButton();
        adbankProjectFilesPage.clickDeleteMenuItem();
        if (action.equalsIgnoreCase("delete")) {
            adbankProjectFilesPage.clickDeleteButtonOnPopupWindow();
        } else if (action.equalsIgnoreCase("cancel delete")) {
            adbankProjectFilesPage.clickCancelButtonOnPopupWindow();
        } else if (action.equalsIgnoreCase("cross delete")) {
            adbankProjectFilesPage.clickCrossButtonOnPopupWindow();
        } else {
            Assert.fail("Parameter action is undefine. It must be one of them:\ndelete\ncancel delete\ncross delete");
        }
        Common.sleep(500);
    }

    @Given("I clicked move button on project files page")
    @When("I click move button on project files page")
    public void clickMoveButton() {
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        adbankProjectFilesPage.clickMoreButton();
        adbankProjectFilesPage.clickMoveMenuItem();
    }

    @Then("{I |}'$shouldState' see active options '$optionsList' in More drop down menu on project files page")
    public void checkMoreOptions(String shouldState, String optionsList) {
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        for (String option : optionsList.split(","))
            assertThat("Check is option " + option + " active: ", adbankProjectFilesPage.isActiveMoreMenuOption(option), is(shouldState.equals("should")));
    }



    @Given("{I |}clicked Send for Approval button in More dropdown on project files page")
    @When("{I |}click Send for Approval button in More dropdown on project files page")
    public void clickSendForApprovalButton() {
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        adbankProjectFilesPage.clickMoreButton();
        adbankProjectFilesPage.clickSendForApprovalItem();
    }
    @Given("{I |}clicked Create new approval on Submit files for approval popup")
    @When("{I |}click Create new approval on Submit files for approval popup")
    public void clickCreateNewApproval() {
        new SendForApprovalPopUp(getSut().getPageCreator().getProjectFilesPage()).clickCreateNewApproval();
    }

    @When("{I |}click Apply a template on Submit files for approval popup")
    public void clickApplyTemplate() {
        new SendForApprovalPopUp(getSut().getPageCreator().getProjectFilesPage()).clickApplyTemplate();
    }

    @When("{I |}click Apply Template button on opened select approval template popup")
    public void clickApplyTemplateOnOpenedSelectApprovalTemplatePopup() {
        new SelectApprovalTemplatePopup(getSut().getPageCreator().getProjectFilesPage()).action.click();
        Common.sleep(2000);
    }

    @Given("{I |}selected approval template '$templateName' on opened select approval template popup")
    @When("{I |}select approval template '$templateName' on opened select approval template popup")
    public void applyApprovalTemplate(String templateName) {
        new SelectApprovalTemplatePopup(getSut().getPageCreator().getProjectFilesPage()).selectTemplate(wrapVariableWithTestSession(templateName));
    }

    @Given("I clicked copy button on project files page")
    @When("I click copy button on project files page")
    public void clickCopyButton() {
        super.clickCopyButton();
    }

    @Given("{I |}clicked on Want to move files to another project link on move/copy file '$fileName' popup")
    @When("{I |}click on Want to move files to another project link on move/copy file '$fileName' popup")
    public void clickWantToMoveFilesToAnotherProjectLinkOnMoveFilePopup(String fileName) {
        AdbankProjectFilesPage page = getSut().getPageCreator().getProjectFilesPage();
        String[] fileArray = fileName.split(",");
        for (String fN : fileArray) page.selectFileByFileName(fN);
        page.clickMoreButton();
        MoveCopyPopUpWindow moveCopyPopUpWindow = page.clickMoveMenuItem();
        moveCopyPopUpWindow.clickWantToMoveFilesToAnotherProjectLink();
    }

    @Given("{I |}clicked on Want to move files to another project link on move/copy file '$fileName' popup for '$localeMore' locale users")
    @When("{I |}click on Want to move files to another project link on move/copy file '$fileName' popup for '$localeMore' locale users")
    public void clickWantToMoveFilesToAnotherProjectLinkOnMoveFilePopup(String fileName,String localeMore) {
        AdbankProjectFilesPage page = getSut().getPageCreator().getProjectFilesPage();
        String[] fileArray = fileName.split(",");
        for (String fN : fileArray) page.selectFileByFileName(fN);
        page.clickMoreButtonforOtherLocale();
        MoveCopyPopUpWindow moveCopyPopUpWindow = page.clickMoveMenuItemforOtherLocale(localeMore);
        moveCopyPopUpWindow.clickWantToMoveFilesToAnotherProjectLinkforOtherLocale(localeMore);
    }
    @Given("{I |}clicked on Want to copy files to another project link on move/copy file '$fileName' popup")
    @When("{I |}click on Want to copy files to another project link on move/copy file '$fileName' popup")
    public void clickWantToCopyFilesToAnotherProjectLinkOnMoveFilePopup(String fileName) {
        super.clickWantToCopyFilesToAnotherProjectLinkOnMoveFilePopup(fileName);
    }

    @Given("{I |}copy '$fileName' file into '$pathTo' folder from folder '$pathFrom' for '$projectName' project")
    @When("{I |}copy the '$fileName' file into '$pathTo' folder from folder '$pathFrom' for '$projectName' project")
    public void copyFileToProjectsFolder(String fileName, String pathTo, String pathFrom, String projectName) {
        copyFile(fileName, pathTo, pathFrom, projectName);
    }

    @Given("{I |}moved '$fileName' file into '$pathTo' folder from folder '$pathFrom' for '$projectName' project")
    @When("{I |}move '$fileName' file into '$pathTo' folder from folder '$pathFrom' for '$projectName' project")
    public void moveFileToProjectsFolder(String fileName, String pathTo, String pathFrom, String projectName) {
        moveFile(fileName, pathTo, pathFrom, projectName);
    }

    @Given("I clicked on Want to move files to another project link")
    public void clickWantToMoveFilesToAnotherProjectLinkOnMoveFilePopup() {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        moveCopyPopUpWindow.clickWantToMoveFilesToAnotherProjectLink();
    }

    @Given("{I |}moved folder '$movedFolder' in folder '$parentFolder' in project '$projectName'")
    @When("{I |}move folder '$copiedFolder' in folder '$parentFolder' in project '$projectName'")
    public void moveFolderToAnotherFolderInWorkRequest(String movedFolder, String parentFolder, String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        String copiedFolderId = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapVariableWithTestSession(movedFolder)).getId();
        String parentFolderId = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapVariableWithTestSession(parentFolder)).getId();

        getCoreApi().moveFolder(Arrays.asList(copiedFolderId), parentFolderId, true);
    }

    @Given("{I |}moved folder '$movedFolder' from project '$project' into folder '$parentFolder' in project '$projectName' with '$isUpdate' metadata")
    @When("{I |}move folder '$movedFolder' from project '$project' into folder '$parentFolder' in project '$projectName' with '$isUpdate' metadata")
    public void moveFolderToAnotherFolderInAnotherProject(String movedFolder, String fromProject, String parentFolder, String inProject, String isUpdate) {
        Project basicProject = getObjectByName(wrapVariableWithTestSession(fromProject));
        String copiedFolderId = getCoreApi(basicProject.getCreatedBy()).getFolderByPath(basicProject.getId(), wrapVariableWithTestSession(movedFolder)).getId();
        Project destinationProject = getObjectByName(wrapVariableWithTestSession(inProject));
        String parentFolderId = getCoreApi(destinationProject.getCreatedBy()).getFolderByPath(destinationProject.getId(), wrapVariableWithTestSession(parentFolder)).getId();
        boolean isUpdateMetadata = isUpdate.equalsIgnoreCase("update");

        getCoreApi().moveFolder(Arrays.asList(copiedFolderId), parentFolderId, isUpdateMetadata);
    }

    @Given("{I |}copied folder '$copiedFolder' from project '$project' into folder '$parentFolder' in project '$projectName'")
    @When("{I |}copy folder '$copiedFolder' from project '$project' into folder '$parentFolder' in project '$projectName'")
    public void copyFolderToAnotherFolderInAnotherProject(String copiedFolder, String fromProject, String parentFolder, String inProject) {
        Project basicProject = getObjectByName(wrapVariableWithTestSession(fromProject));
        String copiedFolderId = getCoreApi(basicProject.getCreatedBy()).getFolderByPath(basicProject.getId(), wrapVariableWithTestSession(copiedFolder)).getId();
        Project destinationProject = getObjectByName(wrapVariableWithTestSession(inProject));
        String parentFolderId = getCoreApi(destinationProject.getCreatedBy()).getFolderByPath(destinationProject.getId(), wrapVariableWithTestSession(parentFolder)).getId();

        getCoreApi().copyFolder(Arrays.asList(copiedFolderId), parentFolderId, true);
    }

    @Given("{I |}copied folder '$folderTarget' from project '$projectTarget' into project '$destanationProject' in root")
    @When("{I |}copy folder '$folderTarget' from project '$projectTarget' into project '$destanationProject' in root")
    public void copyFolderToProjectRoot(String folderTarget, String projectTarget, String destanationProject) {
        Project basicProject = getObjectByName(wrapVariableWithTestSession(projectTarget));
        String folderTargetId = getCoreApi(basicProject.getCreatedBy()).getFolderByPath(basicProject.getId(), wrapVariableWithTestSession(folderTarget)).getId();
        String destinationProjectId = getObjectByName(wrapVariableWithTestSession(destanationProject)).getFolders().get(0).getId();

        getCoreApi().copyFolder(Arrays.asList(folderTargetId), destinationProjectId, true);
    }

    @Given("I clicked on Want to copy files to another project link")
    public void clickWantToCopyFilesToAnotherProjectLinkOnMoveFilePopup() {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        moveCopyPopUpWindow.clickWantToCopyFilesToAnotherProjectLink();
    }

    @When("I type '$text' in search field on move/copy file popup")
    public void typeSearchTextOnMoveCopyFilePopup(String text) {
        super.typeSearchTextOnMoveCopyFilePopup(text);
    }

    @Given("{I |}entered '$projectName' in search field on move/copy file popup")
    @When("{I |}enter '$projectName' in search field on move/copy file popup")
    public void enterSearchTextOnMoveCopyFilePopup(String projectName) {
        super.enterSearchTextOnMoveCopyFilePopup(projectName);
    }

    @When("I select project '$project' on move/copy file popup")
    public void selectProjectFromDropdownList(String project) {
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(adbankProjectFilesPage);
        List<WebElement> list = moveCopyPopUpWindow.getAvailableForSearchProjectsList();
        for (WebElement webElement : list) {
            if (webElement.getText().equalsIgnoreCase(wrapVariableWithTestSession(project))) {
                webElement.click();
                return;
            }
        }
    }

    @Given("{I |}selected folder '$folderName' on move/copy file popup")
    @When("{I |}select folder '$folderName' on move/copy file popup")
    public void selectFolderOnMoveCopyFilePopup(String folderName) {
        if (folderName.replaceAll("/", "").isEmpty()) return;
        MoveCopyPopUpWindow popup = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        if(!popup.isFoldersTreeVisible()) {
            popup.clickRootFolder();
        }
        String[] folderArray = folderName.split("/");
        int size = folderArray.length - 1;
        int counter = 1;
        for (String folder : folderArray) {
            if (folder.isEmpty()) continue;
            folder = wrapVariableWithTestSession(folder);
            popup.clickArrowElementByFolderNameWithCheckActivity(folder, counter);
            Common.sleep(1000);
            if (counter < size) counter++;
        }
        String needFolder = folderArray[folderArray.length - 1];
        needFolder = wrapVariableWithTestSession(needFolder);
        Common.sleep(1000);
        popup.clickByFolderElementOnTreeContainerByLink(needFolder);
    }

    @When("I click cancel link on move/copy files popup")
    public void clickCancelLink() {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        moveCopyPopUpWindow.clickCancelLink();
    }

    @When("I click close button on move/copy files popup")
    public void clickCloseButton() {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        moveCopyPopUpWindow.clickCloseButton();
    }

    @Given("{I |}clicked move button on move/copy files popup")
    @When("{I |}click move button on move/copy files popup")
    public void clickMoveButtonOnMoveCopyFilesPopup() {
        AdbankProjectFilesPage page = getSut().getPageCreator().getProjectFilesPage();
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        moveCopyPopUpWindow.clickMoveCopyButton();
        Common.sleep(1000);
        ConfirmationPopup confirmation = new ConfirmationPopup(page);
        if (confirmation.isPresentOnPage() && confirmation.isClickYesButtonVisible()) {
            confirmation.clickYesButton();
        }
    }

    @Given("{I |}waited untill move/copy files popup will be closed")
    @When("{I |}wait untill move/copy files popup will be closed")
    public void waitUntilMoveCopyPopUpWillbeClosed(){
        AdbankProjectFilesPage page = getSut().getPageCreator().getProjectFilesPage();
        page.waitUntillCopyMovePopUpWillBeClosed();
    }

    @Given("{I |}clicked copy button on move/copy files popup")
    @When("{I |}click copy button on move/copy files popup")
    public void clickCopyButtonOnMoveCopyFilesPopup() {
        AdbankProjectFilesPage page = getSut().getPageCreator().getProjectFilesPage();
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(page);
        moveCopyPopUpWindow.clickMoveCopyButton();
        Common.sleep(1000);
        ConfirmationPopup confirmation = new ConfirmationPopup(page);
        if (confirmation.isPresentOnPage() && confirmation.isClickYesButtonVisible()) {
            confirmation.clickYesButton();
        }
    }

    @When("I delete all files from project '$projectName' folder '$path' files page")
    public void deleteAllFilesFromProjectFilesPage(String projectName, String path) {
        deleteAllFilesFromFilesPage(projectName, path);
    }

    @When("I create sub folder '$subFolderName' in folder '$path' in project '$projectName' using button NewFolder")
    public void createFolderWithNewFolderButton(String subFolderName, String path, String projectName) {
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageNavigator().getProjectFilesPage(project.getId(), "");
        selectFolder(path, projectName).click();
        getSut().getWebDriver().navigate().refresh();
        NewEditFolderPopUpWindow newEditFolderPopUpWindow = adbankProjectFilesPage.clickNewFolderButton();
        newEditFolderPopUpWindow.setFolderName(wrapVariableWithTestSession(subFolderName)).clickAction();
    }

    @When("{I |}copy folder '$copiedFolder' in folder '$parentFolder' in project '$projectName'")
    public void createFolderCopy(String copiedFolder, String parentFolder, String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        String copiedFolderId = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapVariableWithTestSession(copiedFolder)).getId();
        String parentFolderId = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapVariableWithTestSession(parentFolder)).getId();

        getCoreApi().copyFolder(Arrays.asList(copiedFolderId), parentFolderId, false);
    }

    @When("{I |}open pop up menu of folder '$path' on project '$projectName' overview page")
    public void openPopUpMenuOverviewPage(String path , String projectName) {
        openFoldersMenuOverviewPage(path, projectName);
    }

    @When("I open pop up menu of folder '$path' on project '$projectName' files page")
    public void openPopUpMenu(String path , String projectName) {
        openFoldersMenu(path, projectName);
    }

    @When(value = "{I |}create '$path' folder in '$projectName' project", priority = 1)
    public void createProjectFolder(String path, String projectName) {
        createFolder(path, projectName);
    }

    @When("I create '$path' folder in '$projectName' project using nverge api")
    public void createProjectFolderNVerge(String path, String projectName) {
        path = wrapPathWithTestSession(normalizePath(path));
        projectName = wrapVariableWithTestSession(projectName);
        LuceneSearchingParams query = new LuceneSearchingParams().setQuery(projectName).setResultsOnPage(10).setPageNumber(1);
        List<Project> projects = getNVergeApi().findProjects(query).getResult();
        String projectId = projects.get(0).getId();
        getNVergeApi().createFolderRecursive(path, projectId, projectId);
    }

    @Given("{I |}deleted folder '$path' in project '$projectName'")
    @When("{I |}delete folder '$path' in project '$projectName'")
    public void deleteProjectFolder(String path, String projectName) {
        deleteFolder(projectName, path);
    }

    @When(value = "{I |}delete folder '$path' in project '$projectName' with action '$action'", priority = 1)
    public void deleteProjectFolderCancelOrCross(String path, String projectName, String action) {
        if (action.equalsIgnoreCase("cross")) {
            crossDeleteFolder(projectName, path);
        } else if (action.equalsIgnoreCase("cancel")) {
            cancelDeleteFolder(projectName, path);
        }
    }

    @Given("{I |}deleted file '$fileName' in project '$projectName' folder '$path'")
    @When("{I |}delete file '$fileName' in project '$projectName' folder '$path'")
    public void deleteProjectFile(String fileName, String projectName, String path) {
        deleteFile(projectName, path, fileName);
    }

    @When("I create '$count' folders in folder '$path' for project '$projectName'")
    public void createProjectFolders(int count, String path, String projectName) {
        createFolders(count, path, projectName);
    }

    @Given("{I |}renamed folder '$path' to '$newName' in '$projectName' project")
    @When("{I |}rename folder '$path' to '$newName' in '$projectName' project")
    public void renameProjectFolder(String path, String newName, String projectName) {
        renameFolder(path, newName, projectName);
    }

    @When("{I |}rename folder '$path' to '$newName' on project '$projectName' overview page")
    public void renameProjectOverviewFolder(String path, String newName, String projectName) {
        renameFolderOnOverviewPage(path, newName, projectName);
    }

    @When("I cancel creating '$path' in '$projectName' project")
    public void cancelProjectCreatingFolder(String path, String projectName) {
        cancelCreatingFolder(path, projectName);
    }

    @When("I close window of folder creating  '$path' in '$projectName' project")
    public void closeWindowProjectCreatingFolder(String path, String projectName) {
        closeWindowCreatingFolder(path, projectName);
    }

    // | File |
    @When("{I |}add to jumploader in folder '$path' of project '$projectName' following files: $filesTable")
    public void addProjectFilesForUpload(String path, String projectName, ExamplesTable filesTable) {
        addFilesForUpload(path, projectName, filesTable);
    }

    @When("{I |}start jumploader upload in folder '$path' of project '$projectName' and '$waitState' for finish")
    public void startUpload(String path, String projectName, String waitState) {
        startJumploaderUpload(path, projectName, waitState);
    }

    @When("{I |}stop jumploader upload in folder '$path' of project '$projectName' after '$bytesUploaded' bytes uploaded")
    public void stopUpload(String path, String projectName, long bytesUploaded) {
        stopJumploaderUpload(path, projectName, bytesUploaded);
    }

    @When("{I |}resume jumploader upload in folder '$path' of project '$projectName' and '$waitState' for finish")
    public void resumeUpload(String path, String projectName, String waitState) {
        resumeJumploaderUpload(path, projectName, waitState);
    }




    @When("{I |}remove file index '$index' from jumploader in folder '$path' of project '$projectName'")
    public void removeProjectFileFromJumploader(int index, String path, String projectName) {
        removeFileFromJumploader(index, path, projectName);
    }

    @When("{I |}remove all files from jumploader in folder '$path' of project '$projectName'")
    public void removeProjectFilesFromJumploader(String path, String projectName) {
        removeFilesFromJumploader(path, projectName);
    }

    @When("{I |}type folder name '$folderName' in search folders field in project '$projectName' folder '$path'")
    public void typeFolderNameInElement(String folderName, String projectName, String path) {
        typeFolderName(folderName, projectName, path);
    }

    @Given("{I |}waited while file '$fileName' fully uploaded to folder folder '$path' of project '$projectName'")
    @When("{I |}wait while file '$fileName' fully uploaded to folder folder '$path' of project '$projectName'")
    public void waitForProjectFileUploadingFinished(String fileName, String path, String projectName) {
        waitForFileAvailableInDatabase(projectName, path, fileName);
    }

    //To wait until transcoding is fully finished please user 'waited while preview is available' steps
    @Given("{I |}waited while transcoding is finished in folder '$path' on project '$projectName' files page")
    @When("{I |}wait while transcoding is finished in folder '$path' on project '$projectName' files page")
    public void waitForProjectFilesTranscodingFinished(String path, String projectName) {
        waitForSpecAvailable(projectName, path);
    }

    @Given("{I |}waited while preview is available in folder '$path' on project '$projectName' files page")
    @When("{I |}wait while preview is available in folder '$path' on project '$projectName' files page")
    public void waitForProjectFilesPreviewAvailable(String path, String projectName) {
        waitForPreviewAvailable(projectName, path);
    }

    @Given("{I |}waited while preview is available in subfolder '$path' on project '$projectName' files page by User '$userName'")
    @When("{I |}wait while preview is available in  subfolder '$path' on project '$projectName' files page by User '$userName'")
    public void waitForProjectFilesPreviewAvailableInSubFolder(String path, String projectName,String userName) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        waitForPreviewAvailableForClientUsers(projectName, path, user.getEmail());
    }

    @Given("{I |}waited while preview is available in folder '$path' on project '$projectName' files page for client User '$email'")
    @When("{I |}wait while preview is available in folder '$path' on project '$projectName' files page for Client User '$email'")
    public void waitForProjectFilesPreviewAvailableForClientUsers(String path, String projectName,String email) {
        waitForPreviewAvailableForClientUsers(projectName, path, email);
    }

    // | Folder |
    @Given("{I |}waited while preview is available in folder the following folders on project '$projectName' files page: $foldersTable")
    @When("{I |}wait while preview is available in folder the following folders on project '$projectName' files page: $foldersTable")
    public void waitForProjectFilesPreviewAvailable(String projectName, ExamplesTable foldersTable) {
        for (String path : getParametrizedTableColumn(foldersTable, "Folder"))
            waitForPreviewAvailable(projectName, path);
    }

    @Given("{I |}waited while transcoding is finished on project '$projectName' in folder '$path' for '$fileName' file")
    @When("{I |}wait while transcoding is finished on project '$projectName' in folder '$path' for '$fileName' file")
    public void waitForProjectFileTranscodingFinished(String projectName, String path, String fileName) {
        waitForProjectFileTranscodingFinished(projectName, path, fileName, -1);
    }

    @Given("{I |}waited while preview is visible on project '$projectName' in folder '$path' for '$fileName' file")
    @When("{I |}wait while preview is visible on project '$projectName' in folder '$path' for '$fileName' file")
    public void waitForProjectFilePreviewAvailable(String projectName, String path, String fileName) {
        waitForProjectFilePreviewAvailable(projectName, path, fileName, -1);
    }

    @Given("{I |}waited while transcoding is finished on project '$projectName' in folder '$path' for '$fileName' file revision '$revision'")
    @When("{I |}wait while transcoding is finished on project '$projectName' in folder '$path' for '$fileName' file revision '$revision'")
    public void waitForProjectFileTranscodingFinished(String projectName, String path, String fileName, int revision) {
        waitForFileSpecAvailableInSpecificRevision(projectName, path, fileName, revision);
    }

    @Given("{I |}waited while preview is visible on project '$projectName' in folder '$path' for '$fileName' file revision '$revision'")
    @When("{I |}wait while preview is visible on project '$projectName' in folder '$path' for '$fileName' file revision '$revision'")
    public void waitForProjectFilePreviewAvailable(String projectName, String path, String fileName, int revision) {
        waitForFilePreviewAvailableInSpecificRevision(projectName, path, fileName, revision);
    }

    @When("{I |}set media subtype '$mediaSubType' for file '$fileName' in folder '$path' of project '$projectName'")
    public void setProjectMediaSubType(String mediaSubType, String fileName, String path, String projectName) {
        setMediaSubType(mediaSubType, fileName, path, projectName);
    }

    // | Path | FileName | SubType |
    @When("{I |}set media subtype for following files in project '$projectName': $filesTable")
    public void setProjectMediaSubType(String projectName, ExamplesTable filesTable) {
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            setMediaSubType(row.get("SubType"), row.get("FileName"), row.get("Path"), projectName);
        }
    }

    @When("{I |}set title '$title' for file '$fileName' in folder '$path' of project '$projectName'")
    public void setProjectFileTitle(String title, String fileName, String path, String projectName) {
        setFileTitle(title, fileName, path, projectName);
    }

    @Given("{I |}opened Share window from popup menu for folder '$path' on project '$projectName'")
    @When("{I |}open Share window from popup menu for folder '$path' on project '$projectName'")
    public void openFoldersPopUpMenu(String path, String projectName) {
        openShareFromPopUp(path, projectName);

    }

    @Given("{I |}opened Share window from popup menu for folder '$path' on client project '$projectName'")
    @When("{I |}open Share window from popup menu for folder '$path' on client project '$projectName'")
    public void openFoldersPopUpMenuForClientProject(String path, String projectName) {
        openShareFromPopUpForClientUsers(path, projectName);

    }

    @When("{I |}click Download By Sendplus from context menu for folder '$path' on project '$projectName'")
    public void downloadBySendplusFromFolderPopup(String path, String projectName) {
        downloadBySendplusFromPopUpAtFolder(path, projectName);
    }

    @When("{I |}click Download By Sendplus from context menu for project '$path' on project '$projectName'")
    public void downloadBySendplusFromProjectPopup(String path, String projectName) {
        downloadBySendplusFromPopUpAtProject(path, projectName);
    }

    @When("{I |}open Share window using 'Share' button for folder '$path' on files page of project '$projectName'")
    public void openShareUsingShareButton(String path, String projectName){
        this.openProjectFolderPage(projectName, path);
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        adbankProjectFilesPage.clickShareFolderButton();
    }

    @When("{I |}open Share window using 'Share' button for current on opened files page")
    public void clickShareUsingShareButton(){
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        adbankProjectFilesPage.clickShareFolderButton();
    }


    @When("{I |}download using '$downloadOption' on project files page")
    public void clickDownloadButtonAtTopMenu(String downloadOption){
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        if(downloadOption.contains("Download Project by Sendplus")) {
            adbankProjectFilesPage.clickDownloadByProject();
        }
        else if(downloadOption.contains("Download Folder by Sendplus"))  {
            adbankProjectFilesPage.clickDownloadByFolder();
        }
    }

    @Given("{I |}opened uploaded file '$fileName' in folder '$path' project '$projectName'")
    @When("{I |}open uploaded file '$fileName' in folder '$path' project '$projectName'")
    public void openFile(String fileName, String path, String projectName) {
        openUploadedFile(fileName, path, projectName);
    }

    // enabledFilters comma separated
    // possible values: IMAGE, AUDIO, VIDEO, PRINT, DIGITAL
    @When("{I |}select media type filters '$enabledFilters' on project '$projectName' folder '$path' page")
    public void enableProjectMediaTypeFilter(String enabledFilters, String projectName, String path) {
        enableMediaTypeFilter(projectName, path, enabledFilters);
    }

    @When("{I |}select media subtype filter '$mediaSubType' on project '$projectName' folder '$path' page")
    public void selectProjectMediaSubType(String mediaSubType, String projectName, String path) {
        selectMediaSubTypeFilter(projectName, path, mediaSubType);
    }


    @Given("{I |}moved file '$fileName' from project '$projectName' folder '$path' to library page")
    @When("{I |}move file '$fileName' from project '$projectName' folder '$path' to library page")
    public void moveFileToLibrary(String fileName, String projectName, String path) {
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path));
        AdbankProjectFilesPage page = getSut().getPageNavigator().getProjectFilesPage(project.getId(), folder.getId());
        page.selectFileByFileName(fileName).clickMoreButton().clickSendToLibraryMenuItem().clickSaveBtn();
    }


    @Given("{I |}moved file '$fileName' from project '$projectName' folder '$path' to new library page")
    @When("{I |}move file '$fileName' from project '$projectName' folder '$path' to new library page")
    public void moveFileToLibraryNewLibrary(String fileName, String projectName, String path) {
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path));
        AdbankProjectFilesPage page = getSut().getPageNavigator().getProjectFilesPage(project.getId(), folder.getId());
        page.selectFileByFileName(fileName).clickMoreButton().clickSendToLibraryMenuItem().clickSaveBtnNewLib();
    }

    @Given("{I |}moved following files '$fileName' from project '$projectName' folder '$path' to library page")
    @When("{I |}move following files '$fileName' from project '$projectName' folder '$path' to library page")
    public void moveMultiplyFilesToLibrary(String fileName, String projectName, String path) {
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path));
        AdbankProjectFilesPage page = getSut().getPageNavigator().getProjectFilesPage(project.getId(), folder.getId());

        for (String file : fileName.split(",")) {
            page.selectFileByFileName(file);
        }

        page.clickMoreButton().clickSendToLibraryMenuItem().clickSaveBtn();

    }

    @Given("{I |}moved following files '$fileName' from project '$projectName' folder '$path' to new library page")
    @When("{I |}move following files '$fileName' from project '$projectName' folder '$path' to new library page")
    public void moveMultiplyFilesToNewLibrary(String fileName, String projectName, String path) {
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path));
        AdbankProjectFilesPage page = getSut().getPageNavigator().getProjectFilesPage(project.getId(), folder.getId());

        for (String file : fileName.split(",")) {
            page.selectFileByFileName(file);
        }

        page.clickMoreButton().clickSendToLibraryMenuItem().clickSaveBtnNewLib();

    }
    // | Title | Media Type | Sub Media Type | Duration | Width | Height | Screen | File Type | File Size |
    @When("{I |}fill following data on add file to library page: $fieldsTable")
    public void fillAddFileToLibraryPage(ExamplesTable fieldsTable) {
        Map<String, String> fields = parametrizeTabularRow(fieldsTable);
        for (Map.Entry<String, String> entry : fields.entrySet()) {
            if (entry.getKey().equals("ID")) fields.put("ID", wrapVariableWithTestSession(entry.getValue()));
            if (entry.getKey().equals("Client")) fields.put("Client", getData().getAgencyByName(entry.getValue()).getName());
            if (entry.getKey().equals("Advertiser")) fields.put("Advertiser", wrapVariableWithTestSession(entry.getValue()));
            if (entry.getKey().equals("Brand")) fields.put("Brand", wrapVariableWithTestSession(entry.getValue()));
            if (entry.getKey().equals("Sub Brand")) fields.put("Sub Brand", wrapVariableWithTestSession(entry.getValue()));
            if (entry.getKey().equals("Product")) fields.put("Product", wrapVariableWithTestSession(entry.getValue()));
        }
        getAddFileToLibraryPage().fill(fields);
    }

    @When("{I |}fill add file to library page with ID '$id'")
    public void fillAddFileToLibraryPageWithMandatoryFields(String id) {
        Map<String, String> fields = new HashMap<>();
        fields.put("ID", wrapVariableWithTestSession(id));
        getAddFileToLibraryPage().fill(fields);
    }

    @When("{I |}fill add file to library page with Advertiser '$advertiser' and clock number '$clockNumber'")
    public void fillAddFileToLibraryPageMandatoryFields(String advertiser, String clockNumber) {

        Map<String, String> fields = new HashMap<>();
        fields.put("Advertiser", wrapVariableWithTestSession(advertiser));
        fields.put("Clock number", clockNumber);
        getAddFileToLibraryPage().fill(fields);
    }

    @When("{I |}fill add file to library page with ID '$id' and Product '$product'")
    public void fillIDandProductAddFileToLibraryPageFields(String id, String product) {
        AdbankAddFileToLibraryPage page = getAddFileToLibraryPage();
        page.setId(id);
        product = wrapVariableWithTestSession(product);
        page.selectProduct(product);
    }

    @When("{I |}click Save button on Add file to library page")
    public void clickSaveBtn(){
        AdbankAddFileToLibraryPage addFileToLibraryPage = getAddFileToLibraryPage();
        addFileToLibraryPage.clickSaveBtn();
    }

    @When("{I |}click Save button on Add file to new library page")
    public void clickSaveBtnNewLib(){
        AdbankAddFileToLibraryPage addFileToLibraryPage = getAddFileToLibraryPage();
        addFileToLibraryPage.clickSaveBtnNewLib();
    }

    @When("{I |}generate auto code value on New Assets form")
    public void generateAutoCodeWhileSendFileToLibrary() {
        getAddFileToLibraryPage().generateAutoCode();
    }

    @When("I search in the '$searchType' next file '$fileName' for project '$templateName' folder '$folderName'")
    public void searchFileInTheCurrentSearchType(String searchType, String fileName, String templateName, String folderName) {
        searchFile(templateName, folderName, searchType, fileName);
    }

    @When("I click show all results link for current project")
    public void showAllResults() {
        clickShowAllResults();
    }

    @When("{I |}changing title of file '$filePath' to following title '$fileTitleNew' on project '$projectName' folder '$path' page")
    public void changeFileTitleProjectFilesPage(String filePath, String fileTitleNew, String projectName, String path) {
        updateFileContent(filePath, fileTitleNew, projectName, path);
    }

    @When("{I |}click on user '$userName' in project '$projectName' overview activities")
    public void clickUserInProjectActivities(String userName, String projectName) {
        clickUserInActivities(projectName, userName);
    }

    @When("{I |}click on file '$fileName' in project '$projectName' overview activities")
    public void clickFileInProjectActivities(String fileName, String projectName) {
        clickFileInActivities(projectName, fileName);
    }

    @When("{I |}scroll to the and files carousel on project '$projectName' overview page")
    public void scrollFilesCarousel(String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectOverviewPage page = (AdbankProjectOverviewPage) getFoldersTree(project.getId(), null);
        page.getFilesCarousel().loadAllFiles();
    }

    @When("{I |}send file '$fileName' on project '$projectName' folder '$path' page to Library")
    public void sendProjectsFileToLibrary(String fileName, String projectName, String path) {
        sendFileToLibrary(fileName, projectName, path);
    }
   //!--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Starts
    @When("{I |} click send file '$fileName' on project '$projectName' folder '$path' page to Library")
    public void clickSendProjectsFileToLibrary(String fileName, String projectName, String path) {
        sendFileToLibraryButton(fileName, projectName, path);
    }
  //  !--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Ends
    @When("{I |}click Send to Delivery for following files '$fileNamesList' on project '$projectName' folder '$path' page")
    public void clickSendToDeliveryForFiles(String fileNamesList, String projectName, String path) {
        clickSendToDelivery(fileNamesList, projectName, path);
    }

    @When("{I |}send following files '$fileNamesList' on project '$projectName' folder '$path' page to Delivery")
    public void sendProjectsFilesToDelivery(String fileNamesList, String projectName, String path) {
        sendFilesToDelivery(fileNamesList, projectName, path);
    }

    @Given("{I |}added agency project team '$aptName' into folder '$folderName' in the project '$projectName'")
    @When("{I |}add agency project team '$aptName' into folder '$folderName' in the project '$projectName'")
    public void addAPTIntoProjectFolder(String aptName, String folderName, String projectName) {
        addAPTOntoFolder(aptName, folderName, projectName);
    }

    @Given("{I |}switched tab to '$tabName' on opened Share files popup")
    @When("{I |}switch tab to '$tabName' on opened Share files popup")
    public void switchTabOnShareFilesPopup(String tabName) {
        if (tabName.equalsIgnoreCase("Share")) {
            new ShareFilesPopup(getFilesPage()).selectStareTab();
        } else if (tabName.equalsIgnoreCase("Secure Shares")) {
            new ShareFilesPopup(getFilesPage()).selectSecureSharesTab();
        } else if (tabName.equalsIgnoreCase("Public share")) {
            new ShareFilesPopup(getFilesPage()).selectPublicShareTab();
        } else {
            throw new IllegalArgumentException(String.format("Unknown tab name: '%s' on opened Share files popup", tabName));
        }
    }

    @When("{I |}open public url for file '$fileName' in folder '$path' and project '$projectName'")
    public void openPublicUrlForFile(String fileName, String path, String projectName) {
        Project object = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        AdbankFilesPage page = getFilesPage(object.getId(), folder.getId());
        page.selectFileByFileName(fileName);
        page.clickShareFilesButton().selectPublicShareTab();

        openPublicUrlForFile();
    }


    @When("{I |}open public share for file '$fileName' in folder '$path' and project '$projectName'")
    public void openPublicShareForFile(String fileName, String path, String projectName) {
        Project object = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        AdbankFilesPage page = getFilesPage(object.getId(), folder.getId());
        page.selectFileByFileName(fileName);
        page.clickShareFilesButton().selectPublicShareTab();
    }

    @When("{I |}open Secure share for file '$fileName' in folder '$path' and project '$projectName'")
    public void openSecureShareForFile(String fileName, String path, String projectName) {
        Project object = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        AdbankFilesPage page = getFilesPage(object.getId(), folder.getId());
        page.selectFileByFileName(fileName);
        page.clickShareFilesButton().selectStareTab();
    }


    @When("{I |}open public url from opened Share files popup")
    public void openPublicUrlForFile() {
        String url = new ShareFilesPopup(getSut().getPageCreator().getBasePage()).getPublicLinkFieldValue();
        getSut().getWebDriver().get(url);
    }

    // | Message | UserEmails | ExpireDate | DownloadProxy |
    // DownloadProxy is not required properties and may be set as true or false
    @When("{I |}send public link of file '$fileName' from folder '$path' and project '$projectName' to following users: $data")
    public void sendPublicUrlOfFile(String fileName, String path, String projectName, ExamplesTable data) {
        Project object = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        AdbankFilesPage page = getFilesPage(object.getId(), folder.getId());
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectPublicShareTab().activatePublicLink();
        fillSharePopup(parametrizeTabularRow(data), false);
        popup.clickOKButton();
    }

    @When("{I |}send public link of file '$fileName' to following client users: $data")
    public void sendPublicUrlOfFileForClientUsers(String fileName,ExamplesTable data) {
        AdbankFilesPage page = new AdbankFilesPage(getSut().getWebDriver()) ;
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectPublicShareTab().activatePublicLink();
        fillSharePopup(parametrizeTabularRow(data), false);
        popup.clickOKButton();
    }

    @When("{I |}send public link of file without download permission '$fileName' from folder '$path' and project '$projectName' to following users: $data")
    public void sendPublicUrlOfFileWithoutDownloadPermission(String fileName, String path, String projectName, ExamplesTable data) {
        Project object = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        AdbankFilesPage page = getFilesPage(object.getId(), folder.getId());
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectPublicShareTab().activatePublicLink();
        fillSharePopupNoDownloadPermission(parametrizeTabularRow(data), false);
        popup.clickOKButton();
    }
    // | Message | UserEmails | ExpireDate | DownloadProxy | DownloadOriginal |
    // DownloadProxy and DownloadOriginal are not required properties and may be set as true or false
    @Given("{I |}added secure share for file '$fileName' from folder '$path' and project '$projectName' to following users: $data")
    public void addSecureShareOfFileOverCore(String fileName, String path, String projectName, ExamplesTable data) {
        Map<String, String> fields = parametrizeTabularRow(data);
        DateTime expirationDate = parseDateTime(fields.get("ExpireDate"));
        boolean downloadProxy = Boolean.parseBoolean(fields.get("DownloadProxy"));
        boolean downloadOriginal = Boolean.parseBoolean(fields.get("DownloadOriginal"));
        Content folder = createFolderOverCoreApi(path, projectName);
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        List<String> users = new ArrayList<>();
        for (String email : fields.get("UserEmails").split(",")) {
            users.add(getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(email)).getId());
        }
        getCoreApi().shareFile(Arrays.asList(file.getId()), users, expirationDate, fields.get("Message"), downloadProxy, downloadOriginal);
    }

    // | Message | UserEmails | ExpireDate | DownloadProxy | DownloadOriginal |
    // DownloadProxy and DownloadOriginal are not required properties and may be set as true or false
    @When("{I |}add secure share for file '$fileName' from folder '$path' and project '$projectName' to following users: $data")
    public void addSecureShareOfFile(String fileName, String path, String projectName, ExamplesTable data) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        if (path.matches(projectName + "|/|root|^$"))
            path = "/";
        String folderId = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path)).getId();
        AdbankFilesPage page = getFilesPage(project.getId(), folderId);

        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectStareTab();
        fillSharePopup(parametrizeTabularRow(data), true);
        popup.clickOKButton();
    }

    @When("{I |}add secure share for file without download permission '$fileName' from folder '$path' and project '$projectName' to following users: $data")
    public void addSecureShareOfFileWithoutDownloadPermission(String fileName, String path, String projectName, ExamplesTable data) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        if (path.matches(projectName + "|/|root|^$"))
            path = "/";
        String folderId = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path)).getId();
        AdbankFilesPage page = getFilesPage(project.getId(), folderId);

        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectStareTab();
        fillSharePopupNoDownloadPermission(parametrizeTabularRow(data), true);
        popup.clickOKButton();
    }


    @When("{I |}added secure share for all files from folder '$path' and project '$projectName' to following users: $data")
    public void addSecureShareOfFile(String path, String projectName, ExamplesTable data) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        if (path.matches(projectName + "|/|root|^$"))
            path = "/";
        String folderId = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path)).getId();
        AdbankFilesPage page = getFilesPage(project.getId(), folderId);
        ShareFilesPopup popup = page.clickShareFilesButton().selectStareTab();
        fillSharePopup(parametrizeTabularRow(data), true);
        popup.clickOKButton();
    }

    @Given("{I |}switched to '$typeView' view")
    @When("{I |}switch to '$typeView' view")
    public void switchToFilesView(String typeView) {
        AdbankFilesPage page = getFilesPage();
        if (typeView.equalsIgnoreCase("tile"))
            page.clickTileView();
        else if (typeView.equalsIgnoreCase("list"))
            page.clickListView();
        else
            throw new IllegalArgumentException("Type of file's view is undefined");
    }

    @Given("{I |}clicked change view on column mode on opened folder page")
    @When("{I |}click change view on column mode on opened folder page")
    public void changeColumnMode() {
        getSut().getPageCreator().getAdbankProjectFilesPage().showColumnMode().isColumnMode();
    }

    @Given("{I |}selected file '$fileName' from folder '$folderName' in column mode on opened folder page")
    @When("{I |}select file '$fileName' from folder '$folderName' in column mode on opened folder page")
    public void selectFolderInColumnMode(String fileName, String folderName) {
        AdbankProjectFilesPage page = getSut().getPageCreator().getAdbankProjectFilesPage();
        page.showColumnMode().selectFolder(wrapPathWithTestSession(folderName));
        page.showColumnMode().selectFile(fileName);
    }

    @When("{I |}'$action' public url for file '$fileName' in folder '$path' and project '$projectName'")
    public void doActionWithPublicUrlForFile(String action, String fileName, String path, String projectName) {
        Project object = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        AdbankFilesPage page = getFilesPage(object.getId(), folder.getId());
        page.selectFileByFileName(fileName);
        page.clickShareFilesButton().selectPublicShareTab();

        doActionWithPublicUrlForFile(action);
    }

    @When("{I |}'$action' public url on opened Share files popup")
    public void doActionWithPublicUrlForFile(String action) {
        if (action.equalsIgnoreCase("Activate")) {
            new ShareFilesPopup(getSut().getPageCreator().getBasePage()).activatePublicLink();
        } else if (action.equalsIgnoreCase("Deactivate")) {
            new ShareFilesPopup(getSut().getPageCreator().getBasePage()).deactivatePublicLink();
        } else {
            throw new IllegalArgumentException(String.format("Unknown action: '%s' for public url", action));
        }
    }

    @Given("{I |}scrolled down to number of file is '$number' on project '$projectName' folder '$path' page")
    @When("{I |}scroll down to number of file is '$number' on project '$projectName' folder '$path' page")
    public void scrollDownToFooter(int number, String projectName, String path) {
        Project object = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        AdbankFilesPage page = getFilesPage(object.getId(), folder.getId());
        page.scrollDownToFooter(number);

    }

    @Given("{I |}added file '$fileName' from library on project '$project' folder '$path' files page")
    @When("{I |}add file '$fileName' from library on project '$project' folder '$path' files page")
    public void addFileFromLibrary(String fileName, String project, String path) {
        super.addFileFromLibrary(project, path, fileName);
    }

    // order: desc, asc
    @When("{I }sort files list view in project '$project' folder '$path' by column '$column' order '$order'")
    public void sortFilesListView(Project project, String path, String columnName, String order) {
        Content folder = createFolderOverCoreApi(path, project.getName());
        AdbankFilesPage page = getFilesPage(project.getId(), folder.getId());
        switchToFilesView("list");
        page.sortListViewByColumn(columnName, order);
    }

    @When("{I |}reset an userName on project overview page for project")
    public void clearUserNameFilter() {
        getSut().getPageCreator().getProjectOverviewPage().clearFilterUserName();
    }

    @When("{I |}click on filter button on project overview page")
    public void clickOnFilterButton() {
        getSut().getPageCreator().getProjectOverviewPage().clickFilterOnActivities();
    }

    @When("{I |}set Action '$action' on project overview page for project")
    public void setActionActivityComboBox(String action) {
        getSut().getPageCreator().getProjectOverviewPage().setActivityType(action);
    }

    @When("{I |}type an userName '$userName' on project overview page for project")
    public void typeUserNameFilter(String userName) {
        getSut().getPageCreator().getProjectOverviewPage().typeFilterUserName(wrapUserEmailWithTestSession(userName));
    }

    @When("{I |}click on '$file' file in '$activity' activity on Project Overview page")
    public void clickOnFileLinkInActivity(String filename, String activityText){
        getSut().getPageCreator().getProjectOverviewPage().clickFileLinkinActivity(filename, activityText);
    }


    @Then("{I |}should see following activities are sorted on project '$projectName' overview page: $activitiesTable")
    public void checSortingForkProjectActivity(String projectName, ExamplesTable activitiesTable) {
        checkSortingForActivityOverviewPage(projectName, activitiesTable);
    }

    @Then("{I |} should see following count '$count' of total files in project folder")
    public void checkCountOfTotalFiles(int count) {
        int actualState = getSut().getPageCreator().getProjectFilesPage().getCountOfTotalProject();
        assertThat(String.format("Wrong number of files on project folder: %d, but should be %d", actualState, count), count == actualState);
    }

    @Then("{I |}'$condition' see approval status icon '$expectedStatusIcon' in file '$fileName' preview on project '$projectName' folder '$path' files page")
    public void checkFileApprovalStatusIcon(String condition, String expectedStatusIcon, String fileName, String projectName, String path) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        String actualStatusIcon = getFilesPage(project.getId(), folder.getId()).getFileApprovalStatus(fileName);

        assertThat(actualStatusIcon, shouldState ? equalToIgnoringCase(expectedStatusIcon) : not(equalToIgnoringCase(expectedStatusIcon)));
    }

    @Then("{I |}'$condition' see Public share tab on opened Share files popup")
    public void checkThatPublicShareTabPresents(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = new ShareFilesPopup(getSut().getPageCreator().getBasePage()).isPublicShareTabPresent();
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see Public Link Access tab on opened Share files popup")
    public void checkThatPublicLinkAccessTabPresents(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = new ShareFilesPopup(getSut().getPageCreator().getBasePage()).isPublicLinkAccessTabPresent();
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' be on the project files page")
    public void checkThatOpenedPageIsProjectFilesPage(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        try {
            getSut().getPageCreator().getProjectFilesPage();
            assertThat(true, is(expectedState));
        } catch (Exception e) {
            assertThat(false, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see active Share files button on opened project files page")
    public void checkOnShare(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should") || condition.equalsIgnoreCase("should not");
        boolean actualState = getSut().getPageCreator().getProjectFilesPage().isShareFilesButtonActive();
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see '$button' button on project '$projectName' Overview page")
    public void checkPublishUnpublishButon(String condition, String button, String projectName) {
        openProjectOverviewPage(projectName);
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getProjectOverviewPage().isPublishUnpublishButtonPresent(button);
        assertThat(actualState, is(expectedState));


    }

    @Then("{I |}'$condition' see '$button' button on project '$projectName' Overview page with interval")
    public void checkPresenceOf(String condition, String button, String projectName) {
        openProjectOverviewPage(projectName);
        boolean expectedState = condition.equalsIgnoreCase("should");
        int i =1;
        boolean actualState = getSut().getPageCreator().getProjectOverviewPage().isPublishUnpublishButtonPresent(button);
        do {
            if (actualState == true ) {
                Common.sleep(60000);
                getSut().getWebDriver().navigate().refresh();
            }
            actualState = getSut().getPageCreator().getProjectOverviewPage().isPublishUnpublishButtonPresent(button);
            i++;
        } while (actualState == true && i<=6);
        assertThat(actualState, is(expectedState));
    }

    @Then("I should see project '$projectName' folder '$path' page")
    public void checkFolderPage(String projectName, String path) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path));
        String expectedPage = String.format("projects/projects/%s/folders/%s/files", project.getId(), folder.getId());
        BabylonSteps.checkCurrentHashPage(expectedPage);
    }

    @Then("I '$condition' see move/copy files '$fileName' popup")
    public void checkMoveCopyFilesPopupVisibility(String condition, String fileName) {
        boolean should = condition.equals("should");
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        assertThat(moveCopyPopUpWindow.isMoveCopyPopupVisible(fileName), equalTo(should));
    }

    @Then("{I |}'$condition' see folder name '$folderName' on files page")
    public void checkVisibilityOfFolderName(String condition, String folderName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        String[] folderArray = folderName.split("/");
        String folder = wrapVariableWithTestSession(folderArray[folderArray.length - 1]);
        assertThat(adbankProjectFilesPage.getSelectedFolderName(), shouldState ? equalTo(folder) : not(equalTo(folder)));
    }

    @Then("I '$condition' see enabled move button on move/copy file popup")
    @Alias("I '$condition' see enabled copy button on move/copy file popup")
    public void checkMoveCopyButtonState(String condition) {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        boolean should = !condition.equals("should");
        assertThat(moveCopyPopUpWindow.isMoveButtonDisabled(), equalTo(should));
    }

    @Then("I should see selected project '$project' with folder '$folder' on move/copy file popup")
    public void checkSelectedResultsVisibility(String project, String folder) {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        moveCopyPopUpWindow.clickRootFolder();
        project = wrapVariableWithTestSession(project);
        folder = wrapVariableWithTestSession(folder).replaceAll("/", "");
        assertThat(moveCopyPopUpWindow.getProjectElementOnTreeContainerText(), equalTo(project));
        assertThat(moveCopyPopUpWindow.isFolderElemenyOnTreeContainerVisible(folder), equalTo(true));
    }

    @Then("I should see '$projects' are available for selecting in search projects on move/copy file popup")
    public void checkAvailableForSelectingProjectsOnMoveCopyFilePopup(String projects) {
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(adbankProjectFilesPage);
        List<String> listOfProjects = moveCopyPopUpWindow.getAvailableForSearchProjectsListAsText();
        String[] projectsArray = projects.split(",");
        assertThat(listOfProjects.size(), greaterThanOrEqualTo(projectsArray.length));

        for (String project : projectsArray) {
            assertThat(listOfProjects, hasItem(wrapVariableWithTestSession(project)));
        }
    }

    @Then("I should see '$prefix' '$checkStr' as title of move/copy file popup")
    public void checkFileNameAsTitleOnMoveCopyPopup(String prefix, String fileName) {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        assertThat(moveCopyPopUpWindow.isFileNameAsTitleVisible(fileName), equalTo(true));
        assertThat(moveCopyPopUpWindow.getFileNameAsTitleText(fileName), equalTo(prefix + " " + fileName));
    }

    @Then("I should see please select folder where you want to '$prefix' file '$fileName' on move/copy file popup")
    public void checkPleaseSelectFolderTextContainsFileName(String prefix, String fileName) {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        assertThat(moveCopyPopUpWindow.getPleaseSelectLabelText(), endsWith(prefix + " " + fileName));
    }

    @Then("I '$condition' see Search project field on move/copy file popup")
    public void checkSearchProjectFieldOnMoveCopyFilePopup(String condition) {
        boolean should = condition.equals("should");
        AdbankProjectFilesPage adbankProjectFilesPage = getSut().getPageCreator().getProjectFilesPage();
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(adbankProjectFilesPage);
        assertThat(moveCopyPopUpWindow.isSearchFieldVisible(), equalTo(should));
    }

    @Then("{I |}'$condition' see file{s|} '$fileName' on project '$projectName' folder '$folderName' files page")
    public void checkFileOnThePageAfterDelete(String condition, String fileName, String projectName, String folderName) {
        checkFiles(condition, fileName, projectName, folderName);
    }

    // used for check visibility of project folders files after AXEL F
    @Then("{I |}'$shouldState' see next file{s|} '$fileNames' on project '$projectName' folder '$path' page")
    public void checkVisibilityProjectFoldersFiles(String shouldState, String fileNames, String projectName, String path) {
        AdbankFoldersTree filesPage = passToProjectFolderPage(projectName, path);
        for (String fileName: fileNames.split(","))
            assertThat("Check visibility of file: " + fileName, filesPage.isFileVisible(fileName), is(shouldState.equals("should")));
    }

    // | FileName |
    @Then("I '$shouldState' see on project '$projectName' folder '$folderName' files page following files : $filesName")
    public void checkFilesProjectsFilePage(String shouldState, String projectName, String folderName, ExamplesTable filesName) {
        checkFilesOnFilesPage(shouldState, projectName, folderName, filesName);
    }

    // | FileName |
    @Then(value = "I '$shouldState' see on project '$projectName' folder '$folderName' are created by user '$userPlan' files page following files : $filesName", priority = 1)
    public void checkFilesProjectsFilePage(String shouldState, String projectName, String folderName, String userPlan, ExamplesTable filesName) {
        User user = getData().getUserByType(userPlan);
        if (user==null)
            user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userPlan));
        checkFilesOnFilesPage(shouldState, projectName, folderName, user, filesName);
    }


    @Then("{I |}'$condition' see file '$fileName' on project '$projectName' overview page")
    public void checkFilesOnProjectOverviewPage(String condition, String fileName, String projectName) {
       //checkFiles(condition, fileName, projectName, null);
        // 1096 Merge
        checkFilesonOverview(condition, fileName, projectName, null);
        //1096 Merge

    }

    @Then("{I |}'$shouldState' see '$fileName' file inside '$path' folder for '$projectName' project")
    public void checkProjectFile(String shouldState, String fileName, String path, String projectName) {
        boolean should = shouldState.equalsIgnoreCase("should");
        assertThat("Link to file", checkFile(fileName, path, projectName), equalTo(should));
    }

    @Then("{I |}'$shouldState' see '$fileName' file inside '$path' folder for '$projectName' {client | shared} project")
    public void checkClientProjectFile(String shouldState, String fileName, String path, String projectName) {
        boolean should = shouldState.equalsIgnoreCase("should");
        assertThat("Link to file", checkClientFile(fileName, path, projectName), equalTo(should));
    }
    // | Folder | FileName | FilesCount (optional) |
    @Then("{I |}should see following files inside folders for '$projectName' project: $data")
    public void checkProjectFilesInFolders(String projectName, ExamplesTable data) {
        for (Map<String, String> row : parametrizeTableRows(data)) {
            checkObjectFiles(row.get("Folder"), projectName, new ExamplesTable(String.format("| FileName |\n| %s |", row.get("FileName"))));
        }
    }

    // | FileName | FilesCount (optional) |
    @Then("{I |}should see following files inside '$path' folder for '$projectName' project: $filesTable")
    public void checkProjectFiles(String path, String projectName, ExamplesTable filesTable) {
        checkObjectFiles(path, projectName, filesTable);
    }

    @Then("I should see following files on project '$projectName' overview page: $filesTable")
    public void checkProjectFiles(String projectName, ExamplesTable filesTable) {
        checkObjectFiles(null, projectName, filesTable);
    }

    @Then("I should see on project '$projectName' on file '$fileName' following status approval '$status'")
    public void checkFileApprovalStatus(String projectName, String fileName, String status) {
        checkFileApprovalStatusOnOverviewPage(projectName, fileName, status);
    }

    @Then("I should see file '$fileName' with wrapped title from folder '$path' on project '$projectName' overview page")
    public void checkProjectOverviewWrappedFile(String fileName, String path, String projectName) {
        checkObjectWrappedFile(fileName, path, projectName);
    }

    // fileNames comma separated
    @Then("{I |}should see files '$fileNames' inside '$path' folder for '$projectName' project")
    public void checkProjectFiles(String fileNames, String path, String projectName) {
        StringBuilder tableAsString = new StringBuilder("|FileName|\r\n");
        for (String fileName : fileNames.split(",")) {
            if (fileName.isEmpty()) continue;
            tableAsString.append("|").append(fileName).append("|\r\n");
        }
        ExamplesTable filesTable = new ExamplesTable(tableAsString.toString());
        checkObjectFiles(path, projectName, filesTable);
    }

    // fileNames comma separated
    @Then("{I |}should see files '$fileNames' inside '$path' folder for '$projectName' project using nverge api")
    public void checkProjectFilesNVerge(String fileNames, String path, String projectName) {
        String folderId = createFolderOverCoreApi(path, projectName).getId();
        for (String fileName : fileNames.split(",")) {

            System.out.println("folder id "+folderId);
            System.out.println("filename "+fileName);
            Content file = getCoreApi().getFileByName(folderId, fileName);
            System.out.println("Print File "+file);
            System.out.println("Print File ID "+file.getId());
            Content nvergeFile = getNVergeApi().getContent(file.getId());

            // System.out.println("Actual "+nvergeFile.getName());
            // System.out.println("Expected "+nvergeFile.getName());
            // assertThat(nvergeFile.getName(), equalTo(fileName));
        }
    }

    @Then("{I |}should see thumbnail for revision '$revision' for file '$fileName' inside '$path' folder for '$projectName' project")
    public void checkRevisionThumbnail(int revision, String fileName, String path, String project){
        checkFileThumbnailForRevision(path, project, fileName, revision);
    }

    @Then("I should see '$count' selected files in folder '$path' of project '$projectName'")
    public void checkProjectSelectedFilesCount(int count, String path, String projectName) {
        checkSelectedFilesCount(count, path, projectName);
    }

    @Then("I '$condition' see file '$fileName' on {the |}project files page")
    public void checkFileOnThePageAfterDelete(String condition, String fileName) {
        super.checkFileOnThePageAfterDelete(condition, fileName);
    }

    @Then("I '$condition' see file '$fileName' on {the |}project files page and files count are '$count'")
    public void checkFileAndFileCountOnThePage(String condition, String fileName, String count) {
        super.checkFileAndFileCountOnThePage(condition, fileName, count);
    }

    @Then("I '$condition' see file '$fileName' and files count are '$count' on the project search menu")
    public void checkFileAndFileCountOnTheProjectPageForSearch(String condition, String fileName, int count) {
        checkFileAndFileCountOnThePageForSearch(condition, fileName, count);
    }

    @Then("I should not see dropdown menu for trash bin on project page")
    @Alias("I should see opened trash bin")
    public void checkDropdowmMenuForTrashBin() {
        AdbankFilesPage adbankFilesPage = getSut().getPageCreator().getProjectFilesPage();
        assertThat("", adbankFilesPage.getAllChildrenOfTrashBin().size(), equalTo(1));
        log.debug("I check div trash bin");
    }

    // | item |
    @Then("{I |}'$shouldState' see in pop up menu for folder '$path' in project '$projectName' overview page following items: $itemsTable")
    public void checkItemsInFoldersPopUp(String shouldState , String path, String projectName, ExamplesTable filesTable) {
        checkItemsInPopUpOverviewPage(shouldState, projectName, filesTable);
    }

    @Then("{I |}'$shouldState' see in pop up menu for folder '$path' in project '$projectName' files page following items{ |}: $itemsTable")
    public void checkItemsInFoldersPopUpFilesPage(String shouldState , String path, String projectName, ExamplesTable filesTable) {
        checkItemsInPopUp(shouldState, path, projectName, filesTable);
    }

    @Then("{I |}'$shouldSee' see '$path' folder in '$projectName' project")
    public void checkProjectFolder(String shouldSee, String path, String projectName) {
        checkFolder(shouldSee, path, projectName);
    }

    // used for checking visibility of projects folder during AXEL F
    //TD-202 -- Appending the projectName with the year
    @Then("{I |}should see next '$pathList' folder{s|} in '$projectName' project")
    public void checkVisibilityProjectsFolder(String pathList, String projectName) {
        projectName = projectName.concat(" - "+String.valueOf(Calendar.getInstance().get(Calendar.YEAR)));
        for (String path : pathList.split(",")) {
            path = prepareAdstreamIngestPath(path);
            Project project = getObjectByName(projectName);
            Content folder = getCoreApi().createFolderRecursive(path, project.getId(), project.getId());
            AdbankFoldersTree foldersTree = getFoldersTree(project.getId(), folder.getId());
            Common.sleep(2000);
            assertThat("Check visibility of folder: " + path, foldersTree.getCurrentFolderName(), equalTo(folder.getName()));
        }
    }

    @Then("{I |}should see following folders in '$projectName' project: $foldersTable")
    public void checkProjectFolders(String projectName, ExamplesTable foldersTable) {
        checkFolders(projectName, foldersTable);
    }

    // | folder |
    @Then("{I |}should see following folders in '$projectName' project using nverge api: $foldersTable")
    public void checkProjectFoldersNVerge(String projectName, ExamplesTable foldersTable) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        List<Content> folders = getNVergeApi().findContentAllProjects(new LuceneSearchingParams().setQuery(project.getId())).getResult();
        assertThat(folders.size(), equalTo(foldersTable.getRowCount()));
        String[] expectedFolderNames = new String[foldersTable.getRowCount()];
        List<String> folderNames = new ArrayList<>();
        for (int i = 0; i < foldersTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(foldersTable, i);
            expectedFolderNames[i] = wrapVariableWithTestSession(row.get("folder").replace("/", ""));
        }
        for (Content folder : folders) {
            folderNames.add(folder.getName());
        }
        assertThat(folderNames, hasItems(expectedFolderNames));
    }

    // | folder |
    @Then("I should see following folders in search result using nverge api by keyword '$keyword': $folderTable")
    public void checkProjectFoldersSearchNVerge(String keyword, ExamplesTable foldersTable) {
        List<Content> folders = ((BabylonSendplusMiddleTierService) getNVergeApi().getWrappedService()).findFolders(keyword, 1, 50);
        assertThat("Folders count in search result", folders.size(), equalTo(foldersTable.getRowCount()));
        for (int i = 0; i < foldersTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(foldersTable, i);
            String folderName = wrapVariableWithTestSession(row.get("folder"));
            boolean found = false;
            for (Content folder : folders) {
                if (folder.getName().equals(folderName)) {
                    found = true;
                    break;
                }
            }
            assertThat("Folder " + folderName + " is present in search result", found, is(true));
        }
    }

    @Then("{I |}'$condition' see following folders in '$projectName' project: $foldersTable")
    public void checkProjectFolders(String condition, String projectName, ExamplesTable foldersTable) {
        checkFolders(condition, projectName, foldersTable);
    }

    @Then("I should see '$count' folders in '$path' for project '$projectName'")
    public void checkProjectSubFoldersCount(int count, String path, String projectName) {
        checkSubFoldersCount(count, path, projectName);
    }

    @Then("I should see jumploader uploaded '$bytesUploaded' bytes in folder '$path' of project '$projectName'")
    public void checkUploadedVolume(long bytesUploaded, String path, String projectName) {
        checkJumploaderUploadedVolume(bytesUploaded, path, projectName);
    }

    @Then("I should see jumploader uploading '$is' in progress in folder '$path' of project '$projectName'")
    public void checkProjectJumploaderProgress(String is, String path, String projectName) {
        checkJumploaderProgress(is, path, projectName);
    }

    @Then("I should see files count '$count' in jumploader in folder '$path' of project '$projectName'")
    public void checkProjectFilesCountInJumploader(int count, String path, String projectName) {
        checkFilesCountInJumploader(count, path, projectName);
    }

    @Then("{I |}should see sorting type '$sortingType' is selected on project '$projectName' folder '$path' page")
    public void checkSortingTypeTextProjectFilesPage(String sortingType, String projectName, String path) {
        checkSelectedSortingTypeText(sortingType, projectName, path);
    }

    @Then("{I |}should see sorting files by '$sortingType' on project '$projectName' folder '$path'")
    public void checkSortingProjectFiles(String sortingType, String projectName, String path) {
        checkFilesSorting(sortingType, projectName, path);
    }

    @Then("{I |}'$condition' see folders sorted in the following order '$folders' on opened project page")
    public void checkSortingProjectFolders(String condition, String folders) {
        List<String> expectedFolders = new ArrayList<>();

        if (!folders.isEmpty()) {
            for (String folder : folders.split(",")) {
                expectedFolders.add(wrapVariableWithTestSession(folder));
            }
        }

        checkFoldersSorting(condition.equalsIgnoreCase("should"), expectedFolders);
    }

    @Then("{I |}should see folder '$path' on project '$projectName' files page")
    public void checkProjectFoldersSearching(String path, String projectName) {
        checkFolderSearching(path, projectName);
    }

    @Then("Files preview should be available on project '$projectName' overview page")
    public void checkFilePreviewOnOverviewPage(String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectOverviewPage page = (AdbankProjectOverviewPage) getFoldersTree(project.getId(), null);
        assertThat("File preview should be available", page.isPreviewAvailable(), equalTo(true));
    }

    @Then("{I should see|}file '$filePath' in folder '$path' on project '$projectName' files page is fully uploaded")
    public void checkProjectFileUploadComplete(String filePath, String path, String projectName) {
        checkFileUploadComplete(filePath, path, projectName);
    }

    @Then("I '$condition' see '$fileName' file in roulette on overview tab")
    public void checkFileTitleOnOverviewTab(String condition, String fileName) {
        boolean should = condition.equals("should");
        AdbankProjectOverviewPage adbankProjectOverviewPage = getSut().getPageCreator().getProjectOverviewPage();
        assertThat("", adbankProjectOverviewPage.isFileVisible(fileName), equalTo(should));
    }

    @Then("I '$condition' see '$fileName' file activity on team tab")
    public void checkFileNameOnTeamTab(String condition, String fileName) {
        boolean should = condition.equals("should");
        AdbankProjectTeamsPage adbankProjectTeamsPage = getSut().getPageCreator().getProjectTeamsPage();
        for (WebElement webElement : adbankProjectTeamsPage.getAllFilesLinkInActivityList()) {
            assertThat("", webElement.getText(), should ? equalTo(fileName) : not(fileName));
        }
    }

    @Then("I should see following folders on move/copy files popup: $folders")
    public void checkFildersVisibilityOnMoveCopyPopupButton(ExamplesTable folders) {
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        for (Parameters parameters : folders.getRowsAsParameters(true)) {
            String folder = parameters.valueAs("folder", String.class);
            String[] folderArray = folder.split("/");
 //           assertThat(moveCopyPopUpWindow.isFolderElemenyOnTreeContainerVisible(wrapVariableWithTestSession(folderArray[1])), equalTo(true)); // До раскрытия дерева - не должен быть видимым
//            assertThat(moveCopyPopUpWindow.isFolderElemenyOnTreeContainerVisible(wrapVariableWithTestSession(folderArray[folderArray.length - 1])), equalTo(false)); // До раскрытия дерева - не должен быть видимым
            selectFolderOnMoveCopyFilePopup(folder);
            for (String folderName : folderArray) {
                if (folderName.isEmpty()) continue;
                assertThat(moveCopyPopUpWindow.isFolderElemenyOnTreeContainerVisible(wrapVariableWithTestSession(folderName)), equalTo(true));
                log.debug("I check that folder: " + folderName + " is visibile");
            }
        }
    }

    // | master | proxy |
    @Given("{I |}'$condition' see checkbox '$checkbox' is visible on opened pop-up of download File")
    @Then("{I |}'$condition' see checkbox '$checkbox' is visible on opened pop-up of download File")
    public void checkThatCheckboxesAreVisible(String condition, String checkbox) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        DownloadFilePopUpWindow downloadFilePopUpWindow = new DownloadFilePopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        boolean expectedState;

        if (checkbox.equalsIgnoreCase("master")) {
            expectedState = downloadFilePopUpWindow.isDownloadMasterCheckboxVisible();
        } else if (checkbox.equalsIgnoreCase("proxy")) {
            expectedState = downloadFilePopUpWindow.isDownloadProxiesCheckboxVisible();
        } else {
            throw new IllegalArgumentException("Wrong argument exeption: " + checkbox + "Should be only: master,proxy");
        }

        assertThat("Something is wrong with visibility of " + checkbox, shouldState == expectedState);
    }

    @When("{I |}select checkbox '$checkbox' and click download")
    public void selectCheckboxesForDownload(String checkbox) {
        DownloadFilePopUpWindow downloadFilePopUpWindow = new DownloadFilePopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        if (checkbox.equalsIgnoreCase("master")) {
            downloadFilePopUpWindow.selectDownloadMaster();
        } else if (checkbox.equalsIgnoreCase("proxy")) {
            downloadFilePopUpWindow.selectDownloadProxy();
        } else if (checkbox.equalsIgnoreCase("master,proxy")) {
            downloadFilePopUpWindow.selectDownloadMaster();
            downloadFilePopUpWindow.selectDownloadProxy();
        } else {
            throw new IllegalArgumentException("Wrong argument exeption: " + checkbox + "Should be only: master,proxy");
        }
        downloadFilePopUpWindow.clickDownloadButton();
    }

    @When("{I |}select checkbox '$checkbox' and click download by Sendplus")
    public void selectCheckboxesForDownloadBySendPlus(String checkbox) {
        DownloadFilePopUpWindow downloadFilePopUpWindow = new DownloadFilePopUpWindow(getSut().getPageCreator().getProjectFilesPage());
        if (checkbox.equalsIgnoreCase("master")) {
            downloadFilePopUpWindow.selectDownloadMaster();
        } else if (checkbox.equalsIgnoreCase("proxy")) {
            downloadFilePopUpWindow.selectDownloadProxy();
        } else if (checkbox.equalsIgnoreCase("master,proxy")) {
            downloadFilePopUpWindow.selectDownloadMaster();
            downloadFilePopUpWindow.selectDownloadProxy();
        } else {
            throw new IllegalArgumentException("Wrong argument exeption: " + checkbox + "Should be only: master,proxy");
        }
        downloadFilePopUpWindow.clickDownloadBySendPlusButton();
    }

    @Then("{I |}should be able to save file as zip")
    public void saveOnWindowsPopup() throws InterruptedException, AWTException {
        String parentWindowHandler = getSut().getWebDriver().getWindowHandle();
        String subWindowHandler = null;

        Set<String> handles = getSut().getWebDriver().getWindowHandles();
        Iterator<String> iterator = handles.iterator();
        while (iterator.hasNext()){
            subWindowHandler = iterator.next();
        }
        getSut().getWebDriver().switchTo().window(subWindowHandler);
        Robot rb = new Robot();
        Thread.sleep(2000);
        rb.keyPress(KeyEvent.VK_ALT);
        rb.keyPress(KeyEvent.VK_S);
        rb.keyRelease(KeyEvent.VK_S);
        rb.keyRelease(KeyEvent.VK_ALT);
        rb.keyPress(KeyEvent.VK_ENTER);
        rb.keyRelease(KeyEvent.VK_ENTER);
        getSut().getWebDriver().switchTo().window(parentWindowHandler);
    }

    // | Media Type | Enabled |
    @Then("{I |}should see following media type filter status on project '$projectName' folder '$path' page: $statusTable")
    public void checkProjectMediaTypeFilterStatus(String projectName, String path, ExamplesTable statusTable) {
        checkMediaTypeFilterState(projectName, path, statusTable);
    }

    // possible values for $thumbnailElement - from UIMap.xml 'FilesPage':
    // GenericMasterIcon, TitledMasterIcon
    @Then("{I |}should see thumbnail '$thumbnailElement' for each file on project '$projectName' folder '$path' page")
    public void checkThumbnailForEachFile(String thumbnailElement, String projectName, String path) {
        Project object = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        AdbankFilesPage filesPage = getFilesPage(object.getId(), folder.getId());
        int fileCount =   filesPage.getFilesCount();
        By locator = getSut().getUIMap().getByPageName("FilesPage", thumbnailElement);
        int thumbnailsCount = getSut().getWebDriver().findElements(locator).size();
        assertThat("Each file has thumbnail " + thumbnailElement, thumbnailsCount, equalTo(fileCount));
    }

    // possible values for $thumbnailElement:
    // GenericMasterIcon, TitledMasterIcon
    @Then("{I |}'$shouldState' see thumbnail '$thumbnailElement' for file '$fileName' under its preview")
    public void checkThumbnailForFile(String shouldState, String thumbnailElement, String fileName) {
        super.checkThumbnailForFile(shouldState, thumbnailElement, fileName);
    }

    @Then("I should see preview of file '$format' into folder '$folderName' of project '$projectName'")
    public void checkProjectsFilesPreview(String format, String folderName, String projectName) {
        checkFilesPreview(folderName, projectName);
    }

    // | ID | Client | Title | Media Type | Sub Media Type | Duration | Width | Height | Screen | File Type | File Size |
    @Then("{I |}should see following data on add file to library page: $fieldsTable")
    public void checkAddFileToLibraryPageData(ExamplesTable fieldsTable) {
        Map<String, String> fields = parametrizeTabularRow(fieldsTable);
        AdbankAddFileToLibraryPage page = getAddFileToLibraryPage();
        for (Map.Entry<String, String> entry : fields.entrySet()) {
            String field = entry.getKey();
            String value = entry.getValue();
            if (field.equals("Client"))
                value = getData().getAgencyByName(value).getName();
            if ((field.equals("Sub Media Type") || field.equals("Screen")) && value.equals("Not specified"))
                //value = "<span class=\"color-middlegrey\">Not specified</span>";
                value = "";
            if (entry.getKey().equals("ID"))
                fields.put("ID", wrapVariableWithTestSession(entry.getValue()));
            if (entry.getKey().equals("Clock number")) {
                assertThat("Check clock number: ", page.getFieldValue(field), StringByRegExpCheck.matches(value));
                return;
            }
            assertThat("Check field " + field, page.getFieldValue(field), equalTo(value));
        }
    }

    @Then("{I |}'$condition' see red input for fields '$fields' on add file to library page")
    public void checkThatRedFieldsPresented(String condition, String fields) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        AdbankAddFileToLibraryPage page = getAddFileToLibraryPage();

        for (String field : fields.split(",")) {
            boolean actualState;

            if (field.equalsIgnoreCase("id")) {
                actualState = page.isIdFieldHighlighted();
            } else if (field.equalsIgnoreCase("client")) {
                actualState = page.isClientFieldHighlighted();
            } else if (field.equalsIgnoreCase("product")) {
                actualState = page.isProductFieldHighlighted();
            } else {
                throw new IllegalArgumentException(String.format("Unknown field '%s' for add file to library page", field));
            }

            assertThat(actualState, is(expectedState));
        }
    }

    @Then("I should see count '$count' of adbank icons for current folder")
    public void checkCountOfAdbankIcons(String count) {
        super.checkCountOfAdbankItems(count);
    }

    @Then("I should see file '$fileName' info page in project '$projectName' folder '$path'")
    public void checkProjectFilePage(String fileName, String projectName, String path) {
        checkFilePage(projectName, path, fileName);
    }

    @Deprecated
    @Then("{I |}'$shouldState' see activity for user '$userName' on project '$projectName' overview page with message '$message' and value '$value'")
    public void checkActivityOnProjectOverviewPage(String shouldState, String userName, String projectName, String message, String value) {
        openProjectOverviewPage(wrapVariableWithTestSession(projectName));
        checkActivity(getFoldersTree(getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName)).getId(), null), shouldState.equals("should"), userName, message, value);
    }

    // | UserName | Message | Value |
    @Then("{I |}should see following '$sorted' activities on project '$projectName' overview page: $activitiesTable")
    public void checkProjectActivity(String sorted, String projectName, ExamplesTable activitiesTable) {
        checkActivityOverviewPage(projectName, activitiesTable, sorted.equals("sorted"));
    }

    // | FileName | Duration | Size | AspectRatio | Type |
    @Then("I should see following files metadata on project '$projectName' overview page: $filesMetadata")
    public void checkFilesMetadata(String projectName, ExamplesTable filesMetadata) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectOverviewPage page = (AdbankProjectOverviewPage) getFoldersTree(project.getId(), null);
        for (int i = 0; i < filesMetadata.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesMetadata, i);
            AdbankFilesPage.FileMetadata metadata = page.getFileMetadata(row.get("FileName"));
            if (row.get("ShortId") != null) assertThat("ShortId", metadata.getShortId(), equalTo(row.get("ShortId")));
            if(row.get("Type") != null)assertThat("Type", metadata.getType(), equalTo(row.get("Type")));
        }
    }

    @Then("{I |}'$condition' see tab '$tabName' for file '$fileName' in the folder '$folderName' on the project '$projectName'")
    public void checkProjectFilesTab(String condition, String tabName, String fileName, String folderName, String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(folderName));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        AdbankProjectFileInfoPage projectFileInfoPage = getSut().getPageNavigator().getProjectFileInfoPage(project.getId(), folder.getId(), file.getId());
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(projectFileInfoPage.getAllTabLinksNames(), shouldState ? hasItem(tabName) : not(hasItem(tabName)));
    }

    @Then("{I |}'$shouldState' see Download link next to original file '$fileName' and Download master using nVerge button on Download popup for project '$projectName' folder '$path'")
    public void checkVisibilityDownloadLinkDownloadMasterBtnProjectsFile(String shouldState, String fileName, String projectName, String path) {
        checkVisibilityDownloadLinkDownloadMasterBtn(shouldState, fileName, projectName, path);
    }

    @Then("{I |}'$shouldState' see Download link next to original file '$fileName' and Download master using nVerge button on Download popup for current project")
    public void checkDownloadLinkPopupMasternVergForCurrentProject(String shouldState, String fileName) {
        checkDownloadLinkPopupMasternVergForCurrentObject(shouldState, fileName);
    }

    @Then("{I |}'$shouldState' see Download link for '$linkType' type on Download popup for project '$projectName' folder '$path'")
    public void checkVisibilityDownloadLink(String shouldState, String linkType, String objectName, String path) {
        super.checkVisibilityDownloadLink(shouldState, objectName, path, linkType);
    }

    @Then("{I |}'$shouldState' see enabled buttons on Download popup for project '$projectName' folder '$path'")
    public void checkAccessToDownloadButtons(String shouldState, String objectName, String path) {
        checkDownloadButtonButtons(shouldState, objectName, path);
    }

    @Then("{I |}'$shouldState' see count '$count' of download link for current project")
    public void checkCountOfDownloadLink(String shouldState, String count) {
        checkCountOfDownloadLink(shouldState, Integer.parseInt(count));
    }

    @Then("{I |}'$shouldState' see '$fileType' as part of download file name for current project")
    public void checkPartOfDownloadFileName(String shouldState, String fileType) {
        checkTypeOfDownloadFileIsExist(shouldState, fileType);
    }

    @Then("{I |}'$shouldState' see preview file '$filePath' on project '$projectName' folder '$path' page")
    public void checkAvailabilityPreviewProjectsFile(String shouldState, String filePath, String projectName, String path) {
        checkAvailabilityPreviewFile(shouldState, filePath, projectName, path);
    }
    @Then("{I |}'$shouldState' see preview files '$filePath' on project '$projectName' folder '$path' page")
    public void checkAvailabilityPreviewProjectsFiles(String shouldState, String filePath, String projectName, String path) {
        String[] fileArray = filePath.split(",");
        for (String file : fileArray) {
            checkAvailabilityPreviewFile(shouldState, file, projectName, path);
        }
    }


    @Then("{I |}'$condition' see new folder button on project '$projectName' folder '$path' page")
    public void checkNewFolderButton(String condition, String projectName, String path) {
        checkThatNewFolderButtonIsVisible(condition, projectName, path);
    }

    @Then("{I |}'$condition' see share button on project '$projectName' folder '$path' page")
    public void checkShareButton(String condition, String projectName, String path) {
        checkThatShareFolderButtonIsVisible(condition, projectName, path);
    }

    @Then("{I |}'$condition' see enabled share button on project '$projectName' folder '$path' page")
    public void checkShareButtonEnabled(String condition, String projectName, String path) {
        checkThatShareFolderButtonIsEnable(condition, projectName, path);
    }

    // | Name | ShouldState |
    @Then("{I |}should see drop down menu items for project '$projectName' folder '$folderName' according to: $conditionTable")
    public void checkProjectsDropDownMenuVisibility(String projectName, String folderName, ExamplesTable conditionTable) {
        checkDropDownMenuVisibility(projectName, folderName, conditionTable);
    }

    // | Name | ShouldState |
    @Then("{I |}should see tabs for project '$projectName' folder '$folderName' according to: $tabsTable")
    public void checkTabsVisibility(String objectName, String path, ExamplesTable tabsTable) {
        getObjectTabsVisibility(objectName, path, tabsTable);
    }

    // | Folder | State |
    @Then("{I |}should see following folders for the project '$projectName': $stateTable")
    public void checkProjectsFoldersVisibility(String projectName, ExamplesTable stateTable) {
        checkFoldersVisibility(projectName, stateTable);
    }

    @Then("{I |}'$condition' see downloaded file '$fileName'")
    public void checkDownloadedFileName(String condition, String fileName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = new File(getContext().testsTempFolder, fileName).exists();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$shouldState' see active following options '$optionsList' in More drop down menu on project files page")
    public void checkMoreMenuOptionsState(String shouldState, String optionsList) {
        AdbankFilesPage filesPage = getFilesPage().clickMoreButton();
        for (String option : optionsList.split(","))
            assertThat("Check is option " + option + " active: ", filesPage.isActiveMoreMenuOption(option), is(shouldState.equals("should")));
    }

    @Then("{I |}should see for project '$projectName' trash bin page files in the '$typeView' view")
    public void checkFilesViewState(String projectName, String typeView) {
        boolean shouldState = typeView.equalsIgnoreCase("list");
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        AdbankProjectTrashPage page = getSut().getPageNavigator().getProjectTrashPage(project.getId(), "");
        assertThat(page.isViewOfFilesIsList(), equalTo(shouldState));
    }

    @Then("{I |}should see the following fields on project '$projectName' overview page: $projectFields")
    public void verifyProjectFields(String projectName, ExamplesTable projectFields) throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date date = new Date();
        openProjectOverviewPage(projectName);
        String publish_Date=getSut().getPageCreator().getProjectOverviewPage().getPublishDate();
        String publish_DateTimeZone=getSut().getPageCreator().getProjectOverviewPage().getPublishDateTimeZone();
        String publish_Message=getSut().getPageCreator().getProjectOverviewPage().getPublishMessage();
        for (int i = 0; i < projectFields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(projectFields, i);
            if(row.get("Publish Date").contains("Current"))
            {
                dateFormat = new SimpleDateFormat("MM/dd/yyyy, HH:mm aaa");
            }
            else if(row.get("Publish Date").contains("Tomorrow"))
            {
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                cal.add(Calendar.DATE, 1);
                date = cal.getTime();
            }
            if(row.get("Publish Time") != null){
                assertThat("Publish Date", publish_Date, equalTo(dateFormat.format(date)+", "+row.get("Publish Time")));
                if(row.get("Publish DateTimeZone") != null) {
                    assertThat("Publish DateTimeZone", publish_DateTimeZone, equalTo(dateFormat.format(date) + ", " + row.get("Publish Time") + " " + row.get("Publish DateTimeZone")));
                }
            }else{
                assertThat("Publish Date", dateFormat.format(date).compareTo(publish_Date),lessThanOrEqualTo(0));
                if(row.get("Publish DateTimeZone") != null) {
                    assertThat("Publish DateTimeZone", (dateFormat.format(date) + " " + row.get("Publish DateTimeZone")).compareTo(publish_DateTimeZone), lessThanOrEqualTo(0));
                }
            }
            if(row.get("Publish Message") != null)assertThat("Publish Message", publish_Message, equalTo(row.get("Publish Message")));
        }


    }

    @Then("{I |}'$shouldState' see the following fields on project '$projectName' overview page: $projectFields")

    public void verifyPresenceOfProjectFields(String condition, String projectName, ExamplesTable projectFields) throws ParseException {
        openProjectOverviewPage(projectName);
        boolean shouldState=condition.equalsIgnoreCase("should");
        boolean isPublishDate = getSut().getPageCreator().getProjectOverviewPage().isPublishDateDisplayed();
        boolean isPublishDateTimeZone = getSut().getPageCreator().getProjectOverviewPage().isPublishDateTimeZoneDisplayed();
        boolean isPublishMessage = getSut().getPageCreator().getProjectOverviewPage().isPublishMessageDisplayed();
        assertThat(shouldState,equalTo(isPublishDate));
        assertThat(shouldState,equalTo(isPublishDateTimeZone));
        assertThat(shouldState,equalTo(isPublishMessage));
    }

    @Then("{I |}should see for project '$projectName' folder '$path' page files in the '$typeView' view")
    public void checkFilesViewState(String projectName, String path, String typeView) {
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(path, projectName);
        String folderId = folder == null ? project.getId() : folder.getId();
        AdbankFilesPage page = getFilesPage(project.getId(), folderId);
        switch (typeView.toLowerCase()) {
            case "list":
                assertThat(page.isViewOfFilesIsList(), is(true));
                break;
            case "tile":
                assertThat(page.isViewOfFilesIsTile(), is(true));
                break;
            default:
                throw new IllegalArgumentException("Unknown type of view: " + typeView);
        }
    }

    // | UserName | DownloadMaster | DownloadProxy |
    // DownloadProxy and DownloadMaster are not required properties and may be set as true or false
    @Then("{I |}'$condition' see following users on Secure Shares tab in Share files popup for file '$fileName' on opened files page: $data")
    public void checkThatUserPresentOnSecureSharesTab(String condition, String fileName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        getSut().getWebDriver().navigate().refresh();
        AdbankProjectFilesPage page = getSut().getPageCreator().getProjectFilesPage();
        page.selectFileByFileName(fileName);
        ShareFilesPopup popup = page.clickShareFilesButton().selectSecureSharesTab();
        List<Map<String,String>> actualUsers = popup.getUsersList();

        for (Map<String,String> row : parametrizeTableRows(data)) {
            Map<String,String> expectedUser = new HashMap<>();
            expectedUser.put("UserName", getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName"))).getFullName());
            expectedUser.put("DownloadMaster", Boolean.toString(Boolean.parseBoolean(row.get("DownloadMaster"))));
            expectedUser.put("DownloadProxy", Boolean.toString(Boolean.parseBoolean(row.get("DownloadProxy"))));

            assertThat(actualUsers, shouldState ? hasItem(expectedUser) : not(hasItem(expectedUser)));
        }
    }

    @Then("{I }should see not less than '$filesCount' files for project '$projectName' folder '$path'")
    public void checkAllFilesCount(int count, String projectName, String path) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(project.getCreatedBy()).getFolderByPath(project.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage page = getFilesPage(project.getId(), folder.getId());
        assertThat(page.getAllFilesCount(), greaterThanOrEqualTo(count));
    }

    @Then("{I } '$condition' see Add new Approval pop up")
    public void checkvisibilityAddNewStagePopup(String condition){
        boolean shouldState=condition.equalsIgnoreCase("should");
        SendForApprovalPopUp popup = new SendForApprovalPopUp(getSut().getPageCreator().getProjectFilesPage());
        assertThat(shouldState, equalTo(popup.isPopUpVisible()));
    }

    @Then("{I |}'$should' see column mode for files on opened folder page")
    public void openFileColumnView(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankProjectFilesPage adbankProjectFilespage = getSut().getPageNavigator().getAdbankProjectFilesPage();

        assertThat("Column view are not available", shouldState == adbankProjectFilespage.showColumnMode().isColumnMode());
    }

    @Given("{I |}'$state' following project column '$columns' on opened Project folder page")
    @When("{I |}'$state' following project column '$columns' on opened Project folder page")
    public void setFollowingProjectColumns(String state, String columns) {
        AdbankFilesPage page = getFilesPage();
        AddColumnsProjectWindow addColumnsProjectWindow = new AddColumnsProjectWindow(page);
        AddColumnsProjectWindow page1 = page.clickByAddColumnProjectListButton();
        for (String column : columns.split(";")) {
            if ((state.equals("add")) && !addColumnsProjectWindow.isNotChecked(column))
                addColumnsProjectWindow.checkColumn(column);
            else if ((state.equals("delete")) && addColumnsProjectWindow.isNotChecked(column)) {
                addColumnsProjectWindow.checkColumn(column);
            }
        }
    }

    @Then("{I |}'$condition' see following project fields on project folder page: $data")
    public void checkVisibleProjectsFields(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankFilesPage page = getFilesPage();
        List<String> actualFields = page.getProjectsFields();

        for (String expectedField : data.getHeaders())
            assertThat("Check Project Feilds:", actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    private void fillSharePopup(Map<String,String> fields, boolean isSecureShare) {
        ShareFilesPopup popup = new ShareFilesPopup(getSut().getPageCreator().getProjectFilesPage());
        if (fields.get("ExpireDate") == null || fields.get("ExpireDate").isEmpty()) {
            if (isSecureShare) {
                popup.checkNeverExpiresCheckbox();
            } else {
                popup.checkNeverPublicExpiresCheckbox();
            }
        } else {
            if (isSecureShare) {
                popup.uncheckNeverExpiresCheckbox();
            } else {
                popup.uncheckNeverPublicExpiresCheckbox();
            }

            popup.setExpirationDate(parseDateTime(fields.get("ExpireDate")).toString("dd/MM/yyyy"));
        }

        for (String userEmail : fields.get("UserEmails").split(",")) popup.typeUserEmails(wrapUserEmailWithTestSession(userEmail));
        if (fields.get("Message") != null) popup.typeMessage(fields.get("Message"));

        if (popup.isDownloadProxyCheckboxVisible()) {
            if (Boolean.parseBoolean(fields.get("DownloadProxy"))) {
                popup.checkDownloadProxyCheckbox();
            } else {
                popup.uncheckDownloadProxyCheckbox();
            }
        }

        if(popup.isDownloadOriginalCheckboxVisible()) {
            if (isSecureShare) {
                if (Boolean.parseBoolean(fields.get("DownloadOriginal"))) {
                    popup.checkDownloadOriginalCheckbox();
                } else {
                    popup.uncheckDownloadOriginalCheckbox();
                }
            }
        }
    }


    private void fillSharePopupNoDownloadPermission(Map<String,String> fields, boolean isSecureShare) {
        ShareFilesPopup popup = new ShareFilesPopup(getSut().getPageCreator().getProjectFilesPage());
        if (fields.get("ExpireDate") == null || fields.get("ExpireDate").isEmpty()) {
            if (isSecureShare) {
                popup.checkNeverExpiresCheckbox();
            } else {
                popup.checkNeverPublicExpiresCheckbox();
            }
        } else {
            if (isSecureShare) {
                popup.uncheckNeverExpiresCheckbox();
            } else {
                popup.uncheckNeverPublicExpiresCheckbox();
            }

            popup.setExpirationDate(parseDateTime(fields.get("ExpireDate")).toString("dd/MM/yyyy"));
        }

        for (String userEmail : fields.get("UserEmails").split(",")) popup.typeUserEmails(wrapUserEmailWithTestSession(userEmail));
        if (fields.get("Message") != null) popup.typeMessage(fields.get("Message"));


    }

    private String prepareAdstreamIngestPath(String path) {
        if (path.isEmpty()) throw new IllegalArgumentException("Path cannot be empty!");
        path = normalizePath(path);
        StringBuilder sb = new StringBuilder();
        String[] pathParts = path.split("/");
        for (int i = 0; i < pathParts.length; i++) {
            String[] parts = pathParts[i].split("-");
            for (int k = 0; k < parts.length; k++) {
                String wrappedPart = wrapVariableWithTestSession(parts[k]);
                if (k != 1)
                    sb.append(wrappedPart);
                else
                    sb.append(getCoreApiAdmin().getOrderByItemClockNumber(wrappedPart).getOrderReference());
                if (k != parts.length - 1) sb.append("-");
            }
            if (i != pathParts.length - 1) sb.append("/");
        }
        return sb.toString();
    }
}