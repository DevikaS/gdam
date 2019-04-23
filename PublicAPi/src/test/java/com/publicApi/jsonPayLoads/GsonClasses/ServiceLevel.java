package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 08/07/2016.
 */
public class ServiceLevel {

    private String[] id;

    private String name;

    private String minutes;

    public String getMinutes ()
    {
        return minutes;
    }

    public void setMinutes (String minutes)
    {
        this.minutes = minutes;
    }


    public String[] getId ()
    {
        return id;
    }

    public void setId (String[] id)
    {
        this.id = id;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }
}
