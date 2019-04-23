package com.adstream.automate.babylon.JsonObjects;

public enum ApplicationAccess {
    FOLDERS("folders"),
    WORK_REQUESTS("adkits"),
    LIBRARY("library"),
    DELIVERY("ordering"),
    TRAFFIC("adpath"),
    APPROVALS("approvals"),
    ANNOTATIONS("annotations"),
    PRESENTATIONS("presentations"),
    FRAMEGRABBER("frame_grabber"),
    DASHBOARD("dashboard"),
    INGEST("ingest"),
    Reporting("reporting"),
    STREAMLINEORDERING("streamlined_ordering"),
    TASKS("tasks"),
    STREAMLINED_LIBRARY("streamlined_library"),
    MEDIAMANAGER("media_manager"),
    MEDIACHECKER("media_checker"),
    ADCOST("adcost");

    public static ApplicationAccess getByValue(String value) {
        for (ApplicationAccess access : values()) {
            if (access.toString().equals(value)) {
                return access;
            }
        }
        throw new IllegalArgumentException("Unknown access " + value);
    }

    private String value;

    ApplicationAccess(String value) {
        this.value = value;
    }

    public String toString() {
        return value;
    }
}
