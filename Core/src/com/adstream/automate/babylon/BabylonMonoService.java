package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.approval.Approval;
import com.adstream.automate.babylon.JsonObjects.approval.ApprovalStage;

/**
 * User: ruslan.semerenko
 * Date: 25.06.13 10:46
 */
public interface BabylonMonoService {
    public SearchResult<Approval> findApprovals(LuceneSearchingParams query, String type, boolean onlyCompleted);
    public Approval getApproval(String fileId, String masterId);
    public String createApprovalStage(String fileId, String masterId, ApprovalStage stage);
    public void changeApprovalState(String fileId, String masterId, String approvalId, String stageId, String status);
}
