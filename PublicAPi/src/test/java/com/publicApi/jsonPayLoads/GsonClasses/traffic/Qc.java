package com.publicApi.jsonPayLoads.GsonClasses.traffic;

import com.publicApi.jsonPayLoads.GsonClasses.Metadata;

/**
 * Created by Raja.Gone on 05/08/2016.
 */
public class Qc {

    private String primary;

    private Metadata metadata;

    public String getPrimary ()
    {
        return primary;
    }

    public void setPrimary (String primary)
    {
        this.primary = primary;
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
