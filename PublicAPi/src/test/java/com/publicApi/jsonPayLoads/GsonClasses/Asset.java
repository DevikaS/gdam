package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 08/07/2016.
 */
public class Asset {

    private DictionaryMetaData dictionaryMetaData;

    public DictionaryMetaData getDictionaryMetaData ()
    {
        return dictionaryMetaData;
    }

    public void setDictionaryMetaData (DictionaryMetaData dictionaryMetaData)
    {
        this.dictionaryMetaData = dictionaryMetaData;
    }


    private String title;

    private String duration;

    private String unique;

    private String _id;

    private String created;

    private String closedCaptionStatus;

    private String watermarkingInitialised;

    private String advertiser;



    public String getTitle ()
    {
        return title;
    }

    public void setTitle (String title)
    {
        this.title = title;
    }

    public String getDuration ()
    {
        return duration;
    }

    public void setDuration (String duration)
    {
        this.duration = duration;
    }

    public String getUnique ()
    {
        return unique;
    }

    public void setUnique (String unique)
    {
        this.unique = unique;
    }

    public String get_id ()
    {
        return _id;
    }

    public void set_id (String _id)
    {
        this._id = _id;
    }

    public String getCreated ()
    {
        return created;
    }

    public void setCreated (String created)
    {
        this.created = created;
    }

    public String getClosedCaptionStatus ()
    {
        return closedCaptionStatus;
    }

    public void setClosedCaptionStatus (String closedCaptionStatus)
    {
        this.closedCaptionStatus = closedCaptionStatus;
    }

    public String getWatermarkingInitialised ()
    {
        return watermarkingInitialised;
    }

    public void setWatermarkingInitialised (String watermarkingInitialised)
    {
        this.watermarkingInitialised = watermarkingInitialised;
    }

    public String getAdvertiser ()
    {
        return advertiser;
    }

    public void setAdvertiser (String advertiser)
    {
        this.advertiser = advertiser;
    }
}
