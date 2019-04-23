package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 30/05/2017.
 */
public class CostStage {
    private String id;

    private String created;

    private String createdById;

    private String name;

    private String stageOrder;

    private String[] costStageRevisions;

    private String cost;

    private String key;

    private String modified;

    private String costId;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getCreated ()
    {
        return created;
    }

    public void setCreated (String created)
    {
        this.created = created;
    }

    public String getCreatedById ()
    {
        return createdById;
    }

    public void setCreatedById (String createdById)
    {
        this.createdById = createdById;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getStageOrder ()
    {
        return stageOrder;
    }

    public void setStageOrder (String stageOrder)
    {
        this.stageOrder = stageOrder;
    }

    public String[] getCostStageRevisions ()
    {
        return costStageRevisions;
    }

    public void setCostStageRevisions (String[] costStageRevisions)
    {
        this.costStageRevisions = costStageRevisions;
    }

    public String getCost ()
    {
        return cost;
    }

    public void setCost (String cost)
    {
        this.cost = cost;
    }

    public String getKey ()
    {
        return key;
    }

    public void setKey (String key)
    {
        this.key = key;
    }

    public String getModified ()
    {
        return modified;
    }

    public void setModified (String modified)
    {
        this.modified = modified;
    }

    public String getCostId ()
    {
        return costId;
    }

    public void setCostId (String costId)
    {
        this.costId = costId;
    }
}
