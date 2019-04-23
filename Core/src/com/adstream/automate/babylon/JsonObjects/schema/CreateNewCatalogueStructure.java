package com.adstream.automate.babylon.JsonObjects.schema;

public class CreateNewCatalogueStructure {
    private String Parent;

    private String Description;

    private String FieldType;

    public String getParent ()
    {
        return Parent;
    }

    public void setParent (String Parent)
    {
        this.Parent = Parent;
    }

    public String getDescription ()
    {
        return Description;
    }

    public void setDescription (String Description)
    {
        this.Description = Description;
    }

    public String getFieldType ()
    {
        return FieldType;
    }

    public void setFieldType (String FieldType)
    {
        this.FieldType = FieldType;
    }
}
