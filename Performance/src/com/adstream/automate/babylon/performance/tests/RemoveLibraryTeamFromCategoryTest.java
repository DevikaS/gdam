package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;

public class RemoveLibraryTeamFromCategoryTest extends AddLibraryTeamToCategoryTest {
    private static final List<String> addedTeamsId = new ArrayList<>();

    @Override
    public void runOnce() {
        super.runOnce();
        addedTeamsId.addAll(addedTeams.keySet());
    }

    @Override
    public void start() {
        String teamId;
        String categoryId;
        long start = System.currentTimeMillis();
        do {
            teamId = addedTeamsId.get(Gen.getInt(addedTeamsId.size()));
            categoryId = addedTeams.get(teamId).poll();
            if (categoryId == null) {
                addedTeamsId.remove(teamId);
            }
            if (System.currentTimeMillis() - start > 1000) {
                fail("Could not retrieve categoryId for a second");
            }
        } while (categoryId == null);
        getService().unshareAssetFilter(categoryId, teamId);
    }
}
