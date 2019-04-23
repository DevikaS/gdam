package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 26/07/2016.
 */
public class Assets {

    private String duration;

    private String count;

    private List[] list;

    public String getDuration ()
    {
        return duration;
    }

    public void setDuration (String duration)
    {
        this.duration = duration;
    }

    public String getCount ()
    {
        return count;
    }

    public void setCount (String count)
    {
        this.count = count;
    }

    public List[] getList ()
    {
        return list;
    }

    public void setList (List[] list)
    {
        this.list = list;
    }

}
