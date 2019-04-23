package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 26/07/2016.
 */
public class List {

    private String _documentType;

    private String _modified;

    private String[] _parents;

    private String short_id;


    private String _created;

    private String _version;

    private String[] _permissions;

    private String _id;



    private String owner;

    private String _s;

    private String[] revisions;



    public String get_documentType ()
    {
        return _documentType;
    }

    public void set_documentType (String _documentType)
    {
        this._documentType = _documentType;
    }

    public String get_modified ()
    {
        return _modified;
    }

    public void set_modified (String _modified)
    {
        this._modified = _modified;
    }

    public String[] get_parents ()
    {
        return _parents;
    }

    public void set_parents (String[] _parents)
    {
        this._parents = _parents;
    }

    public String getShort_id ()
    {
        return short_id;
    }

    public void setShort_id (String short_id)
    {
        this.short_id = short_id;
    }


    public String get_created ()
    {
        return _created;
    }

    public void set_created (String _created)
    {
        this._created = _created;
    }

    public String get_version ()
    {
        return _version;
    }

    public void set_version (String _version)
    {
        this._version = _version;
    }

    public String[] get_permissions ()
    {
        return _permissions;
    }

    public void set_permissions (String[] _permissions)
    {
        this._permissions = _permissions;
    }

    public String get_id ()
    {
        return _id;
    }

    public void set_id (String _id)
    {
        this._id = _id;
    }


    public String getOwner ()
    {
        return owner;
    }

    public void setOwner (String owner)
    {
        this.owner = owner;
    }

    public String get_s ()
    {
        return _s;
    }

    public void set_s (String _s)
    {
        this._s = _s;
    }

    public String[] getRevisions ()
    {
        return revisions;
    }

    public void setRevisions (String[] revisions)
    {
        this.revisions = revisions;
    }

}
