package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;

/**
 * User: ruslan.semerenko
 * Date: 24.06.13 16:23
 */
public class FindApprovalsTest extends CreateApprovalTest {
    private static Integer pages;

    @Override
    public void runOnce() {
        if (submitter == null) {
            super.runOnce();
        }
    }

    @Override
    public void beforeStart() {
        super.beforeStart();
        if (pages == null) {
            pages = transcodedFiles.size() / 10;
        }
    }

    @Override
    public void start() {
        getService().findApprovals(new LuceneSearchingParams().setPageNumber(Gen.getInt(1, pages)), "submitted", false);
    }

    @Override
    public void afterRun() {
    }
}
