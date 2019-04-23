package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 25.10.13
 * Time: 15:56
 */
public enum ApprovalStatus {
    ON_HOLD("on_hold"),
    APPROVED("approved");

    private String approvalStatus;

    private ApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    @Override
    public String toString() {
        return approvalStatus;
    }
}