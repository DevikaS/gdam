package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 15/06/2017.
 */
public class TravelCountry {

    private String id;

    private String iso;

    private Cities[] cities;

    private String name;

    private String exportName;

    private String regionId;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getIso ()
    {
        return iso;
    }

    public void setIso (String iso)
    {
        this.iso = iso;
    }

    public Cities[] getCities ()
    {
        return cities;
    }

    public void setCities (Cities[] cities)
    {
        this.cities = cities;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getExportName ()
    {
        return exportName;
    }

    public void setExportName (String exportName)
    {
        this.exportName = exportName;
    }

    public String getRegionId ()
    {
        return regionId;
    }

    public void setRegionId (String regionId)
    {
        this.regionId = regionId;
    }
}
