package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.AgencyProjectTeam;
import com.adstream.automate.babylon.JsonObjects.AgencyTeamMember;
import com.adstream.automate.babylon.JsonObjects.Role;
import com.adstream.automate.utils.Gen;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

public class AddAgencyTeamToProjectTeamTest extends AddProjectOwnerTest {
    protected static final List<String> teams = new ArrayList<>();
    protected static final Map<String, Queue<String>> addedTeams = new ConcurrentHashMap<>(); // teamId -> Queue[projectId]

    @Override
    public void runOnce() {
        super.runOnce();
        int usersPerTeam = getParamInt("usersPerTeam");
        List<String> usersForTeam = new ArrayList<>(users);
        Collections.shuffle(usersForTeam);
        Role projectUserRole = getProjectUserRole();
        for (int i = 0; i < usersForTeam.size() / usersPerTeam; i++) {
            AgencyProjectTeam team = new AgencyProjectTeam();
            team.setName(Gen.getHumanReadableString(6, true));
            team.setMembers(new AgencyTeamMember[usersPerTeam]);
            for (int j = 0; j < usersPerTeam; j++) {
                team.getMembers()[j] = new AgencyTeamMember(usersForTeam.get(i * usersPerTeam + j), projectUserRole.getId());
            }
            teams.add(getService().createAgencyTeam(team).getId());
        }
    }

    @Override
    public void start() {
        String teamId;
        String projectId;
        long start = System.currentTimeMillis();
        do {
            teamId = teams.get(Gen.getInt(teams.size()));
            projectId = projects.get(Gen.getInt(projects.size()));
            if (System.currentTimeMillis() - start > 1000) {
                fail("Could not retrieve teamId and projectId for a second");
            }
        } while (addedTeams.get(teamId) != null && addedTeams.get(teamId).contains(projectId));
        if (addedTeams.get(teamId) == null) {
            addedTeams.put(teamId, new ConcurrentLinkedQueue<String>());
        }
        addedTeams.get(teamId).add(projectId);
        getService().addObjectToAgencyProjectTeam(teamId, projectId);
    }

    protected Role getProjectUserRole() {
        return getRoleByName("project.user");
    }
}
