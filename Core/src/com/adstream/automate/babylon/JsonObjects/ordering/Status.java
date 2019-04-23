package com.adstream.automate.babylon.JsonObjects.ordering;

public class Status {
    private Failure failure;

    private String _created;

    private String status;

    private String _modified;

    private String action;

    private String _deleted;

    public Failure getFailure ()
    {
        return failure;
    }

    public void setFailure (Failure failure)
    {
        this.failure = failure;
    }

    public String get_created ()
    {
        return _created;
    }

    public void set_created (String _created)
    {
        this._created = _created;
    }

    public String getStatus ()
    {
        return status;
    }

    public void setStatus (String status)
    {
        this.status = status;
    }

    public String get_modified ()
    {
        return _modified;
    }

    public void set_modified (String _modified)
    {
        this._modified = _modified;
    }

    public String getAction ()
    {
        return action;
    }

    public void setAction (String action)
    {
        this.action = action;
    }

    public String get_deleted ()
    {
        return _deleted;
    }

    public void set_deleted (String _deleted)
    {
        this._deleted = _deleted;
    }
}
