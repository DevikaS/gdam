package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 27.07.12 16:29
 */
public class CreateFileTest extends CreateFolderTest {
    private static List<String> folders = new ArrayList<>();

    @Override
    public void runOnce() {
        super.runOnce();
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
        if (folders.isEmpty()) {
            LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(25);
            for (int i = 0; i < 10; i++) {
                query.setPageNumber(i + 1);
                for (Project project : getService().findProjects(query).getResult()) {
                    Content rootFolder = getProjectRootFolder(project.getId());
                    if (rootFolder != null) {
                        Content folder = getService().createContent(rootFolder.getId(), getFolder(project.getId()));
                        folders.add(folder.getId());
                    }
                }
            }
        }
    }

    @Override
    public void start() {
        String folderId = folders.get(Gen.getInt(folders.size()));
        Content file = uploadFile(new File(getParam("filePath")), folderId);
        if (file == null)
            fail("Can not create file");
    }

    @Override
    public void afterRun() {
    }
}
