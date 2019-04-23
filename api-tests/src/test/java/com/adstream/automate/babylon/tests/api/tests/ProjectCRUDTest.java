package com.adstream.automate.babylon.tests.api.tests;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.tests.api.JsonObjectFactory;
import com.adstream.automate.utils.Common;
import org.testng.annotations.Test;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 14.01.14 14:11
 */
public class ProjectCRUDTest extends AbstractTest {

    @Test
    public void createProjectTest() {
        final String PROJECT_NAME = "CreateProjectTest" + getSessionId();

        Project project = JsonObjectFactory.getProject();
        project.setName(PROJECT_NAME);
        project = getDefaultRestService().createProject(project);
        Common.sleep(3000);

        assertThat("Project name", project.getName(), equalTo(PROJECT_NAME));

        LuceneSearchingParams query = new LuceneSearchingParams()
                .setSortingField("_created")
                .setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING)
                .setResultsOnPage(100);
        SearchResult<Project> searchResult = getDefaultRestService().findProjects(query);
        List<String> projectsIds = new ArrayList<>();
        for (Project projectFromSearch : searchResult.getResult()) {
            projectsIds.add(projectFromSearch.getId());
        }

        assertThat("Project is present on first page", projectsIds, hasItem(project.getId()));
    }

    @Test
    public void readProjectTest() {
        final String PROJECT_NAME = "ReadProjectTest" + getSessionId();

        Project project = JsonObjectFactory.getProject();
        project.setName(PROJECT_NAME);
        project = getDefaultRestService().createProject(project);
        Common.sleep(3000);

        Project readProject = getDefaultRestService().getProject(project.getId());
        assertThat("Project id", readProject.getId(), equalTo(project.getId()));
        assertThat("Project name", readProject.getName(), equalTo(project.getName()));
    }

    @Test
    public void updateProjectTest() {
        final String PROJECT_NAME_OLD = "UpdateProjectTest" + getSessionId();
        final String PROJECT_NAME_NEW = "UpdateProjectTest New" + getSessionId();

        Project project = JsonObjectFactory.getProject();
        project.setName(PROJECT_NAME_OLD);
        project = getDefaultRestService().createProject(project);
        Common.sleep(3000);

        project.setName(PROJECT_NAME_NEW);
        getDefaultRestService().updateProject(project.getId(), project);
        Common.sleep(3000);

        LuceneSearchingParams query = new LuceneSearchingParams()
                .setSortingField("_created")
                .setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING)
                .setResultsOnPage(100);
        SearchResult<Project> searchResult = getDefaultRestService().findProjects(query);
        List<String> projectsNames = new ArrayList<>();
        for (Project projectFromSearch : searchResult.getResult()) {
            projectsNames.add(projectFromSearch.getName());
        }

        assertThat("Old project doesn't exist", projectsNames.contains(PROJECT_NAME_OLD), is(false));
        assertThat("New project available", projectsNames.contains(PROJECT_NAME_NEW), is(true));
    }

    @Test
    public void deleteProjectTest() {
        final String PROJECT_NAME = "DeleteProjectTest" + getSessionId();

        Project project = JsonObjectFactory.getProject();
        project.setName(PROJECT_NAME);
        project = getDefaultRestService().createProject(project);
        Common.sleep(3000);

        getDefaultRestService().deleteProject(project.getId());
        Common.sleep(3000);

        LuceneSearchingParams query = new LuceneSearchingParams()
                .setSortingField("_created")
                .setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING)
                .setResultsOnPage(100);
        SearchResult<Project> searchResult = getDefaultRestService().findProjects(query);
        List<String> projectsNames = new ArrayList<>();
        for (Project projectFromSearch : searchResult.getResult()) {
            projectsNames.add(projectFromSearch.getName());
        }

        assertThat("Project doesn't exist", projectsNames.contains(PROJECT_NAME), is(false));
    }
}
