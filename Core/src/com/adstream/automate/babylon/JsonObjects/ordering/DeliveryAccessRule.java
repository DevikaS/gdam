package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/*
 * Created by demidovskiy-r on 10.12.2014.
 */
public class DeliveryAccessRule {
    private String field;
    private String op;
    private String value;

    public DeliveryAccessRule(CustomMetadata cm) {
        setField(cm.getString("field"));
        setOp(cm.getString("op"));
        setValue(cm.getString("value"));
    }

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public String getOp() {
        return op;
    }

    public void setOp(String op) {
        this.op = op;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}