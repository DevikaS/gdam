package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;

/**
 * User: ruslan.semerenko
 * Date: 13.07.12 12:39
 */
public class CreateProjectTest extends AbstractPerformanceTestServiceWrapper {
    private Project defaultProject;

    @Override
    public void runOnce() {
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
        getCurrentAgency();
        getAgencyAdminRole();
    }

    @Override
    public void start() {
        Project project = getService().createProject(getProject());
        if (project != null) {
            getService().addUserToProjectTeam(project.getId(), getTeamPermission(project.getId()));
        } else {
            fail("Could not create project");
        }
    }

    @Override
    public void afterRun() {
    }

    protected Project getProject() {
        if (defaultProject == null) {
            Project project = new Project();
            project.setMediaType("Broadcast");
            project.setAdministrators(new String[0]);
            project.setSubtype("project");
            project.setLogo("");
            project.setDateStart(new DateTime());
            project.setDateEnd(new DateTime().plus(Period.days(1)));
            defaultProject = project;
        }
        defaultProject.setName(Gen.getHumanReadableString(8, true));
        defaultProject.setJobNumber(Gen.getHumanReadableString(8, true));
        return defaultProject;
    }

    protected TeamPermission[] getTeamPermission(String projectId) {
        return new TeamPermission[] {
                new TeamPermission(projectId, getCurrentUser().getId(), getAgencyAdminRole().getId(), true, null)
        };
    }

    private Role getAgencyAdminRole() {
        return getRoleByName("project.admin");
    }
}
