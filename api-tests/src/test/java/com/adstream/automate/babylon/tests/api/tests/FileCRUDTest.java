package com.adstream.automate.babylon.tests.api.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.FilePreview;
import com.adstream.automate.babylon.JsonObjects.FileRevision;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.babylon.tests.api.JsonObjectFactory;
import com.adstream.automate.utils.Common;
import org.testng.annotations.Test;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 09.01.14 15:21
 */
public class FileCRUDTest extends AbstractTest {
    private final String PROJECT_NAME = "UploadFileTest" + getSessionId();
    private final File FILE_TO_UPLOAD = getResource("files/image.jpg");
    private final long TRANSCODING_TIMEOUT_MS = 60 * 1000; // 1 minute

    @Test()
    public void uploadFileTest() {
        final String FOLDER_NAME = "UploadFileTest";

        Content folder = createFolder(FOLDER_NAME);
        final Content file = getDefaultRestService().uploadFile(FILE_TO_UPLOAD, folder.getId());
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getDefaultRestService().getContent(file.getId()));
            }
        }.withTimeLimit(TRANSCODING_TIMEOUT_MS).process(true);

        Content checkFile = getDefaultRestService().getContent(file.getId());
        assertThat("File name", checkFile.getName(), equalTo(FILE_TO_UPLOAD.getName()));
        assertThat("Revisions count", checkFile.getRevisions().length, equalTo(1));

        FileRevision revision = checkFile.getRevisions()[0];
        assertThat("File size", revision.getMaster().getFileSize(), equalTo(FILE_TO_UPLOAD.length()));
        assertThat("Preview count", revision.getPreview().size(), equalTo(2));
        for (FilePreview preview : revision.getPreview()) {
            assertThat("Preview a5 type", preview.getA5Type(), isOneOf("image_proxy", "thumbnail"));
        }
    }

    @Test
    public void readFileTest() {
        final String FOLDER_NAME = "ReadFileTest";

        Content folder = createFolder(FOLDER_NAME);
        final Content file = getDefaultRestService().uploadFile(FILE_TO_UPLOAD, folder.getId());
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getDefaultRestService().getContent(file.getId()));
            }
        }.withTimeLimit(TRANSCODING_TIMEOUT_MS).process(true);

        Content readFile = getDefaultRestService().getContent(file.getId());
        assertThat("File id", readFile.getId(), equalTo(file.getId()));
        assertThat("File name", readFile.getName(), equalTo(file.getName()));
    }

    @Test
    public void updateFileTest() {
        final String FOLDER_NAME = "UpdateFileTest";
        final String FILE_NAME_NEW = "New file name";

        Content folder = createFolder(FOLDER_NAME);
        final Content file = getDefaultRestService().uploadFile(FILE_TO_UPLOAD, folder.getId());
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getDefaultRestService().getContent(file.getId()));
            }
        }.withTimeLimit(TRANSCODING_TIMEOUT_MS).process(true);

        file.setName(FILE_NAME_NEW);
        Content newFile = getDefaultRestService().updateContent(file);
        Common.sleep(3000);

        assertThat("File id", newFile.getId(), equalTo(file.getId()));
        assertThat("File name", newFile.getName(), equalTo(FILE_NAME_NEW));

        List<Content> folderFiles = getDefaultRestService().findFoldersContent(folder.getId(), new LuceneSearchingParams()).getResult();
        assertThat("Files count", folderFiles.size(), equalTo(1));
        assertThat("File name", folderFiles.get(0).getName(), equalTo(FILE_NAME_NEW));
    }

    @Test
    public void deleteFileTest() {
        final String FOLDER_NAME = "DeleteFileTest";

        Content folder = createFolder(FOLDER_NAME);
        final Content file = getDefaultRestService().uploadFile(FILE_TO_UPLOAD, folder.getId());
        new AbstractTranscodingChecker() {
            @Override
            public List<Content> getFiles() {
                return Arrays.asList(getDefaultRestService().getContent(file.getId()));
            }
        }.withTimeLimit(TRANSCODING_TIMEOUT_MS).process(true);

        getDefaultRestService().deleteContent(file.getId());
        Common.sleep(3000);

        List<Content> folderFiles = getDefaultRestService().findFoldersContent(folder.getId(), new LuceneSearchingParams()).getResult();
        assertThat("Files count", folderFiles.size(), equalTo(0));
    }

    private Project createProject() {
        Project project = getDefaultRestService().getProjectByName(PROJECT_NAME, 0);
        if (project == null) {
            Project newProject = JsonObjectFactory.getProject();
            newProject.setName(PROJECT_NAME);
            project = getDefaultRestService().createProject(newProject);
        }
        return project;
    }

    private Content createFolder(String folderName) {
        Project project = createProject();
        Content folder = getFolderByName(project.getId(), project.getId(), folderName);
        if (folder == null) {
            folder = getDefaultRestService().createFolder(project.getId(), folderName);
        }
        return folder;
    }

    private Content getFolderByName(String projectId, String parentId, String name) {
        List<Content> folders = ((BabylonMiddlewareService) getDefaultRestService().getWrappedService())
                .getProjectFolders(projectId, parentId);
        for (Content folder : folders) {
            if (folder.getName() != null && folder.getName().equals(name)) {
                return folder;
            }
        }
        return null;
    }
}
