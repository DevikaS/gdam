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
 * Date: 27.07.12 19:35
 */
public class UpdateFileTest extends CreateFileTest {
    protected static List<Content> files = new ArrayList<Content>();

    @Override
    public void runOnce() {
        super.runOnce();
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
        if (files.isEmpty()) {
            LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(25);
            for (int i = 0; i < 10; i++) {
                query.setPageNumber(i + 1);
                for (Project project : getService().findProjects(query).getResult()) {
                    Content folder = getService().createContent(project.getId(), getFolder(project.getId()));
                    for (int j = 0; j < 10; j++)
                        files.add(uploadFile(new File(getParam("filePath")), folder.getId()));
                }
            }
        }
    }

    @Override
    public void start() {
        Content file = files.get(Gen.getInt(files.size()));
        file.setName(Gen.getHumanReadableString(6));
        file = getService().updateContent(file.getId(), file);
        if (file == null)
            fail("Can not update file");
    }

    @Override
    public void afterRun() {
    }
}
