package com.adstream.automate.babylon.JsonObjects.approval;

import com.adstream.automate.babylon.JsonObjects.BaseObject;

import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 19.06.13 20:21
 */
public class ApprovalTemplates extends BaseObject {
    private List<ApprovalTemplate> templates;

    public List<ApprovalTemplate> getTemplates() {
        return templates;
    }

    public void setTemplates(List<ApprovalTemplate> templates) {
        this.templates = templates;
    }
}
