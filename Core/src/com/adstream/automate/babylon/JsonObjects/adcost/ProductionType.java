package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 08/06/2017.
 */
public class ProductionType {
    private String id;

    private String value;

    private String key;

    private String fieldName;

    private String operator;

    private String text;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getValue ()
    {
        return value;
    }

    public void setValue (String value)
    {
        this.value = value;
    }

    public String getKey ()
    {
        return key;
    }

    public void setKey (String key)
    {
        this.key = key;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getOperator ()
    {
        return operator;
    }

    public void setOperator (String operator)
    {
        this.operator = operator;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
