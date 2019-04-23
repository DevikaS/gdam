package com.adstream.automate.babylon.core;

import com.adstream.automate.babylon.BabylonMessageSender;
import com.adstream.automate.babylon.BabylonMonoService;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.approval.Approval;
import com.adstream.automate.babylon.JsonObjects.approval.ApprovalStage;
import com.adstream.automate.babylon.LuceneSearchingParams;

import java.net.URL;

/**
 * User: ruslan.semerenko
 * Date: 25.06.13 10:52
 */
public class BabylonCoreMonoService extends BabylonMessageSender implements BabylonMonoService {
    public BabylonCoreMonoService(URL url) {
        super(url);
        contentType = "application/json";
        baseUrl += "gdam.net/api/";
    }

    @Override
    public SearchResult<Approval> findApprovals(LuceneSearchingParams query, String type, boolean onlyCompleted) {
        return null;
    }

    @Override
    public Approval getApproval(String fileId, String masterId) {
        return null;
    }

    @Override
    public String createApprovalStage(String fileId, String masterId, ApprovalStage stage) {
        return null;
    }

    @Override
    public void changeApprovalState(String fileId, String masterId, String approvalId, String stageId, String status) {
    }
}
