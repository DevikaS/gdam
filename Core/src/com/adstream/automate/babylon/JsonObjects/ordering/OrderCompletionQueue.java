package com.adstream.automate.babylon.JsonObjects.ordering;

public class OrderCompletionQueue {
    private String _id;

    private Status status;

    private String name;

    private String objectRef;

    private Metadata metadata;

    public String get_id ()
    {
        return _id;
    }

    public void set_id (String _id)
    {
        this._id = _id;
    }

    public Status getStatus ()
    {
        return status;
    }

    public void setStatus (Status status)
    {
        this.status = status;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getObjectRef ()
    {
        return objectRef;
    }

    public void setObjectRef (String objectRef)
    {
        this.objectRef = objectRef;
    }

    public Metadata getMetadata ()
    {
        return metadata;
    }

    public void setMetadata (Metadata metadata)
    {
        this.metadata = metadata;
    }

}
