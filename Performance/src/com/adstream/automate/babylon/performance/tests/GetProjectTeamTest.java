package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.utils.Gen;

/**
 * User: ruslan.semerenko
 * Date: 06.08.13 15:28
 */
public class GetProjectTeamTest extends AddUserToProjectTeamTest {
    @Override
    public void beforeStart() {
        super.beforeStart();
    }

    @Override
    public void start() {
        Project project = projects.get(Gen.getInt(projects.size()));
        SearchResult<User> result = getService().getTeamUsers(project.getId(), false);
        if (result.getResult().size() == 0) {
            fail("Could not get project team");
        }
    }
}
