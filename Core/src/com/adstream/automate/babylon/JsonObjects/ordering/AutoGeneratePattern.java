package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/*
 * Created by demidovskiy-r on 18.06.2014.
 */
public class AutoGeneratePattern {
    private PatternItem[] items;
    private String name;
    private boolean enabled;
    private String[] markets;

    public AutoGeneratePattern(CustomMetadata cm) {
        setItems(cm.getArrayForClass("items", PatternItem.class));
        setName(cm.getString("name"));
        setEnabled(cm.getBoolean("enabled"));
        setMarkets(cm.getStringArray("markets"));
    }

    public PatternItem[] getItems() {
        return items;
    }

    public void setItems(PatternItem[] items) {
        this.items = items;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public String[] getMarkets() {
        return markets;
    }

    public void setMarkets(String[] markets) {
        this.markets = markets;
    }
}