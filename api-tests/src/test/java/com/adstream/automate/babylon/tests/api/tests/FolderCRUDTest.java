package com.adstream.automate.babylon.tests.api.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.babylon.tests.api.JsonObjectFactory;
import com.adstream.automate.utils.Common;
import org.testng.annotations.Test;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: Ruslan Semerenko
 * Date: 22.01.14 20:23
 */
public class FolderCRUDTest extends AbstractTest {
    private final String PROJECT_NAME = "FolderCRUDTest" + getSessionId();

    @Test
    public void createFolderTest() {
        final String FOLDER_NAME = "CreateFolderTest";

        Project project = getProject();

        Content folder = getDefaultRestService().createFolder(project.getId(), FOLDER_NAME);
        Common.sleep(3000);

        assertThat("Folder name", folder.getName(), equalTo(FOLDER_NAME));

        List<Content> folders = ((BabylonMiddlewareService) getDefaultRestService().getWrappedService())
                .getProjectFolders(project.getId(), project.getId());
        assertThat("Folders count", folders.size(), equalTo(2));
        for (Content folderFromSearch : folders) {
            assertThat("Folder id", folderFromSearch.getId(), isOneOf(folder.getId(), project.getId()));
        }
    }

    @Test
    public void updateFolderTest() {
        final String FOLDER_NAME_OLD = "UpdateFolderTest";
        final String FOLDER_NAME_NEW = "UpdateFolderTest New";

        Project project = getProject();

        Content folder = getDefaultRestService().createFolder(project.getId(), FOLDER_NAME_OLD);
        Common.sleep(3000);

        folder.setName(FOLDER_NAME_NEW);
        Content newFolder = getDefaultRestService().updateContent(folder);
        assertThat("Folder id", newFolder.getId(), equalTo(folder.getId()));
        assertThat("Folder name", newFolder.getName(), equalTo(FOLDER_NAME_NEW));

        List<Content> folders = ((BabylonMiddlewareService) getDefaultRestService().getWrappedService())
                .getProjectFolders(project.getId(), project.getId());
        List<String> foldersNames = new ArrayList<>();
        for (Content folderFromSearch : folders) {
            if (folderFromSearch.getName() == null) {
                continue;
            }
            foldersNames.add(folderFromSearch.getName());
        }
        assertThat("Old name doesn't exist", foldersNames.contains(FOLDER_NAME_OLD), is(false));
        assertThat("New name is present", foldersNames.contains(FOLDER_NAME_NEW), is(true));
    }

    @Test
    public void deleteFolderTest() {
        final String FOLDER_NAME = "DeleteFolderName";

        Project project = getProject();

        Content folder = getDefaultRestService().createFolder(project.getId(), FOLDER_NAME);
        Common.sleep(3000);

        ((BabylonMiddlewareService) getDefaultRestService().getWrappedService()).deleteFolder(project.getId(), folder.getId());
        Common.sleep(3000);

        List<Content> folders = ((BabylonMiddlewareService) getDefaultRestService().getWrappedService())
                .getProjectFolders(project.getId(), project.getId());
        List<String> foldersNames = new ArrayList<>();
        for (Content folderFromSearch : folders) {
            if (folderFromSearch.getName() == null) {
                continue;
            }
            foldersNames.add(folderFromSearch.getName());
        }
        assertThat("Folder doesn't exist", foldersNames.contains(FOLDER_NAME), is(false));
    }

    private Project getProject() {
        Project project = getDefaultRestService().getProjectByName(PROJECT_NAME, 0);
        if (project == null) {
            Project newProject = JsonObjectFactory.getProject();
            newProject.setName(PROJECT_NAME);
            project = getDefaultRestService().createProject(newProject);
        }
        return project;
    }
}
