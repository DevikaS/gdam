package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/*
 * Created by demidovskiy-r on 30.10.2014.
 */
public class ProductionServiceItem {
    private String[] serviceType;
    private String notes;

    public ProductionServiceItem(CustomMetadata cm) {
        setServiceType(cm.getStringArray("serviceType"));
        setNotes(cm.getString("notes"));
    }

    public String[] getServiceType() {
        return serviceType;
    }

    public void setServiceType(String[] serviceType) {
        this.serviceType = serviceType;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}