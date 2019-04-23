package com.adstream.automate.babylon.JsonObjects;

public enum FsObjectType {
    PROJECT("project"),
    PROJECT_TEMPLATE("project_template"),
    WORK_REQUEST("adkit"),
    WORK_REQUEST_TEMPLATE("adkit_template"),
    FOLDER("folder"),
    FILE("element");

    private String subtype;

    private FsObjectType(String subtype) {
        this.subtype = subtype;
    }

    public String getSubtype() {
        return subtype;
    }
}
