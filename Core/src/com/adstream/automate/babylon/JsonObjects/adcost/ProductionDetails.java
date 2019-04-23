package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 19/06/2017.
 */
public class ProductionDetails {
    private Data data;

    private String type;
    private Forms[] forms;

    public Data getData ()
    {
        if (data == null) data = new Data();
        return data;
    }

    public void setData (Data data)
    {
        this.data = data;
    }

    public String getType ()
    {
        return type;
    }

    public void setType (String type)
    {
        this.type = type;
    }

    public Forms[] getForms ()
    {
        return forms;
    }

    public void setForms (Forms[] forms)
    {
        this.forms = forms;
    }
}
