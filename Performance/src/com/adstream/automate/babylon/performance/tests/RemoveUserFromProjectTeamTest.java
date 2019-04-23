package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;

public class RemoveUserFromProjectTeamTest extends AddUserToProjectTeamTest {
    private static final List<String> addedUsersId = new ArrayList<>();

    @Override
    public void runOnce() {
        super.runOnce();
        addedUsersId.addAll(addedUsers.keySet());
    }

    @Override
    public void start() {
        String userId;
        String projectId;
        long start = System.currentTimeMillis();
        do {
            userId = addedUsersId.get(Gen.getInt(addedUsersId.size()));
            projectId = addedUsers.get(userId).poll();
            if (projectId == null) {
                addedUsersId.remove(userId);
            }
            if (System.currentTimeMillis() - start > 1000) {
                fail("Could not retrieve projectId for a second");
            }
        } while (projectId == null);
        getService().removeUserFromProjectTeam(projectId, userId);
    }
}
