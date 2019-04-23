package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 26.07.12 11:18
 */
public class UpdateProjectTest extends SearchProjectsTest {
    private static List<Project> projects = new ArrayList<Project>();

    @Override
    public void runOnce() {
        super.runOnce();
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
        if (projects.isEmpty()) {
            LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(25);
            for (int i = 0; i < 10; i++) {
                query.setPageNumber(i + 1);
                projects.addAll(getService().findProjects(query).getResult());
            }
        }
    }

    @Override
    public void start() {
        Project project = projects.get(Gen.getInt(projects.size()));
        project.setName(Gen.getHumanReadableString(8, true));
        project.setMediaType("Broadcast");
        project = getService().updateProject(project.getId(), project);
        if (project == null)
            fail("Unable to update project");
    }

    @Override
    public void afterRun() {
    }
}
