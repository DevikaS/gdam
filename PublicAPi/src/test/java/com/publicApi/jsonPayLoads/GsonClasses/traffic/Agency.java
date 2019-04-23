package com.publicApi.jsonPayLoads.GsonClasses.traffic;

/**
 * Created by Raja.Gone on 20/01/2017.
 */
public class Agency {
    private String _id;

    private String name;

    private String ingestLocationId;

    private String storageId;

    public String get_id ()
    {
        return _id;
    }

    public void set_id (String _id)
    {
        this._id = _id;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getIngestLocationId ()
    {
        return ingestLocationId;
    }

    public void setIngestLocationId (String ingestLocationId)
    {
        this.ingestLocationId = ingestLocationId;
    }

    public String getStorageId ()
    {
        return storageId;
    }

    public void setStorageId (String storageId)
    {
        this.storageId = storageId;
    }
}
