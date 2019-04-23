package com.adstream.automate.babylon.JsonObjects.mediamanager;

/**
 * Created by Saritha.Dhanala on 19/02/2018.
 */
public class Document
{
    private String timestamp;

    private String task;

    private String uuid;

    private Objects[] objects;

    public String getTimestamp ()
    {
        return timestamp;
    }

    public void setTimestamp (String timestamp)
    {
        this.timestamp = timestamp;
    }

    public String getTask ()
    {
        return task;
    }

    public void setTask (String task)
    {
        this.task = task;
    }

    public String getUuid ()
    {
        return uuid;
    }

    public void setUuid (String uuid)
    {
        this.uuid = uuid;
    }

    public Objects[] getObjects ()
    {
        return objects;
    }

    public void setObjects (Objects[] objects)
    {
        this.objects = objects;
    }

}
