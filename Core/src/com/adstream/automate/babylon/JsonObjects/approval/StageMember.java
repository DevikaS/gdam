package com.adstream.automate.babylon.JsonObjects.approval;

import org.joda.time.DateTime;

/**
 * User: ruslan.semerenko
 * Date: 19.06.13 20:15
 */
public class StageMember {
    private Approver approver;
    private String status;
    private Boolean stageOwner;
    private Boolean moderated;
    private DateTime notificationSent;

    public Approver getApprover() {
        return approver;
    }

    public void setApprover(Approver approver) {
        this.approver = approver;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Boolean isStageOwner() {
        return stageOwner;
    }

    public void setStageOwner(Boolean stageOwner) {
        this.stageOwner = stageOwner;
    }

    public Boolean isModerated() {
        return moderated;
    }

    public void setModerated(Boolean moderated) {
        this.moderated = moderated;
    }

    public DateTime getNotificationSent() {
        return notificationSent;
    }

    public void setNotificationSent(DateTime notificationSent) {
        this.notificationSent = notificationSent;
    }
}
