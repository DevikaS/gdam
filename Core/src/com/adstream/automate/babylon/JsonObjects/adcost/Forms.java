package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 22/06/2017.
 */
public class Forms {

    private String id;

    private String label;

    private String name;

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private CostLineItemSections[] costLineItemSections;

    public CostLineItemSections[] getCostLineItemSections ()
    {
        return costLineItemSections;
    }

    public void setCostLineItemSections (CostLineItemSections[] costLineItemSections)
    {
        this.costLineItemSections = costLineItemSections;
    }
}
