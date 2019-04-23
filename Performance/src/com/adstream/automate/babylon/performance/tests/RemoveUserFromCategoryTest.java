package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;

public class RemoveUserFromCategoryTest extends AddUserToCategoryTest {
    private static final List<String> addedUsersId = new ArrayList<>();

    @Override
    public void runOnce() {
        super.runOnce();
        addedUsersId.addAll(addedUsers.keySet());
    }

    @Override
    public void start() {
        String userId;
        String categoryId;
        long start = System.currentTimeMillis();
        do {
            userId = addedUsersId.get(Gen.getInt(addedUsersId.size()));
            categoryId = addedUsers.get(userId).poll();
            if (categoryId == null) {
                addedUsersId.remove(userId);
            }
            if (System.currentTimeMillis() - start > 1000) {
                fail("Could not retrieve categoryId for a second");
            }
        } while (categoryId == null);
        getService().unshareAssetFilter(categoryId, userId);
    }
}
