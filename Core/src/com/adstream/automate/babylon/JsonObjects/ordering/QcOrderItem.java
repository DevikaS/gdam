package com.adstream.automate.babylon.JsonObjects.ordering;


import java.util.List;

/*
 * Created by demidovskiy-r on 28.02.14.
 */
public class QcOrderItem {
    private String id;
    private List<QcAsset> assets;
    private Object[] convertations;
    private Object metadata;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<QcAsset> getAssets() {
        return assets;
    }

    public void setAssets(List<QcAsset> assets) {
        this.assets = assets;
    }

    public Object[] getConvertations() {
        return convertations;
    }

    public void setConvertations(Object[] convertations) {
        this.convertations = convertations;
    }

    public Object getMetadata() {
        return metadata;
    }

    public void setMetadata(Object metadata) {
        this.metadata = metadata;
    }
}