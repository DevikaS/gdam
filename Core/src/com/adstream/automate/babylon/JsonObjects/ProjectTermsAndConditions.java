package com.adstream.automate.babylon.JsonObjects;

/**
 * Created by sobolev-a on 16.04.2014.
 */
public class ProjectTermsAndConditions extends BaseObject {
    private String text;
    private String docSubType;
    private String docId;
    private String[] _acceptedBy;
    private String[] project;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getDocSubType() {
        return docSubType;
    }

    public void setDocSubType(String docSubType) {
        this.docSubType = docSubType;
    }

    public String getDocId() {
        return docId;
    }

    public void setDocId(String docId) {
        this.docId = docId;
    }

    public String[] get_acceptedBy() {
        return _acceptedBy;
    }

    public void set_acceptedBy(String[] _acceptedBy) {
        this._acceptedBy = _acceptedBy;
    }

    public String[] getProject() {
        return project;
    }

    public void setProject(String[] project) {
        this.project = project;
    }

}
