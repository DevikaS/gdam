package com.publicApi.jsonPayLoads.GsonClasses.traffic;

/**
 * Created by Raja.Gone on 05/08/2016.
 */
public class Assets {
    private String rootAssetId;

    private String _id;

    private String name;

    private Qc qc;

    public String getRootAssetId ()
    {
        return rootAssetId;
    }

    public void setRootAssetId (String rootAssetId)
    {
        this.rootAssetId = rootAssetId;
    }

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

    public Qc getQc ()
    {
        return qc;
    }

    public void setQc (Qc qc)
    {
        this.qc = qc;
    }
}
