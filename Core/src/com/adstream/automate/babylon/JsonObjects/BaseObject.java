package com.adstream.automate.babylon.JsonObjects;

import org.joda.time.DateTime;

/**
 * User: ruslan.semerenko
 * Date: 25.01.13 13:24
 */
public class BaseObject {
    private DateTime _created;
    private String _documentType;
    private User createdBy;
    private String _id;
    private String[] _parents;
    private DateTime _modified;
    private String owner;
    private Agency agency;
    private String _subtype;
    private Boolean _deleted;
    private int _version;
    private String name; // not in schema. but very useful
    private String lo_name; // not in schema. but very useful

    public BaseObject() {}

    public BaseObject(CustomMetadata cm) {
        setCreated(cm.getDateTime("_created"));
        setDocumentType(cm.getString("_documentType"));
        setCreatedBy(cm.getForClass("createdBy", User.class));
        setId(cm.getString("_id"));
        setParents(cm.getStringArray("_parents"));
        setModified(cm.getDateTime("_modified"));
        setOwner(cm.getString("owner"));
        setAgency(cm.getForClass("agency", Agency.class));
        setSubtype(cm.getString("_subtype"));
        setDeleted(cm.getBoolean("_deleted"));
        // do not use setters for following fields
        name = cm.getString("name");
        lo_name = cm.getString("lo_name");
    }

    public BaseObject(String _id) {
        this._id = _id;
    }

    public DateTime getCreated() {
        return _created;
    }

    public void setCreated(DateTime created) {
        this._created = created;
    }

    public String getDocumentType() {
        return _documentType;
    }

    public void setDocumentType(String documentType) {
        this._documentType = documentType;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public String getId() {
        return _id;
    }

    public void setId(String id) {
        this._id = id;
    }

    public String[] getParents() {
        return _parents;
    }

    public void setParents(String[] parents) {
        this._parents = parents;
    }

    public DateTime getModified() {
        return _modified;
    }

    public void setModified(DateTime modified) {
        this._modified = modified;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public Agency getAgency() {
        return agency;
    }

    public void setAgency(Agency agency) {
        this.agency = agency;
    }

    public String getSubtype() {
        return _subtype;
    }

    public void setSubtype(String subtype) {
        this._subtype = subtype;
    }

    public Boolean getDeleted() {
        return _deleted;
    }

    public void setDeleted(Boolean deleted) {
        this._deleted = deleted;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLoName() {
        return lo_name;
    }

    public void setLoName(String lo_name) {
        this.lo_name = lo_name;
    }

    public Identity getIdentity() {
        return new Identity(getId(), getName());
    }

    // Just ID and Name
    public BaseObject getSimpleObject() {
        BaseObject obj = new BaseObject();
        obj.setId(getId());
        obj.setName(getName());
        return obj;
    }

    public int get_version() {
        return _version;
    }

    public void set_version(int _version) {
        this._version = _version;
    }
}