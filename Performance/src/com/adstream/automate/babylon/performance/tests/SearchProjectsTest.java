package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.LuceneSearchingParams;

/**
 * User: ruslan.semerenko
 * Date: 26.07.12 11:20
 */
public class SearchProjectsTest extends CreateProjectTest {
    private static boolean projectsCreated = false;

    @Override
    public void runOnce() {
        if (!projectsCreated) {
            logIn(getParam("login"), getParam("password"));
            int projectsCount = getParamInt("projectsCount");
            log.info(String.format("Check for %d projects", projectsCount));
            int projectsFound = getProjectsCountInDb(projectsCount);
            log.info(String.format("Found %d projects. Need to create %d projects.", projectsFound, projectsCount - projectsFound));
            for (int i = 0; i < projectsCount - projectsFound; i++) {
                if (i % 1000 == 999) log.info(String.format("Created %d projects", i + 1));
                getService().createProject(getProject());
            }
            projectsCreated = true;
            log.info("Projects have been created");
        }
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
    }

    @Override
    public void start() {
        getService().findProjects(getQuery());
    }

    @Override
    public void afterRun() {
    }

    private LuceneSearchingParams getQuery() {
        return new LuceneSearchingParams()
                .setResultsOnPage(getParamInt("projectsOnPage"))
                .setPageNumber(1)
                .setQuery("");
    }

    private int getProjectsCountInDb(int countLimit) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        SearchResult<Project> result;
        int projectsCount = 0, page = 1;
        do {
            int part = countLimit - projectsCount > 100 ? 100 : countLimit - projectsCount;
            query.setResultsOnPage(part).setPageNumber(page);
            result = getService().findProjects(query);
            projectsCount += result.getResult().size();
            log.info(String.format("Found %d projects", projectsCount));
            page++;
        } while(countLimit > projectsCount && result.hasMore());
        return projectsCount;
    }
}
