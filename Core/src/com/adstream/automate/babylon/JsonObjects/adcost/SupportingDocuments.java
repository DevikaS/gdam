package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 31/05/2017.
 */
public class SupportingDocuments {
    private String id;

    private String createdById;

    private String created;

    private String generated;

    private String name;

    private String required;

    private String costStageRevisionId;

    private Revisions[] revisions;

    private String modified;

    public String key;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getCreatedById ()
    {
        return createdById;
    }

    public void setCreatedById (String createdById)
    {
        this.createdById = createdById;
    }

    public String getCreated ()
    {
        return created;
    }

    public void setCreated (String created)
    {
        this.created = created;
    }

    public String getGenerated ()
    {
        return generated;
    }

    public void setGenerated (String generated)
    {
        this.generated = generated;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getRequired ()
    {
        return required;
    }

    public void setRequired (String required)
    {
        this.required = required;
    }

    public String getCostStageRevisionId ()
    {
        return costStageRevisionId;
    }

    public void setCostStageRevisionId (String costStageRevisionId)
    {
        this.costStageRevisionId = costStageRevisionId;
    }

    public Revisions[] getRevisions ()
    {
        return revisions;
    }

    public void setRevisions (Revisions[] revisions)
    {
        this.revisions = revisions;
    }

    public String getModified ()
    {
        return modified;
    }

    public void setModified (String modified)
    {
        this.modified = modified;
    }
}
