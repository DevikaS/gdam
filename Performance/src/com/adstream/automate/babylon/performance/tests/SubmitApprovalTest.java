package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.approval.Approval;
import com.adstream.automate.babylon.JsonObjects.approval.ApprovalStage;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 24.06.13 13:58
 */
public class SubmitApprovalTest extends GetApprovalTest {
    private static List<Content> keys;

    @Override
    public void runOnce() {
        super.runOnce();
    }

    @Override
    public void beforeStart() {
        super.beforeStart();
        if (fileApprovals.size() == 0) {
            log.info("Get approvals for transcoded files");
            for (Content file : transcodedFiles) {
                String masterId = file.getLastRevision().getMaster().getFileID();
                fileApprovals.put(file, getService().getApproval(file.getId(), masterId));
            }
        }
        if (keys == null) {
            keys = new ArrayList<Content>(fileApprovals.keySet());
        }
    }

    @Override
    public void start() {
        Content file = transcodedFiles.get(Gen.getInt(transcodedFiles.size()));
        String masterId = file.getLastRevision().getMaster().getFileID();
        Approval approval = fileApprovals.get(file);
        List<ApprovalStage> stages = approval.getStages();
        ApprovalStage stage = stages.get(Gen.getInt(stages.size()));
        getService().changeApprovalState(file.getId(), masterId, approval.getId(), stage.getStageId(), "Approved");
    }

    @Override
    public void afterRun() {
    }
}
