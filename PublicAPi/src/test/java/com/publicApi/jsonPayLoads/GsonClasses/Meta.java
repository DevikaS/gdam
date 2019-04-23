package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 04/07/2016.
 */
public class Meta {
    private Metadata metadata;
    private Common common;
    private Destinations destinations;
    private Asset asset;
    private Tv tv;

    public Asset getAsset() {
        return asset;
    }

    public void setAsset(Asset asset) {
        this.asset = asset;
    }

    public Destinations getDestinations() {
        return destinations;
    }

    public void setDestinations(Destinations destinations) {
        this.destinations = destinations;
    }



    public Common getCommon ()
    {
        return common;
    }

    public void setCommon (Common common)
    {
        this.common = common;
    }

    public Tv getTv ()
    {
        return tv;
    }

    public void setTv (Tv tv)
    {
        this.tv = tv;
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
