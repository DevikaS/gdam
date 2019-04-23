package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.TeamPermission;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;

public class RemoveProjectOwnerTest extends AddProjectOwnerTest {
    private static final List<String> addedUsers = new ArrayList<>();

    @Override
    public void runOnce() {
        super.runOnce();
        addedUsers.addAll(addedOwners.keySet());
    }

    @Override
    public void start() {
        String userId;
        String projectId;
        long start = System.currentTimeMillis();
        do {
            userId = addedUsers.get(Gen.getInt(addedUsers.size()));
            projectId = addedOwners.get(userId).poll();
            if (projectId == null) {
                addedUsers.remove(userId);
            }
            if (System.currentTimeMillis() - start > 1000) {
                fail("Could not retrieve projectId for a second");
            }
        } while (projectId == null);
        if (isCoreService()) {
            TeamPermission[] permissions = new TeamPermission[]{
                    new TeamPermission(projectId, userId, getProjectAdminRole().getId())
            };
            getService().addUserToProjectTeam(permissions);
        } else {
            getBabylonMiddlewareService().removeProjectOwner(projectId, userId);
        }
    }
}
