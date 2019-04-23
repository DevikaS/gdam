package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 22/06/2017.
 */
public class CostLineItemSections {

    private String id;

    private String name;

    private String label;

    private Items[] items;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
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

    public String getLabel ()
    {
        return label;
    }

    public void setLabel (String label)
    {
        this.label = label;
    }

    public Items[] getItems ()
    {
        return items;
    }

    public void setItems (Items[] items)
    {
        this.items = items;
    }

}
