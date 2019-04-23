package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.approval.Approval;
import com.adstream.automate.utils.Gen;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * User: ruslan.semerenko
 * Date: 24.06.13 13:24
 */
public class GetApprovalTest extends CreateApprovalTest {
    protected static volatile Map<Content, Approval> fileApprovals = new ConcurrentHashMap<Content, Approval>();

    @Override
    public void runOnce() {
        if (submitter == null) {
            super.runOnce();
        }
    }

    @Override
    public void beforeStart() {
        super.beforeStart();
    }

    @Override
    public void start() {
        Content file = transcodedFiles.get(Gen.getInt(transcodedFiles.size()));
        String masterId = file.getLastRevision().getMaster().getFileID();
        Approval approval = getService().getApproval(file.getId(), masterId);
        if (approval == null) {
            fail("Could not get approval");
        }
        if (!fileApprovals.containsKey(file)) {
            fileApprovals.put(file, approval);
        }
    }

    @Override
    public void afterRun() {
    }
}
