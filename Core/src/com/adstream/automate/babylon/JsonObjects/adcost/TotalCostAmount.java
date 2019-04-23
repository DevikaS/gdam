package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Arti.Sharma on 17/01/2018.
 */
public class TotalCostAmount {

    private String fieldName;

    private String operator;

    private String value;

    private String text;

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

    public String getValue ()
    {
        return value;
    }

    public void setValue (String value)
    {
        this.value = value;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
