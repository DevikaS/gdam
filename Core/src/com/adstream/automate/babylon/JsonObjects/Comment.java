package com.adstream.automate.babylon.JsonObjects;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 08.10.12
 * Time: 11:46
 */
public class Comment extends BaseObject {
    private String text;
    private String with;
    private String answerTo;
    private BaseObject object;
    private String objRef;
    private String objName;
    private long objRevision;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getWith() {
        return with;
    }

    public void setWith(String with) {
        this.with = with;
    }

    public String getAnswerTo() {
        return answerTo;
    }

    public void setAnswerTo(String answerTo) {
        this.answerTo = answerTo;
    }

    public BaseObject getObject() {
        return object;
    }

    public void setObject(BaseObject object) {
        this.object = object;
    }

    public String getObjRef() {
        return objRef;
    }

    public void setObjRef(String objRef) {
        this.objRef = objRef;
    }

    public String getObjName() {
        return objName;
    }

    public void setObjName(String objName) {
        this.objName = objName;
    }

    public long getObjRevision() {
        return objRevision;
    }

    public void setObjRevision(long objRevision) {
        this.objRevision = objRevision;
    }
}