package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentByFileSize;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectFilesPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectOverviewPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectTrashPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.page.jumploader.JumpLoaderProxy;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.jbehave.core.steps.Parameters;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.io.File;
import java.io.IOException;
import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 08.05.12 10:41
 */
public abstract class AbstractFolderSteps extends AbstractProjectTabsSteps {
    protected abstract AdbankFoldersTree getFoldersTree(String projectId, String parentId);

    protected abstract JumpLoaderPage getFilesUploadPage(String projectId, String folderId);

    protected abstract AdbankFilesPage getFilesPage(String projectId, String folderId);

    protected abstract AdbankFilesPage getFilesPage();

    protected void openObjectFilesPage(String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content rootFolder = getCoreApi(fsObject.getCreatedBy()).getProjectRootFolder(fsObject.getId());
        getFoldersTree(fsObject.getId(), rootFolder.getId());
    }

    protected AdbankFoldersTree openObjectFolderPage(String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder;
        if (path.matches(objectName + "|/|root|^$")) {
            folder = getCoreApi(fsObject.getCreatedBy()).getProjectRootFolder(fsObject.getId());
        } else {
            folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        }
        return getFoldersTree(fsObject.getId(), folder.getId());
    }

    protected AdbankFoldersTree openObjectFolderPage(String objectName, String path, User user) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName), user);
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        return getFoldersTree(fsObject.getId(), folder.getId());
    }

    protected AdbankFilesPage openObjectFilesPage(String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        return getFilesPage(fsObject.getId(), folder.getId());
    }

    protected void checkThatNewFolderButtonIsVisible(String shouldState, String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        assertThat(getFilesPage(fsObject.getId(), folder.getId()).isNewFolderButtonVisible(), equalTo(shouldState.equalsIgnoreCase("should")));
    }

    protected void checkThatShareFolderButtonIsVisible(String shouldState, String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        assertThat(getFilesPage(fsObject.getId(), folder.getId()).isShareButtonVisible(), equalTo(shouldState.equalsIgnoreCase("should")));
    }

    protected void checkThatShareFolderButtonIsEnable(String shouldState, String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        String folderId = path.matches(objectName + "|/|root|^$")
                ? getCoreApi(fsObject.getCreatedBy()).getProjectRootFolder(fsObject.getId()).getId()
                : getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path)).getId();

        assertThat(getFilesPage(fsObject.getId(), folderId).isShareButtonEnable(), equalTo(shouldState.equalsIgnoreCase("should")));
    }

    protected List<Content> createFoldersOverCoreApi(String projectName, ExamplesTable foldersTable) {
        List<Content> createdFolders = new ArrayList<>();
        for (Map<String, String> row : foldersTable.getRows()) {
            String folderName = row.get("folder");
            createdFolders.add(createFolderOverCoreApi(folderName, projectName));
        }
        return createdFolders;
    }

    /**
     * @param fileName - file name
     * @param path - folder path
     * @param objectName - fs object name
     */
    protected void createFile(String fileName, String path, String objectName) {
        String filePath = getFilePath(fileName);
        if (path.matches(objectName + "|/|root|^$")) {
            path = "/";
        }
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));

        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        if (file == null) {
            uploadFile(filePath, folder.getId());
        }
    }

    protected void createClientFile(String fileName, String path, String objectName,String email) {
        String filePath = getFilePath(fileName);
        if (path.matches(objectName + "|/|root|^$")) {
            path = "/";
        }
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        String[] url =getSut().getPageUrl().split("folders/");
        String[]  splitUrl = url[1].split("/files");
        final String folderId = splitUrl[0];
        Content file = getCoreApi().getFileByName(folderId, new File(filePath).getName());
        User user = getCoreApiAdmin().getUserByEmail(email);
        String userId = user.getId();
        if (file == null) {
            uploadClientFile(filePath, folderId, userId);
        }
    }

    private void uploadClientFile(String filePath, String folder,String userId) {
        getCoreApi().uploadClientFile(new File(filePath), folder, userId);
        long start = System.currentTimeMillis();
        do {
            Common.sleep(500);
        } while (getCoreApi().getFileByName(folder, new File(filePath).getName()) == null && System.currentTimeMillis() - start < 5000 );
    }

    private void uploadFile(String filePath, String folder) {
        getCoreApi().uploadFile(new File(filePath), folder);
        long start = System.currentTimeMillis();
        do {
            Common.sleep(500);
        } while (getCoreApi().getFileByName(folder, new File(filePath).getName()) == null && System.currentTimeMillis() - start < 5000 );
    }

    protected void createFileNVerge(String fileName, String path, String objectName) {
        String filePath = getFilePath(fileName);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        if (file == null) {
            getNVergeApi().uploadFileNverge(new File(filePath), folder.getId());
            long start = System.currentTimeMillis();
            do {
                Common.sleep(500);
            } while (getCoreApi().getFileByName(folder.getId(), new File(filePath).getName()) == null && System.currentTimeMillis() - start < 5000 );
        }
    }


    protected void createFileForSendplusUploadToProject(String fileName, String path, String objectName) throws IOException {
       try {

           String filePath = getFilePath(fileName);
           Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
           Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
           Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
           User user = getData().getCurrentUser();
           getNVergeApi().uploadFileToProjectViaSendplus(new File(filePath), folder.getId(), user.getEmail(), user.getPassword());
       }
       finally {

           editStorageBacktoNonS3();

       }
    }

    protected void editStorageBacktoNonS3()
    {
        int storageIndex = (int) (Thread.currentThread().getId() % getContext().storageId.length);
        Agency agency = getAgencyByName("DefaultAgency");
        agency.setStorageId(getContext().storageId[storageIndex]);
        getCoreApi().updateAgency(agency);
    }

    protected void downloadFolderAndProjectViaSendplus(String elementID, String fileID ) throws IOException
    {
        User user = getData().getCurrentUser();
        getNVergeApi().downloadFilesFromProjectAndFolderViaSendplus(user.getEmail(), user.getPassword(), elementID, fileID);

    }

    protected void createFileForSendplusUploadToLibrary(String fileName) throws IOException {

        try {
            String filePath = getFilePath(fileName);
            User user = getData().getCurrentUser();
            getNVergeApi().uploadFileToLibraryViaSendplus(new File(filePath), user.getEmail(), user.getPassword());
        }
        finally {
            editStorageBacktoNonS3();
        }
    }




    protected void createRevisions(String projectName, ExamplesTable filesTable) {
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            createRevision(row.get("FileName"), row.get("Path"), projectName, row.get("MasterFileName"));
        }
    }

    protected void createClientRevisions(String projectName, ExamplesTable filesTable) {
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            User user = getCoreApiAdmin().getUserByEmail(row.get("Email"));
            String userId = user.getId();
            createClientRevision(row.get("FileName"), row.get("Path"), projectName, row.get("MasterFileName"), userId);
        }
    }


    protected void uploadFileRevisionViaSendplus(String fileName, String fileId) throws IOException {


            String filePath = getFilePath(fileName);
            User user = getData().getCurrentUser();
            getNVergeApi().uploadFileRevisionToProjectViaSendplus(new File(filePath), fileId, user.getEmail(), user.getPassword());


    }

    protected void uploadFileAttachmentViaSendplus(String fileName, String fileId) throws IOException {


        String filePath = getFilePath(fileName);
        User user = getData().getCurrentUser();
        getNVergeApi().uploadFileAttachmentToProjectViaSendplus(new File(filePath), fileId, user.getEmail(), user.getPassword());


    }

    protected void downloadBySendplusFromFolder(String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        getFilesPage(object.getId(), null).downloadBySendplusFolder(folder.getId());

    }

    protected void createRevision(String fileName, String path, String objectName, String masterFileName) {
        String filePath = getFilePath(fileName);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content masterFile = getCoreApi().getFileByName(folder.getId(), masterFileName);
        getCoreApi().uploadRevision(new File(filePath), masterFile.getId());
        long start = System.currentTimeMillis();
        do {
            Common.sleep(1000);
        } while (getCoreApi().getFileByName(folder.getId(), masterFileName).getRevisions().length == masterFile.getRevisions().length
                && System.currentTimeMillis() - start < 10000);
    }

    protected void createRevisionFileInSharedSubFolder(String fileName, String path, String objectName, String masterFileName) {
        String filePath = getFilePath(fileName);
        String[] url =getSut().getPageUrl().split("files/");
        String[] splitUrl1 = url[1].split("/info");
        final String masterFileId = splitUrl1[0];;

        getCoreApi().uploadRevision(new File(filePath), masterFileId);

    }

    protected void createClientRevision(String fileName, String path, String objectName, String masterFileName, String UserId) {
        String filePath = getFilePath(fileName);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        String[] url =getSut().getPageUrl().split("folders/");
        String[]  splitUrl = url[1].split("/files");
        final String folderId = splitUrl[0];
        Content masterFile = getCoreApi().getFileByName(folderId, masterFileName);
        getCoreApi().uploadClientRevision(new File(filePath), masterFile.getId(), UserId);

        long start = System.currentTimeMillis();
        do {
            Common.sleep(1000);
        } while (getCoreApi().getFileByName(folderId, masterFileName).getRevisions().length == masterFile.getRevisions().length
                && System.currentTimeMillis() - start < 10000);
    }

    /**
     *
     * @param fileName - is file which will be attached
     * @param masterFileName - to this file, will be attached new file - fileName
     * @param path - folder, where is masterFileName is placed
     * @param objectName - project name
     */
    protected void createAttachedFile(String fileName, String masterFileName, String path, String objectName) {
        String filePath = getFilePath(fileName);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(masterFileName).getName());
        Content masterFile = getCoreApi().getFileByName(folder.getId(), masterFileName);
        getCoreApi().uploadAttachedFile(new File(filePath), masterFile, file.getId(), "fsobject");
        long start = System.currentTimeMillis();
        do {
            Common.sleep(1000);
        } while (getCoreApi().getFileByName(folder.getId(), masterFileName).getAttachedFiles().length == masterFile.getAttachedFiles().length
                && System.currentTimeMillis() - start < 10000);
    }

    protected void copyFile(String fileName, String pathTo, String pathFrom, String objectName) {
        String filePath = getFilePath(fileName);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folderFrom = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(pathFrom));
        Content folderTo = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(pathTo));
        Content file = getCoreApi().getFileByName(folderFrom.getId(), new File(filePath).getName());
        if (file != null) {
            getCoreApi().copyContent(file.getId(), folderTo.getId());
            long now = System.currentTimeMillis();
            while (getCoreApi().getFileByName(folderTo.getId(), new File(filePath).getName()) == null && System.currentTimeMillis() - now < 5000) { // wait for 5 sec
                Common.sleep(1000);
            }
        }  else {
            throw new NullPointerException("Following file " + fileName + " is not exist in folder " + pathFrom + " ! There is nothing to copy!");
        }
    }

    protected void moveFile(String fileName, String pathTo, String pathFrom, String objectName) {
        String filePath = getFilePath(fileName);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folderFrom = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(pathFrom));
        Content folderTo = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(pathTo));
        Content file = getCoreApi().getFileByName(folderFrom.getId(), new File(filePath).getName());
        if (file != null) {
            getCoreApi().moveContent(file.getId(), folderTo.getId());
            long now = System.currentTimeMillis();
            while (getCoreApi().getFileByName(folderTo.getId(), new File(filePath).getName()) == null && System.currentTimeMillis() - now < 5000) { // wait for 5 sec
                Common.sleep(1000);
            }
        } else {
            throw new NullPointerException("Following file " + fileName + " is not exist in folder " + pathFrom + " ! There is nothing to move!");
        }
    }

    protected void createFiles(String projectName, ExamplesTable filesTable) {
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            createFile(row.get("FileName"), row.get("Path"), projectName);
        }
    }

    protected void createFolder(String path, String objectName) {
        path = normalizePath(path);
        objectName = wrapVariableWithTestSession(objectName);
        createFolderRecursive(path, null, objectName);
    }

    protected WebElement selectFolder(String path, String objectName) {
        path = normalizePath(path);
        objectName = wrapVariableWithTestSession(objectName);
        return selectFolderRecursive(path, null, objectName);
    }

    protected void addFileFromLibrary(String objectName, String path, String fileName) {
        openAddFilesFromLibraryPopup(objectName, path);
        fillQueryFieldOnAddFilesFromLibraryPopup(fileName);
        selectFileOnAddFilesFromLibraryPopup(fileName);
        saveAddFilesFromLibraryPopup();
    }

    protected AddAssetsFromLibraryPopup openAddFilesFromLibraryPopup(String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));

        return getFilesPage(fsObject.getId(), folder.getId()).openAddAssetsFromLibraryPopup();
    }

    protected void fillQueryFieldOnAddFilesFromLibraryPopup(String query) {
        new AddAssetsFromLibraryPopup(getFilesPage()).fillQueryField(query);
    }

    protected void selectFileOnAddFilesFromLibraryPopup(String fileName) {
        new AddAssetsFromLibraryPopup(getFilesPage()).selectFileByName(fileName);
    }

    protected void saveAddFilesFromLibraryPopup() {
        new AddAssetsFromLibraryPopup(getFilesPage()).clickAction();
       // Common.sleep(1000);
    }

    protected void checkFolder(String shouldSee, String path, String projectName) {
        path = normalizePath(path);
        if (shouldSee.equalsIgnoreCase("should")) {
            projectName = wrapVariableWithTestSession(projectName);
            Project project = getObjectByName(projectName);
            checkFolderExistsRecursive(path, null, project.getId());
        } else {
            new TopLevelFolderExtractor(projectName, path) {
                @Override
                public void callBack() {
                    log.debug("Check that folder " + folderName + " with patent folder " + parentFolderId + " isn't on the page");
                    assertThat(foldersTree.getFolderLink(folderName, parentFolderId), nullValue());
                }
            };
        }
    }

    protected void checkFolderTrashBin(String shouldState, String path, String objectName) {
        path = normalizePath(path);
        if (shouldState.equalsIgnoreCase("should")) {
            objectName = wrapVariableWithTestSession(objectName);
            Project project = getObjectByName(objectName);
            checkFolderExistsRecursive(path, null, project.getId());
        } else {
            new TopLevelFolderExtractor(objectName, path) {
                @Override
                public void callBack() {
                    assertThat(foldersTree.getFolderLinkInTrash(folderName, parentFolderId), nullValue());
                }
            };
        }
    }

    protected void checkFolders(String objectName, ExamplesTable foldersTable) {
        for (Map<String, String> item : foldersTable.getRows()) {
            String condition = item.containsKey("should") ? item.get("should") : "should";
            checkFolder(condition, item.get("folder"), objectName);
        }
    }

    protected void checkFolders(String condition, String objectName, ExamplesTable foldersTable) {
        for (Map<String, String> item : foldersTable.getRows()) {
            checkFolder(condition, item.get("folder"), objectName);
        }
    }

    protected void checkFoldersTrashBin(String condition, String objectName, ExamplesTable foldersTable) {
        for (Map<String, String> item : foldersTable.getRows()) {
            checkFolderTrashBin(condition, item.get("folder"), objectName);
        }
    }

    protected void createFolders(int count, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        objectName = wrapVariableWithTestSession(objectName);
        String folderId = folder == null ? null : folder.getId();
        for (int i = 0; i < count; i++) {
            createFolderRecursive("F" + i, folderId, objectName);
        }
    }

    protected void deleteFolder(String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        getFilesPage(object.getId(), folder.getId()).removeFolder(folder.getId());
    }

    protected void cancelDeleteFolder(String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        getFilesPage(object.getId(), null).cancelRemoveFolder(folder.getId());
    }

    protected void crossDeleteFolder(String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        getFilesPage(object.getId(), null).cancelRemoveFolder(folder.getId());
    }

    protected void deleteFile(String objectName, String path, String fileName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        getCoreApi().deleteContent(file.getId());
    }

    protected void checkSubFoldersCount(int count, String path, String projectName) {
        path = normalizePath(path);
        AdbankFoldersTree foldersTree = getFoldersTreeByPath(projectName, path);
        assertThat(foldersTree.getFoldersLinks(foldersTree.getCurrentFolderId()).size(), equalTo(count));
    }

    protected void renameFolder(String path, String newName, String projectName) {
        AdbankFoldersTree foldersTree = getFoldersTreeByPath(projectName, path);
        foldersTree.renameFolder(foldersTree.getCurrentFolderId(), wrapVariableWithTestSession(newName));
    }

    protected void renameFolderOnOverviewPage(String path, String newName, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFoldersTree page = getFoldersTree(fsObject.getId(), null);
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        page.renameFolder(folder.getId(), wrapVariableWithTestSession(newName));
    }

    protected void cancelCreatingFolder(String path, String projectName) {
        new TopLevelFolderExtractor(projectName, path) {
            @Override
            public void callBack() {
                foldersTree.createFolderButClickCancel(folderName, parentFolderId);
            }
        };
    }

    protected void closeWindowCreatingFolder(String path, String projectName) {
        new TopLevelFolderExtractor(projectName, path) {
            @Override
            public void callBack() {
                foldersTree.createFolderButClickCloseWindowButton(folderName, parentFolderId);
            }
        };
    }

    protected boolean checkFile(String fileName, String path, String projectName) {
        fileName = new File(getFilePath(fileName)).getName();
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankProjectFilesPage filesPage = getSut().getPageNavigator().getProjectFilesPage(fsObject.getId(), folder.getId());
        return filesPage.isFilePresent(fileName);
    }

    protected boolean checkClientFile(String fileName, String path, String projectName) {
        fileName = new File(getFilePath(fileName)).getName();
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        String[] url =getSut().getPageUrl().split("folders/");
        String[]  splitUrl = url[1].split("/files");
        final String folderId = splitUrl[0];
        AdbankProjectFilesPage filesPage = getSut().getPageNavigator().getProjectFilesPage(fsObject.getId(), folderId);
        return filesPage.isFilePresent(fileName);
    }

    private void createFolderRecursive(String path, String parentId, String projectName) {
        String[] parts = path.split("/", 2);
        String folderName = wrapVariableWithTestSession(parts[0]);
        Project project = getObjectByName(projectName);
        AdbankFoldersTree foldersTree = getFoldersTree(project.getId(), parentId);
        if (parts.length == 2) {
            parentId = foldersTree.createFolder(folderName, parentId);
            createFolderRecursive(parts[1], parentId, projectName);
        } else {
            foldersTree.createFolder(folderName, parentId, true);
        }
    }

    private WebElement selectFolderRecursive(String path, String parentId, String projectName) {
        WebElement result;
        String[] parts = path.split("/", 2);
        String folderName = wrapVariableWithTestSession(parts[0]);
        Project project = getObjectByName(projectName);
        AdbankFoldersTree foldersTree = getFoldersTree(project.getId(), parentId);
        Common.sleep(1000);
        if (parts.length == 2) {
            if (this.getClass().toString().contains("Trash")) {
                parentId = foldersTree.extractFolderIdInTrash(foldersTree.selectFolderInTrash(folderName, parentId).getAttribute("href"));
            } else {
                parentId = foldersTree.extractFolderId(foldersTree.selectFolder(folderName, parentId).getAttribute("href"));
            }
            result = selectFolderRecursive(parts[1], parentId, projectName);
        } else {
            result = this.getClass().toString().contains("Trash")
                    ? foldersTree.selectFolderInTrash(folderName, parentId)
                    : foldersTree.selectFolder(folderName, parentId);
        }
        return result;
    }

    protected void checkSelectedFilesCount(int count, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folder.getId());
        assertThat(foldersTree.getSelectedFilesId().size(), equalTo(count));
    }

    // | FileName | FilesCount (optional) |
    protected void checkObjectFiles(String path, String objectName, ExamplesTable filesTable) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        String folderId;
        if (path == null) {
            folderId = null;
        } else if (path.equals("/")) {
            folderId = fsObject.getId();
        } else {
            folderId = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path)).getId();
        }
        AdbankFoldersTree filesPage = getFoldersTree(fsObject.getId(), folderId);
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            String fileName = row.get("FileName");
            if (row.containsKey("FilesCount")) {
                int filesCount = Integer.parseInt(row.get("FilesCount"));
                assertThat("Files count by name " + fileName, filesPage.getFilesCount(fileName), equalTo(filesCount));
            } else {
                assertThat("Files count by name " + fileName, filesPage.getFilesCount(fileName), greaterThan(0));
            }
        }
    }

    protected void checkFileApprovalStatusOnOverviewPage(String objectName, String fileName, String status) {
        String expectedState = getSut().getPageNavigator().getProjectOverviewPage(getObjectByName(wrapVariableWithTestSession(objectName)).getId()).getFileApprovalStatus(fileName);
        assertThat(String.format("Wrong approval status - is %s, but should be %s", expectedState, status), status.equalsIgnoreCase(expectedState));
    }

    protected void checkFileThumbnailForRevision(String path, String objectName, String filePath, int revision){
        String fileName = new File(filePath).getName();
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFoldersTree filesPage = getFoldersTree(fsObject.getId(), folder.getId());
        assertThat(filesPage.isThumbnailForRevisionVisible(getRevisionThumbnailFileId(fileName, path, objectName, revision)), equalTo(true));
    }

    protected void checkObjectWrappedFile(String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        AdbankProjectOverviewPage page = (AdbankProjectOverviewPage) getFoldersTree(fsObject.getId(), null);
        String fileTitle = page.getFileTitle(file.getId());
        assertThat(file.getName(), startsWith(fileTitle.substring(0, fileTitle.length() - 3)));
    }

    // | File |
    protected void addFilesForUpload(String path, String objectName, ExamplesTable filesTable) {
        JumpLoaderProxy jl = getJumpLoader(objectName, path);
        String filesFolder = getContext().testDataFolderName;
        for (Map<String, String> row : filesTable.getRows()) {
            jl.addFile(new File(filesFolder + row.get("File")));
        }
    }

    protected void startJumploaderUpload(String path, String objectName, String waitState) {
        JumpLoaderProxy jl = getJumpLoader(objectName, path);
        jl.startUpload();
        if (waitState.equalsIgnoreCase("wait")) {
            do {
                Common.sleep(1000);
            } while (getSut().getWebDriver().getCurrentUrl().endsWith("upload") && jl.isUploading());
            if (getSut().getWebDriver().getCurrentUrl().endsWith("upload"))
                assertThat("Check all finished", jl.getFileCountByStatus(JumpLoaderProxy.STATUS_FAILED), equalTo(0));
        }
    }

    public void stopJumploaderUpload(String path, String objectName, long bytesUploaded) {
        JumpLoaderProxy jl = getJumpLoader(objectName, path);
        do {
            Common.sleep(1000);
        } while (jl.getTransferProgress() != null && jl.getTransferProgress().getBytesTransferred() < bytesUploaded);
        jl.stopUpload();
        do {
            Common.sleep(1000);
        } while (jl.isUploading());
    }

    public void resumeJumploaderUpload(String path, String objectName, String waitState) {
        JumpLoaderProxy jl = getJumpLoader(objectName, path);
        for (int i = 0; i < jl.getFileCount(); i++) {
            jl.retryFileUploadAt(i);
        }
        if (waitState.equalsIgnoreCase("wait")) {
            do {
                Common.sleep(1000);
            } while (getSut().getWebDriver().getCurrentUrl().endsWith("upload") && jl.isUploading());
            if (getSut().getWebDriver().getCurrentUrl().endsWith("upload"))
                assertThat("Check files count with errors", jl.getFileCountByStatus(JumpLoaderProxy.STATUS_FAILED), equalTo(0));
        }
        Common.sleep(1000);
    }

    public void checkJumploaderUploadedVolume(long bytesUploaded, String path, String objectName) {
        JumpLoaderProxy jl = getJumpLoader(objectName, path);
        assertThat("Check bytes uploaded", jl.getTransferProgress().getBytesTransferred(), greaterThan(bytesUploaded));
    }

    public void checkJumploaderProgress(String is, String path, String objectName) {
        JumpLoaderProxy jl = getJumpLoader(objectName, path);
        if (is.equals("is")) {
            assertThat("Check uploading in progress", jl.isUploading(), equalTo(true));
            assertThat("Check progress bar exists", jl.getTransferProgress(), notNullValue());
        } else {
            assertThat("Check uploading in progress", jl.isUploading(), equalTo(false));
            assertThat("Check progress bar exists", jl.getTransferProgress(), nullValue());
        }
    }

    public void removeFileFromJumploader(int index, String path, String objectName) {
        JumpLoaderProxy jl = getJumpLoader(objectName, path);
        jl.removeFileAt(index - 1);
    }

    public void removeFilesFromJumploader(String path, String objectName) {
        JumpLoaderProxy jl = getJumpLoader(objectName, path);
        int count = jl.getFileCount();
        for (int i = 0; i < count; i++) {
            jl.removeFileAt(0);
        }
    }

    public void checkFilesCountInJumploader(int count, String path, String objectName) {
        JumpLoaderProxy jl = getJumpLoader(objectName, path);
        assertThat("Check files count", jl.getFileCount(), equalTo(count));
    }

    public void checkTrashBinFolderFiles(String condition, String objectName, String path, ExamplesTable fileNames) {
        boolean should = condition.equals("should");
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPathInTrash(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        selectFolder(path, objectName).click();    // due to NGN-2635
        Common.sleep(2000);
        for (Parameters parameters : fileNames.getRowsAsParameters(true)) {
            if (parameters.values().get("FileName") != null) {
                String fileName = parameters.valueAs("FileName", String.class);
                assertThat("I check that file: " + fileName + " is on the trash bin", filesPage.isFileVisible(fileName), equalTo(should));
                log.debug("I check that file: " + fileName + " is on the trash bin");
            }
        }
    }

    private JumpLoaderProxy getJumpLoader(String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        return getFilesUploadPage(fsObject.getId(), folder.getId()).getJumpLoader();
    }

    private void checkFolderExistsRecursive(String path, String parentId, String projectId) {
        String[] parts = path.split("/", 2);
        String folderName = wrapVariableWithTestSession(parts[0]);

        AdbankFoldersTree foldersTree = getFoldersTree(projectId, parentId);
        Common.sleep(2000);
        boolean workWithTrash = this.getClass().toString().contains("Trash");
        WebElement link = workWithTrash ? foldersTree.getFolderLinkInTrash(folderName, parentId) : foldersTree.getFolderLink(folderName, parentId);
        assertThat(link != null && link.isDisplayed(), equalTo(true));

        if (parts.length == 2) {
            foldersTree.expandFolder(folderName);
            link = workWithTrash ? foldersTree.getFolderLinkInTrash(folderName, parentId) : foldersTree.getFolderLink(folderName, parentId);
            parentId = workWithTrash ? foldersTree.extractFolderIdInTrash(link.getAttribute("href")) : foldersTree.extractFolderId(link.getAttribute("href"));
            checkFolderExistsRecursive(parts[1], parentId, projectId);
        }
    }

    private AdbankFoldersTree getFoldersTreeByPath(String projectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        String folderId = folder == null ? null : folder.getId();
        return getFoldersTree(fsObject.getId(), folderId);
    }

    private abstract class TopLevelFolderExtractor {
        protected AdbankFoldersTree foldersTree;
        protected String folderName;
        protected String parentFolderId;

        public TopLevelFolderExtractor(String projectName, String path) {
            path = normalizePath(path);
            int lastSlashIndex = path.lastIndexOf('/');
            folderName = wrapVariableWithTestSession(path.substring(lastSlashIndex + 1));
            path = lastSlashIndex == -1 ? "" : path.substring(0, lastSlashIndex);
            Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
            Content parentFolder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
            Project project = getObjectByName(wrapVariableWithTestSession(projectName));
            parentFolderId = parentFolder == null ? null : parentFolder.getId();
            foldersTree = getFoldersTree(project.getId(), parentFolderId);
            callBack();
        }

        public abstract void callBack();
    }

    protected void checkSelectedSortingTypeText(String sortingType, String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        assertThat(filesPage.getSelectedSortingType(), equalTo(sortingType));
    }

    protected void checkSelectedSortingTypeTextTrashBin(String sortingType, String objectName) {
        Project object = getObjectByName(wrapPathWithTestSession(objectName));
        AdbankFilesPage filesPage = getFilesPage(object.getId(), "");
        assertThat(filesPage.getSelectedSortingTypeTrashBin(), equalTo(sortingType));
    }

    protected void checkFilesSorting(String sortingType, String objectName, String path) {
        Common.sleep(1000);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        List<String> actualText = filesPage.getObjectsText();
        List<Content> filesSorted = getCoreApi().findFoldersContent(folder.getId(), new LuceneSearchingParams()).getResult();
        switch (sortingType) {
            case "Most recently uploaded First":
                Collections.sort(filesSorted, new Comparator<Content>() {
                    @Override
                    public int compare(Content o1, Content o2) {
                        return o2.getCreated().compareTo(o1.getCreated());
                    }
                });
                break;
            case "Most recently uploaded Last":
                Collections.sort(filesSorted, new Comparator<Content>() {
                    @Override
                    public int compare(Content o1, Content o2) {
                        return o1.getCreated().compareTo(o2.getCreated());
                    }
                });
                break;
            case "Most recently modified First":
                Collections.sort(filesSorted, new Comparator<Content>() {
                    @Override
                    public int compare(Content o1, Content o2) {
                        return o2.getModified().compareTo(o1.getModified());
                    }
                });
                break;
            case "Most recently modified Last":
                Collections.sort(filesSorted, new Comparator<Content>() {
                    @Override
                    public int compare(Content o1, Content o2) {
                        return o1.getModified().compareTo(o2.getModified());
                    }
                });
                break;
            case "Title (A to Z)":
                Collections.sort(filesSorted, new Comparator<Content>() {
                    @Override
                    public int compare(Content o1, Content o2) {
                        return o1.getName().toLowerCase().compareTo(o2.getName().toLowerCase());
                    }
                });
                break;
            case "Title (Z to A)":
                Collections.sort(filesSorted, new Comparator<Content>() {
                    @Override
                    public int compare(Content o1, Content o2) {
                        return o2.getName().toLowerCase().compareTo(o1.getName().toLowerCase());
                    }
                });
                break;
            case "Size (Descending)":
                filesSorted = sortFilesBySize(filesSorted, false);
                break;
            case "Size (Ascending)":
                filesSorted = sortFilesBySize(filesSorted, true);
                break;
            default:
                throw new IllegalArgumentException("Unknown sorting type");
        }
        assertThat("Files count", actualText.size(), equalTo(filesSorted.size()));
        for (int i = 0; i < actualText.size(); i++) {
            assertThat(actualText.get(i), equalTo(filesSorted.get(i).getName()));
        }
    }

    protected void checkFoldersSorting(boolean shouldState, List<String> expectedFoldersList) {
        List<String> actualFoldersList = getFilesPage().getFoldersTitles();

        if (expectedFoldersList.isEmpty()) {
            assertThat(actualFoldersList.isEmpty(), is(shouldState));
        } else {
            for (int i = 0; i < expectedFoldersList.size(); i++) {
                assertThat(actualFoldersList.get(i), shouldState ? equalTo(expectedFoldersList.get(i)) : not(equalTo(expectedFoldersList.get(i))));
            }
        }
    }

    protected void checkSortingForActivityOverviewPage(String objectName, ExamplesTable activitiesTable) {
        Common.sleep(1500);
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFoldersTree page = getFoldersTree(object.getId(), null);
        checkSortingForProjectActivities(page, activitiesTable);
    }

    protected void checkFilesSortingTrashBin(String sortingType, String objectName) {
        Common.sleep(1000);
        Project object = getObjectByName(wrapPathWithTestSession(objectName));
        AdbankFilesPage filesPage = getFilesPage(object.getId(), "");
        List<String> actualText = filesPage.getObjectsTextTrashBin();
        boolean isDate = false, isAscending = true;
        //todo implements after NGN-2535
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery("_subtype:element");
        switch (sortingType) {
            case "Deleted":
                query.setSortingField("_modified");
                query.setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING);
                break;
            case "Title (A to Z)":
                query.setSortingField("name.untouched");
                query.setSortingOrder(LuceneSearchingParams.ORDER_ASCENDING);
                break;
            case "Title (Z to A)":
                query.setSortingField("name.untouched");
                query.setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING);
                break;
            case "Size (Descending)":
                isDate = true;
                isAscending = false;
                break;
            case "Size (Ascending)":
                isDate = true;
                break;
            default:
                throw new IllegalArgumentException("Unknown sorting type");
        }
        List<Content> filesInTrashBin = getCoreApi().findTrashBinFiles(object.getId()).getResult();
        if (isDate) filesInTrashBin = sortFilesBySize(filesInTrashBin, isAscending);
        assertThat("Files count", filesInTrashBin.size(), equalTo(actualText.size()));
        for (int i = 0; i < actualText.size(); i++) {
            assertThat(actualText.get(i), equalTo(filesInTrashBin.get(i).getName()));
        }
    }

    protected void typeFolderName(String folderName, String objectName, String currentPath) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(currentPath));
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folder.getId());
        foldersTree.typeFolderNameInSearchFoldersField(wrapVariableWithTestSession(folderName));
    }

    protected void checkFolderSearching(String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        assertThat("We're on the wrong page. Search folders is not working!!!", getSut().getWebDriver().getCurrentUrl(), containsString(folder.getId()));
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folder.getId());
        path = wrapPathWithTestSession(path);
        String folderPath = foldersTree.getFoldersPath();
        assertThat(folderPath, containsString(path));
    }

    protected void waitForFileAvailableInDatabase(String objectName, String path, String fileName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        long start = System.currentTimeMillis();
        boolean finished;

        do {
            Common.sleep(2000);
            finished = getCoreApi().getFileByName(folder.getId(), new File(fileName).getName()) != null;
            if (!finished) Common.sleep(3000);
        } while (System.currentTimeMillis() - start < 60000 && !finished); // wait 60 seconds

        if (!finished) throw new TimeoutException("Timeout while waiting for file uploading");
    }

    protected void waitForSpecAvailable(String objectName, String path) {
        waitForSpecOrPreview(objectName, path, false);
    }

    protected void waitForPreviewAvailable(String objectName, String path) {
        waitForSpecOrPreview(objectName, path, true);
    }

    protected void waitForPreviewAvailableForClientUsers(String objectName, String path,String email) {
        waitForSpecOrPreviewForClientUsers(objectName, path,email, true);
    }

    protected void waitForSpecOrPreviewForClientUsers(String objectName, String path,String email, boolean waitForPreview) {
        User user = getCoreApiAdmin().getUserByEmail(email);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        if (path.matches(objectName + "|/|root|^$"))
            path = "/";
        String[] url =getSut().getPageUrl().split("folders/");
        String[]  splitUrl = url[1].split("/files");
        final String folderId = splitUrl[0];
        final String userId = user.getId();
        getFilesPage(fsObject.getId(), folderId);
        Common.sleep(1000);
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return getCoreApi().findClientFoldersContent(folderId, userId, new LuceneSearchingParams()).getResult();
            }

            @Override
            public void doActionWhileWaiting() {
                getFilesPage();
            }
        }.process(waitForPreview);

        getSut().getWebDriver().navigate().refresh();
        getFilesPage(fsObject.getId(), folderId);
    }


    /**
     * @param objectName - is fs object name
     * @param path - folder path
     * @param waitForPreview - if false we will wait for spec only
     */
    protected void waitForSpecOrPreview(String objectName, String path, boolean waitForPreview) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        if (path.matches(objectName + "|/|root|^$"))
            path = "/";
        final String folderId = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path)).getId();

        getFilesPage(fsObject.getId(), folderId);
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return getCoreApi().findFoldersContent(folderId, new LuceneSearchingParams()).getResult();
            }

            @Override
            public void doActionWhileWaiting() {
                getFilesPage();
            }
        }.process(waitForPreview);

        getSut().getWebDriver().navigate().refresh();
        getFilesPage(fsObject.getId(), folderId);
    }

    protected void waitForFileSpecAvailableInSpecificRevision(String objectName, String path, String fileName, int revision) {
        waitForFileSpecOrPreviewInSpecificRevision(objectName, path, fileName, revision, false);
    }

    protected void waitForFilePreviewAvailableInSpecificRevision(String objectName, String path, String fileName, int revision) {
        waitForFileSpecOrPreviewInSpecificRevision(objectName, path, fileName, revision, true);
    }

    protected void waitForFileSpecOrPreviewInSpecificRevision(String objectName, String path, String filePath, int revision, boolean waitForPreview) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        final String folderId = path.matches(objectName + "|/|root|^$")
                ? fsObject.getId() : getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path)).getId();
        final String fileName = new File(filePath).getName();

        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getCoreApi().getFileByName(folderId, fileName));
            }

            @Override
            public void doActionWhileWaiting() {
                getSut().getPageCreator().getBasePage();
            }
        }.process(waitForPreview, revision);

        getSut().getWebDriver().navigate().refresh();
        getFilesPage(fsObject.getId(), folderId);
    }

    protected void checkFileUploadComplete(String filePath, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        getFilesPage(fsObject.getId(), folder.getId());
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        assertThat(file.getStatus(), equalTo("completed"));
    }

    protected void setMediaSubType(String mediaSubType, String fileName, String path, String projectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        file.setMediaSubType(mediaSubType);
        getCoreApi().updateContent(file);
    }

    protected void setFileTitle(String title, String fileName, String path, String projectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        file.setName(title);
        getCoreApi().updateContent(file);
    }

    protected void openShareFromPopUp(String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Common.sleep(2000);
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        String folderId = folder == null ? fsObject.getId() : folder.getId();
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folderId);
        Common.sleep(5000);
        foldersTree.clickShare(folderId);
        Common.sleep(2000);
    }

    protected void openShareFromPopUpForClientUsers(String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        String[] url =getSut().getPageUrl().split("folders/");
        String[]  splitUrl = url[1].split("/files");
        final String folderId = splitUrl[0];
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folderId);
        Common.sleep(5000);
        foldersTree.clickShare(folderId);
        Common.sleep(2000);
    }


    protected void downloadBySendplusFromPopUpAtFolder(String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        String folderId = folder == null ? fsObject.getId() : folder.getId();
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folderId);
        foldersTree.downloadBySendplusFolder(folderId);
        Common.sleep(2000);
    }

    protected void downloadBySendplusFromPopUpAtProject(String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        String folderId = folder == null ? fsObject.getId() : folder.getId();
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folderId);
        foldersTree.downloadBySendplusFolder(fsObject.getId());
        Common.sleep(2000);
    }

    protected void openFoldersMenu(String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folder.getId());
        foldersTree.openFolderMenu(folder.getId());
    }

    protected void openFoldersMenuOverviewPage(String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        String folderId = folder == null ? null : folder.getId();
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), null);
        foldersTree.openFolderMenu(folderId);
        Common.sleep(1000);
    }

    protected void checkItemsInPopUp(String shouldState, String path, String objectName, ExamplesTable itemsTable) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folder.getId());
        boolean should = shouldState.equals("should");
        for (Map<String, String> row : itemsTable.getRows()) {
            String textItem = row.get("item");
            assertThat(should, equalTo(foldersTree.isItemsPresentInFoldersPopUpMenu(textItem)));
        }
    }

    protected void checkItemsInPopUpOverviewPage(String shouldState, String objectName, ExamplesTable itemsTable) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFoldersTree foldersTree = getFoldersTree(object.getId(), null);
        boolean should = shouldState.equals("should");
        Common.sleep(1000);
        for (int i = 0; i < itemsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(itemsTable, i);
            String textItem = row.get("item");
            assertThat(foldersTree.isItemsPresentInFoldersPopUpMenu(textItem), equalTo(should));
        }
    }

    protected void openUploadedFile(String fileName, String path, String objectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        filesPage.openLoadedFile(fileName);
    }

    protected void deleteFiles(String objectName, String path, ExamplesTable fileNames) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        for (int i = 0; i < fileNames.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fileNames, i);
            filesPage.selectFileByFileName(row.get("FileName"));
        }
        filesPage.clickMoreButton();
        filesPage.clickDeleteMenuItem();
        filesPage.clickDeleteButtonOnPopupWindow();
        Common.sleep(1000);
    }

    // enabledFilters comma separated
    // possible values: IMAGE, AUDIO, VIDEO, PRINT, DIGITAL
    protected void enableMediaTypeFilter(String projectName, String path, String enabledFilters) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage page = getFilesPage(fsObject.getId(), folder.getId());
        List<AdbankFilesPage.MediaType> enabledTypes = new ArrayList<>();
        for (String enabledFilter : enabledFilters.split(",")) {
            if (enabledFilter.isEmpty()) continue;
            enabledTypes.add(AdbankFilesPage.MediaType.valueOf(enabledFilter));
        }
        for (AdbankFilesPage.MediaType mediaType : AdbankFilesPage.MediaType.values()) {
            page.setMediaTypeFilterEnabled(mediaType, enabledTypes.contains(mediaType));
        }
    }

    // enabledFilters comma separated
    // possible values: IMAGE, AUDIO, VIDEO, PRINT, DIGITAL
    protected void enableMediaTypeFilterTrashBin(String enabledFilters ,String objectName,String path) {
        AdbankFilesPage filesPage = getTrashBinFilesPage(objectName, path);
        List<AdbankFilesPage.MediaType> enabledTypes = new ArrayList<>();
        for (String enabledFilter : enabledFilters.split(",")) {
            if (enabledFilter.isEmpty()) continue;
            enabledTypes.add(AdbankFilesPage.MediaType.valueOf(enabledFilter));
        }
        for (AdbankFilesPage.MediaType mediaType : AdbankFilesPage.MediaType.values()) {
            filesPage.setMediaTypeFilterEnabled(mediaType, enabledTypes.contains(mediaType));
        }
    }

    protected void selectMediaSubTypeFilter(String projectName, String path, String subType) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        getFilesPage(fsObject.getId(), folder.getId()).selectMediaSubType(subType);
    }

    protected void selectMediaSubTypeFilterTrashBin(String objectName, String path, String subType) {
        AdbankFilesPage filesPage = getTrashBinFilesPage(objectName, path);
        filesPage.selectMediaSubType(subType);
        Common.sleep(500);
    }

    // | Media Type | Enabled |
    protected void checkMediaTypeFilterState(String projectName, String path, ExamplesTable stateTable) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage page = getFilesPage(fsObject.getId(), folder.getId());
        for (int i = 0; i < stateTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(stateTable, i);
            AdbankFilesPage.MediaType type = AdbankFilesPage.MediaType.valueOf(row.get("Media Type"));
            boolean enabled = Boolean.parseBoolean(row.get("Enabled"));
            assertThat(page.isMediaTypeFilterEnabled(type), equalTo(enabled));
        }
    }

    protected void restoreFileFromTrashBin(String fileName, String objectName, String path) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFilesPage filesPage = getFilesPage(object.getId(), "");
        SelectFolderRestorePopUpWindow restorePopUpWindow = filesPage.clickRestoreButtonSelectedFileOnTrashBinPage(fileName);
        restorePopUpWindow.selectFolder(wrapPathWithTestSession(path));
        restorePopUpWindow.action.click();
    }

    protected void restoreFolderFromTrashBin(String path, String objectName, String toFolderPath) {
        AdbankFilesPage filesPage = getTrashBinFilesPage(objectName, path);
        Content folder = getTrashBinFolder(objectName, path);
        if (!toFolderPath.equals("Root folder")) {
            toFolderPath = wrapPathWithTestSession(toFolderPath);
        }
        filesPage.restoreFolder(folder.getId(), toFolderPath);
    }

    protected void clickRestoreFileTrashBin(String fileName, String objectName) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFilesPage filesPage = getFilesPage(object.getId(), "");
        filesPage.clickRestoreButtonSelectedFileOnTrashBinPage(fileName);
    }

    protected void restoreMultipleFilesFromTrashBin(String objectName, String path) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFilesPage filesPage = getFilesPage(object.getId(), "");
        SelectFolderRestorePopUpWindow restorePopUpWindow = filesPage.clickRestoreButtonOnTrashBinPage();
        restorePopUpWindow.selectFolder(wrapPathWithTestSession(path));
        restorePopUpWindow.action.click();
    }

    protected void checkFoldersExistTrashBinRestorePopUp(String shouldState, String path, String fileName, String objectName) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFilesPage filesPage = getFilesPage(object.getId(), "");
        boolean should = shouldState.equals("should");
        SelectFolderRestorePopUpWindow restorePopUpWindow = filesPage.clickRestoreButtonSelectedFileOnTrashBinPage(fileName);
        assertThat(restorePopUpWindow.isFolderExists(wrapPathWithTestSession(path)), equalTo(should));
    }

    protected void checkFoldersExistTrashBinRestoreFolderPopUp(String shouldState, String toFolderPath, String path, String objectName) {
        AdbankFilesPage filesPage = getTrashBinFilesPage(objectName, path);
        Content folder = getTrashBinFolder(objectName, path);
        boolean should = shouldState.equals("should");
        if (!toFolderPath.equals("Root folder")) {
            toFolderPath = wrapPathWithTestSession(toFolderPath);
        }
        SelectFolderRestorePopUpWindow restorePopUpWindow = filesPage.clickRestoreButtonForFolder(folder.getId());
        assertThat(restorePopUpWindow.isFolderExists(toFolderPath), equalTo(should));
    }

    protected void clickRestoreForFolder(String path, String objectName) {
        AdbankFilesPage filesPage = getTrashBinFilesPage(objectName, path);
        Content folder = getTrashBinFolder(objectName, path);
        filesPage.clickRestoreButtonForFolder(folder.getId());
    }

    protected void cancelRestoringFileFromTrashBin(String fileName, String objectName, String path) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFilesPage filesPage = getFilesPage(object.getId(), "");
        SelectFolderRestorePopUpWindow restorePopUpWindow = filesPage.clickRestoreButtonSelectedFileOnTrashBinPage(fileName);
        restorePopUpWindow.selectFolder(wrapPathWithTestSession(path));
        restorePopUpWindow.cancel.click();
    }

    protected void closeByCrossTrashBinRestoreFilePopUp(String fileName, String objectName, String path) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFilesPage filesPage = getFilesPage(object.getId(), "");
        SelectFolderRestorePopUpWindow restorePopUpWindow = filesPage.clickRestoreButtonSelectedFileOnTrashBinPage(fileName);
        restorePopUpWindow.selectFolder(wrapPathWithTestSession(path));
        restorePopUpWindow.close.click();
    }

    protected void closeByCrossTrashBinRestoreFolderPopUp(String path, String objectName, String toFolderPath) {
        AdbankFilesPage filesPage = getTrashBinFilesPage(objectName, path);
        Content folder = getTrashBinFolder(objectName, path);
        if (!toFolderPath.equals("Root folder")) {
            toFolderPath = wrapPathWithTestSession(toFolderPath);
        }
        filesPage.crossRestoreFolder(folder.getId(), toFolderPath);
    }

    protected void cancelRestoreFolderFromTrashBin(String path, String objectName, String toFolderPath) {
        AdbankFilesPage filesPage = getTrashBinFilesPage(objectName, path);
        Content folder = getTrashBinFolder(objectName, path);
        if (!toFolderPath.equals("Root folder")) {
            toFolderPath = wrapPathWithTestSession(toFolderPath);
        }
        filesPage.cancelRestoreFolder(folder.getId(), toFolderPath);
    }

    protected void checkTrashBinFiles(String condition, String objectName, ExamplesTable fileNames) {
        boolean should = condition.equals("should");
        Project object = getObjectByName(wrapPathWithTestSession(objectName));
        AdbankFilesPage filesPage = getFilesPage(object.getId(), "");
        for (Parameters parameters : fileNames.getRowsAsParameters(true)) {
            if (parameters.values().get("FileName") != null) {
                String fileName = parameters.valueAs("FileName", String.class);
                assertThat("I check that file: " + fileName + " is on the trash bin", filesPage.isFileVisible(fileName), equalTo(should));
                log.debug("I check that file: " + fileName + " is on the trash bin");
            }
        }
    }

    protected void checkTrashBinFiles(String fileNames, String objectName, String path) {
        AdbankFilesPage filesPage = getTrashBinFilesPage(objectName, path);
        StringBuilder tableAsString = new StringBuilder("|FileName|\r\n");
        for (String fileName : fileNames.split(",")) {
            if (fileName.isEmpty()) continue;
            tableAsString.append("|").append(fileName).append("|\r\n");
        }
        ExamplesTable filesTable = new ExamplesTable(tableAsString.toString());
        for (Map<String, String> row : filesTable.getRows()) {
            String fileName = row.get("FileName");
            assertThat("Files count by name " + fileName, filesPage.getFilesCountByFileName(fileName), greaterThan(0));
        }
        assertThat("Count of files in trash bin is wrong after applying filtering!", filesPage.getAllFilesCountTrashBin(), equalTo(filesTable.getRowCount()));
    }

    protected void checkMediaSubTypeDisabled(String shouldState, String objectName, String path) {
        AdbankFilesPage filesPage = getTrashBinFilesPage(objectName, path);
        boolean should = shouldState.equals("should");
        assertThat(filesPage.isMediaSubTypeDisabled(), equalTo(should));
    }

    protected void checkFiles(String condition, String fileName, String objectName, String path) {
        boolean should = condition.equals("should");
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        String folderId = path == null ? null : getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path)).getId();
        AdbankFoldersTree filesPage = getFoldersTree(fsObject.getId(), folderId);
        Common.sleep(3000);
        getSut().getWebDriver().navigate().refresh();
        Common.sleep(6000);
        String[] fileArray = fileName.split(",");
        for (String fN: fileArray) {
            assertThat(filesPage.isFileVisible(fN), equalTo(should));
        }
    }

//1096 Merge
protected void checkFilesonOverview(String condition, String fileName, String objectName, String path) {
        boolean should = condition.equals("should");
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        String folderId = path == null ? null : getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path)).getId();
        AdbankFoldersTree filesPage = getFoldersTree(fsObject.getId(), folderId);
        String[] fileArray = fileName.split(",");
        for (String fN: fileArray) {
            assertThat(filesPage.isFileVisibleonoverview(fN), equalTo(should));
        }
    }
   // 1096 Merge

    protected void checkFilesOnFilesPage(String condition, String objectName, String path, ExamplesTable filesName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        boolean should = condition.equals("should");
        for (Parameters parameters : filesName.getRowsAsParameters(true)) {
            if (parameters.values().get("FileName") != null) {
                assertThat(filesPage.isFileVisible(parameters.valueAs("FileName", String.class)), equalTo(should));
            }
        }
    }

    protected void checkFilesOnFilesPage(String condition, String objectName, String path, User user, ExamplesTable filesName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        boolean should = condition.equals("should");
        for (Parameters parameters : filesName.getRowsAsParameters(true)) {
            if (parameters.values().get("FileName") != null) {
                assertThat(filesPage.isFileVisible(parameters.valueAs("FileName", String.class)), equalTo(should));
            }
        }
    }

    protected void deleteAllFilesFromFilesPage(String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        filesPage.clickMoreButton();
        filesPage.clickDeleteMenuItem();
        filesPage.clickDeleteButtonOnPopupWindow();
    }

    protected void checkFilesPreview(String folderName, String projectName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        String folderId = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapVariableWithTestSession(folderName)).getId();
        AdbankFilesPage adbankProjectFilesPage = getFilesPage(fsObject.getId(), folderId);
        assertThat("File preview is not visible", adbankProjectFilesPage.isFilePreviewVisible(), equalTo(true));
    }

    protected void checkFileOnThePageAfterDelete(String condition, String fileName) {
        boolean should = condition.equals("should");
        AdbankFilesPage adbankObjectFilesPage = getFilesPage();
        String[] fileArray = fileName.split(",");
        for (String fN: fileArray) {
            assertThat("File with name: '" + fN + "' has problem with visibility",
                    adbankObjectFilesPage.isFileVisible(fN), equalTo(should));
        }
    }

    protected void clickCopyButton() {
        AdbankFilesPage adbankObjectFilesPage = getFilesPage();
        adbankObjectFilesPage.clickMoreButton();
        adbankObjectFilesPage.clickCopyMenuItem();
    }

    protected void checkFileAndFileCountOnThePage(String condition, String fileNames, String count) {
        int actualCount = 0;
        boolean shouldState = condition.equals("should");
        int expectedCount = Integer.parseInt(count);
        Common.sleep(4000);
        for (String fileName: fileNames.split(",")) {
            actualCount+= getFilesPage().getFilesCount(fileName);
                    }
        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));
    }

    protected void checkFileAndFileCountOnThePageForSearch(String condition, String fileName, int count) {
        boolean should = condition.equals("should");
        AdbankFilesPage adbankProjectFilesPage = getFilesPage();
        assertThat(adbankProjectFilesPage.getCountOfFoundedItems(fileName) == count, is(should));
    }

    protected void clickWantToCopyFilesToAnotherProjectLinkOnMoveFilePopup(String fileName) {
        AdbankFilesPage adbankObjectFilesPage = getFilesPage();
        String[] fileArray = fileName.split(",");
        for (String fN : fileArray) {
            adbankObjectFilesPage.selectFileByFileName(fN);
        }
        adbankObjectFilesPage.clickMoreButton();
        MoveCopyPopUpWindow moveCopyPopUpWindow = adbankObjectFilesPage.clickCopyMenuItem();
        moveCopyPopUpWindow.clickWantToCopyFilesToAnotherProjectLink();
    }

    protected void checkSearchInputOnMoveCopyPopupMenu(String condition) {
        boolean should = condition.equals("should");
        AdbankFilesPage adbankObjectFilesPage = getFilesPage();
        assertThat(adbankObjectFilesPage.isSearchInputVisible(), equalTo(should));
    }

    protected void searchFile(String objectName, String folderName, String searchType, String fileName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(folderName));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        filesPage.searchObject(fileName);
        filesPage.clickSearchInCurrentProject();
    }

    protected void clickShowAllResults() {
        AdbankFilesPage filesPage = getFilesPage();
        filesPage.clickShowAllResults();
    }

    protected void checkSearchDropdown(String objectName, String text) {
        AdbankFilesPage adbankObjectFilesPage = getFilesPage();
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(adbankObjectFilesPage);
        List<String> listOfAvailableObjects = moveCopyPopUpWindow.getAllFoundObjects();
        if (objectName.isEmpty()) {
            assertThat(listOfAvailableObjects.isEmpty(), is(true));
        } else if (listOfAvailableObjects.size()>= 8) {
            for (String listElement : listOfAvailableObjects) {
                assertThat(listElement.startsWith(text), equalTo(true));
            }
        } else {
            String[] arrayObjectName = objectName.split(",");
            for (String object : arrayObjectName) {
                assertThat(listOfAvailableObjects, hasItem(wrapVariableWithTestSession(object)));
            }
            for (String listElement: listOfAvailableObjects) {
                assertThat(listElement.startsWith(text), equalTo(true));
            }
        }
    }

    protected void typeSearchTextOnMoveCopyFilePopup(String text) {
        AdbankFilesPage adbankFilesPage = getFilesPage();
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(adbankFilesPage);
        moveCopyPopUpWindow.typeSearchText(text);
        Common.sleep(1000);
    }

    protected void enterSearchTextOnMoveCopyFilePopup(String objectName) {
        AdbankFilesPage adbankFilesPage = getFilesPage();
        MoveCopyPopUpWindow moveCopyPopUpWindow = new MoveCopyPopUpWindow(adbankFilesPage);
        objectName = wrapVariableWithTestSession(objectName);
        moveCopyPopUpWindow.typeSearchText(objectName);
        Common.sleep(1000);
        moveCopyPopUpWindow.clickSearchButton();
        Common.sleep(1000);
    }

    protected void checkFilePage(String objectName, String path, String fileName) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        String expectedPage = String.format("/projects/projects/%s/folders/%s/files/%s/info", fsObject.getId(), folder.getId(), file.getId());
        assertThat(BabylonSteps.getCurrentPageName(), equalTo(expectedPage));
    }

    protected void checkActivityOverviewPage(String objectName, ExamplesTable activitiesTable, boolean sorted) {
        Common.sleep(1500);
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFoldersTree page = getFoldersTree(object.getId(), null);
        checkActivities(page, activitiesTable, sorted);
    }

    protected void updateFileContent(String filePath, String fileTitleNew, String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        Content fileContent = getCoreApi().getContent(file.getId());
        fileContent.setName(fileTitleNew);
        getCoreApi().updateContent(fileContent);
    }

    protected void checkSelectedFilesTrashBin(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFileNames = getFilesPage().getAllSelectedFileNames();

        for (Map<String,String> row : parametrizeTableRows(data))
            assertThat(actualFileNames, shouldState ? hasItem(row.get("FileName")) : not(hasItem(row.get("FileName"))));
    }

    protected void checkCountFileByFileNameTrashBin(String condition, int quantity, String fileName) {
        boolean should = condition.equals("should");
        AdbankProjectTrashPage adbankProjectTrashPage = getSut().getPageCreator().getProjectTrashPage();
        assertThat("I check count of files with the same name in the trash bin",
                adbankProjectTrashPage.getFilesCountByFileName(fileName) == quantity, is(should));
    }

    private List<Content> sortFilesBySize(List<Content> files, boolean isAscending) {
        Collections.sort(files, new ComparatorContentByFileSize());
        if (!isAscending)
            Collections.reverse(files);
        return files;
    }

    protected AdbankFilesPage getTrashBinFilesPage(String objectName, String path) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        if (path.isEmpty()) {
            return getFilesPage(object.getId(), "");    // trash bin page
        } else {
            path = normalizePath(wrapPathWithTestSession(path));
            getFilesPage(object.getId(), "");    // trash bin page
            List<Content> folders = getCoreApi().findTrashBinFolders(object.getId()).getResult();
            for (Content folder: folders) {
                if (folder.getName().equals(path))  {
                    return getFilesPage(object.getId(), folder.getId());   // trash bin folder's page
                }
            }
        }
        throw new IllegalArgumentException("Cannot open trash bin files page due to non existent folder path " + path + " in it!!!");
    }

    private Content getTrashBinFolder(String objectName, String path) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        String folderName = wrapPathWithTestSession(normalizePath(path));
        List<Content> folders = getCoreApi().findTrashBinFolders(object.getId()).getResult();
        for (Content folder : folders) {
            if (folder.getName().equals(folderName)) {
                return folder;
            }
        }
        return null;
    }

    protected void sendFileToLibrary(String fileName, String objectName, String path) {
        AdbankFilesPage filesPage = openObjectFilesPage(objectName, path);
        String[] fileNames = fileName.split(",");
        for (String fName : fileNames) {
            filesPage.selectFileByFileName(fName);
        }
        filesPage.clickMoreButton();
        filesPage.clickSendToLibrary();
    }
    //  !--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Starts
    protected void sendFileToLibraryButton(String fileName, String objectName, String path) {
        AdbankFilesPage filesPage = openObjectFilesPage(objectName, path);
        String[] fileNames = fileName.split(",");
        for (String fName : fileNames) {
            filesPage.selectFileByFileName(fName);
        }
        filesPage.clickMoreButton();
        filesPage.clickSendToLibraryButton();
    }
    //  !--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Ends
    protected void clickSendToDelivery(String fileNamesList, String objectName, String path) {
        AdbankFilesPage filesPage = openObjectFilesPage(objectName, path);
        String[] fileNames = fileNamesList.split(",");
        for (String fName : fileNames)
            filesPage.selectFileByFileName(getAssetName(fName));
        filesPage.clickMoreButton();
        filesPage.clickSendToDelivery();
    }

    protected void sendFilesToDelivery(String fileNamesList, String objectName, String path) {
        AdbankFilesPage filesPage = openObjectFilesPage(objectName, path);
        String[] fileNames = fileNamesList.split(",");
        for (String fName : fileNames)
            filesPage.selectFileByFileName(getAssetName(fName));
        filesPage.clickMoreButton();
        filesPage.sendToDelivery();
    }

    protected void clickUserInActivities(String objectName, String userName) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFoldersTree page = getFoldersTree(object.getId(), null);
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        page.clickUserInActivities(user);
    }

    protected void clickFileInActivities(String objectName, String fileName) {
        Project object = getObjectByName(wrapVariableWithTestSession(objectName));
        AdbankFoldersTree page = getFoldersTree(object.getId(), null);
        page.clickFileInActivities(fileName);
    }

    //Download Attachment
    protected void downloadAttachedFile(String fileName, String masterFileName, String path, String objectName) {
        String filePath = getFilePath(fileName);
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content masterFile = getCoreApi().getFileByName(folder.getId(), masterFileName);
        getCoreApi().uploadAttachedFile(new File(filePath), masterFile,objectName, "fsobject");
        long start = System.currentTimeMillis();
        do {
            Common.sleep(1000);
        } while (getCoreApi().getFileByName(folder.getId(), masterFileName).getAttachedFiles().length == masterFile.getAttachedFiles().length
                && System.currentTimeMillis() - start < 10000);
    }

    protected void checkVisibilityDownloadLinkDownloadMasterBtn(String shouldState, String fileName, String objectName, String path) {
        AdbankFilesPage filesPage = openObjectFilesPage(objectName, path);
        DownloadFilePopUpWindow downloadFilePopUpWindow = filesPage.clickDownloadButton();
        boolean should = shouldState.equals("should");
        assertThat("Download checkbox " + shouldState + " be visible on Download popup!",
                downloadFilePopUpWindow.downloadMasters.isVisible(), equalTo(should));
    }

    // linkType: original,preview,proxy
    protected void checkVisibilityDownloadLink(String shouldState, String objectName, String path, String linkType) {
        AdbankFilesPage filesPage = openObjectFilesPage(objectName, path);
        DownloadFilePopUpWindow downloadFilePopUpWindow = filesPage.clickDownloadButton();
        boolean should = shouldState.equals("should");
        switch (linkType.toLowerCase()) {
            case "original":
                assertThat("Download masters checkbox " + shouldState + " be visible on Download popup!",
                        downloadFilePopUpWindow.downloadMasters.isVisible(), equalTo(should));
                break;
            case "preview":
            case "proxy":
                assertThat("Download proxies checkbox " + shouldState + " be visible on Download popup!",
                        downloadFilePopUpWindow.downloadProxies.isVisible(), equalTo(should));
                break;
            default:
                throw new IllegalArgumentException("Type of link incorrect. It must be 'original', 'preview' or 'proxy'");
        }
    }

    protected void checkDownloadButtonButtons(String shouldState, String objectName, String path) {
        AdbankFilesPage filesPage = openObjectFilesPage(objectName, path);
        DownloadFilePopUpWindow downloadFilePopUpWindow = filesPage.clickDownloadButton();
        Common.sleep(1000);
        boolean should = shouldState.equals("should");

        assertThat("Download button " + shouldState + " be visible on Download popup!",
                downloadFilePopUpWindow.isDownloadButtonEnabled(), equalTo(should));
        assertThat("Download using nVerge button " + shouldState + " be visible on Download popup!",
                downloadFilePopUpWindow.isDownloadButtonNVergeEnabled(), equalTo(should));
    }

    protected void checkDownloadLinkPopupMasternVergForCurrentObject(String shouldState, String fileName) {
        AdbankFilesPage filesPage = getFilesPage();
        DownloadFilePopUpWindow downloadFilePopUpWindow = new DownloadFilePopUpWindow(filesPage);
        boolean should = shouldState.equals("should");
        assertThat("Download link " + shouldState + " be visible on Download popup!", downloadFilePopUpWindow.download.isVisible(), equalTo(should));
        if (should) {
            assertThat(downloadFilePopUpWindow.getOriginalFileName(), containsString(fileName));
        } else {
            assertThat(downloadFilePopUpWindow.isOriginalFileNameVisible(), equalTo(false));
        }
        assertThat("Download master using nVerge button " + shouldState + " be visible on Download popup!", downloadFilePopUpWindow.action.isVisible(), equalTo(should));
    }

    protected void checkCountOfDownloadLink(String shouldState, int count) {
        AdbankFilesPage filesPage = getFilesPage();
        DownloadFilePopUpWindow downloadFilePopUpWindow = new DownloadFilePopUpWindow(filesPage);
        assertThat(downloadFilePopUpWindow.getCountOfDownloadLink(), shouldState.equalsIgnoreCase("should") ? equalTo(count) : not(equalTo(count)));
    }

    protected void checkTypeOfDownloadFileIsExist(String shouldState, String checkingName) {
        AdbankFilesPage filesPage = getFilesPage();
        DownloadFilePopUpWindow downloadFilePopUpWindow = new DownloadFilePopUpWindow(filesPage);
        assertThat(downloadFilePopUpWindow.getOriginalFileName(), shouldState.equalsIgnoreCase("should") ? containsString(checkingName) : not(containsString(checkingName)));
    }

    protected void checkCountOfAdbankItems(String count) {
        AdbankFilesPage filesPage = getFilesPage();
        assertThat("", filesPage.getCountOfAdbankedIcon(), equalTo(Integer.parseInt(count)));
    }

    protected void checkAvailabilityPreviewFile(String shouldState, String filePath, String objectName, String path) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder.getId());
        boolean should = shouldState.equals("should");
        assertThat("Preview file " + filePath + " " + shouldState + " be visible!", filesPage.isFilePreviewVisible(file.getId()), equalTo(should));
    }

    // | Name | ShouldState |
    protected void getObjectTabsVisibility(String objectName, String path, ExamplesTable tabsTable) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFilesPage filesPage = getFilesPage(fsObject.getId(), folder != null ? folder.getId() : "");
        for (int i = 0; i < tabsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(tabsTable, i);
            List<String> tabsName = filesPage.getAllTabsNames();
            if (row.get("Name") != null) {
                assertThat(row.get("Name"), row.get("ShouldState").equalsIgnoreCase("should") ? isIn(tabsName) : not(isIn(tabsName)));
            }
        }
    }

    public void checkDropDownMenuVisibility(String objectName, String path, ExamplesTable conditionTable) {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(objectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        AdbankFoldersTree foldersTree = getFoldersTree(fsObject.getId(), folder.getId());
        List<String> itemsList = foldersTree.openFolderMenu(folder.getId()).getMenuItems();
        for (int i = 0; i < conditionTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(conditionTable, i);
            boolean shouldState = row.get("ShouldState").equalsIgnoreCase("should");
            assertThat(row.get("Name"), shouldState ? isIn(itemsList) : not(isIn(itemsList)));
        }
    }

    public void checkThumbnailForFile(String shouldState, String thumbnailElement, String fileName) {
        String iconClass = "";
        if (thumbnailElement.equalsIgnoreCase("GenericMasterIcon")) {
            iconClass = "icon-asset-type-g";
        } else if(thumbnailElement.equalsIgnoreCase("TitledMasterIcon")) {
            iconClass = "icon-asset-type-t";
        }
        String locatorXpath = String.format("//div[@class='file-info' and descendant::a[@title='%s' or @title='%s']]//span[contains(@class, '%s')]",
                fileName, wrapVariableWithTestSession(fileName), iconClass);
        boolean should = shouldState.equalsIgnoreCase("should");
        boolean actual = getSut().getWebDriver().isElementVisible(By.xpath(locatorXpath));
        assertThat(String.format("File %s has thumbnail %s", fileName, thumbnailElement), actual, is(should));
    }

    protected void addAPTOntoFolder(String aptName, String folderName, String objectName) {
        String objectId = getObjectByName(wrapVariableWithTestSession(objectName)).getId();
        String wrapedFolderName= "";
        if (folderName.startsWith("/")) folderName = folderName.substring(1);
        for (String fName: folderName.split("/")) {
            wrapedFolderName += wrapVariableWithTestSession(fName) + "/";
        }
        Content folder = getCoreApi().createFolderRecursive(wrapedFolderName.substring(0, wrapedFolderName.length()-1), objectId, objectId);
        String folderId = folder.getId();
        String aptId = getCoreApi().getAgencyProjectTeamByName(wrapVariableWithTestSession(aptName)).getId();
        getCoreApi().addObjectToAgencyProjectTeam(aptId, folderId);
    }

    protected void checkFoldersVisibility(String objectName, ExamplesTable stateTable) {
        String objectId = getObjectByName(wrapVariableWithTestSession(objectName)).getId();
        AdbankFilesPage filesPage = getSut().getPageNavigator().getProjectFilesPage(objectId, "");
        List<String> foldersOnThePage = filesPage.getAllFoldersName();
        for (int i = 0; i < stateTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(stateTable, i);
            boolean shouldState = row.get("State").equalsIgnoreCase("should");
            assertThat(wrapVariableWithTestSession(row.get("Folder")), shouldState ? isIn(foldersOnThePage) : not(isIn(foldersOnThePage)));
        }
    }
    public String getDownloadZipUrl(String Storageid) {
        StringBuilder url = new StringBuilder("/storage/");
        url = url.append(Storageid);
        url = url.append("/CreateZipRequest");
        return url.toString();
    }

    @Then("{I |}'$should' see transcoded preview on asset info page")
    @When("{I |}'$should' see transcoded preview on asset info page")
    public void checkVideoPlayable(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        long start = System.currentTimeMillis();
        do {
            Common.sleep(1000);
        } while (getSut().getPageCreator().getLibraryAssetsInfoPage().isVideoVisible() != shouldState
                && System.currentTimeMillis() - start < 5000);
    }

}