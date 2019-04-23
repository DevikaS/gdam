package com.adstream.automate.babylon.sut.pages.adcost.elements;

public enum AdCostApprovalSection {
    TECHNICAL_APPROVER("technical"),
    BRAND_APPROVER("brand"),
    WATCHER_APPROVER("watcher");

    private String sectionName;

    private AdCostApprovalSection(String sectionName) {
        this.sectionName = sectionName;
    }

    @Override
    public String toString() {
        return sectionName;
    }

    public static AdCostApprovalSection findByType(String type) {
        for (AdCostApprovalSection sectionName: values())
            if (sectionName.toString().equals(type))
                return sectionName;
        throw new IllegalArgumentException("Unknown Approval Section Name: " + type);
    }
}